-- Generated from data/definitions.xml.gz: Check_New_RIP; do not edit.
-- Source SHA256: b7df1699af927307e911cda3f596f1107fb220113f18c92909e656b012ec7251
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_New_RIP)
import X86.Runtime
import X86.Helpers.Check_Segment_Limit
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_Canonical_Wrt_Paging_Mode
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
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Check_New_RIP
    (new_cs : Segment) (new_rip : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (← Is_64Bit_Code_Segment new_cs) then
    -- LAM applies to data accesses only; a branch target must be fully canonical
    if (not (← Is_Canonical_Wrt_Paging_Mode new_rip 0 true)) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
  else
    Check_Segment_Limit new_cs new_rip 1

end X86.Helpers
