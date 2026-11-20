-- Generated from data/definitions.xml.gz: Check_Data_Write_Breakpoint; do not edit.
-- Source SHA256: 09214fe5f9b59572fa36653e841cbc570c5bf12fcf3328c61ee2dbf818ce97ed
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Data_Write_Breakpoint)
import X86.Runtime
import X86.Helpers.BP
import X86.Helpers.Get_Breakpoint_Properties
import X86.Helpers.Is_Breakpoint_Address_Match
import X86.Helpers.Num_Debug_Breakpoints
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Check_Data_Write_Breakpoint
    (linear_address : Bits 64) (num_bytes : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  for i in intRange (0 : Int) (Num_Debug_Breakpoints - 1) do
    let (bp_enabled, bp_cond, bp_address, bp_length) ← Get_Breakpoint_Properties i

    if (bp_enabled and (← bp_cond[0 +: 1]) == BP_DataWrite) then
      if (← Is_Breakpoint_Address_Match bp_address bp_length linear_address num_bytes) then
        modify ({ · with Debug_Breakpoint_Trap_Detected := true })
        Runtime.assert (decide (i < 4))
        Debug_Breakpoints_Matched.setSlice i 1 (1 : Runtime.Bit)

end X86.Helpers
