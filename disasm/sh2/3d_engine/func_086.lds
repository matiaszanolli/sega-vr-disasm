/* Linker script for func_086 (clear register)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x2442C;  /* ROM file offset $02442C */
    .text : SUBALIGN(2) { *(.text) }
}
