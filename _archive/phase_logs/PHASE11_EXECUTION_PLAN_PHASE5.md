# Phase 11: Runtime Hook Injection (Phase 5)

**Status:** Ready to execute
**Checkpoint Status:** Phases 1-4 complete ✅

---

## Objective

Inject the Slave SH2 hook into live emulator memory and verify it executes correctly without crashing the game.

---

## Prerequisites (All Met)

✅ **PicoDrive Integration**
- 4 debug hooks added to structures
- NULL-check guards in execution loops
- pdcore_bridge.c conditional compilation working
- Both standard and pdcore builds compile successfully

✅ **Hook Bytecode**
- 44 bytes SH2 machine code (verified in test harness)
- Injection point: 0x06000596 (SDRAM address)
- Protocol: COMM6=0x0012 (signal), COMM4++ (counter), COMM6=0x0000 (clear)

✅ **Testing Infrastructure**
- test harness (5/5 tests passing)
- ROM patcher tool (fallback validation)
- pdcore_cli tool (debugger interface)
- phase11_hook_injector tool (ready to compile)

---

## Phase 5 Execution Steps

### Step 1: Prepare pdcore-enabled PicoDrive (15 minutes)

```bash
# Build PicoDrive with pdcore integration
./build_picodrive.sh --pdcore

# Verify binary
ls -lh third_party/picodrive/picodrive
file third_party/picodrive/picodrive
```

**Expected Result:**
- Binary compiles without errors
- Dynamically linked (includes libpdcore.so)
- Size ~6.7MB (same as standard build)

### Step 2: Boot ROM with pdcore CLI (15 minutes)

```bash
# Test pdcore_cli with pdcore-enabled PicoDrive
./tools/pdcore_cli build/vr_rebuild.32x boot 50

# Expected output:
# [1/6] Creating emulator...
#   ✓ Emulator created
# [2/6] Loading ROM...
#   ✓ ROM loaded (4194310 bytes)
# [3/6] Resetting emulation...
#   ✓ Reset complete
# ...
# ✓ Boot complete (50 frames)
```

**What This Tests:**
- pdcore can create and initialize PicoDrive
- ROM loads correctly
- Emulation boots without crashes
- No determinism issues from debug hooks

### Step 3: Inspect Slave CPU State (10 minutes)

```bash
# Boot, then read Slave registers
./tools/pdcore_cli build/vr_rebuild.32x boot 50 && \
./tools/pdcore_cli build/vr_rebuild.32x regs slave

# Expected output:
# Slave SH2 State:
# PC   = 0x06000596  (or nearby polling loop address)
# R0   = 0x20004000  (likely)
# R15  = 0x06030000  (stack pointer)
# SR   = 0x00000000
```

**What This Tests:**
- pdcore register access working
- Slave PC is in expected polling loop area
- Slave is responsive to queries

### Step 4: Read Polling Loop Area (10 minutes)

```bash
# Read 52 bytes at injection point
./tools/pdcore_cli build/vr_rebuild.32x read 0x06000596 52

# Expected output:
# Address: 0x06000596
#   06000596: XX XX XX XX ... (original polling loop code)
```

**What This Tests:**
- Memory read access working
- Sufficient space available (52 bytes minimum)
- No access errors or crashes

### Step 5: Inject Hook Bytecode (15 minutes)

```bash
# Store hook bytecode
HOOK_BYTES="d00200002000402c60 04e21232108f060d00 200000023000274000 0009d00200002000 402ce2102103000b0009"

# Inject 44 bytes at 0x06000596
./tools/pdcore_cli build/vr_rebuild.32x write 0x06000596 $HOOK_BYTES

# Verify injection
./tools/pdcore_cli build/vr_rebuild.32x read 0x06000596 44

# Expected: Bytecode exactly matches HOOK_BYTES
```

**What This Tests:**
- Memory write access working
- Hook bytecode successfully injected
- Bytecode verified (no corruption)

### Step 6: Quick Smoke Test (20 minutes)

```bash
# Boot with hook injected, run 10 frames
./tools/pdcore_cli build/vr_rebuild.32x boot 10

# Visual inspection during boot:
# - Game title screen renders normally
# - No visible corruption or glitches
# - No audio artifacts
# - Game responds to input normally
```

**What This Tests:**
- Hook doesn't immediately crash emulator
- Game graphics rendering unaffected
- Sound system stable
- User input responsive

### Step 7: Extended Smoke Test (30 minutes)

```bash
# Boot, inject hook, let it run 120 frames
# Monitor COMM registers

# Manual steps:
# 1. Boot ROM with pdcore
# 2. Inject hook
# 3. Let emulator run 120 frames
# 4. Read COMM4 (frame counter at 0x2000402E)
# 5. Verify counter ≈ 120 (matches frame count)
```

**What This Tests:**
- Hook executes without jitter
- Counter increments correctly
- No frame skips detected
- Protocol timing stable

### Step 8: Stress Test (60 minutes)

```bash
# Extended 60-second test (~3600 frames at 60 FPS)
# Monitor every 30 frames:
# - COMM4 counter value
# - Slave PC stays in loop
# - No anomalies in register values

# Success criteria:
# - Zero crashes
# - Counter monotonic increase (no jumps or resets)
# - Frame timing stable
# - Game remains playable
```

---

## Fallback Options

If any step fails, we have documented fallback approaches:

### Option A: ROM Patcher Fallback
- Static ROM patching (tool already created)
- Patches ROM file instead of runtime injection
- Validates hook mechanism works
- Faster (no PicoDrive integration needed)

### Option B: GDB Debugging
- Use PicoDrive GDB stub
- Inject bytecode via GDB commands
- More hands-on but proven approach
- Can inspect state during execution

### Option C: Simplified Test
- Boot ROM without hook (verify PicoDrive works)
- Verify pdcore_cli basic functionality
- Defer full hook injection for next session
- Document findings for later

---

## Success Criteria

Phase 5 is **COMPLETE** when:

- ✅ pdcore-enabled PicoDrive builds successfully
- ✅ pdcore_cli boots ROM without crashes
- ✅ Slave registers readable and reasonable values
- ✅ 52 bytes available at injection point
- ✅ Hook bytecode injected and verified
- ✅ Quick smoke test (10 frames) passes
- ✅ Extended smoke test (120 frames) shows counter ≈ 120
- ✅ No crashes during 60-frame stress test
- ✅ Game remains playable throughout

---

## Timeline Estimate

| Step | Task | Effort | Checkpoint |
|------|------|--------|------------|
| 1 | Prepare pdcore PicoDrive | 15 min | Binary compiles |
| 2 | Boot with pdcore_cli | 15 min | Emulator stable |
| 3 | Read Slave registers | 10 min | State responsive |
| 4 | Read polling loop | 10 min | Memory access OK |
| 5 | Inject hook bytecode | 15 min | Bytecode verified |
| 6 | Quick smoke test | 20 min | No crashes (10 frames) |
| 7 | Extended smoke test | 30 min | Counter increments (120 frames) |
| 8 | Stress test | 60 min | Stability confirmed (3600 frames) |
| **Total** | | **3 hours** | **Phase 5 complete** |

---

## Detailed Hook Bytecode (44 bytes)

```asm
# Injection point: 0x06000596 (Slave polling loop)

mov.l   #$2000402C, R0  ; Load COMM6 address
mov.l   @R0, R1         ; Read COMM6 (call = signal value)
mov     #$0012, R2      ; Load signal value
cmp/eq  R2, R1          ; Compare with signal
bf      hook_exit       ; If not equal, skip

mov.l   #$02300027, R0  ; Load expansion_frame_counter entry
jsr     @R0             ; Call expansion code
nop                     ; Delay slot

mov.l   #$2000402C, R0  ; Load COMM6 address
mov     #$0000, R1      ; Load clear value
mov.l   R1, @R0         ; Write 0x0000 to COMM6 (clear signal)

hook_exit:
rts                     ; Return to polling loop
nop                     ; Delay slot
```

**Bytecode (hex):**
```
d0 02 00 00 20 00 40 2c  (mov.l #$2000402C, R0)
60 04                    (mov.l @R0, R1)
e2 12                    (mov #$0012, R2)
32 10                    (cmp/eq R2, R1)
8f 06                    (bf hook_exit)
d0 02 00 00 02 30 00 27  (mov.l #$02300027, R0)
40 00                    (jsr @R0)
00 09                    (nop)
d0 02 00 00 20 00 40 2c  (mov.l #$2000402C, R0)
e2 10                    (mov #$0000, R1)
21 03                    (mov.l R1, @R0)
00 0b                    (rts)
00 09                    (nop)
```

---

## Register Addresses (SH2 Address Space)

| Register | Address | Purpose |
|----------|---------|---------|
| COMM6 | 0x2000402C | Master→Slave signal (0x0012 = call) |
| COMM4 | 0x2000402E | Response counter (frame count) |
| Polling Loop | 0x06000596 | Slave execution point |
| Expansion Entry | 0x02300027 | Hook target (expansion ROM) |

---

## Monitoring During Test

### Frame Counter
- Read COMM4 every 30 frames
- Expected: increments by 30 each read
- Anomalies: jumps, resets, or skips indicate problems

### Slave PC
- Query Slave registers every 60 frames
- Expected: stays within polling loop (±100 bytes of 0x06000596)
- Anomalies: PC outside loop = hook not executing

### Visual Inspection
- Game title screen renders
- Graphics are clear and correct
- No texture corruption or glitches
- Sound plays normally
- Game accepts input (menu navigation)

---

## Next Phase (6)

After Phase 5 success:
- Document results in PHASE11_RESULTS.md
- Merge feature branch to master
- Tag commit as v2.2-expansion-complete
- Archive session logs

---

## Notes

- All timing is approximate (depends on system performance)
- Smoke tests can be interrupted and resumed
- If crash occurs, capture error and switch to fallback option
- Document any anomalies in PHASE11_EXECUTION_LOG.md

