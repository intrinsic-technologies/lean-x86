-- Generated from data/instruction/FBLD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: e7ee8efa3c4686e54c5ce6273d708fb36d449b5e1b8eac9002749ca6fa0ecc0b
-- Description: data/sdm/FBLD.docbook
-- Converts the BCD source operand into double extended-precision floating-point format and pushes
-- the value onto the FPU stack.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FBLD)
import X86.Runtime
import X86.Helpers.Check_Logical_Address_Is_Readable
import X86.Helpers.Effective_Address
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Convert_From_BCD
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Is_Unmasked_Pre_Computation_Exception
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.Push
import X86.Helpers.FP87.QNaN_Indefinite
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
import X86.Helpers.Std.Bits.Add_int
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

def Instructions.Operations.FBLD
    (src : Bits 80) :
    Runtime.PartialSpecM Exception (State σ) (Bits 80 × FP87_Status_Type) := do
  let mut status : FP87_Status_Type := (← get).FP87_Status

  status := FP87_Status_Type.setC0 status (← Runtime.liftTotal (UNSPECIFIED (size := 1)))
  status := FP87_Status_Type.setC1 status (0 : Runtime.Bit)
  status := FP87_Status_Type.setC2 status (← Runtime.liftTotal (UNSPECIFIED (size := 1)))
  status := FP87_Status_Type.setC3 status (← Runtime.liftTotal (UNSPECIFIED (size := 1)))

  let result : Bits 80 ← do
    if not (← Runtime.liftTotal (FP87.Is_STi_Empty 7)) then
      status := FP87_Status_Type.setIE status (1 : Runtime.Bit)
      status := FP87_Status_Type.setSF status (1 : Runtime.Bit)
      status := FP87_Status_Type.setC1 status (1 : Runtime.Bit)
      let result : Bits 80 ← FP87.QNaN_Indefinite
      pure result
    else
      let result : Bits 80 ← FP87.Convert_From_BCD src
      pure result
  return (result, status)

-- FBLD_ST0_MEMmem80dec: DF /4
def Instructions.FBLD_ST0_MEMmem80dec
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

  Runtime.liftTotal (Check_Logical_Address_Is_Readable segment effective_address 80)
  let mem_lo : Bits 64 ← Runtime.liftTotal (Logical_Mem_Read segment effective_address 64 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  let mem_hi : Bits 16 ← Runtime.liftTotal (Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address 8) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  let src : Bits 80 ← concatBits (leftSize := 16) (rightSize := 64) mem_hi mem_lo
  modify ({ · with Next_IP := next_ip0 })

  let (result, status) ← Instructions.Operations.FBLD src

  let write_result : Bool := not (← Runtime.liftTotal (FP87.Is_Unmasked_Pre_Computation_Exception (FP87_Status_Type.Exception_Flags status)))
  if write_result then
    Runtime.liftTotal (FP87.Push)
    Runtime.liftTotal (ST_write 0 result)
  Runtime.liftTotal (FP87_Status.setSF (FP87_Status_Type.SF status))
  Runtime.liftTotal (FP87.Process_Exceptions (FP87_Status_Type.Exception_Flags status))
  Runtime.liftTotal (FP87_Status.setC0 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
  Runtime.liftTotal (FP87_Status.setC1 (FP87_Status_Type.C1 status))
  Runtime.liftTotal (FP87_Status.setC2 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
  Runtime.liftTotal (FP87_Status.setC3 (← Runtime.liftTotal (UNSPECIFIED (size := 1))))
  Runtime.liftTotal (FP87.Update_Instruction_Info opcode (← concatBits (leftSize := 5) (rightSize := 3) (← concatBits (leftSize := 2) (rightSize := 3) mod reg) rm) true segment effective_address)

end X86
