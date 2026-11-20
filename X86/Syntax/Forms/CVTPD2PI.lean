-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTPD2PI.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTPD2PI where
  -- CVTPD2PI_MMXq_MEMpd: REG0=MMX_R():w:q:i32 MEM0:r:pd:f64
  | CVTPD2PI_MMXq_MEMpd (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- CVTPD2PI_MMXq_XMMpd: REG0=MMX_R():w:q:i32 REG1=XMM_B():r:pd:f64
  | CVTPD2PI_MMXq_XMMpd (reg0 : Registers.MMX) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTPD2PI.xedForm : Forms.CVTPD2PI → XedForm
  | .CVTPD2PI_MMXq_MEMpd _ _ => .CVTPD2PI_MMXq_MEMpd
  | .CVTPD2PI_MMXq_XMMpd _ _ => .CVTPD2PI_MMXq_XMMpd

def Forms.CVTPD2PI.encodingFits : Forms.CVTPD2PI → Bool
  | .CVTPD2PI_MMXq_MEMpd _ mem0 => mem0.encodingFits
  | .CVTPD2PI_MMXq_XMMpd _ _ => true

end X86.Syntax
