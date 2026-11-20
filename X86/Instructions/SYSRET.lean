-- Generated from a local ISA specification; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: cf167581386a629a156288a6fa3cab8b669ad1271978a9e54c70548361577704
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=SYSRET)
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.CET.Is_Shadow_Stack_Enabled
import X86.Helpers.ECX
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_Canonical_Wrt_Position
import X86.Helpers.Registers
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Set_Segment_Base
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Std.Bits.Zero_Extend
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

-- Intel SDM Vol. 2, SYSRET operation. The executable XML has no SYSRET body.
-- Return to ring 3 with fixed segment fields; RSP is unchanged. The canonical
-- target check occurs before any architectural state changes.
def Instructions.Operations.SYSRET (width : Int) : Runtime.SpecM Exception (State σ) Unit := do
  Runtime.assert (width == 32 || width == 64)

  if (not (← In_64Bit_Mode) or (← get).IA32_EFER.SCE == 0) then
    liftM (Report_Invalid_Opcode)
  if ((← get).CPL != 0) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
  if (← (do if width == 64 then pure (not (← Is_Canonical_Wrt_Position (← RCX) (if (← CR4.LA57) == 1 then 57 else 48))) else pure false)) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))
  let target : Bits 64 ← do
    if width == 64 then
      RCX
    else
      Std.Bits.Zero_Extend (source_size := 32) (← ECX) 64
  RFLAGS.assign ((← GPR.get 11) and (← Std.Bits.Zero_Extend (source_size := 24) 3964887 64) or (2 : Bits 64))
  let mut new_cs : Segment := (← get).CS
  new_cs := { new_cs with selector := (← Std.Bits.Add_int (n := 16) (← sliceInclusive (← get).IA32_STAR 63 48) (if width == 64 then 16 else 0)) or (3 : Bits 16) }
  new_cs := (← Set_Segment_Base (← Std.Bits.Zero 64) new_cs)
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setLimit.partial new_cs.descriptor (← Std.Bits.All_Ones 20)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setA.partial new_cs.descriptor (1 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setR.partial new_cs.descriptor (1 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setConforming.partial new_cs.descriptor (0 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setCode.partial new_cs.descriptor (1 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setS.partial new_cs.descriptor (1 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setDPL.partial new_cs.descriptor (3 : Bits 2)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setP.partial new_cs.descriptor (1 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setL.partial new_cs.descriptor (if width == 64 then (1 : Runtime.Bit) else (0 : Runtime.Bit))) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setD.partial new_cs.descriptor (if width == 64 then (0 : Runtime.Bit) else (1 : Runtime.Bit))) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setG.partial new_cs.descriptor (1 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor_valid := some true }
  Branch_Far new_cs target
  if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
    SSP.assign (← get).IA32_PL3_SSP
  SS.setselector ((← Std.Bits.Add_int (n := 16) (← sliceInclusive (← get).IA32_STAR 63 48) 8) or (3 : Bits 16))
  SS.assign (← Set_Segment_Base (← Std.Bits.Zero 64) (← get).SS)
  let value ← Std.Bits.All_Ones 20
  SS.setdescriptor (← Segment_Descriptor.setLimit.partial (← get).SS.descriptor value)
  SS.setdescriptor (← Segment_Descriptor.setA.partial (← get).SS.descriptor (1 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setR.partial (← get).SS.descriptor (1 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setConforming.partial (← get).SS.descriptor (0 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setCode.partial (← get).SS.descriptor (0 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setS.partial (← get).SS.descriptor (1 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setDPL.partial (← get).SS.descriptor (3 : Bits 2))
  SS.setdescriptor (← Segment_Descriptor.setP.partial (← get).SS.descriptor (1 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setD.partial (← get).SS.descriptor (1 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setG.partial (← get).SS.descriptor (1 : Runtime.Bit))
  SS.setdescriptor_valid (some true)

def Instructions.SYSRET
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.SYSRET 32

def Instructions.SYSRET64
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)
  modify ({ · with Next_IP := ip })
  Instructions.Operations.SYSRET 64

end X86
