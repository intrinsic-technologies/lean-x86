-- Generated from data/instruction/LFENCE.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 11fdd722170aee10662cff7774d2267fc8cc2b1362776dbee06ffb2e1066403e
-- Description: data/sdm/LFENCE.docbook
-- Performs a serializing operation on all load-from-memory instructions that were issued prior the
-- LFENCE instruction.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=LFENCE)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Memory_Load_Fence
import X86.Helpers.Report_Invalid_Opcode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Helpers.Memory_Load_Fence.Binding σ]

def Instructions.Operations.LFENCE  : Runtime.SpecM Exception (State σ) Unit := do
  Memory_Load_Fence

-- LFENCE: NP 0F AE /5
-- CPUID group: SSE2
def Instructions.LFENCE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.LFENCE

end X86
