import unittest

from hermes_core.decision_engine import (
    ActionDecision,
    AutonomyPolicy,
    GoalVerifier,
    PlanStep,
    StructuredPlan,
    StructuredPlanGenerator,
    AutonomousTaskController,
    TaskLifecycleState,
    TaskStateMachine,
    InvalidStateTransition,
    TaskClassifier,
    TaskCategory,
)
from hermes_core.tools.skill_tools import list_skills, read_skill_documentation


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

    def test_goal_verifier_flags_inspection_only_as_unverified(self):
        goal = "Create a video from clips and render it to output.mp4"
        evidence = ["[bash_exec (python -c 'import moviepy; print(moviepy.__version__)')]:\n1.0.3"]
        raw_text = "MoviePy 1.0.3 is installed on your system."
        res = GoalVerifier.evaluate(goal, evidence, raw_text)
        self.assertFalse(res.is_verified)
        self.assertIn("preparatory inspection", res.missing_aspect)

    def test_goal_verifier_flags_transition_intent(self):
        goal = "Create a video from clips and render it to output.mp4"
        evidence = ["[bash_exec (python -c 'import moviepy')]:\n1.0.3"]
        raw_text = "Next I will create the rendering script and generate the video."
        res = GoalVerifier.evaluate(goal, evidence, raw_text)
        self.assertFalse(res.is_verified)
        self.assertIn("announced the next concrete step", res.missing_aspect)

    def test_goal_verifier_approves_when_rendering_succeeded(self):
        goal = "Create a video from clips and render it to output.mp4"
        evidence = [
            "[bash_exec (python -c 'import moviepy')]:\n1.0.3",
            "[bash_exec (python render.py)]:\nRendering video...\nVideo successfully rendered to output.mp4\nexit code: 0",
        ]
        raw_text = "The video has been rendered and verified successfully at output.mp4."
        res = GoalVerifier.evaluate(goal, evidence, raw_text)
        self.assertTrue(res.is_verified)

    def test_goal_verifier_approves_informational_task(self):
        res = GoalVerifier.evaluate("What is MoviePy?", [], "MoviePy is a library.")
        self.assertTrue(res.is_verified)

    def test_goal_verifier_rejects_operational_command_without_success_evidence(self):
        goal = "Create a video from clips and render it to output.mp4"
        evidence = [
            "[bash_exec (python render.py)]:\\nRendering started, waiting...",
        ]
        res = GoalVerifier.evaluate(goal, evidence, "The render command was started.")
        self.assertFalse(res.is_verified)
        self.assertIn("clear evidence of success", res.missing_aspect)

    def test_structured_plan_generator_for_video(self):
        plan = StructuredPlanGenerator.generate_plan("Create a video with MoviePy")
        step_ids = [s.id for s in plan.steps]
        self.assertEqual(step_ids, ["inspect_env", "execute_render", "verify_output"])
        self.assertIn("inspect_env", plan.steps[1].depends_on)

    def test_partial_goal_directive_formatting(self):
        directive = AutonomyPolicy.partial_goal_directive(
            prompt="Build a video",
            gathered_data_blocks=["[bash_exec (python -V)]:\nPython 3.11.9"],
            previous_response="I checked Python.",
            missing_aspect="Core creation step not executed",
            attempt=1,
        )
        self.assertIn("Status: Core creation step not executed", directive)
        self.assertIn("Original goal: Build a video", directive)
        self.assertIn("Recovery attempt 1", directive)


    def test_structured_plan_advance_with_evidence_and_completion(self):
        plan = StructuredPlanGenerator.generate_plan("Create a video with MoviePy and render it")
        self.assertEqual(plan.next_ready_step().id, "inspect_env")

        # Step 1: inspect
        s1 = plan.advance_with_evidence("bash_exec", {"command": "python3 -c 'import moviepy'"}, "1.0.3")
        self.assertIsNotNone(s1)
        self.assertEqual(s1.status, "completed")
        self.assertEqual(plan.next_ready_step().id, "execute_render")

        # Step 2: render
        s2 = plan.advance_with_evidence("bash_exec", {"command": "python render.py"}, "Rendering complete exit code: 0")
        self.assertIsNotNone(s2)
        self.assertEqual(s2.status, "completed")
        self.assertEqual(plan.next_ready_step().id, "verify_output")

        # Step 3: verify output
        s3 = plan.advance_with_evidence("bash_exec", {"command": "ls -l output.mp4"}, "output.mp4 14MB")
        self.assertIsNotNone(s3)
        self.assertEqual(s3.status, "completed")
        self.assertTrue(plan.is_complete)
        self.assertIsNone(plan.next_ready_step())

    def test_structured_plan_serialization(self):
        plan = StructuredPlanGenerator.generate_plan("Clone repo and test")
        d = plan.to_dict()
        self.assertEqual(d["goal"], "Clone repo and test")
        self.assertTrue(len(d["steps"]) >= 2)
        restored = StructuredPlan.from_dict(d)
        self.assertEqual(restored.goal, plan.goal)
        self.assertEqual(len(restored.steps), len(plan.steps))
        self.assertEqual(restored.steps[0].id, plan.steps[0].id)

    def test_plan_step_directive_formatting(self):
        plan = StructuredPlanGenerator.generate_plan("Create a video")
        step = plan.next_ready_step()
        directive = AutonomyPolicy.plan_step_directive(
            plan=plan,
            step=step,
            previous_response="I will check environment",
            attempt=1,
        )
        self.assertIn("[inspect_env]", directive)
        self.assertIn("Inspect Python & MoviePy environment", directive)
        self.assertIn("Recovery attempt 1", directive)


    def test_advance_with_evidence_rejects_unrelated_command(self):
        plan = StructuredPlanGenerator.generate_plan("Create a video with MoviePy")
        # Step 1: complete inspect_env
        plan.advance_with_evidence("bash_exec", {"command": "python3 -c 'import moviepy'"}, "1.0.3")
        self.assertEqual(plan.next_ready_step().id, "execute_render")

        # Attempt to satisfy execute_render with a harmless whoami or ls command
        res = plan.advance_with_evidence("bash_exec", {"command": "whoami"}, "root")
        self.assertIsNone(res)
        self.assertEqual(plan.next_ready_step().id, "execute_render")
        self.assertEqual(plan.next_ready_step().status, "pending")

    def test_advance_with_evidence_rejects_inspection_command_for_render(self):
        plan = StructuredPlanGenerator.generate_plan("Create a video with MoviePy")
        plan.advance_with_evidence("bash_exec", {"command": "python3 -c 'import moviepy'"}, "1.0.3")
        self.assertEqual(plan.next_ready_step().id, "execute_render")

        # Repeating an import check should NOT advance execute_render
        res = plan.advance_with_evidence("bash_exec", {"command": "python -c 'import moviepy'"}, "1.0.3")
        self.assertIsNone(res)
        self.assertEqual(plan.next_ready_step().id, "execute_render")
        self.assertEqual(plan.next_ready_step().status, "pending")

    def test_advance_with_evidence_detects_exit_code_failure(self):
        plan = StructuredPlanGenerator.generate_plan("Create a video with MoviePy")
        plan.advance_with_evidence("bash_exec", {"command": "python3 -c 'import moviepy'"}, "1.0.3")
        self.assertEqual(plan.next_ready_step().id, "execute_render")

        # Render command fails with exit code 1
        res = plan.advance_with_evidence("bash_exec", {"command": "python render.py"}, "Traceback: Render failed\n[EXIT CODE: 1]")
        self.assertIsNotNone(res)
        self.assertEqual(res.status, "failed")
        self.assertIn("failed", res.evidence)

    def test_advance_with_evidence_detects_missing_artifact_in_verification(self):
        plan = StructuredPlanGenerator.generate_plan("Create a video with MoviePy")
        plan.advance_with_evidence("bash_exec", {"command": "python3 -c 'import moviepy'"}, "1.0.3")
        plan.advance_with_evidence("bash_exec", {"command": "python render.py"}, "Rendering complete exit code: 0")
        self.assertEqual(plan.next_ready_step().id, "verify_output")

        # Verify command output states file does not exist
        res = plan.advance_with_evidence("bash_exec", {"command": "ls -l output.mp4"}, "ls: cannot access 'output.mp4': No such file or directory")
        self.assertIsNotNone(res)
        self.assertEqual(res.status, "failed")
        self.assertFalse(plan.is_complete)


    def test_state_machine_valid_and_invalid_transitions(self):
        sm = TaskStateMachine(TaskLifecycleState.NEW)
        self.assertEqual(sm.state, TaskLifecycleState.NEW)
        sm.transition(TaskLifecycleState.CLASSIFYING, "Classifying prompt")
        sm.transition(TaskLifecycleState.PLANNING, "Generating plan")
        sm.transition(TaskLifecycleState.READY, "Plan ready")
        sm.transition(TaskLifecycleState.EXECUTING, "Model executing")
        sm.transition(TaskLifecycleState.VERIFYING, "Checking proof")
        sm.transition(TaskLifecycleState.COMPLETED, "Verified complete")
        self.assertEqual(sm.state, TaskLifecycleState.COMPLETED)

        # Transitioning out of terminal state must raise InvalidStateTransition
        with self.assertRaises(InvalidStateTransition):
            sm.transition(TaskLifecycleState.READY)

    def test_task_controller_stalled_announcement_triggers_deterministic_step(self):
        prompt = "Build a launch video for SmartWatt using the brag skill"
        available_tools = {"read_skill_documentation", "list_directory", "bash_exec"}
        controller = AutonomousTaskController(prompt, available_tools)

        self.assertEqual(controller.classification.category, TaskCategory.ACTION_EXECUTION)
        self.assertIsNotNone(controller.plan)
        first_step = controller.plan.next_ready_step()
        self.assertEqual(first_step.id, "discover_skill")

        # Model stalls with announcement instead of tool call
        announcement = "Let me grab the brag skill references and then dive straight into building the SmartWatt video!"
        decision = controller.evaluate_model_turn(
            raw_text=announcement,
            has_tool_calls=False,
            gathered_data_blocks=[],
            stall_attempts=0,
        )

        self.assertEqual(decision.kind, "EXECUTE_DETERMINISTIC_STEP")
        self.assertEqual(decision.tool, "read_skill_documentation")
        self.assertEqual(decision.arguments, {"skill_name": "brag"})

    def test_task_controller_recovers_with_directive_when_step_has_no_fixed_arguments(self):
        prompt = "Build a launch video for SmartWatt using the brag skill"
        controller = AutonomousTaskController(prompt, {"bash_exec", "read_skill_documentation", "list_directory"})

        # Satisfy steps 1 & 2
        controller.plan.advance_with_evidence("read_skill_documentation", {"skill_name": "brag"}, "Skill instructions loaded")
        controller.plan.advance_with_evidence("list_directory", {"path": "."}, "file1.png\nfile2.mp4")
        self.assertEqual(controller.plan.next_ready_step().id, "execute_render")

        # Model stalls on render step without tool call
        announcement = "Now I will create the rendering script and generate the video."
        decision = controller.evaluate_model_turn(
            raw_text=announcement,
            has_tool_calls=False,
            gathered_data_blocks=["Skill loaded", "Files inspected"],
            stall_attempts=0,
        )

        self.assertEqual(decision.kind, "RETRY_WITH_DIRECTIVE")
        directive = AutonomyPolicy.plan_step_directive(
            controller.plan,
            controller.plan.next_ready_step(),
            announcement,
            attempt=1,
        )
        self.assertIn("execute_render", directive)
        self.assertIn("Recovery attempt 1", directive)

    def test_task_controller_fallback_model_on_stall_exhaustion(self):
        prompt = "Create a video from clips and render it to output.mp4"
        controller = AutonomousTaskController(prompt, {"bash_exec"})
        # Complete environment check
        controller.plan.advance_with_evidence("bash_exec", {"command": "python -c 'import moviepy'"}, "1.0.3")

        # Stall attempts reaches max retries (2)
        decision = controller.evaluate_model_turn(
            raw_text="Let me check the video clips next.",
            has_tool_calls=False,
            gathered_data_blocks=["[bash_exec (python -c 'import moviepy')]:\n1.0.3"],
            stall_attempts=2,
        )
        self.assertEqual(decision.kind, "FALLBACK_MODEL")

    def test_stage2_synthesis_gatekeeper_blocks_unverified_action_task(self):
        prompt = "Render a promotional video to promo.mp4"
        controller = AutonomousTaskController(prompt, {"bash_exec"})
        evidence = ["[bash_exec (python -c 'import moviepy')]:\n1.0.3"]
        final_text = "MoviePy 1.0.3 is installed."

        # Even if model produced text, cannot complete because goal is not verified
        self.assertFalse(controller.can_complete(final_text, evidence))

    def test_informational_query_allowed_to_complete_without_tools(self):
        prompt = "What is MoviePy and how does it compare to ffmpeg?"
        controller = AutonomousTaskController(prompt, set())
        self.assertEqual(controller.classification.category, TaskCategory.INFORMATIONAL)
        self.assertFalse(controller.classification.requires_tools)

        final_text = "MoviePy is an open-source Python library for video editing."
        self.assertTrue(controller.can_complete(final_text, []))

        decision = controller.evaluate_model_turn(final_text, has_tool_calls=False, gathered_data_blocks=[], stall_attempts=0)
        self.assertEqual(decision.kind, "COMPLETE")

    def test_video_task_artifacts_staging_in_plan(self):
        plan = StructuredPlanGenerator.generate_plan("Run brag on smartwatt and generate 30 second video and give me download link")
        verify_step = next((s for s in plan.steps if s.id == "verify_output"), None)
        self.assertIsNotNone(verify_step)
        self.assertIn("artifacts/videos", verify_step.arguments["command"])

    def test_video_goal_verifier_approves_when_artifact_confirmed(self):
        evidence = [
            "[bash_exec (which moviepy)]:\nexit code: 1",  # Intermediate error
            "[bash_exec (python3 generate_video.py)]:\nRendering complete\n[EXIT CODE: 0]",
            "[bash_exec (ls -lh artifacts/videos/*.mp4)]:\n-rw-r--r-- 1 root root 362K Oct 21 17:43 artifacts/videos/smartwatt_promo.mp4"
        ]
        res = GoalVerifier.evaluate("generate video for smartwatt", evidence, "Here is your video download link: [Download](https://jishnupg-hermes.hf.space/artifacts/videos/smartwatt_promo.mp4)")
        self.assertTrue(res.is_verified)
        self.assertIn("Video artifact verified on disk", res.evidence_summary)

    def test_advance_with_evidence_tolerates_wildcard_misses_if_artifact_confirmed(self):
        plan = StructuredPlanGenerator.generate_plan("Render video")
        plan.steps[0].status = "completed"
        plan.steps[1].status = "completed"
        self.assertEqual(plan.next_ready_step().id, "verify_output")
        # Output contains wildcard warning AND actual confirmed artifact file with size
        tool_output = "ls: cannot access '*.mp4': No such file or directory\n-rw-r--r-- 1 root root 362K Oct 21 17:43 brag-output/smartwatt_promo.mp4"
        res = plan.advance_with_evidence("bash_exec", {"command": "ls -lh *.mp4 brag-output/*.mp4"}, tool_output)
        self.assertIsNotNone(res)
        self.assertEqual(res.status, "completed")

    def test_skill_tools_discovery_and_reading(self):
        import asyncio
        skills_output = asyncio.run(list_skills())
        self.assertIn("brag", skills_output)
        doc = asyncio.run(read_skill_documentation("brag"))
        self.assertIn("SKILL.md", doc)
        self.assertIn("video", doc.lower())


if __name__ == "__main__":
    unittest.main()
