-- Generated from data/definitions.xml.gz: Call_More_Privilege; do not edit.
-- Source SHA256: 06d6cc9d5a2aacc50459b352e8983dbcdf1fa0691b6126e3a356444d730c5a0a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Call_More_Privilege)
import X86.Runtime
import X86.Helpers.Push_Parameters
import X86.Helpers.Push_Stack
import X86.Helpers.Registers
import X86.Helpers.Segment
import X86.Helpers.Stack_Switch
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Call_More_Privilege
    (new_cs : Segment) (parameter_count : Bits 5) (stack_access_size : Int) :
    Runtime.SpecM Exception (State σ) (Segment × Bits 64) := do

  let mut (new_ss, new_rsp) ← Stack_Switch new_cs

  -- the stack accesses below should be done at the new CPL

  match stack_access_size with
  | 16 => do
    new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← get).SS.selector false)
    new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 (← Runtime.CheckedSlice.read (← RSP) 0 16) false)
    new_rsp := (← Push_Parameters new_ss new_rsp new_cs parameter_count 16)
  | 32 => do
    new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← Std.Bits.Zero_Extend (source_size := 16) (← get).SS.selector 32) false)
    new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 (← Runtime.CheckedSlice.read (← RSP) 0 32) false)
    new_rsp := (← Push_Parameters new_ss new_rsp new_cs parameter_count 32)
  | 64 => do
    new_rsp := (← Push_Stack new_ss new_rsp new_cs 64 64 (← Std.Bits.Zero_Extend (source_size := 16) (← get).SS.selector 64) false)
    new_rsp := (← Push_Stack new_ss new_rsp new_cs 64 64 (← RSP) false)
  | _ => throw .unmatchedCase

  return (new_ss, new_rsp)

end X86.Helpers
