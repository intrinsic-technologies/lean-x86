import Lean
import Prelude.Bytes.Encoding

/-!
Byte-list literals of UTF-8 text, for names that the `Elf` reader compares byte by byte:
`utf8_bytes "main"`.
-/

namespace Prelude.Bytes

open Lean

/--
The UTF-8 bytes of a string literal, as `bytesLE` of one natural number. The kernel
unfolds it to a byte list in a step per byte; it cannot evaluate `String.toUTF8` on a literal in
reasonable time. A list literal would cost compiled code per byte.
-/
elab "utf8_bytes " text:str : term => do
  let bytes := text.getString.toUTF8
  let value := bytes.toList.foldr (fun byte value => value * 256 + byte.toNat) 0
  return mkApp2 (mkConst ``bytesLE) (mkNatLit bytes.size) (mkNatLit value)

/-- Show `bytesLE` of printable UTF-8 text as the `utf8_bytes` term it elaborates
from. -/
@[app_unexpander bytesLE]
def unexpandBytesLE : PrettyPrinter.Unexpander
  | `($_ $count:num $value:num) => do
    unless value.getNat < 256 ^ count.getNat do throw ()
    let bytes := bytesLE count.getNat value.getNat
    match String.fromUTF8? ⟨bytes.toArray⟩ with
    | some text =>
        if text.toList.any fun (c : Char) => c.val < 32 || c.val == 127 then throw ()
        else `(utf8_bytes $(Syntax.mkStrLit text))
    | none => throw ()
  | _ => throw ()

end Prelude.Bytes
