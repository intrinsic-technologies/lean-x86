set_option autoImplicit false

namespace X86.Machine.MemoryType

/-- Constant MTRR capabilities and the protected SMRR read response. The local MSR owner
supports at most ten variable pairs and the original, ungated SMRR interface. -/
class Config where
  mtrrCap : BitVec 64 := 0x508
  smrrByte : BitVec 64 → UInt8

@[instance_reducible]
def Config.default : Config := {smrrByte := fun _ => 0}

instance (priority := low) : Config := Config.default

end X86.Machine.MemoryType
