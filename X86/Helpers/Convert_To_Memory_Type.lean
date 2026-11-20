-- Generated from data/definitions.xml.gz: Convert_To_Memory_Type; do not edit.
-- Source SHA256: debb7e128959f028582e9f4a317c291b2322ac6f561abe063a2a47808a6d959a
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Convert_To_Memory_Type)
import X86.Runtime
import X86.Helpers.Memory_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86.Helpers

def Convert_To_Memory_Type (rr_base : Bits 3) : Except (Runtime.Error Empty) (Memory_Type) := do
  match Unsigned rr_base with
  | 0b000 => do
    return Memory_Type.Memory_Type_Strong_Uncacheable
  | 0b001 => do
    return Memory_Type.Memory_Type_Write_Combining
  | 0b100 => do
    return Memory_Type.Memory_Type_Write_Through
  | 0b101 => do
    return Memory_Type.Memory_Type_Write_Protected
  | 0b110 => do
    return Memory_Type.Memory_Type_Write_Back
  | 0b111 => do
    return Memory_Type.Memory_Type_Uncacheable
  | _ => do
    return Memory_Type.Memory_Type_Unknown

end X86.Helpers
