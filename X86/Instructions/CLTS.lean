-- Generated from data/instruction/CLTS.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 868b65ab1553a050d1d66920859bf4177a0d6f2a6e03b7c646d5e2174a913bcf
-- Description: data/sdm/CLTS.docbook
-- Clears the task-switched (TS) flag in the CR0 register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CLTS)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Zero
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
  [X86.CR0_Guest_Host_Mask.Binding σ]
  [X86.CR0_Read_Shadow.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]

def Instructions.Operations.CLTS  : Runtime.SpecM Exception (State σ) Unit := do
  let mut new_cr0 : CR0_Type := (← get).CR0

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    let cr0_guest_host_mask : CR0_Type ← CR0_Guest_Host_Mask (← get).Current_VMCS_Pointer
    if (CR0_Type.TS cr0_guest_host_mask == 0) then
      new_cr0 := CR0_Type.setTS new_cr0 (0 : Runtime.Bit)
    else
      let cr0_read_shadow : CR0_Type ← CR0_Read_Shadow (← get).Current_VMCS_Pointer
      if (CR0_Type.TS cr0_read_shadow == 1) then
        VM_Exit VMX_EXIT_CR_ACCESS
  else
    new_cr0 := CR0_Type.setTS new_cr0 (0 : Runtime.Bit)

  if ((← get).VMX_Operation_Mode != VMX_Operation_Type.Outside_VMX_Operation) then
    let fixed_at_0 : CR0_Type := (← get).IA32_VMX_CR0_FIXED0
    if (CR0_Type.TS fixed_at_0 == 1) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with CR0 := new_cr0 })

-- CLTS: 0F 06
def Instructions.CLTS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  Instructions.Operations.CLTS

end X86
