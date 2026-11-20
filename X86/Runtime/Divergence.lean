import X86.Runtime.Control
import Init.Internal.Order.Basic

namespace X86.Runtime

-- None represents nontermination in the formal model. Running such a computation
-- can continue indefinitely; this representation does not detect nontermination.
-- Returning and faulting executions retain their final state.
abbrev PartialResult (exception α : Type) := ExceptT (Error exception) Option α

abbrev PartialSpecM (exception σ α : Type) := ExceptT (Error exception) (StateT σ Option) α

-- Total operations embed without changing their result, fault or state.
@[inline]
def liftTotal {exception σ α : Type} (action : SpecM exception σ α) : PartialSpecM exception σ α :=
  fun state => some (action.run state)

instance {exception σ : Type} : MonadLift (SpecM exception σ) (PartialSpecM exception σ) where
  monadLift := liftTotal

/-- Widen the source-exception type without changing divergence, faults or state. -/
@[inline]
def liftPartialNoSourceException {exception σ α : Type}
    (action : PartialSpecM Empty σ α) : PartialSpecM exception σ α :=
  ExceptT.adapt Error.widen action

instance {exception : Type} : MonadLift (PartialResult Empty) (PartialResult exception) where
  monadLift := ExceptT.adapt Error.widen

open Lean.Order

-- Exception handlers preserve the same least-fixed-point order as ordinary binds.
@[partial_fixpoint_monotone]
theorem monotone_except_tryCatch {ε α γ : Type} {m : Type → Type}
    [PartialOrder γ] [Monad m] [∀ β, PartialOrder (m β)] [MonoBind m]
    (action : γ → ExceptT ε m α) (handler : γ → ε → ExceptT ε m α)
    (actionMono : monotone action) (handlerMono : monotone handler) :
    monotone (fun x => tryCatch (action x) (handler x)) := by
  change monotone (fun x => @Bind.bind m _ (Except ε α) (Except ε α) (action x) (fun result =>
    match result with
    | .ok value => (pure (.ok value) : m (Except ε α))
    | .error error => handler x error))
  apply monotone_bind m _ _ actionMono
  apply monotone_of_monotone_apply
  intro result
  cases result with
  | ok value => exact monotone_const _
  | error error => exact monotone_apply error _ handlerMono

-- Explicit transformer aliases let Lean match recursive catch expressions.
@[partial_fixpoint_monotone]
theorem monotone_partialResult_tryCatch {exception α γ : Type} [PartialOrder γ]
    (action : γ → PartialResult exception α) (handler : γ → Error exception → PartialResult exception α)
    (actionMono : monotone action) (handlerMono : monotone handler) :
    monotone (fun x => tryCatch (action x) (handler x)) :=
  monotone_except_tryCatch (m := Option) action handler actionMono handlerMono

@[partial_fixpoint_monotone]
theorem monotone_partialSpecM_tryCatch {exception σ α γ : Type} [PartialOrder γ]
    (action : γ → PartialSpecM exception σ α)
    (handler : γ → Error exception → PartialSpecM exception σ α)
    (actionMono : monotone action) (handlerMono : monotone handler) :
    monotone (fun x => tryCatch (action x) (handler x)) :=
  monotone_except_tryCatch (m := StateT σ Option) action handler actionMono handlerMono

-- An unbounded loop uses the least fixed point with None as its bottom value.
structure PartialLoop

def PartialLoop.forIn {exception σ β : Type}
    (initial : β) (body : Unit → β → PartialSpecM exception σ (ForInStep β)) :
    PartialSpecM exception σ β := do
  match ← body () initial with
  | .done value => pure value
  | .yield value => PartialLoop.forIn value body
partial_fixpoint

instance {exception σ : Type} : ForIn (PartialSpecM exception σ) PartialLoop Unit where
  forIn _ := PartialLoop.forIn

instance {exception : Type} : MonadLift (Except (Error exception)) (PartialResult exception) where
  monadLift action := some action

instance {exception σ : Type} : MonadLift (PartialResult exception) (PartialSpecM exception σ) where
  monadLift action state := Option.map (fun result => (result, state)) action.run

instance {exception : Type} : ForIn (PartialResult exception) PartialLoop Unit where
  forIn _ initial body :=
    (PartialLoop.forIn (σ := Unit) initial
      (fun token value _ => Option.map (fun result => (result, ())) (body token value).run) ()).map Prod.fst

-- Opt in only for definitions whose result type records possible divergence.
namespace PartialSyntax
@[scoped macro Lean.Parser.Term.doWhile]
def expandWhile : Lean.Macro
  | `(doElem| while $condition:doIfCond do $body) =>
      `(doElem| for _ in PartialLoop.mk do if $condition:doIfCond then $body else break)
  | _ => Lean.Macro.throwUnsupported
@[scoped macro Lean.Parser.Term.doRepeat]
def expandRepeat : Lean.Macro
  | `(doElem| repeat $body) => `(doElem| for _ in PartialLoop.mk do $body)
  | _ => Lean.Macro.throwUnsupported

@[scoped macro Lean.Parser.Term.doRepeatUntil]
def expandRepeatUntil : Lean.Macro
  | `(doElem| repeat $body until $condition) =>
      `(doElem| for _ in PartialLoop.mk do
          do $body:doSeq
          if $condition then break)
  | _ => Lean.Macro.throwUnsupported
end PartialSyntax

end X86.Runtime
