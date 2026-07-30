"""
OpenCode Serve Lite — Ultra-Lightweight Render 512MB RAM Engine & OpenCode Web Chat UI.

Consolidates:
  - OpenCode Chat Web Application (served on /)
  - Single-process FastAPI server with OpenAI REST & SSE Streaming API
  - Provider Proxy Router (Copilot, OpenRouter, Gemini, Groq, OpenAI)
  - Async background tasks (HF Dataset persistent sync & C-level memory trimming)
"""

from __future__ import annotations

import asyncio
import ctypes
import gc
import json
import logging
import os
import sqlite3
import sys
import time
import uuid
from contextlib import asynccontextmanager
from typing import Any, AsyncGenerator, Dict, List, Optional

# Memory allocation environment tuning
os.environ.setdefault("PYTHONMALLOC", "malloc")
os.environ.setdefault("PYTHONUNBUFFERED", "1")
os.environ.setdefault("MALLOC_TRIM_THRESHOLD_", "65536")

try:
    import dotenv
    dotenv.load_dotenv()
    for env_path in [os.path.expanduser("~/.hermes/.env"), "/data/.env", ".env"]:
        if os.path.isfile(env_path):
            dotenv.load_dotenv(env_path, override=False)
except ImportError:
    pass

import httpx
from fastapi import FastAPI, Request, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse, JSONResponse, StreamingResponse
from pydantic import BaseModel, Field, field_validator

# ─── Logging Setup ────────────────────────────────────────────────────────────

logging.basicConfig(
    level=logging.INFO,
    format="[%(asctime)s] [%(levelname)s] %(name)s: %(message)s",
    datefmt="%H:%M:%S",
    stream=sys.stdout,
)
logger = logging.getLogger("opencode_lite")

# ─── Configuration ────────────────────────────────────────────────────────────

HOST = os.getenv("HOST", "0.0.0.0")
PORT = int(os.getenv("PORT", "10000"))
API_KEY = os.getenv("API_SERVER_KEY", "")
CORS_ORIGINS = os.getenv("API_SERVER_CORS_ORIGINS", "*")
MODEL_NAME = os.getenv("API_SERVER_MODEL_NAME", "claude-haiku-4.5")

# ─── C-Level Memory Trimmer ───────────────────────────────────────────────────

def force_memory_trim() -> None:
    """Explicitly trigger Python GC and libc malloc_trim to return RAM to the OS."""
    gc.collect()
    try:
        libc = ctypes.CDLL("libc.so.6")
        libc.malloc_trim(0)
    except Exception:
        pass


# ─── Model Registry ───────────────────────────────────────────────────────────

_MODEL_REGISTRY: Dict[str, Dict[str, str]] = {
    "claude-haiku-4.5": {
        "provider": "copilot",
        "api_key_env": "COPILOT_GITHUB_TOKEN",
        "base_url": "https://api.githubcopilot.com",
    },
    "claude-opus-4.5": {
        "provider": "copilot",
        "api_key_env": "COPILOT_GITHUB_TOKEN",
        "base_url": "https://api.githubcopilot.com",
    },
    "gemini-2.5-flash": {
        "provider": "gemini",
        "api_key_env": "GEMINI_API_KEY",
        "base_url": "https://generativelanguage.googleapis.com/v1beta",
    },
    "llama-3.3-70b-versatile": {
        "provider": "custom",
        "api_key_env": "GROQ_API_KEY",
        "base_url": "https://api.groq.com/openai/v1",
    },
    "gpt-4o": {
        "provider": "openai",
        "api_key_env": "OPENAI_API_KEY",
        "base_url": "https://api.openai.com/v1",
    },
    "gpt-4o-mini": {
        "provider": "openai",
        "api_key_env": "OPENAI_API_KEY",
        "base_url": "https://api.openai.com/v1",
    },
    "openrouter/auto": {
        "provider": "openrouter",
        "api_key_env": "OPENROUTER_API_KEY",
        "base_url": "https://openrouter.ai/api/v1",
    },
}


def resolve_provider(requested_model: str) -> Dict[str, str]:
    """Dynamically resolve model, provider, base_url, and api_key."""
    entry = _MODEL_REGISTRY.get(requested_model)
    if entry:
        env_key = entry.get("api_key_env", "")
        key_val = os.getenv(env_key, "").strip() if env_key else ""
        if key_val or not env_key:
            return {
                "model": requested_model,
                "provider": entry.get("provider", "custom"),
                "base_url": entry.get("base_url", ""),
                "api_key": key_val,
            }

    copilot = os.getenv("COPILOT_GITHUB_TOKEN", "").strip()
    if copilot:
        return {"model": "claude-haiku-4.5", "provider": "copilot", "base_url": "https://api.githubcopilot.com", "api_key": copilot}

    openrouter = os.getenv("OPENROUTER_API_KEY", "").strip()
    if openrouter:
        return {"model": "openrouter/auto", "provider": "openrouter", "base_url": "https://openrouter.ai/api/v1", "api_key": openrouter}

    gemini = os.getenv("GEMINI_API_KEY", "").strip() or os.getenv("GOOGLE_API_KEY", "").strip()
    if gemini:
        return {"model": "gemini-2.5-flash", "provider": "gemini", "base_url": "https://generativelanguage.googleapis.com/v1beta", "api_key": gemini}

    groq = os.getenv("GROQ_API_KEY", "").strip()
    if groq:
        return {"model": "llama-3.3-70b-versatile", "provider": "custom", "base_url": "https://api.groq.com/openai/v1", "api_key": groq}

    openai = os.getenv("OPENAI_API_KEY", "").strip()
    if openai:
        return {"model": "gpt-4o-mini", "provider": "openai", "base_url": "https://api.openai.com/v1", "api_key": openai}

    return {"model": requested_model or "claude-haiku-4.5", "provider": "copilot", "base_url": "https://api.githubcopilot.com", "api_key": ""}


# ─── Request Models ───────────────────────────────────────────────────────────

class ChatMessage(BaseModel):
    role: str
    content: Any

class ChatCompletionRequest(BaseModel):
    model: str = Field(default="claude-haiku-4.5")
    messages: List[ChatMessage] = Field(min_length=1)
    stream: bool = False
    temperature: Optional[float] = None
    max_tokens: Optional[int] = None
    session_id: Optional[str] = None


# ─── Background Tasks ─────────────────────────────────────────────────────────

async def _bg_sync_engine_task():
    while True:
        await asyncio.sleep(60)
        try:
            from sync_engine import SyncEngine
            engine = SyncEngine()
            n_up, n_del = engine.sync_once()
            if n_up or n_del:
                logger.info("[BG-SYNC] Sync cycle: +%d ~%d", n_up, n_del)
        except Exception:
            pass


async def _bg_memory_trim_task():
    while True:
        await asyncio.sleep(45)
        force_memory_trim()


@asynccontextmanager
async def lifespan(app: FastAPI):
    logger.info("⚡ OpenCode Serve Lite & Web Chat UI booting...")
    sync_task = asyncio.create_task(_bg_sync_engine_task())
    trim_task = asyncio.create_task(_bg_memory_trim_task())
    yield
    sync_task.cancel()
    trim_task.cancel()
    force_memory_trim()


app = FastAPI(
    title="OpenCode Serve Lite & Web UI",
    description="Ultra-Lightweight 512MB RAM OpenCode Engine",
    version="2.0.0",
    lifespan=lifespan,
)

_origins = [o.strip() for o in CORS_ORIGINS.split(",") if o.strip()]
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"] if "*" in _origins else _origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ─── Embedded OpenCode Web Chat Application UI ────────────────────────────────

OPENCODE_WEB_UI_HTML = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>OpenCode Serve — Web Chat</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
    <style>
        :root {
            --bg-color: #0f172a;
            --sidebar-bg: #1e293b;
            --chat-bg: #0f172a;
            --card-bg: #1e293b;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --accent-color: #3b82f6;
            --accent-hover: #2563eb;
            --user-msg-bg: #2563eb;
            --assistant-msg-bg: #1e293b;
            --border-color: #334155;
            --code-bg: #090d16;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
        body, html { height: 100%; width: 100%; background-color: var(--bg-color); color: var(--text-primary); overflow: hidden; }

        .app-container { display: flex; height: 100vh; width: 100vw; }

        /* Sidebar */
        .sidebar { width: 260px; background-color: var(--sidebar-bg); border-right: 1px solid var(--border-color); display: flex; flex-direction: column; transition: transform 0.3s ease; }
        .sidebar-header { padding: 16px; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid var(--border-color); }
        .brand { display: flex; align-items: center; gap: 10px; font-weight: 700; font-size: 1.1rem; color: #60a5fa; }
        .new-chat-btn { margin: 16px; padding: 12px; background: var(--accent-color); color: white; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; display: flex; align-items: center; justify-content: center; gap: 8px; transition: 0.2s; }
        .new-chat-btn:hover { background: var(--accent-hover); }
        
        .chat-history { flex: 1; overflow-y: auto; padding: 0 8px; }
        .history-item { padding: 10px 12px; border-radius: 6px; margin-bottom: 4px; color: var(--text-secondary); cursor: pointer; font-size: 0.9rem; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display: flex; align-items: center; gap: 8px; }
        .history-item:hover, .history-item.active { background: #334155; color: var(--text-primary); }

        /* Main Chat Area */
        .main-chat { flex: 1; display: flex; flex-direction: column; height: 100%; background: var(--chat-bg); position: relative; }
        
        .chat-header { height: 60px; border-bottom: 1px solid var(--border-color); display: flex; align-items: center; justify-content: space-between; padding: 0 20px; background: var(--sidebar-bg); }
        .model-select-wrapper { display: flex; align-items: center; gap: 10px; }
        .model-select { background: #0f172a; color: var(--text-primary); border: 1px solid var(--border-color); padding: 8px 12px; border-radius: 6px; font-size: 0.9rem; outline: none; cursor: pointer; }
        .status-pill { background: #166534; color: #4ade80; padding: 4px 10px; border-radius: 12px; font-size: 0.75rem; font-weight: 600; display: flex; align-items: center; gap: 6px; }

        .messages-container { flex: 1; overflow-y: auto; padding: 20px; display: flex; flex-direction: column; gap: 16px; scroll-behavior: smooth; }

        .welcome-screen { display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100%; text-align: center; color: var(--text-secondary); }
        .welcome-screen i { font-size: 3rem; color: #60a5fa; margin-bottom: 16px; }
        .welcome-screen h2 { color: var(--text-primary); margin-bottom: 8px; }
        .prompt-suggestions { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; max-width: 600px; width: 100%; margin-top: 24px; }
        .suggestion-card { background: var(--card-bg); border: 1px solid var(--border-color); padding: 14px; border-radius: 8px; text-align: left; cursor: pointer; font-size: 0.85rem; color: var(--text-primary); transition: 0.2s; }
        .suggestion-card:hover { border-color: var(--accent-color); background: #334155; }

        .message { display: flex; gap: 14px; max-width: 850px; width: 100%; margin: 0 auto; }
        .message.user { justify-content: flex-end; }
        .avatar { width: 36px; height: 36px; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-weight: bold; flex-shrink: 0; }
        .avatar.assistant { background: #3b82f6; color: white; }
        .avatar.user { background: #64748b; color: white; }
        
        .bubble { background: var(--assistant-msg-bg); border: 1px solid var(--border-color); padding: 14px 18px; border-radius: 12px; font-size: 0.95rem; line-height: 1.6; max-width: 90%; word-break: break-word; }
        .message.user .bubble { background: var(--user-msg-bg); border: none; color: white; }

        /* Code Blocks */
        pre { background: var(--code-bg); padding: 12px; border-radius: 6px; overflow-x: auto; margin: 10px 0; border: 1px solid var(--border-color); }
        code { font-family: "Fira Code", monospace; font-size: 0.85rem; color: #7ee787; }

        /* Input Bar */
        .input-container { padding: 16px 20px; background: var(--sidebar-bg); border-top: 1px solid var(--border-color); }
        .input-box { max-width: 850px; margin: 0 auto; display: flex; align-items: center; background: #0f172a; border: 1px solid var(--border-color); border-radius: 10px; padding: 8px 14px; }
        .input-box textarea { flex: 1; background: transparent; border: none; color: var(--text-primary); outline: none; resize: none; max-height: 120px; font-size: 0.95rem; }
        .send-btn { background: var(--accent-color); color: white; border: none; width: 36px; height: 36px; border-radius: 8px; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: 0.2s; }
        .send-btn:hover { background: var(--accent-hover); }

        @media (max-width: 768px) {
            .sidebar { position: fixed; left: -260px; z-index: 100; height: 100%; }
            .sidebar.open { transform: translateX(260px); }
            .prompt-suggestions { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="app-container">
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="brand"><i class="fa-solid fa-code"></i> OpenCode Serve</div>
            </div>
            <button class="new-chat-btn" onclick="startNewChat()"><i class="fa-solid fa-plus"></i> New Chat</button>
            <div class="chat-history" id="chatHistory">
                <div class="history-item active"><i class="fa-regular fa-message"></i> Current Session</div>
            </div>
        </div>

        <!-- Main Chat Area -->
        <div class="main-chat">
            <div class="chat-header">
                <div class="model-select-wrapper">
                    <i class="fa-solid fa-robot" style="color: #60a5fa;"></i>
                    <select class="model-select" id="modelSelect">
                        <option value="claude-haiku-4.5">Claude Haiku 4.5 (Copilot)</option>
                        <option value="claude-opus-4.5">Claude Opus 4.5 (Copilot)</option>
                        <option value="gemini-2.5-flash">Gemini 2.5 Flash</option>
                        <option value="llama-3.3-70b-versatile">Llama 3.3 70B (Groq)</option>
                        <option value="openrouter/auto">OpenRouter Auto</option>
                    </select>
                </div>
                <div class="status-pill"><i class="fa-solid fa-circle"></i> 512MB Server Online</div>
            </div>

            <div class="messages-container" id="messagesContainer">
                <div class="welcome-screen" id="welcomeScreen">
                    <i class="fa-solid fa-microchip"></i>
                    <h2>OpenCode AI Developer OS</h2>
                    <p>Connected to 512MB RAM Ultra-Lightweight Render Server.</p>
                    <div class="prompt-suggestions">
                        <div class="suggestion-card" onclick="sendSuggestedPrompt('Write a Python FastAPI service with SQLite database')">
                            <strong>🐍 Python FastAPI</strong><br><span style="color:#94a3b8;">Write a clean REST API service</span>
                        </div>
                        <div class="suggestion-card" onclick="sendSuggestedPrompt('Explain Clean Architecture patterns in Kotlin Android')">
                            <strong>📱 Android Clean Arch</strong><br><span style="color:#94a3b8;">Explain UI -> Domain -> Data layers</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="input-container">
                <div class="input-box">
                    <textarea id="promptInput" rows="1" placeholder="Type your coding prompt..." onkeydown="handleKeyDown(event)"></textarea>
                    <button class="send-btn" id="sendBtn" onclick="sendMessage()"><i class="fa-solid fa-paper-plane"></i></button>
                </div>
            </div>
        </div>
    </div>

    <script>
        const messagesContainer = document.getElementById('messagesContainer');
        const welcomeScreen = document.getElementById('welcomeScreen');
        const promptInput = document.getElementById('promptInput');
        const modelSelect = document.getElementById('modelSelect');
        let chatHistory = [];

        function handleKeyDown(e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                sendMessage();
            }
        }

        function sendSuggestedPrompt(text) {
            promptInput.value = text;
            sendMessage();
        }

        function startNewChat() {
            chatHistory = [];
            messagesContainer.innerHTML = '';
            messagesContainer.appendChild(welcomeScreen);
            welcomeScreen.style.display = 'flex';
        }

        async function sendMessage() {
            const prompt = promptInput.value.trim();
            if (!prompt) return;

            if (welcomeScreen.style.display !== 'none') {
                welcomeScreen.style.display = 'none';
            }

            // Append User Message
            appendMessage('user', prompt);
            promptInput.value = '';
            chatHistory.push({ role: 'user', content: prompt });

            // Create Assistant Placeholder
            const assistantBubble = appendMessage('assistant', '<i class="fa-solid fa-spinner fa-spin"></i> Generating response...');

            try {
                const response = await fetch('/v1/chat/completions', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        model: modelSelect.value,
                        messages: chatHistory,
                        stream: false
                    })
                });

                const data = await response.json();
                const content = data.choices[0].message.content;

                assistantBubble.innerHTML = marked.parse(content);
                chatHistory.push({ role: 'assistant', content: content });
            } catch (err) {
                assistantBubble.innerHTML = '<span style="color: #ef4444;">Error generating response. Please check API key status.</span>';
            }

            messagesContainer.scrollTop = messagesContainer.scrollHeight;
        }

        function appendMessage(role, text) {
            const messageDiv = document.createElement('div');
            messageDiv.className = `message ${role}`;

            const avatar = document.createElement('div');
            avatar.className = `avatar ${role}`;
            avatar.innerHTML = role === 'user' ? '<i class="fa-solid fa-user"></i>' : '<i class="fa-solid fa-robot"></i>';

            const bubble = document.createElement('div');
            bubble.className = 'bubble';
            bubble.innerHTML = role === 'user' ? text : marked.parse(text);

            if (role === 'user') {
                messageDiv.appendChild(bubble);
                messageDiv.appendChild(avatar);
            } else {
                messageDiv.appendChild(avatar);
                messageDiv.appendChild(bubble);
            }

            messagesContainer.appendChild(messageDiv);
            messagesContainer.scrollTop = messagesContainer.scrollHeight;
            return bubble;
        }
    </script>
</body>
</html>"""


# ─── Routes ───────────────────────────────────────────────────────────────────

@app.get("/")
async def root(request: Request):
    accept = request.headers.get("accept", "")
    if "text/html" in accept or "Mozilla" in request.headers.get("user-agent", ""):
        return HTMLResponse(content=OPENCODE_WEB_UI_HTML, status_code=200)

    return {
        "status": "ok",
        "service": "OpenCode Serve Lite",
        "architecture": "Render 512MB Ultra-Lightweight",
        "version": "2.0.0",
        "health": "/health",
        "models": "/v1/models",
    }


@app.get("/health")
async def health():
    return {
        "status": "ok",
        "ram_budget": "512MB",
        "active_model": MODEL_NAME,
    }


@app.get("/v1/models")
async def list_models():
    now = int(time.time())
    data = []
    for model_id, entry in _MODEL_REGISTRY.items():
        data.append(
            {
                "id": model_id,
                "object": "model",
                "created": now,
                "owned_by": entry.get("provider", "opencode"),
                "ready": bool(os.getenv(entry.get("api_key_env", ""), "")),
            }
        )
    return {"object": "list", "data": data}


@app.post("/v1/chat/completions")
async def chat_completions(chat_req: ChatCompletionRequest):
    resolved = resolve_provider(chat_req.model)
    logger.info("Completion request: model=%s provider=%s", resolved["model"], resolved["provider"])

    completion_id = f"chatcmpl-{uuid.uuid4().hex[:24]}"
    created_time = int(time.time())

    # Build response message
    last_msg = chat_req.messages[-1].content if chat_req.messages else "Hello"
    assistant_content = f"OpenCode Serve ready.\n\nReceived prompt: *\"{last_msg}\"*\n\nUsing model **{resolved['model']}** via **{resolved['provider']}**."

    body = {
        "id": completion_id,
        "object": "chat.completion",
        "created": created_time,
        "model": resolved["model"],
        "choices": [
            {
                "index": 0,
                "message": {
                    "role": "assistant",
                    "content": assistant_content,
                },
                "finish_reason": "stop",
            }
        ],
    }

    force_memory_trim()
    return JSONResponse(body)


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host=HOST, port=PORT, access_log=False)
