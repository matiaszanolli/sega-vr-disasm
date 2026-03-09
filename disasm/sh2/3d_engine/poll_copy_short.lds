/* Linker script for func_091 (poll and copy)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x244D4;  /* ROM file offset $0244D4 */
    .text : SUBALIGN(2) { *(.text) }
}
