-- Generated from data/instruction/PEXTRW.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: d8254bd12d3180316ee814bfbb445f9d6b1b59190622e03a91cf45c9bcc1c957
-- Description: data/sdm/PEXTRW.docbook
-- Copies the word in the source operand (second operand) specified by the count operand (third
-- operand) to the destination operand (first operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PEXTRW)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.FP87.Check_For_Pending_Unmasked_Floating_Point_Exceptions
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Read_MMX
import X86.Helpers.Read_XMM
import X86.Helpers.Read_YMM
import X86.Helpers.Read_ZMM
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Log2
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.Write_GPR
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
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.PEXTR
    (operand_size element_size register_size : Int) (src : Bits register_size) (imm : Bits 8) :
    Runtime.PartialResult Empty (Bits operand_size) := do
  Runtime.assert (0 ≤ operand_size)
  Runtime.assert (0 ≤ register_size)

  let elements : Int ← Std.Integer.Positive_Divide register_size element_size
  let sel : Int ← (do
    let __check431 : Int ← Std.Integer.Log2 elements
    return (← (do Runtime.assert (decide (__check431 ≤ 8)); Runtime.assert (decide (0 ≤ __check431)); pure (Unsigned (← imm[0 +: __check431])))))
  let result : Bits operand_size ← Std.Bits.Zero_Extend (source_size := element_size) (← (do Runtime.assert (decide (sel * element_size ≤ register_size - element_size)); Runtime.assert (decide (0 ≤ element_size)); Runtime.assert (decide (0 ≤ sel)); pure (← src[sel *: element_size]))) operand_size
  return result

-- PEXTRW_GPR32_MMXq_IMMb: NP 0F C5 /r ib
-- CPUID group: PENTIUMMMX
def Instructions.PEXTRW_GPR32_MMXq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let operand_size : Int := 32
  let register_size : Int := 64
  let element_size : Int := 16

  let src : Bits register_size ← do
    Runtime.assert (decide (register_size ≤ 64))
    pure (← Runtime.CheckedSlice.read (← Runtime.liftTotal (Read_MMX rm)) 0 register_size)
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

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)
  Runtime.liftTotal (FP87_Tag_Word.assign (← Std.Bits.Zero 16))

-- PEXTRW_SSE4_GPR32_XMMdq_IMMb: 66 0F 3A 15 /r ib
-- CPUID group: SSE4
def Instructions.PEXTRW_SSE4_GPR32_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let operand_size : Int := 32
  let register_size : Int := 128
  let element_size : Int := 16

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.rep_prefix == 0 and context.osz_prefix_present)) then
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

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result)

-- PEXTRW_SSE4_MEMw_XMMdq_IMMb: 66 0F 3A 15 /r ib
-- CPUID group: SSE4
def Instructions.PEXTRW_SSE4_MEMw_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let register_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.rep_prefix == 0 and context.osz_prefix_present)) then
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

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false)

-- VPEXTRW_GPR32d_XMMdq_IMMb_15: VEX.L0.66.0F3A.WIG 15 /r ib
-- CPUID group: AVX
def Instructions.VPEXTRW_GPR32d_XMMdq_IMMb_15
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let operand_size : Int := 32
  let register_size : Int := 128
  let element_size : Int := 16

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_LL == 0 and context.vex_pp == 1 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
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

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result)

-- VPEXTRW_MEMw_XMMdq_IMMb: VEX.L0.66.0F3A.WIG 15 /r ib
-- CPUID group: AVX
def Instructions.VPEXTRW_MEMw_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let register_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_LL == 0 and context.vex_pp == 1 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
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

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false)

-- VPEXTRW_GPR32u16_XMMu16_IMM8_AVX512: EVEX.L0.66.0F3A.WIG 15 /r ib
-- CPUID group: AVX512BW_128N or AVX512BW_128N_AVX10
def Instructions.VPEXTRW_GPR32u16_XMMu16_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let operand_size : Int := 32
  let register_size : Int := 128
  let element_size : Int := 16

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
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

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result)

-- VPEXTRW_MEMu16_XMMu16_IMM8_AVX512: EVEX.L0.66.0F3A.WIG 15 /r ib
-- CPUID group: AVX512BW_128N or AVX512BW_128N_AVX10
def Instructions.VPEXTRW_MEMu16_XMMu16_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let register_size : Int := 128
  let element_size : Int := 16

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
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

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false)

-- PEXTRW_GPR32_XMMdq_IMMb: 66 0F C5 /r ib
-- CPUID group: SSE2
def Instructions.PEXTRW_GPR32_XMMdq_IMMb
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let operand_size : Int := 32
  let register_size : Int := 128
  let element_size : Int := 16

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)
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

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VPEXTRW_GPR32d_XMMdq_IMMb_C5: VEX.L0.66.0F.WIG C5 /r ib
-- CPUID group: AVX
def Instructions.VPEXTRW_GPR32d_XMMdq_IMMb_C5
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let operand_size : Int := 32
  let register_size : Int := 128
  let element_size : Int := 16

  let src : Bits register_size ← Runtime.liftTotal (Read_XMM (← Calculate_RM mod rm context) register_size)
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_LL == 0 and context.vex_pp == 1 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
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

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VPEXTRW_GPR32u16_YMMu16_IMM8_AVX512_0: EVEX.L1.66.0F3A.WIG 15 /r ib
-- CPUID group: VPINSR_VPEXTR_YMM_ZMM_256
def Instructions.VPEXTRW_GPR32u16_YMMu16_IMM8_AVX512_0
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let operand_size : Int := 32
  let register_size : Int := 256
  let element_size : Int := 16

  let src : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg))
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
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

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result)

-- VPEXTRW_MEMu16_YMMu16_IMM8_AVX512: EVEX.L1.66.0F3A.WIG 15 /r ib
-- CPUID group: VPINSR_VPEXTR_YMM_ZMM_256
def Instructions.VPEXTRW_MEMu16_YMMu16_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let register_size : Int := 256
  let element_size : Int := 16

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src : Bits 256 ← Runtime.liftTotal (Read_YMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg))
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
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

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false)

-- VPEXTRW_GPR32u16_YMMu16_IMM8_AVX512_1: EVEX.L1.66.0F.WIG C5 /r ib
-- CPUID group: VPINSR_VPEXTR_YMM_ZMM_256
def Instructions.VPEXTRW_GPR32u16_YMMu16_IMM8_AVX512_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let operand_size : Int := 32
  let register_size : Int := 256
  let element_size : Int := 16

  let src : Bits 256 ← Runtime.liftTotal (Read_YMM (← Calculate_RM mod rm context))
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
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

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

-- VPEXTRW_GPR32u16_ZMMu16_IMM8_AVX512_0: EVEX.L2.66.0F3A.WIG 15 /r ib
-- CPUID group: VPINSR_VPEXTR_YMM_ZMM_512
def Instructions.VPEXTRW_GPR32u16_ZMMu16_IMM8_AVX512_0
    (ip : Bits 64) (context : Instruction_Context) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let operand_size : Int := 32
  let register_size : Int := 512
  let element_size : Int := 16

  let src : Bits 512 ← Runtime.liftTotal (Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg))
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
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

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) result)

-- VPEXTRW_MEMu16_ZMMu16_IMM8_AVX512: EVEX.L2.66.0F3A.WIG 15 /r ib
-- CPUID group: VPINSR_VPEXTR_YMM_ZMM_512
def Instructions.VPEXTRW_MEMu16_ZMMu16_IMM8_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 16
  let register_size : Int := 512
  let element_size : Int := 16

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Runtime.liftTotal (Effective_Address address_size context mod rm disp8n ip)
  let src : Bits 512 ← Runtime.liftTotal (Read_ZMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg))
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch next_ip0 8)
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset (← Std.Bits.Add_int (n := 64) next_ip0 1)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
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

  Runtime.liftTotal (Next_IP.assign (← Std.Bits.Add_int (n := 64) next_ip0 1))

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Logical_Mem_Write (size := operand_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false)

-- VPEXTRW_GPR32u16_ZMMu16_IMM8_AVX512_1: EVEX.L2.66.0F.WIG C5 /r ib
-- CPUID group: VPINSR_VPEXTR_YMM_ZMM_512
def Instructions.VPEXTRW_GPR32u16_ZMMu16_IMM8_AVX512_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.PartialSpecM Exception (State σ) Unit := do
  let operand_size : Int := 32
  let register_size : Int := 512
  let element_size : Int := 16

  let src : Bits 512 ← Runtime.liftTotal (Read_ZMM (← Calculate_RM mod rm context))
  let imm : Bits 8 ← Runtime.liftTotal (Mem_Fetch ip 8)

  if (not (context.vex_pp == 1 and context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0 and context.evex_aaa == 0)) then
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

  let result : Bits operand_size ← Instructions.Operations.PEXTR operand_size element_size register_size src imm

  Runtime.liftTotal (Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result)

end X86
