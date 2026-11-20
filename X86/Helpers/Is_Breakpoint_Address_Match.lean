-- Generated from data/definitions.xml.gz: Is_Breakpoint_Address_Match; do not edit.
-- Source SHA256: 0f1220a9ffa56942db429c86edad6f5ecc9eee4bf59ca08c6948bc40114f9bf9
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Breakpoint_Address_Match)
import X86.Runtime
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Subtract_int
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Is_Breakpoint_Address_Match
    (bp_address : Bits 64) (bp_length : Bits 2) (first_byte_address : Bits 64) (num_bytes : Int) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  let last_byte_address : Bits 64 ← Std.Bits.Subtract_int (n := 64) (← Std.Bits.Add_int (n := 64) first_byte_address num_bytes) 1

  let bp_first_byte_address : Bits 64 ← do
    if bp_length == 0 then
      pure bp_address
    else
      if bp_length == 1 then
        concatBits (leftSize := 63) (rightSize := 1) (← bp_address[63:1]) (0 : Runtime.Bit)
      else
        if bp_length == 2 then
          concatBits (leftSize := 61) (rightSize := 3) (← bp_address[63:3]) (0 : Bits 3)
        else
          if bp_length == 3 then
            concatBits (leftSize := 62) (rightSize := 2) (← bp_address[63:2]) (0 : Bits 2)
          else
            UNSPECIFIED (size := 64)

  let bp_last_byte_address : Bits 64 ← do
    if bp_length == 0 then
      pure bp_first_byte_address
    else
      if bp_length == 1 then
        Std.Bits.Add_int (n := 64) bp_first_byte_address 1
      else
        if bp_length == 2 then
          Std.Bits.Add_int (n := 64) bp_first_byte_address 7
        else
          if bp_length == 3 then
            Std.Bits.Add_int (n := 64) bp_first_byte_address 3
          else
            UNSPECIFIED (size := 64)

  return not (decide (Unsigned first_byte_address > Unsigned bp_last_byte_address) or decide (Unsigned last_byte_address < Unsigned bp_first_byte_address))

end X86.Helpers
