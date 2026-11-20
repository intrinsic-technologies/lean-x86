import X86.State

namespace Prelude.CR0

open X86

/-- Cache controls with not-write-through and cache-disable clear -/
structure WriteBackCaching (cr0 : CR0_Type) : Prop where
  nw : cr0.NW = 0
  cd : cr0.CD = 0

/-- Protected mode and paging enabled -/
structure ProtectedModePaging (cr0 : CR0_Type) : Prop where
  pe : cr0.PE = 1
  pg : cr0.PG = 1

/-- Alignment checking disabled -/
structure AlignmentCheckingDisabled (cr0 : CR0_Type) : Prop where
  am : cr0.AM = 0

/-- SSE execution permitted without emulation or task-switch traps -/
structure SSEEnabled (cr0 : CR0_Type) : Prop where
  em : cr0.EM = 0
  ts : cr0.TS = 0

end Prelude.CR0
