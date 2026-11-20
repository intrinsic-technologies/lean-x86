-- Generated from data/definitions.xml.gz: FP87::Tan; do not edit.
-- Source SHA256: a36e6ee42f634efcab6be699ac4034eb971c08293388c263613a82c2313223f0
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ATan)
import X86.Runtime
import X86.Helpers.Emulate_F2XM1
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.One
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

variable {σ : Type}

variable
  [X86.Helpers.Emulate_FPTAN.Binding σ]

def FP87.Tan
    (x : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × F80_Type × Bool × Bool × FP_Exception_Flags_Type) := do
  let mut result1 : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut result2 : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut rounded_up : Bool := false
  let mut out_of_range : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  match (← FP87.Classify x) with
  | FP87_Class_Type.FP87_Class_Unsupported => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result1 := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    result2 := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  | FP87_Class_Type.FP87_Class_QNaN => do
    result1 := Runtime.InitializedBits.ofValue x
    result2 := Runtime.InitializedBits.ofValue x
  | FP87_Class_Type.FP87_Class_SNaN => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result1 := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN x)
    result2 := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN x)
  | FP87_Class_Type.FP87_Class_Zero => do
    result1 := Runtime.InitializedBits.ofValue (← FP87.One 0)
    result2 := Runtime.InitializedBits.ofValue x
  | FP87_Class_Type.FP87_Class_Infinity => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result1 := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    result2 := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  | FP87_Class_Type.FP87_Class_Denormal => do
    let (result1_2, result2_2, rounded_up_2, out_of_range_2, exceptions_2) ← Emulate_FPTAN x
    result1 := Runtime.InitializedBits.ofValue result1_2
    result2 := Runtime.InitializedBits.ofValue result2_2
    rounded_up := rounded_up_2
    out_of_range := out_of_range_2
    exceptions := exceptions_2
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
  | _ => do
    let (result1_1, result2_1, rounded_up_1, out_of_range_1, exceptions_1) ← Emulate_FPTAN x
    result1 := Runtime.InitializedBits.ofValue result1_1
    result2 := Runtime.InitializedBits.ofValue result2_1
    rounded_up := rounded_up_1
    out_of_range := out_of_range_1
    exceptions := exceptions_1

  return ((← Runtime.InitializedBits.read result1), (← Runtime.InitializedBits.read result2), rounded_up, out_of_range, exceptions)

end X86.Helpers
