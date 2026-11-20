import X86.Runtime.Divergence

namespace Prelude.Bindings

/-- A read-only helper's precondition and required successful results. -/
structure Contract (State Input Output : Type) where
  pre : State → Input → Prop
  post : State → Input → Output → Prop

namespace Contract

/-- Total correctness for read-only helpers: divergence and failures are
forbidden on admitted inputs. Total computations lift from `Id` to `Option`. -/
def Satisfies {State Input Output ε : Type} {m : Type → Type}
    [MonadLiftT m Option]
    (contract : Contract State Input Output)
    (implementation : Input → ReaderT State (ExceptT (X86.Runtime.Error ε) m) Output) : Prop :=
  ∀ input state, contract.pre state input →
    match (monadLift ((implementation input state).run) :
        Option (Except (X86.Runtime.Error ε) Output)) with
    | some (.ok output) => contract.post state input output
    | some (.error _) | none => False

end Contract

end Prelude.Bindings
