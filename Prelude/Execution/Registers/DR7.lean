import X86.State

namespace Prelude.DR7

open X86

/-- Debug-control profile 0x400 with hardware breakpoints disabled -/
structure BreakpointsDisabled (dr7 : DR7_Inputs) : Prop where
  value : dr7 = 0x400

end Prelude.DR7
