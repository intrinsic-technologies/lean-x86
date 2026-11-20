-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVHLPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVHLPS where
  -- MOVHLPS_XMMq_XMMq: REG0=XMM_R():rw:q:f32 REG1=XMM_B():r:q:f32
  | MOVHLPS_XMMq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVHLPS.xedForm : Forms.MOVHLPS → XedForm
  | .MOVHLPS_XMMq_XMMq _ _ => .MOVHLPS_XMMq_XMMq

def Forms.MOVHLPS.encodingFits : Forms.MOVHLPS → Bool
  | .MOVHLPS_XMMq_XMMq _ _ => true

end X86.Syntax
