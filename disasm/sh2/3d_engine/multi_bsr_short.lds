/* Linker script for func_050 (multi-BSR processing handler)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23D6E;  /* ROM file offset $023D6E */
    .text : SUBALIGN(2) { *(.text) }
}
