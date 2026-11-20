-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/PSHUFD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.PSHUFD where
  -- PSHUFD_XMMdq_MEMdq_IMMb: REG0=XMM_R():w:dq:u32 MEM0:r:dq:u32 IMM0:r:b
  | PSHUFD_XMMdq_MEMdq_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate)
  -- PSHUFD_XMMdq_XMMdq_IMMb: REG0=XMM_R():w:dq:u32 REG1=XMM_B():r:dq:u32 IMM0:r:b
  | PSHUFD_XMMdq_XMMdq_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.PSHUFD.xedForm : Forms.PSHUFD → XedForm
  | .PSHUFD_XMMdq_MEMdq_IMMb _ _ _ => .PSHUFD_XMMdq_MEMdq_IMMb
  | .PSHUFD_XMMdq_XMMdq_IMMb _ _ _ => .PSHUFD_XMMdq_XMMdq_IMMb

def Forms.PSHUFD.encodingFits : Forms.PSHUFD → Bool
  | .PSHUFD_XMMdq_MEMdq_IMMb _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .PSHUFD_XMMdq_XMMdq_IMMb _ _ imm0 => imm0.encodingFits

end X86.Syntax
