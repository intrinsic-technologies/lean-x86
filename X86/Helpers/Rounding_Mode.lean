-- Generated from a local ISA specification; do not edit.
-- Source SHA256: fd2e9f5be701912f05d469fa88eacae81cf08748f0bceb0a8b7b07a7c4d76b3e
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Rounding_Mode where
  | Rounding_Mode_RNE
  | Rounding_Mode_RTN
  | Rounding_Mode_RTP
  | Rounding_Mode_RTZ
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
