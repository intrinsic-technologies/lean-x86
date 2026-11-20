-- Generated from data/definitions.xml.gz: EBX; do not edit.
-- Source SHA256: d148e252ea79e12add9be4e53589ddaea3ebb3d6b1ccc425fac8312ef5ecb699
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EBX)
import X86.Runtime
import X86.Helpers.Registers
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def EBX  : Runtime.SpecM Exception (State σ) (Bits 32) := do
  return (← sliceInclusive (← RBX) 31 0)

end X86.Helpers
