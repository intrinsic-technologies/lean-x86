-- Generated from data/definitions.xml.gz: Check_Extended_Prefix_Conflicts; do not edit.
-- Source SHA256: 2dcb996ad4cf92194dc90cdc12593a2d7f221364dfa9645e4b48d6c8cfddd961
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Check_Extended_Prefix_Conflicts)
import X86.Runtime
import X86.Helpers.Instruction_Context
import X86.Helpers.Report_Invalid_Opcode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Check_Extended_Prefix_Conflicts (context : Instruction_Context) : Result Unit := do
  -- todo: check that this only leaves segment and asz prefixes
  if (context.lock_prefix_present or context.rex_prefix_present or context.osz_prefix_present or context.rep_prefix != 0) then
    liftM (Report_Invalid_Opcode)

  return ()

end X86.Helpers
