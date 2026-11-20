-- Generated from data/instruction/HLT.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: f9a6a41483d11a4f5318f39379426b1b68f797ed296ea9e8ff2540e60a54b664
-- Description: data/sdm/HLT.docbook
-- Stops instruction execution and places the processor in a HALT state.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=HLT)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Thread_Status_Type
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
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]

def Instructions.Operations.HLT  : Runtime.SpecM Exception (State σ) Unit := do
  modify ({ · with Thread_Status := Thread_Status_Type.THREAD_HALTED })

-- HLT: F4
def Instructions.HLT
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).HLT_Exiting == 1) then
      VM_Exit VMX_EXIT_HLT

  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  modify ({ · with Next_IP := ip })

  Instructions.Operations.HLT

end X86
