-- Generated from data/definitions.xml.gz: Segment; do not edit.
-- Source SHA256: 27a23b2075cacb34e37ff7a3caf14d0b83c632b3a5435ffdf6e3abbccb278421
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Segment)
import X86.Runtime
import X86.Helpers.Descriptor_High
import X86.Helpers.Segment_Descriptor
import X86.Helpers.Segment_Selector

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

structure Segment where
  selector : Segment_Selector
  -- The mask preserves bits that have not been initialized.
  descriptor : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  -- The mask preserves bits that have not been initialized.
  descriptor_high : Runtime.InitializedBits 64 := Runtime.InitializedBits.empty 64
  -- None preserves a source field that has not been initialized.
  descriptor_valid : Option (Bool) := none
  -- None preserves a source field that has not been initialized.
  is_stack : Option (Bool) := none
  -- None preserves a source field that has not been initialized.
  is_code : Option (Bool) := none
  -- None preserves a source field that has not been initialized.
  is_64bit_mode_data_segment : Option (Bool) := none
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
