-- Generated from data/definitions.xml.gz: FP87::Log2_Multiply; do not edit.
-- Source SHA256: 53b5791e47176d1b88812617e57d7829d18489e1977f9a9694fd3dc74719f390
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ALog2_Multiply)
import X86.Runtime
import X86.Helpers.Emulate_F2XM1
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Get_NAN_Result
import X86.Helpers.FP87.Infinity
import X86.Helpers.FP87.One
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Quietize_NaN
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

variable
  [X86.Helpers.Emulate_FYL2X.Binding σ]

def FP87.Log2_Multiply
    (x y : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut rounded_up : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  let x_class : FP87_Class_Type ← FP87.Classify x
  let y_class : FP87_Class_Type ← FP87.Classify y

  let f80_bias : Bits 15 ← (16383 : Bits 16)[0 +: 15]

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
    if (F80_Type.Sign x == 1) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign y))
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Denormal) => do
    if (F80_Type.Sign x == 1) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign y))
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Zero) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Normal) => do
    if (F80_Type.Sign x == 1) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign y))
  | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Infinity) => do
    if (F80_Type.Sign x == 1) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.Infinity (~~~ (F80_Type.Sign y)))
  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Infinity) => do
    result := Runtime.InitializedBits.ofValue (← FP87.Infinity (~~~ (F80_Type.Sign y)))
  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Infinity) => do
    if (x == (← FP87.One 0)) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      if (decide (Unsigned (F80_Type.Exponent x) ≥ Unsigned f80_bias) and (← (F80_Type.Mantissa x)[63 +: 1]) == 1 and F80_Type.Sign x == 0) then
        result := Runtime.InitializedBits.ofValue (← FP87.Infinity (F80_Type.Sign y))
      else
        if (F80_Type.Sign x == 1) then
          exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
          result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
        else
          result := Runtime.InitializedBits.ofValue (← FP87.Infinity (~~~ (F80_Type.Sign y)))

  -- Zero
  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Zero) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  | (FP87_Class_Type.FP87_Class_Zero, _) => do
    exceptions := FP_Exception_Flags_Type.setZE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Infinity (~~~ (F80_Type.Sign y)))
  | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Zero) => do
    if (F80_Type.Sign x == 1) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.Zero (~~~ (F80_Type.Sign y)))
  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Zero) => do
    if (F80_Type.Sign x == 1) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      if (decide (Unsigned (F80_Type.Exponent x) < Unsigned f80_bias)) then
        result := Runtime.InitializedBits.ofValue (← FP87.Zero (~~~ (F80_Type.Sign y)))
      else
        result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign y))

  -- Denormal
  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Denormal) | (FP87_Class_Type.FP87_Class_Denormal, _) => do
    if (F80_Type.Sign x == 1) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      let (result_1, rounded_up_1, exceptions_1) ← Emulate_FYL2X x y
      result := Runtime.InitializedBits.ofValue result_1
      rounded_up := rounded_up_1
      exceptions := exceptions_1
      exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)

  -- Normal
  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Normal) => do
    if (F80_Type.Sign x == 1) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      if (x == (← FP87.One 0)) then
        result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign y))
      else
        let (result_2, rounded_up_2, exceptions_2) ← Emulate_FYL2X x y
        result := Runtime.InitializedBits.ofValue result_2
        rounded_up := rounded_up_2
        exceptions := exceptions_2

  return ((← Runtime.InitializedBits.read result), rounded_up, exceptions)

end X86.Helpers
