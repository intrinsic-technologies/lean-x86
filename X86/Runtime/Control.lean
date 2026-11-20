import Std
import X86.Runtime.BitsImpl

namespace X86.Runtime

-- Runtime faults and termination are distinct from source exceptions. An ISA
-- catch must not intercept a failed assertion or the end of execution.
inductive Error (exception : Type) where
  | assertionFailed
  | unmatchedCase
  | executionEnded (success : Bool)
  | uninitializedRead
  -- A malformed source operation consumed a value of the wrong type.
  | operandTypeMismatch
  | externalFailure (message : String)
  | raised (value : exception)
  deriving Repr, DecidableEq

/-- An operation carrying state and failures, including source exceptions. -/
abbrev SpecM (exception σ α : Type) := ExceptT (Error exception) (StateM σ) α

/-- Preserve runtime failures while widening an empty source-exception type. -/
def Error.widen {exception : Type} : Error Empty → Error exception
  | .raised impossible => nomatch impossible
  | .assertionFailed => .assertionFailed
  | .unmatchedCase => .unmatchedCase
  | .executionEnded success => .executionEnded success
  | .uninitializedRead => .uninitializedRead
  | .operandTypeMismatch => .operandTypeMismatch
  | .externalFailure message => .externalFailure message

-- A pure helper without source exceptions can be used by a caller with them.
instance {exception : Type} : MonadLift (Except (Error Empty)) (Except (Error exception)) where
  monadLift := Except.mapError Error.widen

@[simp] theorem lift_no_source_exception_ok {exception α : Type} (value : α) :
    (liftM (.ok value : Except (Error Empty) α) : Except (Error exception) α) = .ok value := rfl

-- A binding without source exceptions can still report a runtime failure.
-- Widen only that error channel; no architectural raise exists.
@[inline]
def liftNoSourceException {exception σ α : Type} (action : SpecM Empty σ α) : SpecM exception σ α :=
  ExceptT.adapt Error.widen action

@[inline]
def assert {exception : Type} [Monad m] [MonadExcept (Error exception) m] (condition : Bool) : m Unit :=
  unless condition do throw Error.assertionFailed

-- Retain the successful source check as erased evidence for dependent types.
@[inline]
def assertWithProof {exception : Type} [Monad m] [MonadExcept (Error exception) m]
    (condition : Bool) : m (PLift (condition = true)) :=
  if passed : condition = true then pure ⟨passed⟩ else throw .assertionFailed

-- Evaluate a pure source action once and retain its result equation as evidence.
def remember {ε α : Type} (action : Except ε α) :
    Except ε { value : α // action = .ok value } :=
  match action with
  | .ok value => .ok ⟨value, rfl⟩
  | .error error => .error error

-- Arguments are evaluated before the source operation reports its type error.
def invalidOperands {exception arguments result : Type} [Monad m]
    [MonadExcept (Error exception) m] (_values : arguments) : m result :=
  throw .operandTypeMismatch

-- Diagnostic output is an observable host effect, separate from machine RAM.
class HasDiagnostics (σ : Type) where
  output : σ → String
  withOutput : σ → String → σ

def print {exception σ : Type} [HasDiagnostics σ]
    (text : String) : SpecM exception σ Unit :=
  modify fun state => HasDiagnostics.withOutput state (HasDiagnostics.output state ++ text)

-- Source events are stored in reverse order so appending an event is constant time.
class HasTrace (σ : Type) where
  eventsRev : σ → List (String × String)
  withEventsRev : σ → List (String × String) → σ

/-- Record one source event without changing architectural memory or unspecified choices. -/
def traceEvent {exception σ : Type} [HasTrace σ]
    (channel message : String) : SpecM exception σ Unit :=
  modify fun state => HasTrace.withEventsRev state
    ((channel, message) :: HasTrace.eventsRev state)

/-- Observe source events in the order in which they occurred. -/
def traceEvents {σ : Type} [HasTrace σ] (state : σ) : List (String × String) :=
  (HasTrace.eventsRev state).reverse

-- Both statuses stop execution. ISA exception handlers cannot intercept them.
def endExecution {exception α : Type} [Monad m] [MonadExcept (Error exception) m]
    (success : Bool) : m α := throw (.executionEnded success)

/-- Report an external failure without entering the source-exception channel. -/
def externalFailure {exception α : Type} [Monad m] [MonadExcept (Error exception) m]
    (message : String) : m α := throw (.externalFailure message)

-- Keep the enabling condition as erased evidence for a recursive decrease proof.
-- The action runs only when enabled, exactly as in the source conditional.
def guardedBool [Monad m] (condition : Bool) (action : Unit → m Bool) :
    m { value : Bool // value = true → condition = true } := do
  if enabled : condition then
    return ⟨← action (), fun _ => enabled⟩
  else
    return ⟨false, by simp⟩

end X86.Runtime
