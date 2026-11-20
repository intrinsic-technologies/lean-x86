import Prelude.Bindings.Numerical.Transcendental.Analytic
import Prelude.Bindings.Numerical.Transcendental.Interface
import Prelude.Bindings.Numerical.Transcendental.Laws
import Prelude.Bindings.Numerical.Transcendental.Properties

set_option autoImplicit false

namespace Prelude.Bindings.Numerical.Transcendental

open Prelude.Bindings.Contract

/-- The SDM requirements in the supported domains (SDM 093 Vol. 1 8.3.8–8.3.10,
8.5 and the instruction pages). Approximation algorithms remain generic. -/
structure Satisfies {σ : Type} (implementation : X86.Machine.Bindings.Numerical σ) : Prop where
  pointwise : (contract σ).Satisfies (run implementation)
  monotone : MonotoneOnSegments implementation
  precisionControl : PrecisionControlIndependent implementation
  precisionMask : PrecisionMaskIndependent implementation

end Prelude.Bindings.Numerical.Transcendental
