-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVUPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVUPD where
  -- MOVUPD_MEMpd_XMMpd: MEM0:w:pd REG0=XMM_R():r:pd
  | MOVUPD_MEMpd_XMMpd (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVUPD_XMMpd_MEMpd: REG0=XMM_R():w:pd MEM0:r:pd
  | MOVUPD_XMMpd_MEMpd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MOVUPD_XMMpd_XMMpd_0F10: REG0=XMM_R():w:pd REG1=XMM_B():r:pd
  | MOVUPD_XMMpd_XMMpd_0F10 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- MOVUPD_XMMpd_XMMpd_0F11: REG0=XMM_B():w:pd REG1=XMM_R():r:pd
  | MOVUPD_XMMpd_XMMpd_0F11 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVUPD.xedForm : Forms.MOVUPD → XedForm
  | .MOVUPD_MEMpd_XMMpd _ _ => .MOVUPD_MEMpd_XMMpd
  | .MOVUPD_XMMpd_MEMpd _ _ => .MOVUPD_XMMpd_MEMpd
  | .MOVUPD_XMMpd_XMMpd_0F10 _ _ => .MOVUPD_XMMpd_XMMpd_0F10
  | .MOVUPD_XMMpd_XMMpd_0F11 _ _ => .MOVUPD_XMMpd_XMMpd_0F11

def Forms.MOVUPD.encodingFits : Forms.MOVUPD → Bool
  | .MOVUPD_MEMpd_XMMpd mem0 _ => mem0.encodingFits
  | .MOVUPD_XMMpd_MEMpd _ mem0 => mem0.encodingFits
  | .MOVUPD_XMMpd_XMMpd_0F10 _ _ => true
  | .MOVUPD_XMMpd_XMMpd_0F11 _ _ => true

end X86.Syntax
