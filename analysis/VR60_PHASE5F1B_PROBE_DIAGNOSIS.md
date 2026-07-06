# VR60 Phase 5F-1b — Bridge Probe Failure Diagnosis (READ-ONLY)

**Created:** 2026-06-18
**Author:** Worker (READ-ONLY diagnostic role — NO asm/source/Makefile modified)
**Status:** ROOT CAUSE FOUND. The bridge probe wrote to the **wrong descriptor block**.
**Method:** Hand-decode of the live Slave SH2 `dc.w` opcodes in `build/vr_rebuild.32x` (custom
decoder correcting the `85md`/`81md` MOV.W-disp family that `tools/sh2_disasm.py` mis-decodes),
cross-checked against the 68K descriptor-writer sources. Every load-bearing claim cites the decoded
SH2 address / `file:line`.

---

## 0. Executive summary

**The probe failed because it cleared the visibility words of `$0600C218`, but the per-frame racing
render (Slave cmd `$02` handler `$06000FA8`) never reads `$0600C218`.** During racing the Slave reads
its display-object descriptors from **`$0600C128` (batch 1, 4 ent), `$0600C178` (batch 2, 8 ent),
`$0600C254` (batch 3, 7×8)** via the entity loop `$060024DC` — confirmed by the handler's own literal
pool (`$0600103C-$060010A8`, decoded below). `$0600C218` is read **only** by the transform dispatcher
`$06000DC8`, which belongs to Slave handlers `$01`/`$04`/`$05`/`$07` (scene-init / non-racing-render
modes) and is **not invoked by cmd `$02`**.

So the cmd-`$3F` "render" is `COMM2_HI=$02` → `$06000FA8`, which ignores C218 entirely. Writing
C218 has no effect on the opponent cars regardless of timing or cache — **H3 (timing) and H4 (cache)
are moot; the address itself is wrong.** The visibility-flag *semantics* the probe assumed (+$00/+$14/+$28,
`0 = invisible`) are actually **correct** — but only for the C128/C178/C254 blocks the racing engine reads.

**Verdict per hypothesis:** **H1 = the operative cause (semantic no-op via wrong target)**; H3 unresolved
but irrelevant given H1; H4 refuted as a cause; H2 refuted (probe does run).

This also retroactively explains the **`render_state_patcher` no-op** and the **5F-1a "GO"** error: 5F-1a
read the C218→CCA0 transform `$06001D34` (reached from the `$06000DC8` dispatcher) and assumed that
dispatcher is the racing render. It is not. The 5F-0 doc even *recommended* the right empirical test
(`VR60_PHASE5F0_RENDER_INPUT.md:231-233`: "write a deliberate offset into the C218 world-X for entity 0
and confirm the car shifts") — that direct test was skipped in favor of the visibility-flag probe, and
the skip hid the wrong-address error.

---

## 1. The decisive evidence — cmd `$02` handler literal pool

Slave dispatch: poll `$06000592` → COMM2_HI → jump table `$060005C8`. Decoded table:

```
entry 0 ($060005C8): $06000608   (idle / cmd $00)
entry 1            : $060039F0
entry 2            : $06000FA8   <-- cmd $02 = the per-frame RACING render
entry 3            : $06001384   (cmd $03)
entry 4            : $06000D88   (cmd $04)
entry 7            : $06000DA8   (cmd $07)
```

cmd `$3F` re-triggers the Slave with **COMM2_HI = $02** (`cmd3f_vr60_gameframe.asm:303-304`), so the
render that consumes the descriptors that frame is **`$06000FA8`**.

**`$06000FA8` literal pool (`$0600103C-$060010A8`, dumped from the build):**

```
$06001060: 0600CA00   batch-0 state base    $06001064: 0600C100   batch-0 descriptor (camera)
$06001078: 0600CA60   batch-1 state base    $0600107C: 0600C128   batch-1 descriptor   <-- R14
$06001084: 0600CB20   batch-2 state base    $06001088: 0600C178   batch-2 descriptor   <-- R14
$06001090: 0600CD30   batch-3 state base    $06001094: 0600C254   batch-3 descriptor   <-- R14
$06001098: 0600D810   batch-G state base    $0600109C: 0600C6DC   batch-G descriptor
$06001068: 06002494   setup     $06001080: 060024DC   entity loop   $0600105C: 06002394   ctx
```

**`$0600C218` is absent from this pool.** The handler calls `$060024DC` (entity loop) and `$06002494`
(setup) with descriptors **C100 / C128 / C178 / C254 / C6DC** — never C218.

Handler body confirms the wiring:
- `$06000FEA` `R13=$0600CA60`, `$06000FEC` `R14=$0600C128`, `$06000FF2` `R7=4`, `$06000FF0` `JSR $060024DC`
- `$06000FF4` `R13=$0600CB20`, `$06000FF6` `R14=$0600C178`, `$06000FFC` `R7=8`, `$06000FFA` `JSR $060024DC`
- `$06001008` `R13=$0600CD30`, `$0600100A` `R14=$0600C254`, outer loop `R13+=$90` (`$06001018/1A`),
  `R14+=$3C` (`$06001020`), `JSR $060024DC` — batch 3.

---

## 2. Where C218 IS read — and why it is NOT the racing path

C218 is loaded as an SH2 literal at exactly five sites (search of file `$20000-$100000` for the
`0600 C218` longword, then back-resolved to the `MOV.L @(disp,PC)` that loads each pool entry):

```
$06000DEA  MOV.L @(C218),R14   <- inside dispatcher $06000DC8 (called from handlers $01/$04/$05)
$06000F06  MOV.L @(C218),R14   <- inside cmd $07 handler chain ($06000DA8)
$06001106  MOV.L @(C218),R14   <- inside cmd $03 handler ($06001384) region
$060013C2  MOV.L @(C218),R14   <- inside cmd $03 handler region
$0600152C  MOV.L @(C218),R14   <- inside handler $05 region ($06001924)
```

The `$06000DC8` dispatcher (the chain 5F-1a traced: `$0600C218`→`$06001D34`→`$0600CCA0`) is invoked from
`$060008C2`, `$06000D22`, `$06001958` — i.e. from handlers `$01`/`$04`/`$05`, **not** from cmd `$02`
(`$06000FA8`). None of the five C218 readers sits inside `$06000FA8`'s body (`$06000FA8-$0600103A`).

**Conclusion:** `$0600C218` (the DREQ landing of the 68K `object_table_sprite_param_update` output) is
consumed by mode-specific / scene-init render paths, **not** the per-TV-frame racing render. The
racing render's car descriptors live at **C128 / C178 / C254**.

---

## 3. Per-hypothesis verdicts

### H1 — Visibility-flag semantics / probe is a semantic no-op. **SUPPORTED (operative cause), with a twist.**

Two parts:

**(a) Are +$00/+$14/+$28 the visibility gate, and does 0 = hidden?** **YES — confirmed for the racing
descriptor blocks.** The entity loop `$060024DC` gates on descriptor +$00:
```
$060024DE  MOV.W @(0,R14),R0
$060024E0  CMP/EQ #0,R0
$060024E2  BT $060024FE        ; +$00 == 0  ->  skip render (entity hidden)
```
And the 68K writer for the C128 block explicitly *disables* display by clearing those exact words:
`vdp_sprite_pointer_setup_cond_disp_clear.asm:36-45` clears `$FF6128` +$00,+$14,+$28,+$3C to 0 to turn
the object off; `sfx_trigger_object_enable_fields.asm:7` *sets* `$FF6128` +$00/+$14 = 1 to enable. So
`0 = invisible` is correct, and +$00/+$14/+$28 are the right fields.

**(b) But the probe wrote them on the WRONG block (C218, not C128/C178/C254).** Because the racing
render never reads C218, clearing C218's +$00/+$14/+$28 changes nothing on screen. The probe is a
no-op **not because the semantics are wrong, but because the target address is wrong.** This is the
operative root cause.

> Note on the C218 transform `$06001D34` itself (decoded `$06001D34-$06001D9E`): it *does* gate on
> +$00 (`CMP/EQ #0,R0; BT $06001D98` skip), so even on the C218 path the probe's field choice would be
> correct — the issue is purely that this transform isn't on the racing-render path. (Aside: the
> C218 reference docs noted entity visibility may also live at `$0600C800` 32×$10 — that is the cmd
> `$23` Huffman class, a third unrelated block; not relevant here.)

### H2 — Probe not executing. **REFUTED.**

The JSR swap is live (`cmd3f_vr60_gameframe.asm:258-260` loads `.bridge_addr = $023039E0` and `JSR @R0`),
cmd `$3F` is the VR60 game-frame handler that runs every racing frame (it performs the geometry/sprite
block copies, full physics pipeline, and the AI loop, then re-triggers the Slave at `:303-304`). The
probe runs; it simply writes to a block the render ignores. (The probe loop body is also correct SH2:
`$2600C218`, 15× stride `$3C`, clearing +$00/+$14/+$28 — verified against the source `bridge_probe.asm`.)

### H3 — Frame timing / "last writer". **UNRESOLVED but IRRELEVANT given H1.**

The timing claim cannot be the cause here because the consumer never reads the written address. The
static evidence does, however, *undercut* the original "last-writer" model independently: the racing
render `$06000FA8` rebuilds its **state arrays** (CA60/CB20/CD30) from C128/C178/C254 via the setup
chain (`$06002494`/`$06002394`) on every cmd `$02`, and the cmd `$02` is issued by cmd `$3F` itself at
its tail. So even the *correct* descriptor blocks are re-consumed-from each frame. Whether a state-0
DREQ also drives a separate render before cmd `$3F`'s COMM2_HI=$02 (the H3/Q-6 double-render question)
remains undetermined from static analysis and is now a second-order question — resolve it only after
the address is corrected.

### H4 — Cache / addressing. **REFUTED as a cause.**

The probe correctly used the Master cache-through alias `$2600C218` (`bridge_probe.asm:90`), which is
the right convention for cross-CPU SDRAM writes (KNOWN_ISSUES "Cache-Through Addressing"). Even if a
coherency hazard existed, it could not explain the null result, because the read side never touches
C218. Cache is not implicated. (When the corrected probe targets C128/C178/C254, the same cache-through
alias `$2600Cxxx` remains mandatory — H-4 still applies to the *correct* address.)

---

## 4. Root cause (single statement)

> **The 5F-1a bridge spec identified `$0600C218` as the racing render's display-object descriptor table,
> but the per-frame Slave racing render (cmd `$02` handler `$06000FA8`) reads its descriptors from
> `$0600C128`/`$0600C178`/`$0600C254` (entity loop `$060024DC`, $14 stride). `$0600C218` is read only by
> non-racing handlers ($01/$04/$05/$07) via dispatcher `$06000DC8`. The probe wrote the correct
> visibility fields at the wrong address, so it could not affect the on-screen opponents.**

Why 5F-1a went wrong: it decoded the `$06000DC8`→`$06001D34`→CCA0 chain (which genuinely reads C218,
15 records, `R7=$0F`) and assumed that chain is the cmd-`$02` render. It is a *different* handler's
chain. The cmd-`$02` handler `$06000FA8` uses a parallel-but-distinct descriptor family
(C128/C178/C254 → CA60/CB20/CD30) that 5F-0 had actually decoded correctly (`VR60_PHASE5F0_RENDER_INPUT.md:68-78`),
but 5F-1a then "corrected" 5F-0 toward the C218 chain — that correction was the error.

---

## 5. Corrected injection strategy

The render-input addresses are **C128 / C178 / C254**, not C218. Concretely:

| Batch | Slave state out (R13) | **Descriptor read (R14)** | Count | 68K WRAM source | 68K writer |
|---|---|---|---|---|---|
| 1 | `$0600CA60` | **`$0600C128`** | 4 | `$FF6128` | `sfx_trigger_object_enable_fields` / `vdp_sprite_pointer_setup_cond_disp_clear` |
| 2 | `$0600CB20` | **`$0600C178`** | 8 | `$FF6178` | `entity_heading_and_turn_rate_calculator` / `render_slot_setup` / `scene_init_vdp_block_setup` |
| 3 | `$0600CD30` | **`$0600C254`** | 7×8 | `$FF6254` | (display-object block continuation) |

All three are sub-ranges of the same `$FF6000`+`$500` DREQ block (so all land in SDRAM `$0600C000+`
each cmd `$0102` frame), and all use the same `0 = invisible` +$00/+$14/+$28 gate (entity loop
`$060024DC` +$00 gate; 68K `vdp_sprite_pointer_setup_cond_disp_clear` clears +$00/+$14/+$28/+$3C).

**Implications for the 5F-1b port:**
1. The port must emit descriptors at **C128/C178/C254** (cache-through `$2600C128` etc.), in the layout
   those blocks' 68K writers use — **NOT** the `object_table_sprite_param_update` $3C-record layout at
   C218. The per-block record layout (stride, fields read by `$060024DC`/`$06002494`) must be decoded for
   each of C128/C178/C254 before porting.
2. `object_table_sprite_param_update` (`$0036DE`, the function 5F-1a planned to port) writes `$FF6218`
   → C218 → a **non-racing** render path. Porting it does not move the racing cars. Re-scope the port to
   reproduce whichever 68K functions write `$FF6128/$FF6178/$FF6254` for the racing entities.
3. The 5F-1a `$3C`-stride assumption is wrong for the racing render: the entity loop `$060024DC` walks
   **$14 (20-byte)** descriptor records (`$06002504 ADD #20,R14`), with the polygon pointer at +$10
   (`$060024EE MOV.L @(16,R14),R13`). Decode the C128/C178/C254 record format at $14 stride.

**Caveat / residual uncertainty:** which 68K function(s) populate C128/C178/C254 with the *opponent-car*
descriptors (vs. viewport/HUD/track sprite blocks) is not yet fully mapped — the writers found
(`sfx_trigger...`, `vdp_sprite_pointer_setup...`, `entity_heading...`, `render_slot_setup`) suggest these
blocks mix sprite-pointer setup, viewport config, and per-entity enable flags. The mapping
"which descriptor index = which opponent car" must be established before a port. **That is exactly what
the next disambiguating probe should pin down empirically** (§6).

---

## 6. Next disambiguating probe (single best test)

Static analysis is conclusive that C218 is wrong and C128/C178/C254 is right; what remains *empirically*
unknown is **which of the three blocks (and which indices) carry the visible opponent cars** during
racing. One cheap probe answers it unambiguously.

**Probe NEXT-1 — clear visibility on the racing descriptor blocks, one block per run.**
In `bridge_probe` (or a sibling), change the base + stride + count to target **one** block at a time,
cache-through, clearing the +$00/+$14/+$28 words (same field logic, already proven correct):

- **Run A:** base `$2600C128`, **stride $14**, count 4 → clears batch-1 visibility.
- **Run B:** base `$2600C178`, **stride $14**, count 8 → clears batch-2 visibility.
- **Run C:** base `$2600C254`, **stride $14**, count 56 (7×8) → clears batch-3 visibility.

(Use $14 stride — the entity loop reads $14-stride records. Clearing +$00 alone is sufficient to hit the
`$060024DE` gate; +$14/+$28 are belt-and-suspenders.)

**Expected outcomes / what each proves:**
- If a run makes **opponent cars vanish** → that block (and the bridge to it) is the correct racing
  render input → the 5F-1b port targets that block. **This is the green light 5F-1b actually needs.**
- If a run makes **track sprites / HUD / viewport elements** vanish instead → that block is non-car;
  move to the next block.
- If **no run** changes the cars → the cars are rendered from a block not in {C128,C178,C254} (e.g. the
  batch-0 camera record C100→CA00, or the on-chip Pipeline-1 path), and we re-trace; but the static
  evidence strongly predicts one of these three is the car block.

**Recommended single run to start: Run C (`$2600C254`, $14, 56).** It is the largest block (56 records
via the 7×8 outer/inner loop) and is the one the handler walks last/most heavily — most likely to hold
the bulk opponent descriptors. If Run C alone vanishes opponents, the bridge target is settled in one
shot.

> Order-of-operations note: keep the probe at the **same injection point** (`cmd3f_vr60_gameframe.asm:259`,
> just before COMM2_HI=$02) so the H3 timing variable is held constant. If a correct-address run *still*
> shows no change, only THEN does the H3 timing/double-render question (§3) become live — and the §4.3
> DREQ-gating discussion in 5F-1a applies, but to C128/C178/C254, not C218.

---

## Appendix — load-bearing decodes (from `build/vr_rebuild.32x`)

- Slave jump table `$060005C8`: entry 2 = `$06000FA8` (cmd $02 racing render).
- cmd `$02` handler `$06000FA8` body + pool `$0600103C-$060010A8`: descriptors C100/C128/C178/C254/C6DC;
  entity loop `$060024DC`; **no C218**.
- Entity loop `$060024DC`: +$00 visibility gate (`$060024DE-E2`), $14 descriptor stride (`$06002504`),
  poly ptr at +$10 (`$060024EE`).
- Transform `$06001D34` (C218 path): +$00 gate (`$06001D34-38`), skip path R14+=$3C (`$06001D9E`),
  active path R14+=$14 (`$06001D5E`) — belongs to dispatcher `$06000DC8`.
- C218 readers: `$06000DEA / $06000F06 / $06001106 / $060013C2 / $0600152C` (all non-cmd-$02 handlers);
  `$06000DC8` callers `$060008C2 / $06000D22 / $06001958`.
- 68K racing-descriptor writers/visibility semantics:
  `vdp_sprite_pointer_setup_cond_disp_clear.asm:36-45` (clears `$FF6128` +$00/+$14/+$28/+$3C = invisible);
  `sfx_trigger_object_enable_fields.asm:7` (sets `$FF6128` +$00/+$14 = 1 = visible).
- Probe under test: `bridge_probe.asm:67-90` (writes `$2600C218`, 15× $3C, +$00/+$14/+$28 = 0).
- Injection: `cmd3f_vr60_gameframe.asm:258-260` (`.bridge_addr = $023039E0`, JSR), `:303-304` (COMM2_HI=$02).
