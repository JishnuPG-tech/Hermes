#!/bin/sh
set -e

log_info() { echo "$(date -u '+%Y-%m-%d %H:%M:%S') [INFO] [HERMES] $1"; }
log_error() { echo "$(date -u '+%Y-%m-%d %H:%M:%S') [ERROR] [HERMES] $1"; }

# 1. Resolve configuration (env-var overridable via HF Space secrets)
OMNIROUTE_BASE_URL="${OMNIROUTE_BASE_URL:-https://jishnupg-opencode-cli.hf.space/v1}"
OMNIROUTE_API_KEY="${OMNIROUTE_API_KEY:-sk-2e556e0437ee2958-7baf2d-b4133935}"
HERMES_MODEL="${HERMES_MODEL:-auto/best-coding}"
# Hermes agent API server binds only to localhost inside the container.
HERMES_INTERNAL_PORT="${HERMES_INTERNAL_PORT:-8642}"
# Public gateway (the HF Space app_port).
PUBLIC_PORT="${PUBLIC_PORT:-7860}"
API_SERVER_KEY="${API_SERVER_KEY:-${OMNIROUTE_API_KEY}}"
HERMES_HOME="${HERMES_HOME:-/root/.hermes}"

# Anthropic bridge upstream = the Hermes agent (which itself calls OmniRoute).
# This gives the Claude app the full agent: persona, memory, skills, tools, loop.
ANTHROPIC_BRIDGE_UPSTREAM_URL="${ANTHROPIC_BRIDGE_UPSTREAM_URL:-http://127.0.0.1:${HERMES_INTERNAL_PORT}/v1/chat/completions}"
ANTHROPIC_BRIDGE_UPSTREAM_KEY="${ANTHROPIC_BRIDGE_UPSTREAM_KEY:-${API_SERVER_KEY:-${OMNIROUTE_API_KEY}}}"
ANTHROPIC_BRIDGE_UPSTREAM_MODEL="${ANTHROPIC_BRIDGE_UPSTREAM_MODEL:-auto/best-coding}"

# Export so the public gateway (uvicorn process) picks them up from os.environ.
export OMNIROUTE_BASE_URL OMNIROUTE_API_KEY API_SERVER_KEY HERMES_INTERNAL_PORT
export HERMES_MODEL ANTHROPIC_BRIDGE_UPSTREAM_URL ANTHROPIC_BRIDGE_UPSTREAM_KEY ANTHROPIC_BRIDGE_UPSTREAM_MODEL

log_info "OmniRoute backend      : ${OMNIROUTE_BASE_URL}"
log_info "Hermes model           : ${HERMES_MODEL}"
log_info "Hermes internal port   : ${HERMES_INTERNAL_PORT} (localhost only)"
log_info "Public gateway port    : ${PUBLIC_PORT}"
log_info "Bridge upstream        : ${ANTHROPIC_BRIDGE_UPSTREAM_URL}"
log_info "Hermes home            : ${HERMES_HOME}"

mkdir -p "${HERMES_HOME}" /data/hermes /data/cache

# 2. Restore persistent Hermes state from the Space /data volume
if [ -d /data/hermes ] && [ "$(ls -A /data/hermes 2>/dev/null)" ]; then
    cp -af /data/hermes/. "${HERMES_HOME}/" 2>/dev/null || true
    log_info "Restored persistent state from /data/hermes"
fi

# 3. Bootstrap zero-touch Hermes config (config.yaml is authoritative)
cat > "${HERMES_HOME}/config.yaml" <<EOF
model:
  provider: omniroute
  default: ${HERMES_MODEL}

providers:
  omniroute:
    base_url: ${OMNIROUTE_BASE_URL}
    api_key: ${OMNIROUTE_API_KEY}

memory:
  enabled: true
  sqlite_fts5: true

gateway:
  platforms:
    api_server:
      enabled: true
      host: 127.0.0.1
      port: ${HERMES_INTERNAL_PORT}
      key: ${API_SERVER_KEY}
      cors_origins: "*"
EOF

# 4. Mirror the same settings into .env (env vars take precedence)
cat > "${HERMES_HOME}/.env" <<EOF
API_SERVER_ENABLED=true
API_SERVER_HOST=127.0.0.1
API_SERVER_PORT=${HERMES_INTERNAL_PORT}
API_SERVER_KEY=${API_SERVER_KEY}
API_SERVER_CORS_ORIGINS=*
API_SERVER_MODEL_NAME=${HERMES_MODEL}
HERMES_MODEL=${HERMES_MODEL}
DEFAULT_MODEL=${HERMES_MODEL}
HERMES_API_BASE_URL=${OMNIROUTE_BASE_URL}
HERMES_API_KEY=${OMNIROUTE_API_KEY}
OMNIROUTE_API_KEY=${OMNIROUTE_API_KEY}
ANTHROPIC_BRIDGE_UPSTREAM_URL=${ANTHROPIC_BRIDGE_UPSTREAM_URL}
ANTHROPIC_BRIDGE_UPSTREAM_KEY=${ANTHROPIC_BRIDGE_UPSTREAM_KEY}
ANTHROPIC_BRIDGE_UPSTREAM_MODEL=${ANTHROPIC_BRIDGE_UPSTREAM_MODEL}
EOF

chmod -R 777 "${HERMES_HOME}" /data/hermes 2>/dev/null || true

# 5. Background 15s persistence sync daemon
(
    while true; do
        sleep 15
        mkdir -p /data/hermes 2>/dev/null || true
        rsync -a --update "${HERMES_HOME}/." /data/hermes/ 2>/dev/null \
            || cp -rf "${HERMES_HOME}/." /data/hermes/ 2>/dev/null \
            || true
    done
) &
log_info "Persistence sync daemon started (every 15s -> /data/hermes)"

if ! command -v hermes >/dev/null 2>&1; then
    log_error "hermes CLI not found on PATH"
    exit 1
fi

# 6. Start the Hermes agent API server (OpenAI-compatible) on the internal port.
log_info "Starting Hermes agent API server on 127.0.0.1:${HERMES_INTERNAL_PORT}"
hermes gateway run 2>&1 | tee /data/cache/hermes.log &
HERMES_PID=$!

# Wait for the Hermes agent to accept connections (up to 90s).
HERMES_READY=0
i=0
while [ $i -lt 90 ]; do
    if curl -fsS "http://127.0.0.1:${HERMES_INTERNAL_PORT}/health" >/dev/null 2>&1; then
        HERMES_READY=1
        break
    fi
    i=$((i + 1))
    sleep 1
done
if [ "$HERMES_READY" -eq 0 ]; then
    log_error "Hermes agent did not become healthy on 127.0.0.1:${HERMES_INTERNAL_PORT}"
    exit 1
fi
log_info "Hermes agent is healthy on 127.0.0.1:${HERMES_INTERNAL_PORT}"

# 7. Start the public gateway (Anthropic bridge + reverse proxy) on the
#    HF Space app_port in the foreground with a crash-restart supervisor.
log_info "Starting public gateway on 0.0.0.0:${PUBLIC_PORT}"
while true; do
    python3 -m uvicorn gateway.main:app \
        --host 0.0.0.0 \
        --port "${PUBLIC_PORT}" \
        --workers 1 2>&1 | tee /data/cache/gateway.log
    log_error "Public gateway exited (code ${PIPESTATUS:-?}); restarting in 5s..."
    sleep 5
done