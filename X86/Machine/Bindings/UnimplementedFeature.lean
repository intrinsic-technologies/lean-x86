import X86.Helpers.Unimplemented_Feature

namespace X86.Machine.Bindings.UnimplementedFeature

open X86.Helpers

variable {σ : Type}

-- Intel permits these markers to continue without changing the result.
-- - This machine has one core and synchronous RAM, with no interleaving within Step.
-- - It does not establish hardware atomicity or rollback after an external failure.
-- Other markers fail with the helper's own name, "unimplemented feature", whether the marker
-- comes from Intel's source or the local source and decoder.
instance : Unimplemented_Feature.Binding σ where
  call name continue_with_step fuzz_result :=
    if continue_with_step && !fuzz_result && ["Logical_Mem_Read(acquire_lock=>True)",
        "Logical_Mem_Write(release_lock=>True)", "LockedMemRead"].contains name then
      pure ()
    else
      throw (.externalFailure s!"unimplemented feature: {name}")

end X86.Machine.Bindings.UnimplementedFeature
