-- Generated from data/instruction/CVTDQ2PD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 38e46635fd982edd121c5d436e5b91b642ea7ee046666b482db96cf7ec96da50
-- Description: data/sdm/CVTDQ2PD.docbook
-- Converts two, four or eight packed signed doubleword integers in the source operand (the second
-- operand) to two, four or eight packed double precision floating-point values in the destination
-- operand (the first operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CVTDQ2PD)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.FP.Check_Exceptions
import X86.Helpers.FP.Decode_Rounding_Mode
import X86.Helpers.FP.From_Int
import X86.Helpers.FP_Exception_Flags_Type
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
import X86.Helpers.Rounding_Mode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Positive_Divide
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

def Instructions.Operations.CVTi2Pg
    (element_size : Int) (register_size : Int) (result_element_size : Int) (result_size : Int) (src : Bits register_size) (context : Instruction_Context) (mod : Bits 2) :
    Runtime.SpecM Exception (State σ) (Bits result_size) := do
  Runtime.assert (register_size == 64 || register_size == 128 || register_size == 256 || register_size == 512)
  Runtime.assert (result_size == 128 || result_size == 256 || result_size == 512)
  Runtime.assert (element_size == 32)
  Runtime.assert (result_element_size == 32 || result_element_size == 64)

  let elements : Int ← Std.Integer.Positive_Divide result_size result_element_size
  let exception_masks : Bits 6 ← MXCSR.Exception_Masks
  let suppress_all_exceptions : Bool := context.evex_b == 1 and mod == 3
  let rc : Bits 2 ← do
    if context.evex_b == 1 and mod == 3 then
      pure context.evex_LLRC
    else
      MXCSR.RC
  let rounding_mode : Rounding_Mode ← FP.Decode_Rounding_Mode rc
  let mut all_exceptions : Bits 6 ← Std.Bits.Zero 6
  let mut result : Bits result_size ← Std.Bits.Zero result_size
  for i in intRange (0 : Int) (elements - 1) do
    let op : Bits element_size ← do
      Runtime.assert (decide (i * element_size ≤ register_size - element_size))
      pure (← src[i *: element_size])
    let (r, exceptions) ← FP.From_Int (source_size := element_size) op true result_element_size rounding_mode
    all_exceptions := all_exceptions or exceptions
    Runtime.assert (decide (i * result_element_size ≤ result_size - result_element_size))
    result := (← setSliceChecked result (i * result_element_size) result_element_size r)
  let reported_exceptions : Bits 6 ← do
    if suppress_all_exceptions then
      Std.Bits.Zero 6
    else
      pure all_exceptions
  FP.Check_Exceptions reported_exceptions exception_masks
  return result

def Instructions.Operations.CVTi2Pg_m
    (element_size : Int) (register_size : Int) (result_element_size : Int) (result_size : Int) (old : Bits result_size) (k : Bits 64) (src : Bits register_size) (context : Instruction_Context) (mod : Bits 2) :
    Runtime.SpecM Exception (State σ) (Bits result_size) := do
  Runtime.assert (register_size == 64 || register_size == 128 || register_size == 256 || register_size == 512)
  Runtime.assert (result_size == 128 || result_size == 256 || result_size == 512)
  Runtime.assert (element_size == 32)
  Runtime.assert (result_element_size == 32 || result_element_size == 64)

  let elements : Int ← Std.Integer.Positive_Divide result_size result_element_size
  let exception_masks : Bits 6 ← MXCSR.Exception_Masks
  let suppress_all_exceptions : Bool := context.evex_b == 1 and mod == 3
  let rc : Bits 2 ← do
    if context.evex_b == 1 and mod == 3 then
      pure context.evex_LLRC
    else
      MXCSR.RC
  let rounding_mode : Rounding_Mode ← FP.Decode_Rounding_Mode rc
  let mut all_exceptions : Bits 6 ← Std.Bits.Zero 6
  let mut result : Bits result_size ← Std.Bits.Zero result_size
  for i in intRange (0 : Int) (elements - 1) do
    if ((← k[i +: 1]) == 1) then
      let op : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        pure (← src[i *: element_size])
      let (r, exceptions) ← FP.From_Int (source_size := element_size) op true result_element_size rounding_mode
      all_exceptions := all_exceptions or exceptions
      Runtime.assert (decide (i * result_element_size ≤ result_size - result_element_size))
      result := (← setSliceChecked result (i * result_element_size) result_element_size r)
    else
      Runtime.assert (decide (i * result_element_size ≤ result_size - result_element_size))
      result := (← setSliceChecked result (i * result_element_size) result_element_size (← (do Runtime.assert (decide (i * result_element_size ≤ result_size - result_element_size)); pure (← old[i *: result_element_size]))))
  let reported_exceptions : Bits 6 ← do
    if suppress_all_exceptions then
      Std.Bits.Zero 6
    else
      pure all_exceptions
  FP.Check_Exceptions reported_exceptions exception_masks
  return result

def Instructions.Operations.CVTi2Pg_z
    (element_size : Int) (register_size : Int) (result_element_size : Int) (result_size : Int) (k : Bits 64) (src : Bits register_size) (context : Instruction_Context) (mod : Bits 2) :
    Runtime.SpecM Exception (State σ) (Bits result_size) := do
  Runtime.assert (register_size == 64 || register_size == 128 || register_size == 256 || register_size == 512)
  Runtime.assert (result_size == 128 || result_size == 256 || result_size == 512)
  Runtime.assert (element_size == 32)
  Runtime.assert (result_element_size == 32 || result_element_size == 64)

  let elements : Int ← Std.Integer.Positive_Divide result_size result_element_size
  let exception_masks : Bits 6 ← MXCSR.Exception_Masks
  let suppress_all_exceptions : Bool := context.evex_b == 1 and mod == 3
  let rc : Bits 2 ← do
    if context.evex_b == 1 and mod == 3 then
      pure context.evex_LLRC
    else
      MXCSR.RC
  let rounding_mode : Rounding_Mode ← FP.Decode_Rounding_Mode rc
  let mut all_exceptions : Bits 6 ← Std.Bits.Zero 6
  let mut result : Bits result_size ← Std.Bits.Zero result_size
  for i in intRange (0 : Int) (elements - 1) do
    if ((← k[i +: 1]) == 1) then
      let op : Bits element_size ← do
        Runtime.assert (decide (i * element_size ≤ register_size - element_size))
        pure (← src[i *: element_size])
      let (r, exceptions) ← FP.From_Int (source_size := element_size) op true result_element_size rounding_mode
      all_exceptions := all_exceptions or exceptions
      Runtime.assert (decide (i * result_element_size ≤ result_size - result_element_size))
      result := (← setSliceChecked result (i * result_element_size) result_element_size r)
    else
      Runtime.assert (decide (i * result_element_size ≤ result_size - result_element_size))
      result := (← setSliceChecked result (i * result_element_size) result_element_size (← Std.Bits.Zero result_element_size))
  let reported_exceptions : Bits 6 ← do
    if suppress_all_exceptions then
      Std.Bits.Zero 6
    else
      pure all_exceptions
  FP.Check_Exceptions reported_exceptions exception_masks
  return result

-- CVTDQ2PD_XMMpd_MEMq: F3 0F E6 /r
-- CPUID group: SSE2
def Instructions.CVTDQ2PD_XMMpd_MEMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 64
  let result_size : Int := 128
  let element_size : Int := 32
  let result_element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg element_size register_size result_element_size result_size src context mod

  Write_XMM (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- CVTDQ2PD_XMMpd_XMMq: F3 0F E6 /r
-- CPUID group: SSE2
def Instructions.CVTDQ2PD_XMMpd_XMMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 128
  let element_size : Int := 32
  let result_element_size : Int := 64

  let src : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg element_size register_size result_element_size result_size src context mod

  Write_XMM (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VCVTDQ2PD_XMMdq_MEMq: VEX.L0.F3.0F.WIG E6 /r
-- CPUID group: AVX
def Instructions.VCVTDQ2PD_XMMdq_MEMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 64
  let result_size : Int := 128
  let element_size : Int := 32
  let result_element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
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

  let src : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg element_size register_size result_element_size result_size src context mod

  Write_XMM (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VCVTDQ2PD_XMMdq_XMMq: VEX.L0.F3.0F.WIG E6 /r
-- CPUID group: AVX
def Instructions.VCVTDQ2PD_XMMdq_XMMq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 128
  let element_size : Int := 32
  let result_element_size : Int := 64

  let src : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
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

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg element_size register_size result_element_size result_size src context mod

  Write_XMM (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VCVTDQ2PD_YMMqq_MEMdq: VEX.L1.F3.0F.WIG E6 /r
-- CPUID group: AVX
def Instructions.VCVTDQ2PD_YMMqq_MEMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let result_size : Int := 256
  let element_size : Int := 32
  let result_element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
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

  let src : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg element_size register_size result_element_size result_size src context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VCVTDQ2PD_YMMqq_XMMdq: VEX.L1.F3.0F.WIG E6 /r
-- CPUID group: AVX
def Instructions.VCVTDQ2PD_YMMqq_XMMdq
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 256
  let element_size : Int := 32
  let result_element_size : Int := 64

  let src : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
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

  modify ({ · with Next_IP := ip })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg element_size register_size result_element_size result_size src context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VCVTDQ2PD_XMMf64_MASKmskw_MEMi32_AVX512_MASK: EVEX.L0.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VCVTDQ2PD_XMMf64_MASKmskw_MEMi32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let result_size : Int := 128
  let element_size : Int := 32
  let register_size : Int := 64
  let result_element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 128 ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 128
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let src : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_m element_size register_size result_element_size result_size old k src context mod

  Write_XMM (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VCVTDQ2PD_XMMf64_MASKmskw_XMMi32_AVX512_MASK: EVEX.L0.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VCVTDQ2PD_XMMf64_MASKmskw_XMMi32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let result_size : Int := 128
  let register_size : Int := 128
  let element_size : Int := 32
  let result_element_size : Int := 64

  let old : Bits 128 ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) 128
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_m element_size register_size result_element_size result_size old k src context mod

  Write_XMM (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VCVTDQ2PD_XMMf64_MASKmskw_MEMi32_AVX512_ZERO: EVEX.L0.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VCVTDQ2PD_XMMf64_MASKmskw_MEMi32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let result_size : Int := 128
  let element_size : Int := 32
  let register_size : Int := 64
  let result_element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let src : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_z element_size register_size result_element_size result_size k src context mod

  Write_XMM (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VCVTDQ2PD_XMMf64_MASKmskw_XMMi32_AVX512_ZERO: EVEX.L0.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VCVTDQ2PD_XMMf64_MASKmskw_XMMi32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 128
  let element_size : Int := 32
  let result_element_size : Int := 64

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_z element_size register_size result_element_size result_size k src context mod

  Write_XMM (size := result_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VCVTDQ2PD_ZMMf64_MASKmskw_YMMi32_AVX512_MASK_1: EVEX.512.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VCVTDQ2PD_ZMMf64_MASKmskw_YMMi32_AVX512_MASK_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let result_size : Int := 512
  let register_size : Int := 256
  let element_size : Int := 32
  let result_element_size : Int := 64

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_m element_size register_size result_element_size result_size old k src context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VCVTDQ2PD_ZMMf64_MASKmskw_YMMi32_AVX512_ZERO_1: EVEX.512.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VCVTDQ2PD_ZMMf64_MASKmskw_YMMi32_AVX512_ZERO_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let result_size : Int := 512
  let element_size : Int := 32
  let result_element_size : Int := 64

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_z element_size register_size result_element_size result_size k src context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VCVTDQ2PD_YMMf64_MASKmskw_MEMi32_AVX512_MASK: EVEX.L1.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VCVTDQ2PD_YMMf64_MASKmskw_MEMi32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let result_size : Int := 256
  let element_size : Int := 32
  let register_size : Int := 128
  let result_element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let src : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_m element_size register_size result_element_size result_size old k src context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VCVTDQ2PD_YMMf64_MASKmskw_XMMi32_AVX512_MASK: EVEX.L1.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VCVTDQ2PD_YMMf64_MASKmskw_XMMi32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let result_size : Int := 256
  let register_size : Int := 128
  let element_size : Int := 32
  let result_element_size : Int := 64

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_m element_size register_size result_element_size result_size old k src context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VCVTDQ2PD_YMMf64_MASKmskw_MEMi32_AVX512_ZERO: EVEX.L1.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VCVTDQ2PD_YMMf64_MASKmskw_MEMi32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let result_size : Int := 256
  let element_size : Int := 32
  let register_size : Int := 128
  let result_element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let src : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_z element_size register_size result_element_size result_size k src context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VCVTDQ2PD_YMMf64_MASKmskw_XMMi32_AVX512_ZERO: EVEX.L1.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VCVTDQ2PD_YMMf64_MASKmskw_XMMi32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let result_size : Int := 256
  let element_size : Int := 32
  let result_element_size : Int := 64

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_z element_size register_size result_element_size result_size k src context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VCVTDQ2PD_ZMMf64_MASKmskw_MEMi32_AVX512_MASK: EVEX.L2.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VCVTDQ2PD_ZMMf64_MASKmskw_MEMi32_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let result_size : Int := 512
  let element_size : Int := 32
  let register_size : Int := 256
  let result_element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let src : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_m element_size register_size result_element_size result_size old k src context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VCVTDQ2PD_ZMMf64_MASKmskw_YMMi32_AVX512_MASK_0: EVEX.L2.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VCVTDQ2PD_ZMMf64_MASKmskw_YMMi32_AVX512_MASK_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let result_size : Int := 512
  let register_size : Int := 256
  let element_size : Int := 32
  let result_element_size : Int := 64

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_m element_size register_size result_element_size result_size old k src context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VCVTDQ2PD_ZMMf64_MASKmskw_MEMi32_AVX512_ZERO: EVEX.L2.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VCVTDQ2PD_ZMMf64_MASKmskw_MEMi32_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let result_size : Int := 512
  let element_size : Int := 32
  let register_size : Int := 256
  let result_element_size : Int := 64

  let disp8n : Int ← do
    if context.evex_b == 1 then
      Std.Integer.Positive_Divide element_size 8
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let src : Bits register_size ← Masked_Vector_Mem_Read register_size element_size (context.evex_b == 1) k segment effective_address true
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_z element_size register_size result_element_size result_size k src context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VCVTDQ2PD_ZMMf64_MASKmskw_YMMi32_AVX512_ZERO_0: EVEX.L2.F3.0F.W0 E6 /r
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VCVTDQ2PD_ZMMf64_MASKmskw_YMMi32_AVX512_ZERO_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let result_size : Int := 512
  let element_size : Int := 32
  let result_element_size : Int := 64

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)

  if (not (context.vex_pp == 2 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits result_size ← Instructions.Operations.CVTi2Pg_z element_size register_size result_element_size result_size k src context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86
