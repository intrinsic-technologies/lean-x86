-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: e5c10bd1baa2ad48038315b4d53ee34bbdc852191ed76f4549ab24d82cb5eed0
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.CET.Check_Target_And_Get_New_SSP
import X86.Helpers.CET.Is_Shadow_Stack_Enabled
import X86.Helpers.CET.Is_Valid_Shadow_Stack_Address
import X86.Helpers.CET.Shadow_Stack_Clear_Token_Busy_Bit
import X86.Helpers.CP_Error_Code
import X86.Helpers.Check_New_RIP
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Invalidate_Inaccessible_Data_Segments
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_Aligned
import X86.Helpers.Is_Data_Segment
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Null_Segment
import X86.Helpers.Pop_Stack
import X86.Helpers.Release_Parameters
import X86.Helpers.Report_Control_Protection_Exception
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Stack_Fault
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Set_Segment_Access_Bit
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Update_Stack_Pointer
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Read.Binding σ]
  [X86.Helpers.CET.Shadow_Stack_Write.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Return_To_Less_Privilege
    (new_cs : Segment) (new_rip curr_rsp : Bits 64) (operand_size : Int) (parameter_count : Bits 16) :
    Runtime.SpecM Exception (State σ) Unit := do
  let mut temp_rsp : Bits 64 := curr_rsp
  let mut new_rsp : Bits 64 ← Std.Bits.Zero 64

  Runtime.assert (decide (operand_size ≤ 64))
  Runtime.assert (decide (0 ≤ operand_size))
  let (new_rsp_part, temp_rsp_1) ← Pop_Stack (← get).SS temp_rsp operand_size operand_size
  new_rsp := (← setSliceChecked new_rsp 0 operand_size new_rsp_part)
  temp_rsp := temp_rsp_1

  -- pop only 16 bits, but increment RSP by operand_size bits (high-order bits discarded)
  let (new_ss_selector, temp_rsp_2) ← Pop_Stack (← get).SS temp_rsp 16 operand_size
  temp_rsp := temp_rsp_2

  let mut new_ss_descriptor : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut new_ss_descriptor_high : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut new_ss_descriptor_valid : Option (Bool) := none
  let mut new_ss_is_stack : Option (Bool) := none
  let mut new_ss_is_code : Option (Bool) := none
  let mut new_ss_is_64bit_mode_data_segment : Option (Bool) := none

  let new_ss_selector_1 : Segment_Selector ← do
    if (← Is_Null_Segment_Selector new_ss_selector) then
      if (not (← Is_64Bit_Code_Segment new_cs) or Segment_Selector.RPL new_cs.selector == 3 or Segment_Selector.RPL new_ss_selector != Segment_Selector.RPL new_cs.selector) then
        liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_ss_selector))

      let new_ss_replacement : Segment ← Null_Segment (← get).SS
      let mut new_ss_selector_1 : Segment_Selector := new_ss_replacement.selector
      new_ss_descriptor := new_ss_replacement.descriptor
      new_ss_descriptor_high := new_ss_replacement.descriptor_high
      new_ss_descriptor_valid := new_ss_replacement.descriptor_valid
      new_ss_is_stack := new_ss_replacement.is_stack
      new_ss_is_code := new_ss_replacement.is_code
      new_ss_is_64bit_mode_data_segment := new_ss_replacement.is_64bit_mode_data_segment
      new_ss_selector_1 := new_ss_selector
      pure new_ss_selector_1
    else
      let new_ss_replacement_1 : Segment ← Load_Segment_Descriptor new_ss_selector (← get).SS false
      let mut new_ss_selector_1 : Segment_Selector := new_ss_replacement_1.selector
      new_ss_descriptor := new_ss_replacement_1.descriptor
      new_ss_descriptor_high := new_ss_replacement_1.descriptor_high
      new_ss_descriptor_valid := new_ss_replacement_1.descriptor_valid
      new_ss_is_stack := new_ss_replacement_1.is_stack
      new_ss_is_code := new_ss_replacement_1.is_code
      new_ss_is_64bit_mode_data_segment := new_ss_replacement_1.is_64bit_mode_data_segment

      if (Segment_Selector.RPL new_ss_selector_1 != Segment_Selector.RPL new_cs.selector or not (← Is_Data_Segment ({
        selector := new_ss_selector_1,
        descriptor := new_ss_descriptor,
        descriptor_high := new_ss_descriptor_high,
        descriptor_valid := new_ss_descriptor_valid,
        is_stack := new_ss_is_stack,
        is_code := new_ss_is_code,
        is_64bit_mode_data_segment := new_ss_is_64bit_mode_data_segment
      } : Segment)) or (← Segment_Descriptor.R.partial new_ss_descriptor) == 0 or (← Segment_Descriptor.DPL.partial new_ss_descriptor) != Segment_Selector.RPL new_cs.selector) then
        liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_ss_selector_1))

      if ((← Segment_Descriptor.P.partial new_ss_descriptor) == 0) then
        liftM (Report_Stack_Fault (← Get_Error_Code_From_Selector new_ss_selector_1))

      if ((← Segment_Descriptor.A.partial new_ss_descriptor) == 0) then
        let new_ss_replacement_2 : Segment ← Set_Segment_Access_Bit ({
          selector := new_ss_selector_1,
          descriptor := new_ss_descriptor,
          descriptor_high := new_ss_descriptor_high,
          descriptor_valid := new_ss_descriptor_valid,
          is_stack := new_ss_is_stack,
          is_code := new_ss_is_code,
          is_64bit_mode_data_segment := new_ss_is_64bit_mode_data_segment
        } : Segment) false
        new_ss_selector_1 := new_ss_replacement_2.selector
        new_ss_descriptor := new_ss_replacement_2.descriptor
        new_ss_descriptor_high := new_ss_replacement_2.descriptor_high
        new_ss_descriptor_valid := new_ss_replacement_2.descriptor_valid
        new_ss_is_stack := new_ss_replacement_2.is_stack
        new_ss_is_code := new_ss_replacement_2.is_code
        new_ss_is_64bit_mode_data_segment := new_ss_replacement_2.is_64bit_mode_data_segment
      pure new_ss_selector_1

  Check_New_RIP new_cs new_rip

  let mut new_ssp : SSP_Type := (← get).SSP
  let mut old_ssp : SSP_Type := (← get).SSP
  if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
    if (not (← Is_Aligned (n := 64) (← get).SSP 8)) then
      Report_Control_Protection_Exception CP_Error_Code.FAR_RET_or_IRET

    if (Segment_Selector.RPL new_cs.selector != 3) then
      let (new_ssp_1, old_ssp_1) ← CET.Check_Target_And_Get_New_SSP new_cs new_rip
      new_ssp := new_ssp_1
      old_ssp := old_ssp_1

  let old_cpl : Int := (← get).CPL

  Branch_Far new_cs new_rip
  -- release parameters using the restored stack and destination code mode
  new_rsp := (← Release_Parameters ({
    selector := new_ss_selector_1,
    descriptor := new_ss_descriptor,
    descriptor_high := new_ss_descriptor_high,
    descriptor_valid := new_ss_descriptor_valid,
    is_stack := new_ss_is_stack,
    is_code := new_ss_is_code,
    is_64bit_mode_data_segment := new_ss_is_64bit_mode_data_segment
  } : Segment) new_rsp parameter_count)
  Update_Stack_Pointer ({
    selector := new_ss_selector_1,
    descriptor := new_ss_descriptor,
    descriptor_high := new_ss_descriptor_high,
    descriptor_valid := new_ss_descriptor_valid,
    is_stack := new_ss_is_stack,
    is_code := new_ss_is_code,
    is_64bit_mode_data_segment := new_ss_is_64bit_mode_data_segment
  } : Segment) new_rsp

  if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
    if (Segment_Selector.RPL new_cs.selector == 3) then
      new_ssp := (← get).IA32_PL3_SSP

    if (not (← CET.Is_Valid_Shadow_Stack_Address new_ssp new_cs)) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    modify ({ · with SSP := new_ssp })

  if (← CET.Is_Shadow_Stack_Enabled old_cpl) then
    -- Now past all faulting points; safe to free the token
    -- The token free is done using the old SSP
    let _ ← CET.Shadow_Stack_Clear_Token_Busy_Bit old_ssp

  Invalidate_Inaccessible_Data_Segments (Segment_Selector.RPL new_cs.selector)

end X86.Helpers
