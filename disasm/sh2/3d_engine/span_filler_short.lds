/* Linker script for func_034 (span filler / edge interpolation)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x2375C;  /* ROM file offset 0x2375C */
    .text : SUBALIGN(2) { *(.text) }
}
