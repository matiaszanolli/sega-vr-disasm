/*
 * pdcore Bridge Function Stubs for Testing
 * Provides minimal implementations for testing pdcore without PicoDrive
 */

#include <stdint.h>
#include <stdlib.h>

/* Full SH2 structure for stubs (matches pdcore.c definition) */
#define ALIGNED(n) __attribute__((aligned(n)))

typedef struct SH2_ {
    uint32_t r[16] ALIGNED(32);   /* General purpose registers */
    uint32_t pc;                  /* Program counter */
    uint32_t ppc;
    uint32_t pr;
    uint32_t sr;
    uint32_t gbr, vbr;
    uint32_t mach, macl;

    /* Memory maps */
    const void *read8_map;
    const void *read16_map;
    const void *read32_map;
    const void **write8_tab;
    const void **write16_tab;
    const void **write32_tab;

    /* DRC stuff */
    int drc_tmp;
    int irq_cycles;
    void *p_bios;
    void *p_da;
    void *p_sdram;
    void *p_rom;
    void *p_dram;
    void *p_drcblk_da;
    void *p_drcblk_ram;
    unsigned int pdb_io_csum[2];

    unsigned int state;
    uint32_t poll_addr;
    unsigned int poll_cycles;
    int poll_cnt;
    int no_polling;

    /* DRC branch cache */
    int rts_cache_idx;
    struct { uint32_t pc; void *code; } rts_cache[16];
    struct { uint32_t pc; void *code; } branch_cache[128];

    /* Interpreter stuff */
    int icount;
    unsigned int ea;
    unsigned int delay;
    unsigned int test_irq;

    int pending_level;
    int pending_irl;
    int pending_int_irq;
    int pending_int_vector;
    int (*irq_callback)(struct SH2_ *sh2, int level);
    int is_slave;

    unsigned int cycles_timeslice;
    struct SH2_ *other_sh2;
    int (*run)(struct SH2_ *, int);

    /* 68k reference cycles */
    unsigned int m68krcycles_done;
    unsigned int mult_m68k_to_sh2;
    unsigned int mult_sh2_to_m68k;

    uint8_t data_array[0x1000];
    uint32_t peri_regs[0x200/4];

    /* Debug hooks (pdcore debugger support - NULL when no debugger attached) */
    int (*debug_check_breakpoint)(struct SH2_ *sh2);
    void *debug_context;
} SH2;

static SH2 stub_sh2_master = {0};
static SH2 stub_sh2_slave = {0};
static uint8_t stub_sdram[0x40000] = {0};
static uint8_t stub_dram[0x40000] = {0};

/* Bridge stubs */
void *picodrive_get_pico32x_state(void)
{
    return NULL;
}

void *picodrive_get_sh2_master(void)
{
    return &stub_sh2_master;
}

void *picodrive_get_sh2_slave(void)
{
    return &stub_sh2_slave;
}

void *picodrive_get_pico_state(void)
{
    return NULL;
}

void *picodrive_get_sdram(void)
{
    return stub_sdram;
}

void *picodrive_get_dram(void)
{
    return stub_dram;
}

unsigned int picodrive_get_sdram_size(void)
{
    return 0x40000;
}

unsigned int picodrive_get_dram_size(void)
{
    return 0x40000;
}

/* Minimal SH2 interpreter stub */
int sh2_execute_interpreter(void *sh2, int cycles)
{
    return cycles;
}
