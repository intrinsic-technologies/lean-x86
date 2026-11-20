-- Generated from data/definitions.xml.gz: Read_GPR; do not edit.
-- Source SHA256: 681321fe0c4a7dc917b7e2000bbd9a3eb03a678de99569aadcf6b67b8eeae116
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Read_GPR)
import X86.Runtime
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Registers
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Read_GPR (rrrrr : Bits 5) (N : Int) : Runtime.SpecM Exception (State σ) (Bits N) := do
  Runtime.assert (0 ≤ N)

  -- upper regs not accessible outside of 64-bit mode
  let index : Bits 5 ← do
    if (← In_64Bit_Mode) then
      pure rrrrr
    else
      concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) (← rrrrr[2:0])

  match Unsigned index with
  | 0b00000 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← RAX) 0 N)
  | 0b00001 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← RCX) 0 N)
  | 0b00010 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← RDX) 0 N)
  | 0b00011 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← RBX) 0 N)
  | 0b00100 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← RSP) 0 N)
  | 0b00101 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← RBP) 0 N)
  | 0b00110 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← RSI) 0 N)
  | 0b00111 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← RDI) 0 N)
  | 0b01000 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R8) 0 N)
  | 0b01001 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R9) 0 N)
  | 0b01010 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R10) 0 N)
  | 0b01011 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R11) 0 N)
  | 0b01100 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R12) 0 N)
  | 0b01101 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R13) 0 N)
  | 0b01110 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R14) 0 N)
  | 0b01111 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R15) 0 N)
  | 0b10000 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R16) 0 N)
  | 0b10001 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R17) 0 N)
  | 0b10010 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R18) 0 N)
  | 0b10011 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R19) 0 N)
  | 0b10100 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R20) 0 N)
  | 0b10101 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R21) 0 N)
  | 0b10110 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R22) 0 N)
  | 0b10111 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R23) 0 N)
  | 0b11000 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R24) 0 N)
  | 0b11001 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R25) 0 N)
  | 0b11010 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R26) 0 N)
  | 0b11011 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R27) 0 N)
  | 0b11100 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R28) 0 N)
  | 0b11101 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R29) 0 N)
  | 0b11110 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R30) 0 N)
  | 0b11111 => do
    Runtime.assert (decide (N ≤ 64))
    return (← Runtime.CheckedSlice.read (← R31) 0 N)
  | _ => throw .unmatchedCase

end X86.Helpers
