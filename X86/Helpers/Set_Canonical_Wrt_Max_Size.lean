-- Generated from data/definitions.xml.gz: Set_Canonical_Wrt_Max_Size; do not edit.
-- Source SHA256: 5441ec5b9fdc4d07f19e5be455ce83917c807d278544c46523bdd65f20da5308
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Set_Canonical_Wrt_Max_Size)
import X86.Runtime
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable
  [X86.Config.Value.Max_Linear_Address]

def Set_Canonical_Wrt_Max_Size (address : Bits 64) : Except (Runtime.Error Empty) (Bits 64) := do
  let position : Int ← Config.Read.Max_Linear_Address (exception := Empty)

  return (← (do if (← address[position - 1 +: 1]) == 0 then pure (BitVec.cast (by omega) (← concatBits (leftSize := ((64 : Int) - position)) (rightSize := position) (← Std.Bits.Zero (64 - position)) (← address[0 +: position])) : Bits 64) else pure (BitVec.cast (by omega) (← concatBits (leftSize := ((64 : Int) - position)) (rightSize := position) (← Std.Bits.All_Ones (64 - position)) (← address[0 +: position])) : Bits 64)))

end X86.Helpers
