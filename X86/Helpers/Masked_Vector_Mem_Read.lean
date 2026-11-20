-- Generated from data/definitions.xml.gz: Masked_Vector_Mem_Read; do not edit.
-- Source SHA256: a74ad8c6166683361e9176faa16ab677c235ef3a486d6409c132785b36404454
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Masked_Vector_Mem_Read)
import X86.Runtime
import X86.BitWidth
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Alignment
import X86.Helpers.Check_Data_Read_Breakpoint
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Is_Alignment_Checking_Enabled
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Count_Leading_Zero_Bits
import X86.Helpers.Std.Bits.Count_Trailing_Zero_Bits
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Repeat
import X86.Helpers.Std.Bits.Zero
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
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

-- Retain checked width facts for dependent casts; their proofs are erased.
def Masked_Vector_Mem_Read
    (size element_size : Int) (is_broadcast : Bool) (k : Bits 64) (ea_segment : Segment) (effective_address : Bits 64) (fault_suppression : Bool) :
    Runtime.SpecM Exception (State σ) (Bits size) := do
  Runtime.assert (0 ≤ size)

  let ⟨size_domain⟩ ← Runtime.assertWithProof ((size == (16 : Int)) || (size == (32 : Int)) || (size == (64 : Int)) || (size == (128 : Int)) || (size == (256 : Int)) || (size == (512 : Int)))
  let ⟨element_size_domain⟩ ← Runtime.assertWithProof ((element_size == (8 : Int)) || (element_size == (16 : Int)) || (element_size == (32 : Int)) || (element_size == (64 : Int)))
  let ⟨elements, elements_result⟩ ← liftM (Runtime.remember (Std.Integer.Positive_Divide size element_size : Except (Runtime.Error Exception) Int))
  have elements_value := Runtime.positiveDivide_eq_of_ok elements_result

  if ((← Std.Bits.Is_Zero (size := elements) (← k[0 +: elements])) and fault_suppression) then
    return (← Std.Bits.Zero size)

  let mut src : Bits size ← Std.Bits.Zero size
  if is_broadcast then
    let mask ← k[0 +: elements]
    let ⟨is_zero, zero_result⟩ ← liftM (Runtime.remember (Std.Bits.Is_Zero (size := elements) mask : Except (Runtime.Error Empty) Bool))
    if selected : not is_zero then
      have elements_positive : 0 < elements :=
        X86.BitWidth.source_is_zero_false_pos mask (by
          have equal : is_zero = false := by simpa using selected
          simpa [equal] using zero_result)
      -- broadcast performs alignment check when enabled
      have width_eq : Int.toNat (element_size * elements) = Int.toNat size := by
        simp_all only [Bool.or_eq_true, beq_iff_eq, or_assoc] <;>
          first
          | omega
          | rcases element_size_domain with rfl | rfl | rfl | rfl <;> omega
      src := BitVec.cast width_eq (← Std.Bits.Repeat (m := element_size) (← Logical_Mem_Read ea_segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false) elements)
  else
    -- ensure that all unmasked values are readable before performing any of the reads
    -- this is done by checking the lowest byte of the lowest unmasked element and the
    -- highest byte of the highest unmasked element before beginning any of the reads
    let lowest_unmasked_byte : Int := (← Std.Bits.Count_Trailing_Zero_Bits (size := elements) (← k[0 +: elements])) * (← Std.Integer.Positive_Divide element_size 8)
    let lowest_logical : Address_Translation ← Create_Logical_Address ea_segment (effective_address + (← lowest_unmasked_byte[0 +: 64])) 8
    let _ ← Translate_Logical_To_Linear lowest_logical Memory_Alignment_Type.Normal_Alignment (← get).CS false

    let highest_unmasked_bit : Int := elements - 1 - (← Std.Bits.Count_Leading_Zero_Bits (size := elements) (← k[0 +: elements]))
    let highest_unmasked_byte : Int := highest_unmasked_bit * (← Std.Integer.Positive_Divide element_size 8) + (← Std.Integer.Positive_Divide element_size 8) - 1
    let highest_logical : Address_Translation ← Create_Logical_Address ea_segment (effective_address + (← highest_unmasked_byte[0 +: 64])) 8
    let _ ← Translate_Logical_To_Linear highest_logical Memory_Alignment_Type.Normal_Alignment (← get).CS false

    if ((← Is_Alignment_Checking_Enabled) and decide (size ≤ 64)) then
      -- check alignment on the memory size, not the element size
      Check_Alignment (← Compute_Linear_Address ea_segment effective_address (← get).CS) (← Std.Integer.Positive_Divide size 8)

    for i in intRange (0 : Int) (elements - 1) do
      if ((← k[i +: 1]) == 1) then
        Runtime.assert (decide (i * element_size ≤ size - element_size))
        Runtime.assert (decide (0 ≤ element_size))
        src := (← setSliceChecked src (i * element_size) element_size (← Logical_Mem_Read ea_segment (← Std.Bits.Add_int (n := 64) effective_address (i * (← Std.Integer.Positive_Divide element_size 8))) element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Explicitly_Unaligned false))
      else
        if (not fault_suppression) then
          -- perform the address translation, but do not read the value
          let logical : Address_Translation ← Create_Logical_Address ea_segment (← Std.Bits.Add_int (n := 64) effective_address (i * (← Std.Integer.Positive_Divide element_size 8))) element_size
          let linear : Address_Translation ← Translate_Logical_To_Linear logical Memory_Alignment_Type.Explicitly_Unaligned (← get).CS false
          Check_Data_Read_Breakpoint linear.linear_address linear.num_bytes
          let _ ← Translate_Linear_To_Physical.interpreted linear Memory_Access_Type.Memory_Read

  return src

end X86.Helpers
