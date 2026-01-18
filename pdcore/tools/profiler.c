/*
 * SH2 Function Profiler
 *
 * Uses pdcore to measure cycle counts at hotspot functions
 * for Virtua Racing Deluxe optimization baseline.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "../include/pdcore.h"

/* Profiling targets - VRD hotspot functions */
typedef struct {
    const char *name;
    uint32_t address;
    uint32_t call_count;
    uint64_t total_cycles;
    uint64_t min_cycles;
    uint64_t max_cycles;
    uint64_t entry_cycle;  /* For measuring duration */
} profile_target_t;

static profile_target_t g_targets[] = {
    { "func_016 (coord transform)", 0x0222335A, 0, 0, UINT64_MAX, 0, 0 },
    { "func_065 (rasterization)",   0x02223F2C, 0, 0, UINT64_MAX, 0, 0 },
    { "func_020 (polygon recurse)", 0x02223468, 0, 0, UINT64_MAX, 0, 0 },
    { "main_loop (frame start)",    0x02224000, 0, 0, UINT64_MAX, 0, 0 },
    { NULL, 0, 0, 0, 0, 0, 0 }
};

static pd_t *g_emu = NULL;
static int g_frames_profiled = 0;
static uint64_t g_total_frame_cycles = 0;

/* Breakpoint handler - called when we hit a profiled function */
static pd_breakpoint_action_t profile_handler(
    pd_t *emu, pd_cpu_t cpu, uint32_t pc, void *user_data)
{
    profile_target_t *target = (profile_target_t *)user_data;
    pd_stop_info_t info;

    (void)cpu;
    (void)pc;

    /* Get current cycle count */
    pd_run_cycles(emu, 0, &info);  /* Just to get cycle count */
    uint64_t current_cycle = info.master_cycles;

    /* If this is entry (first time at this PC), record start */
    if (target->entry_cycle == 0) {
        target->entry_cycle = current_cycle;
        target->call_count++;
    }

    /* Continue execution - we're just counting */
    return PD_BP_CONTINUE;
}

static void print_results(void)
{
    printf("\n");
    printf("╔════════════════════════════════════════════════════════════════════╗\n");
    printf("║  VRD SH2 Profiling Results                                         ║\n");
    printf("╚════════════════════════════════════════════════════════════════════╝\n\n");

    printf("Frames profiled: %d\n", g_frames_profiled);
    if (g_frames_profiled > 0) {
        printf("Average cycles/frame: %lu\n\n",
               (unsigned long)(g_total_frame_cycles / g_frames_profiled));
    }

    printf("%-30s %10s %12s %12s %12s\n",
           "Function", "Calls", "Total Cyc", "Avg Cyc", "% Frame");
    printf("%-30s %10s %12s %12s %12s\n",
           "------------------------------", "----------", "------------",
           "------------", "------------");

    for (int i = 0; g_targets[i].name != NULL; i++) {
        profile_target_t *t = &g_targets[i];
        if (t->call_count > 0) {
            uint64_t avg = t->total_cycles / t->call_count;
            double pct = g_total_frame_cycles > 0 ?
                         (double)t->total_cycles / (double)g_total_frame_cycles * 100.0 : 0.0;

            printf("%-30s %10u %12lu %12lu %11.2f%%\n",
                   t->name,
                   t->call_count,
                   (unsigned long)t->total_cycles,
                   (unsigned long)avg,
                   pct);
        } else {
            printf("%-30s %10s %12s %12s %12s\n",
                   t->name, "0", "-", "-", "-");
        }
    }

    printf("\n");
}

int main(int argc, char **argv)
{
    int frames_to_run = 300;  /* ~5 seconds at 60 FPS */

    printf("VRD SH2 Function Profiler\n");
    printf("=========================\n\n");

    if (argc > 1) {
        frames_to_run = atoi(argv[1]);
    }

    printf("Will profile for %d frames\n\n", frames_to_run);

    /* Create emulator */
    pd_config_t config = {0};
    config.deterministic = 1;
    g_emu = pd_create(&config);

    if (!g_emu) {
        fprintf(stderr, "Failed to create emulator\n");
        return 1;
    }

    /* Set breakpoints on all target functions */
    printf("Setting breakpoints:\n");
    for (int i = 0; g_targets[i].name != NULL; i++) {
        int bp_id = pd_bp_exec_add(g_emu, PD_CPU_MASTER,
                                    g_targets[i].address,
                                    profile_handler,
                                    &g_targets[i]);
        if (bp_id >= 0) {
            printf("  ✓ %s @ 0x%08X\n", g_targets[i].name, g_targets[i].address);
        } else {
            printf("  ✗ %s @ 0x%08X (failed)\n", g_targets[i].name, g_targets[i].address);
        }
    }

    printf("\nRunning emulation...\n");

    /* Run for specified frames */
    pd_stop_info_t stop_info;
    pd_stop_reason_t reason = pd_run_frames(g_emu, frames_to_run, &stop_info);

    printf("Stopped: reason=%d, frames=%u, cycles=%lu\n",
           reason, stop_info.frame_number,
           (unsigned long)stop_info.master_cycles);

    /* Print results */
    g_frames_profiled = stop_info.frame_number;
    g_total_frame_cycles = stop_info.master_cycles;
    print_results();

    /* Cleanup */
    pd_destroy(g_emu);

    return 0;
}
