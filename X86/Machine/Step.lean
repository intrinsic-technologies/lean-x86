import X86.Machine.State
import X86.Machine.Hardware
import X86.Helpers.Step

namespace X86.Machine

/-- The outcome of one completed machine step. -/
inductive StepResult (σ : Type) where
  | next (state : X86.State σ)
  /-- The source explicitly ended execution. -/
  | ended (success : Bool) (state : X86.State σ)
  /-- An error escaped the source handler; the state at that point is retained. -/
  | failed (reason : X86.Runtime.Error X86.Exception) (state : X86.State σ)

variable [Bindings] {σ : Type} [PhysicalMemory σ]

/-- The accelerated helpers the step runs, with `translation` and `events`: Intel's bodies by
default, or implementations proved equal to them. -/
structure Accelerators (translation : X86.Helpers.Translate_Linear_To_Physical.Semantics σ)
    (events : X86.Helpers.Handle_Vectored_Event.Semantics σ) where
  fetch : letI := translation; X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ)) := ⟨_, rfl⟩
  debugTraps : X86.Accelerate (X86.Helpers.Check_Debug_Traps.source (σ := σ)) := ⟨_, rfl⟩
  asynchronousEvent : letI := translation; letI := events
    X86.Accelerate (X86.Helpers.Handle_Asynchronous_Event.source (σ := σ)) := ⟨_, rfl⟩

/--
Execute the generated step, including event handling, fetch and exceptions.
Local source patches retain the current debug cause for exception delivery.

- `none` represents a step that does not finish in the formal model.
  Running it can continue indefinitely; this function does not detect that case.
- Only errors that escape the source handler become failures.
- Explicit source termination has its own outcome. The final state remains
  available after either failure or termination.
- The caller supplies the bodyless Intel helpers. An IO driver can supply
  a new binding for each step.
- Translation and event delivery default to the generated hardware implementations.
  A userspace VM supplies its logical-memory and fault handlers explicitly.
- Accelerated helpers default to Intel's bodies; other implementations must be proved equal.
-/
@[noinline, nospecialize]
def step (state : X86.State σ)
    (translation : X86.Helpers.Translate_Linear_To_Physical.Semantics σ :=
      X86.Helpers.Translate_Linear_To_Physical.defaultSemantics)
    (events : X86.Helpers.Handle_Vectored_Event.Semantics σ :=
      letI := translation
      X86.Helpers.Handle_Vectored_Event.defaultSemantics)
    (accelerators : Accelerators translation events := {}) : Option (StepResult σ) :=
  letI := translation
  letI := events
  letI := accelerators.fetch
  letI := accelerators.debugTraps
  letI := accelerators.asynchronousEvent
  letI := Bindings.cpuidBinding (σ := σ)
  letI := Bindings.numerical (σ := σ)
  letI := Bindings.remainderReduction (σ := σ)
  letI := Bindings.fxsave (σ := σ)
  letI := Bindings.compareMemory (σ := σ)
  letI := Bindings.stackReturn (σ := σ)
  letI := Bindings.memoryType
  letI := Bindings.cacheControlBinding (σ := σ)
  letI := Bindings.invalidateAllTranslations (σ := σ)
  letI := Bindings.msrReadAllowedFallback (σ := σ)
  letI := Bindings.msrWriteAllowedFallback (σ := σ)
  letI := Bindings.msrReadFallback (σ := σ)
  letI := Bindings.msrWriteBehaviorFallback (σ := σ)
  letI := Bindings.msrCommitFallback (σ := σ)
  letI := Bindings.portRead (σ := σ)
  letI := Bindings.portWrite (σ := σ)
  letI := Bindings.invalidateTranslations (σ := σ)
  letI := Bindings.cacheInvalidate (σ := σ)
  letI := Bindings.cacheFlush (σ := σ)
  letI := Bindings.cacheWriteback (σ := σ)
  letI := Bindings.prefetch (σ := σ)
  letI := Bindings.stringStride (σ := σ)
  letI := Bindings.timestamp (σ := σ)
  letI := Bindings.daz16 (σ := σ)
  letI := Bindings.ftz16 (σ := σ)
  (X86.Helpers.Step.run state).map fun (result, after) =>
    match result with
    | .error (.executionEnded success) => .ended success after
    | .error reason => .failed reason after
    | .ok () => .next after

end X86.Machine
