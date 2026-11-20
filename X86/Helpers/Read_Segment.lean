-- Generated from data/definitions.xml.gz: Read_Segment; do not edit.
-- Source SHA256: aee2e131010e49aa48cae45e621346b6b0da4c41356e9072e7964145e82134af
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Read_Segment)
import X86.Runtime
import X86.Helpers.Std.Unreachable
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Read_Segment (rrr : Bits 3) : Runtime.SpecM Exception (State σ) (Bits 16) := do
  match Unsigned rrr with
  | 0b000 => do
    return (← get).ES.selector
  | 0b001 => do
    return (← get).CS.selector
  | 0b010 => do
    return (← get).SS.selector
  | 0b011 => do
    return (← get).DS.selector
  | 0b100 => do
    return (← get).FS.selector
  | 0b101 => do
    return (← get).GS.selector
  | _ => do
    Std.Unreachable

end X86.Helpers
