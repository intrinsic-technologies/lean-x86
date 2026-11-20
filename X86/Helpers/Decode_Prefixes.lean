-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: bac7bdb9cc67aef8ca4fde9bb374f2ac8eeb6ec82b7adb4330aec103ab2cf0c8
import X86.Runtime
import X86.Helpers.Address_Size
import X86.Helpers.Decode_EVEX_Prefix
import X86.Helpers.Decode_Legacy_Map
import X86.Helpers.Decode_Legacy_Prefixes
import X86.Helpers.Decode_REX2_Prefix
import X86.Helpers.Decode_Three_Byte_VEX_Prefix
import X86.Helpers.Decode_Two_Byte_VEX_Prefix
import X86.Helpers.Fetch_Extended_Prefix_Bytes
import X86.Helpers.Instruction_Context
import X86.Helpers.Instruction_Map
import X86.Helpers.Operand_Size
import X86.Helpers.Std.Bits.Add_int
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Decode_Prefixes
    (ip : Bits 64) :
    Runtime.PartialSpecM Exception (State σ) (Instruction_Context × Instruction_Map × Bits 64 × Bits 8) := do

  let mut map : Instruction_Map := Instruction_Map.Map_Invalid
  let mut opcode_ip : Bits 64 := ip

  -- Legacy prefixes (and the REX prefix, which must be the last of them)
  let mut (context, byte, offset) ← Decode_Legacy_Prefixes ip

  context := { context with address_size := (← Runtime.liftTotal (Address_Size context)) }

  let (has_prefix, byte1, byte2, byte3) ← Runtime.liftTotal (Fetch_Extended_Prefix_Bytes byte (← Std.Bits.Add_int (n := 64) ip offset) context.is_mode64)

  if (has_prefix and byte == 98) then
    let num_prefix_bytes : Int := 3
    let (context_4, map_5) ← Runtime.liftTotal (Decode_EVEX_Prefix context byte1 byte2 byte3)
    context := context_4
    map := map_5
    opcode_ip := (← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) ip offset) num_prefix_bytes) 1)
  else
    if (has_prefix and byte == 196) then
      let num_prefix_bytes : Int := 2
      let (context_3, map_4) ← Runtime.liftTotal (Decode_Three_Byte_VEX_Prefix context byte1 byte2)
      context := context_3
      map := map_4
      opcode_ip := (← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) ip offset) num_prefix_bytes) 1)
    else
      if (has_prefix and byte == 197) then
        let num_prefix_bytes : Int := 1
        let (context_2, map_3) ← Runtime.liftTotal (Decode_Two_Byte_VEX_Prefix context byte1)
        context := context_2
        map := map_3
        opcode_ip := (← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) ip offset) num_prefix_bytes) 1)
      else
        if (has_prefix and byte == 213) then
          let num_prefix_bytes : Int := 1
          let (context_1, map_2) ← Runtime.liftTotal (Decode_REX2_Prefix context byte1)
          context := context_1
          map := map_2
          opcode_ip := (← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) ip offset) num_prefix_bytes) 1)
        else
          context := { context with operand_size := (← Runtime.liftTotal (Operand_Size context)) }

          let (map_1, opcode_ip_1) ← Runtime.liftTotal (Decode_Legacy_Map (← Std.Bits.Add_int (n := 64) ip offset) byte)
          map := map_1
          opcode_ip := opcode_ip_1

  return (context, map, opcode_ip, byte)

end X86.Helpers
