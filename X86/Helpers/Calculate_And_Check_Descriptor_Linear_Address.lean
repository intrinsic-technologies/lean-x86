-- Generated from data/definitions.xml.gz: Calculate_And_Check_Descriptor_Linear_Address; do not edit.
-- Source SHA256: 4df2b9f5ef0429e2388b3808cd03ff844d9707f99e5a7975e30601c081fd7666
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Calculate_And_Check_Descriptor_Linear_Address)
import X86.Runtime
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Get_Segment_Base
import X86.Helpers.Get_Segment_Limit
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Is_Canonical_Wrt_Paging_Mode
import X86.Helpers.Is_Local_Segment_Selector
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_TSS
import X86.Helpers.Segment_Selector
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Power2
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]

def Calculate_And_Check_Descriptor_Linear_Address
    (segment_selector : Segment_Selector) (high is_task_switch : Bool) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  if ((← Is_Local_Segment_Selector segment_selector) and not (← Runtime.readInitialized (← get).LDTR.descriptor_valid)) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector segment_selector))

  let base : Bits 64 ← do
    if (← Is_Local_Segment_Selector segment_selector) then
      Get_Segment_Base (← get).LDTR
    else
      pure (← get).GDTR.base
  let descriptor_index : Int := Unsigned (← concatBits (leftSize := 13) (rightSize := 3) (Segment_Selector.Index segment_selector) (0 : Bits 3))
  let offset : Int := if high then 8 else 0
  let descriptor_linear_address : Bits 64 ← Std.Bits.Zero_Extend (source_size := 64) (← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) base descriptor_index) offset) 64

  let limit : Int ← do
    if (← Is_Local_Segment_Selector segment_selector) then
      Get_Segment_Limit (← get).LDTR
    else
      pure (Unsigned (← get).GDTR.limit)
  let descriptor_access_size : Int := 8
  if (decide (descriptor_index + offset + descriptor_access_size - 1 > limit)) then
    if is_task_switch then
      liftM (Report_Invalid_TSS (← Get_Error_Code_From_Selector segment_selector))
    else
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector segment_selector))

  if (← (do if (← In_64Bit_Mode) then pure (not (← Is_Canonical_Wrt_Paging_Mode descriptor_linear_address 0 false)) else pure false)) then
    if is_task_switch then
      liftM (Report_Invalid_TSS (← Get_Error_Code_From_Selector segment_selector))
    else
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector segment_selector))

  return descriptor_linear_address

end X86.Helpers
