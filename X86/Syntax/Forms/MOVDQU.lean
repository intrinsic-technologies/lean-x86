-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVDQU-VMOVDQU8-16-32-64.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVDQU where
  -- MOVDQU_MEMdq_XMMdq: MEM0:w:dq REG0=XMM_R():r:dq
  | MOVDQU_MEMdq_XMMdq (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVDQU_XMMdq_MEMdq: REG0=XMM_R():w:dq MEM0:r:dq
  | MOVDQU_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MOVDQU_XMMdq_XMMdq_0F6F: REG0=XMM_R():w:dq REG1=XMM_B():r:dq
  | MOVDQU_XMMdq_XMMdq_0F6F (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- MOVDQU_XMMdq_XMMdq_0F7F: REG0=XMM_B():w:dq REG1=XMM_R():r:dq
  | MOVDQU_XMMdq_XMMdq_0F7F (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVDQU.xedForm : Forms.MOVDQU → XedForm
  | .MOVDQU_MEMdq_XMMdq _ _ => .MOVDQU_MEMdq_XMMdq
  | .MOVDQU_XMMdq_MEMdq _ _ => .MOVDQU_XMMdq_MEMdq
  | .MOVDQU_XMMdq_XMMdq_0F6F _ _ => .MOVDQU_XMMdq_XMMdq_0F6F
  | .MOVDQU_XMMdq_XMMdq_0F7F _ _ => .MOVDQU_XMMdq_XMMdq_0F7F

def Forms.MOVDQU.encodingFits : Forms.MOVDQU → Bool
  | .MOVDQU_MEMdq_XMMdq mem0 _ => mem0.encodingFits
  | .MOVDQU_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .MOVDQU_XMMdq_XMMdq_0F6F _ _ => true
  | .MOVDQU_XMMdq_XMMdq_0F7F _ _ => true

end X86.Syntax
