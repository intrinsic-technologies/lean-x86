-- Generated from data/definitions.xml.gz: CET::Set_Tracker_Status; do not edit.
-- Source SHA256: 1fc15fe1b3a36eb69c6b44df3e6d70ad5513ade852d6bb977985ba236264b2a9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3ASet_Tracker_Status)
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

def CET.Set_Tracker_Status (new_cpl : Int) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (new_cpl in {0..3})

  Runtime.assert (← Is_End_Branch_Enabled new_cpl)

  let mut IA32_CET_target ← IA32_CET new_cpl
  IA32_CET_target := { IA32_CET_target with TRACKER := (1 : Runtime.Bit) }
  IA32_CET_write new_cpl IA32_CET_target
  let mut IA32_CET_target_1 ← IA32_CET new_cpl
  IA32_CET_target_1 := { IA32_CET_target_1 with SUPPRESS := (0 : Runtime.Bit) }
  IA32_CET_write new_cpl IA32_CET_target_1

  modify ({ · with CET_Tracker_Updated := true })

end X86.Helpers
