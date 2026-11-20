-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CPUID.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CPUID where
  -- CPUID: REG0=XED_REG_EAX:rw:SUPP REG1=XED_REG_EBX:w:SUPP REG2=XED_REG_ECX:crw:SUPP REG3=XED_REG_EDX:w:SUPP
  | CPUID
  deriving Repr, BEq, Inhabited

def Forms.CPUID.xedForm : Forms.CPUID → XedForm
  | .CPUID => .CPUID

def Forms.CPUID.encodingFits : Forms.CPUID → Bool
  | .CPUID  => true

end X86.Syntax
