import Elf.Read
import Elf.Gnu
import Elf.Slice

/-!
An ELF64 reader over any `Elf.ByteSource`, such as a `ByteArray` or an embedded
`Prelude.Bytes.Chunked`, for statements about a program's file. It reads what the file declares:
the header, program headers, sections, symbols, dynamic entries and relocations, and sections'
bytes as slices of the file (`Elf.Slice`). It does not say what Linux accepts or maps. The reader
depends only on Lean's core library.
-/
