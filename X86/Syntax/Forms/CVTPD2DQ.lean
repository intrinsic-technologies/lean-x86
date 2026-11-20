-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTPD2DQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTPD2DQ where
  -- CVTPD2DQ_XMMdq_MEMpd: REG0=XMM_R():w:dq:i32 MEM0:r:pd:f64
  | CVTPD2DQ_XMMdq_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTPD2DQ_XMMdq_XMMpd: REG0=XMM_R():w:dq:i32 REG1=XMM_B():r:pd:f64
  | CVTPD2DQ_XMMdq_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTPD2DQ.xedForm : Forms.CVTPD2DQ → XedForm
  | .CVTPD2DQ_XMMdq_MEMpd _ _ => .CVTPD2DQ_XMMdq_MEMpd
  | .CVTPD2DQ_XMMdq_XMMpd _ _ => .CVTPD2DQ_XMMdq_XMMpd

def Forms.CVTPD2DQ.encodingFits : Forms.CVTPD2DQ → Bool
  | .CVTPD2DQ_XMMdq_MEMpd _ mem0 => mem0.encodingFits
  | .CVTPD2DQ_XMMdq_XMMpd _ _ => true

end X86.Syntax
