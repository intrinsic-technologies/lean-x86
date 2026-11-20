-- Generated from data/instruction/FXAM.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 1a910fc97d7cf71759f306d2245ea44690c3fa50fcf9836e91012c3ac8dce990
-- Description: data/sdm/FXAM.docbook
-- Examines the contents of the ST(0) register and sets the condition code flags C0, C2, and C3 in
-- the FPU status word to indicate the class of value or number in the register (see the table
-- below).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FXAM)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP87_Status_Type
import X86.Helpers.Instruction_Context
import X86.Helpers.Null_Segment
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
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

def Instructions.Operations.FXAM  : Runtime.SpecM Exception (State σ) Unit := do
  let src : F80_Type ← (do
    let __check447 : Int := Unsigned (← FP87_Status.TOP)
    Runtime.assert (decide (__check447 < 8))
    Runtime.assert (decide (0 ≤ __check447))
    pure (← FP87.get __check447))

  let c320 : Bits 3 ← do
    if (← FP87.Is_STi_Empty 0) then
      let c320 : Bits 3 := 5
      pure c320
    else
      let mut c320 : Bits 3 ←
        match (← FP87.Classify src) with
        | FP87_Class_Type.FP87_Class_Unsupported => do
          pure 0
        | FP87_Class_Type.FP87_Class_QNaN | FP87_Class_Type.FP87_Class_SNaN => do
          pure 1
        | FP87_Class_Type.FP87_Class_Normal => do
          pure 2
        | FP87_Class_Type.FP87_Class_Infinity => do
          pure 3
        | FP87_Class_Type.FP87_Class_Zero => do
          pure 4
        | FP87_Class_Type.FP87_Class_Denormal => do
          pure 6
      pure c320

  FP87_Status.setC0 (← c320[0 +: 1])
  FP87_Status.setC1 (F80_Type.Sign src)
  FP87_Status.setC2 (← c320[1 +: 1])
  FP87_Status.setC3 (← c320[2 +: 1])

-- FXAM: D9 E5
def Instructions.FXAM
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  Instructions.Operations.FXAM

  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
