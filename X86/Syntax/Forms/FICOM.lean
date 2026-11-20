-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FICOM-FICOMP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FICOM where
  -- FICOMP_ST0_MEMmem16int: REG0=XED_REG_ST0:r:IMPL:f80 MEM0:r:mem16int REG1=XED_REG_X87POP:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FICOMP_ST0_MEMmem16int (mem0 : MemoryOperand)
  -- FICOMP_ST0_MEMmem32int: REG0=XED_REG_ST0:r:IMPL:f80 MEM0:r:mem32int REG1=XED_REG_X87POP:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FICOMP_ST0_MEMmem32int (mem0 : MemoryOperand)
  -- FICOM_ST0_MEMmem16int: REG0=XED_REG_ST0:r:IMPL:f80 MEM0:r:mem16int REG1=XED_REG_X87STATUS:w:SUPP
  | FICOM_ST0_MEMmem16int (mem0 : MemoryOperand)
  -- FICOM_ST0_MEMmem32int: REG0=XED_REG_ST0:r:IMPL:f80 MEM0:r:mem32int REG1=XED_REG_X87STATUS:w:SUPP
  | FICOM_ST0_MEMmem32int (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FICOM.xedForm : Forms.FICOM → XedForm
  | .FICOMP_ST0_MEMmem16int _ => .FICOMP_ST0_MEMmem16int
  | .FICOMP_ST0_MEMmem32int _ => .FICOMP_ST0_MEMmem32int
  | .FICOM_ST0_MEMmem16int _ => .FICOM_ST0_MEMmem16int
  | .FICOM_ST0_MEMmem32int _ => .FICOM_ST0_MEMmem32int

def Forms.FICOM.encodingFits : Forms.FICOM → Bool
  | .FICOMP_ST0_MEMmem16int mem0 => mem0.encodingFits
  | .FICOMP_ST0_MEMmem32int mem0 => mem0.encodingFits
  | .FICOM_ST0_MEMmem16int mem0 => mem0.encodingFits
  | .FICOM_ST0_MEMmem32int mem0 => mem0.encodingFits

end X86.Syntax
