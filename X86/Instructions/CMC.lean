-- Generated from data/instruction/CMC.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: a09d5a96ad4d810a9e17c1cb8d431cee2263b8e578f84a73a2d919ff2b9171ce
-- Description: data/sdm/CMC.docbook
-- Complements the CF flag in the EFLAGS register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CMC)
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

def Instructions.Operations.CMC  : Runtime.SpecM Exception (State σ) Unit := do
  RFLAGS.setCF (~~~ (← RFLAGS.CF))

-- CMC: F5
def Instructions.CMC
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.CMC

end X86
