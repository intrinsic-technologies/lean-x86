-- Generated from data/definitions.xml.gz: Load_Data_Segment; do not edit.
-- Source SHA256: 7f858be862b998e91ccdb314d9b1ea33dece12aab9aabde6f7527449cf648b8c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Load_Data_Segment)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Is_Code_Segment
import X86.Helpers.Is_Data_Segment
import X86.Helpers.Is_Non_Conforming_Code_Segment
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Load_Real_Or_VM86_Segment
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Null_Segment
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_TSS
import X86.Helpers.Report_Segment_Not_Present
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Selector_Error_Code
import X86.Helpers.Set_Segment_Access_Bit
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

def Load_Data_Segment
    (segment_selector : Bits 16) (segment : Segment) (new_flags : RFLAGS_Type) (is_task_switch : Bool := false) :
    Runtime.SpecM Exception (State σ) (Segment) := do
  Runtime.assert (not (← Runtime.readInitialized segment.is_stack) and not (← Runtime.readInitialized segment.is_code))

  let mode : Execution_Mode ← Current_Mode

  if ((mode == Execution_Mode.Real_Address_Mode) || (mode == Execution_Mode.Virtual_8086_Mode)) then
    return (← Load_Real_Or_VM86_Segment mode segment_selector segment)
  else
    if (mode == Execution_Mode.Protected_Mode and RFLAGS_Type.VM new_flags == 1) then
      return (← Load_Real_Or_VM86_Segment Execution_Mode.Virtual_8086_Mode segment_selector segment)
    else
      if (← Is_Null_Segment_Selector segment_selector) then
        let mut new_segment : Segment ← Null_Segment segment
        new_segment := { new_segment with selector := segment_selector }
        return new_segment
      else
        let new_segment : Segment ← Load_Segment_Descriptor segment_selector segment is_task_switch
        let error_code : Selector_Error_Code ← Get_Error_Code_From_Selector new_segment.selector

        -- data segment register can only be loaded with a data segment or readable code segment
        if (not (← Is_Data_Segment new_segment) and not ((← Is_Code_Segment new_segment) and (← Segment_Descriptor.R.partial new_segment.descriptor) == 1)) then
          if is_task_switch then
            liftM (Report_Invalid_TSS error_code)
          else
            liftM (Report_General_Protection_Exception error_code)

        let rpl : Int := Unsigned (Segment_Selector.RPL new_segment.selector)
        let dpl : Int := Unsigned (← Segment_Descriptor.DPL.partial new_segment.descriptor)

        if ((← Is_Data_Segment new_segment) or (← Is_Non_Conforming_Code_Segment new_segment)) then
          if (decide (rpl > dpl) or decide ((← get).CPL > dpl)) then
            if is_task_switch then
              liftM (Report_Invalid_TSS error_code)
            else
              liftM (Report_General_Protection_Exception error_code)

        if ((← Segment_Descriptor.P.partial new_segment.descriptor) == 0) then
          liftM (Report_Segment_Not_Present error_code)

        if ((← Segment_Descriptor.A.partial new_segment.descriptor) == 0) then
          return (← Set_Segment_Access_Bit new_segment is_task_switch)

        return new_segment

end X86.Helpers
