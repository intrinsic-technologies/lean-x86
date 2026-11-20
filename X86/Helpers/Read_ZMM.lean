-- Generated from data/definitions.xml.gz: Read_ZMM; do not edit.
-- Source SHA256: 91eb716e4e77414f2ac7cfc7a6b6b0f9e7b76996f82bce80ea6a9c032ad66eef
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Read_ZMM)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Read_ZMM (rrrrr : Bits 5) : Runtime.SpecM Exception (State σ) (Bits 512) := do
  -- upper regs not accessible outside of 64-bit mode
  let index : Bits 5 ← do
    if (← In_64Bit_Mode) then
      pure rrrrr
    else
      concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) (← rrrrr[2:0])
  return (← (do Runtime.assert (decide (Unsigned index < 32)); Runtime.assert (decide (0 ≤ Unsigned index)); pure (← ZMM.get (Unsigned index))))

end X86.Helpers
