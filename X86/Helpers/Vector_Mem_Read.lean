-- Generated from data/definitions.xml.gz: Vector_Mem_Read; do not edit.
-- Source SHA256: b067c12063108f99a7fa9299e57fcb9ee72f5a92985b257ccf3c7e732f9cedfb
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Vector_Mem_Read)
import X86.Runtime
import X86.BitWidth
import X86.Helpers.Logical_Mem_Read
import X86.Helpers.Memory_Access_Type
import X86.Helpers.Memory_Alignment_Type
import X86.Helpers.Segment
import X86.Helpers.Std.Bits.Repeat
import X86.Helpers.Std.Integer.Positive_Divide
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

-- Retain checked width facts for dependent casts; their proofs are erased.
def Vector_Mem_Read
    (size element_size : Int) (is_broadcast : Bool) (ea_segment : Segment) (effective_address : Bits 64) :
    Runtime.SpecM Exception (State σ) (Bits size) := do
  Runtime.assert (0 ≤ size)

  let ⟨size_domain⟩ ← Runtime.assertWithProof ((size == (128 : Int)) || (size == (256 : Int)) || (size == (512 : Int)))
  let ⟨element_size_domain⟩ ← Runtime.assertWithProof ((element_size == (8 : Int)) || (element_size == (16 : Int)) || (element_size == (32 : Int)) || (element_size == (64 : Int)))

  let ⟨elements, elements_result⟩ ← liftM (Runtime.remember (Std.Integer.Positive_Divide size element_size : Except (Runtime.Error Exception) Int))
  have elements_value := Runtime.positiveDivide_eq_of_ok elements_result
  have width_eq : Int.toNat (element_size * elements) = Int.toNat size := by
    simp_all only [Bool.or_eq_true, beq_iff_eq, or_assoc] <;>
      first
      | omega
      | rcases element_size_domain with rfl | rfl | rfl | rfl <;> omega
  return (← (do if is_broadcast then pure (BitVec.cast width_eq (← Std.Bits.Repeat (m := element_size) (← Logical_Mem_Read ea_segment effective_address element_size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false) elements)) else pure (← Logical_Mem_Read ea_segment effective_address size Memory_Access_Type.Memory_Read Memory_Alignment_Type.Normal_Alignment false)))

end X86.Helpers
