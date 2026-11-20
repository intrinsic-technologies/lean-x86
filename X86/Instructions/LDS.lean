-- Generated from data/instruction/LDS-LES-LFS-LGS-LSS.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 8c6da2299cb79c88757f0dde59a0555f29e80d1d906eb0e84177e8cf140c8a7c
-- Description: data/sdm/LDS-LES-LFS-LGS-LSS.docbook
-- Loads a far pointer (segment selector and offset) from the second operand (source operand) into
-- a segment register and the first operand (destination operand).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=LDS%2FLES%2FLFS%2FLGS%2FLSS)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Data_Size_Of_Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Execution_Mode
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Load_Data_Segment
import X86.Helpers.Load_Real_Or_VM86_Segment
import X86.Helpers.Load_Stack_Segment
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Seg_Reg
import X86.Helpers.Segment
import X86.Helpers.Segment_Register
import X86.Helpers.Segment_Selector
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Unreachable
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
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.LSS
    (operand_size : Int) (offset : Bits operand_size) (segment_selector : Bits 16) :
    Runtime.SpecM Exception (State σ) (Bits operand_size) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let ss_selector : Segment_Selector := segment_selector

  -- the shared helper handles real/virtual-8086 mode, the 64-bit null-selector
  -- case (permitted when CPL != 3 and RPL == CPL) and the stack-segment type checks
  SS.assign (← Load_Stack_Segment ss_selector (← get).SS (← get).CPL (← get).RFLAGS true)

  let result : Bits operand_size := offset
  return result

def Instructions.Operations.LOAD_FARPTR
    (operand_size : Int) (seg_reg : Seg_Reg) (offset : Bits operand_size) (segment_selector : Bits 16) :
    Runtime.SpecM Exception (State σ) (Bits operand_size) := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let mode : Execution_Mode ← Current_Mode
  match mode with
  | Execution_Mode.Real_Address_Mode => do
    Segment_Register_write seg_reg (← Load_Real_Or_VM86_Segment Execution_Mode.Real_Address_Mode segment_selector (← Segment_Register seg_reg))
  | _ => do

    match mode with
    | Execution_Mode.Virtual_8086_Mode => do
      Segment_Register_write seg_reg (← Load_Real_Or_VM86_Segment Execution_Mode.Virtual_8086_Mode segment_selector (← Segment_Register seg_reg))
    | _ => do

      match mode with
      | Execution_Mode.IA32e_Mode => do
        if (← In_64Bit_Mode) then
          match seg_reg with
          | Seg_Reg.Seg_Reg_DS | Seg_Reg.Seg_Reg_ES => do
            liftM (Report_Invalid_Opcode)
          | Seg_Reg.Seg_Reg_FS | Seg_Reg.Seg_Reg_GS => do
            Segment_Register_write seg_reg (← Load_Data_Segment segment_selector (← Segment_Register seg_reg) (← get).RFLAGS false)
          | _ => do
            Std.Unreachable
        else
          match mode with

          | _ => do
            Segment_Register_write seg_reg (← Load_Data_Segment segment_selector (← Segment_Register seg_reg) (← get).RFLAGS false)
      | _ => do
        match mode with
        | _ => do
          Segment_Register_write seg_reg (← Load_Data_Segment segment_selector (← Segment_Register seg_reg) (← get).RFLAGS false)

  let result : Bits operand_size := offset
  return result

-- LSS_GPRv_MEMp2: 0F B2 /r
def Instructions.LSS_GPRv_MEMp2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let offset : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let segment_selector : Bits 16 ← Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide operand_size 8)) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.LSS operand_size offset segment_selector

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- LFS_GPRv_MEMp2: 0F B4 /r
def Instructions.LFS_GPRv_MEMp2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let seg_reg : Seg_Reg := Seg_Reg.Seg_Reg_FS

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let offset : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let segment_selector : Bits 16 ← Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide operand_size 8)) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.LOAD_FARPTR operand_size seg_reg offset segment_selector

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- LGS_GPRv_MEMp2: 0F B5 /r
def Instructions.LGS_GPRv_MEMp2
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let seg_reg : Seg_Reg := Seg_Reg.Seg_Reg_GS

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let offset : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let segment_selector : Bits 16 ← Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide operand_size 8)) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.LOAD_FARPTR operand_size seg_reg offset segment_selector

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- LES_GPRz_MEMp: C4 /r
def Instructions.LES_GPRz_MEMp
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let seg_reg : Seg_Reg := Seg_Reg.Seg_Reg_ES

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not ((← Data_Size_Of_Current_Mode) != 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  let offset : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let segment_selector : Bits 16 ← Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8)) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.LOAD_FARPTR operand_size seg_reg offset segment_selector

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

-- LDS_GPRz_MEMp: C5 /r
def Instructions.LDS_GPRz_MEMp
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (reg rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size
  let address_size : Int := context.address_size

  let seg_reg : Seg_Reg := Seg_Reg.Seg_Reg_DS

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if (not ((← Data_Size_Of_Current_Mode) != 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  let offset : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  let segment_selector : Bits 16 ← Logical_Mem_Read segment (← Std.Bits.Add_int (n := 64) effective_address (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8)) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  let result : Bits operand_size ← Instructions.Operations.LOAD_FARPTR operand_size seg_reg offset segment_selector

  Write_GPR (size := operand_size) (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_r4 context.rex_r3) reg) result

end X86
