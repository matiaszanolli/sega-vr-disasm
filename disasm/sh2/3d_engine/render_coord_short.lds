/* Linker script for func_041 (main render coordinator)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x239F0;  /* ROM file offset $0239F0 */
    .text : SUBALIGN(2) { *(.text) }
}
