-- Generated from data/definitions.xml.gz: Is_Page_Fault; do not edit.
-- Source SHA256: babf7d60a5d948bc6aa2963a90c96be601a266c382f63ea57949a9c0e745a5e8
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Page_Fault)
import X86.Runtime
import X86.Helpers.Exception_Vector_Numbers
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_Page_Fault (vector : Int) : Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (vector in {0..255})

  return ((vector == PF_Exception) || (vector == VE_Exception))

end X86.Helpers
