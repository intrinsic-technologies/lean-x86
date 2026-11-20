-- Generated from data/definitions.xml.gz: Write_ZMM; do not edit.
-- Source SHA256: b5f8715584704d9bc52ecb337a0a449af0c02b1f7be04f0f0ce4d4367ac52042
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_ZMM)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Write_ZMM (rrrrr : Bits 5) (value : Bits 512) : Runtime.SpecM Exception (State σ) Unit := do
  -- upper regs not accessible outside of 64-bit mode
  let index : Bits 5 ← do
    if (← In_64Bit_Mode) then
      pure rrrrr
    else
      concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) (← rrrrr[2:0])
  Runtime.assert (decide (Unsigned index < 32))
  Runtime.assert (decide (0 ≤ Unsigned index))
  ZMM.set (Unsigned index) value

end X86.Helpers
