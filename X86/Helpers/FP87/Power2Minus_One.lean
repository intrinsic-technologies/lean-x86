-- Generated from data/definitions.xml.gz: FP87::Power2Minus_One; do not edit.
-- Source SHA256: d7c4a922f3904c3743dd197a348b8566a01c32d8844d49e31cdbe39528e19a99
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3APower2Minus_One)
import X86.Runtime
import X86.Helpers.Emulate_F2XM1
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Infinity
import X86.Helpers.FP87.One
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Quietize_NaN
import X86.Helpers.FP87.Zero
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.Emulate_F2XM1.Binding σ]

def FP87.Power2Minus_One
    (x : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut rounded_up : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  let x_class : FP87_Class_Type ← FP87.Classify x

  match x_class with
  | FP87_Class_Type.FP87_Class_Unsupported => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)

  -- NaN
  | FP87_Class_Type.FP87_Class_QNaN => do
    result := Runtime.InitializedBits.ofValue x
  | FP87_Class_Type.FP87_Class_SNaN => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN x)

  | FP87_Class_Type.FP87_Class_Denormal => do
    if ((← Runtime.liftTotal (FP87_Control.DM)) == 1) then
      let (result_1, rounded_up_1, exceptions_1) ← Emulate_F2XM1 x
      result := Runtime.InitializedBits.ofValue result_1
      rounded_up := rounded_up_1
      exceptions := exceptions_1
    else
      result := Runtime.InitializedBits.ofValue (← Runtime.liftTotal (UNSPECIFIED (size := 80)))
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
  | FP87_Class_Type.FP87_Class_Infinity => do
    result := Runtime.InitializedBits.ofValue (← (do if F80_Type.Sign x == 1 then pure (← FP87.One 1) else pure (← FP87.Infinity 0)))
  | FP87_Class_Type.FP87_Class_Zero => do
    result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign x))
  | FP87_Class_Type.FP87_Class_Normal => do
    let (result_2, rounded_up_2, exceptions_2) ← Emulate_F2XM1 x
    result := Runtime.InitializedBits.ofValue result_2
    rounded_up := rounded_up_2
    exceptions := exceptions_2

  return ((← Runtime.InitializedBits.read result), rounded_up, exceptions)

end X86.Helpers
