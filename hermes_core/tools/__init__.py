try:
    import hermes_core.tools.web_tools
except Exception:
    pass

try:
    import hermes_core.tools.terminal_tools
except Exception:
    pass

try:
    import hermes_core.tools.file_tools
except Exception:
    pass

try:
    import hermes_core.tools.vault_tools
except Exception:
    pass

try:
    import hermes_core.tools.memory_tools
except Exception:
    pass

try:
    import hermes_core.tools.knowledge_tools
except Exception:
    pass

try:
    import hermes_core.tools.computer_tools
except Exception:
    pass

try:
    import hermes_core.tools.skill_tools
except Exception:
    pass

from hermes_core.tools.registry import registry

__all__ = ["registry"]
