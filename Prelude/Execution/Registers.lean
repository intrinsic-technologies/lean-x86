import Prelude.Execution.Registers.CR0
import Prelude.Execution.Registers.CR4
import Prelude.Execution.Registers.DR7
import Prelude.Execution.Registers.EFER
import Prelude.Execution.Registers.RFLAGS

namespace Prelude

open X86

/-- CR0 configuration for executing 64-bit x86 integer instructions -/
structure SupportedIntegerCR0 (cr0 : CR0_Type) : Prop extends
    CR0.ProtectedModePaging cr0,
    CR0.WriteBackCaching cr0,
    CR0.AlignmentCheckingDisabled cr0

/-- CR4 configuration for executing 64-bit x86 integer instructions -/
structure SupportedIntegerCR4 (cr4 : CR4_Type) : Prop extends
    CR4.FourLevelPaging cr4,
    CR4.VirtualInterruptsDisabled cr4,
    CR4.SupervisorExecutionProtectionDisabled cr4,
    CR4.SupervisorAccessProtectionDisabled cr4,
    CR4.UserProtectionKeysDisabled cr4,
    CR4.ControlFlowEnforcementDisabled cr4

/-- EFER configuration for executing 64-bit x86 integer instructions -/
structure SupportedIntegerEFER (efer : EFER_Inputs) : Prop extends
    EFER.LongModeActive efer,
    EFER.ExecuteDisableDisabled efer

end Prelude
