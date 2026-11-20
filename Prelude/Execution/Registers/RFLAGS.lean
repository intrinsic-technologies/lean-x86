import X86.State

namespace Prelude.RFLAGS

open X86

/-- Trap flag clear, so execution does not request single-step debug traps -/
structure TrapFlagClear (rflags : RFLAGS_Type) : Prop where
  tf : rflags.TF = 0

/-- Resume flag clear, so instruction-breakpoint debug faults are not suppressed -/
structure ResumeFlagClear (rflags : RFLAGS_Type) : Prop where
  rf : rflags.RF = 0

/-- Direction flag clear, so string instructions advance their pointers -/
structure DirectionFlagClear (rflags : RFLAGS_Type) : Prop where
  df : rflags.DF = 0

end Prelude.RFLAGS
