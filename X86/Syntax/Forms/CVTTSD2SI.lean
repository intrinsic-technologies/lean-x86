-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTTSD2SI.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTTSD2SI where
  -- CVTTSD2SI_GPR32d_MEMsd: REG0=GPR32_R():w:d:i32 MEM0:r:sd:f64
  | CVTTSD2SI_GPR32d_MEMsd (reg0 : Registers.GPR32) (mem0 : MemoryOperand)
  -- CVTTSD2SI_GPR32d_XMMsd: REG0=GPR32_R():w:d:i32 REG1=XMM_B():r:sd:f64
  | CVTTSD2SI_GPR32d_XMMsd (reg0 : Registers.GPR32) (reg1 : Registers.XMM)
  -- CVTTSD2SI_GPR64q_MEMsd: REG0=GPR64_R():w:q:i64 MEM0:r:sd:f64
  | CVTTSD2SI_GPR64q_MEMsd (reg0 : Registers.GPR64) (mem0 : MemoryOperand)
  -- CVTTSD2SI_GPR64q_XMMsd: REG0=GPR64_R():w:q:i64 REG1=XMM_B():r:sd:f64
  | CVTTSD2SI_GPR64q_XMMsd (reg0 : Registers.GPR64) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTTSD2SI.xedForm : Forms.CVTTSD2SI → XedForm
  | .CVTTSD2SI_GPR32d_MEMsd _ _ => .CVTTSD2SI_GPR32d_MEMsd
  | .CVTTSD2SI_GPR32d_XMMsd _ _ => .CVTTSD2SI_GPR32d_XMMsd
  | .CVTTSD2SI_GPR64q_MEMsd _ _ => .CVTTSD2SI_GPR64q_MEMsd
  | .CVTTSD2SI_GPR64q_XMMsd _ _ => .CVTTSD2SI_GPR64q_XMMsd

def Forms.CVTTSD2SI.encodingFits : Forms.CVTTSD2SI → Bool
  | .CVTTSD2SI_GPR32d_MEMsd _ mem0 => mem0.encodingFits
  | .CVTTSD2SI_GPR32d_XMMsd _ _ => true
  | .CVTTSD2SI_GPR64q_MEMsd _ mem0 => mem0.encodingFits
  | .CVTTSD2SI_GPR64q_XMMsd _ _ => true

end X86.Syntax
