# Memory Management Architecture — Virtua Racing Deluxe (32X)

## 1. Overview

Virtua Racing Deluxe uses **no dynamic memory allocation**. All buffers are statically mapped to fixed addresses in 68K Work RAM ($FF0000-$FFFFFF, 64KB). There is no heap, no malloc/free, no garbage collection.

The "memory management" subsystem consists of:
- **High-speed fill/copy primitives** using the JSR cascade ("waterfall") technique
- **A MOVEM-based block copier** with SH2 busy-guard
- **A 16-bit PRNG** (multiply-by-41, XOR-fold)

All primitives live in a single ROM region: **$004836-$004996** (352 bytes).

**Source files:** `disasm/modules/68k/memory/` (12 files, 4 are empty stubs)

---

## 2. WRAM Region Map ($FF0000-$FFFFFF)

| Range | Size | Owner | Purpose |
|-------|------|-------|---------|
| `$FF0000-$FF001F` | 32B | main-loop | Self-modifying main loop (copied from ROM $000F92) |
| `$FF6000-$FF60D0` | 208B | display | Screen coordinate / display list buffers |
| `$FF6100-$FF63FF` | 768B | display | Camera/VDP parameter buffers (P1 at $6100, P2 at $6330) |
| `$FF6218-$FF6578` | 864B | entity | 15-entry object array (60B stride) |
| `$FF6800-$FF6830` | 48B | entity | SH2 objects (3 entries, $10 stride) |
| `$FF6900+` | varies | entity | Display entries (racers) |
| `$FF6950-$FF6960` | 16B | display | Display flags and state |
| `$FF9000-$FF90FF` | 256B | entity | Player entity (Object Table 0) |
| `$FF9100-$FF9FFF` | 3840B | entity | AI entities (Table 1, 15 entries x 256B) |
| `$FF9700-$FF9EFF` | 2048B | entity | Secondary objects (Table 2, 8 x 256B) |
| `$FF9F00-$FF9FFF` | 256B | entity | Special entity (Table 3) |
| `$FFA000-$FFA3FF` | 1024B | camera | Camera position data |
| `$FFA400-$FFA7FF` | 1024B | palette | Palette destination (block_copy target) |
| `$FFB400-$FFB7FF` | 1024B | palette | Palette source (block_copy source) |
| `$FFC000-$FFC09F` | 160B | system | System control (track pointers, speed factors, AI state) |
| `$FFC268` | 4B | track | Track data pointer |
| `$FFC710-$FFC73F` | 48B | track | Segment data buffer (5 longwords + 9 words) |
| `$FFC744` | 4B | track | Segment table pointer |
| `$FFC800-$FFC8FF` | 256B | state | Game state machine ($C80C frame toggle, $C80E SH2 busy, $C822 sound cmd, $C87A V-INT state, $C87E sub-state, $C8A0 race state, $C8A8 command staging, $C8BC segment index) |
| `$FFC900-$FFCFFF` | 1792B | state | Extended game state, race data |
| `$FFEF00` | 4B | math | PRNG seed (32-bit state) |
| `$FFFB00` | 4B | sh2 | cmd27 async queue indices |
| `$FFFC00` | 4B | sh2 | General command queue indices |
| `$FFFEE0-$FFFFFF` | 288B | system | Stack area + controller config |

**Initialization:** `adapter_init` at ROM $000936 clears 32,000 bytes (8000 longwords) starting at $FFC800, wrapping around through $FFFFFF to $FF44FF. Individual state variables ($FFC87A, $FFFB00, $FFFC00, $FFC80C, $FFC80E, $FFC82A) are explicitly cleared before the bulk fill.

---

## 3. Memory Primitives

### 3.1 JSR Cascade ("Waterfall") Technique

The game's signature optimization pattern. Instead of DBRA loops (10 cycles overhead per iteration), it uses nested `JSR label(PC)` calls to multiply execution of an unrolled body:

```
; Pseudocode for a 2-level cascade:
cascade_2:
    jsr body(pc)      ; pushes return addr, jumps to body
body:                   ; 16 x MOVE.L D1,(A1)+
    move.l d1,(a1)+
    ...                 ; 15 more
    rts                 ; returns to instruction after the JSR
                        ; → falls through to body again!
                        ; body executes a 2nd time, then RTS exits cascade_2
```

Each nesting level doubles execution. Callers enter at different offsets to select the fill/copy size, making one function body serve dozens of size requirements.

### 3.2 `quad_memory_fill` — ROM $004836 (82 bytes)

4-level JSR cascade over a 16-longword unrolled fill body.

**Registers:** D1 = fill value (longword), A1 = destination (advances)

**Entry points (by offset):**

| Entry | ROM Address | Cascade Depth | Fill Size |
|-------|------------|--------------|-----------|
| `quad_memory_fill` | $004836 | 4 levels | 112 bytes |
| `+4` | $00483A | 3 levels | 96 bytes |
| `+8` | $00483E | 2 levels | 80 bytes |
| `+12` | $004842 | 1 level | 64 bytes |
| `+16` (body) | $004846 | 0 (direct) | variable |

**Callers:** `animated_seq_player.asm:47` (+16), `race_scene_init_004a32.asm:20` (+8), `z80_commands.asm:154` (+8)

**Source:** [quad_memory_fill.asm](disasm/modules/68k/memory/quad_memory_fill.asm)

### 3.3 `fast_fill_128_fixed` — ROM $004888 (66 bytes)

32 consecutive `MOVE.L D1,(A6)` to a **fixed** (non-incrementing) address. Designed for VDP data port / hardware FIFO writes where the destination register is memory-mapped.

**Registers:** D1 = fill value, A6 = destination (fixed, does NOT advance)

**Entry points:** Full (128B), +32 (64B), +48 (32B via `UnrolledFill32` label)

**Callers:** `init_sequence.asm:1076,1080` (2x), `vdp_dma_xfer_vram_clear.asm:52,56` (2x), `z80_commands.asm:150`

**Source:** [fast_fill_128_fixed.asm](disasm/modules/68k/memory/fast_fill_128_fixed.asm)

### 3.4 `triple_memory_copy` — ROM $0048CA (98 bytes)

3-level JSR cascade with an internal skip-ahead JSR. Copies `(A1)+` to `(A2)+`.

The internal structure uses a skip JSR to jump over 16 MOVE.L instructions to reach a second block of 24 MOVE.Ls. On return, the skipped 16 execute, then control falls through to the 24-block again. This creates a 40-longword inner unit that the cascade multiplies.

**Registers:** A1 = source (advances), A2 = destination (advances)

**Entry points:** `+0` (full), `+8` (4x body), `+32` (~160B), `+80` (partial), `+88` (72B via `UnrolledCopy72`)

**Callers:** 11 call sites across 7 files including `v_int_cram_xfer_gate.asm:19`, `race_scene_data_loader.asm:23,26,31,36` (4x), `tile_block_dma_setup.asm:29`

**Source:** [triple_memory_copy.asm](disasm/modules/68k/memory/triple_memory_copy.asm)

### 3.5 `FastCopy20/16/12/8/4` — ROM $004920 (12 bytes)

The **most-used copy function** in the game (28 call sites across 9+ files). Five staggered entry points over 5 consecutive `MOVE.L (A1)+,(A2)+` instructions.

**Registers:** A1 = source, A2 = destination (both advance)

| Entry | Address | Copies |
|-------|---------|--------|
| `FastCopy20` | $004920 | 5 longs = 20 bytes |
| `FastCopy16` | $004922 | 4 longs = 16 bytes |
| `FastCopy12` | $004924 | 3 longs = 12 bytes |
| `FastCopy8` | $004926 | 2 longs = 8 bytes |
| `FastCopy4` | $004928 | 1 long = 4 bytes |

**Source:** [fast_copy.asm](disasm/modules/68k/memory/fast_copy.asm)

### 3.6 `fast_copy_128_fixed` — ROM $00492C (66 bytes)

32 consecutive `MOVE.L (A1)+,(A6)` to a fixed address. The copy equivalent of `fast_fill_128_fixed` — reads from advancing source, writes to fixed destination (VDP data port).

**Registers:** A1 = source (advances by 128), A6 = destination (fixed)

**Entry points:** `FastCopyA6_64` ($00492C, 64B), `FastCopyA6_60` ($00494E, 60B)

**Source:** [fast_copy_128_fixed.asm](disasm/modules/68k/memory/fast_copy_128_fixed.asm)

### 3.7 `block_copy_with_check` — ROM $0046EE (48 bytes)

MOVEM-based 1024-byte block copy with SH2 busy-guard. Copies palette data from $FFB400 (source) to $FFA400 (destination).

**Algorithm:**
1. Set `$FFC048 = 1` (camera state flag)
2. Test bit 7 of `$FFC80E` — if SH2 busy, skip copy entirely
3. Loop 32x: `MOVEM.L (A1)+,D0-D6/A3` (read 32B), `MOVEM.L D0-D6/A3,-(A2)` (write 32B, predecrement)
4. Queue sound `$F3` to `$FFC822`
5. Advance `$FFC8BE` by 4

**Note:** Predecrement on destination means the copy writes backward. A2 starts at $FFA400 and decrements, so actual destination is $FFA000-$FFA3FF.

**Registers:** D0-D6, A1, A2, A3, D7 (all clobbered)

**Source:** [block_copy_with_check.asm](disasm/modules/68k/memory/block_copy_with_check.asm)

---

## 4. PRNG

**ROM address:** $00496E-$004996 (42 bytes)
**Seed location:** `$FFFFEF00` (32-bit state)
**Default seed:** `$2A6D365A`

**Algorithm (multiply-by-41, XOR-fold):**
```
1. D0 = seed from $FFEF00
2. If zero → substitute $2A6D365A
3. D1 = D0           ; copy
4. D1 = D1 << 2      ; × 4
5. D1 = D1 + D0      ; × 5
6. D1 = D1 << 3      ; × 40
7. D1 = D1 + D0      ; × 41
8. D0.W = D1.low + D1.high  ; XOR-fold to 16 bits (addition, not XOR)
9. D1.W = D0.W       ; merge into state
10. SWAP D1           ; rotate high/low
11. Store D1 → $FFEF00
12. Return D0.W = 16-bit random value
```

**Callers (6 per frame):** 3 sound randomizers (`randomized_sound_param_*.asm`) + 3 timer randomizers (`randomized_timer_decrement_*.asm`)

**Source:** `disasm/modules/68k/math/random_number_gen.asm`, `disasm/modules/68k/util/random.asm`

---

## 5. Usage Patterns

### Initialization (boot)
`adapter_init` clears 32,000 bytes starting at $FFC800 (wrapping through $FFFFFF to $FF44FF) using a DBRA loop of 8000 longword writes. Individual state variables are explicitly cleared before the bulk fill.

### Per-Frame Operations
- **Palette copy:** `block_copy_with_check` copies 1KB $FFB400→$FFA400 when SH2 is not busy
- **VDP fills:** `fast_fill_128_fixed` writes repeated longwords to VDP data port (A6 fixed)
- **VDP data transfers:** `fast_copy_128_fixed` streams source data to VDP data port
- **Display list builds:** `FastCopy16` is the workhorse — used for 16-byte sprite parameter copies across the display system
- **Scene loading:** `triple_memory_copy` handles large ROM→WRAM copies during scene transitions (palette, tile data, track graphics)

### Performance Characteristics
| Technique | Throughput | Overhead |
|-----------|-----------|----------|
| DBRA loop (`MOVE.L (A1)+,(A2)+`) | ~12 cycles/long | 10 cycles/iteration (DBRA) |
| Unrolled `MOVE.L` chain | ~12 cycles/long | 0 (no branch) |
| JSR cascade (4-level) | ~12 cycles/long | 4 × JSR+RTS = ~80 cycles total |
| MOVEM (8 registers) | ~8 cycles/long | ~44 cycles setup per 32B block |

The JSR cascade amortizes its ~80 cycle overhead over hundreds of longword moves. For large fills (>64 bytes), it matches raw unrolled speed. For small copies (4-20 bytes), the direct `FastCopy` entry points have zero overhead.

---

## 6. Design Philosophy

1. **Speed over flexibility** — No general-purpose allocator. Every buffer is at a known address, allowing direct `LEA` access without pointer chasing.
2. **Code size over generality** — One unrolled body with multiple entry points serves all copy sizes. The JSR cascade trades 80 bytes of code for thousands of cycles saved per frame.
3. **Hardware-aware variants** — Fixed-address versions (`fast_fill_128_fixed`, `fast_copy_128_fixed`) exist specifically for VDP FIFO writes where the destination must not increment.
4. **Guard patterns** — `block_copy_with_check` tests the SH2 busy flag before large copies, preventing corruption during concurrent DMA operations.
