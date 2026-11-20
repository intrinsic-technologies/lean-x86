-- Generated from data/instruction/FINIT-FNINIT.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: f6ab33a96aed5d1fb26a61484963bc8ea2900af10c32863c8897e3283e16ee89
-- Description: data/sdm/FINIT-FNINIT.docbook
-- Sets the FPU control, status, tag, instruction pointer, and data pointer registers to their
-- default states.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FINIT%2FFNINIT)
import X86.Runtime
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

def Instructions.Operations.FNINIT  : Runtime.SpecM Exception (State σ) Unit := do
  -- Note: does not check for pending FP exceptions

  FP87_Control.setIM 1
  FP87_Control.setDM 1
  FP87_Control.setZM 1
  FP87_Control.setOM 1
  FP87_Control.setUM 1
  FP87_Control.setPM 1
  FP87_Control.setSlice 6 2 (1 : Bits 2)
  FP87_Control.setPC 3
  FP87_Control.setRC 0
  FP87_Control.setX 0
  FP87_Control.setSlice 13 3 (0 : Bits 3)

  FP87_Status.assign (← Std.Bits.Zero 16)
  FP87_Tag_Word.assign (← Std.Bits.All_Ones 16)
  FP87_FDP.assign (← Std.Bits.Zero 64)
  FP87_FIP.assign (← Std.Bits.Zero 64)
  FP87_FCS.assign (← Std.Bits.Zero 16)
  FP87_FDS.assign (← Std.Bits.Zero 16)
  FP87_FOP.assign (← Std.Bits.Zero 11)

-- FNINIT: DB E3
def Instructions.FNINIT
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.FNINIT

end X86
