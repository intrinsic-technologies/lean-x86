-- Generated from data/instruction/MOVLHPS.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 5de57059bf077b02151463ca86a92209377ad7291428d0162dd349d4cae688aa
-- Description: data/sdm/MOVLHPS.docbook
-- This instruction cannot be used for memory to register moves.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MOVLHPS)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Read_XMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Write_XMM
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

def Instructions.Operations.MOVLHP
    (src1 src2 : Bits 128) (_element_size : Int) :
    Except (Runtime.Error Empty) (Bits 128) := do
  let low1 : Bits 64 ← src1[63:0]
  let low2 : Bits 64 ← src2[63:0]
  let result : Bits 128 ← concatBits (leftSize := 64) (rightSize := 64) low2 low1
  return result

-- MOVLHPS_XMMq_XMMq: NP 0F 16 /r
-- CPUID group: SSE
def Instructions.MOVLHPS_XMMq_XMMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let element_size : Int := 32

  let src1 : Bits 128 ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 128
  let src2 : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
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

  let result : Bits 128 ← Instructions.Operations.MOVLHP src1 src2 element_size

  Write_XMM (size := 128) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMOVLHPS_XMMdq_XMMq_XMMq: VEX.L0.NP.0F.WIG 16 /r
-- CPUID group: AVX
def Instructions.VMOVLHPS_XMMdq_XMMq_XMMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let element_size : Int := 32

  let src1 : Bits 128 ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) 128
  let src2 : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  let result : Bits 128 ← Instructions.Operations.MOVLHP src1 src2 element_size

  Write_XMM (size := 128) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMOVLHPS_XMMf32_XMMf32_XMMf32_AVX512: EVEX.L0.NP.0F.W0 16 /r
-- CPUID group: AVX512F_128N or AVX512F_128N_AVX10
def Instructions.VMOVLHPS_XMMf32_XMMf32_XMMf32_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let element_size : Int := 32

  let src1 : Bits 128 ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) 128
  let src2 : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits 128 ← Instructions.Operations.MOVLHP src1 src2 element_size

  Write_XMM (size := 128) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

end X86
