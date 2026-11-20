-- Generated from data/definitions.xml.gz: Clear_Debug_Traps; do not edit.
-- Source SHA256: 1be3bf2242fc3f6d7289fd61cfc1aa1ee4d33a017c4170377da03daa82d654b2
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Clear_Debug_Traps)
import X86.Runtime
import X86.Helpers.Clear_Debug_Single_Step_Traps
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Clear_Debug_Traps  : Runtime.SpecM Exception (State σ) Unit := do
  Clear_Debug_Single_Step_Traps
  modify ({ · with Debug_Breakpoint_Trap_Detected := false })
  modify ({ · with Debug_Bus_Lock_Trap_Detected := false })
  modify ({ · with Debug_Breakpoints_Matched := (0 : Bits 4) })

end X86.Helpers
