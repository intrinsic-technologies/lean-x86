-- Generated from data/instruction/MINSS.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: d10e1966214e7dcf6b543a76782970157dbf61e65bc282ee12eba82ab97cac48
-- Description: data/sdm/MINSS.docbook
-- Compares the low single precision floating-point values in the first source operand and the
-- second source operand and returns the minimum value to the low doubleword of the destination
-- operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MINSS)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.FP.Check_Exceptions
import X86.Helpers.FP.Get_DAZ
import X86.Helpers.FP.Min_Max
import X86.Helpers.FP_Exception_Flags_Type
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_Mask
import X86.Helpers.Read_XMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Divide
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

def Instructions.Operations.MINSf
    (element_size : Int) (register_size : Int) (src1 : Bits register_size) (src2 : Bits element_size) :
    Runtime.SpecM Exception (State σ) (Bits register_size) := do
  Runtime.assert (element_size == 32 || element_size == 64)
  Runtime.assert (register_size == 128)

  let denormals_are_zeros : Bool ← FP.Get_DAZ element_size
  let exception_masks : Bits 6 ← MXCSR.Exception_Masks
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  let op1 : Bits element_size ← src1[0 +: element_size]
  let (r, exceptions) ← FP.Min_Max (N := element_size) false op1 src2 denormals_are_zeros
  FP.Check_Exceptions exceptions exception_masks
  Runtime.assert (decide (element_size ≤ register_size))
  result := (← setSliceChecked result 0 element_size r)
  Runtime.assert (decide (register_size - 1 < register_size))
  Runtime.assert (decide (element_size ≤ register_size - 1 + 1))
  result := (← setSliceChecked result element_size (((register_size - (1 : Int)) - element_size) + (1 : Int)) (BitVec.cast (by omega) (← src1[register_size - 1:element_size]) : Bits (((register_size - (1 : Int)) - element_size) + (1 : Int))))
  return result

def Instructions.Operations.MINSf_m
    (element_size : Int) (register_size : Int) (old : Bits register_size) (k : Bits 64) (src1 : Bits register_size) (src2 : Bits element_size) (context : Instruction_Context) (mod : Bits 2) :
    Runtime.SpecM Exception (State σ) (Bits register_size) := do
  Runtime.assert (element_size == 32 || element_size == 64)
  Runtime.assert (register_size == 128)

  let denormals_are_zeros : Bool ← FP.Get_DAZ element_size
  let exception_masks : Bits 6 ← MXCSR.Exception_Masks
  let suppress_all_exceptions : Bool := context.evex_b == 1 and mod == 3
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  if ((← k[0 +: 1]) == 1) then
    let op1 : Bits element_size ← src1[0 +: element_size]
    let (r, exceptions) ← FP.Min_Max (N := element_size) false op1 src2 denormals_are_zeros
    let reported_exceptions : FP_Exception_Flags_Type ← do
      if suppress_all_exceptions then
        Std.Bits.Zero 6
      else
        pure exceptions
    FP.Check_Exceptions reported_exceptions exception_masks
    Runtime.assert (decide (element_size ≤ register_size))
    result := (← setSliceChecked result 0 element_size r)
  else
    Runtime.assert (decide (element_size ≤ register_size))
    result := (← setSliceChecked result 0 element_size (← old[0 +: element_size]))
  Runtime.assert (decide (register_size - 1 < register_size))
  Runtime.assert (decide (element_size ≤ register_size - 1 + 1))
  result := (← setSliceChecked result element_size (((register_size - (1 : Int)) - element_size) + (1 : Int)) (BitVec.cast (by omega) (← src1[register_size - 1:element_size]) : Bits (((register_size - (1 : Int)) - element_size) + (1 : Int))))
  return result

def Instructions.Operations.MINSf_z
    (element_size : Int) (register_size : Int) (k : Bits 64) (src1 : Bits register_size) (src2 : Bits element_size) (context : Instruction_Context) (mod : Bits 2) :
    Runtime.SpecM Exception (State σ) (Bits register_size) := do
  Runtime.assert (element_size == 32 || element_size == 64)
  Runtime.assert (register_size == 128)

  let denormals_are_zeros : Bool ← FP.Get_DAZ element_size
  let exception_masks : Bits 6 ← MXCSR.Exception_Masks
  let suppress_all_exceptions : Bool := context.evex_b == 1 and mod == 3
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  if ((← k[0 +: 1]) == 1) then
    let op1 : Bits element_size ← src1[0 +: element_size]
    let (r, exceptions) ← FP.Min_Max (N := element_size) false op1 src2 denormals_are_zeros
    let reported_exceptions : FP_Exception_Flags_Type ← do
      if suppress_all_exceptions then
        Std.Bits.Zero 6
      else
        pure exceptions
    FP.Check_Exceptions reported_exceptions exception_masks
    Runtime.assert (decide (element_size ≤ register_size))
    result := (← setSliceChecked result 0 element_size r)
  else
    Runtime.assert (decide (element_size ≤ register_size))
    result := (← setSliceChecked result 0 element_size (← Std.Bits.Zero element_size))
  Runtime.assert (decide (register_size - 1 < register_size))
  Runtime.assert (decide (element_size ≤ register_size - 1 + 1))
  result := (← setSliceChecked result element_size (((register_size - (1 : Int)) - element_size) + (1 : Int)) (BitVec.cast (by omega) (← src1[register_size - 1:element_size]) : Bits (((register_size - (1 : Int)) - element_size) + (1 : Int))))
  return result

-- MINSS_XMMss_MEMss: F3 0F 5D /r
-- CPUID group: SSE
def Instructions.MINSS_XMMss_MEMss
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MINSf element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- MINSS_XMMss_XMMss: F3 0F 5D /r
-- CPUID group: SSE
def Instructions.MINSS_XMMss_XMMss
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let src2 : Bits 32 ← Read_XMM (← Calculate_RM mod rm context) 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.MINSf element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMINSS_XMMdq_XMMdq_MEMd: VEX.LIG.F3.0F.WIG 5D /r
-- CPUID group: AVX
def Instructions.VMINSS_XMMdq_XMMdq_MEMd
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
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

  let src2 : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MINSf element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMINSS_XMMdq_XMMdq_XMMd: VEX.LIG.F3.0F.WIG 5D /r
-- CPUID group: AVX
def Instructions.VMINSS_XMMdq_XMMdq_XMMd
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits 32 ← Read_XMM (← Calculate_RM mod rm context) 32

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

  let result : Bits register_size ← Instructions.Operations.MINSf element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMINSS_XMMf32_MASKmskw_XMMf32_MEMf32_AVX512_MASK: EVEX.128.F3.0F.W0 5D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VMINSS_XMMf32_MASKmskw_XMMf32_MEMf32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

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

  let src2 : Bits element_size ← do
    if (← k[0 +: 1]) == 1 then
      Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
    else
      Std.Bits.Zero element_size
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MINSf_m element_size register_size old k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMINSS_XMMf32_MASKmskw_XMMf32_XMMf32_AVX512_MASK_0: EVEX.128.F3.0F.W0 5D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VMINSS_XMMf32_MASKmskw_XMMf32_XMMf32_AVX512_MASK_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits 32 ← Read_XMM (← Calculate_RM mod rm context) 32

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

  let result : Bits register_size ← Instructions.Operations.MINSf_m element_size register_size old k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMINSS_XMMf32_MASKmskw_XMMf32_MEMf32_AVX512_ZERO: EVEX.128.F3.0F.W0 5D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VMINSS_XMMf32_MASKmskw_XMMf32_MEMf32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

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

  let src2 : Bits element_size ← do
    if (← k[0 +: 1]) == 1 then
      Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
    else
      Std.Bits.Zero element_size
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MINSf_z element_size register_size k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMINSS_XMMf32_MASKmskw_XMMf32_XMMf32_AVX512_ZERO_0: EVEX.128.F3.0F.W0 5D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VMINSS_XMMf32_MASKmskw_XMMf32_XMMf32_AVX512_ZERO_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits 32 ← Read_XMM (← Calculate_RM mod rm context) 32

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

  let result : Bits register_size ← Instructions.Operations.MINSf_z element_size register_size k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMINSS_XMMf32_MASKmskw_XMMf32_XMMf32_AVX512_MASK_1: EVEX.128.F3.0F.W0 5D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VMINSS_XMMf32_MASKmskw_XMMf32_XMMf32_AVX512_MASK_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits 32 ← Read_XMM (← Calculate_RM mod rm context) 32

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

  let result : Bits register_size ← Instructions.Operations.MINSf_m element_size register_size old k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMINSS_XMMf32_MASKmskw_XMMf32_XMMf32_AVX512_ZERO_1: EVEX.128.F3.0F.W0 5D /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VMINSS_XMMf32_MASKmskw_XMMf32_XMMf32_AVX512_ZERO_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits 32 ← Read_XMM (← Calculate_RM mod rm context) 32

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

  let result : Bits register_size ← Instructions.Operations.MINSf_z element_size register_size k src1 src2 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

end X86
