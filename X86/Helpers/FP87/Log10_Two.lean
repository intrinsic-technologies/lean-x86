-- Generated from data/definitions.xml.gz: FP87::Log10_Two; do not edit.
-- Source SHA256: 4ca072d0dcc8bf78dedf9f909205a2307b057a72483544b32f33738db4215901
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ALog10_Two)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Get_Rounding_Mode
import X86.Helpers.Rounding_Mode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Log10_Two  : Runtime.SpecM Exception (State σ) (F80_Type) := do
  let mut log10_2 : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80

  match (← FP87.Get_Rounding_Mode) with
  | Rounding_Mode.Rounding_Mode_RTN | Rounding_Mode.Rounding_Mode_RTZ => do
    log10_2 := (← F80_Type.setMantissa.partial log10_2 (11106046577046714264 : Bits 64))
  | Rounding_Mode.Rounding_Mode_RNE | Rounding_Mode.Rounding_Mode_RTP => do
    log10_2 := (← F80_Type.setMantissa.partial log10_2 (11106046577046714265 : Bits 64))

  log10_2 := (← F80_Type.setExponent.partial log10_2 (← (16381 : Bits 16)[0 +: 15]))
  log10_2 := (← F80_Type.setSign.partial log10_2 (0 : Runtime.Bit))
  return (← Runtime.InitializedBits.read log10_2)

end X86.Helpers
