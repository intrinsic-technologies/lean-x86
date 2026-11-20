-- Generated from data/instruction/FLD1-FLDL2T-FLDL2E-FLDPI-FLDLG2-FLDLN2-FLDZ.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: a365aac8a509bd20ab566a2d0ffe524f100240685d93fdbe786940d3f7e86c5c
-- Description: data/sdm/FLD1-FLDL2T-FLDL2E-FLDPI-FLDLG2-FLDLN2-FLDZ.docbook
-- Push one of seven commonly used constants (in double extended-precision floating-point format)
-- onto the FPU register stack.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FLD1%2FFLDL2T%2FFLDL2E%2FFLDPI%2FFLDLG2%2FFLDLN2%2FFLDZ)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Is_Unmasked_Pre_Computation_Exception
import X86.Helpers.FP87.Log10_Two
import X86.Helpers.FP87.Log2_Ten
import X86.Helpers.FP87.Log2_e
import X86.Helpers.FP87.Natural_Log_Two
import X86.Helpers.FP87.One
import X86.Helpers.FP87.Pi
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.Push
import X86.Helpers.FP87.QNaN_Indefinite
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

def Instructions.Operations.FLD_Constant
    (constant_value : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool) := do
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 0
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))

  let result : F80_Type ← do
    if not (← FP87.Is_STi_Empty 7) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      FP87_Status.setSF 1
      FP87_Status.setC1 1
      let result : F80_Type ← FP87.QNaN_Indefinite
      pure result
    else
      let result : F80_Type := constant_value
      pure result

  let write_result : Bool := not (← FP87.Is_Unmasked_Pre_Computation_Exception exceptions)

  FP87.Process_Exceptions exceptions
  return (result, write_result)

-- FLD1: D9 E8
def Instructions.FLD1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let constant_value : F80_Type ← FP87.One 0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FLD_Constant constant_value

  if write_result then
    FP87.Push
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FLDL2T: D9 E9
def Instructions.FLDL2T
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let constant_value : F80_Type ← FP87.Log2_Ten

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FLD_Constant constant_value

  if write_result then
    FP87.Push
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FLDL2E: D9 EA
def Instructions.FLDL2E
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let constant_value : F80_Type ← FP87.Log2_e

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FLD_Constant constant_value

  if write_result then
    FP87.Push
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FLDPI: D9 EB
def Instructions.FLDPI
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let constant_value : F80_Type ← FP87.Pi

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FLD_Constant constant_value

  if write_result then
    FP87.Push
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FLDLG2: D9 EC
def Instructions.FLDLG2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let constant_value : F80_Type ← FP87.Log10_Two

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FLD_Constant constant_value

  if write_result then
    FP87.Push
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FLDLN2: D9 ED
def Instructions.FLDLN2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let constant_value : F80_Type ← FP87.Natural_Log_Two

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FLD_Constant constant_value

  if write_result then
    FP87.Push
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FLDZ: D9 EE
def Instructions.FLDZ
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let constant_value : F80_Type ← FP87.Zero 0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FLD_Constant constant_value

  if write_result then
    FP87.Push
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
