-- Generated from data/instruction/PUSHF-PUSHFD-PUSHFQ.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 24289909e073d7a20a6a668036d3123e617cfdfca94cb4573145e074cff1fc5f
-- Description: data/sdm/PUSHF-PUSHFD-PUSHFQ.docbook
-- Decrements the stack pointer by 4 (if the current operand-size attribute is 32) and pushes the
-- entire contents of the EFLAGS register onto the stack, or decrements the stack pointer by 2 (if
-- the operand-size attribute is 16) and pushes the lower 16 bits of the EFLAGS register (that is,
-- the FLAGS register) onto the stack.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PUSHF%2FPUSHFD%2FPUSHFQ)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Push_Stack
import X86.Helpers.Registers
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Zero
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
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Instructions.Operations.PUSHF
    (operand_size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let mut saved_RFLAGS : RFLAGS_Type := (← get).RFLAGS
  saved_RFLAGS := RFLAGS_Type.setRF saved_RFLAGS (0 : Runtime.Bit)
  saved_RFLAGS := RFLAGS_Type.setVM saved_RFLAGS (0 : Runtime.Bit)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode and (← RFLAGS.IOPL) != 3) then
    if ((← CR4.VME) == 0 or operand_size == 32) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    saved_RFLAGS := RFLAGS_Type.setIF saved_RFLAGS (← RFLAGS.VIF)
    saved_RFLAGS := RFLAGS_Type.setIOPL saved_RFLAGS (3 : Bits 2)

  let new_rsp : Bits 64 ← Push_Stack (← get).SS (← RSP) (← get).CS operand_size operand_size (← saved_RFLAGS[0 +: operand_size]) false
  RSP_write new_rsp

-- PUSHFD_0: 9C
def Instructions.PUSHFD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSHF operand_size

-- PUSHFD_1: 9C
def Instructions.PUSHFD_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSHF operand_size

-- PUSHFQ_0: 9C
-- CPUID group: LONGMODE
def Instructions.PUSHFQ_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSHF operand_size

-- PUSHFQ_1: 9C
-- CPUID group: LONGMODE
def Instructions.PUSHFQ_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSHF operand_size

-- PUSHF_0: 9C
def Instructions.PUSHF_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSHF operand_size

-- PUSHF_1: 9C
def Instructions.PUSHF_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSHF operand_size

-- PUSHF_2: 9C
def Instructions.PUSHF_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSHF operand_size

end X86
