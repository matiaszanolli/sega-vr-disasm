/* Linker script for func_025 (coordinate offset calculator)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23634;  /* ROM file offset 0x23634 */
    .text : SUBALIGN(2) { *(.text) }
}
