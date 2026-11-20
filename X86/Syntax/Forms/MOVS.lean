-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVS-MOVSB-MOVSW-MOVSD-MOVSQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVS where
  -- MOVSB: MEM0:w:SUPP:b BASE0=ArDI():rw:SUPP SEG0=FINAL_ESEG():r:SUPP  MEM1:r:SUPP:b BASE1=ArSI():rw:SUPP SEG1=FINAL_DSEG1():r:SUPP
  | MOVSB
  -- MOVSD: MEM0:w:SUPP:d BASE0=ArDI():rw:SUPP SEG0=FINAL_ESEG():r:SUPP MEM1:r:SUPP:d BASE1=ArSI():rw:SUPP SEG1=FINAL_DSEG1():r:SUPP
  | MOVSD
  -- MOVSQ: MEM0:w:SUPP:q BASE0=ArDI():rw:SUPP SEG0=FINAL_ESEG():r:SUPP MEM1:r:SUPP:q BASE1=ArSI():rw:SUPP SEG1=FINAL_DSEG1():r:SUPP
  | MOVSQ
  -- MOVSW: MEM0:w:SUPP:w BASE0=ArDI():rw:SUPP SEG0=FINAL_ESEG():r:SUPP MEM1:r:SUPP:w BASE1=ArSI():rw:SUPP SEG1=FINAL_DSEG1():r:SUPP
  | MOVSW
  -- REP_MOVSB: MEM0:cw:SUPP:b BASE0=ArDI():rcw:SUPP SEG0=FINAL_ESEG():r:SUPP  MEM1:cr:SUPP:b BASE1=ArSI():rcw:SUPP SEG1=FINAL_DSEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REP_MOVSB
  -- REP_MOVSD: MEM0:cw:SUPP:d BASE0=ArDI():rcw:SUPP SEG0=FINAL_ESEG():r:SUPP MEM1:cr:SUPP:d BASE1=ArSI():rcw:SUPP SEG1=FINAL_DSEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REP_MOVSD
  -- REP_MOVSQ: MEM0:cw:SUPP:q BASE0=ArDI():rcw:SUPP SEG0=FINAL_ESEG():r:SUPP MEM1:cr:SUPP:q BASE1=ArSI():rcw:SUPP SEG1=FINAL_DSEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REP_MOVSQ
  -- REP_MOVSW: MEM0:cw:SUPP:w BASE0=ArDI():rcw:SUPP SEG0=FINAL_ESEG():r:SUPP MEM1:cr:SUPP:w BASE1=ArSI():rcw:SUPP SEG1=FINAL_DSEG1():r:SUPP REG0=ArCX():rcw:SUPP
  | REP_MOVSW
  deriving Repr, BEq, Inhabited

def Forms.MOVS.xedForm : Forms.MOVS → XedForm
  | .MOVSB => .MOVSB
  | .MOVSD => .MOVSD
  | .MOVSQ => .MOVSQ
  | .MOVSW => .MOVSW
  | .REP_MOVSB => .REP_MOVSB
  | .REP_MOVSD => .REP_MOVSD
  | .REP_MOVSQ => .REP_MOVSQ
  | .REP_MOVSW => .REP_MOVSW

def Forms.MOVS.encodingFits : Forms.MOVS → Bool
  | .MOVSB  => true
  | .MOVSD  => true
  | .MOVSQ  => true
  | .MOVSW  => true
  | .REP_MOVSB  => true
  | .REP_MOVSD  => true
  | .REP_MOVSQ  => true
  | .REP_MOVSW  => true

end X86.Syntax
