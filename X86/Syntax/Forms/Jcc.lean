-- Generated from pinned Intel XED operand tables and selected SDM forms: data/instruction/Jcc.xml; do not edit.
import X86.Syntax.Operands
import X86.Syntax.Registers
import X86.Syntax.FormIds

namespace X86.Syntax

inductive Forms.Jcc where
  -- JBE_RELBRb: RELBR:r:b:i8  REG0=XED_REG_RIP:rw:SUPP
  | JBE_RELBRb (relbr : RelativeOperand)
  -- JBE_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JBE_RELBRd (relbr : RelativeOperand)
  -- JB_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JB_RELBRb (relbr : RelativeOperand)
  -- JB_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JB_RELBRd (relbr : RelativeOperand)
  -- JCXZ_RELBRb: RELBR:r:b:i8 REG0=XED_REG_CX:r:SUPP REG1=XED_REG_IP:rw:SUPP
  | JCXZ_RELBRb (relbr : RelativeOperand)
  -- JECXZ_RELBRb: RELBR:r:b:i8 REG0=XED_REG_ECX:r:SUPP REG1=XED_REG_RIP:rw:SUPP
  | JECXZ_RELBRb (relbr : RelativeOperand)
  -- JLE_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JLE_RELBRb (relbr : RelativeOperand)
  -- JLE_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JLE_RELBRd (relbr : RelativeOperand)
  -- JL_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JL_RELBRb (relbr : RelativeOperand)
  -- JL_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JL_RELBRd (relbr : RelativeOperand)
  -- JNBE_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JNBE_RELBRb (relbr : RelativeOperand)
  -- JNBE_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JNBE_RELBRd (relbr : RelativeOperand)
  -- JNB_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JNB_RELBRb (relbr : RelativeOperand)
  -- JNB_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JNB_RELBRd (relbr : RelativeOperand)
  -- JNLE_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JNLE_RELBRb (relbr : RelativeOperand)
  -- JNLE_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JNLE_RELBRd (relbr : RelativeOperand)
  -- JNL_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JNL_RELBRb (relbr : RelativeOperand)
  -- JNL_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JNL_RELBRd (relbr : RelativeOperand)
  -- JNO_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JNO_RELBRb (relbr : RelativeOperand)
  -- JNO_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JNO_RELBRd (relbr : RelativeOperand)
  -- JNP_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JNP_RELBRb (relbr : RelativeOperand)
  -- JNP_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JNP_RELBRd (relbr : RelativeOperand)
  -- JNS_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JNS_RELBRb (relbr : RelativeOperand)
  -- JNS_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JNS_RELBRd (relbr : RelativeOperand)
  -- JNZ_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JNZ_RELBRb (relbr : RelativeOperand)
  -- JNZ_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JNZ_RELBRd (relbr : RelativeOperand)
  -- JO_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JO_RELBRb (relbr : RelativeOperand)
  -- JO_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JO_RELBRd (relbr : RelativeOperand)
  -- JP_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JP_RELBRb (relbr : RelativeOperand)
  -- JP_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JP_RELBRd (relbr : RelativeOperand)
  -- JRCXZ_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RCX:r:SUPP REG1=XED_REG_RIP:rw:SUPP
  | JRCXZ_RELBRb (relbr : RelativeOperand)
  -- JS_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JS_RELBRb (relbr : RelativeOperand)
  -- JS_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JS_RELBRd (relbr : RelativeOperand)
  -- JZ_RELBRb: RELBR:r:b:i8 REG0=XED_REG_RIP:rw:SUPP
  | JZ_RELBRb (relbr : RelativeOperand)
  -- JZ_RELBRd: RELBR:r:d REG0=XED_REG_RIP:rw:SUPP
  | JZ_RELBRd (relbr : RelativeOperand)
  deriving Repr, BEq, Inhabited

def Forms.Jcc.xedForm : Forms.Jcc → XedForm
  | .JBE_RELBRb _ => .JBE_RELBRb
  | .JBE_RELBRd _ => .JBE_RELBRd
  | .JB_RELBRb _ => .JB_RELBRb
  | .JB_RELBRd _ => .JB_RELBRd
  | .JCXZ_RELBRb _ => .JCXZ_RELBRb
  | .JECXZ_RELBRb _ => .JECXZ_RELBRb
  | .JLE_RELBRb _ => .JLE_RELBRb
  | .JLE_RELBRd _ => .JLE_RELBRd
  | .JL_RELBRb _ => .JL_RELBRb
  | .JL_RELBRd _ => .JL_RELBRd
  | .JNBE_RELBRb _ => .JNBE_RELBRb
  | .JNBE_RELBRd _ => .JNBE_RELBRd
  | .JNB_RELBRb _ => .JNB_RELBRb
  | .JNB_RELBRd _ => .JNB_RELBRd
  | .JNLE_RELBRb _ => .JNLE_RELBRb
  | .JNLE_RELBRd _ => .JNLE_RELBRd
  | .JNL_RELBRb _ => .JNL_RELBRb
  | .JNL_RELBRd _ => .JNL_RELBRd
  | .JNO_RELBRb _ => .JNO_RELBRb
  | .JNO_RELBRd _ => .JNO_RELBRd
  | .JNP_RELBRb _ => .JNP_RELBRb
  | .JNP_RELBRd _ => .JNP_RELBRd
  | .JNS_RELBRb _ => .JNS_RELBRb
  | .JNS_RELBRd _ => .JNS_RELBRd
  | .JNZ_RELBRb _ => .JNZ_RELBRb
  | .JNZ_RELBRd _ => .JNZ_RELBRd
  | .JO_RELBRb _ => .JO_RELBRb
  | .JO_RELBRd _ => .JO_RELBRd
  | .JP_RELBRb _ => .JP_RELBRb
  | .JP_RELBRd _ => .JP_RELBRd
  | .JRCXZ_RELBRb _ => .JRCXZ_RELBRb
  | .JS_RELBRb _ => .JS_RELBRb
  | .JS_RELBRd _ => .JS_RELBRd
  | .JZ_RELBRb _ => .JZ_RELBRb
  | .JZ_RELBRd _ => .JZ_RELBRd

def Forms.Jcc.encodingFits : Forms.Jcc → Bool
  | .JBE_RELBRb relbr => relbr.encodingFits
  | .JBE_RELBRd relbr => relbr.encodingFits
  | .JB_RELBRb relbr => relbr.encodingFits
  | .JB_RELBRd relbr => relbr.encodingFits
  | .JCXZ_RELBRb relbr => relbr.encodingFits
  | .JECXZ_RELBRb relbr => relbr.encodingFits
  | .JLE_RELBRb relbr => relbr.encodingFits
  | .JLE_RELBRd relbr => relbr.encodingFits
  | .JL_RELBRb relbr => relbr.encodingFits
  | .JL_RELBRd relbr => relbr.encodingFits
  | .JNBE_RELBRb relbr => relbr.encodingFits
  | .JNBE_RELBRd relbr => relbr.encodingFits
  | .JNB_RELBRb relbr => relbr.encodingFits
  | .JNB_RELBRd relbr => relbr.encodingFits
  | .JNLE_RELBRb relbr => relbr.encodingFits
  | .JNLE_RELBRd relbr => relbr.encodingFits
  | .JNL_RELBRb relbr => relbr.encodingFits
  | .JNL_RELBRd relbr => relbr.encodingFits
  | .JNO_RELBRb relbr => relbr.encodingFits
  | .JNO_RELBRd relbr => relbr.encodingFits
  | .JNP_RELBRb relbr => relbr.encodingFits
  | .JNP_RELBRd relbr => relbr.encodingFits
  | .JNS_RELBRb relbr => relbr.encodingFits
  | .JNS_RELBRd relbr => relbr.encodingFits
  | .JNZ_RELBRb relbr => relbr.encodingFits
  | .JNZ_RELBRd relbr => relbr.encodingFits
  | .JO_RELBRb relbr => relbr.encodingFits
  | .JO_RELBRd relbr => relbr.encodingFits
  | .JP_RELBRb relbr => relbr.encodingFits
  | .JP_RELBRd relbr => relbr.encodingFits
  | .JRCXZ_RELBRb relbr => relbr.encodingFits
  | .JS_RELBRb relbr => relbr.encodingFits
  | .JS_RELBRd relbr => relbr.encodingFits
  | .JZ_RELBRb relbr => relbr.encodingFits
  | .JZ_RELBRd relbr => relbr.encodingFits

end X86.Syntax
