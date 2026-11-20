import X86.Machine.Ram
import X86.State
import X86.Syntax.Operands

namespace X86.State

open X86.Syntax

/-- The stored 64-bit value of a named general-purpose register. -/
def regValue {σ : Type} (state : X86.State σ) (register : Reg) : BitVec 64 :=
  state.GPR[register.fin.val]'(by have := register.fin.isLt; omega)

end X86.State

namespace X86.Machine

/-- Complete generated architectural state with persistent physical memory. -/
abbrev RamState := X86.State Ram

end X86.Machine
