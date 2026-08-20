import os

import httpx
from fastapi import Request, Response
from fastapi.responses import StreamingResponse

PUBLIC_HOST = os.getenv("PUBLIC_HOST", "jishnupg-hermes.hf.space")

_http_client = None


def get_http_client() -> httpx.AsyncClient:
    global _http_client
    if _http_client is None or _http_client.is_closed:
        _http_client = httpx.AsyncClient(
            timeout=httpx.Timeout(connect=10.0, read=300.0, write=300.0, pool=30.0),
            follow_redirects=False,
            limits=httpx.Limits(max_connections=500, max_keepalive_connections=100, keepalive_expiry=30.0),
        )
    return _http_client


_HOP_BY_HOP = {
    "connection", "keep-alive", "proxy-authenticate", "proxy-authorization",
    "te", "trailers", "transfer-encoding", "upgrade",
    "content-length", "content-encoding",
}


def build_upstream_headers(request: Request, extra_headers=None) -> dict:
    headers = {
        k: v for k, v in request.headers.items()
        if k.lower() not in _HOP_BY_HOP and k.lower() not in ("host", "user-agent")
    }
    headers["Host"] = PUBLIC_HOST
    headers["X-Forwarded-Host"] = PUBLIC_HOST
    headers["X-Forwarded-Proto"] = "https"
    headers["X-Forwarded-Port"] = "443"
    headers["User-Agent"] = request.headers.get("user-agent") or "HermesSpace-Gateway/1.0"
    if extra_headers:
        for ek, ev in extra_headers.items():
            for existing in list(headers.keys()):
                if existing.lower() == ek.lower():
                    del headers[existing]
            headers[ek] = ev
    return headers


async def proxy_http_request(target_url: str, request: Request, extra_headers=None) -> Response:
    client = get_http_client()
    headers = build_upstream_headers(request, extra_headers)
    body = await request.body()
    req = client.build_request(
        method=request.method,
        url=target_url,
        headers=headers,
        params=dict(request.query_params),
        content=body,
    )
    resp = await client.send(req, stream=True)

    is_stream = (
        "text/event-stream" in resp.headers.get("content-type", "")
        or "video/" in resp.headers.get("content-type", "")
        or "audio/" in resp.headers.get("content-type", "")
        or resp.headers.get("transfer-encoding") == "chunked"
    )

    raw_headers = [
        (k.encode("latin-1"), v.encode("latin-1"))
        for k, v in resp.headers.items()
        if k.lower() not in _HOP_BY_HOP
    ]

    if is_stream:
        async def stream_generator():
            try:
                async for chunk in resp.aiter_bytes():
                    yield chunk
            finally:
                await resp.aclose()

        streaming = StreamingResponse(
            stream_generator(),
            status_code=resp.status_code,
            media_type=resp.headers.get("content-type") or None,
        )
        streaming.raw_headers = raw_headers
        return streaming

    content = await resp.aread()
    await resp.aclose()
    normal = Response(
        content=content,
        status_code=resp.status_code,
        media_type=resp.headers.get("content-type") or None,
    )
    normal.raw_headers = raw_headers
    return normal