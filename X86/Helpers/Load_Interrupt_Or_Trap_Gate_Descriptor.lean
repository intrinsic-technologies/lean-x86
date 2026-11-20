-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: c4e131b24af478d778b64e0b568b048213e7f387eebae7429286467c86bf1da2
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_IDT_Error_Code
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Is_Canonical_Wrt_Paging_Mode
import X86.Helpers.Linear_Mem_Read
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Segment
import X86.Helpers.Segment_Selector
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero
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

def Load_Interrupt_Or_Trap_Gate_Descriptor
    (event_type : Vectored_Event_Type) (vector : Int) (selector : Segment_Selector) :
    Runtime.SpecM Exception (State σ) (Segment) := do
  Runtime.assert (vector in {0..255})

  let descriptor_size : Int ← do
    if (← Current_Mode) == Execution_Mode.IA32e_Mode then
      pure 16
    else
      if (← Current_Mode) == Execution_Mode.Real_Address_Mode then
        pure 4
      else
        pure 8

  let idtr_offset : Int := Unsigned selector * descriptor_size
  let descriptor_linear_address : Bits 64 ← Std.Bits.Zero_Extend (source_size := 64) (← Std.Bits.Add_int (n := 64) (← get).IDTR.base idtr_offset) 64

  if (decide (idtr_offset + descriptor_size - 1 > Unsigned (← get).IDTR.limit)) then
    liftM (Report_General_Protection_Exception (← Get_IDT_Error_Code event_type vector))

  if (← (do if (← In_64Bit_Mode) then pure (not (← Is_Canonical_Wrt_Paging_Mode descriptor_linear_address 0 false)) else pure false)) then
    liftM (Report_General_Protection_Exception (← Get_IDT_Error_Code event_type vector))

  let mut gate_descriptor : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut gate_descriptor_high : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  let mut gate_descriptor_valid : Option (Bool) := none
  let mut gate_is_stack : Option (Bool) := none
  let mut gate_is_code : Option (Bool) := none
  let mut gate_is_64bit_mode_data_segment : Option (Bool) := none
  let gate_selector : Segment_Selector := selector
  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
    gate_descriptor := Runtime.InitializedBits.ofValue (← Std.Bits.Zero_Extend (source_size := 32) (← Linear_Mem_Read descriptor_linear_address 32 true) 64)
  else
    gate_descriptor := Runtime.InitializedBits.ofValue (← Linear_Mem_Read descriptor_linear_address 64 true)
  gate_descriptor_high := Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64)
  gate_descriptor_valid := some true
  return ({
    selector := gate_selector,
    descriptor := gate_descriptor,
    descriptor_high := gate_descriptor_high,
    descriptor_valid := gate_descriptor_valid,
    is_stack := gate_is_stack,
    is_code := gate_is_code,
    is_64bit_mode_data_segment := gate_is_64bit_mode_data_segment
  } : Segment)

end X86.Helpers
