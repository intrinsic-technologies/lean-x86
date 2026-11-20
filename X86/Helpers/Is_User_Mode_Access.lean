-- Generated from data/definitions.xml.gz: Is_User_Mode_Access; do not edit.
-- Source SHA256: cbe3bc52fb970de9d81eae855defd1239d1ddd27a005cdf4e1d1eb47fba5e649
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_User_Mode_Access)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_User_Mode_Access (linear : Address_Translation) : Except (Runtime.Error Empty) (Bool) := do
  return linear.translation_cpl == 3 and not linear.is_implicit_supervisor_mode_access

end X86.Helpers
