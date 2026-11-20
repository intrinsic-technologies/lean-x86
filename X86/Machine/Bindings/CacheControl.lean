import X86.Helpers.Get_Memory_Type
import X86.Machine.Processor

set_option autoImplicit false

namespace X86.Machine.Bindings

/-- Pure binding for CD=1 queries delegated by the generated selector.
The CPUID query is bound to the live XCR0 and OSXSAVE values used by execution.
Prelude's `CacheControl.Satisfies` requires completion and SDM-permitted results
for every query admitted by the generated selector. The caller must additionally
justify its processor-specific results and coverage against hardware. -/
class CacheControl where
  disabledMemoryType : (Nat → Nat → Except String X86.Machine.Cpuid.Registers) → Helpers.Memory_Type_Inputs → BitVec 64 → BitVec 3 →
    Except (Runtime.Error Empty) Helpers.Memory_Type

/-- Explicit rejecting selection for executions that never delegate cache-disabled queries. -/
@[instance_reducible]
def CacheControl.unavailable : CacheControl :=
  ⟨fun _ _ _ _ => .error (.externalFailure "processor cache-disabled memory-type binding is unavailable")⟩

/-- Bind only the cache-disabled result requested by the generated selector. -/
@[instance_reducible]
def CacheControl.toBinding {σ : Type} (binding : CacheControl)
    (cpuid : X86.Machine.Cpuid.Query) :
    Helpers.Get_Cache_Disabled_Memory_Type.Binding σ where
  call inputs address patIndex state :=
    binding.disabledMemoryType (X86.Machine.Cpuid.queryAtState cpuid state) inputs address patIndex

end X86.Machine.Bindings

namespace X86.Machine

/-- Adapt the selected cache-control binding using this processor's CPUID query. -/
@[instance_reducible]
def Processor.cacheControlBinding {σ : Type} (processor : Processor)
    [binding : Bindings.CacheControl] : Helpers.Get_Cache_Disabled_Memory_Type.Binding σ :=
  Bindings.CacheControl.toBinding binding processor.cpuid

end X86.Machine
