-- Generated from data/definitions.xml.gz: Write_RCX; do not edit.
-- Source SHA256: 08e5bb1c8f1a7fa0ccb142b6829f2211088fbd99d4007cbbf566c16a20dfcd53
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_RCX)
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

def Write_RCX {size : Int} (value : Bits size) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  RCX_write (← Merge_GPR (size := size) value (← RCX))

end X86.Helpers
