-- Generated from data/definitions.xml.gz: Instruction_Loop_Type; do not edit.
-- Source SHA256: 3c210b92d4ce37e40541e2593f04573378a5ecf36cad00be8e18b085cfbbd23c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Instruction_Loop_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Instruction_Loop_Type where
  | LOOP
  | LOOPE
  | LOOPNE
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
