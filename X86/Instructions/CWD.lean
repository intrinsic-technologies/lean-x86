-- Generated from data/instruction/CWD-CDQ-CQO.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 519f1b71a0a9ea1ec2f36278135650aab065c26877157beb1d04f7f55000cb47
-- Description: data/sdm/CWD-CDQ-CQO.docbook
-- Doubles the size of the operand in register AX, EAX, or RAX (depending on the operand size) by
-- means of sign extension and stores the result in registers DX:AX, EDX:EAX, or RDX:RAX,
-- respectively.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CWD%2FCDQ%2FCQO)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Write_RDX
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

def Instructions.Operations.SIGNEXTEND2
    (operand_size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let value : Bits (operand_size * (2 : Int)) ← Std.Bits.Sign_Extend (source_size := operand_size) (← (do Runtime.assert (decide (operand_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RAX) 0 operand_size))) (operand_size * 2)
  Write_RDX (size := operand_size) (← (do Runtime.assert (decide (operand_size + operand_size ≤ operand_size * 2)); pure (← value[operand_size +: operand_size])))

-- CDQ_0: 99
def Instructions.CDQ_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND2 operand_size

-- CDQ_1: 99
def Instructions.CDQ_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND2 operand_size

-- CDQ_2: 99
def Instructions.CDQ_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND2 operand_size

-- CQO: 99
-- CPUID group: LONGMODE
def Instructions.CQO
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND2 operand_size

-- CWD_0: 99
def Instructions.CWD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND2 operand_size

-- CWD_1: 99
def Instructions.CWD_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND2 operand_size

-- CWD_2: 99
def Instructions.CWD_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND2 operand_size

end X86
