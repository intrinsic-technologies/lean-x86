-- Generated from data/instruction/RDMSR.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 24c256b9ba628e3a6e38f24e9d101b6b299c1e1a7f4a03a268668d3a8f8f0e27
-- Description: data/sdm/RDMSR.docbook
-- Reads the contents of a 64-bit model specific register (MSR).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=RDMSR)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Current_Mode
import X86.Helpers.Data_Size_Of_Current_Mode
import X86.Helpers.EAX
import X86.Helpers.ECX
import X86.Helpers.EDX
import X86.Helpers.Execution_Mode
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_RDMSR_Allowed
import X86.Helpers.Mem_Fetch
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.VMX.Check_MSR_Bitmap
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
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
  [X86.Helpers.Other_MSR_Read.Binding σ]
  [X86.Helpers.Other_MSR_Read_Allowed.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.IA32_MTRRCAP.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.RDMSR_imm
    (imm32 : Bits 32) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  let msr_address : Int := Unsigned imm32

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).Use_MSR_Bitmaps == 1) then
      VMX.Check_MSR_Bitmap msr_address true VMX_EXIT_RDMSR_IMM
    else
      VM_Exit VMX_EXIT_RDMSR_IMM

  if (not (← Is_RDMSR_Allowed msr_address)) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let result : Bits 64 ← RDMSR_Behavior msr_address
  return result

def Instructions.Operations.RDMSR  : Runtime.SpecM Exception (State σ) Unit := do
  let msr_address : Int := Unsigned (← ECX)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).Use_MSR_Bitmaps == 1) then
      VMX.Check_MSR_Bitmap msr_address true VMX_EXIT_MSR_READ
    else
      VM_Exit VMX_EXIT_MSR_READ

  if (not (← Is_RDMSR_Allowed msr_address)) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let result : Bits 64 ← RDMSR_Behavior msr_address

  EAX_write (← result[31:0])
  EDX_write (← result[63:32])

-- RDMSR_GPR64u64_IMM32: VEX.L0.F2.MAP7.WIG F6 /0 id
-- CPUID group: MSR_IMM
def Instructions.RDMSR_GPR64u64_IMM32
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let imm32 : Bits 32 ← Mem_Fetch ip 32

  if (not (context.vex_LL == 0 and (← Data_Size_Of_Current_Mode) == 64 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (not (← CPUID_MSR_IMM)) then
    liftM (Report_Invalid_Opcode)

  if (not (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 4)

  let result : Bits 64 ← Instructions.Operations.RDMSR_imm imm32

  Write_GPR (size := 64) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- RDMSR: 0F 32
def Instructions.RDMSR
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

  Instructions.Operations.RDMSR

end X86
