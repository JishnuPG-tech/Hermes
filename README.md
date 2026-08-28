# Hermes — Autonomous Agent Platform & Custom Claude Client

A complete full-stack autonomous AI platform comprising a custom reverse-engineered Claude Android mobile client and a high-performance multi-model backend gateway.

---

## Repository Structure

```text
├── Frontend/                 # Custom Reverse-Engineered Claude Android APK
│   ├── AndroidManifest.xml   # Patched Android manifest & permissions
│   ├── smali/                # Decompiled & patched Smali bytecode
│   ├── smali_classes2/       # App routing & network redirect patches
│   ├── smali_classes3/       # Telemetry & bridge hooks
│   ├── smali_classes4/       # Artifact viewer engine & Compose UI patches
│   ├── res/ & assets/        # Application resources & configurations
│   ├── CLAUDE.md             # Reverse engineering & build documentation
│   └── fix_manifest.py       # Automated manifest & packaging patchers
│
└── Backend/                  # Unified AI Gateway & Autonomous Agent Server
    ├── gateway/
    │   ├── agent_executor.py   # Multi-turn autonomous tool loop (bash, files, skills)
    │   ├── claude_rest_api.py  # Claude mobile REST protocol & AI title generation
    │   ├── anthropic_bridge.py # Anthropic Messages API proxy with thinking support
    │   ├── background_agent.py # 24/7 persistent background daemon & cron scheduler
    │   ├── telemetry.py        # Live log streaming & APK event ingestion
    │   └── main.py             # FastAPI gateway router orchestration
    ├── ignis/                  # Obsidian documentation & notes server
    ├── Dockerfile              # Production container build
    ├── entrypoint.sh           # Multi-daemon supervisor (Redis, OmniRoute, Ignis, Gateway)
    ├── nginx.conf              # Reverse proxy with WebSocket and SSE optimizations
    └── ARCHITECTURE.md         # Deep technical architecture documentation
```

---

## Key Capabilities

### Frontend (Claude Android Client)
- **Direct Backend Redirection**: Re-routed from Anthropic production endpoints to your custom private gateway.
- **Native Artifact Rendering**: Full interactive rendering of Markdown, HTML/JS web apps, SVGs, and code files.
- **Real-Time Telemetry**: Automatically batches and streams mobile logs and event diagnostics to the live server dashboard.
- **Seamless State Persistence**: Instant message loading upon app reopening without hanging on background banners.

### Backend (Autonomous Gateway)
- **Multi-Turn Tool Execution**: Autonomous execution of shell commands (`bash`), file management (`read_file`, `write_file`, `list_dir`), and 24/7 tasks (`schedule_task`).
- **Dynamic Skills System**: Activates specialized domain personas (`python-pro`, `fastapi-pro`, `docker-expert`, `database-architect`, `security-auditor`, `systematic-debugging`).
- **24/7 Background Agent Jobs**: Persistent cron and daemon jobs stored on disk that run continuously on the server even when the mobile app is closed.
- **AI-Based Title Generation**: Generates clean, concise 3-to-6 word titles for all conversations automatically.
