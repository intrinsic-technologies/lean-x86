-- Generated from data/definitions.xml.gz: FP87::Expand_Abridged_Tag_Word; do not edit.
-- Source SHA256: d99c9db001474d7af95d88ebf005b8ade7e467e6280df301c381a619b67a99df
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AExpand_Abridged_Tag_Word)
import X86.Runtime
import X86.Helpers.FP87.Get_Tag_Word_Value
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Expand_Abridged_Tag_Word
    (abridged_value : Bits 8) :
    Runtime.SpecM Exception (State σ) (Bits 16) := do
  let mut tag_word : Runtime.InitializedBits 16 := Runtime.InitializedBits.empty 16

  for i in intRange (0 : Int) (7 : Int) do
    Runtime.assert (decide (i * 2 ≤ 14))
    tag_word := (← Runtime.InitializedBits.writeSlice tag_word (i * (2 : Int)) 2 (← (do if (← abridged_value[i +: 1]) == 0 then pure (3 : Bits 2) else pure (← FP87.Get_Tag_Word_Value (← (do Runtime.assert (decide (i < 8)); pure (← FP87.get i)))))))

  return (← Runtime.InitializedBits.read tag_word)

end X86.Helpers
