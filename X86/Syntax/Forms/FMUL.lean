-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FMUL-FMULP-FIMUL.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FMUL where
  -- FIMUL_ST0_MEMmem16int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem16int REG1=XED_REG_X87STATUS:w:SUPP
  | FIMUL_ST0_MEMmem16int (mem0 : MemoryOperand)
  -- FIMUL_ST0_MEMmem32int: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem32int REG1=XED_REG_X87STATUS:w:SUPP
  | FIMUL_ST0_MEMmem32int (mem0 : MemoryOperand)
  -- FMULP_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FMULP_X87_ST0 (reg0 : Registers.X87)
  -- FMUL_ST0_MEMm64real: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:m64real REG1=XED_REG_X87STATUS:w:SUPP
  | FMUL_ST0_MEMm64real (mem0 : MemoryOperand)
  -- FMUL_ST0_MEMmem32real: REG0=XED_REG_ST0:rw:IMPL:f80 MEM0:r:mem32real REG1=XED_REG_X87STATUS:w:SUPP
  | FMUL_ST0_MEMmem32real (mem0 : MemoryOperand)
  -- FMUL_ST0_X87: REG0=XED_REG_ST0:rw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FMUL_ST0_X87 (reg1 : Registers.X87)
  -- FMUL_X87_ST0: REG0=X87():rw:f80 REG1=XED_REG_ST0:r:IMPL:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FMUL_X87_ST0 (reg0 : Registers.X87)
  deriving Repr, BEq, Inhabited

def Forms.FMUL.xedForm : Forms.FMUL → XedForm
  | .FIMUL_ST0_MEMmem16int _ => .FIMUL_ST0_MEMmem16int
  | .FIMUL_ST0_MEMmem32int _ => .FIMUL_ST0_MEMmem32int
  | .FMULP_X87_ST0 _ => .FMULP_X87_ST0
  | .FMUL_ST0_MEMm64real _ => .FMUL_ST0_MEMm64real
  | .FMUL_ST0_MEMmem32real _ => .FMUL_ST0_MEMmem32real
  | .FMUL_ST0_X87 _ => .FMUL_ST0_X87
  | .FMUL_X87_ST0 _ => .FMUL_X87_ST0

def Forms.FMUL.encodingFits : Forms.FMUL → Bool
  | .FIMUL_ST0_MEMmem16int mem0 => mem0.encodingFits
  | .FIMUL_ST0_MEMmem32int mem0 => mem0.encodingFits
  | .FMULP_X87_ST0 _ => true
  | .FMUL_ST0_MEMm64real mem0 => mem0.encodingFits
  | .FMUL_ST0_MEMmem32real mem0 => mem0.encodingFits
  | .FMUL_ST0_X87 _ => true
  | .FMUL_X87_ST0 _ => true

end X86.Syntax
