# Hermes WebUI upstream snapshot

This directory contains the unmodified static runtime from
[`nesquena/hermes-webui`](https://github.com/nesquena/hermes-webui). The full
upstream checkout was audited outside the production tree; only the files
needed to serve its browser client are vendored here.

- Commit: `e168b67e4278df618d1cab61fdb3a8dc55b29a81`
- Date: 2026-08-25
- License: MIT (`LICENSE`)
- Runtime: Python server with vanilla JavaScript and no frontend build step
- Compatibility route: `/hermes-webui/`
- Feature flag: `HERMEX_ENABLE_HERMES_WEBUI=true`

The UI uses the existing Hermex `/api/*` adapter. It is intentionally mounted
as a migration route while `/dashboard/` remains the production default.
Unsupported upstream capabilities must stay explicit; do not add placeholder
responses just to make a panel appear functional.