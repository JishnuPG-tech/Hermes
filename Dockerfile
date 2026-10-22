FROM node:24-bookworm-slim AS web-build

WORKDIR /web

RUN corepack enable && corepack prepare pnpm@10.26.1 --activate

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml tsconfig.base.json tsconfig.json ./
COPY official/web/package.json official/web/package.json
COPY official/apps/shared/package.json official/apps/shared/package.json

RUN pnpm install --frozen-lockfile

COPY official official

RUN pnpm --filter web run build

FROM node:24-bookworm-slim AS opendots-build

WORKDIR /opendots

COPY opendots/package*.json ./
RUN npm ci

COPY opendots/ ./
RUN npm run build

FROM python:3.11-slim-bookworm

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
ENV HERMES_SERVER_WORKDIR=/app
ENV HERMES_MAX_TOOL_ROUNDS=45

WORKDIR /app

# Install system dependencies & GitHub CLI (gh)
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    redis-server \
    sqlite3 \
    git \
    curl \
    ca-certificates \
    procps \
    ffmpeg \
    chromium \
    && mkdir -p -m 755 /etc/apt/keyrings \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update && apt-get install -y --no-install-recommends gh \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 24 runtime from node base image
COPY --from=node:24-bookworm-slim /usr/local/bin /usr/local/bin
COPY --from=node:24-bookworm-slim /usr/local/lib/node_modules /usr/local/lib/node_modules

# Install Python requirements
RUN pip install --no-cache-dir \
    fastapi \
    "uvicorn[standard]" \
    httpx \
    aiohttp \
    requests \
    beautifulsoup4 \
    pydantic \
    python-multipart \
    pyjwt \
    cryptography \
    edge-tts \
    moviepy

# Copy application files
COPY artifacts /app/artifacts
COPY gateway /app/gateway
COPY Backend/gateway/__init__.py /app/Backend/gateway/__init__.py
COPY Backend/gateway/anthropic_bridge.py /app/Backend/gateway/anthropic_bridge.py
COPY Backend/gateway/claude_rest_api.py /app/Backend/gateway/claude_rest_api.py
COPY Backend /app/Backend
COPY harness /app/harness
COPY skills /app/skills
COPY hermes_core /app/hermes_core
COPY ignis /app/ignis
COPY --from=web-build /web/build/hermes-dashboard /app/web
COPY --from=opendots-build /opendots/dist /app/opendots/dist
COPY --from=opendots-build /opendots/node_modules /app/opendots/node_modules
COPY --from=opendots-build /opendots/package.json /app/opendots/package.json
COPY health_doctor.py /app/health_doctor.py
COPY nginx.conf /app/nginx.conf
COPY entrypoint.sh /app/entrypoint.sh
COPY README.md /app/README.md

RUN chmod +x /app/entrypoint.sh

EXPOSE 7860 4096

ENTRYPOINT ["/app/entrypoint.sh"]
