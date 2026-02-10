# FPS Counter Stuck at "00" - Current State Summary

**Date:** February 8, 2026
**Build:** `build/vr_rebuild.32x` (commit after fps_vint_wrapper.asm rewrite)
**Status:** Counter displays stable "00" in both attract mode and gameplay

---

## What We Just Did

### Architecture Change (Research-Based)

Rewrote [disasm/modules/68k/optimization/fps_vint_wrapper.asm](disasm/modules/68k/optimization/fps_vint_wrapper.asm) based on thorough hardware/VRD research:

**OLD design (broken):**
- Wrapper: Track FS bit transitions, increment tick, render on no-work frames
- Epilogue: Sample FPS once/second, render on work frames
- Problem suspected: Stack corruption of shared RAM at $FFFFF800

**NEW design (current):**
- Wrapper: Only increment tick (`addq.w #1,fps_vint_tick`), render on no-work frames, jump to handler
- Epilogue: Track FS bit transitions, sample FPS once/second, render on work frames
- Rationale: VRD flips FS **inside** V-INT state handlers (fn_200_036) → epilogue sees post-flip state

### Research Findings That Informed The Change

1. **Stack Safety Proven:**
   - Initial SSP: $01000000 → wraps to $000000 on 24-bit bus
   - V-INT handler max depth: ~72 bytes → SP never below ~$FFFFFFB0
   - Distance to $FFFFF800: **1,968 bytes** — completely safe
   - $FFFFF800 range: Zero references in game code (grep confirmed)

2. **FS Bit Hardware Behavior (from 32X manual):**
   - Register: FBCTL at $00A1518A, bit 0 = FS (Frame Select)
   - Type: R/W by software
   - Swap timing: If written during active display, deferred to next V-Blank
   - Read returns: Currently displayed buffer

3. **VRD Frame Buffer Flip Mechanism (from fn_200_036.asm):**
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
   - Happens **only inside V-INT state handlers** (work frames only)
   - Called via 16-state dispatch table
   - No-work frames (RTE immediately) never touch FS

4. **V-INT Execution Flow:**
   ```
   V-INT fires → fps_vint_wrapper (our code)
     → JMP ORIG_VINT ($00881684)
       → Work gate: tst.w $FFFFC87A
       ├─ NO WORK: RTE (immediate return)
       └─ WORK: movem.l d0-d7/a0-a6,-(sp)
                dispatch state handler (may call fn_200_036 → FS flip)
                movem.l (sp)+,d0-d7/a0-a6
                JMP vint_epilogue (our code)
                  → sh2_wait_queue_empty
                  → FS tracking + FPS sampling + rendering
                  → RTE
   ```

5. **Previous "99" Root Cause:**
   - NOT stack corruption (proven impossible with 1,968 byte safety margin)
   - Was COMM5 display bug (renderer read active SH2 protocol register instead of fps_value)
   - Control test proved: epilogue writes #42 → stable "42" display → data path works

---

## Current Implementation

### fps_vint_wrapper (lines 66-81)

```asm
fps_vint_wrapper:
        ; 60 Hz time base
        addq.w  #1,fps_vint_tick        ; $FFFFF800 (word)

        ; Check work gate
        tst.w   $FFFFC87A.w
        bne.s   .work

        ; NO-WORK PATH: Render cached fps_value
        bsr.w   fps_render

.work:
        jmp     ORIG_VINT               ; $00881684
```

**Properties:**
- No register saves (addq.w/tst.w only modify CCR, saved in exception frame)
- Only writes 1 word to RAM: `fps_vint_tick` at $FFFFF800
- Cost: ~16 cycles on work path, ~16 + fps_render on no-work path

### vint_epilogue (lines 101-136)

```asm
vint_epilogue:
        move.w  #$2300,sr               ; Re-enable interrupts
        movem.l d0-d1/a0-a1,-(sp)       ; Save regs

        bsr.w   sh2_wait_queue_empty    ; Wait for SH2

        ; === FS BIT TRANSITION DETECTOR ===
        moveq   #0,d0
        move.b  $00A1518B,d0            ; FBCTL low byte
        andi.w  #1,d0                   ; Isolate FS bit
        cmp.w   fps_fs_last,d0          ; Compare to last state
        beq.s   .no_flip
        addq.l  #1,fps_flip_counter     ; Flip detected
.no_flip:
        move.w  d0,fps_fs_last          ; Always update

        ; === ONCE-PER-SECOND FPS SAMPLE ===
        cmpi.w  #60,fps_vint_tick       ; 60 V-INTs = 1 second
        blt.s   .render
        move.l  fps_flip_counter,d0
        sub.l   fps_flip_last,d0        ; Delta = FPS
        move.w  d0,fps_value            ; Store for display
        move.l  fps_flip_counter,fps_flip_last
        subi.w  #60,fps_vint_tick

.render:
        bsr.w   fps_render

        movem.l (sp)+,d0-d1/a0-a1
        rte
```

### fps_render.asm (unchanged)

Proven working with control test (#42 → displays "42"). Reads `fps_value` at $FFFFF802, modulo 100, splits tens/ones, renders to both frame buffers.

### RAM Layout ($FFFFF800-$FFFFF80D, 14 bytes)

| Address | Symbol | Type | Written by | Read by |
|---------|--------|------|-----------|---------|
| $FFFFF800 | fps_vint_tick | word | Wrapper | Epilogue |
| $FFFFF802 | fps_value | word | Epilogue | fps_render (both paths) |
| $FFFFF804 | fps_flip_counter | long | Epilogue | Epilogue |
| $FFFFF808 | fps_flip_last | long | Epilogue | Epilogue |
| $FFFFF80C | fps_fs_last | word | Epilogue | Epilogue |

**Cross-handler dependency:** Only `fps_vint_tick` (wrapper writes, epilogue reads)

---

## Problem: FPS Shows "00"

### Observed Behavior
- Display: Stable "00" in both attract mode and gameplay
- ROM: Builds clean, runs 600 frames in profiler without crash
- Previous control test: `move.w #42,fps_value` in epilogue → stable "42" display

### What "00" Could Mean

#### Hypothesis 1: fps_value Never Gets Written
**Symptom:** Initialized to 0 at boot (ring_buffer_init.asm), never updated
**Implies:**
- Epilogue never reaches the sampling block (`cmpi.w #60,fps_vint_tick` → `blt.s .render`)
- OR fps_flip_counter delta is always 0 (no flips detected)

**Test:**
- Add control value write in epilogue: `move.w #99,fps_value` before `.render` label
- If displays "99" → epilogue executes, sampling logic is broken
- If still displays "00" → epilogue doesn't execute OR fps_render path broken

#### Hypothesis 2: fps_vint_tick Never Reaches 60
**Symptom:** Wrapper's `addq.w #1,fps_vint_tick` not persisting to epilogue
**Implies:**
- Wrapper writes tick to $FFFFF800
- **Something overwrites $FFFFF800 before epilogue reads it**
- Epilogue always sees tick < 60 → never samples

**Test:**
- Display `fps_vint_tick` value instead of `fps_value` (change fps_render source address)
- If displays incrementing numbers (0-59 loop) → tick works, sampling broken
- If displays "00" → tick writes not persisting (corruption hypothesis returns)

#### Hypothesis 3: FS Bit Never Changes
**Symptom:** VRD never flips frame buffers during profiler run
**Implies:**
- `fps_flip_counter` stays at 0
- Delta always 0 → fps_value set to 0 every sample

**Unlikely because:**
- VRD runs at ~20 FPS (profiling confirmed)
- fn_200_036 clearly toggles FS bit on work frames
- We tested during gameplay (should have work frames)

**Test:**
- Display `fps_flip_counter % 100` (cumulative, should increment even if slowly)
- If displays "00" → no flips detected ever
- If displays incrementing → flips detected, sampling math broken

#### Hypothesis 4: Work Frames Never Happen
**Symptom:** Epilogue never executes (only RTE path taken)
**Implies:**
- $FFFFC87A always 0 during test
- Only no-work path renders (displays cached fps_value = 0 from init)

**Unlikely because:**
- Profiler shows normal SH2 activity (rendering happening)
- Game plays normally (requires work frames)

**Test:**
- Add control value write in **wrapper** no-work path: `move.w #88,fps_value` before `bsr.w fps_render`
- If displays "88" → only no-work frames execute (work path broken)
- If displays "00" → neither wrapper nor epilogue writes fps_value

---

## Debug Strategy — Sentinel Values

Add 3 sentinel writes to isolate where execution breaks:

### Test A: Wrapper No-Work Path
```asm
fps_vint_wrapper:
        addq.w  #1,fps_vint_tick
        tst.w   $FFFFC87A.w
        bne.s   .work

        move.w  #11,fps_value           ; SENTINEL: no-work path executes
        bsr.w   fps_render
.work:
        jmp     ORIG_VINT
```

### Test B: Epilogue Entry
```asm
vint_epilogue:
        move.w  #$2300,sr
        movem.l d0-d1/a0-a1,-(sp)

        move.w  #22,fps_value           ; SENTINEL: epilogue executes

        bsr.w   sh2_wait_queue_empty
        ; ... (rest of code)
```

### Test C: Epilogue Sampling Block
```asm
        cmpi.w  #60,fps_vint_tick
        blt.s   .render

        move.w  #33,fps_value           ; SENTINEL: sampling triggered

        move.l  fps_flip_counter,d0
        sub.l   fps_flip_last,d0
        move.w  d0,fps_value            ; Overwrite sentinel with real FPS
        ; ... (rest of sampling)
```

### Expected Results

| Display | Meaning |
|---------|---------|
| "00" | None of the 3 sentinels executed → **massive control flow problem** |
| "11" | Only no-work path executes → work frames not happening OR epilogue broken |
| "22" | Epilogue runs but sampling never triggered → tick not reaching 60 |
| "33" → number | Sampling runs, real FPS computed → **FPS counter should work!** |
| "33" stuck | Sampling runs once, then fps_value overwritten back to 0 somehow |

---

## Alternative: Display Raw Diagnostic Values

Instead of sentinels, display intermediate computation values:

### Option 1: Display fps_vint_tick
Change fps_render to read from `fps_vint_tick` ($FFFFF800) instead of `fps_value` ($FFFFF802).

**Expected:** 0→59 looping pattern (proves wrapper→epilogue data path)

### Option 2: Display fps_flip_counter % 100
Change epilogue sampling to:
```asm
.render:
        move.l  fps_flip_counter,d0     ; Get cumulative flip count
        divu    #100,d0                 ; Modulo 100
        swap    d0
        move.w  d0,fps_value            ; Display last 2 digits
        bsr.w   fps_render
```

**Expected:** Incrementing 0→20→40→60→80→00 pattern (proves FS tracking works)

### Option 3: Display Work Frame Indicator
```asm
vint_epilogue:
        move.w  #$2300,sr
        movem.l d0-d1/a0-a1,-(sp)

        addq.w  #1,fps_value            ; Increment each epilogue execution

        bsr.w   sh2_wait_queue_empty
        ; ... (skip all sampling logic for this test)
        bsr.w   fps_render
```

**Expected:** Incrementing 0→20→40→60... (proves epilogue runs ~20 times/second)

---

## Questions for Codex

1. **Does the execution flow make sense?**
   - Wrapper increments tick every V-INT
   - Work frames jump to epilogue (reads tick, tracks FS, samples FPS)
   - No-work frames render cached fps_value directly

2. **Is there a timing issue with FS bit reads?**
   - We read FS **after** sh2_wait_queue_empty (SH2 done rendering)
   - fn_200_036 flips FS **during** state handler (before epilogue)
   - Should we read FS at a different point in the epilogue?

3. **Could the work gate logic be wrong?**
   - We check `tst.w $FFFFC87A.w` in wrapper
   - Original handler checks the same flag
   - Does jumping to ORIG_VINT bypass the work gate somehow?

4. **Is fps_vint_tick being corrupted?**
   - Wrapper writes to $FFFFF800
   - Stack proven safe (1,968 bytes clearance)
   - Game code doesn't touch $FFFFF800 (grep confirmed)
   - **But what if the V-INT handler itself overwrites it?**

5. **Should we verify initialization?**
   - ring_buffer_init.asm clears $FFFFF800-$FFFFF80D at boot
   - Does this run before our wrapper gets called?
   - Could fps_value be stuck at init value because nothing ever writes to it?

---

## Files for Review

### Core Implementation
- [disasm/modules/68k/optimization/fps_vint_wrapper.asm](disasm/modules/68k/optimization/fps_vint_wrapper.asm) — wrapper + epilogue (JUST REWRITTEN)
- [disasm/modules/68k/optimization/fps_render.asm](disasm/modules/68k/optimization/fps_render.asm) — renderer (PROVEN WORKING)
- [disasm/modules/68k/boot/ring_buffer_init.asm](disasm/modules/68k/boot/ring_buffer_init.asm) — RAM initialization

### Integration Points
- [disasm/sections/header.asm](disasm/sections/header.asm) lines 68-69 — V-INT vector → $0089C208
- [disasm/sections/code_200.asm](disasm/sections/code_200.asm) line 464 — JMP vint_epilogue
- [disasm/sections/code_1c200.asm](disasm/sections/code_1c200.asm) lines 38-41 — Module includes

### VRD Reference Code
- [disasm/modules/68k/game/fn_200_036.asm](disasm/modules/68k/game/fn_200_036.asm) — Frame buffer flip mechanism

---

## Build Status

- `make all`: ✅ Clean build
- Profiler (600 frames): ✅ No crash
- PicoDrive boot: ✅ Boots to attract mode
- FPS display: ❌ Shows "00" (not working)

---

## Previous Test History

1. **Initial attempts:** Counter stuck at "00" → memory collision at $FFFFE600
2. **Relocated to $FFFFFA00:** Counter shows "99" → stack collision suspected (510 bytes from stack base)
3. **Relocated to $FFFFF800:** Counter still shows "99" → COMM5 display bug discovered
4. **Control test:** `move.w #42,fps_value` in epilogue → stable "42" display ✅ (render path proven)
5. **Real FPS logic:** FS tracking in wrapper → "99" persisted (computation bugs)
6. **Architecture change:** FS tracking moved to epilogue → now shows "00" ❌

---

**Key Question:** Why does the control test work (#42 → displays "42") but the real FPS computation produces "00"?

The only difference:
- Control test: Direct write `move.w #42,fps_value` before `bsr.w fps_render`
- Real logic: Computed write from `fps_flip_counter` delta

Something in the computation path is broken, OR the sampling condition is never met.

**Recommended next step:** Add sentinel value "22" at epilogue entry to prove epilogue executes.
