#!/bin/bash
set -e

mkdir -p /projects/default \
         /data/share/opencode \
         /data/config/opencode \
         /data/cache/opencode \
         /data/state/opencode \
         /data/logs

# Run HF Dataset restore & sync daemon if HF_TOKEN is provided
if [ -n "$HF_TOKEN" ]; then
    echo "[SYNC] Restoring workspace from HF Dataset..."
    python3 /sync_engine.py restore || true
    python3 /sync_engine.py watch &
fi

echo "[OPENCODE] Launching official OpenCode Serve on port ${PORT:-10000}..."
exec opencode serve --port "${PORT:-10000}" --hostname 0.0.0.0
