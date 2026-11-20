-- Generated from data/instruction/FUCOM-FUCOMP-FUCOMPP.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 6a97b810925b2bac749944590a56203c1ace0e05ee03cfb4a5b1d972aded7766
-- Description: data/sdm/FUCOM-FUCOMP-FUCOMPP.docbook
-- Performs an unordered comparison of the contents of register ST(0) and ST(i) and sets condition
-- code flags C0, C2, and C3 in the FPU status word according to the results (see the table below).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FUCOM%2FFUCOMP%2FFUCOMPP)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Pop
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.Instruction_Context
import X86.Helpers.Null_Segment
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.ST
import X86.Helpers.Std.Bits.Zero
import X86.Instructions.FCOM
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

-- FUCOMPP: DA E9
def Instructions.FUCOMPP
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src2_index : Bits 3 ← rm[2:0]
  let is_ordered : Bool := false

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← ST 0
  let src2 : F80_Type ← ST 1
  modify ({ · with Next_IP := ip })

  let write_result : Bool ← Instructions.Operations.FCOM src1 src2 src2_index is_ordered

  if write_result then
    FP87.Pop
    FP87.Pop
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FUCOM_ST0_X87: DD E0+i
def Instructions.FUCOM_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src2_index : Bits 3 ← rm[2:0]
  let is_ordered : Bool := false

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← ST 0
  let src2 : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let write_result : Bool ← Instructions.Operations.FCOM src1 src2 src2_index is_ordered

  if write_result then
    pure ()
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FUCOMP_ST0_X87: DD E8+i
def Instructions.FUCOMP_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src2_index : Bits 3 ← rm[2:0]
  let is_ordered : Bool := false

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← ST 0
  let src2 : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let write_result : Bool ← Instructions.Operations.FCOM src1 src2 src2_index is_ordered

  if write_result then
    FP87.Pop
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
