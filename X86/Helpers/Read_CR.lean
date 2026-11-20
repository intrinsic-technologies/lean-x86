-- Generated from data/definitions.xml.gz: Read_CR; do not edit.
-- Source SHA256: ac0f2af5d4d115cca112ca56ecdf177248fdb15850448543ccee4107d1ed4f67
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Read_CR)
import X86.Runtime
import X86.Helpers.Report_Invalid_Opcode
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Read_CR (rrrrr : Bits 5) : Runtime.SpecM Exception (State σ) (Bits 64) := do
  match Unsigned rrrrr with
  | 0b00000 => do
    return (← get).CR0
  | 0b00001 => do
    liftM (Report_Invalid_Opcode)
  | 0b00010 => do
    return (← get).CR2
  | 0b00011 => do
    return (← get).CR3
  | 0b00100 => do
    return (← get).CR4
  | 0b00101 => do
    liftM (Report_Invalid_Opcode)
  | 0b00110 => do
    liftM (Report_Invalid_Opcode)
  | 0b00111 => do
    liftM (Report_Invalid_Opcode)

  | 0b01000 => do
    return (← CR8)
  | 0b01001 => do
    liftM (Report_Invalid_Opcode)
  | 0b01010 => do
    liftM (Report_Invalid_Opcode)
  | 0b01011 => do
    liftM (Report_Invalid_Opcode)
  | 0b01100 => do
    liftM (Report_Invalid_Opcode)
  | 0b01101 => do
    liftM (Report_Invalid_Opcode)
  | 0b01110 => do
    liftM (Report_Invalid_Opcode)
  | 0b01111 => do
    liftM (Report_Invalid_Opcode)

  | 0b10000 => do
    liftM (Report_Invalid_Opcode)
  | 0b10001 => do
    liftM (Report_Invalid_Opcode)
  | 0b10010 => do
    liftM (Report_Invalid_Opcode)
  | 0b10011 => do
    liftM (Report_Invalid_Opcode)
  | 0b10100 => do
    liftM (Report_Invalid_Opcode)
  | 0b10101 => do
    liftM (Report_Invalid_Opcode)
  | 0b10110 => do
    liftM (Report_Invalid_Opcode)
  | 0b10111 => do
    liftM (Report_Invalid_Opcode)

  | 0b11000 => do
    liftM (Report_Invalid_Opcode)
  | 0b11001 => do
    liftM (Report_Invalid_Opcode)
  | 0b11010 => do
    liftM (Report_Invalid_Opcode)
  | 0b11011 => do
    liftM (Report_Invalid_Opcode)
  | 0b11100 => do
    liftM (Report_Invalid_Opcode)
  | 0b11101 => do
    liftM (Report_Invalid_Opcode)
  | 0b11110 => do
    liftM (Report_Invalid_Opcode)
  | 0b11111 => do
    liftM (Report_Invalid_Opcode)
  | _ => throw .unmatchedCase

end X86.Helpers
