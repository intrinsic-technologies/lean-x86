-- Generated from data/instruction/PSLLDQ.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: b204ad93f448d1b80b96bfe8af09f1a2a3f470aa19e2c50b273ce3d177c41c55
-- Description: data/sdm/PSLLDQ.docbook
-- Shifts the destination operand (first operand) to the left by the number of bytes specified in
-- the count operand (second operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PSLLDQ)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_XMM
import X86.Helpers.Read_YMM
import X86.Helpers.Read_ZMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Shift_Left_Logical
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Max
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Write_XMM
import X86.Helpers.Write_YMM
import X86.Helpers.Write_ZMM
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
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.PSLLDQ
    (element_size register_size shift_size : Int) (src1 : Bits register_size) (shift_distance : Bits shift_size) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)
  Runtime.assert (0 ≤ shift_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for i in intRange (0 : Int) (elements - 1) do
    let op1 : Bits element_size ← do
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      pure (← src1[i *: element_size])
    let count : Int := Unsigned shift_distance * 8
    let r : Bits element_size ← Std.Bits.Shift_Left_Logical (size := element_size) op1 count
    Runtime.assert (decide (i * element_size ≤ register_size - element_size))
    Runtime.assert (decide (0 ≤ element_size))
    result := (← setSliceChecked result (i * element_size) element_size r)
  return result

-- PSLLDQ_XMMdq_IMMb: 66 0F 73 /7 ib
-- CPUID group: SSE2
def Instructions.PSLLDQ_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 128

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSLLDQ element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← Calculate_RM mod rm context) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSLLDQ_XMMdq_XMMdq_IMMb: VEX.L0.66.0F.WIG 73 /7 ib
-- CPUID group: AVX
def Instructions.VPSLLDQ_XMMdq_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 128

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSLLDQ element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSLLDQ_XMMu8_MEMu8_IMM8_AVX512: EVEX.L0.66.0F.WIG 73 /7 ib
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSLLDQ_XMMu8_MEMu8_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 128

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src1 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSLLDQ element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSLLDQ_XMMu8_XMMu8_IMM8_AVX512: EVEX.L0.66.0F.WIG 73 /7 ib
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSLLDQ_XMMu8_XMMu8_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let shift_size : Int := 8
  let element_size : Int := 128

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSLLDQ element_size register_size shift_size src1 shift_distance

  Write_XMM (size := register_size) (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSLLDQ_YMMqq_YMMqq_IMMb: VEX.L1.66.0F.WIG 73 /7 ib
-- CPUID group: AVX2
def Instructions.VPSLLDQ_YMMqq_YMMqq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 128

  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSLLDQ element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSLLDQ_YMMu8_MEMu8_IMM8_AVX512: EVEX.L1.66.0F.WIG 73 /7 ib
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSLLDQ_YMMu8_MEMu8_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 128

  let disp8n : Int := 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src1 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSLLDQ element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSLLDQ_YMMu8_YMMu8_IMM8_AVX512: EVEX.L1.66.0F.WIG 73 /7 ib
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSLLDQ_YMMu8_YMMu8_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let shift_size : Int := 8
  let element_size : Int := 128

  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSLLDQ element_size register_size shift_size src1 shift_distance

  Write_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSLLDQ_ZMMu8_MEMu8_IMM8_AVX512: EVEX.L2.66.0F.WIG 73 /7 ib
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSLLDQ_ZMMu8_MEMu8_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 128

  let disp8n : Int := 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch next_ip0 8) shift_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src1 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.PSLLDQ element_size register_size shift_size src1 shift_distance

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

-- VPSLLDQ_ZMMu8_ZMMu8_IMM8_AVX512: EVEX.L2.66.0F.WIG 73 /7 ib
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSLLDQ_ZMMu8_ZMMu8_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let shift_size : Int := 8
  let element_size : Int := 128

  let src1 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)
  let shift_distance : Bits shift_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) shift_size

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.PSLLDQ element_size register_size shift_size src1 shift_distance

  Write_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) result

end X86
