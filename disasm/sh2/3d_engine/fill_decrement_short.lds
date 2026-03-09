/* Linker script for func_079 (fill with decrement)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x242E0;  /* ROM file offset $0242E0 */
    .text : SUBALIGN(2) { *(.text) }
}
