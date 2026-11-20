import Lean
import Prelude.Bytes.Chunked

namespace Prelude.Bytes

open Lean Elab Term

/--
Embed a binary file at elaboration time, relative to the current Lean source. Note the
file must also be declared as a Lake build dependency.
-/
elab "include_bytes " path:str : term => do
  let source := System.FilePath.mk (← readThe Core.Context).fileName
  let some directory := source.parent
    | throwError "cannot compute parent directory of `{source}`"
  let bytes ← IO.FS.readBinFile (directory / path.getString)
  return mkApp (mkConst ``ByteArray.mk) (toExpr bytes.data)

/-- The little-endian value of at most 8 bytes from `start` -/
private def littleEndianWord (bytes : ByteArray) (start size : Nat) : Nat := Id.run do
  if size == 8 then
    return (bytes.extract start (start + 8)).toUInt64LE!.toNat
  let mut value : UInt64 := 0
  for offset in [0:size] do
    value := value ||| bytes[start + offset]!.toUInt64 <<< (8 * offset).toUInt64
  return value.toNat

/-- The little-endian value of `size` bytes from `start`. Halving the range keeps the cost
quasi-linear; adding one byte at a time would copy the growing number at each byte. The halves
split at a multiple of 8 bytes, so all words but the last are read by `ByteArray.toUInt64LE!`:
this elaborator runs in Lean's interpreter, where a loop per byte is slow and allocates, and
Lean counts allocations as heartbeats. -/
private def littleEndian (bytes : ByteArray) (start size : Nat) : Nat :=
  if size ≤ 8 then
    littleEndianWord bytes start size
  else
    let low := max 8 (size / 16 * 8)
    littleEndian bytes start low + littleEndian bytes (start + low) (size - low) <<< (8 * low)
termination_by size
decreasing_by all_goals simp only [Nat.max_def]; split <;> omega

/--
Embed a binary file at elaboration time as `Bytes.Chunked`, relative to the current Lean source.
The term holds one natural-number literal per chunk, and at most 1024 chunks
(`Chunked.chunkSizeFor`), so it elaborates, compiles and serializes quickly: about 10 s for
64 MiB, and within Lean's default heartbeats up to about 300 MiB. Note the file must also be
declared as a Lake build dependency.
-/
elab "include_chunked_bytes " path:str : term => do
  let source := System.FilePath.mk (← readThe Core.Context).fileName
  let some directory := source.parent
    | throwError "cannot compute parent directory of `{source}`"
  let bytes ← IO.FS.readBinFile (directory / path.getString)
  let chunkSize := Chunked.chunkSizeFor bytes.size
  let mut chunks : Array Expr := #[]
  let mut start := 0
  while start < bytes.size do
    chunks := chunks.push (mkNatLit (littleEndian bytes start (min chunkSize (bytes.size - start))))
    start := start + chunkSize
  let table ← Meta.mkArrayLit (mkConst ``Nat) chunks.toList
  return mkApp4 (mkConst ``Chunked.mk) (mkNatLit bytes.size) (mkNatLit chunkSize) table
    (mkNatLit 0)

end Prelude.Bytes
