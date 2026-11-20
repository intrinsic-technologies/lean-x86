-- Generated from data/definitions.xml.gz: EDX; do not edit.
-- Source SHA256: edc62125c4522bdf525fecfde6970619bbefb54fbe210ad5f7c55d0a56895976
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EDX)
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

def EDX  : Runtime.SpecM Exception (State σ) (Bits 32) := do
  return (← sliceInclusive (← RDX) 31 0)

def EDX_write (value : Bits 32) : Runtime.SpecM Exception (State σ) Unit := do
  RDX_write (← Std.Bits.Zero_Extend (source_size := 32) value 64)

end X86.Helpers
