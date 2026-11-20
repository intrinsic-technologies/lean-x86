-- Generated from a local ISA specification; do not edit.
-- Source SHA256: 4887b1d4efb685d7a58be135610fd01ef39904e70af81ef517608c49947779ae
import X86.Runtime
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86

structure CPUID_Feature where
  leaf : Bits 32
  subleaf : Bits 32
  register : Bits 2
  bit : Bits 5
  deriving Repr, DecidableEq, Inhabited

-- The caller supplies a binding for this source declaration, which has no body.
class Get_CPUID_Value.Binding (σ : Type) where
  call (eax ecx : Bits 32) :
    Runtime.SpecM Empty (State σ) ((Bits 32 × Bits 32 × Bits 32 × Bits 32))

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Get_CPUID_Value.Binding

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]

def Get_CPUID_Value
    (eax ecx : Bits 32) :
    Runtime.SpecM Empty (State σ) (Bits 32 × Bits 32 × Bits 32 × Bits 32) := do
  Get_CPUID_Value.Binding.call eax ecx

def CPUID_MTRR_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 12 } : CPUID_Feature)

def CPUID_PAT_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 16 } : CPUID_Feature)

def CPUID_LAM_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 1, register := 0, bit := 26 } : CPUID_Feature)

def CPUID_LA57_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 2, bit := 16 } : CPUID_Feature)

def CPUID_LZCNT_Encoding : CPUID_Feature := ({ leaf := 2147483649, subleaf := 0, register := 2, bit := 5 } : CPUID_Feature)

def CPUID_CMPXCHG16B_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 2, bit := 13 } : CPUID_Feature)

def CPUID_CLFLUSH_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 19 } : CPUID_Feature)

def CPUID_APX_F_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 1, register := 3, bit := 21 } : CPUID_Feature)

def CPUID_PTTT_Encoding : CPUID_Feature := ({ leaf := 20, subleaf := 0, register := 1, bit := 9 } : CPUID_Feature)

def CPUID_CET_SS_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 2, bit := 7 } : CPUID_Feature)

def CPUID_CET_IBT_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 3, bit := 20 } : CPUID_Feature)

def CPUID_DE_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 2 } : CPUID_Feature)

def CPUID_FRED_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 1, register := 0, bit := 17 } : CPUID_Feature)

def CPUID_FSGSBASE_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 1, bit := 0 } : CPUID_Feature)

def CPUID_FXSR_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 24 } : CPUID_Feature)

def CPUID_KEY_LOCKER_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 2, bit := 23 } : CPUID_Feature)

def CPUID_MCE_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 7 } : CPUID_Feature)

def CPUID_PAE_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 6 } : CPUID_Feature)

def CPUID_PCID_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 2, bit := 17 } : CPUID_Feature)

def CPUID_PGE_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 13 } : CPUID_Feature)

def CPUID_PKS_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 2, bit := 31 } : CPUID_Feature)

def CPUID_PKU_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 2, bit := 3 } : CPUID_Feature)

def CPUID_PSE_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 3 } : CPUID_Feature)

def CPUID_RTM_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 1, bit := 11 } : CPUID_Feature)

def CPUID_SMAP_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 1, bit := 20 } : CPUID_Feature)

def CPUID_SMEP_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 1, bit := 7 } : CPUID_Feature)

def CPUID_SMX_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 2, bit := 6 } : CPUID_Feature)

def CPUID_SSE_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 25 } : CPUID_Feature)

def CPUID_SSE2_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 26 } : CPUID_Feature)

def CPUID_MMX_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 23 } : CPUID_Feature)

def CPUID_TRIGGER_DR_MATCH_Encoding : CPUID_Feature := ({ leaf := 20, subleaf := 1, register := 2, bit := 15 } : CPUID_Feature)

def CPUID_TSC_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 4 } : CPUID_Feature)

def CPUID_UINTR_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 3, bit := 5 } : CPUID_Feature)

def CPUID_UMIP_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 2, bit := 2 } : CPUID_Feature)

def CPUID_VME_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 3, bit := 1 } : CPUID_Feature)

def CPUID_VMX_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 2, bit := 5 } : CPUID_Feature)

def CPUID_XSAVE_Encoding : CPUID_Feature := ({ leaf := 1, subleaf := 0, register := 2, bit := 26 } : CPUID_Feature)

def CPUID_FDP_EXCPTN_ONLY_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 1, bit := 6 } : CPUID_Feature)

def CPUID_FCS_FDS_DEPRECATION_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 1, bit := 13 } : CPUID_Feature)

def CPUID_INVD_DISABLE_POST_BIOS_DONE_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 1, register := 0, bit := 30 } : CPUID_Feature)

def CPUID_MSR_IMM_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 1, register := 2, bit := 5 } : CPUID_Feature)

def CPUID_BUS_LOCK_DETECT_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 0, register := 2, bit := 24 } : CPUID_Feature)

def CPUID_LASS_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 1, register := 0, bit := 6 } : CPUID_Feature)

def CPUID_UC_LOCK_DISABLE_Encoding : CPUID_Feature := ({ leaf := 7, subleaf := 2, register := 3, bit := 6 } : CPUID_Feature)

-- Internal queries use the same caller-supplied report as CPUID, without its
-- IA32_MISC_ENABLE hiding policy. Unsupported leaf fallback is not a feature word.
def CPUID_Leaf_Available (leaf subleaf : Bits 32) : Runtime.SpecM Empty (State σ) (Bool) := do
  let (maximum, _, _, _) ← Get_CPUID_Value (if (← leaf[31 +: 1]) == 0 then 0 else 2147483648) 0
  if (decide (Unsigned leaf > Unsigned maximum)) then
    return false
  if (leaf == 7) then
    let (last_subleaf, _, _, _) ← Get_CPUID_Value leaf 0
    return decide (Unsigned subleaf ≤ Unsigned last_subleaf)
  else
    if (leaf == 20) then
      let (_, features, _, _) ← Get_CPUID_Value 7 0
      if ((← features[25 +: 1]) == 0) then
        return false
      let (last_subleaf, _, _, _) ← Get_CPUID_Value leaf 0
      return decide (Unsigned subleaf ≤ Unsigned last_subleaf)
    else
      return true

def Decode_CPUID_Feature
    (feature : CPUID_Feature) (eax ebx ecx edx : Bits 32) :
    Except (Runtime.Error Empty) (Bool) := do
  let reported : Bits 32 := if feature.register == 0 then eax else if feature.register == 1 then ebx else if feature.register == 2 then ecx else edx
  return (← reported[Unsigned feature.bit +: 1]) == 1

def Read_CPUID_Feature (feature : CPUID_Feature) : Runtime.SpecM Empty (State σ) (Bool) := do
  if (not (← CPUID_Leaf_Available feature.leaf feature.subleaf)) then
    return false
  let (eax, ebx, ecx, edx) ← Get_CPUID_Value feature.leaf feature.subleaf
  return (← Decode_CPUID_Feature feature eax ebx ecx edx)

def CPUID_MTRR  : Runtime.SpecM Empty (State σ) (Bool) := do
  return (← Read_CPUID_Feature CPUID_MTRR_Encoding)

def CPUID_PAT  : Runtime.SpecM Empty (State σ) (Bool) := do
  return (← Read_CPUID_Feature CPUID_PAT_Encoding)

def CPUID_LAM  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_LAM_Encoding))

def CPUID_LA57  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_LA57_Encoding))

def CPUID_LZCNT  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_LZCNT_Encoding))

-- Decoder capability from the CMPXCHG16B page's CPUID group; absent from helpers.xml.
def CPUID_CMPXCHG16B  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_CMPXCHG16B_Encoding))

-- SDM093 CLFLUSH 3-144–145: independent CLFSH input, checked by the source form.
def CPUID_CLFLUSH  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_CLFLUSH_Encoding))

def CPUID_APX_F  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_APX_F_Encoding))

def CPUID_PTTT  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_PTTT_Encoding))

-- CPUID feature inputs read by the source control/debug-register checks.
def CPUID_CET_SS  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_CET_SS_Encoding))

def CPUID_CET_IBT  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_CET_IBT_Encoding))

def CPUID_DE  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_DE_Encoding))

def CPUID_FRED  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_FRED_Encoding))

def CPUID_FSGSBASE  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_FSGSBASE_Encoding))

def CPUID_FXSR  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_FXSR_Encoding))

def CPUID_KEY_LOCKER  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_KEY_LOCKER_Encoding))

def CPUID_MCE  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_MCE_Encoding))

def CPUID_PAE  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_PAE_Encoding))

def CPUID_PCID  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_PCID_Encoding))

def CPUID_PGE  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_PGE_Encoding))

def CPUID_PKS  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_PKS_Encoding))

def CPUID_PKU  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_PKU_Encoding))

def CPUID_PSE  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_PSE_Encoding))

def CPUID_RTM  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_RTM_Encoding))

def CPUID_SMAP  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_SMAP_Encoding))

def CPUID_SMEP  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_SMEP_Encoding))

def CPUID_SMX  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_SMX_Encoding))

def CPUID_SSE  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_SSE_Encoding))

-- SSE2 is an XML encoding capability; its state declaration is omitted.
def CPUID_SSE2  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_SSE2_Encoding))

-- MMX exception checks name a capability whose state declaration is omitted.
def CPUID_MMX  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_MMX_Encoding))

def CPUID_TRIGGER_DR_MATCH  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_TRIGGER_DR_MATCH_Encoding))

def CPUID_TSC  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_TSC_Encoding))

def CPUID_UINTR  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_UINTR_Encoding))

def CPUID_UMIP  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_UMIP_Encoding))

def CPUID_VME  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_VME_Encoding))

def CPUID_VMX  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_VMX_Encoding))

def CPUID_XSAVE  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_XSAVE_Encoding))

-- XML references this processor feature without declaring it.
def CPUID_FDP_EXCPTN_ONLY  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_FDP_EXCPTN_ONLY_Encoding))

-- Store_Environment reads this processor feature, whose declaration XML omits.
def CPUID_FCS_FDS_DEPRECATION  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_FCS_FDS_DEPRECATION_Encoding))

def CPUID_INVD_DISABLE_POST_BIOS_DONE  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_INVD_DISABLE_POST_BIOS_DONE_Encoding))

-- Present in the RDMSR source page; not enabled by the baseline decoder profile.
def CPUID_MSR_IMM  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_MSR_IMM_Encoding))

-- Public helper XML omits the remaining declarations. These expose inputs
-- consumed by its memory and CET helpers, not architectural reset values.
def CPUID_BUS_LOCK_DETECT  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_BUS_LOCK_DETECT_Encoding))

def CPUID_LASS  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_LASS_Encoding))

def CPUID_UC_LOCK_DISABLE  : Runtime.SpecM Exception (State σ) (Bool) := do
  return (← Runtime.liftNoSourceException (Read_CPUID_Feature CPUID_UC_LOCK_DISABLE_Encoding))

-- Initialize address-width configuration from CPUID (SDM 093 Vol. 3A 5.1.4).
-- This v1 model does not enable TME or SEAM.
def CPUID_Physical_Address_Width  : Runtime.SpecM Exception (State σ) (Int) := do
  if (not (← Runtime.liftNoSourceException (CPUID_Leaf_Available 2147483656 0))) then
    if (← CPUID_PAE) then
      return 36
    else
      return 32
  let (reported, _, _, _) ← Runtime.liftNoSourceException (Get_CPUID_Value 2147483656 0)
  let width : Int := Unsigned (← reported[7:0])
  -- This v1 memory-type model admits at most 52 physical-address bits.
  Runtime.assert (decide (width ≤ 52))
  return width

def CPUID_Linear_Address_Width  : Runtime.SpecM Exception (State σ) (Int) := do
  if (not (← Runtime.liftNoSourceException (CPUID_Leaf_Available 2147483656 0))) then
    return 32
  let (reported, _, _, _) ← Runtime.liftNoSourceException (Get_CPUID_Value 2147483656 0)
  return Unsigned (← reported[15:8])

-- CPUID.1:EBX[15:8] is valid only when EDX.CLFSH is set. Without CLFSH,
-- cache geometry is an explicit caller input for this processor.
def CPUID_Cache_Line_Size (without_clflush : Int) : Runtime.SpecM Exception (State σ) (Int) := do
  Runtime.assert (← Runtime.liftNoSourceException (CPUID_Leaf_Available 1 0))
  let (_, reported, _, features) ← Runtime.liftNoSourceException (Get_CPUID_Value 1 0)
  if ((← features[19 +: 1]) == 0) then
    Runtime.assert ((without_clflush in {(1 : Int)..(2048 : Int)}))
    return without_clflush
  let bytes : Int := 8 * Unsigned (← reported[15:8])
  Runtime.assert (decide (bytes > 0))
  return bytes

end X86
