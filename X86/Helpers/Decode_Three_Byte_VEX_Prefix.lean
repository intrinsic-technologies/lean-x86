-- Generated from data/definitions.xml.gz: Decode_Three_Byte_VEX_Prefix; do not edit.
-- Source SHA256: cc64dec520f9907887653ec53581afedd74b7c2a49d058eb8628766933f2edbe
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Decode_Three_Byte_VEX_Prefix)
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

def Decode_Three_Byte_VEX_Prefix
    (context_in : Instruction_Context) (byte1 byte2 : Bits 8) :
    Runtime.SpecM Exception (State σ) (Instruction_Context × Instruction_Map) := do
  let mut context : Instruction_Context := context_in
  let mut map : Instruction_Map := Instruction_Map.Map_Invalid

  context := { context with vex_prefix_present := true }
  context := { context with rex_r3 := ~~~ (← byte1[7 +: 1]) }
  context := { context with rex_x3 := ~~~ (← byte1[6 +: 1]) }
  context := { context with rex_b3 := (← (do if context.is_mode64 then pure (~~~ (← byte1[5 +: 1])) else pure (0 : Runtime.Bit))) }
  let vex_map : Bits 5 ← byte1[4:0]

  context := { context with rex_w := (← byte2[7 +: 1]) }
  context := { context with vvvv := ~~~ (← byte2[6:3]) }
  context := { context with vex_LL := (← concatBits (leftSize := 1) (rightSize := 1) (0 : Runtime.Bit) (← byte2[2 +: 1])) }
  context := { context with vex_pp := (← byte2[1:0]) }

  Check_Extended_Prefix_Conflicts context

  context := { context with operand_size := (← Operand_Size context) }

  match Unsigned vex_map with
  | 0b00001 => do
    map := Instruction_Map.Map_VEX_1
  | 0b00010 => do
    map := Instruction_Map.Map_VEX_2
  | 0b00011 => do
    map := Instruction_Map.Map_VEX_3
  | 0b00100 => do
    map := Instruction_Map.Map_VEX_4
  | 0b00101 => do
    map := Instruction_Map.Map_VEX_5
  | 0b00110 => do
    map := Instruction_Map.Map_VEX_6
  | 0b00111 => do
    map := Instruction_Map.Map_VEX_7
  | _ => do
    map := Instruction_Map.Map_Invalid

  return (context, map)

end X86.Helpers
