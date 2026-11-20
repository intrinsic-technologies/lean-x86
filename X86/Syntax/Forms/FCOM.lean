-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FCOM-FCOMP-FCOMPP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FCOM where
  -- FCOMPP: REG0=XED_REG_ST0:r:SUPP:f80 REG1=XED_REG_ST1:r:SUPP:f80 REG2=XED_REG_X87POP2:r:SUPP REG3=XED_REG_X87STATUS:rw:SUPP
  | FCOMPP
  -- FCOMP_ST0_MEMm64real: REG0=XED_REG_ST0:r:IMPL:f80 MEM0:r:m64real REG1=XED_REG_X87POP:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FCOMP_ST0_MEMm64real (mem0 : MemoryOperand)
  -- FCOMP_ST0_MEMmem32real: REG0=XED_REG_ST0:r:IMPL:f80 MEM0:r:mem32real REG1=XED_REG_X87POP:r:SUPP REG2=XED_REG_X87STATUS:w:SUPP
  | FCOMP_ST0_MEMmem32real (mem0 : MemoryOperand)
  -- FCOMP_ST0_X87: REG0=XED_REG_ST0:r:IMPL:f80 REG1=X87():r:f80   REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FCOMP_ST0_X87 (reg1 : Registers.X87)
  -- FCOMP_ST0_X87_DCD1: REG0=XED_REG_ST0:r:IMPL:f80 REG1=X87():r:f80   REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FCOMP_ST0_X87_DCD1 (reg1 : Registers.X87)
  -- FCOMP_ST0_X87_DED0: REG0=XED_REG_ST0:r:IMPL:f80 REG1=X87():r:f80   REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FCOMP_ST0_X87_DED0 (reg1 : Registers.X87)
  -- FCOM_ST0_MEMm64real: REG0=XED_REG_ST0:r:IMPL:f80 MEM0:r:m64real REG1=XED_REG_X87STATUS:w:SUPP
  | FCOM_ST0_MEMm64real (mem0 : MemoryOperand)
  -- FCOM_ST0_MEMmem32real: REG0=XED_REG_ST0:r:IMPL:f80 MEM0:r:mem32real REG1=XED_REG_X87STATUS:w:SUPP
  | FCOM_ST0_MEMmem32real (mem0 : MemoryOperand)
  -- FCOM_ST0_X87: REG0=XED_REG_ST0:r:IMPL:f80 REG1=X87():r:f80   REG2=XED_REG_X87STATUS:w:SUPP
  | FCOM_ST0_X87 (reg1 : Registers.X87)
  -- FCOM_ST0_X87_DCD0: REG0=XED_REG_ST0:r:IMPL:f80 REG1=X87():r:f80   REG2=XED_REG_X87STATUS:w:SUPP
  | FCOM_ST0_X87_DCD0 (reg1 : Registers.X87)
  deriving Repr, BEq, Inhabited

def Forms.FCOM.xedForm : Forms.FCOM → XedForm
  | .FCOMPP => .FCOMPP
  | .FCOMP_ST0_MEMm64real _ => .FCOMP_ST0_MEMm64real
  | .FCOMP_ST0_MEMmem32real _ => .FCOMP_ST0_MEMmem32real
  | .FCOMP_ST0_X87 _ => .FCOMP_ST0_X87
  | .FCOMP_ST0_X87_DCD1 _ => .FCOMP_ST0_X87_DCD1
  | .FCOMP_ST0_X87_DED0 _ => .FCOMP_ST0_X87_DED0
  | .FCOM_ST0_MEMm64real _ => .FCOM_ST0_MEMm64real
  | .FCOM_ST0_MEMmem32real _ => .FCOM_ST0_MEMmem32real
  | .FCOM_ST0_X87 _ => .FCOM_ST0_X87
  | .FCOM_ST0_X87_DCD0 _ => .FCOM_ST0_X87_DCD0

def Forms.FCOM.encodingFits : Forms.FCOM → Bool
  | .FCOMPP  => true
  | .FCOMP_ST0_MEMm64real mem0 => mem0.encodingFits
  | .FCOMP_ST0_MEMmem32real mem0 => mem0.encodingFits
  | .FCOMP_ST0_X87 _ => true
  | .FCOMP_ST0_X87_DCD1 _ => true
  | .FCOMP_ST0_X87_DED0 _ => true
  | .FCOM_ST0_MEMm64real mem0 => mem0.encodingFits
  | .FCOM_ST0_MEMmem32real mem0 => mem0.encodingFits
  | .FCOM_ST0_X87 _ => true
  | .FCOM_ST0_X87_DCD0 _ => true

end X86.Syntax
