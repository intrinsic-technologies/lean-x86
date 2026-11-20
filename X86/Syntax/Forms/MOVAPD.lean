-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVAPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVAPD where
  -- MOVAPD_MEMpd_XMMpd: MEM0:w:pd REG0=XMM_R():r:pd
  | MOVAPD_MEMpd_XMMpd (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVAPD_XMMpd_MEMpd: REG0=XMM_R():w:pd MEM0:r:pd
  | MOVAPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MOVAPD_XMMpd_XMMpd_0F28: REG0=XMM_R():w:pd REG1=XMM_B():r:pd
  | MOVAPD_XMMpd_XMMpd_0F28 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- MOVAPD_XMMpd_XMMpd_0F29: REG0=XMM_B():w:pd REG1=XMM_R():r:pd
  | MOVAPD_XMMpd_XMMpd_0F29 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVAPD.xedForm : Forms.MOVAPD → XedForm
  | .MOVAPD_MEMpd_XMMpd _ _ => .MOVAPD_MEMpd_XMMpd
  | .MOVAPD_XMMpd_MEMpd _ _ => .MOVAPD_XMMpd_MEMpd
  | .MOVAPD_XMMpd_XMMpd_0F28 _ _ => .MOVAPD_XMMpd_XMMpd_0F28
  | .MOVAPD_XMMpd_XMMpd_0F29 _ _ => .MOVAPD_XMMpd_XMMpd_0F29

def Forms.MOVAPD.encodingFits : Forms.MOVAPD → Bool
  | .MOVAPD_MEMpd_XMMpd mem0 _ => mem0.encodingFits
  | .MOVAPD_XMMpd_MEMpd _ mem0 => mem0.encodingFits
  | .MOVAPD_XMMpd_XMMpd_0F28 _ _ => true
  | .MOVAPD_XMMpd_XMMpd_0F29 _ _ => true

end X86.Syntax
