-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVLHPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVLHPS where
  -- MOVLHPS_XMMq_XMMq: REG0=XMM_R():rw:q:f32 REG1=XMM_B():r:q:f32
  | MOVLHPS_XMMq_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVLHPS.xedForm : Forms.MOVLHPS → XedForm
  | .MOVLHPS_XMMq_XMMq _ _ => .MOVLHPS_XMMq_XMMq

def Forms.MOVLHPS.encodingFits : Forms.MOVLHPS → Bool
  | .MOVLHPS_XMMq_XMMq _ _ => true

end X86.Syntax
