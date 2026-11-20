-- Generated from data/instruction/XCHG.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: c347381a627f9a346957f8ba52f57de8314eb10f71da21c209afe04310e58a9e
-- Description: data/sdm/XCHG.docbook
-- Exchanges the contents of the destination (first) and source (second) operands.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=XCHG)
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

def Instructions.Operations.XCHG
    (operand_size : Int) (src1 src2 : Bits operand_size) :
    Except (Runtime.Error Empty) (Bits operand_size × Bits operand_size) := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let result1 : Bits operand_size := src2
  let result2 : Bits operand_size := src1
  return (result1, result2)

-- XCHG_GPRv_OrAX_0: 90+r
def Instructions.XCHG_GPRv_OrAX_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) operand_size
  let src2 : Bits operand_size ← do
    Runtime.assert (decide (operand_size ≤ 64))
    Runtime.assert (decide (0 ≤ operand_size))
    pure (← Runtime.CheckedSlice.read (← RAX) 0 operand_size)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result1, result2) ← Instructions.Operations.XCHG operand_size src1 src2

  Write_RAX (size := operand_size) result2
  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) result1

-- XCHG_GPRv_OrAX_1: 90+r
def Instructions.XCHG_GPRv_OrAX_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) operand_size
  let src2 : Bits operand_size ← do
    Runtime.assert (decide (operand_size ≤ 64))
    Runtime.assert (decide (0 ≤ operand_size))
    pure (← Runtime.CheckedSlice.read (← RAX) 0 operand_size)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result1, result2) ← Instructions.Operations.XCHG operand_size src1 src2

  Write_RAX (size := operand_size) result2
  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) result1

-- XCHG_GPRv_OrAX_2: 90+r
def Instructions.XCHG_GPRv_OrAX_2
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) operand_size
  let src2 : Bits operand_size ← do
    Runtime.assert (decide (operand_size ≤ 64))
    Runtime.assert (decide (0 ≤ operand_size))
    pure (← Runtime.CheckedSlice.read (← RAX) 0 operand_size)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result1, result2) ← Instructions.Operations.XCHG operand_size src1 src2

  Write_RAX (size := operand_size) result2
  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) result1

-- XCHG_MEMv_GPRv_0: LOCK 87 /r
def Instructions.XCHG_MEMv_GPRv_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment true
  modify ({ · with Next_IP := next_ip0 })

  let (result1, result2) ← Instructions.Operations.XCHG operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result1 Memory_Alignment_Type.Normal_Alignment true false Memory_Type.Memory_Type_Unknown false
  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result2

-- XCHG_MEMb_GPR8_0: LOCK 86 /r
def Instructions.XCHG_MEMb_GPR8_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment true
  modify ({ · with Next_IP := next_ip0 })

  let (result1, result2) ← Instructions.Operations.XCHG operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result1 Memory_Alignment_Type.Normal_Alignment true false Memory_Type.Memory_Type_Unknown false
  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result2

-- XCHG_GPRv_GPRv: 87 /r
def Instructions.XCHG_GPRv_GPRv
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result1, result2) ← Instructions.Operations.XCHG operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result2
  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result1

-- XCHG_MEMv_GPRv_1: 87 /r
def Instructions.XCHG_MEMv_GPRv_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) operand_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment true
  modify ({ · with Next_IP := next_ip0 })

  let (result1, result2) ← Instructions.Operations.XCHG operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result1 Memory_Alignment_Type.Normal_Alignment true false Memory_Type.Memory_Type_Unknown false
  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result2

-- XCHG_GPR8_GPR8: 86 /r
def Instructions.XCHG_GPR8_GPR8
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let (result1, result2) ← Instructions.Operations.XCHG operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result2
  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result1

-- XCHG_MEMb_GPR8_1: 86 /r
def Instructions.XCHG_MEMb_GPR8_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment true
  modify ({ · with Next_IP := next_ip0 })

  let (result1, result2) ← Instructions.Operations.XCHG operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result1 Memory_Alignment_Type.Normal_Alignment true false Memory_Type.Memory_Type_Unknown false
  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result2

end X86
