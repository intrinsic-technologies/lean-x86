/-!
Android's extensions to ELF: the dynamic tags of its packed relocation tables, which Android's
bionic defines and LLVM's linker writes. Linux and glibc do not define them.
-/

namespace Elf

/-- `d_tag` of the address of Android's packed relocations without addends.

LLVM: `ANDROID_REL` in `llvm/include/llvm/BinaryFormat/DynamicTags.def`, from Android's bionic. -/
def DT_ANDROID_REL : Nat := 0x6000000f
/-- `d_tag` of the address of Android's packed relocations with addends.

LLVM: `ANDROID_RELA` in `llvm/include/llvm/BinaryFormat/DynamicTags.def`, from Android's bionic. -/
def DT_ANDROID_RELA : Nat := 0x60000011
/-- `d_tag` of the address of Android's packed relative relocations, before `DT_RELR`.

LLVM: `ANDROID_RELR` in `llvm/include/llvm/BinaryFormat/DynamicTags.def`, from Android's
bionic. -/
def DT_ANDROID_RELR : Nat := 0x6fffe000

/-- The dynamic tags that locate one of Android's packed relocation tables -/
def androidRelocationTableTags : List Nat := [DT_ANDROID_REL, DT_ANDROID_RELA, DT_ANDROID_RELR]

end Elf
