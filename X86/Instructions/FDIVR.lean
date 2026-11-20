-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: afc995d39b03764ff4e79fd310d05e0f4490d2dd15a97a9e6abaa5a5157d4bb9
-- Divides the source operand by the destination operand and stores the result in the destination
-- location.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FDIVR%2FFDIVRP%2FFIDIVR)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Convert_From_Float
import X86.Helpers.FP87.Convert_From_Integer
import X86.Helpers.FP87.Divide
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Is_Unmasked_Pre_Computation_Exception
import X86.Helpers.FP87.Pop
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Read_STi
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87_Status_Type
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
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.FDIVR
    (src1 src2 : F80_Type) (src1_index src2_index : Bits 3) (mod : Bits 2) :
    Runtime.SpecM Exception (State σ) (F80_Type × FP87_Status_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut status : FP87_Status_Type := (← get).FP87_Status

  status := FP87_Status_Type.setC0 status (← UNSPECIFIED (size := 1))
  status := FP87_Status_Type.setC1 status (0 : Runtime.Bit)
  status := FP87_Status_Type.setC2 status (← UNSPECIFIED (size := 1))
  status := FP87_Status_Type.setC3 status (← UNSPECIFIED (size := 1))

  if ((← FP87.Is_STi_Empty (Unsigned src1_index)) or mod == 3 and (← FP87.Is_STi_Empty (Unsigned src2_index))) then
    status := FP87_Status_Type.setIE status (1 : Runtime.Bit)
    status := FP87_Status_Type.setSF status (1 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  else
    let mut rounded_up : Bool := false
    let (result_1, rounded_up_1, status_part) ← FP87.Divide src2 src1 false false
    result := Runtime.InitializedBits.ofValue result_1
    rounded_up := rounded_up_1
    status := FP87_Status_Type.setException_Flags status status_part
    status := FP87_Status_Type.setC1 status (← Bit rounded_up)
  return ((← Runtime.InitializedBits.read result), status)

def Instructions.Operations.FDIVR_Convert
    (src1 src2 : F80_Type) (is_denormal : Bool) :
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
    let (result_1, rounded_up_1, status_part) ← FP87.Divide src2 src1 is_denormal false
    result := Runtime.InitializedBits.ofValue result_1
    rounded_up := rounded_up_1
    status := FP87_Status_Type.setException_Flags status status_part
    status := FP87_Status_Type.setC1 status (← Bit rounded_up)
  return ((← Runtime.InitializedBits.read result), status)

-- FIDIVR_ST0_MEMmem16int: DE /7
def Instructions.FIDIVR_ST0_MEMmem16int
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let src1_index : Bits 3 := 0
  let src2_index : Bits 3 := 0

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
    let src1 : F80_Type ← Runtime.liftTotal (FP87.Read_STi 0)
    let _src2 : Bits 16 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
    let src2 : F80_Type ← FP87.Convert_From_Integer (size := 16) _src2
    modify ({ · with Next_IP := next_ip0 })

    let (result, status) ← Runtime.liftTotal (Instructions.Operations.FDIVR src1 src2 src1_index src2_index mod)

    let write_result : Bool := not (← Runtime.liftTotal (FP87.Is_Unmasked_Pre_Computation_Exception (FP87_Status_Type.Exception_Flags status)))
    if write_result then
      Runtime.liftTotal (ST_write 0 result)
    Runtime.liftTotal (FP87_Status.setSF (FP87_Status_Type.SF status))
    Runtime.liftTotal (FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status))
    Runtime.liftTotal (FP87_Status.setC0 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87_Status.setC1 (FP87_Status_Type.C1 status))
    Runtime.liftTotal (FP87_Status.setC2 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87_Status.setC3 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address)
  catch exception =>
    match exception with
    | .raised (.Exception_Info fault) =>
      if (← (do let subject := fault.vector; pure ((subject == GP_Exception) || (subject == SS_Exception) || (subject == PF_Exception) || (subject == AC_Exception)))) then
        modify ({ · with FP87_Status := saved_status })
      throw (.raised (↑fault : Exception))
    | _ => throw exception

-- FDIVR_ST0_MEMmem32real: D8 /7
def Instructions.FDIVR_ST0_MEMmem32real
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
    let src1 : F80_Type ← Runtime.liftTotal (FP87.Read_STi 0)
    let _src2 : Bits 32 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
    let (src2, is_denormal) ← FP87.Convert_From_Float (size := 32) _src2
    modify ({ · with Next_IP := next_ip0 })

    let (result, status) ← Runtime.liftTotal (Instructions.Operations.FDIVR_Convert src1 src2 is_denormal)

    let write_result : Bool := not (← Runtime.liftTotal (FP87.Is_Unmasked_Pre_Computation_Exception (FP87_Status_Type.Exception_Flags status)))
    if write_result then
      Runtime.liftTotal (ST_write 0 result)
    Runtime.liftTotal (FP87_Status.setSF (FP87_Status_Type.SF status))
    Runtime.liftTotal (FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status))
    Runtime.liftTotal (FP87_Status.setC0 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87_Status.setC1 (FP87_Status_Type.C1 status))
    Runtime.liftTotal (FP87_Status.setC2 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87_Status.setC3 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address)
  catch exception =>
    match exception with
    | .raised (.Exception_Info fault) =>
      if (← (do let subject := fault.vector; pure ((subject == GP_Exception) || (subject == SS_Exception) || (subject == PF_Exception) || (subject == AC_Exception)))) then
        modify ({ · with FP87_Status := saved_status })
      throw (.raised (↑fault : Exception))
    | _ => throw exception

-- FIDIVR_ST0_MEMmem32int: DA /7
def Instructions.FIDIVR_ST0_MEMmem32int
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let src1_index : Bits 3 := 0
  let src2_index : Bits 3 := 0

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
    let src1 : F80_Type ← Runtime.liftTotal (FP87.Read_STi 0)
    let _src2 : Bits 32 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
    let src2 : F80_Type ← FP87.Convert_From_Integer (size := 32) _src2
    modify ({ · with Next_IP := next_ip0 })

    let (result, status) ← Runtime.liftTotal (Instructions.Operations.FDIVR src1 src2 src1_index src2_index mod)

    let write_result : Bool := not (← Runtime.liftTotal (FP87.Is_Unmasked_Pre_Computation_Exception (FP87_Status_Type.Exception_Flags status)))
    if write_result then
      Runtime.liftTotal (ST_write 0 result)
    Runtime.liftTotal (FP87_Status.setSF (FP87_Status_Type.SF status))
    Runtime.liftTotal (FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status))
    Runtime.liftTotal (FP87_Status.setC0 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87_Status.setC1 (FP87_Status_Type.C1 status))
    Runtime.liftTotal (FP87_Status.setC2 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87_Status.setC3 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address)
  catch exception =>
    match exception with
    | .raised (.Exception_Info fault) =>
      if (← (do let subject := fault.vector; pure ((subject == GP_Exception) || (subject == SS_Exception) || (subject == PF_Exception) || (subject == AC_Exception)))) then
        modify ({ · with FP87_Status := saved_status })
      throw (.raised (↑fault : Exception))
    | _ => throw exception

-- FDIVR_ST0_MEMm64real: DC /7
def Instructions.FDIVR_ST0_MEMm64real
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
    let src1 : F80_Type ← Runtime.liftTotal (FP87.Read_STi 0)
    let _src2 : Bits 64 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 64 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
    let (src2, is_denormal) ← FP87.Convert_From_Float (size := 64) _src2
    modify ({ · with Next_IP := next_ip0 })

    let (result, status) ← Runtime.liftTotal (Instructions.Operations.FDIVR_Convert src1 src2 is_denormal)

    let write_result : Bool := not (← Runtime.liftTotal (FP87.Is_Unmasked_Pre_Computation_Exception (FP87_Status_Type.Exception_Flags status)))
    if write_result then
      Runtime.liftTotal (ST_write 0 result)
    Runtime.liftTotal (FP87_Status.setSF (FP87_Status_Type.SF status))
    Runtime.liftTotal (FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status))
    Runtime.liftTotal (FP87_Status.setC0 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87_Status.setC1 (FP87_Status_Type.C1 status))
    Runtime.liftTotal (FP87_Status.setC2 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87_Status.setC3 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
    Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address)
  catch exception =>
    match exception with
    | .raised (.Exception_Info fault) =>
      if (← (do let subject := fault.vector; pure ((subject == GP_Exception) || (subject == SS_Exception) || (subject == PF_Exception) || (subject == AC_Exception)))) then
        modify ({ · with FP87_Status := saved_status })
      throw (.raised (↑fault : Exception))
    | _ => throw exception

-- FDIVR_ST0_X87: D8 F8+i
def Instructions.FDIVR_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src1_index : Bits 3 := 0
  let src2_index : Bits 3 ← rm[2:0]

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← FP87.Read_STi 0
  let src2 : F80_Type ← FP87.Read_STi (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result, status) ← Instructions.Operations.FDIVR src1 src2 src1_index src2_index mod

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

-- FDIVR_X87_ST0: DC F0+i
def Instructions.FDIVR_X87_ST0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src1_index : Bits 3 ← rm[2:0]
  let src2_index : Bits 3 := 0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← FP87.Read_STi (Unsigned rm)
  let src2 : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := ip })

  let (result, status) ← Instructions.Operations.FDIVR src1 src2 src1_index src2_index mod

  let write_result : Bool := not (← FP87.Is_Unmasked_Pre_Computation_Exception (FP87_Status_Type.Exception_Flags status))
  if write_result then
    ST_write (Unsigned rm) result
  FP87_Status.setSF (FP87_Status_Type.SF status)
  FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status)
  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (FP87_Status_Type.C1 status)
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FDIVRP_X87_ST0: DE F0+i
def Instructions.FDIVRP_X87_ST0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src1_index : Bits 3 ← rm[2:0]
  let src2_index : Bits 3 := 0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src1 : F80_Type ← FP87.Read_STi (Unsigned rm)
  let src2 : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := ip })

  let (result, status) ← Instructions.Operations.FDIVR src1 src2 src1_index src2_index mod

  let write_result : Bool := not (← FP87.Is_Unmasked_Pre_Computation_Exception (FP87_Status_Type.Exception_Flags status))
  if write_result then
    ST_write (Unsigned rm) result
    FP87.Pop
  FP87_Status.setSF (FP87_Status_Type.SF status)
  FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status)
  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (FP87_Status_Type.C1 status)
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
