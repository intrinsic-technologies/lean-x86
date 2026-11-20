-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/SHUFPD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.SHUFPD where
  -- SHUFPD_XMMpd_MEMpd_IMMb: REG0=XMM_R():rw:pd MEM0:r:pd IMM0:r:b
  | SHUFPD_XMMpd_MEMpd_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate)
  -- SHUFPD_XMMpd_XMMpd_IMMb: REG0=XMM_R():rw:pd REG1=XMM_B():r:pd IMM0:r:b
  | SHUFPD_XMMpd_XMMpd_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.SHUFPD.xedForm : Forms.SHUFPD → XedForm
  | .SHUFPD_XMMpd_MEMpd_IMMb _ _ _ => .SHUFPD_XMMpd_MEMpd_IMMb
  | .SHUFPD_XMMpd_XMMpd_IMMb _ _ _ => .SHUFPD_XMMpd_XMMpd_IMMb

def Forms.SHUFPD.encodingFits : Forms.SHUFPD → Bool
  | .SHUFPD_XMMpd_MEMpd_IMMb _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .SHUFPD_XMMpd_XMMpd_IMMb _ _ imm0 => imm0.encodingFits

end X86.Syntax
