-- Generated from data/definitions.xml.gz: Decode_REX_Prefix; do not edit.
-- Source SHA256: aeb03e6c9f390ad932a4dfd60261d9ac82e841c133b361fd9abe64a526b4189e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Decode_REX_Prefix)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Decode_REX_Prefix
    (byte : Bits 8) (context_in : Instruction_Context) :
    Except (Runtime.Error Empty) (Instruction_Context) := do
  let mut context : Instruction_Context := context_in

  context := { context with rex_prefix_present := true }
  context := { context with rex_w := (← byte[3 +: 1]) }
  context := { context with rex_r3 := (← byte[2 +: 1]) }
  context := { context with rex_x3 := (← byte[1 +: 1]) }
  context := { context with rex_b3 := (← byte[0 +: 1]) }

  return context

end X86.Helpers
