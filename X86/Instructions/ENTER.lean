-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 80cfe5459b964ff23a8b1d2bb1b5c1c5acbeac98e8358e12989b1da1c886750b
-- Creates a stack frame (comprising of space for dynamic storage and 1-32 frame pointer storage)
-- for a procedure.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=ENTER)
import X86.Runtime
import X86.Helpers.Check_Logical_Address_Is_Writable
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Mem_Fetch
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Push_Stack
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Stack_Address_Size
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.Helpers.Write_RBP
import X86.Helpers.Write_RSP
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

def Instructions.Operations.ENTER
    (operand_size stack_address_size : Int) (src1 : Bits 16) (src2 : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)
  Runtime.assert (stack_address_size == 16 || stack_address_size == 32 || stack_address_size == 64)

  let nesting_level : Int ← Std.Integer.Positive_Remainder (Unsigned src2) 32

  let mut new_rsp : Bits 64 ← Push_Stack (← get).SS (← RSP) (← get).CS operand_size operand_size (← (do Runtime.assert (decide (operand_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RBP) 0 operand_size))) false
  let frame_temp : Bits 64 ← Std.Bits.Zero_Extend (source_size := operand_size) (← new_rsp[0 +: operand_size]) 64

  if (decide (nesting_level > 0)) then
    let mut new_rbp : Bits 64 ← RBP

    for _i in intRange (1 : Int) (nesting_level - 1) do
      new_rbp := (← Std.Bits.Zero_Extend (source_size := stack_address_size) (← Std.Bits.Subtract_int (n := stack_address_size) (← new_rbp[0 +: stack_address_size]) (← Std.Integer.Positive_Divide operand_size 8)) 64)
      let curr_frame : Bits operand_size ← Logical_Mem_Read (← get).SS (← Std.Bits.Zero_Extend (source_size := stack_address_size) (← new_rbp[0 +: stack_address_size]) 64) operand_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
      new_rsp := (← Push_Stack (← get).SS new_rsp (← get).CS operand_size operand_size curr_frame false)

    new_rsp := (← Push_Stack (← get).SS new_rsp (← get).CS operand_size operand_size (← frame_temp[0 +: operand_size]) false)

  let alloc_size : Bits 64 ← Std.Bits.Zero_Extend (source_size := 16) src1 64
  new_rsp := new_rsp - alloc_size

  Check_Logical_Address_Is_Writable (← get).SS (← Std.Bits.Zero_Extend (source_size := stack_address_size) (← new_rsp[0 +: stack_address_size]) 64) operand_size Memory_Alignment_Type.Normal_Alignment

  Write_RBP (size := operand_size) (← frame_temp[0 +: operand_size])
  if (← In_64Bit_Mode) then
    Write_RSP (size := 64) new_rsp
  else
    Write_RSP (size := stack_address_size) (← new_rsp[0 +: stack_address_size])

-- ENTER_IMMw_IMMb: C8 iw
def Instructions.ENTER_IMMw_IMMb
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64
  let stack_address_size : Int ← Stack_Address_Size (← get).SS

  let src1 : Bits 16 ← Mem_Fetch ip 16
  let src2 : Bits 8 ← Mem_Fetch (← Std.Bits.Add_int (n := 64) ip 2) 8

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 3)

  Instructions.Operations.ENTER operand_size stack_address_size src1 src2

end X86
