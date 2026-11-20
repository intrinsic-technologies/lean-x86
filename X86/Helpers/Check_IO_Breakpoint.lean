-- Generated from data/definitions.xml.gz: Check_IO_Breakpoint; do not edit.
-- Source SHA256: b721eb3a8ee466ab08670ab6f7bfc710c17a03b09578ae7bfe6437298af1cbb4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_IO_Breakpoint)
import X86.Runtime
import X86.Helpers.BP
import X86.Helpers.Get_Breakpoint_Properties
import X86.Helpers.Is_Breakpoint_Address_Match
import X86.Helpers.Num_Debug_Breakpoints
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Check_IO_Breakpoint
    (port : Bits 32) (num_bytes : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  let io_address : Bits 64 ← Std.Bits.Zero_Extend (source_size := 32) port 64

  if ((← CR4.DE) == 0) then
    return ()

  for i in intRange (0 : Int) (Num_Debug_Breakpoints - 1) do
    let (bp_enabled, bp_cond, bp_address, bp_length) ← Get_Breakpoint_Properties i

    if (bp_enabled and bp_cond == BP_IOReadOrWrite) then
      if (← Is_Breakpoint_Address_Match bp_address bp_length io_address num_bytes) then
        modify ({ · with Debug_Breakpoint_Trap_Detected := true })
        Runtime.assert (decide (i < 4))
        Debug_Breakpoints_Matched.setSlice i 1 (1 : Runtime.Bit)

end X86.Helpers
