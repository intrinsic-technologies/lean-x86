namespace Prelude.Bytes

/-- `count` bytes of a natural number, least significant first -/
def bytesLE : Nat → Nat → List UInt8
  | 0, _ => []
  | count + 1, value => UInt8.ofNat value :: bytesLE count (value / 256)

end Prelude.Bytes
