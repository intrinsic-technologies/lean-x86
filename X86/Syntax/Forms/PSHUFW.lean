-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSHUFW.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSHUFW where
  -- PSHUFW_MMXq_MEMq_IMMb: REG0=MMX_R():w:q:u16 MEM0:r:q:u16 IMM0:r:b
  | PSHUFW_MMXq_MEMq_IMMb (reg0 : Registers.MMX) (mem0 : MemoryOperand) (imm0 : Immediate)
  -- PSHUFW_MMXq_MMXq_IMMb: REG0=MMX_R():w:q:u16 REG1=MMX_B():r:q:u16 IMM0:r:b
  | PSHUFW_MMXq_MMXq_IMMb (reg0 : Registers.MMX) (reg1 : Registers.MMX) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.PSHUFW.xedForm : Forms.PSHUFW → XedForm
  | .PSHUFW_MMXq_MEMq_IMMb _ _ _ => .PSHUFW_MMXq_MEMq_IMMb
  | .PSHUFW_MMXq_MMXq_IMMb _ _ _ => .PSHUFW_MMXq_MMXq_IMMb

def Forms.PSHUFW.encodingFits : Forms.PSHUFW → Bool
  | .PSHUFW_MMXq_MEMq_IMMb _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .PSHUFW_MMXq_MMXq_IMMb _ _ imm0 => imm0.encodingFits

end X86.Syntax
