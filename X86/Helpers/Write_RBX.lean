-- Generated from data/definitions.xml.gz: Write_RBX; do not edit.
-- Source SHA256: de9eea5f0b3c24289fa5f4a8212a1e43f06ad953b6c94d5b24337ea793526230
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_RBX)
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

def Write_RBX {size : Int} (value : Bits size) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  RBX_write (← Merge_GPR (size := size) value (← RBX))

end X86.Helpers
