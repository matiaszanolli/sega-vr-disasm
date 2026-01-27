/*
 * Minimal libretro frontend for VRD profiling
 * Part of v4.0 parallel processing validation
 *
 * Usage: VRD_PROFILE_LOG=/path/to/log.csv ./profiling_frontend /path/to/rom.32x [frames] [--autoplay]
 *
 * --autoplay: Inject button presses to navigate menus and start a race
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dlfcn.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdarg.h>

/* Libretro input device IDs */
#define RETRO_DEVICE_ID_JOYPAD_B        0
#define RETRO_DEVICE_ID_JOYPAD_Y        1
#define RETRO_DEVICE_ID_JOYPAD_SELECT   2
#define RETRO_DEVICE_ID_JOYPAD_START    3
#define RETRO_DEVICE_ID_JOYPAD_UP       4
#define RETRO_DEVICE_ID_JOYPAD_DOWN     5
#define RETRO_DEVICE_ID_JOYPAD_LEFT     6
#define RETRO_DEVICE_ID_JOYPAD_RIGHT    7
#define RETRO_DEVICE_ID_JOYPAD_A        8
#define RETRO_DEVICE_ID_JOYPAD_X        9

/* Autoplay state */
static int autoplay_enabled = 0;
static int current_frame = 0;
static int16_t current_input = 0;

/* Libretro types (minimal subset) */
typedef void (*lr_video_refresh_t)(const void *data, unsigned width,
                                   unsigned height, size_t pitch);
typedef void (*lr_audio_sample_t)(int16_t left, int16_t right);
typedef size_t (*lr_audio_sample_batch_t)(const int16_t *data, size_t frames);
typedef void (*lr_input_poll_t)(void);
typedef int16_t (*lr_input_state_t)(unsigned port, unsigned device,
                                    unsigned index, unsigned id);
typedef bool (*lr_environment_t)(unsigned cmd, void *data);

struct lr_game_info {
    const char *path;
    const void *data;
    size_t size;
    const char *meta;
};

struct lr_system_info {
    const char *library_name;
    const char *library_version;
    const char *valid_extensions;
    bool need_fullpath;
    bool block_extract;
};

typedef void (*lr_log_printf_t)(int level, const char *fmt, ...);

struct lr_log_callback {
    lr_log_printf_t log;
};

/* Environment commands */
#define LR_ENVIRONMENT_GET_LOG_INTERFACE      27
#define LR_ENVIRONMENT_GET_SYSTEM_DIRECTORY   9
#define LR_ENVIRONMENT_GET_SAVE_DIRECTORY     31
#define LR_ENVIRONMENT_GET_CONTENT_DIRECTORY  30
#define LR_ENVIRONMENT_SET_PIXEL_FORMAT       10
#define LR_ENVIRONMENT_GET_VARIABLE           15
#define LR_ENVIRONMENT_SET_MEMORY_MAPS        36

/* Function pointer types */
typedef void (*fn_retro_init)(void);
typedef void (*fn_retro_deinit)(void);
typedef void (*fn_retro_set_environment)(lr_environment_t);
typedef void (*fn_retro_set_video_refresh)(lr_video_refresh_t);
typedef void (*fn_retro_set_audio_sample)(lr_audio_sample_t);
typedef void (*fn_retro_set_audio_sample_batch)(lr_audio_sample_batch_t);
typedef void (*fn_retro_set_input_poll)(lr_input_poll_t);
typedef void (*fn_retro_set_input_state)(lr_input_state_t);
typedef bool (*fn_retro_load_game)(const struct lr_game_info *);
typedef void (*fn_retro_unload_game)(void);
typedef void (*fn_retro_run)(void);
typedef void (*fn_retro_get_system_info)(struct lr_system_info *);

/* Function pointers */
static fn_retro_init core_init;
static fn_retro_deinit core_deinit;
static fn_retro_set_environment core_set_environment;
static fn_retro_set_video_refresh core_set_video_refresh;
static fn_retro_set_audio_sample core_set_audio_sample;
static fn_retro_set_audio_sample_batch core_set_audio_sample_batch;
static fn_retro_set_input_poll core_set_input_poll;
static fn_retro_set_input_state core_set_input_state;
static fn_retro_load_game core_load_game;
static fn_retro_unload_game core_unload_game;
static fn_retro_run core_run;
static fn_retro_get_system_info core_get_system_info;

/* Stub callbacks */
static void stub_video_refresh(const void *data, unsigned width,
                               unsigned height, size_t pitch) {
    /* Do nothing - headless mode */
}

static void stub_audio_sample(int16_t left, int16_t right) {
    /* Do nothing - headless mode */
}

static size_t stub_audio_sample_batch(const int16_t *data, size_t frames) {
    /* Do nothing - headless mode */
    return frames;
}

static void stub_input_poll(void) {
    /* Update input state for autoplay */
    if (!autoplay_enabled) {
        current_input = 0;
        return;
    }

    current_input = 0;

    /*
     * VRD menu navigation - press START repeatedly every 90 frames (1.5 sec)
     * to get through all menus. The game has many screens:
     * - Sega/32X logos
     * - Title screen
     * - Main menu
     * - Mode selection (Grand Prix default)
     * - Track selection
     * - Car selection
     * - Transmission selection
     * - Loading screen
     * - Race countdown
     *
     * After 1200 frames (20 seconds), assume we're racing and hold A.
     */
    if (current_frame >= 1200) {
        /* Racing mode - hold accelerate */
        current_input = (1 << RETRO_DEVICE_ID_JOYPAD_A);
    } else if (current_frame >= 120) {
        /* Menu navigation - press START every 90 frames */
        int menu_phase = (current_frame - 120) / 90;
        int phase_frame = (current_frame - 120) % 90;
        if (phase_frame < 5) {
            current_input = (1 << RETRO_DEVICE_ID_JOYPAD_START);
        }
    }
}

static int16_t stub_input_state(unsigned port, unsigned device,
                                unsigned index, unsigned id) {
    if (port != 0) return 0;  /* Only player 1 */

    /* Return button state from autoplay */
    return (current_input >> id) & 1;
}

static void log_printf(int level, const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    vprintf(fmt, args);
    va_end(args);
}

static bool environment_callback(unsigned cmd, void *data) {
    switch (cmd) {
        case LR_ENVIRONMENT_GET_LOG_INTERFACE: {
            struct lr_log_callback *cb = (struct lr_log_callback *)data;
            cb->log = log_printf;
            return true;
        }
        case LR_ENVIRONMENT_GET_SYSTEM_DIRECTORY:
        case LR_ENVIRONMENT_GET_SAVE_DIRECTORY:
        case LR_ENVIRONMENT_GET_CONTENT_DIRECTORY:
            *(const char **)data = ".";
            return true;
        case LR_ENVIRONMENT_SET_PIXEL_FORMAT:
            return true;
        case LR_ENVIRONMENT_GET_VARIABLE:
            return false;
        case LR_ENVIRONMENT_SET_MEMORY_MAPS:
            return true;
        default:
            return false;
    }
}

static void *load_symbol(void *handle, const char *name) {
    void *sym = dlsym(handle, name);
    if (!sym) {
        fprintf(stderr, "Failed to load symbol: %s\n", name);
    }
    return sym;
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: VRD_PROFILE_LOG=/path/to/log.csv %s /path/to/rom.32x [max_frames] [--autoplay]\n", argv[0]);
        fprintf(stderr, "\nEnvironment variables:\n");
        fprintf(stderr, "  VRD_PROFILE_LOG - Path to CSV output file (required for profiling)\n");
        fprintf(stderr, "\nOptions:\n");
        fprintf(stderr, "  --autoplay  Inject inputs to navigate menus and start a race\n");
        return 1;
    }

    const char *rom_path = argv[1];
    const char *profile_log = getenv("VRD_PROFILE_LOG");
    int max_frames = 600; /* 10 seconds @ 60fps */

    /* Parse arguments */
    for (int i = 2; i < argc; i++) {
        if (strcmp(argv[i], "--autoplay") == 0) {
            autoplay_enabled = 1;
        } else if (argv[i][0] != '-') {
            max_frames = atoi(argv[i]);
        }
    }

    if (profile_log) {
        printf("VRD Profiling frontend\n");
        printf("  ROM: %s\n", rom_path);
        printf("  Profile log: %s\n", profile_log);
        printf("  Max frames: %d\n", max_frames);
        printf("  Autoplay: %s\n", autoplay_enabled ? "ENABLED" : "disabled");
    } else {
        printf("VRD Test frontend (no profiling - set VRD_PROFILE_LOG to enable)\n");
        printf("  ROM: %s\n", rom_path);
        printf("  Max frames: %d\n", max_frames);
        printf("  Autoplay: %s\n", autoplay_enabled ? "ENABLED" : "disabled");
    }

    /* Load libretro core */
    void *handle = dlopen("./picodrive_libretro.so", RTLD_LAZY);
    if (!handle) {
        fprintf(stderr, "Failed to load core: %s\n", dlerror());
        return 1;
    }

    /* Load function pointers */
    core_init = (fn_retro_init)load_symbol(handle, "retro_init");
    core_deinit = (fn_retro_deinit)load_symbol(handle, "retro_deinit");
    core_set_environment = (fn_retro_set_environment)load_symbol(handle, "retro_set_environment");
    core_set_video_refresh = (fn_retro_set_video_refresh)load_symbol(handle, "retro_set_video_refresh");
    core_set_audio_sample = (fn_retro_set_audio_sample)load_symbol(handle, "retro_set_audio_sample");
    core_set_audio_sample_batch = (fn_retro_set_audio_sample_batch)load_symbol(handle, "retro_set_audio_sample_batch");
    core_set_input_poll = (fn_retro_set_input_poll)load_symbol(handle, "retro_set_input_poll");
    core_set_input_state = (fn_retro_set_input_state)load_symbol(handle, "retro_set_input_state");
    core_load_game = (fn_retro_load_game)load_symbol(handle, "retro_load_game");
    core_unload_game = (fn_retro_unload_game)load_symbol(handle, "retro_unload_game");
    core_run = (fn_retro_run)load_symbol(handle, "retro_run");
    core_get_system_info = (fn_retro_get_system_info)load_symbol(handle, "retro_get_system_info");

    if (!core_init || !core_run || !core_load_game) {
        fprintf(stderr, "Failed to load required symbols\n");
        dlclose(handle);
        return 1;
    }

    /* Set up callbacks before init */
    core_set_environment(environment_callback);

    /* Initialize core */
    core_init();

    /* Set remaining callbacks */
    core_set_video_refresh(stub_video_refresh);
    core_set_audio_sample(stub_audio_sample);
    core_set_audio_sample_batch(stub_audio_sample_batch);
    core_set_input_poll(stub_input_poll);
    core_set_input_state(stub_input_state);

    /* Get system info */
    struct lr_system_info sys_info = {0};
    core_get_system_info(&sys_info);
    printf("Core: %s (version %s)\n", sys_info.library_name, sys_info.library_version);

    /* Load ROM */
    struct lr_game_info game_info = {0};
    game_info.path = rom_path;

    /* Read ROM into memory */
    FILE *f = fopen(rom_path, "rb");
    if (!f) {
        fprintf(stderr, "Failed to open ROM: %s\n", rom_path);
        core_deinit();
        dlclose(handle);
        return 1;
    }

    fseek(f, 0, SEEK_END);
    game_info.size = ftell(f);
    fseek(f, 0, SEEK_SET);

    void *rom_data = malloc(game_info.size);
    if (!rom_data) {
        fprintf(stderr, "Failed to allocate ROM buffer\n");
        fclose(f);
        core_deinit();
        dlclose(handle);
        return 1;
    }

    fread(rom_data, 1, game_info.size, f);
    fclose(f);
    game_info.data = rom_data;

    printf("ROM loaded: %zu bytes\n", game_info.size);

    if (!core_load_game(&game_info)) {
        fprintf(stderr, "Failed to load game\n");
        free(rom_data);
        core_deinit();
        dlclose(handle);
        return 1;
    }

    printf("Game loaded successfully\n");
    printf("Running %d frames...\n", max_frames);

    /* Run emulation frames */
    for (int frame = 0; frame < max_frames; frame++) {
        current_frame = frame;  /* Update for autoplay */
        core_run();

        /* Progress indicator */
        if ((frame + 1) % 60 == 0) {
            const char *phase = "";
            if (autoplay_enabled) {
                if (frame < 120) phase = " [boot]";
                else if (frame < 1200) phase = " [menus]";
                else phase = " [racing]";
            }
            printf("  Frame %d/%d (%.0f%%)%s\n", frame + 1, max_frames,
                   (frame + 1) * 100.0 / max_frames, phase);
        }
    }

    printf("Emulation complete.\n");

    /* Cleanup */
    core_unload_game();
    free(rom_data);
    core_deinit();
    dlclose(handle);

    if (profile_log) {
        printf("Profile data written to: %s\n", profile_log);
    }

    return 0;
}
