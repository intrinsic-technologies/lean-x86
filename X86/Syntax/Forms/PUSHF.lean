-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PUSHF-PUSHFD-PUSHFQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PUSHF where
  -- PUSHF: REG0=XED_REG_STACKPUSH:rw:w:SUPP REG1=XED_REG_RFLAGS:r:SUPP:w:u16
  | PUSHF
  -- PUSHFQ: REG0=XED_REG_STACKPUSH:rw:q:SUPP REG1=XED_REG_RFLAGS:r:SUPP:q:u64
  | PUSHFQ
  deriving Repr, BEq, Inhabited

def Forms.PUSHF.xedForm : Forms.PUSHF → XedForm
  | .PUSHF => .PUSHF
  | .PUSHFQ => .PUSHFQ

def Forms.PUSHF.encodingFits : Forms.PUSHF → Bool
  | .PUSHF  => true
  | .PUSHFQ  => true

end X86.Syntax
