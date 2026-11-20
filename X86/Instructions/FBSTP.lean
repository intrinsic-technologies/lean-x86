-- Generated from data/instruction/FBSTP.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 17dcadaa3bf0aeedd8b18ae338ab13630f2c184d6b9d9207e714df43e2c560f5
-- Description: data/sdm/FBSTP.docbook
-- Converts the value in the ST(0) register to an 18-digit packed BCD integer, stores the result in
-- the destination operand, and pops the register stack.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=FBSTP)
import X86.Runtime
import X86.Helpers.Check_Logical_Address_Is_Writable
import X86.Helpers.Effective_Address
import X86.Helpers.F80_Type
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.FP87.Convert_F80_To_BCD
import X86.Helpers.FP87.Is_Enabled
import X86.Helpers.FP87.Is_STi_Empty
import X86.Helpers.FP87.Is_Unmasked_Pre_Computation_Exception
import X86.Helpers.FP87.Pop
import X86.Helpers.FP87.Process_Exceptions
import X86.Helpers.FP87.QNaN_Indefinite
import X86.Helpers.FP87.Read_STi
import X86.Helpers.FP87.Update_Instruction_Info
import X86.Helpers.FP87_Status_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
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

def Instructions.Operations.FBSTP
    (src : F80_Type) :
    Runtime.SpecM Exception (State σ) (Bits 80 × FP87_Status_Type) := do
  let mut result : Runtime.InitializedBits 80 := Runtime.InitializedBits.empty 80
  let mut status : FP87_Status_Type := (← get).FP87_Status
  let mut exceptions : FP_Exception_Flags_Type ← Std.Bits.Zero 6

  if (← FP87.Is_STi_Empty 0) then
    status := FP87_Status_Type.setIE status (1 : Runtime.Bit)
    status := FP87_Status_Type.setSF status (1 : Runtime.Bit)
    status := FP87_Status_Type.setC1 status (0 : Runtime.Bit)
    result := Runtime.InitializedBits.ofValue (← FP87.QNaN_Indefinite)
  else
    let mut rounded_up : Bool := false
    let (result_1, rounded_up_1, exceptions_1) ← FP87.Convert_F80_To_BCD src
    result := Runtime.InitializedBits.ofValue result_1
    rounded_up := rounded_up_1
    exceptions := exceptions_1
    status := FP87_Status_Type.setC1 status (← Bit rounded_up)
    status := FP87_Status_Type.setException_Flags status ((BitVec.cast (by omega) (FP87_Status_Type.Exception_Flags status) : Bits 6) or exceptions)
  return ((← Runtime.InitializedBits.read result), status)

-- FBSTP_MEMmem80dec_ST0: DF /6
def Instructions.FBSTP_MEMmem80dec_ST0
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

  let (result, status) ← Instructions.Operations.FBSTP src

  let write_result : Bool := not (← FP87.Is_Unmasked_Pre_Computation_Exception (FP87_Status_Type.Exception_Flags status))
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

end X86
