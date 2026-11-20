-- Generated from data/definitions.xml.gz: Std::Bits::Length; do not edit.
-- Source SHA256: dbdabc3885d4e7e9850dbd02f4f78cc4eee7c17d42620a875abe536b70d2af5a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Std%3A%3ABits%3A%3ALength)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def Std.Bits.Length {size : Int} (_a : Bits size) : Except (Runtime.Error Empty) (Int) := do
  Runtime.assert (0 ≤ size)

  return size

end X86.Helpers
