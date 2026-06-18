# VR60 Phase 5F-0 — Render-Input Layout Verification (the SH2→render bridge go/no-go)

**Created:** 2026-06-18
**Author:** Worker (READ-ONLY research role — NO code written, no asm/Makefile modified)
**Status:** RESOLVED. This document answers Phase 5F-0 (the FIRST sub-step of `VR60_PHASE5F_SCOPING.md` §G).
**Method:** Disassembly trace of the actual Slave 3D-engine bytes (`dc.w` SH2 opcodes), decoded by hand + script, cross-checked against the architecture docs. Every load-bearing claim is cited to `file:line` + ROM/SDRAM address.

---

## TL;DR — the one-sentence answer

> **GO.** The Slave 3D engine reads each per-entity 48-byte transform/position state from **SDRAM** —
> `$0600CA60` (batch 1, 4 ent), `$0600CB20` (batch 2, 8 ent), `$0600CD30` (batch 3, 8×`$90`) —
> via `R13` in the entity loop `$060024DC`, then **copies it into Slave on-chip SRAM `$C0000740`**
> (subroutine `$06002514`) before the renderer at `$C0000000` consumes it.
> Those SDRAM state arrays are **populated each frame by the Slave cmd `$02` setup routines**
> (`$0600252C`/`$060022BC`/`$06002394`/`$060022B0`/`$06002384`/`$06002494`, invoked from the cmd `$02`
> handler `$06000FA8`) **from the SDRAM display-object/descriptor tables** (`$0600C100`/`$0600C128`/
> `$0600C178`/`$0600C218`/`$0600C254`), which are themselves the **DREQ FIFO landing of the 68K
> display objects** built by `object_table_sprite_param_update` (`$0036DE`) and DMA'd via
> `mars_dma_xfer_vdp_fill` (`$0028C2`).

Because the source is SDRAM (cache-through `$2600xxxx` writable by either SH2), **the Master CAN inject
per-entity render state** — H-9 does NOT bite, because the on-chip SRAM `$C0000740` is only a *transient
per-entity working copy* loaded FROM the SDRAM state each iteration; it is never the source of truth.

---

## 1. The discrepancy — RESOLVED

All three address families are **real literals in the live cmd `$02` handler** (`code_20200.asm`,
literal pool `$021040`–`$021096`). They are NOT alternatives; they are **different roles in the same
state-array block**:

| Address | Role | Evidence |
|---------|------|----------|
| `$0600CA00` | **Batch-0 setup base** — passed to setup routine `$06002494` (NOT the entity-render loop). | `code_20200.asm:1846` (lit `$021060=$0600CA00`); handler loads `R13=$0600CA00, R14=$0600C100, JSR $06002494` at `code_20200.asm:1775-1778` (`$020FD2`–`$020FD8`). |
| `$0600CA60` / `$0600CB20` / `$0600CD30` | **Entity-render-loop state bases** (batches 1/2/3) — passed to the entity loop `$060024DC`. | `code_20200.asm:1859,1865,1871` (lits `$0600CA60`/`$0600CB20`/`$0600CD30`); each loaded into `R13` immediately before `JSR $060024DC` at `$020FEA`/`$020FF4`/`$021008` (`code_20200.asm:1787,1792,1802`). |
| `$0600C800` (32×`$10`) | Huffman / cmd `$23` entity data — a **different data class** (cmd `$23` path `$06004AD0`), not the cmd `$02` per-entity transform input. | `SH2_RENDERING_ARCHITECTURE.md:119-127,133`. |

**Numeric relationships that explain the "near but not equal" confusion:**
- `$0600CA60` = `$0600CA00` + `$60` (batch-0 region precedes batch-1 region).
- `$0600CD30` = `$0600CCA0` + `$90` (one outer stride).

**Why `render_state_patcher` (`$0600CA00` / `$0600CCA0`) is a verified no-op:**
The patcher writes the **batch-0 base `$0600CA00`** (`render_state_patcher.asm:131,307`) and the
**`$0600CCA0` AI base** (`:166,310`). But the entity-render loop reads `$0600CA60`/`$0600CB20`/`$0600CD30`.
`$0600CA00` is consumed only by setup routine `$06002494` (which *overwrites* the CA00 region from the
descriptor tables each frame — see §3), and `$0600CCA0` is `$90` short of the batch-3 base `$0600CD30`.
So the patcher writes (a) a region that is regenerated from the descriptors every frame before the loop
runs, and (b) an address the loop never reads — exactly matching the independently-measured **0% render
change** (`VR60_PHASE5F_SCOPING.md:72-74`). **The patcher was written against a guessed/stale layout.**
Confirmed: do NOT build the bridge on the patcher's literals.

---

## 2. The per-entity input source — exact trace (the load-bearing decode)

### 2.1 Slave dispatch → cmd `$02` handler
- Slave poll loop `$06000592` polls COMM2_HI, indexes jump table `$060005C8`; cmd `$02` → `$06000FA8`
  (`SLAVE_SH2_DISPATCH_ARCHITECTURE.md:53-72`).

### 2.2 cmd `$02` handler `$06000FA8` (= ROM file `$020FA8`, `code_20200.asm:1754`+)
Decoded from the `dc.w` bytes. The three render batches each set `R13`=SDRAM state base, `R14`=SDRAM
descriptor base, `R7`=count, then `JSR $060024DC`:

```
$020FEA  DD23  MOV.L  R13 <- $0600CA60      ; code_20200.asm:1787  batch1 state
$020FEC  DE23  MOV.L  R14 <- $0600C128      ;            :1788  batch1 descriptor
$020FEE  D024  MOV.L  R0  <- $060024DC      ;            :1789
$020FF0  400B  JSR    @R0                   ;            :1790  → entity loop, R7=4
$020FF4  DD23  MOV.L  R13 <- $0600CB20      ;            :1792  batch2 state
$020FF6  DE24  MOV.L  R14 <- $0600C178      ;            :1793  batch2 descriptor
$020FF8  D021  MOV.L  R0  <- $060024DC      ;            :1794
$020FFA  400B  JSR    @R0                   ;            :1795  R7=8
$021008  DD21  MOV.L  R13 <- $0600CD30      ;            :1802  batch3 state
$02100A  DE22  MOV.L  R14 <- $0600C254      ;            :1803  batch3 descriptor
... outer loop R13 += $90 ($021018-$02101A), R14 += $3C ($021020), JSR $060024DC
```

### 2.3 Entity loop `$060024DC` (= ROM file `$0224DC`, `code_22200.asm:374`+) — DECODED
```
$0224DC  4F22  STS.L PR,@-R15
$0224DE  85E0  MOV.W @(0,R14),R0      ; read active flag from DESCRIPTOR (R14)
$0224E0  8800  CMP/EQ #0,R0
$0224E2  890C  BT    $0224FE          ; inactive → skip
$0224EA  B013  BSR   $022514          ; *** copy 48B SDRAM state → on-chip SRAM ***
$0224EE  5DE4  MOV.L @(16,R14),R13    ; R13 = polygon-data ptr from descriptor+$10
$0224F0  DE06  MOV.L R14 <- $C0000700 ; on-chip render context
$0224F2  D007  MOV.L R0  <- $C0000000 ; on-chip renderer entry
$0224F4  400B  JSR   @R0              ; run on-chip renderer (Pipeline 1)
$0224FE  7D30  ADD   #48,R13          ; state stride +$30
$022500  4710  DT    R7
$022502  8FEC  BF/S  $0224DE
$022504  7E14  ADD   #20,R14          ; descriptor stride +$14
```
(`code_22200.asm:374-`; decode reproduced via script over the `dc.w` bytes.)

### 2.4 The copy subroutine `$022514` — the H-9 question, answered
```
$022514  DC04  MOV.L R12 <- $C0000740 ; on-chip SRAM edge buffer (literal @$022528)
$022516  E70C  MOV   #12,R7           ; 12 longwords = 48 bytes
$022518  60D6  MOV.L @R13+,R0         ; *** SOURCE = R13 = SDRAM state ($0600CA60+N*$30 ...) ***
$02251A  2C02  MOV.L R0,@R12          ; DEST = on-chip SRAM $C0000740
$02251C  4710  DT    R7
$02251E  8FFB  BF/S  $022518
$022520  7C04  ADD   #4,R12
$022522  000B  RTS
```
(`code_22200.asm` region `$022514`–`$022522`.)

**This is the crux for go/no-go:** the on-chip SRAM `$C0000740` (Pipeline 1, Slave-private, H-9) is a
**per-entity scratch copy loaded FROM the SDRAM state every iteration**. It is never authoritative and
never persists. The authoritative per-entity transform input is the **SDRAM state array** at `R13`. A
Master write to `$0600CA60+N*$30` (etc.) before the Slave's cmd `$02` runs *would* flow into the render —
**provided it survives the per-frame regeneration in §3** (see the GO caveat).

---

## 3. Who writes the SDRAM state each frame (the WRITER)

The cmd `$02` handler, **before** the three entity-loop calls, runs the setup chain (decoded from
`code_20200.asm:1754-1804`):

```
$020FAA  JSR $060045CC                         ; init
$020FB6  JSR $0600252C                         ; (= the on-chip SRAM boot-copy stub region / setup)
$020FBE  JSR $060022B0
$020FC4  JSR $06002384
$020FCC/CE JSR $06002394  (R0 = $0600C0CC)      ; per-batch state builder
$020FD2  R13=$0600CA00, R14=$0600C100, JSR $06002494   ; batch-0 state build
$020FE4  JSR $06002394  (again)                 ; batch builder reused per batch
```

These setup routines read the **SDRAM descriptor/display-object tables** (`$0600C100`/`$0600C128`/
`$0600C178`/`$0600C218`/`$0600C254`, all loaded as handler literals at `code_20200.asm:1849,1861,1867,
1873`) and **write the 48-byte transform-state arrays** at `$0600CA00`/`CA60`/`CB20`/`CD30`. (Handler
`$05`, the racing per-frame render `$06001924`, uses the identical literal family — `code_20200.asm:1844-
1614` region, lits `$0600CA00`/`$0600CA30`/`$0600CB20`/`$0600CCA0`/`$0600CD90` at `:1844,1859-,021604,
02160E` — confirming the state arrays are rebuilt per-frame, not persistent.)

**The descriptor tables are the DREQ FIFO landing of the 68K display objects:**
- 68K `object_table_sprite_param_update` (`$0036DE`) builds 60-byte display objects at `$FF6218`
  (stride `$3C`) from the WRAM entity table (`ENTITY_OBJECT_ARCHITECTURE.md:241-259`).
- `mars_dma_xfer_vdp_fill` (`$0028C2`) DREQ-streams `$FF6000`+ ($500 bytes) with COMM0 cmd `$0102`
  (`ENTITY_OBJECT_ARCHITECTURE.md:261-276`); the `$FF6218` display objects land at the SDRAM `$0600C218`/
  descriptor tables (`:272,278-280`).

So the full WRITER chain is:
**68K WRAM entity → `object_table_sprite_param_update` → `$FF6218` display objects → MARS DREQ → SDRAM
descriptors `$0600C1xx`/`C218`/`C254` → Slave cmd `$02` setup (`$06002494`/`$06002394`) → SDRAM state
`$0600CA60`/`CB20`/`CD30` → entity loop `$060024DC` → on-chip SRAM `$C0000740` → renderer `$C0000000`.**

---

## 4. Pipeline 1 vs Pipeline 2 — which carries per-entity car position?

- **Pipeline 1 (on-chip SRAM `$C0000000`, 1748B, Slave-private):** the *renderer code* and the
  *per-entity 48B working copy* `$C0000740`. The car's transform INPUT is **not born here** — it is
  copied in from SDRAM each entity (§2.4). Pipeline 1 is "untouchable" as *code*, but it does NOT
  originate the position data, so H-9 does not block a Master-side bridge.
- **Pipeline 2 (SDRAM cache, `main_coordinator_short $06003024`):** display-list/polygon geometry path
  (quad_batch → coord_transform/frustum_cull → span_filler). This is the geometry the renderer walks via
  the `R13` polygon-data pointer (`$0224EE`, descriptor+`$10`), not the per-entity world position.

**Determination:** the per-entity transform/position INPUT that determines on-screen car placement flows
through the **SDRAM state arrays (`$0600CA60`/`CB20`/`CD30`)**, which are read by the Pipeline-1 entity
loop but **sourced from SDRAM** — Master-writable. The car position is **NOT** born in Slave-private
on-chip SRAM. → **No H-9 violation for a Master-side SDRAM bridge.**

---

## 5. GO / NO-GO

### Verdict: **GO** (with one precise caveat about WHERE the Master must inject)

The cited go-condition sentence is satisfiable:

> *"The Slave reads per-entity transform input from `$0600CA60`/`$0600CB20`/`$0600CD30` (SDRAM,
> Master-writable), written each frame by the Slave cmd `$02` setup routines (`$06002494`/`$06002394`)
> from the SDRAM descriptor tables `$0600C1xx`/`C218`/`C254`, which are the DREQ landing of the 68K
> display objects built by `object_table_sprite_param_update`."*

### The caveat — the correct intercept point (NOT the state arrays directly)

The state arrays `$0600CA60`/`CB20`/`CD30` are **regenerated every frame from the descriptor tables** by
the cmd `$02` setup chain (§3) *before* the entity loop reads them. Therefore a Master write **directly to
the CA60/CB20/CD30 state arrays** would be **clobbered** by `$06002494`/`$06002394` in the same cmd `$02`
invocation — this is precisely the failure mode the `render_state_patcher` exhibits (it patches CA00 which
the setup just rebuilt). **Do not bridge at the state arrays.**

**Recommended bridge intercept point (matches `VR60_PHASE5F_SCOPING.md` §5F-1 option (a)/(b)):**
inject one level UPSTREAM — at the **SDRAM descriptor / display-object tables** that the setup routines
read FROM:
1. **Preferred (option a):** Master SH2 produces the `$0600C218`/`$0600C1xx`/`$0600C254` display-object/
   descriptor records **directly from the SH2-authoritative SDRAM entity** (`$0600F20C` player /
   `$06010000` AI), i.e. port `object_table_sprite_param_update` (`$0036DE`, 216B, Phase 2 §6.2) to SH2 and
   write the descriptor tables before the 68K DREQ overwrites them — or suppress the 68K DREQ for those
   bytes. Then the existing setup chain rebuilds CA60/CB20/CD30 from SH2-derived descriptors and the car
   moves from SH2 physics with **no change to the Slave engine**.
2. **Alternative (option b):** Master writes SH2-derived display objects into the **`$FF6218` DREQ source
   region equivalent** so the existing 68K DMA carries SH2 data. (Less clean — `$FF6218` is 68K WRAM,
   NOT Master-writable per Ground-Rule 9 / B-003; this path must instead intercept after the DREQ lands in
   SDRAM, i.e. it collapses into option (a).)

**Net:** option (a) — Master writes the **SDRAM descriptor tables `$0600C1xx`/`C218`/`C254`** (Master-
writable, the genuine per-frame input the setup chain consumes), *or* overwrites the state arrays
**after** the setup chain but **before** the entity loop (would require hooking inside the Slave cmd `$02`
handler between `$06002494` and `$020FEA`, more invasive). Option (a) is the clean intercept.

### What this rules OUT
- Direct CA60/CB20/CD30 patching (clobbered each frame) — the patcher's dead end, now explained.
- On-chip SRAM `$C0000740` injection — transient per-entity scratch, H-9, infeasible and pointless.

---

## 6. Residual uncertainty (honest gaps)

1. **Exact field semantics of the 48-byte state block and exactly which descriptor fields
   `$06002494`/`$06002394` read** were not fully decoded here (the setup routines `$06002494`,
   `$06002384`, `$060022B0`, `$06002394` were identified as the writers and their literal/argument wiring
   confirmed, but their internal field-by-field mapping descriptor→state was not exhaustively traced).
   **Before 5F-1 ships**, decode `$06002494` + `$06002394` field-by-field so the ported
   `object_table_sprite_param_update` writes descriptor fields in the layout the setup chain expects
   (the `+$02`/`+$06` world-X/Y, `+$10` poly ptr, etc. per `ENTITY_OBJECT_ARCHITECTURE.md:245-259`). This
   is a code-time detail, not a go/no-go blocker — the *path* and *writability* are established.
2. **Whether the 68K DREQ can be selectively suppressed for the descriptor bytes** (so the Master write
   isn't immediately re-overwritten by the next frame's DMA) needs a 68K-side trace of
   `mars_dma_xfer_vdp_fill` block list (`ENTITY_OBJECT_ARCHITECTURE.md:269-275`) — confirm the `$FF6218`
   block can be gated. This is the real 5F-1 design question and should be the next trace.
3. **Runtime confirmation** (Matias, emulator): a one-off experiment — have the Master write a deliberate
   offset into the `$0600C218` descriptor world-X for entity 0 each frame and confirm the on-screen car #0
   shifts — would empirically validate the intercept point before committing 5F-1 code.

---

## Appendix: load-bearing citations
- cmd `$02` handler + literal pool: `disasm/sections/code_20200.asm:1754-1896` (handler `$020FA8`,
  lits `$021040-$021096`; batches at `:1787-1808`).
- Entity loop + on-chip copy: `disasm/sections/code_22200.asm:374+` (`$060024DC` loop; copy sub `$022514`;
  src `MOV.L @R13+` = SDRAM, dest `$C0000740`).
- Patcher (the no-op): `disasm/sh2/expansion/render_state_patcher.asm:131,166,307,310`.
- DREQ writer chain: `analysis/ENTITY_OBJECT_ARCHITECTURE.md:241-280`.
- Slave dispatch: `analysis/SLAVE_SH2_DISPATCH_ARCHITECTURE.md:53-72,103-110`.
- Rendering arch (state-array batches, Huffman/C800): `analysis/sh2-analysis/SH2_RENDERING_ARCHITECTURE.md:37-61,119-139`.
- Prior scoping (shadow finding, discrepancy flag): `analysis/VR60_PHASE5F_SCOPING.md:59-99,272-305`.
