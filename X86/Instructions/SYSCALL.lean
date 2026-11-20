-- Generated from Intel XML with an explicit local correction and instruction forms; Intel XED 0bcb6237345c5066726dcc08b3d87928df3b5b26: datafiles/xed-isa.txt, datafiles/xed-amd-prefetch.txt, datafiles/cet/cet-isa.xed.txt, datafiles/cet/cet-nop-remove.xed.txt, datafiles/hsw/lzcnt-isa.xed.txt, datafiles/xed-eOSZ.txt; do not edit.
-- Source SHA256: c49d698985c38c7b95d36402483a9177e961ccaf65608acea462423d6a814b18
-- SYSCALL invokes an OS system-call handler at privilege level 0.
-- [Intel SDM](https://intel.github.io/SDM/sdm.html?instr=SYSCALL)
import X86.Runtime
import X86.Helpers.Branch_Far
import X86.Helpers.CET.Is_Shadow_Stack_Enabled
import X86.Helpers.Data_Size_Of_Current_Mode
import X86.Helpers.FRED.Event_Delivery
import X86.Helpers.In_64Bit_Mode
import X86.Helpers.Instruction_Context
import X86.Helpers.Is_Canonical_Wrt_Paging_Mode
import X86.Helpers.Is_End_Branch_Enabled
import X86.Helpers.Registers
import X86.Helpers.Report_General_Protection_Exception
import X86.Helpers.Report_Invalid_Opcode
import X86.Helpers.Segment
import X86.Helpers.Set_Canonical_Wrt_Paging_Mode
import X86.Helpers.Set_Segment_Base
import X86.Helpers.Std.Bits.Add_int
import X86.Helpers.Std.Bits.All_Ones
import X86.Helpers.Std.Bits.Zero
import X86.Helpers.Vectored_Event_Type
import X86.State

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

open X86.Helpers

namespace X86

variable {σ : Type}

variable
  [X86.Get_CPUID_Value.Binding σ]
  [X86.Helpers.FRED.Event_Delivery.Binding σ]

def Instructions.Operations.SYSCALL  : Runtime.SpecM Exception (State σ) Unit := do
  if ((← CR4.FRED) == 1) then
    FRED.Event_Delivery Vectored_Event_Type.Other_Event 0 (← Std.Bits.Zero 32) (← get).Next_IP true false
    return ()

  if (not (← Is_Canonical_Wrt_Paging_Mode (← get).IA32_LSTAR 0 true)) then
    liftM (Report_General_Protection_Exception (← Std.Bits.Zero 32))

  let mut new_cs_selector : Segment_Selector ← sliceInclusive (← get).IA32_STAR 47 32
  new_cs_selector := Segment_Selector.setRPL new_cs_selector (0 : Bits 2)

  let mut new_cs : Segment ← Set_Segment_Base (← Std.Bits.Zero 64) ({ selector := new_cs_selector } : Segment)
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setLimit.partial new_cs.descriptor (← Std.Bits.All_Ones 20)) }

  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setA.partial new_cs.descriptor (1 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setR.partial new_cs.descriptor (1 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setConforming.partial new_cs.descriptor (0 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setCode.partial new_cs.descriptor (1 : Runtime.Bit)) }

  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setS.partial new_cs.descriptor (1 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setDPL.partial new_cs.descriptor (0 : Bits 2)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setP.partial new_cs.descriptor (1 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setL.partial new_cs.descriptor (1 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setD.partial new_cs.descriptor (0 : Runtime.Bit)) }
  new_cs := { new_cs with descriptor := (← Segment_Descriptor.setG.partial new_cs.descriptor (1 : Runtime.Bit)) }

  new_cs := { new_cs with descriptor_valid := some true }
  new_cs := { new_cs with is_code := some true }
  new_cs := { new_cs with is_stack := some false }
  new_cs := { new_cs with is_64bit_mode_data_segment := some false }

  if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
    IA32_PL3_SSP.assign (← Set_Canonical_Wrt_Paging_Mode (← get).SSP)

  RCX_write (← get).Next_IP
  R11_write (← get).RFLAGS
  -- EFLAGS bit 1 is fixed at 1; IA32_FMASK cannot clear it.
  RFLAGS.assign ((← get).RFLAGS and ~~~ (← get).IA32_FMASK or (2 : Bits 64))
  Branch_Far new_cs (← get).IA32_LSTAR

  if (← CET.Is_Shadow_Stack_Enabled (← get).CPL) then
    SSP.assign (← Std.Bits.Zero 64)

  if (← Is_End_Branch_Enabled (← get).CPL) then
    IA32_S_CET.setTRACKER (1 : Runtime.Bit)
    IA32_S_CET.setSUPPRESS (0 : Runtime.Bit)

  SS.setselector (← Std.Bits.Add_int (n := 16) (← sliceInclusive (← get).IA32_STAR 47 32) 8)

  SS.setdescriptor (Runtime.InitializedBits.ofValue (← Std.Bits.Zero 64))
  SS.assign (← Set_Segment_Base (← Std.Bits.Zero 64) (← get).SS)
  let value ← Std.Bits.All_Ones 20
  SS.setdescriptor (← Segment_Descriptor.setLimit.partial (← get).SS.descriptor value)

  SS.setdescriptor (← Segment_Descriptor.setA.partial (← get).SS.descriptor (1 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setR.partial (← get).SS.descriptor (1 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setConforming.partial (← get).SS.descriptor (0 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setCode.partial (← get).SS.descriptor (0 : Runtime.Bit))

  SS.setdescriptor (← Segment_Descriptor.setS.partial (← get).SS.descriptor (1 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setDPL.partial (← get).SS.descriptor (0 : Bits 2))
  SS.setdescriptor (← Segment_Descriptor.setP.partial (← get).SS.descriptor (1 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setD.partial (← get).SS.descriptor (1 : Runtime.Bit))
  SS.setdescriptor (← Segment_Descriptor.setG.partial (← get).SS.descriptor (1 : Runtime.Bit))

  SS.setdescriptor_valid (some true)
  SS.setis_stack (some true)
  SS.setis_code (some false)
  SS.setis_64bit_mode_data_segment (some false)

-- SYSCALL: 0F 05
-- CPUID group: LONGMODE
def Instructions.SYSCALL
    (ip : Bits 64) (context : Instruction_Context) :
    Runtime.SpecM Exception (State σ) Unit := do
  let _operand_size : Int := 64

  if (not ((← Data_Size_Of_Current_Mode) == 64)) then
    liftM (Report_Invalid_Opcode)

  if context.lock_prefix_present then
    liftM (Report_Invalid_Opcode)

  if (not (← In_64Bit_Mode)) then
    liftM (Report_Invalid_Opcode)

  if ((← CR4.FRED) == 0 and (← get).IA32_EFER.SCE == 0) then
    liftM (Report_Invalid_Opcode)

  modify ({ · with Next_IP := ip })

  Instructions.Operations.SYSCALL

end X86
