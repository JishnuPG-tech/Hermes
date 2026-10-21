"""Runtime decision policy, goal verification, and structured task-plan primitives for Hermes."""
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


@dataclass
class GoalVerificationResult:
    is_verified: bool
    missing_aspect: str = ""
    evidence_summary: str = ""


class GoalVerifier:
    """Evaluates whether the terminal objective of an action task has been achieved."""

    _INSPECTION_PATTERN = re.compile(
        r"\b(?:python\d*\s+-c\s+[\"']import|"
        r"python\d*\s+(?:-V|--version)|"
        r"pip\s+(?:list|show)|which\b|where\b|type\b|cat\b|head\b|tail\b|"
        r"ls\b|dir\b|git\s+status|git\s+branch|find\b|grep\b|"
        r"echo\b|whoami\b|id\b|uname\b|list_directory|read_file|"
        r"computer_system_status|computer_project_list)\b",
        re.IGNORECASE,
    )

    _ARTIFACT_GOAL = re.compile(
        r"\b(?:build|create|generate|render|make|produce|export|transcode|convert)\b.*?"
        r"\b(?:video|clip|movie|audio|animation|apk|image|file|script|code|app|application|binary)\b|"
        r"\b(?:clone|pull|push|commit|deploy|install|setup|run\s+tests?)\b",
        re.IGNORECASE,
    )

    _SUCCESS_INDICATORS = re.compile(
        r"\b(?:rendered|generated|created|saved|output\s+written|"
        r"exit\s*code:\s*0|returncode:\s*0|successfully\s+(?:built|installed|created|rendered|finished)|"
        r"export\s+complete|file\s+exists|test[s]?\s+passed)\b",
        re.IGNORECASE,
    )

    _TRANSITION_INTENT_PATTERN = (
        re.compile(
            r"\b(?:i\s+will\s+now|now\s+i\s+will|next\s+i\s+will|let\s+me\s+now|let's\s+now|now\s+let's)\s+"
            r"(?:create|build|render|run|execute|install|write|implement|generate)\b",
            re.IGNORECASE,
        ),
        re.compile(
            r"\b(?:would\s+you\s+like\s+me\s+to|should\s+i\s+(?:go\s+ahead\s+and|proceed\s+to)?|"
            r"let\s+me\s+know\s+if\s+you\s+(?:want|would\s+like)\s+me\s+to)\s+"
            r"(?:create|build|render|run|execute|install|proceed|write)\b",
            re.IGNORECASE,
        ),
        re.compile(
            r"\b(?:ready\s+to\s+(?:build|render|create|run|execute)|proceeding\s+to\s+(?:build|render|create))\b",
            re.IGNORECASE,
        ),
    )

    @classmethod
    def evaluate(cls, goal: str, gathered_data_blocks: List[str], raw_text_accum: str) -> GoalVerificationResult:
        """Verify whether the requested operational goal has been achieved with evidence."""
        if not AutonomyPolicy.is_action_oriented_task(goal):
            return GoalVerificationResult(is_verified=True, evidence_summary="Task is informational or conversational.")

        if not gathered_data_blocks:
            return GoalVerificationResult(
                is_verified=False,
                missing_aspect="No tools or commands have been executed yet.",
            )

        # 1. Check if model text explicitly signals unfinished transition intent
        opening = raw_text_accum[:400].strip() if raw_text_accum else ""
        for pat in cls._TRANSITION_INTENT_PATTERN:
            if pat.search(opening):
                return GoalVerificationResult(
                    is_verified=False,
                    missing_aspect="Response announced the next concrete step or asked for confirmation instead of executing it.",
                )

        # 2. For artifact/build/render tasks, check if only inspection tools were run
        if cls._ARTIFACT_GOAL.search(goal):
            has_operational_tool = False
            has_success_indicator = False

            for block in gathered_data_blocks:
                header = block.split("\n", 1)[0].strip()
                if not cls._INSPECTION_PATTERN.search(header):
                    has_operational_tool = True
                if cls._SUCCESS_INDICATORS.search(block):
                    has_success_indicator = True

            if not has_operational_tool:
                return GoalVerificationResult(
                    is_verified=False,
                    missing_aspect="Only preparatory inspection commands were executed; core creation/rendering was not executed.",
                )

            if not has_success_indicator:
                return GoalVerificationResult(
                    is_verified=False,
                    missing_aspect="An operational command ran, but the output does not provide clear evidence of success.",
                )

        return GoalVerificationResult(is_verified=True, evidence_summary="Tool execution evidence satisfies the goal.")


class StructuredPlanGenerator:
    """Generates an initial structured execution plan for multi-stage tasks."""

    @classmethod
    def generate_plan(cls, goal: str) -> StructuredPlan:
        goal_lower = goal.lower()
        if any(w in goal_lower for w in ["video", "render", "moviepy"]):
            return StructuredPlan(
                goal=goal,
                assumptions=["Available workspace Python environment", "Output to workspace"],
                steps=[
                    PlanStep(
                        id="inspect_env",
                        action="Inspect Python & MoviePy environment",
                        tool="bash_exec",
                        arguments={"command": "python3 -c \"import moviepy; print(moviepy.__version__)\" 2>/dev/null || python -c \"import moviepy; print(moviepy.__version__)\""},
                        success_criteria="Environment versions recorded",
                    ),
                    PlanStep(
                        id="execute_render",
                        action="Generate and execute video rendering script",
                        tool="bash_exec",
                        depends_on=["inspect_env"],
                        success_criteria="Rendering process completes with exit code 0",
                    ),
                    PlanStep(
                        id="verify_output",
                        action="Verify rendered video artifact exists and is non-empty",
                        tool="bash_exec",
                        depends_on=["execute_render"],
                        success_criteria="Output video file exists on disk",
                    ),
                ],
            )
        elif any(w in goal_lower for w in ["git", "clone", "repo", "repository"]) and any(w in goal_lower for w in ["clone", "pull", "fetch"]):
            return StructuredPlan(
                goal=goal,
                assumptions=["Network access", "Workspace write access"],
                steps=[
                    PlanStep(
                        id="check_repo_status",
                        action="Check target repository and environment status",
                        tool="bash_exec",
                        arguments={"command": "git status 2>/dev/null || ls -la"},
                        success_criteria="Workspace status recorded",
                    ),
                    PlanStep(
                        id="execute_git_action",
                        action="Perform git operation",
                        tool="bash_exec",
                        depends_on=["check_repo_status"],
                        success_criteria="Git command exits successfully",
                    ),
                    PlanStep(
                        id="verify_repo_state",
                        action="Verify repository files and git log",
                        tool="bash_exec",
                        depends_on=["execute_git_action"],
                        success_criteria="Repository state confirmed",
                    ),
                ],
            )
        else:
            return StructuredPlan(
                goal=goal,
                steps=[
                    PlanStep(
                        id="execute_task",
                        action="Execute primary task operation",
                        success_criteria="Operation produces verified output",
                    ),
                    PlanStep(
                        id="verify_result",
                        action="Verify result of operation",
                        depends_on=["execute_task"],
                        success_criteria="Result verified",
                    ),
                ],
            )


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

    @staticmethod
    def partial_goal_directive(
        prompt: str,
        gathered_data_blocks: List[str],
        previous_response: str,
        missing_aspect: str,
        attempt: int,
    ) -> str:
        """Directive injected when an agent stops after a preparatory step without achieving the goal."""
        evidence_snippet = "\n".join(gathered_data_blocks[-2:])[:400]
        previous = re.sub(r"\s+", " ", previous_response or "").strip()[:200]
        goal = re.sub(r"\s+", " ", prompt or "").strip()[:300]
        return (
            "[HERMES RUNTIME DECISION ENGINE] Partial execution detected. "
            f"Status: {missing_aspect}. "
            "You have performed a preparatory step or command inspection, but the main goal has not been completed. "
            "Do not stop, ask the user for permission, or tell the user to run commands themselves. "
            "Make all necessary implementation decisions autonomously (choose reasonable default settings, file names, or compatible syntax). "
            "Execute the next concrete action tool immediately to complete and verify the final result. "
            f"Recovery attempt {attempt}.\n"
            f"Original goal: {goal}\n"
            f"Recent tool evidence:\n{evidence_snippet}\n"
            f"Previous message: {previous}"
        )
