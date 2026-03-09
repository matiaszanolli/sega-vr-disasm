/* Linker script for func_032 - places code at correct SH2 address */
SECTIONS
{
    . = 0x236DA;  /* ROM file offset 0x236DA */
    .text : SUBALIGN(2) { *(.text) }  /* Force 2-byte alignment */
}
