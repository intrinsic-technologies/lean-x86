-- Generated from a local ISA specification; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 62c3aae4ac22ce59ea4c3243b72a1ade26e3bdeccd5d05e30dd4f0395edfb638
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PAUSE)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Unimplemented_Feature
import X86.Helpers.VMX_Operation_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Helpers.Unimplemented_Feature.Binding σ]

-- XML has no PAUSE body. The SDM permits zero delay and no architectural
-- state changes. Timing, power effects and VMX pause exits are not modeled here.
-- https://intel.github.io/SDM/sdm.html?instr=PAUSE
def Instructions.Operations.PAUSE  : Except (Runtime.Error Empty) Unit := do
  pure ()

def Instructions.PAUSE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    Unimplemented_Feature "PAUSE VMX execution controls" false true
  modify ({ · with Next_IP := ip })
  Instructions.Operations.PAUSE

end X86
