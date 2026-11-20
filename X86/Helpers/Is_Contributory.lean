-- Generated from data/definitions.xml.gz: Is_Contributory; do not edit.
-- Source SHA256: 4789e58b862a266ed8d603dbf474e4482b4e19eddaa8372d6f35f2a25ee92438
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Contributory)
import X86.Runtime
import X86.Helpers.Exception_Vector_Numbers
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Is_Contributory (vector : Int) : Except (Runtime.Error Empty) (Bool) := do
  Runtime.assert (vector in {0..255})

  return ((vector == DE_Exception) || (vector == TS_Exception) || (vector == NP_Exception) || (vector == SS_Exception) || (vector == GP_Exception) || (vector == CP_Exception))

end X86.Helpers
