-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SYSCALL.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SYSCALL where
  -- SYSCALL: REG0=XED_REG_RIP:w:SUPP REG1=XED_REG_RCX:w:SUPP REG2=XED_REG_R11:w:SUPP
  | SYSCALL
  deriving Repr, BEq, Inhabited

def Forms.SYSCALL.xedForm : Forms.SYSCALL → XedForm
  | .SYSCALL => .SYSCALL

def Forms.SYSCALL.encodingFits : Forms.SYSCALL → Bool
  | .SYSCALL  => true

end X86.Syntax
