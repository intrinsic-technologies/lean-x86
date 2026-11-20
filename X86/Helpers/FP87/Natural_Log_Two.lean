-- Generated from data/definitions.xml.gz: FP87::Natural_Log_Two; do not edit.
-- Source SHA256: 5718d945b0b50364e85fd6c65e3dd6e21701cc8765dcdd3d37a7dde57239b5ea
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ANatural_Log_Two)
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

def FP87.Natural_Log_Two  : Runtime.SpecM Exception (State σ) (F80_Type) := do
  let mut log_2 : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80

  match (← FP87.Get_Rounding_Mode) with
  | Rounding_Mode.Rounding_Mode_RTN | Rounding_Mode.Rounding_Mode_RTZ => do
    log_2 := (← F80_Type.setMantissa.partial log_2 (12786308645202655659 : Bits 64))
  | Rounding_Mode.Rounding_Mode_RNE | Rounding_Mode.Rounding_Mode_RTP => do
    log_2 := (← F80_Type.setMantissa.partial log_2 (12786308645202655660 : Bits 64))

  log_2 := (← F80_Type.setExponent.partial log_2 (← (16382 : Bits 16)[0 +: 15]))
  log_2 := (← F80_Type.setSign.partial log_2 (0 : Runtime.Bit))
  return (← Runtime.InitializedBits.read log_2)

end X86.Helpers
