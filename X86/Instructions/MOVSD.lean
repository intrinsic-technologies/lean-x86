-- Generated from data/instruction/MOVSD.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: f2443f1d86c93c10caf73a7a0c1d47a0dbdc2925f2c0c1b30fae5628fc35a62e
-- Description: data/sdm/MOVSD.docbook
-- Moves a scalar double precision floating-point value from the source operand (second operand) to
-- the destination operand (first operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=MOVSD)
import X86.Runtime
import X86.Helpers.Calculate_RM
import X86.Helpers.Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Effective_Segment
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Masked_Vector_Mem_Write
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Read_Mask
import X86.Helpers.Read_XMM
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Report_Not_Available_Exception
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Write_RDI
import X86.Helpers.Write_RSI
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
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.MOVS_load
    (element_size : Int) (register_size : Int) (src : Bits element_size) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (element_size == 32 || element_size == 64)
  Runtime.assert (register_size == 128)

  let result : Bits register_size ← Std.Bits.Zero_Extend (source_size := element_size) src register_size
  return result

def Instructions.Operations.MOVS_reg
    (element_size : Int) (register_size : Int) (src1 src2 : Bits register_size) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (register_size == 128)
  Runtime.assert (element_size == 32 || element_size == 64)

  let mut result : Bits register_size := src1
  Runtime.assert (decide (element_size ≤ register_size))
  result := (← setSliceChecked result 0 element_size (← src2[0 +: element_size]))
  return result

def Instructions.Operations.MOVS_store
    (element_size : Int) (register_size : Int) (src : Bits register_size) :
    Except (Runtime.Error Empty) (Bits element_size) := do
  Runtime.assert (element_size == 32 || element_size == 64)
  Runtime.assert (register_size == 128)

  let mut result : Bits element_size ← src[0 +: element_size]
  return result

def Instructions.Operations.MOV_STRING
    (address_size : Int) (operand_size : Int) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let effective_segment1 : Segment ← Get_Effective_Segment context (← get).DS
  let effective_segment2 : Segment ← do
    if (← In_64Bit_Mode) then
      Null_Segment (← get).ES
    else
      pure (← get).ES

  let effective_address1 : Bits 64 ← Std.Bits.Zero_Extend (source_size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RSI) 0 address_size))) 64
  let effective_address2 : Bits 64 ← Std.Bits.Zero_Extend (source_size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RDI) 0 address_size))) 64

  let data : Bits operand_size ← Logical_Mem_Read effective_segment1 effective_address1 operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  Logical_Mem_Write (size := operand_size) effective_segment2 effective_address2 data Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

  let size_in_bytes : Int ← Std.Integer.Positive_Divide operand_size 8
  let address_increment : Int ← do
    if (← RFLAGS.DF) == 0 then
      pure size_in_bytes
    else
      pure (- size_in_bytes)
  Write_RSI (size := address_size) (← Std.Bits.Add_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RSI) 0 address_size))) address_increment)
  Write_RDI (size := address_size) (← Std.Bits.Add_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RDI) 0 address_size))) address_increment)

def Instructions.Operations.VMOVS_load
    (element_size : Int) (register_size : Int) (old : Bits register_size) (k : Bits 64) (src : Bits element_size) (context : Instruction_Context) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (element_size == 32 || element_size == 64)
  Runtime.assert (register_size == 128)

  let result : Bits register_size ← do
    if (← k[0 +: 1]) == 1 then
      Std.Bits.Zero_Extend (source_size := element_size) src register_size
    else
      if context.evex_z == 1 then
        Std.Bits.Zero register_size
      else
        Std.Bits.Zero_Extend (source_size := element_size) (← old[0 +: element_size]) register_size
  return result

def Instructions.Operations.VMOVS_reg
    (element_size : Int) (register_size : Int) (old : Bits register_size) (k : Bits 64) (src1 src2 : Bits register_size) (context : Instruction_Context) :
    Except (Runtime.Error Empty) (Bits register_size) := do
  Runtime.assert (register_size == 128)
  Runtime.assert (element_size == 32 || element_size == 64)

  let mut result : Bits register_size := src1
  if ((← k[0 +: 1]) == 1) then
    Runtime.assert (decide (element_size ≤ register_size))
    result := (← setSliceChecked result 0 element_size (← src2[0 +: element_size]))
  else
    if (context.evex_z == 1) then
      Runtime.assert (decide (element_size ≤ register_size))
      result := (← setSliceChecked result 0 element_size (← Std.Bits.Zero element_size))
    else
      Runtime.assert (decide (element_size ≤ register_size))
      result := (← setSliceChecked result 0 element_size (← old[0 +: element_size]))
  return result

def Instructions.Operations.VMOVS_store
    (element_size : Int) (register_size : Int) (k : Bits 64) (src : Bits register_size) :
    Except (Runtime.Error Empty) (Bits element_size) := do
  Runtime.assert (element_size == 32 || element_size == 64)
  Runtime.assert (register_size == 128)

  let result : Bits element_size ← do
    if (← k[0 +: 1]) == 1 then
      src[0 +: element_size]
    else
      Std.Bits.Zero element_size
  return result

-- MOVSD_XMM_XMMdq_MEMsd_0: F2 0F 10 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_XMMdq_MEMsd_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let element_size : Int := 64
  let register_size : Int := 128

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MOVS_load element_size register_size src

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- MOVSD_XMM_XMMdq_MEMsd_1: F2 0F 10 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_XMMdq_MEMsd_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let element_size : Int := 64
  let register_size : Int := 128

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

  let src : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MOVS_load element_size register_size src

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- MOVSD_XMM_XMMdq_MEMsd_2: F2 0F 10 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_XMMdq_MEMsd_2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let element_size : Int := 64
  let register_size : Int := 128

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

  let src : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MOVS_load element_size register_size src

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- MOVSD_XMM_XMMdq_MEMsd_3: F2 0F 10 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_XMMdq_MEMsd_3
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let element_size : Int := 64
  let register_size : Int := 128

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

  let src : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MOVS_load element_size register_size src

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- MOVSD_XMM_XMMdq_MEMsd_4: F2 0F 10 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_XMMdq_MEMsd_4
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let element_size : Int := 64
  let register_size : Int := 128

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

  let src : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MOVS_load element_size register_size src

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- MOVSD_XMM_XMMsd_XMMsd_0F10: F2 0F 10 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_XMMsd_XMMsd_0F10
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 64

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.MOVS_reg element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMOVSD_XMMdq_MEMq_0: VEX.LIG.F2.0F.WIG 10 /r
-- CPUID group: AVX
def Instructions.VMOVSD_XMMdq_MEMq_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let element_size : Int := 64
  let register_size : Int := 128

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MOVS_load element_size register_size src

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMOVSD_XMMdq_MEMq_1: VEX.LIG.F2.0F.WIG 10 /r
-- CPUID group: AVX
def Instructions.VMOVSD_XMMdq_MEMq_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let element_size : Int := 64
  let register_size : Int := 128

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

  let src : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MOVS_load element_size register_size src

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMOVSD_XMMdq_MEMq_2: VEX.LIG.F2.0F.WIG 10 /r
-- CPUID group: AVX
def Instructions.VMOVSD_XMMdq_MEMq_2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let element_size : Int := 64
  let register_size : Int := 128

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

  let src : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MOVS_load element_size register_size src

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMOVSD_XMMdq_MEMq_3: VEX.LIG.F2.0F.WIG 10 /r
-- CPUID group: AVX
def Instructions.VMOVSD_XMMdq_MEMq_3
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let element_size : Int := 64
  let register_size : Int := 128

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

  let src : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MOVS_load element_size register_size src

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMOVSD_XMMdq_MEMq_4: VEX.LIG.F2.0F.WIG 10 /r
-- CPUID group: AVX
def Instructions.VMOVSD_XMMdq_MEMq_4
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let element_size : Int := 64
  let register_size : Int := 128

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

  let src : Bits element_size ← Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.MOVS_load element_size register_size src

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMOVSD_MEMq_XMMq_0: VEX.LIG.F2.0F.WIG 11 /r
-- CPUID group: AVX
def Instructions.VMOVSD_MEMq_XMMq_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits element_size ← Instructions.Operations.MOVS_store element_size register_size src

  Logical_Mem_Write (size := element_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- VMOVSD_MEMq_XMMq_1: VEX.LIG.F2.0F.WIG 11 /r
-- CPUID group: AVX
def Instructions.VMOVSD_MEMq_XMMq_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
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

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits element_size ← Instructions.Operations.MOVS_store element_size register_size src

  Logical_Mem_Write (size := element_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- VMOVSD_MEMq_XMMq_2: VEX.LIG.F2.0F.WIG 11 /r
-- CPUID group: AVX
def Instructions.VMOVSD_MEMq_XMMq_2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
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

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits element_size ← Instructions.Operations.MOVS_store element_size register_size src

  Logical_Mem_Write (size := element_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- VMOVSD_MEMq_XMMq_3: VEX.LIG.F2.0F.WIG 11 /r
-- CPUID group: AVX
def Instructions.VMOVSD_MEMq_XMMq_3
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
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

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits element_size ← Instructions.Operations.MOVS_store element_size register_size src

  Logical_Mem_Write (size := element_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- VMOVSD_MEMq_XMMq_4: VEX.LIG.F2.0F.WIG 11 /r
-- CPUID group: AVX
def Instructions.VMOVSD_MEMq_XMMq_4
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
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

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits element_size ← Instructions.Operations.MOVS_store element_size register_size src

  Logical_Mem_Write (size := element_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- MOVSD_XMM_XMMsd_XMMsd_0F11: F2 0F 11 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_XMMsd_XMMsd_0F11
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 64

  let src1 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let src2 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.MOVS_reg element_size register_size src1 src2

  Write_XMM (size := register_size) (← Calculate_RM mod rm context) result (context.vex_prefix_present or context.evex_prefix_present)

-- MOVSD_XMM_MEMsd_XMMsd_0: F2 0F 11 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_MEMsd_XMMsd_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits element_size ← Instructions.Operations.MOVS_store element_size register_size src

  Logical_Mem_Write (size := element_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- MOVSD_XMM_MEMsd_XMMsd_1: F2 0F 11 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_MEMsd_XMMsd_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits element_size ← Instructions.Operations.MOVS_store element_size register_size src

  Logical_Mem_Write (size := element_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- MOVSD_XMM_MEMsd_XMMsd_2: F2 0F 11 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_MEMsd_XMMsd_2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits element_size ← Instructions.Operations.MOVS_store element_size register_size src

  Logical_Mem_Write (size := element_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- MOVSD_XMM_MEMsd_XMMsd_3: F2 0F 11 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_MEMsd_XMMsd_3
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits element_size ← Instructions.Operations.MOVS_store element_size register_size src

  Logical_Mem_Write (size := element_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- MOVSD_XMM_MEMsd_XMMsd_4: F2 0F 11 /r
-- CPUID group: SSE2
def Instructions.MOVSD_XMM_MEMsd_XMMsd_4
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let src : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSFXSR) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.EM) == 1) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits element_size ← Instructions.Operations.MOVS_store element_size register_size src

  Logical_Mem_Write (size := element_size) segment effective_address result Memory_Alignment_Type.Normal_Alignment false false Memory_Type.Memory_Type_Unknown false

-- VMOVSD_XMMdq_XMMdq_XMMq_10: VEX.LIG.F2.0F.WIG 10 /r
-- CPUID group: AVX
def Instructions.VMOVSD_XMMdq_XMMdq_XMMq_10
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 64

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

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

  let result : Bits register_size ← Instructions.Operations.MOVS_reg element_size register_size src1 src2

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMOVSD_XMMdq_XMMdq_XMMq_11: VEX.LIG.F2.0F.WIG 11 /r
-- CPUID group: AVX
def Instructions.VMOVSD_XMMdq_XMMdq_XMMq_11
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 64

  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size

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

  let result : Bits register_size ← Instructions.Operations.MOVS_reg element_size register_size src1 src2

  Write_XMM (size := register_size) (← Calculate_RM mod rm context) result (context.vex_prefix_present or context.evex_prefix_present)

-- MOVSD_0: NFx A5
def Instructions.MOVSD_0
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.MOV_STRING address_size operand_size context

-- MOVSD_1: NP A5
def Instructions.MOVSD_1
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.MOV_STRING address_size operand_size context

-- MOVSD_2: NP A5
def Instructions.MOVSD_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 32

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  if context.osz_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.MOV_STRING address_size operand_size context

-- VMOVSD_XMMf64_MASKmskw_MEMf64_AVX512: EVEX.128.F2.0F.W1 10 /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VMOVSD_XMMf64_MASKmskw_MEMf64_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  let src : Bits element_size ← do
    if (← k[0 +: 1]) == 1 then
      Logical_Mem_Read segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
    else
      Std.Bits.Zero element_size
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits register_size ← Instructions.Operations.VMOVS_load element_size register_size old k src context

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMOVSD_XMMf64_MASKmskw_XMMf64_XMMf64_AVX512_0: EVEX.128.F2.0F.W1 10 /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VMOVSD_XMMf64_MASKmskw_XMMf64_XMMf64_AVX512_0
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 64

  let old : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size

  if (not (context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.VMOVS_reg element_size register_size old k src1 src2 context

  Write_XMM (size := register_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result (context.vex_prefix_present or context.evex_prefix_present)

-- VMOVSD_MEMf64_MASKmskw_XMMf64_AVX512: EVEX.128.F2.0F.W1 11 /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VMOVSD_MEMf64_MASKmskw_XMMf64_AVX512
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let register_size : Int := 128
  let element_size : Int := 64

  let disp8n : Int ← Std.Integer.Positive_Divide element_size 8
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not (context.evex_b == 0 and ~~~ (← context.vvvv[3 +: 1]) == 1 and ~~~ (← context.vvvv[2:0]) == 7 and context.evex_v4 == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := next_ip0 })

  let result : Bits element_size ← Instructions.Operations.VMOVS_store element_size register_size k src

  Masked_Vector_Mem_Write element_size element_size k segment effective_address result true

-- VMOVSD_XMMf64_MASKmskw_XMMf64_XMMf64_AVX512_1: EVEX.128.F2.0F.W1 11 /r
-- CPUID group: AVX512F_SCALAR or AVX512F_SCALAR_AVX10
def Instructions.VMOVSD_XMMf64_MASKmskw_XMMf64_XMMf64_AVX512_1
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let register_size : Int := 128
  let element_size : Int := 64

  let old : Bits register_size ← Read_XMM (← Calculate_RM mod rm context) register_size
  let k : Bits 64 ← Read_Mask context.evex_aaa
  let src1 : Bits register_size ← Read_XMM (← concatBits (leftSize := 1) (rightSize := 4) context.evex_v4 context.vvvv) register_size
  let src2 : Bits register_size ← Read_XMM (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) register_size

  if (not (context.evex_b == 0)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode or (← Current_Mode) == Execution_Mode.Virtual_8086_Mode) then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.OSXSAVE) == 0) then
    liftM (Report_Invalid_Opcode)

  if ((← sliceInclusive (← get).XCR0 2 1) != 3) then
    liftM (Report_Invalid_Opcode)

  if ((← CR0.TS) == 1) then
    liftM (Report_Not_Available_Exception)

  modify ({ · with Next_IP := ip })

  let result : Bits register_size ← Instructions.Operations.VMOVS_reg element_size register_size old k src1 src2 context

  Write_XMM (size := register_size) (← Calculate_RM mod rm context) result (context.vex_prefix_present or context.evex_prefix_present)

end X86
