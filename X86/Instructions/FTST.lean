-- Generated from data/instruction/FTST.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 4064c1b509d49a68249bde55bf55a373e4e12eb52d317b464810b1fae4fedb27
-- Description: data/sdm/FTST.docbook
-- Compares the value in the ST(0) register with 0.0 and sets the condition code flags C0, C2, and
-- C3 in the FPU status word according to the results (see table below).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FTST)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Compare
import X86.Helpers.FP87.Comparison_Constants
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87.Zero
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Instruction_Context
import X86.Helpers.Null_Segment
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.ST
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]

def Instructions.Operations.FTST (src : F80_Type) : Runtime.SpecM Exception (State σ) Unit := do
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6
  let mut c320 : Bits 3 ← Std.Bits.Zero 3

  if (← FP87.Is_STi_Empty 0) then
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    FP87_Status.setSF 1
    c320 := FP87_COMPARE_INVALID
  else
    let (c320_1, exceptions_1) ← FP87.Compare src (← FP87.Zero 0) true false
    c320 := c320_1
    exceptions := exceptions_1

  FP87_Status.setC0 (← c320[0 +: 1])
  FP87_Status.setC1 0
  FP87_Status.setC2 (← c320[1 +: 1])
  FP87_Status.setC3 (← c320[2 +: 1])

  FP87.Process_Exceptions exceptions

-- FTST: D9 E4
def Instructions.FTST
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← ST 0
  modify ({ · with Next_IP := ip })

  Instructions.Operations.FTST src

  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
