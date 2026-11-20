import X86.UserProcess.RunResult
import X86.UserProcess.Profile
import X86.Machine.Step

namespace X86.UserProcess.Runner

open X86.Syntax

variable {σ : Type}

/--
Observe a completed user-to-kernel transition at a registered OS entry.

- The incoming CPL is three; the resulting CPL is zero.
- The resulting RIP and CS selector match the supplied boundary.
- A match identifies the entry reached, not which instruction caused it.
-/
def matchesOSEntry (entry : OSEntryBoundary) (before after : X86.State σ) : Bool :=
  before.CPL == 3 && after.CPL == 0 && after.RIP == entry.rip && after.CS.selector == entry.cs

/--
Stop a successful transition at the registered OS entry, retaining its exact state.

- OS entry takes priority over function-return classification.
- Failure, source termination and an already reached OS entry retain their outcomes.
-/
def observeOSEntry (entry : OSEntryBoundary) (before : X86.State σ)
    (result : RunStepResult σ) : RunStepResult σ :=
  match result with
  | .next after | .returned after =>
      if matchesOSEntry entry before after then .reachedOSEntry entry after else result
  | .ended _ _ | .failed _ | .reachedOSEntry _ _ => result

variable [Machine.Bindings] [Machine.PhysicalMemory σ]

open X86.Machine.Hardware in
/--
Execute one machine step and classify a return to the caller.

- A successful step returns when RIP and RSP match the boundary.
- A step error becomes a semantics failure with the state at that point.
- The step runs `accelerators state`, Intel's helper bodies by default.
-/
def step (boundary : ReturnBoundary) (state : X86.State σ)
    (accelerators : X86.State σ → Machine.Accelerators (σ := σ) inferInstance inferInstance :=
      fun _ => {}) :
    Option (RunStepResult σ) :=
  (Machine.step state (accelerators := accelerators state)).map fun
    | .next after =>
        if after.RIP == boundary.rip && after.GPR[Reg.rsp.fin.val] == boundary.rsp then
          .returned after
        else .next after
    | .ended success after => .ended success after
    | .failed reason after => .failed ⟨.semantics reason, after⟩

/--
Run Intel steps with a finite budget.

- Fuel counts completed Intel steps, which can handle events or halted states
  without executing an instruction.
- The budget limits completed steps, not time spent inside one step.
- Generated helpers fetch code from physical RAM. There is no separate code image
  or intercepted binding contract.
- The caller's `Bindings` stay the same throughout this run.
-/
def run (boundary : ReturnBoundary) : Nat → X86.State σ → Option (RunResult σ) :=
  runSteps (step boundary)

open X86.Machine.Hardware in
/-- Execute one generated step and observe its completed OS-entry transition. -/
def stepToOSEntry (entry : OSEntryBoundary) (boundary : ReturnBoundary)
    (state : X86.State σ)
    (accelerators : X86.State σ → Machine.Accelerators (σ := σ) inferInstance inferInstance :=
      fun _ => {}) :
    Option (RunStepResult σ) :=
  (step boundary state accelerators).map (observeOSEntry entry state)

/--
Run generated Intel steps until OS entry, function return or another terminal outcome.

- The registered entry is checked after each completed successful step.
- Reaching the entry retains the complete transition state and stops before the handler runs.
- Fuel counts source steps. Zero fuel executes nothing; divergence stays `none`.
- This runner supplies no OS service or return from the kernel.
-/
def runToOSEntry (entry : OSEntryBoundary) (boundary : ReturnBoundary) :
    Nat → X86.State σ → Option (RunResult σ) :=
  runSteps (stepToOSEntry entry boundary)

end X86.UserProcess.Runner
