import X86.Machine.State
import X86.UserProcess.IdentityMap

namespace X86.UserProcess

open X86.Machine

inductive Error where
  | operand (fault : Fault)
  | semantics (error : X86.Runtime.Error X86.Exception)
  | outsideIdentityMapping
  | identityMap (error : IdentityMap.Error)
  deriving Repr

/--
State remains observable after either a result or an error. In particular,
page-table updates and oracle draws preceding a source exception are retained.
-/
abbrev Action (α : Type) := ExceptT Error (StateM Machine.RamState) α

def liftSource {α : Type} (action : X86.Runtime.SpecM X86.Exception Machine.RamState α) : Action α :=
  ExceptT.adapt Error.semantics action

/-- The complete architectural state at the failure boundary. -/
structure Failure (σ : Type := Machine.Ram) where
  reason : Error
  state : X86.State σ

instance {σ : Type} : Repr (Failure σ) where
  reprPrec failure precedence := reprPrec failure.reason precedence

end X86.UserProcess
