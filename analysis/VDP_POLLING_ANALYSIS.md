# VDP Polling Analysis

**Purpose**: Identify and analyze VDP/COMM polling loops that waste CPU cycles.

---

## Summary of Findings

| Location | Type | Pattern | Impact |
|----------|------|---------|--------|
| VDPFill ($0027F8) | VDP Status | BTST #1 loop | Hardware wait - necessary |
| VDPPrep ($00281E) | VDP Status | BTST #1 loop | Hardware wait - necessary |
| VDPSyncSH2 ($0028C2) | COMM Port | BTST #1 loop | **OPTIMIZABLE** |
| VDP end ($002970) | VDP Status | BTST #1 loop | Hardware wait - necessary |
| 68K COMM polling | ~10 locations | TST.B loop | **OPTIMIZABLE** |
| SH2 Slave main | Sync buffer | BT loop | **OPTIMIZABLE** |

---

## Polling Pattern Details

### 1. VDP Fill Status Polling (Hardware Wait)

**Locations**: $002814, $002848, $002976

```asm
; VDPFill at $0027F8
BTST #1,$008B(A4)     ; Test VDP fill-busy bit
DC.W $66F8            ; BNE.S -8 (loop until clear)
```

**Analysis**:
- `$008B(A4)` = `$A1518B` = VDP status register
- Bit 1 = Auto-fill busy flag
- **NECESSARY**: Must wait for VDP hardware to complete fill
- **Cannot optimize away** - hardware timing constraint

**Cycle Cost**:
- Per iteration: BTST(8) + BNE(10) = ~18 cycles
- Typical duration: 16 fill blocks × ~64 cycles = ~1024 cycles
- **Total per fill**: ~1000-2000 cycles

### 2. COMM Port Polling (68K Side) - OPTIMIZABLE

**Locations**: $00D5F4, $00D77E, $00D7A2, $00DCDE, $00DDF8, $00DEE0, $00DF18, etc.

```asm
; Wait for SH2 to clear COMM0
loc_00D5F4:
    TST.B  $00A15120        ; Test COMM0
    BNE.S  loc_00D5F4       ; Loop while non-zero

; Send command
    MOVE.B  #$002E,$00A15121  ; Write to COMM1
    MOVE.B  #$0001,$00A15120  ; Signal SH2
```

**Analysis**:
- ~10 instances in z80_commands.asm alone
- ~71+ instances across game code
- **CAN BE OPTIMIZED**: Use CMD interrupt instead of polling

**Cycle Cost**:
- Per iteration: TST.B(4) + BNE.S(10) = ~14 cycles
- Typical iterations: 100-10,000 (depends on SH2 processing)
- **Worst case**: 10,000 × 14 = **140,000 cycles wasted per operation**

### 3. VDP/SH2 Synchronization (Mixed)

**Location**: $0028C2 (VDPSyncSH2)

```asm
VDPSyncSH2:
    MOVE.W #$0500,MARS_DREQ_LEN
    ; ... setup ...
    BTST #1,$00A15123        ; Test COMM3 bit 1
    DC.W $67F6               ; BEQ.S -10 (loop until set)
    BCLR #1,$00A15123        ; Clear flag
```

**Analysis**:
- Waits for SH2 to set a flag in COMM3
- **CAN BE OPTIMIZED**: Use interrupt from SH2

### 4. SH2 Slave Main Loop - OPTIMIZABLE

**Location**: SH2 SDRAM `$26000400` cache-through (`$06000400` cached)

```asm
.wait_for_work:
    mov.l   @r14, r0        ; Read sync word
    cmp/eq  #0, r0          ; Compare to 0
    bt      .wait_for_work  ; Loop if zero
```

**Analysis**:
- Slave spins forever waiting for work
- Master NEVER dispatches work in current code
- **CRITICAL OPTIMIZATION TARGET**: Activate Slave

**Cycle Cost**:
- Per iteration: MOV.L(1) + CMP/EQ(1) + BT(2) = ~4 cycles
- Runs ~95% of frame time = ~900,000 cycles/frame
- **MASSIVE WASTE**: ~900,000 cycles/frame

---

## Optimization Strategies

### Strategy A: Replace COMM Polling with Interrupts

**Before** (polling):
```asm
wait:
    TST.B   $A15120
    BNE.S   wait
```

**After** (interrupt-driven):
```asm
    ; Set up interrupt handler
    ; SH2 triggers CMD interrupt when ready
    ; 68K continues other work until interrupt
```

**Estimated Gain**: 50,000-150,000 cycles/frame (+5-15%)

### Strategy B: Activate Slave SH2

**Current**: Slave spins in wait loop
**Proposed**: Master dispatches polygon work to Slave

**Steps**:
1. Master sets polygon range in sync buffer
2. Master writes "WORK" to sync word
3. Slave processes assigned polygons
4. Slave writes "DONE" to sync buffer
5. Master waits for completion (can overlap with own work)

**Estimated Gain**: 200,000-400,000 cycles/frame (+20-40%)

### Strategy C: Reduce VDP Fill Operations

Not directly optimizable (hardware constraint), but:
- Batch multiple fill operations
- Reduce fill frequency where possible
- Use DMA for larger transfers

---

## Priority Ranking

| Priority | Target | Effort | Gain |
|----------|--------|--------|------|
| **1** | Slave SH2 Activation | High | +30-40% |
| **2** | COMM Interrupt Replacement | Medium | +10-15% |
| **3** | VDP Fill Batching | Low | +3-5% |

---

## Files to Modify

### For COMM Polling Fix:
- `disasm/modules/68k/sound/z80_commands.asm` - 10 instances
- `disasm/modules/68k/game/*.asm` - 71 instances
- Add interrupt handlers in V-INT dispatcher

### For Slave Activation:
- `disasm/sections/section_24200.asm` - SH2 Master rendering loop
- Create new slave render routines
- Modify sync buffer protocol

---

## Next Steps

1. **Immediate**: Prototype COMM interrupt approach on single location
2. **Test**: Measure cycle savings with frame counter
3. **Scale**: Apply to all COMM polling locations
4. **Phase 2**: Tackle Slave SH2 activation
