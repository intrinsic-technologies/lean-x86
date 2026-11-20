-- Generated from data/definitions.xml.gz: Instruction_Map; do not edit.
-- Source SHA256: bcbd87b859aa60ab1c07490cf06ad1dbfe211b618afb65736263989e44f99abe
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Instruction_Map)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Instruction_Map where
  | Map_Invalid
  | Map_Legacy_0
  | Map_Legacy_1
  | Map_Legacy_2
  | Map_Legacy_3
  | Map_VEX_1
  | Map_VEX_2
  | Map_VEX_3
  | Map_VEX_4
  | Map_VEX_5
  | Map_VEX_6
  | Map_VEX_7
  | Map_EVEX_1
  | Map_EVEX_2
  | Map_EVEX_3
  | Map_EVEX_4
  | Map_EVEX_5
  | Map_EVEX_6
  | Map_EVEX_7
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
