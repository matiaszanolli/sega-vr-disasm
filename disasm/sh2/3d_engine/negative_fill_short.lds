/* Linker script for func_078 (negative value fill)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x242AC;  /* ROM file offset $0242AC */
    .text : SUBALIGN(2) { *(.text) }
}
