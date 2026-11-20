-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FLD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FLD where
  -- FLD_ST0_MEMm64real: REG0=XED_REG_ST0:w:IMPL:f80 MEM0:r:m64real  REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FLD_ST0_MEMm64real (mem0 : MemoryOperand)
  -- FLD_ST0_MEMmem32real: REG0=XED_REG_ST0:w:IMPL:f80 MEM0:r:mem32real  REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FLD_ST0_MEMmem32real (mem0 : MemoryOperand)
  -- FLD_ST0_MEMmem80real: REG0=XED_REG_ST0:w:IMPL:f80 MEM0:r:mem80real  REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FLD_ST0_MEMmem80real (mem0 : MemoryOperand)
  -- FLD_ST0_X87: REG0=XED_REG_ST0:w:IMPL:f80 REG1=X87():r:f80  REG2=XED_REG_X87PUSH:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FLD_ST0_X87 (reg1 : Registers.X87)
  deriving Repr, BEq, Inhabited

def Forms.FLD.xedForm : Forms.FLD → XedForm
  | .FLD_ST0_MEMm64real _ => .FLD_ST0_MEMm64real
  | .FLD_ST0_MEMmem32real _ => .FLD_ST0_MEMmem32real
  | .FLD_ST0_MEMmem80real _ => .FLD_ST0_MEMmem80real
  | .FLD_ST0_X87 _ => .FLD_ST0_X87

def Forms.FLD.encodingFits : Forms.FLD → Bool
  | .FLD_ST0_MEMm64real mem0 => mem0.encodingFits
  | .FLD_ST0_MEMmem32real mem0 => mem0.encodingFits
  | .FLD_ST0_MEMmem80real mem0 => mem0.encodingFits
  | .FLD_ST0_X87 _ => true

end X86.Syntax
