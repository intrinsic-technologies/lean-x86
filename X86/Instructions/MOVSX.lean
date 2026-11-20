-- Generated from data/instruction/MOVSX-MOVSXD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: d4d4bd30ed20bfe5555476d45eb5b9abec12d8321934d9ce1ba579d20acea394
-- Description: data/sdm/MOVSX-MOVSXD.docbook
-- Copies the contents of the source operand (register or memory location) to the destination
-- operand (register) and sign extends the value to 16 or 32 bits (see Figure 7-6 in the Intel® 64
-- and IA‑32 Architectures Software Developer’s Manual, Volume 1).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MOVSX%2FMOVSXD)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_GPR
import X86.Helpers.Read_GPR8
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Write_GPR
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
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.MOVSX
    (operand_size : Int) (src_size : Int) (src : Bits src_size) :
    Except (Runtime.Error Empty) (Bits operand_size) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (src_size == 8 || src_size == 16 || src_size == 32)

  let result : Bits operand_size ← Std.Bits.Sign_Extend (source_size := src_size) src operand_size
  return result

-- MOVSX_GPRv_MEMb_5: F2 0F BE /r
def Instructions.MOVSX_GPRv_MEMb_5
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let src_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPR16_MEMw: 0F BF /r
def Instructions.MOVSX_GPR16_MEMw
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let src_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPR32_MEMw_0: 0F BF /r
def Instructions.MOVSX_GPR32_MEMw_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let src_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPR32_MEMw_1: 0F BF /r
def Instructions.MOVSX_GPR32_MEMw_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let src_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPR32_MEMw_3: 0F BF /r
def Instructions.MOVSX_GPR32_MEMw_3
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let src_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPR64_MEMw_0: 0F BF /r
def Instructions.MOVSX_GPR64_MEMw_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64
  let src_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPR64_MEMw_1: 0F BF /r
def Instructions.MOVSX_GPR64_MEMw_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64
  let src_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPR64_MEMw_3: 0F BF /r
def Instructions.MOVSX_GPR64_MEMw_3
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64
  let src_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPRv_GPR16: 0F BF /r
def Instructions.MOVSX_GPRv_GPR16
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src_size : Int := 16

  let src : Bits 16 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPRv_MEMw: 0F BF /r
def Instructions.MOVSX_GPRv_MEMw
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let src_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPR32_MEMw_2: F2 0F BF /r
def Instructions.MOVSX_GPR32_MEMw_2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32
  let src_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPR64_MEMw_2: F2 0F BF /r
def Instructions.MOVSX_GPR64_MEMw_2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64
  let src_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSXD_GPR64_MEMd_4: F2 63 /r
-- CPUID group: LONGMODE
def Instructions.MOVSXD_GPR64_MEMd_4
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64
  let src_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSXD_GPR64_MEMd_0: 63 /r
-- CPUID group: LONGMODE
def Instructions.MOVSXD_GPR64_MEMd_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64
  let src_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSXD_GPR64_MEMd_1: 63 /r
-- CPUID group: LONGMODE
def Instructions.MOVSXD_GPR64_MEMd_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64
  let src_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSXD_GPR64_MEMd_2: 63 /r
-- CPUID group: LONGMODE
def Instructions.MOVSXD_GPR64_MEMd_2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64
  let src_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSXD_GPR64_MEMd_3: 63 /r
-- CPUID group: LONGMODE
def Instructions.MOVSXD_GPR64_MEMd_3
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 64
  let src_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSXD_GPRv_GPRz: 63 /r
-- CPUID group: LONGMODE
def Instructions.MOVSXD_GPRv_GPRz
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src_size : Int := Std.Integer.Min operand_size 32

  let src : Bits (Std.Integer.Min operand_size 32) ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (Std.Integer.Min operand_size 32)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size (BitVec.cast (by omega) src : Bits src_size)

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSXD_GPRz_MEMz: 63 /r
-- CPUID group: LONGMODE
def Instructions.MOVSXD_GPRz_MEMz
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let src_size : Int := Std.Integer.Min operand_size 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPRv_GPR8: 0F BE /r
def Instructions.MOVSX_GPRv_GPR8
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src_size : Int := 8

  let src : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPRv_MEMb_0: 0F BE /r
def Instructions.MOVSX_GPRv_MEMb_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let src_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPRv_MEMb_1: 0F BE /r
def Instructions.MOVSX_GPRv_MEMb_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let src_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPRv_MEMb_2: 0F BE /r
def Instructions.MOVSX_GPRv_MEMb_2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let src_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPRv_MEMb_3: 0F BE /r
def Instructions.MOVSX_GPRv_MEMb_3
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let src_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOVSX_GPRv_MEMb_4: 0F BE /r
def Instructions.MOVSX_GPRv_MEMb_4
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let src_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.MOVSX operand_size src_size src

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86
