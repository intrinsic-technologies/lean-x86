-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/IRET-IRETD-IRETQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.IRET where
  -- IRET: REG0=XED_REG_STACKPOP:rw:spw5:SUPP REG1=rIP():w:SUPP
  | IRET
  -- IRETD: REG0=XED_REG_STACKPOP:rw:spw5:SUPP REG1=rIP():w:SUPP
  | IRETD
  -- IRETQ: REG0=XED_REG_STACKPOP:rw:spw5:SUPP REG1=XED_REG_RIP:w:SUPP
  | IRETQ
  deriving Repr, BEq, Inhabited

def Forms.IRET.xedForm : Forms.IRET → XedForm
  | .IRET => .IRET
  | .IRETD => .IRETD
  | .IRETQ => .IRETQ

def Forms.IRET.encodingFits : Forms.IRET → Bool
  | .IRET  => true
  | .IRETD  => true
  | .IRETQ  => true

end X86.Syntax
