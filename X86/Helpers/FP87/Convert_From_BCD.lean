-- Generated from data/definitions.xml.gz: FP87::Convert_From_BCD; do not edit.
-- Source SHA256: 71c9520e0c5cabc4ef6d3962008c1159717f2aeeab7cb6b80a3e582ee06ac4b2
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AConvert_From_BCD)
import X86.Runtime
import X86.Helpers.Emulate_FBLD
import X86.Helpers.F80_Type
import X86.Helpers.FP_Exception_Flags_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def FP87.Convert_From_BCD
    (x : Bits 80) :
    Runtime.PartialSpecM Exception (State σ) (F80_Type) := do
  let (result, _, _) ← Emulate_FBLD x
  return result

end X86.Helpers
