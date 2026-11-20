-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CVTSD2SI.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CVTSD2SI where
  -- CVTSD2SI_GPR32d_MEMsd: REG0=GPR32_R():w:d:i32 MEM0:r:sd:f64
  | CVTSD2SI_GPR32d_MEMsd (reg0 : Registers.GPR32) (mem0 : MemoryOperand)
  -- CVTSD2SI_GPR32d_XMMsd: REG0=GPR32_R():w:d:i32 REG1=XMM_B():r:sd:f64
  | CVTSD2SI_GPR32d_XMMsd (reg0 : Registers.GPR32) (reg1 : Registers.XMM)
  -- CVTSD2SI_GPR64q_MEMsd: REG0=GPR64_R():w:q:i64 MEM0:r:sd:f64
  | CVTSD2SI_GPR64q_MEMsd (reg0 : Registers.GPR64) (mem0 : MemoryOperand)
  -- CVTSD2SI_GPR64q_XMMsd: REG0=GPR64_R():w:q:i64 REG1=XMM_B():r:sd:f64
  | CVTSD2SI_GPR64q_XMMsd (reg0 : Registers.GPR64) (reg1 : Registers.XMM)
  deriving Repr, BEq, Inhabited

def Forms.CVTSD2SI.xedForm : Forms.CVTSD2SI → XedForm
  | .CVTSD2SI_GPR32d_MEMsd _ _ => .CVTSD2SI_GPR32d_MEMsd
  | .CVTSD2SI_GPR32d_XMMsd _ _ => .CVTSD2SI_GPR32d_XMMsd
  | .CVTSD2SI_GPR64q_MEMsd _ _ => .CVTSD2SI_GPR64q_MEMsd
  | .CVTSD2SI_GPR64q_XMMsd _ _ => .CVTSD2SI_GPR64q_XMMsd

def Forms.CVTSD2SI.encodingFits : Forms.CVTSD2SI → Bool
  | .CVTSD2SI_GPR32d_MEMsd _ mem0 => mem0.encodingFits
  | .CVTSD2SI_GPR32d_XMMsd _ _ => true
  | .CVTSD2SI_GPR64q_MEMsd _ mem0 => mem0.encodingFits
  | .CVTSD2SI_GPR64q_XMMsd _ _ => true

end X86.Syntax
