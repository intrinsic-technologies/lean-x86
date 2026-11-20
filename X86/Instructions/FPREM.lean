-- Generated from data/instruction/FPREM.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 22604ab74b5af6287d685ce48f5ca01b3af1ca64c6c92989f46d3e389306213c
-- Description: data/sdm/FPREM.docbook
-- Computes the remainder obtained from dividing the value in the ST(0) register (the dividend) by
-- the value in the ST(1) register (the divisor or modulus), and stores the result in ST(0).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FPREM)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Is_Unmasked_Pre_Computation_Exception
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Remainder
import X86.Helpers.FP87.Update_Instruction_Info
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
  [X86.Helpers.Select_FP87_Remainder_Reduction.Binding σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]

def Instructions.Operations.FPREM
    (src1 src2 : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  if ((← FP87.Is_STi_Empty 0) or (← FP87.Is_STi_Empty 1)) then
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    FP87_Status.setSF 1
    FP87_Status.setC0 (← UNSPECIFIED (size := 1))
    FP87_Status.setC1 0
    FP87_Status.setC2 (← UNSPECIFIED (size := 1))
    FP87_Status.setC3 (← UNSPECIFIED (size := 1))
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  else
    let (result_1, c3210, exceptions_1) ← FP87.Remainder src1 src2 false
    result := Runtime.InitializedBits.ofValue result_1
    exceptions := exceptions_1

    if (not (← FP87.Is_Unmasked_Pre_Computation_Exception exceptions)) then
      FP87_Status.setCC c3210
    else
      FP87_Status.setC1 0
      FP87_Status.setC2 0

  let write_result : Bool := not (← FP87.Is_Unmasked_Pre_Computation_Exception exceptions)

  FP87.Process_Exceptions exceptions
  return ((← Runtime.InitializedBits.read result), write_result)

-- FPREM: D9 F8
def Instructions.FPREM
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← ST 0
  let src2 : F80_Type ← ST 1
  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FPREM src1 src2

  if write_result then
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
