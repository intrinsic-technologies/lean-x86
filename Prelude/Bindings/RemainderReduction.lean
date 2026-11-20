import Prelude.Bindings.Contract
import X86.Machine.Bindings.RemainderReduction

namespace Prelude.Bindings.RemainderReduction

open X86

open Prelude.Bindings.Contract

/-- Every input admits a five-bit reduction choice. The generated remainder
calls this selector only for incomplete steps; the five bits encode N - 32.
The selector must complete; every result fits the permitted reduction range. -/
def contract {σ : Type} :
    Contract (State σ) X86.Machine.Bindings.RemainderReduction.Input (BitVec 5) :=
  Contract.mk (fun _ _ => True) (fun _ _ _ => True)

def Satisfies {σ : Type} (implementation : X86.Machine.Bindings.RemainderReduction σ) : Prop :=
  contract.Satisfies (m := Id) (fun input =>
    implementation.reduction.call input.dividend input.divisor input.nearest)

end Prelude.Bindings.RemainderReduction
