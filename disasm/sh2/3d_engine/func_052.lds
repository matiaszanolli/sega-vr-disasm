/* Linker script for func_052 (small BSR handler)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23E48;  /* ROM file offset $023E48 */
    .text : SUBALIGN(2) { *(.text) }
}
