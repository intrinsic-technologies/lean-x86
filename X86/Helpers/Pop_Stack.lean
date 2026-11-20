-- Generated from data/definitions.xml.gz: Pop_Stack; do not edit.
-- Source SHA256: 15c13b1d29d787216dd685907b55cc28a740aa1856a5f004747abb89e3c55d04
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Pop_Stack)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Segment
import X86.Helpers.Stack_Address_Size
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Positive_Divide
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
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Pop_Stack
    (stack_segment : Segment) (old_rsp : Bits 64) (size pop_size : Int) :
    Runtime.SpecM Exception (State σ) (Bits size × Bits 64) := do
  Runtime.assert (0 ≤ size)

  Runtime.assert ((size == (16 : Int)) || (size == (32 : Int)) || (size == (64 : Int)))
  Runtime.assert ((pop_size == (16 : Int)) || (pop_size == (32 : Int)) || (pop_size == (64 : Int)))
  Runtime.assert (← Runtime.readInitialized stack_segment.is_stack)

  let stack_address_size : Int ← Stack_Address_Size stack_segment
  let size_in_bytes : Int ← Std.Integer.Positive_Divide pop_size 8

  -- no segmentation in 64-bit mode
  let effective_segment : Segment ← do
    if (← In_64Bit_Mode) then
      Null_Segment stack_segment
    else
      pure stack_segment
  let effective_address : Bits 64 ← Std.Bits.Zero_Extend (source_size := stack_address_size) (← old_rsp[0 +: stack_address_size]) 64
  let result : Bits size ← Logical_Mem_Read effective_segment effective_address size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false

  let next_sp : Bits 64 ← Std.Bits.Add_int (n := 64) old_rsp size_in_bytes
  let new_rsp : Bits 64 ← do
    if stack_address_size == 16 then
      concatBits (leftSize := 48) (rightSize := 16) (← old_rsp[63:16]) (← next_sp[15:0])
    else
      Std.Bits.Zero_Extend (source_size := stack_address_size) (← next_sp[0 +: stack_address_size]) 64
  return (result, new_rsp)

end X86.Helpers
