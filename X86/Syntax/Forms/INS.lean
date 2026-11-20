-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/INS-INSB-INSW-INSD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.INS where
  -- INSB: MEM0:w:SUPP:b BASE0=ArDI():rw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_DX:r:SUPP
  | INSB
  -- INSD: MEM0:w:SUPP:d BASE0=ArDI():rw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_DX:r:SUPP
  | INSD
  -- INSW: MEM0:w:SUPP:w BASE0=ArDI():rw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_DX:r:SUPP
  | INSW
  -- REP_INSB: MEM0:cw:SUPP:b BASE0=ArDI():rcw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_DX:r:SUPP REG1=ArCX():rcw:SUPP
  | REP_INSB
  -- REP_INSD: MEM0:cw:SUPP:d BASE0=ArDI():rcw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_DX:r:SUPP REG1=ArCX():rcw:SUPP
  | REP_INSD
  -- REP_INSW: MEM0:cw:SUPP:w BASE0=ArDI():rcw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_DX:r:SUPP REG1=ArCX():rcw:SUPP
  | REP_INSW
  deriving Repr, BEq, Inhabited

def Forms.INS.xedForm : Forms.INS → XedForm
  | .INSB => .INSB
  | .INSD => .INSD
  | .INSW => .INSW
  | .REP_INSB => .REP_INSB
  | .REP_INSD => .REP_INSD
  | .REP_INSW => .REP_INSW

def Forms.INS.encodingFits : Forms.INS → Bool
  | .INSB  => true
  | .INSD  => true
  | .INSW  => true
  | .REP_INSB  => true
  | .REP_INSD  => true
  | .REP_INSW  => true

end X86.Syntax
