---
title: TorProxy
emoji: 🛡️
colorFrom: red
colorTo: red
sdk: docker
app_port: 7860
pinned: false
---

# TorProxy VLESS VPN

A premium, high-speed, and secure VLESS-over-WebSocket VPN service hosted 24/7 on Hugging Face Spaces. 

## Features
- **100% Secure & Encrypted:** Utilizes TLS 1.3 to protect all internet traffic.
- **Zero Apps / Zero Configuration (on server):** Directly hooks up to standard HTTPS WebSockets (port 443).
- **Glassmorphic Console:** Modern web interface to copy connection profile, view QR Code, and check live system health and logs.
- **Persistent:** Fully compatible with UptimeRobot to maintain 24/7 uptime.

## Setup
1. Deploy to your Hugging Face Space.
2. Visit the Space URL (e.g. `https://your-space.hf.space`).
3. Log in with your administration password (default: `admin` or custom set via `ADMIN_PASSWORD` secret).
4. Copy the VLESS configuration link or scan the QR Code in your preferred client (Hiddify, v2rayNG, Shadowrocket).
