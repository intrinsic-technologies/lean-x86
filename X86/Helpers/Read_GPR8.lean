-- Generated from data/definitions.xml.gz: Read_GPR8; do not edit.
-- Source SHA256: 307ee56e18b12860fc79d277db342f2f08252694524e90c4fe3fd41d3a5c5b2e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Read_GPR8)
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

def Read_GPR8
    (rrrrr : Bits 5) (have_rex : Bool) :
    Runtime.SpecM Exception (State σ) (Bits 8) := do
  -- upper regs not accessible outside of 64-bit mode
  let index : Bits 5 ← do
    if (← In_64Bit_Mode) then
      pure rrrrr
    else
      concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) (← rrrrr[2:0])

  match (index, have_rex) with
  | (0b00000, _) => do
    return (← AL)
  | (0b00001, _) => do
    return (← CL)
  | (0b00010, _) => do
    return (← DL)
  | (0b00011, _) => do
    return (← BL)

  | (0b00100, false) => do
    return (← AH)
  | (0b00101, false) => do
    return (← CH)
  | (0b00110, false) => do
    return (← DH)
  | (0b00111, false) => do
    return (← BH)

  | (0b00100, true) => do
    return (← SPL)
  | (0b00101, true) => do
    return (← BPL)
  | (0b00110, true) => do
    return (← SIL)
  | (0b00111, true) => do
    return (← DIL)

  | (0b01000, _) => do
    return (← Runtime.CheckedSlice.read (← R8) 0 8)
  | (0b01001, _) => do
    return (← Runtime.CheckedSlice.read (← R9) 0 8)
  | (0b01010, _) => do
    return (← Runtime.CheckedSlice.read (← R10) 0 8)
  | (0b01011, _) => do
    return (← Runtime.CheckedSlice.read (← R11) 0 8)
  | (0b01100, _) => do
    return (← Runtime.CheckedSlice.read (← R12) 0 8)
  | (0b01101, _) => do
    return (← Runtime.CheckedSlice.read (← R13) 0 8)
  | (0b01110, _) => do
    return (← Runtime.CheckedSlice.read (← R14) 0 8)
  | (0b01111, _) => do
    return (← Runtime.CheckedSlice.read (← R15) 0 8)

  | (0b10000, _) => do
    return (← Runtime.CheckedSlice.read (← R16) 0 8)
  | (0b10001, _) => do
    return (← Runtime.CheckedSlice.read (← R17) 0 8)
  | (0b10010, _) => do
    return (← Runtime.CheckedSlice.read (← R18) 0 8)
  | (0b10011, _) => do
    return (← Runtime.CheckedSlice.read (← R19) 0 8)
  | (0b10100, _) => do
    return (← Runtime.CheckedSlice.read (← R20) 0 8)
  | (0b10101, _) => do
    return (← Runtime.CheckedSlice.read (← R21) 0 8)
  | (0b10110, _) => do
    return (← Runtime.CheckedSlice.read (← R22) 0 8)
  | (0b10111, _) => do
    return (← Runtime.CheckedSlice.read (← R23) 0 8)

  | (0b11000, _) => do
    return (← Runtime.CheckedSlice.read (← R24) 0 8)
  | (0b11001, _) => do
    return (← Runtime.CheckedSlice.read (← R25) 0 8)
  | (0b11010, _) => do
    return (← Runtime.CheckedSlice.read (← R26) 0 8)
  | (0b11011, _) => do
    return (← Runtime.CheckedSlice.read (← R27) 0 8)
  | (0b11100, _) => do
    return (← Runtime.CheckedSlice.read (← R28) 0 8)
  | (0b11101, _) => do
    return (← Runtime.CheckedSlice.read (← R29) 0 8)
  | (0b11110, _) => do
    return (← Runtime.CheckedSlice.read (← R30) 0 8)
  | (0b11111, _) => do
    return (← Runtime.CheckedSlice.read (← R31) 0 8)
  | _ => throw .unmatchedCase

end X86.Helpers
