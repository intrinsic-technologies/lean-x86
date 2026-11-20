-- Generated from data/instruction/DIV.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: e8de2597c7ae0114736f7a2324e62c5985b2c064ccecfd092c88650d73217209
-- Description: data/sdm/DIV.docbook
-- Divides unsigned the value in the AX, DX:AX, EDX:EAX, or RDX:RAX registers (dividend) by the
-- source operand (divisor) and stores the result in the AX (AH:AL), DX:AX, EDX:EAX, or RDX:RAX
-- registers.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=DIV)
import X86.Runtime
import X86.Helpers.EAX
import X86.Helpers.EDX
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_GPR
import X86.Helpers.Read_GPR8
import X86.Helpers.Registers
import X86.Helpers.Report_Divide_Error
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Std.Integer.Truncated_Divide
import X86.Helpers.Std.Integer.Truncated_Remainder
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

def Instructions.Operations.DIV
    (operand_size : Int) (src : Bits operand_size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let mut dividend : Int ←
    match operand_size with
    | 8 => do
      pure (Unsigned (← AX))
    | 16 => do
      pure (Unsigned (← concatBits (leftSize := 16) (rightSize := 16) (← DX) (← AX)))
    | 32 => do
      pure (Unsigned (← concatBits (leftSize := 32) (rightSize := 32) (← EDX) (← EAX)))
    | 64 => do
      pure (Unsigned (← concatBits (leftSize := 64) (rightSize := 64) (← RDX) (← RAX)))
    | _ => throw .unmatchedCase
  let divisor : Int := Unsigned src

  if (divisor == 0) then
    liftM (Report_Divide_Error)

  let quotient : Int ← Std.Integer.Truncated_Divide dividend divisor
  let remainder : Int ← Std.Integer.Truncated_Remainder dividend divisor

  if (decide (Unsigned (← dividend[operand_size +: operand_size]) ≥ divisor)) then
    liftM (Report_Divide_Error)

  match operand_size with
  | 8 => do
    let (AH_value, AL_value) := ((← remainder[7:0]), (← quotient[7:0]))
    AH_write AH_value
    AL_write AL_value
  | 16 => do
    let (DX_value, AX_value) := ((← remainder[15:0]), (← quotient[15:0]))
    DX_write DX_value
    AX_write AX_value
  | 32 => do
    let (EDX_value, EAX_value) := ((← remainder[31:0]), (← quotient[31:0]))
    EDX_write EDX_value
    EAX_write EAX_value
  | 64 => do
    let (RDX_value, RAX_value) := ((← remainder[63:0]), (← quotient[63:0]))
    RDX_write RDX_value
    RAX_write RAX_value
  | _ => throw .unmatchedCase

  RFLAGS.setOF (← UNSPECIFIED (size := 1))
  RFLAGS.setSF (← UNSPECIFIED (size := 1))
  RFLAGS.setZF (← UNSPECIFIED (size := 1))
  RFLAGS.setAF (← UNSPECIFIED (size := 1))
  RFLAGS.setPF (← UNSPECIFIED (size := 1))
  RFLAGS.setCF (← UNSPECIFIED (size := 1))

-- DIV_GPRv: F7 /6
def Instructions.DIV_GPRv
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.DIV operand_size src

-- DIV_MEMv: F7 /6
def Instructions.DIV_MEMv
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

  Instructions.Operations.DIV operand_size src

-- DIV_GPR8: F6 /6
def Instructions.DIV_GPR8
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.DIV operand_size src

-- DIV_MEMb: F6 /6
def Instructions.DIV_MEMb
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

  Instructions.Operations.DIV operand_size src

end X86
