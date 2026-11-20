-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CMPPS.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CMPPS where
  -- CMPPS_XMMps_MEMps_IMMb: REG0=XMM_R():rw:ps MEM0:r:ps IMM0:r:b
  | CMPPS_XMMps_MEMps_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate)
  -- CMPPS_XMMps_XMMps_IMMb: REG0=XMM_R():rw:ps REG1=XMM_B():r:ps IMM0:r:b
  | CMPPS_XMMps_XMMps_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.CMPPS.xedForm : Forms.CMPPS → XedForm
  | .CMPPS_XMMps_MEMps_IMMb _ _ _ => .CMPPS_XMMps_MEMps_IMMb
  | .CMPPS_XMMps_XMMps_IMMb _ _ _ => .CMPPS_XMMps_XMMps_IMMb

def Forms.CMPPS.encodingFits : Forms.CMPPS → Bool
  | .CMPPS_XMMps_MEMps_IMMb _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .CMPPS_XMMps_XMMps_IMMb _ _ imm0 => imm0.encodingFits

end X86.Syntax
