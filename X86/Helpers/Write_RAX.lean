-- Generated from data/definitions.xml.gz: Write_RAX; do not edit.
-- Source SHA256: 42ce2c16121542fa71f92676c82811a4b8dcccb1224b2528cc9f4fdc58de018e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_RAX)
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

def Write_RAX {size : Int} (value : Bits size) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  RAX_write (← Merge_GPR (size := size) value (← RAX))

end X86.Helpers
