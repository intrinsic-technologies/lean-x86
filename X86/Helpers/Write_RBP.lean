-- Generated from data/definitions.xml.gz: Write_RBP; do not edit.
-- Source SHA256: 3bf4d9708a41651f708750b238a29e042f06a8248c7e7a23f4de3de442bb9e21
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_RBP)
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

def Write_RBP {size : Int} (value : Bits size) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  RBP_write (← Merge_GPR (size := size) value (← RBP))

end X86.Helpers
