# Claude APK Reverse Engineering Project — Persistent Memory

> **AUTO-LOADED CONTEXT** — Read this file at the START of EVERY session in this workspace.
> This is the ground-truth knowledge base for this project. Never hallucinate — always reference this.

---

## 🎯 Project Goal (Single Sentence)

Patch the official **Claude Android APK** to redirect all API traffic from `api.anthropic.com` to a self-hosted HuggingFace Space, bypass Google Sign-In, and fix all crashes/streaming issues.

---

## 📦 Target APK Identity

| Field | Value |
|-------|-------|
| Package name | `com.anthropic.claude` |
| Version | `1.260721.20` (versionCode: `26072120`) |
| minSdkVersion | **32** (Android 12L) |
| targetSdkVersion | **36** (Android 16) |
| compileSdkVersion | 36 |
| Launcher Activity | `com.anthropic.claude.mainactivity.MainActivity` |
| Application class | `com.anthropic.claude.application.ClaudeApplication` |
| Original APK | `Claude.apk` (34.8 MB unmodified) |

---

## 📁 Directory Map (c:\Users\JISHNU PG\Music\Claude\)

| Path | Purpose |
|------|---------|
| `Claude.apk` | Original unmodified APK (34.8 MB) |
| `Claude_clean.apk` | Cleaned variant, used as apktool source |
| `smali_out/` | **PRIMARY working dir** — apktool d output (smali + res) |
| `smali_nores/` | Alt decompile, has raw `resources.arsc` |
| `jadx_out/` | JADX Java pseudocode (READ-ONLY reference) |
| `hermes_anthropic_bridge.py` | FastAPI bridge: OpenAI → Anthropic SSE translation |
| `Plan.md` | Master 7-phase reverse engineering plan |
| `Hermes_update.md` | Streaming fix decision log (chose Option B — bridge) |
| `flat_list.txt` | Complete APK file inventory |
| `final_apk/` | **Final signed APK** (`Claude_hermes_v1_patched_aligned-aligned-debugSigned.apk`) |
| `compiled_res/`, `linked_res.apk` | Intermediate AAPT2 resource artifacts |
| `smali_out/res/xml/network_security_config.xml` | **PATCHED** — user cert trust enabled |
| `smali_out/AndroidManifest.xml` | Main manifest |

---

## 🆕 New Backend Configuration (Target & Verified)

| Item | Value |
|------|-------|
| Base URL | `https://jishnupg-hermes.hf.space/hermes` |
| Messages Endpoint | `https://jishnupg-hermes.hf.space/hermes/v1/messages` |
| Models Endpoint | `https://jishnupg-hermes.hf.space/hermes/v1/models` |
| Auth Header | `Authorization: Bearer sk-2e556e0437ee2958-7baf2d-b4133935` |
| Auth Scheme | Bearer token on every request |

## ✅ 2026-08-22 Session — Gateway Fixed & Verified LIVE

**HF Spaces (both mount shared bucket `Jishnupg/Opencode-Cli-storage` as `/data`):**
- `Jishnupg/Hermes` → jishnupg-hermes.hf.space — Anthropic bridge gateway (local repo: `hf_hermes_space/`)
- `Jishnupg/Opencode-Cli` → jishnupg-opencode-cli.hf.space — OmniRoute monolith (LLM upstream, local repo: `Opencode-Cli/`)

**Bugs fixed in `hf_hermes_space/gateway/` (commits 2d00157, 75bf9a7, 1c9eaa0):**
1. `NameError: last_err` ASGI crash — `asyncio.CancelledError` (BaseException) bypassed `except Exception`, hit undefined var in `finally`. Now defined up-front + explicit CancelledError handler persists partial reply.
2. SSE keep-alive heartbeats (`: keep-alive` every 7s via producer task + queue) so OkHttp/Android never times out during long agent turns; upstream read timeout 15s→90s.
3. 150s overall deadline across endpoint×model fallback chain (dead upstream errors out in ~2.5min instead of hanging).
4. `openapi_url=None` (kills Duplicate OperationID spam from scanner probes).
5. Proxy hardening: ReadTimeout/RemoteProtocolError→504, PoolTimeout→502, omniroute connect-retry.
6. GET `/hermes/v1/messages` info handler.
7. OmniRoute keep-warm daemon in entrypoint.sh (curl /health every 10min vs 48h idle sleep).

**Root cause of chronic 502 "Service initializing"**: Opencode-Cli monolith (OmniRoute+OpenWebUI+Jellyfin+Redis+TG) thrashed cpu-basic. **Fixed** in Opencode-Cli commit e50bcce: Jellyfin/OpenWebUI/TG-streamer disabled by default (env gates `ENABLE_JELLYFIN=1` etc. to re-enable). OmniRoute now ready in <2min.

**Verified end-to-end (2026-08-22):** POST /hermes/v1/messages → correct Anthropic SSE stream with real LLM reply in 5–9s, 3 consecutive runs.

**Live bucket access (read/write) from local machine:**
```powershell
$hf = "$env:USERPROFILE\.local\bin\hf.exe"   # logged in as Jishnupg
& $hf buckets ls Jishnupg/Opencode-Cli-storage/hermes
& $hf buckets cp hf://buckets/Jishnupg/Opencode-Cli-storage/<path> <local>
```
Key paths: `hermes/config.yaml`, `hermes/.env`, `hermes/state.db`, `cache/gateway.log`, `claude_conversations.json` (APK chat history). NOTE: git clone of the dataset shows ONLY committed files — live container writes live in Xet layer, use `hf buckets` CLI.

**Remaining known noise (cosmetic, not fixed):**
- Agent hallucinates `skill_view`/`skill_manage` tool calls ("Skill 'Hii' not found") — weak 8B model; skills disabled anyway.
- Opencode-Cli /health shows openwebui/jellyfin/tg_stream as "starting" forever (disabled by design).

**Testing tip:** run python test scripts unbuffered (`python -u`) — buffered stdout loses all output when the shell kills a long streaming test.

## ✅ 2026-08-22 Session 2 — Tool-Hallucination Fix (commits 7338b46, a66ff57, bba995b)

**Problem:** APK replies felt broken even when upstream healthy — the 8B model kept calling tools that can't succeed (`skill_view 'Ur name'`, `skill_manage` bad YAML, `memory` malformed args, `execute_code` burning 93s). Each failed call = extra LLM round-trip before any text reached the user.

**Root cause of failed first fix:** `tools.disabled` / `tools.disabled_tools` config keys are NOT in the hermes-agent schema — silently ignored (even original `skill_manage` disable never worked).

**Correct schema** (verified from hermes-agent 0.14.0 source, gateway/run.py:10618):
```yaml
agent:
  disabled_toolsets: [skills, memory, code_execution]
```
Toolset map: `skills`→skill_view/skills_list/skill_manage, `memory`→memory, `code_execution`→execute_code.

**Invalid-tool-call recovery (bridge):** when model still hallucinates a call, agent streams `"Model generated invalid tool call: X"` as whole reply. Bridge now classifies first content piece; if it's that error → swallow turn silently (client sees only keep-alives) → retry once with anti-tool system nudge → friendly notice if retry fails too.

**Verified post-fix (3 runs):** identity 11.6s/7.6s clean, math 4.9–5.9s correct, chitchat 4.6s natural. No error leakage, no tool loops.

**hermes-agent source reference:** wheel extract at `%TEMP%\hermes_pkg\x\` (run_agent.py = conversation loop, registry.py = tools, api_server.py = OpenAI-compat endpoint).

## ✅ 2026-08-22 Session 3 — Model Routing & Direct LLM Path (commits 11f2489, f0d334f)

**Model discovery:** OmniRoute serves 270 models (`GET /v1/models`). Benchmarked TTFT: `nvidia/meta/llama-3.1-8b-instruct` ~2.1s (fastest), `antigravity/gemini-3.5-flash-low` ~2.9s (smartest fast). `groq/llama-3.3-70b` = dead 404 listing; tiny llama-3.2 hangs; 70b slow (~19s).

**Smart routing in bridge** (`resolve_upstream_model(model_name, prompt)`):
- APK picker: haiku/fast→MODEL_FAST, 3-7/thinking/reasoning/opus→MODEL_SMART, coding/sonnet→MODEL_CODE
- Auto by prompt heuristics: code hints→code model, reasoning hints/>400 chars→smart, else fast
- Env overridable: `HERMES_MODEL_FAST/SMART/CODE`

**Agent demoted to fallback:** hermes-agent prepends its own giant agentic system prompt (tools/vision/terminal) that made small models hallucinate ("request a function call", phantom image analysis, /root file writes). stream_upstream now calls OmniRoute direct FIRST (via local /omniroute proxy), agent second as failover. Agent is stateless per-request (session derived from sha256(system+first_user_msg), api_server.py:555) but its prompt pollution is gone entirely.

**Verified post-change:** simple 2.7s clean, code 2.9s real code block, reasoning 4.2s structured, explicit pick 3.7s. Latency halved vs agent path; zero hallucinated artifacts.


---

## 🌐 Network Configuration Found in Smali

| File | Line | Type | Value |
|------|------|------|-------|
| `smali/dl5.smali` | 66 | QUIC hint (cosmetic) | `claude.ai` |
| `smali/dl5.smali` | 74 | QUIC hint (cosmetic) | `www.claude.ai` |
| `smali/dl5.smali` | 80 | QUIC hint (cosmetic) | `api.anthropic.com` |
| `smali/btg.smali` | 47 | Request header | `Anthropic-Version: 2023-06-01` |
| `smali/btg.smali` | 55 | Request header | `Anthropic-Beta: ccr-byoc-2025-07-29` |
| `smali/btg.smali` | 41 | Request header | `X-Organization-Uuid` |
| `smali/btg.smali` | 76 | Request header | `X-Trusted-Device-Token` |
| `smali/k39.smali` | 198 | OkHttp interceptor | `authorization` header handling |
| `smali/k39.smali` | 406 | OkHttp interceptor | `proxy-authorization` header |
| `smali/kr7.smali` | 831 | Config validation | `"ApiKey must be set."` |
| `smali/zhk.smali` | 494 | Auth header | `Authorization` |
| `smali/mx7.smali` | 436 | Firebase auth | `Authorization` (Firebase SDK — NOT Anthropic) |

> **IMPORTANT**: `api.anthropic.com` in `dl5.smali` are QUIC HINTS ONLY — they are `addQuicHint()` calls for HTTP/3 connection pre-warming optimization. They do NOT control where requests are routed. The base URL was patched separately at the HTTP client builder level.

---

## 🔒 Network Security Config (PATCHED)

File: `smali_out/res/xml/network_security_config.xml`

```xml
<network-security-config>
    <base-config cleartextTrafficPermitted="true">
        <trust-anchors>
            <certificates src="system" />
            <certificates src="user" />   <!-- ADDED: enables mitmproxy / user CA certs -->
        </trust-anchors>
    </base-config>
</network-security-config>
```

This enables SSL inspection via mitmproxy (user CA cert must be installed on device).

---

## 🔐 Google Login — DUAL LAYER AUTH (CRITICAL)

The app uses **TWO auth systems simultaneously**:

### Layer 1: Legacy (GMS)
| File | What | Detail |
|------|------|--------|
| `smali/akk.smali:126` | `GoogleSignInAccount.CREATOR` | Parcelable deserializer |
| `smali/akk.smali:132` | `GoogleSignInAccount` check-cast | Type-checks incoming credential |
| `smali/oo6.smali:6156` | `IRestoreCredentialService` | Blockstore credential restore |

### Layer 2: Modern (Credential Manager — `androidx.credentials`)
| File | Controller | Role |
|------|-----------|------|
| `smali_classes2/eq0.smali:555` | `CredentialProviderGetSignInIntentController` | **Primary Google Sign-In intent** |
| `smali_classes2/eq0.smali:576` | `CredentialProviderBeginSignInController` | One Tap sign-in |
| `smali_classes2/eq0.smali:562` | `CredentialProviderGetRestoreCredentialController` | Blockstore restore |
| `smali_classes2/eq0.smali:569` | `CredentialProviderGetDigitalCredentialController` | Digital credentials/passkeys |
| `smali_classes2/ic.smali:1003` | `CredentialProviderGetSignInIntentController` | Sign-in intent dispatch |
| `smali_classes2/ic.smali:1012` | `CredentialProviderCreatePasswordController` | Password creation |
| `smali_classes2/hj5.smali` | `CredentialProviderGetSignInIntentController` | Error callback lambdas |
| `smali_classes2/ij5.smali` | `CredentialProviderGetSignInIntentController` | Success/error callback lambdas |

> **BYPASS STRATEGY**: Do NOT stub individual controllers. Find the **navigation gate** (the `isAuthenticated` boolean in the splash/launch flow) and patch it to always return `true`. This bypasses both layers at once with one smali edit.

---

## 🧩 Tech Stack

| Component | Library |
|-----------|---------|
| HTTP client | **OkHttp3** + **Retrofit2** + **Cronet** (QUIC/HTTP3 via GMS) |
| Serialization | Kotlinx Serialization |
| Image loading | **Coil3** |
| Analytics | **Segment**, **Sentry**, **Datadog** (`DD-API-KEY` in smali) |
| Fraud detection | **SiftScience** |
| UI framework | Kotlin Compose |
| Auth | Legacy GMS Google Sign-In + Modern `androidx.credentials` (Credential Manager) |
| Push | Firebase Installations (`mx7.smali`) — NOT Firebase Auth |
| Networking | Chromium Cronet engine for HTTP/3 QUIC |
| Code highlighting | `highlight.min.js`, `token-highlight.js` (in assets/) |

---

## ⚠️ The Core Protocol Problem (SOLVED)

**Problem**: Claude app sends **Anthropic Messages API** format:
- Endpoint: `POST /messages`  
- Request: `{ "model": ..., "messages": [...], "stream": true }`
- Expected response: Anthropic SSE events: `message_start → content_block_start → content_block_delta × N → content_block_stop → message_delta → message_stop`

**But** the self-hosted backend (`jishnupg-opencode-cli.hf.space`) returned **OpenAI-format** JSON:
- Response: `{ "choices": [{ "message": { "content": "..." } }] }` (no streaming)

**Fix chosen — Option B**: `hermes_anthropic_bridge.py` — a FastAPI bridge deployed on the HF Space that:
1. Receives Anthropic-format POST `/hermes/v1/messages`
2. Translates messages to OpenAI format → calls upstream LLM
3. Translates OpenAI response back to proper Anthropic SSE stream
4. Returns correct `message_start/content_block_delta/message_stop` events

**Why Option B (not re-patching APK)**: No APK rebuild loop, no VerifyError risk, bridge handles both `stream=true` and `stream=false`.

---

## 🏗️ Build Chain (apktool workflow)

```
Claude.apk → apktool d -o smali_out/  ← edit smali here
smali_out/ → apktool b → build_patched.apk
           → zipalign -v 4 → *_aligned.apk
           → apksigner sign --ks debug.keystore → *_aligned-debugSigned.apk
```

**Build iterations** (in order):
1. `Claude_aligned.apk` (early test)
2. `Claude_clean.apk` + `Claude_hermes_fixed.apk`
3. `Claude_hermes_v1_fixed2.apk`
4. `Claude_hermes_v1_uatest.apk` (User-Agent test)
5. `Claude_hermes_v1_patched.apk` → **FINAL** (in `final_apk/`)

**Size note**: APK inflated from 34.8 MB → 39.7 MB (+14%) — normal apktool rebuild behavior.

---

## 🔑 Key Smali Files (Quick Reference)

| File | What It Does |
|------|-------------|
| `smali/btg.smali` | OkHttp interceptor — adds all Anthropic request headers |
| `smali/dl5.smali` | Cronet engine builder — QUIC hints (cosmetic, not routing) |
| `smali/kr7.smali` | API client config builder — validates ApiKey |
| `smali/k39.smali` | OkHttp — `authorization` / `proxy-authorization` header handling |
| `smali/akk.smali` | Google Sign-In legacy — `GoogleSignInAccount` Parcelable |
| `smali_classes2/eq0.smali` | Credential Manager dispatcher — all modern auth controllers |
| `smali_classes2/ic.smali` | Credential Manager — sign-in intent + password controller |
| `smali/BellConfig.smali` | Bell/voice config data class (PTT, server interrupt, auto-send) |
| `smali/oo6.smali` | Large class — includes `IRestoreCredentialService` |
| `smali/mx7.smali` | Firebase Installations SDK |
| `smali/zhk.smali` | Another auth/authorization header interceptor |

---

## ✅ / ⚠️ Project Status

### Completed
- [x] APK fully unpacked (smali_out + jadx_out)
- [x] Network security config patched (user cert trust)
- [x] Backend URL redirected to HF Space
- [x] Bearer token auth injected
- [x] APK rebuilt, zipaligned, debug-signed (multiple iterations)
- [x] Protocol mismatch discovered and diagnosed
- [x] `hermes_anthropic_bridge.py` written (full Anthropic SSE translation)
- [x] All auth surfaces mapped (dual-layer: legacy GMS + Credential Manager)

### Open / TODO
- [ ] **Deploy `hermes_anthropic_bridge.py` to HF Space**
  - Set `UPSTREAM_URL` = your HF Space's actual LLM endpoint
  - Set `UPSTREAM_KEY` = your upstream API key
  - Route `POST /hermes/v1/messages` through the bridge
- [ ] **Find and patch the navigation auth gate** (the `isAuthenticated` boolean guard in splash/nav graph smali — NOT in individual controller files)
- [ ] **Phase 7 verification** (raw evidence required):
  - `adb uninstall com.anthropic.claude`
  - `adb install final_apk/Claude_hermes_v1_patched_aligned-aligned-debugSigned.apk`
  - Install mitmproxy CA cert on device (user cert trust already enabled in NSC)
  - Confirm requests hit `jishnupg-opencode-cli.hf.space` (NOT `api.anthropic.com`)
  - Confirm `Authorization: Bearer sk-2e556e0437ee2958-7baf2d-b4133935` header present
  - Capture raw SSE stream — verify `message_start/delta/stop` events

---

## ⚡ Useful Commands

```powershell
# Install final APK
adb uninstall com.anthropic.claude
adb install "c:\Users\JISHNU PG\Music\Claude\Claude_hermes_v1_patched_final_aligned_signed.apk"

# Logcat — crashes and Anthropic traffic
adb logcat | Select-String "FATAL|E AndroidRuntime|jishnupg|anthropic|hermes"

# Search smali for a string
Get-ChildItem -Recurse -Path "c:\Users\JISHNU PG\Music\Claude\smali_out" -Filter "*.smali" | Select-String -Pattern "YOUR_PATTERN" | Select-Object -First 30

# Rebuild APK
apktool b "c:\Users\JISHNU PG\Music\Claude\smali_out" -o patched.apk
zipalign -v 4 patched.apk patched-aligned.apk
apksigner sign --ks debug.keystore patched-aligned.apk
apksigner verify --verbose patched-aligned.apk
```

---

## 🏛️ Architecture

```
Claude Android App (com.anthropic.claude)
    │
    - `GET /api/bootstrap/{org_id}/app_start`: AppStartResponse for growthbook, model config, user access.
    - `GET /api/account`: Verified account profile.
    - `GET /api/organizations`: Org listing with Pro capabilities.
    - `GET /api/organizations/{org_id}/chat_conversations`: History list.
    - `GET /api/organizations/{org_id}/chat_conversations/{chat_id}`: Conversation details.
    - `POST /api/organizations/{org_id}/chat_conversations/{chat_id}/completion`: StreamEvent SSE streaming.
    - `POST /api/organizations/{org_id}/chat_conversations/{chat_id}/completion2`: StreamEvent SSE streaming.
    - `POST /api/organizations/{org_id}/chat_conversations/{chat_id}/title`: Title generator.
    - `POST /api/organizations/{org_id}/chat_conversations/{chat_id}/stop_response`: Stop generation.
    - `POST /hermes/v1/messages`: Anthropic Messages API SSE streaming.
    │ Authorization: Bearer sk-2e556e0437ee2958-7baf2d-b4133935
    ▼
HF Space FastAPI  (jishnupg-opencode-cli.hf.space)
    hermes_anthropic_bridge.py
    │
    │ POST /v1/chat/completions  [OpenAI format]
    ▼
Upstream LLM (OpenAI-compatible)
    │
    │ OpenAI JSON response
    ▼
hermes_anthropic_bridge.py  [translates → Anthropic SSE]
    │
    │ SSE: message_start → content_block_delta × N → message_stop
    ▼
Claude App renders streaming response ✓
```

---

*Last updated: 2026-08-21 by Antigravity AI — complete project analysis*
