import Std
import X86.Runtime.BitsImpl

namespace X86.Runtime

-- An explicit stream of unspecified bits. Proofs can quantify over every stream;
-- executable tests supply one, without prescribing architectural values.
structure Oracle where
  bits : Nat → Bool := fun _ => false
  position : Nat := 0
  /-- Bits at or after this index are false. `none` means no limit. -/
  limit : Option Nat := none

/-- The next `size` bits, least significant first, and the advanced oracle. Bits at or after
`limit` are zero and are not read. -/
def Oracle.take (oracle : Oracle) (size : Nat) : BitVec size × Oracle :=
  let available := match oracle.limit with
    | some limit => min size (limit - oracle.position)
    | none => size
  (BitVec.ofNat size (go available 0 0), { oracle with position := oracle.position + size })
where
  /-- Adds the `count` bits from index `i` on to `value`. -/
  go : Nat → Nat → Nat → Nat
    | 0, _, value => value
    | count + 1, i, value =>
        go count (i + 1) (if oracle.bits (oracle.position + i) then value + 2 ^ i else value)

/-- The finite stream `bits`, false after its end. -/
def Oracle.ofList (bits : List Bool) : Oracle :=
  let array := bits.toArray
  { bits := fun index => array[index]?.getD false, limit := some array.size }

end X86.Runtime
