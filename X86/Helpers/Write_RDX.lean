-- Generated from data/definitions.xml.gz: Write_RDX; do not edit.
-- Source SHA256: 93f761ae5619473d4aed466ba9d73ee0e93c8dfbd5a015000975918ba38ebf0c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_RDX)
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

def Write_RDX {size : Int} (value : Bits size) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  RDX_write (← Merge_GPR (size := size) value (← RDX))

end X86.Helpers
