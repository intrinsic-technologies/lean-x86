-- Generated from data/instruction/MFENCE.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: b8806c6bd6a6915fb035a7b704446015b48eb837c3e5fa78bf25882a669608b2
-- Description: data/sdm/MFENCE.docbook
-- Memory Fence
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MFENCE)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Memory_Fence
import X86.Helpers.Report_Invalid_Opcode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Helpers.Memory_Fence.Binding σ]

def Instructions.Operations.MFENCE  : Runtime.SpecM Exception (State σ) Unit := do
  Memory_Fence

-- MFENCE: NP 0F AE /6
-- CPUID group: SSE2
def Instructions.MFENCE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.MFENCE

end X86
