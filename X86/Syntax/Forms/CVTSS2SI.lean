-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTSS2SI.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTSS2SI where
  -- CVTSS2SI_GPR32d_MEMss: REG0=GPR32_R():w:d:i32 MEM0:r:ss:f32
  | CVTSS2SI_GPR32d_MEMss (reg0 : Registers.GPR32) (mem0 : MemoryOperand)
  -- CVTSS2SI_GPR32d_XMMss: REG0=GPR32_R():w:d:i32 REG1=XMM_B():r:ss:f32
  | CVTSS2SI_GPR32d_XMMss (reg0 : Registers.GPR32) (reg1 : Registers.XMM)
  -- CVTSS2SI_GPR64q_MEMss: REG0=GPR64_R():w:q:i64 MEM0:r:ss:f32
  | CVTSS2SI_GPR64q_MEMss (reg0 : Registers.GPR64) (mem0 : MemoryOperand)
  -- CVTSS2SI_GPR64q_XMMss: REG0=GPR64_R():w:q:i64 REG1=XMM_B():r:ss:f32
  | CVTSS2SI_GPR64q_XMMss (reg0 : Registers.GPR64) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTSS2SI.xedForm : Forms.CVTSS2SI → XedForm
  | .CVTSS2SI_GPR32d_MEMss _ _ => .CVTSS2SI_GPR32d_MEMss
  | .CVTSS2SI_GPR32d_XMMss _ _ => .CVTSS2SI_GPR32d_XMMss
  | .CVTSS2SI_GPR64q_MEMss _ _ => .CVTSS2SI_GPR64q_MEMss
  | .CVTSS2SI_GPR64q_XMMss _ _ => .CVTSS2SI_GPR64q_XMMss

def Forms.CVTSS2SI.encodingFits : Forms.CVTSS2SI → Bool
  | .CVTSS2SI_GPR32d_MEMss _ mem0 => mem0.encodingFits
  | .CVTSS2SI_GPR32d_XMMss _ _ => true
  | .CVTSS2SI_GPR64q_MEMss _ mem0 => mem0.encodingFits
  | .CVTSS2SI_GPR64q_XMMss _ _ => true

end X86.Syntax
