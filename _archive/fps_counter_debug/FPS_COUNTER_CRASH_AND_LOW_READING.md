# FPS Counter - Crash + Low FPS Reading (06-07)

**Date:** February 8, 2026
**Build:** `build/vr_rebuild.32x` (latest commit)
**Status:** Counter displays 06-07 FPS (should be ~20), game crashes when pressing START

---

## Current Behavior

### Attract Mode
- FPS counter displays **06-07** (looping between these values)
- Counter IS updating (not stuck) — epilogue is executing
- Value is way too low (should be ~20 FPS)

### Pressing START
- VRD logo falls down (normal transition animation)
- **Game crashes** immediately after
- ROM becomes unresponsive

---

## Current Implementation Architecture

### Design Philosophy
**Zero cross-handler dependencies** — ALL FPS logic runs in `vint_epilogue` (after V-INT handler completes). The wrapper only renders cached `fps_value`.

### Code Flow

```
V-INT fires → fps_vint_wrapper
  ├─ NO-WORK: Render cached fps_value, JMP ORIG_VINT
  └─ WORK: JMP ORIG_VINT → original handler → vint_epilogue
      ├─ sh2_wait_queue_empty
      ├─ Detect FS bit transition
      ├─ Increment fps_sample_count
      ├─ Every 20 work frames: sample FPS = delta(fps_flip_counter)
      ├─ fps_render
      └─ RTE
```

### FPS State (14 bytes at $FFFFF000-$FFFFF00D)

| Address | Symbol | Type | Purpose |
|---------|--------|------|---------|
| $FFFFF000 | fps_sample_count | word | Epilogue execution counter (0-19) |
| $FFFFF002 | fps_value | word | Current FPS for display (0-99) |
| $FFFFF004 | fps_flip_counter | long | Total buffer flip count |
| $FFFFF008 | fps_flip_last | long | Last sampled flip count |
| $FFFFF00C | fps_fs_last | word | Last FS bit state (0 or 1) |

**Location rationale:** $FFFFF000 is 256 bytes above game's highest usage ($FFFFEF00 = RANDOM_SEED), ~4KB below stack.

### Current Code (vint_epilogue)

**File:** [disasm/modules/68k/optimization/fps_vint_wrapper.asm:69-103](disasm/modules/68k/optimization/fps_vint_wrapper.asm#L69-L103)

```asm
vint_epilogue:
        move.w  #$2300,sr               ; Re-enable interrupts
        movem.l d0-d2/a0-a1,-(sp)       ; Save regs (sh2_wait_queue_empty clobbers D0/A0/A1)

        bsr.w   sh2_wait_queue_empty    ; Wait for SH2

        ; === DETECT BUFFER FLIP ===
        moveq   #0,d0
        move.b  $00A1518B,d0            ; Read FBCTL low byte
        andi.w  #1,d0                   ; Isolate FS bit (0 or 1)
        cmp.w   fps_fs_last,d0          ; Compare to last known state
        beq.s   .no_flip                ; Same = no flip
        addq.l  #1,fps_flip_counter     ; Flip detected
.no_flip:
        move.w  d0,fps_fs_last          ; Always update last state

        ; === SAMPLE EVERY 20 WORK FRAMES ===
        addq.w  #1,fps_sample_count     ; Increment epilogue execution counter
        cmpi.w  #20,fps_sample_count
        blt.s   .render

        ; Compute FPS = delta(flip_counter) over last 20 work frames
        move.l  fps_flip_counter,d0
        sub.l   fps_flip_last,d0        ; Flips in sample window
        move.w  d0,fps_value            ; Store for display
        move.l  fps_flip_counter,fps_flip_last
        clr.w   fps_sample_count        ; Reset sample counter

.render:
        bsr.w   fps_render

        movem.l (sp)+,d0-d2/a0-a1
        rte
```

### Register Usage

**sh2_wait_queue_empty clobbers:** D0, A0, A1 (documented in sh2_wait_queue_empty.asm:29)

**fps_render saves/restores:** d0-d5/a0-a2 (fps_render.asm:45)

**vint_epilogue saves:** d0-d2/a0-a1

**Problem?** The epilogue uses D0-D2 after calling `sh2_wait_queue_empty` and `fps_render`, which both save their own registers. This should be safe, but might not be if there's unexpected register corruption.

---

## Problem Analysis

### Issue 1: Low FPS Reading (06-07 instead of ~20)

**Expected:** ~20 FPS (VRD runs at 20 FPS per profiling data)
**Actual:** 06-07 FPS

**Measurement logic:**
- Epilogue runs every **work frame** (~20 times/second at 20 FPS)
- Every 20 epilogue executions (≈1 second), sample: `fps_value = fps_flip_counter - fps_flip_last`
- This counts **buffer flips** detected via FS bit transitions

**Possible causes:**

1. **FS bit not flipping every work frame**
   - VRD might not flip buffers on every work frame
   - fn_200_036.asm shows FS toggle happens in state handler, but maybe not all state handlers flip?
   - If VRD flips every 3rd work frame → 20 work frames = 6-7 flips → matches observed value

2. **FS bit transition detection broken**
   - Reading $00A1518B (FBCTL low byte) might not be correct address
   - Timing issue: reading FS before/after the flip happens
   - FS bit might not toggle the way we expect

3. **Sample window wrong**
   - 20 work frames ≠ 1 second if work frame rate varies
   - At attract mode, work frames might be sparse → 20 work frames spans >1 second
   - Actual FPS over that longer window could be 6-7

4. **Flip detection only catches certain transitions**
   - FS transitions 0→1 vs 1→0 might behave differently
   - Initial state mismatch (fps_fs_last initialized to 0, actual FS might start at 1)

### Issue 2: Game Crash on START Press

**Trigger:** Pressing START button during attract mode
**Symptom:** VRD logo falls (normal), then crash (ROM unresponsive)

**Possible causes:**

1. **Register corruption**
   - Despite saving d0-d2/a0-a1, other registers might be corrupted
   - Original V-INT handler expects certain register state that we're breaking
   - The epilogue modifies SR (sets to $2300) which might conflict with handler expectations

2. **Stack imbalance**
   - Epilogue pushes 5 registers (d0-d2/a0-a1 = 20 bytes)
   - If fps_render or sh2_wait_queue_empty doesn't balance stack properly, RTE returns to wrong address
   - Stack pointer corruption during register saves

3. **Memory corruption at $FFFFF000**
   - Despite being "above game data", $FFFFF000 might still be used by game in specific states
   - START press triggers different game state that uses this range
   - Crash occurs when corrupted game data is accessed

4. **Timing issue**
   - The epilogue adds latency (sh2_wait_queue_empty + FS tracking + render)
   - START press might trigger time-critical code that can't tolerate this delay
   - Frame timing expectations violated

5. **FM bit conflict**
   - fps_render toggles FM bit (sets FM=0 for 68K access, restores afterward)
   - If game/SH2 expects FM=1 at specific point after V-INT, we're breaking that assumption
   - START press might trigger code sensitive to FM state

6. **FBCTL register access side effects**
   - Reading $00A1518A/B might have side effects we're not aware of
   - Hardware manual warnings about register access during certain states

---

## Previous Attempts and Failures

### Memory Location Saga

1. **$FFFFE600** → "00" stuck (game data collision)
2. **$FFFFFA00** → "99" stuck (stack collision, 510 bytes from stack base)
3. **$FFFFF800** → "36" stuck (stack overflow during deep V-INT handler nesting)
4. **$0603F210** (attempted 68K SDRAM access) → "99" (68K cannot access SDRAM directly)
5. **$00FFC7F0** (before game's $FFC800) → "00" (game uses this range with sign-extended addressing)
6. **$FFFFF000** (current) → "06-07" + crash

### Architecture Evolution

1. **Wrapper increments tick** → Stuck at 36 (wrapper→epilogue corruption)
2. **Wrapper+epilogue FS tracking** → Stuck at various values (cross-handler dependency fails)
3. **Epilogue-only (current)** → Low FPS + crash (no cross-handler dependency, but still broken)

---

## Hardware Documentation Review

### FBCTL Register ($00A1518A)

From [32x-hardware-manual.md](docs/32x-hardware-manual.md):

**Bits:**
- Bit 15: VBLK (read-only) - V-Blank indicator
- Bit 14: HBLK (read-only) - H-Blank indicator
- Bit 13: PEN (read-only) - Palette access approval
- Bit 1: FEN (R/W) - Frame buffer access authorization
- Bit 0: FS (R/W) - Frame Select (which buffer displayed)

**FS Bit Behavior:**
- Software-controlled (CPU writes to select buffer)
- Actual swap deferred to next V-Blank if written during active display
- Read returns currently displayed buffer

**Critical:** FS is **software-controlled**, not a hardware toggle. VRD must explicitly write BSET/BCLR to change it.

### VRD's Frame Buffer Flip Mechanism

From [disasm/modules/68k/game/fn_200_036.asm](disasm/modules/68k/game/fn_200_036.asm#L45-L51):

```asm
BCHG    #0,(-14324).W       ; Toggle RAM flag at $FFFFC80C
BNE.S   .set_fs
BSET    #0,$00A1518B         ; FS=1 (display DRAM1)
BRA.S   .done
.set_fs:
BCLR    #0,$00A1518B         ; FS=0 (display DRAM0)
.done:
BSET    #7,$00A15100         ; FM=1 (SH2 gets VDP access)
```

**Key insight:** VRD toggles a **RAM flag at $FFFFC80C** first, then sets/clears FS based on that flag. This is inside fn_200_036, which is called from **state handler 6** (one of 16 V-INT state handlers).

**Question:** Does state handler 6 run every work frame, or only on specific frames?

---

## VRD V-INT State Machine

From [disasm/sections/code_200.asm:451-467](disasm/sections/code_200.asm#L451-L467):

```asm
vint_handler:
    tst.w   $FFFFC87A.w         ; Check pending V-INT state
    beq.s   .no_work            ; If zero, nothing to do
    move.w  #$2700,sr           ; Disable all interrupts
    movem.l d0-d7/a0-a6,-(sp)  ; Save 14 registers
    move.w  $FFFFC87A.w,d0      ; Load state index
    move.w  #0,$FFFFC87A.w      ; Clear state
    dc.w    $227B,$0014          ; MOVEA.L (PC,$14),A1
    jsr     (a1)                ; Dispatch to state handler
    addq.l  #1,$FFFFC964.w     ; Increment frame counter
    movem.l (sp)+,d0-d7/a0-a6  ; Restore 14 registers
    jmp     vint_epilogue+$880000
.no_work:
    rte
```

**16-state dispatch system** — different handlers run on different work frames.

**Question:** Which state handler is fn_200_036 (the one that flips FS)? Does it run every work frame or every Nth frame?

---

## Critical Questions

### 1. FS Bit Flip Frequency
**Q:** Does VRD flip the FS bit on **every work frame**, or only every **Nth work frame**?

**Evidence:**
- Observed: 6-7 flips per 20 work frames
- This suggests: FS flips every ~3 work frames (20 work frames ÷ 3 ≈ 6.67 flips)
- OR: FS flips only when certain state handler runs

**Need:** Trace which state handler contains fn_200_036 and how often it executes.

### 2. Register Save Completeness
**Q:** Does the epilogue need to save **more registers** than d0-d2/a0-a1?

**Evidence:**
- Crash occurs after START press (state transition)
- Original V-INT handler saves **d0-d7/a0-a6** (14 registers)
- Our epilogue only saves **d0-d2/a0-a1** (5 registers)

**Concern:** If the epilogue clobbers d3-d7 or a2-a6, the original handler's register restore will put back WRONG values.

**Test:** Save **all 14 registers** in epilogue to match original handler.

### 3. Memory Location Safety
**Q:** Is $FFFFF000 truly safe, or does the game use it during specific states?

**Evidence:**
- Works in attract mode (06-07 FPS, no crash)
- Crashes when pressing START (different game state)

**Hypothesis:** START press activates code that uses $FFFFF000 range.

**Test:** Move FPS state to a completely different location, or use COMM registers for diagnostics.

### 4. Stack Pointer Integrity
**Q:** Is the stack pointer correctly balanced after epilogue RTE?

**Check:**
- Entry: SR pushed (2 bytes), PC pushed (4 bytes) → SP-=6
- Epilogue: movem.l d0-d2/a0-a1,-(sp) → SP-=20
- Epilogue: bsr sh2_wait_queue_empty → SP-=4 (return address)
- sh2_wait_queue_empty: rts → SP+=4
- Epilogue: bsr fps_render → SP-=4
- fps_render: saves d0-d5/a0-a2 → SP-=36, restores → SP+=36, rts → SP+=4
- Epilogue: movem.l (sp)+,d0-d2/a0-a1 → SP+=20
- Epilogue: rte → SP+=6

**Total:** Balanced if all functions return properly.

**Risk:** If sh2_wait_queue_empty or fps_render doesn't return, stack is unbalanced → RTE returns to wrong address.

### 5. FM Bit Timing
**Q:** Does fps_render's FM bit toggle conflict with game expectations?

**fps_render flow:**
```asm
move.w  $00A15100,d5        ; Save FM state
bclr    #7,$00A15100        ; FM=0 (68K gets frame buffer access)
; ... write pixels ...
btst    #15,d5              ; Was FM=1?
beq.s   .fm_done
bset    #7,$00A15100        ; Restore FM=1
```

**Concern:** If VRD expects FM=1 immediately after V-INT epilogue, we're temporarily setting FM=0 which might break SH2 assumptions.

---

## Recommended Debug Steps

### Priority 1: Isolate Crash Cause

**Test A:** Remove fps_render from epilogue entirely, just track FPS without displaying

```asm
.render:
        ; bsr.w   fps_render    ; COMMENTED OUT
        movem.l (sp)+,d0-d2/a0-a1
        rte
```

**Expected:** If crash disappears → fps_render is the culprit (FM bit or register corruption)

---

### Priority 2: Verify FS Bit Flip Frequency

**Test B:** Display `fps_flip_counter % 100` instead of FPS delta

```asm
.render:
        ; Show raw flip count to verify detection works
        move.l  fps_flip_counter,d0
        divu    #100,d0
        swap    d0
        move.w  d0,fps_value        ; Display last 2 digits of total flips

        bsr.w   fps_render
```

**Expected:** Counter should increment by 1 every time FS flips. If it increments slowly → FS doesn't flip every frame.

---

### Priority 3: Match Original Handler Register Saves

**Test C:** Save ALL 14 registers in epilogue (match original handler)

```asm
vint_epilogue:
        move.w  #$2300,sr
        movem.l d0-d7/a0-a6,-(sp)   ; Save ALL 14 registers

        bsr.w   sh2_wait_queue_empty
        ; ... (FPS logic)
        bsr.w   fps_render

        movem.l (sp)+,d0-d7/a0-a6   ; Restore ALL 14 registers
        rte
```

**Expected:** If crash disappears → register corruption was the cause.

---

### Priority 4: Alternative FPS Measurement

**Test D:** Count work frames directly instead of FS flips

```asm
vint_epilogue:
        ; Increment work frame counter (epilogue runs once per work frame)
        addq.l  #1,fps_flip_counter

        addq.w  #1,fps_sample_count
        cmpi.w  #20,fps_sample_count
        blt.s   .render

        ; FPS = work frames in last 20-frame window
        move.l  fps_flip_counter,d0
        sub.l   fps_flip_last,d0
        move.w  d0,fps_value
        move.l  fps_flip_counter,fps_flip_last
        clr.w   fps_sample_count

.render:
        bsr.w   fps_render
        movem.l (sp)+,d0-d2/a0-a1
        rte
```

**Expected:** Should show "20" every sample (epilogue runs 20 times → 20 work frames → FPS=20).

---

## Files for Review

### Implementation
- [disasm/modules/68k/optimization/fps_vint_wrapper.asm](disasm/modules/68k/optimization/fps_vint_wrapper.asm) — Wrapper + epilogue
- [disasm/modules/68k/optimization/fps_render.asm](disasm/modules/68k/optimization/fps_render.asm) — Renderer (proven working with #42 test)
- [disasm/modules/68k/boot/ring_buffer_init.asm](disasm/modules/68k/boot/ring_buffer_init.asm) — FPS state initialization

### VRD Reference
- [disasm/modules/68k/game/fn_200_036.asm](disasm/modules/68k/game/fn_200_036.asm) — Frame buffer flip mechanism
- [disasm/sections/code_200.asm](disasm/sections/code_200.asm) — V-INT handler + state dispatch

### Hardware Docs
- [docs/32x-hardware-manual.md](docs/32x-hardware-manual.md) — FBCTL register, FM bit, VDP access rules

---

## Summary

We have an FPS counter that:
- ✅ **Executes** (values update, not stuck)
- ✅ **Renders** (display works)
- ✅ **Detects transitions** (FS tracking logic runs)
- ❌ **Shows wrong value** (06-07 instead of ~20)
- ❌ **Crashes game** (START press → logo falls → unresponsive)

The most likely issues:
1. **FS bit doesn't flip every work frame** → Need to verify VRD's flip frequency
2. **Register corruption** → Need to save all 14 registers like original handler
3. **fps_render FM bit toggle** → Need to test without rendering

**Recommended first test:** Remove fps_render from epilogue to isolate crash cause.

---

**Last Updated:** February 8, 2026
**For Review By:** Codex
**Build:** `build/vr_rebuild.32x` (commit after transition-based FS detection)
