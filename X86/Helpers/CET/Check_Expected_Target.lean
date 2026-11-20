-- Generated from data/definitions.xml.gz: CET::Check_Expected_Target; do not edit.
-- Source SHA256: 37313a71e0997c5d68588cd927c09be8affa4b0d703fe3af86f5fff31e40a184
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=CET%3A%3ACheck_Expected_Target)
import X86.Runtime
import X86.Helpers.CET.Is_Valid_Shadow_Stack_Address
import X86.Helpers.CP_Error_Code
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.Is_Aligned
import X86.Helpers.Report_Control_Protection_Exception
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]

def CET.Check_Expected_Target
    (new_cs : Segment) (new_rip expected_cs expected_lip new_ssp : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  let new_lip : Bits 64 ← Compute_Linear_Address new_cs new_rip new_cs

  if (not (← CET.Is_Valid_Shadow_Stack_Address new_ssp new_cs)) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if ((← expected_cs[0 +: 16]) != new_cs.selector or expected_lip != new_lip or not (← Is_Aligned (n := 64) new_ssp 4)) then
    Report_Control_Protection_Exception CP_Error_Code.FAR_RET_or_IRET

end X86.Helpers
