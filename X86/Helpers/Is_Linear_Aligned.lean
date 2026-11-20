-- Generated from data/definitions.xml.gz: Is_Linear_Aligned; do not edit.
-- Source SHA256: e7ae6be0a1bc6b4bf7dd95cfb1dd22999e417c4d64e985adcd8b34c0fa170c40
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_Linear_Aligned)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.Compute_Linear_Address
import X86.Helpers.Create_Logical_Address
import X86.Helpers.Is_Aligned
import X86.Helpers.Segment
import X86.Helpers.Std.Integer.Positive_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Is_Linear_Aligned
    (segment : Segment) (offset : Bits 64) (size : Int) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  Runtime.assert ((size == (8 : Int)) || (size == (16 : Int)) || (size == (32 : Int)) || (size == (64 : Int)) || (size == (80 : Int)) || (size == (128 : Int)) || (size == (256 : Int)) || (size == (384 : Int)) || (size == (512 : Int)) || (size == (1024 : Int)))

  let logical : Address_Translation ← Create_Logical_Address segment offset size
  let linear_address : Bits 64 ← Compute_Linear_Address logical.segment logical.offset (← get).CS
  return (← Is_Aligned (n := 64) linear_address (← Std.Integer.Positive_Divide size 8))

end X86.Helpers
