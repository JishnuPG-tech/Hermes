import os
import sys
import time
import json
import socket
import select
import uuid
import threading
import subprocess
from http.server import BaseHTTPRequestHandler, HTTPServer
from socketserver import ThreadingMixIn
import urllib.parse
import secrets

class ThreadingHTTPServer(ThreadingMixIn, HTTPServer):
    daemon_threads = True

# Global variables
singbox_proc = None
singbox_logs = []
logs_lock = threading.Lock()
active_sessions = {}
session_lock = threading.Lock()

# Load settings or initialize default settings
settings_file = "settings.json"
def load_settings():
    if os.path.exists(settings_file):
        try:
            with open(settings_file, "r") as f:
                return json.load(f)
        except:
            pass
    return {"vless_uuid": str(uuid.uuid4()), "custom_sni": ""}

def save_settings(s):
    try:
        with open(settings_file, "w") as f:
            json.dump(s, f, indent=2)
    except Exception as e:
        print(f"[ERROR] Failed to save settings: {e}", flush=True)

settings = load_settings()

def get_vless_uuid():
    env_uuid = os.getenv("VLESS_UUID", "").strip(" '\"")
    if env_uuid:
        return env_uuid
    return settings.get("vless_uuid")

def build_singbox_config(uuid_val):
    config = {
        "inbounds": [
            {
                "type": "vless",
                "listen": "127.0.0.1",
                "listen_port": 10086,
                "users": [
                    {
                        "name": "default",
                        "uuid": uuid_val
                    }
                ],
                "transport": {
                    "type": "ws",
                    "path": "/vless"
                }
            }
        ],
        "outbounds": [
            {
                "type": "direct",
                "tag": "direct"
            }
        ]
    }
    config_file = "/tmp/singbox_config.json"
    with open(config_file, "w", encoding="utf-8") as f:
        json.dump(config, f, indent=2)
    return config_file

def append_log(line):
    with logs_lock:
        singbox_logs.append(line)
        if len(singbox_logs) > 100:
            singbox_logs.pop(0)

def start_singbox():
    global singbox_proc
    # Terminate existing sing-box process if any
    if singbox_proc:
        try:
            singbox_proc.terminate()
            singbox_proc.wait(timeout=2)
        except:
            pass
            
    uuid_val = get_vless_uuid()
    config_file = build_singbox_config(uuid_val)
    print(f"[VLESS] Starting sing-box (UUID: {uuid_val})...", flush=True)
    append_log(f"Starting sing-box with UUID: {uuid_val}")
    
    cmd = ["/usr/local/bin/sing-box", "run", "-c", config_file]
    try:
        singbox_proc = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            bufsize=1
        )
        
        def read_logs():
            try:
                for line in singbox_proc.stdout:
                    stripped = line.strip()
                    if stripped:
                        print(f"[VLESS] {stripped}", flush=True)
                        append_log(stripped)
            except Exception as e:
                append_log(f"Error reading logs: {e}")
                
        threading.Thread(target=read_logs, daemon=True).start()
    except Exception as e:
        print(f"[ERROR] Failed to start sing-box: {e}", flush=True)
        append_log(f"Failed to start sing-box: {e}")

# Keep-alive thread to make sure sing-box is running
def singbox_watchdog():
    while True:
        time.sleep(10)
        global singbox_proc
        if singbox_proc is None or singbox_proc.poll() is not None:
            print("[WATCHDOG] sing-box exited! Restarting...", flush=True)
            start_singbox()

def get_system_stats():
    # RAM
    ram_percent = 0.0
    try:
        with open("/proc/meminfo", "r") as f:
            lines = f.readlines()
        mem_total = 0
        mem_free = 0
        mem_buffers = 0
        mem_cached = 0
        for line in lines:
            if "MemTotal" in line:
                mem_total = int(line.split()[1])
            elif "MemFree" in line:
                mem_free = int(line.split()[1])
            elif "Buffers" in line:
                mem_buffers = int(line.split()[1])
            elif "Cached" in line:
                mem_cached = int(line.split()[1])
        used = mem_total - mem_free - mem_buffers - mem_cached
        if mem_total > 0:
            ram_percent = round((used / mem_total) * 100, 1)
    except:
        pass

    # CPU
    cpu_percent = 0.0
    try:
        with open("/proc/stat", "r") as f:
            line = f.readline()
        parts = list(map(int, line.split()[1:5]))
        idle = parts[3]
        total = sum(parts)
        time.sleep(0.1)
        with open("/proc/stat", "r") as f:
            line = f.readline()
        parts2 = list(map(int, line.split()[1:5]))
        idle2 = parts2[3]
        total2 = sum(parts2)
        diff_idle = idle2 - idle
        diff_total = total2 - total
        if diff_total > 0:
            cpu_percent = round((1.0 - (diff_idle / diff_total)) * 100, 1)
    except:
        try:
            cpu_percent = round(os.getloadavg()[0] * 10, 1)
        except:
            pass
            
    return cpu_percent, ram_percent

# WebSocket relay removed - Nginx now handles /vless proxies natively on port 7860

class VlessDashboardHandler(BaseHTTPRequestHandler):
    def log_message(self, format, *args):
        pass

    def get_token_from_url(self):
        parsed = urllib.parse.urlparse(self.path)
        params = urllib.parse.parse_qs(parsed.query)
        return params.get("token", [""])[0]

    def verify_token(self):
        token = self.get_token_from_url()
        if not token:
            auth = self.headers.get("Authorization", "")
            if auth.startswith("Bearer "):
                token = auth[7:]
        if not token:
            return False
        with session_lock:
            expiry = active_sessions.get(token)
        if expiry and time.time() < expiry:
            return True
        return False

    def get_post_body(self):
        content_length = int(self.headers.get('Content-Length', 0))
        return self.rfile.read(content_length).decode('utf-8')

    def do_GET(self):
        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path

        if path == "/" or path == "/index.html":
            self.serve_dashboard()
            return

        if path == "/api/status":
            if not self.verify_token():
                self.send_response(401)
                self.end_headers()
                self.wfile.write(json.dumps({"error": "Unauthorized"}).encode("utf-8"))
                return
            cpu, ram = get_system_stats()
            host_header = self.headers.get("Host", "jishnupg-torproxy.hf.space")
            clean_host = host_header.split(":")[0]
            
            uuid_val = get_vless_uuid()
            custom_sni = settings.get("custom_sni", "").strip()
            sni_host = custom_sni if custom_sni else clean_host
            
            vless_link = f"vless://{uuid_val}@{clean_host}:443?encryption=none&security=tls&type=ws&host={sni_host}&path=%2Fvless#TorProxy"
            
            with logs_lock:
                logs_copy = list(singbox_logs)
                
            response = {
                "cpu": cpu,
                "ram": ram,
                "uuid": uuid_val,
                "custom_sni": custom_sni,
                "vless_link": vless_link,
                "logs": "\n".join(logs_copy)
            }
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps(response).encode("utf-8"))
            return

        self.send_response(404)
        self.end_headers()

    def do_POST(self):
        parsed = urllib.parse.urlparse(self.path)
        path = parsed.path

        if path == "/login":
            params = urllib.parse.parse_qs(self.get_post_body())
            password = params.get("password", [""])[0]
            admin_pwd = os.getenv("ADMIN_PASSWORD", "admin").strip(" '\"")
            
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            
            if password == admin_pwd:
                session_token = secrets.token_hex(16)
                with session_lock:
                    active_sessions[session_token] = time.time() + 86400 # 24 hours
                self.wfile.write(json.dumps({"success": True, "token": session_token}).encode("utf-8"))
            else:
                self.wfile.write(json.dumps({"success": False, "error": "Incorrect Password"}).encode("utf-8"))
            return

        if path == "/api/uuid/reset":
            if not self.verify_token():
                self.send_response(401)
                self.end_headers()
                return
            new_uuid = str(uuid.uuid4())
            settings["vless_uuid"] = new_uuid
            save_settings(settings)
            start_singbox()
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps({"success": True, "uuid": new_uuid}).encode("utf-8"))
            return

        if path == "/api/config/update":
            if not self.verify_token():
                self.send_response(401)
                self.end_headers()
                return
            params = urllib.parse.parse_qs(self.get_post_body())
            custom_sni = params.get("custom_sni", [""])[0].strip()
            settings["custom_sni"] = custom_sni
            save_settings(settings)
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(json.dumps({"success": True}).encode("utf-8"))
            return

        self.send_response(404)
        self.end_headers()

    def serve_dashboard(self):
        self.send_response(200)
        self.send_header("Content-Type", "text/html")
        self.end_headers()
        try:
            with open("dashboard.html", "r", encoding="utf-8") as f:
                content = f.read()
            self.wfile.write(content.encode("utf-8"))
        except Exception as e:
            self.wfile.write(f"Error loading dashboard: {e}".encode("utf-8"))

def run_http_server():
    server_address = ('127.0.0.1', 10080)
    httpd = ThreadingHTTPServer(server_address, VlessDashboardHandler)
    print("[HTTP] Threaded control dashboard server started on port 10080", flush=True)
    httpd.serve_forever()

if __name__ == "__main__":
    start_singbox()
    threading.Thread(target=singbox_watchdog, daemon=True).start()
    run_http_server()
