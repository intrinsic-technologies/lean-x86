import Std

/-!
Local byte inspection for static form selection and export. This reads only the
prefix fields needed by those tools. Instruction execution uses Intel's generated
`Fetch_And_Execute`, including its memory reads and faults.
-/

namespace X86.Decode

/-- REX fields used by generated form selection. -/
structure Rex where
  present : Bool := false
  w : Bool := false
  b : Bool := false
  deriving Repr, DecidableEq, Inhabited

/-- Prefix fields used by form selection. Segment overrides do not select forms. -/
structure PrefixState where
  operand16 : Bool := false
  address32 : Bool := false
  lock : Bool := false
  repeatPrefix : Nat := 0
  rex : Rex := {}
  deriving Repr, DecidableEq, Inhabited

def byteAt (bytes : ByteArray) (position : Nat) : Option Nat :=
  (bytes[position]?).map UInt8.toNat

def rexOfByte (byte : Nat) : Rex :=
  { present := true
    w := (byte / 8) % 2 = 1
    b := byte % 2 = 1 }

def parsePrefixes (bytes : ByteArray) (start : Nat) : Option (PrefixState × Nat) :=
  let rec loop (fuel position : Nat) (state : PrefixState) : Option (PrefixState × Nat) :=
    match fuel with
    | 0 => none
    | fuel + 1 => do
        let byte ← byteAt bytes position
        -- Intel ignores a REX prefix followed by any legacy prefix.
        let legacy := { state with rex := {} }
        if byte = 0x66 then
          loop fuel (position + 1) { legacy with operand16 := true }
        else if byte = 0x67 then
          loop fuel (position + 1) { legacy with address32 := true }
        else if byte = 0xf0 then
          loop fuel (position + 1)
            { legacy with lock := true }
        else if byte = 0xf2 then
          loop fuel (position + 1)
            { legacy with repeatPrefix := 242 }
        else if byte = 0xf3 then
          loop fuel (position + 1)
            { legacy with repeatPrefix := 243 }
        else if byte == 0x26 || byte == 0x2e || byte == 0x36 ||
            byte == 0x3e || byte == 0x64 || byte == 0x65 then
          loop fuel (position + 1) legacy
        else if 0x40 ≤ byte ∧ byte ≤ 0x4f then
          loop fuel (position + 1) { state with rex := rexOfByte byte }
        else
          some (state, position)
  loop 15 start {}

end X86.Decode
