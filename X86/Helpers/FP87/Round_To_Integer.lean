-- Generated from data/definitions.xml.gz: FP87::Round_To_Integer; do not edit.
-- Source SHA256: 6bbee4d9f421d692d3a3e0a711e2b237c8500b54d7947e0eb0de0dbb3a004958
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ARound_To_Integer)
import X86.Runtime
import X86.Helpers.Emulate_FRNDINT
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Quietize_NaN
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP87.Round_To_Integer
    (x : F80_Type) (rc : Bits 2) :
    Except (Runtime.Error Empty) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut rounded_up : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  let x_class : FP87_Class_Type ← FP87.Classify x

  match x_class with
  | FP87_Class_Type.FP87_Class_Unsupported => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)

  | FP87_Class_Type.FP87_Class_SNaN => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN x)

  | FP87_Class_Type.FP87_Class_Denormal => do
    let (result_1, rounded_up_1, exceptions_1) ← Emulate_FRNDINT x rc
    result := Runtime.InitializedBits.ofValue result_1
    rounded_up := rounded_up_1
    exceptions := exceptions_1
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)

  | FP87_Class_Type.FP87_Class_QNaN | FP87_Class_Type.FP87_Class_Zero | FP87_Class_Type.FP87_Class_Infinity => do
    result := Runtime.InitializedBits.ofValue x

  | FP87_Class_Type.FP87_Class_Normal => do
    let (result_2, rounded_up_2, exceptions_2) ← Emulate_FRNDINT x rc
    result := Runtime.InitializedBits.ofValue result_2
    rounded_up := rounded_up_2
    exceptions := exceptions_2

  return ((← Runtime.InitializedBits.read result), rounded_up, exceptions)

end X86.Helpers
