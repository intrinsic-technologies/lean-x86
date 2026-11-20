-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FUCOM-FUCOMP-FUCOMPP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FUCOM where
  -- FUCOMPP: REG0=XED_REG_ST0:r:SUPP:f80  REG1=XED_REG_ST1:r:SUPP:f80 REG2=XED_REG_X87POP2:rw:SUPP REG3=XED_REG_X87STATUS:rw:SUPP
  | FUCOMPP
  -- FUCOMP_ST0_X87: REG0=XED_REG_ST0:r:IMPL:f80 REG1=X87():r:f80  REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:rw:SUPP
  | FUCOMP_ST0_X87 (reg1 : Registers.X87)
  -- FUCOM_ST0_X87: REG0=XED_REG_ST0:r:IMPL:f80 REG1=X87():r:f80  REG2=XED_REG_X87STATUS:w:SUPP
  | FUCOM_ST0_X87 (reg1 : Registers.X87)
  deriving Repr, BEq, Inhabited

def Forms.FUCOM.xedForm : Forms.FUCOM → XedForm
  | .FUCOMPP => .FUCOMPP
  | .FUCOMP_ST0_X87 _ => .FUCOMP_ST0_X87
  | .FUCOM_ST0_X87 _ => .FUCOM_ST0_X87

def Forms.FUCOM.encodingFits : Forms.FUCOM → Bool
  | .FUCOMPP  => true
  | .FUCOMP_ST0_X87 _ => true
  | .FUCOM_ST0_X87 _ => true

end X86.Syntax
