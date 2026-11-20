-- Generated from data/definitions.xml.gz: VM_Exit; do not edit.
-- Source SHA256: 52d99d0f056b95115b5b6497a090bf58cd6bfa5015036f7b1851c4c67ef381ca
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=VM_Exit)
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class VM_Exit.Binding (σ : Type) where
  call (basic_exit_reason : Bits 16) :
    Runtime.SpecM Exception (State σ) Empty

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] VM_Exit.Binding

variable {σ : Type}

variable
  [X86.Helpers.VM_Exit.Binding σ]

def VM_Exit (basic_exit_reason : Bits 16) : Runtime.SpecM Exception (State σ) Unit := do
  try
    nomatch (← VM_Exit.Binding.call basic_exit_reason)
  catch
    | .raised (.Exception_Info exception) =>
      Runtime.assert ((exception).vector in {0..255})
      throw (.raised (.Exception_Info exception))
    | error => throw error

end X86.Helpers
