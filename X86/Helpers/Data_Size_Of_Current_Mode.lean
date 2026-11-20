-- Generated from data/definitions.xml.gz: Data_Size_Of_Current_Mode; do not edit.
-- Source SHA256: f15f600a837d79341baa24036f663b42e0ca28b3d4f1da4b60938841d0bb24fd
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Data_Size_Of_Current_Mode)
import X86.Runtime
import X86.Helpers.Is_64Bit_Code_Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Data_Size_Of_Current_Mode  : Runtime.SpecM Exception (State σ) (Int) := do
  return (← (do if (← Is_64Bit_Code_Segment (← get).CS) then pure 64 else pure (if (← Segment_Descriptor.D.partial (← get).CS.descriptor) == 1 then 32 else 16)))

end X86.Helpers
