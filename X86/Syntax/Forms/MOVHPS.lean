-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVHPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVHPS where
  -- MOVHPS_MEMq_XMMps: MEM0:w:q:f32 REG0=XMM_R():r:ps:f32
  | MOVHPS_MEMq_XMMps (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVHPS_XMMq_MEMq: REG0=XMM_R():rw:q:f32 MEM0:r:q:f32
  | MOVHPS_XMMq_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.MOVHPS.xedForm : Forms.MOVHPS → XedForm
  | .MOVHPS_MEMq_XMMps _ _ => .MOVHPS_MEMq_XMMps
  | .MOVHPS_XMMq_MEMq _ _ => .MOVHPS_XMMq_MEMq

def Forms.MOVHPS.encodingFits : Forms.MOVHPS → Bool
  | .MOVHPS_MEMq_XMMps mem0 _ => mem0.encodingFits
  | .MOVHPS_XMMq_MEMq _ mem0 => mem0.encodingFits

end X86.Syntax
