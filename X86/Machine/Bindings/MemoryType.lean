import X86.Machine.MemoryType
import X86.Machine.Processor
import X86.Machine.Ram
import X86.Helpers.Get_Memory_Type
import X86.Machine.Bindings.CacheControl

set_option autoImplicit false

namespace X86.Machine.Bindings.MemoryType

open X86.Helpers

instance {σ : Type} [X86.Machine.MemoryType.Config] : X86.IA32_MTRRCAP.Binding σ where
  call := pure X86.Machine.MemoryType.Config.mtrrCap

/-- Combine live memory registers with the selected processor and its CPUID query. -/
def inputsOfState {σ : Type} (processor : X86.Machine.Processor) [X86.Machine.MemoryType.Config]
    (state : X86.State σ) : Except (X86.Runtime.Error Empty) Memory_Type_Inputs :=
  let _ : X86.Config := processor.config
  let _ := processor.cpuidBinding (σ := σ)
  let _ := processor.processorTypeBinding
  (Emulate_Memory.Read_Type_Inputs.run state).1

/-- Run the generated selector using live registers and the selected processor inputs. -/
def lookup {σ : Type} (processor : X86.Machine.Processor) [X86.Machine.MemoryType.Config]
    [X86.Machine.Bindings.CacheControl]
    (state : X86.State σ) (address : BitVec 64) (pat : BitVec 3) :
    Except (X86.Runtime.Error Empty) Memory_Type :=
  let _ : X86.Config := processor.config
  let _ := processor.cpuidBinding (σ := σ)
  let _ := processor.processorTypeBinding
  let _ := processor.cacheControlBinding (σ := σ)
  ((Get_Memory_Type address pat).run state).1

/-- SMRR blocks ordinary RAM outside SMM, independently of the selected cache type. -/
def smrrBlocked {σ : Type} [X86.Machine.MemoryType.Config] (state : X86.State σ)
    (address : BitVec 64) : Except (X86.Runtime.Error Empty) Bool := do
  return (← Emulate_Memory.SMRR_Matches X86.Machine.MemoryType.Config.mtrrCap
    state.IA32_SMRR_PHYSBASE state.IA32_SMRR_PHYSMASK address) && !state.«SMM::In_SMM»

end X86.Machine.Bindings.MemoryType
