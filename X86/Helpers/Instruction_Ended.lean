-- Generated from data/definitions.xml.gz: Instruction_Ended; do not edit.
-- Source SHA256: b6825ef3be8a8c7a941d6a1f7011e30a4b69691df1d92d14a6905365149a9503
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Instruction_Ended)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

structure Instruction_Ended where
  deriving Repr, DecidableEq

end X86.Helpers
