-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FCOMI-FCOMIP-FUCOMI-FUCOMIP.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FCOMI where
  -- FCOMIP_ST0_X87: REG0=XED_REG_ST0:r:IMPL:f80 REG1=X87():r:f80  REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FCOMIP_ST0_X87 (reg1 : Registers.X87)
  -- FCOMI_ST0_X87: REG0=XED_REG_ST0:r:IMPL:f80 REG1=X87():r:f80  REG2=XED_REG_X87STATUS:w:SUPP
  | FCOMI_ST0_X87 (reg1 : Registers.X87)
  -- FUCOMIP_ST0_X87: REG0=XED_REG_ST0:r:IMPL:f80 REG1=X87():r:f80   REG2=XED_REG_X87POP:r:SUPP REG3=XED_REG_X87STATUS:w:SUPP
  | FUCOMIP_ST0_X87 (reg1 : Registers.X87)
  -- FUCOMI_ST0_X87: REG0=XED_REG_ST0:r:IMPL:f80 REG1=X87():r:f80   REG2=XED_REG_X87STATUS:w:SUPP
  | FUCOMI_ST0_X87 (reg1 : Registers.X87)
  deriving Repr, BEq, Inhabited

def Forms.FCOMI.xedForm : Forms.FCOMI → XedForm
  | .FCOMIP_ST0_X87 _ => .FCOMIP_ST0_X87
  | .FCOMI_ST0_X87 _ => .FCOMI_ST0_X87
  | .FUCOMIP_ST0_X87 _ => .FUCOMIP_ST0_X87
  | .FUCOMI_ST0_X87 _ => .FUCOMI_ST0_X87

def Forms.FCOMI.encodingFits : Forms.FCOMI → Bool
  | .FCOMIP_ST0_X87 _ => true
  | .FCOMI_ST0_X87 _ => true
  | .FUCOMIP_ST0_X87 _ => true
  | .FUCOMI_ST0_X87 _ => true

end X86.Syntax
