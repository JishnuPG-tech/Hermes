#!/bin/bash
set -eo pipefail

echo "========================================================"
echo "=== Hermes Agent + Knowledge Space Starting          ==="
echo "========================================================"

# Step 1: Directory Setup on Persistent /data Volume
mkdir -p /data/hermes /data/conversations /data/obsidian/vault /data/backups /data/sessions /tmp/run

export OBSIDIAN_VAULT_DIR="/data/obsidian/vault"
export HERMES_MEMORY_DB="/data/hermes/memory.sqlite"
export PYTHONPATH="/app:${PYTHONPATH}"

# Step 2: Secret & Environment Verification
if [ -z "$UPSTREAM_OMNIROUTE_URL" ]; then
    export UPSTREAM_OMNIROUTE_URL="https://jishnupg-opencode-cli.hf.space/v1"
fi
if [ -z "$UPSTREAM_API_KEY" ]; then
    export UPSTREAM_API_KEY="${API_KEY_SECRET:-Jishnu2005}"
fi
if [ -z "$HERMES_DEFAULT_MODEL" ]; then
    export HERMES_DEFAULT_MODEL="antigravity/gemini-2.5-flash"
fi
if [ -z "$HERMES_VAULT_REPO" ]; then
    export HERMES_VAULT_REPO="Jishnupg/hermes-storage-vault"
fi
if [ -z "$KNOWLEDGE_ENABLED" ]; then
    export KNOWLEDGE_ENABLED="true"
fi
if [ -z "$KNOWLEDGE_DEFAULT_SOURCE" ]; then
    export KNOWLEDGE_DEFAULT_SOURCE="notion"
fi

echo "[BOOT] Upstream LLM Gateway: ${UPSTREAM_OMNIROUTE_URL}"
echo "[BOOT] Default Hermes Model: ${HERMES_DEFAULT_MODEL}"
echo "[BOOT] Primary Knowledge Engine: ${KNOWLEDGE_DEFAULT_SOURCE}"

# Step 3: Zero-Loss Persistence Restore from Cloud Vault
echo "[INIT] Checking Cloud Vault for persistent state restore..."
python3 /app/vault_sync.py restore 2>&1 || echo "[INIT] Vault restore skipped or completed."

# Step 4: Start Redis Server
echo "[INIT] Starting Redis server on port 6379..."
redis-server --daemonize yes --port 6379 --bind 127.0.0.1 || true

# Step 5: Start Persistence Health Doctor Checkpointer
echo "[INIT] Starting Persistence Health Doctor..."
python3 /app/health_doctor.py > /dev/stdout 2>&1 &
DOCTOR_PID=$!

# Step 6: Start Ignis Obsidian Vault Service (:8080)
echo "[INIT] Starting Ignis Obsidian Vault Server on port 8080..."
python3 /app/ignis/server.py > /dev/stdout 2>&1 &
IGNIS_PID=$!

# Step 7: Start Hermes Agent Core (:8642)
echo "[INIT] Starting Hermes Agent Core on port 8642..."
python3 /app/hermes_core/agent.py > /dev/stdout 2>&1 &
HERMES_PID=$!

# Step 8: Start Telegram Bot Handler (Background if token provided)
if [ -n "$TELEGRAM_BOT_TOKEN" ] && [ -f "/app/hermes_core/telegram_bot.py" ]; then
    echo "[INIT] Starting Hermes Telegram Bot listener..."
    python3 /app/hermes_core/telegram_bot.py > /dev/stdout 2>&1 &
    TG_PID=$!
fi

# Step 9: Start FastAPI Gateway (:8000)
echo "[INIT] Starting FastAPI Ingress Gateway on port 8000..."
uvicorn gateway.main:app --host 127.0.0.1 --port 8000 --workers 1 > /dev/stdout 2>&1 &
GATEWAY_PID=$!

# Wait briefly for backends to bind
sleep 3

# Step 10: Start Nginx Edge Ingress (:7860) in Background
echo "[INIT] Starting Nginx Edge Ingress on port 7860..."
/usr/sbin/nginx -c /app/nginx.conf &
NGINX_PID=$!

cleanup() {
    echo "[SHUTDOWN] Trapped termination signal. Executing emergency cloud vault backup..."
    python3 /app/vault_sync.py backup 2>&1 || true
    kill $GATEWAY_PID $HERMES_PID $IGNIS_PID $DOCTOR_PID $NGINX_PID 2>/dev/null || true
    exit 0
}
trap cleanup SIGTERM SIGINT

echo "[BOOT] All Hermes subsystems initialized successfully. Entering Supervisor Watchdog..."

# Step 11: Process Supervisor Watchdog Loop
while true; do
    if ! kill -0 $HERMES_PID 2>/dev/null; then
        echo "[SUPERVISOR] Hermes Agent Core died! Restarting on port 8642..."
        python3 /app/hermes_core/agent.py > /dev/stdout 2>&1 &
        HERMES_PID=$!
    fi

    if ! kill -0 $GATEWAY_PID 2>/dev/null; then
        echo "[SUPERVISOR] FastAPI Gateway died! Restarting on port 8000..."
        uvicorn gateway.main:app --host 127.0.0.1 --port 8000 --workers 1 > /dev/stdout 2>&1 &
        GATEWAY_PID=$!
    fi

    if ! kill -0 $IGNIS_PID 2>/dev/null; then
        echo "[SUPERVISOR] Ignis Obsidian Server died! Restarting on port 8080..."
        python3 /app/ignis/server.py > /dev/stdout 2>&1 &
        IGNIS_PID=$!
    fi

    if ! kill -0 $NGINX_PID 2>/dev/null; then
        echo "[SUPERVISOR] Nginx Ingress died! Restarting on port 7860..."
        /usr/sbin/nginx -c /app/nginx.conf &
        NGINX_PID=$!
    fi

    sleep 10
done
