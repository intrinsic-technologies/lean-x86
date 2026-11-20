-- Generated from data/definitions.xml.gz: Decode_REX2_Prefix; do not edit.
-- Source SHA256: 41533eaa5c67a812ecf33659adff2ca2329ea54de61cb7ec1759550fe3347879
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Decode_REX2_Prefix)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Instruction_Map
import X86.Helpers.Operand_Size
import X86.Helpers.Report_Invalid_Opcode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Decode_REX2_Prefix
    (context_in : Instruction_Context) (byte1 : Bits 8) :
    Runtime.SpecM Exception (State σ) (Instruction_Context × Instruction_Map) := do
  let mut context : Instruction_Context := context_in

  if (context.rex_prefix_present or (← XCR0.APX_F) == 0) then
    liftM (Report_Invalid_Opcode)

  context := { context with rex2_prefix_present := true }

  let rex2_map : Runtime.Bit ← byte1[7 +: 1]
  context := { context with rex_r4 := (← byte1[6 +: 1]) }
  context := { context with rex_x4 := (← byte1[5 +: 1]) }
  context := { context with rex_b4 := (← byte1[4 +: 1]) }
  context := { context with rex_w := (← byte1[3 +: 1]) }
  context := { context with rex_r3 := (← byte1[2 +: 1]) }
  context := { context with rex_x3 := (← byte1[1 +: 1]) }
  context := { context with rex_b3 := (← byte1[0 +: 1]) }

  context := { context with operand_size := (← Operand_Size context) }

  if (rex2_map == 1) then
    return (context, Instruction_Map.Map_Legacy_1)
  else
    return (context, Instruction_Map.Map_Legacy_0)

end X86.Helpers
