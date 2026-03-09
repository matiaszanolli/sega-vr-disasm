/* Linker script for func_070 (loop dispatcher)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x24060;  /* ROM file offset $024060 */
    .text : SUBALIGN(2) { *(.text) }
}
