import X86.Machine.State

namespace Prelude

open X86

/--
Memory mapping for identity translation of addresses below 4 GiB. These conditions specify:

- CR3 pointing to the page tables at `0x1000`
- Page-table entries mapping the first 4 GiB with read, write, and execute permissions

Memory outside these page-table entries is unrestricted.
-/
structure IdentityMappedMemory (s : Machine.RamState) : Prop where
  cr3 : s.CR3 = 0x1000
  tables :
    (∀ i : Fin 8, s.external[BitVec.ofNat 64 (0x1000 + i.val)]? =
      some (UInt8.ofNat ((0x2027 : Nat) >>> (8 * i.val) % 256))) ∧
    (∀ page : Fin 4, ∀ i : Fin 8,
      s.external[BitVec.ofNat 64 (0x2000 + 8 * page.val + i.val)]? =
        some (UInt8.ofNat (((page.val <<< 30 ||| 0xe7) : Nat) >>> (8 * i.val) % 256)))

end Prelude
