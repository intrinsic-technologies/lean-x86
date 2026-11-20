-- Generated from data/definitions.xml.gz: Write_Mask; do not edit.
-- Source SHA256: e1dd60d02b19d0f4827246662f8c0d43ca724b5199b25149a391c836bd1a265c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_Mask)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def Write_Mask (rrr : Bits 3) (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (decide (Unsigned rrr < 8))
  Runtime.assert (decide (0 ≤ Unsigned rrr))
  K.set (Unsigned rrr) value

end X86.Helpers
