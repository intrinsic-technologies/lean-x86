-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/WRMSR.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.WRMSR where
  -- WRMSR: REG0=XED_REG_EAX:r:SUPP REG1=XED_REG_EDX:r:SUPP REG2=XED_REG_ECX:r:SUPP REG3=XED_REG_MSRS:w:SUPP
  | WRMSR
  deriving Repr, BEq, Inhabited

def Forms.WRMSR.xedForm : Forms.WRMSR → XedForm
  | .WRMSR => .WRMSR

def Forms.WRMSR.encodingFits : Forms.WRMSR → Bool
  | .WRMSR  => true

end X86.Syntax
