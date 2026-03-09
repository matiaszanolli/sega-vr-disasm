/* Linker script for func_069 (block copy with stride)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x2400E;  /* ROM file offset $02400E */
    .text : SUBALIGN(2) { *(.text) }
}
