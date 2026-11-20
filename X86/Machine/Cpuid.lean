import X86.Cpuid

namespace X86.Machine.Cpuid

/-- The four 32-bit outputs, in EAX, EBX, ECX, EDX order. -/
abbrev Registers := BitVec 32 × BitVec 32 × BitVec 32 × BitVec 32

/-- A caller query. Leaf and subleaf use the unsigned 32-bit CPUID domain.
The instruction adapter passes the live XCR0 and CR4.OSXSAVE values. The caller
must keep processor identity, capabilities, address widths and cache geometry
constant; live controls affect only the CPUID outputs specified to depend on them.
This contract is a caller obligation and is not enforced by the function type. -/
abbrev Query := BitVec 64 → Bool → Nat → Nat → Except String Registers

/-- Read the dynamic inputs shared by the instruction and internal capability queries. -/
def queryAtState {σ : Type} (query : Query) (state : X86.State σ)
    (leaf subleaf : Nat) : Except String Registers :=
  query state.XCR0 (state.CR4.getLsbD 18) leaf subleaf

structure Entry where
  leaf : Nat
  subleaf : Nat
  value : Registers
  deriving Repr, Inhabited

/--
One extended-state component from SDM Vol. 1, section 13.2.
Components 0 and 1 use the fixed 512-byte legacy area plus the 64-byte header.
-/
structure Component where
  index : Nat
  size : Nat
  offset : Nat
  supervisor : Bool := false
  align64 : Bool := false
  xfd : Bool := false
  deriving Repr, Inhabited

structure Xsave where
  features : BitVec 32
  components : Array Component
  deriving Repr, Inhabited

/--
Explicit processor inputs. No values are read from the host processor.

The caller supplies ordinary query results and supported extended-state layouts.
Leaf 0xD sizes are calculated from these layouts and the machine's current XCR0.
Leaf 1 OSXSAVE reflects CR4.OSXSAVE; other ordinary outputs are explicit inputs.
`supervisorEnabled` supplies IA32_XSS, which the translated State does not contain.
A caller that changes IA32_XSS must also update this input.
-/
structure Config where
  maxBasic : Nat
  maxExtended : Nat
  vendor : BitVec 32 × BitVec 32 × BitVec 32 -- EBX, ECX, EDX order
  entries : Array Entry
  xsave : Option Xsave := none
  supervisorEnabled : BitVec 64 := 0
  deriving Repr, Inhabited

private def selected (mask : BitVec 64) (index : Nat) : Bool := mask.getLsbD index

private def mask (layout : Xsave) (supervisor : Bool) : BitVec 64 :=
  layout.components.foldl (fun bits component =>
    if component.supervisor == supervisor then bits ||| (1 <<< component.index) else bits)
    (if supervisor then 0 else 3)

/-- Reject inconsistent layouts instead of truncating sizes or choosing duplicate entries. -/
def Config.validate (config : Config) : Except String Unit := do
  unless config.maxBasic < 0x80000000 &&
      0x80000000 ≤ config.maxExtended && config.maxExtended < 2^32 do
    throw "invalid CPUID leaf limits"
  for i in [:config.entries.size] do
    let entry := config.entries[i]!
    unless entry.leaf < 2^32 && entry.subleaf < 2^32 &&
        entry.leaf != 0 && entry.leaf != 0x80000000 && entry.leaf != 0xd do
      throw "CPUID entry uses a reserved configuration key"
    if config.entries[:i].any (fun old => old.leaf == entry.leaf && old.subleaf == entry.subleaf) then
      throw "duplicate CPUID entry"
  if let some layout := config.xsave then
    unless config.maxBasic ≥ 0xd && layout.features.toNat < 32 do
      throw "invalid CPUID XSAVE feature configuration"
    unless !layout.features.getLsbD 3 || layout.features.getLsbD 1 do
      throw "XSAVES requires compacted XSAVE support"
    for i in [:layout.components.size] do
      let component := layout.components[i]!
      unless 2 ≤ component.index && component.index < 63 &&
          0 < component.size && component.size < 2^32 &&
          (component.supervisor || (576 ≤ component.offset && component.offset + component.size < 2^32)) do
        throw "invalid CPUID extended-state component"
      unless (!component.supervisor || component.offset == 0) &&
          (!component.xfd || (!component.supervisor && layout.features.getLsbD 4)) do
        throw "inconsistent CPUID component offset or XFD support"
      if layout.components[:i].any (fun old => !old.supervisor && !component.supervisor &&
          component.offset < old.offset + old.size && old.offset < component.offset + component.size) then
        throw "overlapping standard XSAVE components"
      if layout.components[:i].any (fun old => old.index == component.index) then
        throw "duplicate CPUID extended-state component"
    unless config.supervisorEnabled &&& ~~~(mask layout true) == 0 do
      throw "IA32_XSS enables an unsupported component"
    unless mask layout true == 0 || layout.features.getLsbD 3 do
      throw "supervisor components require XSAVES"
  else
    unless config.supervisorEnabled == 0 do throw "IA32_XSS requires XSAVE support"

private def standardSize (layout : Xsave) (enabled : BitVec 64) : Nat :=
  layout.components.foldl (fun size component =>
    if !component.supervisor && selected enabled component.index then
      max size (component.offset + component.size) else size) 576

private def compactedSize (layout : Xsave) (enabled : BitVec 64) : Nat :=
  (List.range 63).foldl (fun size index =>
    match layout.components.find? (fun component => component.index == index) with
    | some component =>
      if selected enabled index then
        (if component.align64 then (size + 63) / 64 * 64 else size) + component.size
      else size
    | none => size) 576

/-- SDM Vol. 1, section 13.2 and Vol. 2, CPUID leaf 0xD. -/
private def extendedState (config : Config) (xcr0 : BitVec 64) (subleaf : Nat) :
    Except String Registers := do
  let some layout := config.xsave | return (0, 0, 0, 0)
  let user := mask layout false
  let supervisor := mask layout true
  unless xcr0 &&& ~~~user == 0 do throw "XCR0 enables an unsupported component"
  if subleaf == 0 then
    return (BitVec.ofNat 32 user.toNat, BitVec.ofNat 32 (standardSize layout xcr0),
      BitVec.ofNat 32 (standardSize layout user), BitVec.ofNat 32 (user.toNat >>> 32))
  if subleaf == 1 then
    let size := if layout.features.getLsbD 3 then
        compactedSize layout (xcr0 ||| config.supervisorEnabled)
      else if layout.features.getLsbD 1 then compactedSize layout xcr0 else 0
    if size ≥ 2^32 then throw "compacted XSAVE area exceeds 32-bit CPUID size"
    return (layout.features, BitVec.ofNat 32 size, BitVec.ofNat 32 supervisor.toNat,
      BitVec.ofNat 32 (supervisor.toNat >>> 32))
  match layout.components.find? (fun component => component.index == subleaf) with
  | none => return (0, 0, 0, 0)
  | some component =>
    let flags := (if component.supervisor then 1 else 0) +
      (if component.align64 then 2 else 0) + (if component.xfd then 4 else 0)
    return (BitVec.ofNat 32 component.size,
      BitVec.ofNat 32 (if component.supervisor then 0 else component.offset),
      BitVec.ofNat 32 flags, 0)

/--
Answer an Intel CPUID query using explicit processor inputs.
Unsupported leaf numbers return the highest basic leaf.
An absent ordinary query is an error; the caller must supply even known zero results.

`@[inline]` lets the compiler evaluate `config.validate` once for a literal `config`, instead of
on every query.
-/
@[inline] def Config.toQuery (config : Config) : Query := fun xcr0 osxsave leaf subleaf => do
  config.validate
  let leaf := if (leaf < 0x80000000 && leaf > config.maxBasic) || leaf > config.maxExtended
    then config.maxBasic else leaf
  if leaf == 0 then return (BitVec.ofNat 32 config.maxBasic, config.vendor)
  if leaf == 0x80000000 then return (BitVec.ofNat 32 config.maxExtended, 0, 0, 0)
  if leaf == 0xd then return ← extendedState config xcr0 subleaf
  match config.entries.find? (fun entry => entry.leaf == leaf && entry.subleaf == subleaf) with
  | some entry =>
    if leaf == 1 then
      let (eax, ebx, ecx, edx) := entry.value
      let ecx := (ecx &&& ~~~((1 : BitVec 32) <<< 27)) |||
        (if osxsave && ecx.getLsbD 26 then 1 <<< 27 else 0)
      return (eax, ebx, ecx, edx)
    return entry.value
  | none => throw s!"CPUID query not configured: leaf={leaf}, subleaf={subleaf}"

end X86.Machine.Cpuid
