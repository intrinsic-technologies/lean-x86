-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CMPSS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CMPSS where
  -- CMPSS_XMMss_MEMss_IMMb: REG0=XMM_R():rw:ss MEM0:r:ss IMM0:r:b
  | CMPSS_XMMss_MEMss_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate)
  -- CMPSS_XMMss_XMMss_IMMb: REG0=XMM_R():rw:ss REG1=XMM_B():r:ss IMM0:r:b
  | CMPSS_XMMss_XMMss_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.CMPSS.xedForm : Forms.CMPSS → XedForm
  | .CMPSS_XMMss_MEMss_IMMb _ _ _ => .CMPSS_XMMss_MEMss_IMMb
  | .CMPSS_XMMss_XMMss_IMMb _ _ _ => .CMPSS_XMMss_XMMss_IMMb

def Forms.CMPSS.encodingFits : Forms.CMPSS → Bool
  | .CMPSS_XMMss_MEMss_IMMb _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .CMPSS_XMMss_XMMss_IMMb _ _ imm0 => imm0.encodingFits

end X86.Syntax
