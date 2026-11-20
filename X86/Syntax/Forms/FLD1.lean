-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FLD1-FLDL2T-FLDL2E-FLDPI-FLDLG2-FLDLN2-FLDZ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FLD1 where
  -- FLD1: REG0=XED_REG_ST0:w:SUPP:f80 REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FLD1
  -- FLDL2E: REG0=XED_REG_ST0:w:SUPP:f80 REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FLDL2E
  -- FLDL2T: REG0=XED_REG_ST0:w:SUPP:f80 REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FLDL2T
  -- FLDLG2: REG0=XED_REG_ST0:w:SUPP:f80 REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FLDLG2
  -- FLDLN2: REG0=XED_REG_ST0:w:SUPP:f80 REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FLDLN2
  -- FLDPI: REG0=XED_REG_ST0:w:SUPP:f80 REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FLDPI
  -- FLDZ: REG0=XED_REG_ST0:w:SUPP:f80 REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FLDZ
  deriving Repr, BEq, Inhabited

def Forms.FLD1.xedForm : Forms.FLD1 → XedForm
  | .FLD1 => .FLD1
  | .FLDL2E => .FLDL2E
  | .FLDL2T => .FLDL2T
  | .FLDLG2 => .FLDLG2
  | .FLDLN2 => .FLDLN2
  | .FLDPI => .FLDPI
  | .FLDZ => .FLDZ

def Forms.FLD1.encodingFits : Forms.FLD1 → Bool
  | .FLD1  => true
  | .FLDL2E  => true
  | .FLDL2T  => true
  | .FLDLG2  => true
  | .FLDLN2  => true
  | .FLDPI  => true
  | .FLDZ  => true

end X86.Syntax
