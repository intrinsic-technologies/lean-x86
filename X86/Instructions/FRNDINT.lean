-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 441ccc56bef3285bf6ef7ac699dc915dd347afae132c01c22d53cf34e78f6f6f
-- Rounds the source value in the ST(0) register to the nearest integral value, depending on the
-- current rounding mode (setting of the RC field of the FPU control word), and stores the result
-- in ST(0).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FRNDINT)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Is_Unmasked_Pre_Computation_Exception
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Read_STi
import X86.Helpers.FP87.Round_To_Integer
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP87_Status_Type
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

def Instructions.Operations.FRNDINT
    (src : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × FP87_Status_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut status : FP87_Status_Type := (← get).FP87_Status

  status := FP87_Status_Type.setC0 status (← UNSPECIFIED (size := 1))
  status := FP87_Status_Type.setC1 status (0 : Runtime.Bit)
  status := FP87_Status_Type.setC2 status (← UNSPECIFIED (size := 1))
  status := FP87_Status_Type.setC3 status (← UNSPECIFIED (size := 1))

  if (← FP87.Is_STi_Empty 0) then
    status := FP87_Status_Type.setIE status (1 : Runtime.Bit)
    status := FP87_Status_Type.setSF status (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  else
    let mut rounded_up : Bool := false
    let (result_1, rounded_up_1, exceptions) ← FP87.Round_To_Integer src (← FP87_Control.RC)
    result := Runtime.InitializedBits.ofValue result_1
    rounded_up := rounded_up_1
    status := FP87_Status_Type.setException_Flags status exceptions
    status := FP87_Status_Type.setC1 status (if rounded_up and not (← FP87.Is_Unmasked_Pre_Computation_Exception exceptions) then (1 : Runtime.Bit) else (0 : Runtime.Bit))
  return ((← Runtime.InitializedBits.read result), status)

-- FRNDINT: D9 FC
def Instructions.FRNDINT
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := ip })

  let (result, status) ← Instructions.Operations.FRNDINT src

  let write_result : Bool := not (← FP87.Is_Unmasked_Pre_Computation_Exception (FP87_Status_Type.Exception_Flags status))
  if write_result then
    ST_write 0 result
  FP87_Status.setSF (FP87_Status_Type.SF status)
  FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status)
  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (FP87_Status_Type.C1 status)
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
