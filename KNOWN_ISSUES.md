# KNOWN_ISSUES — Pitfalls, Bugs, and Gotchas

Lessons learned across sessions. **Read this before modifying code.**

---

## 68K Assembly Translation

### ASL vs LSL — Different Opcodes
- `ASL.L #4,D0` = $E980 (type bits 4-3 = 00)
- `LSL.L #4,D0` = $E988 (type bits 4-3 = 01)
- Both shift left identically, but encode differently and have different flag behavior
- Original code uses LSL for logical shifts — **always verify against ROM bytes**

### BSR.W vs JSR (d16,PC) — Different Opcodes
- `BSR.W label` = $6100 + displacement
- `JSR label(pc)` = $4EBA + displacement
- VRD uses `JSR (d16,PC)` for intra-section subroutine calls
- **Fix:** Use `jsr label(pc)` syntax in vasm to get the $4EBA encoding

### m68k_disasm.py Known Bugs
The project disassembler (`tools/m68k_disasm.py`) has these confirmed issues:
- **ASL/LSL:** Shift count field 000 means 8, not 0 (shows wrong count)
- **EXT.L** ($48C0): Confused with MOVEM.L when followed by certain words
- **CLR.W** ($4268): Decoded as CLR.B (size bits 01=word decoded as byte)
- **DIVS.W** ($81Cx): Shown as "OR" (opcode line 8 misidentified)
- **ADDQ** ($52xx): Sometimes shown as SUBQ
- **Multi-word instructions:** Extension words sometimes parsed as new opcodes

**Rule:** Always verify disassembler output against ROM hex bytes for critical code.

---

## SH2 Assembly Translation

### Assembler Padding Causes Size Mismatches
`sh-elf-as` adds implicit alignment padding not present in the original ROM.
- **func_001:** 76 bytes assembled (expected 75) — +1 byte
- **func_002:** 96 bytes assembled (expected 87) — +9 bytes
- Even 1-byte mismatch causes section overlap errors in the fixed ROM layout:
  ```
  sections <org0019:22200>:22200-2420e and <org0020:24206>:24206-26200 must not overlap
  ```

### When to Keep SH2 as dc.w
- Complex coordinators with jump tables (func_001, func_002)
- Functions with external BSR calls requiring symbol resolution
- Any function where byte-perfect size matching is required
- **Safe to translate:** Self-contained leaf functions, small (26-32 bytes), no PC-relative data

### 17 SH2 Functions Not Yet Integrated
Source `.asm` files exist in `disasm/sh2/src/` but no `.inc` files generated:
- func_001, func_002 (coordinators — blocked by padding)
- func_009, func_010 (display list functions)
- func_060-063, func_067-068, func_074 (raster/utility)

Marked "translated" in SH2_3D_FUNCTION_REFERENCE.md but **NOT in the build system**.

### Translation Checklist
1. Test immediately after each function translation
2. Focus on leaf functions first (no BSR to external symbols)
3. Use `.short` format for BSR when external calls are needed
4. Verify assembled byte size matches expected before integration
5. Keep coordinators as dc.w if size-critical

---

## Hardware Hazards

### RV Bit — SH2 ROM Access Stalls
When RV=1 (68K ROM→VRAM DMA active), **ALL SH2 ROM access blocks** until 68K clears it.
- **Risk:** Expansion ROM at $02300000+ stalls during DMA transfers
- **Status:** Not yet profiled during gameplay (see [BACKLOG.md](BACKLOG.md) B-008)
- **Mitigation:** If confirmed, copy critical expansion code to SDRAM ($06xxxxxx)

### FM Bit — Immediate VDP Preemption
Writing FM=1 **immediately preempts** any ongoing 68K VDP access, even mid-transfer.
- **Risk:** VRAM/CRAM/VSRAM corruption if switched during active 68K VDP operation
- **Mitigation:** Only switch FM during V-Blank when VDP is idle
- **Hardware Manual:** "access authorisation is forced to switch to the SH2 side, even if access of VDP is in progress in the MEGA Drive side"

### COMM Register Races
Simultaneous writes from 68K and SH2 to the same COMM register = **undefined value**.
- COMM7 ($2000402E): Master→Slave signal (unidirectional — safe)
- COMM5 ($2000402A): Vertex transform counter (verify write direction)
- **Rule:** Never write the same COMM register from both CPUs simultaneously

### CMDINT vs Other Interrupts
Most interrupts (VRES, VINT, HINT, PWMINT) persist until explicitly cleared. CMDINT behaves differently:
- CMDINT is **negated when masked**, re-asserted when unmasked if condition still exists
- Acts as level-triggered with mask-sensitive behavior (reliable for queue signaling)
- Missing interrupt clear = handler fires only once, then stops (for non-CMD interrupts)
- Clear registers: VRES=$20004014, V=$20004016, H=$20004018, CMD=$2000401A, PWM=$2000401C

### Cache-Through Addressing for Shared Memory
Use `0x22XXXXXX` (cache-through), not `0x0XXXXXXX` (cached) for:
- System registers (COMM, control registers)
- VDP registers
- Any memory modified by another CPU or DMA
- Shared memory between Master/Slave SH2

Otherwise: stale cached values → subtle data corruption. Parameter block at $2203E000 already uses cache-through (correct).

### SH2 Interrupt Hardware Bug
Original SH2 silicon has a documented bug (see [32x-hardware-manual-supplement-2.md](docs/32x-hardware-manual-supplement-2.md)):
- FRT TOCR toggle required in every interrupt handler
- Only use interrupt levels 14, 12, 10, 8, 6
- 2+ cycle wait after interrupt clear before RTE
- No VDP access in H-interrupt during DMA

---

## Active Bugs

### FPS Counter Production Sampling Shows 00
**Status:** Parked (diagnostic mode works, production mode broken)
**Symptom:** Flip detection works — Test 1 showed counter incrementing (displayed 99). But production once-per-second sampling always produces `fps_value = 0`.
**Confirmed working:** `fps_vint_tick` increments correctly (diagnostic showed 99), epilogue is reached, ROM encoding verified byte-perfect.
**Likely cause:** Register corruption or addressing issue in the delta computation path (`fps_flip_counter - fps_flip_last → fps_value`).
**Files:** [fps_vint_wrapper.asm](disasm/modules/68k/optimization/fps_vint_wrapper.asm)

---

## 68K Section Space Constraints

### $00E200-$010200 Has 0 Bytes Free
The SH2 communication section is completely full. Any new 68K-side code must either:
1. Reclaim dead code within the section
2. Use a BSR trampoline to a section with space
3. Be implemented entirely on the SH2 side (expansion ROM)

Previous attempt to add async queue logic here was removed (commit 0dd98c4).

---

## Abandoned Approaches (Don't Re-Try)

| Approach | Why It Failed |
|----------|--------------|
| Code injection via `phase11_rom_patcher.py` | Reached space/alignment limits |
| 68K V-INT hook via BSR.W | Exceeded ±32KB range (actual distance: 85KB) |
| 68K in-section async queue | 0 bytes free in $E200 section, removed commit 0dd98c4 |
| SH2 optimization alone for FPS | 66.6% Slave reduction → 0% FPS change (68K is bottleneck) |
| func_065 FIFO batching | Fall-through control flow, can't restructure without breaking callers |
| func_017-019 optimization in isolation | Tightly coupled: shared code paths, cross-function branching |
