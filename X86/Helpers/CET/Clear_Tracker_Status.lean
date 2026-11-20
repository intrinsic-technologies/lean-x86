-- Generated from data/definitions.xml.gz: CET::Clear_Tracker_Status; do not edit.
-- Source SHA256: bb51b1c8c9ba41f5604f8ca6b89a8986c052b91f6e9bbd05a720a44130fb63d3
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3AClear_Tracker_Status)
import X86.Runtime
import X86.Helpers.IA32_CET
import X86.Helpers.Is_End_Branch_Enabled
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def CET.Clear_Tracker_Status  : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (← Is_End_Branch_Enabled (← get).CPL)

  let index := (← get).CPL
  let mut IA32_CET_target ← IA32_CET index
  IA32_CET_target := { IA32_CET_target with TRACKER := (0 : Runtime.Bit) }
  IA32_CET_write index IA32_CET_target
  let index_1 := (← get).CPL
  let mut IA32_CET_target_1 ← IA32_CET index_1
  IA32_CET_target_1 := { IA32_CET_target_1 with SUPPRESS := (0 : Runtime.Bit) }
  IA32_CET_write index_1 IA32_CET_target_1

  modify ({ · with CET_Tracker_Updated := true })

end X86.Helpers
