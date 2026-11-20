-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/INVD.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.INVD where
  -- INVD
  | INVD
  deriving Repr, BEq, Inhabited

def Forms.INVD.xedForm : Forms.INVD → XedForm
  | .INVD => .INVD

def Forms.INVD.encodingFits : Forms.INVD → Bool
  | .INVD  => true

end X86.Syntax
