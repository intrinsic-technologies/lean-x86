-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTTSS2SI.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTTSS2SI where
  -- CVTTSS2SI_GPR32d_MEMss: REG0=GPR32_R():w:d:i32 MEM0:r:ss:f32
  | CVTTSS2SI_GPR32d_MEMss (reg0 : Registers.GPR32) (mem0 : MemoryOperand)
  -- CVTTSS2SI_GPR32d_XMMss: REG0=GPR32_R():w:d:i32 REG1=XMM_B():r:ss:f32
  | CVTTSS2SI_GPR32d_XMMss (reg0 : Registers.GPR32) (reg1 : Registers.XMM)
  -- CVTTSS2SI_GPR64q_MEMss: REG0=GPR64_R():w:q:i64 MEM0:r:ss:f32
  | CVTTSS2SI_GPR64q_MEMss (reg0 : Registers.GPR64) (mem0 : MemoryOperand)
  -- CVTTSS2SI_GPR64q_XMMss: REG0=GPR64_R():w:q:i64 REG1=XMM_B():r:ss:f32
  | CVTTSS2SI_GPR64q_XMMss (reg0 : Registers.GPR64) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTTSS2SI.xedForm : Forms.CVTTSS2SI → XedForm
  | .CVTTSS2SI_GPR32d_MEMss _ _ => .CVTTSS2SI_GPR32d_MEMss
  | .CVTTSS2SI_GPR32d_XMMss _ _ => .CVTTSS2SI_GPR32d_XMMss
  | .CVTTSS2SI_GPR64q_MEMss _ _ => .CVTTSS2SI_GPR64q_MEMss
  | .CVTTSS2SI_GPR64q_XMMss _ _ => .CVTTSS2SI_GPR64q_XMMss

def Forms.CVTTSS2SI.encodingFits : Forms.CVTTSS2SI → Bool
  | .CVTTSS2SI_GPR32d_MEMss _ mem0 => mem0.encodingFits
  | .CVTTSS2SI_GPR32d_XMMss _ _ => true
  | .CVTTSS2SI_GPR64q_MEMss _ mem0 => mem0.encodingFits
  | .CVTTSS2SI_GPR64q_XMMss _ _ => true

end X86.Syntax
