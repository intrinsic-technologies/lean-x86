-- Generated from data/definitions.xml.gz: Get_Instruction_Breakpoint_Match; do not edit.
-- Source SHA256: b00746b8b9ae785500ff8d0a636f217b814429900bc4611d3263fb4c59546a88
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_Instruction_Breakpoint_Match)
import X86.Runtime
import X86.Helpers.BP
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.Get_Breakpoint_Properties
import X86.Helpers.Num_Debug_Breakpoints
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Get_Instruction_Breakpoint_Match  : Runtime.SpecM Exception (State σ) (Bool × Bits 4) := do
  let linear_address : Bits 64 ← Compute_Linear_Address (← get).CS (← get).RIP (← get).CS
  let mut address_match : Bool := false
  let mut matched : Bits 4 ← Std.Bits.Zero 4

  for i in intRange (0 : Int) (Num_Debug_Breakpoints - 1) do
    let (bp_enabled, bp_cond, bp_address, _) ← Get_Breakpoint_Properties i

    if (bp_enabled and bp_cond == BP_InstructionExecution and bp_address == linear_address) then
      Runtime.assert (decide (i < 4))
      matched := (← setSliceChecked matched i 1 1)
      address_match := true

  return (address_match, matched)

end X86.Helpers
