-- Generated from data/instruction/FCMOVcc.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: b355c28e9d7b80594631a0cb012f38eabc5c63c04768ece300252cd59cb7bbe5
-- Description: data/sdm/FCMOVcc.docbook
-- Tests the status flags in the EFLAGS register and moves the source operand (second operand) to
-- the destination operand (first operand) if the given test condition is true.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FCMOVcc)
import X86.Runtime
import X86.Helpers.Condition_Holds
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP87_Status_Type
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

def Instructions.Operations.FCMOV
    (cond : Bits 4) (src : F80_Type) (src_index : Bits 3) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool) := do
  let mut result : F80_Type := src
  let mut write_result : Bool ← Condition_Holds cond

  if ((← FP87.Is_STi_Empty 0) or (← FP87.Is_STi_Empty (Unsigned src_index))) then
    FP87_Status.setIE 1
    FP87_Status.setSF 1
    FP87_Status.setC1 0

    if ((← FP87_Control.IM) == 1) then
      result := (← FP87.QNaN_Indefinite)
      write_result := true
    else
      write_result := false

  FP87.Process_Exceptions (← FP87_Status.Exception_Flags)

  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  return (result, write_result)

-- FCMOVB_ST0_X87: DA C0+i
-- CPUID group: FCMOV
def Instructions.FCMOVB_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let cond : Bits 4 := 2
  let src_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FCMOV cond src src_index

  if write_result then
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCMOVE_ST0_X87: DA C8+i
-- CPUID group: FCMOV
def Instructions.FCMOVE_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let cond : Bits 4 := 4
  let src_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FCMOV cond src src_index

  if write_result then
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCMOVBE_ST0_X87: DA D0+i
-- CPUID group: FCMOV
def Instructions.FCMOVBE_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let cond : Bits 4 := 6
  let src_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FCMOV cond src src_index

  if write_result then
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCMOVU_ST0_X87: DA D8+i
-- CPUID group: FCMOV
def Instructions.FCMOVU_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let cond : Bits 4 := 10
  let src_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FCMOV cond src src_index

  if write_result then
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCMOVNB_ST0_X87: DB C0+i
-- CPUID group: FCMOV
def Instructions.FCMOVNB_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let cond : Bits 4 := 3
  let src_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FCMOV cond src src_index

  if write_result then
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCMOVNE_ST0_X87: DB C8+i
-- CPUID group: FCMOV
def Instructions.FCMOVNE_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let cond : Bits 4 := 5
  let src_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FCMOV cond src src_index

  if write_result then
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCMOVNBE_ST0_X87: DB D0+i
-- CPUID group: FCMOV
def Instructions.FCMOVNBE_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let cond : Bits 4 := 7
  let src_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FCMOV cond src src_index

  if write_result then
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCMOVNU_ST0_X87: DB D8+i
-- CPUID group: FCMOV
def Instructions.FCMOVNU_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let cond : Bits 4 := 11
  let src_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FCMOV cond src src_index

  if write_result then
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
