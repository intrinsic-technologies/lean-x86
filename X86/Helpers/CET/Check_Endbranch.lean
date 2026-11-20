-- Generated from data/definitions.xml.gz: CET::Check_Endbranch; do not edit.
-- Source SHA256: a9db5faf29d2b1c7b7d5676db28ae92e59c94185ef234312e24f08c88688da03
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3ACheck_Endbranch)
import X86.Runtime
import X86.Helpers.CET.Is_Allowed_By_Legacy_Compatibility_Treatment
import X86.Helpers.CP_Error_Code
import X86.Helpers.IA32_CET
import X86.Helpers.Report_Control_Protection_Exception
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]

def CET.Check_Endbranch (cpl : Int) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (cpl in {0..3})

  if (← get).CET_Tracker_Updated then
    -- current step/instruction updated the CET tracker state
    -- don't check for ENDBRANCH
    return ()

  let cet_msr : IA32_U_CET_Type ← IA32_CET cpl
  if (cet_msr.TRACKER == 1 and cet_msr.SUPPRESS == 0 and cet_msr.ENDBR_EN == 1) then
    if (not (← CET.Is_Allowed_By_Legacy_Compatibility_Treatment cpl)) then
      Report_Control_Protection_Exception CP_Error_Code.ENDBRANCH
    else
      let mut IA32_CET_target ← IA32_CET cpl
      IA32_CET_target := { IA32_CET_target with TRACKER := (0 : Runtime.Bit) }
      IA32_CET_write cpl IA32_CET_target
      let IA32_CET_SUPPRESS_value := ~~~ (← IA32_CET cpl).SUPPRESS_DIS
      let mut IA32_CET_target_1 ← IA32_CET cpl
      IA32_CET_target_1 := { IA32_CET_target_1 with SUPPRESS := IA32_CET_SUPPRESS_value }
      IA32_CET_write cpl IA32_CET_target_1
      let mut IA32_CET_target_2 ← IA32_CET cpl
      IA32_CET_target_2 := { IA32_CET_target_2 with ENDBR_EN := (1 : Runtime.Bit) }
      IA32_CET_write cpl IA32_CET_target_2

end X86.Helpers
