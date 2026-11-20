-- Generated from data/instruction/POP.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 4cf4c97bf5071853e7cb9e2db9a99aea6bbb31a5fb5c58b51b485d1e0a607af6
-- Description: data/sdm/POP.docbook
-- Loads the value from the top of the stack to the location specified with the destination operand
-- (or explicit opcode) and then increments the stack pointer.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=POP)
import X86.Runtime
import X86.Helpers.Data_Size_Of_Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Load_Data_Segment
import X86.Helpers.Load_Stack_Segment
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Pop_Stack
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Update_Stack_Pointer
import X86.Helpers.Write_GPR
import X86.Helpers.Write_RSP
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.POP_SEG
    (operand_size : Int) :
    Runtime.SpecM Exception (State σ) (Bits 16 × Bits 64) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let (result, new_rsp) ← Pop_Stack (← get).SS (← RSP) 16 operand_size
  -- Updating the segment register may cause a fault and must be done before updating RSP
  return (result, new_rsp)

def Instructions.Operations.POP
    (operand_size : Int) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bits 64) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let (result, new_rsp) ← Pop_Stack (← get).SS (← RSP) operand_size operand_size
  return (result, new_rsp)

-- POP_ES: 07
def Instructions.POP_ES
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  if (not ((← Data_Size_Of_Current_Mode) != 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, new_rsp) ← Instructions.Operations.POP_SEG operand_size

  ES.assign (← Load_Data_Segment (← result[0 +: 16]) (← get).ES (← get).RFLAGS false)
  Update_Stack_Pointer (← get).SS new_rsp

-- POP_SS: 17
def Instructions.POP_SS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  if (not ((← Data_Size_Of_Current_Mode) != 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, new_rsp) ← Instructions.Operations.POP_SEG operand_size

  SS.assign (← Load_Stack_Segment (← result[0 +: 16]) (← get).SS (← get).CPL (← get).RFLAGS true)
  Event_Blocked.setMOVSS_BLOCKING true
  Update_Stack_Pointer (← get).SS new_rsp

-- POP_DS: 1F
def Instructions.POP_DS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  if (not ((← Data_Size_Of_Current_Mode) != 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, new_rsp) ← Instructions.Operations.POP_SEG operand_size

  DS.assign (← Load_Data_Segment (← result[0 +: 16]) (← get).DS (← get).RFLAGS false)
  Update_Stack_Pointer (← get).SS new_rsp

-- POP_FS: 0F A1
def Instructions.POP_FS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, new_rsp) ← Instructions.Operations.POP_SEG operand_size

  FS.assign (← Load_Data_Segment (← result[0 +: 16]) (← get).FS (← get).RFLAGS false)
  Update_Stack_Pointer (← get).SS new_rsp

-- POP_GS: 0F A9
def Instructions.POP_GS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, new_rsp) ← Instructions.Operations.POP_SEG operand_size

  GS.assign (← Load_Data_Segment (← result[0 +: 16]) (← get).GS (← get).RFLAGS false)
  Update_Stack_Pointer (← get).SS new_rsp

-- POP_GPRv_58_0: 58+r
def Instructions.POP_GPRv_58_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, new_rsp) ← Instructions.Operations.POP operand_size

  Write_RSP (size := 64) new_rsp
  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) result

-- POP_GPRv_58_1: 58+r
def Instructions.POP_GPRv_58_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, new_rsp) ← Instructions.Operations.POP operand_size

  Write_RSP (size := 64) new_rsp
  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) result

-- POP_GPRv_8F: 8F /0
def Instructions.POP_GPRv_8F
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, new_rsp) ← Instructions.Operations.POP operand_size

  Write_RSP (size := 64) new_rsp
  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- POP_MEMv: 8F /0
def Instructions.POP_MEMv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let (result, new_rsp) ← Instructions.Operations.POP operand_size

  let pop_rsp_delta : Bits 64 := new_rsp - (← RSP)
  let pop_ea : Bits 64 ← do
    if base_uses_rsp then
      Std.Bits.Zero_Extend (source_size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← (effective_address + pop_rsp_delta)[0 +: address_size]))) 64
    else
      pure effective_address
  Logical_Mem_Write (size := operand_size) segment pop_ea result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
  Write_RSP (size := 64) new_rsp

end X86
