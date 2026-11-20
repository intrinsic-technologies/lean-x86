-- Generated from data/definitions.xml.gz: FP::Min_Max; do not edit.
-- Source SHA256: d044380489bf5bc30b24a4cff4aa15ac02b92f640ad3ca18ce439a1a6ec64bb8
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AMin_Max)
import X86.Runtime
import X86.Helpers.FP.Pack
import X86.Helpers.FP.Unpack
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.UFloatCompare
import X86.Helpers.UFloatOrdered
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP.Min_Max {N : Int}
    (is_max : Bool) (x y : Bits N) (denormals_are_zeros : Bool) :
    Runtime.SpecM Exception (State σ) (Bits N × FP_Exception_Flags_Type) := do
  Runtime.assert (N == 16 || N == 32 || N == 64)

  Runtime.assert ((N == (16 : Int)) || (N == (32 : Int)) || (N == (64 : Int)))
  let E : Int := if N == 16 then 5 else if N == 32 then 8 else 11
  let ux : UFloat E N ← FP.Unpack (size := N) x E denormals_are_zeros
  let uy : UFloat E N ← FP.Unpack (size := N) y E denormals_are_zeros

  let ur : UFloat E N ← do
    if (← UFloatIsZero (E := E) (N := N) ux) and (← UFloatIsZero (E := E) (N := N) uy) or (ux.isnan or uy.isnan) then
      let ur : UFloat E N := uy
      pure ur
    else
      let ur : UFloat E N ← do
        if is_max then
          UFloatMax (E := E) (N := N) ux uy
        else
          UFloatMin (E := E) (N := N) ux uy
      pure ur

  let r : Bits N ← FP.Pack (size := N) (e_size := E) ur

  let exceptions_bits_0_0 : Runtime.Bit ← Bit ((← UFloatIsNaN (E := E) (N := N) ux) or (← UFloatIsNaN (E := E) (N := N) uy))
  let exceptions_bits_1_1 : Runtime.Bit ← Bit (not ux.isnan and not uy.isnan and ((← UFloatIsSubnormal (E := E) (N := N) ux) or (← UFloatIsSubnormal (E := E) (N := N) uy)))
  let exceptions : FP_Exception_Flags_Type ← concatBits (leftSize := 1) (rightSize := 5) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 4) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 3) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 2) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 1) exceptions_bits_1_1 exceptions_bits_0_0))))

  return (r, exceptions)

end X86.Helpers
