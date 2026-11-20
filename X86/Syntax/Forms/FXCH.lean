-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FXCH.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FXCH where
  -- FXCH_ST0_X87: REG0=XED_REG_ST0:rw:IMPL:f80 REG1=X87():rw:f80   REG2=XED_REG_X87STATUS:w:SUPP
  | FXCH_ST0_X87 (reg1 : Registers.X87)
  -- FXCH_ST0_X87_DDC1: REG0=XED_REG_ST0:rw:IMPL:f80 REG1=X87():rw:f80   REG2=XED_REG_X87STATUS:w:SUPP
  | FXCH_ST0_X87_DDC1 (reg1 : Registers.X87)
  -- FXCH_ST0_X87_DFC1: REG0=XED_REG_ST0:rw:IMPL:f80 REG1=X87():rw:f80   REG2=XED_REG_X87STATUS:w:SUPP
  | FXCH_ST0_X87_DFC1 (reg1 : Registers.X87)
  deriving Repr, BEq, Inhabited

def Forms.FXCH.xedForm : Forms.FXCH → XedForm
  | .FXCH_ST0_X87 _ => .FXCH_ST0_X87
  | .FXCH_ST0_X87_DDC1 _ => .FXCH_ST0_X87_DDC1
  | .FXCH_ST0_X87_DFC1 _ => .FXCH_ST0_X87_DFC1

def Forms.FXCH.encodingFits : Forms.FXCH → Bool
  | .FXCH_ST0_X87 _ => true
  | .FXCH_ST0_X87_DDC1 _ => true
  | .FXCH_ST0_X87_DFC1 _ => true

end X86.Syntax
