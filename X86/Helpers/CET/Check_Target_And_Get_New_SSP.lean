-- Generated from data/definitions.xml.gz: CET::Check_Target_And_Get_New_SSP; do not edit.
-- Source SHA256: fef3f9500ed0d2c8ff8b8093885ee58f1b44aead025b8c7ea2ef40a05ab7c525
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3ACheck_Target_And_Get_New_SSP)
import X86.Runtime
import X86.Helpers.CET.Check_Expected_Target
import X86.Helpers.CET.Get_Expected_Target
import X86.Helpers.CP_Error_Code
import X86.Helpers.Is_Aligned
import X86.Helpers.Report_Control_Protection_Exception
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

def CET.Check_Target_And_Get_New_SSP
    (new_cs : Segment) (new_rip : Bits 64) :
    Runtime.SpecM Exception (State σ) (SSP_Type × SSP_Type) := do
  if (not (← Is_Aligned (n := 64) (← get).SSP 8)) then
    Report_Control_Protection_Exception CP_Error_Code.FAR_RET_or_IRET

  let (expected_cs, expected_lip, new_ssp, old_ssp) ← CET.Get_Expected_Target
  CET.Check_Expected_Target new_cs new_rip expected_cs expected_lip new_ssp

  return (new_ssp, old_ssp)

end X86.Helpers
