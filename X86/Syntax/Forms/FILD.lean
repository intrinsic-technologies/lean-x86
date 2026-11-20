-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FILD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FILD where
  -- FILD_ST0_MEMm64int: REG0=XED_REG_ST0:w:IMPL:f80 MEM0:r:m64int  REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FILD_ST0_MEMm64int (mem0 : MemoryOperand)
  -- FILD_ST0_MEMmem16int: REG0=XED_REG_ST0:w:IMPL:f80 MEM0:r:mem16int REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FILD_ST0_MEMmem16int (mem0 : MemoryOperand)
  -- FILD_ST0_MEMmem32int: REG0=XED_REG_ST0:w:IMPL:f80 MEM0:r:mem32int  REG1=XED_REG_X87PUSH:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FILD_ST0_MEMmem32int (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FILD.xedForm : Forms.FILD → XedForm
  | .FILD_ST0_MEMm64int _ => .FILD_ST0_MEMm64int
  | .FILD_ST0_MEMmem16int _ => .FILD_ST0_MEMmem16int
  | .FILD_ST0_MEMmem32int _ => .FILD_ST0_MEMmem32int

def Forms.FILD.encodingFits : Forms.FILD → Bool
  | .FILD_ST0_MEMm64int mem0 => mem0.encodingFits
  | .FILD_ST0_MEMmem16int mem0 => mem0.encodingFits
  | .FILD_ST0_MEMmem32int mem0 => mem0.encodingFits

end X86.Syntax
