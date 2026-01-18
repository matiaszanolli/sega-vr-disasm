/*
 * PicoDrive Function Stubs - For Integration Testing
 *
 * These stubs replace PicoDrive functions so tests can compile/run
 * without full PicoDrive build. They provide minimal functionality
 * for basic testing.
 *
 * In Phase 8, we'll link against real PicoDrive functions.
 */

#include <stdint.h>
#include <string.h>

/* Stub SH2 structure (minimal version for testing) */
typedef struct {
    uint32_t r[16] __attribute__((aligned(32)));
    uint32_t pc;
    uint32_t ppc;
    uint32_t pr;
    uint32_t sr;
    uint32_t gbr, vbr;
    uint32_t mach, macl;

    const void *read8_map;
    const void *read16_map;
    const void *read32_map;
    const void **write8_tab;
    const void **write16_tab;
    const void **write32_tab;

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

    int rts_cache_idx;
    struct { uint32_t pc; void *code; } rts_cache[16];
    struct { uint32_t pc; void *code; } branch_cache[128];

    int icount;
    unsigned int ea;
    unsigned int delay;
    unsigned int test_irq;

    int pending_level;
    int pending_irl;
    int pending_int_irq;
    int pending_int_vector;
    int (*irq_callback)(void *sh2, int level);
    int is_slave;

    unsigned int cycles_timeslice;
    void *other_sh2;
    int (*run)(void *, int);

    unsigned int m68krcycles_done;
    unsigned int mult_m68k_to_sh2;
    unsigned int mult_sh2_to_m68k;

    uint8_t data_array[0x1000];
    uint32_t peri_regs[0x200/4];

    int (*debug_check_breakpoint)(void *sh2);
    void *debug_context;
} SH2_stub;

/* Stub Genesis/Pico32x structure */
typedef struct {
    uint8_t dummy[4096];  /* Placeholder */
} Pico32x_stub;

/* Global stub instances */
static SH2_stub g_stub_msh2;
static SH2_stub g_stub_ssh2;
static Pico32x_stub g_stub_pico32x;
static uint8_t g_stub_sdram[0x40000];  /* 256 KB SDRAM */
static uint8_t g_stub_rom[0x400000];   /* 4 MB ROM */

/* Initialize stubs */
void __attribute__((constructor)) init_picodrive_stubs(void)
{
    memset(&g_stub_msh2, 0, sizeof(g_stub_msh2));
    memset(&g_stub_ssh2, 0, sizeof(g_stub_ssh2));
    memset(&g_stub_pico32x, 0, sizeof(g_stub_pico32x));
    memset(g_stub_sdram, 0, sizeof(g_stub_sdram));
    memset(g_stub_rom, 0, sizeof(g_stub_rom));

    /* Initialize Master SH2 */
    g_stub_msh2.pc = 0x06001000;
    g_stub_msh2.sr = 0x000000F0;
    g_stub_msh2.r[15] = 0x060FFF00;  /* SP */
    g_stub_msh2.is_slave = 0;
    g_stub_msh2.p_sdram = g_stub_sdram;
    g_stub_msh2.p_rom = g_stub_rom;

    /* Initialize Slave SH2 */
    g_stub_ssh2.pc = 0x06001000;
    g_stub_ssh2.sr = 0x000000F0;
    g_stub_ssh2.r[15] = 0x060FFE00;  /* SP */
    g_stub_ssh2.is_slave = 1;
    g_stub_ssh2.p_sdram = g_stub_sdram;
    g_stub_ssh2.p_rom = g_stub_rom;
}

/* Stub accessor functions */
void *picodrive_get_pico32x_state(void)
{
    return &g_stub_pico32x;
}

void *picodrive_get_sh2_master(void)
{
    return &g_stub_msh2;
}

void *picodrive_get_sh2_slave(void)
{
    return &g_stub_ssh2;
}

/* Stub memory access functions */
unsigned int p32x_sh2_read8(unsigned int address, void *sh2)
{
    (void)sh2;

    /* SDRAM range: 0x06000000-0x0603FFFF */
    if (address >= 0x06000000 && address < 0x06040000) {
        return g_stub_sdram[address - 0x06000000];
    }

    /* ROM range: 0x02000000-0x023FFFFF */
    if (address >= 0x02000000 && address < 0x02400000) {
        return g_stub_rom[address - 0x02000000];
    }

    /* Frame Buffer range: 0x04000000-0x0403FFFF */
    if (address >= 0x04000000 && address < 0x04040000) {
        return 0;  /* Frame buffer stub - return 0 */
    }

    /* Unknown address */
    return 0xFF;
}

void p32x_sh2_write8(unsigned int address, unsigned char data, void *sh2)
{
    (void)sh2;

    /* SDRAM range: 0x06000000-0x0603FFFF */
    if (address >= 0x06000000 && address < 0x06040000) {
        g_stub_sdram[address - 0x06000000] = data;
        return;
    }

    /* ROM range: 0x02000000-0x023FFFFF (ignore writes) */
    if (address >= 0x02000000 && address < 0x02400000) {
        return;  /* ROM is read-only */
    }

    /* Frame Buffer range: 0x04000000-0x0403FFFF */
    if (address >= 0x04000000 && address < 0x04040000) {
        return;  /* Frame buffer stub - ignore */
    }
}

/* Stub SH2 interpreter execution */
int sh2_execute_interpreter(void *sh2_ptr, int cycles)
{
    SH2_stub *sh2 = (SH2_stub *)sh2_ptr;
    int remaining = cycles;

    /* Simulate executing instructions */
    while (remaining > 0) {
        /* Check for breakpoint BEFORE executing instruction (matches real PicoDrive) */
        if (sh2->debug_check_breakpoint && sh2->debug_check_breakpoint(sh2)) {
            return cycles - remaining;  /* Return cycles executed before halt */
        }

        /* Execute one instruction (2 bytes, ~1 cycle average) */
        sh2->pc += 2;
        remaining -= 1;
    }

    return cycles;  /* Return total cycles executed */
}
