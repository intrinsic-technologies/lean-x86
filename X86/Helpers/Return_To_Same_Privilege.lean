-- Generated from data/definitions.xml.gz: Return_To_Same_Privilege; do not edit.
-- Source SHA256: a52e3058401531a61a2ad30d7e38efb1b5e91590ee4832607f3acf103e09437f
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Return_To_Same_Privilege)
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.CET.Check_Target_And_Get_New_SSP
import X86.Helpers.CET.Is_Shadow_Stack_Enabled
import X86.Helpers.Check_New_RIP
import X86.Helpers.Registers
import X86.Helpers.Segment
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Return_To_Same_Privilege
    (new_cs : Segment) (new_rip new_rsp : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Check_New_RIP new_cs new_rip

  if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
    let (new_ssp, _) ← CET.Check_Target_And_Get_New_SSP new_cs new_rip
    modify ({ · with SSP := new_ssp })

  Branch_Far new_cs new_rip
  RSP_write new_rsp

end X86.Helpers
