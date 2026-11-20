-- Generated from data/definitions.xml.gz: Calculate_Offset; do not edit.
-- Source SHA256: a076dac7b1eb6c343b8a3098ccbf76243ea2bffbc28ee1aaa41ba9c469587bef
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Calculate_Offset)
import X86.Runtime
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Calculate_Offset
    (value : Bits 64) (offset address_size : Int) :
    Except (Runtime.Error Empty) (Bits 64) := do
  Runtime.assert ((address_size == (16 : Int)) || (address_size == (32 : Int)) || (address_size == (64 : Int)))
  let ea : Bits 64 ← Std.Bits.Add_int (n := 64) value offset
  return (← Std.Bits.Zero_Extend (source_size := address_size) (← ea[0 +: address_size]) 64)

end X86.Helpers
