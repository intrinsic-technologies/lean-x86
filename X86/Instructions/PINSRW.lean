-- Generated from data/instruction/PINSRW.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 8f5568f77dab9154015747eabf3c1231fc987dec40b5759c9a832d060bec65ba
-- Description: data/sdm/PINSRW.docbook
-- Three operand MMX and SSE instructions:
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PINSRW)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Read_GPR
import X86.Helpers.Read_MMX
import X86.Helpers.Read_XMM
import X86.Helpers.Read_YMM
import X86.Helpers.Read_ZMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Log2
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Write_MMX
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

def Instructions.Operations.PINSR
    (element_size register_size src_size : Int) (src1 : Bits register_size) (src2 : Bits src_size) (imm : Bits 8) :
    Runtime.PartialResult Empty (Bits register_size) := do
  Runtime.assert (0 ≤ register_size)
  Runtime.assert (0 ≤ src_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let mut result : Bits register_size := src1
  let sel : Int ← (do
    let __check432 : Int ← Std.Integer.Log2 elements
    return (← (do Runtime.assert (decide (__check432 ≤ 8)); Runtime.assert (decide (0 ≤ __check432)); pure (Unsigned (← imm[0 +: __check432])))))
  Runtime.assert (decide (sel * element_size ≤ register_size - element_size))
  Runtime.assert (decide (0 ≤ element_size))
  Runtime.assert (decide (0 ≤ sel))
  result := (← setSliceChecked result (sel * element_size) element_size (← src2[0 +: element_size]))
  return result

-- PINSRW_MMXq_GPR32_IMMb: NP 0F C4 /r ib
-- CPUID group: PENTIUMMMX
def Instructions.PINSRW_MMXq_GPR32_IMMb
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 64
  let src_size : Int := 32
  let element_size : Int := 16

  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (Read_MMX reg)) 0 register_size)
  let src2 : Bits 32 ← Runtime.liftTotal (Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 32)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions)

  Runtime.liftTotal (FP87_Status.setTOP 0)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_MMX reg result)
  Runtime.liftTotal (FP87_Tag_Word.assign (← Std.Bits.Zero 16))

-- PINSRW_MMXq_MEMw_IMMb: NP 0F C4 /r ib
-- CPUID group: PENTIUMMMX
def Instructions.PINSRW_MMXq_MEMw_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 64
  let src_size : Int := 16
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src1 : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (Read_MMX reg)) 0 register_size)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions)

  let src2 : Bits src_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  Runtime.liftTotal (FP87_Status.setTOP 0)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_MMX reg result)
  Runtime.liftTotal (FP87_Tag_Word.assign (← Std.Bits.Zero 16))

-- PINSRW_XMMdq_GPR32_IMMb: 66 0F C4 /r ib
-- CPUID group: SSE2
def Instructions.PINSRW_XMMdq_GPR32_IMMb
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let src_size : Int := 32
  let element_size : Int := 16

  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let src2 : Bits 32 ← Runtime.liftTotal (Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 32)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSFXSR)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- PINSRW_XMMdq_MEMw_IMMb: 66 0F C4 /r ib
-- CPUID group: SSE2
def Instructions.PINSRW_XMMdq_MEMw_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let src_size : Int := 16
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSFXSR)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits src_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VPINSRW_XMMdq_XMMdq_GPR32d_IMMb: VEX.L0.66.0F.WIG C4 /r ib
-- CPUID group: AVX
def Instructions.VPINSRW_XMMdq_XMMdq_GPR32d_IMMb
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let src_size : Int := 32
  let element_size : Int := 16

  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size)
  let src2 : Bits 32 ← Runtime.liftTotal (Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 32)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_LL == 0 and context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VPINSRW_XMMdq_XMMdq_MEMw_IMMb: VEX.L0.66.0F.WIG C4 /r ib
-- CPUID group: AVX
def Instructions.VPINSRW_XMMdq_XMMdq_MEMw_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let src_size : Int := 16
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_LL == 0 and context.vex_pp == 1)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits src_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VPINSRW_XMMu16_XMMu16_GPR32u16_IMM8_AVX512: EVEX.L0.66.0F.WIG C4 /r ib
-- CPUID group: AVX512BW_128N or AVX512BW_128N_AVX10
def Instructions.VPINSRW_XMMu16_XMMu16_GPR32u16_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let src_size : Int := 32
  let element_size : Int := 16

  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size)
  let src2 : Bits 32 ← Runtime.liftTotal (Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 32)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VPINSRW_XMMu16_XMMu16_MEMu16_IMM8_AVX512: EVEX.L0.66.0F.WIG C4 /r ib
-- CPUID group: AVX512BW_128N or AVX512BW_128N_AVX10
def Instructions.VPINSRW_XMMu16_XMMu16_MEMu16_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let src_size : Int := 16
  let element_size : Int := 16

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits src_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VPINSRW_YMMu16_YMMu16_GPR32u16_IMM8_AVX512: EVEX.L1.66.0F.WIG C4 /r ib
-- CPUID group: VPINSR_VPEXTR_YMM_ZMM_256
def Instructions.VPINSRW_YMMu16_YMMu16_GPR32u16_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let src_size : Int := 32
  let element_size : Int := 16

  let src1 : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let src2 : Bits 32 ← Runtime.liftTotal (Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 32)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VPINSRW_YMMu16_YMMu16_MEMu16_IMM8_AVX512: EVEX.L1.66.0F.WIG C4 /r ib
-- CPUID group: VPINSR_VPEXTR_YMM_ZMM_256
def Instructions.VPINSRW_YMMu16_YMMu16_MEMu16_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let src_size : Int := 16
  let element_size : Int := 16

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src1 : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits src_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VPINSRW_ZMMu16_ZMMu16_GPR32u16_IMM8_AVX512: EVEX.L2.66.0F.WIG C4 /r ib
-- CPUID group: VPINSR_VPEXTR_YMM_ZMM_512
def Instructions.VPINSRW_ZMMu16_ZMMu16_GPR32u16_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let src_size : Int := 32
  let element_size : Int := 16

  let src1 : Bits 512 ← Runtime.liftTotal (Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let src2 : Bits 32 ← Runtime.liftTotal (Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) 32)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VPINSRW_ZMMu16_ZMMu16_MEMu16_IMM8_AVX512: EVEX.L2.66.0F.WIG C4 /r ib
-- CPUID group: VPINSR_VPEXTR_YMM_ZMM_512
def Instructions.VPINSRW_ZMMu16_ZMMu16_MEMu16_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let src_size : Int := 16
  let element_size : Int := 16

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src1 : Bits 512 ← Runtime.liftTotal (Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and context.evex_aaa == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits src_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address src_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.PINSR element_size register_size src_size src1 src2 imm

  Runtime.liftTotal (Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

end X86
