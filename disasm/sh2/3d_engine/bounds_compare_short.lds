/* Linker script for func_026 + exit paths (func_027, func_028)
 * Places code at correct ROM file offset for PC-relative addressing
 */
SECTIONS
{
    . = 0x23644;  /* ROM file offset 0x23644 */
    .text : SUBALIGN(2) { *(.text) }
}
