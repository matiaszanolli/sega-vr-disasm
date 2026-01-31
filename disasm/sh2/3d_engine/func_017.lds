/* Linker script for func_017 - places code at correct SH2 address */
SECTIONS
{
    . = 0x2338A;  /* ROM file offset 0x2338A */
    .text : SUBALIGN(2) { *(.text) }  /* Force 2-byte alignment */
}
