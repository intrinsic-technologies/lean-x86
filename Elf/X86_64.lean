/-!
The definitions of the x86-64 processor supplement to the System V ABI (the psABI): its
`e_machine` and the relocation types the reader names.
-/

namespace Elf

/-- `e_machine` of x86-64.

Linux: `EM_X86_64` in `include/uapi/linux/elf-em.h`. -/
def EM_X86_64 : Nat := 62

/-- `ELF64_R_TYPE` of a relocation that stores the load bias plus the addend, in the psABI's
relocation table.

Linux: `R_X86_64_RELATIVE` in `arch/x86/include/asm/elf.h`. -/
def R_X86_64_RELATIVE : Nat := 8

end Elf
