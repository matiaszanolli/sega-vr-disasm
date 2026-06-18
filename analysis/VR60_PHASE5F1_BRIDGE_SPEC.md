# VR60 Phase 5F-1a — SH2→Render Bridge Decode Spec (the port prerequisite)

**Created:** 2026-06-18
**Author:** Worker (READ-ONLY research role — NO code written, no asm/Makefile modified)
**Status:** RESOLVED. Decode prerequisite for 5F-1b (porting `object_table_sprite_param_update` to SH2 + DREQ gating).
**Method:** Hand + scripted decode of the live SH2 `dc.w` opcodes in `disasm/sections/code_20200.asm`/`code_22200.asm`, the 68K source `object_table_sprite_param_update.asm`/`mars_dma_xfer_vdp_fill.asm`, and the state dispatchers. Every load-bearing claim cites `file:line` + ROM/SDRAM address. Decodes were verified against the built ROM (`build/vr_rebuild.32x`) with `tools/sh2_disasm.py` and a local opcode decoder.

> **Tooling caveat (recorded for future agents):** `tools/sh2_disasm.py` (a) prints a malformed address column (an extra hex digit, e.g. `02222394` for ROM `$022394`/SH2 `$06002394`), and (b) **mis-decodes the `85md` family** as `MOV.B R0,@(d,R5)` — these are actually `MOV.W @(d*2,Rm),R0`. Mnemonics for MOV.L/JSR/BSR/ADD/DT are correct. All `85xx` reads below were re-decoded by hand. Cross-checked against the already-correct hand decode in `VR60_PHASE5F0_RENDER_INPUT.md:83-110`.

---

## 0. TL;DR — the executive answer

1. **What the port must emit:** the **60-byte ($3C-stride) display-object record**, exactly as 68K `object_table_sprite_param_update` (`$0036DE`) writes to `$FF6218` — 15 records. See the offset table in §1.3.
2. **Where to write it:** SDRAM **`$0600C218`** (cache-through `$2600C218` for the Master), 15 × `$3C`. This address is *literally* the DREQ FIFO landing of the 68K `$FF6218` block (proven in §2). Also write the camera/single record at **`$0600C100`** (DREQ landing of `$FF6100`) if camera must follow SH2.
3. **DREQ-gating mechanism:** **No DREQ disable is strictly required.** The 68K DREQ of `$FF6218`→`$0600C218` runs in **state 0**; the Master cmd `$3F` (where the port runs, replacing the no-op `sh2_render_state_patch` at `cmd3f_vr60_gameframe.asm:252`) runs in **state 4** — *after* the DREQ — and re-triggers the Slave render (`COMM2_HI=$02`) at its own end. So the Master write to `$0600C218` is the **last writer before the Slave reads**. Confirmed gateable-by-ordering (§4). Optional hard gate: skip the state-0 `mars_dma_xfer_vdp_fill` JSR (§4.3) — but this also carries non-entity blocks, so ordering-override is the cleaner first cut.
4. **Biggest port risk (coordinate units):** **LOW/RESOLVED.** The ported physics (Phase 3D) operates on the *same SDRAM entity field layout* as the 68K, so the ported `object_table_sprite_param_update` reads the identical word fields (+$30/+$32/+$34/+$3A/+$3C/+$3E/+$6E/+$BC/+$C1/+$C2/+$C4/+$E5). The "16.16" in Phase 3D is the *internal* integration; +$30/$34 remain integer world-coordinate words (§6, Q-1).
5. **5F-1b verdict: GO** — with one **must-resolve-before-coding** item: the camera/global inputs `object_table_sprite_param_update` reads from absolute WRAM (the `(-14132).W` car-index, `(-16156).W` camera offset, the three ghost/mode flags) are **not present in SDRAM** for a Master-side port; their SDRAM-staged equivalents must be located or staged (§6, Q-2). Everything else (the path, the writability, the landing address, the record format, the ordering) is established.

---

## 1. `object_table_sprite_param_update` ($0036DE) — full I/O spec (what the port must reproduce)

**Source:** `disasm/modules/68k/game/render/object_table_sprite_param_update.asm:25-94` (216 bytes, ROM `$0036DE-$0037B4`).
**Loop:** 15 iterations (`MOVEQ #$0E,D7` + `DBRA`, :31,93), entity stride **$100** (:91), output stride **$3C** (:92).
**Entry:** `A0 = $FF9100` (AI/display entity table, :26), `A1 = $FF6218` (output, :27), `A3 = sprite-def base` (:28, dereferenced once by car index).

### 1.1 Inputs — entity fields read (confirms/corrects ROADMAP §6.2)

| Entity offset | Size | Read at | Used for | Notes |
|---|---|---|---|---|
| +$C1 | byte | :36 (`MOVE.B $00C1(A0),D0`) | sprite type; **0 ⇒ slot inactive** (`BEQ .store_output`, :37) | gates visibility |
| +$E5 | byte | :45 (`BTST #3,$00E5(A0)`) | ghost/visibility bit 3 | with two abs flags |
| +$E4 | byte | :54 (`TST.B $00E4(A0)`) | flip/alt-table flag | under abs flag bit 3 |
| +$C2 | word | :62 (`ADD.W $00C2(A0),D0`) | sprite sub-index added to type×4 | indexes sprite-def table |
| +$32 | word | :65 (`ADD.W $0032(A0),D0`) | + camera offset → output +$04 | "angle offset" |
| +$3A | word | :67 (`>>3`, `NEG`) | output +$08 (lateral, negated) | ASR #3 |
| +$3C | word | :71 (`+ +$6E`, `>>3`) | output +$0A (height w/ roll) | ASR #3 |
| +$6E | word | :72 (added to +$3C) | roll/height offset | — |
| +$3E | word | :75 (`>>3`, `NEG`) | output +$0C (depth, negated) | ASR #3 |
| +$BC | word | :79 (`>>3`) | output +$1C (rotation) | ASR #3 |
| +$C4 | word | :82 (`>>3`) | output +$30 (angular) | ASR #3 |
| +$30 | word | :86 (copied as-is) | output +$02 (world X / speed) | **no shift** |
| +$34 | word | :87 (copied as-is) | output +$06 (world Y / heading) | **no shift** |

**Correction to ROADMAP §6.2 input list:** §6.2 omits **+$C2** (the sprite sub-index, :62) and **+$E4** (:54). The full set is **{+$30,+$32,+$34,+$3A,+$3C,+$3E,+$6E,+$BC,+$C1,+$C2,+$C4,+$E4,+$E5}**.

### 1.2 Absolute-WRAM (non-entity) inputs — the Master-port gap

These are read from fixed 68K Work-RAM addresses, **not** from the entity record. A Master-side SH2 port has **no access to 68K Work RAM** (Ground-Rule 9 / B-003) and these must be staged into SDRAM or COMM:

| WRAM read | Encoding | Address | Meaning (provisional) |
|---|---|---|---|
| `MOVE.W (-14132).W,D0` (:29) | abs.w | `$FFC8CC` | **car/model index** → selects sprite-def sub-table (`A3 = [A3 + index]`, :30) |
| `MOVE.W (-16156).W,D0` (:64) | abs.w | `$FFC0E4` | **camera offset** added to entity +$32 → output +$04 |
| `TST.B (-28444).W` (:40) | abs.w | `$FF9064` | ghost-mode global flag A |
| `TST.B (-15588).W` (:42) | abs.w | `$FFC31C` | ghost-mode global flag B |
| `BTST #3,(-28443).W` (:52) | abs.w | `$FF9065` | flip/alt-table enable flag |

(Address arithmetic: `(-N).W` = `$10000 - N`. `-14132`=$C8CC, `-16156`=$C0E4, `-28444`=$9064, `-15588`=$C31C, `-28443`=$9065.) **These are the Q-2 must-resolve staging items (§6).**

### 1.3 Output — the 60-byte ($3C) display-object record (the port's emit format)

This is the **exact byte layout** the port must write at `$0600C218 + N*$3C`, N=0..14. Offsets not listed are left untouched by this function (set by other 68K render writers / cleared by the DREQ source region).

| Output offset | Size | Source | Written at | Value when slot inactive (+$C1==0) |
|---|---|---|---|---|
| +$00 | word | D5 (visibility flag 1) | :88 | 0 |
| +$02 | word | entity +$30 (world X), copied as-is | :86 | entity +$30 (still written) |
| +$04 | word | `$FFC0E4` + entity +$32 | :66 | — (only in active path) |
| +$06 | word | entity +$34 (world Y), copied as-is | :87 | entity +$34 (still written) |
| +$08 | word | `-(entity +$3A >> 3)` | :70 | — |
| +$0A | word | `(entity +$3C + +$6E) >> 3` | :74 | — |
| +$0C | word | `-(entity +$3E >> 3)` | :78 | — |
| +$10 | long | sprite-def ptr `[A3 + (type<<2) + +$C2]` | :63 | — |
| +$14 | word | D6 (visibility flag 2) | :89 | 0 |
| +$1C | word | `entity +$BC >> 3` (rotation) | :81 | — |
| +$28 | word | D6 (visibility flag 3) | :90 | 0 |
| +$30 | word | `entity +$C4 >> 3` (angular) | :84 | — |

**Visibility flags D5/D6:** both set to 1 when +$C1≠0 (:38-39); D6 forced 0 unless type==1 (:57-59, `CMPI.W #$0001,D0` / `MOVEQ #$00,D6`); both forced 0 (invisible) on ghost/flip conditions (:48-49,:54-55). On inactive slot, only +$00/+$02/+$06/+$14/+$28 are written (the `.store_output` tail, :85-90); +$02/+$06 still copy entity +$30/+$34.

> **Stride note:** the output stride is **$3C (60 bytes)** (:92 `LEA $003C(A1),A1`). This is the record format the descriptor table at `$0600C218` carries. The Slave transform internally re-walks it (see §3.3 stride remark) but the **port emits $3C-stride records** — identical to the 68K.

---

## 2. DREQ landing → SDRAM descriptor tables (the address proof)

### 2.1 The DREQ

`mars_dma_xfer_vdp_fill` (`mars_dma_xfer_vdp_fill.asm:17-39`, ROM `$0028C2`):
- Sets MARS DREQ length `$0500` (:19), mode 4 (:20).
- Writes COMM0_LO/COMM0_HI from `$C8A9`/`$C8A8` (:21-22) → command `$0102` (cmd $02, scene orchestrator) per CLAUDE.md `$C8A8` convention.
- Source `A1 = $FF6000` (:27), streams **$500 bytes** to the MARS FIFO via 10 block-copy calls (:30-39).

### 2.2 The FIFO destination = SDRAM `$0600C000`

`dmac_fifo_setup` (`$06004448`, decoded from build):
- DMAC SAR = `$20004012` (FIFO data port), DAR = **R1** (caller-supplied), TCR = $500-class, chcr set, then ACK bit.
- Callers ($01/$04/$05) pass **R1 = `$0600C000`** (`SH2_COMMAND_HANDLER_REFERENCE.md:66,116,145,208`).

Therefore the $500-byte block `$FF6000…$FF64FF` lands at **`$0600C000…$0600C4FF`**, byte-for-byte. Hence:

| 68K source | Offset in block | SDRAM landing | Role |
|---|---|---|---|
| `$FF6000` | +$000 | `$0600C000` | system/camera state |
| `$FF6100` | +$100 | **`$0600C100`** | viewport A / camera record (descriptor batch A input) |
| `$FF6218` | +$218 | **`$0600C218`** | **display objects (15 × $3C) — the car descriptors** |
| `$FF6254` | +$254 | **`$0600C254`** | (within display-object block; batch-3 descriptor base) |

> **`$0600C218` IS literally the DREQ landing of the 68K `$FF6218` display objects.** This is the single most load-bearing fact of the bridge. `C100`, `C218`, `C254` are all sub-ranges of the one $500-byte DREQ block; there is no separate "descriptor" repack at the landing — the 68K display-object bytes ARE the descriptor table.

### 2.3 Note on `$0600C000` dual-use

`$0600C000` is *also* the Huffman decoder output (`SH2_COMMAND_HANDLER_REFERENCE.md:182,191,231`). The DREQ overwrites `$0600C000+` with the $FF6000 block each cmd-$02 frame; the Huffman path writes the same base during cmd $23/scene-init. They are time-separated (init vs per-frame). The car descriptors live at +$218, clear of the Huffman 2KB window only partially — **flag: confirm the Huffman 2KB output ($0600C000–$0600C7FF) and the display-object descriptors ($0600C218–$0600C4FF) do not corrupt each other during racing** (likely fine — Huffman is scene-init-time, DREQ is per-frame — but worth a runtime check; this is Q-4 in §6).

---

## 3. The cmd $02 setup chain — how descriptors become per-entity render state

### 3.1 The handler `$06000FA8` setup chain (resolved literals)

From `code_20200.asm:1754-1808`, literal pool `$021040-$0210A8` (decoded against build):

| Step | ROM | Call / action | Resolved operands |
|---|---|---|---|
| init | `$020FAA` | `JSR $060045CC` | scene init |
| marker | `$020FB0-B4` | `[$0600F180] = $4C494E4B` ("LINK") | sentinel write |
| | `$020FB6` | `JSR $0600252C` | **on-chip SRAM boot-copy** ($01B5=437 longwords=1748B → `$C0000000`) (`$02252C`, decoded; src literal `$06002544`→`$01B5` count) |
| | `$020FBE` | `JSR $060022B0` | descriptor-region pre-fill (`$0600456C`/`C729`, writes `$0600C71E`-region) |
| | `$020FC4` | `JSR $06002384` | on-chip context tail |
| | `$020FCA-CE` | `R0=[$0600C0CC]`; `JSR $06002394` after `SHLL8` | on-chip render-context build (writes `$C0000700`) |
| **A** | `$020FD2-D8` | `R13=$0600CA00, R14=$0600C100, JSR $06002494` | batch-0 state build |
| | `$020FDE-E8` | `[$C000071C]=$00001000`; `JSR $06002394` | context |
| **1** | `$020FEA-F0` | `R13=$0600CA60, R14=$0600C128, R7=4, JSR $060024DC` | entity render loop, batch 1 |
| **2** | `$020FF4-FA` | `R13=$0600CB20, R14=$0600C178, R7=8, JSR $060024DC` | batch 2 |
| ctx | `$020FFE-04` | `[$C0000700+?]=$00008000`; `JSR $06002394` | context |
| **3** | `$021008-20` | `R13=$0600CD30, R14=$0600C254, R7=3`, outer loop (`R13+=$90`, `R14+=$3C`), `JSR $060024DC` | batch 3 (3 outer × 8 = 24) |
| **G** | `$021022-2A` | `R13=$0600C6DC, R14=$0600D810?, R7=2, JSR $060023B4` | secondary render loop |
| | `$02102C-32` | `JSR` with R1/R2 from `$021034` (`$1C`) | finalize |

### 3.2 **The actual descriptor→state writer is `$06000DC8`, NOT `$06002494`/`$06002394`** (correction to 5F-0)

`VR60_PHASE5F0_RENDER_INPUT.md:120-152` named `$06002494`/`$06002394` as the routines that "write the 48-byte transform-state arrays from the descriptor tables." **The bytes do not support this:**
- `$06002394` writes the **on-chip render context `$C0000700`** (`MOV.L R0,@($C,R14)` with R14=`$C0000700`; copies ctx+$C→@R7, ctx+$8→@R7+$10), not SDRAM state. Decoded `$022394-$0223AA`.
- `$06002494` does `BSR $022514` (the 48-byte **read** of state into on-chip `$C0000740`), reads descriptor `$0600C004` at +$E (count), and loops a per-entity sub — it is a render-dispatch helper, not a state builder. Decoded `$022494-$0224C6`.
- `$06002514` copies **source = R13 (SDRAM state) → dest = `$C0000740` (on-chip)** (literal `$022528`=`$C0000740`). State is the SOURCE, confirming §2.4 of 5F-0.

The genuine per-batch **descriptor→state transform** is **`$06000DC8`** (`SH2_COMMAND_HANDLER_REFERENCE.md:148,211` "entity transform pipeline, 9 sub-calls"), called by handler $01 and $05. Its literal pool (`$020E48-$020EB4`, decoded from build) gives the definitive mapping:

| Batch | State out (R13) | Descriptor in (R14) | Count | Transform fn |
|---|---|---|---|---|
| A | `$0600CA00` | `$0600C100` (camera, via setup `$06001A6C`) | 1 | `$06001BD4` |
| B | `$0600CA30` | `$0600C114` | — | `$06001C08` |
| **C** | **`$0600CCA0`** | **`$0600C218`** | **15** (`R7=$0F`) | **`$06001D34`** |
| D | `$0600D510` | `$0600C59C` | 16 (`R7=$10`) | `$06001E9C` |
| E | `$0600D810` | `$0600C6DC` | 4 (`R7=$04`) | `$06001DA4` |
| F/G/H | `$0600D930`/`D900`/`D8D0` | `$0600C754`/`C740`/`C72C` | — | `$06001E7E`/`DCC`/`DF8` |

> **Batch C is the car path:** **descriptor `$0600C218` (15 records, the `object_table_sprite_param_update` output) → transform `$06001D34` → state `$0600CCA0`** (matrix base R12=`$C0000400`, R4 matrix advance `$C0000038`). This is the chain that turns the SH2-authoritative descriptors into on-screen cars.

### 3.3 Transform `$06001D34` (C218 desc → CCA0 state, 15 ent) — field-level

Decoded `$021D34-$021D9E`. Per descriptor it:
- reads descriptor active flag at +$0 (`MOV.W @(0,R14),R0`; `CMP/EQ #0` early-out at `$021D38`),
- BSR `$021FAC` (load/setup), BSR `$021B04` (matrix mul), BSR `$022206`/`$0221C6`/`$022248` (projection components, results stored to state R5+$5/+$4/+$6 via `MOV.W R0,@(d,R5)`),
- compares against `$0064`/`$00C8` (`$021D54`/`$021D8A` — clip/cull thresholds),
- BSR `$021B2C` (commit), advances R13 (state) by **$30**, R14 (descriptor) by **$14** in the inner pair and by **$3C** in the skip path (`$021D9E`), R4 (matrix) by **$D0**.

**Implication for the port:** the transform is the **unchanged Slave engine**. The port does not touch it. The port's only contract is: *write the $3C-stride descriptor at `$0600C218` with the §1.3 layout, and the existing `$06000DC8`→`$06001D34` chain derives the on-screen state.* The descriptor fields that drive on-screen position/scale/heading are exactly the §1.3 outputs (+$02 world X, +$04 camera-adjusted, +$06 world Y, +$08/$0A/$0C the divided lateral/height/depth, +$10 sprite ptr, +$1C rotation, +$30 angular). A full byte-level decode of all five projection sub-BSRs is **not required for the port** (they consume the §1.3 record as-is); it is recorded as a residual depth item (Q-5).

### 3.4 The 48-byte vs $30 state stride

5F-0 described a "48-byte state" copied by `$022514` (`R7=12` longwords = 48B). The setup/render loops advance state R13 by **$30 (48 bytes)** per entity (`$0224FE`, `$0223F2`, `$021D5C`). Consistent: **per-entity render state = 48 bytes, stride $30**, base `$0600CA60`/`CB20`/`CD30`/`CCA0` depending on batch. The descriptor stride is **$14 (20B)** in the render/transform loops but the **DREQ-landed record is $3C** — the engine reads a $14 *window* at the head of each $3C record (active flag +$0, sprite ptr +$10) plus the projected fields; the port still writes full $3C records (the un-read $14..$3B tail is the 68K's extra render-slot bytes, harmless to replicate).

---

## 4. DREQ gateability

### 4.1 Where the 68K builds + DREQs the descriptors

- **Build:** `object_table_sprite_param_update` ($0036DE) is called in the **rendering-output** tail of every entity render pipeline variant (`entity_render_pipeline.asm:68,102,187`; `entity_render_pipeline_with_vdp_dma.asm:62,92,149,195`; etc.). **Critically, the `$C8D2` bypass trampoline does NOT skip this** — the trampoline re-enters at `entity_render_pipeline_position_ai` (`vr60_physics_bypass_trampoline.asm:33-38`, `entity_render_pipeline.asm:44`), which falls through the render tail. So the 68K rebuilds `$FF6218` every frame regardless of $C8D2.
- **DREQ:** `mars_dma_xfer_vdp_fill` ($0028C2) is called from the **state-0** handlers (`state_disp_004cb8.asm:40`; `state_disp_005308.asm:34`; `state_disp_005586.asm:30`; `state_disp_005618.asm:33`; `state_disp_00573c.asm:33`). State 0 runs **before** state 4 in the per-V-INT state machine (`$C87E` increments 0→4→8).

### 4.2 The ordering fact (the gateability answer)

```
Frame:  state 0  → object_table writes $FF6218 → mars_dma DREQ → $0600C218 (68K data)   [EARLY]
        state 4  → cmd $3F (Master): physics/AI → [PORT WRITES $0600C218] → COMM2_HI=$02 → Slave cmd $02 renders   [LATE]
```

Because cmd $3F runs **after** the state-0 DREQ and **immediately before** it re-triggers the Slave render (`cmd3f_vr60_gameframe.asm:289-294`), a Master write to `$0600C218` inside cmd $3F is the **last writer before the Slave reads**. **The 68K DREQ does not need to be disabled** — it is simply overwritten in the same frame, before its data is consumed. This is the clean, low-risk intercept. (Contrast: `render_state_patcher` failed because it wrote CA00/CCA0 — *downstream* state arrays that `$06000DC8` had *already rebuilt from the descriptors that frame*; writing the descriptors UPSTREAM avoids that.)

### 4.3 Hard-gate option (if ordering proves insufficient)

If the state-0 DREQ + its own cmd `$0102` triggers a render with stale C218 *before* cmd $3F (i.e. two renders per frame, the first showing 68K data), then additionally gate the DREQ. The cleanest 68K gate is to **skip the `mars_dma_xfer_vdp_fill` JSR in the state-0 handlers** behind the existing `$C8D2` flag (the same master switch already used by the physics/AI trampolines). **Hazard:** `mars_dma_xfer_vdp_fill` carries the **entire** $500-byte block (system/camera `$FF6000`, viewports, render-slot config — not just the car descriptors), and the cmd `$0102` it issues is the primary scene-orchestrator trigger. Skipping it wholesale would starve the Slave of camera/system state. So a hard gate must be **selective**: either (a) let the DREQ run but have the Master re-write only the `$0600C218` car-descriptor sub-range afterward (the §4.2 ordering approach — recommended), or (b) split the block so the car-descriptor portion is gateable independently (more invasive). **Recommendation: start with §4.2 ordering-override; only add a gate if a double-render is observed.**

### 4.4 Does gating break anything the 68K needs?

The 68K does **not read back** `$0600C218` (it is SDRAM, Master/Slave-only). The 68K *does* keep using its own WRAM entity for camera/lap/HUD (those are separate WRAM paths, unaffected). So overwriting `$0600C218` from the Master is invisible to the 68K. The only consumer is the Slave render chain (§3). **No 68K breakage from the ordering-override approach.**

---

## 5. Injection-point recommendation

**Write target:** `$0600C218` (Master cache-through **`$2600C218`**), 15 × `$3C`, layout per §1.3. Optionally also `$0600C100` (cache-through `$2600C100`) for the camera record if the camera must track the SH2 player. Do **NOT** write the CA00/CCA0/CA60/CB20/CD30 state arrays (those are rebuilt by `$06000DC8` from the descriptors — the `render_state_patcher` dead end).

**Code site:** inside **cmd $3F**, **replacing the no-op `sh2_render_state_patch` call** at `cmd3f_vr60_gameframe.asm:252-254`, with GBR=player already set (`:246-247`) and AI entities at `$06010000`. The port:
1. for the player + 15 AI SDRAM entities, run the ported `object_table_sprite_param_update` logic reading the SDRAM entity word fields (§1.1) and the staged camera/flag globals (§1.2 / Q-2),
2. write 15 × $3C records to `$2600C218` (and the camera record to `$2600C100`),
3. fall through to the existing `COMM2_HI=$02` Slave re-trigger (`:289-294`).

**What must be gated:** nothing, under §4.2 (ordering override). The state-0 DREQ remains for camera/system/viewport blocks; the Master simply re-stamps the car-descriptor sub-range each frame before the Slave render. Add the §4.3 selective gate only if a double-render artifact appears.

**Byte layout the port emits:** the §1.3 table — `$3C`-stride, 15 records, with +$00/$14/$28 visibility, +$02/$06 world X/Y (unshifted), +$04 camera-adjusted, +$08/$0A/$0C divided lateral/height/depth, +$10 sprite-def pointer (32X address `$020958E4`-based), +$1C rotation, +$30 angular.

---

## 6. Open questions / risks for 5F-1b (the port)

| ID | Question / risk | Severity | Proposed resolution / flag |
|----|-----------------|----------|----------------------------|
| **Q-1** | **Coordinate units (16.16 vs word).** Does the SH2 projection expect raw words at entity +$30/$34, while Phase 3D physics stores 16.16? | **LOW / resolved** | The Phase 3D port (`cmd3f_vr60_gameframe.asm:206`) is the *same* `entity_pos_update`, writing the *same* entity field layout (+$30/$34 = integer world words; +$32 = sub-position). The ported `object_table_sprite_param_update` reads the identical fields as words — self-consistent. **No conversion needed.** Verify once by byte-comparing one port-produced record vs the 68K's for entity 0. |
| **Q-2** | **Non-entity inputs not in SDRAM** (§1.2): car-index `$FFC8CC`, camera offset `$FFC0E4`, ghost flags `$FF9064`/`$FFC31C`, flip flag `$FF9065`. A Master port can't read 68K WRAM (Ground-Rule 9). | **MUST-RESOLVE before coding** | Stage these 5 values into SDRAM/COMM each frame (the camera offset `$FFC0E4` is the load-bearing one — it shifts every car's output +$04). Reuse the existing `vr60_globals_stage` per-frame window, or relay via spare COMM. The sprite-def base ($020958E4) and its car-index dereference must also be reproduced. |
| **Q-3** | **15 vs 16 entity count.** `object_table` iterates 15 (Table 1, $FF9100 = AI). The player is a separate entity ($FF9000 / SDRAM $0600F20C). Where does the player car descriptor go? | Medium | The 68K builds the player's display object via a *different* render-slot path (the player uses the `$FF6100` viewport / camera record at `$0600C100`, batch A). Confirm whether the player's on-screen car is descriptor batch A (`$0600C100`→`$0600CA00`) or one of the 15 in C218. **Decode batch-A transform `$06001BD4` + setup `$06001A6C` to locate the player descriptor before wiring the player.** AI-only (15 records at C218) is the safe first cut; player is a follow-up. |
| **Q-4** | **C218 vs Huffman `$0600C000` overlap** (§2.3). Huffman output is the 2KB `$0600C000-C7FF`; car descriptors are `$0600C218-C4FF`. | Medium | Time-separated (Huffman = scene-init/cmd $23; DREQ + port = per-frame). Confirm at runtime that per-frame C218 writes are not clobbered by a mid-race Huffman pass. Likely safe; flag for the dual-path verify. |
| **Q-5** | **Transform sub-BSRs not fully decoded** (`$021FAC`/`$021B04`/`$022206`/`$0221C6`/`$022248`/`$021B2C`). | Low (not a blocker) | The port writes the §1.3 record; the transform consumes it unchanged. Field-level decode of these only needed if a record field's projection differs from expectation — defer to a byte-compare failure, not a precondition. |
| **Q-6** | **Double-render** (§4.3): does the state-0 cmd `$0102` render the frame *before* cmd $3F's COMM2_HI=$02 re-render? | Medium | If yes, the first render shows 68K (frozen-WRAM) cars for one field, then cmd $3F re-renders SH2 cars — possible flicker. Resolve by Matias visual A-B after the port; if flicker appears, add the §4.3 selective gate. |
| **Q-7** | **2P / mode transitions.** Viewport B (`$FF6330`→`$0600C330`) and the 2P render variants use separate descriptor sub-ranges. | Medium | 5F = 1P only (matches Phase 3/5F scoping §F 5F-9). Defer 2P. Re-stage Q-2 globals on every racing-scene entry (mode transitions reset them). |
| **Q-8** | **Sprite-def pointer form.** Output +$10 stores a 68K-form pointer (`[A3 + ...]`, A3 from ROM `$008958E4`). The Slave dereferences it as an SH2 address. | Medium | The 68K sprite-def table stores *68K* addresses ($00xxxxxx). The Slave reads +$10 as a polygon-data pointer in SDRAM/ROM space. **Confirm whether the 68K-form sprite-def pointer is already SH2-usable** (ROM is shared, $00xxxxxx vs $02xxxxxx mapping) or needs `+$02000000` translation. This is a B-003-class translation check — **verify the +$10 pointer the 68K DREQs is interpreted correctly by the current Slave today** (it already is, since 68K-DREQ'd descriptors render correctly), so emitting the same 68K-form pointer is safe. Flag only if the port computes the pointer differently. |

---

## 7. Verdict

**5F-1b (the port) is GO**, gated on **Q-2** (stage the 5 non-entity WRAM inputs into SDRAM/COMM) as a must-resolve-before-coding item, and with **Q-3** (player-descriptor location) decoded before wiring the player (AI-only is a safe first cut). The path, writability, landing address (`$0600C218` = DREQ landing of `$FF6218`), the $3C record format, the consuming transform chain (`$06000DC8`→`$06001D34`), the injection site (cmd $3F, replacing `sh2_render_state_patch`), and the no-gate ordering mechanism are all established from the bytes.

---

## Appendix: load-bearing citations

- 68K source: `disasm/modules/68k/game/render/object_table_sprite_param_update.asm:25-94` (full I/O); `disasm/modules/68k/game/render/mars_dma_xfer_vdp_fill.asm:17-39` (DREQ).
- DREQ destination: `analysis/sh2-analysis/SH2_COMMAND_HANDLER_REFERENCE.md:66,116,145,208,232` (`$06004448` R1=`$0600C000`); decoded `$024448-$024466` from `build/vr_rebuild.32x`.
- Setup chain + literals: `disasm/sections/code_20200.asm:1754-1808`, pool `$021040-$0210A8`; decoded from build.
- Descriptor→state transform: `$06000DC8` literal pool `$020E48-$020EB4` (decoded from build); transform `$06001D34` decoded `$021D34-$021D9E`.
- `$022394`/`$022494`/`$022514` re-decode (5F-0 correction): `disasm/sections/code_22200.asm:202-227 (`$022394`),:338-363 (`$022494`),:402-413 (`$022514`)`; verified against build.
- State-0 DREQ call sites: `state_disp_004cb8.asm:40`, `state_disp_005308.asm:34`, `state_disp_005586.asm:30`, `state_disp_005618.asm:33`, `state_disp_00573c.asm:33`.
- Render-tail not skipped by $C8D2: `entity_render_pipeline.asm:24,44,68`; `vr60_physics_bypass_trampoline.asm:33-38`.
- Injection site: `disasm/sh2/expansion/cmd3f_vr60_gameframe.asm:206 (physics),246-254 (GBR + patcher no-op),289-294 (Slave re-trigger)`.
- Prior finding (path/writability GO, patcher dead end): `analysis/VR60_PHASE5F0_RENDER_INPUT.md:10-21,99-116,184-213`; `analysis/VR60_PHASE5F_SCOPING.md:92-99,272-282`.
- ROADMAP §6.2 I/O: `VR60_ROADMAP.md:332-343`.
