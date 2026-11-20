-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 2f7034230d5466d1f68a5942226f8b38199b08d69ef84ff4283338c60d6ab112
-- Performs an unordered comparison of the contents of registers ST(0) and ST(i) and sets the
-- status flags ZF, PF, and CF in the EFLAGS register according to the results (see the table
-- below).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FCOMI%2FFCOMIP%2FFUCOMI%2FFUCOMIP)
import X86.Runtime
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Compare
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Is_Unmasked_Pre_Computation_Exception
import X86.Helpers.FP87.Pop
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87_Control_Type
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

def Instructions.Operations.FCOMI
    (src1 src2 : F80_Type) (src2_index : Bits 3) (is_ordered : Bool) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6
  FP87_Status.setC1 0

  if ((← FP87.Is_STi_Empty 0) or (← FP87.Is_STi_Empty (Unsigned src2_index))) then
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    FP87_Status.setSF 1

    RFLAGS.setOF 0
    RFLAGS.setSF 0
    RFLAGS.setAF 0
    if ((← FP87_Control.IM) == 1) then
      RFLAGS.setZF 1
      RFLAGS.setPF 1
      RFLAGS.setCF 1
  else
    let (zpc, exceptions_1) ← FP87.Compare src1 src2 is_ordered false
    exceptions := exceptions_1

    RFLAGS.setOF 0
    RFLAGS.setSF 0
    RFLAGS.setAF 0
    if (FP_Exception_Flags_Type.IE exceptions == 0 or (← FP87_Control.IM) == 1) then
      RFLAGS.setZF (← zpc[2 +: 1])
      RFLAGS.setPF (← zpc[1 +: 1])
      RFLAGS.setCF (← zpc[0 +: 1])

  let write_result : Bool := not (← FP87.Is_Unmasked_Pre_Computation_Exception exceptions)

  FP87.Process_Exceptions exceptions
  return write_result

-- FUCOMI_ST0_X87: DB E8+i
-- CPUID group: FCOMI
def Instructions.FUCOMI_ST0_X87
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

  let write_result : Bool ← Instructions.Operations.FCOMI src1 src2 src2_index is_ordered

  if write_result then
    pure ()
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCOMI_ST0_X87: DB F0+i
-- CPUID group: FCOMI
def Instructions.FCOMI_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src2_index : Bits 3 ← rm[2:0]
  let is_ordered : Bool := true

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← ST 0
  let src2 : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let write_result : Bool ← Instructions.Operations.FCOMI src1 src2 src2_index is_ordered

  if write_result then
    pure ()
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FUCOMIP_ST0_X87: DF E8+i
-- CPUID group: FCOMI
def Instructions.FUCOMIP_ST0_X87
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

  let write_result : Bool ← Instructions.Operations.FCOMI src1 src2 src2_index is_ordered

  if write_result then
    FP87.Pop
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCOMIP_ST0_X87: DF F0+i
-- CPUID group: FCOMI
def Instructions.FCOMIP_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src2_index : Bits 3 ← rm[2:0]
  let is_ordered : Bool := true

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← ST 0
  let src2 : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let write_result : Bool ← Instructions.Operations.FCOMI src1 src2 src2_index is_ordered

  if write_result then
    FP87.Pop
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
