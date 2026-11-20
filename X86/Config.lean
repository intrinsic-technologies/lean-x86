-- Generated from source configuration declarations: configuration types, checks, readers and defaults; do not edit.
-- Source SHA256: 617238d52801fbf9404979e5daebe22f123946b692a6cb619a40877ca9825572
import X86.Runtime

set_option autoImplicit false

open X86.Runtime
open scoped X86.Runtime.Syntax

namespace X86

class Config where
  Cache_Line_Size : Int
  Max_Linear_Address : Int
  Max_Physical_Address : Int
  Feature_4G_Limit_Treated_As_Flat_Segment : Bool
  Feature_Early_Page_Access_Bit_Update : Bool
  Feature_FIP_Use_Linear_Address : Bool
  Feature_Ingore_FCS_FDS_Deprecation : Bool
  Feature_LAM_Moffs_Displacement : Bool
  MODEP5 : Bool

class Config.Value.Cache_Line_Size where
  value : Int

@[instance_reducible, instance]
def Config.Value.Cache_Line_Size.ofConfig [Config] : Config.Value.Cache_Line_Size := ⟨Config.Cache_Line_Size⟩

class Config.Value.Max_Linear_Address where
  value : Int

@[instance_reducible, instance]
def Config.Value.Max_Linear_Address.ofConfig [Config] : Config.Value.Max_Linear_Address := ⟨Config.Max_Linear_Address⟩

class Config.Value.Max_Physical_Address where
  value : Int

@[instance_reducible, instance]
def Config.Value.Max_Physical_Address.ofConfig [Config] : Config.Value.Max_Physical_Address := ⟨Config.Max_Physical_Address⟩

class Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment where
  value : Bool

@[instance_reducible, instance]
def Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment.ofConfig [Config] : Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment := ⟨Config.Feature_4G_Limit_Treated_As_Flat_Segment⟩

class Config.Value.Feature_Early_Page_Access_Bit_Update where
  value : Bool

@[instance_reducible, instance]
def Config.Value.Feature_Early_Page_Access_Bit_Update.ofConfig [Config] : Config.Value.Feature_Early_Page_Access_Bit_Update := ⟨Config.Feature_Early_Page_Access_Bit_Update⟩

class Config.Value.Feature_FIP_Use_Linear_Address where
  value : Bool

@[instance_reducible, instance]
def Config.Value.Feature_FIP_Use_Linear_Address.ofConfig [Config] : Config.Value.Feature_FIP_Use_Linear_Address := ⟨Config.Feature_FIP_Use_Linear_Address⟩

class Config.Value.Feature_Ingore_FCS_FDS_Deprecation where
  value : Bool

@[instance_reducible, instance]
def Config.Value.Feature_Ingore_FCS_FDS_Deprecation.ofConfig [Config] : Config.Value.Feature_Ingore_FCS_FDS_Deprecation := ⟨Config.Feature_Ingore_FCS_FDS_Deprecation⟩

class Config.Value.Feature_LAM_Moffs_Displacement where
  value : Bool

@[instance_reducible, instance]
def Config.Value.Feature_LAM_Moffs_Displacement.ofConfig [Config] : Config.Value.Feature_LAM_Moffs_Displacement := ⟨Config.Feature_LAM_Moffs_Displacement⟩

class Config.Value.MODEP5 where
  value : Bool

@[instance_reducible, instance]
def Config.Value.MODEP5.ofConfig [Config] : Config.Value.MODEP5 := ⟨Config.MODEP5⟩

def Config.Check.Cache_Line_Size (value : Int) {exception : Type} : Except (Runtime.Error exception) Unit := do
  Runtime.assert (value in {1..2048})
  pure ()

def Config.Check.Max_Linear_Address (value : Int) {exception : Type} : Except (Runtime.Error exception) Unit := do
  Runtime.assert (value == 32 || value == 48 || value == 52 || value == 57)
  pure ()

def Config.Check.Max_Physical_Address (value : Int) {exception : Type} : Except (Runtime.Error exception) Unit := do
  Runtime.assert (value in {32..52})
  pure ()

def Config.validate (configuration : Config) {exception : Type} :
    Except (Runtime.Error exception) Unit := do
  Config.Check.Cache_Line_Size configuration.Cache_Line_Size
  Config.Check.Max_Linear_Address configuration.Max_Linear_Address
  Config.Check.Max_Physical_Address configuration.Max_Physical_Address
  pure ()

def Config.Read.Cache_Line_Size [Config.Value.Cache_Line_Size] {exception : Type} : Except (Runtime.Error exception) (Int) := do
  let value := Config.Value.Cache_Line_Size.value
  Config.Check.Cache_Line_Size (exception := exception) value
  return value

def Config.Read.Max_Linear_Address [Config.Value.Max_Linear_Address] {exception : Type} : Except (Runtime.Error exception) (Int) := do
  let value := Config.Value.Max_Linear_Address.value
  Config.Check.Max_Linear_Address (exception := exception) value
  return value

def Config.Read.Max_Physical_Address [Config.Value.Max_Physical_Address] {exception : Type} : Except (Runtime.Error exception) (Int) := do
  let value := Config.Value.Max_Physical_Address.value
  Config.Check.Max_Physical_Address (exception := exception) value
  return value

def Config.Read.Feature_4G_Limit_Treated_As_Flat_Segment [Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment] {exception : Type} : Except (Runtime.Error exception) (Bool) := do
  let value := Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment.value
  return value

def Config.Read.Feature_Early_Page_Access_Bit_Update [Config.Value.Feature_Early_Page_Access_Bit_Update] {exception : Type} : Except (Runtime.Error exception) (Bool) := do
  let value := Config.Value.Feature_Early_Page_Access_Bit_Update.value
  return value

def Config.Read.Feature_FIP_Use_Linear_Address [Config.Value.Feature_FIP_Use_Linear_Address] {exception : Type} : Except (Runtime.Error exception) (Bool) := do
  let value := Config.Value.Feature_FIP_Use_Linear_Address.value
  return value

def Config.Read.Feature_Ingore_FCS_FDS_Deprecation [Config.Value.Feature_Ingore_FCS_FDS_Deprecation] {exception : Type} : Except (Runtime.Error exception) (Bool) := do
  let value := Config.Value.Feature_Ingore_FCS_FDS_Deprecation.value
  return value

def Config.Read.Feature_LAM_Moffs_Displacement [Config.Value.Feature_LAM_Moffs_Displacement] {exception : Type} : Except (Runtime.Error exception) (Bool) := do
  let value := Config.Value.Feature_LAM_Moffs_Displacement.value
  return value

def Config.Read.MODEP5 [Config.Value.MODEP5] {exception : Type} : Except (Runtime.Error exception) (Bool) := do
  let value := Config.Value.MODEP5.value
  return value

end X86
namespace X86

section

def Config.Default.MODEP5  : Except (Runtime.Error Empty) (Bool) := do
  return false

end

end X86

namespace X86

section

def Config.Default.Max_Physical_Address  : Except (Runtime.Error Empty) (Int) := do
  return 52

end

end X86

namespace X86

section

def Config.Default.Cache_Line_Size  : Except (Runtime.Error Empty) (Int) := do
  return 64

end

end X86

namespace X86

section

def Config.Default.Max_Linear_Address  : Except (Runtime.Error Empty) (Int) := do
  return 52

end

end X86

namespace X86.Helpers

section

inductive __Processor_Type where
  | Core
  | Atom
  deriving Repr, DecidableEq, Inhabited

end

end X86.Helpers

namespace X86

open X86.Helpers

-- The caller supplies a binding for this source declaration, which has no body.
class __Implements_Processor_Type.Binding where
  call (processor_type : __Processor_Type) :
    (Bool)

-- Callers are compiled once and receive the supplied implementation at run time.
attribute [nospecialize] __Implements_Processor_Type.Binding

section

variable
  [X86.__Implements_Processor_Type.Binding]

-- Intel's processor-family configuration defaults use this omitted helper.
def __Implements_Processor_Type
    (processor_type : __Processor_Type) :
    Except (Runtime.Error Empty) (Bool) := do
  pure (__Implements_Processor_Type.Binding.call processor_type)

end

end X86

namespace X86

open X86.Helpers

section

variable
  [X86.__Implements_Processor_Type.Binding]

def Config.Default.Feature_4G_Limit_Treated_As_Flat_Segment
     :
    Except (Runtime.Error Empty) (Bool) := do
  return not (← __Implements_Processor_Type __Processor_Type.Atom)

end

end X86

namespace X86

open X86.Helpers

section

variable
  [X86.__Implements_Processor_Type.Binding]

def Config.Default.Feature_Early_Page_Access_Bit_Update
     :
    Except (Runtime.Error Empty) (Bool) := do
  return (← __Implements_Processor_Type __Processor_Type.Atom)

end

end X86

namespace X86

open X86.Helpers

section

variable
  [X86.__Implements_Processor_Type.Binding]

def Config.Default.Feature_FIP_Use_Linear_Address  : Except (Runtime.Error Empty) (Bool) := do
  return (← __Implements_Processor_Type __Processor_Type.Atom)

end

end X86

namespace X86

open X86.Helpers

section

variable
  [X86.__Implements_Processor_Type.Binding]

def Config.Default.Feature_Ingore_FCS_FDS_Deprecation  : Except (Runtime.Error Empty) (Bool) := do
  return not (← __Implements_Processor_Type __Processor_Type.Atom)

end

end X86

namespace X86

open X86.Helpers

section

variable
  [X86.__Implements_Processor_Type.Binding]

def Config.Default.Feature_LAM_Moffs_Displacement  : Except (Runtime.Error Empty) (Bool) := do
  return (← __Implements_Processor_Type __Processor_Type.Atom)

end

end X86

open X86.Helpers

namespace X86

def Config.initialize [X86.__Implements_Processor_Type.Binding]
    (Cache_Line_Size : Option (Int) := none)
    (Max_Linear_Address : Option (Int) := none)
    (Max_Physical_Address : Option (Int) := none)
    (Feature_4G_Limit_Treated_As_Flat_Segment : Option (Bool) := none)
    (Feature_Early_Page_Access_Bit_Update : Option (Bool) := none)
    (Feature_FIP_Use_Linear_Address : Option (Bool) := none)
    (Feature_Ingore_FCS_FDS_Deprecation : Option (Bool) := none)
    (Feature_LAM_Moffs_Displacement : Option (Bool) := none)
    (MODEP5 : Option (Bool) := none) :
    Except (Runtime.Error Empty) Config := do
  let value0 ← match Cache_Line_Size with
    | some value => pure value
    | none => do
      let value ← X86.Config.Default.Cache_Line_Size
      pure value
  let _ : Config.Value.Cache_Line_Size := ⟨value0⟩
  let value1 ← match Max_Linear_Address with
    | some value => pure value
    | none => do
      let value ← X86.Config.Default.Max_Linear_Address
      pure value
  let _ : Config.Value.Max_Linear_Address := ⟨value1⟩
  let value2 ← match Max_Physical_Address with
    | some value => pure value
    | none => do
      let value ← X86.Config.Default.Max_Physical_Address
      pure value
  let _ : Config.Value.Max_Physical_Address := ⟨value2⟩
  let value3 ← match Feature_4G_Limit_Treated_As_Flat_Segment with
    | some value => pure value
    | none => do
      let value ← X86.Config.Default.Feature_4G_Limit_Treated_As_Flat_Segment
      pure value
  let _ : Config.Value.Feature_4G_Limit_Treated_As_Flat_Segment := ⟨value3⟩
  let value4 ← match Feature_Early_Page_Access_Bit_Update with
    | some value => pure value
    | none => do
      let value ← X86.Config.Default.Feature_Early_Page_Access_Bit_Update
      pure value
  let _ : Config.Value.Feature_Early_Page_Access_Bit_Update := ⟨value4⟩
  let value5 ← match Feature_FIP_Use_Linear_Address with
    | some value => pure value
    | none => do
      let value ← X86.Config.Default.Feature_FIP_Use_Linear_Address
      pure value
  let _ : Config.Value.Feature_FIP_Use_Linear_Address := ⟨value5⟩
  let value6 ← match Feature_Ingore_FCS_FDS_Deprecation with
    | some value => pure value
    | none => do
      let value ← X86.Config.Default.Feature_Ingore_FCS_FDS_Deprecation
      pure value
  let _ : Config.Value.Feature_Ingore_FCS_FDS_Deprecation := ⟨value6⟩
  let value7 ← match Feature_LAM_Moffs_Displacement with
    | some value => pure value
    | none => do
      let value ← X86.Config.Default.Feature_LAM_Moffs_Displacement
      pure value
  let _ : Config.Value.Feature_LAM_Moffs_Displacement := ⟨value7⟩
  let value8 ← match MODEP5 with
    | some value => pure value
    | none => do
      let value ← X86.Config.Default.MODEP5
      pure value
  let _ : Config.Value.MODEP5 := ⟨value8⟩
  return { Cache_Line_Size := value0, Max_Linear_Address := value1, Max_Physical_Address := value2, Feature_4G_Limit_Treated_As_Flat_Segment := value3, Feature_Early_Page_Access_Bit_Update := value4, Feature_FIP_Use_Linear_Address := value5, Feature_Ingore_FCS_FDS_Deprecation := value6, Feature_LAM_Moffs_Displacement := value7, MODEP5 := value8 }

end X86
