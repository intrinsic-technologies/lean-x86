-- Generated from data/definitions.xml.gz: HLAT::Is_Address_Enabled; do not edit.
-- Source SHA256: 2225a8a14b547b94bef6585693cf29c9d2cde07c219cfa7d092b490c1c713181
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=HLAT%3A%3AIs_Address_Enabled)
import X86.Runtime
import X86.Helpers.Std.Bits.Is_All_Ones
import X86.Helpers.Std.Integer.Power2
import X86.Helpers.VMX_Operation_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.HLAT_PLR_Prefix_Size.Binding σ]
  [X86.VM_Exec_Controls3.Binding σ]

def HLAT.Is_Address_Enabled
    (linear_address : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bool) := do
  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root and (← VM_Exec_Controls3).Enable_HLAT == 1) then
    let mut hlat_prefix_size : Int := Unsigned (← HLAT_PLR_Prefix_Size (← get).Current_VMCS_Pointer)
    if (hlat_prefix_size == 0) then
      return true

    let plr_prefix_size : Int := Unsigned (← concatBits (leftSize := 5) (rightSize := 1) (← get).IA32_VMX_EPT_VPID_CAP.PLR_PREFIX_SIZE_5_1 (← get).IA32_VMX_EPT_VPID_CAP.PLR_PREFIX_SIZE_0)

    if (decide (hlat_prefix_size > plr_prefix_size)) then
      hlat_prefix_size := plr_prefix_size

    return (← Std.Bits.Is_All_Ones (size := hlat_prefix_size) (← (do Runtime.assert (decide (64 - hlat_prefix_size ≤ 64)); pure (BitVec.cast (by omega) (← linear_address[63:64 - hlat_prefix_size]) : Bits hlat_prefix_size))))

  return false

end X86.Helpers
