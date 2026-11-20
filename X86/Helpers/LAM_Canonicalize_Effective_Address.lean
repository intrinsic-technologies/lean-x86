-- Generated from data/definitions.xml.gz: LAM_Canonicalize_Effective_Address; do not edit.
-- Source SHA256: 2c8f270660ac5fc4eadef4ef0ad4ad5415d90d63e698a05f466ce77bd76a2c09
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=LAM_Canonicalize_Effective_Address)
import X86.Runtime
import X86.Helpers.Is_Canonical_Wrt_Position
import X86.Helpers.Std.Bits.Sign_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def LAM_Canonicalize_Effective_Address
    (orig_ea : Bits 64) :
    Except (Runtime.Error Empty) (Bits 64) := do
  let mut ea : Bits 64 := orig_ea
  if (not (← Is_Canonical_Wrt_Position orig_ea 49)) then
    ea := (← setSliceChecked ea 49 1 (~~~ (← orig_ea[48 +: 1])))
    ea := (← Std.Bits.Sign_Extend (source_size := 50) (← ea[0 +: 50]) 64)

  return ea

end X86.Helpers
