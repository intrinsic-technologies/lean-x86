-- Generated from data/definitions.xml.gz: FP87::Scale; do not edit.
-- Source SHA256: c28f993eff5540767321277fdc544115476bf607a8ff2f387c270ddc234d9454
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AScale)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Get_NAN_Result
import X86.Helpers.FP87.Infinity
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Quietize_NaN
import X86.Helpers.FP87.Scale_Number
import X86.Helpers.FP87.Zero
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Scale
    (x y : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut rounded_up : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  let x_class : FP87_Class_Type ← FP87.Classify x
  let y_class : FP87_Class_Type ← FP87.Classify y

  match (x_class, y_class) with
  | (FP87_Class_Type.FP87_Class_Unsupported, _) | (_, FP87_Class_Type.FP87_Class_Unsupported) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)

  -- Not-a-Number (NaN)
  | (FP87_Class_Type.FP87_Class_QNaN, FP87_Class_Type.FP87_Class_QNaN) => do
    result := Runtime.InitializedBits.ofValue (← FP87.Get_NAN_Result x y)
  | (FP87_Class_Type.FP87_Class_QNaN, FP87_Class_Type.FP87_Class_SNaN) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue x
  | (FP87_Class_Type.FP87_Class_SNaN, FP87_Class_Type.FP87_Class_QNaN) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue y
  | (FP87_Class_Type.FP87_Class_SNaN, FP87_Class_Type.FP87_Class_SNaN) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Get_NAN_Result x y)
    result := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN (← Runtime.InitializedBits.read result))

  | (FP87_Class_Type.FP87_Class_QNaN, _) => do
    result := Runtime.InitializedBits.ofValue x
  | (_, FP87_Class_Type.FP87_Class_QNaN) => do
    result := Runtime.InitializedBits.ofValue y

  | (FP87_Class_Type.FP87_Class_SNaN, _) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN x)
  | (_, FP87_Class_Type.FP87_Class_SNaN) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN y)

  -- Infinity
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Infinity) => do
    if (F80_Type.Sign y == 1) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign x))
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Denormal) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign x))
  | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Infinity) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    if (F80_Type.Sign y == 1) then
      result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign x))
    else
      result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign x))
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Zero) | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Normal) => do
    result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign x))
  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Infinity) => do
    if (F80_Type.Sign y == 1) then
      result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign x))
    else
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Infinity) => do
    if (F80_Type.Sign y == 1) then
      result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign x))
    else
      result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign x))

  -- Denormal
  | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Zero) => do
    let (result_1, rounded_up_1, exceptions_1) ← FP87.Scale_Number x y
    result := Runtime.InitializedBits.ofValue result_1
    rounded_up := rounded_up_1
    exceptions := exceptions_1
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
  | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Denormal) => do
    let (result_2, rounded_up_2, exceptions_2) ← FP87.Scale_Number x y
    result := Runtime.InitializedBits.ofValue result_2
    rounded_up := rounded_up_2
    exceptions := exceptions_2
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
  | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Normal) => do
    let (result_3, rounded_up_3, exceptions_3) ← FP87.Scale_Number x y
    result := Runtime.InitializedBits.ofValue result_3
    rounded_up := rounded_up_3
    exceptions := exceptions_3
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Denormal) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign x))
  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Denormal) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue x

  -- Zero
  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Zero) | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Normal) => do
    result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign x))

  -- Normal
  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Zero) => do
    result := Runtime.InitializedBits.ofValue x
  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Normal) => do
    let (result_4, rounded_up_4, exceptions_4) ← FP87.Scale_Number x y
    result := Runtime.InitializedBits.ofValue result_4
    rounded_up := rounded_up_4
    exceptions := exceptions_4

  return ((← Runtime.InitializedBits.read result), rounded_up, exceptions)

end X86.Helpers
