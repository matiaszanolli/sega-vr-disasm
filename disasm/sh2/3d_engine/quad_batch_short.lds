/* Linker script for func_018 (quad batch processor)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x233A4;  /* ROM file offset 0x233A4 */
    .text : SUBALIGN(2) { *(.text) }
}
