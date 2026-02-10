# FPS Counter Debug Summary - Stuck at 00

**Date**: February 8, 2026
**Status**: Counter displays "00" and never increments
**Goal**: Display real-time FPS counter on 32X frame buffer

---

## What Works ✅

1. **Digit rendering is functional**
   - 2-digit counter displays in top-left corner (rows 3-9, cols 2-15)
   - Black box with white digits visible in all game states
   - 4×5 pixel font renders correctly
   - Nibble-to-pixel LUT working (16 entries verified in binary)

2. **fps_render executes every frame**
   - Called from `vint_epilogue` at end of V-INT handler
   - FM bit save/restore works (no crashes)
   - Line table lookups work (word offset → byte offset conversion verified)
   - Both FB0 ($840000) and FB1 ($860000) written successfully

3. **ROM structure is correct**
   - V-INT vector points to `$0089C208` (verified at offset $78 in ROM)
   - `fps_vint_wrapper` assembled at file offset `$1C208` = CPU address `$89C208`
   - Wrapper jumps to original V-INT handler `$00881684` after processing
   - All 68K code byte-verified in binary

4. **RAM variables are safe**
   - Moved from `$FFFFFE00` (too close to stack) to `$FFFFC8F8`
   - Variables: `fps_vint_tick` ($C8F8), `fps_value` ($C8FA), `fps_last_c964` ($C8FC)
   - Initialized to zero by `ring_buffer_init` during boot
   - No conflicts with game RAM usage (verified via grep)

---

## What Doesn't Work ❌

**Counter shows "00" and never increments**, despite:
- V-INT wrapper contains diagnostic: `move.w fps_vint_tick.w,fps_value.w` (verified at $1C20C)
- This should copy the tick counter directly to display value
- Expected behavior: counter increments 00→01→02...→59→60→00 every second

---

## Code Flow Analysis

### Boot Sequence
```
1. ROM header at $0: SP=$01000000, PC=$000003F0
2. adapter_init executes ($000882-$0009A6)
3. ring_buffer_init called ($0009A2: bsr.w ring_buffer_init)
   - Clears fps_vint_tick, fps_value, fps_last_c964 to 0
4. Main loop polls V-INT flag at $C87A
```

### V-INT Flow (Every Frame)
```
1. V-INT fires → CPU jumps to vector at $000078
2. Vector = $0089C208 → fps_vint_wrapper entry
3. fps_vint_wrapper:
   - addq.w #1,fps_vint_tick.w          ; Increment tick
   - move.w fps_vint_tick.w,fps_value.w ; DIAGNOSTIC: copy to display
   - cmpi.w #60,fps_vint_tick.w         ; Check if 1 second elapsed
   - blt.s .skip_sample                 ; Skip FPS calculation if < 60
   - [FPS calculation: D0 = ($C964 - last_c964)]
   - move.w d0,fps_value.w              ; Store FPS result
   - clr.w fps_vint_tick.w              ; Reset tick counter
   .skip_sample:
   - jmp $00881684                      ; Jump to original V-INT handler

4. Original V-INT handler ($881684) executes:
   - Checks $C87A (work pending flag)
   - If 0, exits early
   - If non-zero, processes game state
   - Eventually jumps to vint_epilogue ($89C234)

5. vint_epilogue:
   - bsr.w sh2_wait_queue_empty         ; Drain async commands
   - bsr.w fps_render                   ; Render FPS counter to FB
   - rte                                ; Return from interrupt
```

### fps_render Execution
```
1. movem.l d0-d5/a0-a2,-(sp)
2. Save FM bit state
3. FM=0 (claim 68K FB access)
4. Set CRAM[254]=black, CRAM[255]=white
5. move.w fps_value.w,d0                ; Read fps_value from $C8FA
6. Clamp to 0-99
7. DIVU #10 → tens digit, ones digit
8. For each FB (FB0, FB1):
   - Render 7 rows (border + 5 digit rows + border)
   - Use nibble-to-pixel LUT for fast rendering
9. Restore FM bit
10. movem.l (sp)+,d0-d5/a0-a2
11. rts
```

---

## Binary Verification (Clean Build Feb 8 15:43)

### V-INT Vector (ROM offset $78)
```
00000078: 0089 c208
```
✅ Points to $0089C208 (fps_vint_wrapper)

### fps_vint_wrapper Disassembly (File offset $1C208)
```
$01C208: 5278 C8F8                addq.w  #1,$FFFFC8F8.w       ; Increment tick
$01C20C: 31F8 C8F8 C8FA          move.w  $C8F8.w,$C8FA.w      ; DIAGNOSTIC: copy tick → value
$01C212: 0C78 003C C8F8           cmpi.w  #60,$C8F8.w          ; Check if 60 ticks
$01C218: 6D1A                     blt.s   $01C234              ; Branch to .skip_sample
$01C21A: 2F00                     move.l  d0,-(sp)
$01C21C: 2038 C964                move.l  $FFFFC964.w,d0       ; Read frame counter
$01C220: 90B8 C8FC                sub.l   $C8FC.w,d0           ; Subtract last snapshot
$01C224: 31C0 C8FA                move.w  d0,$C8FA.w           ; Store FPS value
$01C228: 21F8 C964 C8FC           move.l  $C964.w,$C8FC.w      ; Update snapshot
$01C22E: 201F                     move.l  (sp)+,d0
$01C230: 4278 C8F8                clr.w   $C8F8.w              ; Reset tick counter
$01C234: 4EF9 0088 1684           jmp     $00881684            ; Jump to original V-INT
```
✅ All instructions verified correct

### vint_epilogue Disassembly (File offset $1C234)
```
$01C234: 46FC 2300                move.w  #$2300,sr            ; Re-enable interrupts
$01C238: 48E7 C0C0                movem.l d0-d1/a0-a1,-(sp)
$01C23C: 6100 01B6                bsr.w   sh2_wait_queue_empty ; → $01C3F4
$01C240: 6100 0008                bsr.w   fps_render           ; → $01C24A
$01C244: 4CDF 0303                movem.l (sp)+,d0-d1/a0-a1
$01C248: 4E73                     rte
```
✅ Calls fps_render correctly

### fps_render Entry (File offset $1C24A)
```
$01C24A: 48E7 FCE0                movem.l d0-d5/a0-a2,-(sp)
$01C24E: 3A39 00A1 5100           move.w  $A15100,d5           ; Save FM state
$01C254: 08B9 0007 00A1 5100      bclr    #7,$A15100           ; FM=0
...
$01C26E: 3038 C8FA                move.w  $FFFFC8FA.w,d0       ; Read fps_value
$01C272: 0C40 0063                cmpi.w  #99,d0               ; Clamp check
```
✅ Reads fps_value from correct address

### Nibble-to-Pixel LUT (File offset $1C378)
```
$01C378: FEFEFEFE FEFEFEFF FEFEFFFE FEFEFFFF  ; Entries 0-3
$01C388: FEFFFEFE FEFFFEFF FEFFFFFE FEFFFFFF  ; Entries 4-7
$01C398: FFFEFEFE FFFEFEFF FFFEFFFE FFFEFFFF  ; Entries 8-11
$01C3A8: FFFFFEFE FFFFFEFF FFFFFFFE FFFFFFFF  ; Entries 12-15
```
✅ All 16 LUT entries verified correct

---

## Hypotheses for "Stuck at 00"

### Hypothesis 1: V-INT Wrapper Never Executes
**Evidence FOR:**
- Counter stuck at 00 = fps_value never changes from initialized state
- Diagnostic `move.w fps_vint_tick.w,fps_value.w` should show tick incrementing

**Evidence AGAINST:**
- fps_render IS executing (we see the "00" counter)
- fps_render is called from vint_epilogue
- vint_epilogue is jumped to from original V-INT handler
- Original V-INT handler is jumped to from fps_vint_wrapper
- Therefore fps_vint_wrapper MUST execute for fps_render to execute

**Contradiction**: How can vint_epilogue execute if fps_vint_wrapper doesn't?

### Hypothesis 2: Original V-INT Handler Doesn't Jump to vint_epilogue
**What to check:**
- Does the original V-INT handler at `$00881684` actually jump to `$0089C234`?
- Maybe it RTEs directly instead?

**How to test:**
- Disassemble original V-INT handler to find jump to vint_epilogue
- Check if vint_epilogue address is hardcoded or patched

### Hypothesis 3: fps_vint_tick Gets Cleared Every Frame
**Possibility:**
- Some other code clears `$FFFFC8F8` every frame AFTER fps_vint_wrapper increments it
- Game might use this address for something else

**How to test:**
- Search ROM for writes to `$FFC8F8` or `$C8F8` outside our code
- Check if game has a "clear work RAM" routine that runs in V-INT

### Hypothesis 4: PicoDrive Doesn't Honor ROM V-INT Vector
**Possibility:**
- Emulator might use a cached/hardcoded V-INT handler address
- ROM header vector might be ignored after initial boot

**How to test:**
- Add a visible side effect to fps_vint_wrapper (write to COMM register or CRAM)
- Check if side effect appears in emulator

### Hypothesis 5: Stack Overflow Overwrites Variables (AGAIN)
**Possibility:**
- Despite moving to `$C8F8`, stack still corrupts variables
- V-INT handler call chain deeper than expected

**Evidence AGAINST:**
- Stack at `$01000000` wraps to `$FFFFFFFC`
- Variables at `$FFFFC8F8` are 14KB away from stack top
- Would need >14KB stack frame (impossible)

---

## Next Debugging Steps (Priority Order)

### 1. Verify Original V-INT Handler Jumps to vint_epilogue
**Action:** Disassemble `$00881684` and find where it jumps to vint_epilogue

### 2. Add Hardware Side Effect to fps_vint_wrapper
**Action:** Write `$DEAD` to COMM4 at start of fps_vint_wrapper
```asm
fps_vint_wrapper:
    move.w  #$DEAD,$00A15128        ; COMM4 = $DEAD (proves wrapper runs)
    addq.w  #1,fps_vint_tick.w
    move.w  fps_vint_tick.w,fps_value.w
    ...
```
**Test:** Check COMM4 in debugger or add visual indicator

### 3. Search ROM for Writes to $C8F8
**Action:** `grep -r "C8F8" disasm/` to find any other references

### 4. Test on Real Hardware
**Possibility:** PicoDrive emulation bug with V-INT vector redirect

---

## Files Modified (This Session)

1. `disasm/sections/header.asm` - V-INT vector redirected to `$0089C208`
2. `disasm/modules/68k/optimization/fps_vint_wrapper.asm` - Wrapper + diagnostic
3. `disasm/modules/68k/optimization/fps_render.asm` - Digit renderer
4. `disasm/modules/68k/boot/ring_buffer_init.asm` - FPS variable initialization
5. `disasm/sections/code_1c200.asm` - Module includes

---

## Question for Second Opinion

**Why does fps_render execute (proving vint_epilogue runs) but fps_vint_wrapper appears not to (tick counter stays at 0)?**

The control flow suggests:
```
V-INT → fps_vint_wrapper → original handler → vint_epilogue → fps_render
```

If fps_render executes, the entire chain must execute. But if fps_vint_wrapper executes, fps_value should show the incrementing tick counter (due to diagnostic line at $1C20C).

**Possible explanations:**
1. Original V-INT handler bypasses fps_vint_wrapper and jumps directly to vint_epilogue
2. Something clears fps_vint_tick after it's incremented
3. The diagnostic line doesn't execute (branch always taken?)
4. PicoDrive caches the original handler address and ignores the vector redirect

What are we missing?
