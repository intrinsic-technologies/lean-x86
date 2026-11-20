-- Generated from data/definitions.xml.gz: Translate_Linear_To_Physical; do not edit.
-- Source SHA256: 83fb87c7df6eb96b55b3c511495caeec3c2d952e5341f9e618d9c65ee5bb7075
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Translate_Linear_To_Physical)
import X86.Runtime
import X86.Helpers.Address_Translation
import X86.Helpers.EPT.Translate
import X86.Helpers.Get_Memory_Type
import X86.Helpers.Is_EPT_Enabled
import X86.Helpers.Is_Linear_Access_Split_Across4KB_Pages
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Paging_Level_Type
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Integer.Positive_Remainder
import X86.Helpers.Translate
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

-- Optional typed boundary; the source implementation is retained below.
class Translate_Linear_To_Physical.Semantics (σ : Type) where
  call (linear : Address_Translation) (access_type : Memory_Access_Type) :
    Runtime.SpecM Exception (State σ) (Address_Translation)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] Translate_Linear_To_Physical.Semantics

variable {σ : Type}

variable
  [X86.EPTP_Index.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.HLAT_PLR_Prefix_Size.Binding σ]
  [X86.Helpers.EPT.Get_Exit_Qualification.Binding σ]
  [X86.Helpers.Get_Cache_Disabled_Memory_Type.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Physical_Mem_Read_EPT.Binding σ]
  [X86.Helpers.Physical_Mem_Read_PTW.Binding σ]
  [X86.Helpers.Physical_Mem_Write.Binding σ]
  [X86.Helpers.Physical_Mem_Write_PTW.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.IA32_MTRRCAP.Binding σ]
  [X86.VM_Exec_Controls2.Binding σ]
  [X86.VM_Exec_Controls3.Binding σ]
  [X86.Virtualization_Exception_Information_Address.Binding σ]
  [X86.__Implements_Processor_Type.Binding]
  [X86.Config.Value.Max_Physical_Address]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_Early_Page_Access_Bit_Update]

def Translate_Linear_To_Physical
    (linear : Address_Translation) (access_type : Memory_Access_Type) :
    Runtime.SpecM Exception (State σ) (Address_Translation) := do

  let mut physical : Address_Translation := linear

  if ((← CR0.PG) == 0) then
    physical := { physical with is_split_access := false }
    physical := { physical with translation1 := { physical.translation1 with physical_address := linear.linear_address } }

    if (← Is_EPT_Enabled) then
      physical := { physical with translation1 := (← EPT.Translate physical.translation1 access_type false Paging_Level_Type.Paging_Level_Unknown) }

    physical := { physical with translation1 := { physical.translation1 with page_pat_pcd_pwt := (0 : Bits 3) } }
    physical := { physical with translation1 := { physical.translation1 with memory_type := (← Runtime.liftNoSourceException (Get_Memory_Type physical.translation1.physical_address 0)) } }
  else
    -- Paging can be enabled only if protection is enabled (CR0.PE := 1)
    Runtime.assert ((← CR0.PE) == 1)

    if (← Is_Linear_Access_Split_Across4KB_Pages linear.linear_address linear.num_bytes) then
      let Page_Size_4KB : Int := 4096
      let size1 : Int := Page_Size_4KB - (← Std.Integer.Positive_Remainder (Unsigned linear.linear_address) Page_Size_4KB)
      let size2 : Int := linear.num_bytes - size1

      let address1 : Bits 64 := linear.linear_address
      let address2 : Bits 64 ← Std.Bits.Add_int (n := 64) address1 size1

      let first : Address_Translation := { { linear with linear_address := address1 } with num_bytes := size1 }
      let second : Address_Translation := { { linear with linear_address := address2 } with num_bytes := size2 }

      physical := { physical with is_split_access := true }
      physical := { physical with translation1 := (← Translate first access_type) }
      physical := { physical with translation2 := (← Translate second access_type) }
    else
      physical := { physical with is_split_access := false }
      physical := { physical with translation1 := (← Translate linear access_type) }
  return physical

def Translate_Linear_To_Physical.interpreted
    (linear : Address_Translation) (access_type : Memory_Access_Type) :
    Runtime.SpecM Exception (State σ) (Address_Translation) := do
  Translate_Linear_To_Physical.Semantics.call linear access_type

@[instance_reducible]
def Translate_Linear_To_Physical.defaultSemantics : Translate_Linear_To_Physical.Semantics σ := ⟨Translate_Linear_To_Physical⟩

end X86.Helpers
