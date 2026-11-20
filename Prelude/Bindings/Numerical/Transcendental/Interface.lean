import Prelude.Float.Binary80
import X86.Helpers.Rounding_Mode
import X86.Helpers.FP87_Control_Type
import X86.State

set_option autoImplicit false

namespace Prelude.Bindings.Numerical.Transcendental

inductive Operation where
  | exp2m1 | sin | cos | sincos | tan | atan2 | mulLog2 | mulLog2p1
  deriving DecidableEq, Repr

abbrev Encoding := BitVec 80

/-- Decode the architectural x87 rounding control independently of the machine state. -/
def roundingOfControl (control : X86.Helpers.FP87_Control_Type) : X86.Helpers.Rounding_Mode :=
  match (X86.Helpers.FP87_Control_Type.RC control).toNat with
  | 0 => .Rounding_Mode_RNE
  | 1 => .Rounding_Mode_RTN
  | 2 => .Rounding_Mode_RTP
  | _ => .Rounding_Mode_RTZ

def roundingOfState {σ : Type} (state : X86.State σ) : X86.Helpers.Rounding_Mode :=
  roundingOfControl state.FP87_Control

/-- Return fields are in architectural order: sincos=(cos,sin), tan=(1,tan). -/
structure Output where
  first : Encoding
  second : Encoding := 0
  roundedUp : Bool
  outOfRange : Bool := false
  flags : BitVec 6

/-- Select the computed function; the pushed one is not a tangent approximation. -/
def Output.result (r : Output) (op : Operation) (cosine : Bool := false) : Encoding :=
  match op with
  | .sincos => if cosine then r.first else r.second
  | .tan => r.second
  | _ => r.first

structure Input where
  operation : Operation
  x : Encoding
  y : Encoding := Prelude.Float.Binary80.one

end Prelude.Bindings.Numerical.Transcendental
