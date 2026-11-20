-- Generated from data/definitions.xml.gz: Read_XMM; do not edit.
-- Source SHA256: e79e89b4f738fd0fe6978c37dcecb8bbf28bd445a07b26c6db7ad5a3d454caeb
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Read_XMM)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.XMM
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Read_XMM (rrrrr : Bits 5) (size : Int) : Runtime.SpecM Exception (State σ) (Bits size) := do
  Runtime.assert (0 ≤ size)

  -- upper regs not accessible outside of 64-bit mode
  let index : Bits 5 ← do
    if (← In_64Bit_Mode) then
      pure rrrrr
    else
      concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) (← rrrrr[2:0])
  Runtime.assert (decide (size ≤ 128))
  return (← Runtime.CheckedSlice.read (← XMM (Unsigned index)) 0 size)

end X86.Helpers
