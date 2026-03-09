/* Linker script for func_080 (memory clear)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x24300;  /* ROM file offset $024300 */
    .text : SUBALIGN(2) { *(.text) }
}
