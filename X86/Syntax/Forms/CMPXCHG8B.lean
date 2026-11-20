-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/CMPXCHG8B-CMPXCHG16B.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.CMPXCHG8B where
  -- CMPXCHG16B_LOCK_MEMdq: MEM0:rcw:dq REG0=XED_REG_RDX:rcw:SUPP REG1=XED_REG_RAX:rcw:SUPP REG2=XED_REG_RCX:r:SUPP REG3=XED_REG_RBX:r:SUPP
  | CMPXCHG16B_LOCK_MEMdq (mem0 : MemoryOperand)
  -- CMPXCHG16B_MEMdq: MEM0:rcw:dq REG0=XED_REG_RDX:rcw:SUPP REG1=XED_REG_RAX:rcw:SUPP REG2=XED_REG_RCX:r:SUPP REG3=XED_REG_RBX:r:SUPP
  | CMPXCHG16B_MEMdq (mem0 : MemoryOperand)
  -- CMPXCHG8B_LOCK_MEMq: MEM0:rcw:q REG0=XED_REG_EDX:rcw:SUPP REG1=XED_REG_EAX:rcw:SUPP REG2=XED_REG_ECX:r:SUPP REG3=XED_REG_EBX:r:SUPP
  | CMPXCHG8B_LOCK_MEMq (mem0 : MemoryOperand)
  -- CMPXCHG8B_MEMq: MEM0:rcw:q REG0=XED_REG_EDX:rcw:SUPP REG1=XED_REG_EAX:rcw:SUPP REG2=XED_REG_ECX:r:SUPP REG3=XED_REG_EBX:r:SUPP
  | CMPXCHG8B_MEMq (mem0 : MemoryOperand)
  deriving Repr, BEq, Inhabited

def Forms.CMPXCHG8B.xedForm : Forms.CMPXCHG8B → XedForm
  | .CMPXCHG16B_LOCK_MEMdq _ => .CMPXCHG16B_LOCK_MEMdq
  | .CMPXCHG16B_MEMdq _ => .CMPXCHG16B_MEMdq
  | .CMPXCHG8B_LOCK_MEMq _ => .CMPXCHG8B_LOCK_MEMq
  | .CMPXCHG8B_MEMq _ => .CMPXCHG8B_MEMq

def Forms.CMPXCHG8B.encodingFits : Forms.CMPXCHG8B → Bool
  | .CMPXCHG16B_LOCK_MEMdq mem0 => mem0.encodingFits
  | .CMPXCHG16B_MEMdq mem0 => mem0.encodingFits
  | .CMPXCHG8B_LOCK_MEMq mem0 => mem0.encodingFits
  | .CMPXCHG8B_MEMq mem0 => mem0.encodingFits

end X86.Syntax
