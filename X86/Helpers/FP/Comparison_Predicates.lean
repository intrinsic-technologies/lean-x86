-- Generated from data/definitions.xml.gz: FP::Comparison_Predicates; do not edit.
-- Source SHA256: e7844107242c13bf4957b824371ff52288dc94ad8e4ab56a981a8bde5dd3cd03
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=FP%3A%3AComparison_Predicates)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def EQ_OQ : Bits 5 := 0

def LT_OS : Bits 5 := 1

def LE_OS : Bits 5 := 2

def UNORD_Q : Bits 5 := 3

def NEQ_UQ : Bits 5 := 4

def NLT_US : Bits 5 := 5

def NLE_US : Bits 5 := 6

def ORD_Q : Bits 5 := 7

def EQ_UQ : Bits 5 := 8

def NGE_US : Bits 5 := 9

def NGT_US : Bits 5 := 10

def FALSE_OQ : Bits 5 := 11

def NEQ_OQ : Bits 5 := 12

def GE_OS : Bits 5 := 13

def GT_OS : Bits 5 := 14

def TRUE_UQ : Bits 5 := 15

def EQ_OS : Bits 5 := 16

def LT_OQ : Bits 5 := 17

def LE_OQ : Bits 5 := 18

def UNORD_S : Bits 5 := 19

def NEQ_US : Bits 5 := 20

def NLT_UQ : Bits 5 := 21

def NLE_UQ : Bits 5 := 22

def ORD_S : Bits 5 := 23

def EQ_US : Bits 5 := 24

def NGE_UQ : Bits 5 := 25

def NGT_UQ : Bits 5 := 26

def FALSE_OS : Bits 5 := 27

def NEQ_OS : Bits 5 := 28

def GE_OQ : Bits 5 := 29

def GT_OQ : Bits 5 := 30

def TRUE_US : Bits 5 := 31

end X86.Helpers
