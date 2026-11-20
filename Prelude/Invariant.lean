import Prelude.Execution.Environment
import Prelude.Memory.Mapping

namespace Prelude

open X86

/-- Supported execution environment for 64-bit x86 programs with integer and SSE instructions -/
structure SupportedIntegerMachineState (processor : Machine.Processor) (s : Machine.RamState) : Prop where
  integer : SupportedIntegerCPU processor s
  sse : SupportedSSE processor s
  memory : IdentityMappedMemory s
  ready : ExecutionReady s

end Prelude
