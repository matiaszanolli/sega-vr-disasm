/* Linker script for func_029 + exit paths (func_030, func_031)
 * Places code at correct ROM file offset for PC-relative addressing
 */
SECTIONS
{
    . = 0x23688;  /* ROM file offset 0x23688 */
    .text : SUBALIGN(2) { *(.text) }
}
