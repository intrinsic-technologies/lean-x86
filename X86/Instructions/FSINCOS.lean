-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: c83b2d27a9e13732647c3b1888bf458d4aeea7504b80ae17744a252972f955d5
-- Computes both the approximate sine and the cosine of the source operand in register ST(0),
-- stores the sine in ST(0), and pushes the cosine onto the top of the FPU register stack.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FSINCOS)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Is_Unmasked_Pre_Computation_Exception
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.Push
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Sin_Cos
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87_Status_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Instruction_Context
import X86.Helpers.Null_Segment
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.ST
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.UFloatCompare
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Emulate_FSINCOS.Binding σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]

def Instructions.Operations.FSINCOS
    (src : F80_Type) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type × F80_Type × Bool) := do
  let mut result1 : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut result2 : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  Runtime.liftTotal (FP87_Status.setC0 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
  Runtime.liftTotal (FP87_Status.setC1 0)
  Runtime.liftTotal (FP87_Status.setC2 0)
  Runtime.liftTotal (FP87_Status.setC3 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))

  if (not (← Runtime.liftTotal (FP87.Is_STi_Empty 7))) then
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    Runtime.liftTotal (FP87_Status.setSF 1)
    Runtime.liftTotal (FP87_Status.setC1 1)

    result1 := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    result2 := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  else
    if (← Runtime.liftTotal (FP87.Is_STi_Empty 0)) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      Runtime.liftTotal (FP87_Status.setSF 1)

      result1 := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
      result2 := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
    else
      let (result1_1, result2_1, rounded_up, out_of_range, exceptions_1) ← FP87.Sin_Cos src
      result1 := Runtime.InitializedBits.ofValue result1_1
      result2 := Runtime.InitializedBits.ofValue result2_1
      exceptions := exceptions_1
      Runtime.liftTotal (FP87_Status.setC2 (← Bit out_of_range))
      -- C1 is undefined when the source operand is out of range (C2 == 1)
      if out_of_range then
        Runtime.liftTotal (FP87_Status.setC1 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
      else
        Runtime.liftTotal (FP87_Status.setC1 (if rounded_up and not (← Runtime.liftTotal (FP87.Is_Unmasked_Pre_Computation_Exception exceptions)) then 1 else 0))

  let write_result : Bool := (← Runtime.liftTotal (FP87_Status.C2)) == 0 and not (← Runtime.liftTotal (FP87.Is_Unmasked_Pre_Computation_Exception exceptions))

  Runtime.liftTotal (FP87.Process_Exceptions exceptions)
  return ((← Runtime.InitializedBits.read result1), (← Runtime.InitializedBits.read result2), write_result)

-- FSINCOS: D9 FB
def Instructions.FSINCOS
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← Runtime.liftTotal (FP87.Is_Enabled))) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions)

  let src : F80_Type ← Runtime.liftTotal (ST 0)
  modify ({ · with Next_IP := ip })

  let (result1, result2, write_result) ← Instructions.Operations.FSINCOS src

  if write_result then
    Runtime.liftTotal (FP87.Push)
    Runtime.liftTotal (ST_write 1 result2)
    Runtime.liftTotal (ST_write 0 result1)
  Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64))

end X86
