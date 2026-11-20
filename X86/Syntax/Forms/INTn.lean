-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/INTn-INTO-INT3-INT1.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.INTn where
  -- INT1: REG0=rIP():w:SUPP
  | INT1
  -- INT3: REG0=rIP():w:SUPP
  | INT3
  -- INT_IMMb: IMM0:r:b REG0=rIP():w:SUPP
  | INT_IMMb (imm0 : Immediate)
  deriving Repr, BEq, Inhabited

def Forms.INTn.xedForm : Forms.INTn → XedForm
  | .INT1 => .INT1
  | .INT3 => .INT3
  | .INT_IMMb _ => .INT_IMMb

def Forms.INTn.encodingFits : Forms.INTn → Bool
  | .INT1  => true
  | .INT3  => true
  | .INT_IMMb imm0 => imm0.encodingFits

end X86.Syntax
