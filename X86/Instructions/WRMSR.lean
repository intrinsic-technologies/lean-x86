-- Generated from data/instruction/WRMSR.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 09c4a5d9b4e1e4f6ec95d597cffeeb041193c8ca1f0d787852e64e91019b807c
-- Description: data/sdm/WRMSR.docbook
-- Writes the contents of registers EDX:EAX into the 64-bit model specific register (MSR) specified
-- in the ECX register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=WRMSR)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.EAX
import X86.Helpers.ECX
import X86.Helpers.EDX
import X86.Helpers.Execution_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_RDMSR_Allowed
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Serialize_Instructions
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.VMX.Check_MSR_Bitmap
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Other_MSR_Commit.Binding σ]
  [X86.Helpers.Other_MSR_Write_Allowed.Binding σ]
  [X86.Helpers.Other_MSR_Write_Behavior.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.IA32_MTRRCAP.Binding σ]
  [X86.Invalidate_All_Translation_Caches.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.Config.Value.Max_Physical_Address]

def Instructions.Operations.WRMSR  : Runtime.SpecM Exception (State σ) Unit := do
  Serialize_Instructions

  let msr_address : Int := Unsigned (← ECX)
  let new_value : Bits 64 ← concatBits (leftSize := 32) (rightSize := 32) (← EDX) (← EAX)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).Use_MSR_Bitmaps == 1) then
      VMX.Check_MSR_Bitmap msr_address false VMX_EXIT_MSR_WRITE
    else
      VM_Exit VMX_EXIT_MSR_WRITE

  if (not (← Is_WRMSR_Allowed msr_address new_value)) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  MSR_write msr_address (← WRMSR_Behavior msr_address new_value)

-- WRMSR: 0F 30
def Instructions.WRMSR
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if ((← get).CPL != 0 and (← Current_Mode) != Execution_Mode.Real_Address_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  Instructions.Operations.WRMSR

end X86
