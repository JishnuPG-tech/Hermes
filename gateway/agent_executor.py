import os
import re
import json
import uuid
import time
import asyncio
import subprocess
from pathlib import Path
from typing import Dict, Any, List, Optional, Tuple, AsyncGenerator
import httpx
from gateway import anthropic_bridge as ab

# Base workspace directory for safe executions
DEFAULT_WORKSPACE = Path("/data") if Path("/data").exists() else Path("/tmp")
DEFAULT_WORKSPACE.mkdir(parents=True, exist_ok=True)
SKILLS_DIR = Path("/data/hermes/skills") if Path("/data/hermes").exists() else Path("/tmp/hermes/skills")
SKILLS_DIR.mkdir(parents=True, exist_ok=True)

# Active skills per conversation: chat_id -> list of skill names
ACTIVE_CONVERSATION_SKILLS: Dict[str, List[str]] = {}

# Built-in Skills Catalog
BUILTIN_SKILLS = {
    "python-pro": {
        "name": "python-pro",
        "description": "Master Python 3.12+ with modern features, async programming, performance optimization, and clean architecture.",
        "prompt": "You are a master Python engineer. Write modern Python 3.12+ code with type hints, asyncio, clean modular design, and robust error handling."
    },
    "fastapi-pro": {
        "name": "fastapi-pro",
        "description": "Expert in building high-performance async APIs with FastAPI, Pydantic V2, and SQLAlchemy 2.0.",
        "prompt": "You are a FastAPI expert. Build high-performance async REST/WebSocket APIs with Pydantic V2 models, dependency injection, and clean architecture."
    },
    "code-reviewer": {
        "name": "code-reviewer",
        "description": "Elite code review specialist analyzing security, performance, correctness, and clean code practices.",
        "prompt": "You are an elite code reviewer. Thoroughly analyze code for security vulnerabilities, edge cases, maintainability, and algorithmic performance."
    },
    "docker-expert": {
        "name": "docker-expert",
        "description": "Containerization expert specializing in multi-stage Docker builds, orchestration, security, and minimal images.",
        "prompt": "You are a Docker and containerization expert. Craft production-grade Dockerfiles, Compose files, and container optimization strategies."
    },
    "database-architect": {
        "name": "database-architect",
        "description": "Database design and optimization expert for PostgreSQL, SQLite, Redis, and schema modeling.",
        "prompt": "You are a senior database architect. Design optimal relational/document schemas, indexing strategies, migrations, and query tuning."
    },
    "security-auditor": {
        "name": "security-auditor",
        "description": "Security auditing specialist analyzing OWASP Top 10 vulnerabilities, API security, and privilege escalation.",
        "prompt": "You are a security auditor. Inspect code and configurations for injection, auth bypasses, CSRF/XSS, and credential leaks."
    },
    "systematic-debugging": {
        "name": "systematic-debugging",
        "description": "Root-cause diagnosis and debugging specialist tracing stack traces, network failures, and race conditions.",
        "prompt": "You are a systematic debugging specialist. Hypothesize, isolate root causes, examine logs/traces, and construct minimal verified fixes."
    }
}

# OpenAI-compatible Function Tool Definitions
AGENT_TOOLS = [
    {
        "type": "function",
        "function": {
            "name": "bash",
            "description": "Execute a bash shell command on the server in a controlled environment. Returns stdout, stderr, and exit code.",
            "parameters": {
                "type": "object",
                "properties": {
                    "command": {
                        "type": "string",
                        "description": "The shell command line string to execute."
                    },
                    "cwd": {
                        "type": "string",
                        "description": "Optional working directory path (defaults to /data or /tmp)."
                    }
                },
                "required": ["command"]
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "read_file",
            "description": "Read the contents of a file on the server.",
            "parameters": {
                "type": "object",
                "properties": {
                    "path": {
                        "type": "string",
                        "description": "The absolute or relative file path to read."
                    }
                },
                "required": ["path"]
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "write_file",
            "description": "Write or create a file on the server.",
            "parameters": {
                "type": "object",
                "properties": {
                    "path": {
                        "type": "string",
                        "description": "The file path to write to."
                    },
                    "content": {
                        "type": "string",
                        "description": "The text content to write."
                    }
                },
                "required": ["path", "content"]
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "list_dir",
            "description": "List files and subdirectories in a directory path on the server.",
            "parameters": {
                "type": "object",
                "properties": {
                    "path": {
                        "type": "string",
                        "description": "The directory path to list (defaults to /data)."
                    }
                }
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "activate_skill",
            "description": "Activate a specialized agent skill to enhance your domain expertise.",
            "parameters": {
                "type": "object",
                "properties": {
                    "skill_name": {
                        "type": "string",
                        "description": "The name of the skill to activate (e.g., 'python-pro', 'fastapi-pro', 'code-reviewer', 'docker-expert', 'database-architect', 'security-auditor', 'systematic-debugging')."
                    }
                },
                "required": ["skill_name"]
            }
        }
    },
    {
        "type": "function",
        "function": {
            "name": "list_skills",
            "description": "List all available skills that can be activated on the server.",
            "parameters": {
                "type": "object",
                "properties": {}
            }
        }
    }
]

async def execute_tool_call(name: str, args: Dict[str, Any], chat_id: str) -> str:
    """Execute a tool call safely and return the result string."""
    try:
        if name == "bash":
            cmd = args.get("command", "")
            cwd = args.get("cwd") or str(DEFAULT_WORKSPACE)
            if not os.path.exists(cwd):
                cwd = str(DEFAULT_WORKSPACE)
            
            proc = await asyncio.create_subprocess_shell(
                cmd,
                cwd=cwd,
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE
            )
            try:
                stdout, stderr = await asyncio.wait_for(proc.communicate(), timeout=45.0)
                out_str = stdout.decode("utf-8", errors="replace")
                err_str = stderr.decode("utf-8", errors="replace")
                res = f"Exit code: {proc.returncode}\n"
                if out_str:
                    res += f"Output:\n{out_str}\n"
                if err_str:
                    res += f"Error:\n{err_str}\n"
                if not out_str and not err_str:
                    res += "(Command finished with no output)\n"
                return res.strip()
            except asyncio.TimeoutError:
                try:
                    proc.kill()
                except Exception:
                    pass
                return "Error: Command timed out after 45 seconds."

        elif name == "read_file":
            fpath = Path(args.get("path", ""))
            if not fpath.is_absolute():
                fpath = DEFAULT_WORKSPACE / fpath
            if not fpath.exists():
                return f"Error: File '{fpath}' does not exist."
            if fpath.is_dir():
                return f"Error: '{fpath}' is a directory, not a file."
            content = fpath.read_text(encoding="utf-8", errors="replace")
            # Limit size for safety
            if len(content) > 30000:
                content = content[:30000] + "\n... (truncated)"
            return content

        elif name == "write_file":
            fpath = Path(args.get("path", ""))
            if not fpath.is_absolute():
                fpath = DEFAULT_WORKSPACE / fpath
            fpath.parent.mkdir(parents=True, exist_ok=True)
            content = args.get("content", "")
            fpath.write_text(content, encoding="utf-8")
            return f"Successfully wrote {len(content)} characters to '{fpath}'."

        elif name == "list_dir":
            dpath = Path(args.get("path") or DEFAULT_WORKSPACE)
            if not dpath.is_absolute():
                dpath = DEFAULT_WORKSPACE / dpath
            if not dpath.exists():
                return f"Error: Directory '{dpath}' does not exist."
            if not dpath.is_dir():
                return f"Error: '{dpath}' is a file, not a directory."
            
            entries = []
            for item in sorted(os.listdir(dpath)):
                ipath = dpath / item
                if ipath.is_dir():
                    entries.append(f"📁 {item}/")
                else:
                    sz = ipath.stat().st_size
                    entries.append(f"📄 {item} ({sz} bytes)")
            return "\n".join(entries) if entries else "(Directory is empty)"

        elif name == "activate_skill":
            sname = args.get("skill_name", "").strip().lower()
            # Check builtin skills
            if sname in BUILTIN_SKILLS:
                skill_info = BUILTIN_SKILLS[sname]
                if chat_id not in ACTIVE_CONVERSATION_SKILLS:
                    ACTIVE_CONVERSATION_SKILLS[chat_id] = []
                if sname not in ACTIVE_CONVERSATION_SKILLS[chat_id]:
                    ACTIVE_CONVERSATION_SKILLS[chat_id].append(sname)
                return f"✓ Skill '{sname}' activated! Description: {skill_info['description']}"
            
            # Check skills in /data/hermes/skills
            custom_skill_file = SKILLS_DIR / sname / "SKILL.md"
            if custom_skill_file.exists():
                content = custom_skill_file.read_text(encoding="utf-8", errors="replace")
                if chat_id not in ACTIVE_CONVERSATION_SKILLS:
                    ACTIVE_CONVERSATION_SKILLS[chat_id] = []
                if sname not in ACTIVE_CONVERSATION_SKILLS[chat_id]:
                    ACTIVE_CONVERSATION_SKILLS[chat_id].append(sname)
                return f"✓ Custom skill '{sname}' loaded and activated from disk!\n{content[:500]}..."

            return f"Error: Skill '{sname}' not found. Use list_skills to view available skills."

        elif name == "list_skills":
            lines = ["Available Built-in Skills:"]
            for k, v in BUILTIN_SKILLS.items():
                lines.append(f"- **{k}**: {v['description']}")
            
            # Check disk skills
            if SKILLS_DIR.exists():
                disk_skills = [d for d in os.listdir(SKILLS_DIR) if (SKILLS_DIR / d).is_dir()]
                if disk_skills:
                    lines.append("\nAvailable Custom Skills on Disk (/data/hermes/skills):")
                    for ds in disk_skills:
                        lines.append(f"- **{ds}**")
            
            active = ACTIVE_CONVERSATION_SKILLS.get(chat_id, [])
            if active:
                lines.append(f"\nCurrently Active in this conversation: {', '.join(active)}")
            return "\n".join(lines)

        else:
            return f"Error: Unknown tool '{name}'."
    except Exception as e:
        return f"Error executing tool '{name}': {str(e)}"

def build_system_prompt_with_skills(chat_id: str) -> str:
    base_prompt = (
        "You are Hermes, an autonomous agent and AI pair programmer with full shell command execution, file management, and dynamic skills activation.\n\n"
        "# Capabilities & Tools:\n"
        "You have direct access to execute tools on the server:\n"
        "- `bash`: Run shell commands in the container.\n"
        "- `read_file`: Inspect any file or source code on the server.\n"
        "- `write_file`: Create or edit files on the server.\n"
        "- `list_dir`: Browse directories.\n"
        "- `activate_skill`: Dynamically activate specialized skills.\n"
        "- `list_skills`: View all available skills.\n\n"
        "# Artifacts Rendering:\n"
        "When generating complete, substantial, or self-contained documents, websites, code, or diagrams, wrap the content in an `<antArtifact>` tag:\n"
        "<antArtifact identifier=\"unique-id\" type=\"application/vnd.ant.markdown\" title=\"Title\">\n"
        "... content ...\n"
        "</antArtifact>\n\n"
        "Supported types:\n"
        "- `application/vnd.ant.markdown`: For Markdown (.md) documents and summaries.\n"
        "- `text/html`: For complete HTML/CSS/JavaScript web pages and interactive apps.\n"
        "- `image/svg+xml`: For vector diagrams and icons.\n"
        "- `application/vnd.ant.code` (with `language=\"python\" | \"javascript\" | ...`): For standalone source files.\n"
        "- `application/vnd.ant.mermaid`: For flowcharts and diagrams.\n\n"
        "Be concise, direct, helpful, and take action autonomously when asked to inspect files, execute tasks, or activate skills."
    )

    active_skills = ACTIVE_CONVERSATION_SKILLS.get(chat_id, [])
    if active_skills:
        base_prompt += "\n\n# Active Specialized Skills:\n"
        for s in active_skills:
            if s in BUILTIN_SKILLS:
                base_prompt += f"## Skill: {s}\n{BUILTIN_SKILLS[s]['prompt']}\n\n"
            else:
                sfile = SKILLS_DIR / s / "SKILL.md"
                if sfile.exists():
                    base_prompt += f"## Skill: {s}\n{sfile.read_text(encoding='utf-8', errors='replace')}\n\n"

    return base_prompt

async def run_autonomous_agent(
    chat_id: str,
    prompt: str,
    messages: list,
    model: str,
    msg_id: str,
    queue: asyncio.Queue
) -> str:
    """Multi-turn autonomous execution loop with function calling and tool execution."""
    full_text = ""
    text_active = False

    # Check for direct slash command to activate skill
    skill_match = re.search(r'(?:^/skill\s+|activate\s+(?:the\s+)?skill\s+|use\s+(?:the\s+)?skill\s+)([a-zA-Z0-9_\-]+)', prompt, re.IGNORECASE)
    if skill_match:
        sname = skill_match.group(1).strip().lower()
        res = await execute_tool_call("activate_skill", {"skill_name": sname}, chat_id)
        await queue.put(ab.create_content_block_start(0))
        await queue.put(ab.create_content_block_delta(res, 0))
        await queue.put(ab.create_content_block_stop(0))
        await queue.put(ab.create_message_delta("end_turn"))
        await queue.put(ab.create_message_stop())
        return res

    system_prompt = build_system_prompt_with_skills(chat_id)
    openai_messages = [{"role": "system", "content": system_prompt}]

    for m in messages:
        role = m.get("role") or m.get("sender") or "user"
        r = "user" if role in ["human", "user"] else ("assistant" if role in ["assistant", "ai"] else "system")
        txt = m.get("content") or m.get("text") or ""
        if isinstance(txt, list):
            txt = "".join(cb.get("text", "") for cb in txt if isinstance(cb, dict) and cb.get("type") == "text")
        txt_str = str(txt).strip()
        if txt_str:
            openai_messages.append({"role": r, "content": txt_str})

    if not any(m["role"] == "user" for m in openai_messages):
        openai_messages.append({"role": "user", "content": prompt or "Hello"})

    max_turns = 10
    block_index = 0

    for turn in range(max_turns):
        payload = {
            "model": model or "auto/smart",
            "messages": openai_messages,
            "tools": AGENT_TOOLS,
            "tool_choice": "auto",
            "stream": False
        }

        response_data = None
        for candidate_url in [
            "http://127.0.0.1:20128/v1/chat/completions",
            "http://127.0.0.1:8642/v1/chat/completions"
        ]:
            try:
                async with httpx.AsyncClient(timeout=60.0) as client:
                    resp = await client.post(
                        candidate_url,
                        headers={
                            "Authorization": f"Bearer {ab.UPSTREAM_KEY}",
                            "Content-Type": "application/json"
                        },
                        json=payload
                    )
                    if resp.status_code == 200:
                        response_data = resp.json()
                        break
            except Exception:
                continue

        if not response_data or "choices" not in response_data or not response_data["choices"]:
            break

        choice = response_data["choices"][0]
        message_obj = choice.get("message", {})
        content = message_obj.get("content") or ""
        tool_calls = message_obj.get("tool_calls") or []

        if content:
            if not text_active:
                await queue.put(ab.create_content_block_start(block_index))
                text_active = True
            await queue.put(ab.create_content_block_delta(content, block_index))
            full_text += content

        openai_messages.append(message_obj)

        if not tool_calls:
            break

        for tc in tool_calls:
            fn = tc.get("function", {})
            fn_name = fn.get("name", "")
            raw_args = fn.get("arguments", "{}")
            try:
                fn_args = json.loads(raw_args) if isinstance(raw_args, str) else raw_args
            except Exception:
                fn_args = {}

            tool_msg = f"\n\n⚡ **Executing `{fn_name}`**"
            if "command" in fn_args:
                tool_msg += f": `{fn_args['command']}`"
            elif "path" in fn_args:
                tool_msg += f": `{fn_args['path']}`"
            elif "skill_name" in fn_args:
                tool_msg += f": `{fn_args['skill_name']}`"
            tool_msg += "...\n"

            if not text_active:
                await queue.put(ab.create_content_block_start(block_index))
                text_active = True
            await queue.put(ab.create_content_block_delta(tool_msg, block_index))
            full_text += tool_msg

            tool_result = await execute_tool_call(fn_name, fn_args, chat_id)

            openai_messages.append({
                "role": "tool",
                "tool_call_id": tc.get("id", f"call_{uuid.uuid4().hex[:12]}"),
                "name": fn_name,
                "content": str(tool_result)
            })

    if text_active:
        await queue.put(ab.create_content_block_stop(block_index))
    elif not full_text:
        reply = "I've processed your request."
        await queue.put(ab.create_content_block_start(0))
        await queue.put(ab.create_content_block_delta(reply, 0))
        await queue.put(ab.create_content_block_stop(0))
        full_text = reply

    await queue.put(ab.create_message_delta("end_turn"))
    await queue.put(ab.create_message_stop())
    return full_text
