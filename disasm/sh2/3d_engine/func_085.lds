/* Linker script for func_085 (poll until zero)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x2441C;  /* ROM file offset $02441C */
    .text : SUBALIGN(2) { *(.text) }
}
