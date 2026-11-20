-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVLPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVLPD where
  -- MOVLPD_MEMq_XMMsd: MEM0:w:q REG0=XMM_R():r:sd
  | MOVLPD_MEMq_XMMsd (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVLPD_XMMsd_MEMq: REG0=XMM_R():rw:sd MEM0:r:q
  | MOVLPD_XMMsd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.MOVLPD.xedForm : Forms.MOVLPD → XedForm
  | .MOVLPD_MEMq_XMMsd _ _ => .MOVLPD_MEMq_XMMsd
  | .MOVLPD_XMMsd_MEMq _ _ => .MOVLPD_XMMsd_MEMq

def Forms.MOVLPD.encodingFits : Forms.MOVLPD → Bool
  | .MOVLPD_MEMq_XMMsd mem0 _ => mem0.encodingFits
  | .MOVLPD_XMMsd_MEMq _ mem0 => mem0.encodingFits

end X86.Syntax
