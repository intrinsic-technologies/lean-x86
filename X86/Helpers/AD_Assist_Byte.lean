-- Generated from data/definitions.xml.gz: AD_Assist_Byte; do not edit.
-- Source SHA256: 9db7ebca44b3334556fe263b462a4acd4e5d18e4dece0cf79b2ffbe4bf4b6499
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=AD_Assist_Byte)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev AD_Assist_Byte := Bits 8

def AD_Assist_Byte.A (bits : AD_Assist_Byte) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def AD_Assist_Byte.setA (bits : AD_Assist_Byte) (value : Runtime.Bit) : AD_Assist_Byte :=
  setSlice bits 5 1 value

def AD_Assist_Byte.D (bits : AD_Assist_Byte) : Runtime.Bit :=
  BitVec.extractLsb' 6 1 bits

def AD_Assist_Byte.setD (bits : AD_Assist_Byte) (value : Runtime.Bit) : AD_Assist_Byte :=
  setSlice bits 6 1 value

def AD_Assist_Byte.IGNORED (bits : AD_Assist_Byte) : Bits 6 :=
  BitVec.append (BitVec.extractLsb' 7 1 bits) (BitVec.extractLsb' 0 5 bits)

def AD_Assist_Byte.setIGNORED (bits : AD_Assist_Byte) (value : Bits 6) : AD_Assist_Byte :=
  let bits := setSlice bits 0 5 (BitVec.extractLsb' 0 5 value)
  setSlice bits 7 1 (BitVec.extractLsb' 5 1 value)

end X86.Helpers
