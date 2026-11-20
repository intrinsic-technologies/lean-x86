-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVSS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVSS where
  -- MOVSS_MEMss_XMMss: MEM0:w:ss REG0=XMM_R():r:ss
  | MOVSS_MEMss_XMMss (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVSS_XMMdq_MEMss: REG0=XMM_R():w:dq:f32 MEM0:r:ss
  | MOVSS_XMMdq_MEMss (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MOVSS_XMMss_XMMss_0F10: REG0=XMM_R():w:ss REG1=XMM_B():r:ss
  | MOVSS_XMMss_XMMss_0F10 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- MOVSS_XMMss_XMMss_0F11: REG0=XMM_B():w:ss REG1=XMM_R():r:ss
  | MOVSS_XMMss_XMMss_0F11 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVSS.xedForm : Forms.MOVSS → XedForm
  | .MOVSS_MEMss_XMMss _ _ => .MOVSS_MEMss_XMMss
  | .MOVSS_XMMdq_MEMss _ _ => .MOVSS_XMMdq_MEMss
  | .MOVSS_XMMss_XMMss_0F10 _ _ => .MOVSS_XMMss_XMMss_0F10
  | .MOVSS_XMMss_XMMss_0F11 _ _ => .MOVSS_XMMss_XMMss_0F11

def Forms.MOVSS.encodingFits : Forms.MOVSS → Bool
  | .MOVSS_MEMss_XMMss mem0 _ => mem0.encodingFits
  | .MOVSS_XMMdq_MEMss _ mem0 => mem0.encodingFits
  | .MOVSS_XMMss_XMMss_0F10 _ _ => true
  | .MOVSS_XMMss_XMMss_0F11 _ _ => true

end X86.Syntax
