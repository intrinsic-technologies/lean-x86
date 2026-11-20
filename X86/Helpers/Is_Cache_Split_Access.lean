-- Generated from data/definitions.xml.gz: Is_Cache_Split_Access; do not edit.
-- Source SHA256: 167b022ed0cff8d3e1c10f6a8868322e921aed6dcb372548f89bcf6d1cfd9d49
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Cache_Split_Access)
import X86.Runtime
import X86.Helpers.Std.Integer.Positive_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable
  [X86.Config.Value.Cache_Line_Size]

def Is_Cache_Split_Access
    (address : Bits 64) (size_in_bits : Int) :
    Except (Runtime.Error Empty) (Bool) := do
  let size_in_bytes : Int ← Std.Integer.Positive_Divide size_in_bits 8
  let start_address : Int := Unsigned address
  let end_address : Int := start_address + size_in_bytes - 1
  return (← (do Runtime.assert (decide (0 < (← Config.Read.Cache_Line_Size (exception := Empty)))); Runtime.assert (decide (0 ≤ start_address)); pure (← Std.Integer.Positive_Divide start_address (← Config.Read.Cache_Line_Size (exception := Empty))))) != (← (do Runtime.assert (decide (0 < (← Config.Read.Cache_Line_Size (exception := Empty)))); Runtime.assert (decide (0 ≤ end_address)); pure (← Std.Integer.Positive_Divide end_address (← Config.Read.Cache_Line_Size (exception := Empty)))))

end X86.Helpers
