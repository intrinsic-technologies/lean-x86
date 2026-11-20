-- Generated from data/definitions.xml.gz: Read_YMM; do not edit.
-- Source SHA256: 73d958101c06de77bd8d041358222bd54b57bcd35354a64bac4ad085f867a5e0
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Read_YMM)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.YMM
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Read_YMM (rrrrr : Bits 5) : Runtime.SpecM Exception (State σ) (Bits 256) := do
  -- upper regs not accessible outside of 64-bit mode
  let index : Bits 5 ← do
    if (← In_64Bit_Mode) then
      pure rrrrr
    else
      concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) (← rrrrr[2:0])
  return (← YMM (Unsigned index))

end X86.Helpers
