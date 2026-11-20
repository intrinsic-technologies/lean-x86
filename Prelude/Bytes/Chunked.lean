import Elf.Bytes

namespace Prelude.Bytes

/--
Bytes as little-endian natural-number chunks of `chunkSize` bytes each, the first byte of a chunk
in its low eight bits. A byte lookup is one chunk lookup and one shift, which the kernel
evaluates with GMP. `readLE` finds a chunk by walking the chunk list, so its kernel cost grows
with the chunk's index but not with the byte's position in the chunk. Byte 0 is at position
`base` of the chunks, so `extract` shares the chunks of the bytes it is taken from.
-/
structure Chunked where
  size : Nat
  chunkSize : Nat
  chunks : Array Nat
  /-- The position of byte 0 in `chunks` -/
  base : Nat := 0

namespace Chunked

/-- The chunk size for `size` bytes: 8 KiB, or more for over 8 MiB, so that there are at most
1024 chunks. Lean elaborates and compiles a literal of that many chunks quickly; one of a few
thousand exceeds its recursion depth. -/
def chunkSizeFor (size : Nat) : Nat :=
  max 8192 ((size + 1023) / 1024)

/-- The chunk at an index, or 0 past the last chunk, by walking the chunk list: `readLE`'s
lookup. The kernel walks the list about seven times faster than it indexes the array; compiled
code copies the array to a list, at most 1024 chunks, for each lookup. -/
def chunk (data : Chunked) (index : Nat) : Nat :=
  data.chunks.toList.getD index 0

/-- The byte at an index below `size` -/
def get? (data : Chunked) (index : Nat) : Option UInt8 :=
  if index < data.size then
    let position := data.base + index
    some (UInt8.ofNat (data.chunks[position / data.chunkSize]! >>> (8 * (position % data.chunkSize))))
  else none

/-- The byte at an index below `size`, and `fallback` at or past it -/
def getD (data : Chunked) (index : Nat) (fallback : UInt8 := 0) : UInt8 :=
  (data.get? index).getD fallback

/-- `count` bytes from `start`. The kernel unfolds `List.map` over `List.range'` one byte at a
time, so a list operation near the start does not evaluate every byte. Compiled code runs core's
tail-recursive `List.mapTR` and `List.range'TR`, which core's `@[csimp]` theorems prove equal, so
it does not recurse once per byte. -/
def toListFrom (data : Chunked) (start count : Nat) : List UInt8 :=
  (List.range' start count).map data.getD

/-- The bytes in order -/
def toList (data : Chunked) : List UInt8 :=
  data.toListFrom 0 data.size

/-- The little-endian value of `width` bytes from `offset`, read a byte at a time: `readLE`'s
path for a value that spans two chunks -/
def readLEBytewise (data : Chunked) : Nat → Nat → Nat
  | _, 0 => 0
  | offset, width + 1 => (data.getD offset).toNat + 256 * data.readLEBytewise (offset + 1) width

/-- The little-endian value of `width` bytes from `offset`; meaningful below `size`. A value
within one chunk is one chunk lookup and one shift. -/
def readLE (data : Chunked) (offset width : Nat) : Nat :=
  let position := data.base + offset
  if position % data.chunkSize + width ≤ data.chunkSize then
    (data.chunk (position / data.chunkSize) >>> (8 * (position % data.chunkSize))) % 2 ^ (8 * width)
  else
    data.readLEBytewise offset width

/-- The bytes from index `start` to `stop`, sharing the chunks, so that a lookup costs what it
costs in `data` -/
def extract (data : Chunked) (start stop : Nat) : Chunked :=
  { data with base := data.base + start, size := min stop data.size - start }

/-- The bytes as a byte array -/
def toByteArray (data : Chunked) : ByteArray :=
  ⟨data.toList.toArray⟩

end Chunked

instance : Elf.ByteSource Chunked where
  size := Chunked.size
  readLE := Chunked.readLE

end Prelude.Bytes
