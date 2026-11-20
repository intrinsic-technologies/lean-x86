-- Generated from data/definitions.xml.gz: ECX; do not edit.
-- Source SHA256: 0ea82ce3a6a86af0859bee6dd1f3a68a1a03c45e59be35166cfc25bf8bf43ccb
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=ECX)
import X86.Runtime
import X86.Helpers.Registers
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def ECX  : Runtime.SpecM Exception (State σ) (Bits 32) := do
  return (← sliceInclusive (← RCX) 31 0)

end X86.Helpers
