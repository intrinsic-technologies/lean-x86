-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVLPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVLPS where
  -- MOVLPS_MEMq_XMMq: MEM0:w:q:f32 REG0=XMM_R():r:q:f32
  | MOVLPS_MEMq_XMMq (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVLPS_XMMq_MEMq: REG0=XMM_R():rw:q:f32 MEM0:r:q:f32
  | MOVLPS_XMMq_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.MOVLPS.xedForm : Forms.MOVLPS → XedForm
  | .MOVLPS_MEMq_XMMq _ _ => .MOVLPS_MEMq_XMMq
  | .MOVLPS_XMMq_MEMq _ _ => .MOVLPS_XMMq_MEMq

def Forms.MOVLPS.encodingFits : Forms.MOVLPS → Bool
  | .MOVLPS_MEMq_XMMq mem0 _ => mem0.encodingFits
  | .MOVLPS_XMMq_MEMq _ mem0 => mem0.encodingFits

end X86.Syntax
