-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVDQA-VMOVDQA32-64.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVDQA where
  -- MOVDQA_MEMdq_XMMdq: MEM0:w:dq REG0=XMM_R():r:dq
  | MOVDQA_MEMdq_XMMdq (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVDQA_XMMdq_MEMdq: REG0=XMM_R():w:dq MEM0:r:dq
  | MOVDQA_XMMdq_MEMdq (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  -- MOVDQA_XMMdq_XMMdq_0F6F: REG0=XMM_R():w:dq REG1=XMM_B():r:dq
  | MOVDQA_XMMdq_XMMdq_0F6F (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  -- MOVDQA_XMMdq_XMMdq_0F7F: REG0=XMM_B():w:dq REG1=XMM_R():r:dq
  | MOVDQA_XMMdq_XMMdq_0F7F (reg0 : Registers.XMM) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.MOVDQA.xedForm : Forms.MOVDQA → XedForm
  | .MOVDQA_MEMdq_XMMdq _ _ => .MOVDQA_MEMdq_XMMdq
  | .MOVDQA_XMMdq_MEMdq _ _ => .MOVDQA_XMMdq_MEMdq
  | .MOVDQA_XMMdq_XMMdq_0F6F _ _ => .MOVDQA_XMMdq_XMMdq_0F6F
  | .MOVDQA_XMMdq_XMMdq_0F7F _ _ => .MOVDQA_XMMdq_XMMdq_0F7F

def Forms.MOVDQA.encodingFits : Forms.MOVDQA → Bool
  | .MOVDQA_MEMdq_XMMdq mem0 _ => mem0.encodingFits
  | .MOVDQA_XMMdq_MEMdq _ mem0 => mem0.encodingFits
  | .MOVDQA_XMMdq_XMMdq_0F6F _ _ => true
  | .MOVDQA_XMMdq_XMMdq_0F7F _ _ => true

end X86.Syntax
