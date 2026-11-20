-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTTPS2DQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTTPS2DQ where
  -- CVTTPS2DQ_XMMdq_MEMps: REG0=XMM_R():w:dq:i32 MEM0:r:ps:f32
  | CVTTPS2DQ_XMMdq_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTTPS2DQ_XMMdq_XMMps: REG0=XMM_R():w:dq:i32 REG1=XMM_B():r:ps:f32
  | CVTTPS2DQ_XMMdq_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTTPS2DQ.xedForm : Forms.CVTTPS2DQ → XedForm
  | .CVTTPS2DQ_XMMdq_MEMps _ _ => .CVTTPS2DQ_XMMdq_MEMps
  | .CVTTPS2DQ_XMMdq_XMMps _ _ => .CVTTPS2DQ_XMMdq_XMMps

def Forms.CVTTPS2DQ.encodingFits : Forms.CVTTPS2DQ → Bool
  | .CVTTPS2DQ_XMMdq_MEMps _ mem0 => mem0.encodingFits
  | .CVTTPS2DQ_XMMdq_XMMps _ _ => true

end X86.Syntax
