-- Generated from data/definitions.xml.gz: Byte_Reverse; do not edit.
-- Source SHA256: 14db8758ebe282081dcdba1fcb54cc442a1558717912bf58cc8bd0986b55f307
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Byte_Reverse)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Byte_Reverse
    (N : Int) (x : Bits ((8 : Int) * N)) :
    Except (Runtime.Error Empty) (Bits ((8 : Int) * N)) := do
  Runtime.assert (0 ≤ N)

  let mut r : Runtime.InitializedBits ((8 : Int) * N) := Runtime.InitializedBits.empty ((8 : Int) * N)
  for i in intRange (0 : Int) (N - 1) do
    let j : Int := N - 1 - i
    let __check132 : Int := i * 8
    Runtime.assert (decide (__check132 + 8 ≤ 8 * N))
    Runtime.assert (decide (0 ≤ __check132))
    r := (← Runtime.InitializedBits.writeSlice r __check132 8 (← (do Runtime.assert (decide (j * 8 + 8 ≤ 8 * N)); Runtime.assert (decide (0 ≤ j * 8)); pure (← x[j * 8 +: 8]))))
  return (← Runtime.InitializedBits.read r)

end X86.Helpers
