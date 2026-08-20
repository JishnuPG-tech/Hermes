# ==============================================================================
# Hermes Agent — Standalone Hugging Face Space
# ==============================================================================
FROM python:3.11-slim

ENV HOME=/root
ENV HERMES_HOME=/root/.hermes
ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1

# Runtime utilities only — no build toolchain needed
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    sqlite3 \
 && rm -rf /var/lib/apt/lists/*

# aiohttp is required by the Hermes API-server gateway adapter and is NOT
# pulled in by the base hermes-agent package (it ships under messaging extras).
RUN pip3 install --no-cache-dir \
    aiohttp \
    hermes-agent

# Public gateway package (Anthropic Messages bridge + reverse proxy).
COPY gateway /gateway

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV PYTHONPATH=/:/gateway
WORKDIR /

EXPOSE 7860

ENTRYPOINT ["/entrypoint.sh"]