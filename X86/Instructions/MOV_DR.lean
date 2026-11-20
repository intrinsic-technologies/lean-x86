-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 1dfab1a3cd13281724da34d6e46e97be7965338893a520688f0f504da950cead
-- Moves the contents of a debug register (DR0, DR1, DR2, DR3, DR4, DR5, DR6, or DR7) to a
-- general-purpose register or vice versa.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MOV)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Clear_Debug_Traps
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Instruction_Breakpoint_Match
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Read_DR
import X86.Helpers.Read_GPR
import X86.Helpers.Report_Debug_Exception
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
import X86.Helpers.Write_CR
import X86.Helpers.Write_GPR
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]

def Instructions.Operations.MOV_from_DR
    (result_size : Int) (src : Bits 64) (_dr_index : Int) :
    Runtime.SpecM Exception (State σ) (Bits result_size) := do
  Runtime.assert (result_size == 32 || result_size == 64)

  if ((← DR7.GD) == 1) then
    DR6.setBD 1
    let (_, DR6_part) ← Get_Instruction_Breakpoint_Match
    DR6.setB DR6_part
    DR6.setB ((BitVec.cast (by omega) (← DR6.B) : Bits 4) or (← get).Debug_Breakpoints_Matched)
    Clear_Debug_Traps
    DR7.setGD 0
    modify ({ · with Execution_Debug_Cause := Debug_Cause.Debug_General_Detect })
    liftM (Report_Debug_Exception)

  let result : Bits result_size ← src[0 +: result_size]
  return result

def Instructions.Operations.MOV_to_DR
    (src_size : Int) (src : Bits src_size) (dr_index : Int) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.assert (src_size == 32 || src_size == 64)

  if ((← DR7.GD) == 1) then
    DR6.setBD 1
    let (_, DR6_part) ← Get_Instruction_Breakpoint_Match
    DR6.setB DR6_part
    DR6.setB ((BitVec.cast (by omega) (← DR6.B) : Bits 4) or (← get).Debug_Breakpoints_Matched)
    Clear_Debug_Traps
    DR7.setGD 0
    modify ({ · with Execution_Debug_Cause := Debug_Cause.Debug_General_Detect })
    liftM (Report_Debug_Exception)

  -- upper 32 bits of DR4-7 are reserved
  if (src_size == 64 and ((dr_index in {(4 : Int)..(7 : Int)}))) then
    if (dr_index == 7 and (← CPUID_TRIGGER_DR_MATCH)) then
      if (not (← Std.Bits.Is_Zero (size := 28) (← src[63:36]))) then
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
    else
      if (not (← Std.Bits.Is_Zero (size := 32) (← src[63:32]))) then
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let mut result : Bits 64 ← Std.Bits.Zero_Extend (source_size := src_size) src 64
  return result

-- MOV_DR_GPR32_DR: 0F 21 /r
def Instructions.MOV_DR_GPR32_DR
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let result_size : Int := 32
  let dr_index : Int := Unsigned (← concatBits (leftSize := 1) (rightSize := 3) context.rex_r3 (← reg[2:0]))

  let src : Bits 64 ← Read_DR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if (decide (dr_index > 7)) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.DE) == 1 and ((dr_index == (4 : Int)) || (dr_index == (5 : Int)))) then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).MOV_DR_Exiting == 1) then
      VM_Exit VMX_EXIT_DR_ACCESS

  if ((← get).CPL != 0 and (← Current_Mode) != Execution_Mode.Real_Address_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.MOV_from_DR result_size src dr_index

  Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- MOV_DR_GPR64_DR: 0F 21 /r
def Instructions.MOV_DR_GPR64_DR
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let result_size : Int := 64
  let dr_index : Int := Unsigned (← concatBits (leftSize := 1) (rightSize := 3) context.rex_r3 (← reg[2:0]))

  let src : Bits 64 ← Read_DR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if (decide (dr_index > 7)) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.DE) == 1 and ((dr_index == (4 : Int)) || (dr_index == (5 : Int)))) then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).MOV_DR_Exiting == 1) then
      VM_Exit VMX_EXIT_DR_ACCESS

  if ((← get).CPL != 0 and (← Current_Mode) != Execution_Mode.Real_Address_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.MOV_from_DR result_size src dr_index

  Write_GPR (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- MOV_DR_DR_GPR32: 0F 23 /r
def Instructions.MOV_DR_DR_GPR32
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src_size : Int := 32
  let dr_index : Int := Unsigned (← concatBits (leftSize := 1) (rightSize := 3) context.rex_r3 (← reg[2:0]))

  let src : Bits 32 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if (decide (dr_index > 7)) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.DE) == 1 and ((dr_index == (4 : Int)) || (dr_index == (5 : Int)))) then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).MOV_DR_Exiting == 1) then
      VM_Exit VMX_EXIT_DR_ACCESS

  if ((← get).CPL != 0 and (← Current_Mode) != Execution_Mode.Real_Address_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  let result : Bits 64 ← Instructions.Operations.MOV_to_DR src_size src dr_index

  Write_DR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- MOV_DR_DR_GPR64: 0F 23 /r
def Instructions.MOV_DR_DR_GPR64
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src_size : Int := 64
  let dr_index : Int := Unsigned (← concatBits (leftSize := 1) (rightSize := 3) context.rex_r3 (← reg[2:0]))

  let src : Bits 64 ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if (decide (dr_index > 7)) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.DE) == 1 and ((dr_index == (4 : Int)) || (dr_index == (5 : Int)))) then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).MOV_DR_Exiting == 1) then
      VM_Exit VMX_EXIT_DR_ACCESS

  if ((← get).CPL != 0 and (← Current_Mode) != Execution_Mode.Real_Address_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  let result : Bits 64 ← Instructions.Operations.MOV_to_DR src_size src dr_index

  Write_DR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86
