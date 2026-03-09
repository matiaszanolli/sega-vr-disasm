/* Linker script for func_040 (display list buffer setup)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x2385E;  /* ROM file offset 0x2385E */
    .text : SUBALIGN(2) { *(.text) }
}
