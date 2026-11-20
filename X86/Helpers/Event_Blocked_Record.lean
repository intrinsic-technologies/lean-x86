-- Generated from data/definitions.xml.gz: Event_Blocked_Record; do not edit.
-- Source SHA256: 9e43d75ef9dda3367f8c81102735938ef5fd50dca5eae2debbc8fe268d2d4476
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Event_Blocked_Record)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

structure Event_Blocked_Record where
  NMI_BLOCKED : Bool
  SMI_BLOCKED : Bool
  INTR_BLOCKED : Bool
  INIT_BLOCKED : Bool
  STI_BLOCKING : Bool
  MOVSS_BLOCKING : Bool
  VIRT_NMI_BLOCKED : Bool
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
