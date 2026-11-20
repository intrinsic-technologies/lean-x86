-- Generated from a local ISA specification; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: cdd2038a6232c2bc876c3821af767157aeffe3cf270bfcea37e020e5e0204975
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=CMPS)
import X86.Runtime
import X86.Helpers.Address_Size
import X86.Helpers.Emulate_Compare_Memory_Operands
import X86.Helpers.Get_Effective_Segment
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Null_Segment
import X86.Helpers.Registers
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Write_RCX
import X86.Helpers.Write_RDI
import X86.Helpers.Write_RSI
import X86.Instructions.CMP
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
  [X86.Helpers.Select_Compare_Memory_Fault.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Order.Binding σ]
  [X86.Helpers.Select_Compare_Memory_Probe.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

-- Intel's executable XML omits CMPS. SDM Vol. 2, CMPS and REP/REPE/REPNE
-- define these operations. Reuse Intel's comparison and memory/register helpers.
-- A repeated instruction performs one comparison per Step.
def Instructions.Operations.COMPARE_STRING
    (operand_size : Int) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  let address_size : Int ← Address_Size context
  let source_segment : Segment ← Get_Effective_Segment context (← get).DS
  let destination_segment : Segment ← do
    if (← In_64Bit_Mode) then
      Null_Segment (← get).ES
    else
      pure (← get).ES
  let source : Bits 64 ← Std.Bits.Zero_Extend (source_size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RSI) 0 address_size))) 64
  let destination : Bits 64 ← Std.Bits.Zero_Extend (source_size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RDI) 0 address_size))) 64
  let (left, right) ← Emulate_Compare_Memory_Operands operand_size source_segment source destination_segment destination
  Instructions.Operations.CMP operand_size left right
  let increment : Int ← do
    if (← RFLAGS.DF) == 0 then
      Std.Integer.Positive_Divide operand_size 8
    else
      pure (- (← Std.Integer.Positive_Divide operand_size 8))
  Write_RSI (size := address_size) (← Std.Bits.Add_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RSI) 0 address_size))) increment)
  Write_RDI (size := address_size) (← Std.Bits.Add_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RDI) 0 address_size))) increment)

def Instructions.Compare_String
    (ip : Bits 64) (context : Instruction_Context) (operand_size : Int) (repeated while_equal : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (operand_size == 8 || operand_size == 16 || operand_size == 32 || operand_size == 64)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  modify ({ · with Repeat_String_Operation := false })
  let address_size : Int ← Address_Size context
  if (repeated and (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))))) then
    return ()
  let old_flags : RFLAGS_Type := (← get).RFLAGS
  Instructions.Operations.COMPARE_STRING operand_size context
  if repeated then
    Write_RCX (size := address_size) (← Std.Bits.Subtract_int (n := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size))) 1)
    let «continue» : Bool := not (← Std.Bits.Is_Zero (size := address_size) (← (do Runtime.assert (decide (address_size ≤ 64)); Runtime.assert (decide (0 ≤ address_size)); pure (← Runtime.CheckedSlice.read (← RCX) 0 address_size)))) and ((← RFLAGS.ZF) == 1) == while_equal
    modify ({ · with Repeat_String_Operation := «continue» })
    -- Preserve entry flags until the final comparison. A later fault can
    -- restart at the updated indices/count with the original flags.
    if «continue» then
      modify ({ · with RFLAGS := old_flags })

def Instructions.CMPSB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 8 false true

def Instructions.CMPSW
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 16 false true

def Instructions.CMPSD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 32 false true

def Instructions.CMPSQ
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 64 false true

def Instructions.REPE_CMPSB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 8 true true

def Instructions.REPE_CMPSW
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 16 true true

def Instructions.REPE_CMPSD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 32 true true

def Instructions.REPE_CMPSQ
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 64 true true

def Instructions.REPNE_CMPSB
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 8 true false

def Instructions.REPNE_CMPSW
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 16 true false

def Instructions.REPNE_CMPSD
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 32 true false

def Instructions.REPNE_CMPSQ
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Instructions.Compare_String ip context 64 true false

end X86
