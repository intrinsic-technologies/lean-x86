import Prelude.Bindings.Contract
import X86.Helpers.Get_Repeat_String_Stride

set_option autoImplicit false

namespace Prelude.Bindings.StringStride

open X86

open Prelude.Bindings.Contract

open X86.Helpers

structure Input where
  operandSize : Int
  count : Int
  deriving DecidableEq, Repr

/-- REP MOVS/STOS pass a positive count from an at-most-64-bit count register.
Each execution chunk is nonempty and bounded by the remaining REP count, without
selecting a grouping size. This shared-hook
convention covers unguarded transfers and the first SCAS comparison (SDM 093
Vol. 1, 7.3.9.2; Vol. 2B, REP/REPE/REPNE). It is an execution interface
restriction, not complete SDM conformance. -/
def contract (σ : Type) :
    Contract (X86.State σ) Input Int :=
  Contract.mk
    (fun _ input =>
      (input.operandSize = 8 ∨ input.operandSize = 16 ∨ input.operandSize = 32 ∨ input.operandSize = 64) ∧
        0 < input.count ∧ input.count < 2 ^ 64)
    (fun _ input stride => 0 < stride ∧ stride ≤ input.count)

def Satisfies {σ : Type}
    (implementation : Get_Repeat_String_Stride.Binding σ) : Prop :=
  (contract σ).Satisfies (m := Id)
    (fun input => implementation.call input.operandSize input.count)

end Prelude.Bindings.StringStride
