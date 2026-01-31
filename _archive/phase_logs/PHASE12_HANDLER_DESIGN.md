# Phase 12: Expansion ROM Handler Design & Implementation

**Status:** Planning
**Date:** 2026-01-22

---

## Objective

Implement the Slave expansion ROM handler that receives calls from the Phase 11 hook, enabling complete Master→Slave frame-perfect synchronization.

---

## Architecture Overview

### Signal Flow

```
Master Frame N:
  ├─ Set COMM6 = 0x0012 (call signal)
  └─ V-BLANK triggers Slave

Slave Polling Loop (0x06000596):
  ├─ Hook detects COMM6 = 0x0012
  ├─ Hook verifies signal matches
  ├─ Hook calls JSR @R0 where R0 = 0x02300027
  ├─ Expansion ROM Handler executes
  │  ├─ Increment COMM4 (response counter)
  │  └─ RTS (return to hook)
  ├─ Hook clears COMM6 = 0x0000
  └─ Hook returns to polling loop

Master Frame N+1:
  ├─ Reads COMM4 (sees increment)
  └─ Polls COMM6 for clear (sees 0x0000)
```

---

## Technical Details

### Address Mapping

**ROM Structure:**
```
File Offset     SH2 Address    Contents
────────────────────────────────────────
0x300000        0x02300000     Expansion ROM start
0x300000        0x06300000     (Slave SH2 view)
...
0x300027        0x02300027     Handler entry point
0x300027        0x06300027     (Slave SH2 view)
```

**Why 0x02300027?**
- The hook bytecode hardcodes: `mov.l #$02300027, R0`
- This is an SH2 address in ROM space
- Maps to file offset 0x300027 in the 4MB expansion ROM

### Current State

**Expansion ROM Section:** `disasm/sections/expansion_300000.asm`

Current content:
- 0x000000-0x000005: `expansion_test` (NOP + RTS)
- 0x000006-0x000017: `expansion_frame_counter` (increment COMM4)
- 0x000018-0x0FFFFF: Padding (0xFF)

**Issue:** Handler needs to be at 0x000027 (offset 39), but `expansion_frame_counter` only occupies 18 bytes (0-17).

---

## Handler Implementation

### Handler Code (44 bytes)

The handler at 0x300027 should:
1. Load COMM4 address
2. Read current counter value
3. Increment by 1
4. Write back to COMM4
5. Return to hook

**SH2 Assembly:**
```asm
handler_frame_sync:
    mov.l   #$20004028, R0    ; Load COMM4 address
    mov.l   @R0, R1           ; Read COMM4 value
    add     #1, R1            ; Increment
    mov.l   R1, @R0           ; Write back to COMM4
    rts                       ; Return to hook
    nop                       ; Delay slot
```

**Bytecode (12 bytes):**
```
D0 02 00 00 20 00 40 28  (mov.l #$20004028, R0)
60 04                    (mov.l @R0, R1)
71 01                    (add #1, R1)
20 12                    (mov.l R1, @R0)
00 0B                    (rts)
00 09                    (nop)
```

### Placement Strategy

**Option 1: Exact Offset (Recommended)**
- Place handler at exactly 0x300027 (39 bytes from start)
- Fill 0x300000-0x300026 with placeholder or test code
- Guarantees hook calls correct handler

**Option 2: Relocate Hook Call**
- Modify Phase 11 hook to call different address
- Risk: Requires re-testing hook injection
- Benefit: More flexibility in placement

**We'll use Option 1** (exact offset) to minimize changes to working Phase 11.

---

## Implementation Plan

### Step 1: Analyze Current Offsets

Count bytes in current expansion_300000.asm:
- org $300000
- expansion_test: 6 bytes (3 × dc.w)
- expansion_frame_counter: 18 bytes (multiple instructions + literal)
- Total used: 24 bytes
- Target offset: 39 bytes (0x27)
- Gap to fill: 15 bytes (0x18-0x26)

### Step 2: Reorganize Expansion Section

Restructure `disasm/sections/expansion_300000.asm`:

```asm
        org     $300000

; Space 0x00-0x26: Reserved for handler alignment
        dcb.b   $27, $FF        ; Fill with 0xFF padding

; Space 0x27+: Handler entry point
handler_frame_sync:
        dc.w    $D002           ; MOV.L @(disp,PC),R0 (load COMM4)
        dc.w    $6004           ; MOV.L @R0,R1 (read COMM4)
        dc.w    $7101           ; ADD #1,R1 (increment)
        dc.w    $2012           ; MOV.L R1,@R0 (write back)
        dc.w    $000B           ; RTS
        dc.w    $0009           ; NOP
        dc.l    $20004028       ; COMM4 address literal

; Remaining padding
        dcb.b   $100000-0x3D, $FF
```

**Calculation:**
- Handler code: 6 words = 12 bytes
- COMM4 literal: 4 bytes
- Total: 16 bytes
- Next free: 0x27 + 0x10 = 0x37

Actually, better to just put code at the right offset without worrying about earlier space.

### Step 3: Test Integration

After updating expansion section:
1. Rebuild ROM with new handler
2. Boot patched ROM (Phase 11 hooked version)
3. Verify:
   - Game boots without crash
   - COMM4 increments on each hook call
   - No jitter or corruption

### Step 4: Full Master→Slave Sync Validation

Test complete protocol:
1. Master sends signal (COMM6 = 0x0012)
2. Hook executes handler
3. Handler increments counter (COMM4++)
4. Master reads counter (should match frame count)
5. Repeat for 60+ frames

---

## Risk Assessment

### Potential Issues

**Risk: Handler at Wrong Address**
- **Mitigation:** Carefully verify offset calculation
- **Fallback:** Test with custom ROM patcher to inject handler

**Risk: Handler Corrupts Registers**
- **Mitigation:** Handler preserves all registers except R0, R1
- **Fallback:** Slave hook can save/restore registers if needed

**Risk: COMM4 Overflow**
- **Mitigation:** COMM4 is 16-bit counter, wraps after 65535 frames
- **Fallback:** Software handles wrap-around or resets counter

**Risk: Timing Issues**
- **Mitigation:** Handler is deterministic (3 memory ops + arithmetic)
- **Fallback:** Can add cycle-counting to measure overhead

---

## Files to Modify

### Primary
1. `disasm/sections/expansion_300000.asm`
   - Reorganize with handler at 0x000027
   - Remove old placeholder code
   - Add new handler implementation

### Secondary
1. `disasm/vrd.asm` (no changes needed, already includes expansion section)
2. `PHASE11_RESULTS.md` (update with Phase 12 implementation notes)

### Test/Validation
1. Create `PHASE12_HANDLER_TEST.md` (test procedure)
2. Update ROM build

---

## Success Criteria

Phase 12 is **COMPLETE** when:

- ✅ Handler code placed at 0x300027 (verified via offset)
- ✅ ROM builds successfully with new handler
- ✅ Game boots with hooked + handler ROM
- ✅ COMM4 increments on each hook call
- ✅ No register corruption or jitter
- ✅ 120+ frame test runs without crash
- ✅ Handler returns correctly to hook

---

## Timeline

| Step | Task | Effort |
|------|------|--------|
| 1 | Analyze & plan | 15 min |
| 2 | Implement handler | 15 min |
| 3 | Rebuild ROM | 5 min |
| 4 | Boot test | 10 min |
| 5 | Extended validation | 20 min |
| 6 | Document results | 15 min |
| **Total** | | **1.5 hours** |

---

## Notes

- Handler can be expanded later with more complex logic (rendering, synchronization, etc.)
- Current implementation is minimal (just counter increment)
- Provides foundation for Phase 12+ enhancements
- No changes to Phase 11 hook required

