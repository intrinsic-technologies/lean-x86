-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LEA.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LEA where
  -- LEA_GPRv_AGEN: REG0=GPRv_R():w AGEN:r
  | LEA_GPRv_AGEN (reg0 : Registers.GPRv) (agen : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.LEA.xedForm : Forms.LEA → XedForm
  | .LEA_GPRv_AGEN _ _ => .LEA_GPRv_AGEN

def Forms.LEA.encodingFits : Forms.LEA → Bool
  | .LEA_GPRv_AGEN _ agen => agen.encodingFits

end X86.Syntax
