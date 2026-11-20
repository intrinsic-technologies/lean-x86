-- Generated from data/instruction/STD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 270a81b768c37a2a13b607c46f669b3b40840aeac23874b2f919544a1019c379
-- Description: data/sdm/STD.docbook
-- Sets the DF flag in the EFLAGS register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=STD)
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

def Instructions.Operations.STD  : Runtime.SpecM Exception (State σ) Unit := do
  RFLAGS.setDF 1

-- STD: FD
def Instructions.STD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.STD

end X86
