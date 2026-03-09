/* Linker script for func_055 (unrolled 8-block copy with stride)
 * Places code at correct ROM file offset
 */
SECTIONS
{
    . = 0x23ED0;  /* ROM file offset $023ED0 */
    .text : SUBALIGN(2) { *(.text) }
}
