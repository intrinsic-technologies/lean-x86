-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTTPD2PI.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTTPD2PI where
  -- CVTTPD2PI_MMXq_MEMpd: REG0=MMX_R():w:q:i32 MEM0:r:pd:f64
  | CVTTPD2PI_MMXq_MEMpd (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- CVTTPD2PI_MMXq_XMMpd: REG0=MMX_R():w:q:i32 REG1=XMM_B():r:pd:f64
  | CVTTPD2PI_MMXq_XMMpd (reg0 : Registers.MMX) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTTPD2PI.xedForm : Forms.CVTTPD2PI → XedForm
  | .CVTTPD2PI_MMXq_MEMpd _ _ => .CVTTPD2PI_MMXq_MEMpd
  | .CVTTPD2PI_MMXq_XMMpd _ _ => .CVTTPD2PI_MMXq_XMMpd

def Forms.CVTTPD2PI.encodingFits : Forms.CVTTPD2PI → Bool
  | .CVTTPD2PI_MMXq_MEMpd _ mem0 => mem0.encodingFits
  | .CVTTPD2PI_MMXq_XMMpd _ _ => true

end X86.Syntax
