-- Generated from data/definitions.xml.gz: FP87::Sqrt; do not edit.
-- Source SHA256: 927501d56612c76f05b6aeb0ad85220cc0dbe11cf45a10cbe60a35b15d906675
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ASqrt)
import X86.Runtime
import X86.Helpers.Emulate_FSQRT
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

def FP87.Sqrt
    (x : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut rounded_up : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  let x_class : FP87_Class_Type ← FP87.Classify x
  let negative : Bool := F80_Type.Sign x == 1

  match (x_class, negative) with
  | (FP87_Class_Type.FP87_Class_Unsupported, _) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)

  | (FP87_Class_Type.FP87_Class_SNaN, _) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN x)

  | (FP87_Class_Type.FP87_Class_QNaN, _) | (FP87_Class_Type.FP87_Class_Zero, _) | (FP87_Class_Type.FP87_Class_Infinity, false) => do
    result := Runtime.InitializedBits.ofValue x

  | (_, true) => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)

  | (FP87_Class_Type.FP87_Class_Denormal, false) => do
    let (result_1, rounded_up_1, exceptions_1) ← Emulate_FSQRT x
    result := Runtime.InitializedBits.ofValue result_1
    rounded_up := rounded_up_1
    exceptions := exceptions_1
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)

  | (FP87_Class_Type.FP87_Class_Normal, false) => do
    let (result_2, rounded_up_2, exceptions_2) ← Emulate_FSQRT x
    result := Runtime.InitializedBits.ofValue result_2
    rounded_up := rounded_up_2
    exceptions := exceptions_2

  return ((← Runtime.InitializedBits.read result), rounded_up, exceptions)

end X86.Helpers
