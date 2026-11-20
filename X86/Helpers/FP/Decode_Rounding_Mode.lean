-- Generated from data/definitions.xml.gz: FP::Decode_Rounding_Mode; do not edit.
-- Source SHA256: b524b0277fd1f70002e360219ce1fc1baa47db5b633993804a1a10eb9644e343
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3ADecode_Rounding_Mode)
import X86.Runtime
import X86.Helpers.Rounding_Mode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP.Decode_Rounding_Mode (rc : Bits 2) : Except (Runtime.Error Empty) (Rounding_Mode) := do
  match Unsigned rc with
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
