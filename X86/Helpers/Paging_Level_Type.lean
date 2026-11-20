-- Generated from data/definitions.xml.gz: Paging_Level_Type; do not edit.
-- Source SHA256: 130fdbd375f39b1972c05aaf376ee60aa65925c017ae86fe2ea101fed6b3c9a4
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Paging_Level_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive Paging_Level_Type where
  | Paging_Level_Unknown
  | PDE
  | PTE
  | PDPTE
  | PML4E
  | PML5E
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
