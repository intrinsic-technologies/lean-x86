import X86.Decode.Prefixes
import X86.Decode.Decoded
import X86.Helpers.Decode_Legacy_0
import X86.Helpers.Decode_Legacy_1

namespace X86.Decode

open X86.Syntax

private def requireValue (message : String) : Option α → Except String α
  | some value => .ok value
  | none => .error message

private def selectionResult (result : Except (X86.Runtime.Error Empty) α) : Except String α :=
  result.mapError (fun error => s!"generated selector failure: {reprStr error}")

/--
Select a generated form from legacy instruction bytes in 64-bit mode. This
returns a typed Intel source form identifier. It calls the same
generated selection functions as execution. It does not read
immediates or displacement bytes, check instruction length, or execute operands.
-/
def selectForm (features : DecodeFeatures) (bytes : ByteArray) : Except String Form := do
  let (prefixes, position) ← requireValue "truncated or overlong prefixes" (parsePrefixes bytes 0)
  let first ← requireValue "missing opcode" (byteAt bytes position)
  let (map, opcode, afterOpcode) ← if first == 0x0f then do
    let second ← requireValue "truncated opcode map" (byteAt bytes (position + 1))
    if second == 0x38 || second == 0x3a then do
      let third ← requireValue "truncated opcode" (byteAt bytes (position + 2))
      pure (if second == 0x38 then 2 else 3, third, position + 3)
    else pure (1, second, position + 2)
    else pure (0, first, position + 1)
  if map > 1 then throw "unselected opcode map"
  -- The generated selector reads only these prefix fields. The remaining
  -- context fields, including segment contents, do not enter form selection.
  let context : X86.Helpers.Instruction_Context := {
    (default : X86.Helpers.Instruction_Context) with
    is_mode64 := true
    osz_prefix_present := prefixes.operand16
    asz_prefix_present := prefixes.address32
    lock_prefix_present := prefixes.lock
    rep_prefix := Int.ofNat prefixes.repeatPrefix
    rex_prefix_present := prefixes.rex.present
    rex_w := if prefixes.rex.w then 1 else 0
    rex_b3 := if prefixes.rex.b then 1 else 0
    address_size := if prefixes.address32 then 32 else 64
  }
  let opcode := BitVec.ofNat 8 opcode
  let usesModRM ← selectionResult <| match map with
    | 0 => X86.Helpers.Legacy_0_Uses_ModRM opcode
    | _ => X86.Helpers.Legacy_1_Uses_ModRM opcode
  let modrm ← if usesModRM then
    requireValue "truncated ModRM" (byteAt bytes afterOpcode)
    else pure 0
  let select := match map with
    | 0 => X86.Helpers.Select_Legacy_0
    | _ => X86.Helpers.Select_Legacy_1
  let selected : Int ← selectionResult <| select context true features.lzcnt features.mmx features.sse features.sse2
    features.cet features.cmpxchg16b opcode (BitVec.ofNat 8 modrm)
  if selected == 0 then throw "unselected instruction form"
  let names ← selectionResult <| if map == 0 then X86.Helpers.Legacy_0_Form_Names opcode (Int.ofNat selected.natAbs)
    else X86.Helpers.Legacy_1_Form_Names opcode (Int.ofNat selected.natAbs)
  if selected < 0 then throw s!"disabled capability for {names.1}"
  requireValue "generated selector returned an unknown form" (Form.ofNames names.1 names.2)

end X86.Decode
