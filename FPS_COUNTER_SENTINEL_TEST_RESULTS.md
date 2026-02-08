# FPS Counter - Sentinel Test Results & RAM Corruption Analysis

**Date**: February 8, 2026
**Status**: **CRITICAL - RAM corruption confirmed in multiple isolated ranges**
**Request**: Codex review - Need expert analysis of VRD V-INT handler RAM usage

---

## Executive Summary

Implemented same-frame RAM survival test to diagnose why FPS counter shows "99" instead of expected "42". Test **successfully isolated the root cause**: RAM written in the V-INT wrapper is corrupted during the V-INT handler execution, before epilogue can render it.

**Critical finding**: RAM corruption occurs in BOTH tested ranges:
- **$FFFFC**A20-$FFFFC**A2F** (98 displayed = corrupted)
- **$FFFFD**200-$FFFFD**20F** (98 displayed = corrupted)

This suggests either:
1. V-INT handler has undocumented bulk RAM clear that touches high RAM
2. Sentinel test logic has a flaw
3. Different corruption mechanism than direct writes

---

## Test Methodology

### Same-Frame Survival Test (Diagnostic Step 1)

**Purpose**: Prove whether RAM written in wrapper survives until epilogue render within same V-INT.

**Implementation**:
```asm
fps_vint_wrapper:
    ; Write test values
    move.w  #42,$FFFFD202.w         ; Display value
    move.w  #$4242,$FFFFD20E.w      ; Sentinel canary

    ; Jump to original V-INT handler (~50,000 cycles)
    jmp     ORIG_VINT

vint_epilogue:
    ; Check if sentinel survived
    cmpi.w  #$4242,$FFFFD20E.w
    beq.s   .ram_intact
    ; Corruption detected - overwrite display with 98
    move.w  #98,$FFFFD202.w
.ram_intact:
    bsr.w   fps_render              ; Render whatever's in $D202
```

**Expected Results**:
- **Display = 42**: Sentinel survived, RAM is safe
- **Display = 98**: Sentinel corrupted, RAM clobbered during V-INT handler

**Binary Verification** (both test runs):
```
Wrapper ($1C208):
  5278 D200       addq.w #1,$D200.w        ✓
  31FC 002A D202  move.w #42,$D202.w       ✓
  31FC 4242 D20E  move.w #$4242,$D20E.w    ✓

Epilogue ($1C228):
  0C78 4242 D20E  cmpi.w #$4242,$D20E.w    ✓
  6706            beq.s +6                  ✓
  31FC 0062 D202  move.w #98,$D202.w       ✓
```

All opcodes correct. Test logic is sound.

---

## Test Results

### Test 1: $FFFFC**A20 Range (Initial Location)

**RAM Layout**:
```
$FFFFCA20: fps_vint_tick   (word)
$FFFFCA22: fps_value       (word) - test writes 42 here
$FFFFCA2E: fps_sentinel    (word) - test writes $4242 here
```

**Result**: **Display = 98** (sentinel corrupted)

**Known Collision**: $CA20 range was suspected to collide with game state:
- Expert diagnosis: "$C900-$C9FF marked as active frame/timing state"
- However, $CA20-$CA2F is 32 bytes ABOVE $C9FF
- Investigation found 112-byte gap between async queue end ($C8F4) and next variable ($C964)

**Conclusion**: Corruption confirmed, but collision mechanism unclear.

---

### Test 2: $FFFFD**200 Range (Relocated +2016 bytes)

**RAM Layout**:
```
$FFFFD200: fps_vint_tick   (word)
$FFFFD202: fps_value       (word) - test writes 42 here
$FFFFD20E: fps_sentinel    (word) - test writes $4242 here
```

**Result**: **Display = 98** (sentinel STILL corrupted!)

**Distance from documented state**:
- **+2016 bytes** above $CA20
- **+2848 bytes** above $C900 (active frame/timing state)
- $D200 range is in upper Work RAM, far from all known game variables

**Conclusion**: Either V-INT handler clears large RAM ranges, or test has logic flaw.

---

## Investigation Findings (3 Parallel Agent Search)

### 1. Documented Game State Analysis
**Searched**: DATA_STRUCTURES.md, STATE_MACHINES.md, 68K_FUNCTION_REFERENCE.md

**Findings**:
- Async queue telemetry: $FFC8D8-$FFC8E8 (ends at $C8E8, not $C8F4)
- Active frame/timing state: $FFC900-$FFC9FF (documented range)
- Next variable after queue: $FFFFC964 (frame counter)
- **Gap**: $C8F4 to $C964 = 112 bytes unused

**Documented ranges DO NOT include**:
- $CA20-$CA2F (32 bytes above $C9FF)
- $D200-$D20F (2848 bytes above $C900)

**Conclusion**: No documented collision explains $D200 corruption.

---

### 2. Code Search for $CA20 and $D200 Range Access

**Searched**: Entire disasm/ directory for dc.w matches

**$CA2X range** (121 matches):
- All verified as instruction operands (addresses, immediates)
- No direct RAM writes found: `move.w xxx,$FFFFCA2X`

**$D2XX range** (similar results):
- Matches are instruction data, not RAM access patterns

**Conclusion**: No smoking gun direct writes found via grep.

---

### 3. Bulk RAM Clear Analysis

**Found**: adapter_init.asm lines 171-177

```asm
lea     $00FFC800,a1                    ; Work RAM start
moveq   #0,d0                           ; Zero value
move.w  #$1F3F,d7                       ; 8000 longwords = 32,000 bytes
.clear_ram:
    move.l  d0,(a1)+                    ; Clear 4 bytes
    dbra    d7,.clear_ram
```

**Range cleared**: $FFC800 + 32,000 bytes = $FFC800 to ~$FFE4FF

**Includes**:
- ✓ $FFFFC**A20** range (within clear zone)
- ✓ $FFFFD**200** range (within clear zone)

**BUT**: This runs during BOOT ONLY (adapter_init), not during every V-INT.

**FPS initialization**: ring_buffer_init runs AFTER bulk clear, so variables are properly initialized at boot.

**Conclusion**: Bulk clear does NOT explain per-V-INT corruption.

---

## Critical Questions

### Q1: Is V-INT Handler Clearing RAM Every Frame?

**Evidence FOR**:
- Sentinel corrupted in both $CA20 and $D200 ranges
- $D200 is 2KB+ away from documented game state
- Suggests broad RAM clear pattern

**Evidence AGAINST**:
- No RAM clear loops found in V-INT handler code (fn_200_000 through fn_200_041)
- Clearing 2KB+ RAM every V-INT would consume massive cycles
- Game runs at 20 FPS (cycle-constrained) - unlikely to waste cycles

**Need**: Disassemble V-INT handler ($00881684) to check for:
- CLR.W/CLR.L in loops
- MOVEM.L with zero register to RAM
- JSR to bulk clear subroutines

---

### Q2: Could Sentinel Test Logic Be Flawed?

**Possible Issues**:

1. **Epilogue register corruption**: If sh2_wait_queue_empty corrupts registers and sentinel check uses wrong address?
   - Binary shows literal `$D20E` in cmpi.w, so address is hardcoded correctly
   - Unlikely

2. **Multiple V-INTs during test**: If V-INT fires again before epilogue completes?
   - V-INTs disabled during handler (SR = $2700)
   - Re-enabled at epilogue start (SR = $2300)
   - Should be safe

3. **Sentinel value coincidentally matches cleared value**: If RAM is cleared to $4242?
   - Bulk clear uses 0 (moveq #0,d0)
   - Would show 42, not 98
   - Unlikely

4. **Render reads wrong address**: If fps_render reads from old $CA22 instead of $D202?
   - Binary verified: `3038 D202` at $1C270 (correct)
   - Would show 00 or garbage, not 98
   - Unlikely

**Conclusion**: Test logic appears sound. Display = 98 means sentinel check FAILED.

---

### Q3: Why Does "99" Appear During Gameplay But "98" in Test?

**Previous Observation**: User reported "jumps straight to 99" when race starts.

**Current Test**: Shows stable "98" (sentinel corrupted).

**Possible Explanations**:

1. **Different code paths**: Gameplay uses work-path (vint_epilogue), test uses no-work path (wrapper render)?
   - Test actually uses BOTH paths (gates on $C87A)
   - 98 is written in epilogue, so epilogue definitely executes

2. **"99" was clamped value**: fps_render clamps to 99 if value > 99
   - Diagnostic A writes 42 (below clamp)
   - Corruption writes 98 (below clamp)
   - What value in RAM would clamp to 99?
   - If $FFFFD202 contained $0063 (99 decimal), would display 99
   - If $FFFFD202 contained $0064+ (100+), would clamp to 99

3. **Timing difference**: "99" during race vs "98" in attract mode
   - Different V-INT workloads?
   - Different RAM access patterns?

**Need**: Check what value is actually in $FFFFD202 when "99" or "98" displays (debugger read).

---

## Possible RAM Corruption Mechanisms

### Mechanism 1: Direct Write to Sentinel Address

V-INT handler contains:
```asm
move.w  #0,$FFFFD20E.w    ; Clear sentinel
```

**Likelihood**: Low
- Would need to clear $D20E specifically
- Code search found no such pattern
- Why would game use $D20E specifically?

---

### Mechanism 2: Bulk Clear with High Start Address

V-INT handler contains:
```asm
lea     $FFFFD000,a0      ; High RAM
move.w  #$100,d7          ; 256 words
.clear:
    clr.w   (a0)+
    dbra    d7,.clear
```

**Likelihood**: Medium
- Would explain both $CA20 and $D200 corruption
- But why clear high RAM every frame?
- Need to audit V-INT handler for CLR loops

---

### Mechanism 3: Stack Overflow

V-INT handler uses excessive stack, overwriting high RAM:
- Stack grows downward from $FFFFFE
- If stack overflows into $FFFFD200 range (3KB+ overflow)
- Sentinel at $D20E would be clobbered

**Likelihood**: Low
- 3KB stack overflow would crash immediately
- Game runs stably, only counter affected

---

### Mechanism 4: Pointer Arithmetic Bug in Test

Wrapper writes to $D202 and $D20E correctly, but epilogue checks wrong address:
```asm
; Intended:
cmpi.w  #$4242,$FFFFD20E.w

; Actual (if bug):
cmpi.w  #$4242,$FFFFCA2E.w   ; Old address from copy-paste?
```

**Likelihood**: Zero
- Binary verified: epilogue uses $D20E (see binary dump above)
- Opcodes correct

---

### Mechanism 5: Cache Coherency Issue (Emulator Bug?)

PicoDrive caches RAM writes incorrectly, causing:
- Wrapper write to $D20E not visible to epilogue read
- Or epilogue read returns stale value

**Likelihood**: Low but possible
- Would be emulator-specific bug
- Test on real hardware or different emulator
- Could explain why documented safe ranges fail

---

## Next Steps (Recommended Sequence)

### Step A: Verify Sentinel Test Integrity

**Goal**: Confirm test isn't misinterpreting results.

**Method**: Add COMM register mirror for visibility
```asm
fps_vint_wrapper:
    move.w  #42,$FFFFD202.w
    move.w  #$4242,$FFFFD20E.w
    move.w  $FFFFD20E.w,$00A15128   ; Mirror sentinel to COMM4

vint_epilogue:
    move.w  $FFFFD20E.w,$00A1512A   ; Mirror sentinel to COMM5
    cmpi.w  #$4242,$FFFFD20E.w
    beq.s   .ram_intact
    move.w  #98,$FFFFD202.w
.ram_intact:
```

**Check in debugger**:
- COMM4 = $4242? Wrapper write succeeded
- COMM5 = $4242? Epilogue read succeeded, but comparison failed (logic bug)
- COMM5 = $0000? RAM cleared between wrapper and epilogue (corruption confirmed)
- COMM5 = other? Unexpected corruption pattern

---

### Step B: Disassemble Original V-INT Handler

**Location**: $00881684 (code_200.asm)

**Search for**:
1. CLR instructions in loops
2. MOVEM.L to RAM ranges
3. JSR to subroutines (check callees for RAM clears)
4. LEA/MOVEA to high RAM addresses ($FFFDxxxx, $FFFCAxxx)

**Goal**: Find if/where V-INT handler modifies high Work RAM.

---

### Step C: Test Different RAM Ranges

Try sentinel test with:
- **$FFFFE000** (near stack, unlikely to be cleared)
- **$FFFF8000** (low Work RAM, before documented ranges)
- **SDRAM cache-through** $2203E100 (off-chip, isolated from 68K RAM)

If ALL fail → test logic bug or emulator issue.
If ONE succeeds → found safe range for FPS variables.

---

### Step D: Simplify Test (Remove Queue Drain)

Current epilogue:
```asm
vint_epilogue:
    bsr.w   sh2_wait_queue_empty    ; Could this corrupt RAM?
    cmpi.w  #$4242,$FFFFD20E.w
```

**Test**: Check sentinel BEFORE queue drain
```asm
vint_epilogue:
    cmpi.w  #$4242,$FFFFD20E.w      ; Check first
    beq.s   .intact
    move.w  #98,$FFFFD202.w
.intact:
    bsr.w   sh2_wait_queue_empty
```

If still shows 98 → queue drain not the cause.
If shows 42 → queue drain corrupts $D20E (unlikely but possible).

---

## Data Summary for Codex

### Test Parameters

| Parameter | Value |
|-----------|-------|
| Test method | Same-frame sentinel ($4242 canary) |
| Wrapper address | $0089C208 |
| Epilogue address | $0089C228 |
| V-INT handler | $00881684 (original) |
| Sentinel write location | Wrapper (before handler) |
| Sentinel check location | Epilogue (after handler + queue drain) |

---

### Test Results

| RAM Range | Display | Sentinel Status | Distance from $C900 |
|-----------|---------|----------------|---------------------|
| $FFFFC**A20**-$FFFFC**A2F** | **98** | Corrupted | +288 bytes |
| $FFFFD**200**-$FFFFD**20F** | **98** | Corrupted | +2848 bytes |

---

### Binary Verification (Test 2 - $D200 range)

```
$1C208: 5278 D200        addq.w #1,$D200.w         (tick counter)
$1C20C: 31FC 002A D202   move.w #42,$D202.w        (display value)
$1C212: 31FC 4242 D20E   move.w #$4242,$D20E.w     (sentinel write)

$1C228: 46FC 2300        move.w #$2300,sr          (enable ints)
$1C22C: 48E7 C0C0        movem.l d0-d1/a0-a1,-(sp) (save regs)
$1C230: 6100 026A        bsr.w sh2_wait_queue_empty
$1C234: 0C78 4242 D20E   cmpi.w #$4242,$D20E.w     (sentinel check)
$1C23A: 6706             beq.s +6                  (skip if intact)
$1C23C: 31FC 0062 D202   move.w #98,$D202.w        (corruption handler)
```

All opcodes correct. Test executes as designed.

---

### Boot-Time RAM Clear (NOT related to per-frame corruption)

```asm
; adapter_init.asm:171-177
lea     $00FFC800,a1
moveq   #0,d0
move.w  #$1F3F,d7                ; 8000 longwords
.clear_ram:
    move.l  d0,(a1)+
    dbra    d7,.clear_ram
```

**Range**: $FFC800 to ~$FFE4FF (32,000 bytes)
**Timing**: Boot only (before ring_buffer_init)
**Effect on FPS**: None (variables initialized after clear)

---

### Investigation Search Results

**Documented collisions**: None for $CA20 or $D200 ranges
**Code search for direct writes**: None found
**V-INT handler audit**: Not yet performed (Step B)

---

## Questions for Codex

1. **Is the sentinel test methodology sound?**
   - Write canary in wrapper, check in epilogue
   - Display 42 = survived, 98 = corrupted
   - Any logic flaws or edge cases we're missing?

2. **Why would $D200 range (2KB+ from game state) be corrupted?**
   - No documented variables there
   - No direct writes found via grep
   - Suggests bulk clear or unusual access pattern

3. **Could this be an emulator caching bug?**
   - PicoDrive-specific issue with RAM coherency?
   - Should we test on real hardware before further debugging?

4. **What RAM range is GUARANTEED safe from V-INT handler?**
   - SDRAM cache-through ($22xxxxxx)?
   - Near stack ($FFFFExxx)?
   - Low Work RAM ($FFFF8xxx)?

5. **Is there a standard VRD pattern for per-frame persistent state?**
   - Where does VRD store variables that must survive across V-INTs?
   - Can we use the same range for FPS counter?

6. **Should we audit the V-INT handler disassembly manually?**
   - Location: $00881684 in code_200.asm
   - Goal: Find RAM clear loops or high-address writes
   - Effort: ~500 lines of 68K assembly to review

---

## Files Modified (Current State)

| File | Changes |
|------|---------|
| fps_vint_wrapper.asm | Sentinel write + check, relocated to $D200 |
| fps_render.asm | Read from $D202 (relocated) |
| ring_buffer_init.asm | Initialize $D200-$D20F (relocated) |

---

## Build Information

- **ROM**: build/vr_rebuild.32x (4.0M)
- **Build date**: February 8, 2026 18:23
- **Emulator**: PicoDrive (system package)
- **Test mode**: Attract mode + race start

---

## Conclusion

Sentinel test successfully isolated the problem: RAM corruption between wrapper write and epilogue read. However, corruption occurs in MULTIPLE isolated ranges (+2KB apart), suggesting either:

1. **Broad RAM clear** in V-INT handler (need disassembly audit)
2. **Emulator bug** (need hardware test)
3. **Test logic flaw** (need COMM mirror verification)

**Recommended next action**: Step A (COMM mirror test) to verify test integrity before further investigation.

No assumptions, no guesses - we need either debugger visibility (COMM registers) or hardware manual audit (V-INT handler disassembly) to proceed.
