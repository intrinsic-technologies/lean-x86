-- Generated from data/definitions.xml.gz: FP87::Add; do not edit.
-- Source SHA256: dcc33eb8b6cda7e78f56593a759d60c2e59da91df51284ba8c843f99ec97c4d6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AAdd)
import X86.Runtime
import X86.Helpers.Emulate_FADD
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Get_NAN_Result
import X86.Helpers.FP87.Get_Rounding_Mode
import X86.Helpers.FP87.Infinity
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Quietize_NaN
import X86.Helpers.FP87.Zero
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Rounding_Mode
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Add
    (x y : F80_Type) (is_y_denormal : Bool := false) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut rounded_up : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  let x_class : FP87_Class_Type ← FP87.Classify x
  let y_class : FP87_Class_Type ← do
    if is_y_denormal then
      pure FP87_Class_Type.FP87_Class_Denormal
    else
      FP87.Classify y

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
    if (F80_Type.Sign x != F80_Type.Sign y) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign x))
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Denormal) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign x))
  | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Infinity) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign y))
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Zero) | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Normal) => do
    result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign x))
  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Infinity) | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Infinity) => do
    result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign y))

  -- Denormal
  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Denormal) | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Denormal) | (FP87_Class_Type.FP87_Class_Denormal, _) => do
    if ((← FP87_Control.DM) == 1) then
      let (result_1, rounded_up_1, exceptions_1) ← Emulate_FADD x y
      result := Runtime.InitializedBits.ofValue result_1
      rounded_up := rounded_up_1
      exceptions := exceptions_1
    else
      result := Runtime.InitializedBits.ofValue (← UNSPECIFIED (size := 80))
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)

  -- Zero
  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Zero) => do
    result := Runtime.InitializedBits.ofValue (← FP87.Zero 0)
    if (F80_Type.Sign x == F80_Type.Sign y) then
      result := (← F80_Type.setSign.partial result (F80_Type.Sign x))
    else
      if ((← FP87.Get_Rounding_Mode) == Rounding_Mode.Rounding_Mode_RTN) then
        result := (← F80_Type.setSign.partial result (1 : Runtime.Bit))

  -- Normal
  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Zero) | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Normal) | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Normal) => do
    let (result_2, rounded_up_2, exceptions_2) ← Emulate_FADD x y
    result := Runtime.InitializedBits.ofValue result_2
    rounded_up := rounded_up_2
    exceptions := exceptions_2

  return ((← Runtime.InitializedBits.read result), rounded_up, exceptions)

end X86.Helpers
