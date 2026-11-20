-- Generated from Intel XML with an explicit local correction; do not edit.
-- Source SHA256: 410caa24e7c645f81eb6e585acbd5edbd960a76b8717e23ad8ee7367f6dd7959
import X86.Runtime
import X86.Helpers.Check_Segment_Limit
import X86.Helpers.Current_Mode
import X86.Helpers.Descriptor_High
import X86.Helpers.Execution_Mode
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Get_Segment_Type
import X86.Helpers.Get_System_Segment_Size
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_Code_Segment
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Load_Interrupt_Or_Trap_Gate_Descriptor_High
import X86.Helpers.Load_Real_Or_VM86_Segment
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Load_Segment_Descriptor_High
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Segment_Not_Present
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Segment_Type
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
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
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Get_Target_From_Gate
    (gate : Segment) (event_type : Vectored_Event_Type := Vectored_Event_Type.Hardware_Exception) (vector : Int := 0) :
    Runtime.SpecM Exception (State σ) (Segment × Bits 64) := do
  Runtime.assert (vector in {0..255})

  let new_cs_selector : Segment_Selector ← Segment_Descriptor.Selector.partial gate.descriptor

  if ((← Current_Mode) == Execution_Mode.Real_Address_Mode) then
    let new_cs : Segment ← Load_Real_Or_VM86_Segment Execution_Mode.Real_Address_Mode new_cs_selector (← get).CS
    let new_rip : Bits 64 ← Std.Bits.Zero_Extend (source_size := 16) (← (do
      let __check59 : Int := 16 + 16
      Runtime.assert (decide (16 ≤ __check59))
      pure (← Runtime.CheckedSlice.read (← Segment_Descriptor.Offset.partial gate.descriptor) 0 16))) 64

    -- In real-address mode, the new RIP limit check is done
    -- before the registers are pushed to the stack
    Check_Segment_Limit new_cs new_rip 1

    return (new_cs, new_rip)
  else
    let gate_type : Segment_Type ← Get_Segment_Type gate
    Runtime.assert ((gate_type == Segment_Type.System16Bit_Call_Gate) || (gate_type == Segment_Type.System_Call_Gate) || (gate_type == Segment_Type.System_16Bit_Interrupt_Gate) || (gate_type == Segment_Type.System_Interrupt_Gate) || (gate_type == Segment_Type.System_16Bit_Trap_Gate) || (gate_type == Segment_Type.System_Trap_Gate) || (gate_type == Segment_Type.System_Task_Gate))

    if ((← get).IA32_EFER.LMA == 1 and ((gate_type == Segment_Type.System16Bit_Call_Gate) || (gate_type == Segment_Type.System_16Bit_Interrupt_Gate) || (gate_type == Segment_Type.System_16Bit_Trap_Gate))) then
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector gate.selector))

    if ((← Segment_Descriptor.P.partial gate.descriptor) == 0) then
      liftM (Report_Segment_Not_Present (← Get_Error_Code_From_Selector gate.selector))

    let mut new_rip : Bits 64 ← Std.Bits.Zero_Extend (source_size := 32) (← Segment_Descriptor.Offset.partial gate.descriptor) 64

    if ((← get).IA32_EFER.LMA == 1) then
      let gate_descriptor_high : Descriptor_High ← do
        if gate_type == Segment_Type.System_Call_Gate then
          Load_Segment_Descriptor_High gate.selector
        else
          Load_Interrupt_Or_Trap_Gate_Descriptor_High gate.selector event_type vector true

      new_rip := (← setSliceChecked new_rip 32 32 (Descriptor_High.Base_High gate_descriptor_high))

      if (not (← Std.Bits.Is_Zero (size := 5) (Descriptor_High.Type2 gate_descriptor_high))) then
        liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector gate.selector))

    if (← Is_Null_Segment_Selector new_cs_selector) then
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs_selector))

    let mut new_cs : Segment ← Load_Segment_Descriptor new_cs_selector (← get).CS false

    if (not (← Is_Code_Segment new_cs) or decide (Unsigned (← Segment_Descriptor.DPL.partial new_cs.descriptor) > (← get).CPL)) then
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))

    if ((← get).IA32_EFER.LMA == 1 and not (← Is_64Bit_Code_Segment new_cs)) then
      liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))

    new_cs := { new_cs with selector := Segment_Selector.setRPL new_cs.selector (← Segment_Descriptor.DPL.partial new_cs.descriptor) }

    if ((← Get_System_Segment_Size gate) == 16) then
      new_rip := (← setSliceChecked new_rip 16 48 (← Std.Bits.Zero 48))

    return (new_cs, new_rip)

end X86.Helpers
