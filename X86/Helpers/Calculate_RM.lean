-- Generated from data/definitions.xml.gz: Calculate_RM; do not edit.
-- Source SHA256: f7e33ff7b5a2bd31e8404ba295b906e1e25bef2b5e20e83ae7f1af7152af9dad
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Calculate_RM)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Calculate_RM
    (mod : Bits 2) (rm : Bits 3) (context : Instruction_Context) :
    Except (Runtime.Error Empty) (Bits 5) := do
  let sib_encoding : Bool := mod != 3 and rm == 4
  let mut retval : Bits 5 ← concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) rm

  if (not sib_encoding) then
    -- for sib encodings, REX.B extends the sib.base field
    -- otherwise it extends the RM field
    Runtime.assert (decide (3 < 2 + 3))
    retval := (← setSliceChecked retval 3 1 context.rex_b3)

    -- EVEX.X3 encodes MOD bit 4 when SIB absent
    Runtime.assert (decide (4 < 2 + 3))
    retval := (← setSliceChecked retval 4 1 (if mod == 3 and context.evex_prefix_present then context.rex_x3 else context.rex_b4))

  return retval

end X86.Helpers
