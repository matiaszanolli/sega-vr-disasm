/* Linker script for func_043 (polygon batch processor)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23A70;  /* ROM file offset $023A70 */
    .text : SUBALIGN(2) { *(.text) }
}
