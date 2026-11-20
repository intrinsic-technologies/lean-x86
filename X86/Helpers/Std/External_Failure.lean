-- Generated from a local ISA specification; do not edit.
-- Source SHA256: bc10bc37c91cfdcbf5d4f1f372cb12164f85b5d3f9acc94dfc47d60819af6a3a
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The source declares this builtin without an ISA body.
def Std.External_Failure {α : Type} {exception : Type} {m : Type → Type}
    [Monad m] [MonadExcept (Runtime.Error exception) m]
    (message : String) : m α := do
  Runtime.externalFailure message

end X86.Helpers
