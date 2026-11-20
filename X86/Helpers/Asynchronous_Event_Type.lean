-- Generated from data/definitions.xml.gz: Asynchronous_Event_Type; do not edit.
-- Source SHA256: d396e4c10978b3e54760f3e31c06ab653f7038ff1db6703c27b76cdec0237a4e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Asynchronous_Event_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Asynchronous_Event_Type where
  | No_Event
  | Reset_Event
  | Asynchronous_Machine_Check_Event
  | Synchronous_Machine_Check_Event
  | PSMI_Event
  | SMI_Event
  | Init_Event
  | NMI_Event
  | Interrupt_Event
  | MONITOR_Wake_Event
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
