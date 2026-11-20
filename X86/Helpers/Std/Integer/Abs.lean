-- Generated from isa-tools/stdlib/stdlib.isa: reachable source declarations; do not edit.
-- Source SHA256: fcb9eb570aea13d1bba8211ef6d957a3bfdc9f18eccaee52b8a3442b5cf1e8cc
-- [isa-tools standard library](https://github.com/IntelLabs/isa-tools/blob/16260979137c38339743a04b7fd5d9f0fa8a6ee5/stdlib.isa)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- omit since they are auto-generated
-- __operator2 == = eq_bool;
-- __operator2 != = ne_bool;

def Std.Integer.Abs (x : Int) : Except (Runtime.Error Empty) (Int) := do
  return if decide (x ≥ 0) then x else - x

end X86.Helpers
