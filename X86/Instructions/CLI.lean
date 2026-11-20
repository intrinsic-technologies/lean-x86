-- Generated from data/instruction/CLI.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 1db97c1d5197c47d475f8d337e4a8ce1468e5991144f513fe59632689d808853
-- Description: data/sdm/CLI.docbook
-- In most cases, CLI clears the IF flag in the EFLAGS register and no other flags are affected.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CLI)
import X86.Runtime
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

def Instructions.Operations.CLI  : Runtime.SpecM Exception (State σ) Unit := do
  if ((← CR0.PE) == 0 or decide (Unsigned (← RFLAGS.IOPL) ≥ (← get).CPL)) then
    RFLAGS.setIF 0
  else
    if ((← In_VME_Mode) or (← In_PVI_Mode)) then
      RFLAGS.setVIF 0
    else
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

-- CLI: FA
def Instructions.CLI
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.CLI

end X86
