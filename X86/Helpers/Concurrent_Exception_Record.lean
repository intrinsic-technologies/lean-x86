-- Generated from data/definitions.xml.gz: Concurrent_Exception_Record; do not edit.
-- Source SHA256: 085031d4cc96326c6bae016f6ed3497bd25af500e3b99b7b5ab3ae8a87e7dfe4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Concurrent_Exception_Record)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

structure Concurrent_Exception_Record where
  vector : Int
  valid : Bool
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
