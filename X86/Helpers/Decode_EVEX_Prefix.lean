-- Generated from data/definitions.xml.gz: Decode_EVEX_Prefix; do not edit.
-- Source SHA256: 51d47494d27530c7d2a390da73360cddc5bf35c7ca7f6a53826c267843635758
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Decode_EVEX_Prefix)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Check_Extended_Prefix_Conflicts
import X86.Helpers.Instruction_Context
import X86.Helpers.Instruction_Map
import X86.Helpers.Operand_Size
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]

def Decode_EVEX_Prefix
    (context_in : Instruction_Context) (byte1 byte2 byte3 : Bits 8) :
    Runtime.SpecM Exception (State σ) (Instruction_Context × Instruction_Map) := do
  let mut context : Instruction_Context := context_in
  let mut map : Instruction_Map := Instruction_Map.Map_Invalid

  context := { context with evex_prefix_present := true }
  context := { context with rex_r3 := ~~~ (← byte1[7 +: 1]) }
  context := { context with rex_x3 := ~~~ (← byte1[6 +: 1]) }
  context := { context with rex_b3 := ~~~ (← byte1[5 +: 1]) }
  context := { context with rex_r4 := ~~~ (← byte1[4 +: 1]) }
  let evex_map : Bits 3 ← byte1[2:0]

  context := { context with rex_w := (← byte2[7 +: 1]) }
  context := { context with vvvv := ~~~ (← byte2[6:3]) }
  context := { context with evex_u := (← byte2[2 +: 1]) }
  context := { context with vex_pp := (← byte2[1:0]) }

  context := { context with evex_z := (← byte3[7 +: 1]) }
  context := { context with evex_LLRC := (← byte3[6:5]) }
  context := { context with vex_LL := (← byte3[6:5]) }
  context := { context with evex_b := (← byte3[4 +: 1]) }
  context := { context with evex_v4 := ~~~ (← byte3[3 +: 1]) }
  context := { context with evex_aaa := (← byte3[2:0]) }

  if (← CPUID_APX_F) then
    context := { context with rex_b4 := (← byte1[3 +: 1]) }
    context := { context with rex_x4 := ~~~ (← byte2[2 +: 1]) }
    context := { context with evex_dfv := (← byte2[6:3]) }
    context := { context with evex_nd := (← byte3[4 +: 1]) }
    context := { context with evex_scc := (← byte3[3:0]) }
    context := { context with evex_nf := (← byte3[2 +: 1]) }
  else
    -- EVEX.B4 is only supported for APX
    if ((← byte1[3 +: 1]) == 1) then
      liftM (Report_Invalid_Opcode)

  if (context.evex_u == 0) then
    if (not (← CPUID_APX_F) or not context.is_mode64) then
      -- If APX is not enabled (or outside of 64-bit mode), the EVEX.U bit is reserved at 1
      liftM (Report_Invalid_Opcode)

  Check_Extended_Prefix_Conflicts context

  -- zeroing not allowed when opmask K0 is indicated
  if (context.evex_z == 1 and (← Std.Bits.Is_Zero (size := 3) context.evex_aaa)) then
    liftM (Report_Invalid_Opcode)

  -- registers 16-31 are not accessible outside of 64-bit mode
  if (context.evex_v4 == 1 and not context.is_mode64) then
    liftM (Report_Invalid_Opcode)

  context := { context with operand_size := (← Operand_Size context) }

  match Unsigned evex_map with
  | 0b001 => do
    map := Instruction_Map.Map_EVEX_1
  | 0b010 => do
    map := Instruction_Map.Map_EVEX_2
  | 0b011 => do
    map := Instruction_Map.Map_EVEX_3
  | 0b100 => do
    map := Instruction_Map.Map_EVEX_4
  | 0b101 => do
    map := Instruction_Map.Map_EVEX_5
  | 0b110 => do
    map := Instruction_Map.Map_EVEX_6
  | 0b111 => do
    map := Instruction_Map.Map_EVEX_7
  | _ => do
    map := Instruction_Map.Map_Invalid

  return (context, map)

end X86.Helpers
