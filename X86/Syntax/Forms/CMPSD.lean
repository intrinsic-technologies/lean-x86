-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CMPSD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CMPSD where
  -- CMPSD_XMM_XMMsd_MEMsd_IMMb: REG0=XMM_R():rw:sd MEM0:r:sd IMM0:r:b
  | CMPSD_XMM_XMMsd_MEMsd_IMMb (reg0 : Registers.XMM) (mem0 : MemoryOperand) (imm0 : Immediate)
  -- CMPSD_XMM_XMMsd_XMMsd_IMMb: REG0=XMM_R():rw:sd REG1=XMM_B():r:sd IMM0:r:b
  | CMPSD_XMM_XMMsd_XMMsd_IMMb (reg0 : Registers.XMM) (reg1 : Registers.XMM) (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.CMPSD.xedForm : Forms.CMPSD → XedForm
  | .CMPSD_XMM_XMMsd_MEMsd_IMMb _ _ _ => .CMPSD_XMM_XMMsd_MEMsd_IMMb
  | .CMPSD_XMM_XMMsd_XMMsd_IMMb _ _ _ => .CMPSD_XMM_XMMsd_XMMsd_IMMb

def Forms.CMPSD.encodingFits : Forms.CMPSD → Bool
  | .CMPSD_XMM_XMMsd_MEMsd_IMMb _ mem0 imm0 => mem0.encodingFits && imm0.encodingFits
  | .CMPSD_XMM_XMMsd_XMMsd_IMMb _ _ imm0 => imm0.encodingFits

end X86.Syntax
