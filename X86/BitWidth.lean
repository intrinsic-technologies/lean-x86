import X86.Helpers.Std.Bits.Is_Zero

open X86.Runtime X86.Helpers

-- Generated masked-memory helpers use this fact for positive-width operations.
-- It depends on translated Is_Zero, so it cannot belong to the language runtime.
namespace X86.BitWidth

/-- A successful nonzero source test excludes an empty bit vector. -/
theorem source_is_zero_false_pos {size : Int} (x : Bits size)
    (result : Std.Bits.Is_Zero x = .ok false) : 0 < size := by
  by_cases positive : 0 < size
  · exact positive
  have invalid : ¬ 0 < size := positive
  have width : size.toNat = 0 := by omega
  have zero : x = 0 := by
    apply BitVec.eq_of_toNat_eq
    have bound := x.isLt
    simp only [width] at bound
    simp_all
  simp only [Std.Bits.Is_Zero, X86.Runtime.assert] at result
  split at result
  · simp [Std.Bits.Zero, X86.Runtime.zeroBits, X86.Runtime.assert, *] at result
    cases result
  · cases result

end X86.BitWidth
