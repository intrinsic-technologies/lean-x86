-- Generated from data/definitions.xml.gz: FP87::Calculate_Abridged_Tag_Word; do not edit.
-- Source SHA256: e2b35ce9fdedd80422bddc5450bd9163a89bada6d45df5effcc902e973dbc0b3
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ACalculate_Abridged_Tag_Word)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

def FP87.Calculate_Abridged_Tag_Word  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  let mut ftw8 : Runtime.InitializedBits 8 := Runtime.InitializedBits.empty 8

  for i in intRange (0 : Int) (7 : Int) do
    Runtime.assert (decide (i < 8))
    ftw8 := (← Runtime.InitializedBits.writeSlice ftw8 i 1 (if (← (do Runtime.assert (decide (i * 2 ≤ 14)); pure (← sliceElement (← get).FP87_Tag_Word 2 i))) == 3 then (0 : Runtime.Bit) else (1 : Runtime.Bit)))

  return (← Runtime.InitializedBits.read ftw8)

end X86.Helpers
