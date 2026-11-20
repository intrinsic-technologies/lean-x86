-- Generated from data/definitions.xml.gz: Reset_Events; do not edit.
-- Source SHA256: 79746e2477c55a2274d0860e5911f7003967e740c2e4204e8d2d88bbef328ece
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Reset_Events)
import X86.Runtime
import X86.Helpers.Asynchronous_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Reset_Events  : Runtime.SpecM Exception (State σ) Unit := do
  modify ({ · with Current_Event := Asynchronous_Event_Type.No_Event })
  Event_Blocked.setNMI_BLOCKED false
  Event_Blocked.setSMI_BLOCKED false
  Event_Blocked.setINTR_BLOCKED false
  Event_Blocked.setINIT_BLOCKED false
  Event_Blocked.setSTI_BLOCKING false
  Event_Blocked.setMOVSS_BLOCKING false
  Event_Blocked.setVIRT_NMI_BLOCKED false

end X86.Helpers
