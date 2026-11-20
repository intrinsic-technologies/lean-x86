-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/OUTS-OUTSB-OUTSW-OUTSD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.OUTS where
  -- OUTSB: REG0=XED_REG_DX:r:SUPP MEM0:r:SUPP:b BASE0=ArSI():rw:SUPP SEG0=FINAL_DSEG():r:SUPP
  | OUTSB
  -- OUTSD: REG0=XED_REG_DX:r:SUPP MEM0:r:SUPP:d BASE0=ArSI():rw:SUPP SEG0=FINAL_DSEG():r:SUPP
  | OUTSD
  -- OUTSW: REG0=XED_REG_DX:r:SUPP MEM0:r:SUPP:w BASE0=ArSI():rw:SUPP SEG0=FINAL_DSEG():r:SUPP
  | OUTSW
  -- REP_OUTSB: REG0=XED_REG_DX:r:SUPP MEM0:cr:SUPP:b BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP REG1=ArCX():rcw:SUPP
  | REP_OUTSB
  -- REP_OUTSD: REG0=XED_REG_DX:r:SUPP MEM0:cr:SUPP:d BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP REG1=ArCX():rcw:SUPP
  | REP_OUTSD
  -- REP_OUTSW: REG0=XED_REG_DX:r:SUPP MEM0:cr:SUPP:w BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP REG1=ArCX():rcw:SUPP
  | REP_OUTSW
  deriving Repr, BEq, Inhabited

def Forms.OUTS.xedForm : Forms.OUTS → XedForm
  | .OUTSB => .OUTSB
  | .OUTSD => .OUTSD
  | .OUTSW => .OUTSW
  | .REP_OUTSB => .REP_OUTSB
  | .REP_OUTSD => .REP_OUTSD
  | .REP_OUTSW => .REP_OUTSW

def Forms.OUTS.encodingFits : Forms.OUTS → Bool
  | .OUTSB  => true
  | .OUTSD  => true
  | .OUTSW  => true
  | .REP_OUTSB  => true
  | .REP_OUTSD  => true
  | .REP_OUTSW  => true

end X86.Syntax
