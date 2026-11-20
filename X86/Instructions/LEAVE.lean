-- Generated from data/instruction/LEAVE.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 0f496d5e0c3df5e2b55a9d89ea08973c202fa487b10550d8b4fbd7a9b054f903
-- Description: data/sdm/LEAVE.docbook
-- Releases the stack frame set up by an earlier ENTER instruction.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=LEAVE)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Pop_Stack
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Stack_Address_Size
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Unreachable
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
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Instructions.Operations.LEAVE
    (operand_size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 16 || operand_size == 32 || operand_size == 64)

  let (new_rbp, _) ← Pop_Stack (← get).SS (← RBP) operand_size operand_size

  let stack_address_size : Int ← Stack_Address_Size (← get).SS
  match stack_address_size with
  | 64 => do
    Write_RSP (size := 64) (← Std.Bits.Add_int (n := 64) (← RBP) (← Std.Integer.Positive_Divide operand_size 8))
  | 32 => do
    Write_RSP (size := 32) (← Std.Bits.Add_int (n := 32) (← Runtime.CheckedSlice.read (← RBP) 0 32) (← Std.Integer.Positive_Divide operand_size 8))
  | 16 => do
    Write_RSP (size := 16) (← Std.Bits.Add_int (n := 16) (← Runtime.CheckedSlice.read (← RBP) 0 16) (← Std.Integer.Positive_Divide operand_size 8))
  | _ => do
    Std.Unreachable

  Write_RBP (size := operand_size) new_rbp

-- LEAVE: C9
def Instructions.LEAVE
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let operand_size : Int := if not context.is_mode64 then context.operand_size else if context.rex_w == 1 then 64 else if context.osz_prefix_present then 16 else 64

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.LEAVE operand_size

end X86
