-- Generated from data/definitions.xml.gz: Write_RSP; do not edit.
-- Source SHA256: 0ee65d49c4f3c340530ca64004709909e48081c99db740474cc0ede24c8476df
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_RSP)
import X86.Runtime
import X86.Helpers.Merge_GPR
import X86.Helpers.Registers
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Write_RSP {size : Int} (value : Bits size) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  RSP_write (← Merge_GPR (size := size) value (← RSP))

end X86.Helpers
