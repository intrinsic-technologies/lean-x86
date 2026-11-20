/-!
GNU extensions to ELF, in the OS-specific ranges of the System V ABI.
-/

namespace Elf

/-- `p_type` of the GNU stack-permission header, `PT_LOOS + 0x474e551`; its `PF_X` asks for an
executable stack.

Linux: `PT_GNU_STACK` and `PT_LOOS` (`0x60000000`) in `include/uapi/linux/elf.h`. -/
def PT_GNU_STACK : Nat := 0x6474e551

end Elf
