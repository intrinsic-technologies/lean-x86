-- Generated from data/definitions.xml.gz: FP::Convert; do not edit.
-- Source SHA256: ea388c450a636124ffebaaca59ef9b0aa1b621a535e7a0b192290618f8d80bd1
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AConvert)
import X86.Runtime
import X86.Helpers.FP.Pack
import X86.Helpers.FP.Rounding_Context
import X86.Helpers.FP.Unpack
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Rounding_Mode
import X86.Helpers.UFloatCompare
import X86.Helpers.UFloatRound
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP.Convert {N : Int}
    (x : Bits N) (M : Int) (denormals_are_zeros : Bool) (rm : Rounding_Mode) (flush_subnormals : Bool) :
    Runtime.SpecM Exception (State σ) (Bits M × FP_Exception_Flags_Type) := do
  Runtime.assert (N == 16 || N == 32 || N == 64)
  Runtime.assert (M == 16 || M == 32 || M == 64)

  let Ex : Int := if N == 16 then 5 else if N == 32 then 8 else 11
  let Er : Int := if M == 16 then 5 else if M == 32 then 8 else 11
  let ctx : RoundingContext Er M ← FP.Rounding_Context Er M rm flush_subnormals
  let ux : UFloat Ex N ← FP.Unpack (size := N) x Ex denormals_are_zeros
  let ur : UFloat Er M ← UFloatRound (Ex := Ex) (Nx := N) (Er := Er) (Nr := M) ux ctx
  let r : Bits M ← FP.Pack (size := M) (e_size := Er) ur

  let exceptions_bits_0_0 : Runtime.Bit ← Bit (← UFloatIsSNaN (E := Ex) (N := N) ux)
  let exceptions_bits_1_1 : Runtime.Bit ← Bit (← UFloatIsSubnormal (E := Ex) (N := N) ux)
  let exceptions_bits_3_3 : Runtime.Bit ← Bit (← Runtime.readInitialized ur.overflow)
  let exceptions_bits_4_4 : Runtime.Bit ← Bit (← Runtime.readInitialized ur.underflow)

  -- When overflow/underflow is masked, the masked response (saturating to
  -- infinity/max-finite, or clamping into the subnormal range) always loses
  -- information relative to the true result, so `ur.inexact` is (correctly)
  -- forced True. When overflow/underflow is unmasked, the precision (#P)
  -- exception must instead reflect only whether the significand itself
  -- required rounding, independent of the exponent range clamping -- that
  -- value is preserved in `ur.inexact_significand`.
  -- This mirrors the equivalent logic in FP::Arithmetic.
  let exceptions_bits_5_5 : Runtime.Bit ← do
    if (← Runtime.readInitialized ur.overflow) and (← MXCSR.OM) == 0 or (← Runtime.readInitialized ur.underflow) and (← MXCSR.UM) == 0 then
      Bit (← Runtime.readInitialized ur.inexact_significand)
    else
      Bit (← UFloatIsInexact (E := Er) (N := M) ur)
  let exceptions : FP_Exception_Flags_Type ← concatBits (leftSize := 1) (rightSize := 5) exceptions_bits_5_5 (← concatBits (leftSize := 1) (rightSize := 4) exceptions_bits_4_4 (← concatBits (leftSize := 1) (rightSize := 3) exceptions_bits_3_3 (← concatBits (leftSize := 1) (rightSize := 2) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 1) exceptions_bits_1_1 exceptions_bits_0_0))))

  return (r, exceptions)

end X86.Helpers
