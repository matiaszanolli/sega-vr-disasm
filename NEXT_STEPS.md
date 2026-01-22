# Next Steps - Incremental Testable Plan

**Version:** v2.0-4mb-cartridge
**Date:** 2026-01-21
**Approach:** Small steps, test after each change, early crash detection

---

## Golden Rule

**After EVERY change: `make clean && make all && picodrive build/vr_rebuild.32x`**

If ROM fails to boot → revert immediately, investigate before proceeding.

---

## Step 1: Verify Baseline

**Goal:** Confirm current 4MB ROM boots correctly

**Actions:**
```bash
make clean && make all
picodrive build/vr_rebuild.32x
```

**Test:** Game reaches title screen within 5 seconds

**Pass/Fail:**
- ✅ PASS → Proceed to Step 2
- ❌ FAIL → Stop, investigate regression

---

## Step 2: Verify Original ROM Slave Behavior

**Goal:** Check if Slave SH2 works in the *original* ROM

**Actions:**
```bash
picodrive roms/Virtua\ Racing\ Deluxe\ \(USA\).32x
```

**Test:** Use PicoDrive debug build to check Slave SH2 PC register
- If Slave PC changes over time → Slave is executing
- If Slave PC stuck at same address → Slave may be idle/broken

**Pass/Fail:**
- ✅ Slave executing → Proceed to Step 3
- ❌ Slave stuck → Document as PicoDrive limitation, adjust plan

**Note:** This determines if Slave SH2 issue is PicoDrive bug or ROM-specific.

---

## Step 3: Add Minimal SH2 Code (NOP only)

**Goal:** Inject simplest possible SH2 code into expansion space

**File:** `disasm/sections/expansion_300000.asm`

**Change:**
```asm
        org     $300000

; Minimal SH2 test: Single NOP instruction
expansion_test:
        dc.w    $0009               ; NOP (SH2 opcode)

        ; Fill remaining space
        dcb.b   $100000-2,$FF       ; 1MB - 2 bytes of padding
```

**Test:** `make clean && make all && picodrive build/vr_rebuild.32x`

**Pass/Fail:**
- ✅ PASS (boots) → Proceed to Step 4
- ❌ FAIL → Revert change, investigate

---

## Step 4: Add NOP + RTS

**Goal:** Add a complete minimal function (just returns)

**File:** `disasm/sections/expansion_300000.asm`

**Change:**
```asm
        org     $300000

; Minimal SH2 function: NOP then return
expansion_test:
        dc.w    $0009               ; NOP
        dc.w    $000B               ; RTS
        dc.w    $0009               ; NOP (delay slot)

        ; Fill remaining space
        dcb.b   $100000-6,$FF       ; 1MB - 6 bytes of padding
```

**Test:** `make clean && make all && picodrive build/vr_rebuild.32x`

**Pass/Fail:**
- ✅ PASS → Proceed to Step 5
- ❌ FAIL → Revert, check opcode encoding

---

## Step 5: Add COMM Register Write

**Goal:** Write a signature value to COMM6 register

**File:** `disasm/sections/expansion_300000.asm`

**Change:**
```asm
        org     $300000

; Write signature 0xABCD to COMM6, then return
; COMM6 is at $2000402C (SH2 address for $A1512C) per hardware manual
expansion_comm_test:
        dc.w    $E1AB               ; MOV #0xAB,R1 (load 0xAB into R1)
        dc.w    $D002               ; MOV.L @(disp,PC),R0 (load COMM6 addr)
        dc.w    $2012               ; MOV.L R1,@R0 (write R1 to COMM6)
        dc.w    $000B               ; RTS
        dc.w    $0009               ; NOP (delay slot)
        dc.w    $0000               ; alignment
        dc.l    $2000402C           ; COMM6 address literal

        ; Fill remaining space
        dcb.b   $100000-16,$FF
```

**Test:** `make clean && make all && picodrive build/vr_rebuild.32x`

**Pass/Fail:**
- ✅ PASS → Proceed to Step 6
- ❌ FAIL → Revert, verify opcode encoding

**Note:** This code exists but is NOT called yet. Just testing ROM still boots.

---

## Step 6: Verify Expansion Code is Reachable

**Goal:** Confirm SH2 can read expansion ROM addresses

**Actions:** Use PicoDrive debug build to:
1. Set breakpoint at $02300000 (expansion start in SH2 space)
2. Manually examine memory at $02300000
3. Verify our injected opcodes are visible

**Test:** Memory at $02300000 shows our opcodes (not $FF padding)

**Pass/Fail:**
- ✅ Opcodes visible → Proceed to Step 7
- ❌ All $FF or wrong data → Check ROM build, address mapping

---

## Step 7: Hook Expansion Code from 68K V-INT

**Goal:** Call expansion code via existing V-INT wrapper

**File:** `disasm/sections/code_200.asm`

**Change:** In the V-INT wrapper (around $00037A), add JSR to expansion test

**Approach:**
1. Find where V-INT wrapper has space for additional call
2. Add `JSR expansion_comm_test` equivalent in dc.w format
3. Ensure return path is preserved

**Test:** `make clean && make all && picodrive build/vr_rebuild.32x`

**Pass/Fail:**
- ✅ PASS → Expansion code is being called!
- ❌ FAIL → Revert, check JSR encoding

**Verification:** Check COMM6 register in debugger for signature value

---

## Step 8: Verify COMM6 Signature Appears

**Goal:** Confirm expansion code actually executes

**Test:** In PicoDrive debug:
1. Run ROM for a few frames
2. Check COMM6 ($A1512C) value
3. Should contain our signature (0xAB or similar)

**Pass/Fail:**
- ✅ Signature present → Expansion code execution confirmed!
- ❌ No signature → Code not reached, investigate call path

---

## Step 9: Add Frame Counter to COMM6

**Goal:** Prove code runs every frame (not just once)

**File:** `disasm/sections/expansion_300000.asm`

**Change:** Increment COMM6 instead of writing constant
```asm
expansion_frame_counter:
        ; Read COMM6, increment, write back
        dc.w    $D001               ; MOV.L @(disp,PC),R0 (COMM6 addr)
        dc.w    $6002               ; MOV.L @R0,R0 (read current value)
        dc.w    $7001               ; ADD #1,R0 (increment)
        dc.w    $D001               ; MOV.L @(disp,PC),R1 (COMM6 addr again)
        dc.w    $2102               ; MOV.L R0,@R1 (write back)
        dc.w    $000B               ; RTS
        dc.w    $0009               ; NOP (delay slot)
        dc.w    $0000               ; alignment
        dc.l    $2000402C           ; COMM6 address (per hardware manual)
```

**Test:** COMM6 value increases each frame

**Pass/Fail:**
- ✅ Counter incrementing → Per-frame execution confirmed
- ❌ Stuck at same value → Called once or not at all

---

## Step 10: Document Success, Plan Next Phase

**Goal:** Record working configuration before advancing

**Actions:**
1. Commit working expansion code
2. Document exact opcodes and addresses used
3. Tag as milestone (e.g., `v2.1-expansion-executing`)
4. Plan Slave SH2 activation steps

---

## Quick Reference: SH2 Opcodes

| Instruction | Opcode | Notes |
|-------------|--------|-------|
| NOP | $0009 | No operation |
| RTS | $000B | Return from subroutine |
| MOV #imm,Rn | $E_nn | Load 8-bit immediate |
| MOV.L @(disp,PC),Rn | $D_nn | PC-relative load |
| MOV.L Rm,@Rn | $2nm2 | Store to address |
| ADD #imm,Rn | $7nii | Add 8-bit immediate |

**Delay slot:** Instruction after RTS/BRA always executes

---

## Revert Procedure

If any step fails:

```bash
# Revert expansion file to padding only
git checkout disasm/sections/expansion_300000.asm

# Rebuild and verify
make clean && make all && picodrive build/vr_rebuild.32x
```

---

## Success Metrics

| Step | Description | Status |
|------|-------------|--------|
| 1 | Baseline 4MB boots | ✅ Complete |
| 2 | Original ROM Slave check | ⏳ |
| 3 | NOP in expansion | ⏳ |
| 4 | NOP + RTS | ⏳ |
| 5 | COMM write (passive) | ⏳ |
| 6 | Expansion reachable | ⏳ |
| 7 | Hook from V-INT | ⏳ |
| 8 | COMM signature verified | ⏳ |
| 9 | Frame counter works | ⏳ |
| 10 | Document & tag | ⏳ |

---

## Key Files

| File | Purpose |
|------|---------|
| `disasm/sections/expansion_300000.asm` | SH2 expansion code |
| `disasm/sections/code_200.asm` | V-INT wrapper (68K) |
| `disasm/vrd.asm` | Main build file |

---

## Emulator Notes

- **PicoDrive (system):** Use for boot testing
- **PicoDrive (custom):** Use for debugging/register inspection
- **BlastEm:** Does NOT support 32X

---

**Last Updated:** 2026-01-21
