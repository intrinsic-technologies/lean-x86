-- Generated from data/definitions.xml.gz: Thread_Status_Type; do not edit.
-- Source SHA256: d3b49dbd2dd3954e7512ecd70801f815383a442fe76f45e15cdcf24fb5ae7f2b
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Thread_Status_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Thread_Status_Type where
  | THREAD_ACTIVE
  | THREAD_HALTED
  | THREAD_SHUTDOWN
  | THREAD_WAIT_FOR_SIPI
  | THREAD_MWAITING
  | THREAD_WAIT_FOR_WAKEUP
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
