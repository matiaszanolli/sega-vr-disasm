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
#include <limits.h>

/* Small self-contained SHA-256 implementation used only to bind passive
 * Q-028 host artifacts.  Keeping it here avoids an unpinned crypto-library
 * dependency in the validation frontend. */
struct q028_sha256_ctx {
    uint32_t h[8];
    uint64_t bytes;
    unsigned char block[64];
    size_t used;
};

static uint32_t q028_rotr32(uint32_t v, unsigned n) {
    return (v >> n) | (v << (32 - n));
}

static void q028_sha256_block(struct q028_sha256_ctx *ctx,
                              const unsigned char *p) {
    static const uint32_t k[64] = {
        0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,
        0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,
        0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,
        0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,
        0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,
        0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,
        0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,
        0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2
    };
    uint32_t w[64], a, b, c, d, e, f, g, h, t1, t2;
    unsigned i;
    for (i = 0; i < 16; i++)
        w[i] = (uint32_t)p[i*4] << 24 | (uint32_t)p[i*4+1] << 16 |
               (uint32_t)p[i*4+2] << 8 | p[i*4+3];
    for (; i < 64; i++) {
        uint32_t s0 = q028_rotr32(w[i-15],7) ^ q028_rotr32(w[i-15],18) ^ (w[i-15] >> 3);
        uint32_t s1 = q028_rotr32(w[i-2],17) ^ q028_rotr32(w[i-2],19) ^ (w[i-2] >> 10);
        w[i] = w[i-16] + s0 + w[i-7] + s1;
    }
    a=ctx->h[0]; b=ctx->h[1]; c=ctx->h[2]; d=ctx->h[3];
    e=ctx->h[4]; f=ctx->h[5]; g=ctx->h[6]; h=ctx->h[7];
    for (i = 0; i < 64; i++) {
        uint32_t s1=q028_rotr32(e,6)^q028_rotr32(e,11)^q028_rotr32(e,25);
        uint32_t ch=(e&f)^((~e)&g);
        uint32_t s0=q028_rotr32(a,2)^q028_rotr32(a,13)^q028_rotr32(a,22);
        uint32_t maj=(a&b)^(a&c)^(b&c);
        t1=h+s1+ch+k[i]+w[i]; t2=s0+maj;
        h=g; g=f; f=e; e=d+t1; d=c; c=b; b=a; a=t1+t2;
    }
    ctx->h[0]+=a; ctx->h[1]+=b; ctx->h[2]+=c; ctx->h[3]+=d;
    ctx->h[4]+=e; ctx->h[5]+=f; ctx->h[6]+=g; ctx->h[7]+=h;
}

static void q028_sha256_init(struct q028_sha256_ctx *ctx) {
    static const uint32_t initial[8] = {
        0x6a09e667,0xbb67ae85,0x3c6ef372,0xa54ff53a,
        0x510e527f,0x9b05688c,0x1f83d9ab,0x5be0cd19
    };
    memcpy(ctx->h, initial, sizeof(initial));
    ctx->bytes = 0; ctx->used = 0;
}

static void q028_sha256_update(struct q028_sha256_ctx *ctx,
                               const void *data, size_t size) {
    const unsigned char *p = data;
    ctx->bytes += size;
    while (size) {
        size_t take = 64 - ctx->used;
        if (take > size) take = size;
        memcpy(ctx->block + ctx->used, p, take);
        ctx->used += take; p += take; size -= take;
        if (ctx->used == 64) {
            q028_sha256_block(ctx, ctx->block);
            ctx->used = 0;
        }
    }
}

static void q028_sha256_final(struct q028_sha256_ctx *ctx, char out[65]) {
    uint64_t bits = ctx->bytes * 8;
    unsigned char pad[128] = {0x80};
    unsigned char digest[32];
    size_t pad_len = ctx->used < 56 ? 56 - ctx->used : 120 - ctx->used;
    unsigned i;
    q028_sha256_update(ctx, pad, pad_len);
    for (i = 0; i < 8; i++) pad[i] = (unsigned char)(bits >> (56 - i*8));
    q028_sha256_update(ctx, pad, 8);
    for (i = 0; i < 8; i++) {
        digest[i*4]=(unsigned char)(ctx->h[i]>>24);
        digest[i*4+1]=(unsigned char)(ctx->h[i]>>16);
        digest[i*4+2]=(unsigned char)(ctx->h[i]>>8);
        digest[i*4+3]=(unsigned char)ctx->h[i];
    }
    for (i = 0; i < 32; i++) sprintf(out + i*2, "%02x", digest[i]);
    out[64] = '\0';
}

static bool q028_sha256_file(const char *path, char out[65], long *size_out) {
    struct q028_sha256_ctx ctx;
    unsigned char buffer[32768];
    FILE *stream = fopen(path, "rb");
    size_t got;
    long total = 0;
    if (!stream) return false;
    q028_sha256_init(&ctx);
    while ((got = fread(buffer, 1, sizeof(buffer), stream)) != 0) {
        q028_sha256_update(&ctx, buffer, got);
        total += (long)got;
    }
    if (ferror(stream) || fclose(stream) != 0) return false;
    q028_sha256_final(&ctx, out);
    if (size_out) *size_out = total;
    return true;
}

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
static uint16_t current_input = 0;
static uint16_t hold_input_mask = 0;   /* VRD_HOLD_INPUT: bitmask held from frame 0, independent of --autoplay's menu-timing logic */
static uint16_t *input_script_masks = NULL;
static int input_script_frames = 0;
static FILE *input_record_stream = NULL;
static char *input_record_path = NULL;
static unsigned int input_record_frame = 0;
static const char *video_dump_dir = NULL;
static FILE *video_dump_manifest = NULL;
static int video_dump_start = -1;
static int video_dump_end = -1;
static unsigned int video_dump_errors = 0;
static unsigned int video_callbacks_this_run = 0;
static unsigned int video_pixel_format_requests = 0;
static int video_run_active = 0;
static int video_pixel_format = -1;
static char video_session_path[1024];
static unsigned long long video_callback_ordinal = 0;
static int q028_video_capture = 1;
static FILE *q028_applied_input_stream = NULL;
static const char *q028_applied_input_path = NULL;
static unsigned int q028_applied_input_rows = 0;
static unsigned int q028_applied_input_errors = 0;

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

struct lr_variable {
    const char *key;
    const char *value;
};

/* Environment commands */
#define LR_ENVIRONMENT_GET_LOG_INTERFACE      27
#define LR_ENVIRONMENT_GET_SYSTEM_DIRECTORY   9
#define LR_ENVIRONMENT_GET_SAVE_DIRECTORY     31
#define LR_ENVIRONMENT_GET_CONTENT_DIRECTORY  30
#define LR_ENVIRONMENT_SET_PIXEL_FORMAT       10
#define LR_ENVIRONMENT_GET_VARIABLE           15
#define LR_ENVIRONMENT_SET_MEMORY_MAPS        36

/* enum retro_pixel_format values from libretro.h. */
#define LR_PIXEL_FORMAT_RGB565                 2

/* Function pointer types */
typedef void (*fn_retro_init)(void);
typedef void (*fn_retro_deinit)(void);
typedef void (*fn_retro_reset)(void);
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
typedef size_t (*fn_retro_serialize_size)(void);
typedef bool (*fn_retro_serialize)(void *data, size_t size);
typedef bool (*fn_retro_unserialize)(const void *data, size_t size);

struct vrd_debug_sh2_regs {
    uint32_t r[16];
    uint32_t pc, pr, sr, gbr, vbr, mach, macl;
    uint32_t state, poll_addr;
    int poll_cnt;
};

typedef int (*fn_vrd_debug_get_sh2_regs)(unsigned cpu_id,
                                         struct vrd_debug_sh2_regs *out);
typedef int (*fn_vrd_debug_read)(unsigned cpu_id, uint32_t address,
                                 void *data, size_t size);
typedef unsigned (*fn_vrd_debug_abi_version)(void);
typedef size_t (*fn_vrd_debug_sh2_regs_size)(void);

/* Function pointers */
static fn_retro_init core_init;
static fn_retro_deinit core_deinit;
static fn_retro_reset core_reset;
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
static fn_retro_serialize_size core_serialize_size;
static fn_retro_serialize core_serialize;
static fn_retro_unserialize core_unserialize;
static fn_vrd_debug_get_sh2_regs core_debug_get_sh2_regs;
static fn_vrd_debug_read core_debug_read;
static fn_vrd_debug_abi_version core_debug_abi_version;
static fn_vrd_debug_sh2_regs_size core_debug_sh2_regs_size;

/* Stub callbacks */
static void stub_video_refresh(const void *data, unsigned width,
                               unsigned height, size_t pitch) {
    FILE *stream;
    char path[1024];
    char digest[65] = "-";
    const unsigned char *row = data;
    struct q028_sha256_ctx sha;
    unsigned y;
    int ok = 1;

    if (!video_dump_manifest)
        return;
    if (!video_run_active) {
        video_dump_errors++;
        return;
    }
    video_callbacks_this_run++;
    video_callback_ordinal++;
    if (current_frame < video_dump_start || current_frame > video_dump_end)
        return;
    if (!data || width != 320 || height != 224 || pitch != 640 ||
        video_pixel_format != LR_PIXEL_FORMAT_RGB565 ||
        video_pixel_format_requests == 0 || strlen(video_dump_dir) > 900) {
        video_dump_errors++;
        return;
    }
    if (q028_video_capture) {
        snprintf(path, sizeof(path), "%s/frame-%04d.rgb565",
            video_dump_dir, current_frame);
        stream = fopen(path, "wbx");
        if (!stream) {
            video_dump_errors++;
            return;
        }
        q028_sha256_init(&sha);
        for (y = 0; y < height; y++, row += pitch) {
            q028_sha256_update(&sha, row, width * 2);
            if (fwrite(row, 1, width * 2, stream) != width * 2) {
                ok = 0;
                break;
            }
        }
        if (fclose(stream) != 0) ok = 0;
        q028_sha256_final(&sha, digest);
    }
    else {
        strcpy(path, "-");
    }
    if (!ok || fprintf(video_dump_manifest,
            "%llu,%d,%d,%u,1,%u,%u,%zu,RGB565,%u,%u,%s,%s\n",
            video_callback_ordinal, current_frame, current_frame,
            video_callbacks_this_run, width, height, pitch,
            q028_video_capture, q028_video_capture ? 143360 : 0,
            digest, q028_video_capture ? strrchr(path, '/') ?
                strrchr(path, '/') + 1 : path : "-") < 0 ||
        fflush(video_dump_manifest) != 0)
        video_dump_errors++;
}

static void stub_audio_sample(int16_t left, int16_t right) {
    (void)left;
    (void)right;
    /* Do nothing - headless mode */
}

static size_t stub_audio_sample_batch(const int16_t *data, size_t frames) {
    (void)data;
    /* Do nothing - headless mode */
    return frames;
}

static void stub_input_poll(void) {
    /* current_input is resolved exactly once immediately before core_run(). */
}

static int16_t stub_input_state(unsigned port, unsigned device,
                                unsigned index, unsigned id) {
    (void)device;
    (void)index;
    if (port != 0) return 0;  /* Only player 1 */

    /* Return button state from autoplay */
    return (current_input >> id) & 1;
}

static void log_printf(int level, const char *fmt, ...) {
    (void)level;
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
            if (video_dump_manifest) {
                int requested;
                if (!data) {
                    video_dump_errors++;
                    return false;
                }
                requested = *(const int *)data;
                video_pixel_format_requests++;
                if (requested != LR_PIXEL_FORMAT_RGB565) {
                    video_dump_errors++;
                    return false;
                }
                video_pixel_format = requested;
            }
            return true;
        case LR_ENVIRONMENT_GET_VARIABLE: {
            struct lr_variable *var = (struct lr_variable *)data;
            const char *run_kind = getenv("VRD_Q028_RUN_KIND");
            if (var && var->key && run_kind &&
                strcmp(run_kind, "Q028_RESOURCE_PILOT_V9") == 0 &&
                strcmp(var->key, "picodrive_drc") == 0) {
                var->value = "disabled";
                return true;
            }
            return false;
        }
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

/* Load a complete per-frame joypad replay. Sparse scripts are rejected so a
 * missing row can never silently become zero input during a control run. */
static bool load_input_script(const char *path, int frame_count) {
    FILE *stream = fopen(path, "r");
    uint16_t *masks;
    unsigned char *seen;
    char line[128];
    int line_number = 0;
    int expected_frame = 0;
    bool saw_header = false;

    if (!stream) {
        fprintf(stderr, "Failed to open input script: %s\n", path);
        return false;
    }
    masks = (uint16_t *)calloc((size_t)frame_count, sizeof(*masks));
    seen = (unsigned char *)calloc((size_t)frame_count, sizeof(*seen));
    if (!masks || !seen) {
        fprintf(stderr, "Failed to allocate input script for %d frames\n", frame_count);
        free(masks);
        free(seen);
        fclose(stream);
        return false;
    }

    while (fgets(line, sizeof(line), stream)) {
        char *cursor = line;
        char *end;
        long frame;
        unsigned long mask;
        line_number++;
        line[strcspn(line, "\r\n")] = '\0';
        while (*cursor == ' ' || *cursor == '\t') cursor++;
        if (*cursor == '\0' || *cursor == '#') continue;
        if (!saw_header) {
            if (strcmp(cursor, "frame,mask") != 0) goto malformed;
            saw_header = true;
            continue;
        }
        if (strcmp(cursor, "frame,mask") == 0) goto malformed;
        frame = strtol(cursor, &end, 0);
        if (end == cursor || *end != ',') goto malformed;
        cursor = end + 1;
        mask = strtoul(cursor, &end, 0);
        while (*end == ' ' || *end == '\t' || *end == '\r' || *end == '\n') end++;
        if (*end != '\0' || frame < 0 || frame >= frame_count ||
            frame != expected_frame || mask > 0xFFFF || seen[frame])
            goto malformed;
        masks[frame] = (uint16_t)mask;
        seen[frame] = 1;
        expected_frame++;
        continue;

malformed:
        fprintf(stderr, "Invalid input script row %d: %s\n", line_number, line);
        free(masks);
        free(seen);
        fclose(stream);
        return false;
    }
    bool read_ok = !ferror(stream) && saw_header;
    if (fclose(stream) != 0) read_ok = false;
    if (!read_ok) {
        fprintf(stderr, "Failed to read complete input script: %s\n", path);
        free(masks);
        free(seen);
        return false;
    }
    for (int frame = 0; frame < frame_count; frame++) {
        if (!seen[frame]) {
            fprintf(stderr, "Input script is missing frame %d (requires 0..%d)\n",
                    frame, frame_count - 1);
            free(masks);
            free(seen);
            return false;
        }
    }
    free(seen);
    input_script_masks = masks;
    input_script_frames = frame_count;
    return true;
}

static char *copy_string(const char *text) {
    size_t length;
    char *copy;

    if (!text) return NULL;
    length = strlen(text) + 1;
    copy = malloc(length);
    if (copy) memcpy(copy, text, length);
    return copy;
}

static void input_record_abort(void) {
    if (input_record_stream) fclose(input_record_stream);
    input_record_stream = NULL;
    if (input_record_path) remove(input_record_path);
    free(input_record_path);
    input_record_path = NULL;
    input_record_frame = 0;
}

static bool input_record_start(const char *path) {
    FILE *stream;
    char *path_copy;

    if (!path || !*path || input_record_stream) return false;
    path_copy = copy_string(path);
    if (!path_copy) return false;
    stream = fopen(path, "wx");
    if (!stream) {
        fprintf(stderr, "Cannot create new input recording: %s\n", path);
        free(path_copy);
        return false;
    }
    if (fprintf(stream, "frame,mask\n") < 0 || fflush(stream) != 0) {
        fprintf(stderr, "Cannot initialize input recording: %s\n", path);
        fclose(stream);
        remove(path);
        free(path_copy);
        return false;
    }
    input_record_stream = stream;
    input_record_path = path_copy;
    input_record_frame = 0;
    printf("Recording joypad input: %s\n", path);
    return true;
}

static bool input_record_stop(void) {
    FILE *stream;
    char *path;
    unsigned int frames;
    bool ok;

    if (!input_record_stream || !input_record_path) return false;
    stream = input_record_stream;
    path = input_record_path;
    frames = input_record_frame;
    input_record_stream = NULL;
    input_record_path = NULL;
    input_record_frame = 0;
    ok = fflush(stream) == 0 && !ferror(stream);
    if (fclose(stream) != 0) ok = false;
    if (!ok) {
        fprintf(stderr, "Failed to finalize input recording: %s\n", path);
        remove(path);
    } else {
        printf("Recorded %u frame%s: %s\n", frames, frames == 1 ? "" : "s", path);
    }
    free(path);
    return ok;
}

static bool input_record_current_frame(void) {
    if (!input_record_stream) return true;
    if (fprintf(input_record_stream, "%u,0x%04X\n",
                input_record_frame, current_input) < 0 ||
        fflush(input_record_stream) != 0) {
        fprintf(stderr, "Failed while writing input recording: %s\n", input_record_path);
        input_record_abort();
        return false;
    }
    input_record_frame++;
    return true;
}

static bool resolve_frame_input(void) {
    if (input_script_masks) {
        if (current_frame < 0 || current_frame >= input_script_frames) {
            fprintf(stderr,
                    "Input replay exhausted at frame %d (script covers 0..%d)\n",
                    current_frame, input_script_frames - 1);
            return false;
        }
        current_input = input_script_masks[current_frame];
        return true;
    }

    current_input = hold_input_mask;
    if (!autoplay_enabled) return true;
    if (current_frame >= 1200) {
        current_input = (1 << RETRO_DEVICE_ID_JOYPAD_A);
    } else if (current_frame >= 120) {
        int phase_frame = (current_frame - 120) % 90;
        if (phase_frame < 5)
            current_input = (1 << RETRO_DEVICE_ID_JOYPAD_START);
    }
    return true;
}

static bool run_emulated_frame(void) {
    if (current_frame == INT_MAX || !resolve_frame_input()) return false;
    if (q028_applied_input_stream) {
        if (q028_applied_input_rows != (unsigned int)current_frame ||
            fprintf(q028_applied_input_stream, "%d,0x%04X\n",
                    current_frame, current_input) < 0 ||
            fflush(q028_applied_input_stream) != 0) {
            q028_applied_input_errors++;
            return false;
        }
        q028_applied_input_rows++;
    }
    video_callbacks_this_run = 0;
    video_run_active = 1;
    core_run();
    video_run_active = 0;
    if (video_dump_manifest && current_frame >= video_dump_start &&
        current_frame <= video_dump_end && video_callbacks_this_run != 1) {
        video_dump_errors++;
        return false;
    }
    current_frame++;
    return input_record_current_frame();
}

static bool debug_parse_u32(const char *text, uint32_t *out) {
    char *end;
    unsigned long value;

    if (!text || !out || *text == '-') return false;
    value = strtoul(text, &end, 0);
    if (end == text || *end != '\0' || value > UINT32_MAX) return false;
    *out = (uint32_t)value;
    return true;
}

static bool debug_save_state(const char *path) {
    size_t size;
    void *data;
    FILE *stream;
    bool ok;

    if (!path || !core_serialize_size || !core_serialize) return false;
    size = core_serialize_size();
    data = malloc(size);
    if (!data) return false;
    ok = core_serialize(data, size);
    if (!ok) {
        free(data);
        return false;
    }
    stream = fopen(path, "wb");
    if (!stream) {
        free(data);
        return false;
    }
    ok = fwrite(data, 1, size, stream) == size;
    if (fclose(stream) != 0) ok = false;
    free(data);
    if (ok) printf("Saved state: %s (%zu bytes)\n", path, size);
    return ok;
}

static bool debug_load_state(const char *path) {
    FILE *stream;
    long length;
    void *data;
    bool ok;

    if (!path || !core_unserialize) return false;
    stream = fopen(path, "rb");
    if (!stream) return false;
    if (fseek(stream, 0, SEEK_END) != 0 || (length = ftell(stream)) < 0 ||
        fseek(stream, 0, SEEK_SET) != 0) {
        fclose(stream);
        return false;
    }
    if (length == 0 || (unsigned long)length > 16UL * 1024UL * 1024UL) {
        fprintf(stderr, "Invalid savestate size: %ld\n", length);
        fclose(stream);
        return false;
    }
    data = malloc((size_t)length);
    if (!data) {
        fclose(stream);
        return false;
    }
    ok = fread(data, 1, (size_t)length, stream) == (size_t)length;
    fclose(stream);
    if (ok) ok = core_unserialize(data, (size_t)length);
    free(data);
    if (ok) {
        current_frame = 0;
        printf("Loaded state: %s (%ld bytes)\n", path, length);
    }
    return ok;
}

static bool debug_set_joypad(const char *mask_text) {
    uint32_t mask;

    if (!debug_parse_u32(mask_text, &mask) || mask > 0xFFFF) return false;
    if (input_script_masks) {
        fprintf(stderr, "Cannot override joypad while VRD_INPUT_SCRIPT is active\n");
        return false;
    }
    autoplay_enabled = 0;
    hold_input_mask = (uint16_t)mask;
    current_input = hold_input_mask;
    printf("Joypad mask: 0x%04X\n", hold_input_mask);
    return true;
}

static bool debug_run_frames(uint32_t count) {
    for (uint32_t i = 0; i < count; i++) {
        if (!run_emulated_frame()) return false;
    }
    printf("Advanced %u frame%s; session frame=%d\n",
           count, count == 1 ? "" : "s", current_frame);
    return true;
}

static bool debug_print_regs(const char *cpu_name) {
    struct vrd_debug_sh2_regs regs;
    unsigned cpu_id;

    if (!cpu_name || strcmp(cpu_name, "master") == 0) cpu_id = 1;
    else if (strcmp(cpu_name, "slave") == 0) cpu_id = 2;
    else return false;
    if (!core_debug_get_sh2_regs(cpu_id, &regs)) return false;
    printf("%s SH2: PC=%08X PR=%08X SR=%08X GBR=%08X VBR=%08X\n",
           cpu_id == 1 ? "Master" : "Slave", regs.pc, regs.pr, regs.sr,
           regs.gbr, regs.vbr);
    printf("  MACH=%08X MACL=%08X state=%08X poll_addr=%08X poll_cnt=%d\n",
           regs.mach, regs.macl, regs.state, regs.poll_addr, regs.poll_cnt);
    for (int i = 0; i < 16; i += 2)
        printf("  R%-2d=%08X  R%-2d=%08X\n", i, regs.r[i], i + 1, regs.r[i + 1]);
    return true;
}

static bool debug_read_memory(const char *cpu_name, const char *address_text,
                              const char *size_text) {
    uint32_t cpu_id, address, size = 16;
    unsigned char *data;

    if (!cpu_name || !address_text) return false;
    if (strcmp(cpu_name, "68k") == 0) cpu_id = 0;
    else if (strcmp(cpu_name, "master") == 0) cpu_id = 1;
    else if (strcmp(cpu_name, "slave") == 0) cpu_id = 2;
    else return false;
    if (!debug_parse_u32(address_text, &address) ||
        (size_text && !debug_parse_u32(size_text, &size)) ||
        size == 0 || size > 4096)
        return false;
    data = malloc(size);
    if (!data) return false;
    if (!core_debug_read(cpu_id, address, data, size)) {
        free(data);
        return false;
    }
    for (uint32_t i = 0; i < size; i += 16) {
        printf("%08X:", address + i);
        for (uint32_t j = 0; j < 16 && i + j < size; j++)
            printf(" %02X", data[i + j]);
        printf("\n");
    }
    free(data);
    return true;
}

static void debug_print_help(void) {
    printf("Commands:\n");
    printf("  run [frames]                    Advance emulation (default 1)\n");
    printf("  joypad <mask>                   Set the P1 mask used by subsequent frames\n");
    printf("  record start <path>             Start a new frame,mask recording\n");
    printf("  record stop                     Finalize the active recording\n");
    printf("  regs [master|slave]             Read SH2 registers\n");
    printf("  read <68k|master|slave> <addr> [size]\n");
    printf("  save <path>                     Save a libretro savestate\n");
    printf("  load <path>                     Load a matching savestate\n");
    printf("  reset                           Assert the core's normal reset path\n");
    printf("  status                          Show session frame\n");
    printf("  help                            Show this help\n");
    printf("  quit                            Exit debugger\n");
}

static int debug_repl(FILE *input, bool scripted) {
    char line[1024];
    char original[1024];
    int status = 0;

    debug_print_help();
    while (true) {
        char *cmd;
        char *arg1;
        char *arg2;
        char *arg3;
        char *arg4;
        bool ok = true;

        if (!scripted) {
            printf("vrd-dbg> ");
            fflush(stdout);
        }
        if (!fgets(line, sizeof(line), input)) break;
        line[strcspn(line, "\r\n")] = '\0';
        snprintf(original, sizeof(original), "%s", line);
        cmd = strtok(line, " \t");
        if (!cmd || cmd[0] == '#') continue;
        if (scripted) printf("vrd-dbg> %s\n", original);
        arg1 = strtok(NULL, " \t");
        arg2 = strtok(NULL, " \t");
        arg3 = strtok(NULL, " \t");
        arg4 = strtok(NULL, " \t");

        if ((strcmp(cmd, "quit") == 0 || strcmp(cmd, "exit") == 0) && !arg1) break;
        if (strcmp(cmd, "help") == 0 && !arg1) debug_print_help();
        else if (strcmp(cmd, "status") == 0 && !arg1)
            printf("Session frame: %d\n", current_frame);
        else if (strcmp(cmd, "run") == 0) {
            uint32_t count = 1;
            ok = !arg2 && (!arg1 || debug_parse_u32(arg1, &count)) && count > 0;
            if (ok) ok = debug_run_frames(count);
        } else if (strcmp(cmd, "joypad") == 0) {
            ok = arg1 && !arg2 && debug_set_joypad(arg1);
        } else if (strcmp(cmd, "record") == 0) {
            if (arg1 && strcmp(arg1, "start") == 0)
                ok = arg2 && !arg3 && input_record_start(arg2);
            else if (arg1 && strcmp(arg1, "stop") == 0)
                ok = !arg2 && input_record_stop();
            else
                ok = false;
        } else if (strcmp(cmd, "regs") == 0) {
            ok = !arg2 && debug_print_regs(arg1);
        } else if (strcmp(cmd, "read") == 0) {
            ok = !arg4 && debug_read_memory(arg1, arg2, arg3);
        } else if (strcmp(cmd, "save") == 0) {
            ok = arg1 && !arg2 && debug_save_state(arg1);
        } else if (strcmp(cmd, "load") == 0) {
            ok = arg1 && !arg2 && debug_load_state(arg1);
        } else if (strcmp(cmd, "reset") == 0) {
            ok = !arg1 && core_reset;
            if (ok) {
                core_reset();
                printf("Core reset at session frame: %d\n", current_frame);
            }
        } else {
            ok = false;
        }
        if (!ok) {
            fprintf(stderr, "Debugger command failed: %s\n", cmd);
            status = 1;
            if (scripted) break;
        }
    }
    if (input_record_stream) {
        fprintf(stderr, "Input recording was not stopped; discarding partial file: %s\n",
                input_record_path ? input_record_path : "(unknown)");
        input_record_abort();
        status = 1;
    }
    return status;
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: VRD_PROFILE_LOG=/path/to/log.csv %s /path/to/rom.32x [max_frames] [--autoplay|--debug|--debug-script file]\n", argv[0]);
        fprintf(stderr, "\nEnvironment variables:\n");
        fprintf(stderr, "  VRD_PROFILE_LOG - Path to CSV output file (required for profiling)\n");
        fprintf(stderr, "  VRD_LOAD_STATE  - Path to a savestate to load before running (see VRD_PROFILING.md)\n");
        fprintf(stderr, "  VRD_HOLD_INPUT  - Joypad bitmask held from frame 0, independent of --autoplay (e.g. 0x100 = hold A/accelerate)\n");
        fprintf(stderr, "  VRD_INPUT_SCRIPT - Complete CSV replay: frame,mask for every frame 0..N-1\n");
        fprintf(stderr, "\nOptions:\n");
        fprintf(stderr, "  --autoplay  Inject inputs to navigate menus and start a race\n");
        fprintf(stderr, "  --debug     Start the PicoDrive debugger (inspection is read-only)\n");
        fprintf(stderr, "  --debug-script file  Run debugger commands from a file\n");
        return 1;
    }

    const char *rom_path = argv[1];
    const char *profile_log = getenv("VRD_PROFILE_LOG");
    const char *debug_script_path = NULL;
    int debug_enabled = 0;
    int max_frames = 600; /* 10 seconds @ 60fps */
    { const char *hi = getenv("VRD_HOLD_INPUT"); if (hi) hold_input_mask = (int16_t)strtoul(hi, 0, 0); }

    /* Parse arguments */
    for (int i = 2; i < argc; i++) {
        if (strcmp(argv[i], "--autoplay") == 0) {
            autoplay_enabled = 1;
        } else if (strcmp(argv[i], "--debug") == 0) {
            debug_enabled = 1;
        } else if (strcmp(argv[i], "--debug-script") == 0) {
            if (i + 1 >= argc) {
                fprintf(stderr, "--debug-script requires a file\n");
                return 1;
            }
            debug_enabled = 1;
            debug_script_path = argv[++i];
        } else if (argv[i][0] != '-') {
            max_frames = atoi(argv[i]);
        } else {
            fprintf(stderr, "Unknown option: %s\n", argv[i]);
            return 1;
        }
    }
    if (max_frames <= 0) {
        fprintf(stderr, "Frame count must be positive\n");
        return 1;
    }

    video_dump_dir = getenv("VRD_VIDEO_DUMP_DIR");
    if (video_dump_dir && *video_dump_dir) {
        const char *start = getenv("VRD_VIDEO_DUMP_START");
        const char *end = getenv("VRD_VIDEO_DUMP_END");
        const char *capture = getenv("VRD_Q028_VIDEO_CAPTURE");
        char manifest_path[1024];
        if (!start || !end || strlen(video_dump_dir) > 900) {
            fprintf(stderr, "Video dump requires bounded start/end and path\n");
            return 1;
        }
        video_dump_start = atoi(start);
        video_dump_end = atoi(end);
        if (video_dump_start < 0 || video_dump_end < video_dump_start ||
            video_dump_end >= max_frames) {
            fprintf(stderr, "Invalid video dump frame bounds\n");
            return 1;
        }
        if (capture && strcmp(capture, "0") != 0 && strcmp(capture, "1") != 0) {
            fprintf(stderr, "VRD_Q028_VIDEO_CAPTURE must be 0 or 1\n");
            return 1;
        }
        q028_video_capture = !capture || strcmp(capture, "0") != 0;
        snprintf(manifest_path, sizeof(manifest_path), "%s/video-frames.csv",
            video_dump_dir);
        snprintf(video_session_path, sizeof(video_session_path),
            "%s/video-session.csv", video_dump_dir);
        video_dump_manifest = fopen(manifest_path, "wx");
        if (!video_dump_manifest ||
            fprintf(video_dump_manifest,
                "callback_ordinal,frame,retro_run,callback_in_run,data_nonnull,width,height,pitch,pixel_format,captured,bytes,sha256,path\n") < 0) {
            fprintf(stderr, "Cannot initialize video dump manifest\n");
            if (video_dump_manifest) fclose(video_dump_manifest);
            return 1;
        }
    }

    const char *input_script_path = getenv("VRD_INPUT_SCRIPT");
    if (input_script_path && !load_input_script(input_script_path, max_frames)) {
        return 1;
    }
    q028_applied_input_path = getenv("VRD_Q028_APPLIED_INPUT_LOG");
    if (q028_applied_input_path && *q028_applied_input_path) {
        static const char expected_fixture[] =
            "2df0ffe53cad0c7d7a5d70c1819051685905a60ff96727a6256e6a300116fbbf";
        char fixture_hash[65];
        long fixture_size = 0;
        if (!input_script_path || max_frames != 1340 ||
            getenv("VRD_RECORD_INPUT") ||
            !q028_sha256_file(input_script_path, fixture_hash, &fixture_size) ||
            fixture_size != 14981 || strcmp(fixture_hash, expected_fixture) != 0) {
            fprintf(stderr, "Q-028 applied-input logging requires the pinned 1340-frame fixture and forbids VRD_RECORD_INPUT\n");
            return 1;
        }
        q028_applied_input_stream = fopen(q028_applied_input_path, "wx");
        if (!q028_applied_input_stream ||
            fprintf(q028_applied_input_stream, "frame,mask\n") < 0 ||
            fflush(q028_applied_input_stream) != 0) {
            fprintf(stderr, "Cannot initialize Q-028 applied-input log\n");
            if (q028_applied_input_stream) fclose(q028_applied_input_stream);
            q028_applied_input_stream = NULL;
            return 1;
        }
    }

    if (profile_log) {
        printf("VRD Profiling frontend\n");
        printf("  ROM: %s\n", rom_path);
        printf("  Profile log: %s\n", profile_log);
        printf("  Max frames: %d\n", max_frames);
        printf("  Autoplay: %s\n", autoplay_enabled ? "ENABLED" : "disabled");
        printf("  Input: %s\n", input_script_path ? input_script_path : "fixed hold mask");
    } else {
        printf("VRD Test frontend (no profiling - set VRD_PROFILE_LOG to enable)\n");
        printf("  ROM: %s\n", rom_path);
        printf("  Max frames: %d\n", max_frames);
        printf("  Autoplay: %s\n", autoplay_enabled ? "ENABLED" : "disabled");
        printf("  Input: %s\n", input_script_path ? input_script_path : "fixed hold mask");
    }

    /* Load libretro core */
    const char *core_path = getenv("VRD_LIBRETRO_CORE");
    if (!core_path || !core_path[0]) core_path = "./picodrive_libretro.so";
    void *handle = dlopen(core_path, RTLD_LAZY);
    if (!handle) {
        fprintf(stderr, "Failed to load core: %s\n", dlerror());
        return 1;
    }

    /* Load function pointers */
    core_init = (fn_retro_init)load_symbol(handle, "retro_init");
    core_deinit = (fn_retro_deinit)load_symbol(handle, "retro_deinit");
    core_reset = (fn_retro_reset)load_symbol(handle, "retro_reset");
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
    core_serialize_size = (fn_retro_serialize_size)load_symbol(handle, "retro_serialize_size");
    core_serialize = (fn_retro_serialize)load_symbol(handle, "retro_serialize");
    core_unserialize = (fn_retro_unserialize)load_symbol(handle, "retro_unserialize");
    if (debug_enabled) {
        core_debug_get_sh2_regs = (fn_vrd_debug_get_sh2_regs)
            load_symbol(handle, "vrd_debug_get_sh2_regs");
        core_debug_read = (fn_vrd_debug_read)load_symbol(handle, "vrd_debug_read");
        core_debug_abi_version = (fn_vrd_debug_abi_version)
            load_symbol(handle, "vrd_debug_abi_version");
        core_debug_sh2_regs_size = (fn_vrd_debug_sh2_regs_size)
            load_symbol(handle, "vrd_debug_sh2_regs_size");
    }

    if (!core_init || !core_run || !core_load_game ||
        (debug_enabled && (!core_reset || !core_debug_get_sh2_regs || !core_debug_read ||
                           !core_debug_abi_version || !core_debug_sh2_regs_size ||
                           !core_serialize_size || !core_serialize || !core_unserialize))) {
        fprintf(stderr, "Failed to load required symbols\n");
        dlclose(handle);
        return 1;
    }
    if (debug_enabled &&
        (core_debug_abi_version() != 1 ||
         core_debug_sh2_regs_size() != sizeof(struct vrd_debug_sh2_regs))) {
        fprintf(stderr, "PicoDrive debugger ABI mismatch\n");
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

    if (fseek(f, 0, SEEK_END) != 0) {
        fprintf(stderr, "Failed to seek ROM: %s\n", rom_path);
        fclose(f);
        core_deinit();
        dlclose(handle);
        return 1;
    }
    long rom_size = ftell(f);
    if (rom_size <= 0 || fseek(f, 0, SEEK_SET) != 0) {
        fprintf(stderr, "Invalid ROM size: %ld\n", rom_size);
        fclose(f);
        core_deinit();
        dlclose(handle);
        return 1;
    }
    game_info.size = (size_t)rom_size;

    void *rom_data = malloc(game_info.size);
    if (!rom_data) {
        fprintf(stderr, "Failed to allocate ROM buffer\n");
        fclose(f);
        core_deinit();
        dlclose(handle);
        return 1;
    }

    if (fread(rom_data, 1, game_info.size, f) != game_info.size) {
        fprintf(stderr, "Failed to read complete ROM: %s\n", rom_path);
        free(rom_data);
        fclose(f);
        core_deinit();
        dlclose(handle);
        return 1;
    }
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

    /* Optional: load a savestate captured from real (manual) gameplay, so
     * headless verification can target a scene --autoplay's canned input
     * can't reach (e.g. real 1P GP racing -- --autoplay only ever reaches
     * Free Run, see VR60_DISPATCHER_ROUTING.md). The state file is whatever
     * bytes retro_serialize() produced; format is core/version-specific,
     * not game-ROM data. */
    const char *load_state_path = getenv("VRD_LOAD_STATE");
    if (load_state_path) {
        if (!debug_load_state(load_state_path)) {
            fprintf(stderr, "Failed to load matching savestate: %s\n", load_state_path);
            free(rom_data);
            core_deinit();
            dlclose(handle);
            return 1;
        }
    }

    int run_status = 0;
    if (debug_enabled) {
        FILE *debug_input = stdin;
        if (debug_script_path) {
            debug_input = fopen(debug_script_path, "r");
            if (!debug_input) {
                fprintf(stderr, "Failed to open debugger script: %s\n", debug_script_path);
                run_status = 1;
            }
        }
        if (debug_input) run_status = debug_repl(debug_input, debug_script_path != NULL);
        if (debug_script_path && debug_input) fclose(debug_input);
    } else {
        printf("Running %d frames...\n", max_frames);

        /* Run emulation frames */
        for (int frame = 0; frame < max_frames; frame++) {
            if (!run_emulated_frame()) {
                run_status = 1;
                break;
            }

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
        if (run_status == 0) printf("Emulation complete.\n");
    }

    /* Cleanup */
    /* Debugger recording is explicitly started/stopped by debugger commands.
     * An unclosed recording remains partial and is removed. */
    if (input_record_stream) input_record_abort();
    core_unload_game();
    free(rom_data);
    core_deinit();
    dlclose(handle);
    free(input_script_masks);
    if (q028_applied_input_stream) {
        if (q028_applied_input_rows != 1340 || q028_applied_input_errors != 0 ||
            fflush(q028_applied_input_stream) != 0 ||
            fclose(q028_applied_input_stream) != 0) {
            fprintf(stderr, "Q-028 applied-input log failed closed: rows=%u errors=%u\n",
                    q028_applied_input_rows, q028_applied_input_errors);
            run_status = 1;
        }
        q028_applied_input_stream = NULL;
    }
    if (video_dump_manifest) {
        FILE *session;
        if (video_pixel_format != LR_PIXEL_FORMAT_RGB565 ||
            video_pixel_format_requests == 0)
            video_dump_errors++;
        if (fclose(video_dump_manifest) != 0)
            video_dump_errors++;
        video_dump_manifest = NULL;
        session = fopen(video_session_path, "wx");
        if (!session || fprintf(session,
                "pixel_format,requests,start,end,errors\n"
                "RGB565,%u,%d,%d,%u\n",
                video_pixel_format_requests, video_dump_start, video_dump_end,
                video_dump_errors) < 0 || fclose(session) != 0)
            video_dump_errors++;
    }
    if (video_dump_errors) {
        fprintf(stderr, "Video dump failed closed: errors=%u\n",
            video_dump_errors);
        run_status = 1;
    }

    if (profile_log) {
        printf("Profile data written to: %s\n", profile_log);
    }

    return run_status;
}
