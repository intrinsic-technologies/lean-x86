import X86.Helpers.Cache.Flush_By_Address
import X86.Helpers.Cache.Invalidate
import X86.Helpers.Cache.Prefetch_By_Address
import X86.Helpers.Cache.Writeback

namespace X86.Machine.Bindings.Cache

open X86.Helpers

-- Cache contents, write-back effects and translation caches belong to the caller's machine model.
instance {σ : Type} : X86.Invalidate_Translation_Caches.Binding σ where
  call _ _ := throw (.externalFailure "Invalidate_Translation_Caches requires a caller binding")

instance {σ : Type} : X86.Invalidate_All_Translation_Caches.Binding σ where
  call := throw (.externalFailure "Invalidate_All_Translation_Caches requires a caller binding")

instance {σ : Type} : Cache.Invalidate.Binding σ where
  call := throw (.externalFailure "Cache::Invalidate requires a caller binding")

instance {σ : Type} : Cache.Flush_By_Address.Binding σ where
  call _ _ := throw (.externalFailure "Cache::Flush_By_Address requires a caller binding")

instance {σ : Type} : Cache.Writeback.Binding σ where
  call _ := throw (.externalFailure "Cache::Writeback requires a caller binding")

/--
Ignore cache hints in a machine that does not model caches or their timing.
The generated instruction still computes the address and checks its prefixes.
-/
@[instance_reducible] def ignorePrefetch {σ : Type} : Cache.Prefetch_By_Address.Binding σ :=
  ⟨fun _ _ _ _ _ => pure ()⟩

end X86.Machine.Bindings.Cache
