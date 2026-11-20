-- Generated from data/definitions.xml.gz: FP87::Compare; do not edit.
-- Source SHA256: d8f7351c3aa1c5a73f1d3e530064a37e1460e2a499f061925535f4c41fa8555c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ACompare)
import X86.Runtime
import X86.Helpers.Emulate_FSUB_For_Compare
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Comparison_Constants
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Compare
    (x y : F80_Type) (is_ordered : Bool) (is_y_denormal : Bool := false) :
    Except (Runtime.Error Empty) (Bits 3 × FP_Exception_Flags_Type) := do
  let mut c320 : Bits 3 ← Std.Bits.Zero 3
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6
  let mut difference : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80

  let x_class : FP87_Class_Type ← FP87.Classify x
  let y_class : FP87_Class_Type ← do
    if is_y_denormal then
      pure FP87_Class_Type.FP87_Class_Denormal
    else
      FP87.Classify y

  match (x_class, y_class) with
  | (FP87_Class_Type.FP87_Class_Unsupported, _) | (_, FP87_Class_Type.FP87_Class_Unsupported) | (FP87_Class_Type.FP87_Class_SNaN, _) | (_, FP87_Class_Type.FP87_Class_SNaN) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    c320 := FP87_COMPARE_INVALID

  | (FP87_Class_Type.FP87_Class_QNaN, _) | (_, FP87_Class_Type.FP87_Class_QNaN) => do
    if is_ordered then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    c320 := FP87_COMPARE_INVALID

  -- Denormal
  | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Denormal) | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Normal) | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Denormal) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    difference := Runtime.InitializedBits.ofValue (← Emulate_FSUB_For_Compare x y)
    if ((← FP87.Classify (← Runtime.InitializedBits.read difference)) == FP87_Class_Type.FP87_Class_Zero) then
      c320 := FP87_COMPARE_EQUAL
    else
      if ((← F80_Type.Sign.partial difference) == 1) then
        c320 := FP87_COMPARE_LESS_THAN
      else
        c320 := FP87_COMPARE_GREATER_THAN
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Denormal) | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Zero) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    if (F80_Type.Sign x == 1) then
      c320 := FP87_COMPARE_LESS_THAN
    else
      c320 := FP87_COMPARE_GREATER_THAN
  | (FP87_Class_Type.FP87_Class_Denormal, FP87_Class_Type.FP87_Class_Infinity) | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Denormal) => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    if (F80_Type.Sign y == 1) then
      c320 := FP87_COMPARE_GREATER_THAN
    else
      c320 := FP87_COMPARE_LESS_THAN

  -- Infinity
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Infinity) => do
    if (F80_Type.Sign x == F80_Type.Sign y) then
      c320 := FP87_COMPARE_EQUAL
    else
      if (F80_Type.Sign x == 1) then
        c320 := FP87_COMPARE_LESS_THAN
      else
        c320 := FP87_COMPARE_GREATER_THAN
  | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Zero) | (FP87_Class_Type.FP87_Class_Infinity, FP87_Class_Type.FP87_Class_Normal) | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Zero) => do
    if (F80_Type.Sign x == 1) then
      c320 := FP87_COMPARE_LESS_THAN
    else
      c320 := FP87_COMPARE_GREATER_THAN
  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Infinity) | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Normal) | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Infinity) => do
    if (F80_Type.Sign y == 1) then
      c320 := FP87_COMPARE_GREATER_THAN
    else
      c320 := FP87_COMPARE_LESS_THAN

  -- Zero
  | (FP87_Class_Type.FP87_Class_Zero, FP87_Class_Type.FP87_Class_Zero) => do
    c320 := FP87_COMPARE_EQUAL

  | (FP87_Class_Type.FP87_Class_Normal, FP87_Class_Type.FP87_Class_Normal) => do
    difference := Runtime.InitializedBits.ofValue (← Emulate_FSUB_For_Compare x y)
    if ((← FP87.Classify (← Runtime.InitializedBits.read difference)) == FP87_Class_Type.FP87_Class_Zero) then
      c320 := FP87_COMPARE_EQUAL
    else
      if ((← F80_Type.Sign.partial difference) == 1) then
        c320 := FP87_COMPARE_LESS_THAN
      else
        c320 := FP87_COMPARE_GREATER_THAN

  return (c320, exceptions)

end X86.Helpers
