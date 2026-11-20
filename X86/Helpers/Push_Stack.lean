-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: f273c4cfaf41171cd90f5ebcc50dd599d517db053ed87e7fbb16d458b488107e
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Alignment
import X86.Helpers.Check_Data_Write_Breakpoint
import X86.Helpers.Check_LASS_Violation
import X86.Helpers.Check_Write_Permission
import X86.Helpers.Create_Linear_Address
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_Alignment_Checking_Enabled
import X86.Helpers.Is_Canonical_Wrt_Paging_Mode
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Physical_Mem_Write
import X86.Helpers.Report_Stack_Fault
import X86.Helpers.Segment
import X86.Helpers.Segment_Selector
import X86.Helpers.Stack_Address_Size
import X86.Helpers.Std.Bits.Subtract_int
import X86.Helpers.Std.Bits.Zero_Extend
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
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Push_Stack
    (stack_segment : Segment) (old_rsp : Bits 64) (code_segment : Segment) (size push_size : Int) (value : Bits size) (check_lass : Bool := false) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.assert (0 ≤ size)

  Runtime.assert ((size == (16 : Int)) || (size == (32 : Int)) || (size == (64 : Int)))
  Runtime.assert ((push_size == (16 : Int)) || (push_size == (32 : Int)) || (push_size == (64 : Int)))
  Runtime.assert (← Runtime.readInitialized stack_segment.is_stack)

  let mut linear_segment_descriptor : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut linear_segment_descriptor_high : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut linear_segment_descriptor_valid : Option (Bool) := none
  let mut linear_segment_is_stack : Option (Bool) := none
  let mut linear_segment_is_code : Option (Bool) := none
  let mut linear_segment_is_64bit_mode_data_segment : Option (Bool) := none

  let (_effective_address, new_rsp, linear_num_bytes, linear_offset, linear_linear_address, linear_is_implicit_supervisor_mode_access, linear_is_shadow_stack_access, linear_translation_cpl, linear_is_split_access, linear_translation1, linear_translation2, linear_segment_selector) : (Bits 64 × Bits 64 × Int × Bits 64 × Bits 64 × Bool × Bool × Int × Bool × Translation × Translation × Segment_Selector) ← do
    if (← Is_64Bit_Code_Segment code_segment) then
      -- In 64-bit mode, address calculations that reference SS segments
      -- are treated as if the segment base is zero
      let effective_address : Bits 64 ← Std.Bits.Subtract_int (n := 64) old_rsp (← Std.Integer.Positive_Divide push_size 8)
      let new_rsp : Bits 64 := effective_address

      if (not (← Is_Canonical_Wrt_Paging_Mode new_rsp size false)) then
        liftM (Report_Stack_Fault (← get).Default_Error_Code)

      let linear_replacement : Address_Translation ← Create_Linear_Address new_rsp size
      let linear_num_bytes : Int := linear_replacement.num_bytes
      let linear_segment_replacement : Segment := linear_replacement.segment
      let mut linear_segment_selector : Segment_Selector := linear_segment_replacement.selector
      linear_segment_descriptor := linear_segment_replacement.descriptor
      linear_segment_descriptor_high := linear_segment_replacement.descriptor_high
      linear_segment_descriptor_valid := linear_segment_replacement.descriptor_valid
      linear_segment_is_stack := linear_segment_replacement.is_stack
      linear_segment_is_code := linear_segment_replacement.is_code
      linear_segment_is_64bit_mode_data_segment := linear_segment_replacement.is_64bit_mode_data_segment
      let linear_offset : Bits 64 := linear_replacement.offset
      let linear_linear_address : Bits 64 := linear_replacement.linear_address
      let linear_is_implicit_supervisor_mode_access : Bool := linear_replacement.is_implicit_supervisor_mode_access
      let linear_is_shadow_stack_access : Bool := linear_replacement.is_shadow_stack_access
      let mut linear_translation_cpl : Int := linear_replacement.translation_cpl
      let linear_is_split_access : Bool := linear_replacement.is_split_access
      let linear_translation1 : Translation := linear_replacement.translation1
      let linear_translation2 : Translation := linear_replacement.translation2
      linear_translation_cpl := Unsigned (Segment_Selector.RPL code_segment.selector)
      if ((← Is_Alignment_Checking_Enabled) and linear_translation_cpl == 3 and decide (linear_num_bytes ≤ 8)) then
        Check_Alignment linear_linear_address linear_num_bytes
      if check_lass then
        let linear_segment_replacement_1 : Segment := stack_segment
        linear_segment_selector := linear_segment_replacement_1.selector
        linear_segment_descriptor := linear_segment_replacement_1.descriptor
        linear_segment_descriptor_high := linear_segment_replacement_1.descriptor_high
        linear_segment_descriptor_valid := linear_segment_replacement_1.descriptor_valid
        linear_segment_is_stack := linear_segment_replacement_1.is_stack
        linear_segment_is_code := linear_segment_replacement_1.is_code
        linear_segment_is_64bit_mode_data_segment := linear_segment_replacement_1.is_64bit_mode_data_segment
        Check_LASS_Violation ({
          num_bytes := linear_num_bytes,
          segment := ({
            selector := linear_segment_selector,
            descriptor := linear_segment_descriptor,
            descriptor_high := linear_segment_descriptor_high,
            descriptor_valid := linear_segment_descriptor_valid,
            is_stack := linear_segment_is_stack,
            is_code := linear_segment_is_code,
            is_64bit_mode_data_segment := linear_segment_is_64bit_mode_data_segment
          } : Segment),
          offset := linear_offset,
          linear_address := linear_linear_address,
          is_implicit_supervisor_mode_access := linear_is_implicit_supervisor_mode_access,
          is_shadow_stack_access := linear_is_shadow_stack_access,
          translation_cpl := linear_translation_cpl,
          is_split_access := linear_is_split_access,
          translation1 := linear_translation1,
          translation2 := linear_translation2
        } : Address_Translation)
      pure (effective_address, new_rsp, linear_num_bytes, linear_offset, linear_linear_address, linear_is_implicit_supervisor_mode_access, linear_is_shadow_stack_access, linear_translation_cpl, linear_is_split_access, linear_translation1, linear_translation2, linear_segment_selector)
    else
      let stack_address_size : Int ← Stack_Address_Size stack_segment
      let effective_address : Bits 64 ← Std.Bits.Zero_Extend (source_size := stack_address_size) (← (do Runtime.assert (decide (stack_address_size ≤ 64)); Runtime.assert (decide (0 ≤ stack_address_size)); pure (← Runtime.CheckedSlice.read (← Std.Bits.Subtract_int (n := 64) old_rsp (← Std.Integer.Positive_Divide push_size 8)) 0 stack_address_size))) 64
      let new_rsp : Bits 64 ← do
        if stack_address_size == 16 then
          concatBits (leftSize := 48) (rightSize := 16) (← old_rsp[63:16]) (← effective_address[15:0])
        else
          pure effective_address
      let mut logical : Address_Translation ← Create_Logical_Address stack_segment effective_address size
      logical := { logical with translation_cpl := Unsigned (Segment_Selector.RPL code_segment.selector) }
      let linear_replacement_1 : Address_Translation ← Translate_Logical_To_Linear logical Memory_Alignment_Type.Normal_Alignment code_segment false
      let linear_num_bytes : Int := linear_replacement_1.num_bytes
      let linear_segment_replacement_2 : Segment := linear_replacement_1.segment
      let linear_segment_selector : Segment_Selector := linear_segment_replacement_2.selector
      linear_segment_descriptor := linear_segment_replacement_2.descriptor
      linear_segment_descriptor_high := linear_segment_replacement_2.descriptor_high
      linear_segment_descriptor_valid := linear_segment_replacement_2.descriptor_valid
      linear_segment_is_stack := linear_segment_replacement_2.is_stack
      linear_segment_is_code := linear_segment_replacement_2.is_code
      linear_segment_is_64bit_mode_data_segment := linear_segment_replacement_2.is_64bit_mode_data_segment
      let linear_offset : Bits 64 := linear_replacement_1.offset
      let linear_linear_address : Bits 64 := linear_replacement_1.linear_address
      let linear_is_implicit_supervisor_mode_access : Bool := linear_replacement_1.is_implicit_supervisor_mode_access
      let linear_is_shadow_stack_access : Bool := linear_replacement_1.is_shadow_stack_access
      let linear_translation_cpl : Int := linear_replacement_1.translation_cpl
      let linear_is_split_access : Bool := linear_replacement_1.is_split_access
      let linear_translation1 : Translation := linear_replacement_1.translation1
      let linear_translation2 : Translation := linear_replacement_1.translation2
      pure (effective_address, new_rsp, linear_num_bytes, linear_offset, linear_linear_address, linear_is_implicit_supervisor_mode_access, linear_is_shadow_stack_access, linear_translation_cpl, linear_is_split_access, linear_translation1, linear_translation2, linear_segment_selector)

  Check_Write_Permission stack_segment
  Check_Data_Write_Breakpoint linear_linear_address (← Std.Integer.Positive_Divide size 8)

  let physical : Address_Translation ← Translate_Linear_To_Physical.interpreted ({
    num_bytes := linear_num_bytes,
    segment := ({
      selector := linear_segment_selector,
      descriptor := linear_segment_descriptor,
      descriptor_high := linear_segment_descriptor_high,
      descriptor_valid := linear_segment_descriptor_valid,
      is_stack := linear_segment_is_stack,
      is_code := linear_segment_is_code,
      is_64bit_mode_data_segment := linear_segment_is_64bit_mode_data_segment
    } : Segment),
    offset := linear_offset,
    linear_address := linear_linear_address,
    is_implicit_supervisor_mode_access := linear_is_implicit_supervisor_mode_access,
    is_shadow_stack_access := linear_is_shadow_stack_access,
    translation_cpl := linear_translation_cpl,
    is_split_access := linear_is_split_access,
    translation1 := linear_translation1,
    translation2 := linear_translation2
  } : Address_Translation) Memory_Access_Type.Memory_Write
  Physical_Mem_Write physical size value

  return new_rsp

end X86.Helpers
