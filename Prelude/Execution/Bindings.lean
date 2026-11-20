import Prelude.Execution.Environment
import Prelude.Memory.Region
import X86.Machine.Step

namespace Prelude

open X86 X86.Machine

/-- No physical address matches a configured SMRR protected range -/
def SMRRUnblocked {σ : Type} (b : Machine.Bindings) (state : X86.State σ) : Prop :=
  ∀ (address : BitVec 64),
    X86.Helpers.Emulate_Memory.SMRR_Matches b.memoryType.mtrrCap
      state.IA32_SMRR_PHYSBASE state.IA32_SMRR_PHYSMASK address = .ok false

/-- The current memory registers select write-back below the user address limit. -/
def WriteBackMemoryType {σ : Type} (b : Machine.Bindings) (state : X86.State σ)
    (selector : BitVec 3) : Prop :=
  ∀ (address : BitVec 64),
    address.toNat < userAddressLimit →
      @X86.Machine.Bindings.MemoryType.lookup _ b.processor b.memoryType b.cacheControl state address selector =
        .ok .Memory_Type_Write_Back

/--
For positive counts, the read-only stride helper succeeds with stride 1,
for a state over any memory
-/
def UnitStringStride (b : Machine.Bindings) : Prop :=
  ∀ {σ : Type} (s : X86.State σ) (size count : Int), 0 < count →
    b.stringStride.call size count s = .ok 1

/--
The processor reports, in the state, whether it supports the leading-zero-count instruction
(LZCNT), which the decoder queries
-/
def LeadingZeroCountReported {σ : Type} (b : Machine.Bindings) (state : X86.State σ) : Prop :=
  ∃ enabled, ReportsCPUFeature b.processor state CPUID_LZCNT_Encoding enabled

/--
In the state, no SMRR range blocks memory, memory below the user address limit is write-back,
string instructions step one element at a time, and the processor answers the decoder's
leading-zero-count query
-/
structure MachineRamUnitStrideDecodable {σ : Type} (b : Machine.Bindings) (state : X86.State σ) :
    Prop where
  smrr : SMRRUnblocked b state
  memoryType : WriteBackMemoryType b state 0
  stringStride : UnitStringStride b
  leadingZeroCount : LeadingZeroCountReported b state

end Prelude
