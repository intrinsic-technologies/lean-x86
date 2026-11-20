-- Generated from data/definitions.xml.gz: Execution_Mode; do not edit.
-- Source SHA256: afef63815fec07e27fae27ec980b8da5bf4001b7ff513a1e58302f1fb0c7e4c0
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Execution_Mode)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Execution_Mode where
  | Real_Address_Mode
  | Protected_Mode
  | Virtual_8086_Mode
  | System_Management_Mode
  | IA32e_Mode
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
