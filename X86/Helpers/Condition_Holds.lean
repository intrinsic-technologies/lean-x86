-- Generated from data/definitions.xml.gz: Condition_Holds; do not edit.
-- Source SHA256: 394dccd46370153bd59614cf08413f47a804719dc8fcfe0d26175f8ab1acd8a0
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Condition_Holds)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def Condition_Holds (cond : Bits 4) : Runtime.SpecM Exception (State σ) (Bool) := do
  let mut result : Bool ←
    match Unsigned (← cond[3:1]) with
    | 0b000 => do
      pure ((← RFLAGS.OF) == 1)
    | 0b001 => do
      pure ((← RFLAGS.CF) == 1)
    | 0b010 => do
      pure ((← RFLAGS.ZF) == 1)
    | 0b011 => do
      pure ((← RFLAGS.CF) == 1 or (← RFLAGS.ZF) == 1)
    | 0b100 => do
      pure ((← RFLAGS.SF) == 1)
    | 0b101 => do
      pure ((← RFLAGS.PF) == 1)
    | 0b110 => do
      pure ((← RFLAGS.SF) != (← RFLAGS.OF))
    | 0b111 => do
      pure ((← RFLAGS.ZF) == 1 or (← RFLAGS.SF) != (← RFLAGS.OF))
    | _ => throw .unmatchedCase
  return if (← cond[0 +: 1]) == 0 then result else not result

end X86.Helpers
