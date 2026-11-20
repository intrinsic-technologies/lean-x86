-- Generated from data/definitions.xml.gz: FP87::Remainder; do not edit.
-- Source SHA256: 4fd53943d7b9962a394a1dc2737db3babec8257b1bd685ef16c4dff890dc7724
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ARemainder)
import X86.Runtime
import X86.Helpers.Emulate_FPREM
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Get_NAN_Result
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Quietize_NaN
import X86.Helpers.FP87.Zero
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP87_Status_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.Select_FP87_Remainder_Reduction.Binding σ]

def FP87.Remainder
    (x y : F80_Type) (is_IEEE_compliant : Bool) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bits 4 × FP_Exception_Flags_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  -- C0/C3 are preserved and C1/C2 are cleared
  let mut c3210 : Bits 4 ← concatBits (leftSize := 3) (rightSize := 1) (← concatBits (leftSize := 2) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := 1) (← FP87_Status.C3) (0 : Runtime.Bit)) (0 : Runtime.Bit)) (← FP87_Status.C0)
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

  | (FP87_Class_Type.FP87_Class_Infinity, _) | (_, FP87_Class_Type.FP87_Class_Zero) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)

  -- Denormal
  | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Infinity) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue x
    c3210 := (← Std.Bits.Zero 4)
    if ((← x[63 +: 1]) == 1) then
      let min_normal_exponent : Bits 15 ← Std.Bits.Zero_Extend (source_size := 4) 1 15
      result := (← F80_Type.setExponent.partial result min_normal_exponent)

  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Denormal) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign x))
    c3210 := (← Std.Bits.Zero 4)

  | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Denormal) | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Normal) | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Denormal) => do
    let (result_1, c3210_1, exceptions_1) ← do
      if is_IEEE_compliant then
        Emulate_FPREM1 x y
      else
        Emulate_FPREM x y
    result := Runtime.InitializedBits.ofValue result_1
    c3210 := c3210_1
    exceptions := exceptions_1
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)

  | (FP87_Class_Type.FP87_Class_Zero, _) => do
    result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign x))
    c3210 := (← Std.Bits.Zero 4)

  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Infinity) => do
    result := Runtime.InitializedBits.ofValue x
    c3210 := (← Std.Bits.Zero 4)

  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Normal) => do
    let (result_2, c3210_2, exceptions_2) ← do
      if is_IEEE_compliant then
        Emulate_FPREM1 x y
      else
        Emulate_FPREM x y
    result := Runtime.InitializedBits.ofValue result_2
    c3210 := c3210_2
    exceptions := exceptions_2

  return ((← Runtime.InitializedBits.read result), c3210, exceptions)

end X86.Helpers
