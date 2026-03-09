/* Linker script for func_084 (hardware register init)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x243F0;  /* ROM file offset $0243F0 */
    .text : SUBALIGN(2) { *(.text) }
}
