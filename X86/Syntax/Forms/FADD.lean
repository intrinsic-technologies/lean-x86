-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FADD-FADDP-FIADD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FADD where
  -- FADDP_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FADDP_X87_ST0 (reg0 : Registers.X87)
  -- FADD_MEMm64real: REG0=XED_REG_ST0:rw:SUPP:f80 MEM0:r:m64real REG1=XED_REG_X87STATUS:w:SUPP
  | FADD_MEMm64real (mem0 : MemoryOperand)
  -- FADD_MEMmem32real: REG0=XED_REG_ST0:rw:SUPP:f80 MEM0:r:mem32real REG1=XED_REG_X87STATUS:w:SUPP
  | FADD_MEMmem32real (mem0 : MemoryOperand)
  -- FADD_ST0_X87: REG0=XED_REG_ST0:rw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FADD_ST0_X87 (reg1 : Registers.X87)
  -- FADD_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FADD_X87_ST0 (reg0 : Registers.X87)
  -- FIADD_ST0_MEMmem16int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem16int REG1=XED_REG_X87STATUS:w:SUPP
  | FIADD_ST0_MEMmem16int (mem0 : MemoryOperand)
  -- FIADD_ST0_MEMmem32int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem32int REG1=XED_REG_X87STATUS:w:SUPP
  | FIADD_ST0_MEMmem32int (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.FADD.xedForm : Forms.FADD → XedForm
  | .FADDP_X87_ST0 _ => .FADDP_X87_ST0
  | .FADD_MEMm64real _ => .FADD_MEMm64real
  | .FADD_MEMmem32real _ => .FADD_MEMmem32real
  | .FADD_ST0_X87 _ => .FADD_ST0_X87
  | .FADD_X87_ST0 _ => .FADD_X87_ST0
  | .FIADD_ST0_MEMmem16int _ => .FIADD_ST0_MEMmem16int
  | .FIADD_ST0_MEMmem32int _ => .FIADD_ST0_MEMmem32int

def Forms.FADD.encodingFits : Forms.FADD → Bool
  | .FADDP_X87_ST0 _ => true
  | .FADD_MEMm64real mem0 => mem0.encodingFits
  | .FADD_MEMmem32real mem0 => mem0.encodingFits
  | .FADD_ST0_X87 _ => true
  | .FADD_X87_ST0 _ => true
  | .FIADD_ST0_MEMmem16int mem0 => mem0.encodingFits
  | .FIADD_ST0_MEMmem32int mem0 => mem0.encodingFits

end X86.Syntax
