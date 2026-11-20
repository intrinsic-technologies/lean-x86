-- Generated from data/definitions.xml.gz: FP87::Comparison_Constants; do not edit.
-- Source SHA256: bb67c1e1877c7a28f6ffea0205e257d2191c37b4e381dd52396b536f09f718cd
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP87%3A%3AComparison_Constants)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def FP87_COMPARE_EQUAL : Bits 3 := 4

def FP87_COMPARE_LESS_THAN : Bits 3 := 1

def FP87_COMPARE_GREATER_THAN : Bits 3 := 0

def FP87_COMPARE_INVALID : Bits 3 := 7

end X86.Helpers
