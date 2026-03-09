/* Linker script for func_083 (poll wait)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x243E0;  /* ROM file offset $0243E0 */
    .text : SUBALIGN(2) { *(.text) }
}
