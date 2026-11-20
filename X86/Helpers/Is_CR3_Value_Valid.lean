-- Generated from data/definitions.xml.gz: Is_CR3_Value_Valid; do not edit.
-- Source SHA256: 4f3d345e0da5163a019a6aab3ec6c9071a017be7b0a2275163e5ba9a695c0a6f
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Is_CR3_Value_Valid)
import X86.Runtime
import X86.Cpuid
import X86.Helpers.Std.Bits.Is_Zero
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Config.Value.Max_Physical_Address]

def Is_CR3_Value_Valid (new_cr3 : CR3_Type) : Runtime.SpecM Exception (State σ) (Bool) := do
  -- LAM allows LAM_U57 (bit 61) and LAM_U48 (bit 62) to be set
  return (← (do if (← CPUID_LAM) then pure ((← (do
    let Config__Max_Physical_Address_1 ← Config.Read.Max_Physical_Address (exception := Exception)
    return (← Std.Bits.Is_Zero (size := ((61 : Int) + (- Config__Max_Physical_Address_1))) (← (do Runtime.assert (decide (Config__Max_Physical_Address_1 ≤ 61)); pure (BitVec.cast (by omega) (← new_cr3[60:Config__Max_Physical_Address_1]) : Bits ((61 : Int) + (- Config__Max_Physical_Address_1)))))))) and (← new_cr3[63 +: 1]) == 0) else pure (← (do
    let Config__Max_Physical_Address ← Config.Read.Max_Physical_Address (exception := Exception)
    return (← Std.Bits.Is_Zero (size := ((64 : Int) + (- Config__Max_Physical_Address))) (← (do Runtime.assert (decide (Config__Max_Physical_Address ≤ 64)); pure (BitVec.cast (by omega) (← new_cr3[63:Config__Max_Physical_Address]) : Bits ((64 : Int) + (- Config__Max_Physical_Address))))))))))

end X86.Helpers
