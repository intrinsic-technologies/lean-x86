-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 01ddca469bf83efd0c43618eb59988960ea884b71a3325eadcbab24c07e6e2f5
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

-- Register storage aliases omitted from the public XML.
-- All aliases refer to the same GPR backing store.

def RAX  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 0)

def RAX_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 0 value

def AX  : Runtime.SpecM Exception (State σ) (Bits 16) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 0) 0 16)

def AX_write (value : Bits 16) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 0 (← setSliceChecked (← GPR.get 0) 0 16 value)

def RCX  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 1)

def RCX_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 1 value

def RDX  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 2)

def RDX_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 2 value

def DX  : Runtime.SpecM Exception (State σ) (Bits 16) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 2) 0 16)

def DX_write (value : Bits 16) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 2 (← setSliceChecked (← GPR.get 2) 0 16 value)

def RBX  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 3)

def RBX_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 3 value

def RSP  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 4)

def RSP_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 4 value

def RBP  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 5)

def RBP_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 5 value

def RSI  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 6)

def RSI_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 6 value

def RDI  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 7)

def RDI_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 7 value

def AL  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 0) 0 8)

def AL_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 0 (← setSliceChecked (← GPR.get 0) 0 8 value)

def CL  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 1) 0 8)

def CL_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 1 (← setSliceChecked (← GPR.get 1) 0 8 value)

def DL  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 2) 0 8)

def DL_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 2 (← setSliceChecked (← GPR.get 2) 0 8 value)

def BL  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 3) 0 8)

def BL_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 3 (← setSliceChecked (← GPR.get 3) 0 8 value)

def SPL  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 4) 0 8)

def SPL_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 4 (← setSliceChecked (← GPR.get 4) 0 8 value)

def BPL  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 5) 0 8)

def BPL_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 5 (← setSliceChecked (← GPR.get 5) 0 8 value)

def SIL  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 6) 0 8)

def SIL_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 6 (← setSliceChecked (← GPR.get 6) 0 8 value)

def DIL  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 7) 0 8)

def DIL_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 7 (← setSliceChecked (← GPR.get 7) 0 8 value)

def AH  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 0) 8 8)

def AH_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 0 (← setSliceChecked (← GPR.get 0) 8 8 value)

def CH  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 1) 8 8)

def CH_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 1 (← setSliceChecked (← GPR.get 1) 8 8 value)

def DH  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 2) 8 8)

def DH_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 2 (← setSliceChecked (← GPR.get 2) 8 8 value)

def BH  : Runtime.SpecM Exception (State σ) (Bits 8) := do
  return (← Runtime.CheckedSlice.read (← GPR.get 3) 8 8)

def BH_write (value : Bits 8) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 3 (← setSliceChecked (← GPR.get 3) 8 8 value)

-- Intel's GPR accessors name the numbered registers R8-R31.

def R8  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 8)

def R8_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 8 value

def R9  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 9)

def R9_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 9 value

def R10  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 10)

def R10_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 10 value

def R11  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 11)

def R11_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 11 value

def R12  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 12)

def R12_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 12 value

def R13  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 13)

def R13_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 13 value

def R14  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 14)

def R14_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 14 value

def R15  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 15)

def R15_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 15 value

def R16  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 16)

def R16_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 16 value

def R17  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 17)

def R17_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 17 value

def R18  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 18)

def R18_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 18 value

def R19  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 19)

def R19_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 19 value

def R20  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 20)

def R20_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 20 value

def R21  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 21)

def R21_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 21 value

def R22  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 22)

def R22_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 22 value

def R23  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 23)

def R23_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 23 value

def R24  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 24)

def R24_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 24 value

def R25  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 25)

def R25_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 25 value

def R26  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 26)

def R26_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 26 value

def R27  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 27)

def R27_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 27 value

def R28  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 28)

def R28_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 28 value

def R29  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 29)

def R29_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 29 value

def R30  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 30)

def R30_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 30 value

def R31  : Runtime.SpecM Exception (State σ) (Bits 64) := do
  return (← GPR.get 31)

def R31_write (value : Bits 64) : Runtime.SpecM Exception (State σ) Unit := do
  GPR.set 31 value

end X86.Helpers
