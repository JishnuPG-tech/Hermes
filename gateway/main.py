from fastapi import FastAPI
from fastapi.responses import JSONResponse

from gateway.anthropic_bridge import router as anthropic_router
from gateway.hermes_proxy import router as hermes_proxy_router

app = FastAPI(
    title="Hermes Agent Space Gateway",
    description="Anthropic Messages API bridge + reverse proxy to the Hermes agent.",
    docs_url=None,
    redoc_url=None,
)

# Order matters: exact Anthropic bridge routes AND the gateway's own health/live
# route are registered BEFORE the catch-all proxy router so they win.
app.include_router(anthropic_router)


@app.api_route("/", methods=["GET", "HEAD"])
async def root():
    return JSONResponse({
        "status": "ok",
        "service": "Hermes Agent Space",
        "endpoints": {
            "anthropic_messages": "/hermes/v1/messages",
            "anthropic_models": "/hermes/v1/models",
            "openai_chat_completions": "/v1/chat/completions",
            "openai_models": "/v1/models",
            "health": "/health",
        },
    })


@app.api_route("/health/live", methods=["GET", "HEAD"])
async def health_live():
    return JSONResponse({"status": "alive"})


app.include_router(hermes_proxy_router)