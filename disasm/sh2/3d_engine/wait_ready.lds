/* Linker script for func_022 - places code at correct SH2 address */
SECTIONS
{
    . = 0x234EE;  /* ROM file offset 0x234EE */
    .text : SUBALIGN(2) { *(.text) }  /* Force 2-byte alignment */
}
