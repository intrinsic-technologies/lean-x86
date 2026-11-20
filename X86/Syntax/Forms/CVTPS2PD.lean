-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTPS2PD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTPS2PD where
  -- CVTPS2PD_XMMpd_MEMq: REG0=XMM_R():w:pd:f64 MEM0:r:q:f32
  | CVTPS2PD_XMMpd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTPS2PD_XMMpd_XMMq: REG0=XMM_R():w:pd:f64 REG1=XMM_B():r:q:f32
  | CVTPS2PD_XMMpd_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTPS2PD.xedForm : Forms.CVTPS2PD → XedForm
  | .CVTPS2PD_XMMpd_MEMq _ _ => .CVTPS2PD_XMMpd_MEMq
  | .CVTPS2PD_XMMpd_XMMq _ _ => .CVTPS2PD_XMMpd_XMMq

def Forms.CVTPS2PD.encodingFits : Forms.CVTPS2PD → Bool
  | .CVTPS2PD_XMMpd_MEMq _ mem0 => mem0.encodingFits
  | .CVTPS2PD_XMMpd_XMMq _ _ => true

end X86.Syntax
