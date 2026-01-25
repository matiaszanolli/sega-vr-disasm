# SH2 Master and Slave Code Map

## ✅ UPDATE: v4.0 PARALLEL PROCESSING (2026-01-25)

This document is now partially historical. Key updates:
- Slave idle loop at $0203CC redirected to `slave_work_wrapper` at $300200
- func_021 trampoline at $0234C8 signals Slave via COMM7
- **COMM4/5/7 now in active use** for Master→Slave communication

**See:** [SLAVE_INJECTION_GUIDE.md](SLAVE_INJECTION_GUIDE.md) for current implementation.

---

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

## COMM Register Usage (v4.0 - UPDATED)

| Register | Address (SH2) | Current Use | Status |
|----------|---------------|-------------|--------|
| COMM0 | $20004020 | 68K→SH2 command | Used by game |
| COMM1 | $20004022 | Reserved/flags | Used by game |
| COMM2 | $20004024 | Work status | Used by game |
| COMM3 | $20004026 | "OVRN" marker | Used by game |
| COMM4 | $20004028 | **Slave work counter** | ✅ Mod uses |
| COMM5 | $2000402A | **Vertex transform counter** | ✅ Mod uses (+101/call) |
| COMM6 | $2000402C | 68K→Master handshake | ⚠️ Used by game |
| COMM7 | $2000402E | **Master→Slave signal** | ✅ Mod uses |

**v4.0 Protocol:**
- COMM7 = 0x16 signals Slave to execute vertex transform
- COMM5 increments by 101 per successful transform
- COMM4 increments for frame sync testing

---

## Implementation Status (v4.0)

### ✅ Phase 1: Map Code Sections - COMPLETE
- [x] Disassemble Master init
- [x] Disassemble Master main loop
- [x] Disassemble Slave work processing
- [x] Full ROM disassembly in `disasm/sections/`

### ✅ Phase 2: Understand Coordination - COMPLETE
- [x] Document all COMM register reads/writes
- [x] Trace Master-Slave handshake protocol
- [x] Identify work dispatch mechanism
- [x] Map frame synchronization points

### ✅ Phase 3: Injection Points - COMPLETE
- [x] Slave idle loop at $0203CC → redirected to $300200
- [x] func_021 at $0234C8 → replaced with trampoline
- [x] 1MB expansion ROM at $300000-$3FFFFF for new code
- [x] **Parallel processing operational!**

---

**Status**: v4.0 - Parallel processing operational
**Date**: 2026-01-25
**See**: [SLAVE_INJECTION_GUIDE.md](SLAVE_INJECTION_GUIDE.md)
