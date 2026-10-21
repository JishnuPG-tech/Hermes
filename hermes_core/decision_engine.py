"""Runtime decision policy and structured task-plan primitives for Hermes."""
from __future__ import annotations

import os
import re
from dataclasses import dataclass, field
from typing import Any, Dict, List, Literal, Optional

try:
    MAX_STALL_RETRIES = max(0, min(int(os.getenv("HERMES_MAX_STALL_RETRIES", "2")), 5))
except ValueError:
    MAX_STALL_RETRIES = 2

StepStatus = Literal["pending", "running", "completed", "failed"]


@dataclass
class PlanStep:
    id: str
    action: str
    tool: Optional[str] = None
    arguments: Dict[str, Any] = field(default_factory=dict)
    status: StepStatus = "pending"
    success_criteria: str = ""
    evidence: Optional[str] = None
    depends_on: List[str] = field(default_factory=list)


@dataclass
class StructuredPlan:
    goal: str
    assumptions: List[str] = field(default_factory=list)
    steps: List[PlanStep] = field(default_factory=list)

    def next_ready_step(self) -> Optional[PlanStep]:
        """Return the first pending step whose dependencies are completed."""
        status_by_id = {step.id: step.status for step in self.steps}
        for step in self.steps:
            if step.status not in ("pending", "running"):
                continue
            if all(status_by_id.get(dep) == "completed" for dep in step.depends_on):
                return step
        return None

    @property
    def is_complete(self) -> bool:
        return bool(self.steps) and all(step.status == "completed" for step in self.steps)


@dataclass
class ActionDecision:
    kind: Literal["EXECUTE_TOOL", "REPLAN", "VERIFY", "COMPLETE", "ASK_USER"]
    reason: str
    tool: Optional[str] = None
    arguments: Optional[Dict[str, Any]] = None
    evidence: Optional[Dict[str, Any]] = None


class AutonomyPolicy:
    """Classify action-oriented tasks and detect announcements that were not executed."""

    _INFORMATIONAL_PREFIX = re.compile(
        r"^\s*(?:how\s+(?:do\s+i|can\s+i|does|to)\b|"
        r"what\s+(?:is|are|does|do)\b|why\b|explain\b|describe\b|define\b|"
        r"tell\s+me\s+how\b|can\s+you\s+explain\b|could\s+you\s+explain\b)",
        re.IGNORECASE,
    )
    _DIRECT_ACTION_VERB = re.compile(
        r"\b(?:run|execute|install|render|deploy|clone|download|upload|fix|debug|"
        r"implement|modify|edit|update|inspect|check|verify|test|compile|search|"
        r"find|look\s+up|fetch|read|convert|transcode|process|open|scan|"
        r"analy[sz]e|review|commit|push)\b",
        re.IGNORECASE,
    )
    _ARTIFACT_VERB = re.compile(r"\b(?:build|create|generate|make|write)\b", re.IGNORECASE)
    _ARTIFACT_TARGET = re.compile(
        r"\b(?:video|movie|clip|image|audio|file|script|code|app|application|apk|"
        r"website|web\s+app|repository|repo|project|dataset|package|binary|"
        r"document|pdf|spreadsheet|asset)\b",
        re.IGNORECASE,
    )
    _WORKSPACE_TARGET = re.compile(
        r"\b(?:in|inside|within|to|on)\s+(?:the\s+)?"
        r"(?:repo|repository|workspace|server|project|working\s+directory|codebase)\b",
        re.IGNORECASE,
    )
    _ANNOUNCEMENT_PATTERNS = (
        re.compile(
            r"^\s*(?:okay[,! ]*)?(?:first[,! ]*)?let\s+me\s+"
            r"(?:check|inspect|look|verify|find|run|install|create|build|render|"
            r"test|search|open|read|fetch|analy[sz]e|review)\b",
            re.IGNORECASE,
        ),
        re.compile(
            r"^\s*(?:first[,! ]*)?i(?:'ll|\s+will)\s+"
            r"(?:check|inspect|look|verify|find|run|install|create|build|render|"
            r"test|search|open|read|fetch|analy[sz]e|review)\b",
            re.IGNORECASE,
        ),
        re.compile(
            r"^\s*(?:first[,! ]*)?(?:i am going to|i'm going to|i need to)\s+"
            r"(?:check|inspect|look|verify|find|run|install|create|build|render|"
            r"test|search|open|read|fetch|analy[sz]e|review)\b",
            re.IGNORECASE,
        ),
        re.compile(
            r"^\s*(?:checking|inspecting|fetching|installing|running|creating|"
            r"building|rendering|testing|searching|verifying)\b[^\n]{0,240}$",
            re.IGNORECASE,
        ),
    )

    @classmethod
    def is_action_oriented_task(cls, prompt: str) -> bool:
        """Return True for direct requests to do work, not questions about how."""
        text = (prompt or "").strip()
        if not text or cls._INFORMATIONAL_PREFIX.search(text):
            return False
        if cls._DIRECT_ACTION_VERB.search(text):
            return True
        return bool(
            cls._ARTIFACT_VERB.search(text)
            and (
                cls._ARTIFACT_TARGET.search(text)
                or cls._WORKSPACE_TARGET.search(text)
            )
        )

    @classmethod
    def is_unfulfilled_action_announcement(cls, raw_text: str, has_tool_calls: bool) -> bool:
        """Detect a next-action announcement that produced no executable tool call."""
        if has_tool_calls:
            return False
        text = (raw_text or "").strip()
        if not text:
            return False
        opening = text[:320].strip()
        return any(pattern.search(opening) for pattern in cls._ANNOUNCEMENT_PATTERNS)

    @staticmethod
    def recovery_directive(prompt: str, previous_response: str, attempt: int) -> str:
        """Build a runtime instruction to continue the same task with a real action."""
        previous = re.sub(r"\s+", " ", previous_response or "").strip()[:320]
        goal = re.sub(r"\s+", " ", prompt or "").strip()[:500]
        return (
            "[HERMES RUNTIME DECISION ENGINE] The task is still active. Your previous "
            "message announced an action but no tool call was emitted. Do not repeat a "
            "status announcement or ask the user what to do next. Choose the next safe, "
            "concrete action from the available registered tools and execute it now. "
            "Use the actual tool result to decide the following step. Preserve the "
            "original goal. If a tool is unavailable, select a viable alternative. "
            "Do not perform destructive or externally consequential actions without "
            "required authorization. If genuinely blocked, state the specific blocker "
            "only after checking available alternatives. Recovery attempt "
            f"{attempt}.\nOriginal goal: {goal}\nPrevious announcement: {previous}"
        )
