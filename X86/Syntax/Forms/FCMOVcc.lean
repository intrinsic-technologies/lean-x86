-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/FCMOVcc.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.FCMOVcc where
  -- FCMOVBE_ST0_X87: REG0=XED_REG_ST0:cw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FCMOVBE_ST0_X87 (reg1 : Registers.X87)
  -- FCMOVB_ST0_X87: REG0=XED_REG_ST0:cw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FCMOVB_ST0_X87 (reg1 : Registers.X87)
  -- FCMOVE_ST0_X87: REG0=XED_REG_ST0:cw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FCMOVE_ST0_X87 (reg1 : Registers.X87)
  -- FCMOVNBE_ST0_X87: REG0=XED_REG_ST0:cw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FCMOVNBE_ST0_X87 (reg1 : Registers.X87)
  -- FCMOVNB_ST0_X87: REG0=XED_REG_ST0:cw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FCMOVNB_ST0_X87 (reg1 : Registers.X87)
  -- FCMOVNE_ST0_X87: REG0=XED_REG_ST0:cw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FCMOVNE_ST0_X87 (reg1 : Registers.X87)
  -- FCMOVNU_ST0_X87: REG0=XED_REG_ST0:cw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FCMOVNU_ST0_X87 (reg1 : Registers.X87)
  -- FCMOVU_ST0_X87: REG0=XED_REG_ST0:cw:IMPL:f80 REG1=X87():r:f80 REG2=XED_REG_X87STATUS:w:SUPP
  | FCMOVU_ST0_X87 (reg1 : Registers.X87)
  deriving Repr, BEq, Inhabited

def Forms.FCMOVcc.xedForm : Forms.FCMOVcc → XedForm
  | .FCMOVBE_ST0_X87 _ => .FCMOVBE_ST0_X87
  | .FCMOVB_ST0_X87 _ => .FCMOVB_ST0_X87
  | .FCMOVE_ST0_X87 _ => .FCMOVE_ST0_X87
  | .FCMOVNBE_ST0_X87 _ => .FCMOVNBE_ST0_X87
  | .FCMOVNB_ST0_X87 _ => .FCMOVNB_ST0_X87
  | .FCMOVNE_ST0_X87 _ => .FCMOVNE_ST0_X87
  | .FCMOVNU_ST0_X87 _ => .FCMOVNU_ST0_X87
  | .FCMOVU_ST0_X87 _ => .FCMOVU_ST0_X87

def Forms.FCMOVcc.encodingFits : Forms.FCMOVcc → Bool
  | .FCMOVBE_ST0_X87 _ => true
  | .FCMOVB_ST0_X87 _ => true
  | .FCMOVE_ST0_X87 _ => true
  | .FCMOVNBE_ST0_X87 _ => true
  | .FCMOVNB_ST0_X87 _ => true
  | .FCMOVNE_ST0_X87 _ => true
  | .FCMOVNU_ST0_X87 _ => true
  | .FCMOVU_ST0_X87 _ => true

end X86.Syntax
