-- Generated from data/definitions.xml.gz: FP87::Is_Round_Up; do not edit.
-- Source SHA256: ee3578740caa43ae7596b1ca334db7b681e427c7277d49d643dc965329752721
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AIs_Round_Up)
import X86.Runtime
import X86.Helpers.FP87.Get_Rounding_Mode
import X86.Helpers.Rounding_Mode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Is_Round_Up (sign L R S : Runtime.Bit) : Runtime.SpecM Exception (State σ) (Bool) := do
  let rounding_mode : Rounding_Mode ← FP87.Get_Rounding_Mode

  let round_up : Bool := if rounding_mode == Rounding_Mode.Rounding_Mode_RNE then R == 1 and (L == 1 or S == 1) else if rounding_mode == Rounding_Mode.Rounding_Mode_RTN then sign == 1 and (R == 1 or S == 1) else if rounding_mode == Rounding_Mode.Rounding_Mode_RTP then sign == 0 and (R == 1 or S == 1) else false

  return round_up

end X86.Helpers
