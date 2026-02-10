# FPS Counter Debug - Still Showing 00

**Date**: February 8, 2026
**Status**: ~~Counter displays "00" consistently~~ **ROOT CAUSE FOUND AND FIXED**
**Context**: Virtua Racing Deluxe 32X - trying to add on-screen FPS counter

---

## ⚠️ UPDATE: ROOT CAUSE IDENTIFIED AND FIXED

**See [FPS_COUNTER_ADDRESS_BUG_RESOLUTION.md](FPS_COUNTER_ADDRESS_BUG_RESOLUTION.md) for complete details.**

**TL;DR**: EQU symbols with `.w` suffix generated wrong addresses in vasm. All RAM operations were accessing ROM instead ($00FFxxxx vs $FFFFxxxx). Fixed by using explicit `$FFFFxxxx.w` addresses throughout.

**Files fixed:**
- `fps_vint_wrapper.asm` - 9 locations
- `fps_render.asm` - 1 location

**Binary verified**: All addresses now correct. Counter should work.

**Original debug log preserved below for reference:**

---

## What We've Proven Works ✅

1. **V-INT vector redirect**: ROM offset $78 → $0089C208 (wrapper entry) ✓
2. **Wrapper executes**: Earlier sentinel test showed "11" for 1 second ✓
3. **fps_render executes**: Counter box visible on screen (shows "00") ✓
4. **Digit rendering works**: Font/LUT verified, can display any value
5. **Binary verification**: All code assembled correctly at expected offsets

---

## What We've Tried (All Show "00")

### Attempt 1: Work-path counter ($C964)
- **Method**: Sample `$C964` (frame counter, increments when $C87A != 0)
- **Result**: First test showed "11" then "0", later tests showed "34" (work cadence, not display)
- **Issue**: Measures state updates, not display rate

### Attempt 2: Flip counter in fn_200_041
- **Method**: Increment counter in `fps_marker_hook` (called from fn_200_041)
- **Result**: Counter shows "00"
- **Issue**: fn_200_041 is state-gated - only runs when state machine in state 41

### Attempt 3: V-INT proxy counter
- **Method**: Increment counter in wrapper (every V-INT, before original handler)
- **Code**: `addq.l #1,fps_flip_counter.w` at wrapper line 64
- **Result**: Counter shows "00"
- **Issue**: ??? Counter should increment to 60, sample should show 60

---

## Current Implementation (Still Broken)

### Wrapper (fps_vint_wrapper.asm)
```asm
fps_vint_wrapper:
        addq.w  #1,fps_vint_tick.w              ; Increment tick: 0→60
        addq.l  #1,fps_flip_counter.w           ; Increment counter every V-INT
        cmpi.w  #60,fps_vint_tick.w             ; Check if 1 second
        blt.s   .skip_sample

        ; Sample once per second:
        move.l  fps_flip_counter.w,d0           ; Read counter
        sub.l   fps_flip_last.w,d0              ; Subtract last snapshot
        move.w  d0,fps_value.w                  ; Store result → display
        move.l  fps_flip_counter.w,fps_flip_last.w
        clr.w   fps_vint_tick.w

.skip_sample:
        ; Render gated by work/no-work path
        tst.w   $C87A
        bne.s   .skip_no_work_render
        bsr.w   fps_render                      ; Render on no-work frames
.skip_no_work_render:
        jmp     ORIG_VINT
```

### Render (called from both paths)
- **No-work path**: BSR in wrapper (most frames)
- **Work path**: BSR in vint_epilogue (fewer frames)

### RAM Variables ($C8F8-$C907)
```
$C8F8: fps_vint_tick    (word) - tick counter 0-59
$C8FA: fps_value        (word) - display value (what fps_render reads)
$C900: fps_flip_counter (long) - incremented every V-INT
$C904: fps_flip_last    (long) - snapshot from last sample
```

---

## The Mystery

**Expected behavior:**
1. Every V-INT: tick++, counter++
2. After 60 V-INTs: fps_value = counter - last = 60
3. Display shows "60"

**Actual behavior:**
- Display shows "00" consistently
- Earlier test showed "11" (constant write worked)
- Later test showed "34" (work-path sampling worked)
- Current test shows "00" (V-INT sampling fails?)

**Contradiction:**
- Wrapper MUST execute (earlier "11" sentinel proved it)
- Counter increment is at line 64 of wrapper (verified in binary)
- Sampling logic verified in binary
- But result is always 0

---

## Binary Verification (Build Feb 8 17:21)

### Wrapper at $1C208
```
$1C208: 5278 c8f8                addq.w  #1,$C8F8    ; tick++
$1C20C: 52B9 00FF C900           addq.l  #1,$C900    ; counter++
$1C212: 0c78 003c c8f8           cmpi.w  #60,$C8F8
$1C218: 6d1a                     blt.s   .skip_sample
$1C21A: 2f00                     move.l  d0,-(sp)
$1C21C: 2038 c900                move.l  $C900.w,d0  ; Read counter
$1C220: 90b8 c904                sub.l   $C904.w,d0  ; Subtract last
$1C224: 31c0 c8fa                move.w  d0,$C8FA    ; Store result
```

**All instructions verified correct.**

---

## Possible Root Causes

### 1. Counter Never Increments ($C900 stuck at 0)
- **Test**: addq.l instruction doesn't execute?
- **Test**: $C900 address wrong/invalid?
- **Test**: Something clears $C900 after increment?

### 2. Counter Increments But Sampling Reads 0
- **Test**: Both reads of $C900 return same value (timing)?
- **Test**: Subtraction logic broken?

### 3. Display Shows 0 Despite fps_value != 0
- **Test**: fps_render reads wrong address?
- **Evidence against**: Earlier tests DID display values (11, 34)

### 4. RAM Corruption or Collision
- **Test**: $C900-$C907 used by game code?
- **Note**: Earlier stack corruption at $FFFFFE00, moved to $C8F8

### 5. Render Cadence Mismatch (AGAIN)
- **Test**: fps_render samples before wrapper increments?
- **Note**: Render gated by $C87A, might sample at wrong time

---

## Questions for Fresh Eyes

1. **Why does constant write work but counter fails?**
   - `move.w #$11,fps_value` → displays "11" ✓
   - Counter++ → sample → store → displays "00" ❌

2. **Could wrapper be bypassed after first execution?**
   - ROM vector verified pointing to wrapper
   - But maybe emulator caches handler address?

3. **Is $C900 safe to use?**
   - 14KB from stack top
   - But in "hot" $C8xx-$C9xx game state region
   - Could be cleared by range init or table copy

4. **Does addq.l to absolute.w work correctly?**
   - Binary shows: 52B9 00FF C900
   - Is this the right encoding?

5. **Timing issue between increment and render?**
   - Wrapper: increment → check work flag → maybe render
   - Could render execute BEFORE increment somehow?

---

## Suggested Next Steps

1. **Add COMM register diagnostic** (independent of RAM):
   ```asm
   addq.l  #1,fps_flip_counter.w
   move.l  fps_flip_counter.w,$00A15128  ; Mirror to COMM4
   ```
   Check COMM4 in debugger - if it increments, counter works

2. **Test with simpler display** (no sampling):
   ```asm
   addq.w  #1,fps_vint_tick.w      ; Just show tick counter
   move.w  fps_vint_tick.w,fps_value.w  ; Display directly (0-60)
   ```
   Earlier version had this but still showed 00

3. **Verify RAM writes work**:
   ```asm
   move.l  #$12345678,$C900        ; Write constant
   move.l  $C900,d0                ; Read back
   move.w  d0,fps_value.w          ; Display low word
   ```

4. **Check if wrapper actually runs every V-INT**:
   - Add visible side effect (CRAM write) in wrapper
   - Should see flicker if running 60 times/sec

5. **Test on real hardware** (not emulator):
   - PicoDrive might cache V-INT handler address
   - Or have bugs with ROM vector redirect

---

## Key Files

- `disasm/modules/68k/optimization/fps_vint_wrapper.asm` - Counter increment + sampling
- `disasm/modules/68k/optimization/fps_render.asm` - Display logic (2-digit font)
- `disasm/modules/68k/boot/ring_buffer_init.asm` - RAM initialization
- `disasm/sections/header.asm:68-69` - V-INT vector redirect

---

## Summary

We have a **display system that works** (proved by earlier "11" and "34" values), a **wrapper that executes** (proved by "11" sentinel), and **verified binary code**. But somehow **counter-based FPS measurement always shows 00**.

The most likely issues:
1. RAM corruption (something clearing $C900)
2. Timing issue (render samples wrong moment)
3. Emulator bug (caching or V-INT redirect issue)
4. Subtle logic error we're missing

**What would help:**
- Fresh eyes on the control flow
- Explanation for why constant write works but counter doesn't
- Test suggestions that isolate increment vs. sample vs. display
