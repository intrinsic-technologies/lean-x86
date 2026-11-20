-- Generated from data/definitions.xml.gz: Decode_Two_Byte_VEX_Prefix; do not edit.
-- Source SHA256: 5e3e601d97ecf682d2adbf167b84efe4f1274bf7fa5f0aef44ba9fb8eaf0f9b3
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Decode_Two_Byte_VEX_Prefix)
import X86.Runtime
import X86.Helpers.Check_Extended_Prefix_Conflicts
import X86.Helpers.Instruction_Context
import X86.Helpers.Instruction_Map
import X86.Helpers.Operand_Size
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Decode_Two_Byte_VEX_Prefix
    (context_in : Instruction_Context) (byte1 : Bits 8) :
    Runtime.SpecM Exception (State σ) (Instruction_Context × Instruction_Map) := do
  let mut context : Instruction_Context := context_in

  context := { context with rex_w := (0 : Runtime.Bit) }
  context := { context with rex_x3 := (0 : Runtime.Bit) }
  context := { context with rex_b3 := (0 : Runtime.Bit) }

  context := { context with vex_prefix_present := true }
  context := { context with rex_r3 := ~~~ (← byte1[7 +: 1]) }
  context := { context with vvvv := ~~~ (← byte1[6:3]) }
  context := { context with vex_LL := (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (← byte1[2 +: 1])) }
  context := { context with vex_pp := (← byte1[1:0]) }

  Check_Extended_Prefix_Conflicts context

  context := { context with operand_size := (← Operand_Size context) }

  return (context, Instruction_Map.Map_VEX_1)

end X86.Helpers
