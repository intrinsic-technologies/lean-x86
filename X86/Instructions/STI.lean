-- Generated from data/instruction/STI.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 1f584efaa91dd517a2fc8aa49df3e32f617273a80ccab1e924517159258cbb06
-- Description: data/sdm/STI.docbook
-- In most cases, STI sets the interrupt flag (IF) in the EFLAGS register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=STI)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.In_PVI_Mode
import X86.Helpers.In_VME_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

def Instructions.Operations.STI  : Runtime.SpecM Exception (State σ) Unit := do
  -- Interrupts are inhibited on the instruction boundary
  -- following an execution of STI that begins with IF := 0
  Event_Blocked.setSTI_BLOCKING ((← RFLAGS.IF) == 0)

  match (← Current_Mode) with
  | Execution_Mode.Real_Address_Mode => do
    RFLAGS.setIF 1

  | Execution_Mode.Virtual_8086_Mode => do
    if ((← RFLAGS.IOPL) == 3) then
      RFLAGS.setIF 1
    else
      if ((← In_VME_Mode) and (← RFLAGS.VIP) == 0) then
        RFLAGS.setVIF 1
      else
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  | _ => do
    if (decide (Unsigned (← RFLAGS.IOPL) ≥ (← get).CPL)) then
      RFLAGS.setIF 1
    else
      if ((← In_PVI_Mode) and (← RFLAGS.VIP) == 0) then
        RFLAGS.setVIF 1
      else
        liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

-- STI: FB
def Instructions.STI
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.STI

end X86
