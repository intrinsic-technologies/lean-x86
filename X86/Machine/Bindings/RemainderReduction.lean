import X86.Helpers.Emulate_FPREM

namespace X86.Machine.Bindings

/-- Inputs of one incomplete FPREM or FPREM1 reduction. -/
structure RemainderReduction.Input where
  dividend : BitVec 80
  divisor : BitVec 80
  nearest : Bool

/-- The implementation-dependent N of an incomplete step (SDM 093 Vol. 2A FPREM,
FPREM1), encoded as N - 32. -/
class RemainderReduction (σ : Type) where
  reduction : Helpers.Select_FP87_Remainder_Reduction.Binding σ

attribute [instance_reducible, instance] RemainderReduction.reduction

/-- A choice from the operands and the pre-operation state. -/
@[instance_reducible]
def RemainderReduction.ofFunction {σ : Type}
    (choose : State σ → RemainderReduction.Input → BitVec 5) : RemainderReduction σ where
  reduction := ⟨fun x y nearest => do return choose (← read) ⟨x, y, nearest⟩⟩

/-- An explicit fixed reduction; zero chooses N=32. -/
@[instance_reducible]
def RemainderReduction.fixed {σ : Type} (reduction : BitVec 5) : RemainderReduction σ :=
  RemainderReduction.ofFunction (fun _ _ => reduction)

end X86.Machine.Bindings
