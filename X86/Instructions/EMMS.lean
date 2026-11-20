-- Generated from data/instruction/EMMS.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 08a15d11d866bc9cfc99ad6b3de64fa6d8676f76057cd8681d685e099c303397
-- Description: data/sdm/EMMS.docbook
-- Sets the values of all the tags in the x87 FPU tag word to empty (all 1s).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=EMMS)
import X86.Runtime
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Std.Bits.All_Ones
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Helpers.Unimplemented_Feature.Binding σ]

def Instructions.Operations.EMMS  : Runtime.SpecM Exception (State σ) Unit := do
  FP87_Tag_Word.assign (← Std.Bits.All_Ones 16)
  FP87_Status.setTOP 0

-- EMMS: NP 0F 77
-- CPUID group: PENTIUMMMX
def Instructions.EMMS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (not (context.rep_prefix == 0 and not context.osz_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  Instructions.Operations.EMMS

end X86
