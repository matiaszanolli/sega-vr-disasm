# FPS Counter - Codex Review Request

**Date**: February 8, 2026
**Status**: Counter still displays "00" after multiple fix attempts
**Request**: Fresh eyes needed - we're stuck

---

## The Goal

Add an on-screen FPS counter to Virtua Racing Deluxe (32X) that displays actual frames per second during gameplay. Counter should measure real display rate, not internal state updates.

---

## What We Know Works ✅

These have been **independently verified**:

1. **V-INT wrapper executes**: Earlier sentinel test (`move.w #$11,fps_value`) showed "11" on screen for 1 second, proving:
   - V-INT vector redirect works (ROM $78 → $0089C208)
   - Wrapper code executes every V-INT
   - Control flow reaches sampling/storage code

2. **Display system works**: Counter box renders correctly, has shown multiple values:
   - "11" (constant write test)
   - "34" (work-path counter test)
   - "00" (current implementation)

   This proves fps_render reads *something* and displays it correctly.

3. **Binary verification passes**: All assembled code at expected addresses, opcodes correct per disassembly.

4. **Initialization runs**: `ring_buffer_init` called from adapter_init, clears all FPS RAM variables at boot.

---

## What We're Trying to Do

### High-Level Logic

```
Every V-INT (60 Hz):
    tick_counter++
    flip_counter++

    if tick_counter == 60:  // 1 second elapsed
        fps = flip_counter - last_snapshot
        display_value = fps
        last_snapshot = flip_counter
        tick_counter = 0

Every frame:
    render display_value to screen
```

### RAM Variables

| Address | Size | Name | Purpose |
|---------|------|------|---------|
| $FFFFC8F8 | word | fps_vint_tick | Tick counter (0→59→0) |
| $FFFFC8FA | word | fps_value | Display value (what renders) |
| $FFFFC900 | long | fps_flip_counter | Cumulative count |
| $FFFFC904 | long | fps_flip_last | Snapshot from last second |

### Implementation Files

- **fps_vint_wrapper.asm**: V-INT wrapper, increments counters, samples once/second
- **fps_render.asm**: Reads fps_value, renders 2-digit display
- **ring_buffer_init.asm**: Clears variables at boot
- **header.asm**: V-INT vector redirect

---

## Current Problem

**Counter always displays "00"** despite:
- Wrapper proven to execute (sentinel test)
- Display proven to work (showed 11 and 34)
- Code logic looks correct
- Binary verification passes

---

## What We've Tried (Chronologically)

### Attempt 1: Measure Work-Path Counter
- **Method**: Sample `$FFFFC964` (game's frame counter)
- **Result**: Showed "34" consistently
- **Issue**: Measures state updates (~34/sec), not display rate (~20-24 FPS)

### Attempt 2: Hook Buffer Flip in fn_200_041
- **Method**: Increment counter in `fps_marker_hook`
- **Result**: Counter showed "00"
- **Issue**: fn_200_041 only runs in state 41, misses flips from states 036-040

### Attempt 3: V-INT Proxy Counter
- **Method**: Increment counter in wrapper (every V-INT regardless of state)
- **Result**: Still "00"
- **Issue**: Unknown

### Attempt 4: Fix Addressing Mode Bug
- **Found**: EQU symbols with `.w` suffix generated wrong addresses in binary
- **Before**: `addq.l #1,fps_flip_counter.w` → binary `52B9 00FF C900` (targets $00FFC900 ROM)
- **After**: `addq.l #1,$FFFFC900.w` → binary `52B8 C900` (targets $FFFFC900 RAM)
- **Fixed**: 9 locations in wrapper, 1 in render
- **Result**: **Still shows "00"** (per user report)

---

## Binary Verification (Latest Build)

### Wrapper - Counter Increment
```
$1C20C: 52b8 c900          addq.l #1,$C900.w
```
- Opcode: 52B8 = ADDQ.L #1,(xxx).W (absolute word mode)
- Address: $C900 (sign-extends to $FFFFC900)
- **This looks correct**

### Wrapper - Sample and Store
```
$1C21A: 2038 c900          move.l $C900.w,d0      ; Read counter
$1C21E: 90b8 c904          sub.l  $C904.w,d0      ; Subtract last
$1C222: 31c0 c8fa          move.w d0,$C8FA.w      ; Store fps_value
$1C226: 21f8 c900 c904     move.l $C900.w,$C904.w ; Update snapshot
```
- All addresses use absolute word mode with sign-extension
- **All look correct**

### Render - Read Display Value
```
$1C27A: 3038 c8fa          move.w $C8FA.w,d0
```
- Reads fps_value from RAM
- **Looks correct**

---

## Code Snippets (Current State)

### fps_vint_wrapper.asm (lines 57-82)
```asm
fps_vint_wrapper:
        ; Always increment tick counter (runs every V-INT)
        addq.w  #1,$FFFFC8F8.w

        ; Increment flip counter (proxy: ~1 flip per V-INT)
        addq.l  #1,$FFFFC900.w

        ; Check if 60 ticks have elapsed (1 second on NTSC)
        cmpi.w  #60,$FFFFC8F8.w
        blt.s   .skip_sample

        ; === FPS Sample (runs once per second) ===
        move.l  d0,-(sp)                       ; Save D0

        move.l  $FFFFC900.w,d0                 ; Current flip count
        sub.l   $FFFFC904.w,d0                 ; D0 = flips in last second
        move.w  d0,$FFFFC8FA.w                 ; Store for display

        move.l  $FFFFC900.w,$FFFFC904.w        ; Update snapshot
        move.l  (sp)+,d0                       ; Restore D0

        clr.w   $FFFFC8F8.w                    ; Reset tick counter

.skip_sample:
        ; Gate render by work/no-work state
        tst.w   $FFFFC87A.w                    ; Check work pending flag
        bne.s   .skip_no_work_render           ; If work, epilogue will render

        ; NO-WORK PATH: Render on idle frames
        bsr.w   fps_render

.skip_no_work_render:
        jmp     ORIG_VINT                      ; Jump to original handler
```

### fps_render.asm (line 54)
```asm
        move.w  $FFFFC8FA.w,d0          ; Read fps_value from RAM
```

### ring_buffer_init.asm (lines 43-48)
```asm
        ; Initialize FPS counter RAM variables
        clr.w   $FFFFC8F8           ; fps_vint_tick = 0
        clr.w   $FFFFC8FA           ; fps_value = 0
        clr.l   $FFFFC8FC           ; fps_last_c964 = 0 (unused)
        clr.l   $FFFFC900           ; fps_flip_counter = 0
        clr.l   $FFFFC904           ; fps_flip_last = 0
```

---

## Key Contradictions / Mysteries

### Mystery 1: Why Does Constant Write Work But Counter Doesn't?
```asm
; This worked (showed "11"):
move.w  #$11,$FFFFC8FA.w

; This doesn't work (shows "00"):
move.l  $FFFFC900.w,d0
sub.l   $FFFFC904.w,d0
move.w  d0,$FFFFC8FA.w
```

Both write to the same address. Why does one display and the other doesn't?

### Mystery 2: Wrapper Must Be Executing
The sentinel test proved the wrapper runs. So the counter increment at line 64 MUST execute 60 times per second. Why doesn't it accumulate?

### Mystery 3: Binary Looks Correct
All opcodes verified, all addresses verified. Code should work. What are we missing?

---

## Hypotheses (Unverified)

### Hypothesis 1: RAM Corruption
Something else in the game clears $FFFFC900-$C907 after we increment.
- **Test**: Add COMM register mirror (`move.l $FFFFC900.w,$00A15128` after increment)
- **Check**: If COMM4 increments, counter works but RAM gets cleared

### Hypothesis 2: Timing Issue
Render samples fps_value before sampling logic stores it.
- **Problem**: Render is called AFTER sampling in wrapper, so timing should be correct
- **Unless**: vint_epilogue render path runs first somehow?

### Hypothesis 3: Subtraction Always Returns 0
Both reads return the same value every time.
- **Test**: Display raw counter value instead of delta
- **Code**: `move.l $FFFFC900.w,d0` / `move.w d0,$FFFFC8FA.w` (no subtraction)

### Hypothesis 4: Display Value Gets Overwritten
Something writes 0 to $FFFFC8FA between sampling and rendering.
- **Test**: Add write to different address, check if that displays correctly

### Hypothesis 5: Emulator Bug
PicoDrive caches V-INT handler address or has other quirks.
- **Test**: Try on real hardware or different emulator

### Hypothesis 6: We're Missing Something Obvious
There's a subtle bug in the logic we keep overlooking.
- **Need**: Fresh eyes on the control flow

---

## Diagnostic Tests (Not Yet Tried)

### Test 1: Simplest Possible Counter
```asm
fps_vint_wrapper:
        addq.w  #1,$FFFFC8FA.w          ; Just increment display value
        jmp     ORIG_VINT
```
**Expected**: Counter increases from 00→01→02... every frame (60 Hz).
**If this doesn't work**: Problem is with the wrapper itself or the display value address.

### Test 2: Display Raw Tick Counter
```asm
fps_vint_wrapper:
        addq.w  #1,$FFFFC8F8.w          ; Tick counter
        move.w  $FFFFC8F8.w,$FFFFC8FA.w ; Copy to display
        cmpi.w  #60,$FFFFC8F8.w
        blt.s   .skip
        clr.w   $FFFFC8F8.w             ; Reset at 60
.skip:
        jmp     ORIG_VINT
```
**Expected**: Counter cycles 00→59→00→59 every second.
**If shows 00**: Tick increment isn't working (address wrong or RAM clearing).

### Test 3: COMM Register Diagnostic
```asm
        addq.l  #1,$FFFFC900.w          ; Increment in RAM
        move.l  $FFFFC900.w,$00A15128   ; Mirror to COMM4
```
**Check in debugger**: If COMM4 increments, RAM writes work. If COMM4 stays 0, counter never increments.

### Test 4: Constant Write Every Frame
```asm
        move.w  #$42,$FFFFC8FA.w        ; Write 42 every V-INT
```
**Expected**: Display shows "42" constantly.
**If shows 00**: Something overwrites fps_value after wrapper but before render.

### Test 5: Remove Sampling Logic
```asm
fps_vint_wrapper:
        addq.w  #1,$FFFFC8F8.w
        cmpi.w  #60,$FFFFC8F8.w
        blt.s   .skip
        move.w  #$60,$FFFFC8FA.w        ; Just write 60 when tick reaches 60
        clr.w   $FFFFC8F8.w
.skip:
        jmp     ORIG_VINT
```
**Expected**: Shows "00" for 1 second, then "60" forever.
**If shows 00**: Sampling condition never triggers or display value gets overwritten.

---

## Questions for Codex

1. **Is there an obvious bug in the wrapper logic we're missing?**
   - Control flow issue?
   - Register usage problem?
   - Addressing mode still wrong somehow?

2. **Why would constant writes work but counter-based sampling fail?**
   - Both write to same address ($FFFFC8FA)
   - Constant write test showed "11"
   - Counter sampling shows "00"

3. **Could there be RAM corruption at $FFFFC900-$C907?**
   - Is this range safe to use?
   - Could game code be clearing it?
   - Should we use a different location?

4. **Is the V-INT wrapper timing model correct?**
   - Wrapper increments, then jumps to original handler
   - Original handler may or may not process work
   - Render called from wrapper (no-work) OR epilogue (work)
   - Could there be a race condition?

5. **What diagnostic test would isolate the failure point fastest?**
   - Which of the 5 tests above should we try first?
   - Is there a better test we haven't thought of?

---

## Build Information

- **Emulator**: PicoDrive (system package)
- **Assembler**: vasm (built from source)
- **ROM**: Virtua Racing Deluxe (32X), 4MB
- **Build command**: `make all`
- **Test command**: `picodrive build/vr_rebuild.32x`

---

## Files to Review

| File | Purpose | Key Lines |
|------|---------|-----------|
| `disasm/modules/68k/optimization/fps_vint_wrapper.asm` | Counter increment + sampling | 57-92 |
| `disasm/modules/68k/optimization/fps_render.asm` | Display value read + render | 41-80 |
| `disasm/modules/68k/boot/ring_buffer_init.asm` | Variable initialization | 43-48 |
| `disasm/sections/header.asm` | V-INT vector redirect | 68-69 |

---

## Summary

We have a counter that should work based on:
- Verified binary code
- Proven wrapper execution
- Working display system

But it shows "00" consistently. We've tried multiple approaches and fixed an addressing bug, but the problem persists. We need fresh eyes to either:
1. Spot the bug we're missing
2. Suggest a diagnostic test that isolates the failure point
3. Explain why the logic is fundamentally wrong

No assumptions, no heroics - just help us see what we're not seeing.
