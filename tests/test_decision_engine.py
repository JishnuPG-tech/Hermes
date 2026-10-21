import unittest

from hermes_core.decision_engine import (
    ActionDecision,
    AutonomyPolicy,
    PlanStep,
    StructuredPlan,
)


class AutonomyPolicyTests(unittest.TestCase):
    def test_build_video_is_action_oriented(self):
        self.assertTrue(
            AutonomyPolicy.is_action_oriented_task(
                "Create a video from the clips in this workspace and render it"
            )
        )

    def test_informational_moviepy_question_is_not_action_oriented(self):
        self.assertFalse(
            AutonomyPolicy.is_action_oriented_task(
                "What is MoviePy, and how do I install it?"
            )
        )

    def test_creative_text_request_does_not_require_tools(self):
        self.assertFalse(
            AutonomyPolicy.is_action_oriented_task("Create a poem about the rain")
        )

    def test_moviepy_announcement_is_unfulfilled_without_tool_call(self):
        response = (
            "Let me check which MoviePy version we have and build the video accordingly!"
        )
        self.assertTrue(
            AutonomyPolicy.is_unfulfilled_action_announcement(
                response, has_tool_calls=False
            )
        )

    def test_announcement_is_not_unfulfilled_if_tool_was_called(self):
        self.assertFalse(
            AutonomyPolicy.is_unfulfilled_action_announcement(
                "Let me check which MoviePy version we have",
                has_tool_calls=True,
            )
        )

    def test_normal_explanation_does_not_trigger_announcement(self):
        self.assertFalse(
            AutonomyPolicy.is_unfulfilled_action_announcement(
                "MoviePy is a Python library for video editing.", has_tool_calls=False
            )
        )

    def test_recovery_directive_preserves_goal(self):
        directive = AutonomyPolicy.recovery_directive(
            "Create a video", "Let me check MoviePy", attempt=1
        )
        self.assertIn("Original goal: Create a video", directive)
        self.assertIn("Recovery attempt 1", directive)

    def test_structured_plan_respects_dependencies(self):
        first = PlanStep(
            id="inspect",
            action="Inspect dependencies",
            status="completed",
            evidence="MoviePy version recorded",
        )
        second = PlanStep(
            id="render",
            action="Render video",
            depends_on=["inspect"],
        )
        plan = StructuredPlan(
            goal="Create a video",
            steps=[first, second],
        )
        self.assertIs(plan.next_ready_step(), second)
        self.assertFalse(plan.is_complete)
        second.status = "completed"
        self.assertTrue(plan.is_complete)

    def test_action_decision_schema(self):
        decision = ActionDecision(
            kind="EXECUTE_TOOL",
            reason="The next plan step requires environment inspection.",
            tool="bash_exec",
            arguments={"command": "python -V"},
        )
        self.assertEqual(decision.kind, "EXECUTE_TOOL")
        self.assertEqual(decision.arguments["command"], "python -V")


if __name__ == "__main__":
    unittest.main()
