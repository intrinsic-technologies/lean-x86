-- Generated from data/instruction/ENDBR64.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 0cb4609a692ce9130bbda2a9b530d9d42b6f98b74d7572f84656201db10c3e6a
-- Description: data/sdm/ENDBR64.docbook
-- Terminate an indirect branch in 64 bit mode.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=ENDBR64)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.CET.Check_Endbranch
import X86.Helpers.CET.Clear_Tracker_Status
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_End_Branch_Enabled
import X86.Helpers.Report_Invalid_Opcode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]

def Instructions.Operations.ENDBR64  : Runtime.SpecM Exception (State σ) Unit := do
  if (← Is_End_Branch_Enabled (← get).CPL) then
    if (← In_64Bit_Mode) then
      CET.Clear_Tracker_Status
    else
      CET.Check_Endbranch (← get).CPL

-- ENDBR64: F3 0F 1E FA
-- CPUID group: CET
def Instructions.ENDBR64
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (not (← CPUID_CET_SS)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.ENDBR64

end X86
