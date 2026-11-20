-- Generated from data/definitions.xml.gz: Check_Split_Lock; do not edit.
-- Source SHA256: 17c79e396818c8d8df38e2eb67cb78921c1444e01b7805c7c58c48ef86fd407e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Split_Lock)
import X86.Runtime
import X86.Helpers.Is_Cache_Split_Access
import X86.Helpers.Report_Alignment_Check_Exception
import X86.Helpers.Std.Bits.Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Config.Value.Cache_Line_Size]

def Check_Split_Lock
    (physical_address : Bits 64) (size : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  if (← Is_Cache_Split_Access physical_address size) then
    if ((← get).MEMORY_CONTROL.SPLIT_LOCK_DISABLE == 1) then
      liftM (Report_Alignment_Check_Exception (← Std.Bits.Zero 32))

end X86.Helpers
