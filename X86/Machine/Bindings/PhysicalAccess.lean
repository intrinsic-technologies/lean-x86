import X86.Machine.Bindings.MemoryType
import X86.Machine.Bindings.Vmx
import X86.Helpers.Physical_Mem_Read
import X86.Helpers.Physical_Mem_Write
import X86.Helpers.Physical_Mem_Read_PTW
import X86.Helpers.Physical_Mem_Write_PTW
import X86.Helpers.Is_EPT_Enabled
import X86.Helpers.Get_Memory_Type

namespace X86.Machine.Bindings.PhysicalAccess

open X86.Runtime X86.Helpers

variable {σ : Type}

/--
Physical RAM is explicitly allocated. Missing bytes are external failures,
not architectural page faults; Intel's page walker produces those separately.
-/
def readPhysicalByte [MemoryType.Config] [PhysicalMemory σ] {exception : Type} (address : BitVec 64) :
    X86.Runtime.SpecM exception (X86.State σ) UInt8 := do
  let state ← get
  if ← Bindings.MemoryType.smrrBlocked state address then
    return MemoryType.Config.smrrByte address
  match PhysicalMemory.read state.external address with
  | some byte => pure byte
  | none => throw (.externalFailure s!"unmapped physical RAM at {address.toNat}")

/--
Instruction fetch uses the same allocated physical RAM as data accesses.
The generated Mem_Fetch helper owns translation and execute-permission checks.
-/
instance [MemoryType.Config] [PhysicalMemory σ] : X86.__Physical_Mem_Fetch.Binding σ where
  call address _ := return (← readPhysicalByte address).toBitVec

def writePhysicalByte [MemoryType.Config] [PhysicalMemory σ] {exception : Type} (address : BitVec 64) (byte : UInt8) :
    X86.Runtime.SpecM exception (X86.State σ) Unit := do
  let state ← get
  if ← Bindings.MemoryType.smrrBlocked state address then return ()
  if (PhysicalMemory.read state.external address).isNone then
    throw (.externalFailure s!"unmapped physical RAM at {address.toNat}")
  set { state with external := PhysicalMemory.write state.external address byte }

/-- Require a whole number of bytes before a physical access. -/
def byteCount {exception : Type} (size : Int) :
    X86.Runtime.SpecM exception (X86.State σ) Nat := do
  if size < 0 || size % 8 != 0 then
    throw (.externalFailure s!"invalid physical access size: {size}")
  pure (size / 8).toNat

/-- Assemble bytes from translated physical locations in little-endian order. -/
def readBytes [MemoryType.Config] [PhysicalMemory σ] {exception : Type} (size : Int) (address : Nat → BitVec 64) :
    X86.Runtime.SpecM exception (X86.State σ) (Bits size) := do
  let count ← byteCount size
  let mut result : Bits size := 0
  for index in [:count] do
    let byte ← readPhysicalByte (address index)
    result := result ||| (BitVec.ofNat size.toNat byte.toNat <<< (8 * index))
  pure result

/-- Store successive low bytes at translated physical locations. -/
def writeBytes [MemoryType.Config] [PhysicalMemory σ] {exception : Type} (size : Int) (address : Nat → BitVec 64)
    (value : Bits size) : X86.Runtime.SpecM exception (X86.State σ) Unit := do
  let count ← byteCount size
  for index in [:count] do
    writePhysicalByte (address index) (UInt8.ofNat (value.toNat >>> (8 * index)))

/--
Each translated fragment has its own physical base: adjacent virtual pages
need not map to adjacent physical pages.
-/
def physicalByteAddress (physical : Address_Translation) (index : Nat) : BitVec 64 :=
  if physical.is_split_access && index ≥ physical.translation1.size_in_bytes.toNat then
    BitVec.add physical.translation2.physical_address
      (BitVec.ofNat 64 (index - physical.translation1.size_in_bytes.toNat))
  else
    BitVec.add physical.translation1.physical_address (BitVec.ofNat 64 index)

/-- Validate the fragment boundary supplied by the generated translator. -/
def checkTranslation {exception : Type} (physical : Address_Translation) (size : Int) :
    X86.Runtime.SpecM exception (X86.State σ) Unit := do
  let count ← byteCount size
  let first := physical.translation1.size_in_bytes
  -- Create_Physical_Address deliberately leaves translation sizes at zero.
  -- Only split accesses use a fragment length to select a physical base.
  if physical.is_split_access && (first ≤ 0 || first ≥ Int.ofNat count) then
    throw (.externalFailure "invalid physical translation split")

instance [MemoryType.Config] [PhysicalMemory σ] : Physical_Mem_Read.Binding σ where
  call physical size := do
    checkTranslation physical size
    let value ← readBytes size (physicalByteAddress physical)
    X86.Runtime.traceEvent "isa.memory" "load"
    pure value

instance [MemoryType.Config] [PhysicalMemory σ] : Physical_Mem_Write.Binding σ where
  call physical size value := do
    checkTranslation physical size
    writeBytes size (physicalByteAddress physical) value
    X86.Runtime.traceEvent "isa.memory" "store"

/-- Read a calculated page-table entry, or its physical RAM bytes when no entry is supplied. -/
def readPageTableEntry [MemoryType.Config] [PhysicalMemory σ] {exception : Type}
    (address : BitVec 64) (size : Int) : SpecM exception (State σ) (Bits size) := do
  match PhysicalMemory.entry (← get).external address with
  | none => readBytes size (fun index => BitVec.add address (BitVec.ofNat 64 index))
  | some entry =>
      if h : size = 64 then pure (BitVec.cast (by simp [h]) entry)
      else throw (.externalFailure s!"computed page-table read of {size} bits")

/--
Page-walk reads. The binding returns a calculated entry as one value. A calculated entry is not
in RAM, so SMRR does not apply. At other physical addresses the walk reads RAM, where a profile or a test
can put its own tables.

This binding has no nested translation. Reject that path before treating a guest physical
address as a host physical address.
-/
instance [MemoryType.Config] [PhysicalMemory σ] [X86.VM_Exec_Controls2.Binding σ] : Physical_Mem_Read_PTW.Binding σ where
  call _ address size _ _ := do
    if ← Is_EPT_Enabled then
      -- Nested paging is EPT, so `Vmx` reports the rejection.
      Vmx.unsupported "Physical_Mem_Read_PTW with nested paging"
    readPageTableEntry address size

/-- The accessed and dirty bits in the low byte of a page-table entry. -/
private def accessedDirty : UInt8 := 0x60

/--
Page-walk writes. The walk writes the low byte of an entry to set its accessed or dirty bit. A
calculated entry accepts only these two bits. Another change is an external failure. At other
physical addresses the byte goes to RAM.
-/
instance [MemoryType.Config] [PhysicalMemory σ] : Physical_Mem_Write_PTW.Binding σ where
  call address _ _ value := do
    let state ← get
    let lowByte := UInt8.ofNat value.toNat
    match PhysicalMemory.entry state.external address with
    | none => writePhysicalByte address lowByte
    | some entry =>
        let current := UInt8.ofNat entry.toNat
        if lowByte &&& current != current || lowByte &&& ~~~(current ||| accessedDirty) != 0 then
          throw (.externalFailure s!"unsupported write to computed page-table entry at {address.toNat}")
        set { state with external := PhysicalMemory.markEntry state.external address lowByte }

end X86.Machine.Bindings.PhysicalAccess
