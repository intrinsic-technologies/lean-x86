-- Generated from data/definitions.xml.gz: IA32_SSP; do not edit.
-- Source SHA256: bec37ad6464d00a10cf19f026d4f45206fedb12fb967995849ddddec1d43b55a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=IA32_SSP)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def IA32_SSP (privilege_level : Bits 2) : Runtime.SpecM Exception (State σ) (SSP_Type) := do
  match Unsigned privilege_level with
  | 0b00 => do
    return (← get).IA32_PL0_SSP
  | 0b01 => do
    return (← get).IA32_PL1_SSP
  | 0b10 => do
    return (← get).IA32_PL2_SSP
  | 0b11 => do
    return (← get).IA32_PL3_SSP
  | _ => throw .unmatchedCase

end X86.Helpers
