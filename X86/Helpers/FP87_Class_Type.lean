-- Generated from data/definitions.xml.gz: FP87_Class_Type; do not edit.
-- Source SHA256: f68223fe7f09805994a7990b8c691b8d3587199bf79a12bc822694aa3dd10bb2
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87_Class_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

inductive FP87_Class_Type where
  | FP87_Class_Unsupported
  | FP87_Class_QNaN
  | FP87_Class_SNaN
  | FP87_Class_Normal
  | FP87_Class_Infinity
  | FP87_Class_Zero
  | FP87_Class_Denormal
  deriving Repr, DecidableEq, Inhabited

end X86.Helpers
