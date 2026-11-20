-- Generated from data/definitions.xml.gz: Code_Segment_Checks; do not edit.
-- Source SHA256: 14c4f9eb8cb04f6c65086f989079bedd6a191816fd61795bb103e29dc2f30334
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Code_Segment_Checks)
import X86.Runtime
import X86.Helpers.Get_Error_Code_From_Selector
import X86.Helpers.Is_Code_Segment
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Segment_Not_Present
import X86.Helpers.Segment
import X86.Helpers.Segment_Descriptor
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

def Code_Segment_Checks (new_cs : Segment) : Runtime.SpecM Exception (State σ) Unit := do
  if (not (← Is_Code_Segment new_cs) or (← get).IA32_EFER.LMA == 1 and (← Segment_Descriptor.L.partial new_cs.descriptor) == 1 and (← Segment_Descriptor.D.partial new_cs.descriptor) == 1 or (← CR4.FRED) == 1 and (← get).CPL == 0 and (← Segment_Descriptor.L.partial new_cs.descriptor) == 0 and (← Segment_Descriptor.L.partial (← get).CS.descriptor) == 1) then
    liftM (Report_General_Protection_Exception (← Get_Error_Code_From_Selector new_cs.selector))

  if ((← Segment_Descriptor.P.partial new_cs.descriptor) == 0) then
    liftM (Report_Segment_Not_Present (← Get_Error_Code_From_Selector new_cs.selector))

end X86.Helpers
