/* Linker script for func_090 (poll wait with flag set)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x244B4;  /* ROM file offset $0244B4 */
    .text : SUBALIGN(2) { *(.text) }
}
