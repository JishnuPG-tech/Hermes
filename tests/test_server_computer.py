import asyncio
from harness.computer.project_registry import ProjectRegistry
from harness.computer.workspace_manager import WorkspaceManager
from harness.computer.verification_engine import VerificationEngine
from harness.computer.models import VerificationContract
from hermes_core.tools.registry import registry
from gateway.main import app

print("--- Test 1: Project Registry ---")
reg = ProjectRegistry()
p = reg.register_project(
    project_id="hermes-x",
    name="Hermes Agent OS",
    github_repo="JishnuPG-tech/Hermes-x",
    default_branch="main",
    description="Authoritative autonomous personal AI agent computer"
)
assert p.project_id == "hermes-x"
assert reg.get_project("hermes-x") is not None
print("Project registered:", p.name, "at", p.path)

print("\n--- Test 2: Workspace Manager ---")
wm = WorkspaceManager(registry=reg)

async def test_ws():
    info = await wm.provision_workspace(task_id="test_task_1", project_id="hermes-x")
    assert info.task_id == "test_task_1"
    print("Workspace provisioned:", info.path)
    
    print("\n--- Test 3: Verification Engine ---")
    ve = VerificationEngine()
    contract = VerificationContract(commands=["python -c \"print('Verification Passed!')\""])
    res = await ve.verify_workspace(info.path, contract)
    assert res.passed, "Verification should pass"
    print("Verification status:", res.summary)
    for cr in res.command_results:
        print("  Command:", cr["command"], "Passed:", cr["passed"], "Output:", cr["stdout_tail"].strip())

asyncio.run(test_ws())

print("\n--- Test 4: Registry Tools ---")
comp_tools = [t for t in registry._tools if "computer_" in t]
print("Registered Computer Tools:", comp_tools)
assert len(comp_tools) >= 5

print("\nAll Server Computer local tests PASSED!")
