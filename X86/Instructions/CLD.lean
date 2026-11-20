-- Generated from data/instruction/CLD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 92e193b1f92c0b233ba8e0466c3c3264b1f4b76940e9d4c76f52beca28be59e1
-- Description: data/sdm/CLD.docbook
-- Clears the DF flag in the EFLAGS register.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CLD)
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

def Instructions.Operations.CLD  : Runtime.SpecM Exception (State σ) Unit := do
  RFLAGS.setDF 0

-- CLD: FC
def Instructions.CLD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.CLD

end X86
