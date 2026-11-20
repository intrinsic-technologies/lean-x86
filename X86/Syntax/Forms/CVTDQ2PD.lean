-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTDQ2PD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTDQ2PD where
  -- CVTDQ2PD_XMMpd_MEMq: REG0=XMM_R():w:pd:f64 MEM0:r:q:i32
  | CVTDQ2PD_XMMpd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTDQ2PD_XMMpd_XMMq: REG0=XMM_R():w:pd:f64 REG1=XMM_B():r:q:i32
  | CVTDQ2PD_XMMpd_XMMq (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTDQ2PD.xedForm : Forms.CVTDQ2PD → XedForm
  | .CVTDQ2PD_XMMpd_MEMq _ _ => .CVTDQ2PD_XMMpd_MEMq
  | .CVTDQ2PD_XMMpd_XMMq _ _ => .CVTDQ2PD_XMMpd_XMMq

def Forms.CVTDQ2PD.encodingFits : Forms.CVTDQ2PD → Bool
  | .CVTDQ2PD_XMMpd_MEMq _ mem0 => mem0.encodingFits
  | .CVTDQ2PD_XMMpd_XMMq _ _ => true

end X86.Syntax
