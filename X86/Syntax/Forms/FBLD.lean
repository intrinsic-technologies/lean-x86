-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FBLD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FBLD where
  -- FBLD_ST0_MEMmem80dec: REG0=XED_REG_ST0:w:IMPL:f80 MEM0:r:mem80dec  REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FBLD_ST0_MEMmem80dec (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FBLD.xedForm : Forms.FBLD → XedForm
  | .FBLD_ST0_MEMmem80dec _ => .FBLD_ST0_MEMmem80dec

def Forms.FBLD.encodingFits : Forms.FBLD → Bool
  | .FBLD_ST0_MEMmem80dec mem0 => mem0.encodingFits

end X86.Syntax
