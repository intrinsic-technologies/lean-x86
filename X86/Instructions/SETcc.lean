-- Generated from data/instruction/SETcc.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 6d90246da2894ec92ef69d9be01f60393607ea42c992e5f01d2bc1b80aea87ca
-- Description: data/sdm/SETcc.docbook
-- Set Byte on Condition
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=SETcc)
import X86.Runtime
import X86.Helpers.Condition_Holds
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Write_GPR8
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.SETcc
    (cond : Bits 4) :
    Runtime.SpecM Exception (State σ) (Bits 8) := do
  let result : Bits 8 ← do
    if (← Condition_Holds cond) then
      (1 : Int)[7:0]
    else
      (0 : Int)[7:0]
  return result

-- SETO_GPR8: 0F 90 /r
def Instructions.SETO_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETO_MEMb: 0F 90 /r
def Instructions.SETO_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETNO_GPR8: 0F 91 /r
def Instructions.SETNO_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETNO_MEMb: 0F 91 /r
def Instructions.SETNO_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETB_GPR8: 0F 92 /r
def Instructions.SETB_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETB_MEMb: 0F 92 /r
def Instructions.SETB_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETNB_GPR8: 0F 93 /r
def Instructions.SETNB_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETNB_MEMb: 0F 93 /r
def Instructions.SETNB_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETZ_GPR8: 0F 94 /r
def Instructions.SETZ_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETZ_MEMb: 0F 94 /r
def Instructions.SETZ_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETNZ_GPR8: 0F 95 /r
def Instructions.SETNZ_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETNZ_MEMb: 0F 95 /r
def Instructions.SETNZ_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETBE_GPR8: 0F 96 /r
def Instructions.SETBE_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETBE_MEMb: 0F 96 /r
def Instructions.SETBE_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETNBE_GPR8: 0F 97 /r
def Instructions.SETNBE_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETNBE_MEMb: 0F 97 /r
def Instructions.SETNBE_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETS_GPR8: 0F 98 /r
def Instructions.SETS_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETS_MEMb: 0F 98 /r
def Instructions.SETS_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETNS_GPR8: 0F 99 /r
def Instructions.SETNS_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETNS_MEMb: 0F 99 /r
def Instructions.SETNS_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETP_GPR8: 0F 9A /r
def Instructions.SETP_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETP_MEMb: 0F 9A /r
def Instructions.SETP_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETNP_GPR8: 0F 9B /r
def Instructions.SETNP_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETNP_MEMb: 0F 9B /r
def Instructions.SETNP_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETL_GPR8: 0F 9C /r
def Instructions.SETL_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETL_MEMb: 0F 9C /r
def Instructions.SETL_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETNL_GPR8: 0F 9D /r
def Instructions.SETNL_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETNL_MEMb: 0F 9D /r
def Instructions.SETNL_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETLE_GPR8: 0F 9E /r
def Instructions.SETLE_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETLE_MEMb: 0F 9E /r
def Instructions.SETLE_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- SETNLE_GPR8: 0F 9F /r
def Instructions.SETNLE_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- SETNLE_MEMb: 0F 9F /r
def Instructions.SETNLE_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let _operand_size : Int := 8
  let cond : Bits 4 ← opcode[3:0]

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits 8 ← Instructions.Operations.SETcc cond

  Logical_Mem_Write (size := 8) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

end X86
