-- Generated from data/definitions.xml.gz: Invalidate_Inaccessible_Data_Segments; do not edit.
-- Source SHA256: 0ef15ae1aa4329996c6f4cadc812b0b5375fd6072a68f4650518e9115699858c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Invalidate_Inaccessible_Data_Segments)
import X86.Runtime
import X86.Helpers.Get_Segment_Base
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Invalidate_Inaccessible_Data_Segment
import X86.Helpers.Set_Segment_Base
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Invalidate_Inaccessible_Data_Segments
    (new_cpl : Bits 2) :
    Runtime.SpecM Exception (State σ) Unit := do
  let fs_base : Bits 64 ← Get_Segment_Base (← get).FS
  let gs_base : Bits 64 ← Get_Segment_Base (← get).GS

  DS.assign (← Invalidate_Inaccessible_Data_Segment new_cpl (← get).DS)
  ES.assign (← Invalidate_Inaccessible_Data_Segment new_cpl (← get).ES)
  FS.assign (← Invalidate_Inaccessible_Data_Segment new_cpl (← get).FS)
  GS.assign (← Invalidate_Inaccessible_Data_Segment new_cpl (← get).GS)

  if (← In_64Bit_Mode) then
    if (not (← Runtime.readInitialized (← get).FS.descriptor_valid)) then
      FS.assign (← Set_Segment_Base fs_base (← get).FS)

    if (not (← Runtime.readInitialized (← get).GS.descriptor_valid)) then
      GS.assign (← Set_Segment_Base gs_base (← get).GS)

end X86.Helpers
