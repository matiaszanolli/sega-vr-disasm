/* Linker script for func_021 (original vertex transform)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x234C8;  /* ROM file offset 0x234C8 */
    .text : SUBALIGN(2) { *(.text) }
}
