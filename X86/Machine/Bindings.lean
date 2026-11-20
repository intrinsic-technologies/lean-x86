import X86.Machine.Bindings.Cpuid
import X86.Machine.Bindings.Cache
import X86.Machine.Bindings.CacheControl
import X86.Machine.Bindings.Event
import X86.Machine.Bindings.Fence
import X86.Machine.Bindings.MemoryType
import X86.Machine.Bindings.Msr
import X86.Machine.Bindings.PhysicalAccess
import X86.Machine.Bindings.Port
import X86.Machine.Bindings.ShadowStack
import X86.Machine.Bindings.StringStride
import X86.Machine.Bindings.Timestamp
import X86.Machine.Bindings.Instrumentation
import X86.Machine.Bindings.UnimplementedFeature
import X86.Machine.Bindings.Vmx
import X86.Machine.Bindings.Numerical
import X86.Machine.Bindings.Fxsave
import X86.Machine.Bindings.RemainderReduction
import X86.Machine.Bindings.CompareMemory
import X86.Machine.Bindings.StackReturn
import X86.Machine.Processor

namespace X86.Machine

/--
The caller supplies the initialized processor and the helper bindings
used by the generated instruction step. Stateful helpers are polymorphic in `σ`; cache-flush can access memory.

- MSR callbacks handle addresses outside the modeled memory-type MSR inventory.
- Local choice helpers read the state and return results; environment operations may change it.
- `Numerical`, `RemainderReduction`, `Fxsave`, `CompareMemory`, `StackReturn` and
  `CacheControl` define binding-group classes. The other submodules supply
  constructors, instances that reject a missing caller binding and that callers can
  select for the fields (`timestamp := inferInstance`), and the instances below.

The fields are what the caller selects for each run: the processor, the memory-type
configuration, binding groups and individual bindings. The step also uses *model bindings*:
instances that are part of this model rather than parameters of it. Unlike those above, no
field lets a caller select a different one:

- `PhysicalAccess` implements memory access for every state type with a `PhysicalMemory`
  instance. The caller selects memory by selecting `σ`.
- `Vmx` supplies the VMX-disabled controls that address translation reads and rejects every
  other VMCS input, EPT access and VM exit. The page walk in `PhysicalAccess` rejects nested
  paging with the same VMX message.
- `ShadowStack` and `Event` reject operations that this machine does not model.
- `UnimplementedFeature` continues past Intel's locking markers on this single-core machine
  and rejects every other unimplemented feature.
- `Fence` records fence events without enforcing memory ordering. `Instrumentation` discards
  Intel's trace hooks and rejects its fault-injection hook.
-/
class Bindings where
    numerical : {σ : Type} → Bindings.Numerical σ
    remainderReduction : {σ : Type} → Bindings.RemainderReduction σ
    fxsave : {σ : Type} → Bindings.Fxsave σ
    compareMemory : {σ : Type} → Bindings.CompareMemory σ
    stackReturn : {σ : Type} → Bindings.StackReturn σ
    memoryType : MemoryType.Config
    cacheControl : Bindings.CacheControl
    msrReadAllowedFallback : {σ : Type} → X86.Helpers.Other_MSR_Read_Allowed.Binding σ
    msrWriteAllowedFallback : {σ : Type} → X86.Helpers.Other_MSR_Write_Allowed.Binding σ
    msrReadFallback : {σ : Type} → X86.Helpers.Other_MSR_Read.Binding σ
    msrWriteBehaviorFallback : {σ : Type} → X86.Helpers.Other_MSR_Write_Behavior.Binding σ
    msrCommitFallback : {σ : Type} → X86.Helpers.Other_MSR_Commit.Binding σ
    portRead : {σ : Type} → X86.Helpers.IO_Read.Binding σ
    portWrite : {σ : Type} → X86.Helpers.IO_Write.Binding σ
    invalidateAllTranslations : {σ : Type} → X86.Invalidate_All_Translation_Caches.Binding σ
    invalidateTranslations : {σ : Type} → X86.Invalidate_Translation_Caches.Binding σ
    cacheInvalidate : {σ : Type} → X86.Helpers.Cache.Invalidate.Binding σ
    cacheFlush : {σ : Type} → [PhysicalMemory σ] → X86.Helpers.Cache.Flush_By_Address.Binding σ
    cacheWriteback : {σ : Type} → X86.Helpers.Cache.Writeback.Binding σ
    prefetch : {σ : Type} → X86.Helpers.Cache.Prefetch_By_Address.Binding σ
    stringStride : {σ : Type} → X86.Helpers.Get_Repeat_String_Stride.Binding σ
    timestamp : {σ : Type} → X86.Helpers.Read_Time_Stamp_Counter.Binding σ
    processor : Processor
    daz16 : {σ : Type} → X86.Read_MXCSR_DAZ16.Binding σ
    ftz16 : {σ : Type} → X86.Read_MXCSR_FTZ16.Binding σ

attribute [instance_reducible, instance]
  Bindings.processor Bindings.numerical Bindings.remainderReduction Bindings.fxsave
  Bindings.compareMemory Bindings.stackReturn
  Bindings.memoryType Bindings.cacheControl Bindings.portRead Bindings.portWrite
  Bindings.invalidateAllTranslations Bindings.invalidateTranslations Bindings.cacheInvalidate Bindings.cacheWriteback Bindings.cacheFlush
  Bindings.prefetch Bindings.stringStride Bindings.timestamp
  Bindings.daz16 Bindings.ftz16
  Bindings.msrReadAllowedFallback Bindings.msrWriteAllowedFallback Bindings.msrReadFallback
  Bindings.msrWriteBehaviorFallback Bindings.msrCommitFallback

@[instance_reducible, instance]
def Bindings.config [bindings : Bindings] : X86.Config :=
  bindings.processor.config

@[instance_reducible, instance]
def Bindings.cpuidBinding [bindings : Bindings] {σ : Type} : X86.Get_CPUID_Value.Binding σ :=
  bindings.processor.cpuidBinding

@[instance_reducible, instance]
def Bindings.cacheControlBinding [Bindings] {σ : Type} : X86.Helpers.Get_Cache_Disabled_Memory_Type.Binding σ :=
  Bindings.processor.cacheControlBinding

@[instance_reducible, instance]
def Bindings.processorTypeBinding [bindings : Bindings] : X86.__Implements_Processor_Type.Binding :=
  bindings.processor.processorTypeBinding

end X86.Machine
