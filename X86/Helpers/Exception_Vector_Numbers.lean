-- Generated from data/definitions.xml.gz: Exception Vector Numbers; do not edit.
-- Source SHA256: 735f9f5523dc342884d67dad20b5e406eaa07619e972b98b70d7062d7c33768a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Exception%20Vector%20Numbers)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

def DE_Exception : Int := 0

def DB_Exception : Int := 1

def UD_Exception : Int := 6

def NM_Exception : Int := 7

def DF_Exception : Int := 8

def TS_Exception : Int := 10

def NP_Exception : Int := 11

def SS_Exception : Int := 12

def GP_Exception : Int := 13

def PF_Exception : Int := 14

def MF_Exception : Int := 16

def AC_Exception : Int := 17

def XM_Exception : Int := 19

def VE_Exception : Int := 20

def CP_Exception : Int := 21

end X86.Helpers
