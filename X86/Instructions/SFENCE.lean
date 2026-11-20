-- Generated from data/instruction/SFENCE.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 73fbea4bae3b78efa51a049275d635efca69ea056c8d2e660d88b71e8f7ff272
-- Description: data/sdm/SFENCE.docbook
-- Orders processor execution relative to all memory stores prior to the SFENCE instruction.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=SFENCE)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Memory_Store_Fence
import X86.Helpers.Report_Invalid_Opcode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Helpers.Memory_Store_Fence.Binding σ]

def Instructions.Operations.SFENCE  : Runtime.SpecM Exception (State σ) Unit := do
  Memory_Store_Fence

-- SFENCE: NP 0F AE /7
-- CPUID group: SSE
def Instructions.SFENCE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SFENCE

end X86
