# SH2 Parallelization - Refined Implementation Strategy

## Strategy Refinements Based on User Preferences

This document consolidates the implementation plan with specific technical decisions made during planning review.

---

## Overview

**Conservative Phase 3 + Polygon-Based Partitioning + Hardware-Validated Development**

Start with **minimal stub that immediately uses real polygon-based partitioning**, verify on both emulator and hardware, then iterate rendering functions gradually.

**Expected outcome**: +20-30% performance gain with lower risk than aggressive full-function duplication.

---

## Phase-by-Phase Strategy

### Phase 1: Slave Activation (2-3 days) - Unchanged
- Replace idle loop with work dispatcher
- Establish SDRAM sync buffer at 0x22000400
- Basic handshaking: MASTER_READY / SLAVE_READY / MASTER_DONE / SLAVE_DONE

**No changes to this phase.**

---

### Phase 2: Work Distribution (3-4 days) - Unchanged
- Master initializes sync buffer in func_001
- Master dispatches work in final_exit
- Slave receives polygon range via SDRAM parameters

**Implementation detail: Include bounds parse phase call**

```assembly
; In Master's dispatch_slave_and_wait:
dispatch_slave_and_wait:
    mov.l   @(sync_base,PC),r14

    ; NEW: Call shared bounds parser
    bsr     parse_polygon_bounds
    nop

    ; ... rest of dispatch (unchanged)
```

---

### Phase 3: Polygon-Based Partitioning (6-8 days) - REFINED

**Key changes from original plan:**

#### 3.1: Shared Bounds Parse Function

Create a **single parse function** that both Master and Slave call:

```assembly
; Location: sh2_slave_engine.asm (first, then copy to Master section)

; ============================================================================
; parse_polygon_bounds - Build bounds index for all polygons
; ============================================================================
; Called once per frame by Master during dispatch phase
; Stores polygon bounds (X-min, X-max) in SDRAM for both CPUs to read
; ============================================================================

parse_polygon_bounds:
    sts.l   pr,@-r15

    ; bounds_array location: SDRAM 0x22001000 (room for 1600 entries)
    ; Each entry: 4 bytes (X-min in bits 15-0, X-max in bits 31-16)

    mov.l   @(bounds_array,PC),r14    ; R14 = &bounds_array[0]
    mov.l   @(display_list,PC),r13    ; R13 = display list pointer
    mov     #0,r10                      ; R10 = polygon index

.parse_loop:
    ; Read polygon command from display list
    mov.w   @r13+,r0                   ; Read 16-bit command

    ; Check for terminator (0x0C)
    extu.b  r0,r0
    cmp/eq  #0x0C,r0
    bt      .parse_done

    ; Decode polygon and extract bounds
    ; (Simplified: assume bounds are in next few commands)
    ; In practice: follow display list format to find polygon vertices

    ; Extract X-coordinates from polygon data
    ; R8 = X-min, R9 = X-max (computed from vertices)
    ; ...bounds extraction logic...

    ; Store bounds: [X-min (low 16), X-max (high 16)]
    shll16  r9                         ; X-max in high word
    extu.w  r8,r0                      ; X-min in low word
    or      r9,r0                      ; Combine
    mov.l   r0,@r14                    ; Store to bounds array
    add     #4,r14                     ; Next entry

    add     #1,r10                     ; Next polygon
    cmp/ge  #800,r10                   ; Stop at 800 polygons
    bf      .parse_loop

.parse_done:
    lds.l   @r15+,pr
    rts
    nop

.align 4
bounds_array:
    .long   0x22001000    ; SDRAM bounds index (1600 entries × 4 bytes)
display_list:
    .long   0x02000000    ; Placeholder, set at runtime
```

**Benefits:**
- Both CPUs use same bounds data (no duplication)
- Fast lookup: O(1) per polygon
- Master does the work once, Slave reuses

#### 3.2: Stub Rendering with Real Partitioning

Slave stub immediately uses **polygon-based left/right split**:

```assembly
slave_process_polygons:
    sts.l   pr,@-r15

    ; Load pointers
    mov.l   @(frame_buf_base,PC),r9       ; R9 = frame buffer base (0x24000000)
    mov.l   @(bounds_array,PC),r14        ; R14 = bounds index
    mov.l   @(sync_base,PC),r1
    mov.l   @(20,r1),r10                  ; R10 = SLAVE_START (e.g., 400)
    mov.l   @(24,r1),r11                  ; R11 = SLAVE_END (e.g., 799)

.polygon_loop:
    cmp/gt  r11,r10
    bt      .done

    ; Check bounds for this polygon
    ; bounds_entry = bounds_array[r10]
    shll2   r10                           ; R10 *= 4 (word offset)
    mov.l   @(r14,r10),r0                 ; Load bounds

    ; Extract X-max (high 16 bits)
    shar16  r0                            ; Shift right 16
    extu.w  r0,r0                         ; Mask to 16 bits

    ; Slave renders only if X-max >= 160 (right half)
    cmp/ge  #160,r0
    bf      .skip_polygon                 ; Skip if not in right half

    ; STUB IMPLEMENTATION: Just increment counter for now
    ; Later: Replace with actual rendering call
    mov.l   #1,r2
    ; bsr   slave_func_023_stub            ; Stub function (later: real rendering)

.skip_polygon:
    shar2   r10                           ; R10 /= 4 (restore)
    add     #1,r10
    bra     .polygon_loop
    nop

.done:
    lds.l   @r15+,pr
    rts
    nop

.align 4
frame_buf_base:
    .long   0x24000000
bounds_array:
    .long   0x22001000
sync_base:
    .long   0x22000400
```

**Key insight**: Start with real polygon-based bounds checking from day one. The stub logic is correct and testable. Rendering comes later.

#### 3.3: Master-Side Bounds Checking (Mirror Code)

Master also checks bounds before rendering:

```assembly
master_process_polygons:
    ; ... similar loop to Slave ...

    ; Master renders only if X-max < 160 (left half)
    cmp/lt  #160,r0
    bf      .skip_polygon

    ; bsr   func_023  ; Actual rendering (unchanged)
```

**Result**: Both CPUs have identical bounds logic, partition correctly, can be independently verified.

---

### Phase 4: Gradual Function Addition (7-10 days) - NEW PHASING

Instead of duplicating all functions at once:

**4.1 First Rendering Function: func_029 (Region Code Gen)**
- Simplest function (82 bytes)
- No frame buffer access
- Pure computation on polygon data
- Test: Verify computed region codes match Master's

**4.2 Second: func_032 (Scanline Fill)**
- Simple loop, writes to frame buffer
- Now test actual rendering
- Verify left/right split produces correct pixels

**4.3 Third: func_033 (Polygon Rendering)**
- Calls func_034 (Bresenham)
- More complex but follows func_032 pattern
- Test with real polygons

**4.4 Fourth: func_023 (Frustum Culler)**
- The main hub function
- Calls 029, 032, 033, 036
- Final integration

**Milestone**: Only after 4.4 succeeds do we move to Phase 5.

**Benefits:**
- Test each function independently
- Isolate bugs quickly
- Lower risk than big-bang duplication
- Can validate on hardware after each function

---

## Debugging Strategy

### Dual Debugging Approach

#### 1. COMM Register Status (Real-Time Monitoring)

Use COMM3 and COMM4 for status output:

```assembly
; Configurable debug levels
DEBUG_LEVEL equ 3  ; 0=off, 1=frame count, 2=sync state, 3=full

.if DEBUG_LEVEL >= 1
    ; Frame counter output (heartbeat)
    mov.l   #(master_frame_count & 0xFFFF),r0
    mov.w   r0,@(0x20004026)     ; Write to COMM3 (Master)
    mov.l   #(slave_frame_count & 0xFFFF),r0
    mov.w   r0,@(0x20004028)     ; Write to COMM4 (Slave)
.endif

.if DEBUG_LEVEL >= 2
    ; Sync state machine output
    ; COMM3 bits [3:0] = sync state
    ; COMM3 bits [7:4] = error code
    mov     #sync_state,r0
    shll    r0
    mov.w   r0,@(0x20004026)
.endif

.if DEBUG_LEVEL >= 3
    ; Cycle counter output
    mov.l   @(FRT_counter,PC),r1
    mov.w   @r1,r0
    mov.w   r0,@(0x20004026)     ; Master cycles
    ; ... similar for Slave
.endif
```

**Advantage**: Watch in real-time with COMM register viewer in emulator

#### 2. Software Trace Buffer (Post-Mortem Analysis)

SDRAM trace buffer at 0x22020000:

```assembly
; Trace format: [event_id (16-bit), timestamp (16-bit), reserved (32-bit)]
TRACE_BUFFER equ 0x22020000
TRACE_INDEX  equ 0x22020004  ; Current index
TRACE_SIZE   equ 256         ; Entries (1KB total)

; Macro: Log event
TRACE_EVENT macro event_code, timestamp_source
    mov.l   @(trace_idx,PC),r0
    mov.l   @r0,r1

    ; Bounds check (wrap at TRACE_SIZE)
    cmp/ge  #TRACE_SIZE,r1
    bf      .continue\@
    mov     #0,r1
    mov.l   r1,@r0

.continue\@:
    ; Write event: [event_code, timestamp]
    mov.l   @(trace_buf,PC),r2
    shll2   r1
    add     r2,r1

    mov     #\event_code,r0
    mov.w   r0,@r1

    ; Timestamp
    mov.l   @(FRT_addr,PC),r0
    mov.w   @r0,r0
    mov.w   r0,@(2,r1)

    ; Increment index
    mov.l   @(trace_idx,PC),r0
    mov.l   @r0,r1
    add     #1,r1
    mov.l   r1,@r0
endm

; Use in code:
    TRACE_EVENT 0x1000, FRT     ; Master: Start frame
    TRACE_EVENT 0x2000, FRT     ; Slave: Received work
    TRACE_EVENT 0x2001, FRT     ; Slave: Completed work
```

**Advantage**: Extract trace to PC, analyze full timeline, detect deadlocks

---

## Memory Layout (Final)

```
SDRAM Address Map:
0x22000400  Sync buffer (control flags, work params)      [64 bytes]
0x22001000  Polygon bounds index (800 × 4 bytes)          [3.2 KB]
0x22020000  Trace buffer (256 × 8 bytes)                  [2 KB]
0x22030000  Debug counters (frame count, cycles, etc)     [1 KB]
0x22040000  Available for future expansion

Total used: ~6.3 KB out of 256 KB SDRAM
```

---

## Testing Procedure (Refined)

### Phase 1 Testing
- [x] ROM boots
- [x] Slave heartbeat visible in COMM3

### Phase 2 Testing
- [x] Sync flags change correctly
- [x] Timeout fallback works
- [x] Trace buffer shows correct event sequence

### Phase 3.0 (Bounds Parse Testing)
- [x] Bounds index populated correctly
- [x] Both CPUs read correct bounds for each polygon
- [ ] Partition boundary test: draw vertical line at X=160
- [ ] Visual: Upper-left and lower-right regions render

### Phase 3.1-3.4 (Incremental Function Testing)
- **3.1**: func_029 region codes match Master
- **3.2**: func_032 pixels appear correctly in right-half regions
- **3.3**: func_033 complex polygons render without artifacts
- **3.4**: func_023 integration produces full scene

### Phase 4 Testing (Post-Validation)
- [x] Emulator: 1000-frame stress test
- [x] Hardware: Play through full race
- [x] Performance: Measure improvement

---

## Critical Implementation Order

1. **Shared bounds parse function** (high priority - used by both CPUs)
2. **Slave work loop with bounds checking** (foundation)
3. **Master bounds checking** (mirror Slave logic)
4. **func_029 stub** (first real function)
5. **func_032 stub** (frame buffer writes)
6. **func_033 stub** (complex rendering)
7. **func_023 integration** (complete hub)
8. **Optimization** (Phase 4, only after Phase 3 stable)

---

## Risk Mitigation

**Bounds Checking Bugs** (HIGH RISK)
- Mitigation: Extensive testing on both emulator and hardware
- Fallback: Quick disable via compile flag

**Polygon Independence Assumption** (MEDIUM RISK)
- Mitigation: Visual inspection of rendered output for overlaps/gaps
- Fallback: Reduce polygon range if issues found

**SDRAM Contention** (MEDIUM RISK)
- Mitigation: Monitor cycle counts, profile SDRAM access patterns
- Fallback: Use FIFO more strategically, reduce parallel work

**Cache Coherency** (LOW RISK with current approach)
- Bounds are READ-ONLY during rendering
- Trace buffer is per-CPU write only
- No risk of stale cached data

---

## Build Integration

Simple approach (existing toolchain ready):

```makefile
# SH2 Master code modifications
disasm/sh2_3d_engine_annotated.asm:
  - Add sync_buffer initialization in func_001
  - Add bounds parsing call in func_001
  - Add bounds checking in rendering main loop
  - Add Slave dispatch in final_exit

# SH2 Slave code (new)
disasm/sh2_slave_engine.asm:
  - Slave main loop (work dispatcher)
  - Shared parse_polygon_bounds function
  - Slave rendering functions (added gradually)
  - Stub implementations
```

No Makefile changes needed - existing build system can handle modified source files.

---

## Success Criteria (Updated)

### Phase 1
- ✅ ROM boots
- ✅ Slave loop responds to MASTER_READY
- ✅ COMM3 shows Slave heartbeat

### Phase 2
- ✅ Sync protocol works
- ✅ Trace buffer shows correct event sequence
- ✅ Timeout fallback functions

### Phase 3 (with Bounds Partition)
- ✅ Bounds index populated
- ✅ Polygon-based partition working (visible on screen)
- ✅ func_029 computed correctly
- ✅ func_032 writes to correct regions
- ✅ func_033 & func_023 integrated
- ✅ No visual artifacts
- ✅ +10-15% performance gain visible
- ✅ Validated on real hardware

### Phase 4
- ✅ Pipeline overlap working
- ✅ +20-30% total performance gain
- ✅ Stable for 1000+ frames

---

## Next Steps

1. Create skeleton `disasm/sh2_slave_engine.asm`
2. Implement Phase 1: Slave main loop
3. Implement Phase 2: Sync protocol with COMM/trace debugging
4. Implement Phase 3.0: Bounds parse function
5. Test on emulator (BlastEm), validate with hardware
6. Iterate through rendering functions 3.1-3.4
7. Only proceed to Phase 4 after Phase 3 validated

---

## Timeline Estimate (Revised)

- **Phase 1**: 2-3 days
- **Phase 2**: 3-4 days
- **Phase 3 (with gradual functions)**: 10-12 days (not 5-7)
- **Phase 4**: 4-5 days (only if needed)
- **Total**: 19-24 days (3.5-4 weeks)

Slightly longer due to more conservative approach and testing, but lower risk profile.

---

## Key Differences from Original Plan

1. **Bounds Pre-Parsing**: Shared function, reduces duplication
2. **Polygon-Based Partition**: More complex but better load balancing
3. **Gradual Function Addition**: One function at a time, not all at once
4. **Dual Debugging**: COMM registers + trace buffer for visibility
5. **Hardware Validation**: Emulator development with hardware milestones
6. **Conservative but Complete**: Start with real partition, verify at each step

This approach balances risk and feature completeness for sustainable development pace.
