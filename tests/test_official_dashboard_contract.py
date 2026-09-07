"""Regression checks for the upstream dashboard/API compatibility boundary."""
from pathlib import Path
import ast
import unittest


ROOT = Path(__file__).resolve().parents[1]
MAIN = ROOT / "gateway" / "main.py"
API = ROOT / "gateway" / "hermes_dashboard_api.py"
MIGRATION_UI = ROOT / "third_party" / "hermes-webui"


def route_literals(path: Path):
    tree = ast.parse(path.read_text(encoding="utf-8"))
    routes = set()
    for node in ast.walk(tree):
        for decorator in getattr(node, "decorator_list", []):
            if isinstance(decorator, ast.Call) and decorator.args:
                value = decorator.args[0]
                if isinstance(value, ast.Constant) and isinstance(value.value, str):
                    routes.add(value.value)
    return routes


class OfficialDashboardContractTests(unittest.TestCase):
    def test_static_dashboard_and_spa_routes_exist(self):
        routes = route_literals(MAIN)
        self.assertIn("/dashboard", routes)
        self.assertIn("/dashboard/{asset_path:path}", routes)
        self.assertIn("/login", routes)

    def test_upstream_webui_is_isolated_behind_migration_flag(self):
        routes = route_literals(MAIN)
        self.assertIn("/hermes-webui", routes)
        self.assertIn("/hermes-webui/", routes)
        self.assertIn("/hermes-webui/{asset_path:path}", routes)
        source = MAIN.read_text(encoding="utf-8")
        self.assertIn("HERMEX_ENABLE_HERMES_WEBUI", source)
        self.assertIn("HERMES_WEBUI_STATIC_ROOT", source)
        self.assertIn('"adapter-1"', source)
        self.assertIn('asset_path.startswith("static/")', source)

    def test_upstream_webui_snapshot_is_pinned_and_has_runtime_assets(self):
        metadata = (MIGRATION_UI / "UPSTREAM.md").read_text(encoding="utf-8")
        self.assertIn("e168b67e4278df618d1cab61fdb3a8dc55b29a81", metadata)
        for relative in ("index.html", "boot.js", "messages.js", "style.css"):
            self.assertTrue((MIGRATION_UI / "static" / relative).is_file(), relative)

    def test_api_compatibility_routes_exist(self):
        routes = route_literals(API)
        for path in (
            "/api/status",
            "/api/auth/me",
            "/api/auth/ws-ticket",
            "/api/sessions/{session_id}",
            "/api/sessions/{session_id}/messages",
            "/api/config",
            "/api/config/defaults",
            "/api/config/schema",
            "/api/model/info",
            "/api/model/options",
            "/api/events",
            "/api/ws",
            "/api/pty",
        ):
            self.assertIn(path, routes)

    def test_compatibility_layer_has_no_shell_subprocess_bridge(self):
        source = API.read_text(encoding="utf-8")
        self.assertNotIn("subprocess.", source)
        self.assertNotIn("os.system(", source)
        self.assertIn("feature_not_supported", source)


if __name__ == "__main__":
    unittest.main()