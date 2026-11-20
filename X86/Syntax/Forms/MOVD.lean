-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVD-MOVQ.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVD where
  -- MOVD_GPR32_MMXd: REG0=GPR32_B():w REG1=MMX_R():r:d
  | MOVD_GPR32_MMXd (reg0 : Registers.GPR32) (reg1 : Registers.MMX)
  -- MOVD_GPR32_XMMd: REG0=GPR32_B():w REG1=XMM_R():r:d
  | MOVD_GPR32_XMMd (reg0 : Registers.GPR32) (reg1 : Registers.XMM)
  -- MOVD_MEMd_MMXd: MEM0:w:d REG0=MMX_R():r:d
  | MOVD_MEMd_MMXd (mem0 : MemoryOperand) (reg0 : Registers.MMX)
  -- MOVD_MEMd_XMMd: MEM0:w:d REG0=XMM_R():r:d
  | MOVD_MEMd_XMMd (mem0 : MemoryOperand) (reg0 : Registers.XMM)
  -- MOVD_MMXq_GPR32: REG0=MMX_R():w:q REG1=GPR32_B():r
  | MOVD_MMXq_GPR32 (reg0 : Registers.MMX) (reg1 : Registers.GPR32)
  -- MOVD_MMXq_MEMd: REG0=MMX_R():w:q MEM0:r:d
  | MOVD_MMXq_MEMd (reg0 : Registers.MMX) (mem0 : MemoryOperand)
  -- MOVD_XMMdq_GPR32: REG0=XMM_R():w:dq REG1=GPR32_B():r
  | MOVD_XMMdq_GPR32 (reg0 : Registers.XMM) (reg1 : Registers.GPR32)
  -- MOVD_XMMdq_MEMd: REG0=XMM_R():w:dq MEM0:r:d
  | MOVD_XMMdq_MEMd (reg0 : Registers.XMM) (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.MOVD.xedForm : Forms.MOVD → XedForm
  | .MOVD_GPR32_MMXd _ _ => .MOVD_GPR32_MMXd
  | .MOVD_GPR32_XMMd _ _ => .MOVD_GPR32_XMMd
  | .MOVD_MEMd_MMXd _ _ => .MOVD_MEMd_MMXd
  | .MOVD_MEMd_XMMd _ _ => .MOVD_MEMd_XMMd
  | .MOVD_MMXq_GPR32 _ _ => .MOVD_MMXq_GPR32
  | .MOVD_MMXq_MEMd _ _ => .MOVD_MMXq_MEMd
  | .MOVD_XMMdq_GPR32 _ _ => .MOVD_XMMdq_GPR32
  | .MOVD_XMMdq_MEMd _ _ => .MOVD_XMMdq_MEMd

def Forms.MOVD.encodingFits : Forms.MOVD → Bool
  | .MOVD_GPR32_MMXd _ _ => true
  | .MOVD_GPR32_XMMd _ _ => true
  | .MOVD_MEMd_MMXd mem0 _ => mem0.encodingFits
  | .MOVD_MEMd_XMMd mem0 _ => mem0.encodingFits
  | .MOVD_MMXq_GPR32 _ _ => true
  | .MOVD_MMXq_MEMd _ mem0 => mem0.encodingFits
  | .MOVD_XMMdq_GPR32 _ _ => true
  | .MOVD_XMMdq_MEMd _ mem0 => mem0.encodingFits

end X86.Syntax
