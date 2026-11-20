-- Generated from data/definitions.xml.gz: Clear_Debug_Single_Step_Traps; do not edit.
-- Source SHA256: 949f8d13f1883b44b1cd845163368f8d268e38f3d48f6ab12270e9968e51d354
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Clear_Debug_Single_Step_Traps)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def Clear_Debug_Single_Step_Traps  : Runtime.SpecM Exception (State σ) Unit := do
  modify ({ · with Debug_Single_Step_Trap_Detected := false })
  modify ({ · with Debug_Task_Switch_Trap_Detected := false })

end X86.Helpers
