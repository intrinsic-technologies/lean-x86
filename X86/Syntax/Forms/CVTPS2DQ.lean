-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTPS2DQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTPS2DQ where
  -- CVTPS2DQ_XMMdq_MEMps: REG0=XMM_R():w:dq:i32 MEM0:r:ps:f32
  | CVTPS2DQ_XMMdq_MEMps (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTPS2DQ_XMMdq_XMMps: REG0=XMM_R():w:dq:i32 REG1=XMM_B():r:ps:f32
  | CVTPS2DQ_XMMdq_XMMps (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTPS2DQ.xedForm : Forms.CVTPS2DQ → XedForm
  | .CVTPS2DQ_XMMdq_MEMps _ _ => .CVTPS2DQ_XMMdq_MEMps
  | .CVTPS2DQ_XMMdq_XMMps _ _ => .CVTPS2DQ_XMMdq_XMMps

def Forms.CVTPS2DQ.encodingFits : Forms.CVTPS2DQ → Bool
  | .CVTPS2DQ_XMMdq_MEMps _ mem0 => mem0.encodingFits
  | .CVTPS2DQ_XMMdq_XMMps _ _ => true

end X86.Syntax
