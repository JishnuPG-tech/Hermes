"""
Hermes Skill Discovery & Documentation Tools
Enables Hermes to discover, inspect, and read instructions for local and project skills
such as brag, python-pro, fastapi-pro, etc.
"""
from __future__ import annotations

import os
import re
import json
from pathlib import Path
from typing import Dict, Any, List, Optional
from hermes_core.tools.registry import registry

ACTIVE_CONVERSATION_SKILLS: Dict[str, Any] = {}
BUILTIN_SKILLS: List[str] = ["brag", "python-pro", "fastapi-pro", "ig-reel", "ig-caption", "ig-plan", "ig-human", "ig-viral"]

SKILL_DIRECTORIES = [
    Path("skills"),
    Path(".agents/skills"),
    Path("../.agents/skills"),
    Path("/data/hermes/skills"),
    Path("/app/skills"),
    Path("/app/.agents/skills"),
    Path(os.path.expanduser("~/.agents/skills")),
]


def _find_skill_paths() -> Dict[str, Path]:
    """Locate all skill folders across configured search directories, preferring folders containing SKILL.md."""
    found: Dict[str, Path] = {}
    for base_dir in SKILL_DIRECTORIES:
        if not base_dir.exists():
            continue
        try:
            for entry in base_dir.iterdir():
                if entry.is_dir() and not entry.name.startswith("."):
                    skill_name = entry.name.lower()
                    has_skill_md = (entry / "SKILL.md").exists()
                    if skill_name not in found or (has_skill_md and not (found[skill_name] / "SKILL.md").exists()):
                        found[skill_name] = entry
        except Exception:
            continue
    return found


def _extract_skill_metadata(skill_dir: Path) -> Dict[str, Any]:
    """Parse skill name and description from SKILL.md frontmatter or first header."""
    skill_md = skill_dir / "SKILL.md"
    name = skill_dir.name
    description = ""

    if skill_md.exists():
        try:
            content = skill_md.read_text(encoding="utf-8", errors="replace")
            # Parse YAML frontmatter
            fm_match = re.search(r"^---\s*\n(.*?)\n---", content, re.DOTALL)
            if fm_match:
                fm_text = fm_match.group(1)
                name_m = re.search(r"^name:\s*(.+)$", fm_text, re.MULTILINE)
                if name_m:
                    name = name_m.group(1).strip()
                desc_m = re.search(r"^description:\s*(.+)$", fm_text, re.MULTILINE)
                if desc_m:
                    description = desc_m.group(1).strip()
            if not description:
                # Use first paragraph or header
                lines = [l.strip() for l in content.splitlines() if l.strip() and not l.startswith("---")]
                if lines:
                    description = lines[0].lstrip("#").strip()
        except Exception:
            pass

    return {
        "name": name,
        "directory": str(skill_dir).replace("\\", "/"),
        "description": description or f"Skill instructions in {skill_dir.name}",
        "has_skill_md": skill_md.exists(),
    }


@registry.register(
    name="list_skills",
    description="Discover and list available agent skills (e.g. 'brag', 'python-pro', 'fastapi-pro') with their descriptions and file paths.",
    parameters={
        "type": "object",
        "properties": {
            "query": {
                "type": "string",
                "description": "Optional search term to filter skills by name or description."
            }
        }
    },
    category="system"
)
async def list_skills(query: Optional[str] = None) -> str:
    """Discover available skills."""
    skills_map = _find_skill_paths()
    results = []

    for name, skill_path in skills_map.items():
        meta = _extract_skill_metadata(skill_path)
        if query:
            q = query.lower()
            if q not in meta["name"].lower() and q not in meta["description"].lower():
                continue
        results.append(meta)

    return json.dumps({
        "status": "success",
        "count": len(results),
        "skills": results
    }, indent=2)


@registry.register(
    name="read_skill_documentation",
    description="Retrieve the complete instructions and workflow documentation for a specific skill (e.g. 'brag').",
    parameters={
        "type": "object",
        "properties": {
            "skill_name": {
                "type": "string",
                "description": "The exact name or keyword of the skill (e.g. 'brag', 'python-pro')."
            }
        },
        "required": ["skill_name"]
    },
    category="system"
)
async def read_skill_documentation(skill_name: str) -> str:
    """Read the full documentation for the specified skill."""
    s_name = skill_name.strip().lower()
    skills_map = _find_skill_paths()

    target_dir = skills_map.get(s_name)
    if not target_dir:
        # Check partial match
        for k, v in skills_map.items():
            if s_name in k or k in s_name:
                target_dir = v
                break

    if not target_dir:
        return json.dumps({
            "status": "error",
            "message": f"Skill '{skill_name}' not found. Available skills: {list(skills_map.keys())}"
        })

    # Search for SKILL.md or main markdown file
    skill_md = target_dir / "SKILL.md"
    if not skill_md.exists():
        md_files = list(target_dir.glob("*.md"))
        if md_files:
            skill_md = md_files[0]

    if not skill_md.exists():
        # List assets or files in the skill directory
        files = [f.name for f in target_dir.iterdir()]
        return json.dumps({
            "status": "success",
            "skill": target_dir.name,
            "directory": str(target_dir).replace("\\", "/"),
            "files": files,
            "note": "No SKILL.md found; folder contains the listed assets/files."
        })

    try:
        content = skill_md.read_text(encoding="utf-8", errors="replace")
        if len(content) > 3500:
            content = content[:3500] + "\n\n... [documentation truncated for prompt context] ..."
        return json.dumps({
            "status": "success",
            "skill": target_dir.name,
            "path": str(skill_md).replace("\\", "/"),
            "documentation": content
        })
    except Exception as e:
        return json.dumps({
            "status": "error",
            "message": f"Failed reading skill documentation: {str(e)}"
        })
