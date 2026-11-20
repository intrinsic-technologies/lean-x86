-- Generated from data/definitions.xml.gz: FP87::Cos; do not edit.
-- Source SHA256: d37c5042698effd3d4f7677d6c2ac0fd261be1faeeecc2c5a124f47d054b2d21
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ACos)
import X86.Runtime
import X86.Helpers.Emulate_F2XM1
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.One
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Quietize_NaN
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
  [X86.Helpers.Emulate_FCOS.Binding σ]

def FP87.Cos
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
  | FP87_Class_Type.FP87_Class_QNaN => do
    result := Runtime.InitializedBits.ofValue x
  | FP87_Class_Type.FP87_Class_SNaN => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.Quietize_NaN x)
  | FP87_Class_Type.FP87_Class_Infinity => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  | FP87_Class_Type.FP87_Class_Zero => do
    result := Runtime.InitializedBits.ofValue (← FP87.One 0)
  | FP87_Class_Type.FP87_Class_Denormal => do
    exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
    if ((← Runtime.liftTotal (FP87_Control.DM)) == 0) then
      result := Runtime.InitializedBits.ofValue x
    else
      exceptions := FP_Exception_Flags_Type.setPE exceptions (1 : Runtime.Bit)
      result := Runtime.InitializedBits.ofValue (← FP87.One 0)
  | _ => do
    let (result_1, rounded_up_1, out_of_range_1, exceptions_1) ← Emulate_FCOS x
    result := Runtime.InitializedBits.ofValue result_1
    rounded_up := rounded_up_1
    out_of_range := out_of_range_1
    exceptions := exceptions_1

  return ((← Runtime.InitializedBits.read result), rounded_up, out_of_range, exceptions)

end X86.Helpers
