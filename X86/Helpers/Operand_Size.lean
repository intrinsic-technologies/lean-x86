-- Generated from data/definitions.xml.gz: Operand_Size; do not edit.
-- Source SHA256: c4b322df7658ea979500d28a76434ba79895a9e1f25d0e4be08de3c2121e897c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Operand_Size)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Operand_Size (context : Instruction_Context) : Runtime.SpecM Exception (State σ) (Int) := do
  if (← In_64Bit_Mode) then
    if (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) then
      if (context.rex_w == 0) then
        return if context.osz_prefix_present or context.vex_pp == 1 then 16 else 32
      else
        return 64
    else
      return if context.osz_prefix_present then 16 else 32
  else
    if ((← Segment_Descriptor.D.partial (← get).CS.descriptor) == 0) then
      return if context.osz_prefix_present then 32 else 16
    else
      return if context.osz_prefix_present then 16 else 32

end X86.Helpers
