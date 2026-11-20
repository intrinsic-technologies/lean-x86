-- Generated from data/definitions.xml.gz: FP87::Convert_F80_To_BCD; do not edit.
-- Source SHA256: 089b1c598aa5a2533eaef6e189d212bd72178b17d459f2977ae7454ff6b5765f
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AConvert_F80_To_BCD)
import X86.Runtime
import X86.Helpers.Emulate_FBLD
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.QNaN_Indefinite
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

def FP87.Convert_F80_To_BCD
    (x : F80_Type) :
    Runtime.SpecM Exception (State σ) (Bits 80 × Bool × Bits 6) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut rounded_up : Bool := false
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  let x_class : FP87_Class_Type ← FP87.Classify x

  match x_class with
  | FP87_Class_Type.FP87_Class_Unsupported | FP87_Class_Type.FP87_Class_QNaN | FP87_Class_Type.FP87_Class_SNaN | FP87_Class_Type.FP87_Class_Infinity => do
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)

  | FP87_Class_Type.FP87_Class_Zero => do
    result := Runtime.InitializedBits.ofValue (← FP87.Zero (F80_Type.Sign x))

  | FP87_Class_Type.FP87_Class_Denormal | FP87_Class_Type.FP87_Class_Normal => do
    let (result_1, rounded_up_1, exceptions_1) ← Emulate_FBSTP x
    result := Runtime.InitializedBits.ofValue result_1
    rounded_up := rounded_up_1
    exceptions := exceptions_1

  return ((← Runtime.InitializedBits.read result), rounded_up, exceptions)

end X86.Helpers
