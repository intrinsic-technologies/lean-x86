-- Generated from the decoder generator: explicit unsupported-map implementation; data/definitions.xml.gz: Fetch_And_Execute map reference, not an implementation; do not edit.
-- Source SHA256: c6192543be690cbdef8875b13e2046798f0ecb301f78912235e72ba13dd55963
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

def Decode_VEX_7
    (_ip : Bits 64) (_context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  Unimplemented_Feature "unselected Decode_VEX_7 instruction" false true

end X86.Helpers
