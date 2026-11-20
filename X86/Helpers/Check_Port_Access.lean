-- Generated from a local ISA specification; do not edit.
-- Source SHA256: c3f935fd0c6cb2430c39d16fee118e339d55e2b07194221918bd3ed68c2a71a4
import X86.Runtime
import X86.Helpers.Check_IO_Breakpoint
import X86.Helpers.Check_IO_Permissions
import X86.Helpers.Std.Integer.Positive_Divide
import X86.Helpers.VMX.Check_IO_Bitmap
import X86.Helpers.VMX_Basic_Exit_Reasons
import X86.Helpers.VMX_Operation_Type
import X86.Helpers.VM_Exit
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

variable {σ : Type}

variable
  [X86.Address_Of_IO_Bitmap_A.Binding σ]
  [X86.Address_Of_IO_Bitmap_B.Binding σ]
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.Physical_Mem_Read.Binding σ]
  [X86.Helpers.Translate_Linear_To_Physical.Semantics σ]
  [X86.Helpers.Unimplemented_Feature.Binding σ]
  [X86.Helpers.VM_Exit.Binding σ]
  [X86.VM_Exec_Controls1.Binding σ]
  [X86.Config.Value.Cache_Line_Size]
  [X86.Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment]

-- Shared scalar-port checks from Intel SDM IN/OUT and VMX I/O interception.
-- Device reads and writes remain caller-supplied IO_Read/IO_Write operations.
def Check_Port_Access
    (port : Bits 32) (width : Int) :
    Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (width == 8 || width == 16 || width == 32)

  Check_IO_Permissions port (← Std.Integer.Positive_Divide width 8)
  if ((← get).VMX_Operation_Mode == VMX_Operation_Type.VMX_Non_Root) then
    if ((← VM_Exec_Controls1).Use_IO_Bitmaps == 1) then
      VMX.Check_IO_Bitmap port (← Std.Integer.Positive_Divide width 8)
    else
      if ((← VM_Exec_Controls1).Unconditional_IO_Exiting == 1) then
        VM_Exit VMX_EXIT_IO_INSTRUCTION
  Check_IO_Breakpoint port (← Std.Integer.Positive_Divide width 8)

end X86.Helpers
