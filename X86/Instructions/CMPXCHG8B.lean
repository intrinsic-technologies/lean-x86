-- Generated from data/instruction/CMPXCHG8B-CMPXCHG16B.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 5e1d36defb3a1ead5684ffd26ddd2106c74996d5f043a056d583911571b40c1d
-- Description: data/sdm/CMPXCHG8B-CMPXCHG16B.docbook
-- Compares the 64-bit value in EDX:EAX (or 128-bit value in RDX:RAX if operand size is 128 bits)
-- with the operand (destination operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CMPXCHG8B%2FCMPXCHG16B)
import X86.Runtime
import X86.Helpers.EAX
import X86.Helpers.EBX
import X86.Helpers.ECX
import X86.Helpers.EDX
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
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

def Instructions.Operations.CMPXCHG16B
    (src : Bits 128) :
    Runtime.SpecM Exception (State σ) (Bits 128) := do

  let result : Bits 128 ← do
    if (← concatBits (leftSize := 64) (rightSize := 64) (← RDX) (← RAX)) == src then
      RFLAGS.setZF 1
      let result : Bits 128 ← concatBits (leftSize := 64) (rightSize := 64) (← RCX) (← RBX)
      pure result
    else
      RFLAGS.setZF 0
      RDX_write (← src[127:64])
      RAX_write (← src[63:0])
      let result : Bits 128 := src
      pure result
  return result

def Instructions.Operations.CMPXCHG8B
    (src : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do

  let result : Bits 64 ← do
    if (← concatBits (leftSize := 32) (rightSize := 32) (← EDX) (← EAX)) == src then
      RFLAGS.setZF 1
      let result : Bits 64 ← concatBits (leftSize := 32) (rightSize := 32) (← ECX) (← EBX)
      pure result
    else
      RFLAGS.setZF 0
      EDX_write (← src[63:32])
      EAX_write (← src[31:0])
      let result : Bits 64 := src
      pure result
  return result

-- CMPXCHG16B_MEMdq: 0F C7 /1
-- CPUID group: CMPXCHG16B
def Instructions.CMPXCHG16B_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  let src : Bits 128 ← Logical_Mem_Read segment effective_address 128 Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Explicitly_Aligned false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 128 ← Instructions.Operations.CMPXCHG16B src

  Logical_Mem_Write (size := 128) segment effective_address result Memory_Alignment_Type.Explicitly_Aligned false false Memory_Type.Memory_Type_Unknown false

-- CMPXCHG8B_MEMq_0: 0F C7 /1
def Instructions.CMPXCHG8B_MEMq_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  let src : Bits 64 ← Logical_Mem_Read segment effective_address 64 Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 64 ← Instructions.Operations.CMPXCHG8B src

  Logical_Mem_Write (size := 64) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- CMPXCHG8B_MEMq_1: 0F C7 /1
def Instructions.CMPXCHG8B_MEMq_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  let src : Bits 64 ← Logical_Mem_Read segment effective_address 64 Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 64 ← Instructions.Operations.CMPXCHG8B src

  Logical_Mem_Write (size := 64) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- CMPXCHG16B_LOCK_MEMdq: LOCK 0F C7 /1
-- CPUID group: CMPXCHG16B
def Instructions.CMPXCHG16B_LOCK_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  let src : Bits 128 ← Logical_Mem_Read segment effective_address 128 Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 128 ← Instructions.Operations.CMPXCHG16B src

  Logical_Mem_Write (size := 128) segment effective_address result Memory_Alignment_Type.Normal_Alignment true false Memory_Type.Memory_Type_Unknown false

-- CMPXCHG8B_LOCK_MEMq_0: LOCK 0F C7 /1
def Instructions.CMPXCHG8B_LOCK_MEMq_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  let src : Bits 64 ← Logical_Mem_Read segment effective_address 64 Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 64 ← Instructions.Operations.CMPXCHG8B src

  Logical_Mem_Write (size := 64) segment effective_address result Memory_Alignment_Type.Normal_Alignment true false Memory_Type.Memory_Type_Unknown false

-- CMPXCHG8B_LOCK_MEMq_1: LOCK 0F C7 /1
def Instructions.CMPXCHG8B_LOCK_MEMq_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  let src : Bits 64 ← Logical_Mem_Read segment effective_address 64 Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 64 ← Instructions.Operations.CMPXCHG8B src

  Logical_Mem_Write (size := 64) segment effective_address result Memory_Alignment_Type.Normal_Alignment true false Memory_Type.Memory_Type_Unknown false

end X86
