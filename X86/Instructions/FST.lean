-- Generated from data/instruction/FST-FSTP.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: d3ade758ec195dd87726765238225127f14093b72a03a49cd225392f46cc5d5a
-- Description: data/sdm/FST-FSTP.docbook
-- The FST instruction copies the value in the ST(0) register to the destination operand, which can
-- be a memory location or another register in the FPU register stack.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FST%2FFSTP)
import X86.Runtime
import X86.Helpers.Check_Logical_Address_Is_Writable
import X86.Helpers.Effective_Address
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Convert_To_Float
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Is_Unmasked_Exception
import X86.Helpers.FP87.Is_Unmasked_Pre_Computation_Exception
import X86.Helpers.FP87.Pop
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Read_STi
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87_Control_Type
import X86.Helpers.FP87_Status_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.ST
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
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
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.FST
    (src : F80_Type) :
    Runtime.SpecM Exception (State σ) (F80_Type × Bool × FP87_Status_Type) := do
  let mut status : FP87_Status_Type := (← get).FP87_Status
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6
  status := FP87_Status_Type.setC1 status (0 : Runtime.Bit)

  let result : F80_Type ← do
    if (← FP87.Is_STi_Empty 0) then
      exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
      status := FP87_Status_Type.setSF status (1 : Runtime.Bit)
      let result : F80_Type ← FP87.QNaN_Indefinite
      pure result
    else
      let result : F80_Type := src
      pure result

  status := FP87_Status_Type.setException_Flags status ((BitVec.cast (by omega) (FP87_Status_Type.Exception_Flags status) : Bits 6) or exceptions)

  let write_result : Bool := not (← FP87.Is_Unmasked_Pre_Computation_Exception exceptions)

  -- NOTE: FP87::Process_Exceptions is NOT called here. The wrapper code must call it
  -- after successfully writing the result to memory, to preserve status on faults.
  return (result, write_result, status)

def Instructions.Operations.FST_Convert
    (src : F80_Type) (result_size : Int) :
    Runtime.SpecM Exception (State σ) (Bits result_size × Bool × FP87_Status_Type) := do
  Runtime.assert (result_size == 32 || result_size == 64)

  let mut result : Runtime.InitializedBits result_size := Runtime.InitializedBits.empty result_size
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6
  let mut status : FP87_Status_Type := (← get).FP87_Status

  if (← FP87.Is_STi_Empty 0) then
    exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
    status := FP87_Status_Type.setSF status (1 : Runtime.Bit)
    status := FP87_Status_Type.setC1 status (0 : Runtime.Bit)
    let (result_2, _, _) ← FP87.Convert_To_Float (← FP87.QNaN_Indefinite) result_size
    result := Runtime.InitializedBits.ofValue result_2
  else
    let (result_1, rounded_up, exceptions_1) ← FP87.Convert_To_Float src result_size
    result := Runtime.InitializedBits.ofValue result_1
    exceptions := exceptions_1

    if (FP_Exception_Flags_Type.UE exceptions == 1 and (← FP87_Control.UM) == 0 or FP_Exception_Flags_Type.OE exceptions == 1 and (← FP87_Control.OM) == 0) then
      status := FP87_Status_Type.setC1 status (0 : Runtime.Bit)
    else
      status := FP87_Status_Type.setC1 status (← Bit rounded_up)

  -- write_result is not affected by #P precision exception
  let write_result : Bool := not (← FP87.Is_Unmasked_Exception (← concatBits (leftSize := 1) (rightSize := 5) (0 : Runtime.Bit) (← exceptions[0 +: 5])) (← FP87_Control.Exception_Masks))

  status := FP87_Status_Type.setException_Flags status ((BitVec.cast (by omega) (FP87_Status_Type.Exception_Flags status) : Bits 6) or exceptions)
  return ((← Runtime.InitializedBits.read result), write_result, status)

def Instructions.Operations.FSTPNCE
     :
    Runtime.SpecM Exception (State σ) (FP87_Status_Type × F80_Type × Bool) := do
  let mut status : FP87_Status_Type := (← get).FP87_Status

  status := FP87_Status_Type.setC1 status (0 : Runtime.Bit)
  let write_result : Bool := not (← FP87.Is_STi_Empty 0)
  let result : Bits 80 ← do
    if write_result then
      ST 0
    else
      Std.Bits.Zero 80
  -- pop the stack even if not writing the result (special undocumented behavior)
  if (not write_result) then
    FP87.Pop
  return (status, result, write_result)

-- FSTP_MEMmem80real_ST0: DB /7
def Instructions.FSTP_MEMmem80real_ST0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := next_ip0 })

  let (result, write_result, status) ← Instructions.Operations.FST src

  if write_result then
    Check_Logical_Address_Is_Writable segment (← Std.Bits.Add_int (n := 64) effective_address 8) 16 Memory_Alignment_Type.Normal_Alignment
    Logical_Mem_Write (size := 64) segment effective_address (← result[0 +: 64]) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    Logical_Mem_Write (size := 16) segment (← Std.Bits.Add_int (n := 64) effective_address 8) (← result[64 +: 16]) Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    FP87.Pop
  FP87_Status.setSF (FP87_Status_Type.SF status)
  FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status)
  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (FP87_Status_Type.C1 status)
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address

-- FST_MEMmem32real_ST0: D9 /2
def Instructions.FST_MEMmem32real_ST0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let result_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := next_ip0 })
  Check_Logical_Address_Is_Writable segment effective_address result_size Memory_Alignment_Type.Normal_Alignment

  let (result, write_result, status) ← Instructions.Operations.FST_Convert src result_size

  if write_result then
    Logical_Mem_Write (size := result_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
  FP87_Status.setSF (FP87_Status_Type.SF status)
  FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status)
  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (FP87_Status_Type.C1 status)
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address

-- FSTP_MEMmem32real_ST0: D9 /3
def Instructions.FSTP_MEMmem32real_ST0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let result_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := next_ip0 })
  Check_Logical_Address_Is_Writable segment effective_address result_size Memory_Alignment_Type.Normal_Alignment

  let (result, write_result, status) ← Instructions.Operations.FST_Convert src result_size

  if write_result then
    Logical_Mem_Write (size := result_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    FP87.Pop
  FP87_Status.setSF (FP87_Status_Type.SF status)
  FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status)
  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (FP87_Status_Type.C1 status)
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address

-- FST_MEMm64real_ST0: DD /2
def Instructions.FST_MEMm64real_ST0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let result_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := next_ip0 })
  Check_Logical_Address_Is_Writable segment effective_address result_size Memory_Alignment_Type.Normal_Alignment

  let (result, write_result, status) ← Instructions.Operations.FST_Convert src result_size

  if write_result then
    Logical_Mem_Write (size := result_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
  FP87_Status.setSF (FP87_Status_Type.SF status)
  FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status)
  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (FP87_Status_Type.C1 status)
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address

-- FSTP_MEMm64real_ST0: DD /3
def Instructions.FSTP_MEMm64real_ST0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let result_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := next_ip0 })
  Check_Logical_Address_Is_Writable segment effective_address result_size Memory_Alignment_Type.Normal_Alignment

  let (result, write_result, status) ← Instructions.Operations.FST_Convert src result_size

  if write_result then
    Logical_Mem_Write (size := result_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false
    FP87.Pop
  FP87_Status.setSF (FP87_Status_Type.SF status)
  FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status)
  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (FP87_Status_Type.C1 status)
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address

-- FSTPNCE_X87_ST0: D9 D8+i
def Instructions.FSTPNCE_X87_ST0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  modify ({ · with Next_IP := ip })

  let (status, result, write_result) ← Instructions.Operations.FSTPNCE

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

-- FST_X87_ST0: DD D0+i
def Instructions.FST_X87_ST0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := ip })

  let (result, write_result, status) ← Instructions.Operations.FST src

  if write_result then
    ST_write (Unsigned rm) result
  FP87_Status.setSF (FP87_Status_Type.SF status)
  FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status)
  FP87_Status.setC0 (← UNSPECIFIED (size := 1))
  FP87_Status.setC1 (FP87_Status_Type.C1 status)
  FP87_Status.setC2 (← UNSPECIFIED (size := 1))
  FP87_Status.setC3 (← UNSPECIFIED (size := 1))
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

-- FSTP_X87_ST0: DD D8+i
def Instructions.FSTP_X87_ST0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := ip })

  let (result, write_result, status) ← Instructions.Operations.FST src

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

-- FSTP_X87_ST0_DFD0: DF D0+i
def Instructions.FSTP_X87_ST0_DFD0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := ip })

  let (result, write_result, status) ← Instructions.Operations.FST src

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

-- FSTP_X87_ST0_DFD1: DF D8+i
def Instructions.FSTP_X87_ST0_DFD1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← FP87.Read_STi 0
  modify ({ · with Next_IP := ip })

  let (result, write_result, status) ← Instructions.Operations.FST src

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
