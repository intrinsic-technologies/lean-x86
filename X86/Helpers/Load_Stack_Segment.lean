-- Generated from data/definitions.xml.gz: Load_Stack_Segment; do not edit.
-- Source SHA256: 1a7036f563d6337fc29168dc75b1d0ca9f1ef00ed1e95708121439480de4b38c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Load_Stack_Segment)
import X86.Runtime
import X86.Helpers.Check_New_Stack_Segment
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Load_Real_Or_VM86_Segment
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Null_Segment
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Set_Segment_Access_Bit
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
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]

def Load_Stack_Segment
    (segment_selector : Bits 16) (segment : Segment) (cpl : Int) (new_flags : RFLAGS_Type) (set_access_bit : Bool) :
    Runtime.SpecM Exception (State σ) (Segment) := do
  Runtime.assert (cpl in {0..3})

  Runtime.assert (← Runtime.readInitialized segment.is_stack)

  let mode : Execution_Mode ← Current_Mode

  if ((mode == Execution_Mode.Real_Address_Mode) || (mode == Execution_Mode.Virtual_8086_Mode)) then
    return (← Load_Real_Or_VM86_Segment mode segment_selector segment)
  else
    if (mode == Execution_Mode.Protected_Mode and RFLAGS_Type.VM new_flags == 1) then
      return (← Load_Real_Or_VM86_Segment Execution_Mode.Virtual_8086_Mode segment_selector segment)
    else
      if (← Is_Null_Segment_Selector segment_selector) then
        if (← In_64Bit_Mode) then
          let mut new_segment : Segment ← Null_Segment segment
          new_segment := { new_segment with selector := segment_selector }
          if (Unsigned (Segment_Selector.RPL new_segment.selector) == 3 or Unsigned (Segment_Selector.RPL new_segment.selector) != cpl) then
            liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
          else
            return new_segment
        else
          liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let new_segment : Segment ← Load_Segment_Descriptor segment_selector segment false

  if (Unsigned (Segment_Selector.RPL new_segment.selector) != cpl) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_segment.selector))

  if (not (← Is_Null_Segment_Selector new_segment.selector)) then
    Check_New_Stack_Segment new_segment cpl

  if ((← Segment_Descriptor.A.partial new_segment.descriptor) == 0 and set_access_bit) then
    return (← Set_Segment_Access_Bit new_segment false)

  return new_segment

end X86.Helpers
