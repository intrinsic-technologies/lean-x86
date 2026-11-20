import X86.Machine.Bindings
import X86.Helpers.Translate_Linear_To_Physical
import X86.Helpers.Handle_Vectored_Event
import X86.Helpers.Mem_Fetch

namespace X86.Machine.Hardware

/-- Explicitly opened by clients that call individual helpers with their hardware meaning. -/
scoped instance [Bindings] {σ : Type} [PhysicalMemory σ] :
    X86.Helpers.Translate_Linear_To_Physical.Semantics σ :=
  X86.Helpers.Translate_Linear_To_Physical.defaultSemantics

scoped instance [Bindings] {σ : Type} [PhysicalMemory σ]
    [X86.Helpers.Translate_Linear_To_Physical.Semantics σ] :
    X86.Helpers.Handle_Vectored_Event.Semantics σ :=
  X86.Helpers.Handle_Vectored_Event.defaultSemantics

scoped instance [Bindings] {σ : Type} [PhysicalMemory σ]
    [X86.Helpers.Translate_Linear_To_Physical.Semantics σ] :
    X86.Accelerate (X86.Helpers.Mem_Fetch.source (σ := σ)) :=
  ⟨X86.Helpers.Mem_Fetch.source, rfl⟩

end X86.Machine.Hardware
