-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/RDMSR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.RDMSR where
  -- RDMSR: REG0=XED_REG_EAX:w:SUPP REG1=XED_REG_EDX:w:SUPP REG2=XED_REG_ECX:r:SUPP REG3=XED_REG_MSRS:r:SUPP
  | RDMSR
  deriving Repr, BEq, Inhabited

def Forms.RDMSR.xedForm : Forms.RDMSR → XedForm
  | .RDMSR => .RDMSR

def Forms.RDMSR.encodingFits : Forms.RDMSR → Bool
  | .RDMSR  => true

end X86.Syntax
