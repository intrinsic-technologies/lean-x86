-- Generated from data/definitions.xml.gz: FP::Arithmetic; do not edit.
-- Source SHA256: c85d51711d4e7936aafb67a398065a5be53d84f71f2d29cfa70f7f4b48b11c00
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AArithmetic)
import X86.Runtime
import X86.Helpers.FP.Arithmetic_Op_Type
import X86.Helpers.FP.Pack
import X86.Helpers.FP.Rounding_Context
import X86.Helpers.FP.Unpack
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Rounding_Mode
import X86.Helpers.UFloatCompare
import X86.Helpers.UFloatMul
import X86.Helpers.UFloatRound
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP.Arithmetic {N : Int}
    (op : «FP::Arithmetic_Op_Type») (x y : Bits N) (denormals_are_zeros : Bool) (rm : Rounding_Mode) (flush_subnormals mask_underflow : Bool) :
    Runtime.SpecM Exception (State σ) (Bits N × FP_Exception_Flags_Type) := do
  Runtime.assert (N == 16 || N == 32 || N == 64)

  Runtime.assert ((N == (16 : Int)) || (N == (32 : Int)) || (N == (64 : Int)))
  let E : Int := if N == 16 then 5 else if N == 32 then 8 else 11

  let ux : UFloat E N ← FP.Unpack (size := N) x E denormals_are_zeros
  let uy : UFloat E N ← FP.Unpack (size := N) y E denormals_are_zeros
  let ctx : RoundingContext E N ← FP.Rounding_Context E N rm flush_subnormals

  let ur : UFloat E N ← do
    if (← UFloatIsNaN (E := E) (N := N) ux) then
      let ur : UFloat E N ← UFloatRound (Ex := E) (Nx := N) (Er := E) (Nr := N) ux ctx
      pure ur
    else
      if (← UFloatIsNaN (E := E) (N := N) uy) then
        let ur : UFloat E N ← UFloatRound (Ex := E) (Nx := N) (Er := E) (Nr := N) uy ctx
        pure ur
      else
        let mut ur : UFloat E N ←
          match op with
          | «FP::Arithmetic_Op_Type».FP_ADD => do
            pure (← UFloatAdd (E := E) (N := N) ux uy ctx)
          | «FP::Arithmetic_Op_Type».FP_SUB => do
            pure (← UFloatSub (E := E) (N := N) ux uy ctx)
          | «FP::Arithmetic_Op_Type».FP_MUL => do
            pure (← UFloatMul (E := E) (N := N) ux uy ctx)
          | «FP::Arithmetic_Op_Type».FP_DIV => do
            pure (← UFloatDiv (E := E) (N := N) ux uy ctx)
        pure ur

  let r : Bits N ← FP.Pack (size := N) (e_size := E) ur

  let is_div_zero : Bool := op == «FP::Arithmetic_Op_Type».FP_DIV and not ux.isnan and not ux.isinf and not (← UFloatIsZero (E := E) (N := N) ux) and (← UFloatIsZero (E := E) (N := N) uy)

  let exceptions_bits_0_0 : Runtime.Bit ← Bit ((← (do
    let operand := ur.invalid
    let operand_1 := some (← UFloatIsSNaN (E := E) (N := N) ux)
    let value ← Runtime.readInitialized operand
    let value_1 ← Runtime.readInitialized operand_1
    pure (value or value_1))) or (← UFloatIsSNaN (E := E) (N := N) uy))
  let exceptions_bits_1_1 : Runtime.Bit ← Bit (not is_div_zero and not ux.isnan and not uy.isnan and ((← UFloatIsSubnormal (E := E) (N := N) ux) or (← UFloatIsSubnormal (E := E) (N := N) uy)))
  let exceptions_bits_2_2 : Runtime.Bit ← Bit is_div_zero
  let exceptions_bits_3_3 : Runtime.Bit ← Bit (not is_div_zero and ((← Runtime.readInitialized ur.overflow) or (← UFloatIsInfinite (E := E) (N := N) ur) and not (← UFloatIsInfinite (E := E) (N := N) ux) and not (← UFloatIsInfinite (E := E) (N := N) uy)))
  let exceptions_bits_4_4 : Runtime.Bit ← Bit ((← Runtime.readInitialized ur.underflow) or (← UFloatIsSubnormal (E := E) (N := N) ur) and (not mask_underflow or (← UFloatIsInexact (E := E) (N := N) ur)))

  -- When overflow is masked (MXCSR.OM=1), the masked response (saturating
  -- to infinity or max-finite) always loses information relative to the
  -- true result, so `ur.inexact` is (correctly) forced True by
  -- UFloatRoundFinalize. When overflow is unmasked (MXCSR.OM=0), the
  -- precision (#P) exception must instead reflect only whether the
  -- significand itself required rounding, independent of the exponent
  -- range clamping -- that value is preserved in `ur.inexact_significand`.
  -- The same reasoning applies symmetrically to underflow/subnormal
  -- clamping when underflow is unmasked (MXCSR.UM=0, i.e. mask_underflow
  -- is False).
  let exceptions_bits_5_5 : Runtime.Bit ← do
    if (← Runtime.readInitialized ur.overflow) and (← MXCSR.OM) == 0 or (← Runtime.readInitialized ur.underflow) and not mask_underflow then
      Bit (← Runtime.readInitialized ur.inexact_significand)
    else
      Bit (← Runtime.readInitialized ur.inexact)
  let exceptions : FP_Exception_Flags_Type ← concatBits (leftSize := 1) (rightSize := 5) exceptions_bits_5_5 (← concatBits (leftSize := 1) (rightSize := 4) exceptions_bits_4_4 (← concatBits (leftSize := 1) (rightSize := 3) exceptions_bits_3_3 (← concatBits (leftSize := 1) (rightSize := 2) exceptions_bits_2_2 (← concatBits (leftSize := 1) (rightSize := 1) exceptions_bits_1_1 exceptions_bits_0_0))))

  return (r, exceptions)

end X86.Helpers
