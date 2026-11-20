-- Generated from data/definitions.xml.gz: Write_GPR; do not edit.
-- Source SHA256: bdaacf1de15f8ffa11d62e2dfbc23aa4a549f41aa5c595efdbb04f253cc0554c
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_GPR)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Merge_GPR
import X86.Helpers.Registers
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Write_GPR {size : Int}
    (rrrrr : Bits 5) (value : Bits size) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (0 ≤ size)

  -- upper regs not accessible outside of 64-bit mode
  let index : Bits 5 ← do
    if (← In_64Bit_Mode) then
      pure rrrrr
    else
      concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) (← rrrrr[2:0])

  match Unsigned index with
  | 0b00000 => do
    RAX_write (← Merge_GPR (size := size) value (← RAX))
  | 0b00001 => do
    RCX_write (← Merge_GPR (size := size) value (← RCX))
  | 0b00010 => do
    RDX_write (← Merge_GPR (size := size) value (← RDX))
  | 0b00011 => do
    RBX_write (← Merge_GPR (size := size) value (← RBX))
  | 0b00100 => do
    RSP_write (← Merge_GPR (size := size) value (← RSP))
  | 0b00101 => do
    RBP_write (← Merge_GPR (size := size) value (← RBP))
  | 0b00110 => do
    RSI_write (← Merge_GPR (size := size) value (← RSI))
  | 0b00111 => do
    RDI_write (← Merge_GPR (size := size) value (← RDI))
  | 0b01000 => do
    R8_write (← Merge_GPR (size := size) value (← R8))
  | 0b01001 => do
    R9_write (← Merge_GPR (size := size) value (← R9))
  | 0b01010 => do
    R10_write (← Merge_GPR (size := size) value (← R10))
  | 0b01011 => do
    R11_write (← Merge_GPR (size := size) value (← R11))
  | 0b01100 => do
    R12_write (← Merge_GPR (size := size) value (← R12))
  | 0b01101 => do
    R13_write (← Merge_GPR (size := size) value (← R13))
  | 0b01110 => do
    R14_write (← Merge_GPR (size := size) value (← R14))
  | 0b01111 => do
    R15_write (← Merge_GPR (size := size) value (← R15))
  | 0b10000 => do
    R16_write (← Merge_GPR (size := size) value (← R16))
  | 0b10001 => do
    R17_write (← Merge_GPR (size := size) value (← R17))
  | 0b10010 => do
    R18_write (← Merge_GPR (size := size) value (← R18))
  | 0b10011 => do
    R19_write (← Merge_GPR (size := size) value (← R19))
  | 0b10100 => do
    R20_write (← Merge_GPR (size := size) value (← R20))
  | 0b10101 => do
    R21_write (← Merge_GPR (size := size) value (← R21))
  | 0b10110 => do
    R22_write (← Merge_GPR (size := size) value (← R22))
  | 0b10111 => do
    R23_write (← Merge_GPR (size := size) value (← R23))
  | 0b11000 => do
    R24_write (← Merge_GPR (size := size) value (← R24))
  | 0b11001 => do
    R25_write (← Merge_GPR (size := size) value (← R25))
  | 0b11010 => do
    R26_write (← Merge_GPR (size := size) value (← R26))
  | 0b11011 => do
    R27_write (← Merge_GPR (size := size) value (← R27))
  | 0b11100 => do
    R28_write (← Merge_GPR (size := size) value (← R28))
  | 0b11101 => do
    R29_write (← Merge_GPR (size := size) value (← R29))
  | 0b11110 => do
    R30_write (← Merge_GPR (size := size) value (← R30))
  | 0b11111 => do
    R31_write (← Merge_GPR (size := size) value (← R31))
  | _ => throw .unmatchedCase

end X86.Helpers
