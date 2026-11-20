-- Generated from data/instruction/CMPXCHG.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 45eb3e9ee77d15362de25ad2302364238d781fd8784a48e7d6f16dddeb6ebc33
-- Description: data/sdm/CMPXCHG.docbook
-- Compares the value in the AL, AX, EAX, or RAX register with the first operand (destination
-- operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CMPXCHG)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Read_GPR
import X86.Helpers.Read_GPR8
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Is_Parity_Even
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Subtract
import X86.Helpers.UFloatCompare
import X86.Helpers.Write_GPR
import X86.Helpers.Write_GPR8
import X86.Helpers.Write_RAX
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

def Instructions.Operations.CMPXCHG
    (operand_size : Int) (old_dest src : Bits operand_size) (is_mem_operand : Bool) :
    Runtime.SpecM Exception (State σ) (Bits operand_size × Bool) := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let accumulator : Bits operand_size ← do
    Runtime.assert (decide (operand_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← RAX) 0 operand_size)
  let (difference, carry_out, overflow, alternative_carry) ← Subtract (size := operand_size) accumulator old_dest

  let (result, write_result) : (Bits operand_size × Bool) ← do
    if (← Std.Bits.Is_Zero (size := operand_size) difference) then
      let result : Bits operand_size := src
      let write_result : Bool := true
      pure (result, write_result)
    else
      Write_RAX (size := operand_size) (← old_dest[0 +: operand_size])
      let result : Bits operand_size := old_dest

      -- Rewrite the "old_dest" value to the destination only when the destination is a memory operand.
      -- In case of register destination operand there is no need to rewrite the register with the same
      -- value as the upper 32-bits of the register will get cleared when operand_size == 32.
      let write_result : Bool := is_mem_operand
      pure (result, write_result)

  RFLAGS.setOF overflow
  RFLAGS.setSF (← difference[operand_size - 1 +: 1])
  RFLAGS.setZF (← Bit (← Std.Bits.Is_Zero (size := operand_size) difference))
  RFLAGS.setAF alternative_carry
  RFLAGS.setPF (← Bit (← Std.Bits.Is_Parity_Even (size := 8) (← difference[0 +: 8])))
  RFLAGS.setCF carry_out
  return (result, write_result)

-- CMPXCHG_GPRv_GPRv: 0F B1 /r
def Instructions.CMPXCHG_GPRv_GPRv
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let is_mem_operand : Bool := false

  let old_dest : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.CMPXCHG operand_size old_dest src is_mem_operand

  if write_result then
    Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- CMPXCHG_MEMv_GPRv: 0F B1 /r
def Instructions.CMPXCHG_MEMv_GPRv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let is_mem_operand : Bool := true

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  let old_dest : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let (result, write_result) ← Instructions.Operations.CMPXCHG operand_size old_dest src is_mem_operand

  if write_result then
    Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- CMPXCHG_GPR8_GPR8: 0F B0 /r
def Instructions.CMPXCHG_GPR8_GPR8
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8
  let is_mem_operand : Bool := false

  let old_dest : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.CMPXCHG operand_size old_dest src is_mem_operand

  if write_result then
    Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- CMPXCHG_MEMb_GPR8: 0F B0 /r
def Instructions.CMPXCHG_MEMb_GPR8
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8
  let is_mem_operand : Bool := true

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  let old_dest : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let (result, write_result) ← Instructions.Operations.CMPXCHG operand_size old_dest src is_mem_operand

  if write_result then
    Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- CMPXCHG_LOCK_MEMv_GPRv: LOCK 0F B1 /r
def Instructions.CMPXCHG_LOCK_MEMv_GPRv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let is_mem_operand : Bool := true

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  let old_dest : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment true
  modify ({ · with Next_IP := next_ip0 })

  let (result, write_result) ← Instructions.Operations.CMPXCHG operand_size old_dest src is_mem_operand

  if write_result then
    Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment true false Memory_Type.Memory_Type_Unknown false

-- CMPXCHG_LOCK_MEMb_GPR8: LOCK 0F B0 /r
def Instructions.CMPXCHG_LOCK_MEMb_GPR8
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8
  let is_mem_operand : Bool := true

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  let old_dest : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment true
  modify ({ · with Next_IP := next_ip0 })

  let (result, write_result) ← Instructions.Operations.CMPXCHG operand_size old_dest src is_mem_operand

  if write_result then
    Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment true false Memory_Type.Memory_Type_Unknown false

end X86
