namespace X86.Syntax

inductive Width where
  | w8 | w16 | w32 | w64
  deriving Repr, DecidableEq, Inhabited

def Width.bits : Width → Nat
  | .w8 => 8
  | .w16 => 16
  | .w32 => 32
  | .w64 => 64

inductive Reg where
  | rax | rcx | rdx | rbx | rsp | rbp | rsi | rdi
  | r8 | r9 | r10 | r11 | r12 | r13 | r14 | r15
  deriving Repr, DecidableEq, Inhabited

def Reg.fin : Reg → Fin 16
  | .rax => 0 | .rcx => 1 | .rdx => 2 | .rbx => 3
  | .rsp => 4 | .rbp => 5 | .rsi => 6 | .rdi => 7
  | .r8 => 8 | .r9 => 9 | .r10 => 10 | .r11 => 11
  | .r12 => 12 | .r13 => 13 | .r14 => 14 | .r15 => 15

inductive Segment where
  | es | cs | ss | ds | fs | gs
  deriving Repr, DecidableEq

inductive Scale where
  | one | two | four | eight
  deriving Repr, DecidableEq, Inhabited

def Scale.value : Scale → Nat
  | .one => 1 | .two => 2 | .four => 4 | .eight => 8

structure Address where
  base : Option Reg
  index : Option (Reg × Scale)
  displacement : Int
  ripRelative : Bool
  addressWidth : Width
  segment : Option Segment
  deriving Repr, DecidableEq, Inhabited

structure Immediate where
  value : BitVec 64
  encodedWidth : Width
  signExtend : Bool := false
  deriving Repr, DecidableEq, Inhabited

/-- An encoded displacement width. `none` means that no displacement bytes occur. -/
inductive DisplacementWidth where
  | none | w8 | w16 | w32 | w64
  deriving Repr, DecidableEq, Inhabited

/--
An address expression and its encoded displacement width. The address uses the
shared register, segment and scale types. It does not read memory.
-/
structure MemoryOperand where
  address : Address
  displacementWidth : DisplacementWidth
  deriving Repr, DecidableEq, Inhabited

/-- A signed offset from the end of the instruction, with its encoded width. -/
structure RelativeOperand where
  displacement : Int
  encodedWidth : Width
  deriving Repr, DecidableEq, Inhabited

def Immediate.encodingFits (value : Immediate) : Bool :=
  value.value.toNat < 2 ^ value.encodedWidth.bits

private def signedFits (value : Int) (width : Nat) : Bool :=
  -(2 ^ (width - 1) : Int) ≤ value && value < (2 ^ (width - 1) : Int)

def RelativeOperand.encodingFits (value : RelativeOperand) : Bool :=
  signedFits value.displacement value.encodedWidth.bits

def MemoryOperand.encodingFits (value : MemoryOperand) : Bool :=
  let widthFits := match value.displacementWidth with
    | .none => value.address.displacement == 0
    | .w8 => signedFits value.address.displacement 8
    | .w16 => signedFits value.address.displacement 16
    | .w32 => signedFits value.address.displacement 32
    | .w64 => signedFits value.address.displacement 64
  widthFits && (value.address.addressWidth == .w32 || value.address.addressWidth == .w64) &&
    (!value.address.ripRelative || (value.address.base.isNone && value.address.index.isNone))

end X86.Syntax
