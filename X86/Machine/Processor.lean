import X86.Machine.Bindings.Cpuid
import X86.Config

namespace X86.Machine

/-- Processor settings initialized from a caller query and Intel's family defaults.
The query must keep its capabilities and geometry constant across live control states. -/
class Processor where
  private mk ::
  cpuid : Cpuid.Query
  processorType : X86.Helpers.__Processor_Type
  config : X86.Config

@[instance_reducible]
private def bindProcessorType (processorType : X86.Helpers.__Processor_Type) :
    X86.__Implements_Processor_Type.Binding :=
  ⟨fun requested => decide (requested = processorType)⟩

/-- Answer the omitted classifier from the selected processor family. -/
@[instance_reducible]
def Processor.processorTypeBinding (processor : Processor) :
    X86.__Implements_Processor_Type.Binding :=
  bindProcessorType processor.processorType

/-- Read the processor geometry using the generated CPUID helpers in initialization order. -/
def Processor.readGeometry {σ : Type} (query : Cpuid.Query)
    (cacheLineSizeWithoutClflush : Int) :
    X86.Runtime.SpecM X86.Exception (X86.State σ) (Int × Int × Int) := do
  let _ : X86.Get_CPUID_Value.Binding σ := Bindings.Cpuid.ofQuery query
  let physical ← X86.CPUID_Physical_Address_Width
  let linear ← X86.CPUID_Linear_Address_Width
  let line ← X86.CPUID_Cache_Line_Size cacheLineSizeWithoutClflush
  return (physical, linear, line)

/-- Initialize and validate processor settings before execution. CPUID supplies the
address widths and, when CLFSH is set, the cache-line size. Core/Atom selects Intel's
remaining defaults; without CLFSH the caller supplies the cache-line size explicitly. -/
def Processor.initialize {σ : Type} (query : Cpuid.Query) (state : X86.State σ)
    (processorType : X86.Helpers.__Processor_Type)
    (cacheLineSizeWithoutClflush : Int := 0) :
    Except (X86.Runtime.Error X86.Exception) Processor := do
  let (physical, linear, line) ←
    ((Processor.readGeometry query cacheLineSizeWithoutClflush).run state).1
  let _ := bindProcessorType processorType
  let config ← X86.Config.initialize
    (Max_Physical_Address := some physical) (Max_Linear_Address := some linear)
    (Cache_Line_Size := some line)
  config.validate (exception := X86.Exception)
  return ⟨query, processorType, config⟩

/-- Bind generated CPUID helpers to this processor and the live control state. -/
@[instance_reducible]
def Processor.cpuidBinding {σ : Type} (processor : Processor) : X86.Get_CPUID_Value.Binding σ :=
  Bindings.Cpuid.ofQuery processor.cpuid

end X86.Machine
