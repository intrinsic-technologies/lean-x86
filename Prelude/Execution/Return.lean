import X86.UserProcess.RunResult
import X86.Helpers.Pop_Stack
import X86.Machine.Hardware

open scoped X86.Machine.Hardware

namespace Prelude

variable {σ : Type} [X86.Machine.PhysicalMemory σ]

open X86 X86.UserProcess

/--
Expected RIP and RSP after a plain 64-bit near return: read RIP from the virtual stack at
the initial RSP and advance RSP by eight bytes. Read errors are propagated; state changes
from the boundary query are discarded.
-/
def nearReturn64Boundary [Machine.Bindings] (initial : X86.State σ) :
    X86.Result ReturnBoundary := do
  let sp := initial.regValue .rsp
  let (address, nextSP) ← ((Helpers.Pop_Stack initial.SS sp 64 64).run initial).1
  pure { rip := address, rsp := nextSP }

/-- The 32-bit return status in EAX is zero -/
def SuccessfulStatus (final : X86.State σ) : Prop :=
  (final.regValue .rax).setWidth 32 = 0

/-- The 32-bit return status in EAX matches the expected error code -/
def FailureStatus (final : X86.State σ) (expectedErrorCode : BitVec 32) : Prop :=
  (final.regValue .rax).setWidth 32 = expectedErrorCode

end Prelude
