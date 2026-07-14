# VR60 Phase 1 — cmd $3E ACK Hang Root-Cause Analysis

**Date:** 2026-07-13
**Role:** Worker, read-only research. No asm/source/Makefile modified except this document.
**Scope:** Why does `jsr vr60_entity_transfer` (cmd $3E, DREQ entity transfer) hang the game
when added to `vr60_1p_staging_hook` (1P interactive racing, state 8 of
`state_disp_004cb8`), when the same function is claimed to work from `state4_epilogue`
in the 2-player dispatcher (`state_disp_005020`)?

**Bottom line up front:** static analysis found **one concrete, citable bug** in
`cmd3e_entity_transfer.asm` (wrong-width DMAOR write — §3), but it does **not**, by
itself, explain a hang specifically at the 68K's `.wait_ack` spin, because the ACK write
in the SH2 handler executes unconditionally regardless of DMAC arm status. Critically,
**the premise that this code "works in 2P" is itself unverified** — `VR60_ROADMAP.md:33`
states explicitly "2P is the only one already wired (**and unvalidated itself — no 2P
profiling run exists**)." This investigation could not find a causal chain that is
*specific to the 1P calling context*; every difference found is either (a) present in
both contexts, or (b) unproven to differ. Section 5 ranks hypotheses and Section 6
proposes the cheapest empirical tests to disambiguate.

---

## 1. COMM register rules relevant to this handshake

Source: `analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md` (full read).

| Rule | Citation | Relevance to cmd $3E |
|---|---|---|
| Read-during-write between 68K/SH2 on the same register is **undefined** (not just write-write) | `COMM_REGISTERS_HARDWARE_ANALYSIS.md:137-151` | The 68K writes COMM0_LO then COMM0_HI while the Master SH2's `poll_wait` loop continuously reads COMM0_HI. This hazard exists for **every** COMM0 trigger in the game (cmd $02, $3E, $3F, …), not uniquely for 1P's cmd $3E call site. It cannot explain a *consistent, 100%-reproducible* hang by itself (undefined ≠ always-fails), but is flagged as a background risk. |
| SH2 writes are buffered; a dummy read is needed to force the write to the physical register immediately | `COMM_REGISTERS_HARDWARE_ANALYSIS.md:165-195` | `cmd3e_entity_transfer.asm` does not dummy-read after its ACK write (`mov.b r0,@(3,r8)` at offset 36, no follow-up read). This can add latency but the 68K's tight polling loop (`.wait_ack`) will still observe the value once flushed — not an infinite-hang mechanism by itself. |
| Always use cache-through (`$20004020`) for SH2 COMM access | `COMM_REGISTERS_HARDWARE_ANALYSIS.md:199-212` | `cmd3e_entity_transfer.asm:24` uses `R8 = $20004020` (entry convention, set by dispatch loop) — correct, cache-through. Not implicated. |
| COMM1 is a system signal register; COMM1_LO bit 0 = "done", the hardware ALSO reuses **COMM1_LO bit 1 as "ACK/FIFO ready"** for `dmac_fifo_setup`-style protocols | `COMM_REGISTERS_HARDWARE_ANALYSIS.md:324-356`, confirmed in code (§2, §3 below) | Bit 1 is **shared** across every DREQ-based command in the game (cmd $02's `mars_dma_xfer_vdp_fill`, cmd $01/$04/$05's `dmac_fifo_setup`, and VR60's cmd $3E). All of them use the identical `btst #1,COMM1_LO / beq.s .wait / bclr #1,COMM1_LO` 68K-side idiom. This is a **shared namespace**, but every user immediately consumes (clears) the bit itself, so a stale bit from an earlier command should not be visible to a later command's wait loop (§4). |
| COMM7 is the Slave doorbell; never broadcast game command bytes to it | `COMM_REGISTERS_HARDWARE_ANALYSIS.md:431` | Confirmed **not** in play here: the historical `master_dispatch_hook` that did this (`disasm/sh2/expansion/master_dispatch_hook.asm`) is **DORMANT / B-006-reverted** — see §2. The live dispatch loop is the original, unpatched game code. |

**Verdict on §1:** the general COMM hazards are real but pre-exist cmd $3E and are shared by
cmd $02, which fires every single racing frame in 1P without observed failure. None of the
generic hazards is 1P-specific.

---

## 2. Master SH2 cmd $3E dispatch — traced end to end

### 2.1 Dispatch loop is the original, unpatched code

The dispatch loop lives at SH2 `$06000460` (`disasm/sh2/3d_engine/master_command_loop.asm`,
mirrored byte-for-byte in `disasm/sections/code_20200.asm:307-330`). Confirmed **unpatched**://
`code_20200.asm:321-322` explicitly documents `master_dispatch_hook` (which would have
broadcast every command byte to COMM7 — the exact anti-pattern in B-006) as **"REVERTED —
master_dispatch_hook caused COMM7 signal collision crash"**, and `expansion_300000.asm:37`
confirms the hook's status as **"DORMANT (B-006 reverted)"**. So cmd $3E dispatches through
the plain, original loop with no interception.

**Documentation bug found in passing (not the root cause, but worth fixing):** both
`master_command_loop.asm:69` and `SH2_COMMAND_DISPATCH.md:47` label the instruction at
`$020468` (`dc.w $8481`) as `mov.b @(1,r8),r4`. Decoding the raw opcode: `$8481` =
`1000 0100 1000 0001` = SH2 format `1000 0100 mmmm dddd` (`MOV.B @(disp,Rm),R0` — this
opcode class is hard-wired to target **R0**, not an arbitrary register, per the SH2 ISA
byte/word-load restriction already noted in `COMM_REGISTERS_HARDWARE_ANALYSIS.md:90-97`).
The actual destination is **R0**, overwriting the trigger byte with the command byte
before the `shll2 r0` dispatch shift — which is what makes the dispatch arithmetically
correct in the first place. The `R4` label in both docs is simply wrong; it does not
affect behavior, since the raw `dc.w` bytes (guaranteed-accurate per file header) are
correct.

### 2.2 Jump table entry for cmd $3E is correctly wired

Jump table base is SDRAM `$06000780` (`master_command_loop.asm:96`, `SH2_COMMAND_DISPATCH.md:30`).
Entry index `$3E` (×4 = offset `$F8`) is stored at SDRAM `$06000878` = ROM file offset
`$020878` (SDRAM mapping rule, CLAUDE.md §9). Confirmed in `code_20200.asm:834-835`:

```
dc.w $0230 ; $020878  cmd $3E → expansion ROM $023016B0 (VR60 Phase 7: shifted)
dc.w $16B0 ; $02087A
```

This resolves to SH2 address `$023016B0`, which **is** where `cmd3e_entity_transfer` actually
lives in `expansion_300000.asm` (`:441` `dcb.b ($3016B0 - *),$FF` immediately precedes the
`cmd3e_entity_transfer:` label at `:442`). Two adjacent comments in `expansion_300000.asm`
are **stale** (`:57` says "0x301600…" and `:437` says "…= $023015B0") — leftover from before
a Phase 7 shift — but the padding directive and the jump-table dc.w bytes agree with each
other and are the ground truth. **Confirmed: routing to the handler is correct; this is a
comment-staleness issue, not a functional bug.**

### 2.3 cmd3e_entity_transfer handler body (full trace)

Source: `disasm/sh2/expansion/cmd3e_entity_transfer.asm:32-153`.

| Step | Code | Effect |
|---|---|---|
| 1 | `mov.b @(6,r8),r0` | R0 = COMM3_HI (mode byte: 0/1/2) |
| 2 | `tst/bf` chain | Branches to one of 3 blocks (mode 0/1/2) — all converge at `.configure_chcr` |
| 3 | `mov.l @(.dmac_sar0,pc),r1` / `mov.l @(.fifo_addr,pc),r0` / `mov.l r0,@r1` | SAR0 = `$20004012` (FIFO data port) |
| 4 | same pattern for DAR0 | DAR0 = mode-selected destination (`$0600F20C` mode 0, `$0600F30C` mode 1, `$06010000` mode 2) |
| 5 | same pattern for TCR0 | TCR0 = mode-selected hardcoded count (`$A0`/`$20`/`$780`) |
| 6 | `.configure_chcr:` — `mov.l @(.dmac_chcr0,pc),r1` / `mov.l @(.chcr_value,pc),r0` / `mov.l r0,@r1` | CHCR0 = `$000014E5` (full **longword** store) |
| 7 | `mov.l @(.dmac_dmaor,pc),r1` / `mov #1,r0` / **`mov.w r0,@r1`** | DMAOR ← 1 (**16-bit** store — see §3, this is the bug) |
| 8 | `mov.b @(3,r8),r0` / `or #2,r0` / `mov.b r0,@(3,r8)` | **ACK: COMM1_LO |= bit 1 — unconditional, no check of DMAC/DMAOR state** |
| 9 | `.wait_done:` poll `$20004010` (DREQ_LEN, SH2-side alias) until 0 | Waits for 68K to finish pushing all words into the FIFO |
| 10 | Clear COMM0_HI | idle signal |

**Key structural fact for root-causing the hang:** step 8 (the ACK the 68K's
`.wait_ack` loop is spinning on) happens **before** step 9, and is **not conditioned on**
whether the DMAC actually armed in steps 6-7. So even if the DMAC never
starts a real transfer (§3), this code as written would still set the ACK bit. A pure
DMAC-arming bug should manifest as a hang **later** (in `.wait_done` on the SH2 side, or as
68K-side backpressure once it starts pushing to a FIFO that nothing drains — see §5,
Hypothesis A) — not as "ACK never appears," unless the SH2 fails to reach step 8 at all
(crashes/traps earlier) or the 68K is observed hanging somewhere the plan's background
notes did not actually pinpoint (see §6).

---

## 3. DMAC channel 0 conflict with cmd $02 (render DMA) — confirmed bug found, impact undetermined

### 3.1 cmd $02 also drives DMAC channel 0, via the same COMM1_LO-bit-1 ACK protocol

`mars_dma_xfer_vdp_fill.asm:17-26` (68K side, called at **state 0** of `state_disp_004cb8`,
`state_disp_004cb8.asm:40`, i.e. 2 V-INTs before state 8 fires in the SAME one-state-per-V-INT
race dispatcher):

```asm
move.w  #$0500,MARS_DREQ_LEN
move.b  #$04,MARS_DREQ_CTRL+1
move.b  ($FFFFC8A9).w,COMM0_LO          ; command code ($02, per CLAUDE.md $C8A8=$0102 convention)
move.b  ($FFFFC8A8).w,COMM0_HI          ; trigger
.wait_ack:
        btst    #1,COMM1_LO
        beq.s   .wait_ack
        bclr    #1,COMM1_LO
```

This is **byte-for-byte the same handshake idiom** as `vr60_entity_transfer.asm` — same
registers (`MARS_DREQ_LEN`, `MARS_DREQ_CTRL+1`, `COMM0_LO/HI`, `COMM1_LO` bit 1). This
confirms COMM1_LO bit 1 is a **shared ACK channel** used by cmd $02 every single racing
frame (state 0) and by cmd $3E in the modified state 8 — in the **same** one-state-per-V-INT
dispatcher, 2 V-INTs apart. However, since `mars_dma_xfer_vdp_fill` is fully synchronous
(the 68K blocks in its own `.wait_ack` until the SH2 handles it, and the SH2 side's own
completion sequence — see `SH2_COMMAND_HANDLER_REFERENCE.md:34-37` — clears COMM0_HI before
returning to the poll loop) — by the time state 8 runs, the Master should be idle again.
This matches the audit's own empirical observation (`VR60_IMPLEMENTATION_AUDIT.md` and the
task background: COMM0/COMM1 read `0x0` at every state-8 entry in the known-safe build).
**This rules out a simple "COMM0 still busy from state 0" race**, confirming the plan's own
prior conclusion.

### 3.2 The actual DMAC-configuring code for cmd $02 was not locatable in this pass

`analysis/sh2-analysis/SH2_COMMAND_HANDLER_REFERENCE.md:22,81-87` documents cmd $02's handler
(`$06000CFC`, "Scene Orchestrator") only at a high level ("Contains BSR calls to entity loop
callers… Dispatches entity rendering via function pointers") and does **not** list it as a
caller of the shared `dmac_fifo_setup` subroutine (`:208`, callers listed as "$01, $04, $05"
only) — yet the 68K side (`mars_dma_xfer_vdp_fill`) unmistakably performs a DREQ+ACK
handshake for cmd $02. **This means cmd $02's SH2 handler has its own, separate inline DMAC
configuration + ACK code, not yet disassembled in this repository's checked-in analysis.**
This is a genuine gap: I could not verify by reading the SH2 opcodes whether cmd $02's own
DMAOR write is correct (longword) or shares the same bug class as cmd $3E's. Given cmd $02
demonstrably works every racing frame in 1P with no hang, its DMAC/ACK code — whatever it is
— must be functionally sound, so it is **not itself evidence of a defect**, but I flag its
absence from the disassembly as a documentation gap that should be closed before further
VR60 DMAC work (see §6, recommended follow-up but not the priority empirical test).

### 3.3 Concrete bug found: cmd3e_entity_transfer's DMAOR write is the wrong access width

The **original, proven-working** SH2 routine that performs this exact "arm DMAC channel 0 +
set ACK" sequence is `func_088` / `struct_init_short`, SH2 address `$06004448` (ROM file
offset `$024448`), documented as `dmac_fifo_setup`, used by handlers $01, $04, $05
(`SH2_COMMAND_HANDLER_REFERENCE.md:208`). Its full disassembly, decoded from the actual
`build/vr_rebuild.32x` bytes, is in `disasm/sh2/3d_engine/struct_init_short.asm:23-40`
(mirrored in `disasm/sections/code_24200.asm:171-186`). The relevant tail:

```asm
D007        /* MOV.L @(28,PC),R0 → $00000001 */
180C        /* MOV.L R0,@(48,R8)  ← R8 = $FFFFFF80 (SAR0), so R8+48 = $FFFFFFB0 = DMAOR */
```

`0001nnnnmmmmdddd` (`$180C`, n=8, m=0, disp=12→×4=48) is the SH2 **MOV.L Rm,@(disp:4,Rn)**
encoding — an unambiguous **32-bit (longword) store** of `$00000001` to DMAOR.

Compare `cmd3e_entity_transfer.asm:94-97`:

```asm
mov.l   @(.dmac_dmaor,pc),r1
mov     #1,r0
mov.w   r0,@r1          /* <-- 16-bit store, not mov.l */
```

**This is a real, verifiable divergence from the codebase's own established, working
pattern for the identical register**, and it matters because of documented SH2/32X hardware
facts:

- DMAOR is a 32-bit register; **"DMAOR is written as a 32-bit value, including the upper 28
  bits… These bits always read 0"** (`docs/sh7604-hardware-manual.md:4147,4149`).
- The only valid/live bits (PR, AE, NMIF, **DME**) are bits 3-0 — i.e. entirely inside the
  **lower** 16 bits of the 32-bit register (`docs/sh7604-hardware-manual.md:4134-4142`).
- The SH2 is **big-endian**. A `mov.w` store to a register's *base* address writes the
  **upper** 16 bits (bits 31-16) of that 32-bit location, not the lower 16 bits where DME
  lives. `cmd3e_entity_transfer.asm`'s `mov.w r0,@r1` (r1 = DMAOR base, `$FFFFFFB0`) therefore
  writes `$0001` into the reserved-and-hardwired-to-0 upper half, and **never touches DME**
  (bit 0) at all.
- **"A DMA transfer becomes enabled when the DE bit in the CHCR and the DME bit are set to
  1"** (`docs/sh7604-hardware-manual.md:4174`). If DME is not 1 at this moment, **the DMAC
  will not start the transfer**, regardless of what CHCR0/DE say.

**Confirmed by reading code: this is a bug** — a deviation from the codebase's own working
idiom for the same register, consistent with the datasheet's explicit width requirement.

### 3.4 Why this bug's *impact on the observed hang* is undetermined, not confirmed

Two facts limit how much weight this bug alone can bear as "the" root cause:

1. **DME is a single global enable bit for all DMAC channels** (`docs/sh7604-hardware-manual.md:4174`:
   "Enables or disables DMA transfers **on all channels**"), not per-channel, and nothing in
   the codebase searched (`grep` across `disasm/sh2/`) clears DMAOR back to 0 after it is
   first set. Scene init (cmd $01, `$060008A0`) calls the correctly-implemented
   `dmac_fifo_setup` at least once per race
   (`SH2_COMMAND_HANDLER_REFERENCE.md:57-66`), and 1P's own scene-init routine
   (`race_scene_init_004a32.asm:42-43`) does trigger COMM0/cmd $01 before racing begins
   (`race_scene_init_004a32.asm:104`: `jsr sh2_handler_dispatch_scene_init+98`). **If DME is
   already 1 (sticky) by the time state 8 first fires cmd $3E, the bug in §3.3 is latent/
   inert** — CHCR0's own DE bit (correctly set via `mov.l`, step 6 in §2.3) would be
   sufficient to arm the channel, and the flawed DMAOR write would be a harmless no-op.
2. Even if DME were somehow 0 and the transfer failed to arm, **the ACK write (§2.3 step 8)
   still executes unconditionally** in the code as written — so a DME-arming failure predicts
   a **downstream** hang (FIFO backpressure on the 68K's block-copy push, or the SH2's own
   `.wait_done` spin never seeing DREQ_LEN reach 0), not specifically "the 68K never sees the
   ACK." The task's background description of the symptom ("busy-waits… for the ACK…
   apparently never arrives") is an inference from the overall freeze (`$C87E` stuck at 8),
   not a value confirmed via a targeted watch of COMM1_LO **during the actual hang** — the
   only COMM0/1 watch described in the background was captured in the **known-safe build
   without `vr60_entity_transfer`**, before the trigger the plan is asking about even exists
   in that build. **This is a genuinely open, empirically-resolvable gap — see §6.**

### 3.5 A related, definitely-real inconsistency (probably not the cause, but a code-quality bug worth fixing regardless)

Unlike its siblings, `vr60_entity_transfer.asm` (mode 0) **never explicitly sets COMM3_HI**
before triggering cmd $3E — it relies on COMM3_HI already being 0 from a previous clear.
Compare:

- `vr60_globals_transfer.asm:31-32`: `move.b #$01,COMM3` (mode 1, explicit)
- `vr60_ai_entity_transfer.asm:31-32`: `move.b #$02,COMM3` (mode 2, explicit)
- `vr60_entity_transfer.asm`: **no COMM3 write at all** (mode 0 assumed by omission)

`grep` across `disasm/modules/68k/` for `COMM3` (excluding VR60 files) found no other write
site (`adapter_init.asm` and `ring_buffer_init.asm` reference COMM3 only in comments/dead
boot-time notes, not live code paths active during racing). So on the *very first* call in
a fresh race (COMM3_HI zeroed since boot, never written by anything else), mode 0 is
correctly selected by default. This is a real robustness bug (silently wrong if anything
ever writes COMM3 between races, or if call order changes), but as analyzed in §2.3, a wrong
*mode* selects a wrong DAR0/TCR0 pair — it does **not** skip the unconditional ACK write,
so it cannot explain an ACK-never-appears symptom either. Flagged for the eventual fix list,
not ranked as a hang cause.

---

## 4. 2P (working, allegedly) vs 1P (hanging) calling context — compared precisely

| Aspect | 2P (`state_disp_005020` / `state4_epilogue`) | 1P (`state_disp_004cb8` / `game_frame_orch_013` / `vr60_1p_staging_hook`) | Same or different? |
|---|---|---|---|
| Dispatcher shape | Linear, all-states-every-frame (VR60 Phase 8 rewrite) — `state_disp_005020.asm:16,45` (`VR60_DISPATCHER_ROUTING.md:134,220`) | One-state-per-V-INT jump table, unmodified legacy shape — `state_disp_004cb8.asm:25-38` | **Different dispatch cadence**, but cmd $3E's own handler code is identical either way — see below. |
| Call site relative to state-0 DMA | `state4_epilogue` runs at whatever cadence the linear dispatcher reaches state 4 (every frame, since all states run every frame) | `game_frame_orch_013` (state 8) runs 2 V-INTs after state 0's `mars_dma_xfer_vdp_fill` (both dispatchers share the same "state 0 = DMA, some later state = heavy frame" pattern, `VR60_DISPATCHER_ROUTING.md:174-178`) | Structurally analogous; no evidence the *timing* relative to cmd $02 differs in a way that matters (§3.1: cmd $02 is fully synchronous and self-completing before returning). |
| Does state 8 run `vr60_entity_transfer` on a scene-init frame vs. a steady-state frame? | Not verified — no 2P playtest exists (`VR60_ROADMAP.md:33`) | The gate is `$C8D2` (`state4_epilogue.asm:158-159`, shared with the 1P flag question — actually 1P's hook uses its **own** flag `VR60_1P_FLAG = $FFFFF7B40`, `vr60_1p_staging_hook.asm:22-26`, deliberately *not* reusing `$C8D2` per the header comment, to avoid the exact stale-namespace collision documented for `$C8D2` in `VR60_IMPLEMENTATION_AUDIT.md`'s "Safety check" section) | 1P's flag hygiene is actually **better** than 2P's own `$C8D2` gate (which is a **repurposed pre-existing game variable**, per `VR60_IMPLEMENTATION_AUDIT.md:118-122` — "a pre-existing *original-game* variable… VR60 repurposed this address as its control flag… a namespace-collision fragility"). If anything this cuts the other way: 1P's flag is cleaner, so a flag-collision explanation for 1P-only failure is **not supported**. |
| Does 2P's own dispatcher do anything to DMAC/COMM0 that 1P's doesn't, immediately before the trigger? | `gfx_2_player_entity_frame_orch` (2P-only block copy, `state_disp_005020.asm:51`) runs before `state4_epilogue` in the same linear pass | `race_entity_update_loop` (`game_frame_orch_013.asm:56`) runs before the hook — this is **68K-only entity physics/AI update code** (no SH2/COMM/DMAC touch found in scope of this pass; not fully re-audited byte-for-byte here) | **Unresolved similarity check** — I did not fully disassemble `gfx_2_player_entity_frame_orch` in this pass to compare against `race_entity_update_loop`'s SH2 footprint; flagged as a gap. Given cmd $02's state-0 DMA is the only confirmed DMAC/COMM1-bit-1 user common to both paths, and it behaves identically in both dispatchers, no *differential* DMAC hazard was found — but this is not exhaustively ruled out. |
| Has cmd $3E's ACK protocol ever actually been exercised in *either* context on real hardware/emulator? | **No** — `VR60_ROADMAP.md:33`: "2P is the only one already wired (and unvalidated itself — no 2P profiling run exists)." The "3600-frame autoplay… no crashes" Phase 3 acceptance results (`VR60_ROADMAP.md:647-663`) were measured via the project's standard autoplay harness, which `VR60_IMPLEMENTATION_AUDIT.md` independently proved **always plays 1P** and **never dispatches through `state_disp_005020`** — i.e. those "PASS" results structurally could not have exercised cmd $3E/$3F at all, by the same logic the audit already applied to cmd $3F. | **This is the single most important finding of this section.** The premise "cmd $3E works in 2P" that motivated calling it "safe to reuse" from 1P has **no supporting empirical evidence** in the repository. The current 1P integration attempt may be the **first time this handler has ever actually run under real game timing**, in any mode. |

**Conclusion of §4:** No positively-identified, citable difference between the 1P and 2P
calling contexts was found that would explain a context-*specific* ACK failure. The
strongest, best-supported explanation reframes the question: this may not be "why does it
work in 2P but not 1P" but **"this code has never been proven to work at all, and 1P is the
first real exercise of it."** That reframing is consistent with (a) the DMAOR width bug in
§3.3 being a genuine, previously-undiscovered defect, and (b) the project's own established
pattern of this exact class of mistake (cmd $3F was integrated and believed "active" for
months while structurally unreachable — `VR60_IMPLEMENTATION_AUDIT.md`).

---

## 5. Ranked hypotheses

| Rank | Hypothesis | Status | Supporting evidence | Why it might NOT be sufficient alone |
|---|---|---|---|---|
| 1 | **`cmd3e_entity_transfer.asm`'s DMAOR write never sets DME**, because of a wrong access width (`mov.w` instead of `mov.l`), and *some* precondition (DME not yet globally latched at this exact point in the 1P timeline, or CHCR0's stale **TE bit** blocking re-arm — `docs/sh7604-hardware-manual.md:4072`: "When the TE bit is set, setting the DE bit to 1 will not enable a transfer") prevents the transfer from starting, and the 68K actually hangs **later** than `.wait_ack` (in the FIFO-push loop, on 32X hardware backpressure) rather than at the ACK spin itself — meaning the symptom description in the task background ("ACK never arrives") is an approximation of a freeze whose exact PC was never directly observed. | **Confirmed bug (§3.3), unconfirmed as root cause of *this* hang** | Real, cited divergence from the codebase's own working pattern for the same register; datasheet-documented behavior for both DME and TE. | DME is very likely already globally latched by scene-init's correct `dmac_fifo_setup` call before racing begins, in both 1P and 2P (§3.4) — would make the bug latent, not causative, *unless* something clears DMAOR between scene init and state 8 (not found). |
| 2 | **Cmd $3E has never actually been validated in any real execution context** (§4) — the current 1P wiring is the first genuine end-to-end exercise, and any of the above (or an as-yet-undiscovered defect elsewhere in the 96-byte handler, e.g. the literal-pool offsets, or an SH2 exception from some other cause) is simply being seen for the first time. | **Best-supported framing overall** | `VR60_ROADMAP.md:33` (2P unvalidated), `VR60_IMPLEMENTATION_AUDIT.md` (identical mis-validation pattern already proven once for cmd $3F). | Doesn't by itself name a mechanism — it's a meta-finding that should lower confidence in "it definitely used to work," not a standalone technical cause. |
| 3 | Generic COMM0 read-during-write hazard (§1) coincidentally manifesting only under 1P's V-INT timing. | Plausible in principle, unproven | Documented hardware hazard (`COMM_REGISTERS_HARDWARE_ANALYSIS.md:137-151`). | Same hazard exists for cmd $02 every single 1P racing frame with no observed failure; a hazard that is "undefined" but empirically reliable for one caller and unreliable for another, with no different code path, has no mechanism offered here. Lowest-ranked. |
| 4 | An SH2 exception/trap inside `cmd3e_entity_transfer` before reaching the ACK write (e.g., from the DMAOR/CHCR writes, if the CPU faults rather than silently mis-writing) that leaves the Master SH2 in a broken state that **also stops servicing COMM0 for all future commands** — consistent with "`$C87E` frozen forever," not just this one command timing out. | Speculative, not confirmed | SH2 requires aligned accesses, but the addresses/widths involved (`mov.w` to a 4-byte-aligned register) are not misaligned by SH2's own alignment rules, so a hard address-error trap is unlikely on this specific instruction; no exception vector table for expansion-code faults was located in this pass. | No corroborating exception-vector evidence found; ranked low without further check. |

---

## 6. Recommended empirical tests (cheapest first)

Static analysis cannot resolve **which** hypothesis is correct without runtime data,
specifically because the ACK-write-is-unconditional fact (§2.3) means the DMAC bug (§3.3)
and the "ACK never appears" symptom are not obviously the same failure unless directly
observed together.

**Test 1 (cheapest, highest information value) — pinpoint exactly what freezes and where:**
Re-enable `jsr vr60_entity_transfer` in `vr60_1p_staging_hook.asm` and run with a
combined watch of the COMM registers, the DREQ length register, and the DMAC control
register, using the tools documented in `tools/libretro-profiling/VRD_PROFILING.md:28-30`:

```
VRD_SCENE=0x4CBC VRD_WATCH=0xA15120:2,0xA15122:2,0xA15126:2,0x20004010:2 \
  VRD_WATCH_LOG=cmd3e_hang.csv \
  ./profiling_frontend ../../build/vr_rebuild.32x 300 --autoplay
```

(`0xA15120`=COMM0 word, `0xA15122`=COMM1 word, `0xA15126`=COMM3 word, `0x20004010`=DREQ_LEN
SH2-side address — confirm the harness can address SH2-side registers; if not, watch the
68K-side `MARS_DREQ_LEN`/`MARS_DREQ_CTRL` mirror instead). This directly answers:

- Does COMM1_LO bit 1 **ever** get set after the trigger (refutes/confirms "ACK never
  arrives" as literally true, vs. the game freezing *after* a real ACK, e.g. on FIFO
  backpressure)?
- Does COMM3_HI read as `$00` (mode 0, as assumed) at trigger time, or something else
  (confirms/refutes §3.5)?
- Does DREQ_LEN ever decrement from `$00A0` (confirms/refutes whether the 68K's FIFO pushes
  are even reached, which bounds where the freeze physically occurs)?

**Test 2 (if Test 1 shows the ACK genuinely never sets) — capture Master SH2 PC/state at
the freeze:** use `VRD_DUMP_FRAME=<hang frame>` with `VRD_DUMP=0x023016B0:96` (the handler's
own code+literal-pool region) per the `VRD_DUMP` syntax in `VRD_PROFILING.md:30,59`, plus, if
the harness exposes SH2 PC/register state at all (check `VRD_PROFILING.md` for an SH2-side
trace facility — not confirmed present in the excerpt read), capture where the Master SH2's
program counter is parked. This would directly confirm or refute Hypothesis 4 (stuck/crashed
SH2) versus Hypothesis 1/2 (SH2 returns fine, but downstream FIFO/DMAC state is wrong).

**Test 3 (targeted fix-and-retest, cheap, but conflates variables if done first) — patch
only the DMAOR write width** (`mov.w r0,@r1` → `mov.l r0,@r1` in `cmd3e_entity_transfer.asm`,
matching `struct_init_short.asm`'s proven pattern) and re-run the 1800-frame autoplay. If the
hang disappears, Hypothesis 1 is confirmed as sufficient (regardless of the theoretical
"should still ACK" concern in §3.4 — real hardware/emulator behavior would settle the
argument). If it does not disappear, Hypothesis 1 is refuted as *sufficient* (though it
should still be fixed as a latent bug per §3.3). **This test should follow, not replace,
Test 1** — per the plan's own Ground Rules ("test patches in isolation," CLAUDE.md §10),
and because fixing a bug without first confirming what it does empirically would leave the
actual mechanism undocumented even if the hang happens to go away.

---

## 7. Summary table (confirmed vs. hypothesis vs. unresolved)

| Status | Finding |
|---|---|
| **Confirmed by reading code** | Dispatch loop is unpatched original code; `master_dispatch_hook` (COMM7-broadcast anti-pattern) is dormant/reverted (§2.1). |
| **Confirmed by reading code** | Jump table entry for cmd $3E correctly resolves to `cmd3e_entity_transfer` at `$023016B0`; two nearby comments are stale but the functional wiring is correct (§2.2). |
| **Confirmed by reading code** | The ACK write in `cmd3e_entity_transfer` is unconditional — not gated on DMAC arm success (§2.3). |
| **Confirmed by reading code** | `cmd3e_entity_transfer.asm`'s DMAOR write uses `mov.w` (16-bit) where the codebase's own proven-working equivalent (`struct_init_short`/`dmac_fifo_setup`) uses `mov.l` (32-bit) for the identical register — a genuine, citable bug against SH7604 datasheet requirements (§3.3). |
| **Confirmed by reading code** | `vr60_entity_transfer.asm` never explicitly sets COMM3_HI (mode 0 by omission), unlike its sibling functions — a real but likely-inert robustness bug (§3.5). |
| **Confirmed by project history** | The premise "cmd $3E/state4_epilogue works in 2P" is unvalidated — no 2P profiling/playtest run exists in this project's own records (§4, `VR60_ROADMAP.md:33`). |
| **Hypothesis, not yet tested** | The DMAOR bug is the root cause of the observed 1P hang (Hypothesis 1, §5) — plausible but undermined by DME likely already being globally latched from scene init. |
| **Hypothesis, not yet tested** | The hang is not 1P-specific at all — cmd $3E has simply never been exercised successfully anywhere, in any mode, and 1P is the first real test (Hypothesis 2, §5) — best-supported framing but not a specific mechanism. |
| **Genuinely unresolved, needs empirical test** | Whether COMM1_LO bit 1 (ACK) is ever actually set after the 1P trigger, or whether the 68K's freeze happens somewhere else entirely (the FIFO push loop, or the SH2 side) — **Test 1, §6**, is the specific, cheap experiment that resolves this. |
| **Genuinely unresolved, out of scope for this pass** | The exact SH2 opcodes of cmd $02's own DMAC-configuring code (`$06000CFC`) were not located/decoded in this repository's checked-in analysis (§3.2) — a documentation gap, not blocking, but worth closing before further DMAC-touching VR60 work. |
| **Genuinely unresolved, out of scope for this pass** | Whether `gfx_2_player_entity_frame_orch` (2P-only, runs immediately before `state4_epilogue`) touches COMM/DMAC state in a way `race_entity_update_loop` (1P) does not — not fully re-disassembled in this pass (§4). |

---

## 8. Follow-up: PicoDrive DMAC/DREQ emulation fidelity check (session 2)

**Role:** Worker, read-only research. No `disasm/`, `third_party/`, build, or Makefile file modified —
only this document. Triggered by the empirical fact (established after §1-7 above were written)
that fixing the DMAOR access-width bug (§3.3: `mov.w`→`mov.l`) did **not** resolve the hang —
confirmed by re-disassembling the rebuilt ROM (`python3 tools/sh2_disasm.py build/vr_rebuild.32x
0x301706 10` now correctly shows `MOV.L R0,@R1`), yet `$FFC87E` still freezes at `8` forever, and
`VRD_WATCH` still shows COMM0/COMM1 at `0x0` and SH2-side DREQ_LEN (`$20004010`) stuck at `$00A0`
(never decrementing once) across an 1800-frame autoplay run, both before and after the fix. This
section investigates whether PicoDrive's own SH2 DMAC / 32X DREQ emulation is complete for the
exact configuration `cmd3e_entity_transfer` uses, per the task's five numbered questions.

### 8.1 Where PicoDrive emulates the SH2 on-chip DMAC

Location: `third_party/picodrive/pico/32x/sh2soc.c` (not a separate DMAC file — DMAC emulation
lives inline in the SH2 peripheral-register read/write handlers of this one file, alongside SCI,
WDT, and the divide unit).

- **Register model** (`sh2soc.c:33-62`): `struct dma_chan { u32 sar, dar, tcr, chcr; }` × 2
  channels, plus `struct dmac { chan[2], vcrdma0, vcrdma1, dmaor }`. Bit-name comments at
  `sh2soc.c:37-46` and `:56-61` transcribe the exact CHCR/DMAOR bit layout from the datasheet.
  `#define DMA_DME (1<<0)` (`:61`), `#define DMA_DE (1<<0)`, `DMA_TE (1<<1)`, `DMA_AR (1<<9)`
  (`:43-46`) — **DME (DMAOR bit 0) and per-channel DE (CHCR bit 0) are both modeled**, confirming
  the task's question 1a is answered **yes** for those two bits.
- **External-request (DREQ) vs. auto-request mode is modeled explicitly.** `dmac_trigger()`
  (`sh2soc.c:153-190`) branches on `chan->chcr & DMA_AR` (`:159`): if `AR=1` it does an immediate,
  synchronous auto-request transfer (`dmac_memcpy`/`dmac_transfer_one` loop, `:160-170`); if `AR=0`
  (external request — this is `cmd3e_entity_transfer`'s configuration, CHCR0 bit 9 = 0, confirmed
  by direct opcode decode of `$000014E5` below) it takes the DREQ0/DREQ1 branch (`:173-189`), which
  for a channel whose `sar` (masked) equals `$00004012` (the FIFO port — `cmd3e_entity_transfer.asm`
  sets exactly this) does **not** transfer anything itself; it only calls `p32x_dreq0_trigger()`
  **if the shared software FIFO (`Pico32x.dmac0_fifo_ptr`) already holds a non-zero multiple of 4
  words** (`:176-179`). This is architecturally correct for a DREQ-driven channel: arming the
  register set alone should not push data — a real DREQ pulse (here modeled as "4 words landed in
  the FIFO") is required, and that pulse comes from the 68K's own FIFO writes, not from the SH2
  register-configuration writes. **Conclusion: external-request/DREQ mode is genuinely modeled**,
  answering the task's "does it model external-request mode at all" question — yes.

### 8.2 CHCR0 = `$000014E5` decoded, and a second, previously-undiscovered ROM bug found

Per the bit-name comment at `sh2soc.c:37` (`dm dm sm sm  ts ts ar am  al ds dl tb  ta ie te de`,
MSB→LSB) and the datasheet's own bit tables, `$14E5` = `0001 0100 1110 0101` decodes as:
`DM1:DM0=00` (destination address **fixed**), `SM1:SM0=01` (source address **increment**),
`TS1:TS0=01` (word size), `AR=0` (external request — correct), `AM=0`, `AL=1`, `DS=1`, `DL=1`,
`TB=0`, `TA=0`, `IE=1`, `TE=0`, `DE=1`.

`docs/32x-hardware-manual.md:1474-1483` (§"DMA Controller Settings") gives the **mandatory, fixed
bit pattern** for exactly this use case:

> **Transfer from DREQ FIFO to memory (channel 0, external request):**
> - DMA Source Address Register 0 (FFFF FF80h) → 2000 4012h fixed
> - DMA Destination Address Register 0 (FFFF FF84h) → optional
> - DMA Transfer Count Register 0 (FFFF FF88h) → same value as DREQ Length Register (2000 4010h)
> - **DMA Channel Control Register 0 (FFFF FF8Ch) → 0100 0100 1110 0XXXb (fixed except for X)**
> - DMA Operation Register (FFFF FFB0h) → optional

Decoding the manual's mandated `0100 0100 1110 0XXXb`: `DM1:DM0=01` (destination **increment**),
`SM1:SM0=00` (source **fixed**) — **the exact opposite of what `cmd3e_entity_transfer` configures.**
`cmd3e_entity_transfer.asm:151-154`'s `.chcr_value: .long 0x000014E5` has the **source and
destination address-mode fields transposed**: it tells the DMAC to leave the destination address
(the SDRAM entity/globals buffer, which must advance through 160 sequential words) **fixed**, and
to **increment** the source address (which must stay pinned at the FIFO port `$20004012`, since
that register is the FIFO's read port, not a memory buffer). The comment on
`cmd3e_entity_transfer.asm:154` ("External request, word, dest auto-inc, enable") **asserts the
opposite of what the encoded value actually does** — the value does not set destination auto-inc;
it sets source auto-inc and destination-fixed.

**This is independently corroborated by PicoDrive's own internal correctness check**, not just the
datasheet: `dreq0_do()`'s sanity assertion at `sh2soc.c:502-503`:

```c
if ((chan->chcr & 0x3f08) != 0x0400)
    elprintf(EL_32XP|EL_ANOMALY, "dreq0: bad control: %04x", chan->chcr);
```

`0x14E5 & 0x3f08 = 0x1400` (bit 12 = SM0 = 1 spuriously set) `≠ 0x0400` — **this check would fire
its "bad control" anomaly log on every single invocation of `cmd3e_entity_transfer`**, i.e.
PicoDrive's own emulator, independently of any docs read in this session, already "knows" this
CHCR0 value is wrong for a DREQ0 transfer.

**However — this second bug, while real and now independently confirmed by two sources (manual +
emulator's own check), is very unlikely to be the hang's root cause under PicoDrive specifically**,
because `dreq0_do()`'s actual data-movement loop (`sh2soc.c:507-517`) does **not consult the CHCR
SM/DM fields at all** — it unconditionally does `chan->dar += 2` per transferred word
(`sh2soc.c:514`), regardless of what the (wrong) CHCR value nominally specifies. So, per this
emulator's model, the transfer would still land at the intended, advancing SDRAM destination and
would still count `chan->tcr` down to 0 — the anomaly is logged but not acted on. **This is a real,
citable, previously-undocumented ROM defect that should be fixed regardless** (real hardware, or
any more cycle-accurate SH2/32X core, would honor the SM/DM fields and either corrupt the transfer
or leave the source pointer wandering out of the FIFO's fixed address), **but it does not explain
"DREQ_LEN never decrements even once" under PicoDrive.** Corrected value per the manual's mandated
pattern, preserving `IE=1/TE=0/DE=1`: `0100 0100 1110 0101b = 0x44E5` (i.e. `$14E5` → `$44E5`,
flipping only bits 14 and 12).

### 8.3 32X-side DREQ FIFO/CTRL/LEN emulation — generic, not special-cased to the original game

Location: `third_party/picodrive/pico/32x/memory.c`.

- **68K→SH2 FIFO write path is real and generic.** A 68K word write to `MARS_FIFO` (`$A15112`,
  register offset `0x12`) — exactly what both `mars_dma_xfer_vdp_fill.asm:28-39` (cmd $02, proven
  working) and `vr60_entity_transfer.asm:49-57` (cmd $3E) do via `MOVE.W (A1)+,(A2)` — routes
  through `p32x_reg_write16()`'s `case 0x12/2:` (`memory.c:610-612`) straight into `dreq0_write()`
  (`memory.c:380-403`). `dreq0_write()` requires `P32XS_68S` (bit 2 of the DREQ CTRL byte,
  `memory.c:382`) to be set — set by both callers via `MARS_DREQ_CTRL+1 = $04`
  (`mars_dma_xfer_vdp_fill.asm:20`, `vr60_entity_transfer.asm:34`; confirmed to hit
  `p32x_reg_write8`'s `case 0x07:` at `memory.c:448-455`, which ORs in `P32XS_68S` from bit 2 of the
  written byte — the register offsets in `disasm/modules/shared/definitions.asm:15-27`
  — `MARS_DREQ_CTRL=$A15106`, `MARS_DREQ_LEN=$A15110`, `MARS_FIFO=$A15112` — all resolve to exactly
  the offsets PicoDrive's switch statements expect; **no register-offset mismatch found**). Each
  accepted FIFO word decrements the shared `DREQ_LEN` register (`memory.c:392`, mirrored to the
  SH2 side at `$20004010` via the identical `Pico32x.regs[]` array, confirmed readable from the SH2
  side unmodified at `memory.c:767-768`'s `case 0x10/2:`), and every 4th accumulated word calls
  `p32x_dreq0_trigger()` (`memory.c:396-399`), which re-checks **both** SH2 cores' live
  `dmaor`/`chcr` state fresh at that instant (`sh2soc.c:545-557`) and, if armed, calls `dreq0_do()`
  to drain the software FIFO into the configured destination.
- **This mechanism is entirely register-value-driven, not hardcoded to the original game's
  literal channel/mode.** `dmac_trigger()`, `dreq0_write()`, `dreq0_do()`, and `p32x_dreq0_trigger()`
  contain no comparison against the *original* game's specific SAR0/DAR0/TCR0/CHCR0 constants —
  they operate purely on whatever values are currently stored in `chan->sar/dar/tcr/chcr` and
  `Pico32x.regs[]`/`Pico32x.dmac_fifo[]` at the time each hook fires. A "new," differently-configured
  DREQ transfer (different destination, different word count) is handled by the **exact same code
  path** as the original game's cmd $02 transfer — there is no evidence of a special-cased or
  partial implementation that would silently ignore an unfamiliar configuration. **This directly
  answers task question 2: no, there is no hardcoded/special-cased gap found — the emulation is
  generic.**
- The software FIFO itself is only `DMAC_FIFO_LEN = 4*2 = 8` words deep
  (`pico/pico_int.h:633,653`) versus the hardware-manual's "4 Word FIFO" diagram
  (`docs/32x-hardware-manual.md:704,707`) — a 2×-oversized software buffer, presumably as slack for
  the 4-words-per-trigger draining granularity, not a functional gap; overflow past 8 words is
  handled (silently drops the write and logs `EL_32X|EL_ANOMALY "DREQ FIFO overflow!"`,
  `memory.c:401-402`) rather than crashing, so even a badly-paced push loop would not itself hang
  the emulator, only lose data silently past the 8th unconsumed word.

### 8.4 Locating cmd $02's own SH2-side DMAC-configuring code — the §3.2 gap, closed

The linked document's §3.2 explicitly stated this could not be found in the prior pass. It was
located in this session by **direct disassembly of the actual rebuilt ROM**, not by further static
reading of source, using this project's own `tools/sh2_disasm.py`:

```
python3 tools/sh2_disasm.py build/vr_rebuild.32x 0x020CFC 60
```

(`0x020CFC` is the cmd $02 handler's own documented ROM offset,
`analysis/sh2-analysis/SH2_COMMAND_HANDLER_REFERENCE.md:83`.) **Caveat on absolute address labels:**
this tool's internal `SH2Disassembler.__init__` (`tools/sh2_disasm.py:11-14`) uses a hardcoded
`base_address=0x02200000` that does **not** match this project's own documented SH2 addressing rule
(`cpu_addr = file_offset + 0x02000000`, CLAUDE.md §"ROM Address Mapping") — the tool's printed
absolute-address column is therefore off by a constant from the project's own convention and should
**not** be quoted as a ground-truth SH2 address. The **relative structure and literal data it
decodes from the correct file bytes are unaffected** by this labeling quirk, and were verified
against already-known-correct addresses: the disassembly's `BSR` targets, after stripping the
tool's own base label, land on low-order offsets `115C`, `0EB4`, `10AC` — exactly matching
`SH2_COMMAND_HANDLER_REFERENCE.md:85`'s already-documented "entity loop callers at `$0600115C`,
`$06000EB4`, `$060010AC`" for this same handler, confirming the correct file offset was read.

The handler's very first action after `STS.L PR,@-R15` is:

```
MOV.L @(disp,PC),R1      ; R1 = <some SDRAM pointer, $2600C000 — unrelated to this investigation>
MOV.L @(disp,PC),R0      ; R0 = literal 0x06004448   <-- raw literal, unambiguous, no label-quirk risk
JSR   @R0
NOP
```

`0x06004448` is **exactly** `struct_init_short`/`dmac_fifo_setup`'s documented SH2 address
(`disasm/sh2/3d_engine/struct_init_short.asm` header, `analysis/sh2-analysis/
SH2_COMMAND_HANDLER_REFERENCE.md:208`). **Finding: cmd $02 (Scene Orchestrator) does not have its
own, separate, undisassembled inline DMAC-configuring code as §3.2 speculated — it calls the
identical, already-proven-correct `dmac_fifo_setup` subroutine used by cmd $01/$04/$05, as its very
first action, every single time it runs (i.e. every racing frame, `state_disp_004cb8.asm:40`).**
This closes the §3.2 documentation gap.

**Consequence for the DMAOR-width-bug analysis (§3.3-3.4):** this means DMAC channel 0's
`DME`/`CHCR0`/`SAR0`/`DAR0`/`TCR0` are freshly re-armed by the **known-correct** `dmac_fifo_setup`
routine roughly every 2 V-INTs (state 0 = cmd $02), immediately before state 8 fires cmd $3E. Since
`dmac_fifo_setup` sets DMAOR via `mov.l` (`struct_init_short.asm:23-40`, confirmed in the original
§3.3 analysis) and nothing in the codebase clears DMAOR back to 0 (confirmed by the original `grep`
in §3.4), **`DME` is essentially guaranteed to already be `1` on the Master SH2's own peripheral
register state by the time `cmd3e_entity_transfer` runs its own CHCR0 write** — and `sh2soc.c`'s
`sh2_peripheral_write32`'s DMAC-trigger switch (`:469-482`) re-checks `dmac->dmaor & DMA_DME`
**fresh at CHCR0-write time**, using whatever value is *already* in the DMAOR register — which
would already be 1, correctly, regardless of whether `cmd3e_entity_transfer`'s own (buggy, pre-fix)
16-bit DMAOR store ever ran. This is consistent with — and offers a concrete mechanism for — the
observed fact that fixing the DMAOR width did not change the hang: **per this emulator's actual
register-write dispatch, the CHCR0 write (always `mov.l`, correct in both the pre-fix and post-fix
ROM builds) was already the operative arm-check point, and DMAOR's value was already correctly `1`
well before either version of the handler's own DMAOR write executed.** (Separately worth noting for
future DMAC work, found while reading `sh2_peripheral_write16`/`write32` side-by-side,
`sh2soc.c:394-419` vs `:421-489`: the DMAC "maybe start a transfer" switch — cases `0x18c`/`0x19c`/
`0x1b0`, i.e. CHCR0/CHCR1/DMAOR — exists **only** in the 32-bit write handler; a 16-bit store to
any of those three registers, from **any** future SH2 patch, will never call `dmac_trigger()` in
this emulator, independent of which half of the register it lands in. This generalizes and
sharpens — but does not change the sufficiency conclusion for — the original §3.3 finding.)

### 8.5 Re-verifying `cmd3e_entity_transfer`'s own assembled bytes at its live, post-Phase-7-relocation address

To rule out a bad literal-pool displacement surviving the Phase 7 SDRAM relocation (jump table now
resolves cmd $3E to `$023016B0`, §2.2), the handler was re-disassembled directly from the rebuilt
ROM at its own file offset:

```
python3 tools/sh2_disasm.py build/vr_rebuild.32x 0x3016B0 60
```

(Same base-address labeling caveat as §8.4 applies to the printed address column; the file offset
`0x3016B0` itself is ground truth — `$0301600` + the confirmed `$B0` handler-entry offset from
`expansion_300000.asm:441-442`'s `dcb.b` padding, matching the jump-table-resolved `$023016B0`
minus the documented `$02000000` SH2 base.) Findings:

- **Literal pool data is intact and resolves correctly.** The first literal pair read back as
  `$FFFFFF80` (SAR0 register address) immediately followed by `$20004012` (FIFO port value) —
  matching `cmd3e_entity_transfer.asm:131-134`'s `.dmac_sar0`/`.fifo_addr` exactly, byte for byte.
- **The path from `.configure_chcr` through the ACK write is unconditional, branch-free,
  straight-line code.** Manually decoding the raw opcodes (not trusting this disassembler's printed
  operand-direction/register-number text, which has a known display bug already flagged in §2.1 —
  e.g. it printed `MOV.B R0,@($3,R4)` for what the raw opcode `$8483` actually encodes as the
  **load** `MOV.B @(3,R8),R0`, and `$8083` as the correct **store** `MOV.B R0,@(3,R8)`, matching
  `cmd3e_entity_transfer.asm:107,109` exactly once decoded correctly) confirms: CHCR0 write → DMAOR
  write → COMM1_LO read → `OR #2,R0` (raw opcode `$CB02`, the SH2 `OR #imm,R0` immediate form, which
  this particular tool's opcode table does not decode and instead prints as raw `DW` — a tool
  limitation, not a code defect) → COMM1_LO store (the ACK write) — **with zero conditional or
  unconditional branches anywhere in this ~12-instruction span.** The **only** backward branch
  (loop) in the entire 96-byte function is the final `.wait_done` DREQ_LEN poll, which comes
  **after** the ACK write in program order.

**This is a materially new, ground-truth-verified fact**: if `cmd3e_entity_transfer` is entered at
all, the ACK write is unavoidable and near-immediate (well under the ~1-frame granularity of the
`VRD_WATCH` sampling used to observe the hang) — there is no code path inside this handler that
could "get stuck" before setting COMM1_LO bit 1. Combined with §8.1-8.4's finding that the DMAC/DREQ
emulation path is generic and shares 100% of its trigger machinery with cmd $02's proven-working
case, this significantly narrows the remaining possibilities to two: **(i) the handler is simply
never dispatched to at all in the 1P call context** (the COMM0 trigger write from
`vr60_entity_transfer.asm:37-38` never gets seen/acted on by the Master's poll loop — an entirely
different failure mode than "DMAC doesn't arm," worth checking with a raw PC trace if the profiling
harness can be made to expose one), **or (ii) the ACK genuinely is set, but transiently and outside
what the per-frame-granularity `VRD_WATCH` can observe, and the real freeze is downstream** — most
plausibly in the 68K's own FIFO-push code (`BLOCK_COPY_256` at `$008988EC`, shared verbatim with
cmd $02's own push loop and therefore a low-probability suspect, but not yet independently
re-examined in this session) or in whatever 68K code runs *after* `vr60_entity_transfer` returns and
is presumably waiting on the transferred entity data before advancing `$C87E` past state 8 — a code
path outside the scope of both this and the original session's investigation.

### 8.6 Conclusion and ranking

| Option | Verdict | Key evidence |
|---|---|---|
| (a) Real ROM-code bug beyond the DMAOR width fix | **Partially confirmed, but not sufficient by itself** | A second, genuine, previously-undocumented bug was found and independently corroborated by two sources: `cmd3e_entity_transfer.asm`'s CHCR0 constant (`$14E5`) has its source/destination address-mode fields transposed relative to `docs/32x-hardware-manual.md:1481`'s mandated fixed pattern for this exact transfer type, AND PicoDrive's own `dreq0_do()` sanity check (`sh2soc.c:502-503`) would flag it as `chcr & 0x3f08 = 0x1400 ≠ 0x0400` on every invocation (§8.2). However, `dreq0_do()`'s actual transfer loop ignores CHCR's SM/DM bits entirely for its own data movement (§8.2), so this bug alone does not explain "DREQ_LEN never decrements" under PicoDrive. Should still be fixed (`$14E5`→`$44E5`). |
| (b) Genuine PicoDrive DMAC/DREQ emulation gap for this configuration | **Not supported** | The DMAC trigger (`dmac_trigger`), FIFO-write path (`dreq0_write`), and drain path (`dreq0_do`/`p32x_dreq0_trigger`) are all generic and register-value-driven (§8.1, §8.3) — they contain no special-casing tied to the original game's specific literal register values, and are the **exact same code path** cmd $02 exercises successfully every racing frame, via the **exact same** shared global FIFO state (`Pico32x.dmac0_fifo_ptr`/`dmac_fifo[]`). No TODO/FIXME/HACK comments regarding DMAC/DREQ completeness were found anywhere in `third_party/picodrive/pico/32x/*.c` or `cpu/sh2/*.c` (`grep -rniE 'TODO|FIXME|HACK|XXX'`, empty for DMAC-relevant files), and `git log -- pico/32x/sh2soc.c` in this checkout shows no informative history (single unrelated commit, consistent with a squashed/shallow vendor import — no changelog evidence either way). |
| (c) Something else (trigger/timing/dispatch issue) | **Now the best-supported remaining explanation** | §8.5's ground-truth re-disassembly proves the ACK write is unconditional and unavoidable if the handler is entered at all — yet the empirical watch shows no transient ACK and DREQ_LEN never decrementing even once, which (given §8.1-8.4 rule out a DMAC-arming failure as the likely explanation) points either to the handler never being dispatched to in this specific 1P context, or to a real transient success invisible to frame-granularity sampling with the actual freeze occurring elsewhere (68K FIFO-push code or post-return 68K logic) — neither of which was re-examined in this session. |

**Updated bottom line:** The DMAOR-width bug (§3.3) and the newly found CHCR0 SM/DM-swap bug
(§8.2) are both real, both citable, and both worth fixing — but neither, individually or together,
plausibly explains the specific symptom (DREQ_LEN frozen at its initial value across 1800 frames,
in both the pre-fix and post-fix builds) once PicoDrive's actual DMAC-trigger and DREQ-drain code
is read line-by-line, because (i) DME is essentially certainly already latched from `dmac_fifo_setup`
running every frame via cmd $02 (§8.4), making the DMAOR bug largely moot for arming, and (ii) the
CHCR0 SM/DM bug doesn't affect `dreq0_do()`'s hardcoded destination-increment behavior (§8.2). No
PicoDrive DMAC/DREQ emulation gap specific to this configuration was found (§8.1, §8.3, §8.6-b) —
the emulation is generic and already proven correct for this exact mechanism via cmd $02. **The
single most valuable next step** is therefore **Test 1 from §6, but instrumented to distinguish
"handler never entered" from "handler entered, ACK set transiently, hang is downstream"** —
concretely: add a **one-time SH2-side sentinel write** to an unused SDRAM byte (e.g. the first
instruction of `cmd3e_entity_transfer`, before any other state changes) that a *post-hang* memory
dump (`VRD_DUMP=0x023016B0:4` or similar, per `VRD_PROFILING.md`) can check for presence/absence —
this cheaply answers "was the handler ever entered at all" without needing per-cycle PC tracing,
and directly discriminates between this section's hypothesis (c-i) and (c-ii) before any further
ROM-code changes are attempted.

---

## 9. Session 3 — the sentinel test executed, and a definitive result: the handler is never dispatched

**Role:** task manager (Claude), executing §8's own proposed next step directly (not delegated to
a research agent), verifying every claim against the actual build before drawing conclusions.

### 9.1 Both independently-confirmed bugs from §3.3 and §8.2 applied and kept

- `cmd3e_entity_transfer.asm`: DMAOR write changed from `mov.w` to `mov.l` (§3.3). Re-verified
  post-build by disassembling the rebuilt ROM directly
  (`python3 tools/sh2_disasm.py build/vr_rebuild.32x 0x301706 10` → `MOV.L R0,@R1`, confirmed).
- `cmd3e_entity_transfer.asm`: CHCR0 constant changed from `$14E5` to `$44E5` (§8.2), correcting the
  transposed source/destination address-mode fields per `docs/32x-hardware-manual.md`'s mandated
  pattern for this exact transfer type.
- **Both are real, independently-verified defects and are kept fixed regardless of the outcome
  below** — they do not, by themselves, explain the hang (confirmed empirically: re-running the
  full 1800-frame autoplay with the DMAOR fix alone applied reproduced the identical symptom,
  `$FFC87E` frozen at `8`, `$FFFF7B40` flag never reaching `1`, `$20004010` DREQ_LEN frozen at its
  initial `$00A0` — byte-for-byte the same as the pre-fix run).

### 9.2 The sentinel test (§8's proposed "single most valuable next step") — executed

A one-time, unconditional SH2-side write was added to the very first instructions of
`cmd3e_entity_transfer`, before `STS.L PR,@-R15` or any register/DMAC configuration — i.e. before
anything else in the handler runs. Two iterations were needed:

1. **First attempt: wrote a distinct 32-bit value (`$CAFEBABE`) to a newly-chosen scratch address
   (`$06011100`), and the address itself was a separate literal.** This did not fit: the module's
   expansion-ROM slot has only 8 bytes of slack before the next module's fixed pad target
   (`expansion_300000.asm:441`: `dcb.b ($3016B0 - *),$FF ; ... cmd $3E = 168B, fits before
   $301760`), and the naive sentinel (2 new literals + 3 instructions = 14 bytes) overflowed it —
   caught immediately and loudly by the build itself (`error 46 ... address space overflow`,
   exactly the safe failure mode this project's section-packing discipline is designed to produce;
   no silent corruption occurred). This was **not** worked around by shifting the following module
   (which would require re-verifying every hardcoded absolute-address literal pool entry elsewhere
   in the VR60 expansion code that references anything downstream of this slot — far too risky for
   a temporary diagnostic) — instead the sentinel was redesigned to fit the existing gap.
2. **Second attempt (fit exactly in 8 bytes): store R8 itself** (guaranteed `$20004020`, the COMM
   base, per this handler's own documented entry contract) to a single new address literal, needing
   only one `mov.l @(pc),r1` (2B code + 4B pool) + one `mov.l r8,@r1` (2B code) = 8 bytes exactly.
3. **The chosen scratch address (`$06011100`) turned out to be a bad choice for an unrelated
   reason**: watching it across a full 1800-frame run (`VRD_WATCH=...,0x06011100:4,0x26011100:4`)
   showed it changing value on **every single frame**, cycling through dozens of distinct,
   plausible-looking data values (`0x15FFEC`, `0x180013`, `0x2C0014`, `0xFFD92200`, …) — i.e. this
   address is **live, actively-written memory**, almost certainly touched by the stock renderer's
   own per-frame work via a computed/indexed address that a static `grep` for the literal address
   string cannot find. This invalidated the first sentinel run's result and is an important
   standalone finding: **the `$06011000`+ "TRACK_WORK" region's free extent, as previously
   documented from Phase 5C-5E, should not be assumed to extend indefinitely past what was
   explicitly measured (`$06011000-$06011063`) without re-verifying** — `$06011100` is well outside
   that measured range and is not, in fact, free.
4. **Final, valid run**: the sentinel's target address was changed to `$2600FC00` — the exact same
   address as cmd $3F's own execution canary — which this session had **already empirically
   confirmed, across many prior watches, reads a stable `0x0` throughout this precise 1P scenario**
   (cmd $3F never fires in 1P, so nothing else writes there). This is a safe, pre-validated choice,
   not a newly-assumed one.

### 9.3 Result: definitive, unambiguous

```
VRD_WATCH=0xFFC87E:2,0x0600FC00:4,0x2600FC00:4  (1800-frame autoplay)
```

Both addresses read `0x0` on **every single one of 1800 frames**. R8's value (`$20004020`) **never
appears at any point**. Since this sentinel is the unconditional first action of the handler —
before the DMAC configuration, before the ACK write, before anything else — this proves, without
any ambiguity about timing granularity or downstream effects:

**`cmd3e_entity_transfer` (the Master SH2's cmd `$3E` handler) is never entered at all when
triggered from `vr60_1p_staging_hook` in the 1-player racing context.**

This reframes the entire investigation. It is **not** a DMAC-configuration bug (§3, §8.2 — both
real bugs, but downstream of a point that's never reached), and **not** a PicoDrive DMAC/DREQ
emulation fidelity gap (§8.1, §8.3 — the emulation is generic and shared with cmd $02's own
working path, and none of that code ever runs either, consistent with "never dispatched," not
"dispatched but the emulator mishandles it"). The failure is further upstream: somewhere between
the 68K writing the COMM0 trigger and the Master SH2's poll loop reacting to it.

### 9.4 Hypotheses checked and ruled out this session

| # | Hypothesis | Check | Result |
|---|---|---|---|
| 1 | The runtime SDRAM copy of the jump table is stale/wrong (only the static ROM *file* bytes were ever checked in §2.2/§8.4, not the live, booted game state) | `VRD_DUMP=0x06000878:4,0x26000878:4` during an active 1P race | Reads `0230 16B0` at both the native and cache-through address — **correct, matches expectation exactly. Ruled out.** |
| 2 | `COMM0_LO`/`COMM0_HI`/`COMM1_LO`/`MARS_DREQ_LEN`/`MARS_DREQ_CTRL` are shadowed/redefined somewhere, so `vr60_entity_transfer.asm`'s writes silently target different addresses than `mars_dma_xfer_vdp_fill.asm`'s (cmd $02, proven working) | `grep -rn` for every `equ` definition of these five symbols across all of `disasm/` | Exactly one definition each, all in `disasm/modules/shared/definitions.asm`; the only other hits are a non-compiled `.md` reference doc with identical values. **No shadowing. Ruled out.** |
| 3 | The V-INT handler (which visibly keeps firing every frame — the emulator's own frame counter keeps advancing even while `$C87E` stays parked at `8`, meaning the CPU is not stuck in a true unbounded tight loop with interrupts masked) clobbers COMM0 or the COMM1 ACK bit as a side effect of its own, unrelated per-frame work, racing with `vr60_entity_transfer`'s trigger-then-poll sequence | `grep -n 'COMM0\|COMM1' disasm/modules/68k/vint/vint_unified_60fps.asm` (the state-`$54` unified V-INT handler) | No COMM0 reference at all. The one COMM1 reference is `btst #0,COMM1_LO` / `bclr #0,COMM1_LO` — **bit 0** only (the pre-existing, unrelated "render done" signal); `BCLR` is a single-bit atomic operation and cannot affect bit 1 (VR60's ACK bit). **Ruled out.** |
| 4 | Straight-line code between the confirmed-executing `MARS_DREQ_LEN` write and the COMM0 trigger write contains a branch/skip not previously noticed | Re-read `vr60_entity_transfer.asm:28-38` end to end | Confirmed straight-line, no branches: `MARS_DREQ_LEN` write → `MARS_DREQ_CTRL+1` write → `COMM0_LO` write → `COMM0_HI` write → `.wait_ack`. If the first is reached (independently confirmed via `$20004010` reading `$00A0`), the COMM0 writes are unconditionally reached too — **assuming no interrupt/exception diverts execution in between**, which items 1-3 above rule out as ordinary causes. |

### 9.5 What remains genuinely unresolved

The dispatch failure itself is not yet root-caused. What's established: the 68K reaches and
executes at least as far as the `MARS_DREQ_LEN` write (confirmed); the COMM0 trigger write
*should* immediately follow in straight-line code; the Master SH2's jump table is correct at
runtime; no symbol shadowing or V-INT interference was found; and PicoDrive's DMAC/DREQ emulation
is confirmed generic and not a factor, since the handler that would exercise it never runs.

Two possibilities remain open, neither yet distinguished:

- **(i) The 68K's COMM0 write genuinely never happens** — despite the straight-line code appearance,
  something (an exception, an unexamined side effect of one of the two calls immediately preceding
  the hook — `vr60_entity_stage`/`vr60_globals_stage`, both independently confirmed safe in
  isolation earlier this session — or something in `race_entity_update_loop`, called just before
  the hook, not re-examined for COMM/DMAC side effects this session) prevents it.
- **(ii) The 68K's COMM0 write does happen, but the Master SH2's poll loop never reacts to it in
  this specific context** — e.g. the Master SH2 might not be idle/polling COMM0 at the relevant
  moment for a reason specific to 1P's still-legacy one-state-per-V-INT timing (as opposed to 2P's
  linear, all-states-every-frame Phase-8 rewrite) that has not yet been identified.

**Recommended next step** (not yet executed): a *second* sentinel, symmetrical to this session's
one, placed on the **68K side** immediately after the `COMM0_HI` write in `vr60_entity_transfer.asm`
(e.g. an unconditional write to a free WRAM byte, checked the same way) would cheaply distinguish
these two remaining hypotheses: if that 68K-side sentinel fires but the SH2-side one still never
does, the 68K genuinely completes its trigger write and the failure is entirely on the SH2
dispatch side (hypothesis ii); if even the 68K-side sentinel never fires, the 68K itself is not
reaching that point, and the investigation must move to `race_entity_update_loop`,
`vr60_entity_stage`, and `vr60_globals_stage` for an overlooked side effect (hypothesis i) despite
their earlier isolated verification.

### 9.6 Final repository state after this session

- **Kept** (real, independently-verified bug fixes, applied and left in place): DMAOR access width
  (`mov.w`→`mov.l`), CHCR0 address-mode field correction (`$14E5`→`$44E5`), both in
  `disasm/sh2/expansion/cmd3e_entity_transfer.asm`.
- **Reverted** (diagnostic-only, its purpose served): the SH2-side sentinel write at the top of
  `cmd3e_entity_transfer`.
- **Left in the last confirmed-safe checkpoint** (per this session's isolation discipline):
  `vr60_1p_staging_hook.asm` calls only `vr60_entity_stage` + `vr60_globals_stage` (both
  independently verified correct — real data copy confirmed, zero regression) and sets the
  `$FFFF7B40` flag; `vr60_entity_transfer` (and everything after it in the original design —
  `vr60_ai_entity_stage`/`vr60_ai_entity_transfer`/`vr60_globals_transfer`/`vr60_comm_trigger`) is
  **not yet re-attempted**, pending resolution of this dispatch-failure investigation. Verified via
  the full regression check: `$FFC87E` cycles `0/4/8` normally, `fb_crc` is byte-identical to the
  Phase-0 baseline, and `$FFFF7B40` correctly reaches `1`.
- **Not committed.** Phase 1's actual goal (cmd `$3F`/`$3E` genuinely firing and driving SH2 work in
  1P) is not yet reached — this remains a checkpoint, matching this session's established practice
  of only committing completed, verified milestones.

---

## 9.5b The 68K-side sentinel from §9.5 — executed, result: the 68K completes the trigger

Implemented exactly as proposed: `move.b #$01,$FFFF7B41` inserted in
`disasm/modules/68k/sh2/vr60_entity_transfer.asm` immediately after `move.b #$01,COMM0_HI`
(the trigger write) and before `.wait_ack:`. `$FFFF7B41` is a verified-free WRAM byte (adjacent
to `VR60_1P_FLAG`/`$FFFF7B40`, confirmed free by the same exhaustive grep in §0.3 of the
original implementation plan). `code_1c200.asm` (where `vr60_entity_transfer` lives) has ~6.8KB
of slack before its own `$01E200` pad target, so this addition needed no byte-budget juggling.

**Result, watched across a full 1800-frame autoplay session:**

```
frame,0xFFC87E,0xFF7B40,0xFF7B41,0xA15120,0xA15122,0x20004010
1799,0x8,     0x0,     0x1,     0x0,     0x0,     0xA0
```

`$FFFF7B41` reads `0x1` on every sampled frame from the moment the hook first fires onward. This
proves, unambiguously: **the 68K reaches and completes every instruction of the trigger sequence**
— `MARS_DREQ_LEN` write, `MARS_DREQ_CTRL+1` write, `COMM0_LO=$3E` write, `COMM0_HI=$01` write, and
this sentinel — all before entering `.wait_ack`, where it then spins forever (consistent with
`$FFFC87E` freezing and `$FFFF7B40`, the "seeded" flag, never reaching `1`, since the function
never returns).

**Combined with §9.3's SH2-side result, this fully resolves §9.5's open question in favor of
hypothesis (ii):** the 68K genuinely completes its half of the handshake; the failure is entirely
on the Master SH2's side — it never dispatches to `cmd3e_entity_transfer` in response to an
apparently well-formed, complete trigger write. The investigation now moves to the Master SH2's
own poll/dispatch loop itself (`disasm/sh2/3d_engine/master_command_loop.asm`) — continued in
§10.

**Repository state:** the 68K-side sentinel is currently **still present** in
`vr60_entity_transfer.asm` (not yet reverted, pending §10's outcome, since it may still be useful
for a follow-up test); `vr60_entity_transfer` is currently **re-enabled** in
`vr60_1p_staging_hook.asm` (diagnostic re-enable, not a committed fix — the hang is unchanged and
expected, this is purely instrumentation).

---

## 10. Session 4: tracing the Master SH2 dispatch-loop failure directly

**Role:** Worker, read-only research. No `disasm/`, build, or Makefile file modified — only this
document. Continues directly from §9's definitive result (the handler is never entered) by
examining the one thing not yet directly re-verified from scratch: the Master SH2's own poll/
dispatch loop itself (`disasm/sh2/3d_engine/master_command_loop.asm`), for hooks, gating, an
alternate interrupt-driven path, or a reason Master might not be listening at the critical moment.

### 10.1 Is `master_command_loop.asm` actually what runs? Mirroring re-verified, one real gap found

The file's header states both "ROM File Offset: 0x20450–0x20490" and "SH2 Address:
0x02020450–0x02020490" (`master_command_loop.asm:3-4`). These are consistent with each other and
with CLAUDE.md's own `cpu_addr = file_offset + 0x02000000` rule — `0x20450 + 0x02000000 =
0x02020450` — so there is **no** file-offset-vs-SH2-address confusion in this specific file (unlike
the `tools/sh2_disasm.py` labeling quirk flagged in §8.4, which is a different tool with a
different, wrong base). All in-body citations in this document and in `master_command_loop.asm`
itself use the **file-offset form** (`$020450` etc.), consistently, and that is the correct form to
match against `code_20200.asm`'s own `; $020450`-style comments.

**The dc.w bytes were re-compared, word-for-word, between `master_command_loop.asm` and
`disasm/sections/code_20200.asm:307-330`** (the latter re-read in full this session, `code_20200.asm`
lines 307-330). Every single opcode matches exactly for the region that actually executes at
runtime ($020450 `D10A` through $02048A `4020`) — **confirmed, not just asserted this time.**
`code_20200.asm:321-322` still carries the original "PATCH #2 REVERTED" comment, and no other
`.asm` file anywhere in `disasm/sections/` or `disasm/modules/` writes to, includes, or redirects
this address range (`grep -rn "020450\|020460\|020468\|02046A\|020470\|020474"` across the whole
tree, results enumerated in this session — every hit is either this same loop, the long-reverted
`master_dispatch_hook` history in `KNOWN_ISSUES.md`/`_archive/sync_debug/*`/analysis docs, or
`disasm/sh2_symbols.inc:27`'s harmless `comm_send_response EQU $02020450` symbol alias, which is
never referenced by any `.inc`/`.asm` outside that symbol table). **Answering the task's question 1
directly: no other hook, redirection, or alternate dispatch path targets this address range at
runtime. `master_dispatch_hook` (`$300050`) remains the only one ever built, and it is confirmed
dormant** — not called from anywhere, not the target of any live JSR/JMP/BRA, consistent with §2.1's
original finding, now independently re-confirmed by directly diffing the mirror against the real
assembled section rather than trusting the prior session's citation of it.

**One real gap in the "mirrors byte-for-byte" claim was found, and it is significant enough to
address on its own — see §10.3.** It does not involve a hook or redirection; it involves an entire
annotated block in the *documentation* file that was never applied to the real build at all.

### 10.2 The dispatch path traced instruction-by-instruction — no gating on command value found, and two additional pre-existing comment errors corrected

Every instruction from `.poll_wait` to the `jsr @r0` was independently re-decoded from the raw
opcodes in `code_20200.asm` against the SH2 ISA (not trusting either file's inline comments):

| Addr | Opcode | Correct decode | Matches existing doc? |
|---|---|---|---|
| `$020462` | `6080` | `MOV.B @R8,R0` | Yes |
| `$020464` | `8800` | `CMP/EQ #0,R0` | Yes |
| `$020466` | `89FB` | `BT .poll_wait` (disp=-5) | Yes |
| `$020468` | `8481` | `MOV.B @(1,R8),R0` — **hard-wired R0 destination**, not R4 | Yes — matches §2.1's prior correction, re-verified independently this session by decoding the `1000 0100 mmmm dddd` format from scratch |
| `$02046A` | `4008` | `SHLL2 R0` (×4) | Yes |
| `$02046C` | `D107` | `MOV.L @(28,PC),R1` → EA computed as `($02046C+4 & ~3)+28 = $02048C` = `jump_table_addr` | Yes |
| `$02046E` | `001E` | `MOV.L @(R0,R1),R0` (indexed load, format `0000mmmmnnnn1110`, m=R0=dest, n=R1=base) | Yes |
| `$020470` | `400B` | `JSR @R0` | Yes |
| `$020474` | `AFF4` | `BRA` disp=-12 → `$020460` | Yes, target arithmetic re-verified: `($020474+4)+(-12*2) = 0x020460` ✓ |

**No `CMP`, `TST`, `AND`, or any other value-testing/masking instruction exists anywhere in this
9-instruction span.** The command byte is read once (`$020468`), shifted (`$02046A`), and used
directly as a table index (`$02046E`) with zero validation. **This directly answers the task's
question 2 and question 4: there is no range check, no maximum-command-value comparison, and no
special-casing of any byte value anywhere in the dispatch path.** `$3E` (62) and `$02` (2) are
processed by *bit-for-bit identical* code, differing only in the data value that flows through
unconditional arithmetic (`62<<2=$F8` vs `2<<2=$08`, both trivially in-range for a 256-entry×4-byte
= 1024-byte table at `$06000780-$06000B7F`, with no evidence anywhere that the table is smaller
than that). No sign-extension risk exists either: the byte is loaded with a plain `MOV.B` into a
32-bit register (SH2 byte loads always sign-extend to 32 bits per the ISA, but `SHLL2` cares only
about the low bits before any subsequent masking, and the table-index arithmetic here never
branches on sign) and `$3E`/`$02` are both < `$80`, so even signed vs. unsigned interpretation of the
byte is moot for either value.

**Two additional, previously-uncorrected errors were found in `master_init_comm`
($020450-$02045E, the boot-time prologue that runs once before falling into `master_poll_loop` —
confirmed one-time by exhaustive `grep` for any other jump into `master_init_comm:`; the only
back-reference is its own internal retry branch, `$020456: 8BFC bf master_init_comm`):**

1. **`$020450: D10A` does *not* load `0x20004020`.** Decoding the PC-relative displacement from
   scratch: EA = `($020450+4 & ~3) + 10*4 = $02047C`. The raw bytes at `$02047C-$02047F` in
   `code_20200.asm` (lines quoted in §10.1's diff) are `2000 4000` = **`0x20004000`** — the 32X
   interrupt-mask-register base, not the COMM base. The doc's own annotation
   (`master_command_loop.asm:89`, `.long 0x20004020 /* COMM base address */`) transcribes the
   correct raw hex (`2000 4000`) right next to a *wrong* decoded value, then hedges with "Note:
   Listed as 0x20004000 but should be 0x20004020?" — the hedge resolves the opposite way from what
   it guesses: **the raw bytes (`0x20004000`) are the ground truth; the annotated `.long` value
   (`0x20004020`) is the error.** The label used for this instruction (`comm_base_addr`, pointing at
   a *different* literal further down at `$020488`) is consequently also mismatched — R1 at this
   point in program order is `0x20004000`, not the COMM base.
2. **`$020452: 5018` is not a mysterious "Load something?" — it is a live hardware-register read
   used for a boot-time handshake wait.** Decoding `5018` as `MOV.L @(disp,Rm),Rn` (format
   `0101nnnnmmmmdddd`): n=0000=R0 (dest), m=0001=R1 (base), disp=8×4=32. This is `MOV.L
   @(32,R1),R0` — with R1=`0x20004000` from the corrected decode above, this reads the 32-bit word
   at `0x20004000+32 = 0x20004020`, i.e., it reads the **live current value of COMM0:COMM1** (both
   registers, as one 32-bit access) straight off the hardware. The following `CMP/EQ #0,R0` /
   `BF master_init_comm` then loops **at boot** until COMM0:COMM1 read back as all-zero — a
   handshake wait for the 68K to have released these registers before Master's polling loop
   starts. `$02045A: 1109 MOV.L R0,@(36,R1)` (R0=0 at this point) then clears `*(0x20004000+36) =
   0x20004024` = **COMM2:COMM3** as a 32-bit write (the doc's guess "Clear COMM9?" is simply wrong —
   there is no COMM9 in the 16-byte COMM register block, `$20004020-$2000402F`, 8 registers ×
   2 bytes).

Neither of these two corrections changes any conclusion about steady-state dispatch — this code
runs exactly once, at Master boot, well before any racing state exists, and does not gate on
command value either. They are recorded here because the task asked to re-verify every hedged
comment in this file the same way §2.1 already caught one register-decode error, and two more were
found by doing so.

### 10.3 CMDINT: definitively confirmed dead, unwired, and — had it ever been wired — using the wrong bit

The task's question 3 asked whether the CMDINT enable block documented in `master_command_loop.asm`
(`:46-55`, "Phase 1: Enable CMDINT") governs an interrupt-driven path that cmd `$3E` might have been
intended to use instead of the plain poll loop. **It does not, for three independent, stacked
reasons, each confirmed directly:**

1. **The block does not exist in the real, assembled ROM at all.** `code_20200.asm`'s raw byte
   stream (re-read in full this session, §10.1) has **zero bytes of room** between `$02045E`'s
   `400E` (`LDC R0,SR`, the last instruction of the real `master_init_comm`) and `$020460`'s `D809`
   (the real first instruction of `master_poll_loop`) — these two addresses are back-to-back with no
   gap. The 4-instruction, 8-byte CMDINT-enable sequence shown in the doc simply has nowhere to
   physically exist between them.
2. **This is not a mystery — it is fully explained by git history.** `git show d0c32c3` (commit
   `d0c32c3`, "feat(phase1): Implement Steps 1-3 — CMDINT infrastructure", Feb 7 2026 — an entirely
   different, earlier, and separate "Phase 1" than the current VR60 investigation) modified
   **only** `disasm/sh2/3d_engine/master_command_loop.asm` (a `+13` line diff adding exactly this
   block) and created new expansion-ROM files (`cmdint_handler.asm`, `queue_processor.asm`) plus
   Makefile rules — but its diff **does not touch `disasm/sections/code_20200.asm` at all.** The doc
   file was edited to describe an intended patch to the real dispatch loop; the real dispatch loop
   itself was never actually edited. `PHASE1_COMPLETION_REPORT.md:387` lists this as a completed
   "Files Modified" row ("`master_command_loop.asm` | After 44 | Enable CMD interrupt mask"), which
   is accurate about *which file* was edited but creates a false impression that the *game's own
   Master SH2 code* was changed — it was not. The associated ring-buffer/CMDINT-handler
   infrastructure (`ring_buffer_init.asm`, `cmdint_handler.inc`, `queue_processor.inc`) does still
   exist and is still built into `expansion_300000.asm` today (confirmed via `grep`), but per that
   same report's own text ("Next: Vector table modification (Step 4)") the CMDINT vector was never
   actually redirected to it either — confirmed by `grep -n "CMDINT\|02300800" disasm/sections/
   code_1e200.asm` returning **no hits at all** in this session. So even the separate,
   abandoned side-project's own interrupt handler is unreachable: nothing ever points the CMDINT
   vector at it, and (per point 1) nothing ever unmasks CMDINT on the real Master SH2 either.
3. **Had the phantom block actually been built, it would have set the wrong bit anyway.**
   `docs/32x-hardware-manual.md:561-604` ("System Registers [SH2 side]", address `2000 4000h`)
   gives the authoritative bit layout: `FM(15) | -(14-10) | ADEN(9) | CART(8) | HEN(7) | -(6-4) |
   V(3) | H(2) | CMD(1) | PWM(0)`. **CMD is bit 1 (mask `0x0002`), not bit 3.** The phantom code's
   `or #0x08,r0` (`master_command_loop.asm`'s "Phase 1" diff) sets **bit 3, which is V (V-INT
   mask)** — already-enabled/irrelevant to CMDINT — and never touches bit 1 at all. The block's own
   comment ("Set CMD bit (bit 3, enables CMDINT)") is simply wrong about which bit CMD is.

**This closes out question 3 unambiguously: CMDINT is not a live, alternate, or intended dispatch
path for cmd `$3E` or anything else in this codebase.** It is inert leftover documentation from an
abandoned, unrelated Feb 2026 async-infrastructure experiment that (a) was never wired into the
real Master SH2 boot code, (b) was never given a working vector redirect, and (c) targeted the
wrong interrupt-mask bit even in its own unbuilt design. The plain busy-wait in `master_poll_loop`
is, and has only ever been, the sole dispatch mechanism for every command byte in this ROM,
cmd `$3E` included.

### 10.4 Is the Master SH2 busy elsewhere at the moment cmd $3E fires? — re-examined, still no

Re-reading `vr60_1p_staging_hook.asm` and `vr60_entity_transfer.asm` in full this session surfaced
a structural fact load-bearing enough to restate precisely: **`VR60_1P_FLAG` (`$FFFF7B40`) is only
set to `1` *after* `jsr vr60_entity_transfer` returns** (`vr60_1p_staging_hook.asm:37-38`), and
`vr60_entity_transfer`'s `.wait_ack` loop (`vr60_entity_transfer.asm:48-50`) has no timeout or
escape condition other than the ACK bit itself. Per §9's own empirical finding (the flag never
reaches `1` across a full 1800-frame run), **this call never returns — meaning the entire
staging-hook block (`.tst.b VR60_1P_FLAG / bne.s .done`, `vr60_1p_staging_hook.asm:25-26`) is
entered exactly once per game session, and the 68K's COMM0 trigger write for cmd `$3E` therefore
also executes exactly once, ever, in the whole run — not once per V-INT, not retried.** Every
frame after the first entry is simply the 68K's main-loop thread permanently parked in this one
spin, while V-INT (unrelated, unaffected — confirmed again this session, `vint_unified_60fps.asm`
touches only `COMM1_LO` bit 0) keeps firing on schedule.

This sharpens, rather than weakens, the "is Master busy elsewhere" question, and also supplies a
general argument against pure-timing explanations: **COMM0, once set by this one write, is never
cleared by the 68K (only the SH2 handler's own step 10 clears it, and that handler is confirmed —
§9.3 — never entered) and is never touched by anything else in the system** (re-confirmed this
session: `grep` across `disasm/modules/68k/` for `COMM0` outside the VR60/cmd-$02 files found no
other writer). `master_poll_loop`'s `.poll_wait` re-reads this same persistent, never-cleared value
in a **tight, 4-cycle busy loop, forever**, as long as Master is executing it at all. A momentary
read-during-write hazard (§1's COMM0 concern) can, at most, cause **one** polling iteration to
observe a stale/undefined value — the very next iteration, a few cycles later, re-reads a register
that has by then unambiguously settled to its new value and stays there indefinitely. **This means
a transient hazard cannot, by itself, explain a *permanent* miss of a value that never goes away
again** — it would explain at most a few cycles of extra latency, not "never, across 1800 frames."
The only two structural explanations that survive this argument are (i) Master is not executing
`master_poll_loop` at all by the time (or forever after) the trigger fires, or (ii) Master's read of
`$20004020` and the 68K's write to `COMM0_HI` are not, for some address-mapping or emulation reason,
the same physical storage location at this specific moment — not "sometimes glitchy," but
consistently disconnected.

On whether Master could plausibly be stuck in unrelated work at the critical instant: `state_disp_
004cb8` is a **one-state-per-V-INT** dispatcher (`state_disp_004cb8.asm:25-38`), so states 0
(cmd `$02`, `mars_dma_xfer_vdp_fill`) and 8 (`vr60_1p_staging_hook`) execute on V-INTs **7 ticks
apart** (~116 ms at 60 Hz). `mars_dma_xfer_vdp_fill` is itself fully synchronous — the 68K blocks in
its *own* `.wait_ack` (`mars_dma_xfer_vdp_fill.asm:23-26`) until cmd `$02` completes and the SH2 side
clears COMM0_HI before returning to `master_poll_loop` (per `SH2_COMMAND_HANDLER_REFERENCE.md:34-37`,
cited in §3.1) — so by construction, Master is already back in `.poll_wait` before the 68K's own
dispatcher even leaves state 0. Given Master's own documented utilization is ~41% of a single
**16.7 ms** frame budget (CLAUDE.md's own current profiling numbers), a 116 ms idle gap is roughly
7 frames' worth of budget with nothing else scheduled on Master in between (no other VR60 command
fires between states 0 and 8 in this call chain, and no evidence was found — via `vr60_entity_stage`
/`vr60_globals_stage`'s full re-read, §9.6 — of any SH2/COMM/DMAC touch in the code that runs
immediately before the trigger). **No plausible "Master is still finishing something else" mechanism
survives this arithmetic.** This re-confirms (does not newly refute) the prior sessions' conclusion,
now backed by an explicit timing argument rather than just "no evidence found."

One tangential, non-causal finding surfaced while checking whether the 68K does anything to the SH2
around this window: `vint_unified_60fps.asm` and several original-game VDP/DMA routines
(`vdp_dma_frame_swap_037.asm:54,66`, `vdp_dma_palette_xfer_036.asm:54,67`,
`vdp_dma_cram_xfer.asm:51,67`, `vdp_dma_scroll_frame_swap.asm:58,74`,
`vdp_reg_write_32x_adapter_control.asm:44,55`) all do
`bclr #7,MARS_SYS_INTCTL` / `bset #7,MARS_SYS_INTCTL` around VDP DMA work, every V-INT, labeled in
this codebase's own comments as "clear/re-enable CMD INT" or "request/release MARS access". Per
`docs/32x-hardware-manual.md:349-374` ("Adapter Control Register", address `A1 5100h`), **bit 7 of
this 68K-side register is REN ("SH2 Reset Enable"), not a CMD-interrupt bit** — a third, separate
mislabeled-comment class in this codebase (distinct from the two in §10.2 and the dead-CMDINT
labeling in §10.3). This toggle is pre-existing original-game code (not VR60-authored), runs every
V-INT regardless of the freeze, and only touches REN — never the actual `RES` bit
(`MARS_SYS_INTCTL` bit 1, "Resets SH2") — so it cannot be resetting Master mid-race. It is flagged
here purely as a documentation-accuracy finding worth fixing sometime (consistent with this
project's `feedback_audit_docs_glitch_addresses.md` practice of proactively catching stale/wrong
inline comments), **not** as a contributor to the hang.

### 10.5 Updated ranking

| Rank | Hypothesis | Status after this session |
|---|---|---|
| 1 | Master SH2 is not executing `master_poll_loop` at all (crashed, trapped, or diverted to an unidentified code path) by the time — or shortly after — the 68K's one-and-only cmd `$3E` trigger write occurs. | **Best-supported remaining explanation.** Every alternative this session checked for (hooks, gating, CMDINT, busy-elsewhere, transient hazard) is now ruled out with direct evidence, and the "persistent value + infinite busy-loop" argument (§10.4) shows a transient hazard is logically insufficient to explain a *permanent* miss. This leaves "Master genuinely isn't reaching/running the loop" as the explanation with the fewest unaddressed objections — though **no direct evidence of a Master crash/trap was found either**; this is elimination-based, not positive, confirmation. |
| 2 | The 68K's write and Master's read are not, at this specific moment, touching the same physical storage (a structural, not transient, disconnect) — e.g. some COMM-register aliasing/mirroring detail specific to this exact 32X/PicoDrive configuration not yet identified. | **Not disproven, no positive evidence either.** No symbol shadowing (§9.4), no register-offset mismatch (§8.3), and no bit-width/gating issue (§10.2) was found anywhere in the paths checked so far in any session. |
| 3 | A momentary COMM0 read-during-write hazard. | **Downgraded this session.** The persistent-value argument in §10.4 shows this cannot, by itself, cause a permanent miss — it would need to combine with something else (e.g., corrupt Master's PC on the bad read, folding into Hypothesis 1) to matter at all. |
| 4 | CMDINT/interrupt-driven dispatch as an alternate path for cmd `$3E`. | **Ruled out, high confidence (§10.3).** Confirmed dead by git history, never vector-wired, and would have targeted the wrong interrupt-mask bit even if it had been finished. |
| 5 | A dispatch-loop hook, patch, or command-value gate specific to `$3E` vs `$02`. | **Ruled out, high confidence (§10.1-10.2).** Full instruction-level re-decode of the entire dispatch path found no comparison/mask instruction anywhere, and no code outside `master_dispatch_hook` (confirmed dormant) targets this address range. |
| 6 | Master genuinely busy with unrelated work at the trigger instant. | **Ruled out, high confidence (§10.4).** cmd `$02` is synchronous and self-completing; the 7-V-INT (~116 ms) gap to state 8 vastly exceeds Master's documented per-frame utilization; no other SH2-touching code was found between them. |

### 10.6 What remains unresolved, and the recommended next step

The investigation across all four sessions has now eliminated essentially every hypothesis that
static analysis alone can test: the dispatch loop is unhooked and ungated, cmd `$3E` and cmd `$02`
are dispatched by bit-identical code, CMDINT is definitively dead infrastructure, and Master should
be idle and listening by construction. What is **left** is binary and can no longer be resolved by
reading more source: **either Master SH2 stops running `master_poll_loop` at some point before or
at the trigger (Hypothesis 1), or the write/read pair is structurally disconnected in a way no
`grep` or opcode decode will surface (Hypothesis 2).** Both require a *runtime* answer.

**Recommended next step (not implemented — read-only per this session's scope):** rather than
another one-shot sentinel (which only answers "was the handler entered," already known to be no,
§9.3), instrument `master_poll_loop` itself with a **live, continuously-updating trace**, analogous
in spirit to §9.2's technique but placed in the *loop*, not the handler:

- At `$020462` (right after `mov.b @r8,r0` loads the raw COMM0 byte, before the `cmp/eq`), add a
  store of that raw byte to a small, fixed, pre-validated-free scratch address (following §9.2's
  lesson: re-verify freeness with a `VRD_WATCH` first, do not reuse `$06011100`-class addresses
  without re-checking — `$2600FC00`'s sibling bytes, e.g. `$2600FC01`, are already confirmed
  quiet in this exact scenario and are a safe starting candidate). This produces a live "last COMM0
  byte value Master's poll saw" trace.
- Separately, increment a 1- or 2-byte counter at another fixed scratch address on every loop
  iteration (or every N iterations, to avoid overflow across 1800 frames) — a live "is `.poll_wait`
  still executing" heartbeat.
- Watch both via `VRD_WATCH` across the run. If the heartbeat counter is still advancing after the
  freeze point, Master is provably still alive and executing this exact loop, which would refute
  Hypothesis 1 and sharpen the investigation toward Hypothesis 2 (a structural read/write
  disconnect specific to this address/value, at which point PicoDrive's COMM-register read/write
  handlers in `third_party/picodrive/pico/32x/memory.c` — the `p32x_reg_read8/16`/`p32x_reg_write8/
  16` family, not yet read in this session — would be the next concrete file to audit line-by-line
  for any special-casing keyed on address `$20`/`$A15120` specifically). If the heartbeat counter
  stops advancing at or before the freeze, Master genuinely halts, which would confirm Hypothesis 1
  and redirect the investigation to Master SH2 exception vectors / fault handling (not yet located
  in this repository's checked-in analysis) as the new primary target.

**Caveat, stated for whoever implements this:** unlike §9.2's sentinel (placed in unused expansion
ROM slack), this instrumentation modifies **live, real-game dispatch code** inside
`code_20200.asm`'s `master_poll_loop` — the hottest, most safety-critical path in the entire SH2
side of the game, executed every single command dispatch across all game modes, not just 1P racing.
Per CLAUDE.md §10 ("SH2 Patching Discipline"), this requires scanning for every `MOV.L
@(disp,PC),Rn` literal-pool reference into this exact region before inserting any bytes (this
session's own re-read of the literal pool, §10.2, found at least one already-documented historical
collision at `$020480` from the old B-006 patches — a fresh insertion here would need to avoid
recreating that class of bug), and should go through an Auditor review before being attempted, given
it touches the command dispatch path used by every mode of the game, not an isolated expansion-ROM
handler.

---

## 11. Session 5: a profiler-tooling bug found, and a promising new emulator-level lead

**Role:** task manager (Claude), executing §10.6's proposed live-loop instrumentation directly,
with independent verification at every step.

### 11.1 A real bug found in the profiling tool itself, affecting prior COMM0/COMM1 observations

`tools/libretro-profiling/libretro_vrd_profiling_v4.patch`'s `vrd_r16`/`vrd_r8` (the functions
backing `VRD_WATCH`/`VRD_DUMP`) route every address to one of two buses:

```c
if (addr < 0x400000 || (addr >= 0xFF0000 && addr <= 0xFFFFFF))
    return PicoCpuFM68k.read_word(addr) & 0xFFFF;   /* 68K bus */
return p32x_sh2_read16(addr, &msh2) & 0xFFFF;        /* SH2 bus */
```

**`$A15120`/`$A15122`/`$A15126` (the 68K-side COMM0/COMM1/COMM3 addresses this and all prior
sessions watched) are >= `$400000` and outside the WRAM carve-out — so every watch of them in
this entire investigation was silently routed through the SH2 bus function, not the 68K bus.**
`$A15120` is not a meaningful SH2-space address at all; reading it via `p32x_sh2_read16` does not
reflect the real COMM0 register value as either CPU sees it. **This means every "COMM0/COMM1 read
0x0 throughout" observation in §1–§10 that used the 68K-side address form should be treated as
unreliable — not necessarily wrong, but not verified either.** (Watches of `$20004010`/`$20004020`
— genuine SH2-space addresses — and of SDRAM addresses like `$0600FC00`/`$2600FC00` were NOT
affected by this bug; those route correctly and their conclusions stand.)

**Corrected re-test**, watching COMM0 via its real SH2-side address (`$20004020`) instead:

```
frame,0xFFC87E,0xFF7B41,0xFF7B42,0x20004020,0x20004010,0x2600FC00
1259,  0x8,     0x1,     0x13E,   0x3E,      0xA0,      0x0
1799,  0x8,     0x1,     0x13E,   0x3E,      0xA0,      0x0
```

`$FF7B42` is a **new** 68K-side sentinel added this session (`move.w COMM0,$FFFF7B42`, inserted
immediately after the trigger write, before `.wait_ack` — a static, one-time snapshot of what the
68K's own next instruction reads back, with zero timing gap). It reads `$013E` — confirming the
write is real and immediately visible to the 68K itself. The **live**, continuously-sampled value
at `$20004020` (correct SH2-side address) shows `$003E` from the transition frame onward: **COMM0_LO
(`$3E`) persists indefinitely, but COMM0_HI reads back as `$00`**, not the `$01` the 68K's own
inline read just confirmed writing.

### 11.2 Observer-effect hypothesis tested and refuted

Before trusting the `$20004020` reading, the possibility that the *external tool's own read* was
altering the value (e.g. if the register had read-clear semantics and my once-per-frame `VRD_WATCH`
sample was "stealing" the flag before Master's poll loop could see it) was tested directly: the
identical 1800-frame run was repeated **watching no COMM-register address of any kind** (only
`$FFC87E`, the two WRAM sentinels, and the SDRAM handler-entry sentinel). Result: unchanged —
the handler-entry sentinel (`$2600FC00`) still reads `0x0` throughout. **The freeze is not an
artifact of external observation; it happens regardless of whether anything reads COMM0 at all.**

### 11.3 A significant, independently-surprising finding: COMM0_HI does not read back to 0 between commands

Checking the frame *immediately before* the transition (frame 1258, before the 1P hook's trigger
write executes at all) via the corrected `$20004020` address: **COMM0 already reads `$0102`**
(HI=`$01`, LO=`$02` — cmd $02's own command code) — i.e. **`mars_dma_xfer_vdp_fill`'s successful,
proven-working cmd `$02` trigger does not leave COMM0_HI cleared back to `0` once it completes.**
This directly contradicts the assumption (inherited from `analysis/sh2-analysis/
SH2_COMMAND_HANDLER_REFERENCE.md:34-37`'s description and repeated in §3.1/§10.4 of this document)
that cmd `$02`'s SH2-side handler "clears COMM0_HI before returning to the poll loop." Empirically,
between racing frames, COMM0_HI stays at `$01` continuously; only COMM0_LO changes (tracking
whichever command most recently fired).

### 11.4 A promising, not-yet-confirmed lead: PicoDrive's SH2 poll-detection/fast-forward optimization

Reading `third_party/picodrive/pico/32x/memory.c`'s COMM-port write handlers
(`p32x_reg_write8:453-475`, `p32x_reg_write16:608-627` — both the 8-bit and 16-bit paths, ruling
out a byte-vs-word distinction) found identical logic for every COMM register write:

```c
if (REG8IN16(r, a) != (u8)d) {           /* only if the value actually changes */
    REG8IN16(r, a) = d;
    p32x_sh2_poll_event(a, &sh2s[0], SH2_STATE_CPOLL, cycles);
    p32x_sh2_poll_event(a, &sh2s[1], SH2_STATE_CPOLL, cycles);
    sh2_poll_write(a & ~1, r[a / 2], cycles, NULL);
}
```

This is evidently PicoDrive's **CPU-idle/spin-detection optimization**: an SH2 core that appears to
be busy-waiting on an unchanging memory address can be fast-forwarded/skipped by the emulator to
save host CPU time, and `p32x_sh2_poll_event`/`sh2_poll_write` are how a write "wakes up" a core
that's been fast-forwarded past a poll loop. **Critically, the wake-up path is entirely skipped
if the newly-written value equals the value already stored** — the assignment itself is also
skipped in that case (`REG8IN16(r,a) = d` sits inside the same `if`). Given §11.3's finding that
COMM0_HI persists at `$01` from cmd `$02`'s last invocation, and every VR60 trigger (including
`vr60_entity_transfer`'s) also writes `$01` to COMM0_HI, **that specific byte-write is a
no-op for wake-up purposes on every VR60 trigger** — only the COMM0_LO write (a genuine value
change, e.g. `$02`→`$3E`) would fire the wake-up logic, and it targets a *different* register
offset than the one `master_poll_loop`'s `.poll_wait` actually tests (`.poll_wait` reads offset
`$00`/COMM0_HI, not offset `$01`/COMM0_LO).

**This is a plausible, not-yet-confirmed mechanism**: if PicoDrive's SH2 core has, by the time the
1P hook fires (~116ms / 7 V-INTs after Master last did anything, per §10.4's timing argument),
been classified as idle-polling and fast-forwarded past `master_poll_loop`, and if that
fast-forwarded state is *specifically* woken by a change at the exact byte-address the poll
condition reads (COMM0_HI, offset `$00`) rather than by a change anywhere in the COMM block, then
a trigger sequence that only genuinely changes COMM0_LO (because COMM0_HI is already stuck at its
"active" value from the last command and never returns to `0`) could leave Master's fast-forwarded
state undisturbed indefinitely — consistent with every observation so far: the write is real and
immediately visible to the 68K, the jump table is correct, the dispatch loop is unhooked and
ungated, and yet the handler never runs.

**This has NOT been confirmed** — it requires reading the SH2 core's own interpreter/dynarec
(`third_party/picodrive/cpu/sh2/sh2.c`, `compiler.c`) to understand exactly what `SH2_STATE_CPOLL`
and the poll-detection state machine do to a core's actual execution state, and whether this
mechanism can produce a *permanent* (not just delayed) miss. This is squarely a "read more, don't
guess" moment per the project's own research-first discipline, and is a substantially more
promising lead than continuing to instrument the live game-dispatch loop itself (§10.6's
originally-proposed next step) — if confirmed, the fix may not require touching
`master_poll_loop`, `cmd3e_entity_transfer`, or any other game code at all, only the VR60 trigger
sequence's *write pattern* (e.g. writing COMM0 as a single 16-bit word with a value guaranteed to
differ from its predecessor, or writing a `0` to COMM0_HI first to force a real transition before
writing `$01`).

### 11.5 Current repository state

All diagnostic sentinels described in §9-§11 remain in place (not yet reverted): the SH2-side
handler-entry sentinel and both bug fixes in `cmd3e_entity_transfer.asm`; the 68K-side
trigger-reached sentinel and immediate COMM0 read-back in `vr60_entity_transfer.asm`;
`vr60_entity_transfer` re-enabled in `vr60_1p_staging_hook.asm`. None of this is committed. The
hang is unchanged and fully expected in this state — this is instrumentation, not a fix attempt.

---

## 12. Session 6: resolving the PicoDrive poll-detection hypothesis

**Role:** Worker, read-only research. No `disasm/`, `third_party/`, build, or Makefile file
modified — only this document. Directly investigates §11.4's not-yet-confirmed lead by reading
`third_party/picodrive/pico/32x/memory.c`, `third_party/picodrive/pico/32x/32x.c`,
`third_party/picodrive/cpu/sh2/sh2.h`, and `third_party/picodrive/pico/pico_int.h` line-by-line.

### 12.1 What `SH2_STATE_CPOLL` and `p32x_sh2_poll_event` actually do

`SH2_STATE_CPOLL` is one of four bits collectively called `SH2_IDLE_STATES` — `"polling comm
regs"` (`cpu/sh2/sh2.h:50`), alongside `SH2_STATE_SLEEP`, `SH2_STATE_VPOLL` (VDP polling), and
`SH2_STATE_RPOLL` (SDRAM-address polling); the aggregate macro is defined at
`pico/32x/32x.c:20`: `#define SH2_IDLE_STATES (SH2_STATE_CPOLL|SH2_STATE_VPOLL|SH2_STATE_RPOLL|SH2_STATE_SLEEP)`.

The top-level scheduler, `sync_sh2s_normal()` (`pico/32x/32x.c:552-653`), is the answer to "does
this stop real instruction-by-instruction interpretation": at `32x.c:588` and `32x.c:602` it
gates the call to `run_sh2()` (the function that actually invokes `sh2_execute()`,
`32x.c:463-507`) behind `if (!(ssh2.state & SH2_IDLE_STATES))` / `if (!(msh2.state &
SH2_IDLE_STATES))` — **if the flag is set, `run_sh2` is not called at all** for that core, for
that entire scheduling quantum. Instead, at `32x.c:642-648` ("advance idle CPUs"), an idle core's
cycle-accounting (`m68krcycles_done`) is simply fast-forwarded to the target time with **zero
instructions executed**. This directly confirms the hypothesis's premise: **once flagged
CPOLL/VPOLL/RPOLL/SLEEP, a core genuinely stops being interpreted at all**, cycle after cycle,
until something explicitly clears the flag — it is not re-checked or nudged periodically on its
own. (`sh2_end_run()`, `pico_int.h:225-230` for the interpreter build actually in use here per
`master_command_loop.asm`'s reliance on `VRD_PROFILE_PC` forcing the interpreter — confirms the
same: it truncates the *current* timeslice immediately, it does not schedule a future recheck.)

`p32x_sh2_poll_event(a, sh2, flags, m68k_cycles)` (`memory.c:156-172`) is the wake function:

```c
void NOINLINE p32x_sh2_poll_event(u32 a, SH2 *sh2, u32 flags, u32 m68k_cycles)
{
  a &= ~0x20000000;
  if ((sh2->state & flags) && a - sh2->poll_addr <= 3) {
    ...
    sh2->state &= ~flags;
  }
  if (!(sh2->state & (SH2_STATE_CPOLL|SH2_STATE_VPOLL|SH2_STATE_RPOLL)))
    sh2->poll_addr = sh2->poll_cycles = sh2->poll_cnt = 0;
}
```

It clears the named idle bit(s) on `sh2` **only if two conditions both hold**: the bit is
currently set, **and** the address being written (`a`) is within `sh2->poll_addr .. poll_addr+3`
(`memory.c:159`, unsigned subtraction — this is a coarse 4-byte window test, not an exact-address
match). This is the single most important line for this investigation's question — see §12.4.

### 12.2 `sh2_poll_write` — a separate, unrelated mechanism (cross-CPU read-ordering, not wake-up)

`sh2_poll_write()` (`memory.c:226-264`) is **not** part of the wake path at all. It stores the
written value into a small per-address ring buffer (`sh2_poll_fifo[]`, `memory.c:186-193`) keyed
by address, tagged with the writing CPU's identity (`cpu = sh2 ? sh2->is_slave : -1`,
`memory.c:231`; the 68K passes `sh2=NULL`, i.e. `cpu=-1`). Its purpose, read together with its
counterpart `sh2_poll_read()` (`memory.c:196-224`), is to let a **different** CPU's *later, real*
memory read replay a value that was written slightly "in the future" relative to that CPU's own
cycle-accounting position, so cross-CPU synchronization doesn't observe values out of causal
order (the file's own header comment at `memory.c:183-185`: "stores writes to potential addresses
used for polling ... to correctly deliver synchronisation data to the 3 cpus"). It has **no
effect on any core's `state` bits** — it never sets or clears `SH2_STATE_CPOLL` and is entirely
orthogonal to whether a core is scheduled to run. **Answering the task's question 2 directly**:
`sh2_poll_write` and `p32x_sh2_poll_event` are unrelated sibling mechanisms called together
(same call sites, e.g. `memory.c:530-532`), not two names for the same thing; only
`p32x_sh2_poll_event` governs wake-up.

### 12.3 Where a core is classified as "polling" in the first place

`p32x_sh2_poll_detect(a, sh2, flags, maxcnt)` (`memory.c:118-154`) is called from the **real SH2
read path**, not a separate background checker: `p32x_sh2reg_read16()`'s comm-port case calls it
at `memory.c:791` (`p32x_sh2_poll_detect(a, sh2, SH2_STATE_CPOLL, 9)`), and its H-count/"often
used as comm too" case at `memory.c:757` (`maxcnt=5`). It requires the **same word-aligned
address** to be read again (`a - sh2->poll_addr <= 3`, `memory.c:127`) **within roughly 20 SH2
cycles of the previous qualifying read** (`CYCLES_GE(20, cycles_diff)`, same line, plus
`CYCLES_GT(cycles_diff, 2)` at `:128` to reject same-cycle 32-bit-split reads) for **`maxcnt`
consecutive such reads** (9, here) before it sets `sh2->state |= flags` and calls
`sh2_end_run(sh2, 0)` (`memory.c:135`) to stop the current timeslice immediately. Critically, if
either the address or the cycle-gap test fails on any given read, the `else` branch
(`memory.c:148-151`) **resets `poll_cnt` to 0 and re-anchors `poll_addr`** to the new address —
i.e., detection requires a *tight, sub-20-cycle, same-address* read loop, and real work (a full
command handler dispatch, which takes vastly more than 20 SH2 cycles) resets the counter every
time it happens. This directly answers the task's question 3: **entering "polling" classification
requires genuine, repeated execution of a short read loop** — it is not a separate periodic
scanner: an idle core is not re-checked "once per some fixed cycle count" once classified (§12.1
already established the scheduler skips it entirely); it is asleep **indefinitely** until
`p32x_sh2_poll_event` (or a hard reset / IRQ path, `32x.c:63-68` `p32x_update_irls`) explicitly
clears the flag.

**One address specifically checked and ruled out**: DREQ_LEN (`case 0x10/2`,
`memory.c:763-768`, `return r[a / 2];`) has **no `p32x_sh2_poll_detect` call at all** — unlike the
comm-port and H-count cases. This means `cmd3e_entity_transfer`'s own `.wait_done` spin on DREQ_LEN
(§2.3 step 9) and `mars_dma_xfer_vdp_fill`'s/`dmac_fifo_setup`'s equivalent inner wait can **never**
be classified CPOLL/idle by this mechanism — those spins are always genuinely, fully interpreted.
This matters because it confirms the *only* address range whose polling can register `poll_addr`
in the COMM block is the comm-port switch case itself (`0x20-0x2f`, plus the unrelated H-count
alias at `0x04-0x05`) — ruling out a scenario where Master's registered `poll_addr` could have
silently drifted to some unrelated DMA-status address by the time the 1P trigger fires.

### 12.4 Byte read of COMM0_HI is serviced by the 16-bit handler — poll_addr is the whole-word base, and the wake window is loose, not exact

`master_poll_loop`'s `.poll_wait: mov.b @r8,r0` (`code_20200.asm` per §10.2) is an **8-bit** read
of `$20004020` (COMM0_HI). Tracing PicoDrive's byte-read dispatch for this address range:
`sh2_read8_cs0()` (`memory.c:1498-1542`) recognizes `(a & 0x3ffc0) == 0x4000` (the sys-register
block, `memory.c:1506`) and does **not** have its own byte-granularity poll-detect path — it
calls straight into the **16-bit** handler, `p32x_sh2reg_read16(a, sh2)` (`memory.c:1507`), and
only *afterwards* extracts the correct half-byte (`out_16to8:`, `memory.c:1531-1535`). Inside
`p32x_sh2reg_read16`, `a &= 0x3e;` (`memory.c:750`) rounds the address down to the **even, 2-byte-
aligned base of the word** — for `$...4020` this is `0x20` regardless of whether the original
access targeted the even (HI) or odd (LO) byte. The comm-port case then calls
`p32x_sh2_poll_detect(a=0x20, sh2, SH2_STATE_CPOLL, 9)` (`memory.c:791`). **So Master's `poll_addr`,
once registered from its byte-wide reads of COMM0_HI, is recorded as `0x20` — the shared,
word-aligned base address of the whole COMM0 register (both HI and LO bytes), not a HI-byte-
specific address.**

Now the write side. The 68K's trigger sequence (`mars_dma_xfer_vdp_fill.asm:24-25`,
`vr60_entity_transfer.asm`, both: write COMM0_LO first, then COMM0_HI) reaches
`p32x_reg_write8()`'s shared comm-port case (`memory.c:507-535`, cases `0x20`-`0x2f` all share one
body). For the COMM0_LO write specifically, `a == 0x21`. The guard at `memory.c:528`
(`if (REG8IN16(r, a) != (u8)d)`) passes for this write **because COMM0_LO's value does change**
(`$02` → `$3E`, or whatever the previous command was), so `p32x_sh2_poll_event(a=0x21, &sh2s[0],
SH2_STATE_CPOLL, cycles)` **is called** (`memory.c:530`; `sh2s[0]` is confirmed to be `msh2`/Master
via `#define msh2 sh2s[0]`, `pico_int.h:221`). Inside `p32x_sh2_poll_event`, the wake test is
`a - sh2->poll_addr <= 3` (`memory.c:159`) — with `a=0x21` and `sh2->poll_addr=0x20`, this is
`0x21 - 0x20 = 1 <= 3` → **true**. Combined with `sh2->state & SH2_STATE_CPOLL` being true (Master
was actually classified idle), the wake fires: `sh2->state &= ~SH2_STATE_CPOLL` — **Master's idle
flag is cleared by the COMM0_LO write alone**, independent of whatever the subsequent COMM0_HI
write does or does not do.

**This directly answers the task's question 4: the wake condition is a coarse ±3-byte address
window relative to `poll_addr`, not an exact match against the specific byte the polled
instruction reads.** The window (`poll_addr` through `poll_addr+3`) covers **all four bytes of
COMM0 and COMM1** from a `poll_addr` anchored at COMM0's base — so *any* write anywhere in that
4-byte span that actually changes value wakes the core, regardless of which exact byte the
`.poll_wait` instruction itself tests.

### 12.5 Verdict: the §11.4 hypothesis is REFUTED

Per §12.4, the COMM0_LO write (`$02`→`$3E`, a genuine value change) is, by itself, **sufficient**
to clear Master's `SH2_STATE_CPOLL` — the fact that the immediately-following COMM0_HI write is a
same-value no-op (`memory.c:528`'s guard skipping it, per §11.4's own correct observation) is
**irrelevant to the wake**, because the wake was already triggered by the LO write moments earlier
in the same straight-line instruction sequence, and the ±3-byte window means the LO write's own
address independently satisfies the wake test without ever needing to touch the HI byte.

This is not merely a theoretical rebuttal — it is empirically load-bearing given a fact already
established earlier in this document: **`mars_dma_xfer_vdp_fill.asm` (cmd `$02`, §3.1) uses the
byte-for-byte identical two-write idiom** (COMM0_LO write, value-changing; COMM0_HI write, always
`$01`, frequently a same-value no-op per §11.3's finding that COMM0_HI never returns to 0) **and
demonstrably dispatches successfully every single racing frame** (§8.4 traced its handler calling
`dmac_fifo_setup`; the entire rendering pipeline depends on it running every frame; CLAUDE.md's own
profiling numbers — 158,977 useful Master cycles/frame — are impossible if cmd `$02` were not
reliably dispatched). Since cmd `$02`'s trigger goes through the **exact same** `p32x_reg_write8`
comm-port code path (`memory.c:507-535`) as cmd `$3E`'s, with the **exact same** same-value-skip
behavior on its own HI-byte write, and it works every frame, **the specific failure mode proposed
in §11.4 — "the COMM0_HI same-value write skips the wake, and this permanently starves a
fast-forwarded Master" — cannot be the explanation for cmd `$3E`'s hang**, because if it were, cmd
`$02` would exhibit the identical failure and the game would not render at all. The mechanism this
session read in full (§12.1-§12.4) shows *why* it doesn't fail: the wake test's address tolerance
is loose enough that the LO write alone is enough, for both commands equally.

**Task question 5 (reconciling "COMM0_HI never returns to 0" with `.poll_wait` making sense)**:
partially resolved, flagged as inference rather than fully proven. Decoded literally
(`master_command_loop.asm`/§10.2: `cmp/eq #0,r0` / `bt .poll_wait` loops *while* the byte is zero,
falls through once non-zero), once COMM0_HI is permanently non-zero the loop no longer performs a
literal multi-iteration "wait" — it falls through to dispatch on every pass and reads whatever is
currently in COMM0_LO. This does not, by itself, imply the emulator can never classify Master as
CPOLL again: `p32x_sh2_poll_detect`'s window test (§12.3) keys purely on *repeated reads of the
same address within ~20 SH2 cycles*, regardless of what happens in between two such reads. A real
per-frame dispatch (e.g. cmd `$02`'s actual DMA/render work) takes far more than 20 cycles and
resets `poll_cnt` every time (`memory.c:148-151`); only a dispatch that returns to the top of the
loop **fast** (within the ~20-cycle window, repeated ≥9 times) accumulates toward the CPOLL
threshold. This reconciles the empirical fact (COMM0_HI never clears) with both correct gameplay
and with PicoDrive's own idle-classification model **without requiring COMM0_HI to ever return to
zero** — the protocol this ROM actually implements is best understood as level-triggered on
COMM0_LO's *content*, with COMM0_HI functioning as an initial "unblock the very first wait" latch
that (per this session's reading, not a full disassembly of every command handler) is apparently
never designed to be un-latched again. **This part is offered as the most evidence-consistent
reading available from what was read this session, not as an independently verified disassembly
finding** — verifying it fully would require finding the specific point (if any) where a
dispatched handler's "nothing new to do, return fast" path exists, which was not undertaken here
and is not necessary to settle question 6.

### 12.6 Conclusion and recommended next step

**Confirmed by reading code (not inference):**
- `SH2_STATE_CPOLL`-classified cores are not interpreted at all until explicitly woken (§12.1,
  `32x.c:588,602,617,621,642-648`) — no periodic recheck exists.
- The wake test (`p32x_sh2_poll_event`, `memory.c:159`) is a **±3-byte address window**, not an
  exact-byte match (§12.1, §12.4).
- A byte-wide read of COMM0_HI registers `poll_addr` at COMM0's **word-aligned base** (`0x20`),
  which the wake window already covers for a write to COMM0_LO (`0x21`) (§12.4).
- DREQ_LEN reads never register as pollable (§12.3), ruling out `poll_addr` drift to an unrelated
  DMA-status address.

**Verdict: REFUTED.** The "COMM0_HI same-value write starves the wake-up, permanently missing
Master" hypothesis from §11.4 does not hold, because the COMM0_LO write alone — present, unchanged,
in both cmd `$02`'s and cmd `$3E`'s 68K-side trigger code — already satisfies PicoDrive's loose
address-window wake test, and cmd `$02` proves this path works every single racing frame. **No fix
to the VR60 trigger's write pattern is warranted from this angle**: none of the three candidate
fixes floated in this task (single 16-bit MOVE.W; force a 0→1 transition on COMM0_HI; or
"something else") address a real defect, because there isn't one at this layer. Applying candidate
(a) or (b) anyway would be a no-op at best (the wake already fires) and would not be justified by
what was read this session — per this project's Ground Rules (`CLAUDE.md` §"Do Not Guess"), a fix
should not be applied for a hypothesis just refuted by direct code reading.

This closes out the emulator-level lead opened in §11.4 and returns the investigation to §10.5's
ranking, now with one fewer live hypothesis to weigh: **Hypothesis 1 (Master is not executing
`master_poll_loop` at all by the time cmd `$3E` fires — crashed, trapped, or diverted) and
Hypothesis 2 (the 68K write and Master's read are structurally disconnected for some other reason)
remain the only two standing explanations**, and §10.6's proposed live-loop heartbeat
instrumentation (a continuously-updating counter placed inside `master_poll_loop` itself, watched
across the hang) is still the correct, cheapest next empirical step to discriminate between them —
now with added confidence that it is not chasing an emulator-side red herring, since this session
has read the relevant PicoDrive mechanism in full and found it to be sound and generic for this
exact trigger idiom.

---

## 13. Session 2026-07-13 continued — the retry fix, a false-positive verification, and a live hang

**This section is the cautionary coda to §12.6's own warning.** §12.6 explicitly said "a fix
should not be applied for a hypothesis just refuted by direct code reading." A later pass in this
same investigation (not documented here before now — a gap this section corrects) built the
`VRD_SH2_STATE` diagnostic (reads `sh2s[0].state`/`poll_addr`/`poll_cnt` directly, added to
`third_party/picodrive/platform/libretro/libretro.c`, zero game-ROM risk) and used it to observe
Master transiently polling a *different* address (COMM2, `$20004024`) at the moment the 68K's
one-shot cmd `$3E` trigger landed. That observation motivated a retry fix — force a genuine 0→1
transition on COMM0_HI and retry with a short settle delay until COMM1_LO's ACK bit is seen —
applied first to `vr60_entity_transfer.asm`, then headlessly re-tested: DREQ_LEN drained, the SH2
sentinel fired, `msh2.state` cycled healthily, `fb_crc` matched baseline. **This looked like a
clean, evidence-backed win**, and the fix was extended to the sibling functions
(`vr60_ai_entity_transfer.asm`, `vr60_globals_transfer.asm`, `vr60_comm_trigger.asm`, the last
adapted for its fire-and-forget contract) and the full `vr60_1p_staging_hook.asm` body was wired up
to match `state4_epilogue`'s call order.

### 13.1 The verification was never actually exercising real GP racing

While trying to headlessly verify the *full* hook body, every diagnostic sentinel read zero,
`VR60_1P_FLAG` never latched, and `$C87E` (the 1P state-dispatch index) read `0x0` for 1799/1800
sampled frames — even with the previously-"working" minimal 3-call hook. Tracing this down:
`profiling_frontend`'s `[racing]` progress-bar label (`profiling_frontend.c:333-336`) is a **naive
frame-count heuristic** (`frame < 1200 ? "menus" : "racing"`), not derived from any real game
state. Watching the actual scene-handler word (`$FF0004`) across an 1800- and then 3600-frame
`--autoplay` run showed the game settling into scene `$5586` (`state_disp_005586`, **Free Run /
Time Attack** — confirmed against `VR60_DISPATCHER_ROUTING.md`) by frame ~395 and **never leaving
it** for the rest of either run. `--autoplay`'s canned input (`profiling_frontend.c:118-153`: press
START blindly every 90 frames, then hold A after frame 1200, comment assumes "Grand Prix default"
cursor position) does not actually reach scene `$4CBC` (`state_disp_004cb8`, real 1P GP racing) at
all — confirmed the same even with **no input whatsoever** (attract/demo mode also lands in
`$5586`). `frame_update_orch_0055d0.asm` (Free Run's per-frame orchestrator) does not call
`game_frame_orch_013` — grepped, zero references — so `vr60_1p_staging_hook` is structurally
unreachable under every headless test run this session, before and after the retry fix. **Every
"verified working" result, including the original entity_transfer fix's, was measured against a
code path that never executes the hooked code at all.** This was never caught earlier because
`$4CBC` (cited correctly in `VRD_PROFILING.md:26` and `VR60_DISPATCHER_ROUTING.md`) was trusted as
what `--autoplay` reaches, and no one had checked that assumption against the scene word directly
until this session.

### 13.2 Real GP racing hard-hangs the 68K

Matias manually navigated PicoDrive into Free Run (not GP — a mode mix-up on the first attempt)
and saved a state; loading it headlessly (via a new `VRD_LOAD_STATE` capability added to
`profiling_frontend.c` — confirmed format-compatible with standalone PicoDrive's own savestates,
since both funnel through the identical `PicoStateFP`/`pico_state_internal` serialization in
`pico/state.c`, differing only in the `.gz` wrapper standalone adds) confirmed scene `$5586` again,
consistent with §13.1. Matias then tried reaching real GP directly in PicoDrive with the full hook
built in — the game hard-hung (black screen right after the boot logos, audio still running,
implying the 68K froze while SH2/Z80 kept running). Reverting `vr60_1p_staging_hook.asm` alone
(back to a bare passthrough) **did not fix it** — the black screen persisted on a fresh relaunch.

**Root cause: `vr60_entity_transfer.asm`, `vr60_ai_entity_transfer.asm`,
`vr60_globals_transfer.asm`, and `vr60_comm_trigger.asm` are not 1P-exclusive.** All four are
called unconditionally, every frame, by `state4_epilogue` (`code_2200.asm`, the always-active
2P/demo path) — confirmed by an Explore-agent read of `state4_epilogue`'s complete body. Editing
them to add an unbounded retry loop (`.retrigger: ... beq.s .retrigger`, no attempt limit) changed
already-working, always-executing functionality, not just the dormant 1P hook. If the ACK never
arrives in whatever context the demo/2P path actually exercises this in — plausible given §13.1
already proved the fix's only "verification" ran in a context that never called this code at all —
the 68K spins forever, frozen: exactly the observed symptom.

### 13.3 Full revert

All four files were reverted to `HEAD` (`git checkout HEAD -- <files>`), restoring their original,
always-shipped synchronous `wait_ack` pattern. `vr60_1p_staging_hook.asm` was cleaned up to a pure,
clearly-commented passthrough. Rebuilt (`make clean && make all`) and Matias confirmed, on a fresh
PicoDrive relaunch, that the black screen is gone. `cmd3e_entity_transfer.asm`'s two independently
hardware-manual-justified bug fixes (DMAOR needs `mov.l` not `mov.w`; CHCR0's address-mode fields
were transposed — §3 and §8.2) do not depend on the reverted retry logic and were kept; the
diagnostic sentinel there is harmless (a stray write to an inert scratch SDRAM address) and can be
removed in a future cleanup pass.

### 13.4 Lessons

- **§12.6's caution was correct and should have been followed more strictly**: a fix motivated by
  a plausible-sounding emulator-state observation still needs to be verified against the *actual*
  code path it's meant to fix, not just a headless run that merely doesn't crash.
- **A passing headless test is not evidence the tested code path executed at all.** Always confirm
  the scene/state word directly (`$FF0004` here) rather than trusting a frame-count-based label or
  an assumption about what `--autoplay` reaches.
- **Shared/reused functions are not safe to "fix" for one caller's problem without checking every
  caller.** `vr60_entity_transfer.asm` and its siblings serve both the working 2P path and the
  experimental 1P hook; a change scoped to "fix 1P" silently became a change to 2P's already-working
  behavior.
- **Unbounded retry loops on a hardware/emulator ACK are a standing hazard.** If a retry-based fix
  is attempted again, it must have a hard attempt cap — falling through to "give up this frame,
  don't hang" is always safer than looping forever on an assumption that might be wrong.
- **New reusable capability**: `VRD_LOAD_STATE=path` in `profiling_frontend.c` loads a real
  savestate (from standalone PicoDrive or this same headless core) before the frame loop starts,
  finally making it possible to headlessly test scenes `--autoplay` can't reach (real GP racing
  chief among them). Still needed: an actual GP-racing (not Free Run) savestate, since the one
  captured this session was the wrong mode.

**Status: back to the Phase 0 baseline, fully reverted, confirmed safe.** No SH2-offload code is
wired into 1P racing. Next attempt at fixing the cmd `$3E`/`$3F` dispatch gap (if pursued) should:
(1) get a real GP-racing savestate first, (2) use bounded retries, (3) implement any new logic in
1P-exclusive copies of the transfer functions rather than editing the shared
`vr60_*_transfer.asm`/`vr60_comm_trigger.asm` files, so a wrong fix can never again hang the
already-working 2P/demo path.

## 14. Session 2026-07-13 continued — a real GP savestate, and a premature "it works" reversed

A real GP-racing savestate was captured (Matias selecting "Virtua Racing" from Mode Select,
confirmed via `$FF0004` reading `$4CBC` across 300+ sampled frames — the actual in-game menu label
is "Virtua Racing", not "Grand Prix"; saved at
`tools/libretro-profiling/savestate_1p_gp_racing.bin`, gitignored). Re-wired the ORIGINAL,
unmodified `vr60_entity_transfer.asm` chain (entity_stage + globals_stage + entity_transfer, no
retry logic, gated first-frame-only by `VR60_1P_FLAG`) into `vr60_1p_staging_hook.asm` as a
ground-truth test: does cmd `$3E` actually hang against real GP racing, or was every earlier "hang"
observation confounded by the `--autoplay`-reaches-Free-Run gap (§13.1)?

**Initial result looked like a clean answer**: 1800 consecutive frames, no hang, `VR60_1P_FLAG`
never latched (so `vr60_entity_transfer` re-ran every sampled frame instead of once), yet the SH2
canary (`$2600FC00`) read nonzero on 1798/1800 samples and `DREQ_LEN` cycled through many draining
values. Read as: cmd `$3E` dispatches and completes successfully under real GP racing with the
plain, unmodified code — no race condition after all.

**This was wrong, and caught by a much stronger check.** Trying to root-cause why `VR60_1P_FLAG`
never latches (even with an unconditional, first-instruction write, and even to a totally
unrelated scratch address `$FFFFD000` — ruling out an address-specific WRAM collision), a
`VRD_PROFILE_PC` histogram over the same 300-frame run showed **zero samples anywhere in
`game_frame_orch_013`'s entire original address range** (`$884D1A-$884D98`) across 823,113 total
sampled 68K instructions — and correspondingly zero samples in `vr60_1p_staging_hook`'s relocated
body either. **The hook was never entered at all in this test.** State 8 (`game_frame_orch_013`,
"Path A") is transient — it fires once, right at the loading→driving transition, and per the
earlier Explore-agent finding (§ "the transient nature of state 8"), state `$0C` (Path B) never
advances the dispatch index again once reached, so it never recurs later in the race. The
savestate was captured **mid-race**, after that one-shot transition had already passed, so the
hook structurally could not run in this window. The canary/`DREQ_LEN` activity observed was almost
certainly stale data already present in the savestate's SDRAM snapshot from Matias's play session,
or unrelated DREQ traffic from the stock render pipeline's own block copies sharing the same
hardware register — not evidence of this hook's code running at all.

**Lesson**: a memory-write side effect "looking right" (nonzero canary, plausible-looking cycling
values) is not sufficient evidence a code path executed — it can be residual state from before the
test began. **PC-histogram profiling (`VRD_PROFILE_PC=1`), which counts every sampled instruction
directly, is a much stronger check than inferring execution from downstream memory effects,** and
should be the first thing reached for when a "does X code path run" question matters, not the last.

**Status: unchanged from §13's revert** (still fully safe, inert passthrough) — this session did
not find new evidence either for or against a real cmd `$3E` race condition, because the test
never actually exercised the code path it was meant to test. **Still needed**: a savestate captured
AT (or just before) the race-start transition — not mid-race — so state 8 fires within the test
window.

## 15. Session 2026-07-13 continued — Path A is dead code; the real 1P driver is elsewhere

Matias captured three further savestates chasing the state-8 transition (mid-race, a hand-timed
"instant of gaining control", and finally one at the Loading screen, before scene init runs). Each
was tested with a `VRD_PROFILE_PC=1` histogram checked against `game_frame_orch_013`'s exact
address range (`$884D1A-$884D98`), across window sizes up to 28.5 million sampled 68K instructions
(150 real seconds) from the mid-race savestate alone, and with a newly-added `VRD_HOLD_INPUT` env
var (holds a joypad button from frame 0, independent of `--autoplay`'s menu-timing logic) to rule
out "maybe it needs player input to reach state 8". **Zero hits in every single test**, across four
independent savestates/conditions and two independent methodologies (PC histogram, direct
unconditional memory writes that persist regardless of sampling granularity).

Along the way, a real methodological trap was caught and corrected: the PC histogram CSV has a
second category, `WRAM_CALLER` (call-site return addresses for JSRs originating from self-modified
WRAM code), separate from the plain `68K` category — filtering on `$1=="68K"` alone silently
discards this data. Early re-analysis mistook heavy `WRAM_CALLER` hits at `$884D8E`/`$884D96` for
evidence the hook was firing; precise range-checking showed these addresses are in **Path B**
("`; --- path B: minimal update ---`", state `$0C`'s handler, `game_frame_orch_013.asm:66-73`) —
specifically its own `move.w #$0054,$00FF0008` and `rts` — not Path A (state 8, where the hook
lives, `$884D1A-$884D62`), which showed **zero** hits in every single check.

**Conclusion: Path A (`game_frame_orch_013`'s "full frame update", where the VR60 1P hook was
wired) is dead code during real 1-player gameplay.** State `$C87E` apparently transits 0→4→8→12
at most once, very early (likely during scene initialization itself, before `state_disp_004cb8`
even becomes the active scene handler — see `race_scene_data_loader.asm:18`, which sets
`$FF0002=$00894262`, a third, different handler, as part of the loading sequence), and Path B
(state `$0C`) is what persists and runs every frame thereafter. Path B itself is lightweight
(sound, controller read, frame counter, AI buffer setup only — no entity/physics/render calls), so
it cannot be the real per-frame game-logic driver either.

**The actual per-frame entity/physics/AI driver was traced (partially) to
`race_frame_main_dispatch_entity_updates`** (`disasm/modules/68k/game/race/
race_frame_main_dispatch_entity_updates.asm`, ROM `$006D9C-$006F98`) — this function's body
contains the real physics pipeline (`entity_force_integration_and_speed_calc`,
`entity_speed_clamp`, `tilt_adjust`, `drift_physics_and_camera_offset_calc`,
`suspension_steering_damping`, `entity_pos_update`, `ai_opponent_select`,
`collision_response_surface_tracking`, `race_pos_sorting_and_rank_assignment`, etc.) and calls
`race_entity_update_loop` repeatedly across three entity batches. `race_entity_update_loop`'s own
body is confirmed executing heavily in every real-racing PC histogram this session (e.g.
`$885A24-$885AB2`, thousands of samples each). Its only found static caller is
`race_scene_data_loader.asm:45` (`jsr race_frame_main_dispatch_entity_updates+448`) — but that call
site is itself deep inside a one-time scene-loading sequence (the same function that writes
`$FF0002=$00894262`), not an obviously-recurring per-frame call — so **the exact recurring trigger
for `race_frame_main_dispatch_entity_updates` (or whichever of its internal entry points actually
runs every frame) is not yet fully pinned down.** This needs its own dedicated tracing session
before any new VR60 1P hook can be designed.

**Actionable status**:
- Confirmed dead: `game_frame_orch_013` / Path A / the current VR60 1P hook location. Any future
  1P SH2-offload work must NOT reuse this insertion point — it is provably unreachable during real
  gameplay across every tested scenario.
- Confirmed alive, real: `race_entity_update_loop` and (by strong inference) the surrounding
  `race_frame_main_dispatch_entity_updates` physics/AI pipeline. This is almost certainly the
  correct place to look for a 1P hook point in any future session.
- New reusable tooling: `VRD_HOLD_INPUT=mask` in `profiling_frontend.c` (hold a joypad button from
  frame 0, independent of `--autoplay`).
- `vr60_1p_staging_hook.asm` left in its safe, inert-passthrough, diagnostic-marker-cleaned state
  (the temporary `move.b #$7E,VR60_1P_FLAG` ground-truth-test write should be removed before any
  future session builds on top of this — it served its diagnostic purpose and is now stale).
