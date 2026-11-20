-- Generated from data/definitions.xml.gz: FP::Sqrt; do not edit.
-- Source SHA256: a91a2e033f92aef2ae652f3454781cfd892fc56edb4a7585edebdacddb5c9615
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3ASqrt)
import X86.Runtime
import X86.Helpers.FP.Pack
import X86.Helpers.FP.Rounding_Context
import X86.Helpers.FP.Unpack
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Rounding_Mode
import X86.Helpers.UFloatCompare
import X86.Helpers.UFloatRound
import X86.Helpers.UFloatSqrt
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP.Sqrt {N : Int}
    (x : Bits N) (denormals_are_zeros : Bool) (rm : Rounding_Mode) (flush_subnormals : Bool) :
    Runtime.SpecM Exception (State σ) (Bits N × FP_Exception_Flags_Type) := do
  Runtime.assert (N == 16 || N == 32 || N == 64)

  Runtime.assert ((N == (16 : Int)) || (N == (32 : Int)) || (N == (64 : Int)))
  let E : Int := if N == 16 then 5 else if N == 32 then 8 else 11
  let ctx : RoundingContext E N ← FP.Rounding_Context E N rm flush_subnormals
  let ux : UFloat E N ← FP.Unpack (size := N) x E denormals_are_zeros
  let ur : UFloat E N ← UFloatSqrt (E := E) (N := N) ux ctx
  let r : Bits N ← FP.Pack (size := N) (e_size := E) ur

  let exceptions_bits_0_0 : Runtime.Bit ← Bit (ux.sign and not (← UFloatIsQNaN (E := E) (N := N) ux) and not (← UFloatIsZero (E := E) (N := N) ux) or (← UFloatIsSNaN (E := E) (N := N) ux))
  let exceptions_bits_1_1 : Runtime.Bit ← Bit ((← UFloatIsSubnormal (E := E) (N := N) ux) and not ux.sign)
  let exceptions_bits_5_5 : Runtime.Bit ← Bit (← UFloatIsInexact (E := E) (N := N) ur)
  let exceptions : FP_Exception_Flags_Type ← concatBits (leftSize := 1) (rightSize := 5) exceptions_bits_5_5 (← concatBits (leftSize := 1) (rightSize := 4) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 3) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 2) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 1) exceptions_bits_1_1 exceptions_bits_0_0))))

  return (r, exceptions)

end X86.Helpers
