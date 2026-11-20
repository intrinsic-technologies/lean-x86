import X86.State
import X86.Helpers.Select_FXSAVE_Fields

namespace X86.Machine.Bindings

/-- The actual layout and first linear address of a local FXSAVE execution. -/
structure Fxsave.Input where
  wide : Bool
  linearAddress : BitVec 64

/-- A pending real canonicality, LASS or alignment fault competing with page walks. -/
structure Fxsave.PageFaultPriorityInput extends Fxsave.Input where
  faultVector : Int

/-- The logical stack slot. Its mandatory payload uses the physical register selected by TOP. -/
structure Fxsave.SlotInput extends Fxsave.Input where
  slot : BitVec 3

structure Fxsave.WriteSwapInput extends Fxsave.Input where
  first : X86.Helpers.FXSAVE_Write_Request
  second : X86.Helpers.FXSAVE_Write_Request

/-- `none` retains reserved bytes; `some` writes them with the adjacent mandatory field.
The FOP high bits share its required sixteen-bit store. CS/DS apply to the narrow layout. -/
structure Fxsave.ReservedHeader where
  ftwReservedByte : Option (BitVec 8)
  fopHigh : BitVec 5
  fcsHigh : Option (BitVec 16)
  fdsHigh : Option (BitVec 16)
  deriving Repr, DecidableEq

def Fxsave.ReservedHeader.encode (header : Fxsave.ReservedHeader) : BitVec 48 :=
  (if header.ftwReservedByte.isSome then (1 : BitVec 48) <<< 47 else 0) |||
  (if header.fcsHigh.isSome then (1 : BitVec 48) <<< 46 else 0) |||
  (if header.fdsHigh.isSome then (1 : BitVec 48) <<< 45 else 0) |||
  (BitVec.ofNat 48 (header.ftwReservedByte.getD 0).toNat <<< 37) |||
  (BitVec.ofNat 48 header.fopHigh.toNat <<< 32) |||
  (BitVec.ofNat 48 (header.fcsHigh.getD 0).toNat <<< 16) |||
  BitVec.ofNat 48 (header.fdsHigh.getD 0).toNat

/-- Optional reserved bytes following the full 80-bit register payload. -/
structure Fxsave.ReservedSlot where
  padding : Option (BitVec 48)
  deriving Repr, DecidableEq

/-- Bits47:0 hold padding; bit48 selects whether to write it. -/
def Fxsave.ReservedSlot.encode (reserved : Fxsave.ReservedSlot) : BitVec 49 :=
  (if reserved.padding.isSome then (1 : BitVec 49) <<< 48 else 0) |||
  BitVec.ofNat 49 (reserved.padding.getD 0).toNat

/-- The fields FXSAVE saves only if the processor chooses to while `CR4.OSFXSR` is clear: `MXCSR`
and the XMM registers. `MXCSR_MASK` is saved either way (`Emulate_FXSAVE_Write_Enabled`). -/
structure Fxsave.OptionalFields where
  mxcsr : Bool
  xmm : Bool
  deriving Repr, DecidableEq

/-- Bit0 selects `MXCSR`, not `MXCSR_MASK`, which is always saved; bit1 selects the XMM registers. -/
def Fxsave.OptionalFields.encode (fields : Fxsave.OptionalFields) : BitVec 2 :=
  (if fields.xmm then (1 : BitVec 2) <<< 1 else 0) ||| (if fields.mxcsr then 1 else 0)

/-- Required bindings for choices owned by the local FXSAVE completion.
Domain admission is separate from the permutation choice; generated code owns every access. -/
class Fxsave (σ : Type) where
  optionalFields : X86.Helpers.Select_FXSAVE_Fields.Binding σ
  alignment : X86.Helpers.Select_FXSAVE_AC.Binding σ
  pageFaultPriority : X86.Helpers.Select_FXSAVE_Page_Fault_Priority.Binding σ
  reservedHeader : X86.Helpers.Select_FXSAVE_Reserved_Header.Binding σ
  reservedSlot : X86.Helpers.Select_FXSAVE_Reserved_Slot.Binding σ
  scheduleDomain : X86.Helpers.Select_FXSAVE_Schedule_Domain.Binding σ
  writeSwap : X86.Helpers.Select_FXSAVE_Write_Swap.Binding σ

attribute [instance_reducible, instance]
  Fxsave.optionalFields Fxsave.alignment Fxsave.pageFaultPriority
  Fxsave.reservedHeader Fxsave.reservedSlot Fxsave.scheduleDomain Fxsave.writeSwap

/-- Each implementation function sees the pre-callback state. -/
@[instance_reducible]
def Fxsave.ofFunctions {σ : Type}
    (optionalFields : X86.State σ → Fxsave.Input → BitVec 2)
    (alignment : X86.State σ → Fxsave.Input → Bool)
    (pageFaultPriority : X86.State σ → Fxsave.PageFaultPriorityInput → Bool)
    (reservedHeader : X86.State σ → Fxsave.Input → Fxsave.ReservedHeader)
    (reservedSlot : X86.State σ → Fxsave.SlotInput → Fxsave.ReservedSlot)
    (scheduleDomain : X86.State σ → Fxsave.Input → Bool)
    (writeSwap : X86.State σ → Fxsave.WriteSwapInput → Bool) : Fxsave σ where
  optionalFields := ⟨fun wide linearAddress => do return optionalFields (← read) ⟨wide, linearAddress⟩⟩
  alignment := ⟨fun wide linearAddress => do return alignment (← read) ⟨wide, linearAddress⟩⟩
  pageFaultPriority := ⟨fun wide linearAddress faultVector => do
    return pageFaultPriority (← read) ⟨⟨wide, linearAddress⟩, faultVector⟩⟩
  reservedHeader := ⟨fun wide linearAddress => do return (reservedHeader (← read) ⟨wide, linearAddress⟩).encode⟩
  reservedSlot := ⟨fun wide linearAddress slot => do
    return (reservedSlot (← read) ⟨⟨wide, linearAddress⟩, slot⟩).encode⟩
  scheduleDomain := ⟨fun wide linearAddress => do return scheduleDomain (← read) ⟨wide, linearAddress⟩⟩
  writeSwap := ⟨fun wide linearAddress first second => do
    return writeSwap (← read) ⟨⟨wide, linearAddress⟩, first, second⟩⟩

end X86.Machine.Bindings
