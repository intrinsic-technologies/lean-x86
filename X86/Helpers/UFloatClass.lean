-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 8ce424d64e4846ede6b5ee4c3616c83faa37ba76375eb318bead2c3f91a60eab
import X86.Runtime
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.UFloatCompare
import X86.Helpers.UFloatMul
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

inductive UFloatClass_Type where
  | UFLOAT_CLASS_SIGNALING_NAN
  | UFLOAT_CLASS_QUIET_NAN
  | UFLOAT_CLASS_NEGATIVE_INFINITY
  | UFLOAT_CLASS_POSITIVE_INFINITY
  | UFLOAT_CLASS_NEGATIVE_ZERO
  | UFLOAT_CLASS_POSITIVE_ZERO
  | UFLOAT_CLASS_NEGATIVE_SUBNORMAL
  | UFLOAT_CLASS_POSITIVE_SUBNORMAL
  | UFLOAT_CLASS_NEGATIVE_NORMAL
  | UFLOAT_CLASS_POSITIVE_NORMAL
  deriving Repr, DecidableEq, Inhabited

def UFloatClass {E : Int} {N : Int}
    (x : UFloat E N) :
    Except (Runtime.Error Empty) (UFloatClass_Type) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  if (← UFloatIsSNaN (E := E) (N := N) x) then
    return UFloatClass_Type.UFLOAT_CLASS_SIGNALING_NAN
  else
    if (← UFloatIsNaN (E := E) (N := N) x) then
      return UFloatClass_Type.UFLOAT_CLASS_QUIET_NAN
    else
      if (← UFloatIsInfinite (E := E) (N := N) x) then
        return if x.sign then UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_INFINITY else UFloatClass_Type.UFLOAT_CLASS_POSITIVE_INFINITY
      else
        if (← UFloatIsZero (E := E) (N := N) x) then
          return if x.sign then UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_ZERO else UFloatClass_Type.UFLOAT_CLASS_POSITIVE_ZERO
        else
          if (← UFloatIsSubnormal (E := E) (N := N) x) then
            return if x.sign then UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_SUBNORMAL else UFloatClass_Type.UFLOAT_CLASS_POSITIVE_SUBNORMAL
          else
            return if x.sign then UFloatClass_Type.UFLOAT_CLASS_NEGATIVE_NORMAL else UFloatClass_Type.UFLOAT_CLASS_POSITIVE_NORMAL

def ContextInfinity {E : Int} {N : Int}
    (_ctx : RoundingContext E N) (sign : Bool) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return (← BinaryFloat_Produced E N (BitVec.cast (by omega) (← concatBits (leftSize := ((1 : Int) + E)) (rightSize := ((N - E) - (1 : Int))) (← concatBits (leftSize := 1) (rightSize := E) (← Bit sign) (← Std.Bits.All_Ones E)) (← Std.Bits.Zero (N - E - 1))) : Bits N) false false false false false)

-- IEEE binary NaN encoding: all exponent bits set, followed by the quiet bit
-- and the payload. A signaling NaN requires a nonzero payload.
def IEEE754ContextNan {E : Int} {N : Int}
    (_ctx : RoundingContext E N) (sign quiet : Bool) (payload : Bits ((N - E) - (2 : Int))) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (quiet or not (← Std.Bits.Is_Zero (size := ((N - E) - (2 : Int))) payload))
  return (← BinaryFloat_Produced E N (BitVec.cast (by omega) (← concatBits (leftSize := (((1 : Int) + E) + (1 : Int))) (rightSize := ((N - E) - (2 : Int))) (← concatBits (leftSize := ((1 : Int) + E)) (rightSize := 1) (← concatBits (leftSize := 1) (rightSize := E) (← Bit sign) (← Std.Bits.All_Ones E)) (← Bit quiet)) payload) : Bits N) false false false false false)

end X86.Helpers
