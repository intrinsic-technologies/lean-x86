{generated_header}

import {ns}.Sections
import {ns}.Symbols
import Prelude.ImageSections

namespace {ns}

{parts}/-- The selected sections at their link-time addresses, code sections first -/
def programSections : Prelude.ImageSections :=
  {sections}

/-- The selected sections as the code map that the user-process model installs -/
def programImage : X86.UserProcess.CodeMap := programSections.toCodeMap

end {ns}
