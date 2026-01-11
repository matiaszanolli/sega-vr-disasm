/*
 * PicoDrive Debugger Core - Execution Control Implementation
 *
 * Execution control functions for running emulation with cycle/frame precision
 */

#include "pdcore.h"
#include "pdcore_internal.h"
#include <string.h>

/* PicoDrive SH2 structure definition (must match pdcore.c) */
#define ALIGNED(n) __attribute__((aligned(n)))

typedef struct SH2_ {
    uint32_t r[16] ALIGNED(32);
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
    int (*irq_callback)(struct SH2_ *sh2, int level);
    int is_slave;

    unsigned int cycles_timeslice;
    struct SH2_ *other_sh2;
    int (*run)(struct SH2_ *, int);

    unsigned int m68krcycles_done;
    unsigned int mult_m68k_to_sh2;
    unsigned int mult_sh2_to_m68k;

    uint8_t data_array[0x1000];
    uint32_t peri_regs[0x200/4];

    int (*debug_check_breakpoint)(struct SH2_ *sh2);
    void *debug_context;
} SH2;

/* External declarations for PicoDrive execution functions */
extern int sh2_execute_interpreter(SH2 *sh2, int cycles);

/* V-BLANK callback state (set by V-BLANK handler) */
static int g_vblank_triggered = 0;
extern pd_t *g_pdcore_emu;  /* From pdcore.c */

/**
 * V-BLANK callback handler
 * Called from PicoDrive when V-BLANK occurs
 */
void pdcore_vblank_handler(void)
{
    pd_t *emu = g_pdcore_emu;
    if (emu) {
        emu->frame_count++;
        g_vblank_triggered = 1;
    }
}

/**
 * Attach V-BLANK callback to Pico32x
 */
int pdcore_attach_vblank_callback(pd_t *emu)
{
    /* Placeholder - will be implemented when we have Pico32x structure */
    (void)emu;
    return 0;
}

/**
 * Run for N cycles
 */
pd_stop_reason_t pd_run_cycles(pd_t *emu, uint64_t cycles, pd_stop_info_t *out_stop_info)
{
    SH2 *sh2_master, *sh2_slave;
    uint64_t cycles_remaining;
    int cycles_per_slice;
    int cycles_executed;

    if (!emu || !out_stop_info) return PD_STOP_NONE;

    memset(out_stop_info, 0, sizeof(pd_stop_info_t));

    /* Get SH2 instances */
    sh2_master = pdcore_get_sh2_master();
    sh2_slave = pdcore_get_sh2_slave();

    if (!sh2_master) {
        out_stop_info->reason = PD_STOP_NONE;
        return PD_STOP_NONE;
    }

    /* Reset halt flag */
    emu->halt_requested = 0;
    cycles_remaining = cycles;

    /* Execute in slices to allow halt detection */
    while (cycles_remaining > 0 && !emu->halt_requested) {
        /* Execute up to 1000 cycles at a time for responsiveness */
        cycles_per_slice = (cycles_remaining > 1000) ? 1000 : (int)cycles_remaining;

        /* Execute Master SH2 */
        if (sh2_master->run) {
            cycles_executed = sh2_master->run(sh2_master, cycles_per_slice);
        } else {
            cycles_executed = sh2_execute_interpreter(sh2_master, cycles_per_slice);
        }

        emu->master_cycles += cycles_executed;
        emu->master_instructions++;
        cycles_remaining -= cycles_executed;

        /* Execute Slave SH2 (optional) */
        if (sh2_slave && sh2_slave->run) {
            sh2_slave->run(sh2_slave, cycles_per_slice);
        }

        /* Check for halt */
        if (emu->halt_requested) {
            out_stop_info->reason = PD_STOP_HALT;
            out_stop_info->master_cycles = emu->master_cycles;
            out_stop_info->frame_number = emu->frame_count;
            return PD_STOP_HALT;
        }
    }

    /* Normal completion */
    out_stop_info->reason = PD_STOP_CYCLE_LIMIT;
    out_stop_info->master_cycles = emu->master_cycles;
    out_stop_info->frame_number = emu->frame_count;

    return PD_STOP_CYCLE_LIMIT;
}

/**
 * Run for N frames
 */
pd_stop_reason_t pd_run_frames(pd_t *emu, uint32_t frame_count, pd_stop_info_t *out_stop_info)
{
    uint32_t target_frame;
    uint32_t frames_completed;
    pd_stop_reason_t reason;

    if (!emu || !out_stop_info) return PD_STOP_NONE;

    memset(out_stop_info, 0, sizeof(pd_stop_info_t));

    /* Attach V-BLANK callback */
    pdcore_attach_vblank_callback(emu);

    target_frame = emu->frame_count + frame_count;
    frames_completed = 0;
    g_vblank_triggered = 0;

    /* Execute until target frame reached */
    while (emu->frame_count < target_frame && !emu->halt_requested) {
        reason = pd_run_cycles(emu, 400000, out_stop_info);

        if (g_vblank_triggered) {
            frames_completed++;
            g_vblank_triggered = 0;
        }

        if (reason == PD_STOP_HALT) {
            out_stop_info->reason = PD_STOP_HALT;
            return PD_STOP_HALT;
        }

        /* Safety check */
        if (emu->master_cycles > (emu->frame_count + frames_completed + 2) * 500000) {
            break;
        }
    }

    out_stop_info->reason = PD_STOP_FRAME_BOUNDARY;
    out_stop_info->frame_number = emu->frame_count;
    out_stop_info->master_cycles = emu->master_cycles;

    return PD_STOP_FRAME_BOUNDARY;
}

/**
 * Single instruction step
 */
pd_stop_reason_t pd_step_instruction(pd_t *emu, pd_cpu_t cpu, pd_stop_info_t *out_stop_info)
{
    SH2 *sh2;
    uint32_t pc_after;
    int cycles;

    if (!emu || !out_stop_info) return PD_STOP_NONE;

    memset(out_stop_info, 0, sizeof(pd_stop_info_t));

    /* Get SH2 instance */
    if (cpu == PD_CPU_MASTER) {
        sh2 = pdcore_get_sh2_master();
    } else if (cpu == PD_CPU_SLAVE) {
        sh2 = pdcore_get_sh2_slave();
    } else {
        out_stop_info->reason = PD_STOP_NONE;
        return PD_STOP_NONE;
    }

    if (!sh2) {
        out_stop_info->reason = PD_STOP_NONE;
        return PD_STOP_NONE;
    }

    /* Execute 10 cycles (enough for 1 instruction + delay slot) */
    if (sh2->run) {
        cycles = sh2->run(sh2, 10);
    } else {
        cycles = sh2_execute_interpreter(sh2, 10);
    }

    pc_after = sh2->pc;

    /* Update cycle count */
    if (cpu == PD_CPU_MASTER) {
        emu->master_cycles += cycles;
        emu->master_instructions++;
    }

    /* Fill stop info */
    out_stop_info->reason = PD_STOP_HALT;
    out_stop_info->cpu = cpu;
    out_stop_info->address = pc_after;
    out_stop_info->master_cycles = emu->master_cycles;
    out_stop_info->frame_number = emu->frame_count;

    return PD_STOP_HALT;
}
