-- Generated from data/instruction/UD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: ae567af832ece07da55bac39b5a4cbe3bf1ad020d2f24472a92f4561c5a1ef5d
-- Description: data/sdm/UD.docbook
-- Generates an invalid opcode exception.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=UD)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Read_GPR
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
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

-- This procedure never returns normally; its result type is unrestricted.
def Instructions.Operations.UD2 {α : Type} : Result α := do
  liftM (Report_Invalid_Opcode)

-- This procedure never returns normally; its result type is unrestricted.
def Instructions.Operations.UD {α : Type} (_src1 _src2 : Bits 32) : Result α := do
  liftM (Report_Invalid_Opcode)

-- This procedure never returns normally; its result type is unrestricted.
def Instructions.Operations.UD_mem {α : Type}
    (_src1 : Bits 32) (_segment : Segment) (_effective_address : Bits 64) :
    Result α := do
  liftM (Report_Invalid_Opcode)

-- UD2: 0F 0B
def Instructions.UD2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  liftM (Instructions.Operations.UD2)

-- UDB: D6
def Instructions.UDB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  liftM (Instructions.Operations.UD2)

-- UD1_GPR32_GPR32: 0F B9 /r
def Instructions.UD1_GPR32_GPR32
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src1 : Bits 32 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 32
  let src2 : Bits 32 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  liftM (Instructions.Operations.UD src1 src2)

-- UD1_GPR32_MEMd: 0F B9 /r
def Instructions.UD1_GPR32_MEMd
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits 32 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 32
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  liftM (Instructions.Operations.UD_mem src1 segment effective_address)

-- UD0_GPR32_GPR32: 0F FF /r
def Instructions.UD0_GPR32_GPR32
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src1 : Bits 32 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 32
  let src2 : Bits 32 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  liftM (Instructions.Operations.UD src1 src2)

-- UD0_GPR32_MEMd: 0F FF /r
def Instructions.UD0_GPR32_MEMd
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits 32 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 32
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := next_ip0 })

  liftM (Instructions.Operations.UD_mem src1 segment effective_address)

end X86
