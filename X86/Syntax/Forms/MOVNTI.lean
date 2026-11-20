-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/MOVNTI.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.MOVNTI where
  -- MOVNTI_MEMd_GPR32: MEM0:w:d REG0=GPR32_R():r
  | MOVNTI_MEMd_GPR32 (mem0 : MemoryOperand) (reg0 : Registers.GPR32)
  -- MOVNTI_MEMq_GPR64: MEM0:w:q REG0=GPR64_R():r
  | MOVNTI_MEMq_GPR64 (mem0 : MemoryOperand) (reg0 : Registers.GPR64)
  deriving Repr, BEq, Inhabited

def Forms.MOVNTI.xedForm : Forms.MOVNTI → XedForm
  | .MOVNTI_MEMd_GPR32 _ _ => .MOVNTI_MEMd_GPR32
  | .MOVNTI_MEMq_GPR64 _ _ => .MOVNTI_MEMq_GPR64

def Forms.MOVNTI.encodingFits : Forms.MOVNTI → Bool
  | .MOVNTI_MEMd_GPR32 mem0 _ => mem0.encodingFits
  | .MOVNTI_MEMq_GPR64 mem0 _ => mem0.encodingFits

end X86.Syntax
