ENTRY(entry)
PHDRS {
  code PT_LOAD FLAGS(5);
  data PT_LOAD FLAGS(4);
}
SECTIONS {
  .text 0x100000 : { *(.text) } :code
  .text.hot 0x180000 : { *(.text.extra) } :code
  .rodata 0x200000 : { *(.rodata) } :data
  /DISCARD/ : { *(.note*) *(.comment*) }
}
