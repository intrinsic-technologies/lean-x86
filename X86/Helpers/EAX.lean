-- Generated from data/definitions.xml.gz: EAX; do not edit.
-- Source SHA256: f8680e4c042a09a8eb905368f57d8521012ce706fb0f52727d6bcd0b087c19c9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EAX)
import X86.Runtime
import X86.Helpers.Registers
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def EAX  : Runtime.SpecM Exception (State σ) (Bits 32) := do
  return (← sliceInclusive (← RAX) 31 0)

def EAX_write (value : Bits 32) : Runtime.SpecM Exception (State σ) Unit := do
  RAX_write (← Std.Bits.Zero_Extend (source_size := 32) value 64)

end X86.Helpers
