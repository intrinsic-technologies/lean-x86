-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/POP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.POP where
  -- POP_FS: REG0=XED_REG_FS:w:IMPL REG1=XED_REG_STACKPOP:rw:spw:SUPP
  | POP_FS
  -- POP_GPRv_58: REG0=GPRv_SB():w REG1=XED_REG_STACKPOP:rw:spw:SUPP
  | POP_GPRv_58 (reg0 : Registers.GPRv)
  -- POP_GPRv_8F: REG0=GPRv_B():w REG1=XED_REG_STACKPOP:rw:spw:SUPP
  | POP_GPRv_8F (reg0 : Registers.GPRv)
  -- POP_GS: REG0=XED_REG_GS:w:IMPL REG1=XED_REG_STACKPOP:rw:spw:SUPP
  | POP_GS
  -- POP_MEMv: MEM0:w:v REG0=XED_REG_STACKPOP:rw:spw:SUPP
  | POP_MEMv (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.POP.xedForm : Forms.POP → XedForm
  | .POP_FS => .POP_FS
  | .POP_GPRv_58 _ => .POP_GPRv_58
  | .POP_GPRv_8F _ => .POP_GPRv_8F
  | .POP_GS => .POP_GS
  | .POP_MEMv _ => .POP_MEMv

def Forms.POP.encodingFits : Forms.POP → Bool
  | .POP_FS  => true
  | .POP_GPRv_58 _ => true
  | .POP_GPRv_8F _ => true
  | .POP_GS  => true
  | .POP_MEMv mem0 => mem0.encodingFits

end X86.Syntax
