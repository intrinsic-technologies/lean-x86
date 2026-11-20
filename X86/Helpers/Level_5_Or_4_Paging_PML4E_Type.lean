-- Generated from data/definitions.xml.gz: Level_5_Or_4_Paging_PML4E_Type; do not edit.
-- Source SHA256: 3221e0334be432137ac151a26395bc47ba5ff6dba2b66f1c085084d76c72ec5e
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?helper=Level_5_Or_4_Paging_PML4E_Type)
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86.Helpers

abbrev Level_5_Or_4_Paging_PML4E_Type := Bits 64

def Level_5_Or_4_Paging_PML4E_Type.P (bits : Level_5_Or_4_Paging_PML4E_Type) : Runtime.Bit :=
  BitVec.extractLsb' 0 1 bits

def Level_5_Or_4_Paging_PML4E_Type.setP (bits : Level_5_Or_4_Paging_PML4E_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PML4E_Type :=
  setSlice bits 0 1 value

def Level_5_Or_4_Paging_PML4E_Type.RW (bits : Level_5_Or_4_Paging_PML4E_Type) : Runtime.Bit :=
  BitVec.extractLsb' 1 1 bits

def Level_5_Or_4_Paging_PML4E_Type.setRW (bits : Level_5_Or_4_Paging_PML4E_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PML4E_Type :=
  setSlice bits 1 1 value

def Level_5_Or_4_Paging_PML4E_Type.US (bits : Level_5_Or_4_Paging_PML4E_Type) : Runtime.Bit :=
  BitVec.extractLsb' 2 1 bits

def Level_5_Or_4_Paging_PML4E_Type.setUS (bits : Level_5_Or_4_Paging_PML4E_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PML4E_Type :=
  setSlice bits 2 1 value

def Level_5_Or_4_Paging_PML4E_Type.PWT (bits : Level_5_Or_4_Paging_PML4E_Type) : Runtime.Bit :=
  BitVec.extractLsb' 3 1 bits

def Level_5_Or_4_Paging_PML4E_Type.setPWT (bits : Level_5_Or_4_Paging_PML4E_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PML4E_Type :=
  setSlice bits 3 1 value

def Level_5_Or_4_Paging_PML4E_Type.PCD (bits : Level_5_Or_4_Paging_PML4E_Type) : Runtime.Bit :=
  BitVec.extractLsb' 4 1 bits

def Level_5_Or_4_Paging_PML4E_Type.setPCD (bits : Level_5_Or_4_Paging_PML4E_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PML4E_Type :=
  setSlice bits 4 1 value

def Level_5_Or_4_Paging_PML4E_Type.A (bits : Level_5_Or_4_Paging_PML4E_Type) : Runtime.Bit :=
  BitVec.extractLsb' 5 1 bits

def Level_5_Or_4_Paging_PML4E_Type.setA (bits : Level_5_Or_4_Paging_PML4E_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PML4E_Type :=
  setSlice bits 5 1 value

def Level_5_Or_4_Paging_PML4E_Type.IGNORED (bits : Level_5_Or_4_Paging_PML4E_Type) : Bits 15 :=
  BitVec.append (BitVec.append (BitVec.extractLsb' 52 11 bits) (BitVec.extractLsb' 8 3 bits)) (BitVec.extractLsb' 6 1 bits)

def Level_5_Or_4_Paging_PML4E_Type.setIGNORED (bits : Level_5_Or_4_Paging_PML4E_Type) (value : Bits 15) : Level_5_Or_4_Paging_PML4E_Type :=
  let bits := setSlice bits 6 1 (BitVec.extractLsb' 0 1 value)
  let bits := setSlice bits 8 3 (BitVec.extractLsb' 1 3 value)
  setSlice bits 52 11 (BitVec.extractLsb' 4 11 value)

def Level_5_Or_4_Paging_PML4E_Type.RESERVED (bits : Level_5_Or_4_Paging_PML4E_Type) : Runtime.Bit :=
  BitVec.extractLsb' 7 1 bits

def Level_5_Or_4_Paging_PML4E_Type.setRESERVED (bits : Level_5_Or_4_Paging_PML4E_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PML4E_Type :=
  setSlice bits 7 1 value

def Level_5_Or_4_Paging_PML4E_Type.RESTART (bits : Level_5_Or_4_Paging_PML4E_Type) : Runtime.Bit :=
  BitVec.extractLsb' 11 1 bits

def Level_5_Or_4_Paging_PML4E_Type.setRESTART (bits : Level_5_Or_4_Paging_PML4E_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PML4E_Type :=
  setSlice bits 11 1 value

def Level_5_Or_4_Paging_PML4E_Type.PDPT_ADDRESS (bits : Level_5_Or_4_Paging_PML4E_Type) : Bits 40 :=
  BitVec.extractLsb' 12 40 bits

def Level_5_Or_4_Paging_PML4E_Type.setPDPT_ADDRESS (bits : Level_5_Or_4_Paging_PML4E_Type) (value : Bits 40) : Level_5_Or_4_Paging_PML4E_Type :=
  setSlice bits 12 40 value

def Level_5_Or_4_Paging_PML4E_Type.XD (bits : Level_5_Or_4_Paging_PML4E_Type) : Runtime.Bit :=
  BitVec.extractLsb' 63 1 bits

def Level_5_Or_4_Paging_PML4E_Type.setXD (bits : Level_5_Or_4_Paging_PML4E_Type) (value : Runtime.Bit) : Level_5_Or_4_Paging_PML4E_Type :=
  setSlice bits 63 1 value

end X86.Helpers
