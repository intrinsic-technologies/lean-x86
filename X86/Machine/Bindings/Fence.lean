import X86.Helpers.Memory_Load_Fence
import X86.Helpers.Memory_Store_Fence
import X86.Helpers.Memory_Fence

namespace X86.Machine.Bindings.Fence

open X86.Helpers

variable {σ : Type}

-- These bodyless Intel primitives record fence events in this sequential machine.
-- They do not enforce memory ordering.
instance : Memory_Load_Fence.Binding σ where
  call := X86.Runtime.traceEvent "isa.memory" "lfence"

instance : Memory_Store_Fence.Binding σ where
  call := X86.Runtime.traceEvent "isa.memory" "sfence"

instance : Memory_Fence.Binding σ where
  call := X86.Runtime.traceEvent "isa.memory" "mfence"

end X86.Machine.Bindings.Fence
