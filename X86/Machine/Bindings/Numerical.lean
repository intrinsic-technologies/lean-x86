import X86.Helpers.Emulate_RCPSS
import X86.Helpers.Emulate_F2XM1

namespace X86.Machine.Bindings

/-- Explicit numerical implementations. This interface alone asserts no SDM conformance;
portable proofs use the corresponding specification contracts. -/
class Numerical (σ : Type) where
  reciprocal : Helpers.Emulate_RCPSS.Binding σ
  reciprocalSqrt : Helpers.Emulate_RSQRTSS.Binding σ
  exp2m1 : Helpers.Emulate_F2XM1.Binding σ
  sin : Helpers.Emulate_FSIN.Binding σ
  cos : Helpers.Emulate_FCOS.Binding σ
  sincos : Helpers.Emulate_FSINCOS.Binding σ
  /-- The tangent for FPTAN, which also pushes 1. -/
  tan : Helpers.Emulate_FPTAN.Binding σ
  atan2 : Helpers.Emulate_FPATAN.Binding σ
  mulLog2 : Helpers.Emulate_FYL2X.Binding σ
  mulLog2p1 : Helpers.Emulate_FYL2XP1.Binding σ

attribute [instance_reducible, instance]
  Numerical.reciprocal Numerical.reciprocalSqrt Numerical.exp2m1
  Numerical.sin Numerical.cos Numerical.sincos Numerical.tan
  Numerical.atan2 Numerical.mulLog2 Numerical.mulLog2p1

end X86.Machine.Bindings
