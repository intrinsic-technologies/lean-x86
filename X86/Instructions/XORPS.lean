-- Generated from data/instruction/XORPS.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: f7f06a1b62e6edfb2def0271110b56d5c2a55e0f17f6663444e178b18b4f442d
-- Description: data/sdm/XORPS.docbook
-- Performs a bitwise logical XOR of the four, eight or sixteen packed single precision
-- floating-point values from the first source operand and the second source operand, and stores
-- the result in the destination operand
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=XORPS)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Masked_Vector_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_Mask
import X86.Helpers.Read_XMM
import X86.Helpers.Read_YMM
import X86.Helpers.Read_ZMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Write_XMM
import X86.Helpers.Write_YMM
import X86.Helpers.Write_ZMM
import X86.Instructions.PXOR
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

def Instructions.Operations.XORPf_m
    (element_size register_size : Int) (old : Bits register_size) (k : Bits 64) (src1 src2 : Bits register_size) (_context : Instruction_Context) (_mod : Bits 2) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for i in intRange (0 : Int) (elements - 1) do
    if ((← k[i +: 1]) == 1) then
      let op1 : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        pure (← src1[i *: element_size])
      let op2 : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        pure (← src2[i *: element_size])
      let r : Bits element_size := op1 xor op2
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size r)
    else
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size (← (do Runtime.assert (decide (i * element_size ≤ register_size - element_size)); Runtime.assert (decide (0 ≤ element_size)); pure (← old[i *: element_size]))))
  return result

def Instructions.Operations.XORPf_z
    (element_size register_size : Int) (k : Bits 64) (src1 src2 : Bits register_size) (_context : Instruction_Context) (_mod : Bits 2) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for i in intRange (0 : Int) (elements - 1) do
    if ((← k[i +: 1]) == 1) then
      let op1 : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        pure (← src1[i *: element_size])
      let op2 : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        pure (← src2[i *: element_size])
      let r : Bits element_size := op1 xor op2
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size r)
    else
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      result := (← setSliceChecked result (i * element_size) element_size (← Std.Bits.Zero element_size))
  return result

-- XORPS_XMMxud_MEMxud: NP 0F 57 /r
-- CPUID group: SSE
def Instructions.XORPS_XMMxud_MEMxud
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 128

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits 128 ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 128
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Explicitly_Aligned false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.PXOR operand_size src1 src2

  Write_XMM (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- XORPS_XMMxud_XMMxud: NP 0F 57 /r
-- CPUID group: SSE
def Instructions.XORPS_XMMxud_XMMxud
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 128

  let src1 : Bits 128 ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 128
  let src2 : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.PXOR operand_size src1 src2

  Write_XMM (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VXORPS_XMMdq_XMMdq_MEMdq: VEX.L0.NP.0F.WIG 57 /r
-- CPUID group: AVX
def Instructions.VXORPS_XMMdq_XMMdq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 128

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits 128 ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) 128
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

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

  let src2 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.PXOR operand_size src1 src2

  Write_XMM (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VXORPS_XMMdq_XMMdq_XMMdq: VEX.L0.NP.0F.WIG 57 /r
-- CPUID group: AVX
def Instructions.VXORPS_XMMdq_XMMdq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 128

  let src1 : Bits 128 ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) 128
  let src2 : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128

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

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.PXOR operand_size src1 src2

  Write_XMM (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VXORPS_YMMqq_YMMqq_MEMqq: VEX.L1.NP.0F.WIG 57 /r
-- CPUID group: AVX
def Instructions.VXORPS_YMMqq_YMMqq_MEMqq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 256

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

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

  let src2 : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.PXOR operand_size src1 src2

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VXORPS_YMMqq_YMMqq_YMMqq: VEX.L1.NP.0F.WIG 57 /r
-- CPUID group: AVX
def Instructions.VXORPS_YMMqq_YMMqq_YMMqq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := 256

  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

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

  modify ({ · with Next_IP := ip })

  let result : Bits operand_size ← Instructions.Operations.PXOR operand_size src1 src2

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VXORPS_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_MASK: EVEX.L0.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_128 or AVX512DQ_128_AVX10
def Instructions.VXORPS_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.XORPf_m element_size register_size old k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VXORPS_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_MASK: EVEX.L0.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_128 or AVX512DQ_128_AVX10
def Instructions.VXORPS_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.XORPf_m element_size register_size old k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VXORPS_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_ZERO: EVEX.L0.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_128 or AVX512DQ_128_AVX10
def Instructions.VXORPS_XMMu32_MASKmskw_XMMu32_MEMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.XORPf_z element_size register_size k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VXORPS_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_ZERO: EVEX.L0.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_128 or AVX512DQ_128_AVX10
def Instructions.VXORPS_XMMu32_MASKmskw_XMMu32_XMMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.XORPf_z element_size register_size k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VXORPS_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_MASK: EVEX.L1.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_256 or AVX512DQ_256_AVX10
def Instructions.VXORPS_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.XORPf_m element_size register_size old k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VXORPS_YMMu32_MASKmskw_YMMu32_YMMu32_AVX512_MASK: EVEX.L1.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_256 or AVX512DQ_256_AVX10
def Instructions.VXORPS_YMMu32_MASKmskw_YMMu32_YMMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 32

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.XORPf_m element_size register_size old k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VXORPS_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_ZERO: EVEX.L1.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_256 or AVX512DQ_256_AVX10
def Instructions.VXORPS_YMMu32_MASKmskw_YMMu32_MEMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.XORPf_z element_size register_size k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VXORPS_YMMu32_MASKmskw_YMMu32_YMMu32_AVX512_ZERO: EVEX.L1.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_256 or AVX512DQ_256_AVX10
def Instructions.VXORPS_YMMu32_MASKmskw_YMMu32_YMMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.XORPf_z element_size register_size k src1 src2 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VXORPS_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_MASK: EVEX.L2.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_512 or AVX512DQ_512_AVX10
def Instructions.VXORPS_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.XORPf_m element_size register_size old k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VXORPS_ZMMu32_MASKmskw_ZMMu32_ZMMu32_AVX512_MASK: EVEX.L2.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_512 or AVX512DQ_512_AVX10
def Instructions.VXORPS_ZMMu32_MASKmskw_ZMMu32_ZMMu32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 32

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.XORPf_m element_size register_size old k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VXORPS_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_ZERO: EVEX.L2.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_512 or AVX512DQ_512_AVX10
def Instructions.VXORPS_ZMMu32_MASKmskw_ZMMu32_MEMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.XORPf_z element_size register_size k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VXORPS_ZMMu32_MASKmskw_ZMMu32_ZMMu32_AVX512_ZERO: EVEX.L2.NP.0F.W0 57 /r
-- CPUID group: AVX512DQ_512 or AVX512DQ_512_AVX10
def Instructions.VXORPS_ZMMu32_MASKmskw_ZMMu32_ZMMu32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv)
  let src2 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.XORPf_z element_size register_size k src1 src2 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86
