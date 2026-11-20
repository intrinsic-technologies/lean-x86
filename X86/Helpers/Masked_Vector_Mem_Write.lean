-- Generated from data/definitions.xml.gz: Masked_Vector_Mem_Write; do not edit.
-- Source SHA256: c726a0ae6d14d50cea522d70b00caf58f1bf41f045b0303d785b3ffcd1b69ff7
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Masked_Vector_Mem_Write)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Alignment
import X86.Helpers.Check_Data_Write_Breakpoint
import X86.Helpers.Check_Logical_Address_Is_Writable
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Is_Alignment_Checking_Enabled
import X86.Helpers.Logical_Mem_Write
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Memory_Type
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Count_Leading_Zero_Bits
import X86.Helpers.Std.Bits.Count_Trailing_Zero_Bits
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Translate_Linear_To_Physical
import X86.Helpers.Translate_Logical_To_Linear
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Masked_Vector_Mem_Write
    (size element_size : Int) (k : Bits 64) (ea_segment : Segment) (effective_address : Bits 64) (value : Bits size) (fault_suppression : Bool) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  Runtime.assert ((size == (16 : Int)) || (size == (32 : Int)) || (size == (64 : Int)) || (size == (128 : Int)) || (size == (256 : Int)) || (size == (512 : Int)))
  Runtime.assert ((element_size == (8 : Int)) || (element_size == (16 : Int)) || (element_size == (32 : Int)) || (element_size == (64 : Int)))
  let elements : Int ← Std.Integer.Positive_Divide size element_size

  if (not (← Std.Bits.Is_Zero (size := elements) (← k[0 +: elements])) or not fault_suppression) then
    -- ensure that all unmasked values are writable before performing any of the writes
    -- this is done by checking the lowest byte of the lowest unmasked element and the
    -- highest byte of the highest unmasked element before beginning any of the writes
    let lowest_unmasked_byte : Int := (← Std.Bits.Count_Trailing_Zero_Bits (size := elements) (← k[0 +: elements])) * (← Std.Integer.Positive_Divide element_size 8)
    Check_Logical_Address_Is_Writable ea_segment (effective_address + (← lowest_unmasked_byte[0 +: 64])) 8 Memory_Alignment_Type.Normal_Alignment
    let highest_unmasked_bit : Int := elements - 1 - (← Std.Bits.Count_Leading_Zero_Bits (size := elements) (← k[0 +: elements]))
    let highest_unmasked_byte : Int := highest_unmasked_bit * (← Std.Integer.Positive_Divide element_size 8) + (← Std.Integer.Positive_Divide element_size 8) - 1
    Check_Logical_Address_Is_Writable ea_segment (effective_address + (← highest_unmasked_byte[0 +: 64])) 8 Memory_Alignment_Type.Normal_Alignment

    if ((← Is_Alignment_Checking_Enabled) and decide (size ≤ 64)) then
      -- check alignment on the memory size, not the element size
      Check_Alignment (← Compute_Linear_Address ea_segment effective_address (← get).CS) (← Std.Integer.Positive_Divide size 8)

    for i in intRange (0 : Int) (elements - 1) do
      if ((← k[i +: 1]) == 1) then
        Logical_Mem_Write (size := element_size) ea_segment (← Std.Bits.Add_int (n := 64) effective_address (i * (← Std.Integer.Positive_Divide element_size 8))) (← (do Runtime.assert (decide (i * element_size ≤ size - element_size)); Runtime.assert (decide (0 ≤ element_size)); pure (← value[i *: element_size]))) Memory_Alignment_Type.Explicitly_Unaligned false false Memory_Type.Memory_Type_Unknown false
      else
        if (not fault_suppression) then
          -- perform the address translation, but do not store to the address
          let logical : Address_Translation ← Create_Logical_Address ea_segment (← Std.Bits.Add_int (n := 64) effective_address (i * (← Std.Integer.Positive_Divide element_size 8))) element_size
          let linear : Address_Translation ← Translate_Logical_To_Linear logical Memory_Alignment_Type.Explicitly_Unaligned (← get).CS false
          Check_Data_Write_Breakpoint linear.linear_address linear.num_bytes
          let _ ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Write

end X86.Helpers
