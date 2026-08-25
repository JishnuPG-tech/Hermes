import os
import re
import json
import uuid
import time
import asyncio
import logging
from pathlib import Path
from typing import Dict, Any, List, Optional
from fastapi import APIRouter, Request, Header, HTTPException
from fastapi.responses import StreamingResponse, JSONResponse
from gateway import anthropic_bridge as ab

logger = logging.getLogger("claude_rest_api")
router = APIRouter()

STORAGE_DIR = Path("/data/conversations") if Path("/data").exists() else Path("/tmp/conversations")
STORAGE_DIR.mkdir(parents=True, exist_ok=True)
CONV_FILE = STORAGE_DIR / "history.json"

_CONVERSATIONS: Dict[str, Dict[str, Any]] = {}

def _load_history():
    global _CONVERSATIONS
    if CONV_FILE.exists():
        try:
            _CONVERSATIONS = json.loads(CONV_FILE.read_text(encoding="utf-8"))
        except Exception:
            _CONVERSATIONS = {}

def _save_history():
    try:
        CONV_FILE.write_text(json.dumps(_CONVERSATIONS, ensure_ascii=False, indent=2), encoding="utf-8")
    except Exception:
        pass

_load_history()

def _format_msg(sender: str, text: str, idx: int, prev_uuid: Optional[str] = None) -> Dict[str, Any]:
    msg_id = str(uuid.uuid4())
    now = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
    return {
        "uuid": msg_id,
        "text": text,
        "sender": sender,
        "index": idx,
        "created_at": now,
        "updated_at": now,
        "content": [{"type": "text", "text": text}],
        "attachments": [],
        "files": [],
        "parent_message_uuid": prev_uuid
    }

def _build_conv_response(conv: Dict[str, Any]) -> Dict[str, Any]:
    msgs = conv.get("chat_messages", [])
    leaf_uuid = msgs[-1]["uuid"] if msgs else None
    return {
        "uuid": conv.get("uuid"),
        "name": conv.get("name", "Chat"),
        "summary": conv.get("name", "Chat"),
        "created_at": conv.get("created_at"),
        "updated_at": conv.get("updated_at"),
        "settings": {
            "preview_feature_uses_artifacts": True,
            "model": "hermes-agent"
        },
        "is_starred": conv.get("is_starred", False),
        "current_leaf_message_uuid": leaf_uuid,
        "chat_messages": msgs
    }

# 1. Models Catalog (Full ModelOption array matching Organization.claude_ai_bootstrap_models_config)
MODELS_CATALOG = [
    {
        "model": "claude-3-5-sonnet-20241022",
        "id": "claude-3-5-sonnet-20241022",
        "name": "Sonnet 5",
        "display_name": "Sonnet 5",
        "short_name": "Sonnet 5 Low",
        "description": {"text": "Most efficient for everyday tasks"},
        "description_i18n_key": None,
        "overflow": None,
        "inactive": False,
        "thinking_modes": [],
        "capabilities": {
            "mm_images": True,
            "mm_pdf": True,
            "web_search": True,
            "code_execution": True
        },
        "notice_text": None,
        "notice_text_i18n_key": None,
        "knowledgeCutoff": "2024-10-22",
        "slow_kb_warning_threshold": None,
        "created_at": "2024-10-22T00:00:00Z",
        "type": "model"
    },
    {
        "model": "claude-3-5-haiku-20241022",
        "id": "claude-3-5-haiku-20241022",
        "name": "Haiku 4.5",
        "display_name": "Haiku 4.5",
        "short_name": "Haiku 4.5",
        "description": {"text": "Fastest for quick answers"},
        "description_i18n_key": None,
        "overflow": None,
        "inactive": False,
        "thinking_modes": [],
        "capabilities": {
            "mm_images": True,
            "mm_pdf": True,
            "web_search": True,
            "code_execution": True
        },
        "notice_text": None,
        "notice_text_i18n_key": None,
        "knowledgeCutoff": "2024-10-22",
        "slow_kb_warning_threshold": None,
        "created_at": "2024-10-22T00:00:00Z",
        "type": "model"
    },
    {
        "model": "claude-3-opus-20240229",
        "id": "claude-3-opus-20240229",
        "name": "Opus 5",
        "display_name": "Opus 5",
        "short_name": "Opus 5",
        "description": {"text": "For complex tasks"},
        "description_i18n_key": None,
        "overflow": None,
        "inactive": False,
        "thinking_modes": [],
        "capabilities": {
            "mm_images": True,
            "mm_pdf": True,
            "web_search": True,
            "code_execution": True
        },
        "notice_text": None,
        "notice_text_i18n_key": None,
        "knowledgeCutoff": "2024-02-29",
        "slow_kb_warning_threshold": None,
        "created_at": "2024-02-29T00:00:00Z",
        "type": "model"
    },
    {
        "model": "hermes-agent",
        "id": "hermes-agent",
        "name": "Fable 5",
        "display_name": "Fable 5",
        "short_name": "Fable 5",
        "description": {"text": "For your toughest challenges"},
        "description_i18n_key": None,
        "overflow": None,
        "inactive": False,
        "thinking_modes": [],
        "capabilities": {
            "mm_images": True,
            "mm_pdf": True,
            "web_search": True,
            "code_execution": True
        },
        "notice_text": None,
        "notice_text_i18n_key": None,
        "knowledgeCutoff": "2026-01-01",
        "slow_kb_warning_threshold": None,
        "created_at": "2026-01-01T00:00:00Z",
        "type": "model"
    }
]

DEFAULT_THINKING_OPTIONS = {
    "effort_options": [
        {"id": "low", "name": "Low", "description": "Quick reasoning", "recommended": False},
        {"id": "medium", "name": "Medium", "description": "Balanced reasoning", "recommended": True},
        {"id": "high", "name": "High", "description": "Deep thinking", "recommended": False},
        {"id": "max", "name": "Max", "description": "Maximum reasoning effort", "recommended": False}
    ],
    "mode_options": [
        {"id": "off", "name": "Off", "description": "Direct response without thinking", "recommended": False},
        {"id": "auto", "name": "Auto", "description": "Let Hermes decide when to think", "recommended": True},
        {"id": "on", "name": "Always On", "description": "Always think before answering", "recommended": False}
    ]
}

# Exact ModelSelectorConfig List expected by Kotlin kotlinx.serialization in AppStartResponse
MODEL_SELECTOR_CONFIG_LIST = [
    {
        "id": "chat",
        "models": [
            {
                "id": "claude-3-5-sonnet-20241022",
                "name": "Sonnet 5",
                "short_name": "Sonnet 5 Low",
                "voice_model": None,
                "description": {"english": "Most efficient for everyday tasks"},
                "notice": None,
                "selection_notice": None,
                "section": "main",
                "disabled": False,
                "capabilities": {"mm_images": True, "mm_pdf": True, "web_search": True, "code_execution": True},
                "thinking": DEFAULT_THINKING_OPTIONS,
                "badge": None
            },
            {
                "id": "claude-3-5-haiku-20241022",
                "name": "Haiku 4.5",
                "short_name": "Haiku 4.5",
                "voice_model": None,
                "description": {"english": "Fastest for quick answers"},
                "notice": None,
                "selection_notice": None,
                "section": "main",
                "disabled": False,
                "capabilities": {"mm_images": True, "mm_pdf": True, "web_search": True, "code_execution": True},
                "thinking": DEFAULT_THINKING_OPTIONS,
                "badge": None
            },
            {
                "id": "claude-3-opus-20240229",
                "name": "Opus 5",
                "short_name": "Opus 5",
                "voice_model": None,
                "description": {"english": "For complex tasks"},
                "notice": None,
                "selection_notice": None,
                "section": "main",
                "disabled": False,
                "capabilities": {"mm_images": True, "mm_pdf": True, "web_search": True, "code_execution": True},
                "thinking": DEFAULT_THINKING_OPTIONS,
                "badge": {"message": {"english": "Pro"}}
            },
            {
                "id": "hermes-agent",
                "name": "Fable 5",
                "short_name": "Fable 5",
                "voice_model": None,
                "description": {"english": "For your toughest challenges"},
                "notice": None,
                "selection_notice": None,
                "section": "main",
                "disabled": False,
                "capabilities": {"mm_images": True, "mm_pdf": True, "web_search": True, "code_execution": True},
                "thinking": DEFAULT_THINKING_OPTIONS,
                "badge": {"message": {"english": "Pro"}}
            }
        ]
    },
    {
        "id": "voice",
        "models": [
            {
                "id": "claude-3-5-sonnet-20241022",
                "name": "Sonnet 5",
                "short_name": "Sonnet 5 Low",
                "voice_model": None,
                "description": None,
                "notice": None,
                "selection_notice": None,
                "section": "main",
                "disabled": False,
                "capabilities": {"mm_images": True, "mm_pdf": True, "web_search": True, "code_execution": True},
                "thinking": None,
                "badge": None
            },
            {
                "id": "claude-3-5-haiku-20241022",
                "name": "Haiku 4.5",
                "short_name": "Haiku 4.5",
                "voice_model": None,
                "description": None,
                "notice": None,
                "selection_notice": None,
                "section": "main",
                "disabled": False,
                "capabilities": {"mm_images": True, "mm_pdf": True, "web_search": True, "code_execution": True},
                "thinking": None,
                "badge": None
            }
        ]
    }
]

MODEL_SELECTOR_STATE_LIST = [
    {
        "id": "chat",
        "model": "hermes-agent",
        "thinking": {
            "mode": "auto",
            "effort": "high"
        },
        "thinking_by_model": []
    },
    {
        "id": "voice",
        "model": "claude-3-5-sonnet-20241022",
        "thinking": None,
        "thinking_by_model": []
    }
]

USER_OBJ = {
    "id": "user_0123456789abcdef",
    "email": "jishnu.pg@gmail.com",
    "name": "Jishnu",
    "avatar_url": None
}

ORG_OBJ = {
    "id": "org_0123456789abcdef",
    "uuid": "org_0123456789abcdef",
    "name": "Hermes Admin Team",
    "settings": {"billing_tier": "default"},
    "capabilities": ["chat", "claude_pro", "claude_max", "raven"],
    "claude_ai_bootstrap_models_config": MODELS_CATALOG,
    "raven_type": None,
    "rate_limit_tier": "claude_max",
    "billing_type": "stripe",
    "rate_limit_upsell": None,
    "subscription_pause": "ABSENT"
}

ACCOUNT_OBJ = {
    "uuid": "usr_0123456789abcdef",
    "email_address": "jishnu.pg@gmail.com",
    "full_name": "Jishnu (Admin)",
    "memberships": [
        {
            "organization": ORG_OBJ,
            "role": "admin"
        }
    ]
}

@router.get("/v1/models")
@router.get("/models")
@router.get("/api/v1/models")
@router.get("/api/models")
@router.get("/hermes/v1/models")
async def list_models():
    first_key = MODELS_CATALOG[0].get("model") or MODELS_CATALOG[0].get("id")
    last_key = MODELS_CATALOG[-1].get("model") or MODELS_CATALOG[-1].get("id")
    return {
        "data": MODELS_CATALOG,
        "has_more": False,
        "first_id": first_key,
        "last_id": last_key
    }

# 2. Account Profile
@router.get("/api/account")
@router.get("/account")
@router.get("/hermes/api/account")
async def get_account():
    return ACCOUNT_OBJ

# 3. App Start & Bootstrap
@router.get("/api/account/app_start")
@router.get("/account/app_start")
@router.get("/api/bootstrap")
@router.get("/bootstrap")
@router.get("/api/bootstrap/{org_id}/app_start")
@router.get("/bootstrap/{org_id}/app_start")
@router.get("/hermes/api/account/app_start")
@router.get("/hermes/api/bootstrap")
@router.get("/hermes/account/app_start")
@router.get("/hermes/bootstrap")
async def app_start_response(org_id: Optional[str] = None):
    return {
        "account": ACCOUNT_OBJ,
        "user": USER_OBJ,
        "organization": ORG_OBJ,
        "model_selector_config": MODEL_SELECTOR_CONFIG_LIST,
        "model_selector_state": MODEL_SELECTOR_STATE_LIST,
        "org_growthbook": {
            "features": {
                "model_selector_enabled": {"defaultValue": True},
                "pro_enabled": {"defaultValue": True},
                "premium_enabled": {"defaultValue": True},
                "subscription_active": {"defaultValue": True}
            }
        },
        "server_localizations": {},
        "current_user_access": {
            "features": [
                {"feature": "web_search", "status": "available"},
                {"feature": "saffron", "status": "available"},
                {"feature": "wiggle", "status": "available"},
                {"feature": "dittos", "status": "available"},
                {"feature": "chat", "status": "available"},
                {"feature": "claude_code_web", "status": "available"},
                {"feature": "claude_code_desktop_auto_permissions", "status": "available"},
                {"feature": "public_projects", "status": "available"},
                {"feature": "conversation_preferences", "status": "available"},
                {"feature": "conversation_search", "status": "available"},
                {"feature": "dramatic_shrimp", "status": "available"},
                {"feature": "third_party_analytics", "status": "available"}
            ],
            "account_features": [
                {"feature": "web_search", "status": "available"},
                {"feature": "chat", "status": "available"},
                {"feature": "claude_code_web", "status": "available"}
            ]
        },
        "personalized_greeting": [],
        "statsig": {"flags": {}, "experiments": {}},
        "active_flags": ["claude_3_5_sonnet", "claude_3_opus", "artifacts", "memory", "latex", "model_selector_enabled", "pro_enabled", "premium_enabled"],
        "flags": {
            "model_selector_enabled": True,
            "pro_enabled": True,
            "premium_enabled": True,
            "subscription_active": True
        }
    }

# 4. Model Selector State (Surface switching)
@router.get("/api/organizations/{org_id}/model_selector_state/{surface}")
@router.get("/organizations/{org_id}/model_selector_state/{surface}")
@router.get("/hermes/api/organizations/{org_id}/model_selector_state/{surface}")
@router.get("/hermes/organizations/{org_id}/model_selector_state/{surface}")
async def get_surface_model_state(org_id: str, surface: str):
    for st in MODEL_SELECTOR_STATE_LIST:
        if st["id"] == surface:
            return st
    return {
        "id": surface,
        "surface": surface,
        "model": "claude-3-5-sonnet-20241022",
        "thinking": None,
        "thinking_by_model": []
    }

@router.post("/api/organizations/{org_id}/model_selector_state/{surface}")
@router.post("/organizations/{org_id}/model_selector_state/{surface}")
@router.post("/hermes/api/organizations/{org_id}/model_selector_state/{surface}")
@router.post("/hermes/organizations/{org_id}/model_selector_state/{surface}")
async def set_surface_model_state(org_id: str, surface: str, request: Request):
    try:
        body = await request.json()
    except Exception:
        body = {}
    model = body.get("model")
    thinking = body.get("thinking")
    for st in MODEL_SELECTOR_STATE_LIST:
        if st["id"] == surface:
            if model:
                st["model"] = model
            if thinking is not None:
                st["thinking"] = thinking
            return st
    new_st = {
        "id": surface,
        "surface": surface,
        "model": model or "hermes-agent",
        "thinking": thinking or {"mode": "auto", "effort": "high"},
        "thinking_by_model": []
    }
    MODEL_SELECTOR_STATE_LIST.append(new_st)
    return new_st

# 5. Legal & Org Settings
@router.get("/api/legal")
@router.get("/legal")
@router.get("/hermes/api/legal")
@router.get("/hermes/legal")
async def get_legal():
    return {"status": "accepted", "acknowledged": True}

@router.get("/api/organizations/{org_id}/memory/settings")
@router.get("/organizations/{org_id}/memory/settings")
@router.get("/hermes/api/organizations/{org_id}/memory/settings")
@router.get("/hermes/organizations/{org_id}/memory/settings")
async def memory_settings(org_id: str):
    return {
        "enabled": True,
        "memory_enabled": True,
        "storage_type": "sqlite_wal"
    }

@router.post("/api/organizations/{org_id}/notification/channels")
@router.post("/organizations/{org_id}/notification/channels")
@router.post("/hermes/api/organizations/{org_id}/notification/channels")
@router.post("/hermes/organizations/{org_id}/notification/channels")
async def register_notification_channel(org_id: str, request: Request):
    return {"status": "registered"}

@router.get("/api/organizations/{org_id}/projects_v2")
@router.get("/organizations/{org_id}/projects_v2")
@router.get("/hermes/api/organizations/{org_id}/projects_v2")
@router.get("/hermes/organizations/{org_id}/projects_v2")
async def list_projects_v2(org_id: str):
    return []

# 6. Chat Conversations Management
@router.get("/api/organizations/{org_id}/chat_conversations")
@router.get("/organizations/{org_id}/chat_conversations")
@router.get("/hermes/api/organizations/{org_id}/chat_conversations")
@router.get("/hermes/organizations/{org_id}/chat_conversations")
async def list_conversations(org_id: str):
    conv_list = []
    for conv in _CONVERSATIONS.values():
        conv_list.append(_build_conv_response(conv))
    conv_list.sort(key=lambda x: x.get("updated_at", ""), reverse=True)
    return conv_list

@router.post("/api/organizations/{org_id}/chat_conversations")
@router.post("/organizations/{org_id}/chat_conversations")
@router.post("/hermes/api/organizations/{org_id}/chat_conversations")
@router.post("/hermes/organizations/{org_id}/chat_conversations")
async def create_conversation(org_id: str, request: Request):
    try:
        body = await request.json()
    except Exception:
        body = {}
    chat_id = body.get("uuid") or str(uuid.uuid4())
    name = body.get("name") or body.get("title") or "Chat"
    now = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
    if chat_id not in _CONVERSATIONS:
        _CONVERSATIONS[chat_id] = {
            "uuid": chat_id,
            "name": name,
            "created_at": now,
            "updated_at": now,
            "chat_messages": []
        }
        _save_history()
    return _build_conv_response(_CONVERSATIONS[chat_id])

@router.put("/api/organizations/{org_id}/chat_conversations/{chat_id}")
@router.put("/organizations/{org_id}/chat_conversations/{chat_id}")
@router.put("/hermes/api/organizations/{org_id}/chat_conversations/{chat_id}")
@router.patch("/api/organizations/{org_id}/chat_conversations/{chat_id}")
@router.patch("/organizations/{org_id}/chat_conversations/{chat_id}")
@router.patch("/hermes/api/organizations/{org_id}/chat_conversations/{chat_id}")
async def update_conversation(org_id: str, chat_id: str, request: Request):
    try:
        body = await request.json()
    except Exception:
        body = {}
    name = body.get("name") or body.get("title") or "Chat"
    now = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
    if chat_id not in _CONVERSATIONS:
        _CONVERSATIONS[chat_id] = {
            "uuid": chat_id,
            "name": name,
            "created_at": now,
            "updated_at": now,
            "chat_messages": []
        }
    else:
        _CONVERSATIONS[chat_id]["name"] = name
        _CONVERSATIONS[chat_id]["updated_at"] = now
    _save_history()
    return _build_conv_response(_CONVERSATIONS[chat_id])

@router.post("/api/organizations/{org_id}/chat_conversations/{chat_id}/title")
@router.post("/organizations/{org_id}/chat_conversations/{chat_id}/title")
@router.post("/hermes/api/organizations/{org_id}/chat_conversations/{chat_id}/title")
async def set_conversation_title(org_id: str, chat_id: str, request: Request):
    try:
        body = await request.json()
    except Exception:
        body = {}
    title = body.get("title") or body.get("name")
    if not title:
        prompt = body.get("message_content") or body.get("prompt") or "Hermes Chat"
        title = prompt.strip()[:35] + "..." if len(prompt.strip()) > 35 else prompt.strip()
    now = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
    if chat_id in _CONVERSATIONS:
        _CONVERSATIONS[chat_id]["name"] = title
        _CONVERSATIONS[chat_id]["updated_at"] = now
    else:
        _CONVERSATIONS[chat_id] = {
            "uuid": chat_id,
            "name": title,
            "created_at": now,
            "updated_at": now,
            "chat_messages": []
        }
    _save_history()
    return {"title": title, "uuid": chat_id, "name": title}

@router.post("/api/organizations/{org_id}/chat_conversations/{chat_id}/stop_response")
@router.post("/organizations/{org_id}/chat_conversations/{chat_id}/stop_response")
@router.post("/hermes/api/organizations/{org_id}/chat_conversations/{chat_id}/stop_response")
async def stop_conversation_response(org_id: str, chat_id: str):
    return {"status": "stopped", "uuid": chat_id}

@router.delete("/api/organizations/{org_id}/chat_conversations/{chat_id}")
@router.delete("/organizations/{org_id}/chat_conversations/{chat_id}")
@router.delete("/hermes/api/organizations/{org_id}/chat_conversations/{chat_id}")
async def delete_conversation(org_id: str, chat_id: str):
    if chat_id in _CONVERSATIONS:
        del _CONVERSATIONS[chat_id]
        _save_history()
    return {"status": "deleted", "uuid": chat_id}

@router.get("/api/organizations/{org_id}/chat_conversations/{chat_id}")
@router.get("/organizations/{org_id}/chat_conversations/{chat_id}")
@router.get("/hermes/api/organizations/{org_id}/chat_conversations/{chat_id}")
async def get_conversation(org_id: str, chat_id: str):
    if chat_id not in _CONVERSATIONS:
        now = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
        _CONVERSATIONS[chat_id] = {
            "uuid": chat_id,
            "name": "Chat",
            "created_at": now,
            "updated_at": now,
            "chat_messages": []
        }
        _save_history()
    return _build_conv_response(_CONVERSATIONS[chat_id])

# Background execution tracking
_ACTIVE_RUNS = {}

async def _execute_agent_background(chat_id: str, prompt: str, messages: list, model: str, msg_id: str, queue: asyncio.Queue):
    """Autonomous agent runner that executes to completion in the background regardless of client connection."""
    full_text = ""
    full_thinking = ""
    thinking_active = False
    text_active = False
    
    try:
        await queue.put(ab.create_message_start(msg_id, model))

        system_instruction = "You are Hermes, an intelligent and helpful AI assistant. Answer the user's query clearly and directly."
        openai_messages = [{"role": "system", "content": system_instruction}]

        for m in messages:
            role = m.get("role") or m.get("sender") or "user"
            if role in ["human", "user"]:
                r = "user"
            elif role in ["assistant", "ai"]:
                r = "assistant"
            elif role == "system":
                r = "system"
            else:
                r = "user"

            txt = m.get("content") or m.get("text") or ""
            if isinstance(txt, list):
                txt = "".join(
                    cb.get("text", "") for cb in txt if isinstance(cb, dict) and cb.get("type") == "text"
                )
            txt_str = str(txt).strip()
            if txt_str:
                openai_messages.append({"role": r, "content": txt_str})

        if not any(m["role"] == "user" for m in openai_messages):
            openai_messages.append({"role": "user", "content": prompt or "Hello"})

        payload = {
            "model": "auto/best-coding",
            "messages": openai_messages,
            "stream": True,
        }

        async for data in ab.stream_upstream(payload):
            data = data.strip()
            if not data or data == "[DONE]":
                continue
            try:
                chunk = json.loads(data)
            except Exception:
                continue

            delta = chunk.get("choices", [{}])[0].get("delta", {}) or {}
            reasoning_delta = delta.get("reasoning_content") or delta.get("reasoning")
            text_delta = delta.get("content", "")

            if reasoning_delta and not text_active:
                if not thinking_active:
                    await queue.put(ab.create_thinking_block_start(0))
                    thinking_active = True
                full_thinking += reasoning_delta
                await queue.put(ab.create_thinking_block_delta(reasoning_delta, 0))

            if text_delta:
                if thinking_active:
                    await queue.put(ab.create_thinking_block_stop(0))
                    thinking_active = False
                if not text_active:
                    text_idx = 1 if full_thinking else 0
                    await queue.put(ab.create_content_block_start(text_idx))
                    text_active = True
                text_idx = 1 if full_thinking else 0
                full_text += text_delta
                await queue.put(ab.create_content_block_delta(text_delta, text_idx))

        if thinking_active:
            await queue.put(ab.create_thinking_block_stop(0))
        
        if text_active:
            text_idx = 1 if full_thinking else 0
            await queue.put(ab.create_content_block_stop(text_idx))
        else:
            await queue.put(ab.create_content_block_start(0))
            await queue.put(ab.create_content_block_stop(0))

        await queue.put(ab.create_message_delta("end_turn"))
        await queue.put(ab.create_message_stop())
    except Exception as e:
        logger.error(f"Error in background agent execution for {chat_id}: {e}")
        # Emit friendly fallback error if stream failed
        if not text_active and not full_text:
            err_text = "I'm here and ready to help. Could you please rephrase or try again?"
            await queue.put(ab.create_content_block_start(0))
            await queue.put(ab.create_content_block_delta(err_text, 0))
            await queue.put(ab.create_content_block_stop(0))
            await queue.put(ab.create_message_delta("end_turn"))
            await queue.put(ab.create_message_stop())
            full_text = err_text
    finally:
        # Guarantee conversation history is saved to disk
        try:
            if full_text.strip():
                if chat_id not in _CONVERSATIONS:
                    now = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
                    _CONVERSATIONS[chat_id] = {
                        "uuid": chat_id,
                        "name": prompt[:30] if prompt else "Chat",
                        "created_at": now,
                        "updated_at": now,
                        "chat_messages": []
                    }
                
                msgs = _CONVERSATIONS[chat_id]["chat_messages"]
                prev_uuid = msgs[-1]["uuid"] if msgs else None
                
                asst_msg = _format_msg("assistant", full_text, len(msgs), prev_uuid)
                asst_msg["content"] = [
                    {"type": "text", "text": full_text}
                ]
                if full_thinking:
                    asst_msg["thinking_process"] = full_thinking
                msgs.append(asst_msg)
                _CONVERSATIONS[chat_id]["updated_at"] = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
                _save_history()
        except Exception as se:
            logger.error(f"Failed to save conversation history for {chat_id}: {se}")
        
        # Signal queue completion
        await queue.put(None)
        if chat_id in _ACTIVE_RUNS:
            del _ACTIVE_RUNS[chat_id]


# 7. Conversation Completion (Streaming Claude Web / App Protocol with Thinking Support)
@router.post("/api/organizations/{org_id}/chat_conversations/{chat_id}/completion")
@router.post("/organizations/{org_id}/chat_conversations/{chat_id}/completion")
@router.post("/api/organizations/{org_id}/chat_conversations/{chat_id}/retry_completion")
@router.post("/organizations/{org_id}/chat_conversations/{chat_id}/retry_completion")
@router.post("/hermes/api/organizations/{org_id}/chat_conversations/{chat_id}/completion")
@router.post("/hermes/api/organizations/{org_id}/chat_conversations/{chat_id}/retry_completion")
async def conversation_completion(org_id: str, chat_id: str, request: Request):
    body = await request.json()
    prompt = body.get("prompt", "")
    attachments = body.get("attachments", [])
    files = body.get("files", [])
    model = "hermes-agent"
    msg_id = f"msg_{uuid.uuid4().hex[:24]}"

    file_context_blocks = []
    for att in attachments:
        fname = att.get("file_name", "file")
        fcontent = att.get("extracted_content") or att.get("content", "")
        if fcontent:
            file_context_blocks.append(f"[Attached File: {fname}]\n{fcontent}")
    for f in files:
        fname = f.get("file_name", "file")
        fcontent = f.get("extracted_content") or f.get("content", "")
        if fcontent:
            file_context_blocks.append(f"[Attached File: {fname}]\n{fcontent}")

    full_prompt = prompt
    if file_context_blocks:
        full_prompt += "\n\n" + "\n\n".join(file_context_blocks)

    # Save user message immediately
    if chat_id not in _CONVERSATIONS:
        now = time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime())
        _CONVERSATIONS[chat_id] = {
            "uuid": chat_id,
            "name": prompt[:30] if prompt else "Chat",
            "created_at": now,
            "updated_at": now,
            "chat_messages": []
        }
    
    msgs = _CONVERSATIONS[chat_id]["chat_messages"]
    prev_uuid = msgs[-1]["uuid"] if msgs else None
    user_msg = _format_msg("human", prompt, len(msgs), prev_uuid)
    if attachments:
        user_msg["attachments"] = attachments
    if files:
        user_msg["files"] = files
    msgs.append(user_msg)
    _save_history()

    history = _CONVERSATIONS[chat_id].get("chat_messages", [])
    formatted = []
    for h in history:
        role = "user" if h.get("sender") == "human" else "assistant"
        msg_text = h.get("text", "")
        content_blocks = h.get("content", [])
        if content_blocks and isinstance(content_blocks, list):
            for cb in content_blocks:
                if isinstance(cb, dict) and cb.get("type") == "text":
                    msg_text = cb.get("text", "")
        if msg_text:
            formatted.append({"role": role, "content": msg_text})
    
    messages = formatted if formatted else [{"role": "user", "content": full_prompt}]
    if messages and messages[-1].get("role") == "user":
        messages[-1]["content"] = full_prompt

    # Create stream queue & launch decoupled background runner
    queue = asyncio.Queue()
    bg_task = asyncio.create_task(_execute_agent_background(chat_id, full_prompt, messages, model, msg_id, queue))
    _ACTIVE_RUNS[chat_id] = {"task": bg_task, "queue": queue}

    async def event_stream():
        while True:
            try:
                item = await asyncio.wait_for(queue.get(), timeout=15.0)
                if item is None:
                    break
                yield item
            except asyncio.TimeoutError:
                # Emit SSE keep-alive heartbeat comment to prevent mobile proxy timeouts
                yield ": keep-alive\n\n"

    return StreamingResponse(
        event_stream(),
        media_type="text/event-stream",
        headers={
            "Cache-Control": "no-cache",
            "X-Accel-Buffering": "no",
            "Connection": "keep-alive"
        }
    )

# 8. Artifacts & In-Chat Files Endpoints
_UPLOADED_FILES: Dict[str, Dict[str, Any]] = {}

def _extract_artifacts_from_conv(chat_id: str) -> List[Dict[str, Any]]:
    conv = _CONVERSATIONS.get(chat_id, {})
    artifacts = []
    seen_ids = set()
    for msg in conv.get("chat_messages", []):
        text = msg.get("text", "")
        for match in re.finditer(r'<antArtifact\s+([^>]+)>([\s\S]*?)</antArtifact>', text):
            attrs_str = match.group(1)
            content = match.group(2).strip()
            attrs = dict(re.findall(r'([a-zA-Z0-9_]+)="([^"]+)"', attrs_str))
            art_id = attrs.get("identifier") or attrs.get("id") or str(uuid.uuid4())
            if art_id not in seen_ids:
                seen_ids.add(art_id)
                artifacts.append({
                    "id": art_id,
                    "uuid": art_id,
                    "version_uuid": str(uuid.uuid4()),
                    "identifier": art_id,
                    "type": attrs.get("type", "application/vnd.ant.markdown"),
                    "title": attrs.get("title", "Document"),
                    "language": attrs.get("language", ""),
                    "content": content,
                    "is_complete": True,
                    "created_at": msg.get("created_at"),
                    "updated_at": msg.get("updated_at")
                })
    return artifacts

@router.get("/api/organizations/{org_id}/chat_conversations/{chat_id}/artifacts")
@router.get("/organizations/{org_id}/chat_conversations/{chat_id}/artifacts")
@router.get("/hermes/api/organizations/{org_id}/chat_conversations/{chat_id}/artifacts")
async def list_conversation_artifacts(org_id: str, chat_id: str):
    artifacts = _extract_artifacts_from_conv(chat_id)
    return {"artifacts": artifacts, "data": artifacts}

@router.get("/api/organizations/{org_id}/chat_conversations/{chat_id}/artifacts/{artifact_id}")
@router.get("/organizations/{org_id}/chat_conversations/{chat_id}/artifacts/{artifact_id}")
@router.get("/hermes/api/organizations/{org_id}/chat_conversations/{chat_id}/artifacts/{artifact_id}")
async def get_artifact(org_id: str, chat_id: str, artifact_id: str):
    artifacts = _extract_artifacts_from_conv(chat_id)
    for art in artifacts:
        if art.get("id") == artifact_id or art.get("identifier") == artifact_id:
            return art
    return {"id": artifact_id, "identifier": artifact_id, "type": "application/vnd.ant.markdown", "title": "Document", "content": "", "is_complete": True}

@router.get("/api/organizations/{org_id}/chat_conversations/{chat_id}/artifacts/{artifact_id}/versions")
@router.get("/organizations/{org_id}/chat_conversations/{chat_id}/artifacts/{artifact_id}/versions")
async def get_artifact_versions(org_id: str, chat_id: str, artifact_id: str):
    artifacts = _extract_artifacts_from_conv(chat_id)
    for art in artifacts:
        if art.get("id") == artifact_id or art.get("identifier") == artifact_id:
            return {"versions": [art], "data": [art]}
    return {"versions": [], "data": []}

@router.post("/api/organizations/{org_id}/chat_conversations/{chat_id}/artifacts/{artifact_id}/publish")
@router.post("/organizations/{org_id}/chat_conversations/{chat_id}/artifacts/{artifact_id}/publish")
async def publish_artifact(org_id: str, chat_id: str, artifact_id: str, request: Request):
    return {"status": "published", "artifact_id": artifact_id, "url": f"https://claude.ai/artifacts/{artifact_id}"}

@router.post("/api/organizations/{org_id}/chat_conversations/{chat_id}/files")
@router.post("/organizations/{org_id}/chat_conversations/{chat_id}/files")
@router.post("/api/organizations/{org_id}/files")
@router.post("/organizations/{org_id}/files")
@router.post("/api/files")
async def upload_file(request: Request):
    try:
        body = await request.json()
        file_name = body.get("file_name", "uploaded_file.txt")
        file_content = body.get("content") or body.get("extracted_content") or ""
        file_type = body.get("file_type", "text/plain")
        file_size = len(file_content.encode("utf-8")) if file_content else body.get("file_size", 0)
    except Exception:
        file_name = "file.txt"
        file_content = ""
        file_type = "text/plain"
        file_size = 0
    
    file_id = f"file_{uuid.uuid4().hex[:16]}"
    file_record = {
        "id": file_id,
        "file_name": file_name,
        "file_size": file_size,
        "file_type": file_type,
        "extracted_content": file_content
    }
    _UPLOADED_FILES[file_id] = file_record
    return file_record

@router.get("/api/organizations/{org_id}/chat_conversations/{chat_id}/files/{file_id}")
@router.get("/organizations/{org_id}/chat_conversations/{chat_id}/files/{file_id}")
@router.get("/api/organizations/{org_id}/files/{file_id}")
@router.get("/organizations/{org_id}/files/{file_id}")
@router.get("/api/files/{file_id}")
async def get_file(file_id: str):
    if file_id in _UPLOADED_FILES:
        return _UPLOADED_FILES[file_id]
    return {"id": file_id, "file_name": "file.txt", "file_size": 0, "file_type": "text/plain", "extracted_content": ""}

# 9. Directory & Feature Flags
@router.get("/v1/directory/servers")
@router.get("/directory/servers")
@router.get("/api/v1/directory/servers")
@router.get("/api/directory/servers")
@router.get("/hermes/v1/directory/servers")
async def directory_servers():
    return {
        "servers": [],
        "data": [],
        "has_more": False
    }

@router.get("/api/organizations/{org_id}/feature_flags")
@router.get("/organizations/{org_id}/feature_flags")
@router.get("/hermes/api/organizations/{org_id}/feature_flags")
async def feature_flags(org_id: str):
    return {
        "flags": {
            "claude_3_5_sonnet": True,
            "claude_3_opus": True,
            "artifacts": True,
            "memory": True,
            "latex": True,
            "model_selector_enabled": True
        }
    }
