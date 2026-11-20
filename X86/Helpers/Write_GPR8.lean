-- Generated from data/definitions.xml.gz: Write_GPR8; do not edit.
-- Source SHA256: 8525b6ba5ba3cfbf09317116b6b335c337e91ceb9fbbfddd18f578acfed09dc6
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Write_GPR8)
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

def Write_GPR8
    (rrrrr : Bits 5) (have_rex : Bool) (value : Bits 8) :
    Runtime.SpecM Exception (State σ) Unit := do
  -- upper regs not accessible outside of 64-bit mode
  let index : Bits 5 ← do
    if (← In_64Bit_Mode) then
      pure rrrrr
    else
      concatBits (leftSize := 2) (rightSize := 3) (0 : Bits 2) (← rrrrr[2:0])

  match (index, have_rex) with
  | (0b00000, _) => do
    AL_write value
  | (0b00001, _) => do
    CL_write value
  | (0b00010, _) => do
    DL_write value
  | (0b00011, _) => do
    BL_write value

  | (0b00100, false) => do
    AH_write value
  | (0b00101, false) => do
    CH_write value
  | (0b00110, false) => do
    DH_write value
  | (0b00111, false) => do
    BH_write value

  | (0b00100, true) => do
    SPL_write value
  | (0b00101, true) => do
    BPL_write value
  | (0b00110, true) => do
    SIL_write value
  | (0b00111, true) => do
    DIL_write value

  | (0b01000, _) => do
    let mut R8_target ← R8
    R8_target := (← setSliceChecked R8_target 0 8 value)
    R8_write R8_target
  | (0b01001, _) => do
    let mut R9_target ← R9
    R9_target := (← setSliceChecked R9_target 0 8 value)
    R9_write R9_target
  | (0b01010, _) => do
    let mut R10_target ← R10
    R10_target := (← setSliceChecked R10_target 0 8 value)
    R10_write R10_target
  | (0b01011, _) => do
    let mut R11_target ← R11
    R11_target := (← setSliceChecked R11_target 0 8 value)
    R11_write R11_target
  | (0b01100, _) => do
    let mut R12_target ← R12
    R12_target := (← setSliceChecked R12_target 0 8 value)
    R12_write R12_target
  | (0b01101, _) => do
    let mut R13_target ← R13
    R13_target := (← setSliceChecked R13_target 0 8 value)
    R13_write R13_target
  | (0b01110, _) => do
    let mut R14_target ← R14
    R14_target := (← setSliceChecked R14_target 0 8 value)
    R14_write R14_target
  | (0b01111, _) => do
    let mut R15_target ← R15
    R15_target := (← setSliceChecked R15_target 0 8 value)
    R15_write R15_target

  | (0b10000, _) => do
    let mut R16_target ← R16
    R16_target := (← setSliceChecked R16_target 0 8 value)
    R16_write R16_target
  | (0b10001, _) => do
    let mut R17_target ← R17
    R17_target := (← setSliceChecked R17_target 0 8 value)
    R17_write R17_target
  | (0b10010, _) => do
    let mut R18_target ← R18
    R18_target := (← setSliceChecked R18_target 0 8 value)
    R18_write R18_target
  | (0b10011, _) => do
    let mut R19_target ← R19
    R19_target := (← setSliceChecked R19_target 0 8 value)
    R19_write R19_target
  | (0b10100, _) => do
    let mut R20_target ← R20
    R20_target := (← setSliceChecked R20_target 0 8 value)
    R20_write R20_target
  | (0b10101, _) => do
    let mut R21_target ← R21
    R21_target := (← setSliceChecked R21_target 0 8 value)
    R21_write R21_target
  | (0b10110, _) => do
    let mut R22_target ← R22
    R22_target := (← setSliceChecked R22_target 0 8 value)
    R22_write R22_target
  | (0b10111, _) => do
    let mut R23_target ← R23
    R23_target := (← setSliceChecked R23_target 0 8 value)
    R23_write R23_target

  | (0b11000, _) => do
    let mut R24_target ← R24
    R24_target := (← setSliceChecked R24_target 0 8 value)
    R24_write R24_target
  | (0b11001, _) => do
    let mut R25_target ← R25
    R25_target := (← setSliceChecked R25_target 0 8 value)
    R25_write R25_target
  | (0b11010, _) => do
    let mut R26_target ← R26
    R26_target := (← setSliceChecked R26_target 0 8 value)
    R26_write R26_target
  | (0b11011, _) => do
    let mut R27_target ← R27
    R27_target := (← setSliceChecked R27_target 0 8 value)
    R27_write R27_target
  | (0b11100, _) => do
    let mut R28_target ← R28
    R28_target := (← setSliceChecked R28_target 0 8 value)
    R28_write R28_target
  | (0b11101, _) => do
    let mut R29_target ← R29
    R29_target := (← setSliceChecked R29_target 0 8 value)
    R29_write R29_target
  | (0b11110, _) => do
    let mut R30_target ← R30
    R30_target := (← setSliceChecked R30_target 0 8 value)
    R30_write R30_target
  | (0b11111, _) => do
    let mut R31_target ← R31
    R31_target := (← setSliceChecked R31_target 0 8 value)
    R31_write R31_target
  | _ => throw .unmatchedCase

end X86.Helpers
