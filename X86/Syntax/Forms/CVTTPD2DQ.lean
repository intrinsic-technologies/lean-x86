-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTTPD2DQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTTPD2DQ where
  -- CVTTPD2DQ_XMMdq_MEMpd: REG0=XMM_R():w:dq:i32 MEM0:r:pd:f64
  | CVTTPD2DQ_XMMdq_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTTPD2DQ_XMMdq_XMMpd: REG0=XMM_R():w:dq:i32 REG1=XMM_B():r:pd:f64
  | CVTTPD2DQ_XMMdq_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTTPD2DQ.xedForm : Forms.CVTTPD2DQ → XedForm
  | .CVTTPD2DQ_XMMdq_MEMpd _ _ => .CVTTPD2DQ_XMMdq_MEMpd
  | .CVTTPD2DQ_XMMdq_XMMpd _ _ => .CVTTPD2DQ_XMMdq_XMMpd

def Forms.CVTTPD2DQ.encodingFits : Forms.CVTTPD2DQ → Bool
  | .CVTTPD2DQ_XMMdq_MEMpd _ mem0 => mem0.encodingFits
  | .CVTTPD2DQ_XMMdq_XMMpd _ _ => true

end X86.Syntax
