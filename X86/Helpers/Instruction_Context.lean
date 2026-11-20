-- Generated from data/definitions.xml.gz: Instruction_Context; do not edit.
-- Source SHA256: 7d5fd879d48d9ba15b75222f1b2d1fdfa14775e4ac89e2c7881a873379920a2e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Instruction_Context)
import X86.Runtime
import X86.Helpers.Execution_Mode
import X86.Helpers.Segment

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

structure Instruction_Context where
  segment : Segment
  seg_prefix_present : Bool
  lock_prefix_present : Bool
  osz_prefix_present : Bool
  asz_prefix_present : Bool
  rex_prefix_present : Bool
  vex_prefix_present : Bool
  evex_prefix_present : Bool
  rep_prefix : Int
  rex2_prefix_present : Bool
  no_track_prefix : Bool
  mode : Execution_Mode
  is_mode64 : Bool
  rex_w : Runtime.Bit
  rex_r3 : Runtime.Bit
  rex_r4 : Runtime.Bit
  rex_x3 : Runtime.Bit
  rex_x4 : Runtime.Bit
  rex_b3 : Runtime.Bit
  rex_b4 : Runtime.Bit
  vvvv : Bits 4
  evex_v4 : Runtime.Bit
  vex_LL : Bits 2
  vex_pp : Bits 2
  evex_z : Runtime.Bit
  evex_LLRC : Bits 2
  evex_b : Runtime.Bit
  evex_aaa : Bits 3
  evex_u : Runtime.Bit
  evex_dfv : Bits 4
  evex_nd : Runtime.Bit
  evex_nf : Runtime.Bit
  evex_scc : Bits 4
  operand_size : Int
  address_size : Int
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
