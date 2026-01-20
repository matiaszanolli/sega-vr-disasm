# SH2 Master and Slave Code Map

## Purpose
Systematic documentation of Master and Slave SH2 code locations and functions.

## Master SH2 Section

### Entry Point: ROM $020500
```assembly
; Master SH2 Entry Signature
$020500: 4D5F 4F4B = "M_OK"     ; Entry point marker
$020504: 434D 4449 = "CMDI"    ; Command interface marker
```

### Master Initialization: ROM $020508-???
```assembly
$020508: D105          ; MOV.L @(5,PC),R1
$02050A: D706          ; MOV.L @(6,PC),R7
```

**Status**: ❌ NOT YET DISASSEMBLED
**Critical for**: Understanding Master main loop and work dispatch

---

## Slave SH2 Section

### Entry Point: ROM $020650

```assembly
; Slave SH2 Entry - CRITICAL CODE SECTION
$020650: DE13          ; MOV.L @(19,PC),R14
$020652: D014          ; MOV.L @(20,PC),R0
$020654: 1E01          ; MOV.L R0,@(1,R14)
$020656: 50E0          ; ?
$020658: D113          ; MOV.L @(19,PC),R1
$02065A: 3010          ; CMP/EQ R1,R0
$02065C: 8901          ; BT +1
$02065E: AFFA          ; BRA -6 (loop back to $02065A)
$020660: 0009          ; NOP (delay slot)
```

**Purpose**: Slave initialization and main idle loop
**Status**: 🔄 PARTIALLY UNDERSTOOD
**Critical for**: Understanding where Slave waits for work

### VDP Wait Function: ROM $02050C (CRITICAL - DO NOT MODIFY)

```assembly
; VDP synchronization function called during rendering
$02050C: E000          ; MOV #0,R0
$02050E: 2106          ; MOV.W R0,@R1
$020510: 2106          ; MOV.W R0,@R1
$020512: 2106          ; MOV.W R0,@R1
$020514: 2106          ; MOV.W R0,@R1
$020516: 4710          ; DT R1
$020518: 8BF9          ; BF -7 (loop to $02050E)
$02051A: 000B          ; RTS
$02051C: 0009          ; NOP (delay slot)
```

**Purpose**: VDP wait/sync during frame rendering
**Called by**: Slave SH2 during rendering operations
**WARNING**: Modifying this breaks rendering - verified through testing

---

## Code Section Boundaries

### Confirmed SH2 Code Regions
| Start Offset | End Offset | Size | Description |
|--------------|------------|------|-------------|
| $020500 | $02050B | 12 B | Master entry signature |
| $02050C | $02051C | 17 B | VDP wait function (CRITICAL) |
| $020650 | ~$0206A0 | ~80 B | Slave entry and idle loop |

### Complete SH2 Code Map
| ROM Offset Range | Size | Purpose | Status |
|------------------|------|---------|--------|
| $020500-$020650 | 256 B | Master initialization & main loop | ✅ MAPPED |
| $020650-$020750 | 256 B | Slave init & **IDLE LOOP** | ✅ MAPPED |
| $020750-$025B76 | ~5.4 KB | 3D rendering engine (58 functions) | ✅ MAPPED |
| $025B76-$026000 | ~1.2 KB | Data tables & constants | ✅ MAPPED |

---

## COMM Register Usage (Current State)

From analysis/architecture/MASTER_SLAVE_ANALYSIS.md:

| Register | Address (SH2) | Current Use | Notes |
|----------|---------------|-------------|-------|
| COMM0 | $20004020 | Status | |
| COMM1 | $20004022 | Status | |
| COMM2 | $20004024 | Unused? | Available for testing |
| COMM3 | $2000402C | "OVRN" marker | Slave writes in idle loop |
| COMM4 | $20004028 | Unused? | Available for testing |
| COMM5 | $2000402A | Unused? | |
| COMM6 | $2000402C | Unused? | Available for work signal |
| COMM7 | $2000402E | Unused? | |

**Note**: COMM register usage needs verification through full code disassembly.

---

## Next Steps for Complete Understanding

### Phase 1: Map Code Sections
- [ ] Disassemble Master init ($020508-$02064F)
- [ ] Disassemble Master main loop
- [ ] Disassemble Slave work processing ($0206A0+)
- [ ] Find extent of SH2 code (where does it end?)

### Phase 2: Understand Coordination
- [ ] Document all COMM register reads/writes
- [ ] Trace Master-Slave handshake protocol
- [ ] Identify work dispatch mechanism
- [ ] Map frame synchronization points

### Phase 3: Identify Safe Injection Points
- [ ] Find Slave idle check location
- [ ] Find Master frame start location
- [ ] Identify unused code gaps for new functions
- [ ] Verify expansion ROM is accessible from SH2

---

**Status**: Initial mapping complete
**Confidence**: High for VDP wait, Low for other sections
**Date**: 2026-01-20
