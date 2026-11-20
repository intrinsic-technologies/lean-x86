-- Generated from data/instruction/RCL-RCR-ROL-ROR.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 756ae2858c16640285dcc54f3b6ec5504fe6beeca418cf7b7ec5826cf6309c0b
-- Description: data/sdm/RCL-RCR-ROL-ROR.docbook
-- Shifts (rotates) the bits of the first operand (destination operand) the number of bit positions
-- specified in the second operand (count operand) and stores the result in the destination
-- operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=RCL%2FRCR%2FROL%2FROR)
import X86.Runtime
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Read_GPR
import X86.Helpers.Read_GPR8
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Rotate_Left
import X86.Helpers.Std.Bits.Rotate_Right
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.Helpers.Write_GPR
import X86.Helpers.Write_GPR8
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
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.ROL
    (operand_size : Int) (src1 : Bits operand_size) (src2 : Bits 8) :
    Runtime.SpecM Exception (State σ) (Bits operand_size) := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let count : Int ← do
    if operand_size == 64 then
      pure (Unsigned (← src2[5:0]))
    else
      pure (Unsigned (← src2[4:0]))
  let temp_count : Int ← Std.Integer.Positive_Remainder count operand_size
  let result : Bits operand_size ← Std.Bits.Rotate_Left (size := operand_size) src1 temp_count

  -- count == 0 leaves flags unmodified
  if (count == 1) then
    RFLAGS.setOF ((← result[operand_size - 1 +: 1]) xor (← result[0 +: 1]))
    RFLAGS.setCF (← result[0 +: 1])
  else
    if (count != 0) then
      RFLAGS.setOF (← UNSPECIFIED (size := 1))
      RFLAGS.setCF (← result[0 +: 1])

  return result

def Instructions.Operations.ROR
    (operand_size : Int) (src1 : Bits operand_size) (src2 : Bits 8) :
    Runtime.SpecM Exception (State σ) (Bits operand_size) := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let count : Int ← do
    if operand_size == 64 then
      pure (Unsigned (← src2[5:0]))
    else
      pure (Unsigned (← src2[4:0]))
  let temp_count : Int ← Std.Integer.Positive_Remainder count operand_size
  let result : Bits operand_size ← Std.Bits.Rotate_Right (size := operand_size) src1 temp_count

  -- count == 0 leaves flags unmodified
  if (count == 1) then
    RFLAGS.setOF ((← result[operand_size - 1 +: 1]) xor (← result[operand_size - 2 +: 1]))
    RFLAGS.setCF (← result[operand_size - 1 +: 1])
  else
    if (count != 0) then
      RFLAGS.setOF (← UNSPECIFIED (size := 1))
      RFLAGS.setCF (← result[operand_size - 1 +: 1])
  return result

def Instructions.Operations.RCL
    (operand_size : Int) (src1 : Bits operand_size) (src2 : Bits 8) :
    Runtime.SpecM Exception (State σ) (Bits operand_size) := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let count : Int ← do
    if operand_size == 64 then
      pure (Unsigned (← src2[5:0]))
    else
      pure (Unsigned (← src2[4:0]))
  let mut rotate_count : Int ←
    match operand_size with
    | 8 => do
      pure (← Std.Integer.Positive_Remainder count 9)
    | 16 => do
      pure (← Std.Integer.Positive_Remainder count 17)
    | 32 => do
      pure count
    | 64 => do
      pure count
    | _ => throw .unmatchedCase

  let mut rotate : Bits ((1 : Int) + operand_size) ← concatBits (leftSize := 1) (rightSize := operand_size) (← RFLAGS.CF) src1
  for _i in intRange (1 : Int) rotate_count do
    let top : Runtime.Bit ← do
      Runtime.assert (decide (operand_size < 1 + operand_size))
      pure (← rotate[operand_size +: 1])
    let bottom : Bits operand_size ← do
      Runtime.assert (decide (operand_size ≤ 1 + operand_size))
      pure (← rotate[0 +: operand_size])
    rotate := (BitVec.cast (by omega) (← concatBits (leftSize := operand_size) (rightSize := 1) bottom top) : Bits ((1 : Int) + operand_size))

  let result : Bits operand_size ← do
    Runtime.assert (decide (operand_size ≤ 1 + operand_size))
    pure (← rotate[0 +: operand_size])
  let cf : Runtime.Bit ← do
    Runtime.assert (decide (operand_size < 1 + operand_size))
    pure (← rotate[operand_size +: 1])

  if (count == 1) then
    RFLAGS.setOF ((← result[operand_size - 1 +: 1]) xor cf)
  else
    if (count != 0) then
      RFLAGS.setOF (← UNSPECIFIED (size := 1))

  RFLAGS.setCF cf
  return result

def Instructions.Operations.RCR
    (operand_size : Int) (src1 : Bits operand_size) (src2 : Bits 8) :
    Runtime.SpecM Exception (State σ) (Bits operand_size) := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let count : Int ← do
    if operand_size == 64 then
      pure (Unsigned (← src2[5:0]))
    else
      pure (Unsigned (← src2[4:0]))
  let mut rotate_count : Int ←
    match operand_size with
    | 8 => do
      pure (← Std.Integer.Positive_Remainder count 9)
    | 16 => do
      pure (← Std.Integer.Positive_Remainder count 17)
    | 32 => do
      pure count
    | 64 => do
      pure count
    | _ => throw .unmatchedCase

  let mut rotate : Bits ((1 : Int) + operand_size) ← concatBits (leftSize := 1) (rightSize := operand_size) (← RFLAGS.CF) src1
  for _i in intRange (1 : Int) rotate_count do
    let top : Bits operand_size ← do
      Runtime.assert (decide (1 + operand_size ≤ 1 + operand_size))
      pure (← rotate[1 +: operand_size])
    let bottom : Runtime.Bit ← do
      Runtime.assert (decide (0 < 1 + operand_size))
      pure (← rotate[0 +: 1])
    rotate := (← concatBits (leftSize := 1) (rightSize := operand_size) bottom top)

  let result : Bits operand_size ← do
    Runtime.assert (decide (operand_size ≤ 1 + operand_size))
    pure (← rotate[0 +: operand_size])
  let cf : Runtime.Bit ← do
    Runtime.assert (decide (operand_size < 1 + operand_size))
    pure (← rotate[operand_size +: 1])

  if (count == 1) then
    RFLAGS.setOF ((← src1[operand_size - 1 +: 1]) xor (← RFLAGS.CF))
  else
    if (count != 0) then
      RFLAGS.setOF (← UNSPECIFIED (size := 1))

  RFLAGS.setCF cf

  return result

-- ROL_GPR8_IMMb: C0 /0 ib
def Instructions.ROL_GPR8_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 ← Mem_Fetch ip 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- ROL_MEMb_IMMb: C0 /0 ib
def Instructions.ROL_MEMb_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- ROR_GPR8_IMMb: C0 /1 ib
def Instructions.ROR_GPR8_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 ← Mem_Fetch ip 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- ROR_MEMb_IMMb: C0 /1 ib
def Instructions.ROR_MEMb_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCL_GPR8_IMMb: C0 /2 ib
def Instructions.RCL_GPR8_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 ← Mem_Fetch ip 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- RCL_MEMb_IMMb: C0 /2 ib
def Instructions.RCL_MEMb_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCR_GPR8_IMMb: C0 /3 ib
def Instructions.RCR_GPR8_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 ← Mem_Fetch ip 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- RCR_MEMb_IMMb: C0 /3 ib
def Instructions.RCR_MEMb_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- ROL_GPRv_IMMb: C1 /0 ib
def Instructions.ROL_GPRv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 ← Mem_Fetch ip 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- ROL_MEMv_IMMb: C1 /0 ib
def Instructions.ROL_MEMv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- ROR_GPRv_IMMb: C1 /1 ib
def Instructions.ROR_GPRv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 ← Mem_Fetch ip 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- ROR_MEMv_IMMb: C1 /1 ib
def Instructions.ROR_MEMv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCL_GPRv_IMMb: C1 /2 ib
def Instructions.RCL_GPRv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 ← Mem_Fetch ip 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- RCL_MEMv_IMMb: C1 /2 ib
def Instructions.RCL_MEMv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCR_GPRv_IMMb: C1 /3 ib
def Instructions.RCR_GPRv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 ← Mem_Fetch ip 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- RCR_MEMv_IMMb: C1 /3 ib
def Instructions.RCR_MEMv_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- ROL_GPRv_ONE: D1 /0
def Instructions.ROL_GPRv_ONE
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 := 1

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- ROL_MEMv_ONE: D1 /0
def Instructions.ROL_MEMv_ONE
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 := 1
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- ROR_GPRv_ONE: D1 /1
def Instructions.ROR_GPRv_ONE
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 := 1

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- ROR_MEMv_ONE: D1 /1
def Instructions.ROR_MEMv_ONE
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 := 1
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCL_GPRv_ONE: D1 /2
def Instructions.RCL_GPRv_ONE
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 := 1

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- RCL_MEMv_ONE: D1 /2
def Instructions.RCL_MEMv_ONE
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 := 1
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCR_GPRv_ONE: D1 /3
def Instructions.RCR_GPRv_ONE
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 := 1

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- RCR_MEMv_ONE: D1 /3
def Instructions.RCR_MEMv_ONE
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 := 1
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- ROL_GPRv_CL: D3 /0
def Instructions.ROL_GPRv_CL
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 ← CL

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- ROL_MEMv_CL: D3 /0
def Instructions.ROL_MEMv_CL
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← CL
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- ROR_GPRv_CL: D3 /1
def Instructions.ROR_GPRv_CL
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 ← CL

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- ROR_MEMv_CL: D3 /1
def Instructions.ROR_MEMv_CL
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← CL
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCL_GPRv_CL: D3 /2
def Instructions.RCL_GPRv_CL
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 ← CL

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- RCL_MEMv_CL: D3 /2
def Instructions.RCL_MEMv_CL
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← CL
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCR_GPRv_CL: D3 /3
def Instructions.RCR_GPRv_CL
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src1 : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size
  let src2 : Bits 8 ← CL

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result

-- RCR_MEMv_CL: D3 /3
def Instructions.RCR_MEMv_CL
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← CL
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- ROL_GPR8_ONE: D0 /0
def Instructions.ROL_GPR8_ONE
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 := 1

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- ROL_MEMb_ONE: D0 /0
def Instructions.ROL_MEMb_ONE
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 := 1
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- ROR_GPR8_ONE: D0 /1
def Instructions.ROR_GPR8_ONE
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 := 1

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- ROR_MEMb_ONE: D0 /1
def Instructions.ROR_MEMb_ONE
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 := 1
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCL_GPR8_ONE: D0 /2
def Instructions.RCL_GPR8_ONE
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 := 1

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- RCL_MEMb_ONE: D0 /2
def Instructions.RCL_MEMb_ONE
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 := 1
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCR_GPR8_ONE: D0 /3
def Instructions.RCR_GPR8_ONE
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 := 1

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- RCR_MEMb_ONE: D0 /3
def Instructions.RCR_MEMb_ONE
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 := 1
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- ROL_GPR8_CL: D2 /0
def Instructions.ROL_GPR8_CL
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 ← CL

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- ROL_MEMb_CL: D2 /0
def Instructions.ROL_MEMb_CL
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← CL
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.ROL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- ROR_GPR8_CL: D2 /1
def Instructions.ROR_GPR8_CL
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 ← CL

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- ROR_MEMb_CL: D2 /1
def Instructions.ROR_MEMb_CL
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← CL
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.ROR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCL_GPR8_CL: D2 /2
def Instructions.RCL_GPR8_CL
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 ← CL

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- RCL_MEMb_CL: D2 /2
def Instructions.RCL_MEMb_CL
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← CL
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.RCL operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- RCR_GPR8_CL: D2 /3
def Instructions.RCR_GPR8_CL
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 8

  let src1 : Bits 8 ← Read_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present)
  let src2 : Bits 8 ← CL

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Write_GPR8 (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) (context.rex_prefix_present or context.rex2_prefix_present or context.vex_prefix_present or context.evex_prefix_present) result

-- RCR_MEMb_CL: D2 /3
def Instructions.RCR_MEMb_CL
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src2 : Bits 8 ← CL
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src1 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read_Modify_Write Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.RCR operand_size src1 src2

  Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

end X86
