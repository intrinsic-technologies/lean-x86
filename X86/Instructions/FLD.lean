-- Generated from data/instruction/FLD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: d996ad87a8a43cd7a87f0978ac2c10937b14f7e6dd5ae4a37efb30f4f15834b2
-- Description: data/sdm/FLD.docbook
-- Pushes the source operand onto the FPU register stack.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FLD)
import X86.Runtime
import X86.Helpers.Check_Logical_Address_Is_Readable
import X86.Helpers.Effective_Address
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Classify
import X86.Helpers.FP87.Convert_From_Float
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.Push
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Quietize_NaN
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87_Class_Type
import X86.Helpers.FP87_Control_Type
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
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Instructions.FILD
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

def Instructions.Operations.FLD_Convert
    (src : F80_Type) (is_denormal : Bool) :
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
      let mut result : F80_Type := src

      if ((← FP87.Classify src) == FP87_Class_Type.FP87_Class_SNaN) then
        exceptions := FP_Exception_Flags_Type.setIE exceptions (1 : Runtime.Bit)
        result := (← FP87.Quietize_NaN src)
      else
        if is_denormal then
          exceptions := FP_Exception_Flags_Type.setDE exceptions (1 : Runtime.Bit)
      pure result

  -- unmasked #IE will not write result
  let write_result : Bool := FP_Exception_Flags_Type.IE exceptions == 0 or (← FP87_Control.IM) == 1

  FP87.Process_Exceptions exceptions
  return (result, write_result)

-- FLD_ST0_MEMmem80real: DB /5
def Instructions.FLD_ST0_MEMmem80real
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let src_index : Bits 3 := 0
  let is_memory_operand : Bool := true

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  Check_Logical_Address_Is_Readable segment effective_address 80
  let mem_lo : Bits 64 ← Logical_Mem_Read segment effective_address 64 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let mem_hi : Bits 16 ← Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address 8) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let src : Bits 80 ← concatBits (leftSize := 16) (rightSize := 64) mem_hi mem_lo
  modify ({ · with Next_IP := next_ip0 })

  let (result, write_result) ← Instructions.Operations.FLD src src_index is_memory_operand

  if write_result then
    FP87.Push
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address

-- FLD_ST0_MEMmem32real: D9 /0
def Instructions.FLD_ST0_MEMmem32real
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

  let _src : Bits 32 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  let (src, is_denormal) ← FP87.Convert_From_Float (size := 32) _src
  modify ({ · with Next_IP := next_ip0 })

  let (result, write_result) ← Runtime.liftTotal (Instructions.Operations.FLD_Convert src is_denormal)

  if write_result then
    Runtime.liftTotal (FP87.Push)
    Runtime.liftTotal (ST_write 0 result)
  Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address)

-- FLD_ST0_MEMm64real: DD /0
def Instructions.FLD_ST0_MEMm64real
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

  let _src : Bits 64 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 64 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  let (src, is_denormal) ← FP87.Convert_From_Float (size := 64) _src
  modify ({ · with Next_IP := next_ip0 })

  let (result, write_result) ← Runtime.liftTotal (Instructions.Operations.FLD_Convert src is_denormal)

  if write_result then
    Runtime.liftTotal (FP87.Push)
    Runtime.liftTotal (ST_write 0 result)
  Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address)

-- FLD_ST0_X87: D9 C0+i
def Instructions.FLD_ST0_X87
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let src_index : Bits 3 ← rm[2:0]
  let is_memory_operand : Bool := false

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← FP87.Is_Enabled)) then
    liftM (Report_Not_Available_Exception)

  FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions

  let src : F80_Type ← ST (Unsigned rm)
  modify ({ · with Next_IP := ip })

  let (result, write_result) ← Instructions.Operations.FLD src src_index is_memory_operand

  if write_result then
    FP87.Push
    ST_write 0 result
  FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) false (← Null_Segment (← get).DS) (← Std.Bits.Zero 64)

end X86
