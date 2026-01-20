# Simple COMM Register Test Plan

## Problem Identified

Cannot fit COMM4 work detection logic in the 18-byte space at $02050C. All attempts require minimum 22-26 bytes with proper delay slots and loop structure.

## Simplified Solution

**Test the communication channel WITHOUT modifying Slave code.**

### Current State (Already Working!)
- Slave SH2 at $02050C increments COMM2 continuously
- ~37-39 increments per 60 frames @ 60 FPS
- ~3.8 million increments/second
- **This proves Slave is alive and can write to COMM registers**

### Phase 1: Master Reads COMM2 (Communication Validation)

**Goal**: Prove Master SH2 can read Slave's COMM2 value

**Implementation**: Add simple code to Master that:
1. Reads COMM2 periodically
2. Stores value to a different COMM register (e.g., COMM4)
3. 68K can verify Master is reading Slave's counter

**Code** (Master SH2):
```asm
; Master monitoring loop (add to existing Master code)
monitor_slave:
    mov.l   comm2_addr,r0       ; R0 = 0x20004024 (COMM2)
    mov.l   comm4_addr,r1       ; R1 = 0x20004028 (COMM4)

check_loop:
    mov.l   @r0,r2              ; Read COMM2 (Slave's counter)
    mov.l   r2,@r1              ; Write to COMM4 (echo to Master)
    ; ... continue Master's normal work ...
    bra     check_loop
    nop

.align 4
comm2_addr:
    .long   0x20004024
comm4_addr:
    .long   0x20004028
```

**Verification**:
- COMM2 increments (Slave active)
- COMM4 = COMM2 (Master reading Slave)
- **Proves bidirectional COMM register access**

### Phase 2: Master Signals Work via COMM6

**Goal**: Master signals "work available" to future Slave code

**Implementation**:
1. Master sets COMM6 = 1 when it starts frame rendering
2. Master clears COMM6 = 0 when frame complete
3. Current Slave ignores COMM6 (just keeps incrementing COMM2)
4. **Later**: Update Slave to check COMM6

**Code** (Master SH2):
```asm
frame_start:
    mov.l   comm6_addr,r0
    mov     #1,r1
    mov.l   r1,@r0              ; Signal: work available

    ; ... Master does rendering ...

frame_end:
    mov.l   comm6_addr,r0
    mov     #0,r1
    mov.l   r1,@r0              ; Signal: work complete

.align 4
comm6_addr:
    .long   0x2000402C          ; COMM6 register
```

**Verification**:
- COMM6 toggles 0→1→0 each frame
- COMM2 still increments (Slave unaffected)
- **Proves Master can signal without breaking Slave**

### Phase 3: Update Slave (When We Find Space)

**Goal**: Make Slave respond to Master's signals

**Approach**:
- **Option A**: Find larger injection point (30+ bytes)
- **Option B**: Use redirect to expansion ROM ($300000+)
- **Option C**: Modify Slave's initialization to hook into larger function

**Deferred** until Phases 1-2 proven working.

## Benefits of This Approach

### ✅ Testable Immediately
- No Slave modifications needed
- Uses existing proven Slave code
- Can verify Master→COMM and Slave→COMM independently

### ✅ Low Risk
- Slave keeps running unchanged
- Master additions don't break existing rendering
- Can test incrementally

### ✅ Proves Architecture
- COMM register communication works
- Both CPUs can read/write shared registers
- Foundation for future work distribution

## Implementation Steps

### Step 1: Find Master Rendering Loop
**Action**: Locate where Master SH2 processes frames
**Method**: Search for frame buffer writes, display list processing
**Output**: Address of Master's main loop

### Step 2: Add COMM2 Monitor
**Action**: Insert code to read COMM2 and echo to COMM4
**Method**: Add 10-12 bytes to Master's loop
**Verification**: COMM4 = COMM2 (proves Master reading)

### Step 3: Add COMM6 Signaling
**Action**: Set COMM6=1 at frame start, COMM6=0 at frame end
**Method**: Add ~8 bytes at two locations
**Verification**: COMM6 toggles each frame

### Step 4: Test in Emulator
**Action**: Build ROM and run in PicoDrive
**Method**: Monitor COMM2, COMM4, COMM6 with debug traces
**Success**: All registers show expected values

### Step 5: Document Results
**Action**: Record COMM register behavior
**Output**: Baseline for future Slave work distribution

## Why This Works

### Current Architecture
```
Slave SH2           COMM Registers          Master SH2
    |                                            |
    |--[COMM2++]---> COMM2 (counter)            |
    |                                            |
    |                COMM4 <-----[echo COMM2]---|
    |                                            |
    |                COMM6 <-----[signal work]--|
```

### Communication Proven
- Slave→Master: COMM2 increments visible to Master
- Master→Slave: COMM6 signals (Slave will use later)
- Master→68K: COMM4 echo (for debugging)

### No Space Constraints
- Master SH2 has plenty of ROM space
- Master code is in multiple 8KB sections
- Easy to find 20-30 bytes for monitoring code

## Timeline

- **Step 1**: 30 minutes (find Master loop)
- **Step 2**: 20 minutes (add COMM2 monitor)
- **Step 3**: 15 minutes (add COMM6 signals)
- **Step 4**: 30 minutes (test and verify)
- **Step 5**: 15 minutes (document)

**Total**: ~2 hours to prove bidirectional communication

## Success Criteria

✅ COMM2 increments continuously (Slave active)
✅ COMM4 = COMM2 (Master reading Slave)
✅ COMM6 toggles 0/1 each frame (Master signaling)
✅ No crashes or freezes
✅ Rendering continues normally

## Next Steps After Success

1. Find suitable Slave injection point (30+ bytes)
2. Implement Slave COMM6 detection
3. Add actual work payload (polygon rendering)
4. Measure performance improvement

---

**Current Status**: Ready to implement Step 1 (find Master loop)
**Blocker**: None - can proceed immediately
