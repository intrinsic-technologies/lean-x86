-- Generated from a local ISA specification; do not edit.
-- Source SHA256: ad84d0008aff375ee3e19c6371be9c8f47c0aa03ffc081975c08ccc0bb9d2026
import X86.Runtime
import X86.Helpers.Rounding_Mode
import X86.Helpers.Std.Bits.Is_All_Ones
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Boolean.To_Bit
import X86.Helpers.Std.Integer.Power2
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

structure RoundingContext (E N : Int) where
  -- None preserves a source field that has not been initialized.
  rm : Option (Rounding_Mode) := none
  -- None preserves a source field that has not been initialized.
  flush_subnormals : Option (Bool) := none
  mask_overflow : Bool
  mask_underflow : Bool
  deriving Repr, DecidableEq, Inhabited

structure PackedFloat (E N : Int) where
  bits : Bits N
  deriving Repr, DecidableEq, Inhabited

structure UFloat (E N : Int) where
  sign : Bool
  magnitude : Bits (N - (1 : Int))
  -- None preserves a source field that has not been initialized.
  overflow : Option (Bool) := none
  -- None preserves a source field that has not been initialized.
  underflow : Option (Bool) := none
  -- None preserves a source field that has not been initialized.
  inexact : Option (Bool) := none
  -- None preserves a source field that has not been initialized.
  inexact_significand : Option (Bool) := none
  -- None preserves a source field that has not been initialized.
  invalid : Option (Bool) := none
  isnan : Bool
  isinf : Bool
  deriving Repr, DecidableEq, Inhabited

inductive FloatCompare where
  | FPCompare_GREATER
  | FPCompare_LESS
  | FPCompare_EQUAL
  | FPCompare_ZERO_GREATER
  | FPCompare_ZERO_LESS
  | FPCompare_NAN_LEFT
  | FPCompare_NAN_RIGHT
  | FPCompare_NAN_SIGN_LESS
  | FPCompare_NAN_SIGN_GREATER
  | FPCompare_NAN_MANTISSA_LESS
  | FPCompare_NAN_MANTISSA_GREATER
  | FPCompare_NAN_EQUAL
  deriving Repr, DecidableEq, Inhabited

variable {σ : Type}

def IEEE754Context (E N : Int) : Runtime.SpecM Exception (State σ) (RoundingContext E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  -- The missing library context captures the supplied machine's exception masks.
  -- FP::Convert does not pass them separately, but narrowing needs them.
  let mut ctx_rm : Option (Rounding_Mode) := none
  let mut ctx_flush_subnormals : Option (Bool) := none
  let ctx_mask_overflow : Bool := (← MXCSR.OM) == 1
  let ctx_mask_underflow : Bool := (← MXCSR.UM) == 1
  return ({
    rm := ctx_rm,
    flush_subnormals := ctx_flush_subnormals,
    mask_overflow := ctx_mask_overflow,
    mask_underflow := ctx_mask_underflow
  } : RoundingContext E N)

def PFloat {E : Int} {N : Int}
    (bits : Bits N) (_ctx : RoundingContext E N) :
    Except (Runtime.Error Empty) (PackedFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return ({ bits := bits } : PackedFloat E N)

def PFloatUnpack {E : Int} {N : Int}
    (x : PackedFloat E N) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (decide (N ≥ 3) and decide (E ≥ 2) and decide (E ≤ N - 2))
  let mut result_overflow : Option (Bool) := none
  let mut result_underflow : Option (Bool) := none
  let mut result_inexact : Option (Bool) := none
  let mut result_inexact_significand : Option (Bool) := none
  let mut result_invalid : Option (Bool) := none
  let result_sign : Bool := (← x.bits[N - 1 +: 1]) == 1
  let result_magnitude : Bits (N - (1 : Int)) ← x.bits[0 +: N - 1]
  let result_isnan : Bool := (← Std.Bits.Is_All_Ones (size := E) (← x.bits[N - E - 1 +: E])) and not (← Std.Bits.Is_Zero (size := ((N - E) - (1 : Int))) (← x.bits[0 +: N - E - 1]))
  let result_isinf : Bool := (← Std.Bits.Is_All_Ones (size := E) (← x.bits[N - E - 1 +: E])) and (← Std.Bits.Is_Zero (size := ((N - E) - (1 : Int))) (← x.bits[0 +: N - E - 1]))
  return ({
    sign := result_sign,
    magnitude := result_magnitude,
    overflow := result_overflow,
    underflow := result_underflow,
    inexact := result_inexact,
    inexact_significand := result_inexact_significand,
    invalid := result_invalid,
    isnan := result_isnan,
    isinf := result_isinf
  } : UFloat E N)

def ContextZero {E : Int} {N : Int}
    (_ctx : RoundingContext E N) (sign : Bool) :
    Except (Runtime.Error Empty) (UFloat E N) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (decide (N ≥ 3))
  let mut result_overflow : Option (Bool) := none
  let mut result_underflow : Option (Bool) := none
  let mut result_inexact : Option (Bool) := none
  let mut result_inexact_significand : Option (Bool) := none
  let mut result_invalid : Option (Bool) := none
  let result_sign : Bool := sign
  let result_magnitude : Bits (N - (1 : Int)) ← Std.Bits.Zero (N - 1)
  let result_isnan : Bool := false
  let result_isinf : Bool := false
  return ({
    sign := result_sign,
    magnitude := result_magnitude,
    overflow := result_overflow,
    underflow := result_underflow,
    inexact := result_inexact,
    inexact_significand := result_inexact_significand,
    invalid := result_invalid,
    isnan := result_isnan,
    isinf := result_isinf
  } : UFloat E N)

def UFloatIsNaN {E : Int} {N : Int} (x : UFloat E N) : Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (decide (N ≥ 3) and decide (E ≥ 2) and decide (E ≤ N - 2))
  return (← Std.Bits.Is_All_Ones (size := E) (← (do Runtime.assert (decide (N - E - 1 + E ≤ N - 1)); Runtime.assert (decide (0 ≤ N - E - 1)); pure (← x.magnitude[N - E - 1 +: E])))) and not (← Std.Bits.Is_Zero (size := ((N - E) - (1 : Int))) (← (do Runtime.assert (decide (N - E - 1 ≤ N - 1)); Runtime.assert (decide (0 ≤ N - E - 1)); pure (← x.magnitude[0 +: N - E - 1]))))

def UFloatIsSNaN {E : Int} {N : Int} (x : UFloat E N) : Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (decide (N ≥ 3) and decide (E ≥ 2) and decide (E ≤ N - 2))
  return (← UFloatIsNaN (E := E) (N := N) x) and (← (do Runtime.assert (decide (N - E - 2 < N - 1)); Runtime.assert (decide (0 ≤ N - E - 2)); pure (← x.magnitude[N - E - 2 +: 1]))) == 0

def UFloatIsSubnormal {E : Int} {N : Int}
    (x : UFloat E N) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (decide (N ≥ 3) and decide (E ≥ 2) and decide (E ≤ N - 2))
  return (← Std.Bits.Is_Zero (size := E) (← (do Runtime.assert (decide (N - E - 1 + E ≤ N - 1)); Runtime.assert (decide (0 ≤ N - E - 1)); pure (← x.magnitude[N - E - 1 +: E])))) and not (← Std.Bits.Is_Zero (size := ((N - E) - (1 : Int))) (← (do Runtime.assert (decide (N - E - 1 ≤ N - 1)); Runtime.assert (decide (0 ≤ N - E - 1)); pure (← x.magnitude[0 +: N - E - 1]))))

def UFloatCompare {E : Int} {N : Int}
    (x y : UFloat E N) :
    Except (Runtime.Error Empty) (FloatCompare) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  Runtime.assert (E == 8 and N == 32 or E == 11 and N == 64)
  if ((← UFloatIsNaN (E := E) (N := N) x) or (← UFloatIsNaN (E := E) (N := N) y)) then
    return FloatCompare.FPCompare_NAN_LEFT
  let a : Int := if x.sign then - Unsigned x.magnitude else Unsigned x.magnitude
  let b : Int := if y.sign then - Unsigned y.magnitude else Unsigned y.magnitude
  if (decide (a < b)) then
    return FloatCompare.FPCompare_LESS
  else
    if (decide (b < a)) then
      return FloatCompare.FPCompare_GREATER
    else
      return FloatCompare.FPCompare_EQUAL

-- Preserve the XML conversion name using the existing standard-library body.
def Bit (x : Bool) : Except (Runtime.Error Empty) (Runtime.Bit) := do
  return (← Std.Boolean.To_Bit x)

def UFloatIsInfinite {E : Int} {N : Int}
    (x : UFloat E N) :
    Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return (← Std.Bits.Is_All_Ones (size := E) (← (do Runtime.assert (decide (N - E - 1 + E ≤ N - 1)); Runtime.assert (decide (0 ≤ N - E - 1)); pure (← x.magnitude[N - E - 1 +: E])))) and (← Std.Bits.Is_Zero (size := ((N - E) - (1 : Int))) (← (do Runtime.assert (decide (N - E - 1 ≤ N - 1)); Runtime.assert (decide (0 ≤ N - E - 1)); pure (← x.magnitude[0 +: N - E - 1]))))

def UFloatIsZero {E : Int} {N : Int} (x : UFloat E N) : Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (0 ≤ E)
  Runtime.assert (0 ≤ N)

  return (← Std.Bits.Is_Zero (size := (N - (1 : Int))) x.magnitude)

end X86.Helpers
