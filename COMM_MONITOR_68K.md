# 68K COMM Register Monitor - Simple Test Plan

## Ultra-Simple Approach

Instead of modifying complex Master SH2 code, add a tiny COMM monitor to the **68K V-INT handler** that already runs every frame.

## Implementation

### 68K V-INT Handler Addition

Add this code to the V-INT handler (runs every 16.7ms @ 60Hz):

```asm
; Location: Insert into V-INT handler at $001684
; Add after frame counter increment (line $0016A2)

comm_monitor:
    MOVE.L  A0,-(SP)            ; Save A0
    LEA     $A15120,A0          ; A0 = COMM register base

    ; Read COMM2 (Slave's counter)
    MOVE.W  4(A0),D0            ; D0 = COMM2 (offset +4)

    ; Echo to COMM4 for verification
    MOVE.W  D0,8(A0)            ; COMM4 = COMM2 (offset +8)

    ; Signal work available via COMM6
    MOVE.W  #$0001,12(A0)       ; COMM6 = 1 (offset +12)

    MOVE.L  (SP)+,A0            ; Restore A0
    ; ... continue V-INT handler ...
```

### Code Size

- MOVE.L A0,-(SP)  : 4 bytes
- LEA $A15120,A0   : 6 bytes
- MOVE.W 4(A0),D0  : 4 bytes
- MOVE.W D0,8(A0)  : 4 bytes
- MOVE.W #1,12(A0) : 6 bytes
- MOVE.L (SP)+,A0  : 4 bytes
- **Total**: 28 bytes

## Expected Behavior

### COMM Register States

| Register | Address | Value | Source | Purpose |
|----------|---------|-------|--------|---------|
| COMM0 | $A15120 | varies | 68K/SH2 | General status |
| COMM1 | $A15122 | varies | 68K/SH2 | General status |
| **COMM2** | **$A15124** | **0→37** | **Slave SH2** | **Counter (increments)** |
| COMM3 | $A15126 | varies | varies | Unused |
| **COMM4** | **$A15128** | **= COMM2** | **68K echo** | **Proof 68K reading** |
| COMM5 | $A1512A | varies | varies | Unused |
| **COMM6** | **$A1512C** | **1** | **68K signal** | **Work available flag** |
| COMM7 | $A1512E | varies | varies | Unused |

### Timeline (60 FPS)

```
Frame 0:
  Slave writes COMM2 = 0 → 1 → 2 → ... → 37
  68K V-INT reads COMM2 = 37
  68K writes COMM4 = 37
  68K writes COMM6 = 1

Frame 1:
  Slave continues COMM2 = 38 → 39 → ... → 74
  68K V-INT reads COMM2 = 74
  68K writes COMM4 = 74
  68K writes COMM6 = 1

...
```

## Verification

### Success Criteria

✅ **COMM2 increments continuously** (~37-39 per frame)
- Proves Slave SH2 is active and writing to COMM

✅ **COMM4 = COMM2** (approximately, may lag by 1 frame)
- Proves 68K can read Slave's COMM2
- Proves 68K can write to COMM4

✅ **COMM6 = 1** (constant)
- Proves 68K can set work signals
- Ready for future Slave COMM6 detection

### Debugging

If COMM4 ≠ COMM2:
- Check 68K code injection location
- Verify V-INT handler is running
- Check COMM register addresses

If COMM2 not incrementing:
- Slave code issue (but we already verified this works)
- ROM build problem

## Implementation Location

**File**: `disasm/sections/code_1600.asm` (68K V-INT handler)
**Offset**: After line with frame counter increment ($0016A2)
**Safe injection**: V-INT has plenty of time budget

## Next Steps After Success

1. ✅ Prove 68K↔Slave communication works
2. Add Master SH2 COMM monitor (optional)
3. Update Slave to check COMM6 (when we find space)
4. Implement actual parallel work distribution

## Why This Works

### No SH2 Master Complexity
- Don't need to find Master rendering loop
- Don't need to modify Master code
- 68K V-INT is easy to locate and modify

### Proves Same Concept
- Bidirectional COMM register access
- Signal/response protocol
- Foundation for Master-Slave work distribution

### Low Risk
- 28 bytes in V-INT handler (plenty of space)
- Slave code unchanged (already proven working)
- Easy to test and verify

---

**Status**: Ready to implement
**Time estimate**: 30 minutes
**Risk level**: Very low
