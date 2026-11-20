-- Generated from data/definitions.xml.gz: EPT::Get_Exit_Qualification; do not edit.
-- Source SHA256: 8a0f421f360d3254b992768e5c034f7ccf3aad1bd331ff97e401cc31dc0bdf59
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=EPT%3A%3AGet_Exit_Qualification)
import X86.Runtime
import X86.Helpers.EPT_Entries_Combined_Access_Permissions_Type
import X86.Helpers.EPT_Exit_Qualification_Type
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Translation
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class EPT.Get_Exit_Qualification.Binding (σ : Type) where
  call (translation : Translation) (access_type : Memory_Access_Type) (ept_access_permissions : EPT_Entries_Combined_Access_Permissions_Type) (is_page_walk_access : Bool) :
    Runtime.SpecM Empty (State σ) (EPT_Exit_Qualification_Type)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] EPT.Get_Exit_Qualification.Binding

variable {σ : Type}

variable
  [X86.Helpers.EPT.Get_Exit_Qualification.Binding σ]

def EPT.Get_Exit_Qualification
    (translation : Translation) (access_type : Memory_Access_Type) (ept_access_permissions : EPT_Entries_Combined_Access_Permissions_Type) (is_page_walk_access : Bool) :
    Runtime.SpecM Exception (State σ) (EPT_Exit_Qualification_Type) := do
  Runtime.liftNoSourceException (EPT.Get_Exit_Qualification.Binding.call translation access_type ept_access_permissions is_page_walk_access)

end X86.Helpers
