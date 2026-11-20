-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/LODS-LODSB-LODSW-LODSD-LODSQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.LODS where
  -- LODSB: REG0=XED_REG_AL:w:SUPP MEM0:r:SUPP:b BASE0=ArSI():rw:SUPP SEG0=FINAL_DSEG():r:SUPP
  | LODSB
  -- LODSD: REG0=XED_REG_EAX:w:SUPP MEM0:r:SUPP:d BASE0=ArSI():rw:SUPP SEG0=FINAL_DSEG():r:SUPP
  | LODSD
  -- LODSQ: REG0=XED_REG_RAX:w:SUPP MEM0:r:SUPP:q BASE0=ArSI():rw:SUPP SEG0=FINAL_DSEG():r:SUPP
  | LODSQ
  -- LODSW: REG0=XED_REG_AX:w:SUPP MEM0:r:SUPP:w BASE0=ArSI():rw:SUPP SEG0=FINAL_DSEG():r:SUPP
  | LODSW
  -- REP_LODSB: REG0=XED_REG_AL:cw:SUPP MEM0:cr:SUPP:b BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP REG1=ArCX():rcw:SUPP
  | REP_LODSB
  -- REP_LODSD: REG0=XED_REG_EAX:cw:SUPP MEM0:cr:SUPP:d BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP REG1=ArCX():rcw:SUPP
  | REP_LODSD
  -- REP_LODSQ: REG0=XED_REG_RAX:cw:SUPP MEM0:cr:SUPP:q BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP REG1=ArCX():rcw:SUPP
  | REP_LODSQ
  -- REP_LODSW: REG0=XED_REG_AX:cw:SUPP MEM0:cr:SUPP:w BASE0=ArSI():rcw:SUPP SEG0=FINAL_DSEG():r:SUPP REG1=ArCX():rcw:SUPP
  | REP_LODSW
  deriving Repr, BEq, Inhabited

def Forms.LODS.xedForm : Forms.LODS → XedForm
  | .LODSB => .LODSB
  | .LODSD => .LODSD
  | .LODSQ => .LODSQ
  | .LODSW => .LODSW
  | .REP_LODSB => .REP_LODSB
  | .REP_LODSD => .REP_LODSD
  | .REP_LODSQ => .REP_LODSQ
  | .REP_LODSW => .REP_LODSW

def Forms.LODS.encodingFits : Forms.LODS → Bool
  | .LODSB  => true
  | .LODSD  => true
  | .LODSQ  => true
  | .LODSW  => true
  | .REP_LODSB  => true
  | .REP_LODSD  => true
  | .REP_LODSQ  => true
  | .REP_LODSW  => true

end X86.Syntax
