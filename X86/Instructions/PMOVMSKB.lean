-- Generated from data/instruction/PMOVMSKB.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 5c98072ca83e8a0deafac8af1ef3c8046f746900ed27d8bd08d934566fe2fe64
-- Description: data/sdm/PMOVMSKB.docbook
-- Creates a mask made up of the most significant bit of each byte of the source operand (second
-- operand) and stores the result in the low byte or word of the destination operand (first
-- operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PMOVMSKB)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.Instruction_Context
import X86.Helpers.Read_MMX
import X86.Helpers.Read_XMM
import X86.Helpers.Read_YMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Write_GPR
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Helpers.Unimplemented_Feature.Binding σ]

def Instructions.Operations.MOVMSK
    (element_size register_size result_size : Int) (src : Bits register_size) :
    Except (Runtime.Error Empty) (Bits result_size) := do
  Runtime.assert (0 ≤ register_size)
  Runtime.assert (0 ≤ result_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size

  let mut r : Runtime.InitializedBits elements := Runtime.InitializedBits.empty elements
  for i in intRange (0 : Int) (elements - 1) do
    Runtime.assert (decide (i < elements))
    r := (← Runtime.InitializedBits.writeSlice r i 1 (← src[i * element_size + (element_size - 1) +: 1]))
  let result : Bits result_size ← Std.Bits.Zero_Extend (source_size := elements) (← Runtime.InitializedBits.read r) result_size
  return result

-- PMOVMSKB_GPR32_MMXq: NP 0F D7 /r
-- CPUID group: SSE
def Instructions.PMOVMSKB_GPR32_MMXq
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let result_size : Int := 32
  let element_size : Int := 8

  let src : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Read_MMX rm) 0 register_size)

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  FP87_Status.setTOP 0
  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.MOVMSK element_size register_size result_size src

  Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result
  FP87_Tag_Word.assign (← Std.Bits.Zero 16)

-- PMOVMSKB_GPR32_XMMdq: 66 0F D7 /r
-- CPUID group: SSE2
def Instructions.PMOVMSKB_GPR32_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 32
  let element_size : Int := 8

  let src : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.MOVMSK element_size register_size result_size src

  Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPMOVMSKB_GPR32d_XMMdq: VEX.L0.66.0F.WIG D7 /r
-- CPUID group: AVX
def Instructions.VPMOVMSKB_GPR32d_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 32
  let element_size : Int := 8

  let src : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 1 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.MOVMSK element_size register_size result_size src

  Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPMOVMSKB_GPR32d_YMMqq: VEX.L1.66.0F.WIG D7 /r
-- CPUID group: AVX2
def Instructions.VPMOVMSKB_GPR32d_YMMqq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let result_size : Int := 32
  let element_size : Int := 8

  let src : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 1 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.MOVMSK element_size register_size result_size src

  Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86
