-- Generated from data/instruction/STC.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 492ccd310792ae8c899b08a95f2672a92b0e23568af5b3556717569884b4987a
-- Description: data/sdm/STC.docbook
-- Sets the CF flag in the EFLAGS register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=STC)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_Invalid_Opcode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

def Instructions.Operations.STC  : Runtime.SpecM Exception (State σ) Unit := do
  RFLAGS.setCF 1

-- STC: F9
def Instructions.STC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.STC

end X86
