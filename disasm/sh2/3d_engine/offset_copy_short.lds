/* Linker script for func_003_004 (includes func_002 exit paths)
 * Places code at correct ROM file offset for PC-relative addressing
 */
SECTIONS
{
    . = 0x230C8;  /* ROM file offset 0x230C8 */
    .text : SUBALIGN(2) { *(.text) }
}
