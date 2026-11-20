-- Generated from data/definitions.xml.gz: Vectored_Event_Type; do not edit.
-- Source SHA256: e55850fe6fa04091ae14646fcfc39102be4926fac48ca306315df540b83ad660
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Vectored_Event_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Vectored_Event_Type where
  | External_Interrupt
  | Non_Maskable_Interrupt
  | Hardware_Exception
  | Software_Interrupt_INTn
  | Privileged_Software_Exception_INT1
  | Software_Exception_INT3_Or_INTO
  | Other_Event
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
