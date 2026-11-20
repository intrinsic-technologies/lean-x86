-- Generated from data/instruction/LOOP-LOOPcc.xml: selected operations and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: 959ec8dd3abedeb11f84e0b80d9a59f02335fb421f015d11a8f2bbd5d42fe499
-- Description: data/sdm/LOOP-LOOPcc.docbook
-- Performs a loop operation using the RCX, ECX or CX register as a counter (depending on whether
-- address size is 64 bits, 32 bits, or 16 bits).
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=LOOP%2FLOOPcc)
import X86.Runtime
import X86.Helpers.Branch_Near
import X86.Helpers.Check_New_RIP
import X86.Helpers.Instruction_Context
import X86.Helpers.Instruction_Loop_Type
import X86.Helpers.Mem_Fetch
import X86.Helpers.Registers
import X86.Helpers.Relative_Branch_Wrap
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Sign_Extend
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Write_RCX
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.__Physical_Mem_Fetch.Binding σ]
  [X86.__Trace_Physical_Mem.Binding σ]
  [X86.Config.Value.MODEP5]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]
  [X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ))]

def Instructions.Operations.LOOP
    (instruction : Instruction_Loop_Type) (address_size : Int) (operand_size : Int) (context : Instruction_Context) (src : Bits operand_size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ operand_size)
  Runtime.assert (address_size == 16 || address_size == 32 || address_size == 64)

  let count : Bits address_size ← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1
  let mut take_branch : Bool ←
    match instruction with
    | Instruction_Loop_Type.LOOP => do
      pure (not (← Std.Bits.Is_Zero (size := address_size) count))
    | Instruction_Loop_Type.LOOPE => do
      pure (not (← Std.Bits.Is_Zero (size := address_size) count) and (← RFLAGS.ZF) == 1)
    | Instruction_Loop_Type.LOOPNE => do
      pure (not (← Std.Bits.Is_Zero (size := address_size) count) and (← RFLAGS.ZF) == 0)

  if take_branch then
    let new_rip : Bits 64 ← Relative_Branch_Wrap context.operand_size ((← get).Next_IP + (← Std.Bits.Sign_Extend (source_size := operand_size) src 64))
    Check_New_RIP (← get).CS new_rip
    Branch_Near new_rip

  Write_RCX (size := address_size) count

-- LOOPNE_RELBRb_2: E0 cb
def Instructions.LOOPNE_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8
  let instruction : Instruction_Loop_Type := Instruction_Loop_Type.LOOPNE

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not (← Config.Read.MODEP5 (exception := Exception)) and not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.LOOP instruction address_size operand_size context src

-- LOOPE_RELBRb_2: E1 cb
def Instructions.LOOPE_RELBRb_2
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8
  let instruction : Instruction_Loop_Type := Instruction_Loop_Type.LOOPE

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not (← Config.Read.MODEP5 (exception := Exception)) and not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.LOOP instruction address_size operand_size context src

-- LOOP_RELBRb: E2 cb
def Instructions.LOOP_RELBRb
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let address_size : Int := context.address_size

  let operand_size : Int := 8
  let instruction : Instruction_Loop_Type := Instruction_Loop_Type.LOOP

  let src : Bits operand_size ← Std.Bits.Sign_Extend (source_size := 8) (← Mem_Fetch ip 8) operand_size

  if (not (not context.rex2_prefix_present)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  Next_IP.assign (← Std.Bits.Add_int (n := 64) ip 1)

  Instructions.Operations.LOOP instruction address_size operand_size context src

end X86
