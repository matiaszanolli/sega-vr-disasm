# FPS Counter Debug Summary v2 - Stuck at 00 After V-INT Vector Confirmed

**Date**: February 8, 2026  
**Status**: V-INT wrapper executes (proven), but counter shows 00  
**Goal**: Understand why tick counter doesn't increment or display

---

## What We've Proven ✅

1. **V-INT vector redirect works**
   - ROM offset $000078 points to $0089C208 (wrapper entry) ✓
   - First test showed "11" for 1 second (wrapper sentinel) ✓
   - **Conclusion**: CPU enters wrapper on every V-INT

2. **fps_render executes**
   - Counter displays in top-left corner (rows 3-9, cols 2-15) ✓
   - 2-digit font renders correctly ✓
   - **Conclusion**: vint_epilogue → fps_render path works

3. **Wrapper is in the V-INT call chain**
   - V-INT vector → wrapper ($89C208) → original handler ($881684) → vint_epilogue ($89C23A) → fps_render
   - All binary addresses verified ✓

---

## Current Mystery ❌

**Counter stuck at "00"** with diagnostic code that should count 0→60 every second.

### Test Evolution

| Build | Code | Expected | Observed |
|-------|------|----------|----------|
| **v1 (sentinel)** | `move.w #$11,fps_value` | Shows 11 constantly | Shows 11 for 1 sec, then 0 |
| **v2 (tick counter)** | `move.w fps_vint_tick.w,fps_value.w` | Counts 00→01→...→60 | Stuck at 00 |

---

## Binary Verification (Build Feb 8 16:46)

### V-INT Vector (ROM offset $78)
```
00000078: 0089 c208
```
✅ Points to $0089C208 (fps_vint_wrapper)

### fps_vint_wrapper (File offset $1C208)
```
$01C208: 5278 C8F8                addq.w  #1,$C8F8.w       ; Increment tick
$01C20C: 31F8 C8F8 C8FA          move.w  $C8F8.w,$C8FA.w  ; Copy tick → fps_value
$01C212: 0C78 003C C8F8           cmpi.w  #60,$C8F8.w      ; Check if 60
$01C218: 6D1A                     blt.s   .skip_sample     ; Branch if < 60
```
✅ Diagnostic code assembled correctly

### RAM Variables (Initialized by ring_buffer_init)
```
$FFFFC8F8: fps_vint_tick  (word) - V-INT tick counter (0-59)
$FFFFC8FA: fps_value      (word) - Display value (what fps_render reads)
$FFFFC8FC: fps_last_c964  (long) - Frame counter snapshot
```

**Initialization** (ring_buffer_init at boot, called from adapter_init line 102):
```asm
clr.w   $FFFFC8F8           ; fps_vint_tick = 0
clr.w   $FFFFC8FA           ; fps_value = 0
clr.l   $FFFFC8FC           ; fps_last_c964 = 0
```

---

## Code Flow Analysis

### Every V-INT (60 times/second on NTSC)

```
1. V-INT fires → CPU jumps to vector at $000078
2. Vector = $0089C208 → fps_vint_wrapper entry
3. fps_vint_wrapper:
   - addq.w #1,fps_vint_tick.w          ; Increment: 0→1→2→...→60
   - move.w fps_vint_tick.w,fps_value.w ; COPY to display (should show live count)
   - cmpi.w #60,fps_vint_tick.w         ; Check if 1 second elapsed
   - blt.s .skip_sample                 ; Most V-INTs skip to here
   - jmp $00881684                      ; Jump to original handler

4. Original V-INT handler ($881684):
   - Check $C87A (work pending flag)
   - If non-zero: process state machine, increment $C964
   - jmp $0089C23A (vint_epilogue)

5. vint_epilogue ($89C23A):
   - bsr.w sh2_wait_queue_empty
   - bsr.w fps_render                   ; Reads fps_value, displays as 2 digits
   - rte
```

### Once Per Second (on 60th V-INT)

```
After line "cmpi.w #60,fps_vint_tick.w", branch NOT taken:
   - move.l $FFFFC964.w,d0              ; Read frame counter
   - sub.l fps_last_c964.w,d0           ; FPS = current - last
   - move.w d0,fps_value.w              ; Overwrite tick with FPS result
   - move.l $FFFFC964.w,fps_last_c964.w ; Update snapshot
   - clr.w fps_vint_tick.w              ; Reset tick to 0
   - (continue to original handler)
```

**Expected behavior**: Counter should count 0→60 continuously, briefly showing FPS result at 60.

---

## Hypotheses for "Stuck at 00"

### Hypothesis 1: fps_vint_tick Never Increments
**Symptoms match**: Display shows constant 00  
**Possible causes**:
- Wrapper doesn't execute (contradicted by earlier "11" sentinel test ✓)
- `addq.w #1,$C8F8.w` doesn't write (hardware issue? address wrong?)
- $C8F8 is being cleared by other code every frame

**Test**: Search ROM for other writes to $C8F8

### Hypothesis 2: fps_value Gets Overwritten After Copy
**Symptoms match**: Display shows constant 00  
**Possible causes**:
- Something clears $C8FA between wrapper and fps_render
- Game uses $C8FA for other purposes
- Stack overflow still corrupting variables (unlikely at $C8F8, 14KB from stack)

**Test**: Search ROM for writes to $C8FA

### Hypothesis 3: fps_render Reads Wrong Address
**Symptoms match**: Display shows constant 00  
**Evidence against**: fps_render correctly displayed "11" sentinel in v1 build

### Hypothesis 4: Emulator Caches Old Handler Address
**Symptoms**: Wrapper appears to execute (from v1 test) but new diagnostic doesn't work  
**Possible**: PicoDrive caches V-INT handler address after first boot?  
**Test**: Try on real hardware or different emulator

### Hypothesis 5: Build Didn't Actually Update
**Symptoms**: Behavior doesn't match new code  
**Evidence against**: Binary verification shows correct code at $1C208  
**Verification needed**: Confirm user is testing fresh ROM with timestamp Feb 8 16:46

---

## Outstanding Questions

1. **How did v1 show "11" but v2 shows "00"?**  
   - v1: `move.w #$11,fps_value` → proved wrapper executes  
   - v2: `move.w fps_vint_tick.w,fps_value.w` → stuck at 00  
   - Both should write to $C8FA every frame

2. **Is $C8F8 being cleared somewhere else?**  
   - Need to search ROM for all writes to $FFC8F8 or $C8F8

3. **Is the difference FPS calculation running every frame instead of every 60th?**  
   - Would cause fps_value to constantly get overwritten with 0 (if $C964 doesn't increment much)
   - But code has `blt.s .skip_sample` to prevent this

4. **Could interrupts be masked during wrapper execution?**  
   - Would prevent wrapper from running, but contradicts "11" sentinel test

---

## Files Modified (Current State)

1. **disasm/sections/header.asm:68-69** - V-INT vector → $0089C208
2. **disasm/modules/68k/optimization/fps_vint_wrapper.asm** - Live tick counter diagnostic
3. **disasm/modules/68k/optimization/fps_render.asm** - 2-digit display (unchanged)
4. **disasm/modules/68k/boot/ring_buffer_init.asm** - FPS variable initialization
5. **disasm/modules/68k/boot/adapter_init.asm:102** - BSR to ring_buffer_init

---

## Next Steps (Priority Order)

### 1. Verify User Is Testing Fresh Build
**Action**: Confirm ROM timestamp is Feb 8 16:46:47  
**Why**: Eliminate possibility of testing stale build

### 2. Search for Other Writes to $C8F8 or $C8FA
**Action**: 
```bash
xxd build/vr_rebuild.32x | grep -E "c8f8|c8fa" | head -20
```
**Why**: Check if game code clears these addresses

### 3. Add Hardware Side Effect in Wrapper
**Action**: Add `move.w #$CAFE,$00A15128` at wrapper start (write to COMM4)  
**Why**: Visible proof wrapper executes, independent of RAM variables

### 4. Test fps_vint_tick Increment Directly
**Action**: Display `fps_vint_tick` value directly via COMM register:
```asm
move.w  fps_vint_tick.w,$00A15128  ; COMM4 = tick (visible in debugger)
```

### 5. Check if Branch Always Taken
**Action**: Verify `blt.s .skip_sample` isn't always branching to FPS calculation  
**Why**: Would cause fps_value to get overwritten with 0 every frame

---

## Key Insight from Test v1

**The "11→0" transition in v1 proves:**
- Wrapper writes $11 successfully (for ~1 second) ✓
- After 1 second, something overwrites $11 with 0
- Most likely: FPS calculation runs and writes 0 (because $C964 - fps_last_c964 = 0)
- **This suggests wrapper works but $C964 doesn't increment**

**Why $C964 might not increment:**
- Frame counter at $C964 only increments when $C87A != 0 (work pending)
- During attract mode or idle states, $C87A = 0 → no increment
- During gameplay, should increment 20-30 times/sec

**Test needed**: Display $C964 value directly to see if it increments at all

---

## Critical Code Addresses (Quick Reference)

| Component | CPU Address | File Offset | Size |
|-----------|-------------|-------------|------|
| V-INT vector | N/A | $000078 | 4 bytes |
| fps_vint_wrapper | $0089C208 | $01C208 | 46 bytes |
| vint_epilogue | $0089C23A | $01C23A | ~30 bytes |
| Original V-INT handler | $00881684 | $001684 | ~44 bytes |
| fps_render | $0089C210 | $01C210 | ~200 bytes |
| ring_buffer_init | (in adapter_init) | ~$0009A8 | ~20 bytes |

---

## Questions for Second Opinion

1. **Why does v1 (constant $11) work but v2 (variable copy) fails?**  
   Both write to $C8FA every frame, but v1 displays correctly and v2 shows 00.

2. **Could there be a read/modify/write hazard?**  
   `addq.w #1,$C8F8.w` reads, increments, writes. Could something interfere?

3. **Is $C8F8-$C8FF safe from game code?**  
   Chosen as "14KB from stack" but is it used by game for other purposes?

4. **Could PicoDrive have a V-INT vector caching bug?**  
   First test showed wrapper works, but new test suggests it doesn't?

---

## Summary

**Working**: V-INT vector redirect, fps_render display, code flow chain  
**Not working**: Counter shows 00 instead of 0→60 live count  
**Most likely cause**: Either fps_vint_tick doesn't increment, OR fps_value gets cleared after copy  
**Critical question**: Why did constant $11 display correctly but variable copy shows 00?
