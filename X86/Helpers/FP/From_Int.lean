-- Generated from data/definitions.xml.gz: FP::From_Int; do not edit.
-- Source SHA256: bbd93f9a7b8c13f364c334d7893ab172ed80f933da86a62a701887904805a909
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AFrom_Int)
import X86.Runtime
import X86.Helpers.FP.Pack
import X86.Helpers.FP.Rounding_Context
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.IntegerToUFloat
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

def FP.From_Int {source_size : Int}
    (x : Bits source_size) (is_signed : Bool) (target_size : Int) (rm : Rounding_Mode) :
    Runtime.SpecM Exception (State σ) (Bits target_size × FP_Exception_Flags_Type) := do
  Runtime.assert (source_size == 16 || source_size == 32 || source_size == 64)
  Runtime.assert (target_size == 16 || target_size == 32 || target_size == 64)

  let e_size : Int := if target_size == 16 then 5 else if target_size == 32 then 8 else 11
  let ctx : RoundingContext e_size target_size ← FP.Rounding_Context e_size target_size rm true
  let ur : UFloat e_size target_size ← do
    if is_signed then
      SignedToUFloat (E := e_size) (N := target_size) (width := source_size) ctx x
    else
      UnsignedToUFloat (E := e_size) (N := target_size) (width := source_size) ctx x
  let r : Bits target_size ← FP.Pack (size := target_size) (e_size := e_size) ur

  let exceptions_bits_3_3 : Runtime.Bit ← Bit (← Runtime.readInitialized ur.overflow)
  let exceptions_bits_4_4 : Runtime.Bit ← Bit (← Runtime.readInitialized ur.underflow)
  let exceptions_bits_5_5 : Runtime.Bit ← Bit (← UFloatIsInexact (E := e_size) (N := target_size) ur)
  let exceptions : FP_Exception_Flags_Type ← concatBits (leftSize := 1) (rightSize := 5) exceptions_bits_5_5 (← concatBits (leftSize := 1) (rightSize := 4) exceptions_bits_4_4 (← concatBits (leftSize := 1) (rightSize := 3) exceptions_bits_3_3 (← concatBits (leftSize := 1) (rightSize := 2) (0 : Runtime.Bit) (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (0 : Runtime.Bit)))))

  return (r, exceptions)

end X86.Helpers
