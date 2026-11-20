-- Generated from data/instruction/MOVQ2DQ.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: a1b7367a4392ff425cfeccb0263b4d9c6243c544957e16a0013a0036eb3bf29c
-- Description: data/sdm/MOVQ2DQ.docbook
-- Moves the quadword from the source operand (second operand) to the low quadword of the
-- destination operand (first operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MOVQ2DQ)
import X86.Runtime
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.Instruction_Context
import X86.Helpers.Read_MMX
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Write_XMM
import X86.Instructions.MOV
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Helpers.Unimplemented_Feature.Binding σ]

-- MOVQ2DQ_XMMdq_MMXq: F3 0F D6 /r
-- CPUID group: SSE2
def Instructions.MOVQ2DQ_XMMdq_MMXq
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 64

  let src : Bits 64 ← Runtime.CheckedSlice.read (← Read_MMX rm) 0 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  FP87_Status.setTOP 0
  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.MOV operand_size src

  Write_XMM (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

end X86
