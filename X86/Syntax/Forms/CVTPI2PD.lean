-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTPI2PD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTPI2PD where
  -- CVTPI2PD_XMMpd_MEMq: REG0=XMM_R():w:pd:f64 MEM0:r:q:i32
  | CVTPI2PD_XMMpd_MEMq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- CVTPI2PD_XMMpd_MMXq: REG0=XMM_R():w:pd:f64 REG1=MMX_B():r:q:i32
  | CVTPI2PD_XMMpd_MMXq (reg0 : Registers.XMM) (reg1 : Registers.MMX)
  deriving Repr, BEq, Inhabited

def Forms.CVTPI2PD.xedForm : Forms.CVTPI2PD → XedForm
  | .CVTPI2PD_XMMpd_MEMq _ _ => .CVTPI2PD_XMMpd_MEMq
  | .CVTPI2PD_XMMpd_MMXq _ _ => .CVTPI2PD_XMMpd_MMXq

def Forms.CVTPI2PD.encodingFits : Forms.CVTPI2PD → Bool
  | .CVTPI2PD_XMMpd_MEMq _ mem0 => mem0.encodingFits
  | .CVTPI2PD_XMMpd_MMXq _ _ => true

end X86.Syntax
