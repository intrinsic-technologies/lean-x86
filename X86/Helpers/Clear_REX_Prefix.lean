-- Generated from data/definitions.xml.gz: Clear_REX_Prefix; do not edit.
-- Source SHA256: 5f55d6d6c33d1daa2d7bc6d64747b0980ba6b11143fe46d41815e159f6cad13d
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Clear_REX_Prefix)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Clear_REX_Prefix
    (context_in : Instruction_Context) :
    Except (Runtime.Error Empty) (Instruction_Context) := do
  let mut context : Instruction_Context := context_in

  context := { context with rex_prefix_present := false }
  context := { context with rex_w := (0 : Runtime.Bit) }
  context := { context with rex_r3 := (0 : Runtime.Bit) }
  context := { context with rex_x3 := (0 : Runtime.Bit) }
  context := { context with rex_b3 := (0 : Runtime.Bit) }

  return context

end X86.Helpers
