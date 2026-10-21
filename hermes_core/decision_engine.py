"""
Runtime decision policy, goal verification, formal lifecycle state machine,
universal task planner, and autonomous task controller for Hermes.
"""
from __future__ import annotations

import os
import re
import time
import uuid
import json
import logging
from dataclasses import dataclass, field, asdict
from enum import Enum
from typing import Any, Dict, List, Literal, Optional, Set, Tuple

logger = logging.getLogger("hermes.decision_engine")

try:
    MAX_STALL_RETRIES = max(0, min(int(os.getenv("HERMES_MAX_STALL_RETRIES", "2")), 5))
except ValueError:
    MAX_STALL_RETRIES = 2

StepStatus = Literal["pending", "running", "completed", "failed", "blocked"]


class TaskLifecycleState(str, Enum):
    """Formal lifecycle states for an autonomous task."""
    NEW = "NEW"
    CLASSIFYING = "CLASSIFYING"
    PLANNING = "PLANNING"
    READY = "READY"
    EXECUTING = "EXECUTING"
    VERIFYING = "VERIFYING"
    RECOVERING = "RECOVERING"
    WAITING_APPROVAL = "WAITING_APPROVAL"
    BLOCKED = "BLOCKED"
    COMPLETED = "COMPLETED"
    FAILED = "FAILED"
    CANCELLED = "CANCELLED"


class InvalidStateTransition(Exception):
    """Raised when an illegal lifecycle state transition is attempted."""
    def __init__(self, current: TaskLifecycleState, target: TaskLifecycleState, reason: str = ""):
        super().__init__(f"Invalid state transition from {current.value} to {target.value}. {reason}")
        self.current = current
        self.target = target
        self.reason = reason


class TaskStateMachine:
    """Enforces valid task state transitions and preserves state invariants."""

    VALID_TRANSITIONS: Dict[TaskLifecycleState, Set[TaskLifecycleState]] = {
        TaskLifecycleState.NEW: {
            TaskLifecycleState.CLASSIFYING,
            TaskLifecycleState.CANCELLED,
        },
        TaskLifecycleState.CLASSIFYING: {
            TaskLifecycleState.PLANNING,
            TaskLifecycleState.READY,
            TaskLifecycleState.COMPLETED,
            TaskLifecycleState.CANCELLED,
            TaskLifecycleState.FAILED,
        },
        TaskLifecycleState.PLANNING: {
            TaskLifecycleState.READY,
            TaskLifecycleState.WAITING_APPROVAL,
            TaskLifecycleState.CANCELLED,
            TaskLifecycleState.FAILED,
            TaskLifecycleState.BLOCKED,
        },
        TaskLifecycleState.READY: {
            TaskLifecycleState.EXECUTING,
            TaskLifecycleState.WAITING_APPROVAL,
            TaskLifecycleState.CANCELLED,
            TaskLifecycleState.BLOCKED,
            TaskLifecycleState.COMPLETED,
        },
        TaskLifecycleState.EXECUTING: {
            TaskLifecycleState.VERIFYING,
            TaskLifecycleState.WAITING_APPROVAL,
            TaskLifecycleState.RECOVERING,
            TaskLifecycleState.BLOCKED,
            TaskLifecycleState.FAILED,
            TaskLifecycleState.CANCELLED,
        },
        TaskLifecycleState.VERIFYING: {
            TaskLifecycleState.COMPLETED,
            TaskLifecycleState.RECOVERING,
            TaskLifecycleState.BLOCKED,
            TaskLifecycleState.FAILED,
            TaskLifecycleState.CANCELLED,
        },
        TaskLifecycleState.RECOVERING: {
            TaskLifecycleState.READY,
            TaskLifecycleState.EXECUTING,
            TaskLifecycleState.WAITING_APPROVAL,
            TaskLifecycleState.BLOCKED,
            TaskLifecycleState.FAILED,
            TaskLifecycleState.CANCELLED,
        },
        TaskLifecycleState.WAITING_APPROVAL: {
            TaskLifecycleState.READY,
            TaskLifecycleState.EXECUTING,
            TaskLifecycleState.RECOVERING,
            TaskLifecycleState.BLOCKED,
            TaskLifecycleState.CANCELLED,
            TaskLifecycleState.FAILED,
        },
        TaskLifecycleState.BLOCKED: {
            TaskLifecycleState.RECOVERING,
            TaskLifecycleState.READY,
            TaskLifecycleState.CANCELLED,
            TaskLifecycleState.FAILED,
        },
        TaskLifecycleState.COMPLETED: set(),
        TaskLifecycleState.FAILED: set(),
        TaskLifecycleState.CANCELLED: set(),
    }

    def __init__(self, initial_state: TaskLifecycleState = TaskLifecycleState.NEW):
        self.state = initial_state
        self.history: List[Tuple[TaskLifecycleState, TaskLifecycleState, str, float]] = []

    def can_transition(self, target: TaskLifecycleState) -> bool:
        return target in self.VALID_TRANSITIONS.get(self.state, set())

    def transition(self, target: TaskLifecycleState, reason: str = "") -> TaskLifecycleState:
        if not self.can_transition(target):
            raise InvalidStateTransition(self.state, target, reason)
        old_state = self.state
        self.state = target
        self.history.append((old_state, target, reason, time.time()))
        logger.debug(f"[STATE] {old_state.value} -> {target.value} ({reason})")
        return self.state


class TaskCategory(str, Enum):
    INFORMATIONAL = "INFORMATIONAL"
    CONVERSATIONAL = "CONVERSATIONAL"
    ACTION_EXECUTION = "ACTION_EXECUTION"


@dataclass
class TaskClassification:
    category: TaskCategory
    action_type: str = "general"
    requires_tools: bool = False
    requires_approval: bool = False
    confidence: float = 1.0
    rationale: str = ""


class TaskClassifier:
    """Classifies requests into informational answers, conversation, or action workflows."""

    _INFORMATIONAL_PREFIX = re.compile(
        r"^\s*(?:how\s+(?:do\s+i|can\s+i|does|to)\b|"
        r"what\s+(?:is|are|does|do)\b|why\b|explain\b|describe\b|define\b|"
        r"tell\s+me\s+how\b|can\s+you\s+explain\b|could\s+you\s+explain\b)",
        re.IGNORECASE,
    )
    _DIRECT_ACTION_VERBS = re.compile(
        r"\b(?:run|execute|install|render|deploy|clone|download|upload|fix|debug|"
        r"implement|modify|edit|update|inspect|check|verify|test|compile|search|"
        r"find|look\s+up|fetch|read|convert|transcode|process|open|scan|"
        r"analy[sz]e|review|commit|push|build|create|generate|make|write)\b",
        re.IGNORECASE,
    )
    _HIGH_RISK_VERBS = re.compile(
        r"\b(?:rm\s+-rf|drop\s+database|drop\s+table|delete\s+all|format|"
        r"git\s+push\s+--force|force\s+push|truncate|deploy\s+prod|production\s+release)\b",
        re.IGNORECASE,
    )

    @classmethod
    def classify(cls, prompt: str) -> TaskClassification:
        text = (prompt or "").strip()
        if not text:
            return TaskClassification(category=TaskCategory.CONVERSATIONAL, requires_tools=False)

        # 1. Fast conversational filter
        words = text.lower().split()
        trivial_greetings = {"hi", "hello", "hey", "sup", "thanks", "thank", "you", "ok", "okay", "k", "bye", "ping"}
        if len(words) <= 3 and all(re.sub(r'[^a-z]', '', w) in trivial_greetings for w in words if re.sub(r'[^a-z]', '', w)):
            return TaskClassification(category=TaskCategory.CONVERSATIONAL, action_type="greeting", requires_tools=False)

        # 2. Informational questions
        if cls._INFORMATIONAL_PREFIX.search(text) and not any(
            w in text.lower() for w in ["and run", "then run", "then execute", "and execute", "and fix", "and build"]
        ):
            return TaskClassification(category=TaskCategory.INFORMATIONAL, action_type="explanation", requires_tools=False)

        # 3. Creative writing / casual chatter without external action
        if any(p in text.lower() for p in ["tell me a joke", "write a poem", "tell a story", "who are you", "what is your name"]):
            return TaskClassification(category=TaskCategory.CONVERSATIONAL, action_type="creative", requires_tools=False)

        # 4. Action-oriented workflows
        is_action = AutonomyPolicy.is_action_oriented_task(text)
        action_type = "general"
        t_lower = text.lower()
        if any(w in t_lower for w in ["skill", "brag", "references"]):
            action_type = "skill_workflow"
        elif any(w in t_lower for w in ["video", "render", "moviepy", "clip", "mp4"]):
            action_type = "video"
        elif any(w in t_lower for w in ["git", "clone", "commit", "push", "pull", "pr", "branch"]):
            action_type = "git"
        elif any(w in t_lower for w in ["fix", "bug", "traceback", "test", "unittest", "pytest"]):
            action_type = "code_fix"
        elif any(w in t_lower for w in ["write code", "implement", "create script", "scaffold"]):
            action_type = "coding"
        elif any(w in t_lower for w in ["research", "investigate", "web search"]):
            action_type = "research"

        requires_approval = bool(cls._HIGH_RISK_VERBS.search(text))

        if is_action or cls._DIRECT_ACTION_VERBS.search(text):
            return TaskClassification(
                category=TaskCategory.ACTION_EXECUTION,
                action_type=action_type,
                requires_tools=True,
                requires_approval=requires_approval,
                rationale=f"Direct operational request ({action_type})",
            )

        return TaskClassification(category=TaskCategory.INFORMATIONAL, requires_tools=False)


@dataclass
class ToolExecutionResult:
    """Structured record of a tool execution."""
    execution_id: str
    task_id: str
    step_id: Optional[str]
    tool_name: str
    arguments: Dict[str, Any]
    status: Literal["success", "failed", "blocked"] = "success"
    exit_code: Optional[int] = 0
    stdout: str = ""
    stderr: str = ""
    artifacts: List[str] = field(default_factory=list)
    started_at: float = field(default_factory=time.time)
    finished_at: float = field(default_factory=time.time)
    error: Optional[str] = None

    def to_dict(self) -> Dict[str, Any]:
        return asdict(self)

    @classmethod
    def from_raw(
        cls,
        tool_name: str,
        arguments: Dict[str, Any],
        raw_output: str,
        task_id: str = "",
        step_id: Optional[str] = None,
        execution_id: Optional[str] = None,
    ) -> ToolExecutionResult:
        now = time.time()
        exec_id = execution_id or f"exec_{uuid.uuid4().hex[:8]}"

        exit_code = 0
        m_code = re.search(r"\[EXIT CODE:\s*(\d+)\]", raw_output, re.IGNORECASE)
        if m_code:
            exit_code = int(m_code.group(1))
        else:
            m_ret = re.search(r'"returncode":\s*(\d+)', raw_output, re.IGNORECASE)
            if m_ret:
                exit_code = int(m_ret.group(1))

        error_indicators = (
            "command not found",
            "traceback (most recent call last)",
            "syntaxerror:",
            "fatal error",
            "no such file or directory",
            "cannot find module",
            "failed to render",
            "exit code: 1",
            "exit code: 2",
            "exit code: 127",
            "permission denied",
        )
        has_error = (exit_code != 0) or any(err in raw_output.lower() for err in error_indicators)

        artifacts: List[str] = []
        for line in raw_output.splitlines():
            m_art = re.search(r"(?:created|written|rendered|output|saved):\s*([^\s<>'\"]+\.(?:mp4|mov|avi|py|json|md|txt|html|png|jpg))", line, re.IGNORECASE)
            if m_art:
                artifacts.append(m_art.group(1).strip())

        status = "failed" if has_error else "success"
        error_msg = raw_output[:300] if has_error else None

        return cls(
            execution_id=exec_id,
            task_id=task_id,
            step_id=step_id,
            tool_name=tool_name,
            arguments=arguments,
            status=status,
            exit_code=exit_code,
            stdout=raw_output,
            stderr=raw_output if has_error else "",
            artifacts=artifacts,
            started_at=now,
            finished_at=now,
            error=error_msg,
        )


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
    execution_id: Optional[str] = None
    attempt: int = 0
    artifacts: List[str] = field(default_factory=list)
    requires_approval: bool = False


@dataclass
class StructuredPlan:
    goal: str
    task_id: str = field(default_factory=lambda: f"task_{uuid.uuid4().hex[:8]}")
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

    @property
    def has_failed_step(self) -> bool:
        return any(step.status == "failed" for step in self.steps)

    @staticmethod
    def _is_tool_relevant_to_step(step: PlanStep, tool_name: str, command: str, output: str) -> bool:
        """Validate whether the executed command actually corresponds to the step's intent."""
        cmd_lower = command.lower().strip()
        step_id = step.id.lower()
        t_name = tool_name.lower().strip()

        # Step A: Skill discovery and retrieval
        if any(w in step_id for w in ["skill", "discover", "reference"]):
            if t_name in ("list_skills", "read_skill_documentation", "read_file", "list_directory"):
                return True
            if any(ind in cmd_lower for ind in ["skill", "ls", "cat", "find", "grep"]):
                return True
            return False

        # Step B: Environment / Dependency inspection
        if any(w in step_id for w in ["inspect", "check", "env"]):
            inspection_indicators = (
                "python", "pip", "node", "npm", "which", "where",
                "version", "-v", "--version", "import", "status", "ls", "find"
            )
            return any(ind in cmd_lower for ind in inspection_indicators) or t_name in ("list_directory", "read_file", "list_skills")

        # Step C: Operational execution / Render / Build / Run / Implement
        if any(w in step_id for w in ["render", "execute", "build", "run", "implement"]):
            # Must NOT be a simple read-only command or basic diagnostic echo
            pure_read_only = (
                cmd_lower.startswith("echo ") or
                cmd_lower.startswith("whoami") or
                cmd_lower.startswith("pwd") or
                cmd_lower.startswith("which ") or
                cmd_lower.startswith("cat ") or
                (cmd_lower.startswith("python") and "-c 'import" in cmd_lower) or
                (cmd_lower.startswith("python") and '-c "import' in cmd_lower) or
                cmd_lower in ("ls", "dir", "git status")
            )
            if pure_read_only and t_name == "bash_exec":
                return False

            execution_cues = ("python", "render", "ffmpeg", "build", "make", "compile", "run", "node", "bash", "git", "sh")
            return any(cue in cmd_lower for cue in execution_cues) or t_name in ("python_exec", "bash_exec", "write_file", "edit_file")

        # Step D: Verification / Output validation
        if any(w in step_id for w in ["verify", "output", "validate"]):
            verification_cues = (
                "ls", "test -f", "test -e", "stat", "file ", "ffprobe", "dir",
                "os.path", "exists", "grep", "cat", "git log", "git status"
            )
            return any(cue in cmd_lower for cue in verification_cues) or t_name in ("list_directory", "read_file")

        # Step E: Git operations
        if "git" in step_id:
            return "git" in cmd_lower or t_name in ("bash_exec",)

        # Default fallback: check tool name match
        if step.tool and step.tool != tool_name:
            return False
        return True

    def advance_with_evidence(
        self,
        tool_name: str,
        tool_args: Dict[str, Any],
        tool_output: str,
        execution_id: Optional[str] = None,
    ) -> Optional[PlanStep]:
        """Correlate tool output with the current ready step and advance if satisfied."""
        step = self.next_ready_step()
        if not step:
            return None

        command = str(tool_args.get("command") or tool_args.get("query") or tool_args.get("skill_name") or "").strip()

        # 1. Validate tool relevance
        if not self._is_tool_relevant_to_step(step, tool_name, command, tool_output):
            return None

        step.attempt += 1
        if execution_id:
            step.execution_id = execution_id

        # 2. Check for explicit non-zero exit codes
        exit_code = None
        m_code = re.search(r"\[EXIT CODE:\s*(\d+)\]", tool_output, re.IGNORECASE)
        if m_code:
            exit_code = int(m_code.group(1))
        else:
            m_ret = re.search(r'"returncode":\s*(\d+)', tool_output, re.IGNORECASE)
            if m_ret:
                exit_code = int(m_ret.group(1))

        error_indicators = (
            "command not found",
            "traceback (most recent call last)",
            "syntaxerror:",
            "fatal error",
            "no such file or directory",
            "cannot find module",
            "failed to render",
            "exit code: 1",
            "exit code: 2",
            "exit code: 127",
            "permission denied",
        )
        has_error_text = any(err in tool_output.lower() for err in error_indicators)

        if (exit_code is not None and exit_code != 0) or has_error_text:
            step.status = "failed"
            step.evidence = f"Step failed: {tool_output[:400]}"
            return step

        # 3. For verification steps, check artifact confirmation
        if "verify" in step.id.lower():
            missing_indicators = ("not found", "no such file", "cannot access", "0 bytes", "empty file")
            if any(m in tool_output.lower() for m in missing_indicators):
                step.status = "failed"
                step.evidence = f"Artifact verification failed: {tool_output[:400]}"
                return step

        # Step successfully completed
        step.status = "completed"
        step.evidence = tool_output[:500] if tool_output else "Executed successfully"
        return step

    def to_dict(self) -> Dict[str, Any]:
        return {
            "task_id": self.task_id,
            "goal": self.goal,
            "assumptions": self.assumptions,
            "steps": [asdict(s) for s in self.steps],
            "is_complete": self.is_complete,
        }

    @classmethod
    def from_dict(cls, data: Dict[str, Any]) -> StructuredPlan:
        steps = [PlanStep(**s) for s in data.get("steps", [])]
        return cls(
            goal=data.get("goal", ""),
            task_id=data.get("task_id", f"task_{uuid.uuid4().hex[:8]}"),
            assumptions=data.get("assumptions", []),
            steps=steps,
        )


@dataclass
class ActionDecision:
    kind: Literal[
        "EXECUTE_TOOL",
        "EXECUTE_DETERMINISTIC_STEP",
        "RETRY_WITH_DIRECTIVE",
        "SWITCH_CANDIDATE",
        "FALLBACK_MODEL",
        "ASK_USER",
        "COMPLETE",
        "BLOCKED",
    ]
    tool: Optional[str] = None
    arguments: Dict[str, Any] = field(default_factory=dict)
    rationale: str = ""
    reason: str = ""
    target_candidate: Optional[str] = None
    requires_approval: bool = False
    is_terminal: bool = False

    def __post_init__(self):
        if self.reason and not self.rationale:
            self.rationale = self.reason
        elif self.rationale and not self.reason:
            self.reason = self.rationale


@dataclass
class GoalVerificationResult:
    is_verified: bool
    missing_aspect: str = ""
    evidence_summary: str = ""
    verified_artifacts: List[str] = field(default_factory=list)


class GoalVerifier:
    """Verifies that an action-oriented goal has actual completed execution evidence."""

    _INSPECTION_ONLY = re.compile(
        r"^(?:python\d*\s+-c\s+[\"']import\s+[^;\"']+(?:;\s*print\([^)]+\))?[\"']|"
        r"pip\s+show\s+\w+|which\s+\w+|ls\b|dir\b|echo\b|whoami\b|pwd\b|git\s+status\b)\s*$",
        re.IGNORECASE,
    )

    _UNFINISHED_TRANSITIONS = (
        re.compile(r"\b(?:now\s+(?:i\s+will|let\s+me|we\s+can|proceed\s+to))\b", re.IGNORECASE),
        re.compile(r"\b(?:next\s+(?:i\s+will|step\s+is\s+to)|i\s+will\s+now|let\s+me\s+now)\b", re.IGNORECASE),
        re.compile(r"\b(?:ready\s+to\s+build|preparing\s+to\s+render|about\s+to\s+execute)\b", re.IGNORECASE),
        re.compile(r"\b(?:let\s+me\s+grab|dive\s+straight\s+into)\b", re.IGNORECASE),
    )

    @classmethod
    def evaluate(
        cls,
        prompt: str,
        gathered_data_blocks: List[str],
        final_response: str,
    ) -> GoalVerificationResult:
        if not AutonomyPolicy.is_action_oriented_task(prompt):
            return GoalVerificationResult(is_verified=True, missing_aspect="", evidence_summary="Informational query approved")

        if not gathered_data_blocks:
            return GoalVerificationResult(
                is_verified=False,
                missing_aspect="No tools were executed for an operational task.",
            )

        combined_evidence = "\n".join(gathered_data_blocks)
        commands_run = re.findall(r"\[(?:bash_exec|bash)\s*\((.*?)\)\]", combined_evidence)

        # 1. Check for announced next concrete steps in response
        for pattern in cls._UNFINISHED_TRANSITIONS:
            if pattern.search(final_response or ""):
                return GoalVerificationResult(
                    is_verified=False,
                    missing_aspect="Response announced the next concrete step instead of completing it.",
                )

        # 2. Check for preparatory inspection only
        if commands_run and all(cls._INSPECTION_ONLY.match(cmd.strip()) for cmd in commands_run):
            return GoalVerificationResult(
                is_verified=False,
                missing_aspect="Execution stopped after preparatory inspection without performing the action.",
            )

        p_lower = prompt.lower()
        if any(w in p_lower for w in ["video", "render", "moviepy"]):
            has_render_evidence = any(
                term in combined_evidence.lower()
                for term in [
                    "moviepy - writing video",
                    "rendering complete",
                    "video ready",
                    "fps:",
                    ".mp4",
                    "exit code: 0",
                    "[exit code: 0]",
                ]
            )
            has_error = any(
                err in combined_evidence.lower()
                for err in [
                    "failed to render",
                    "traceback",
                    "syntaxerror",
                    "exit code: 1",
                ]
            )
            if has_error or not has_render_evidence:
                return GoalVerificationResult(
                    is_verified=False,
                    missing_aspect="Operational command executed without clear evidence of success.",
                )

        return GoalVerificationResult(is_verified=True, evidence_summary="Action verified with tool evidence")


class StructuredPlanGenerator:
    """Generates an initial structured execution plan for multi-stage tasks."""

    @classmethod
    def generate_plan(cls, goal: str, available_tools: Optional[Set[str]] = None) -> StructuredPlan:
        goal_lower = goal.lower()

        # 1. Skill-based task (e.g. SmartWatt brag launch video)
        if any(w in goal_lower for w in ["skill", "brag"]) and any(w in goal_lower for w in ["video", "build", "create", "make", "render"]):
            return StructuredPlan(
                goal=goal,
                assumptions=["Workspace assets available", "Local skill documentation present"],
                steps=[
                    PlanStep(
                        id="discover_skill",
                        action="Discover and read brag skill instructions",
                        tool="read_skill_documentation",
                        arguments={"skill_name": "brag"},
                        success_criteria="Skill instructions retrieved",
                    ),
                    PlanStep(
                        id="inspect_assets",
                        action="Inspect workspace project files and brag assets",
                        tool="list_directory",
                        arguments={"path": "."},
                        depends_on=["discover_skill"],
                        success_criteria="Workspace layout confirmed",
                    ),
                    PlanStep(
                        id="execute_render",
                        action="Generate and execute video rendering script",
                        tool="bash_exec",
                        depends_on=["inspect_assets"],
                        success_criteria="Rendering process completes with exit code 0",
                    ),
                    PlanStep(
                        id="verify_output",
                        action="Verify rendered video artifact exists on disk",
                        tool="bash_exec",
                        arguments={"command": "ls -lh *.mp4 brag-output/*.mp4 2>/dev/null || test -f bragv1.mp4"},
                        depends_on=["execute_render"],
                        success_criteria="Output video file exists on disk and is non-empty",
                    ),
                ],
            )

        # 2. Video rendering task
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
                        arguments={"command": "ls -lh *.mp4 2>/dev/null || test -f output.mp4"},
                        depends_on=["execute_render"],
                        success_criteria="Output video file exists on disk",
                    ),
                ],
            )

        # 3. Git repository operations
        if any(w in goal_lower for w in ["git", "clone", "repo", "repository"]) and any(w in goal_lower for w in ["clone", "pull", "fetch"]):
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
                        arguments={"command": "git log -n 1 --oneline"},
                        depends_on=["execute_git_action"],
                        success_criteria="Repository state confirmed",
                    ),
                ],
            )

        # 4. Code fix & testing task
        if any(w in goal_lower for w in ["fix", "bug", "issue", "error"]) and any(w in goal_lower for w in ["test", "repo", "code", "file"]):
            return StructuredPlan(
                goal=goal,
                steps=[
                    PlanStep(
                        id="inspect_code",
                        action="Inspect relevant files and error reproduction",
                        tool="bash_exec",
                        arguments={"command": "git status 2>/dev/null || ls"},
                        success_criteria="Code context inspected",
                    ),
                    PlanStep(
                        id="apply_fix",
                        action="Apply the code fix or modification",
                        depends_on=["inspect_code"],
                        success_criteria="Code changes applied",
                    ),
                    PlanStep(
                        id="verify_tests",
                        action="Execute unit tests to verify fix",
                        tool="bash_exec",
                        arguments={"command": "python -m unittest discover -s tests -v"},
                        depends_on=["apply_fix"],
                        success_criteria="Tests execute with 0 failures",
                    ),
                ],
            )

        # 5. Default universal two-step plan
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

    # Broadened to capture all action announcements: grab, dive, retrieve, research, prepare, etc.
    _ANNOUNCEMENT_PATTERNS = (
        re.compile(
            r"^\s*(?:okay[,! ]*)?(?:first[,! ]*)?let\s+me\s+"
            r"(?:check|inspect|look|verify|find|run|install|create|build|render|"
            r"test|search|open|read|fetch|analy[sz]e|review|grab|dive|retrieve|prepare|research)\b",
            re.IGNORECASE,
        ),
        re.compile(
            r"^\s*(?:first[,! ]*)?i(?:'ll|\s+will)\s+"
            r"(?:check|inspect|look|verify|find|run|install|create|build|render|"
            r"test|search|open|read|fetch|analy[sz]e|review|grab|dive|retrieve|prepare|research|now)\b",
            re.IGNORECASE,
        ),
        re.compile(
            r"^\s*(?:first[,! ]*)?(?:i am going to|i'm going to|i need to|i am preparing to|i'm preparing to)\s+"
            r"(?:check|inspect|look|verify|find|run|install|create|build|render|"
            r"test|search|open|read|fetch|analy[sz]e|review|grab|dive|retrieve|prepare|research)\b",
            re.IGNORECASE,
        ),
        re.compile(
            r"^\s*(?:the\s+next\s+step\s+is\s+to|first\s+i'll\s+retrieve|i\s+will\s+now\s+inspect|i'm\s+preparing\s+the\s+implementation)\b",
            re.IGNORECASE,
        ),
        re.compile(
            r"^\s*(?:checking|inspecting|fetching|installing|running|creating|"
            r"building|rendering|testing|searching|verifying|preparing|retrieving)\b[^\n]{0,240}$",
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
        opening = text[:360].strip()
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
    def plan_step_directive(
        plan: StructuredPlan,
        step: PlanStep,
        previous_response: str,
        attempt: int,
    ) -> str:
        """Directive injected to advance to a specific pending step in the structured plan."""
        completed = [s.id for s in plan.steps if s.status == "completed"]
        previous = re.sub(r"\s+", " ", previous_response or "").strip()[:200]
        tool_hint = f"Recommended tool: {step.tool}" if step.tool else "Select a relevant tool"
        return (
            f"[HERMES RUNTIME DECISION ENGINE] Plan Progress: "
            f"Completed steps: {completed or 'None'}. "
            f"Current pending step: [{step.id}] '{step.action}'. "
            f"Success criteria: {step.success_criteria or 'Execute the operation and verify its result'}. "
            f"{tool_hint}. "
            "Do not stop, defer to the user, or announce what you plan to do. "
            f"Execute the concrete tool call for step [{step.id}] immediately now. "
            f"Recovery attempt {attempt}.\n"
            f"Previous message: {previous}"
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


class AutonomousTaskController:
    """
    Authoritative controller for autonomous task execution.
    Decides whether a turn can terminate, must recover, or must execute deterministic steps.
    """

    def __init__(self, prompt: str, available_tools: Optional[Set[str]] = None):
        self.prompt = prompt
        self.task_id = f"task_{uuid.uuid4().hex[:8]}"
        self.classification = TaskClassifier.classify(prompt)
        self.state_machine = TaskStateMachine(TaskLifecycleState.NEW)
        self.available_tools = available_tools or set()

        # Initialize plan if action task
        self.plan: Optional[StructuredPlan] = None
        if self.classification.requires_tools:
            self.state_machine.transition(TaskLifecycleState.CLASSIFYING, "Classified as action task")
            self.state_machine.transition(TaskLifecycleState.PLANNING, "Generating plan")
            self.plan = StructuredPlanGenerator.generate_plan(prompt, self.available_tools)
            self.plan.task_id = self.task_id
            self.state_machine.transition(TaskLifecycleState.READY, "Plan generated and ready")
        else:
            self.state_machine.transition(TaskLifecycleState.CLASSIFYING, "Classified as conversational/informational")
            self.state_machine.transition(TaskLifecycleState.READY, "Ready for synthesis")

    def evaluate_model_turn(
        self,
        raw_text: str,
        has_tool_calls: bool,
        gathered_data_blocks: List[str],
        stall_attempts: int,
    ) -> ActionDecision:
        """
        Evaluate model output when no tool calls were emitted.
        Decides whether to execute deterministic step, inject directive, fallback model, or block.
        """
        # 1. Non-action tasks are complete
        if not self.classification.requires_tools:
            if self.state_machine.can_transition(TaskLifecycleState.COMPLETED):
                self.state_machine.transition(TaskLifecycleState.COMPLETED, "Informational task complete")
            return ActionDecision(kind="COMPLETE", is_terminal=True, rationale="Informational response complete")

        # 2. Check if goal is already fully verified
        verification = GoalVerifier.evaluate(self.prompt, gathered_data_blocks, raw_text)
        if verification.is_verified and (not self.plan or self.plan.is_complete):
            if self.state_machine.can_transition(TaskLifecycleState.VERIFYING):
                self.state_machine.transition(TaskLifecycleState.VERIFYING, "Goal verified with evidence")
            if self.state_machine.can_transition(TaskLifecycleState.COMPLETED):
                self.state_machine.transition(TaskLifecycleState.COMPLETED, "All steps verified")
            return ActionDecision(kind="COMPLETE", is_terminal=True, rationale="Task verified complete")

        # 3. Action task is incomplete: must transition to RECOVERING
        if self.state_machine.can_transition(TaskLifecycleState.RECOVERING):
            self.state_machine.transition(TaskLifecycleState.RECOVERING, "Incomplete action detected")

        # 4. Check for deterministic next ready step
        if self.plan and not self.plan.is_complete:
            next_step = self.plan.next_ready_step()
            if next_step and next_step.tool and next_step.arguments:
                # If the step provides explicit arguments (e.g. read_skill_documentation, inspect_env),
                # runtime can deterministically execute it directly!
                return ActionDecision(
                    kind="EXECUTE_DETERMINISTIC_STEP",
                    tool=next_step.tool,
                    arguments=next_step.arguments,
                    rationale=f"Executing plan step [{next_step.id}] '{next_step.action}'",
                )

        # 5. Check stall retry budget
        if stall_attempts < MAX_STALL_RETRIES:
            return ActionDecision(
                kind="RETRY_WITH_DIRECTIVE",
                rationale=f"Incomplete action; retry attempt {stall_attempts + 1}/{MAX_STALL_RETRIES}",
            )

        # 6. Retry exhausted on this model candidate -> trigger model fallback
        return ActionDecision(
            kind="FALLBACK_MODEL",
            rationale=f"Stall retry budget ({MAX_STALL_RETRIES}) exhausted on current model",
        )

    def mark_blocked(self, reason: str) -> None:
        """Mark task as legitimately blocked."""
        if self.state_machine.can_transition(TaskLifecycleState.BLOCKED):
            self.state_machine.transition(TaskLifecycleState.BLOCKED, reason)
        elif self.state_machine.can_transition(TaskLifecycleState.FAILED):
            self.state_machine.transition(TaskLifecycleState.FAILED, reason)

    def can_complete(self, final_text: str, gathered_data_blocks: List[str]) -> bool:
        """Strict invariant: action tasks MUST pass goal verification before completion."""
        if not self.classification.requires_tools:
            return True
        verification = GoalVerifier.evaluate(self.prompt, gathered_data_blocks, final_text)
        return verification.is_verified and (not self.plan or self.plan.is_complete)
