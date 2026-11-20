-- Generated from data/instruction/FCLEX-FNCLEX.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: d155450c1fee31268364ce3e80f059a655b6a654b6569600798f40695f4349a5
-- Description: data/sdm/FCLEX-FNCLEX.docbook
-- Clears the floating-point exception flags (PE, UE, OE, ZE, DE, and IE), the exception summary
-- status flag (ES), the stack fault flag (SF), and the busy flag (B) in the FPU status word.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FCLEX%2FFNCLEX)
import X86.Runtime
import X86.Helpers.FP87.Is_Enabled
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

def Instructions.Operations.FNCLEX  : Runtime.SpecM Exception (State σ) Unit := do
  -- Note: does not check for pending FP exceptions

  FP87_Status.setIE 0
  FP87_Status.setDE 0
  FP87_Status.setZE 0
  FP87_Status.setOE 0
  FP87_Status.setUE 0
  FP87_Status.setPE 0
  FP87_Status.setSF 0
  FP87_Status.setES 0
  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (← UNSPECIFIED (size := 1))
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  -- FP87_Status.TOP and FP87_Status.CC are not affected
  FP87_Status.setB 0

-- FNCLEX: DB E2
def Instructions.FNCLEX
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.FNCLEX

end X86
