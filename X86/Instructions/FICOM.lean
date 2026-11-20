-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: f2a222a1a068875277727edadc1efba233a143a03b57940b72eebafbcad28850
-- Compares the value in ST(0) with an integer source operand and sets the condition code flags C0,
-- C2, and C3 in the FPU status word according to the results (see table below).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FICOM%2FFICOMP)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Convert_From_Integer
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Pop
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87_Status_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.ST
import X86.Helpers.Segment
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
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Config.Value.Feature_FIP_Use_Linear_Address]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

-- FICOM_ST0_MEMmem16int: DE /2
def Instructions.FICOM_ST0_MEMmem16int
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let src2_index : Bits 3 := 0
  let is_ordered : Bool := true

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
    let _src2 : Bits 16 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
    let src2 : F80_Type ← FP87.Convert_From_Integer (size := 16) _src2
    modify ({ · with Next_IP := next_ip0 })

    let write_result : Bool ← Runtime.liftTotal (Instructions.Operations.FCOM src1 src2 src2_index is_ordered)

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

-- FICOMP_ST0_MEMmem16int: DE /3
def Instructions.FICOMP_ST0_MEMmem16int
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let src2_index : Bits 3 := 0
  let is_ordered : Bool := true

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
    let _src2 : Bits 16 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
    let src2 : F80_Type ← FP87.Convert_From_Integer (size := 16) _src2
    modify ({ · with Next_IP := next_ip0 })

    let write_result : Bool ← Runtime.liftTotal (Instructions.Operations.FCOM src1 src2 src2_index is_ordered)

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

-- FICOM_ST0_MEMmem32int: DA /2
def Instructions.FICOM_ST0_MEMmem32int
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let src2_index : Bits 3 := 0
  let is_ordered : Bool := true

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
    let src2 : F80_Type ← FP87.Convert_From_Integer (size := 32) _src2
    modify ({ · with Next_IP := next_ip0 })

    let write_result : Bool ← Runtime.liftTotal (Instructions.Operations.FCOM src1 src2 src2_index is_ordered)

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

-- FICOMP_ST0_MEMmem32int: DA /3
def Instructions.FICOMP_ST0_MEMmem32int
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let src2_index : Bits 3 := 0
  let is_ordered : Bool := true

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
    let src2 : F80_Type ← FP87.Convert_From_Integer (size := 32) _src2
    modify ({ · with Next_IP := next_ip0 })

    let write_result : Bool ← Runtime.liftTotal (Instructions.Operations.FCOM src1 src2 src2_index is_ordered)

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

end X86
