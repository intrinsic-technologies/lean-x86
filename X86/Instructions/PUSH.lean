-- Generated from data/instruction/PUSH.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 4fa2bb18f022ed79f561526a369e4545bbb0848f9e2fa27f14164d9ed7c35226
-- Description: data/sdm/PUSH.docbook
-- Decrements the stack pointer and then stores the source operand on the top of the stack.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=PUSH)
import X86.Runtime
import X86.Helpers.Data_Size_Of_Current_Mode
import X86.Helpers.Effective_Address
import X86.Helpers.Handle_RIP_Relative_Address
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Push_Stack
import X86.Helpers.Read_GPR
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Segment_Selector
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Std.Integer.Positive_Divide
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

def Instructions.Operations.PUSH
    (operand_size : Int) (src : Bits operand_size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let new_rsp : Bits 64 ← Push_Stack (← get).SS (← RSP) (← get).CS operand_size operand_size src false
  RSP_write new_rsp

def Instructions.Operations.PUSH_SEG
    (operand_size : Int) (src : Bits 16) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let new_rsp : Bits 64 ← do
    if (← In_64Bit_Mode) and operand_size == 64 then
      Push_Stack (← get).SS (← RSP) (← get).CS 64 64 (← Std.Bits.Zero_Extend (source_size := 16) src 64) true
    else
      Push_Stack (← get).SS (← RSP) (← get).CS 16 operand_size src false
  RSP_write new_rsp

-- PUSH_IMMb: 6A ib
def Instructions.PUSH_IMMb
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.PUSH operand_size src

-- PUSH_IMMz: 68 iz
def Instructions.PUSH_IMMz
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := (Std.Integer.Min operand_size 32)) (← Mem_Fetch ip (Std.Integer.Min operand_size 32)) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip (← Std.Integer.Positive_Divide (Std.Integer.Min operand_size 32) 8))

  Instructions.Operations.PUSH operand_size src

-- PUSH_ES: 06
def Instructions.PUSH_ES
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src : Segment_Selector := (← get).ES.selector

  if (not ((← Data_Size_Of_Current_Mode) != 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSH_SEG operand_size src

-- PUSH_CS: 0E
def Instructions.PUSH_CS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src : Segment_Selector := (← get).CS.selector

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSH_SEG operand_size src

-- PUSH_SS: 16
def Instructions.PUSH_SS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src : Segment_Selector := (← get).SS.selector

  if (not ((← Data_Size_Of_Current_Mode) != 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSH_SEG operand_size src

-- PUSH_DS: 1E
def Instructions.PUSH_DS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := context.operand_size

  let src : Segment_Selector := (← get).DS.selector

  if (not ((← Data_Size_Of_Current_Mode) != 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (← In_64Bit_Mode) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSH_SEG operand_size src

-- PUSH_GPRv_50_0: 50+r
def Instructions.PUSH_GPRv_50_0
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSH operand_size src

-- PUSH_GPRv_50_1: 50+r
def Instructions.PUSH_GPRv_50_1
    (ip : Bits 64) (context : Instruction_Context) (opcode : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) (← opcode[2:0])) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (context.rex_w == 1) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSH operand_size src

-- PUSH_FS: 0F A0
def Instructions.PUSH_FS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  let src : Segment_Selector := (← get).FS.selector

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSH_SEG operand_size src

-- PUSH_GS: 0F A8
def Instructions.PUSH_GS
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  let src : Segment_Selector := (← get).GS.selector

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSH_SEG operand_size src

-- PUSH_GPRv_FFr6: FF /6
def Instructions.PUSH_GPRv_FFr6
    (ip : Bits 64) (context : Instruction_Context) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  let src : Bits operand_size ← Read_GPR (← concatBits (leftSize := 2) (rightSize := 3) (← concatBits (leftSize := 1) (rightSize := 1) context.rex_b4 context.rex_b3) rm) operand_size

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.PUSH operand_size src

-- PUSH_MEMv: FF /6
def Instructions.PUSH_MEMv
    (ip : Bits 64) (context : Instruction_Context) (mod : Bits 2) (rm : Bits 3) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64
  let address_size : Int := context.address_size

  let disp8n : Int := 1
  let (ea_offset, segment, next_ip0, is_rip_relative, _base_uses_rsp) ← Effective_Address address_size context mod rm disp8n ip
  let effective_address : Bits 64 ← Handle_RIP_Relative_Address address_size is_rip_relative ea_offset next_ip0

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  let src : Bits operand_size ← Logical_Mem_Read segment effective_address operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
  modify ({ · with Next_IP := next_ip0 })

  Instructions.Operations.PUSH operand_size src

end X86
