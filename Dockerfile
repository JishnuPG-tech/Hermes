# Official OpenCode-Serve for Render 512MB RAM Architecture
FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=10000

ENV XDG_DATA_HOME=/data/share
ENV XDG_CONFIG_HOME=/data/config
ENV XDG_CACHE_HOME=/data/cache
ENV XDG_STATE_HOME=/data/state

ARG OPENCODE_VERSION=1.18.3

# Install minimal dependencies & official OpenCode binary
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates curl git python3 python3-pip \
 && curl -fsSL "https://github.com/anomalyco/opencode/releases/download/v${OPENCODE_VERSION}/opencode-linux-x64.tar.gz" \
      | tar -xz -C /usr/local/bin opencode \
 && chmod +x /usr/local/bin/opencode \
 && rm -rf /var/lib/apt/lists/*

# Install huggingface_hub for background workspace sync
RUN pip3 install --quiet --no-cache-dir --break-system-packages "huggingface_hub>=0.23"

COPY sync_engine.py      /sync_engine.py
COPY entrypoint_lite.sh /entrypoint_lite.sh
RUN chmod +x /entrypoint_lite.sh /sync_engine.py

WORKDIR /projects/default

EXPOSE 10000

ENTRYPOINT ["/entrypoint_lite.sh"]
