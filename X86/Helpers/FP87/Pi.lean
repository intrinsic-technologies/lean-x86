-- Generated from data/definitions.xml.gz: FP87::Pi; do not edit.
-- Source SHA256: f105956100941aeb5f5649789bf2e0fb1e4bee525456c53f9bf8060932f3b761
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3APi)
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

def FP87.Pi  : Runtime.SpecM Exception (State σ) (F80_Type) := do
  let mut pi : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80

  match (← FP87.Get_Rounding_Mode) with
  | Rounding_Mode.Rounding_Mode_RTN | Rounding_Mode.Rounding_Mode_RTZ => do
    pi := (← F80_Type.setMantissa.partial pi (14488038916154245684 : Bits 64))
  | Rounding_Mode.Rounding_Mode_RNE | Rounding_Mode.Rounding_Mode_RTP => do
    pi := (← F80_Type.setMantissa.partial pi (14488038916154245685 : Bits 64))

  pi := (← F80_Type.setExponent.partial pi (← (16384 : Bits 16)[0 +: 15]))
  pi := (← F80_Type.setSign.partial pi (0 : Runtime.Bit))
  return (← Runtime.InitializedBits.read pi)

end X86.Helpers
