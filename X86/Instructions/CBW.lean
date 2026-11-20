-- Generated from data/instruction/CBW-CWDE-CDQE.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: e31f465007588e2aed0755bd0e97d5d07407664aeeeac3ad97b7329749ab7bc0
-- Description: data/sdm/CBW-CWDE-CDQE.docbook
-- Double the size of the source operand by means of sign extension.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CBW%2FCWDE%2FCDQE)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Write_RAX
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

def Instructions.Operations.SIGNEXTEND1
    (operand_size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  Write_RAX (size := operand_size) (← (do
    let width ← Std.Integer.Positive_Divide operand_size 2
    return (← Std.Bits.Sign_Extend (source_size := width) (← (do
      Runtime.assert (decide (width ≤ 64))
      Runtime.assert (decide (0 ≤ width))
      pure (← Runtime.CheckedSlice.read (← RAX) 0 width))) operand_size)))

-- CBW_0: 98
def Instructions.CBW_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND1 operand_size

-- CBW_1: 98
def Instructions.CBW_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND1 operand_size

-- CBW_2: 98
def Instructions.CBW_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 16

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND1 operand_size

-- CDQE: 98
-- CPUID group: LONGMODE
def Instructions.CDQE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND1 operand_size

-- CWDE_0: 98
def Instructions.CWDE_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND1 operand_size

-- CWDE_1: 98
def Instructions.CWDE_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SIGNEXTEND1 operand_size

-- CWDE_2: 98
def Instructions.CWDE_2
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

  Instructions.Operations.SIGNEXTEND1 operand_size

end X86
