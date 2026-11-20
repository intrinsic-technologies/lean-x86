import Prelude.Bindings.Numerical.Transcendental.Laws
import X86.Machine.Bindings.Numerical

set_option autoImplicit false

namespace Prelude.Bindings.Numerical.Transcendental

open X86

open Prelude.Bindings.Contract

open Prelude.Float.Binary80

/-- Pack each generated tuple without recomputing or changing its result fields. -/
def run {σ : Type} (implementation : X86.Machine.Bindings.Numerical σ) (input : Input) :
    ReaderT (X86.State σ) (X86.Runtime.PartialResult Empty) Output := do
  match input.operation with
  | .exp2m1 =>
    let (result, up, flags) ← implementation.exp2m1.call input.x
    return ⟨result, 0, up, false, flags⟩
  | .sin =>
    let (result, up, outOfRange, flags) ← implementation.sin.call input.x
    return ⟨result, 0, up, outOfRange, flags⟩
  | .cos =>
    let (result, up, outOfRange, flags) ← implementation.cos.call input.x
    return ⟨result, 0, up, outOfRange, flags⟩
  | .sincos =>
    let (cosine, sine, up, outOfRange, flags) ← implementation.sincos.call input.x
    return ⟨cosine, sine, up, outOfRange, flags⟩
  | .tan =>
    let (one, tangent, up, outOfRange, flags) ← implementation.tan.call input.x
    return ⟨one, tangent, up, outOfRange, flags⟩
  | .atan2 =>
    let (result, up, flags) ← implementation.atan2.call input.x input.y
    return ⟨result, 0, up, false, flags⟩
  | .mulLog2 =>
    let (result, up, flags) ← implementation.mulLog2.call input.x input.y
    return ⟨result, 0, up, false, flags⟩
  | .mulLog2p1 =>
    let (result, up, flags) ← implementation.mulLog2p1.call input.x input.y
    return ⟨result, 0, up, false, flags⟩

/-- Compare results from one complete pre-operation state. -/
def MonotoneOnSegments {σ : Type} (implementation : X86.Machine.Bindings.Numerical σ) : Prop :=
  ∀ op x₁ y₁ x₂ y₂ cosine (before : X86.State σ),
    supportedPrecisionControl before →
    computedFiniteIn before ⟨op, x₁, y₁⟩ → computedFiniteIn before ⟨op, x₂, y₂⟩ →
    definedResult op x₁ y₁ → definedResult op x₂ y₂ →
    ¬ discardedDenormal before ⟨op, x₁, y₁⟩ → ¬ discardedDenormal before ⟨op, x₂, y₂⟩ →
    (cosine = true → op = .sincos ∨ op = .cos) →
    MonotoneSegment op (value x₁) (value y₁) (value x₂) (value y₂) cosine →
    match run implementation ⟨op, x₁, y₁⟩ before,
        run implementation ⟨op, x₂, y₂⟩ before with
    | some (.ok r₁), some (.ok r₂) =>
      unscaledOutput before r₁ → unscaledOutput before r₂ →
      finite (r₁.result op cosine) → finite (r₂.result op cosine) →
        value (r₁.result op cosine) ≤ value (r₂.result op cosine)
    | _, _ => True

/-- Compare the result and status fields observed by the generated wrappers
for computed inputs; unused tuple fields remain free. -/
def SameComputedOutput (op : Operation) (first second : Output) : Prop :=
  first.result op false = second.result op false ∧
    (op = .sincos → first.first = second.first) ∧
    first.flags = second.flags ∧
    first.roundedUp = second.roundedUp ∧
    (trigonometric op = true → first.outOfRange = second.outOfRange)

/-- PC affects only basic arithmetic and FSQRT (SDM 093 Vol. 1, 8.1.5.2).
Computed transcendental results and status are independent of supported PC values
when the rest of the pre-state is unchanged. Reserved 01 and unused tuple fields are excluded. -/
def PrecisionControlIndependent {σ : Type}
    (implementation : X86.Machine.Bindings.Numerical σ) : Prop :=
  ∀ input (before : X86.State σ) (precision : BitVec 2),
    computedFiniteIn before input → definedResult input.operation input.x input.y →
    ¬ discardedDenormal before input →
    supportedPrecisionControl before → precision ≠ 1 →
    let changed := {before with FP87_Control :=
      X86.Helpers.FP87_Control_Type.setPC before.FP87_Control precision}
    match (run implementation input).run before, (run implementation input).run changed with
    | some (.ok first), some (.ok second) =>
      SameComputedOutput input.operation first second
    | _, _ => True

/-- PM changes delivery of the precision exception, not the computed register
result or status (SDM 093 Vol. 1, 8.5.6). OM, UM, RC and the rest of the pre-state stay fixed. -/
def PrecisionMaskIndependent {σ : Type}
    (implementation : X86.Machine.Bindings.Numerical σ) : Prop :=
  ∀ input (before : X86.State σ) (masked : BitVec 1),
    supportedPrecondition before input → definedResult input.operation input.x input.y →
    ¬ discardedDenormal before input →
    let changed := {before with FP87_Control :=
      X86.Helpers.FP87_Control_Type.setPM before.FP87_Control masked}
    match (run implementation input).run before, (run implementation input).run changed with
    | some (.ok first), some (.ok second) =>
      SameComputedOutput input.operation first second
    | _, _ => True

end Prelude.Bindings.Numerical.Transcendental
