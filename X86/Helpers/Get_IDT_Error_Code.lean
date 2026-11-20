-- Generated from data/definitions.xml.gz: Get_IDT_Error_Code; do not edit.
-- Source SHA256: 4ef56993b7fb0da7e1e392088210787ce860b5f6a2b5a97a24bca6d1fdc66fac
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_IDT_Error_Code)
import X86.Runtime
import X86.Helpers.Selector_Error_Code
import X86.Helpers.Std.Bits.Unsigned_Saturate
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Get_IDT_Error_Code
    (event_type : Vectored_Event_Type) (vector : Int) :
    Except (Runtime.Error Empty) (Selector_Error_Code) := do
  Runtime.assert (vector in {0..255})

  let mut idt_error_code : Selector_Error_Code ← Std.Bits.Zero 32
  idt_error_code := Selector_Error_Code.setIndex idt_error_code (← Std.Bits.Unsigned_Saturate vector 13)
  idt_error_code := Selector_Error_Code.setTI idt_error_code (0 : Runtime.Bit)
  idt_error_code := Selector_Error_Code.setIDT idt_error_code (1 : Runtime.Bit)
  if (event_type == Vectored_Event_Type.External_Interrupt or event_type == Vectored_Event_Type.Non_Maskable_Interrupt or event_type == Vectored_Event_Type.Privileged_Software_Exception_INT1) then
    idt_error_code := Selector_Error_Code.setEXT idt_error_code (1 : Runtime.Bit)
  return idt_error_code

end X86.Helpers
