# Phase 11: Slave Hook Bytecode Encoding

**Date:** 2026-01-22
**Version:** 1.0
**Status:** Ready for injection

---

## Slave Expansion Hook - SH2 Bytecode

This document provides the exact byte sequence to inject into Slave SDRAM at address $06000596.

### Assembly Source

```asm
; slave_expansion_hook (24 bytes / 12 instructions)
slave_expansion_hook:
        mov.l   #$2000402C, R0  ; Load COMM6 address
        mov.l   @R0, R1         ; Read COMM6 value
        mov     #$0012, R2      ; Load signal value
        cmp/eq  R2, R1          ; Check if signal matches
        bf      hook_exit       ; If not, skip call

        mov.l   #$02300027, R0  ; Load expansion_frame_counter address
        jsr     @R0             ; Call expansion code
        nop                     ; Delay slot

        mov.l   #$2000402C, R0  ; Load COMM6 address again
        mov     #$0000, R1      ; Load clear value
        mov.l   R1, @R0         ; Write 0x0000 to COMM6

hook_exit:
        rts                     ; Return to polling loop
        nop                     ; Delay slot
```

### SH2 Opcode Encoding

#### Instruction-by-Instruction Encoding

| # | Instruction | Opcode | Bytes | Notes |
|---|-------------|--------|-------|-------|
| 1 | `mov.l #$2000402C, R0` | D002 | 4 | PC-relative load (32-bit immediate) |
| 1b | *immediate literal* | 0000 | 2 | Part of mov.l (alignment) |
| 1c | *address literal* | 2000 402C | 4 | COMM6 address (0x2000402C) |
| 2 | `mov.l @R0, R1` | 6004 | 2 | Read from address in R0 into R1 |
| 3 | `mov #$0012, R2` | E212 | 2 | Load 8-bit immediate into R2 |
| 4 | `cmp/eq R2, R1` | 3210 | 2 | Compare R1 with R2 |
| 5 | `bf hook_exit` | 8F06 | 2 | Branch if false (offset = 6) |
| 6 | `mov.l #$02300027, R0` | D002 | 4 | PC-relative load (32-bit immediate) |
| 6b | *immediate literal* | 0000 | 2 | Part of mov.l (alignment) |
| 6c | *address literal* | 0230 0027 | 4 | expansion_frame_counter address |
| 7 | `jsr @R0` | 4000 | 2 | Jump to subroutine at R0 |
| 8 | `nop` | 0009 | 2 | Delay slot (required after jsr) |
| 9 | `mov.l #$2000402C, R0` | D002 | 4 | PC-relative load (COMM6 again) |
| 9b | *immediate literal* | 0000 | 2 | Part of mov.l |
| 9c | *address literal* | 2000 402C | 4 | COMM6 address |
| 10 | `mov #$0000, R1` | E210 | 2 | Load 0x0000 into R1 |
| 11 | `mov.l R1, @R0` | 2103 | 2 | Write R1 to address in R0 |
| 12 | `rts` | 000B | 2 | Return from subroutine |
| 13 | `nop` | 0009 | 2 | Delay slot (required after rts) |

**Total Size:** 52 bytes (with literal pools)

#### Compact Bytecode Sequence (for injection)

The complete hook bytecode in injection order:

```
ADDRESS OFFSET | BYTES (hex)                           | DESCRIPTION
-------|------------------------------------------------|------------------------
$596   | D0 02 00 00 20 00 40 2C | mov.l #$2000402C, R0 + literal
$59E   | 60 04                   | mov.l @R0, R1
$5A0   | E2 12                   | mov #$0012, R2
$5A2   | 32 10                   | cmp/eq R2, R1
$5A4   | 8F 06                   | bf hook_exit (offset +6 words = +12 bytes)
$5A6   | D0 02 00 00 02 30 00 27 | mov.l #$02300027, R0 + literal
$5AE   | 40 00                   | jsr @R0
$5B0   | 00 09                   | nop
$5B2   | D0 02 00 00 20 00 40 2C | mov.l #$2000402C, R0 + literal
$5BA   | E2 10                   | mov #$0000, R1
$5BC   | 21 03                   | mov.l R1, @R0
$5BE   | 00 0B                   | rts
$5C0   | 00 09                   | nop
```

**Total**: 52 bytes (0x34 bytes)

### Raw Injection Bytes

For pdcore or manual injection:

```c
// Hook bytecode as raw bytes
uint8_t slave_hook_code[] = {
    // mov.l #$2000402C, R0 + literal
    0xD0, 0x02, 0x00, 0x00, 0x20, 0x00, 0x40, 0x2C,
    // mov.l @R0, R1
    0x60, 0x04,
    // mov #$0012, R2
    0xE2, 0x12,
    // cmp/eq R2, R1
    0x32, 0x10,
    // bf hook_exit
    0x8F, 0x06,
    // mov.l #$02300027, R0 + literal
    0xD0, 0x02, 0x00, 0x00, 0x02, 0x30, 0x00, 0x27,
    // jsr @R0
    0x40, 0x00,
    // nop
    0x00, 0x09,
    // mov.l #$2000402C, R0 + literal
    0xD0, 0x02, 0x00, 0x00, 0x20, 0x00, 0x40, 0x2C,
    // mov #$0000, R1
    0xE2, 0x10,
    // mov.l R1, @R0
    0x21, 0x03,
    // rts
    0x00, 0x0B,
    // nop
    0x00, 0x09,
};

#define SLAVE_HOOK_SIZE 52  // bytes
#define SLAVE_HOOK_ADDR 0x06000596  // SDRAM injection address
```

### SH2 Opcode Reference

**Immediate Load (mov.l with 32-bit immediate):**
```
Pattern: D0 02 XX XX AA AA AA AA
  D002 = mov.l @(PC,disp), R0 (disp=2, next 2 words are literal)
  XXXXXXXX = pad/reserved (typically 0000)
  AAAAAAAA = 32-bit address literal
```

**Memory Operations:**
```
6004 = mov.l @R0, R1  (read R0 into R1)
2103 = mov.l R1, @R0  (write R1 to R0)
```

**Register Operations:**
```
E212 = mov #$0012, R2 (load 8-bit immediate into R2)
E210 = mov #$0000, R1 (load 0 into R1)
3210 = cmp/eq R2, R1  (compare and set flags)
```

**Branching:**
```
8F06 = bf +6 words (branch if false, 12 bytes forward)
```

**Control Flow:**
```
4000 = jsr @R0 (jump to subroutine at R0)
000B = rts     (return from subroutine)
0009 = nop     (no operation - delay slot)
```

---

## Injection Methods

### Method 1: pdcore Runtime Injection

```c
// Using pdcore API (once fully integrated)
pd_t *emu = pd_create(config);
pd_load_rom_file(emu, "test_rom.32x");
pd_reset(emu);

// Wait for boot to stabilize
for (int i = 0; i < 50; i++) {
    pd_stop_info_t stop;
    pd_run_frames(emu, 1, &stop);
}

// Inject hook
int result = pd_mem_write(emu, PD_BUS_SH2_SDRAM, 0x06000596,
                          slave_hook_code, SLAVE_HOOK_SIZE);
if (result != SLAVE_HOOK_SIZE) {
    printf("Hook injection failed!\n");
    return 1;
}

// Verify injection
uint8_t verify[SLAVE_HOOK_SIZE];
pd_mem_read(emu, PD_BUS_SH2_SDRAM, 0x06000596, verify, SLAVE_HOOK_SIZE);
if (memcmp(verify, slave_hook_code, SLAVE_HOOK_SIZE) == 0) {
    printf("Hook injection verified!\n");
}
```

### Method 2: Python Script for pdcore

```python
import pdcore

# Connect to running emulator
emu = pdcore.create()
emu.load_rom("test_rom.32x")
emu.reset()

# Boot sequence
for i in range(50):
    emu.run_frames(1)

# Inject hook
hook_bytes = bytes([
    0xD0, 0x02, 0x00, 0x00, 0x20, 0x00, 0x40, 0x2C,
    # ... rest of bytes ...
])
emu.write_memory(0x06000596, hook_bytes)
print("Hook injected at 0x06000596")

# Verify
verify = emu.read_memory(0x06000596, len(hook_bytes))
assert verify == hook_bytes, "Hook injection mismatch!"
print("Hook verified!")
```

### Method 3: GDB Script (if pdcore unavailable)

```gdb
# Connect to PicoDrive GDB stub
target remote localhost:1234

# Boot ROM
continue
# Wait for boot to complete (~5 seconds)

# Stop execution
interrupt

# Write hook bytes
set $pc = 0x06000596
set *((unsigned char*) 0x06000596) = 0xD0
set *((unsigned char*) 0x06000597) = 0x02
# ... set each byte ...

# Verify
dump memory /tmp/hook_verify.bin 0x06000596 0x065005CC
quit

# Compare with expected bytes
# $ cmp -bl /tmp/hook_verify.bin phase11_hook.bin
```

---

## Verification Checklist

After injection, verify:

- [ ] Hook bytes written successfully (readback matches)
- [ ] Game boots normally (no crash immediately after)
- [ ] Slave PC cycles through polling loop (not stuck)
- [ ] COMM6 register oscillates 0→0012→0 (protocol working)
- [ ] COMM4 increments each frame (hook executing)
- [ ] SDRAM[0x22000100] increments (diagnostic counter working)
- [ ] No jitter in counters (increment by exactly 1 per frame)
- [ ] Game renders normally (no graphics corruption)

---

## Known Issues & Workarounds

### Issue 1: Odd addresses in SDRAM injection

**Problem:** SH2 instructions must be aligned to even addresses (word-aligned).
**Workaround:** Always inject at even addresses (0x06000596, 0x06000598, etc.)
**Verification:** If injection fails, check address alignment.

### Issue 2: PC-relative addressing in moved code

**Problem:** mov.l with PC-relative immediate won't work if hook is relocated.
**Note:** Hook is injected at fixed $06000596, so PC-relative works fine.
**Caveat:** Don't move hook to different address without recalculating displacements.

### Issue 3: Delay slots after JSR/RTS/BRA

**Problem:** SH2 processor always executes next instruction after branch.
**Solution:** Every JSR, RTS, or BRA must have NOP or compatible instruction in delay slot.
**Verification:** Our hook includes explicit NOPs after JSR and RTS.

---

## References

- SH7095 CPU Manual (Hitachi SH2 instruction set)
- [phase11_slave_hook.asm](phase11_slave_hook.asm) - ASM source
- [PHASE11_SLAVE_HOOK_ROADMAP.md](PHASE11_SLAVE_HOOK_ROADMAP.md) - Full roadmap
- [EXPANSION_ROM_PROTOCOL_ABI.md](EXPANSION_ROM_PROTOCOL_ABI.md) - Protocol spec

