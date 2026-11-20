-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CLI.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CLI where
  -- CLI
  | CLI
  deriving Repr, BEq, Inhabited

def Forms.CLI.xedForm : Forms.CLI → XedForm
  | .CLI => .CLI

def Forms.CLI.encodingFits : Forms.CLI → Bool
  | .CLI  => true

end X86.Syntax
