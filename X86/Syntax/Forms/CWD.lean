-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CWD-CDQ-CQO.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CWD where
  -- CDQ: REG0=XED_REG_EDX:w:SUPP REG1=XED_REG_EAX:r:SUPP
  | CDQ
  -- CQO: REG0=XED_REG_RDX:w:SUPP REG1=XED_REG_RAX:r:SUPP
  | CQO
  -- CWD: REG0=XED_REG_DX:w:SUPP REG1=XED_REG_AX:r:SUPP
  | CWD
  deriving Repr, BEq, Inhabited

def Forms.CWD.xedForm : Forms.CWD → XedForm
  | .CDQ => .CDQ
  | .CQO => .CQO
  | .CWD => .CWD

def Forms.CWD.encodingFits : Forms.CWD → Bool
  | .CDQ  => true
  | .CQO  => true
  | .CWD  => true

end X86.Syntax
