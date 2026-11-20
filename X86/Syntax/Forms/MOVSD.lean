-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVSD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVSD where
  -- MOVSD_XMM_MEMsd_XMMsd: MEM0:w:sd REG0=XMM_R():r:sd
  | MOVSD_XMM_MEMsd_XMMsd (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVSD_XMM_XMMdq_MEMsd: REG0=XMM_R():w:dq:f64 MEM0:r:sd
  | MOVSD_XMM_XMMdq_MEMsd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MOVSD_XMM_XMMsd_XMMsd_0F10: REG0=XMM_R():w:sd REG1=XMM_B():r:sd
  | MOVSD_XMM_XMMsd_XMMsd_0F10 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- MOVSD_XMM_XMMsd_XMMsd_0F11: REG0=XMM_B():w:sd REG1=XMM_R():r:sd
  | MOVSD_XMM_XMMsd_XMMsd_0F11 (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVSD.xedForm : Forms.MOVSD → XedForm
  | .MOVSD_XMM_MEMsd_XMMsd _ _ => .MOVSD_XMM_MEMsd_XMMsd
  | .MOVSD_XMM_XMMdq_MEMsd _ _ => .MOVSD_XMM_XMMdq_MEMsd
  | .MOVSD_XMM_XMMsd_XMMsd_0F10 _ _ => .MOVSD_XMM_XMMsd_XMMsd_0F10
  | .MOVSD_XMM_XMMsd_XMMsd_0F11 _ _ => .MOVSD_XMM_XMMsd_XMMsd_0F11

def Forms.MOVSD.encodingFits : Forms.MOVSD → Bool
  | .MOVSD_XMM_MEMsd_XMMsd mem0 _ => mem0.encodingFits
  | .MOVSD_XMM_XMMdq_MEMsd _ mem0 => mem0.encodingFits
  | .MOVSD_XMM_XMMsd_XMMsd_0F10 _ _ => true
  | .MOVSD_XMM_XMMsd_XMMsd_0F11 _ _ => true

end X86.Syntax
