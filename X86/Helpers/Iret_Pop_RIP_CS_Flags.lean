-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 87f64df914aabc561ebea4cfaa900fefaef58007542bdbccacb3b537ea24fd04
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.CET.Is_Shadow_Stack_Enabled
import X86.Helpers.Emulate_Buffered_Stack_Return_Header
import X86.Helpers.Exception_Info
import X86.Helpers.Exception_Vector_Numbers
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Invalidate_Inaccessible_Data_Segments
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Is_Code_Segment
import X86.Helpers.Is_Null_Segment_Selector
import X86.Helpers.Is_Valid_Code_Segment
import X86.Helpers.Load_Segment_Descriptor
import X86.Helpers.Load_Stack_Segment
import X86.Helpers.Registers
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Segment_Not_Present
import X86.Helpers.Report_Stack_Fault
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector
import X86.Helpers.Set_Segment_Access_Bit
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
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
  [X86.Helpers.Select_Buffered_Stack_Return_Swap.Binding σ]
  [X86.Helpers.Select_Stack_Return_Validation_Fault.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

-- Missing IRET helpers, SDM Vol. 2 IRET operation and 64-bit exception table.
-- The protected-return implementation below supports entry from 64-bit mode
-- with shadow stacks disabled. Other entry modes and CET need separate support.
def Iret_Pop_RIP_CS_Flags
    (operand_size : Int) :
    Runtime.SpecM Exception (State σ) (Bits 64 × Segment_Selector × Bits 64 × Bits 64) := do
  Runtime.assert ((operand_size == (16 : Int)) || (operand_size == (32 : Int)) || (operand_size == (64 : Int)))
  let (ip, selector, flags_part, after_flags) ← Emulate_Buffered_Stack_Return_Header operand_size (← get).SS (← RSP)
  let mut flags : RFLAGS_Type := (← get).RFLAGS
  Runtime.assert (decide (operand_size ≤ 64))
  Runtime.assert (decide (0 ≤ operand_size))
  flags := (← setSliceChecked flags 0 operand_size flags_part)
  return ((← Std.Bits.Zero_Extend (source_size := operand_size) ip 64), selector, flags, after_flags)

-- IRET uses #SS(0), unlike the generic stack-load helper's #SS(selector).
def Iret_Load_Stack_Segment
    (selector : Segment_Selector) (cpl : Int) (flags : RFLAGS_Type) :
    Runtime.SpecM Exception (State σ) (Segment) := do
  let mut result : Segment := (← get).SS
  try
    result := (← Load_Stack_Segment selector (← get).SS cpl flags true)
  catch exception =>
    match exception with
    | .raised (.Exception_Info e) =>
      if (e.vector == SS_Exception) then
        liftM (Report_Stack_Fault (← Std.Bits.Zero 32))
      throw (.raised (↑e : Exception))
    | _ => throw exception
  return result

def Iret_Protected_Or_IA32e_Mode
    (operand_size : Int) (new_cs_selector : Segment_Selector) (new_rip : Bits 64) (new_flags : RFLAGS_Type) (curr_rsp : Bits 64) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (← In_64Bit_Mode)
  Runtime.assert ((operand_size == (16 : Int)) || (operand_size == (32 : Int)) || (operand_size == (64 : Int)))
  let new_cpl : Int := Unsigned (Segment_Selector.RPL new_cs_selector)
  Emulate_Stack_Return_CS_Check Buffered_Stack_Return_Group.IRET_Header new_cs_selector
  let mut new_cs : Segment ← Load_Segment_Descriptor new_cs_selector (← get).CS false
  if (not (← Is_Code_Segment new_cs) or not (← Is_Valid_Code_Segment new_cs new_cpl) or (← Segment_Descriptor.L.partial new_cs.descriptor) == 1 and (← Segment_Descriptor.D.partial new_cs.descriptor) == 1) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs_selector))
  if ((← Segment_Descriptor.P.partial new_cs.descriptor) == 0) then
    liftM (Report_Segment_Not_Present (← Get_Error_Code_From_Selector new_cs_selector))
  let new_64bit : Bool ← Is_64Bit_Code_Segment new_cs
  if ((← CR4.FRED) == 1 and (← get).CPL == 0 and not new_64bit) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs_selector))
  -- This local implementation does not approximate CET token operations.
  Runtime.assert (not (← CET.Is_Shadow_Stack_Enabled (← get).CPL))
  Runtime.assert (not (← CET.Is_Shadow_Stack_Enabled new_cpl))
  let (stack_part, ss_selector, _) ← Emulate_Buffered_Stack_Return_Target_Pair Buffered_Stack_Return_Group.IRET_Stack operand_size (← get).SS curr_rsp new_cs new_rip
  let new_rsp : Bits 64 ← Std.Bits.Zero_Extend (source_size := operand_size) stack_part 64
  if ((← Is_Null_Segment_Selector ss_selector) and not new_64bit) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
  let new_ss : Segment ← Iret_Load_Stack_Segment ss_selector new_cpl new_flags
  Emulate_Iret_Target_Check new_cs new_rip new_64bit
  if ((← Segment_Descriptor.A.partial new_cs.descriptor) == 0) then
    new_cs := (← Set_Segment_Access_Bit new_cs false)
  let old_cpl : Int := (← get).CPL
  let old_iopl : Int := Unsigned (← RFLAGS.IOPL)
  RFLAGS.setCF (RFLAGS_Type.CF new_flags)
  RFLAGS.setPF (RFLAGS_Type.PF new_flags)
  RFLAGS.setAF (RFLAGS_Type.AF new_flags)
  RFLAGS.setZF (RFLAGS_Type.ZF new_flags)
  RFLAGS.setSF (RFLAGS_Type.SF new_flags)
  RFLAGS.setTF (RFLAGS_Type.TF new_flags)
  RFLAGS.setDF (RFLAGS_Type.DF new_flags)
  RFLAGS.setOF (RFLAGS_Type.OF new_flags)
  RFLAGS.setNT (RFLAGS_Type.NT new_flags)
  if (operand_size != 16) then
    RFLAGS.setRF (RFLAGS_Type.RF new_flags)
    RFLAGS.setAC (RFLAGS_Type.AC new_flags)
    RFLAGS.setID (RFLAGS_Type.ID new_flags)
  if (decide (old_cpl ≤ old_iopl)) then
    RFLAGS.setIF (RFLAGS_Type.IF new_flags)
  if (old_cpl == 0) then
    RFLAGS.setIOPL (RFLAGS_Type.IOPL new_flags)
    if (operand_size != 16) then
      RFLAGS.setVIF (RFLAGS_Type.VIF new_flags)
      RFLAGS.setVIP (RFLAGS_Type.VIP new_flags)
  Branch_Far new_cs new_rip
  modify ({ · with SS := new_ss })
  RSP_write new_rsp
  if (decide (new_cpl > old_cpl)) then
    Invalidate_Inaccessible_Data_Segments (Segment_Selector.RPL new_cs_selector)

end X86.Helpers
