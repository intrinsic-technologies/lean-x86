-- Generated from data/instruction/CLC.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 459efb97b03f9c17f0697d439175b1520aa223e8c107a51f2e83b659d8e1fab6
-- Description: data/sdm/CLC.docbook
-- Clears the CF flag in the EFLAGS register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CLC)
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

def Instructions.Operations.CLC  : Runtime.SpecM Exception (State σ) Unit := do
  RFLAGS.setCF 0

-- CLC: F8
def Instructions.CLC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.CLC

end X86
