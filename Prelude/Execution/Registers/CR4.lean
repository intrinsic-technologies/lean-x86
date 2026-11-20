import X86.State

namespace Prelude.CR4

open X86

/-- Four-level paging selected in IA-32e mode -/
structure FourLevelPaging (cr4 : CR4_Type) : Prop where
  pae : cr4.PAE = 1
  la57 : cr4.LA57 = 0

/-- Virtual-interrupt modes disabled -/
structure VirtualInterruptsDisabled (cr4 : CR4_Type) : Prop where
  vme : cr4.VME = 0
  pvi : cr4.PVI = 0

/-- Supervisor-mode execution prevention disabled -/
structure SupervisorExecutionProtectionDisabled (cr4 : CR4_Type) : Prop where
  smep : cr4.SMEP = 0

/-- Supervisor-mode access prevention disabled -/
structure SupervisorAccessProtectionDisabled (cr4 : CR4_Type) : Prop where
  smap : cr4.SMAP = 0

/-- User-mode protection keys disabled -/
structure UserProtectionKeysDisabled (cr4 : CR4_Type) : Prop where
  pke : cr4.PKE = 0

/-- Control-flow enforcement disabled -/
structure ControlFlowEnforcementDisabled (cr4 : CR4_Type) : Prop where
  cet : cr4.CET = 0

/-- Operating-system support for SSE state and exceptions enabled -/
structure SSEEnabled (cr4 : CR4_Type) : Prop where
  osfxsr : cr4.OSFXSR = 1
  osxmmexcpt : cr4.OSXMMEXCPT = 1

end Prelude.CR4
