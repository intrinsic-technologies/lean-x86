import X86.Machine.State
import Prelude.Execution.Registers.RFLAGS

namespace Prelude.Execution.CallingConvention

open X86

/-- The MXCSR control bits: DAZ (bit 6), the exception masks (bits 7–12), the rounding control
(bits 13–14) and FTZ (bit 15). Bits 0–5 are the exception flags, status bits. -/
def mxcsrControlBits (mxcsr : MXCSR_Type) : BitVec 10 :=
  mxcsr.extractLsb' 6 10

/-- The x87 register stack is empty: every two-bit tag of the x87 tag word is empty (`11`), as
`EMMS` and `FNINIT` leave it. This is x87 mode at a System V call boundary, where nothing is passed
on the x87 stack. -/
def X87StackEmpty {σ : Type} (s : X86.State σ) : Prop :=
  s.FP87_Tag_Word = 0xFFFF

/--
A callee's return under the System V AMD64 calling convention (psABI 3.2.1 and Figure 3.4), from
the state at its entry `initial` (RSP at the return address) to the state after its `ret`
`final`:

- RIP is `returnAddress` and RSP is the entry RSP plus 8: the callee has popped the return address
  and jumped to it;
- RBX, RBP and R12–R15 hold their entry values;
- DF is clear;
- the MXCSR control bits (`mxcsrControlBits`) and the x87 control word hold their entry values;
- a callee entered in x87 mode returns in it (`X87StackEmpty`); one that returns a value on the
  x87 stack (the psABI's X87 and COMPLEX_X87 classes: a `long double` in ST(0), a
  `complex long double` in ST(0) and ST(1)) does not, and does not meet this structure;
- FS, the thread pointer, holds its entry value: its selector and the descriptor state kept with
  it. `%fs:` addresses depend on more than the base, since that state also decides whether the
  base applies (`X86.Helpers.Compute_Linear_Address`), so keeping only the base would not keep
  them.

The structure reads no memory, so `returnAddress` is a parameter: a statement gives it the address
stored at the entry RSP, which `Prelude.nearReturn64Boundary` reads. Without it, a callee that pops
eight bytes and jumps elsewhere would meet every other field.

The ABI preserves nothing else across a call: the other general-purpose registers, the status
flags, the XMM registers, the MXCSR exception flags, the x87 status word and the x87 registers are
the caller's to save.
-/
structure SysVCalleeReturn {σ : Type} (initial final : X86.State σ) (returnAddress : BitVec 64) :
    Prop where
  rip : final.RIP = returnAddress
  rspPopped : final.regValue .rsp = initial.regValue .rsp + 8
  rbx : final.regValue .rbx = initial.regValue .rbx
  rbp : final.regValue .rbp = initial.regValue .rbp
  r12 : final.regValue .r12 = initial.regValue .r12
  r13 : final.regValue .r13 = initial.regValue .r13
  r14 : final.regValue .r14 = initial.regValue .r14
  r15 : final.regValue .r15 = initial.regValue .r15
  directionFlag : RFLAGS.DirectionFlagClear final.RFLAGS
  mxcsrControl : mxcsrControlBits final.MXCSR = mxcsrControlBits initial.MXCSR
  x87Control : final.FP87_Control = initial.FP87_Control
  x87Mode : X87StackEmpty initial → X87StackEmpty final
  fs : final.FS = initial.FS

end Prelude.Execution.CallingConvention
