-- Generated from data/definitions.xml.gz: Write_RDI; do not edit.
-- Source SHA256: 4ea0320a81fd450cb51b2230044a9a5a8716d5a0dc3f1d115c72454a9817d9c6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_RDI)
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

def Write_RDI {size : Int} (value : Bits size) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  RDI_write (← Merge_GPR (size := size) value (← RDI))

end X86.Helpers
