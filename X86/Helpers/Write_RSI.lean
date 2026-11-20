-- Generated from data/definitions.xml.gz: Write_RSI; do not edit.
-- Source SHA256: 15f7b868f5fbcaa42f3034a24c7a9191dcc54ae9336fde6634c994688bee5134
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_RSI)
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

def Write_RSI {size : Int} (value : Bits size) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  RSI_write (← Merge_GPR (size := size) value (← RSI))

end X86.Helpers
