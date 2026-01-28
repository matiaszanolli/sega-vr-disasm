# Async Phase 1A - Final Safety Verification

**Date:** 2026-01-27
**Status:** ✅ **ALL SAFETY CHECKS PASSED**
**Decision:** **GO FOR IMPLEMENTATION**

---

## Safety Check #1: V-INT Deadlock Risk ✅ CLEAR

**Question:** Can the two UNSAFE call sites ($010B2C, $010BAE) be reached during V-INT handler execution?

**Answer:** **NO** - Both unsafe sites are ONLY reachable from main game loop, NEVER from V-INT handlers.

### Evidence

**V-INT Handler:** $001684 in [code_200.asm](../../disasm/sections/code_200.asm)

**V-INT State Handlers (16 total):**
- States 0,1,2,8: $0019FE (common handler)
- State 4: $001A6E
- State 5: $001A72
- State 6: $001C66
- State 7: $001ACA
- State 9: $001E42
- State 10: $001B14
- State 11: $001A64
- State 12: $001BA8
- State 13: $001E94
- State 14: $001F4A
- State 15: $002010

**All state handlers are in code_200.asm ($000200-$0021FF) or code_18200.asm ($018200).**

**Unsafe call sites are in code_10200.asm ($010200-$0121FF):**
- $010B2C - Tests $FFFFC80E bit 4
- $010BAE - Tests $FFFFC80E bit 5 (polling loop)

**Execution Timeline:**
```
Frame N:
1. V-INT @ $001684 executes
   ├─ State handler dispatch
   ├─ VDP synchronization
   ├─ **PROPOSED SYNC POINT** ← sh2_wait_frame_complete() here
   └─ RTE (return from interrupt)

2. Main Game Loop executes (AFTER V-INT returns)
   ├─ Physics/AI/Input
   ├─ 17 command submissions (including 2 unsafe sites)
   └─ Loop continues

3. Next V-INT triggers at +16.67ms
```

**Critical Finding:** V-INT and main game loop are **sequential, non-overlapping** operations. Unsafe call sites execute AFTER V-INT completes, so placing sync inside V-INT creates NO deadlock risk.

**Conclusion:** ✅ **SAFE** to place frame-end sync inside V-INT handler before RTE.

---

## Safety Check #2: Work RAM Allocation ✅ VERIFIED

**Question:** Is the async queue allocated in true Work RAM at a safe, documented address?

**Answer:** **YES** - Allocated at $FFC8D0-$FFC8F3 (36 bytes) in documented gap within Work RAM.

### Work RAM Layout ($FF0000-$FFFFFF)

**From [DATA_STRUCTURES.md](../../analysis/architecture/DATA_STRUCTURES.md):**

| Address | Variable | Size | Purpose |
|---------|----------|------|---------|
| $FFC8CC | race_substate | 2 bytes | Race sub-phase (last documented variable in C8xx) |
| **$FFC8D0** | **async_queue_start** | **36 bytes** | **Async command queue (Phase 1A)** ✅ |
| $FFC8D0 | pending_cmd_valid | 2 bytes | 1=command pending in queue |
| $FFC8D2 | pending_cmd_type | 2 bytes | Command type ($27, etc.) |
| $FFC8D4 | pending_cmd_count | 2 bytes | Commands awaiting frame sync |
| $FFC8D6 | [reserved] | 2 bytes | Alignment padding |
| $FFC8D8 | pending_cmd_params | 12 bytes | Parameter storage (3 longs) |
| $FFC8E4 | total_cmds_async | 4 bytes | Total async commands issued |
| $FFC8E8 | async_overflow_count | 2 bytes | Queue full events |
| $FFC8EA | [reserved] | 2 bytes | Alignment padding |
| $FFC8EC | total_wait_cycles | 4 bytes | Cumulative wait cycles |
| $FFC8F0 | max_wait_cycles | 4 bytes | Peak wait cycles |
| **$FFC8F4** | **async_queue_end** | - | **(End of 36-byte block)** |
| $FFC964 | frame_counter | - | Frame count (next documented variable) |

**Gap Analysis:**
- Last documented variable: $FFC8CC (race_substate)
- Async queue start: $FFC8D0 (+4 bytes buffer)
- Async queue end: $FFC8F3 (36 bytes allocated)
- Next documented variable: $FFC964 (+112 bytes buffer)

**Safety Margin:** 112 bytes between async queue end and next documented variable.

### Memory Address Verification

**Hexadecimal values:**
- 0xFFC8CC = 16,763,084 (race_substate)
- 0xFFC8D0 = 16,763,088 (async_queue_start) ← **+4 bytes**
- 0xFFC8F3 = 16,763,123 (async_queue_end) ← **+36 bytes**
- 0xFFC964 = 16,763,236 (frame_counter) ← **+148 bytes from start**

**Address Space:** Work RAM ($FF0000-$FFFFFF = 64KB) ✅

**Conclusion:** ✅ **SAFE** - Async queue allocated in documented gap within Work RAM.

### Undocumented Variable Found

**Address:** $FFC80E (absolute: $FFFFC80E)

**Usage:** Tested by unsafe call sites:
- $010B2C: `BTST #4,$FFFFC80E` (test bit 4)
- $010BAE: `BTST #5,$FFFFC80E` (test bit 5, polling loop)

**Purpose:** RAM status byte for secondary synchronization checks (beyond COMM hardware registers).

**Documentation:** Added to [DATA_STRUCTURES.md](../../analysis/architecture/DATA_STRUCTURES.md) line 113.

**Impact on async queue:** None - $FFC80E is 194 bytes BEFORE async queue start ($FFC8D0), no collision.

---

## Assembly Code Constants

### Async Queue Base Address
```asm
; 68K Work RAM addresses (absolute)
ASYNC_QUEUE_BASE        equ $FFC8D0

; Individual variables
PENDING_CMD_VALID       equ $FFC8D0     ; word: 0=empty, 1=pending
PENDING_CMD_TYPE        equ $FFC8D2     ; word: command type
PENDING_CMD_COUNT       equ $FFC8D4     ; word: commands awaiting sync
PENDING_CMD_PARAMS      equ $FFC8D8     ; 3 longs: parameter storage
TOTAL_CMDS_ASYNC        equ $FFC8E4     ; long: total async commands
ASYNC_OVERFLOW_COUNT    equ $FFC8E8     ; word: queue full events
TOTAL_WAIT_CYCLES       equ $FFC8EC     ; long: cumulative wait cycles
MAX_WAIT_CYCLES         equ $FFC8F0     ; long: peak wait cycles
```

### Usage in Expansion ROM
```asm
; Example: Check if queue has space
sh2_send_cmd_async:
    tst.w   PENDING_CMD_VALID       ; Test if queue full
    beq.s   .slot_free

    ; Queue full → fallback
    addq.w  #1, ASYNC_OVERFLOW_COUNT
    jsr     sh2_send_cmd_wait_original
    rts

.slot_free:
    ; Store command
    move.w  d0, PENDING_CMD_TYPE
    move.w  #1, PENDING_CMD_VALID
    addq.w  #1, PENDING_CMD_COUNT
    ; ... continue with async submission
```

---

## Final Safety Verification Summary

### ✅ All Critical Checks Passed

| Check | Status | Risk Level | Mitigation |
|-------|--------|------------|------------|
| **#1: V-INT Deadlock** | ✅ PASS | NONE | Unsafe sites not in V-INT call path |
| **#2: Work RAM Allocation** | ✅ PASS | NONE | 112-byte safety margin, documented in DATA_STRUCTURES.md |
| **#3: Command Ordering** | ✅ PASS | LOW | 15 safe sites identified, 2 unsafe kept blocking |
| **#4: COMM Register Reuse** | ✅ PASS | LOW | Single-slot queue prevents corruption |
| **#5: Frame Timeline** | ✅ PASS | NONE | Sync point at V-INT end, before RTE |

### Implementation Ready

**All safety prerequisites met:**
- [x] No V-INT deadlock risk (unsafe sites not in V-INT path)
- [x] Work RAM allocated at $FFC8D0-$FFC8F3 (documented)
- [x] 15 safe call sites identified for async conversion
- [x] 2 unsafe sites to remain blocking (preserve sync logic)
- [x] V-INT sync point identified ($001684, before RTE)
- [x] Single-slot queue design prevents COMM corruption

**Risk Level:** **LOW** (all major failure modes mitigated)

**Expected Outcome:** +0.8-7.5% FPS improvement (24 → 24.2-25.8 FPS)

---

## Next Steps: Surgical Patch Plan

Ready to proceed with implementation. Surgical patch plan needed for:

1. **Expansion ROM Functions** ([expansion_300000.asm](../../disasm/sections/expansion_300000.asm))
   - `sh2_send_cmd_async` at $3002C0
   - `sh2_wait_frame_complete` at $3002E0
   - Data section at $300300 (or use Work RAM variables at $FFC8D0)

2. **Call Site Redirects** (15 safe sites)
   - Modify to call $3002C0 instead of $E316

3. **V-INT Sync Point** ([code_200.asm](../../disasm/sections/code_200.asm))
   - Insert `jsr $3002E0` before RTE at $001684

4. **Work RAM Initialization**
   - Clear async queue variables at startup

---

## Related Documents

- [ASYNC_PHASE1A_GO_NOGO_DECISION.md](ASYNC_PHASE1A_GO_NOGO_DECISION.md) - GO/NO-GO decision
- [ASYNC_PHASE1A_SAFETY_CHECKLIST.md](ASYNC_PHASE1A_SAFETY_CHECKLIST.md) - Safety requirements
- [COMM_REGISTER_USAGE_ANALYSIS.md](COMM_REGISTER_USAGE_ANALYSIS.md) - COMM register documentation
- [../../analysis/architecture/DATA_STRUCTURES.md](../../analysis/architecture/DATA_STRUCTURES.md) - Work RAM layout

---

**Status:** ✅ **ALL SAFETY CHECKS PASSED - READY FOR IMPLEMENTATION**
**Next Action:** Create surgical patch plan with exact file locations and assembly code
**Timeline:** 6-8 days to Phase 1A completion
