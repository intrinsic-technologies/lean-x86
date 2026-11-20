-- Generated from data/definitions.xml.gz: FP87::Log2_e; do not edit.
-- Source SHA256: 681b93837ee113e716d9a56c35854b01f65c605bc281f7bbdb5a51142f1d8b29
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ALog2_e)
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

def FP87.Log2_e  : Runtime.SpecM Exception (State σ) (F80_Type) := do
  let mut log2_e : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80

  match (← FP87.Get_Rounding_Mode) with
  | Rounding_Mode.Rounding_Mode_RTN | Rounding_Mode.Rounding_Mode_RTZ => do
    log2_e := (← F80_Type.setMantissa.partial log2_e (13306513097844322491 : Bits 64))
  | Rounding_Mode.Rounding_Mode_RNE | Rounding_Mode.Rounding_Mode_RTP => do
    log2_e := (← F80_Type.setMantissa.partial log2_e (13306513097844322492 : Bits 64))

  log2_e := (← F80_Type.setExponent.partial log2_e (← (16383 : Bits 16)[0 +: 15]))
  log2_e := (← F80_Type.setSign.partial log2_e (0 : Runtime.Bit))
  return (← Runtime.InitializedBits.read log2_e)

end X86.Helpers
