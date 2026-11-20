-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 37a6359abab41c9ab553db481e37cb212caa66a66da619cac12c1daad95a6ab6
-- Compares the contents of register ST(0) and source value and sets condition code flags C0, C2,
-- and C3 in the FPU status word according to the results (see the table below).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FCOM%2FFCOMP%2FFCOMPP)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Compare
import X86.Helpers.FP87.Convert_From_Float
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Is_Unmasked_Pre_Computation_Exception
import X86.Helpers.FP87.Pop
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87_Status_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.ST
import X86.Helpers.Segment
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
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.FCOM_Convert
    (src1 src2 : F80_Type) (is_denormal : Bool) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  if (← FP87.Is_STi_Empty 0) then
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    FP87_Status.setSF 1

    FP87_Status.setC0 1
    FP87_Status.setC1 0
    FP87_Status.setC2 1
    FP87_Status.setC3 1
  else
    let (c320, exceptions_1) ← FP87.Compare src1 src2 true is_denormal
    exceptions := exceptions_1

    FP87_Status.setC0 (← c320[0 +: 1])
    FP87_Status.setC1 0
    FP87_Status.setC2 (← c320[1 +: 1])
    FP87_Status.setC3 (← c320[2 +: 1])

  let write_result : Bool := not (← FP87.Is_Unmasked_Pre_Computation_Exception exceptions)

  FP87.Process_Exceptions exceptions
  return write_result

def Instructions.Operations.FCOM
    (src1 src2 : F80_Type) (src2_index : Bits 3) (is_ordered : Bool) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  if ((← FP87.Is_STi_Empty 0) or (← FP87.Is_STi_Empty (Unsigned src2_index))) then
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    FP87_Status.setSF 1

    FP87_Status.setC0 1
    FP87_Status.setC1 0
    FP87_Status.setC2 1
    FP87_Status.setC3 1
  else
    let (c320, exceptions_1) ← FP87.Compare src1 src2 is_ordered false
    exceptions := exceptions_1

    FP87_Status.setC0 (← c320[0 +: 1])
    FP87_Status.setC1 0
    FP87_Status.setC2 (← c320[1 +: 1])
    FP87_Status.setC3 (← c320[2 +: 1])

  let write_result : Bool := not (← FP87.Is_Unmasked_Pre_Computation_Exception exceptions)

  FP87.Process_Exceptions exceptions
  return write_result

-- FCOM_ST0_MEMmem32real: D8 /2
def Instructions.FCOM_ST0_MEMmem32real
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← Runtime.liftTotal (FP87.Is_Enabled))) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions)

  let saved_status : FP87_Status_Type := (← get).FP87_Status
  try
    let src1 : F80_Type ← Runtime.liftTotal (ST 0)
    let _src2 : Bits 32 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
    let (src2, is_denormal) ← FP87.Convert_From_Float (size := 32) _src2
    modify ({ · with Next_IP := next_ip0 })

    let write_result : Bool ← Runtime.liftTotal (Instructions.Operations.FCOM_Convert src1 src2 is_denormal)

    if write_result then
      pure ()
    Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address)
  catch exception =>
    match exception with
    | .raised (.Exception_Info fault) =>
      if (← (do let subject := fault.vector; pure ((subject == GP_Exception) || (subject == SS_Exception) || (subject == PF_Exception) || (subject == AC_Exception)))) then
        modify ({ · with FP87_Status := saved_status })
      throw (.raised (↑fault : Exception))
    | _ => throw exception

-- FCOMP_ST0_MEMmem32real: D8 /3
def Instructions.FCOMP_ST0_MEMmem32real
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← Runtime.liftTotal (FP87.Is_Enabled))) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions)

  let saved_status : FP87_Status_Type := (← get).FP87_Status
  try
    let src1 : F80_Type ← Runtime.liftTotal (ST 0)
    let _src2 : Bits 32 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
    let (src2, is_denormal) ← FP87.Convert_From_Float (size := 32) _src2
    modify ({ · with Next_IP := next_ip0 })

    let write_result : Bool ← Runtime.liftTotal (Instructions.Operations.FCOM_Convert src1 src2 is_denormal)

    if write_result then
      Runtime.liftTotal (FP87.Pop)
    Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address)
  catch exception =>
    match exception with
    | .raised (.Exception_Info fault) =>
      if (← (do let subject := fault.vector; pure ((subject == GP_Exception) || (subject == SS_Exception) || (subject == PF_Exception) || (subject == AC_Exception)))) then
        modify ({ · with FP87_Status := saved_status })
      throw (.raised (↑fault : Exception))
    | _ => throw exception

-- FCOM_ST0_MEMm64real: DC /2
def Instructions.FCOM_ST0_MEMm64real
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← Runtime.liftTotal (FP87.Is_Enabled))) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions)

  let saved_status : FP87_Status_Type := (← get).FP87_Status
  try
    let src1 : F80_Type ← Runtime.liftTotal (ST 0)
    let _src2 : Bits 64 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 64 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
    let (src2, is_denormal) ← FP87.Convert_From_Float (size := 64) _src2
    modify ({ · with Next_IP := next_ip0 })

    let write_result : Bool ← Runtime.liftTotal (Instructions.Operations.FCOM_Convert src1 src2 is_denormal)

    if write_result then
      pure ()
    Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address)
  catch exception =>
    match exception with
    | .raised (.Exception_Info fault) =>
      if (← (do let subject := fault.vector; pure ((subject == GP_Exception) || (subject == SS_Exception) || (subject == PF_Exception) || (subject == AC_Exception)))) then
        modify ({ · with FP87_Status := saved_status })
      throw (.raised (↑fault : Exception))
    | _ => throw exception

-- FCOMP_ST0_MEMm64real: DC /3
def Instructions.FCOMP_ST0_MEMm64real
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← Runtime.liftTotal (FP87.Is_Enabled))) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions)

  let saved_status : FP87_Status_Type := (← get).FP87_Status
  try
    let src1 : F80_Type ← Runtime.liftTotal (ST 0)
    let _src2 : Bits 64 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 64 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
    let (src2, is_denormal) ← FP87.Convert_From_Float (size := 64) _src2
    modify ({ · with Next_IP := next_ip0 })

    let write_result : Bool ← Runtime.liftTotal (Instructions.Operations.FCOM_Convert src1 src2 is_denormal)

    if write_result then
      Runtime.liftTotal (FP87.Pop)
    Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address)
  catch exception =>
    match exception with
    | .raised (.Exception_Info fault) =>
      if (← (do let subject := fault.vector; pure ((subject == GP_Exception) || (subject == SS_Exception) || (subject == PF_Exception) || (subject == AC_Exception)))) then
        modify ({ · with FP87_Status := saved_status })
      throw (.raised (↑fault : Exception))
    | _ => throw exception

-- FCOMPP: DE D9
def Instructions.FCOMPP
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
  let src2 : F80_Type ← ST 1
  modify ({ · with Next_IP := ip })

  let write_result : Bool ← Instructions.Operations.FCOM src1 src2 src2_index is_ordered

  if write_result then
    FP87.Pop
    FP87.Pop
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCOM_ST0_X87: D8 D0+i
def Instructions.FCOM_ST0_X87
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

  let write_result : Bool ← Instructions.Operations.FCOM src1 src2 src2_index is_ordered

  if write_result then
    pure ()
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCOMP_ST0_X87: D8 D8+i
def Instructions.FCOMP_ST0_X87
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

  let write_result : Bool ← Instructions.Operations.FCOM src1 src2 src2_index is_ordered

  if write_result then
    FP87.Pop
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCOM_ST0_X87_DCD0: DC D0+i
def Instructions.FCOM_ST0_X87_DCD0
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

  let write_result : Bool ← Instructions.Operations.FCOM src1 src2 src2_index is_ordered

  if write_result then
    pure ()
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCOMP_ST0_X87_DCD1: DC D8+i
def Instructions.FCOMP_ST0_X87_DCD1
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

  let write_result : Bool ← Instructions.Operations.FCOM src1 src2 src2_index is_ordered

  if write_result then
    FP87.Pop
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FCOMP_ST0_X87_DED0: DE D0+i
def Instructions.FCOMP_ST0_X87_DED0
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

  let write_result : Bool ← Instructions.Operations.FCOM src1 src2 src2_index is_ordered

  if write_result then
    FP87.Pop
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
