---
title: Hermes Agent
emoji: 🤖
colorFrom: purple
colorTo: indigo
sdk: docker
app_port: 7860
pinned: false
---

# 🤖 Hermes Agent (Standalone)

A standalone deployment of the **Hermes Agent** — the self-improving, tool-calling AI agent from [Nous Research](https://hermes-agent.nousresearch.com) — running on a Hugging Face Space.

Hermes is wired to the **OmniRoute AI Gateway** (`https://jishnupg-opencode-cli.hf.space/v1`) as its LLM brain, using the `auto/best-coding` routing model.

A public FastAPI gateway fronts the Space: it exposes the **Anthropic Messages API** (for the patched Claude Android app) and reverse-proxies the **OpenAI-compatible** API to the Hermes agent. The Anthropic bridge forwards to the Hermes agent (not raw OmniRoute), so the app gets the **full agent**: Hermes persona, persistent memory, skills, tools, and the agentic loop.

---

## 🔌 Exposed API

The Space exposes a public gateway on `https://jishnupg-hermes.hf.space` (`app_port` 7860):

| Endpoint | Path |
|---|---|
| Anthropic Messages API | `POST /hermes/v1/messages` |
| Anthropic Model List | `GET /hermes/v1/models` |
| OpenAI Base URL | `https://jishnupg-hermes.hf.space/v1` |
| OpenAI Models | `GET /v1/models` |
| Chat Completions | `POST /v1/chat/completions` (SSE streaming supported) |
| Responses API | `POST /v1/responses` |
| Health | `GET /health`, `GET /health/detailed` |

**Auth:** Bearer token — use the `API_SERVER_KEY` Space secret (or the configured OmniRoute API key if unset). `/hermes/v1/*` Anthropic endpoints pass through the same bearer key.

### Patched Claude Android app

Point the app's API base URL at:

```
https://jishnupg-hermes.hf.space/hermes
```

with the `API_SERVER_KEY` as the API key. The bridge accepts Anthropic `POST /v1/messages` requests, translates them to the upstream's OpenAI format, forwards them to the Hermes agent (persona + memory + tools + OmniRoute brain), and translates the response back (proper JSON for `stream:false`, proper `message_start` / `content_block_delta` / `message_stop` SSE for `stream:true`).

### Python OpenAI SDK
```python
from openai import OpenAI

client = OpenAI(
    base_url="https://jishnupg-hermes.hf.space/v1",
    api_key="<your API_SERVER_KEY>",
)

response = client.chat.completions.create(
    model="auto/best-coding",   # routed through OmniRoute
    messages=[{"role": "user", "content": "Search the web for the latest AI news"}],
)
print(response.choices[0].message.content)
```

---

## 🔐 Environment Variables (Space Secrets)

| Variable | Description | Default |
|---|---|---|
| `OMNIROUTE_BASE_URL` | OmniRoute OpenAI-compatible base URL | `https://jishnupg-opencode-cli.hf.space/v1` |
| `OMNIROUTE_API_KEY` | OmniRoute API key used by Hermes as its LLM brain | `sk-2e556e0437ee2958-7baf2d-b4133935` |
| `HERMES_MODEL` | Default model routed through OmniRoute | `auto/best-coding` |
| `API_SERVER_KEY` | Bearer key clients use to call the Hermes API server | falls back to `OMNIROUTE_API_KEY` |
| `HERMES_INTERNAL_PORT` | Hermes agent API server port (localhost only) | `8642` |
| `PUBLIC_PORT` | Public gateway port (HF `app_port`) | `7860` |
| `ANTHROPIC_BRIDGE_UPSTREAM_URL` | Bridge upstream OpenAI endpoint (Hermes agent) | `http://127.0.0.1:8642/v1/chat/completions` |
| `ANTHROPIC_BRIDGE_UPSTREAM_KEY` | Bridge upstream API key | falls back to `OMNIROUTE_API_KEY` |
| `ANTHROPIC_BRIDGE_UPSTREAM_MODEL` | Model the bridge sends upstream | `auto/best-coding` |

---

## 📁 Persistence

Hermes memory (`MEMORY.md`, `USER.md`), generated skills (`skills/`), and session history (`sessions/`) live in `~/.hermes` inside the container. Every 15 seconds they are synced to the Space's persistent `/data/hermes` volume and restored on boot.

---

## 🏗️ Architecture

```
Claude Android app (patched)          OpenAI SDK / other clients
        │  Anthropic Messages                │  OpenAI API
        ▼                                    ▼
        └────────────► Public Gateway  https://jishnupg-hermes.hf.space:7860
                              │
              ┌───────────────┴────────────────┐
              ▼ (Anthropic bridge, in-process) ▼ (reverse proxy)
        /hermes/v1/messages              /v1/* , /health
              │                                   │
              └────────┐                          │
                       ▼                          ▼
                Hermes Agent API Server  (127.0.0.1:8642, localhost)
                       │  persona + memory + skills + tools + agent loop
                       ▼
                OmniRoute AI Gateway (LLM brain, auto/best-coding)
                       │
                       ▼
                Cloud LLM Providers
```

`config.yaml` (bootstrap):

```yaml
model:
  provider: omniroute
  default: auto/best-coding

providers:
  omniroute:
    base_url: https://jishnupg-opencode-cli.hf.space/v1
    api_key: <secret>

memory:
  enabled: true
  sqlite_fts5: true

gateway:
  platforms:
    api_server:
      enabled: true
      host: 127.0.0.1
      port: 8642
      key: <API_SERVER_KEY>
      cors_origins: "*"
```

To override the backend at deploy time, set the `OMNIROUTE_BASE_URL` / `OMNIROUTE_API_KEY` / `HERMES_MODEL` / `API_SERVER_KEY` Space secrets.# Force wake 08/25/2026 17:23:54
