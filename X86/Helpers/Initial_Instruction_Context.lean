-- Generated from data/definitions.xml.gz: Initial_Instruction_Context; do not edit.
-- Source SHA256: 4cdb18ee4a703d50f59fc464bfb48dfa9de2cb16692261ee25d52ac1774dcb98
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Initial_Instruction_Context)
import X86.Runtime
import X86.Helpers.Current_Mode
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Initial_Instruction_Context  : Runtime.SpecM Exception (State σ) (Instruction_Context) := do
  return ({
    segment := (← get).DS,
    seg_prefix_present := false,
    lock_prefix_present := false,
    osz_prefix_present := false,
    asz_prefix_present := false,
    rex_prefix_present := false,
    vex_prefix_present := false,
    evex_prefix_present := false,
    rep_prefix := 0,
    rex2_prefix_present := false,
    no_track_prefix := false,
    mode := (← Current_Mode),
    is_mode64 := (← In_64Bit_Mode),
    rex_w := 0,
    rex_r3 := 0,
    rex_r4 := 0,
    rex_x3 := 0,
    rex_x4 := 0,
    rex_b3 := 0,
    rex_b4 := 0,
    vvvv := 0,
    evex_v4 := 0,
    vex_LL := 0,
    vex_pp := 0,
    evex_z := 0,
    evex_LLRC := 0,
    evex_b := 0,
    evex_aaa := 0,
    evex_u := 0,
    evex_dfv := 0,
    evex_nd := 0,
    evex_nf := 0,
    evex_scc := 0,
    operand_size := 32,
    address_size := 32
  } : Instruction_Context)

end X86.Helpers
