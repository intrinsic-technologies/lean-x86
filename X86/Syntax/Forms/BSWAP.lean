-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/BSWAP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.BSWAP where
  -- BSWAP_GPRv: REG0=GPRv_SB():rw
  | BSWAP_GPRv (reg0 : Registers.GPRv)
  deriving Repr, BEq, Inhabited

def Forms.BSWAP.xedForm : Forms.BSWAP → XedForm
  | .BSWAP_GPRv _ => .BSWAP_GPRv

def Forms.BSWAP.encodingFits : Forms.BSWAP → Bool
  | .BSWAP_GPRv _ => true

end X86.Syntax
