-- Generated from a local ISA specification; do not edit.
-- Source SHA256: f378a246736f0d40290a1446a754d4c09f0d2649e3697cc0dad0f22199dc2852
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Convert_From_Integer
import X86.Helpers.FP87.Convert_To_Integer
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Std.Integer.Truncated_Divide
import X86.Helpers.Std.Integer.Truncated_Remainder
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

-- Missing packed-decimal primitives, Intel SDM Vol. 1 packed BCD format and
-- Vol. 2 FBLD/FBSTP. Intel's callers own stack updates and exception delivery.
def Emulate_FBLD
    (x : Bits 80) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × Bool × FP_Exception_Flags_Type) := do
  let mut magnitude : Int := 0
  let mut power : Int := 1
  for i in intRange (0 : Int) (17 : Int) do
    let digit : Int := Unsigned (← (do Runtime.assert (decide (i * 4 ≤ 76)); pure (← x[i *: 4])))
    -- Intel leaves invalid BCD input results undefined.
    if (decide (digit > 9)) then
      return ((← Runtime.liftTotal (UNSPECIFIED (size := 80))), false, (← Std.Bits.Zero 6))
    magnitude := magnitude + digit * power
    power := power * 10
  let mut result : F80_Type ← FP87.Convert_From_Integer (size := 64) (← magnitude[0 +: 64])
  result := F80_Type.setSign result (← x[79 +: 1])
  return (result, false, (← Std.Bits.Zero 6))

def Emulate_FBSTP
    (x : F80_Type) :
    Runtime.SpecM Exception (State σ) (Bits 80 × Bool × FP_Exception_Flags_Type) := do
  Runtime.assert (← (do
    let __check97 : FP87_Class_Type ← FP87.Classify x
    pure ((__check97 == FP87_Class_Type.FP87_Class_Normal) || (__check97 == FP87_Class_Type.FP87_Class_Denormal))))
  let (integer, rounded_up, converted_status) ← FP87.Convert_To_Integer x (← FP87_Control.RC) 64 true
  let mut status : FP_Exception_Flags_Type := converted_status
  -- FBSTP signals precision for tiny inputs, but not a denormal-operand exception.
  status := FP_Exception_Flags_Type.setDE status (0 : Runtime.Bit)
  let signed_value : Int := Signed integer
  let mut magnitude : Int := if decide (signed_value < 0) then - signed_value else signed_value
  if (FP_Exception_Flags_Type.IE status == 1 or decide (magnitude ≥ (← (10 : Int) ** (18 : Int)))) then
    let mut invalid : FP_Exception_Flags_Type ← Std.Bits.Zero 6
    invalid := FP_Exception_Flags_Type.setIE invalid (1 : Runtime.Bit)
    return (1208921207928610747318272, false, invalid)
  let mut result : Bits 80 ← Std.Bits.Zero 80
  result := (← setSliceChecked result 79 1 (F80_Type.Sign x))
  for i in intRange (0 : Int) (17 : Int) do
    Runtime.assert (decide (i * 4 ≤ 76))
    result := (← setSliceChecked result (i * (4 : Int)) 4 (← Runtime.CheckedSlice.read (← Std.Integer.Truncated_Remainder magnitude 10) 0 4))
    magnitude := (← Std.Integer.Truncated_Divide magnitude 10)
  return (result, rounded_up, status)

end X86.Helpers
