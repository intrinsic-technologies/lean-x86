-- Generated from data/definitions.xml.gz: Load_Interrupt_Or_Trap_Gate_Descriptor_High; do not edit.
-- Source SHA256: 0cb4a1439bbd82ff389b8e99fa1e535aec23ffe4f9d446f48cf59ecf8b2ecfb4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Load_Interrupt_Or_Trap_Gate_Descriptor_High)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Descriptor_High
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Get_IDT_Error_Code
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Is_Canonical_Wrt_Paging_Mode
import X86.Helpers.Linear_Mem_Read
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Segment_Selector
import X86.Helpers.Selector_Error_Code
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.Helpers.Std.Integer.Exp
import X86.Helpers.Std.Integer.Max
import X86.Helpers.Std.Integer.Min
import X86.Helpers.Vectored_Event_Type
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

def Load_Interrupt_Or_Trap_Gate_Descriptor_High
    (selector : Segment_Selector) (event_type : Vectored_Event_Type := Vectored_Event_Type.Hardware_Exception) (vector : Int := 0) (use_idt_error_code : Bool := false) :
    Runtime.SpecM Exception (State σ) (Descriptor_High) := do
  Runtime.assert (vector in {0..255})

  let idtr_offset : Int ← do
    if (← Current_Mode) == Execution_Mode.IA32e_Mode then
      pure (Unsigned selector * 16)
    else
      pure (Unsigned selector * 8)
  let descriptor_linear_address : Bits 64 ← Std.Bits.Zero_Extend (source_size := 64) (← Std.Bits.Add_int (n := 64) (← Std.Bits.Add_int (n := 64) (← get).IDTR.base idtr_offset) 8) 64

  if (decide (idtr_offset + 15 > Unsigned (← get).IDTR.limit)) then
    let error_code : Selector_Error_Code ← do
      if use_idt_error_code then
        Get_IDT_Error_Code event_type vector
      else
        Get_Error_Code_From_Selector selector
    liftM (Report_General_Protection_Exception error_code)

  if (← (do if (← In_64Bit_Mode) then pure (not (← Is_Canonical_Wrt_Paging_Mode descriptor_linear_address 0 false)) else pure false)) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector selector))

  let gate_descriptor_high : Descriptor_High ← Linear_Mem_Read descriptor_linear_address 64 true
  return gate_descriptor_high

end X86.Helpers
