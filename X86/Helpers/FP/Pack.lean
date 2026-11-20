-- Generated from a local ISA specification; do not edit.
-- Source SHA256: d1d67c628126a8b27925be75c6353a3d18c47b6c9dc43ea0c729d4d4cb37bcc9
import X86.Runtime
import X86.Helpers.UFloatCompare
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def FP.Pack {size : Int} {e_size : Int}
    (x : UFloat e_size size) :
    Except (Runtime.Error Empty) (Bits size) := do
  Runtime.assert (size == 16 || size == 32 || size == 64)
  Runtime.assert (e_size == 5 || e_size == 8 || e_size == 11)

  Runtime.assert (size == 32 and e_size == 8 or size == 64 and e_size == 11)
  return (BitVec.cast (by omega) (← concatBits (leftSize := 1) (rightSize := (size - (1 : Int))) (← Bit x.sign) x.magnitude) : Bits size)

end X86.Helpers
