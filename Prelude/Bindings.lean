import Prelude.Bindings.CacheControl
import Prelude.Bindings.MemoryAccess
import Prelude.Bindings.Numerical
import Prelude.Bindings.Contract
import Prelude.Bindings.RemainderReduction
import Prelude.Bindings.CompareMemory
import Prelude.Bindings.StackReturn
import Prelude.Bindings.StringStride
import Prelude.Bindings.Fxsave
import X86.Machine.Step

set_option autoImplicit false

namespace Prelude.Bindings

open X86

/-- The contracts of the locally completed choices for the supplied machine
bindings. This does not assert complete ISA or
environment conformance. Ordinary memory, translation, MSR, I/O, event and other
binding laws remain independent obligations.
The numerical contracts state the SDM requirements without selecting algorithms.
The memory-ordering contracts use the bindings' memory-type configuration and run the
generated continuation under the guards in `MemoryAccess`. -/
structure Satisfies {σ : Type} [X86.Machine.PhysicalMemory σ]
    (bindings : X86.Machine.Bindings) : Prop where
  reciprocal : Numerical.Reciprocal.Satisfies (bindings.numerical (σ := σ)).reciprocal
  reciprocalSqrt : Numerical.ReciprocalSqrt.Satisfies (bindings.numerical (σ := σ)).reciprocalSqrt
  transcendental : Numerical.Transcendental.Satisfies (bindings.numerical (σ := σ))
  remainderReduction : RemainderReduction.Satisfies (bindings.remainderReduction (σ := σ))
  fxsave : letI := bindings; Fxsave.Satisfies (bindings.fxsave (σ := σ))
  compareMemory : letI := bindings; CompareMemory.Satisfies (bindings.compareMemory (σ := σ))
  stackReturn : letI := bindings; StackReturn.Satisfies (bindings.stackReturn (σ := σ))
  stringStride : StringStride.Satisfies (bindings.stringStride (σ := σ))
  cacheControl : CacheControl.Satisfies bindings.cacheControl

end Prelude.Bindings
