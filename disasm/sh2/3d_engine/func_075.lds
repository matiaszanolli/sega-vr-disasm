/* Linker script for func_075 (byte block iterator)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x2420C;  /* ROM file offset $02420C */
    .text : SUBALIGN(2) { *(.text) }
}
