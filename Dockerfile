FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and nginx
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    python3 \
    git \
    nginx \
    && rm -rf /var/lib/apt/lists/* \
    && chmod -R 777 /var/log/nginx /var/lib/nginx /run

# Install sing-box
RUN set -eu \
    && arch="$(dpkg --print-architecture)" \
    && case "$arch" in \
        amd64|x86_64) SINGBOX_URL="https://github.com/SagerNet/sing-box/releases/download/v1.13.14/sing-box-1.13.14-linux-amd64.tar.gz" ;; \
        arm64|aarch64) SINGBOX_URL="https://github.com/SagerNet/sing-box/releases/download/v1.13.14/sing-box-1.13.14-linux-arm64.tar.gz" ;; \
        *) echo "Unsupported architecture" >&2; exit 1 ;; \
       esac \
     && curl -fsSL "$SINGBOX_URL" -o /tmp/singbox.tar.gz \
     && tar -xzf /tmp/singbox.tar.gz -C /tmp \
     && mv /tmp/sing-box-1.13.14-linux-*/sing-box /usr/local/bin/sing-box \
     && chmod +x /usr/local/bin/sing-box \
     && rm -rf /tmp/singbox* /tmp/sing-box*

WORKDIR /app
COPY app.py dashboard.html users.json settings.json nginx.conf ./

# Copy nginx config to system location
RUN cp nginx.conf /etc/nginx/nginx.conf

ENV PYTHONUNBUFFERED=1

EXPOSE 7860

CMD ["sh", "-c", "nginx && python3 app.py"]
