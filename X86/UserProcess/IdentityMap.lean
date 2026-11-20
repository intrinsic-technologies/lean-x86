import X86.Machine.Ram
import X86.Helpers.Level_5_Or_4_Paging_PML4E_Type
import X86.Helpers.Level_5_Or_4_Paging_PDPTE_1GB_page_Type
import Std.Data.TreeSet

/-!
# Identity-mapped memory

Programs use virtual addresses. The x86 page tables translate them to physical addresses
in memory. An identity map keeps the address value unchanged: a read from virtual address
`0x400000` reads physical address `0x400000`.

This module constructs a four-level identity map using 1-GiB pages. The generated Intel
code reads the table bytes from physical memory. For example, requesting 4 KiB at
`0x400000` produces one 1-GiB mapping, one root table and one PDPT:

```
regions = [(0x400000, 4 KiB)], tableBase = 2 GiB

           Virtual addresses                       Physical addresses
       0 +------------------------+            0 +------------------------+
         | mapped: 1 GiB          |--- VA = PA ->| same address range     |
         | program at 0x400000    |              | program bytes: 4 KiB   |
         |                        |              | other bytes absent     |
   1 GiB +------------------------+        1 GiB +------------------------+
         |                        |              |          ...           |
         |                        |        2 GiB +------------------------+ <- tableBase
         | unmapped               |        CR3 ->| PML4: 4 KiB            | }
         |                        |              |       |                | }
         |                        |              +-------|----------------+ } 8 KiB
         |                        |              |       v                | } reserved
         |                        |              | PDPT: 4 KiB            | }
         |                        |              +------------------------+
         |                        |              |          ...           |
    2^47 +------------------------+              +------------------------+ 2^physicalBits
```

The CR3 register points to the root table (PML4) at `tableBase`. Root entries point to
second-level tables (PDPTs). Each present PDPT entry maps a whole 1-GiB block. Requested
ranges expand to these block boundaries; other blocks remain unmapped. The root and PDPTs
occupy consecutive 4-KiB tables in physical memory. The caller supplies the program bytes
separately. The page walk reads the tables by physical address, so they need no virtual
mapping.

Mapped pages permit user reads, writes and instruction fetches. `Layout.install` rejects
occupied bytes in the table footprint, which `Layout.reserved` reports. Each `TableStorage`
instance defines occupancy for its memory; in `Ram`, a present byte is occupied. Later
writes to mapped table bytes are allowed. Program proofs must establish that execution
preserves the tables and paging controls.
-/

namespace X86.UserProcess.IdentityMap

open X86.Machine X86.Helpers

/-- Four-level paging uses eight-byte entries in 4-KiB tables (SDM Vol. 3A §5.5). -/
def entryBytes : Nat := 8
def tableFrameBytes : Nat :=
  (Level_5_Or_4_Paging_PML4E_Type.setPDPT_ADDRESS 0 1).toNat
def entriesPerTable : Nat := tableFrameBytes / entryBytes

/-- Setting the lowest page-address bit gives the 1-GiB page size. -/
def page1GBBytes : Nat :=
  (Level_5_Or_4_Paging_PDPTE_1GB_page_Type.setPAGE_ADDRESS 0 1).toNat

/-- The lower canonical half uses half the PML4 entries, each covering a full PDPT. -/
def lowerCanonicalLimit : Nat := page1GBBytes * entriesPerTable^2 / 2

/-- Maximum MAXPHYADDR representable by the PML4 address field. -/
def maxPhysicalBits : Nat :=
  (Level_5_Or_4_Paging_PML4E_Type.setPDPT_ADDRESS 0 (~~~0)).toNat.log2 + 1

open Level_5_Or_4_Paging_PML4E_Type in
/-- Present, writable, user-accessible and accessed; preset A avoids walk-time updates. -/
def tableFlags : Nat := (setA (setUS (setRW (setP 0 1) 1) 1) 1).toNat

open Level_5_Or_4_Paging_PDPTE_1GB_page_Type in
/-- Also set page-size and dirty: a 1-GiB leaf whose D bit needs no update on writes. -/
def pageFlags : Nat := (setD (setPS (BitVec.ofNat _ tableFlags) 1) 1).toNat

/-- A requested byte interval `[start, start + size)`. Empty intervals require no mapping. -/
structure Region where
  start : Nat
  size : Nat
  deriving Repr

inductive Error where
  | unsupportedPhysicalBits (bits : Nat)
  | outsideAddressSpace (region : Region)
  | invalidTablePlacement (base size : Nat)
  | tableCollision (address : BitVec 64)
  | unsupportedPageSize
  deriving Repr

/-- PDPT frames follow the root contiguously, one per used PML4 entry. -/
structure Layout where
  private mk ::
  tableBase : Nat
  /-- Numbers of the mapped 1-GiB pages. -/
  pages : List Nat
  pml4Indices : List Nat
  deriving Repr

/-- The size in bytes of the root and its PDPT frames. -/
def Layout.tableBytes (layout : Layout) : Nat :=
  tableFrameBytes * (1 + layout.pml4Indices.length)

/-- Whether a physical byte lies in the table footprint. -/
def Layout.reserved (layout : Layout) (address : BitVec 64) : Bool :=
  layout.tableBase ≤ address.toNat && address.toNat < layout.tableBase + layout.tableBytes

/-- Whether a virtual address is covered, including the rounding to whole 1-GiB pages. -/
def Layout.contains (layout : Layout) (address : BitVec 64) : Bool :=
  layout.pages.contains (address.toNat / page1GBBytes)

/--
Compute the page-table layout for `regions`, mapping each virtual address to the same
physical address. Include every 1-GiB page that intersects a nonempty region. The root
starts at `tableBase`, followed by one PDPT for each used PML4 entry. Return the layout
without writing memory.

Require nonempty regions to lie below `lowerCanonicalLimit` and `2^physicalBits`. The table
placement must be 4-KiB aligned and end at or below `2^physicalBits`. The tables are read by
physical address, so `regions` need not cover them.
-/
def build (physicalBits : Nat) (regions : List Region) (tableBase : Nat) : Except Error Layout := do
  unless physicalBits ≤ maxPhysicalBits && page1GBBytes ≤ 2^physicalBits do
    throw (.unsupportedPhysicalBits physicalBits)
  let limit := min (2^physicalBits) lowerCanonicalLimit
  let mut pages : Std.TreeSet Nat compare := {}
  for region in regions do
    if region.size != 0 then
      unless region.start + region.size ≤ limit do
        throw (.outsideAddressSpace region)
      let first := region.start / page1GBBytes
      let last := (region.start + region.size - 1) / page1GBBytes
      for offset in List.range (last + 1 - first) do
        pages := pages.insert (first + offset)
  let pageList := pages.toList
  let pml4Indices := (pageList.foldl (fun (indices : Std.TreeSet Nat compare) page =>
    indices.insert (page / entriesPerTable)) {}).toList
  let layout := Layout.mk tableBase pageList pml4Indices
  unless tableBase % tableFrameBytes == 0 && tableBase + layout.tableBytes ≤ 2^physicalBits do
    throw (.invalidTablePlacement tableBase layout.tableBytes)
  return layout

/-- Encode a table entry as eight little-endian bytes through `put`. -/
private def writeEntry {α : Type} (put : α → BitVec 64 → UInt8 → α)
    (memory : α) (address value : Nat) : α :=
  (List.range entryBytes).foldl (fun memory byte =>
    put memory (BitVec.ofNat 64 (address + byte)) (UInt8.ofNat (value / UInt8.size^byte))) memory

/-- Write the table image through a caller's byte installer, which must provide its storage. -/
def Layout.writeImage {α : Type} (layout : Layout) (put : α → BitVec 64 → UInt8 → α)
    (memory : α) : α := Id.run do
  let mut memory := (List.range layout.tableBytes).foldl (fun memory offset =>
    put memory (BitVec.ofNat 64 (layout.tableBase + offset)) 0) memory
  for (pml4Index, slot) in layout.pml4Indices.zipIdx do
    let pdpt := layout.tableBase + tableFrameBytes * (slot + 1)
    memory := writeEntry put memory (layout.tableBase + entryBytes * pml4Index) (pdpt ||| tableFlags)
  for page in layout.pages do
    let slot := layout.pml4Indices.findIdx (· == page / entriesPerTable)
    let pdpt := layout.tableBase + tableFrameBytes * (slot + 1)
    memory := writeEntry put memory (pdpt + entryBytes * (page % entriesPerTable))
      ((page * page1GBBytes) ||| pageFlags)
  return memory

/--
Physical memory that can receive the table image. Memory that backs every byte in advance
cannot infer occupancy from its contents, so it must record the bytes its caller placed.
-/
class TableStorage (σ : Type) where
  /-- Whether `address` holds a caller byte that the tables must not replace. -/
  occupied : σ → BitVec 64 → Bool
  /-- Store a table byte, providing its storage. -/
  put : σ → BitVec 64 → UInt8 → σ

/-- In RAM, a byte is occupied when it is present; table bytes are allocated. -/
instance : TableStorage Ram where
  occupied memory address := memory.contains address
  put memory address byte := memory.insert address byte

/-- Store the table image, rejecting collisions and preserving all caller bytes. -/
def Layout.install {σ : Type} [TableStorage σ] (layout : Layout) (memory : σ) :
    Except Error σ := do
  for offset in List.range layout.tableBytes do
    let address := BitVec.ofNat 64 (layout.tableBase + offset)
    if TableStorage.occupied memory address then throw (.tableCollision address)
  return layout.writeImage TableStorage.put memory

end X86.UserProcess.IdentityMap
