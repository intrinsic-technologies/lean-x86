-- Generated from data/instruction/CMPSS.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 0115d82b1c65effb9b7b95d64a8fdc944b3a6c8d5b85de820e674cbbeb837cce
-- Description: data/sdm/CMPSS.docbook
-- Compares the low single precision floating-point values in the second source operand and the
-- first source operand and returns the result of the comparison to the destination operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CMPSS)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.FP.Check_Exceptions
import X86.Helpers.FP.Compare5
import X86.Helpers.FP.Get_DAZ
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_Mask
import X86.Helpers.Read_XMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.UFloatCompare
import X86.Helpers.Write_Mask
import X86.Helpers.Write_XMM
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
  [X86.Read_MXCSR_DAZ16.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.CMP3Sf
    (element_size : Int) (register_size : Int) (src_size : Int) (src1 : Bits register_size) (src2 : Bits src_size) (imm8 : Bits 8) :
    Runtime.SpecM Exception (State σ) (Bits register_size) := do
  Runtime.assert (register_size == 128)
  Runtime.assert (src_size == 32 || src_size == 64 || src_size == 128)
  Runtime.assert (element_size == 32 || element_size == 64)

  let denormals_are_zeros : Bool ← FP.Get_DAZ element_size
  let exception_masks : Bits 6 ← MXCSR.Exception_Masks
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  let op1 : Bits element_size ← src1[0 +: element_size]
  let op2 : Bits element_size ← src2[0 +: element_size]
  let (e, exceptions) ← FP.Compare5 (N := element_size) op1 op2 (← concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) (← imm8[2:0])) denormals_are_zeros
  let r : Bits element_size ← do
    if e then
      Std.Bits.All_Ones element_size
    else
      Std.Bits.Zero element_size
  FP.Check_Exceptions exceptions exception_masks
  Runtime.assert (decide (element_size ≤ register_size))
  result := (← setSliceChecked result 0 element_size r)
  Runtime.assert (decide (register_size - 1 < register_size))
  Runtime.assert (decide (element_size ≤ register_size - 1 + 1))
  result := (← setSliceChecked result element_size (((register_size - (1 : Int)) - element_size) + (1 : Int)) (BitVec.cast (by omega) (← src1[register_size - 1:element_size]) : Bits (((register_size - (1 : Int)) - element_size) + (1 : Int))))
  return result

def Instructions.Operations.CMP5Sf
    (element_size : Int) (register_size : Int) (src_size : Int) (src1 : Bits register_size) (src2 : Bits src_size) (imm8 : Bits 8) :
    Runtime.SpecM Exception (State σ) (Bits register_size) := do
  Runtime.assert (register_size == 128)
  Runtime.assert (src_size == 32 || src_size == 64 || src_size == 128)
  Runtime.assert (element_size == 32 || element_size == 64)

  let denormals_are_zeros : Bool ← FP.Get_DAZ element_size
  let exception_masks : Bits 6 ← MXCSR.Exception_Masks
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  let op1 : Bits element_size ← src1[0 +: element_size]
  let op2 : Bits element_size ← src2[0 +: element_size]
  let (e, exceptions) ← FP.Compare5 (N := element_size) op1 op2 (← imm8[4:0]) denormals_are_zeros
  let r : Bits element_size ← do
    if e then
      Std.Bits.All_Ones element_size
    else
      Std.Bits.Zero element_size
  FP.Check_Exceptions exceptions exception_masks
  Runtime.assert (decide (element_size ≤ register_size))
  result := (← setSliceChecked result 0 element_size r)
  Runtime.assert (decide (register_size - 1 < register_size))
  Runtime.assert (decide (element_size ≤ register_size - 1 + 1))
  result := (← setSliceChecked result element_size (((register_size - (1 : Int)) - element_size) + (1 : Int)) (BitVec.cast (by omega) (← src1[register_size - 1:element_size]) : Bits (((register_size - (1 : Int)) - element_size) + (1 : Int))))
  return result

def Instructions.Operations.CMP5Sf_mask_z
    (element_size : Int) (register_size : Int) (src_size : Int) (k : Bits 64) (src1 : Bits register_size) (src2 : Bits src_size) (imm8 : Bits 8) (context : Instruction_Context) (mod : Bits 2) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.assert (register_size == 128)
  Runtime.assert (src_size == 32 || src_size == 64 || src_size == 128)
  Runtime.assert (element_size == 32 || element_size == 64)

  let denormals_are_zeros : Bool ← FP.Get_DAZ element_size
  let exception_masks : Bits 6 ← MXCSR.Exception_Masks
  let suppress_all_exceptions : Bool := context.evex_b == 1 and mod == 3
  let mut result : Bits 64 ← Std.Bits.Zero 64
  if ((← k[0 +: 1]) == 1) then
    let op1 : Bits element_size ← src1[0 +: element_size]
    let op2 : Bits element_size ← src2[0 +: element_size]
    let (e, exceptions) ← FP.Compare5 (N := element_size) op1 op2 (← imm8[4:0]) denormals_are_zeros
    let r : Runtime.Bit ← Bit e
    let reported_exceptions : FP_Exception_Flags_Type ← do
      if suppress_all_exceptions then
        Std.Bits.Zero 6
      else
        pure exceptions
    FP.Check_Exceptions reported_exceptions exception_masks
    result := (← setSliceChecked result 0 1 r)
  else
    result := (← setSliceChecked result 0 1 (← Std.Bits.Zero 1))
  return result

-- CMPSS_XMMss_MEMss_IMMb: F3 0F C2 /r ib
-- CPUID group: SSE
def Instructions.CMPSS_XMMss_MEMss_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let src_size : Int := 32
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let imm8 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.CMP3Sf element_size register_size src_size src1 src2 imm8

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- CMPSS_XMMss_XMMss_IMMb: F3 0F C2 /r ib
-- CPUID group: SSE
def Instructions.CMPSS_XMMss_XMMss_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let src_size : Int := 32
  let element_size : Int := 32

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let src2 : Bits 32 ← Read_XMM (← Calculate_RM mod rm context) 32
  let imm8 : Bits 8 ← Mem_Fetch ip 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.CMP3Sf element_size register_size src_size src1 src2 imm8

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VCMPSS_XMMdq_XMMdq_MEMd_IMMb: VEX.LIG.F3.0F.WIG C2 /r ib
-- CPUID group: AVX
def Instructions.VCMPSS_XMMdq_XMMdq_MEMd_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let src_size : Int := 32
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let imm8 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src2 : Bits src_size ← Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.CMP5Sf element_size register_size src_size src1 src2 imm8

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VCMPSS_XMMdq_XMMdq_XMMd_IMMb: VEX.LIG.F3.0F.WIG C2 /r ib
-- CPUID group: AVX
def Instructions.VCMPSS_XMMdq_XMMdq_XMMd_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let src_size : Int := 32
  let element_size : Int := 32

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits 32 ← Read_XMM (← Calculate_RM mod rm context) 32
  let imm8 : Bits 8 ← Mem_Fetch ip 8

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

  let result : Bits register_size ← Instructions.Operations.CMP5Sf element_size register_size src_size src1 src2 imm8

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VCMPSS_MASKmskw_MASKmskw_XMMf32_MEMf32_IMM8_AVX512_ZERO: EVEX.128.F3.0F.W0 C2 /r ib
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCMPSS_MASKmskw_MASKmskw_XMMf32_MEMf32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let src_size : Int := 32
  let element_size : Int := 32

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let imm8 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.evex_z != 1)) then
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

  let src2 : Bits src_size ← do
    if (← k[0 +: 1]) == 1 then
      Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
    else
      Std.Bits.Zero src_size
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits 64 ← Instructions.Operations.CMP5Sf_mask_z element_size register_size src_size k src1 src2 imm8 context mod

  Write_Mask reg result

-- VCMPSS_MASKmskw_MASKmskw_XMMf32_XMMf32_IMM8_AVX512_ZERO_0: EVEX.128.F3.0F.W0 C2 /r ib
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCMPSS_MASKmskw_MASKmskw_XMMf32_XMMf32_IMM8_AVX512_ZERO_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let src_size : Int := 128
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128
  let imm8 : Bits 8 ← Mem_Fetch ip 8

  if (not (context.evex_z != 1)) then
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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits 64 ← Instructions.Operations.CMP5Sf_mask_z element_size register_size src_size k src1 src2 imm8 context mod

  Write_Mask reg result

-- VCMPSS_MASKmskw_MASKmskw_XMMf32_XMMf32_IMM8_AVX512_ZERO_1: EVEX.128.F3.0F.W0 C2 /r ib
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VCMPSS_MASKmskw_MASKmskw_XMMf32_XMMf32_IMM8_AVX512_ZERO_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let src_size : Int := 128
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits 128 ← Read_XMM (← Calculate_RM mod rm context) 128
  let imm8 : Bits 8 ← Mem_Fetch ip 8

  if (not (context.evex_z != 1)) then
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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits 64 ← Instructions.Operations.CMP5Sf_mask_z element_size register_size src_size k src1 src2 imm8 context mod

  Write_Mask reg result

end X86
