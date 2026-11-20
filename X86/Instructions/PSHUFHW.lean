-- Generated from data/instruction/PSHUFHW.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 585b25bde6ca1fc8c83c49e25e31393cbc3d7ba33a248b78131704bbafcdba93
-- Description: data/sdm/PSHUFHW.docbook
-- Copies words from the high quadword of a 128-bit lane of the source operand and inserts them in
-- the high quadword of the destination operand at word locations (of the respective lane) selected
-- with the immediate operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PSHUFHW)
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
import X86.Helpers.Read_Mask
import X86.Helpers.Read_XMM
import X86.Helpers.Read_YMM
import X86.Helpers.Read_ZMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Align_Down
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Positive_Remainder
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

def Instructions.Operations.SHUFH_lanes
    (element_size register_size : Int) (src1 : Bits register_size) (imm8 : Bits 8) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)

  let lanes : Int ← Std.Integer.Positive_Divide register_size 128
  let elements : Int ← Std.Integer.Positive_Divide 128 element_size
  let half_elements : Int ← Std.Integer.Positive_Divide elements 2
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for lane in intRange (0 : Int) (lanes - 1) do
    let s1 : Bits 128 ← do
      Runtime.assert (decide (lane * 128 ≤ register_size - 128))
      pure (← src1[lane *: 128])
    let mut lane_result : Bits 128 ← Std.Bits.Zero 128
    for i in intRange (0 : Int) (elements - 1) do
      let r : Bits element_size ← do
        if decide ((← Std.Integer.Positive_Remainder i elements) ≥ half_elements) then
          let index : Int := (← Std.Integer.Align_Down i elements) + half_elements + Unsigned (← (do
            let __check384 : Int ← Std.Integer.Positive_Remainder i half_elements
            Runtime.assert (decide (__check384 * 2 ≤ 6))
            Runtime.assert (decide (0 ≤ __check384))
            pure (← imm8[__check384 *: 2])))
          let r : Bits element_size ← do
            Runtime.assert (decide (index * element_size ≤ 128 - element_size))
            Runtime.assert (decide (0 ≤ element_size))
            Runtime.assert (decide (0 ≤ index))
            pure (← s1[index *: element_size])
          pure r
        else
          let r : Bits element_size ← do
            Runtime.assert (decide (i * element_size ≤ 128 - element_size))
            Runtime.assert (decide (0 ≤ element_size))
            pure (← s1[i *: element_size])
          pure r
      Runtime.assert (decide (i * element_size ≤ 128 - element_size))
      Runtime.assert (decide (0 ≤ element_size))
      lane_result := (← setSliceChecked lane_result (i * element_size) element_size r)
    Runtime.assert (decide (lane * 128 ≤ register_size - 128))
    result := (← setSliceChecked result (lane * (128 : Int)) 128 lane_result)
  return result

def Instructions.Operations.SHUFH_lanes_m
    (element_size register_size : Int) (old : Bits register_size) (k : Bits 64) (src1 : Bits register_size) (imm8 : Bits 8) (_context : Instruction_Context) (_mod : Bits 2) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)

  let lanes : Int ← Std.Integer.Positive_Divide register_size 128
  let elements : Int ← Std.Integer.Positive_Divide 128 element_size
  let half_elements : Int ← Std.Integer.Positive_Divide elements 2
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for lane in intRange (0 : Int) (lanes - 1) do
    let lane_old : Bits 128 ← do
      Runtime.assert (decide (lane * 128 ≤ register_size - 128))
      pure (← old[lane *: 128])
    let s1 : Bits 128 ← do
      Runtime.assert (decide (lane * 128 ≤ register_size - 128))
      pure (← src1[lane *: 128])
    let mut lane_result : Bits 128 ← Std.Bits.Zero 128
    for i in intRange (0 : Int) (elements - 1) do
      if ((← k[lane * elements + i +: 1]) == 1) then
        let r : Bits element_size ← do
          if decide ((← Std.Integer.Positive_Remainder i elements) ≥ half_elements) then
            let index : Int := (← Std.Integer.Align_Down i elements) + half_elements + Unsigned (← (do
              let __check386 : Int ← Std.Integer.Positive_Remainder i half_elements
              Runtime.assert (decide (__check386 * 2 ≤ 6))
              Runtime.assert (decide (0 ≤ __check386))
              pure (← imm8[__check386 *: 2])))
            let r : Bits element_size ← do
              Runtime.assert (decide (index * element_size ≤ 128 - element_size))
              Runtime.assert (decide (0 ≤ element_size))
              Runtime.assert (decide (0 ≤ index))
              pure (← s1[index *: element_size])
            pure r
          else
            let r : Bits element_size ← do
              Runtime.assert (decide (i * element_size ≤ 128 - element_size))
              Runtime.assert (decide (0 ≤ element_size))
              pure (← s1[i *: element_size])
            pure r
        Runtime.assert (decide (i * element_size ≤ 128 - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        lane_result := (← setSliceChecked lane_result (i * element_size) element_size r)
      else
        Runtime.assert (decide (i * element_size ≤ 128 - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        lane_result := (← setSliceChecked lane_result (i * element_size) element_size (← (do Runtime.assert (decide (i * element_size ≤ 128 - element_size)); Runtime.assert (decide (0 ≤ element_size)); pure (← lane_old[i *: element_size]))))
    Runtime.assert (decide (lane * 128 ≤ register_size - 128))
    result := (← setSliceChecked result (lane * (128 : Int)) 128 lane_result)
  return result

def Instructions.Operations.SHUFH_lanes_z
    (element_size register_size : Int) (k : Bits 64) (src1 : Bits register_size) (imm8 : Bits 8) (_context : Instruction_Context) (_mod : Bits 2) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)

  let lanes : Int ← Std.Integer.Positive_Divide register_size 128
  let elements : Int ← Std.Integer.Positive_Divide 128 element_size
  let half_elements : Int ← Std.Integer.Positive_Divide elements 2
  let mut result : Bits register_size ← Std.Bits.Zero register_size
  for lane in intRange (0 : Int) (lanes - 1) do
    let s1 : Bits 128 ← do
      Runtime.assert (decide (lane * 128 ≤ register_size - 128))
      pure (← src1[lane *: 128])
    let mut lane_result : Bits 128 ← Std.Bits.Zero 128
    for i in intRange (0 : Int) (elements - 1) do
      if ((← k[lane * elements + i +: 1]) == 1) then
        let r : Bits element_size ← do
          if decide ((← Std.Integer.Positive_Remainder i elements) ≥ half_elements) then
            let index : Int := (← Std.Integer.Align_Down i elements) + half_elements + Unsigned (← (do
              let __check388 : Int ← Std.Integer.Positive_Remainder i half_elements
              Runtime.assert (decide (__check388 * 2 ≤ 6))
              Runtime.assert (decide (0 ≤ __check388))
              pure (← imm8[__check388 *: 2])))
            let r : Bits element_size ← do
              Runtime.assert (decide (index * element_size ≤ 128 - element_size))
              Runtime.assert (decide (0 ≤ element_size))
              Runtime.assert (decide (0 ≤ index))
              pure (← s1[index *: element_size])
            pure r
          else
            let r : Bits element_size ← do
              Runtime.assert (decide (i * element_size ≤ 128 - element_size))
              Runtime.assert (decide (0 ≤ element_size))
              pure (← s1[i *: element_size])
            pure r
        Runtime.assert (decide (i * element_size ≤ 128 - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        lane_result := (← setSliceChecked lane_result (i * element_size) element_size r)
      else
        Runtime.assert (decide (i * element_size ≤ 128 - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        lane_result := (← setSliceChecked lane_result (i * element_size) element_size (← Std.Bits.Zero element_size))
    Runtime.assert (decide (lane * 128 ≤ register_size - 128))
    result := (← setSliceChecked result (lane * (128 : Int)) 128 lane_result)
  return result

-- PSHUFHW_XMMdq_MEMdq_IMMb: F3 0F 70 /r ib
-- CPUID group: SSE2
def Instructions.PSHUFHW_XMMdq_MEMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
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

  let src1 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Explicitly_Aligned false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes element_size register_size src1 imm8

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- PSHUFHW_XMMdq_XMMdq_IMMb: F3 0F 70 /r ib
-- CPUID group: SSE2
def Instructions.PSHUFHW_XMMdq_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 16

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes element_size register_size src1 imm8

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSHUFHW_XMMdq_MEMdq_IMMb: VEX.L0.F3.0F.WIG 70 /r ib
-- CPUID group: AVX
def Instructions.VPSHUFHW_XMMdq_MEMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let imm8 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes element_size register_size src1 imm8

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSHUFHW_XMMdq_XMMdq_IMMb: VEX.L0.F3.0F.WIG 70 /r ib
-- CPUID group: AVX
def Instructions.VPSHUFHW_XMMdq_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 16

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let imm8 : Bits 8 ← Mem_Fetch ip 8

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes element_size register_size src1 imm8

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSHUFHW_YMMqq_MEMqq_IMMb: VEX.L1.F3.0F.WIG 70 /r ib
-- CPUID group: AVX2
def Instructions.VPSHUFHW_YMMqq_MEMqq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let imm8 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src1 : Bits register_size ← Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1)

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes element_size register_size src1 imm8

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSHUFHW_YMMqq_YMMqq_IMMb: VEX.L1.F3.0F.WIG 70 /r ib
-- CPUID group: AVX2
def Instructions.VPSHUFHW_YMMqq_YMMqq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 16

  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let imm8 : Bits 8 ← Mem_Fetch ip 8

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

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes element_size register_size src1 imm8

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSHUFHW_XMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK: EVEX.L0.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSHUFHW_XMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let imm8 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_m element_size register_size old k src1 imm8 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSHUFHW_XMMu16_MASKmskw_XMMu16_IMM8_AVX512_MASK: EVEX.L0.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSHUFHW_XMMu16_MASKmskw_XMMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 16

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let imm8 : Bits 8 ← Mem_Fetch ip 8

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_m element_size register_size old k src1 imm8 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSHUFHW_XMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO: EVEX.L0.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSHUFHW_XMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let imm8 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_z element_size register_size k src1 imm8 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSHUFHW_XMMu16_MASKmskw_XMMu16_IMM8_AVX512_ZERO: EVEX.L0.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_128 or AVX512BW_128_AVX10
def Instructions.VPSHUFHW_XMMu16_MASKmskw_XMMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let imm8 : Bits 8 ← Mem_Fetch ip 8

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_z element_size register_size k src1 imm8 context mod

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VPSHUFHW_YMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK: EVEX.L1.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSHUFHW_YMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 16

  let disp8n : Int := 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let imm8 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_m element_size register_size old k src1 imm8 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSHUFHW_YMMu16_MASKmskw_YMMu16_IMM8_AVX512_MASK: EVEX.L1.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSHUFHW_YMMu16_MASKmskw_YMMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 16

  let old : Bits 256 ← Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let imm8 : Bits 8 ← Mem_Fetch ip 8

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_m element_size register_size old k src1 imm8 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSHUFHW_YMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO: EVEX.L1.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSHUFHW_YMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 16

  let disp8n : Int := 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let imm8 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_z element_size register_size k src1 imm8 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSHUFHW_YMMu16_MASKmskw_YMMu16_IMM8_AVX512_ZERO: EVEX.L1.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_256 or AVX512BW_256_AVX10
def Instructions.VPSHUFHW_YMMu16_MASKmskw_YMMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 256 ← Read_YMM (← Calculate_RM mod rm context)
  let imm8 : Bits 8 ← Mem_Fetch ip 8

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_z element_size register_size k src1 imm8 context mod

  Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSHUFHW_ZMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK: EVEX.L2.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSHUFHW_ZMMu16_MASKmskw_MEMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 16

  let disp8n : Int := 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let imm8 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_m element_size register_size old k src1 imm8 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSHUFHW_ZMMu16_MASKmskw_ZMMu16_IMM8_AVX512_MASK: EVEX.L2.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSHUFHW_ZMMu16_MASKmskw_ZMMu16_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 16

  let old : Bits 512 ← Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg)
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)
  let imm8 : Bits 8 ← Mem_Fetch ip 8

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_m element_size register_size old k src1 imm8 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSHUFHW_ZMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO: EVEX.L2.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSHUFHW_ZMMu16_MASKmskw_MEMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 16

  let disp8n : Int := 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let imm8 : Bits 8 ← Mem_Fetch next_ip0 8
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_z element_size register_size k src1 imm8 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- VPSHUFHW_ZMMu16_MASKmskw_ZMMu16_IMM8_AVX512_ZERO: EVEX.L2.F3.0F.WIG 70 /r ib
-- CPUID group: AVX512BW_512 or AVX512BW_512_AVX10
def Instructions.VPSHUFHW_ZMMu16_MASKmskw_ZMMu16_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 16

  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits 512 ← Read_ZMM (← Calculate_RM mod rm context)
  let imm8 : Bits 8 ← Mem_Fetch ip 8

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
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

  let result : Bits register_size ← Instructions.Operations.SHUFH_lanes_z element_size register_size k src1 imm8 context mod

  Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86
