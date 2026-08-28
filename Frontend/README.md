# Hermes Android Client — Reverse Engineering & Patching Guide

This directory contains the decompiled Smali bytecode, patch tools, injected components, and build specifications for the custom **Claude Android Client** connected directly to the private Hermes Gateway.

---

## 🔍 Architecture & Modifications Overview

```text
               ┌────────────────────────────────────────────────────────┐
               │              Claude Android Client (APK)               │
               └──────────────┬──────────────────────────┬──────────────┘
                              │                          │
              [Network Redirect Interceptor]     [Injected HermesLog]
                              │                          │
                              ▼                          ▼
               ┌──────────────────────────────┐ ┌──────────────────────┐
               │    Hermes Gateway Server     │ │ Real-Time Telemetry  │
               │ (https://...hf.space/api/..) │ │ (/api/telemetry/log) │
               └──────────────────────────────┘ └──────────────────────┘
```

---

## 🛠️ Key Components & Modifications

### 1. Network Endpoint Redirection (`smali/`, `src/NetworkRedirector.java`)
- **Original Behavior**: Out-of-the-box Claude Android client connects to `https://api.claude.ai/api/...` with hardcoded certificate pinning and Cloudflare validation.
- **Reverse-Engineered Patch**:
  - Intercepted string constants and URI builders in `uy4.smali`, `xf0.smali`, `ye0.smali`, and `cu0.smali`.
  - Replaced production Anthropic endpoints with `https://jishnupg-hermes.hf.space` (or local development proxies).
  - Modified `AndroidManifest.xml` with `android:networkSecurityConfig="@xml/network_security_config"` to trust user and cleartext development traffic.

### 2. Native Jetpack Compose Artifact Fix (`patches/n6_artifact_fix.smali`)
- **Original Bug**: Standard Claude Android APK crashes when rendering custom server-generated Markdown, SVG, or HTML artifacts due to null-pointer assertion checks in `smali_classes4/n6.smali`.
- **Patch**: Sanitized incoming message payload chunk strings, bypassed strict schema validation, and added safe null-guards so in-message cards render interactively on Android.

### 3. Real-Time Telemetry & Log Ingestion (`smali/HermesLog.smali`, `src/HermesLog.java`)
- **Injected Feature**: Custom Dalvik class `com.anthropic.hermes.HermesLog` hooked into system event listeners.
- **Functionality**: Catches all mobile crashes, connection retries, and SSE lifecycle events, bundling them into asynchronous JSON payloads dispatched to `/api/telemetry/log` without blocking the UI thread.

### 4. Background Message State Restoration
- Patched message tree deserializers (`dn6.smali`, `gx0.smali`) to immediately resolve `current_leaf_message_uuid` to completed assistant turns, eliminating the perpetual *"Claude is responding in the background"* loading banner upon app reopening.

---

## 📦 Directory Structure

```text
Frontend/
├── AndroidManifest.xml          # Patched Android manifest & security permissions
├── apktool.yml                  # Apktool disassembly & rebuild definitions
├── CLAUDE.md                    # Technical decompilation & reverse-engineering notes
├── patches/
│   └── n6_artifact_fix.smali    # Bytecode fix for native Compose artifact viewer
├── src/com/anthropic/hermes/    # Java reference implementations
│   ├── HermesLog.java           # Async telemetry logger
│   ├── NetworkRedirector.java   # URL rewriter specification
│   └── ArtifactPatch.java       # Artifact schema sanitizer
├── smali/                       # 39 Custom Patched Smali Bytecode Files
│   ├── smali/                   # Core network, logger, and auth classes
│   ├── smali_classes2/          # HTTP pipelines & SSE stream parsers
│   ├── smali_classes3/          # Endpoint dispatchers & background sync service
│   └── smali_classes4/          # Compose UI renderers & artifact previews
└── scripts/
    ├── extract_apk.py           # Automated APK extraction pipeline
    ├── fix_manifest.py          # Manifest & network config patcher
    ├── fix_package.py           # Package namespace patcher
    ├── parse_arsc.py            # Resource table inspector
    └── parse_pools.py           # String pool manipulator
```

---

## 🔨 Step-by-Step Build & Installation

### Prerequisites
- Java Development Kit (JDK 17+)
- `apktool` (v2.9.0+)
- Android SDK Build-Tools (`zipalign`, `apksigner`)

### 1. Build APK from Disassembled Source
```bash
apktool b Frontend -o build/Claude_Hermes_Unsigned.apk --use-aapt2
```

### 2. Align the Built Package
```bash
zipalign -p -f -v 4 build/Claude_Hermes_Unsigned.apk build/Claude_Hermes_Aligned.apk
```

### 3. Sign with Debug / Custom Keystore
```bash
apksigner sign --ks debug.keystore --ks-pass pass:android --ks-key-alias androiddebugkey --out build/Claude_Hermes_Signed.apk build/Claude_Hermes_Aligned.apk
```

### 4. Install on Android Device via ADB
```bash
adb install -r build/Claude_Hermes_Signed.apk
```
