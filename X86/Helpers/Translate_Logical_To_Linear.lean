-- Generated from data/definitions.xml.gz: Translate_Logical_To_Linear; do not edit.
-- Source SHA256: 6478c4054feba79d3b843ee22021b92aca12c09e9c29aac5349c559fa19557af
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Translate_Logical_To_Linear)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Check_Alignment
import X86.Helpers.Check_LASS_Violation
import X86.Helpers.Check_Segment_Limit
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_Aligned
import X86.Helpers.Is_Alignment_Checking_Enabled
import X86.Helpers.Is_Canonical_Wrt_Paging_Mode
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Is_System_Segment
import X86.Helpers.Is_Task_Segment
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_TSS
import X86.Helpers.Report_Stack_Fault
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Translate_Logical_To_Linear
    (logical : Address_Translation) (alignment_type : Memory_Alignment_Type) (code_segment : Segment) (is_instruction_fetch : Bool := false) :
    Runtime.SpecM Exception (State σ) (Address_Translation) := do

  let mut linear : Address_Translation := logical
  linear := { linear with linear_address := (← Compute_Linear_Address logical.segment logical.offset code_segment) }
  linear := { linear with is_implicit_supervisor_mode_access := (← Is_System_Segment logical.segment) }

  if (alignment_type == Memory_Alignment_Type.Explicitly_Aligned) then
    if (not (← Is_Aligned (n := 64) linear.linear_address linear.num_bytes)) then
      liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
  else
    if (alignment_type == Memory_Alignment_Type.Normal_Alignment) then
      if ((← Is_Alignment_Checking_Enabled) and not (← Runtime.readInitialized linear.segment.is_code) and linear.translation_cpl == 3 and not (← Is_System_Segment linear.segment) and ((← Is_64Bit_Code_Segment code_segment) or not (← Is_Null_Segment_Selector linear.segment.selector)) and decide (linear.num_bytes ≤ 8)) then
        Check_Alignment linear.linear_address linear.num_bytes

  if (← Is_64Bit_Code_Segment code_segment) then
    -- LAM masking applies to data accesses only, never to instruction fetches
    if (not (← Is_Canonical_Wrt_Paging_Mode linear.linear_address (linear.num_bytes * 8) is_instruction_fetch)) then
      if (← Runtime.readInitialized logical.segment.is_stack) then
        liftM (Report_Stack_Fault (← Std.Bits.Zero 32))
      else
        if (← Is_Task_Segment logical.segment) then
          liftM (Report_Invalid_TSS (← Std.Bits.Zero 32))
        else
          liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
  else
    if (not (← Runtime.readInitialized logical.segment.descriptor_valid) or (← Segment_Descriptor.P.partial logical.segment.descriptor) == 0) then
      if (← Runtime.readInitialized logical.segment.is_stack) then
        liftM (Report_Stack_Fault (← Std.Bits.Zero 32))
      else
        if (← Is_Task_Segment logical.segment) then
          liftM (Report_Invalid_TSS (← Std.Bits.Zero 32))
        else
          liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

    Check_Segment_Limit logical.segment logical.offset logical.num_bytes

  Check_LASS_Violation linear

  return linear

end X86.Helpers
