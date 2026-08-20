# ==============================================================================
# Anthropic Messages API bridge for the (patched) Claude Android app.
#
# The patched app POSTs Anthropic-format requests to /hermes/v1/messages. The
# upstream (OmniRoute) speaks OpenAI chat/completions and ignores stream:true,
# returning a single OpenAI JSON blob. This bridge translates:
#   Anthropic request  -> OpenAI payload  -> upstream
#   upstream response  -> Anthropic Messages JSON / SSE   (back to the app)
# Works for both stream=false and stream=true (proper message_start /
# content_block_delta / message_stop SSE events).
# ==============================================================================

import json
import os
import uuid

import httpx
from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse, StreamingResponse

router = APIRouter(tags=["AnthropicBridge"])

# Upstream OpenAI-compatible endpoint Hermes calls to get completions.
UPSTREAM_URL = os.getenv(
    "ANTHROPIC_BRIDGE_UPSTREAM_URL",
    "https://jishnupg-opencode-cli.hf.space/v1/chat/completions",
)
UPSTREAM_KEY = os.getenv(
    "ANTHROPIC_BRIDGE_UPSTREAM_KEY",
    os.getenv("OMNIROUTE_API_KEY", "sk-2e556e0437ee2958-7baf2d-b4133935"),
)
# Model sent to the upstream. OmniRoute only understands its own routing ids,
# so always send auto/best-coding regardless of what the app requests. The app
# still sees its own requested model echoed back in the response.
UPSTREAM_MODEL = os.getenv("ANTHROPIC_BRIDGE_UPSTREAM_MODEL", "auto/best-coding")
# Model name the app requested -> echoed back in Anthropic responses.
DEFAULT_APP_MODEL = os.getenv("HERMES_ANTHROPIC_MODEL", "hermes-3-2503")


def anthropic_message(oc: dict, request_model: str) -> dict:
    text = ""
    if oc.get("choices"):
        text = oc["choices"][0].get("message", {}).get("content", "") or ""
    usage = oc.get("usage", {})
    return {
        "id": "msg_" + oc.get("id", str(uuid.uuid4())),
        "type": "message",
        "role": "assistant",
        "model": request_model,
        "content": [{"type": "text", "text": text}],
        "stop_reason": "end_turn",
        "stop_sequence": None,
        "usage": {
            "input_tokens": usage.get("prompt_tokens", 0),
            "output_tokens": usage.get("completion_tokens", 0),
        },
    }


def messages_to_openai(anthropic_messages: list) -> list:
    out = []
    for m in anthropic_messages:
        content = m.get("content")
        if isinstance(content, list):
            text = "".join(
                b.get("text", "") for b in content if b.get("type") == "text"
            )
        else:
            text = content or ""
        out.append({"role": m.get("role", "user"), "content": text})
    return out


def system_to_openai(system) -> str:
    """Flatten the Anthropic `system` field (string or content blocks) to text."""
    if isinstance(system, str):
        return system
    if isinstance(system, list):
        return "".join(
            b.get("text", "") for b in system if b.get("type") == "text"
        )
    return str(system or "")


async def stream_upstream(payload: dict):
    """Stream raw SSE data lines from the upstream.

    OmniRoute ignores stream:false and ALWAYS returns text/event-stream, so
    every call is streamed and parsed as SSE.
    """
    async with httpx.AsyncClient(timeout=300) as client:
        async with client.stream(
            "POST",
            UPSTREAM_URL,
            headers={
                "Authorization": f"Bearer {UPSTREAM_KEY}",
                "Content-Type": "application/json",
            },
            json=payload,
        ) as r:
            r.raise_for_status()
            async for line in r.aiter_lines():
                line = line.strip()
                if line.startswith("data: "):
                    yield line[6:]
                elif line == "data: [DONE]":
                    yield "[DONE]"


async def assemble_upstream(payload: dict) -> tuple:
    """Consume the upstream SSE stream and assemble full text + usage.

    Returns (text, usage_dict). Used for stream:false clients.
    """
    text_parts = []
    prompt_tokens = 0
    completion_tokens = 0
    async for data in stream_upstream(payload):
        data = data.strip()
        if not data or data == "[DONE]":
            continue
        try:
            chunk = json.loads(data)
        except json.JSONDecodeError:
            continue
        delta = chunk.get("choices", [{}])[0].get("delta", {}) or {}
        piece = delta.get("content")
        if piece:
            text_parts.append(piece)
        usage = chunk.get("usage") or {}
        if usage:
            prompt_tokens = usage.get("prompt_tokens", prompt_tokens)
            completion_tokens = usage.get("completion_tokens", completion_tokens)
    return "".join(text_parts), {
        "prompt_tokens": prompt_tokens,
        "completion_tokens": completion_tokens,
    }


async def anthropic_sse(request_model: str, payload: dict):
    id_ = "msg_" + uuid.uuid4().hex
    started = False
    text_so_far = ""
    try:
        async for data in stream_upstream(payload):
            data = data.strip()
            if not data or data == "[DONE]":
                continue
            try:
                chunk = json.loads(data)
            except json.JSONDecodeError:
                continue
            delta = (
                chunk.get("choices", [{}])[0].get("delta", {}) or {}
            )
            piece = delta.get("content")
            if piece is None:
                continue
            if not started:
                started = True
                yield (
                    "event: message_start\n"
                    "data: " + json.dumps({
                        "type": "message_start",
                        "message": {
                            "id": id_, "type": "message", "role": "assistant",
                            "model": request_model, "content": [],
                            "stop_reason": None, "stop_sequence": None,
                            "usage": {"input_tokens": 0, "output_tokens": 0},
                        },
                    }) + "\n\n"
                )
                yield (
                    "event: content_block_start\n"
                    "data: " + json.dumps({
                        "type": "content_block_start", "index": 0,
                        "content_block": {"type": "text", "text": ""},
                    }) + "\n\n"
                )
            text_so_far += piece
            yield (
                "event: content_block_delta\n"
                "data: " + json.dumps({
                    "type": "content_block_delta", "index": 0,
                    "delta": {"type": "text_delta", "text": piece},
                }) + "\n\n"
            )
    finally:
        if started:
            yield "event: content_block_stop\ndata: " + json.dumps({
                "type": "content_block_stop", "index": 0}) + "\n\n"
            yield "event: message_delta\ndata: " + json.dumps({
                "type": "message_delta",
                "delta": {"stop_reason": "end_turn", "stop_sequence": None},
                "usage": {"input_tokens": 0, "output_tokens": len(text_so_far)},
            }) + "\n\n"
            yield "event: message_stop\ndata: " + json.dumps({
                "type": "message_stop"}) + "\n\n"


def build_openai_payload(body: dict) -> dict:
    """Translate an Anthropic Messages body into an OpenAI chat/completions payload."""
    model = body.get("model") or DEFAULT_APP_MODEL
    max_tokens = body.get("max_tokens", 4096)
    openai_messages = messages_to_openai(body.get("messages", []))
    system = body.get("system")
    if system:
        system_text = system_to_openai(system)
        if system_text:
            openai_messages.insert(0, {"role": "system", "content": system_text})
    payload = {
        "model": UPSTREAM_MODEL,
        "messages": openai_messages,
        "max_tokens": max_tokens,
    }
    if body.get("temperature") is not None:
        payload["temperature"] = body["temperature"]
    if body.get("top_p") is not None:
        payload["top_p"] = body["top_p"]
    return model, payload


@router.get("/hermes/v1/models")
async def models():
    """Anthropic-compatible model list so the app can discover the backend."""
    return JSONResponse({
        "data": [{"type": "model", "id": UPSTREAM_MODEL}],
        "has_more": False,
    })


@router.post("/hermes/v1/messages")
async def messages(request: Request):
    body = await request.json()
    model = body.get("model") or DEFAULT_APP_MODEL
    app_model, payload = build_openai_payload(body)

    if body.get("stream"):
        payload["stream"] = True
        return StreamingResponse(
            anthropic_sse(app_model, payload),
            media_type="text/event-stream",
            headers={"Cache-Control": "no-cache", "X-Accel-Buffering": "no"},
        )

    # Upstream always streams SSE; assemble the full response for the client.
    payload["stream"] = True
    text, usage = await assemble_upstream(payload)
    oc = {
        "id": str(uuid.uuid4()),
        "choices": [{"message": {"content": text}}],
        "usage": usage,
    }
    return JSONResponse(anthropic_message(oc, app_model))