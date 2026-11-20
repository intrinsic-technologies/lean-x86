-- Generated from data/definitions.xml.gz: FP87::Log2_Ten; do not edit.
-- Source SHA256: 7eaf62516537880e9d84bacf7903177b9ffec3f86e15461def40ca9b9f147823
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ALog2_Ten)
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

def FP87.Log2_Ten  : Runtime.SpecM Exception (State σ) (F80_Type) := do
  let mut log2_10 : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80

  match (← FP87.Get_Rounding_Mode) with
  | Rounding_Mode.Rounding_Mode_RNE | Rounding_Mode.Rounding_Mode_RTN | Rounding_Mode.Rounding_Mode_RTZ => do
    log2_10 := (← F80_Type.setMantissa.partial log2_10 (15319689349413178110 : Bits 64))
  | Rounding_Mode.Rounding_Mode_RTP => do
    log2_10 := (← F80_Type.setMantissa.partial log2_10 (15319689349413178111 : Bits 64))

  log2_10 := (← F80_Type.setExponent.partial log2_10 (← (16384 : Bits 16)[0 +: 15]))
  log2_10 := (← F80_Type.setSign.partial log2_10 (0 : Runtime.Bit))
  return (← Runtime.InitializedBits.read log2_10)

end X86.Helpers
