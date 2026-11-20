-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/STOS-STOSB-STOSW-STOSD-STOSQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.STOS where
  -- REP_STOSB: MEM0:cw:SUPP:b BASE0=ArDI():rcw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_AL:r:SUPP REG1=ArCX():rcw:SUPP
  | REP_STOSB
  -- REP_STOSD: MEM0:cw:SUPP:d BASE0=ArDI():rcw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_EAX:r:SUPP REG1=ArCX():rcw:SUPP
  | REP_STOSD
  -- REP_STOSQ: MEM0:cw:SUPP:q BASE0=ArDI():rcw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_RAX:r:SUPP REG1=ArCX():rcw:SUPP
  | REP_STOSQ
  -- REP_STOSW: MEM0:cw:SUPP:w BASE0=ArDI():rcw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_AX:r:SUPP REG1=ArCX():rcw:SUPP
  | REP_STOSW
  -- STOSB: MEM0:w:SUPP:b BASE0=ArDI():rw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_AL:r:SUPP
  | STOSB
  -- STOSD: MEM0:w:SUPP:d BASE0=ArDI():rw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_EAX:r:SUPP
  | STOSD
  -- STOSQ: MEM0:w:SUPP:q BASE0=ArDI():rw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_RAX:r:SUPP
  | STOSQ
  -- STOSW: MEM0:w:SUPP:w BASE0=ArDI():rw:SUPP SEG0=FINAL_ESEG():r:SUPP REG0=XED_REG_AX:r:SUPP
  | STOSW
  deriving Repr, BEq, Inhabited

def Forms.STOS.xedForm : Forms.STOS → XedForm
  | .REP_STOSB => .REP_STOSB
  | .REP_STOSD => .REP_STOSD
  | .REP_STOSQ => .REP_STOSQ
  | .REP_STOSW => .REP_STOSW
  | .STOSB => .STOSB
  | .STOSD => .STOSD
  | .STOSQ => .STOSQ
  | .STOSW => .STOSW

def Forms.STOS.encodingFits : Forms.STOS → Bool
  | .REP_STOSB  => true
  | .REP_STOSD  => true
  | .REP_STOSQ  => true
  | .REP_STOSW  => true
  | .STOSB  => true
  | .STOSD  => true
  | .STOSQ  => true
  | .STOSW  => true

end X86.Syntax
