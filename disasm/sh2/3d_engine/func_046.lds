/* Linker script for func_046 (array copy with stride)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23CF8;  /* ROM file offset $023CF8 */
    .text : SUBALIGN(2) { *(.text) }
}
