-- Generated from data/instruction/WAIT-FWAIT.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 2855d7e9f65b57288d4d894b10be55867fd5234d794d7ecdce29598f6e4ed36c
-- Description: data/sdm/WAIT-FWAIT.docbook
-- Causes the processor to check for and handle pending, unmasked, floating-point exceptions before
-- proceeding.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=WAIT%2FFWAIT)
import X86.Runtime
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Helpers.Unimplemented_Feature.Binding σ]

def Instructions.Operations.FWAIT  : Runtime.SpecM Exception (State σ) Unit := do
  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (← UNSPECIFIED (size := 1))
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))

-- FWAIT: 9B
def Instructions.FWAIT
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.MP) == 1 and (← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  Instructions.Operations.FWAIT

end X86
