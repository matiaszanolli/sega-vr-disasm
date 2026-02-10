# FPS Counter Memory Corruption - Diagnostic Summary

**Date:** February 8, 2026
**Status:** BLOCKED - fps_value displays "99" instead of "42"
**Severity:** Critical - Memory corruption preventing FPS counter functionality

---

## Problem Statement

The FPS counter wrapper **executes correctly** (proven by visible white pixel diagnostics), but `fps_value` at `$FFFFF802` reads as **>99** instead of the literal **42** written by the wrapper.

**Observable symptom:** Display shows "99" (clamped value) instead of "42"
**Proven fact:** Wrapper runs every V-INT (white lines visible during logos)
**Implication:** Memory is being corrupted between write and read

---

## Current Memory Layout

```asm
FPS_BASE         equ     $FFFFF800      ; Base address (3rd relocation)
fps_vint_tick    equ     FPS_BASE+0     ; $FFFFF800: V-INT tick counter (word)
fps_value        equ     FPS_BASE+2     ; $FFFFF802: Current FPS display value (word)
fps_flip_counter equ     FPS_BASE+4     ; $FFFFF804: Total buffer flip count (long)
fps_flip_last    equ     FPS_BASE+8     ; $FFFFF808: Last sampled flip count (long)
fps_fs_last      equ     FPS_BASE+12    ; $FFFFF80C: Last FS bit state (word)
```

**Total:** 14 bytes ($FFFFF800-$FFFFF80D)
**Distance from stack:** 1KB (stack starts at $FFFFFC00, grows down)

---

## Memory Relocation History

### Relocation 1: $FFFFE600 (FAILED - Game Collision)
**Symptom:** Counter stuck at "00"
**Root cause:** Original V-INT handler overwrites this range
**Evidence:** White pixel test showed wrapper executes, but fps_value reads as 0

### Relocation 2: $FFFFFA00 (FAILED - Stack Collision)
**Symptom:** Counter shows "99" instead of expected value
**Root cause:** Only 510 bytes from stack base ($FFFFFC00)
**Stack pressure:** V-INT handlers save registers, may exceed margin

### Relocation 3: $FFFFF800 (CURRENT - Still Corrupted)
**Symptom:** Counter still shows "99"
**Expected:** Should show "42" (literal test value)
**Distance from stack:** 1KB safety margin
**Status:** UNRESOLVED corruption

---

## Code Execution Flow

### 1. V-INT Vector Redirect (header.asm:68-69)
```asm
dc.w    $0089        ; $000078
dc.w    $C208        ; $00007A  → $0089C208 (fps_vint_wrapper)
```

### 2. Wrapper Writes fps_value (fps_vint_wrapper.asm:67-104)
```asm
fps_vint_wrapper:
        movem.l d0-d1,-(sp)                     ; Save registers

        ; Diagnostic: Direct frame buffer write (PROVES EXECUTION)
        bclr    #7,$00A15100                    ; FM=0 (68K gets FB access)
        move.l  #$FFFFFFFF,$840006              ; FB0 white pixels (VISIBLE)
        move.l  #$FFFFFFFF,$84000A              ; FB0 white pixels (VISIBLE)
        move.l  #$FFFFFFFF,$860006              ; FB1 white pixels
        move.l  #$FFFFFFFF,$86000A              ; FB1 white pixels
        bset    #7,$00A15100                    ; FM=1 (SH2 access)

        move.w  #42,fps_value                   ; WRITE: Set test value to 42

        movem.l (sp)+,d0-d1                     ; Restore registers

        ; Work gate + jump to original handler...
        jmp     ORIG_VINT
```

**Evidence wrapper executes:**
User confirmed: "Yes. I see two white lines at the right during the logos"

### 3. Renderer Reads fps_value (fps_render.asm:44-83)
```asm
fps_render:
        movem.l d0-d5/a0-a2,-(sp)

        ; ... FM bit protocol ...

        moveq   #0,d0
        move.w  fps_value,d0                    ; READ: Should be 42
        cmpi.w  #99,d0                          ; Clamp check
        bls.s   .clamp_ok
        moveq   #99,d0                          ; CLAMPED: Value was >99
.clamp_ok:
        ; ... render d0 as digits ...
```

**Current behavior:** Clamp triggers, indicating `fps_value` > 99

---

## Diagnostic Evidence

### Test 1: Literal "42" Display
**Code:** `move.w #42,fps_value`
**Expected:** Display shows "42"
**Result:** Display shows "99"
**Conclusion:** fps_value reads as >99, clamp activates

### Test 2: White Pixel Diagnostic
**Code:** Direct frame buffer writes with FM protocol
**Expected:** White lines visible if wrapper executes
**Result:** User confirmed white lines visible during logos
**Conclusion:** Wrapper executes every V-INT as designed

### Test 3: Memory Relocation (3 attempts)
| Location | Distance from Stack | Result |
|----------|---------------------|--------|
| $FFFFE600 | N/A (game code range) | "00" (game overwrites) |
| $FFFFFA00 | 510 bytes | "99" (corrupted) |
| $FFFFF800 | 1KB | "99" (still corrupted) |

**Pattern:** All relocated positions show corruption, suggesting either:
1. Stack grows beyond 1KB during V-INT
2. Unidentified memory user (DMA? VDP? SH2?)
3. Code addressing error (wrong base calculation)

---

## Hypotheses (Ordered by Likelihood)

### Hypothesis A: Stack Exceeds 1KB Safety Margin (HIGH)
**Theory:** V-INT handler + nested calls + register saves exceed 1KB stack depth

**Evidence For:**
- Corruption persists at $FFFFF800 (1KB from stack)
- 68K stack grows downward from $FFFFFC00
- V-INT saves many registers (see wrapper + original handler)

**Test:** Move FPS_BASE to $FFFFF000 (3KB margin) or lower

### Hypothesis B: Uninitialized Memory Read (MEDIUM)
**Theory:** fps_value never actually written due to addressing error

**Evidence For:**
- Consistent ">99" behavior (uninitialized RAM garbage)
- Same symptom across different addresses

**Evidence Against:**
- White pixels prove wrapper executes
- Same wrapper writes both frame buffer AND fps_value

**Test:** Add COMM register write immediately after fps_value write, verify COMM shows 42

### Hypothesis C: Symbol Resolution Error (MEDIUM)
**Theory:** `fps_value` in wrapper points to different address than in renderer

**Evidence For:**
- Both files define fps_value via equates
- Possible assembler address calculation mismatch

**Test:** Replace `move.w #42,fps_value` with `move.w #42,$FFFFF802.w` (absolute)

### Hypothesis D: Write Timing Issue (LOW)
**Theory:** fps_value written but immediately overwritten by original handler

**Evidence For:**
- Wrapper writes before jumping to original V-INT handler
- Original handler may use this range

**Evidence Against:**
- Already relocated 3 times, unlikely all addresses collide

**Test:** Write fps_value AFTER original handler returns (in epilogue)

---

## Recommended Diagnostic Steps

### Priority 1: Verify Write Actually Happens
**Action:** Add COMM register diagnostic immediately after fps_value write

```asm
move.w  #42,fps_value
move.w  #42,$00A1512A        ; COMM5 = 42 (verify write executed)
```

**Expected:** If COMM5 shows 42 in emulator, write instruction executes
**If COMM5 = 42 but fps_value ≠ 42:** Addressing error or memory corruption
**If COMM5 ≠ 42:** Code path doesn't execute (contradicts white pixel test)

### Priority 2: Use Absolute Addressing
**Action:** Replace symbol with absolute address

```asm
; Before:
move.w  #42,fps_value

; After:
move.w  #42,$FFFFF802.w      ; Absolute address, bypass symbol resolution
```

**Purpose:** Eliminate symbol resolution as potential issue

### Priority 3: Increase Stack Safety Margin
**Action:** Relocate FPS_BASE to $FFFFF000 (3KB from stack)

```asm
FPS_BASE         equ     $FFFFF000      ; 3KB below stack
```

**Purpose:** Rule out stack collision definitively

### Priority 4: Write in Epilogue Instead of Wrapper
**Action:** Move fps_value write to vint_epilogue (after original handler)

**Purpose:** Test if original handler overwrites the address

---

## Files Involved

| File | Lines | Role |
|------|-------|------|
| [fps_vint_wrapper.asm](disasm/modules/68k/optimization/fps_vint_wrapper.asm) | 53-105 | Writes fps_value = 42 |
| [fps_render.asm](disasm/modules/68k/optimization/fps_render.asm) | 44-83 | Reads fps_value, clamps to 99 |
| [ring_buffer_init.asm](disasm/modules/68k/boot/ring_buffer_init.asm) | 43-50 | Initializes fps_value = 0 at boot |
| [header.asm](disasm/sections/header.asm) | 68-69 | V-INT vector redirect |

---

## Critical Questions for Review

1. **Is $FFFFF800 actually safe?**
   What is the maximum stack depth during V-INT execution?

2. **Are the symbol equates resolving correctly?**
   Should verify with absolute addressing test

3. **Could another CPU be writing this range?**
   SH2s or DMA accessing 68K RAM?

4. **Is there a gap between write and read?**
   When does fps_render execute relative to wrapper?

5. **Is the memory even getting initialized?**
   Does ring_buffer_init run before first V-INT?

---

## Success Criteria

The FPS counter is **working correctly** when:

1. ✅ Wrapper executes every V-INT (white pixels visible)
2. ❌ fps_value reads the value written by wrapper (currently fails)
3. ❌ Display shows expected value, not clamped "99" (currently fails)

**Current Status:** 1/3 criteria met

---

## Request for Review

**Primary Question:** Why does fps_value at $FFFFF800 read as >99 when wrapper writes 42?

**Specific Investigation Needed:**
1. Verify symbol `fps_value` resolves to $FFFFF802 in both files
2. Check if $FFFFF800-$FFFFF80D is used by original game code
3. Determine maximum stack depth during V-INT
4. Verify execution order: wrapper → original handler → epilogue → renderer

**Recommended First Test:** Priority 1 (COMM5 diagnostic) to confirm write executes

---

**Last Updated:** February 8, 2026 (Post-relocation #3)
**For Review By:** Codex (fresh session)
**Reported By:** Primary development session
