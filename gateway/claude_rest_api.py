"""
Claude APK Mock REST API - Full Implementation for Hermes Agent
Returns proper Map-format model_selector_config, premium flags, thinking modes
"""
from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse, StreamingResponse

router = APIRouter(tags=["ClaudeREST"])

ORG_UUID = "org-personal"
USER_UUID = "user-00000000-0000-0000-0000-000000000001"

MODEL_SELECTOR_CONFIG = {
    "chat": {
        "id": "chat",
        "models": [
            {
                "id": "claude-3-5-sonnet-20241022",
                "name": "Sonnet 5",
                "short_name": "Sonnet 5 Low",
                "badge": None,
                "capabilities": {
                    "mm_images": True,
                    "mm_pdf": True,
                    "web_search": True,
                    "code_execution": True
                },
                "thinking": {
                    "mode_options": [
                        {"id": "off", "name": "Off", "description": "Direct response without thinking", "recommended": False},
                        {"id": "auto", "name": "Auto", "description": "Let Hermes decide when to think", "recommended": True},
                        {"id": "on", "name": "Always On", "description": "Always think before answering", "recommended": False}
                    ],
                    "effort_options": [
                        {"id": "low", "name": "Low", "description": "Quick reasoning", "recommended": False},
                        {"id": "medium", "name": "Medium", "description": "Balanced reasoning", "recommended": True},
                        {"id": "high", "name": "High", "description": "Deep thinking", "recommended": False},
                        {"id": "max", "name": "Max", "description": "Maximum reasoning effort", "recommended": False}
                    ]
                }
            },
            {
                "id": "claude-3-5-haiku-20241022",
                "name": "Haiku 4.5",
                "short_name": "Haiku 4.5",
                "badge": None,
                "capabilities": {
                    "mm_images": True,
                    "mm_pdf": True,
                    "web_search": True,
                    "code_execution": True
                },
                "thinking": {
                    "mode_options": [
                        {"id": "off", "name": "Off", "description": "Direct response without thinking", "recommended": False},
                        {"id": "auto", "name": "Auto", "description": "Let Hermes decide when to think", "recommended": True},
                        {"id": "on", "name": "Always On", "description": "Always think before answering", "recommended": False}
                    ],
                    "effort_options": [
                        {"id": "low", "name": "Low", "description": "Quick reasoning", "recommended": False},
                        {"id": "medium", "name": "Medium", "description": "Balanced reasoning", "recommended": True},
                        {"id": "high", "name": "High", "description": "Deep thinking", "recommended": False},
                        {"id": "max", "name": "Max", "description": "Maximum reasoning effort", "recommended": False}
                    ]
                }
            },
            {
                "id": "claude-3-opus-20240229",
                "name": "Opus 5",
                "short_name": "Opus 5",
                "badge": {"message": {"english": "Pro"}},
                "capabilities": {
                    "mm_images": True,
                    "mm_pdf": True,
                    "web_search": True,
                    "code_execution": True
                },
                "thinking": {
                    "mode_options": [
                        {"id": "off", "name": "Off", "description": "Direct response without thinking", "recommended": False},
                        {"id": "auto", "name": "Auto", "description": "Let Hermes decide when to think", "recommended": True},
                        {"id": "on", "name": "Always On", "description": "Always think before answering", "recommended": False}
                    ],
                    "effort_options": [
                        {"id": "low", "name": "Low", "description": "Quick reasoning", "recommended": False},
                        {"id": "medium", "name": "Medium", "description": "Balanced reasoning", "recommended": True},
                        {"id": "high", "name": "High", "description": "Deep thinking", "recommended": False},
                        {"id": "max", "name": "Max", "description": "Maximum reasoning effort", "recommended": False}
                    ]
                }
            },
            {
                "id": "hermes-agent",
                "name": "Fable 5",
                "short_name": "Fable 5",
                "badge": {"message": {"english": "Pro"}},
                "capabilities": {
                    "mm_images": True,
                    "mm_pdf": True,
                    "web_search": True,
                    "code_execution": True
                },
                "thinking": {
                    "mode_options": [
                        {"id": "off", "name": "Off", "description": "Direct response without thinking", "recommended": False},
                        {"id": "auto", "name": "Auto", "description": "Let Hermes decide when to think", "recommended": True},
                        {"id": "on", "name": "Always On", "description": "Always think before answering", "recommended": False}
                    ],
                    "effort_options": [
                        {"id": "low", "name": "Low", "description": "Quick reasoning", "recommended": False},
                        {"id": "medium", "name": "Medium", "description": "Balanced reasoning", "recommended": True},
                        {"id": "high", "name": "High", "description": "Deep thinking", "recommended": False},
                        {"id": "max", "name": "Max", "description": "Maximum reasoning effort", "recommended": False}
                    ]
                }
            }
        ]
    },
    "voice": {
        "id": "voice",
        "models": [
            {
                "id": "claude-3-5-sonnet-20241022",
                "name": "Sonnet 5",
                "short_name": "Sonnet 5 Low",
                "badge": None,
                "capabilities": {
                    "mm_images": True,
                    "mm_pdf": True,
                    "web_search": True,
                    "code_execution": True
                }
            },
            {
                "id": "claude-3-5-haiku-20241022",
                "name": "Haiku 4.5",
                "short_name": "Haiku 4.5",
                "badge": None,
                "capabilities": {
                    "mm_images": True,
                    "mm_pdf": True,
                    "web_search": True,
                    "code_execution": True
                }
            }
        ]
    }
}

MODEL_SELECTOR_STATE = {
    "chat": {
        "id": "chat",
        "model": "hermes-agent",
        "thinking": {"mode": "auto", "effort": "high"}
    },
    "voice": {
        "id": "voice",
        "model": "claude-3-5-sonnet-20241022",
        "thinking": None
    }
}

PREMIUM_FLAGS = {
    "pro_enabled": True,
    "premium_enabled": True,
    "subscription_active": True,
    "model_selector_enabled": True,
    "artifacts_enabled": True,
    "web_search_enabled": True,
    "code_execution_enabled": True,
    "memory_enabled": True,
    "voice_enabled": True
}

ACTIVE_FLAGS = [
    "claude_3_5_sonnet",
    "claude_3_opus",
    "artifacts",
    "memory",
    "latex",
    "model_selector_enabled",
    "pro_enabled",
    "premium_enabled"
]


@router.get("/api/account/app_start")
async def app_start():
    """Main app start endpoint - returns account, model selector config/state, premium flags"""
    return JSONResponse({
        "account": {
            "uuid": USER_UUID,
            "email": "user@hermes.local",
            "name": "User",
            "organization": {
                "uuid": ORG_UUID,
                "name": "Personal",
                "capabilities": ["pro", "artifacts", "tools", "memory", "web_search"],
                "chat_access": True,
            },
        },
        "flags": PREMIUM_FLAGS,
        "active_flags": ACTIVE_FLAGS,
        "model_selector_config": MODEL_SELECTOR_CONFIG,
        "model_selector_state": [
            {"id": k, "model": v["model"], "thinking": v.get("thinking")}
            for k, v in MODEL_SELECTOR_STATE.items()
        ],
        "growthbook": {"features": {}},
        "server_localizations": {},
        "current_user_access": {"has_access": True},
        "personalized_greeting": [],
    })


@router.get("/api/bootstrap")
@router.get("/api/bootstrap/{org_id}")
async def bootstrap(org_id: str = ORG_UUID):
    return JSONResponse({
        "account": {
            "uuid": USER_UUID,
            "email": "user@hermes.local",
            "name": "User",
            "organization": {
                "uuid": org_id,
                "name": "Personal",
                "capabilities": ["pro", "artifacts", "tools", "memory", "web_search"],
                "chat_access": True,
            },
        },
        "flags": PREMIUM_FLAGS,
        "active_flags": ACTIVE_FLAGS,
        "model_selector_config": MODEL_SELECTOR_CONFIG,
        "model_selector_state": [
            {"id": k, "model": v["model"], "thinking": v.get("thinking")}
            for k, v in MODEL_SELECTOR_STATE.items()
        ],
        "growthbook": {"features": {}},
        "server_localizations": {},
        "current_user_access": {"has_access": True},
        "personalized_greeting": [],
    })


@router.get("/api/account")
async def account():
    return JSONResponse({
        "uuid": USER_UUID,
        "email": "user@hermes.local",
        "name": "User",
        "organization": {"uuid": ORG_UUID, "name": "Personal", "capabilities": ["pro"]},
        "subscription": {
            "tier": "MAX",
            "status": "active",
            "expires_at": "2099-12-31T23:59:59Z"
        },
        "entitlements": {
            "pro": True,
            "max": True,
            "artifacts": True,
            "web_search": True,
            "code_execution": True,
            "memory": True,
            "voice": True
        }
    })


@router.get("/api/organizations")
async def organizations():
    return JSONResponse([
        {"uuid": ORG_UUID, "name": "Personal", "capabilities": ["pro"], "chat_access": True}
    ])


@router.get("/api/organizations/{org_id}/model_selector_state/{surface}")
async def get_model_selector_state(org_id: str, surface: str):
    state = MODEL_SELECTOR_STATE.get(surface, {})
    return JSONResponse({
        "id": surface,
        "model": state.get("model", "hermes-agent"),
        "thinking": state.get("thinking")
    })


@router.post("/api/organizations/{org_id}/model_selector_state/{surface}")
async def set_model_selector_state(org_id: str, surface: str, request: Request):
    body = await request.json()
    model = body.get("model", "hermes-agent")
    thinking = body.get("thinking", {"mode": "auto", "effort": "high"})
    
    if surface in MODEL_SELECTOR_STATE:
        MODEL_SELECTOR_STATE[surface] = {"id": surface, "model": model, "thinking": thinking}
    
    return JSONResponse({
        "id": surface,
        "model": model,
        "thinking": thinking
    })


@router.get("/api/organizations/{org_id}/chat_conversations")
async def chat_conversations(org_id: str, limit: int = 30):
    return JSONResponse({"data": []})


@router.get("/api/organizations/{org_id}/chat_conversations/{chat_id}")
async def get_conversation(org_id: str, chat_id: str):
    return JSONResponse({
        "uuid": chat_id,
        "name": "Conversation",
        "messages": [],
        "model": "hermes-agent"
    })


@router.post("/api/organizations/{org_id}/chat_conversations/{chat_id}/completion")
async def completion(org_id: str, chat_id: str, request: Request):
    async def event_stream():
        yield "event: message_start\ndata: {\"message_id\":\"msg-auto\",\"model\":\"hermes-agent\"}\n\n"
        yield "event: content_block_start\ndata: {\"index\":0,\"type\":\"text\"}\n\n"
        yield "event: content_block_delta\ndata: {\"index\":0,\"text\":\"I received your message.\"}\n\n"
        yield "event: content_block_stop\ndata: {\"index\":0}\n\n"
        yield "event: message_stop\ndata: {}\n\n"
    return StreamingResponse(event_stream(), media_type="text/event-stream")


@router.post("/api/organizations/{org_id}/chat_conversations/{chat_id}/title")
async def generate_title(org_id: str, chat_id: str):
    return JSONResponse({"title": "New Conversation"})


@router.post("/api/organizations/{org_id}/chat_conversations/{chat_id}/stop_response")
async def stop_response(org_id: str, chat_id: str):
    return JSONResponse({"status": "stopped"})


# Background task endpoints for 24x7 agent
@router.post("/api/organizations/{org_id}/chat_conversations/{chat_id}/completion/background")
async def start_background_run(org_id: str, chat_id: str, request: Request):
    body = await request.json()
    run_id = f"run_{uuid.uuid4().hex[:16]}"
    # In production, this would trigger the Hermes agent background execution
    return JSONResponse({
        "run_id": run_id,
        "status": "started",
        "message": "Background task started"
    })


@router.get("/api/organizations/{org_id}/background_runs/{run_id}")
async def get_background_run(org_id: str, run_id: str):
    return JSONResponse({
        "run_id": run_id,
        "status": "completed",
        "result": "Background task completed successfully",
        "completed_at": "2026-08-25T10:00:00Z"
    })


@router.get("/api/organizations/{org_id}/background_runs")
async def list_background_runs(org_id: str):
    return JSONResponse({
        "runs": []
    })


import uuid