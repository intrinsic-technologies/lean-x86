-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTPD2PS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTPD2PS where
  -- CVTPD2PS_XMMps_MEMpd: REG0=XMM_R():w:ps:f32 MEM0:r:pd:f64
  | CVTPD2PS_XMMps_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTPD2PS_XMMps_XMMpd: REG0=XMM_R():w:ps:f32 REG1=XMM_B():r:pd:f64
  | CVTPD2PS_XMMps_XMMpd (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTPD2PS.xedForm : Forms.CVTPD2PS → XedForm
  | .CVTPD2PS_XMMps_MEMpd _ _ => .CVTPD2PS_XMMps_MEMpd
  | .CVTPD2PS_XMMps_XMMpd _ _ => .CVTPD2PS_XMMps_XMMpd

def Forms.CVTPD2PS.encodingFits : Forms.CVTPD2PS → Bool
  | .CVTPD2PS_XMMps_MEMpd _ mem0 => mem0.encodingFits
  | .CVTPD2PS_XMMps_XMMpd _ _ => true

end X86.Syntax
