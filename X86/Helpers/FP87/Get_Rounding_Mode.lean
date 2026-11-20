-- Generated from data/definitions.xml.gz: FP87::Get_Rounding_Mode; do not edit.
-- Source SHA256: 673152a79e233952859afb4995db1b07844990a39cf53f7066371372cbf2eb99
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AGet_Rounding_Mode)
import X86.Runtime
import X86.Helpers.FP87_Control_Type
import X86.Helpers.Rounding_Mode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Get_Rounding_Mode  : Runtime.SpecM Exception (State σ) (Rounding_Mode) := do
  match Unsigned (← FP87_Control.RC) with
  | 0b00 => do
    return Rounding_Mode.Rounding_Mode_RNE
  | 0b01 => do
    return Rounding_Mode.Rounding_Mode_RTN
  | 0b10 => do
    return Rounding_Mode.Rounding_Mode_RTP
  | 0b11 => do
    return Rounding_Mode.Rounding_Mode_RTZ
  | _ => throw .unmatchedCase

end X86.Helpers
