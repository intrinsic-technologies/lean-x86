-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOV_CR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOV_CR where
  -- MOV_CR_CR_GPR64: REG0=CR_R():w REG1=GPR64_B():r
  | MOV_CR_CR_GPR64 (reg0 : Registers.CR) (reg1 : Registers.GPR64)
  -- MOV_CR_GPR64_CR: REG0=GPR64_B():w REG1=CR_R():r
  | MOV_CR_GPR64_CR (reg0 : Registers.GPR64) (reg1 : Registers.CR)
  deriving Repr, BEq, Inhabited

def Forms.MOV_CR.xedForm : Forms.MOV_CR → XedForm
  | .MOV_CR_CR_GPR64 _ _ => .MOV_CR_CR_GPR64
  | .MOV_CR_GPR64_CR _ _ => .MOV_CR_GPR64_CR

def Forms.MOV_CR.encodingFits : Forms.MOV_CR → Bool
  | .MOV_CR_CR_GPR64 _ _ => true
  | .MOV_CR_GPR64_CR _ _ => true

end X86.Syntax
