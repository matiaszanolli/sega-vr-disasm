# Master SH2 Work Dispatch - Implementation Plan

## Current Status

✅ **Slave SH2**: Active and incrementing COMM2 continuously
⏳ **Master SH2**: No work dispatch code yet
❌ **Communication**: No handshake implemented

## Priority Shift: Master First!

**Realization**: We're trying to implement Slave work detection, but the Master isn't sending any work signals yet. We need to implement Master dispatch FIRST, then update Slave to respond.

## Phase 2 Revised: Master Dispatch Implementation

### Step 1: Find Master V-INT Handler

**Goal**: Locate where Master handles V-BLANK interrupts
**Method**: Search for COMM register writes in Master code

```bash
# Search for COMM writes in Master ROM region
tools/sh2_disasm.py build/vr_rebuild.32x 0x000000 65536 | grep -i "MOV.*COMM\|20004"
```

### Step 2: Add Minimal Work Signal

**Location**: Master V-INT handler or rendering loop
**Action**: Write non-zero value to COMM4

**Pseudocode**:
```c
// Master V-INT handler
void master_vint() {
    frame_counter++;

    // Simple test: Signal work every 60 frames
    if (frame_counter % 60 == 0) {
        COMM4 = 1;  // Signal work to Slave
    }

    // Continue normal rendering...
}
```

**Assembly** (Master SH2):
```asm
; At end of V-INT handler
mov.l   comm4_addr,r0       ; Load COMM4 address
mov.w   #1,r1               ; Work signal value
mov.w   r1,@r0              ; Write to COMM4 (Slave will see this)
rts
nop

.align 4
comm4_addr:
    .long   0x20004028      ; COMM4 register
```

### Step 3: Observe Slave Response

With Master writing COMM4 = 1 every 60 frames:
- **Current Slave behavior**: Ignores COMM4, keeps incrementing COMM2
- **Expected**: COMM2 increments at steady rate (no change yet)
- **Verification**: Master can READ COMM2 to see Slave is alive

### Step 4: Update Slave to Check COMM4

**Only after Master dispatch works**, update Slave:

**Simple responsive test** (fits in 18 bytes):
```asm
; Instead of just incrementing, check COMM4 first
mov.l   comm4_addr,r0      ; Load COMM4
mov.l   comm2_addr,r1      ; Load COMM2
loop:
    mov.w   @r0,r2          ; Read COMM4
    tst     r2,r2           ; Check if non-zero
    bt      loop            ; If zero, keep waiting
    nop
    ; Work detected!
    mov.w   @r1,r3          ; Read COMM2
    add     #1,r3           ; Increment
    mov.w   r3,@r1          ; Write COMM2
    bra     loop
    nop
```

*This is still too big, but we'll solve that with redirect approach when we get there*

### Step 5: Implement Full Handshake

```
Master                          Slave
  │                               │
  │  1. Write COMM4 = 1          │
  │  ────────────────────────►   │
  │                              │ 2. Detect COMM4 != 0
  │                              │ 3. Increment COMM2
  │  4. Poll COMM2               │ 4. Write COMM2
  │  ◄────────────────────────   │
  │  5. See COMM2 changed        │
  │  6. Clear COMM4 = 0          │
  │  ────────────────────────►   │
  │                              │ 7. See COMM4 = 0
  │                              │ 8. Back to polling
  └                              └
```

## Master Code Locations to Find

### Priority Search Targets

1. **V-INT Handler**
   - Where Master responds to V-BLANK
   - Likely location for frame-based work dispatch

2. **Rendering Loop**
   - Main game loop
   - Where frame rendering happens

3. **COMM Register Usage**
   - Find existing COMM reads/writes
   - Understand current Master-Slave communication

### Search Strategy

```bash
# 1. Find V-INT vector (offset 0x600 in ROM)
hexdump -C build/vr_rebuild.32x -s 0x600 -n 4

# 2. Disassemble Master ROM (0x000000-0x01FFFF)
tools/sh2_disasm.py build/vr_rebuild.32x 0x000000 131072 > master_disasm.txt

# 3. Search for COMM register addresses
grep "20004024\|20004028" master_disasm.txt

# 4. Find potential V-INT handler
# Look for patterns like: save registers, do work, restore, RTE
```

## Implementation Checklist

- [ ] Find Master V-INT handler location
- [ ] Understand Master frame timing
- [ ] Find safe injection point for COMM4 write
- [ ] Implement minimal Master dispatch (write COMM4 = 1)
- [ ] Build and test in emulator
- [ ] Verify Slave sees COMM4 changes (via debug trace)
- [ ] Update Slave to respond to COMM4
- [ ] Implement full handshake protocol

## Why This Order?

**Master First** because:
1. Master is the controller - it initiates work
2. Can test Master dispatch independently (just write COMM4)
3. Can verify with current Slave test (monitor COMM2 continues)
4. Simpler to add Master code than retrofit Slave in 18 bytes
5. Can observe Master→Slave communication in emulator

**Slave Second** because:
1. Need Master signals to test against
2. Can use redirect approach for space
3. Can verify response to real Master signals
4. More confidence in working system

## Next Immediate Actions

1. **Search for Master V-INT handler** (30 minutes)
2. **Add COMM4 write** to Master (1 hour)
3. **Test in emulator** - verify COMM4 changes (15 minutes)
4. **Monitor COMM2** - verify Slave unaffected (15 minutes)
5. **Document findings** (30 minutes)

Total time: ~2.5 hours to working Master dispatch

---

**Current Position**: Need to pivot to Master implementation
**Next Milestone**: Master writes COMM4 periodically
**Success Metric**: Can observe COMM4 = 1 in emulator traces
