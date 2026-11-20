-- Generated from data/definitions.xml.gz: Is_CR4_Value_Valid; do not edit.
-- Source SHA256: 75784787a66f8deeedcb26624745ff7642835474ea56bfc0e06d17aa05e94de3
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_CR4_Value_Valid)
import X86.Runtime
import X86.Cpuid
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]

def Is_CR4_Value_Valid (new_cr4 : CR4_Type) : Runtime.SpecM Exception (State σ) (Bool) := do
  if (not (← CPUID_VME) and (CR4_Type.VME new_cr4 == 1 or CR4_Type.PVI new_cr4 == 1) or not (← CPUID_TSC) and CR4_Type.TSD new_cr4 == 1 or not (← CPUID_DE) and CR4_Type.DE new_cr4 == 1 or not (← CPUID_PSE) and CR4_Type.PSE new_cr4 == 1 or not (← CPUID_PAE) and CR4_Type.PAE new_cr4 == 1 or not (← CPUID_MCE) and CR4_Type.MCE new_cr4 == 1 or not (← CPUID_PGE) and CR4_Type.PGE new_cr4 == 1 or not (← CPUID_FXSR) and CR4_Type.OSFXSR new_cr4 == 1 or not (← CPUID_SSE) and CR4_Type.OSXMMEXCPT new_cr4 == 1 or not (← CPUID_UMIP) and CR4_Type.UMIP new_cr4 == 1 or not (← CPUID_LA57) and CR4_Type.LA57 new_cr4 == 1 or not (← CPUID_VMX) and CR4_Type.VMXE new_cr4 == 1 or not (← CPUID_SMX) and CR4_Type.SMXE new_cr4 == 1 or not (← CPUID_FSGSBASE) and CR4_Type.FSGSBASE new_cr4 == 1 or not (← CPUID_PCID) and CR4_Type.PCIDE new_cr4 == 1 or not (← CPUID_XSAVE) and CR4_Type.OSXSAVE new_cr4 == 1 or not (← CPUID_KEY_LOCKER) and CR4_Type.KL new_cr4 == 1 or not (← CPUID_SMEP) and CR4_Type.SMEP new_cr4 == 1 or not (← CPUID_SMAP) and CR4_Type.SMAP new_cr4 == 1 or not (← CPUID_PKU) and CR4_Type.PKE new_cr4 == 1 or not ((← CPUID_CET_SS) or (← CPUID_CET_IBT)) and CR4_Type.CET new_cr4 == 1 or not (← CPUID_PKS) and CR4_Type.PKS new_cr4 == 1 or not (← CPUID_UINTR) and CR4_Type.UINTR new_cr4 == 1 or not (← CPUID_LASS) and CR4_Type.LASS new_cr4 == 1 or not (← CPUID_LAM) and CR4_Type.LAM_SUP new_cr4 == 1 or not (← CPUID_FRED) and CR4_Type.FRED new_cr4 == 1) then
    return false

  return true

end X86.Helpers
