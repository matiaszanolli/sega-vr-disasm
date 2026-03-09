/* Linker script for func_082 (multi-JSR alternate)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x2438C;  /* ROM file offset $02438C */
    .text : SUBALIGN(2) { *(.text) }
}
