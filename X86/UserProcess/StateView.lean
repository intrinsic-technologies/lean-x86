import X86.Machine.Ram
import X86.Syntax.Operands

namespace X86.UserProcess

open X86.Machine X86.Syntax

structure Flags where
  cf : Bool
  pf : Bool
  af : Bool
  zf : Bool
  sf : Bool
  of : Bool
  df : Bool
  deriving Repr, DecidableEq, Inhabited

/--
Compact register, flag and memory view used to initialize and observe a process. The memory type
`σ` defaults to `Ram`.
-/
structure StateView (σ : Type := Ram) where
  regs : Vector (BitVec 64) 16
  rip : BitVec 64
  flags : Flags
  mem : σ
  oraclePos : Nat  -- Cursor into the external source of unspecified bits.

def StateView.readReg {σ : Type} (state : StateView σ) (reg : Reg) : BitVec 64 :=
  state.regs[reg.fin]

def StateView.writeReg {σ : Type} (state : StateView σ) (reg : Reg) (value : BitVec 64) :
    StateView σ :=
  { state with regs := state.regs.set reg.fin value }

end X86.UserProcess
