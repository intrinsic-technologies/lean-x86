-- Generated from data/definitions.xml.gz: FP87::Synchronize; do not edit.
-- Source SHA256: 2f3dfaa2be7900519b3c7dcadf81da33ebe43727d814ad5ba9475a966638c293
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3ASynchronize)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def FP87.Synchronize  : Except (Runtime.Error Empty) Unit := do
  pure ()

end X86.Helpers
