-- Generated from data/definitions.xml.gz: Push_Parameters; do not edit.
-- Source SHA256: 4da2287a3529d13fb5579fb4fd0bcadf40124ecfe726deb9b2a0fb26e0ef6697
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Push_Parameters)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Pop_Stack
import X86.Helpers.Push_Stack
import X86.Helpers.Registers
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.Std.Unreachable
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
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

def Push_Parameters
    (new_ss : Segment) (curr_rsp : Bits 64) (new_cs : Segment) (parameter_count : Bits 5) (stack_access_size : Int) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  Runtime.assert (not (← In_64Bit_Mode))

  if (← Std.Bits.Is_Zero (size := 5) parameter_count) then
    return curr_rsp
  else

    let mut new_rsp : Bits 64 := curr_rsp

    for i in intRange (0 : Int) (Unsigned parameter_count - 1) do
      let param_offset : Bits 64 ← Std.Bits.Add_int (n := 64) (← RSP) ((Unsigned parameter_count - i - 1) * (← Std.Integer.Positive_Divide stack_access_size 8))
      match stack_access_size with
      | 16 => do
        let (parameter_16, _) ← Pop_Stack (← get).SS param_offset 16 16
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 16 16 parameter_16 false)
      | 32 => do
        let (parameter_32, _) ← Pop_Stack (← get).SS param_offset 32 32
        new_rsp := (← Push_Stack new_ss new_rsp new_cs 32 32 parameter_32 false)
      | _ => do
        Std.Unreachable

    return new_rsp

end X86.Helpers
