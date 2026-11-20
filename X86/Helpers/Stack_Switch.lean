-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: ddc230558bae861e56dcf353a087b780a1f0689e64a0ffa8fc0c77d2a650ebed
import X86.Runtime
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Is_16Bit_Task
import X86.Helpers.Is_Data_Segment
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Is_Segment_Limit_Violation
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Null_Segment
import X86.Helpers.Report_Invalid_TSS
import X86.Helpers.Report_Stack_Fault
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Selector_Error_Code
import X86.Helpers.Set_Segment_Access_Bit
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Integer.Max
import X86.Helpers.Std.Integer.Min
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

def Stack_Switch
    (new_cs : Segment) (tss_limit_ext : Runtime.Bit := 0) :
    Runtime.SpecM Exception (State σ) (Segment × Bits 64) := do

  let mut new_rsp : Bits 64 ← Std.Bits.Zero 64
  let mut new_ss_descriptor : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut new_ss_descriptor_high : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut new_ss_descriptor_valid : Option (Bool) := none
  let mut new_ss_is_stack : Option (Bool) := none
  let mut new_ss_is_code : Option (Bool) := none
  let mut new_ss_is_64bit_mode_data_segment : Option (Bool) := none

  let new_ss_selector : Segment_Selector ← do
    if (← get).IA32_EFER.LMA == 1 then
      let tr_offset_64 : Bits 64 ← (Unsigned (Segment_Selector.RPL new_cs.selector) * 8)[0 +: 64]
      if (← Is_Segment_Limit_Violation (← get).TR (← Std.Bits.Add_int (n := 64) tr_offset_64 4) 8) then
        let mut tss_error_code : Selector_Error_Code ← Get_Error_Code_From_Selector (← get).TR.selector
        tss_error_code := Selector_Error_Code.setEXT tss_error_code tss_limit_ext
        liftM (Report_Invalid_TSS tss_error_code)
      new_rsp := (← Logical_Mem_Read (← get).TR (← Std.Bits.Add_int (n := 64) tr_offset_64 4) 64 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)
      -- In IA-32e mode a new SS selector is not loaded from the TSS
      -- Instead, the new SS selector is forced to NULL
      -- and the SS selector’s RPL field is set to the new CPL
      let new_ss_replacement : Segment ← Null_Segment (← get).SS
      let mut new_ss_selector : Segment_Selector := new_ss_replacement.selector
      new_ss_descriptor := new_ss_replacement.descriptor
      new_ss_descriptor_high := new_ss_replacement.descriptor_high
      new_ss_descriptor_valid := new_ss_replacement.descriptor_valid
      new_ss_is_stack := new_ss_replacement.is_stack
      new_ss_is_code := new_ss_replacement.is_code
      new_ss_is_64bit_mode_data_segment := new_ss_replacement.is_64bit_mode_data_segment
      new_ss_selector := Segment_Selector.setRPL new_ss_selector (Segment_Selector.RPL new_cs.selector)
      pure new_ss_selector
    else
      let mut new_ss_selector : Segment_Selector ← do
        if not (← Is_16Bit_Task (← get).TR) then
          let tr_offset_32 : Bits 64 ← (Unsigned (Segment_Selector.RPL new_cs.selector) * 8)[0 +: 64]
          new_rsp := (← setSliceChecked new_rsp 0 32 (← Logical_Mem_Read (← get).TR (← Std.Bits.Add_int (n := 64) tr_offset_32 4) 32 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false))
          let new_ss_selector : Segment_Selector ← Logical_Mem_Read (← get).TR (← Std.Bits.Add_int (n := 64) tr_offset_32 8) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
          pure new_ss_selector
        else
          let tr_offset_16 : Bits 64 ← (Unsigned (Segment_Selector.RPL new_cs.selector) * 4)[0 +: 64]
          new_rsp := (← setSliceChecked new_rsp 0 16 (← Logical_Mem_Read (← get).TR (← Std.Bits.Add_int (n := 64) tr_offset_16 2) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false))
          let new_ss_selector : Segment_Selector ← Logical_Mem_Read (← get).TR (← Std.Bits.Add_int (n := 64) tr_offset_16 4) 16 Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false
          pure new_ss_selector

      if ((← Is_Null_Segment_Selector new_ss_selector) or Segment_Selector.RPL new_ss_selector != (← Segment_Descriptor.DPL.partial new_cs.descriptor)) then
        liftM (Report_Invalid_TSS (← Get_Error_Code_From_Selector new_ss_selector))

      let new_ss_replacement_1 : Segment ← Load_Segment_Descriptor new_ss_selector (← get).SS false
      new_ss_selector := new_ss_replacement_1.selector
      new_ss_descriptor := new_ss_replacement_1.descriptor
      new_ss_descriptor_high := new_ss_replacement_1.descriptor_high
      new_ss_descriptor_valid := new_ss_replacement_1.descriptor_valid
      new_ss_is_stack := new_ss_replacement_1.is_stack
      new_ss_is_code := new_ss_replacement_1.is_code
      new_ss_is_64bit_mode_data_segment := new_ss_replacement_1.is_64bit_mode_data_segment

      if (not (← Is_Data_Segment ({
        selector := new_ss_selector,
        descriptor := new_ss_descriptor,
        descriptor_high := new_ss_descriptor_high,
        descriptor_valid := new_ss_descriptor_valid,
        is_stack := new_ss_is_stack,
        is_code := new_ss_is_code,
        is_64bit_mode_data_segment := new_ss_is_64bit_mode_data_segment
      } : Segment)) or (← Segment_Descriptor.R.partial new_ss_descriptor) == 0 or (← Segment_Descriptor.DPL.partial new_ss_descriptor) != (← Segment_Descriptor.DPL.partial new_cs.descriptor)) then
        liftM (Report_Invalid_TSS (← Get_Error_Code_From_Selector new_ss_selector))

      if ((← Segment_Descriptor.P.partial new_ss_descriptor) == 0) then
        liftM (Report_Stack_Fault (← Get_Error_Code_From_Selector new_ss_selector))

      if ((← Segment_Descriptor.A.partial new_ss_descriptor) == 0) then
        let new_ss_replacement_2 : Segment ← Set_Segment_Access_Bit ({
          selector := new_ss_selector,
          descriptor := new_ss_descriptor,
          descriptor_high := new_ss_descriptor_high,
          descriptor_valid := new_ss_descriptor_valid,
          is_stack := new_ss_is_stack,
          is_code := new_ss_is_code,
          is_64bit_mode_data_segment := new_ss_is_64bit_mode_data_segment
        } : Segment) false
        new_ss_selector := new_ss_replacement_2.selector
        new_ss_descriptor := new_ss_replacement_2.descriptor
        new_ss_descriptor_high := new_ss_replacement_2.descriptor_high
        new_ss_descriptor_valid := new_ss_replacement_2.descriptor_valid
        new_ss_is_stack := new_ss_replacement_2.is_stack
        new_ss_is_code := new_ss_replacement_2.is_code
        new_ss_is_64bit_mode_data_segment := new_ss_replacement_2.is_64bit_mode_data_segment
      pure new_ss_selector

  return (({
    selector := new_ss_selector,
    descriptor := new_ss_descriptor,
    descriptor_high := new_ss_descriptor_high,
    descriptor_valid := new_ss_descriptor_valid,
    is_stack := new_ss_is_stack,
    is_code := new_ss_is_code,
    is_64bit_mode_data_segment := new_ss_is_64bit_mode_data_segment
  } : Segment), new_rsp)

end X86.Helpers
