import X86.State

namespace Prelude.EFER

open X86

/-- Long mode enabled and active -/
structure LongModeActive (efer : EFER_Inputs) : Prop where
  lme : efer.LME = 1
  lma : efer.LMA = 1

/-- Execute-disable page protection disabled -/
structure ExecuteDisableDisabled (efer : EFER_Inputs) : Prop where
  nxe : efer.NXE = 0

end Prelude.EFER
