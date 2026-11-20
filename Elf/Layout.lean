/-!
Where an ELF64 record keeps each field: its offset in the record and its width, in bytes, from the
record layouts in Linux 7.0's `include/uapi/linux/elf.h`. An `Elf64_Half` is 2 bytes, an
`Elf64_Word` 4, and an `Elf64_Addr`, `Elf64_Off`, `Elf64_Xword` or `Elf64_Sxword` 8. Each field
starts where the one before it ends, so no record has padding, and a record's size is the end of
its last field.
-/

namespace Elf

/-- A field of an ELF record: its offset in the record and its width, in bytes -/
structure Field where
  offset : Nat
  width : Nat

/-! ### `Elf64_Ehdr`, the file header, at the start of the file -/

/-- `e_ident[EI_MAG0]` to `e_ident[EI_MAG3]`, the magic number (`SELFMAG` bytes from `EI_MAG0`) -/
def EI_MAG : Field := ⟨0, 4⟩
/-- `e_ident[EI_CLASS]`, the class: 32-bit or 64-bit records -/
def EI_CLASS : Field := ⟨4, 1⟩
/-- `e_ident[EI_DATA]`, the byte order -/
def EI_DATA : Field := ⟨5, 1⟩
/-- `e_type`, after `e_ident`'s `EI_NIDENT` (16) bytes -/
def e_type : Field := ⟨16, 2⟩
/-- `e_machine` -/
def e_machine : Field := ⟨18, 2⟩
/-- `e_entry`, after `e_version` (4 bytes at 20) -/
def e_entry : Field := ⟨24, 8⟩
/-- `e_phoff` -/
def e_phoff : Field := ⟨32, 8⟩
/-- `e_shoff` -/
def e_shoff : Field := ⟨40, 8⟩
/-- `e_phentsize`, after `e_flags` (4 bytes at 48) and `e_ehsize` (2 bytes at 52) -/
def e_phentsize : Field := ⟨54, 2⟩
/-- `e_phnum` -/
def e_phnum : Field := ⟨56, 2⟩
/-- `e_shentsize` -/
def e_shentsize : Field := ⟨58, 2⟩
/-- `e_shnum` -/
def e_shnum : Field := ⟨60, 2⟩
/-- `e_shstrndx` -/
def e_shstrndx : Field := ⟨62, 2⟩
/-- The size of `Elf64_Ehdr`: the end of `e_shstrndx` -/
def fileHeaderSize : Nat := 64

/-! ### `Elf64_Phdr`, a program header -/

/-- `p_type` -/
def p_type : Field := ⟨0, 4⟩
/-- `p_flags` -/
def p_flags : Field := ⟨4, 4⟩
/-- `p_offset` -/
def p_offset : Field := ⟨8, 8⟩
/-- `p_vaddr` -/
def p_vaddr : Field := ⟨16, 8⟩
/-- `p_paddr` -/
def p_paddr : Field := ⟨24, 8⟩
/-- `p_filesz` -/
def p_filesz : Field := ⟨32, 8⟩
/-- `p_memsz` -/
def p_memsz : Field := ⟨40, 8⟩
/-- `p_align` -/
def p_align : Field := ⟨48, 8⟩
/-- The size of `Elf64_Phdr`: the end of `p_align` -/
def programHeaderSize : Nat := 56

/-! ### `Elf64_Shdr`, a section header -/

/-- `sh_name` -/
def sh_name : Field := ⟨0, 4⟩
/-- `sh_type` -/
def sh_type : Field := ⟨4, 4⟩
/-- `sh_flags` -/
def sh_flags : Field := ⟨8, 8⟩
/-- `sh_addr` -/
def sh_addr : Field := ⟨16, 8⟩
/-- `sh_offset` -/
def sh_offset : Field := ⟨24, 8⟩
/-- `sh_size` -/
def sh_size : Field := ⟨32, 8⟩
/-- `sh_link` -/
def sh_link : Field := ⟨40, 4⟩
/-- `sh_info` -/
def sh_info : Field := ⟨44, 4⟩
/-- `sh_addralign` -/
def sh_addralign : Field := ⟨48, 8⟩
/-- `sh_entsize` -/
def sh_entsize : Field := ⟨56, 8⟩
/-- The size of `Elf64_Shdr`: the end of `sh_entsize` -/
def sectionHeaderSize : Nat := 64

/-! ### `Elf64_Sym`, a symbol -/

/-- `st_name` -/
def st_name : Field := ⟨0, 4⟩
/-- `st_info`: the type and binding -/
def st_info : Field := ⟨4, 1⟩
/-- `st_other` -/
def st_other : Field := ⟨5, 1⟩
/-- `st_shndx` -/
def st_shndx : Field := ⟨6, 2⟩
/-- `st_value` -/
def st_value : Field := ⟨8, 8⟩
/-- `st_size` -/
def st_size : Field := ⟨16, 8⟩
/-- The size of `Elf64_Sym`: the end of `st_size` -/
def symbolSize : Nat := 24

/-- `ELF64_ST_TYPE`: the type in the low four bits of `st_info`.

Linux: `ELF_ST_TYPE` in `include/uapi/linux/elf.h`. -/
def ELF64_ST_TYPE (info : Nat) : Nat := info % 16

/-- `ELF64_ST_BIND`: the binding in the high four bits of `st_info`.

Linux: `ELF_ST_BIND` in `include/uapi/linux/elf.h`. -/
def ELF64_ST_BIND (info : Nat) : Nat := info / 16

/-! ### `Elf64_Rela`, a relocation with addend -/

/-- `r_offset` -/
def r_offset : Field := ⟨0, 8⟩
/-- `r_info`: the symbol index and relocation type -/
def r_info : Field := ⟨8, 8⟩
/-- `r_addend` -/
def r_addend : Field := ⟨16, 8⟩
/-- The size of `Elf64_Rela`: the end of `r_addend` -/
def relaSize : Nat := 24

/-- `ELF64_R_TYPE`: the relocation type in the low 32 bits of `r_info`.

Linux: `ELF64_R_TYPE` in `include/uapi/linux/elf.h`. -/
def ELF64_R_TYPE (info : Nat) : Nat := info % 2 ^ 32

/-- `ELF64_R_SYM`: the symbol index in the high 32 bits of `r_info`.

Linux: `ELF64_R_SYM` in `include/uapi/linux/elf.h`. -/
def ELF64_R_SYM (info : Nat) : Nat := info / 2 ^ 32

/-! ### `Elf64_Dyn`, a dynamic entry -/

/-- `d_tag` -/
def d_tag : Field := ⟨0, 8⟩
/-- `d_un`, read as `d_val` or `d_ptr` -/
def d_val : Field := ⟨8, 8⟩
/-- The size of `Elf64_Dyn`: the end of `d_un` -/
def dynamicEntrySize : Nat := 16

end Elf
