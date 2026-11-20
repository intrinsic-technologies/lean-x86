-- Generated from data/instruction/MUL.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 8a5855589c0e60c00e7bb5800b6dcee5b88176aeb06004544e04ec9fce43ec13
-- Description: data/sdm/MUL.docbook
-- Performs an unsigned multiplication of the first operand (destination operand) and the second
-- operand (source operand) and stores the result in the destination operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MUL)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Merge_GPR
import X86.Helpers.Read_GPR
import X86.Helpers.Read_GPR8
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Integer.Max
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Std.Integer.Power2
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

def Instructions.Operations.MUL
    (operand_size : Int) (src : Bits operand_size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let multiplicand : Int := Unsigned (← (do Runtime.assert (decide (operand_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RAX) 0 operand_size)))
  let multiplier : Int := Unsigned src
  let result : Int := multiplicand * multiplier

  match operand_size with
  | 8 => do
    AX_write (← result[15:0])
  | 16 | 32 | 64 => do
    let lo : Bits operand_size ← result[0 *: operand_size]
    let hi : Bits operand_size ← result[1 *: operand_size]
    RAX_write (← Merge_GPR (size := operand_size) lo (← RAX))
    RDX_write (← Merge_GPR (size := operand_size) hi (← RDX))
  | _ => throw .unmatchedCase

  RFLAGS.setOF (if (← Std.Bits.Is_Zero (size := operand_size) (← result[operand_size +: operand_size])) then 0 else 1)
  RFLAGS.setSF (← UNSPECIFIED (size := 1))
  RFLAGS.setZF (← UNSPECIFIED (size := 1))
  RFLAGS.setAF (← UNSPECIFIED (size := 1))
  RFLAGS.setPF (← UNSPECIFIED (size := 1))
  RFLAGS.setCF (if (← Std.Bits.Is_Zero (size := operand_size) (← result[operand_size +: operand_size])) then 0 else 1)

-- MUL_GPRv: F7 /4
def Instructions.MUL_GPRv
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.MUL operand_size src

-- MUL_MEMv: F7 /4
def Instructions.MUL_MEMv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.MUL operand_size src

-- MUL_GPR8: F6 /4
def Instructions.MUL_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.MUL operand_size src

-- MUL_MEMb: F6 /4
def Instructions.MUL_MEMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.MUL operand_size src

end X86
