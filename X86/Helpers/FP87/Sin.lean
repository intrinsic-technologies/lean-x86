-- Generated from data/definitions.xml.gz: FP87::Sin; do not edit.
-- Source SHA256: 8d26796d92d9cf58418fb46b0a15c155b2545653e8f1a342dfdd6f39cff5d901
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ASin)
import X86.Runtime
import X86.Helpers.Emulate_F2XM1
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

variable {σ : Type}

variable
  [X86.Helpers.Emulate_FSIN.Binding σ]

def FP87.Sin
    (x : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × Bool × Bool × FP_Exception_Flags_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut rounded_up : Bool := false
  let mut out_of_range : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  match (← FP87.Classify x) with
  | FP87_Class_Type.FP87_Class_Unsupported => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  | FP87_Class_Type.FP87_Class_QNaN | FP87_Class_Type.FP87_Class_Zero => do
    result := Runtime.InitializedBits.ofValue x
  | FP87_Class_Type.FP87_Class_SNaN => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN x)
  | FP87_Class_Type.FP87_Class_Infinity => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  | FP87_Class_Type.FP87_Class_Denormal => do
    let (result_2, rounded_up_2, out_of_range_2, exceptions_2) ← Emulate_FSIN x
    result := Runtime.InitializedBits.ofValue result_2
    rounded_up := rounded_up_2
    out_of_range := out_of_range_2
    exceptions := exceptions_2
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
  | _ => do
    let (result_1, rounded_up_1, out_of_range_1, exceptions_1) ← Emulate_FSIN x
    result := Runtime.InitializedBits.ofValue result_1
    rounded_up := rounded_up_1
    out_of_range := out_of_range_1
    exceptions := exceptions_1

  return ((← Runtime.InitializedBits.read result), rounded_up, out_of_range, exceptions)

end X86.Helpers
