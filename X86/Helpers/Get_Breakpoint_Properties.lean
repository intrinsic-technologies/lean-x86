-- Generated from data/definitions.xml.gz: Get_Breakpoint_Properties; do not edit.
-- Source SHA256: 4c4947a5626fbf0cfa657a94f96d4999233e54305b9d8a466f9aa31852ece850
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Get_Breakpoint_Properties)
import X86.Runtime
import X86.Helpers.Std.Unreachable
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Get_Breakpoint_Properties
    (bp_index : Int) :
    Runtime.SpecM Exception (State σ) (Bool × Bits 2 × Bits 64 × Bits 2) := do
  Runtime.assert (bp_index in {0..3})

  match bp_index with
  | 0 => do
    return ((← DR7.L0) == 1 or (← DR7.G0) == 1, (← DR7.RW0), (← get).DR0, (← DR7.LEN0))
  | 1 => do
    return ((← DR7.L1) == 1 or (← DR7.G1) == 1, (← DR7.RW1), (← get).DR1, (← DR7.LEN1))
  | 2 => do
    return ((← DR7.L2) == 1 or (← DR7.G2) == 1, (← DR7.RW2), (← get).DR2, (← DR7.LEN2))
  | 3 => do
    return ((← DR7.L3) == 1 or (← DR7.G3) == 1, (← DR7.RW3), (← get).DR3, (← DR7.LEN3))
  | _ => do
    Std.Unreachable

end X86.Helpers
