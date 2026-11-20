-- Generated from data/definitions.xml.gz: Get_Event_Error_Code_From_Selector; do not edit.
-- Source SHA256: 177cb3906b35b1a740e07e6a8f431fba8fedf7e4ce59a1e39d768d28902f0c23
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_Event_Error_Code_From_Selector)
import X86.Runtime
import X86.Helpers.Segment_Selector
import X86.Helpers.Selector_Error_Code
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Get_Event_Error_Code_From_Selector
    (event_type : Vectored_Event_Type) (selector : Segment_Selector) :
    Except (Runtime.Error Empty) (Selector_Error_Code) := do
  let mut idt_error_code : Selector_Error_Code ← Std.Bits.Zero 32
  idt_error_code := Selector_Error_Code.setIndex idt_error_code (Segment_Selector.Index selector)
  idt_error_code := Selector_Error_Code.setTI idt_error_code (Segment_Selector.TI selector)
  idt_error_code := Selector_Error_Code.setIDT idt_error_code (0 : Runtime.Bit)
  if (event_type == Vectored_Event_Type.External_Interrupt or event_type == Vectored_Event_Type.Non_Maskable_Interrupt or event_type == Vectored_Event_Type.Privileged_Software_Exception_INT1) then
    idt_error_code := Selector_Error_Code.setEXT idt_error_code (1 : Runtime.Bit)
  return idt_error_code

end X86.Helpers
