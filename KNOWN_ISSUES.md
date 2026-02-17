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

### Indexed vs Displacement Addressing — Easy to Confuse
- `dc.w $31BC,$0000,$2000` is **NOT** `move.w #$0000,$2000(a0)` (d16,An mode 5)
- It IS `move.w #$0000,(a0,d2.w)` (d8,An,Xn mode 6) — $2000 is the extension word
- Extension word $2000 = D2.W index register, displacement $00
- The disassembler may show these as `$2000(A0)` which is misleading
- **Rule:** When translating dc.w with 3+ words, decode the addressing mode bits before choosing mnemonic syntax

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
- Even 1-byte mismatch causes section overlap errors in the fixed ROM layout
- **Workaround:** Use `.short` raw hex opcodes instead of mnemonics (bypasses padding entirely)
- func_001 and func_002 were blocked by this but now integrated using `_short.asm` format

### When to Keep SH2 as dc.w
- Functions with external BSR calls requiring symbol resolution
- Any function where byte-perfect size matching is required
- **Safe to translate:** Self-contained leaf functions, small (26-32 bytes), no PC-relative data
- **For larger functions:** Use `.short` hex format with annotated comments

### All SH2 Functions Now Integrated
All 92 SH2 3D engine functions (func_000 through func_091, with gaps for non-existent numbers)
are integrated into the build system via `.inc` generated includes. Zero remaining.

### Translation Checklist
1. Test immediately after each function translation
2. Use `.short` format for functions with external BSR calls or alignment-sensitive code
3. Verify assembled byte size matches expected before integration

---

## Hardware Hazards

### RV Bit — SH2 ROM Access Stalls (RESOLVED — Not a Risk for VRD)
When RV=1 (68K ROM→VRAM DMA active), **ALL SH2 ROM access blocks** until 68K clears it.
- **Risk:** Expansion ROM at $02300000+ would stall during DMA transfers
- **Status:** RESOLVED (B-008, 2026-02-16) — VRD never sets RV=1. All DREQ_CTRL writes use `#$04` (68S mode only). The game uses manual FIFO feeding, not ROM-to-VRAM DMA. Expansion ROM is safe for SH2 execution at all times.
- **No mitigation needed.** SDRAM copy is unnecessary.

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

### COMM Register Mislabeling in Legacy Code
Two COMM registers were mislabeled as "COMM3" in different files:
- `comm_transfer_block.asm`: `$A15123` was called "COMM3" — actually **COMM1_LO** (COMM1 low byte). Fixed in 3b347d3.
- `adapter_init.asm`: `$A1512C` was called "COMM3" — actually **COMM6** (handshake flag). Fixed in 350e346.
- **Rule:** Always verify COMM register identity against the byte map: COMM0=$A15120, COMM1=$A15122, ..., COMM7=$A1512E. Byte access adds 0 (HI) or 1 (LO) to the word address.

### DREQ Registers Mislabeled as Bank Registers
`adapter_init.asm` originally labeled `$A1510A` as `ADAPTER_BANK` and `$A1510C` as `ADAPTER_BANKDAT`. These are actually **DREQ Source Address Low** and **DREQ Destination Address High** respectively (see 32X Hardware Manual §4.3).
- The code at adapter_init lines 117-126 configures DREQ, **not** ROM banking
- Fixed in this session: renamed to `ADAPTER_DREQ_SL` / `ADAPTER_DREQ_DH`
- **Actual bank register candidates:** `$A130F1` (Genesis standard, byte write) and `$A15104` (32X Bank Set Register, word write, bits 0-1)

### Bank Register Probe — Access Path Unresolved
A boot-time probe at [bank_probe.asm](disasm/modules/68k/optimization/bank_probe.asm) tests three 68K access paths to expansion ROM ($300000-$3FFFFF):
- **Direct** (`$300000`): Works if 32X maps full 4MB at $000000-$3FFFFF
- **Bank A** (`$A130F1`): Genesis standard bank register, bank 3 → $900000 window
- **Bank B** (`$A15104`): 32X Bank Set Register, bank 3 → $900000 window
- Results written to Work RAM `$FFFFF080` (28 bytes): signature "PROB", test values, winner code ('D'/'A'/'B'/'?'), completion marker $DEAD
- **Status:** Probe integrated into boot sequence, ROM builds. Awaiting PicoDrive test to read results.
- **Do not hardcode a bank register** until probe results confirm which path works

### SH2 Cannot Access 68K Work RAM — At ANY Address
The SH2 memory map (hardware manual §4.2) shows:
- `$0200 0000h` — SDRAM (256KB, ends at `$0203 FFFF`)
- `$0240 0000h` — **"-" (NOTHING)** — unmapped space
- `$0400 0000h` — Frame Buffer DRAM

68K Work RAM lives at 68K address `$FF0000-$FFFFFF`. There is **NO SH2 address** that maps to this region. Both `$02FFFB00` and `$22FFFB00` fall in the unmapped gap between SDRAM and Frame Buffer.

**Failed approaches (B-003 v1-v3):**
- `$22FFFB00` (cache-through) — unmapped, reads as garbage
- `$02FFFB00` (cached) — same unmapped region, same result
- `$06FFFB00` (SDRAM mirror on PicoDrive) — not documented, not portable

**Correct approach:** Use COMM registers ($20004020-$2000402E) for parameter passing between 68K and SH2. These 8 words are the ONLY always-accessible shared writable memory between the two CPUs.

**Rule:** NEVER use 68K Work RAM addresses in SH2 code. The only shared memory options are:
1. **COMM registers** (16 bytes, always accessible)
2. **SDRAM** ($0200 0000 - $0203 FFFF, both CPUs can access)
3. **Frame Buffer** ($0400 0000 / $2400 0000, access controlled by FM bit)

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

## SH2 Patch Design

### COMM7 Signal Namespace Collision — Don't Broadcast Game Commands

**Status:** Root cause of race-mode crash in B-006 activation (commits 651a415, 7bab6fc). **Fixed in B-003** (2026-02-14) by activating the async infrastructure correctly.

The `master_dispatch_hook` (B-006 Patch #2) was designed to write every game command byte to COMM7 so the Slave could "see" what the Master was dispatching. This is fundamentally wrong because **game command codes overlap with expansion ROM signal values**:

| Value | Game meaning | Expansion meaning | Collision? |
|-------|-------------|-------------------|------------|
| 0x01 | Frame init | Frame sync signal | **YES** |
| 0x16 | Vertex transform | Vertex transform signal | Skipped (by design) |
| 0x27 | Pixel region fill (21×/frame) | Queue drain signal | **YES — CRASH** |

The Slave's `slave_work_wrapper` interprets COMM7 values as expansion ROM signals. When the hook writes `COMM7 = 0x27` (from a normal game cmd), the Slave calls `cmd27_queue_drain`, which reads from uninitialized Work RAM at `$02FFFB00` — garbage pointers, widths, heights → writes to random memory → corruption → crash with stuck engine sound.

**Rules:**
1. **Never broadcast raw game command bytes to COMM7.** The game's command namespace and the expansion ROM's signal namespace are independent; conflating them causes collisions.
2. **Only write COMM7 from code that knows the Slave's signal protocol.** Currently: `sh2_cmd_27` async enqueue (COMM7=$0027 when queue has work).
3. **Don't activate signal consumers (queue drain) before their producers (async queue) exist.** Infrastructure without data = garbage processing.
4. **A dispatch hook that only dispatches is pointless overhead.** If the hook doesn't add behavior beyond what the original code does, don't have a hook.

**B-003 Implementation (Feb 2026):**
- 68K writes COMM7=$0027 ONLY from `sh2_cmd_27` enqueue (after queueing valid entry)
- Slave checks COMM7 in idle loop (expansion handler at $300700)
- Queue initialized to zero at boot (covered by Work RAM clear)
- No namespace collision: COMM7 is written by async producer, not by generic dispatch hook

**Fix:** Revert Patch #2 entirely. The original Master dispatch at `$02046A` works correctly. COMM7 signaling for cmd 0x16 is already handled by `shadow_path_wrapper` (Patch #3), which writes COMM7 only when vertex transform parameters are ready.

### B-006 Patch #2 Had Three Independent Bugs (Committed in 651a415)

The committed `master_dispatch_hook` trampoline at `$02046A` had three bugs beyond the COMM7 design flaw:

1. **R0 clobbered before hook reads it.** `D005` (MOV.L hook_addr,**R0**) overwrites the command byte that the hook needs. Fix: use R1 for the hook address (`D102`).

2. **Literal pool collision at `$020480`.** The hook's literal (0x02300050) was placed at `$020480`, which is also the target of `D011` at `$020438` (Master SH2 init code). This made the init code JSR to the hook address instead of `0x060045CC`. Fix: place literal at `$020474` (dead code area after the BRA), restore `$020480` to original value.

3. **COMM7 broadcast (the crash).** Described above. Writing every game command to COMM7 triggers uninitialized queue drain on the Slave.

**Lesson:** When patching SH2 code, always check whether literal pool addresses are shared by other `MOV.L @(disp,PC)` instructions in the surrounding code. SH2 literal pools are positional — moving code can silently redirect other instructions' data loads.

### SH2 Literal Pool Sharing — Verify Before Overwriting

SH2 `MOV.L @(disp,PC),Rn` instructions reference literal pools by PC-relative offset. Multiple instructions can share the same literal. When patching code, verify with:

```python
# Find all MOV.L @(disp,PC) that reference a given address
target = 0x020480  # address being overwritten
for addr in range(section_start, section_end, 2):
    opcode = read_word(addr)
    if (opcode & 0xF000) == 0xD000:  # MOV.L @(disp,PC),Rn
        disp = (opcode & 0xFF) * 4
        pc = (addr + 4) & ~3
        ea = pc + disp
        if ea == target:
            print(f"WARNING: ${addr:06X} also loads from ${target:06X}")
```

**Rule:** Before placing a literal at any address, scan the entire section for `$Dnxx` opcodes that resolve to that address.

### Slave SH2 Idle Loop at $0203CC — Context and Constraints

The original Slave idle loop at `$0203CC` is:
```
$0203CC: D101  MOV.L @(4,PC),R1   ; R1 = 0x2000402C (COMM6)
$0203CE: 2102  MOV.L R0,@R1       ; COMM6 = R0 (boot-complete signal)
$0203D0: AFFE  BRA $0203D0        ; Loop forever
$0203D2: 0009  NOP
$0203D4: 2000 402C               ; COMM6 address literal
```

This is a **terminal idle loop**, not the Slave's main dispatch. The Slave's rendering dispatch loop is at `$06000608` in SDRAM (confirmed by profiling hotspot at `$0600060A`). The Slave reaches `$0203CC` once during boot, writes a status value to COMM6, and spins forever. Rendering work arrives via **interrupts**, not by breaking out of this loop.

**Implication for Patch #1:** Replacing this loop with `slave_work_wrapper` (COMM7 polling) is safe for rendering — the interrupt-driven SDRAM dispatch continues to handle COMM1 commands. The COMM7 poll runs in the "background" (base level), and interrupts preempt it normally.

**Caution:** The COMM6 write at `$0203CE` may serve as a boot handshake. If the 68K or Master polls COMM6 to confirm Slave readiness, skipping this write could cause init-time issues. Current testing shows menus work without it, but the write should be preserved if possible. See [MASTER_SH2_DISPATCH_ANALYSIS.md](analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md) for the full control flow analysis.

### Master SH2 JMP vs JSR for Command Dispatch

Both work correctly for dispatching to command handlers, because SH2 handlers follow a strict save/restore PR convention:

**JSR dispatch (original):**
```
JSR @R0          ; PR = return_addr
                 ; Handler saves PR, does work, restores PR, RTS → return_addr
```

**JMP dispatch (hook):**
```
; Caller: JSR @R1 (sets PR = loop_BRA)
; Hook:   JMP @R0 (PR unchanged = loop_BRA)
;         Handler saves PR, does work, restores PR, RTS → loop_BRA
```

Both produce the same result: handler returns to the dispatch loop. The difference is which address is saved — but both point to BRA $020460 (loop back). **JMP is valid** as long as PR was set correctly by the caller's JSR.

**Exception:** If a handler is a leaf function that doesn't save PR AND also modifies PR (impossible for a true leaf), JMP would break. In practice all non-trivial handlers save/restore PR.

### Successful Async Pattern — sh2_cmd_27 via COMM Registers (B-003, Feb 2026)

**Works:** Direct parameter passing via COMM registers, bypassing Master SH2 entirely.

**Design:**
1. **68K sender** (`sh2_cmd_27` at $E3B4): Waits COMM7==0, writes params to COMM2-6, writes COMM7=$0027 (doorbell), waits COMM7==0 (ack)
2. **Slave inline drain** (SDRAM at $020608, 88 bytes): Checks COMM7, reads COMM2-6, clears COMM7, processes pixels with cache-through writes, loops back to check for more
3. No Master SH2 involvement, no Work RAM queue, no expansion ROM execution

**Key implementation details:**
- **COMM-only parameter passing:** data_ptr→COMM4+5 (move.l), width→COMM2, height→COMM3, add_value→COMM6. Uses ONLY documented shared memory (see "SH2 Cannot Access 68K Work RAM" above).
- **In-place 68K replacement:** 82-byte function body replaced with 50B COMM writes + 32B NOP padding. No section space needed, no register clobber (no MOVEM needed).
- **Two short waits:** WAIT#1 for previous entry (Slave processing time), WAIT#2 for Slave ack (~17 SH2 cycles to read params + clear COMM7). Much faster than original Master SH2 dispatch.
- **Cache-through conversion on SH2 side:** Slave converts data_ptr from $04xxxxxx → $24xxxxxx (OR with $20000000) to bypass SH2 data cache. Without this, pixel writes stay in cache and never reach DRAM.
- **Inline SDRAM execution:** All Slave drain code runs from SDRAM at $020608 (128-byte slot replacing original delay loop). PicoDrive cannot execute Slave code from expansion ROM ($02300000+).
- **COMM conflict safety:** WAIT#2 ensures Slave has read all params before RTS. No other command can overwrite COMM2-6 while Slave is still reading them.
- **Re-entrancy:** After processing, Slave BRAs back to COMM7 check — picks up next entry immediately if 68K wrote one during processing.

**Tested:** Boots and runs in PicoDrive. Menu highlights, records/options, race mode all working.

**Files:**
- [code_e200.asm](disasm/sections/code_e200.asm) lines 313-346 (68K sh2_cmd_27)
- [code_20200.asm](disasm/sections/code_20200.asm) lines 534-580 (SH2 inline drain dc.w)
- [inline_slave_drain.asm](disasm/sh2/expansion/inline_slave_drain.asm) (SH2 source)

**Previous failed approaches (v1-v3):** Used Work RAM ring buffer ($FFFB00) readable from SH2 — impossible because SH2 cannot access 68K Work RAM. See "SH2 Cannot Access 68K Work RAM" and Abandoned Approaches table.

---

## Active Bugs

### B-006 Race-Mode Crash (All Patches Reverted)
**Status:** FIXED — all 3 B-006 patches reverted to original game code (2026-02-11)
**Symptom:** ROM boots, menus work, crashes with stuck engine sound when entering race mode.
**Root cause:** Multiple interacting issues. Patch #2 (COMM7 broadcast) was the primary cause, but reverting Patch #2 alone was insufficient — Patches #1+#3 together also produced the same crash. Likely causes: shadow_path_wrapper's COMM7 barrier deadlocks the Master (blocks waiting for Slave to clear COMM7), and/or parallel func_021 execution on both CPUs creates data races on shared output buffers.
**Fix:** Full revert of all 3 patches. Original game code restored at $0203CC, $02046A, $0234C8.

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
3. **Replace existing function bodies in-place** (used for B-003: sh2_cmd_27's 82-byte body replaced with 68B async enqueue + 14B padding)
3. Use a banked-call trampoline to expansion ROM at $300000+ (see bank_probe results)

Previous attempt to add async queue logic here was removed (commit 0dd98c4).

### Expansion ROM — 68K Access via Banking (Pending Confirmation)
ROM $300000-$3FFFFF (~1MB, 99.9% free) is accessible to the 68K via banking or possibly direct access. Once `bank_probe` results confirm the access path, heavy 68K logic can be relocated here using fixed-window trampolines (see [bank_call.asm](disasm/modules/shared/bank_call.asm) for patterns). This solves the B-001 space blocker.

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
| COMM7 broadcast of game commands via dispatch hook | Game cmd bytes (0x01, 0x27) collide with expansion signal values → Slave processes uninitialized queue → crash. See §COMM7 Signal Namespace Collision above. |
| Placing Patch #2 literal at $020480 | Shared by D011@$020438 (init code). Silently redirects init JSR to hook address. Always scan for $Dnxx refs before overwriting. |
| Fully async general commands ($22/$25/$2F/$21) | Buffer aliasing: 68K overwrites shared data buffers before Slave replays COMM protocol. Menu graphics corrupt, race timer runs at wrong speed. COMM replay mechanism confirmed working (race 3D scene rendered). Infrastructure kept dormant at $301000. Needs per-call-site data dependency analysis before selective async activation. |
| Work RAM ring buffer for SH2 queue ($FFFB00) | SH2 CANNOT access 68K Work RAM at ANY address. $02FFFB00 and $22FFFB00 are both in unmapped space (past SDRAM at $0203FFFF, before Frame Buffer at $04000000). Three attempts failed before reading the hardware manual. **Use COMM registers or SDRAM for 68K↔SH2 shared data.** |
