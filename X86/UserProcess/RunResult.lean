import X86.UserProcess.Error

namespace X86.UserProcess

/--
The caller's continuation address and expected stack pointer on return.
The caller supplies both values; the runner does not inspect guest stack memory.
-/
structure ReturnBoundary where
  rip : BitVec 64
  rsp : BitVec 64
  deriving DecidableEq

/-- A registered operating-system entry address and code-segment selector. -/
structure OSEntryBoundary where
  rip : BitVec 64
  cs : BitVec 16
  deriving DecidableEq

inductive RunStepResult (σ : Type := Machine.Ram) where
  | next (state : X86.State σ)
  | returned (state : X86.State σ)
  /-- The source explicitly ended execution; this is not a function return. -/
  | ended (success : Bool) (state : X86.State σ)
  | failed (failure : Failure σ)
  /-- Execution reached the registered OS entry; the transition state is retained. -/
  | reachedOSEntry (entry : OSEntryBoundary) (state : X86.State σ)

inductive RunResult (σ : Type := Machine.Ram) where
  | returned (state : X86.State σ)
  /-- The source explicitly ended execution; this is not a function return. -/
  | ended (success : Bool) (state : X86.State σ)
  | failed (failure : Failure σ)
  /-- The completed-step budget is exhausted. This does not time out a running step. -/
  | outOfFuel (state : X86.State σ)
  /-- Execution reached the registered OS entry; the transition state is retained. -/
  | reachedOSEntry (entry : OSEntryBoundary) (state : X86.State σ)

/--
Run a supplied transition, retaining termination, failure and exhaustion as
separate outcomes. `none` propagates divergence inside a transition.
-/
def runSteps {σ : Type} (transition : X86.State σ → Option (RunStepResult σ)) :
    Nat → X86.State σ → Option (RunResult σ)
  | 0, state => some (.outOfFuel state)
  | fuel + 1, state => do
    match ← transition state with
    | .next after => runSteps transition fuel after
    | .returned final => pure (.returned final)
    | .ended success final => pure (.ended success final)
    | .failed failure => pure (.failed failure)
    | .reachedOSEntry entry after => pure (.reachedOSEntry entry after)

end X86.UserProcess
