-- Generated from the decoder generator: explicit unsupported-map implementation; data/definitions.xml.gz: Fetch_And_Execute map reference, not an implementation; do not edit.
-- Source SHA256: 8ea79f57992768722d26867eb083f3d0c5638abb861c89be08bdd9c169bbd785
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Unimplemented_Feature
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Helpers.Unimplemented_Feature.Binding σ]

def Decode_VEX_3
    (_ip : Bits 64) (_context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Unimplemented_Feature "unselected Decode_VEX_3 instruction" false true

end X86.Helpers
