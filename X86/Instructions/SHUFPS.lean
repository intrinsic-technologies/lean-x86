-- Generated from data/instruction/SHUFPS.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 2ad7b3e6e6caaff72812a6554c7a9a9ff328c8b0b37f1c6e1480d7624f30d2aa
-- Description: data/sdm/SHUFPS.docbook
-- Selects a single precision floating-point value of an input quadruplet using a two-bit control
-- and move to a designated element of the destination operand.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=SHUFPS)
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
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Vector_Mem_Read
import X86.Helpers.Write_XMM
import X86.Helpers.Write_YMM
import X86.Helpers.Write_ZMM
import X86.Instructions.SHUFPD
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

-- SHUFPS_XMMps_MEMps_IMMb: NP 0F C6 /r ib
-- CPUID group: SSE
def Instructions.SHUFPS_XMMps_MEMps_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSFXSR)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.EM)) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Explicitly_Aligned false)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes element_size register_size src1 src2 imm8

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- SHUFPS_XMMps_XMMps_IMMb: NP 0F C6 /r ib
-- CPUID group: SSE
def Instructions.SHUFPS_XMMps_XMMps_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let src2 : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.rep_prefix == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
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

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes element_size register_size src1 src2 imm8

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VSHUFPS_XMMdq_XMMdq_MEMdq_IMMb: VEX.L0.NP.0F.WIG C6 /r ib
-- CPUID group: AVX
def Instructions.VSHUFPS_XMMdq_XMMdq_MEMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size)
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src2 : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes element_size register_size src1 src2 imm8

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VSHUFPS_XMMdq_XMMdq_XMMdq_IMMb: VEX.L0.NP.0F.WIG C6 /r ib
-- CPUID group: AVX
def Instructions.VSHUFPS_XMMdq_XMMdq_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size)
  let src2 : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

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

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes element_size register_size src1 src2 imm8

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VSHUFPS_YMMqq_YMMqq_MEMqq_IMMb: VEX.L1.NP.0F.WIG C6 /r ib
-- CPUID group: AVX
def Instructions.VSHUFPS_YMMqq_YMMqq_MEMqq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 32

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src1 : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

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

  let src2 : Bits register_size ← Runtime.liftTotal (Logical_Mem_Read segment effective_address register_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes element_size register_size src1 src2 imm8

  Runtime.liftTotal (Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VSHUFPS_YMMqq_YMMqq_YMMqq_IMMb: VEX.L1.NP.0F.WIG C6 /r ib
-- CPUID group: AVX
def Instructions.VSHUFPS_YMMqq_YMMqq_YMMqq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 32

  let src1 : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let src2 : Bits 256 ← Runtime.liftTotal (Read_YMM (← Calculate_RM mod rm context))
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

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

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes element_size register_size src1 src2 imm8

  Runtime.liftTotal (Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VSHUFPS_XMMf32_MASKmskw_XMMf32_MEMf32_IMM8_AVX512_MASK: EVEX.L0.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VSHUFPS_XMMf32_MASKmskw_XMMf32_MEMf32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      pure (← Std.Integer.Positive_Divide element_size 8)
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let old : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size)
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Runtime.liftTotal (Vector_Mem_Read register_size element_size (context.evex_b == 1) segment effective_address)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_m element_size register_size old k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VSHUFPS_XMMf32_MASKmskw_XMMf32_XMMf32_IMM8_AVX512_MASK: EVEX.L0.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VSHUFPS_XMMf32_MASKmskw_XMMf32_XMMf32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let old : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size)
  let src2 : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_m element_size register_size old k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VSHUFPS_XMMf32_MASKmskw_XMMf32_MEMf32_IMM8_AVX512_ZERO: EVEX.L0.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VSHUFPS_XMMf32_MASKmskw_XMMf32_MEMf32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      pure (← Std.Integer.Positive_Divide element_size 8)
    else
      pure 16
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size)
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Runtime.liftTotal (Vector_Mem_Read register_size element_size (context.evex_b == 1) segment effective_address)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_z element_size register_size k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VSHUFPS_XMMf32_MASKmskw_XMMf32_XMMf32_IMM8_AVX512_ZERO: EVEX.L0.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_128 or AVX512F_128_AVX10
def Instructions.VSHUFPS_XMMf32_MASKmskw_XMMf32_XMMf32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 32

  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size)
  let src2 : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_z element_size register_size k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present))

-- VSHUFPS_YMMf32_MASKmskw_YMMf32_MEMf32_IMM8_AVX512_MASK: EVEX.L1.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VSHUFPS_YMMf32_MASKmskw_YMMf32_MEMf32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      pure (← Std.Integer.Positive_Divide element_size 8)
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let old : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg))
  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Runtime.liftTotal (Vector_Mem_Read register_size element_size (context.evex_b == 1) segment effective_address)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_m element_size register_size old k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VSHUFPS_YMMf32_MASKmskw_YMMf32_YMMf32_IMM8_AVX512_MASK: EVEX.L1.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VSHUFPS_YMMf32_MASKmskw_YMMf32_YMMf32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 32

  let old : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg))
  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let src2 : Bits 256 ← Runtime.liftTotal (Read_YMM (← Calculate_RM mod rm context))
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_m element_size register_size old k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VSHUFPS_YMMf32_MASKmskw_YMMf32_MEMf32_IMM8_AVX512_ZERO: EVEX.L1.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VSHUFPS_YMMf32_MASKmskw_YMMf32_MEMf32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 256
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      pure (← Std.Integer.Positive_Divide element_size 8)
    else
      pure 32
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Runtime.liftTotal (Vector_Mem_Read register_size element_size (context.evex_b == 1) segment effective_address)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_z element_size register_size k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VSHUFPS_YMMf32_MASKmskw_YMMf32_YMMf32_IMM8_AVX512_ZERO: EVEX.L1.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_256 or AVX512F_256_AVX10
def Instructions.VSHUFPS_YMMf32_MASKmskw_YMMf32_YMMf32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 256
  let element_size : Int := 32

  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let src2 : Bits 256 ← Runtime.liftTotal (Read_YMM (← Calculate_RM mod rm context))
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_z element_size register_size k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VSHUFPS_ZMMf32_MASKmskw_ZMMf32_MEMf32_IMM8_AVX512_MASK: EVEX.L2.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VSHUFPS_ZMMf32_MASKmskw_ZMMf32_MEMf32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      pure (← Std.Integer.Positive_Divide element_size 8)
    else
      pure 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let old : Bits 512 ← Runtime.liftTotal (Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg))
  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits 512 ← Runtime.liftTotal (Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Runtime.liftTotal (Vector_Mem_Read register_size element_size (context.evex_b == 1) segment effective_address)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_m element_size register_size old k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VSHUFPS_ZMMf32_MASKmskw_ZMMf32_ZMMf32_IMM8_AVX512_MASK: EVEX.L2.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VSHUFPS_ZMMf32_MASKmskw_ZMMf32_ZMMf32_IMM8_AVX512_MASK
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 32

  let old : Bits 512 ← Runtime.liftTotal (Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg))
  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits 512 ← Runtime.liftTotal (Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let src2 : Bits 512 ← Runtime.liftTotal (Read_ZMM (← Calculate_RM mod rm context))
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_m element_size register_size old k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VSHUFPS_ZMMf32_MASKmskw_ZMMf32_MEMf32_IMM8_AVX512_ZERO: EVEX.L2.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VSHUFPS_ZMMf32_MASKmskw_ZMMf32_MEMf32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 512
  let element_size : Int := 32

  let disp8n : Int ← do
    if context.evex_b == 1 then
      pure (← Std.Integer.Positive_Divide element_size 8)
    else
      pure 64
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits 512 ← Runtime.liftTotal (Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  let src2 : Bits register_size ← Runtime.liftTotal (Vector_Mem_Read register_size element_size (context.evex_b == 1) segment effective_address)
  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_z element_size register_size k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VSHUFPS_ZMMf32_MASKmskw_ZMMf32_ZMMf32_IMM8_AVX512_ZERO: EVEX.L2.NP.0F.W0 C6 /r ib
-- CPUID group: AVX512F_512 or AVX512F_512_AVX10
def Instructions.VSHUFPS_ZMMf32_MASKmskw_ZMMf32_ZMMf32_IMM8_AVX512_ZERO
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let register_size : Int := 512
  let element_size : Int := 32

  let k : Bits 64 ← Runtime.liftTotal (Read_Mask context.evex_aaa)
  let src1 : Bits 512 ← Runtime.liftTotal (Read_ZMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv))
  let src2 : Bits 512 ← Runtime.liftTotal (Read_ZMM (← Calculate_RM mod rm context))
  let imm8 : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 0 and context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Real_Address_Mode or (← Runtime.liftTotal (Current_Mode)) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR4.OSXSAVE)) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← Runtime.liftTotal (CR0.TS)) == 1) then
    liftM (Report_Not_Available_Exception)

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1))

  let result : Bits register_size ← Instructions.Operations.SHUFP_lanes_z element_size register_size k src1 src2 imm8 context mod

  Runtime.liftTotal (Write_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

end X86
