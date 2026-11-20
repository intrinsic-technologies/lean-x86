import X86.Helpers.Read_Time_Stamp_Counter

namespace X86.Machine.Bindings.Timestamp

open X86.Helpers

-- Intel supplies no timestamp-counter body. Callers must provide its result;
-- this instance rejects the missing input instead of inventing a clock value.
instance {σ : Type} : Read_Time_Stamp_Counter.Binding σ where
  call := throw (.externalFailure "Read_Time_Stamp_Counter requires a caller binding")

end X86.Machine.Bindings.Timestamp
