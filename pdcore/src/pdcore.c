/*
 * PicoDrive 32X Debugger Core - Implementation
 *
 * MVP-1: Core lifecycle, memory access, breakpoints, and execution control
 * P1/P2: Watchpoints, trace, events, GDB protocol
 */

#include "pdcore.h"
#include "pdcore_internal.h"
#include "pdcore_bp.h"

#include <stdlib.h>
#include <string.h>
#include <stdio.h>

/* External declarations for PicoDrive bridge functions
 * These are implemented in third_party/picodrive/pico/pdcore_bridge.c
 */
extern void *picodrive_get_pico32x_state(void);
extern void *picodrive_get_sh2_master(void);
extern void *picodrive_get_sh2_slave(void);
extern void *picodrive_get_pico_state(void);
extern void *picodrive_get_sdram(void);
extern void *picodrive_get_dram(void);
extern unsigned int picodrive_get_sdram_size(void);
extern unsigned int picodrive_get_dram_size(void);

/* Forward declarations for pdcore accessor wrappers */
void *pdcore_get_sdram(void);
void *pdcore_get_dram(void);

/* PicoDrive SH2 structure definition
 * Full structure from third_party/picodrive/cpu/sh2/sh2.h
 * This must match exactly for proper field access
 */
#ifndef PDCORE_SH2_DEFINED
#define PDCORE_SH2_DEFINED

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
#endif


/* ============================================================================
 * HELPER MACROS
 * ============================================================================
 */

#define PDCORE_ERROR(emu, fmt, ...) \
    snprintf((emu)->error_buf, sizeof((emu)->error_buf), fmt, ##__VA_ARGS__)

#define PDCORE_CHECK(condition, emu, code, fmt, ...) \
    if (!(condition)) { \
        PDCORE_ERROR(emu, fmt, ##__VA_ARGS__); \
        return code; \
    }


/* ============================================================================
 * GLOBAL STATE
 * ============================================================================
 */

/* Global emulator instance
 * Used to map from SH2* back to pd_t in breakpoint/V-BLANK callbacks
 * Shared with pdcore_exec.c
 */
pd_t *g_pdcore_emu = NULL;


/* ============================================================================
 * LIFECYCLE - INITIALIZATION & CLEANUP
 * ============================================================================
 */

/**
 * Create emulator instance with default or custom configuration
 */
pd_t *pd_create(const pd_config_t *config)
{
    pd_t *emu = malloc(sizeof(pd_t));
    if (!emu) return NULL;

    memset(emu, 0, sizeof(pd_t));

    /* Store configuration */
    if (config) {
        emu->config = *config;
    } else {
        memset(&emu->config, 0, sizeof(pd_config_t));
        emu->config.deterministic = 1;  /* Default: deterministic execution */
    }

    /* Initialize breakpoint arrays */
    emu->bp_array_master = malloc(sizeof(pdcore_breakpoint_array_t));
    emu->bp_array_slave = malloc(sizeof(pdcore_breakpoint_array_t));

    if (!emu->bp_array_master || !emu->bp_array_slave) {
        free(emu->bp_array_master);
        free(emu->bp_array_slave);
        free(emu);
        return NULL;
    }

    pdcore_bp_init((pdcore_breakpoint_array_t *)emu->bp_array_master);
    pdcore_bp_init((pdcore_breakpoint_array_t *)emu->bp_array_slave);

    /* Store SH2 references */
    emu->master_sh2 = pdcore_get_sh2_master();
    emu->slave_sh2 = pdcore_get_sh2_slave();

    /* Set global for callbacks */
    g_pdcore_emu = emu;

    return emu;
}

/**
 * Destroy emulator instance
 */
void pd_destroy(pd_t *emu)
{
    if (!emu) return;

    if (emu == g_pdcore_emu) {
        g_pdcore_emu = NULL;
    }

    free(emu->bp_array_master);
    free(emu->bp_array_slave);
    free(emu);
}


/* ============================================================================
 * ROM LOADING
 * ============================================================================
 */

/**
 * Load ROM from memory buffer
 */
int pd_load_rom(pd_t *emu, const void *data, size_t size)
{
    if (!emu) return PD_ERR_INVALID_PARAM;
    if (!data || size == 0) return PD_ERR_INVALID_PARAM;

    PDCORE_ERROR(emu, "Not implemented");
    return PD_ERR_UNSUPPORTED;
}

/**
 * Load ROM from file
 */
int pd_load_rom_file(pd_t *emu, const char *path)
{
    FILE *f;
    void *data;
    size_t size;
    int ret;

    if (!emu || !path) return PD_ERR_INVALID_PARAM;

    /* Open file */
    f = fopen(path, "rb");
    if (!f) {
        PDCORE_ERROR(emu, "Cannot open file: %s", path);
        return PD_ERR_INVALID_PARAM;
    }

    /* Get file size */
    fseek(f, 0, SEEK_END);
    size = ftell(f);
    fseek(f, 0, SEEK_SET);

    /* Allocate buffer */
    data = malloc(size);
    if (!data) {
        fclose(f);
        PDCORE_ERROR(emu, "Out of memory");
        return PD_ERR_OUT_OF_MEMORY;
    }

    /* Read file */
    if (fread(data, size, 1, f) != 1) {
        free(data);
        fclose(f);
        PDCORE_ERROR(emu, "Cannot read file: %s", path);
        return PD_ERR_INVALID_PARAM;
    }

    fclose(f);

    /* Load ROM */
    ret = pd_load_rom(emu, data, size);
    free(data);

    return ret;
}

/**
 * Reset emulation state
 */
int pd_reset(pd_t *emu)
{
    if (!emu) return PD_ERR_INVALID_PARAM;

    /* TODO: Reset PicoDrive state */
    emu->frame_count = 0;
    emu->master_cycles = 0;
    emu->master_instructions = 0;
    emu->halt_requested = 0;

    return 0;
}


/* ============================================================================
 * EXECUTION CONTROL
 * ============================================================================
 */

/* Execution control functions are implemented in pdcore_exec.c
 * Declarations here for reference:
 * - pd_run_cycles()
 * - pd_run_frames()
 * - pd_step_instruction()
 */

/**
 * Run until condition
 */
pd_stop_reason_t pd_run_until(pd_t *emu, uint64_t cycle_limit, pd_stop_info_t *out_stop_info)
{
    if (!emu || !out_stop_info) return PD_STOP_NONE;

    /* Simply delegate to pd_run_cycles */
    return pd_run_cycles(emu, cycle_limit, out_stop_info);
}

/**
 * Halt execution
 */
void pd_halt(pd_t *emu)
{
    if (emu) {
        emu->halt_requested = 1;
    }
}


/* ============================================================================
 * CPU STATE ACCESS
 * ============================================================================
 */

/**
 * Read all SH2 registers
 */
int pd_get_sh2_regs(pd_t *emu, pd_cpu_t cpu, pd_sh2_regs_t *out)
{
    SH2 *sh2;
    int i;

    if (!emu || !out) return PD_ERR_INVALID_PARAM;

    memset(out, 0, sizeof(pd_sh2_regs_t));

    /* Get SH2 instance */
    if (cpu == PD_CPU_MASTER) {
        sh2 = pdcore_get_sh2_master();
    } else if (cpu == PD_CPU_SLAVE) {
        sh2 = pdcore_get_sh2_slave();
    } else {
        PDCORE_ERROR(emu, "Invalid CPU specified");
        return PD_ERR_INVALID_PARAM;
    }

    if (!sh2) {
        PDCORE_ERROR(emu, "SH2 not initialized");
        return PD_ERR_UNSUPPORTED;
    }

    /* Copy general purpose registers */
    for (i = 0; i < 16; i++) {
        out->r[i] = sh2->r[i];
    }

    /* Copy special registers */
    out->pc = sh2->pc;
    out->sr = sh2->sr;
    out->pr = sh2->pr;
    out->gbr = sh2->gbr;
    out->vbr = sh2->vbr;
    out->mach = sh2->mach;
    out->macl = sh2->macl;

    /* Copy informational fields */
    if (cpu == PD_CPU_MASTER) {
        out->cycle_count = (uint32_t)emu->master_cycles;
        out->instruction_count = (uint32_t)emu->master_instructions;
    } else {
        out->cycle_count = (uint32_t)emu->slave_cycles;
        out->instruction_count = 0;  /* Not tracked for slave */
    }

    out->in_delay_slot = (sh2->delay != 0) ? 1 : 0;
    out->in_interrupt = (sh2->pending_level > 0) ? 1 : 0;

    return 0;
}

/**
 * Write all SH2 registers
 */
int pd_set_sh2_regs(pd_t *emu, pd_cpu_t cpu, const pd_sh2_regs_t *in)
{
    SH2 *sh2;
    int i;

    if (!emu || !in) return PD_ERR_INVALID_PARAM;

    /* Get SH2 instance */
    if (cpu == PD_CPU_MASTER) {
        sh2 = pdcore_get_sh2_master();
    } else if (cpu == PD_CPU_SLAVE) {
        sh2 = pdcore_get_sh2_slave();
    } else {
        PDCORE_ERROR(emu, "Invalid CPU specified");
        return PD_ERR_INVALID_PARAM;
    }

    if (!sh2) {
        PDCORE_ERROR(emu, "SH2 not initialized");
        return PD_ERR_UNSUPPORTED;
    }

    /* Copy general purpose registers */
    for (i = 0; i < 16; i++) {
        sh2->r[i] = in->r[i];
    }

    /* Copy special registers */
    sh2->pc = in->pc;
    sh2->sr = in->sr;
    sh2->pr = in->pr;
    sh2->gbr = in->gbr;
    sh2->vbr = in->vbr;
    sh2->mach = in->mach;
    sh2->macl = in->macl;

    /* Note: cycle_count, instruction_count, in_delay_slot, in_interrupt
     * are read-only informational fields and are not written back
     */

    return 0;
}

/**
 * Read single register
 */
uint32_t pd_get_sh2_reg(pd_t *emu, pd_cpu_t cpu, int reg)
{
    pd_sh2_regs_t regs;

    if (pd_get_sh2_regs(emu, cpu, &regs) != 0) {
        return 0;
    }

    if (reg >= 0 && reg < 16) {
        return regs.r[reg];
    } else if (reg == 16) {
        return regs.pc;
    } else if (reg == 17) {
        return regs.sr;
    }

    return 0;
}

/**
 * Write single register
 */
int pd_set_sh2_reg(pd_t *emu, pd_cpu_t cpu, int reg, uint32_t value)
{
    pd_sh2_regs_t regs;

    if (pd_get_sh2_regs(emu, cpu, &regs) != 0) {
        return -1;
    }

    if (reg >= 0 && reg < 16) {
        regs.r[reg] = value;
    } else if (reg == 16) {
        regs.pc = value;
    } else if (reg == 17) {
        regs.sr = value;
    } else {
        return -1;
    }

    return pd_set_sh2_regs(emu, cpu, &regs);
}


/* ============================================================================
 * MEMORY ACCESS
 * ============================================================================
 */

/* External declarations for PicoDrive memory handlers
 * These are implemented in PicoDrive's memory.c/32x/memory.c
 */
extern uint32_t p32x_sh2_read8(uint32_t a, SH2 *sh2);
extern uint32_t p32x_sh2_read16(uint32_t a, SH2 *sh2);
extern uint32_t p32x_sh2_read32(uint32_t a, SH2 *sh2);
extern void p32x_sh2_write8(uint32_t a, uint32_t d, SH2 *sh2);
extern void p32x_sh2_write16(uint32_t a, uint32_t d, SH2 *sh2);
extern void p32x_sh2_write32(uint32_t a, uint32_t d, SH2 *sh2);

/**
 * Read from memory bus
 */
int pd_mem_read(pd_t *emu, pd_bus_t bus, uint32_t address, void *out_buf, size_t size)
{
    void *src = NULL;
    size_t available = 0;
    size_t offset = 0;

    if (!emu || !out_buf) return PD_ERR_INVALID_PARAM;
    if (size == 0) return 0;

    switch (bus) {
        case PD_BUS_SH2_SDRAM:
        case PD_BUS_SH2_SDRAM_WT:
            src = pdcore_get_sdram();
            if (!src) {
                PDCORE_ERROR(emu, "SDRAM not available");
                return PD_ERR_INVALID_ADDRESS;
            }
            /* SDRAM is at 0x06000000 in SH2 space, 256KB */
            if (address >= 0x06000000 && address < 0x06040000) {
                offset = address - 0x06000000;
                available = 0x40000 - offset;  /* 256KB */
            } else if (address >= 0x26000000 && address < 0x26040000) {
                /* Cache-through mirror */
                offset = address - 0x26000000;
                available = 0x40000 - offset;
            } else {
                PDCORE_ERROR(emu, "Invalid SDRAM address: 0x%08x", address);
                return PD_ERR_INVALID_ADDRESS;
            }
            break;

        case PD_BUS_SH2_FB:
            src = pdcore_get_dram();
            if (!src) {
                PDCORE_ERROR(emu, "Frame buffer not available");
                return PD_ERR_INVALID_ADDRESS;
            }
            /* Frame buffers at 0x04000000 / 0x04020000, 128KB each */
            if (address >= 0x04000000 && address < 0x04040000) {
                offset = address - 0x04000000;
                available = 0x40000 - offset;  /* 256KB total */
            } else if (address >= 0x24000000 && address < 0x24040000) {
                /* Cache-through mirror */
                offset = address - 0x24000000;
                available = 0x40000 - offset;
            } else {
                PDCORE_ERROR(emu, "Invalid FB address: 0x%08x", address);
                return PD_ERR_INVALID_ADDRESS;
            }
            break;

        case PD_BUS_SH2_ROM:
            /* ROM access - read from loaded ROM data */
            /* For now, not implemented - ROM is in separate buffer */
            PDCORE_ERROR(emu, "ROM bus access not yet implemented");
            return PD_ERR_UNSUPPORTED;

        case PD_BUS_SH2_SYS:
            /* System registers - special handling needed */
            PDCORE_ERROR(emu, "System register access not yet implemented");
            return PD_ERR_UNSUPPORTED;

        case PD_BUS_68K:
            /* 68K address space - not needed for Phase 11 */
            PDCORE_ERROR(emu, "68K bus access not yet implemented");
            return PD_ERR_UNSUPPORTED;

        default:
            PDCORE_ERROR(emu, "Unknown bus type: %d", bus);
            return PD_ERR_INVALID_PARAM;
    }

    /* Calculate how much to read */
    size_t to_read = (size > available) ? available : size;
    memcpy(out_buf, (uint8_t *)src + offset, to_read);

    return (int)to_read;
}

/**
 * Write to memory bus
 */
int pd_mem_write(pd_t *emu, pd_bus_t bus, uint32_t address, const void *data, size_t size)
{
    void *dst = NULL;
    size_t available = 0;
    size_t offset = 0;

    if (!emu || !data) return PD_ERR_INVALID_PARAM;
    if (size == 0) return 0;

    switch (bus) {
        case PD_BUS_SH2_SDRAM:
        case PD_BUS_SH2_SDRAM_WT:
            dst = pdcore_get_sdram();
            if (!dst) {
                PDCORE_ERROR(emu, "SDRAM not available");
                return PD_ERR_INVALID_ADDRESS;
            }
            if (address >= 0x06000000 && address < 0x06040000) {
                offset = address - 0x06000000;
                available = 0x40000 - offset;
            } else if (address >= 0x26000000 && address < 0x26040000) {
                offset = address - 0x26000000;
                available = 0x40000 - offset;
            } else {
                PDCORE_ERROR(emu, "Invalid SDRAM address: 0x%08x", address);
                return PD_ERR_INVALID_ADDRESS;
            }
            break;

        case PD_BUS_SH2_FB:
            dst = pdcore_get_dram();
            if (!dst) {
                PDCORE_ERROR(emu, "Frame buffer not available");
                return PD_ERR_INVALID_ADDRESS;
            }
            if (address >= 0x04000000 && address < 0x04040000) {
                offset = address - 0x04000000;
                available = 0x40000 - offset;
            } else if (address >= 0x24000000 && address < 0x24040000) {
                offset = address - 0x24000000;
                available = 0x40000 - offset;
            } else {
                PDCORE_ERROR(emu, "Invalid FB address: 0x%08x", address);
                return PD_ERR_INVALID_ADDRESS;
            }
            break;

        default:
            PDCORE_ERROR(emu, "Write to bus %d not supported", bus);
            return PD_ERR_UNSUPPORTED;
    }

    size_t to_write = (size > available) ? available : size;
    memcpy((uint8_t *)dst + offset, data, to_write);

    return (int)to_write;
}

/**
 * Read 32-bit word
 */
uint32_t pd_mem_read_u32(pd_t *emu, pd_bus_t bus, uint32_t address)
{
    uint32_t value = 0;
    pd_mem_read(emu, bus, address, &value, 4);
    return value;
}

/**
 * Write 32-bit word
 */
int pd_mem_write_u32(pd_t *emu, pd_bus_t bus, uint32_t address, uint32_t value)
{
    return pd_mem_write(emu, bus, address, &value, 4);
}

/**
 * Get bus information
 */
int pd_get_bus_info(pd_t *emu, pd_bus_t bus, pd_bus_info_t *out)
{
    if (!emu || !out) return PD_ERR_INVALID_PARAM;

    memset(out, 0, sizeof(pd_bus_info_t));

    switch (bus) {
        case PD_BUS_SH2_ROM:
            out->name = "SH2 ROM";
            out->start = 0x02000000;
            out->size = 4 * 1024 * 1024;  /* 4 MB max */
            break;

        case PD_BUS_SH2_SDRAM:
            out->name = "SH2 SDRAM (cached)";
            out->start = 0x06000000;
            out->size = 256 * 1024;  /* 256 KB */
            break;

        case PD_BUS_SH2_SDRAM_WT:
            out->name = "SH2 SDRAM (write-through)";
            out->start = 0x26000000;
            out->size = 256 * 1024;  /* 256 KB */
            break;

        case PD_BUS_SH2_FB:
            out->name = "SH2 Frame Buffer";
            out->start = 0x04000000;
            out->size = 128 * 1024;  /* 2x 64KB frame buffers */
            break;

        case PD_BUS_SH2_SYS:
            out->name = "SH2 System Registers";
            out->start = 0x20000000;
            out->size = 256;  /* Small register space */
            break;

        case PD_BUS_68K:
            out->name = "68000 Address Space";
            out->start = 0x00000000;
            out->size = 16 * 1024 * 1024;  /* 16 MB */
            break;

        default:
            PDCORE_ERROR(emu, "Unknown bus type");
            return PD_ERR_UNSUPPORTED;
    }

    return 0;
}

/**
 * Create memory snapshot
 */
void *pd_mem_snapshot(pd_t *emu, pd_bus_t bus, uint32_t address, size_t size)
{
    void *snapshot = malloc(size);
    if (!snapshot) return NULL;

    if (pd_mem_read(emu, bus, address, snapshot, size) < 0) {
        free(snapshot);
        return NULL;
    }

    return snapshot;
}


/* ============================================================================
 * BREAKPOINTS
 * ============================================================================
 */

/**
 * Breakpoint dispatcher callback
 * Called from SH2 execution loop on every instruction
 * Returns: 1 to halt execution, 0 to continue
 */
static int pdcore_breakpoint_dispatcher(SH2 *sh2)
{
    pdcore_breakpoint_array_t *arr;
    pdcore_breakpoint_t *bp;
    uint32_t pc;
    pd_cpu_t cpu;
    pd_t *emu = g_pdcore_emu;

    if (!emu || !sh2) return 0;

    /* Determine which CPU this is */
    cpu = sh2->is_slave ? PD_CPU_SLAVE : PD_CPU_MASTER;

    /* Get breakpoint array for this CPU */
    if (cpu == PD_CPU_MASTER) {
        arr = (pdcore_breakpoint_array_t *)emu->bp_array_master;
    } else {
        arr = (pdcore_breakpoint_array_t *)emu->bp_array_slave;
    }

    if (!arr) return 0;

    /* Get current PC */
    pc = sh2->pc;

    /* Look up breakpoint at this address */
    bp = pdcore_bp_find(arr, pc);
    if (!bp || !bp->active) {
        return 0;  /* No breakpoint or inactive - continue execution */
    }

    /* Breakpoint hit! Call user's handler */
    if (bp->handler) {
        pd_breakpoint_action_t action = bp->handler(emu, cpu, pc, bp->user_data);

        /* Check what the handler wants us to do */
        if (action == PD_BP_HALT) {
            emu->halt_requested = 1;
            return 1;  /* Stop execution */
        } else if (action == PD_BP_CONTINUE) {
            return 0;  /* Continue execution */
        } else if (action == PD_BP_DISABLE) {
            /* Disable this breakpoint and continue */
            bp->active = 0;
            return 0;
        }
    }

    /* Default: halt on breakpoint */
    emu->halt_requested = 1;
    return 1;
}

/**
 * Attach breakpoint callback to SH2
 * Only attaches if not already attached
 */
static void pdcore_attach_breakpoint_callback(pd_t *emu, pd_cpu_t cpu)
{
    SH2 *sh2;

    if (!emu) return;

    /* Get SH2 instance */
    if (cpu == PD_CPU_MASTER) {
        sh2 = pdcore_get_sh2_master();
    } else if (cpu == PD_CPU_SLAVE) {
        sh2 = pdcore_get_sh2_slave();
    } else {
        return;
    }

    if (!sh2) return;

    /* Install callback if not already installed */
    if (sh2->debug_check_breakpoint == NULL) {
        sh2->debug_check_breakpoint = pdcore_breakpoint_dispatcher;
        sh2->debug_context = emu;
        g_pdcore_emu = emu;  /* Store global reference for dispatcher */
    }
}

/**
 * Detach breakpoint callback from SH2
 */
static void pdcore_detach_breakpoint_callback(pd_t *emu, pd_cpu_t cpu)
{
    SH2 *sh2;

    if (!emu) return;

    /* Get SH2 instance */
    if (cpu == PD_CPU_MASTER) {
        sh2 = pdcore_get_sh2_master();
    } else if (cpu == PD_CPU_SLAVE) {
        sh2 = pdcore_get_sh2_slave();
    } else {
        return;
    }

    if (!sh2) return;

    /* Detach callback */
    sh2->debug_check_breakpoint = NULL;
    sh2->debug_context = NULL;
}

/**
 * Add execution breakpoint
 */
int pd_bp_exec_add(pd_t *emu, pd_cpu_t cpu, uint32_t address,
                   pd_breakpoint_handler_t handler, void *user_data)
{
    pdcore_breakpoint_array_t *arr;

    if (!emu || !handler) return PD_ERR_INVALID_PARAM;

    /* Select correct array */
    if (cpu == PD_CPU_MASTER) {
        arr = (pdcore_breakpoint_array_t *)emu->bp_array_master;
    } else if (cpu == PD_CPU_SLAVE) {
        arr = (pdcore_breakpoint_array_t *)emu->bp_array_slave;
    } else {
        PDCORE_ERROR(emu, "Invalid CPU");
        return PD_ERR_INVALID_PARAM;
    }

    /* Add to array */
    int bp_id = pdcore_bp_add(arr, address, handler, user_data);
    if (bp_id < 0) {
        PDCORE_ERROR(emu, "Cannot add breakpoint (limit reached?)");
        return bp_id;
    }

    /* Attach callback to SH2 (if not already attached) */
    pdcore_attach_breakpoint_callback(emu, cpu);

    return bp_id;
}

/**
 * Remove execution breakpoint
 */
int pd_bp_exec_del(pd_t *emu, pd_cpu_t cpu, uint32_t address)
{
    pdcore_breakpoint_array_t *arr;

    if (!emu) return PD_ERR_INVALID_PARAM;

    if (cpu == PD_CPU_MASTER) {
        arr = (pdcore_breakpoint_array_t *)emu->bp_array_master;
    } else if (cpu == PD_CPU_SLAVE) {
        arr = (pdcore_breakpoint_array_t *)emu->bp_array_slave;
    } else {
        return PD_ERR_INVALID_PARAM;
    }

    return pdcore_bp_del(arr, address);
}

/**
 * Clear all breakpoints
 */
int pd_bp_exec_clear(pd_t *emu, pd_cpu_t cpu)
{
    if (!emu) return PD_ERR_INVALID_PARAM;

    if (cpu == PD_CPU_MASTER) {
        pdcore_bp_clear((pdcore_breakpoint_array_t *)emu->bp_array_master);
        /* Detach callback when no breakpoints remain */
        pdcore_detach_breakpoint_callback(emu, PD_CPU_MASTER);
    } else if (cpu == PD_CPU_SLAVE) {
        pdcore_bp_clear((pdcore_breakpoint_array_t *)emu->bp_array_slave);
        /* Detach callback when no breakpoints remain */
        pdcore_detach_breakpoint_callback(emu, PD_CPU_SLAVE);
    } else {
        return PD_ERR_INVALID_PARAM;
    }

    return 0;
}

/**
 * Check if breakpoint exists
 */
int pd_bp_exec_exists(pd_t *emu, pd_cpu_t cpu, uint32_t address)
{
    pdcore_breakpoint_array_t *arr;

    if (!emu) return 0;

    if (cpu == PD_CPU_MASTER) {
        arr = (pdcore_breakpoint_array_t *)emu->bp_array_master;
    } else if (cpu == PD_CPU_SLAVE) {
        arr = (pdcore_breakpoint_array_t *)emu->bp_array_slave;
    } else {
        return 0;
    }

    return pdcore_bp_find(arr, address) != NULL ? 1 : 0;
}


/* ============================================================================
 * ERROR HANDLING
 * ============================================================================
 */

/**
 * Get last error message
 */
const char *pd_get_error(pd_t *emu)
{
    return emu ? emu->error_buf : "NULL emulator";
}

/**
 * Clear error state
 */
void pd_clear_error(pd_t *emu)
{
    if (emu) {
        emu->error_buf[0] = 0;
    }
}


/* ============================================================================
 * INTERNAL IMPLEMENTATIONS
 * ============================================================================
 */

/**
 * PicoDrive accessor functions
 * These bridge to PicoDrive's internal state via pdcore_bridge.c
 */

// Forward declarations of bridge functions (implemented in PicoDrive source)
// Note: We can't use the same names due to forward declaration conflicts,
// so the bridge uses different internal names
extern void *picodrive_get_pico32x_state(void);
extern void *picodrive_get_sh2_master(void);
extern void *picodrive_get_sh2_slave(void);
extern void *picodrive_get_pico_state(void);

Genesis_State *pdcore_get_genesis_state(void)
{
    // Note: In PicoDrive, the "genesis state" is the Pico32x structure
    return (Genesis_State *)picodrive_get_pico32x_state();
}

SH2 *pdcore_get_sh2_master(void)
{
    return (SH2 *)picodrive_get_sh2_master();
}

SH2 *pdcore_get_sh2_slave(void)
{
    return (SH2 *)picodrive_get_sh2_slave();
}

void *pdcore_get_sdram(void)
{
    return picodrive_get_sdram();
}

void *pdcore_get_dram(void)
{
    return picodrive_get_dram();
}
