-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVHPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVHPD where
  -- MOVHPD_MEMq_XMMsd: MEM0:w:q REG0=XMM_R():r:sd
  | MOVHPD_MEMq_XMMsd (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVHPD_XMMsd_MEMq: REG0=XMM_R():rw:sd MEM0:r:q
  | MOVHPD_XMMsd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.MOVHPD.xedForm : Forms.MOVHPD → XedForm
  | .MOVHPD_MEMq_XMMsd _ _ => .MOVHPD_MEMq_XMMsd
  | .MOVHPD_XMMsd_MEMq _ _ => .MOVHPD_XMMsd_MEMq

def Forms.MOVHPD.encodingFits : Forms.MOVHPD → Bool
  | .MOVHPD_MEMq_XMMsd mem0 _ => mem0.encodingFits
  | .MOVHPD_XMMsd_MEMq _ mem0 => mem0.encodingFits

end X86.Syntax
