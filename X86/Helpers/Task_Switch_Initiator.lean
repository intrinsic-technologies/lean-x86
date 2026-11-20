-- Generated from data/definitions.xml.gz: Task_Switch_Initiator; do not edit.
-- Source SHA256: 1787a046cfaf9cac412a57f4639aea44574eedd5c55d4c89a1647c208f5ad292
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Task_Switch_Initiator)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Task_Switch_Initiator where
  | Task_Switch_Call
  | Task_Switch_Iret
  | Task_Switch_Jmp
  | Task_Switch_Task_Gate_In_IDT
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
