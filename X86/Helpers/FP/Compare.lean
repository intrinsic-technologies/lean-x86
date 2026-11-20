-- Generated from data/definitions.xml.gz: FP::Compare; do not edit.
-- Source SHA256: 8922d9c0634fd308603f8459afba760fa07d08cebd88f40f92925d5c3a41add0
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3ACompare)
import X86.Runtime
import X86.Helpers.FP.Unpack
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.UFloatCompare
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP.Compare {N : Int}
    (x y : Bits N) (signalling denormals_are_zeros : Bool) :
    Runtime.SpecM Exception (State σ) (Bits 3 × FP_Exception_Flags_Type) := do
  Runtime.assert (N == 16 || N == 32 || N == 64)

  Runtime.assert ((N == (16 : Int)) || (N == (32 : Int)) || (N == (64 : Int)))
  let E : Int := if N == 16 then 5 else if N == 32 then 8 else 11
  let ux : UFloat E N ← FP.Unpack (size := N) x E denormals_are_zeros
  let uy : UFloat E N ← FP.Unpack (size := N) y E denormals_are_zeros

  let mut zpc : Bits 3 ←
    match (← UFloatCompare (E := E) (N := N) ux uy) with
    | FloatCompare.FPCompare_GREATER => do
      pure 0
    | FloatCompare.FPCompare_LESS => do
      pure 1
    | FloatCompare.FPCompare_EQUAL | FloatCompare.FPCompare_ZERO_GREATER | FloatCompare.FPCompare_ZERO_LESS => do
      pure 4
    | FloatCompare.FPCompare_NAN_LEFT | FloatCompare.FPCompare_NAN_RIGHT | FloatCompare.FPCompare_NAN_SIGN_LESS | FloatCompare.FPCompare_NAN_SIGN_GREATER | FloatCompare.FPCompare_NAN_MANTISSA_LESS | FloatCompare.FPCompare_NAN_MANTISSA_GREATER | FloatCompare.FPCompare_NAN_EQUAL => do
      pure 7

  let exceptions_bits_0_0 : Runtime.Bit ← do
    if signalling then
      Bit ((← UFloatIsNaN (E := E) (N := N) ux) or (← UFloatIsNaN (E := E) (N := N) uy))
    else
      Bit ((← UFloatIsSNaN (E := E) (N := N) ux) or (← UFloatIsSNaN (E := E) (N := N) uy))
  let exceptions_bits_1_1 : Runtime.Bit ← Bit ((← UFloatIsSubnormal (E := E) (N := N) ux) and not (← UFloatIsNaN (E := E) (N := N) uy) or (← UFloatIsSubnormal (E := E) (N := N) uy) and not (← UFloatIsNaN (E := E) (N := N) ux))
  let exceptions : FP_Exception_Flags_Type ← concatBits (leftSize := 1) (rightSize := 5) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 4) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 3) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 2) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 1) exceptions_bits_1_1 exceptions_bits_0_0))))

  return (zpc, exceptions)

end X86.Helpers
