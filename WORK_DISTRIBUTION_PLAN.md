# Slave SH2 Work Distribution - Architecture & Plan

## Current Status: ✅ Slave CPU Active

**Achieved**: Slave SH2 successfully executing custom code, incrementing COMM2
**Verified**: ~3.8 million increments/second, stable execution, no crashes

## Next Phase: Work Distribution System

### Communication Protocol

**COMM Registers** (16-bit, SH2 addresses):
```
COMM0: 0x20004020  (unused - available)
COMM2: 0x20004024  (work counter - Slave → Master acknowledgment)
COMM4: 0x20004028  (work signal - Master → Slave command)
COMM6: 0x2000402C  (unused - available)
```

### Architecture

```
┌─────────────┐                    ┌─────────────┐
│ Master SH2  │                    │ Slave SH2   │
│             │                    │             │
│ Rendering   │                    │ Idle Loop   │
│ Main Loop   │                    │ (18 bytes)  │
│             │                    │             │
│   ┌─────────┴──────┐            │   ┌─────────┴──────┐
│   │ Frame Start    │            │   │ Check COMM4    │
│   │   Work         │            │   │  (work signal) │
│   │  Available?    │            │   └────────┬───────┘
│   └─────────┬──────┘            │            │
│             │                    │      No work? Loop
│       Yes   │                    │            │
│             ▼                    │      Work! │
│   ┌──────────────────┐          │            ▼
│   │ Write COMM4 = 1  │─────────────────►┌──────────────────┐
│   │ (signal work)    │          │       │ Inc COMM2        │
│   └──────────┬───────┘          │       │ (acknowledge)    │
│              │                   │       └──────────────────┘
│              ▼                   │                │
│   ┌──────────────────┐          │                ▼
│   │ Continue Master  │          │       ┌──────────────────┐
│   │ Rendering        │          │       │ Process Work     │
│   └──────────────────┘          │       │ (future)         │
│                                  │       └──────────────────┘
│                                  │                │
│   ┌──────────────────┐          │                │
│   │ Poll COMM2       │◄─────────────────────────┘
│   │ (wait for ack)   │          │
│   └──────────┬───────┘          │
│              │                   │
│       COMM2  │                   │
│    changed?  │                   │
│              ▼                   │
│   ┌──────────────────┐          │
│   │ Clear COMM4 = 0  │          │
│   │ (work complete)  │          │
│   └──────────────────┘          │
│                                  │
└─────────────┘                    └─────────────┘
```

## Implementation Phases

### Phase 1: Current (✅ Complete)
**Simple COMM2 increment test**
- Proves Slave CPU is executing code
- Verifies COMM register writes work
- Establishes baseline (~37-39 increments per 60 frames)

**Code**: 18 bytes at $02050C
```asm
mov.l   .L_comm2,r0         ; Load COMM2 address
mov     #0,r1               ; Counter = 0
loop:
    add     #1,r1           ; Increment
    mov.l   r1,@r0          ; Write to COMM2
    bra     loop            ; Loop forever
    nop
```

### Phase 2: Work Signal Detection (Next)
**Upgrade to check COMM4**

**Option A: Minimal (fits in 18 bytes)**
- Check COMM4 for work signal
- If work: increment COMM2
- If no work: keep checking

**Problem**: Complex logic doesn't fit in 18 bytes (need 48+)

**Option B: Redirect (recommended)**
- 18-byte space: JSR to full function
- Full function: In unused ROM gap ($020466, 18 bytes available)
- Gives us room to grow

**Option C: Expansion ROM**
- Put function at $300000+
- Problem: PicoDrive 0x06 region is SDRAM, not ROM
- Would need to copy function to SDRAM first

**Recommendation**: Start with Option A (minimal), upgrade to B if needed

### Phase 3: Master Work Dispatch
**Add Master-side work signaling**

**Location**: Master V-INT handler or rendering loop
**Hook point**: Find where Master decides to render a frame

**Pseudocode**:
```c
// Master V-INT handler
void master_vint() {
    if (work_available_for_slave()) {
        COMM4 = 1;  // Signal work to Slave

        // Wait for acknowledgment (with timeout)
        int timeout = 1000;
        while (COMM2 == old_comm2 && timeout--) {
            // Slave should increment COMM2 when it sees work
        }

        if (COMM2 != old_comm2) {
            // Slave acknowledged, work was distributed
            COMM4 = 0;  // Clear work signal
        } else {
            // Timeout - Slave not responding
            // Handle error...
        }
    }
}
```

### Phase 4: Actual Work Payload
**Define what work the Slave will do**

**Options for parallel rendering**:
1. **Polygon list splitting**
   - Master: First half of polygons
   - Slave: Second half
   - Merge in VDP

2. **Double buffering**
   - Master: Render odd frames
   - Slave: Render even frames
   - Alternate frame buffers

3. **Object splitting**
   - Master: Track + background
   - Slave: Cars + opponents
   - Composite layers

4. **LOD processing**
   - Master: Near objects (high detail)
   - Slave: Far objects (low detail)
   - Combine for full scene

**Recommendation**: Start with polygon list splitting (easiest to verify)

## Space Analysis

### Available Code Space

**Tight spaces** (current location):
- $02050C: 18 bytes (where test code is now)

**Unused gaps** (from gap analysis):
- $020466-$020476: 18 bytes
- $0209D8-$0209E4: 12 bytes
- $0209E4-$0209F0: 12 bytes
- $0209F0-$0209FC: 12 bytes
- $0209FC-$020A08: 12 bytes
- $020A08-$020A14: 12 bytes
- $020A14-$020A20: 12 bytes
- **Total**: 100 bytes available

**Expansion ROM**:
- $300000-$30FFFF: 64 KB (but may not be accessible for execution)

### Space Allocation Plan

```
$02050C (18 bytes):  JSR redirect to work check
$020466 (18 bytes):  Work check function (COMM4 poll + COMM2 increment)
$0209D8 (12 bytes):  Work processing stub (future)
$0209E4 (12 bytes):  Error handler (future)
$300000+:            Full work payload functions (if accessible)
```

## Testing Strategy

### Phase 2 Test: Work Signal Detection
```bash
# 1. Build ROM with work check code
make clean && make all

# 2. Test in emulator with debug trace
picodrive build/vr_rebuild.32x

# 3. Verify Slave behavior:
# - COMM4 = 0: Slave loops, COMM2 unchanged
# - COMM4 = 1: Slave increments COMM2

# 4. Manual COMM4 manipulation (via debugger):
# Set COMM4 = 1, verify COMM2 increments
# Set COMM4 = 0, verify COMM2 stops
```

### Phase 3 Test: Master Dispatch
```bash
# 1. Add Master dispatch code
# 2. Build and run
# 3. Monitor COMM registers:
#    - Master should set COMM4 periodically
#    - Slave should respond by incrementing COMM2
#    - Master should clear COMM4 after acknowledgment
```

### Phase 4 Test: Parallel Rendering
```bash
# 1. Implement polygon splitting
# 2. Measure FPS improvement
# 3. Target: 20 FPS → 25-30 FPS (+25-50%)
```

## Success Metrics

- [ ] Phase 2: Slave responds to COMM4 signal
- [ ] Phase 3: Master can trigger Slave work on demand
- [ ] Phase 4: Measurable FPS improvement (target: +30%)

## Risks & Mitigation

**Risk 1**: Work check function too complex for available space
- **Mitigation**: Use redirect approach, place full function in gap

**Risk 2**: Master-Slave synchronization issues
- **Mitigation**: Implement timeout and error handling

**Risk 3**: Work distribution overhead negates benefits
- **Mitigation**: Measure carefully, optimize critical path

**Risk 4**: Expansion ROM not executable
- **Mitigation**: Use ROM gaps for code, expansion ROM for data only

## Next Immediate Steps

1. **Implement Phase 2**: Work signal detection
   - Create minimal work check (if fits in 18 bytes)
   - OR create redirect + full function in gap

2. **Test work detection**: Manually set COMM4, verify COMM2 response

3. **Implement Phase 3**: Master dispatch hook

4. **Measure baseline**: Current FPS without work distribution

5. **Implement Phase 4**: Actual parallel workload

---

**Current Position**: Phase 1 complete, ready for Phase 2
**Next Milestone**: Slave responds to COMM4 work signal
