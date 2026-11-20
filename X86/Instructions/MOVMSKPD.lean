-- Generated from data/instruction/MOVMSKPD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 7479a0196df54adce937f0c90cf5c53e9e1bf165a0346a829ee120d50f5a0bea
-- Description: data/sdm/MOVMSKPD.docbook
-- Extracts the sign bits from the packed double precision floating-point values in the source
-- operand (second operand), formats them into a 2-bit mask, and stores the mask in the destination
-- operand (first operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MOVMSKPD)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Read_XMM
import X86.Helpers.Read_YMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Write_GPR
import X86.Instructions.PMOVMSKB
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

-- MOVMSKPD_GPR32_XMMpd: 66 0F 50 /r
-- CPUID group: SSE2
def Instructions.MOVMSKPD_GPR32_XMMpd
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 32
  let element_size : Int := 64

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

-- VMOVMSKPD_GPR32d_XMMdq: VEX.L0.66.0F.WIG 50 /r
-- CPUID group: AVX
def Instructions.VMOVMSKPD_GPR32d_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 32
  let element_size : Int := 64

  let src : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
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

-- VMOVMSKPD_GPR32d_YMMqq: VEX.L1.66.0F.WIG 50 /r
-- CPUID group: AVX
def Instructions.VMOVMSKPD_GPR32d_YMMqq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let result_size : Int := 32
  let element_size : Int := 64

  let src : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
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
