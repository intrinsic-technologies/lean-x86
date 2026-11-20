-- Generated from data/definitions.xml.gz: Release_Parameters; do not edit.
-- Source SHA256: 491b6cff53e7eb85224a6b9248fbb1a9e9952569ea81ea20a409a7831a7f6200
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Release_Parameters)
import X86.Runtime
import X86.Helpers.Segment
import X86.Helpers.Stack_Address_Size
import X86.Helpers.Std.Bits.Is_Zero
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Release_Parameters
    (stack_segment : Segment) (curr_rsp : Bits 64) (parameter_count : Bits 16) :
    Runtime.SpecM Exception (State σ) (Bits 64) := do
  if (← Std.Bits.Is_Zero (size := 16) parameter_count) then
    return curr_rsp
  else
    let mut new_rsp : Bits 64 := curr_rsp + (← Std.Bits.Zero_Extend (source_size := 16) parameter_count 64)
    let stack_address_size : Int ← Stack_Address_Size stack_segment

    if (stack_address_size == 16) then
      new_rsp := (← setSliceChecked new_rsp 16 48 (← curr_rsp[63:16]))
    else
      if (stack_address_size == 32) then
        new_rsp := (← setSliceChecked new_rsp 32 32 (← Std.Bits.Zero 32))

    return new_rsp

end X86.Helpers
