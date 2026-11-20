-- Generated from data/instruction/FXCH.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 56318c924df85a9e1bda4ce7eb5d4aca8b07ad93500bc87c16f7b212c1502779
-- Description: data/sdm/FXCH.docbook
-- Exchanges the contents of registers ST(0) and ST(i).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FXCH)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Is_Unmasked_Pre_Computation_Exception
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.QNaN_Indefinite
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
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]

def Instructions.Operations.FXCH
    (src1 src2 : F80_Type) (src2_index : Bits 3) :
    Runtime.SpecM Exception (State σ) (F80_Type × F80_Type × Bool) := do
  let mut result1 : F80_Type := src2
  let mut result2 : F80_Type := src1
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 0
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))

  if ((← FP87.Is_STi_Empty 0) or (← FP87.Is_STi_Empty (Unsigned src2_index))) then
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    FP87_Status.setSF 1

    if (← FP87.Is_STi_Empty 0) then
      result2 := (← FP87.QNaN_Indefinite)
    if (← FP87.Is_STi_Empty (Unsigned src2_index)) then
      result1 := (← FP87.QNaN_Indefinite)

  let write_result : Bool := not (← FP87.Is_Unmasked_Pre_Computation_Exception exceptions)

  FP87.Process_Exceptions exceptions
  return (result1, result2, write_result)

-- FXCH_ST0_X87: D9 C8+i
def Instructions.FXCH_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src2_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← ST 0
  let src2 : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result1, result2, write_result) ← Instructions.Operations.FXCH src1 src2 src2_index

  if write_result then
    ST_write (Unsigned rm) result2
    ST_write 0 result1
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FXCH_ST0_X87_DDC1: DD C8+i
def Instructions.FXCH_ST0_X87_DDC1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src2_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← ST 0
  let src2 : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result1, result2, write_result) ← Instructions.Operations.FXCH src1 src2 src2_index

  if write_result then
    ST_write (Unsigned rm) result2
    ST_write 0 result1
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FXCH_ST0_X87_DFC1: DF C8+i
def Instructions.FXCH_ST0_X87_DFC1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src2_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← ST 0
  let src2 : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result1, result2, write_result) ← Instructions.Operations.FXCH src1 src2 src2_index

  if write_result then
    ST_write (Unsigned rm) result2
    ST_write 0 result1
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
