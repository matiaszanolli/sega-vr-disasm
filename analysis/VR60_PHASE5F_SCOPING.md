# VR60 Phase 5F — Collision Switchover: Scoping & Design

**Created:** 2026-06-18
**Author:** Worker (research/scoping role — NO code written)
**Status:** SCOPING. This document answers the Phase 5F central question and scopes A–G.
**Inputs:** `VR60_ROADMAP.md` §9/§13/§14, `analysis/agent-scratch/worker/findings.md` (5A–5E),
the ported collision sources, `render_state_patcher.asm`, `cmd3f_vr60_gameframe.asm`,
the 68K `entity_render_pipeline.asm` + `vr60_physics_bypass_trampoline.asm`, and
`analysis/sh2-analysis/SH2_RENDERING_ARCHITECTURE.md`.

> **Bottom line up front:** In the current build the SH2 physics/AI (and the ported-but-unwired
> collision) are **pure shadow computation**. The on-screen car is driven by the **68K WRAM
> entity**, rendered through the DREQ'd display objects; the 68K still runs `entity_pos_update`
> and 68K collision every frame. SH2 results in SDRAM ($0600F20C / $06010000) reach **nothing
> visible**. Therefore **5F as currently imagined (just "wire collision in") is NOT the right
> next step** — shape **(Y)** is the reality: a **SH2→render bridge must be built first**, or
> wiring collision changes nothing on screen. This document scopes that bridge as the true
> first deliverable and recommends a go/no-go gated sub-phase plan.

---

## 0. The Central Question — Definitive Evidence-Based Answer

### 0.1 End-to-end data path for the visible car (CURRENT build, SH2-physics mode)

```
68K V-INT input scan
  → (COMM relay) → cmd $3E stages WRAM entity → SDRAM $0600F20C (player) / $06010000 (AI)   [INITIAL FRAME ONLY, A-1 / R-019]
  → cmd $3F (Master SH2): physics(player) + AI loop(15) + render_state_patch + Slave re-trigger
       │  physics writes SDRAM entity +$30/$34 etc.            ── SHADOW (see 0.3)
       │  render_state_patch writes $0600CA00 / $0600CCA0      ── NO-OP (see 0.2)
       │  COMM2_HI=$02 re-triggers Slave cmd $02               ── re-renders, but reads frozen DREQ data
       ▼
68K entity_render_pipeline (Variant A) with $C8D2 != 0:
       trampoline SKIPS physics math, BUT STILL runs:
         entity_pos_update → 68K collision (tail-JMP)          ── 68K collision AUTHORITATIVE
         display-object production from the WRAM entity         ── frozen positions (no copy-back)
       ▼
68K object_table_sprite_param_update → display objects ($FF6218) → DREQ FIFO
       ▼
Slave 3D engine reads $0600C000 (Huffman) / $0600C800 (entity visibility, 32×16B)
       → main_coordinator_short ($06003024), coord_transform, frustum_cull, span_filler
       → Frame Buffer $04000000
```

**Citations:**
- 68K bypass re-entry STILL runs collision + rendering:
  `disasm/modules/68k/sh2/vr60_physics_bypass_trampoline.asm:33-38` (`.bypass_physics` jumps to
  `entity_render_pipeline_position_ai`, i.e. *after* physics but *before* `entity_pos_update`),
  and `disasm/modules/68k/game/render/entity_render_pipeline.asm:43-44` (re-entry label,
  `jsr entity_pos_update`).
- `entity_pos_update` tail-JMPs into 68K collision:
  `disasm/modules/68k/game/physics/entity_pos_update.asm:32,35,38` (`jmp collision_response_surface_tracking[+278]`).
- Slave 3D engine inputs: `analysis/sh2-analysis/SH2_RENDERING_ARCHITECTURE.md:74` (main_coordinator_short
  $06003024), `:123` (R13 = $0600C000), `:133` ($0600C800 Huffman, "active during racing").
- cmd $3F call sequence: `disasm/sh2/expansion/cmd3f_vr60_gameframe.asm:206-208` (entity_pos_update,
  NO collision), `:252-253` (render_state_patch), `:292-294` (COMM2_HI=$02 Slave re-trigger).

### 0.2 `sh2_render_state_patch` is a verified no-op (independently confirmed)

- The patcher writes **only** $0600CA00 (PHASE 2, 82 entries × $30) and $0600CCA0 (PHASE 3,
  15 AI × $90): `render_state_patcher.asm:131` (`.state_base = $0600CA00`), `:166`/`:307`/`:310`.
- **Grep of the entire `disasm/sh2/3d_engine/` tree for any reader of the CA00/CCA0/CA60/CB20/CD30
  state-array region returned ZERO hits** (excluding the unrelated $060043F0/$060045CC/$0600410C/
  $06004184/$060048D0 literals). The only mentions of CA00/CCA0 anywhere in `disasm/sh2/` are inside
  `render_state_patcher.asm` (the writer) and the two findings/comment blocks in
  `collision_response.asm`.
- The 3D engine reads its per-entity transform inputs from a **different** memory:
  $0600C000 (context/Huffman), $0600C800 (entity visibility 32×16B), plus on-chip SRAM context
  ($C0000400 matrix, $C0000700 render context) and the SDRAM tables $0600410C/$06004184/$060048D0.
  See `SH2_RENDERING_ARCHITECTURE.md:100-101,123,133` and `context_setup_short.asm:21-22`.
- **Empirical corroboration:** the roadmap changelog (2026-06-17) and `collision_response.asm:31-35`
  record **0% measured Slave-render change** from the patcher — i.e. removing/altering its writes
  has no visible effect. This matches the static grep.

> **Documented discrepancy (flag):** `SH2_RENDERING_ARCHITECTURE.md:138-141` lists the entity-state
> batches at $0600CA60 / $0600CB20 / $0600CD30 — *near* but not identical to the patcher's
> $0600CA00 / $0600CCA0. Either the patcher targets the wrong base (off by $60/$0) **or** the doc's
> addresses are stale. Either way the net effect is the same (no reader in the build), but **this
> address mismatch must be resolved before any bridge is built on these arrays** — it suggests the
> patcher was written against a guessed layout, not a verified one. MUST-RESOLVE for the bridge.

### 0.3 Are Phases 3–5 shadow computation? — YES (with one nuance)

| Question | Answer | Key evidence |
|----------|--------|--------------|
| Is WRAM ($FF9000) or SDRAM ($0600F20C/$06010000) entity authoritative for what's RENDERED? | **WRAM.** Display objects are built by the 68K from the WRAM entity (trampoline still runs the render half). | trampoline:33-38; entity_render_pipeline.asm:43+ |
| Does the visible player car move because of 68K or SH2 physics? | Neither *visibly* moves it correctly: 68K physics math is *skipped* ($C8D2 set) so the WRAM positions are **frozen** at the staged value; SH2 physics moves the SDRAM copy which nothing renders. The car you see is driven by the **frozen WRAM entity + 68K collision/rendering** path. | trampoline:27-28 (skip physics), no SH2→WRAM copy-back anywhere |
| Do SH2 results reach the screen via any bridge? | **No.** render_state_patch is the *intended* bridge but is a proven no-op. | §0.2 |
| Are Phases 3–5 pure shadow? | **Yes.** Physics/AI run on SDRAM entities nothing reads; collision (5A–5E) isn't even dispatched. | cmd3f:206-208 (no collision JSR); 5C/5D/5E "DEFERRED" |

**The missing bridge (precise):** a step that takes the SH2-authoritative SDRAM entity
(+$30/$34 world X/Y, heading, scale, render fields) and makes it the source of the **display
objects the Slave actually reads** — i.e. either (a) Master SH2 produces the $0600C800 entity-
visibility / display-object records directly from the SDRAM entity (porting
`object_table_sprite_param_update`, already scoped in Phase 2 §6.2), or (b) the SH2 writes
WRAM-equivalent display objects back through the DREQ landing area so the existing 3D engine
reads SH2-derived data. `render_state_patch` attempted a *third* path (patch the CA00/CCA0
arrays) that the engine doesn't read — that path is a dead end.

> **Nuance worth stating honestly:** because the WRAM positions are *frozen* (68K physics
> skipped, no copy-back), the visible car in SH2-physics mode is **not** being driven by live
> 68K physics either. The game still *appears* to play in autoplay because (i) the player entity's
> frozen state + 68K collision still resolves wall contacts on the WRAM entity, and (ii) much of
> the visible motion is camera/scene scrolling. The precise behavioral fidelity of the current
> SH2-physics-on / frozen-WRAM build vs. a stock 68K build is **not characterized** and is a
> must-resolve before trusting any switchover (see §F open questions).

### 0.4 WRAM↔SDRAM sync model & authoritative-copy (answers central Q4)

- cmd $3E stages WRAM → SDRAM **initial-frame-only**, gated by `$C8D2` (A-1 / R-019 RESOLVED):
  `VR60_ROADMAP.md` R-019 ("initial-frame-only staging … entity persists in SDRAM"), Decision Log
  2026-03-26 ("Co-port timer/guard … no per-frame WRAM→SDRAM staging needed").
- After the seed frame there is **no per-frame WRAM↔SDRAM reconciliation in either direction.**
  SDRAM accumulates SH2 physics; WRAM is frozen. **They diverge by design** and never re-sync.
- **Authoritative-copy model today:** *split and divergent* — WRAM authoritative for **render**,
  SDRAM authoritative for **nothing consumed**. There is no single source of truth.
- **Implication for collision ownership:** whoever owns collision must own the **same** entity copy
  that drives rendering. Today that is WRAM (68K). So **wiring SH2 collision onto the SDRAM entity
  cannot affect gameplay until the SDRAM entity also drives rendering.** This is precisely why 5F
  must build the render bridge before (or together with) the collision switchover.

---

## A. Collision wiring mechanics (for when the bridge is live)

**Single dispatch entry point (confirmed):** `collision_response_surface_tracking`
(SH2 **$02303410**, 5D). It internally calls `track_boundary_collision_detection` ($02303250, 5C),
which itself calls `track_data_index_calc`/`extract_033` ($02303100/$0230317C, 5B),
`angle_normalize[_p24/_alt]` + `plane_eval_signed` + `object_type_dispatch` (5A/5C). So **5C needs
no separate dispatch** — 5D is the one JSR for the entire track-boundary stack
(findings.md 5D "WIRING DECISION", `VR60_ROADMAP.md` §9.0b 5D bullet).

**Object/proximity stack** is a *separate* entry: `object_collision_detection` (SH2 **$02303640**,
5E) → `zone_check_inner` ($023037C4) / `position_separation` ($02303768); plus
`proximity_zone_loop` ($02303964) for the 15-entity zone classify.

**Call site in cmd $3F:** after `.phys_f12` (the `entity_pos_update` JSR) at
`cmd3f_vr60_gameframe.asm:206-209`. This mirrors the 68K order, where `entity_pos_update` tail-JMPs
into `collision_response_surface_tracking` (entity_pos_update.asm:32/35/38).

**Per-entity application — proposed (must match 68K):**

| Entity | 68K behaviour | SH2 5F wiring |
|--------|---------------|---------------|
| Player (entity 0) | `entity_pos_update`→`collision_response_surface_tracking` (full track boundary + binary search + EMA), then `proximity_trigger` / `object_collision` in the render orch | JSR $02303410 with GBR=player after `.phys_f12`; then JSR object_collision ($02303640, loads A1=$06010E00) + proximity |
| AI (1..15) | Variant B (`entity_render_pipeline_with_2_player_dispatch.asm:68,194`) calls `collision_response_surface_tracking+278` (the surface-tracking-only re-entry, NOT the full binary search). object_collision is player-vs-entity-15. | In the AI loop (cmd3f:216-243): the AI variant uses the **+278 entry** (surface tracking only). The 5D port currently exposes the **$303410 head** (full search). **GAP:** the `+278` SH2 offset must be located/exported before AI collision can match 68K. Player-only collision is the safe first cut. |

> **Order to preserve (68K state 8):** physics → `entity_pos_update` → collision_response (tail) →
> `proximity_trigger`/`object_collision` (in the render orch). The cmd $3F port already has
> physics→entity_pos_update; collision_response goes immediately after; object/proximity after the
> AI loop with GBR=player.

**Open mechanical questions (must resolve before wiring live):**
1. The 68K AI path uses `collision_response_surface_tracking+278` (a mid-function re-entry). The 5D
   port must expose that offset as a labeled entry; not yet done (findings.md 5D documents only the
   $303410 head).
2. `object_collision_detection` is player-vs-**entity-15** only ($06010E00) in 68K; confirm whether
   5F needs the full N² proximity (`proximity_zone_loop`, 15 entities) wired too, or just the
   player path. 68K runs both (`proximity_trigger` per entity + `object_collision` player-vs-15).

---

## B. Globals staging needed

| Global | 68K addr | SDRAM target | Scene-stable (A-2) or per-frame? | Status |
|--------|----------|--------------|----------------------------------|--------|
| race_state | $FFC8A0 | globals +$38 (word) | per-frame (live value) | **WIRED** (vr60_globals_stage; findings 5C) |
| track_seg_base | $FFC268 | globals +$3A (long, **+$01780000 pre-translated**) | scene-stable, but staged per-frame as live value (A-2) | **WIRED + ROM-verified** (findings 5C: bytes `2038 c268 / d0bc 0178 0000 / 22c0`) |
| entity +$E4 alt-flag | entity field | read directly via GBR | n/a | no staging needed |
| OBJ_COLL_GLOBALS: thresholds $C8CE/$C8D0 + zone bounds $C8E4–$C8F2 (8 words) | $FFC8CE.. | $06011050 (TRACK_WORK) | **scene-stable → stage ONCE at scene init (A-2)** | **NOT wired** — 5E identified, deferred to 5F |
| probe-offset / COLL_POS scratch | $C02E–$C044 / $C0D0–$C0E2 | $06011000 (workbuf) / $06011030 (COLL_POS) | intra-frame SH2-only scratch | **WIRED** (5C/5D; native SDRAM) |
| surface type/counter | $C319/$C31A | $06011020/$06011021 | intra-frame | **WIRED** (5C) |
| sound +$2C | (collision sound) | globals +$2C → COMM6_HI | per-frame relay | **WIRED** (cmd3f:264-276) |
| $C268→globals+$3A | — | — | — | **DONE** (A-2) |

**Packer changes required for 5F:** add the **scene-init-once** stage of OBJ_COLL_GLOBALS
($C8CE/$C8D0 + $C8E4–$C8F2) to $06011050. **Free-globals constraint:** the per-frame staged window
**+$30–$3F is rewritten every frame** by `vr60_globals_stage` (Decision Log 2026-03-26: globals+$30
"cleared every frame"), so OBJ_COLL_GLOBALS **cannot** live there — it must go to the scene-stable
TRACK_WORK region $06011050 (verified free, 5E). race_state(+$38)/track_seg_base(+$3A) are the only
collision globals that belong in the per-frame window (they're live values).

---

## C. Gating off the 68K collision path

**Where the 68K runs collision:**
- Player: `entity_pos_update` tail-JMP → `collision_response_surface_tracking`
  (`entity_pos_update.asm:32,35,38`).
- AI/variant: `collision_response_surface_tracking+278` from the render pipelines
  (`entity_render_pipeline_with_2_player_dispatch.asm:68,194`,
  `race_frame_main_dispatch_entity_updates.asm:128`, + 4 more render modules).
- Object/proximity: `object_collision_detection` in `gfx_2_player_entity_frame_orch.asm:42`;
  `proximity_trigger` in `entity_render_pipeline.asm:50`.

**Gating mechanism:** the existing `$C8D2` flag already gates physics off via the trampolines
(`vr60_physics_bypass_trampoline.asm:27-28`, `vr60_ai_bypass_trampoline.asm`). Extending the
bypass to **also skip `entity_pos_update`/collision** is the gating lever. **CRITICAL CAVEAT:**
`entity_pos_update` does the **position integration** (16.16 → entity +$30/$34) that the *render
half* still depends on. You cannot simply skip it without the SDRAM entity's position flowing into
the display objects — i.e. the gate is only safe **once the render bridge is live** (§0.3). Gating
collision off the 68K WRAM entity while the WRAM entity still drives rendering would leave the
visible car with **no collision at all**.

**68K consumers of collision outputs (who breaks if WRAM collision fields go stale):**

| Field(s) | Meaning | Downstream 68K consumer (must audit before gating) |
|----------|---------|----------------------------------------------------|
| +$55–$59 | per-probe collision flags | collision_response binary search; render visibility |
| +$5A/$5C/$5E/+$32 | surface-height EMA | drift/physics tilt, render height |
| +$30/$34 | corrected world position | **display-object production, camera, lap/checkpoint logic** |
| +$88/+$02 | collision/state flags | state machine, sound triggers |
| +$C0/+$89 | zone classification | AI avoidance, scoring |
| +$CE/$D2/$D6/$DA/$DE | track tile pointers (68K-form in WRAM) | 68K collision re-dereference; **A-3: never copy WRAM-form into SDRAM** |

> The +$30/$34 dependency is the crux: corrected position feeds rendering, camera, **and**
> lap/checkpoint/scoring. A full audit of every reader of +$30/$34/+$C0/+$89 is a **must-resolve
> before gating** — these are read far beyond the collision module.

---

## D. Carried Auditor advisories → concrete 5F steps

| Advisory | Requirement | Concrete 5F step |
|----------|-------------|------------------|
| **A-1** | cmd $3E player-entity staging stays **initial-frame-only** ($C8D2-gated). A mid-race mode-0 stage corrupts SDRAM entity +$CE/$D2/$D6/$DE pointers with 68K-form garbage. | **Step 5F-pre:** re-confirm the $C8D2 gate on cmd $3E hasn't regressed (read `cmd3e_entity_transfer.asm` + the 68K stage trigger) **before** any pointer-bearing collision runs live. Add an assert/canary on the staging mode each frame during dual-path. |
| **A-2** | OBJ_COLL_GLOBALS + $C268 are scene-stable → stage **once** at scene init, sample where the 68K collision uses them. | **Step:** add scene-init-once packer write of $C8CE/$C8D0/$C8E4–$C8F2 → $06011050. ($C268→+$3A already A-2-compliant, ROM-verified.) |
| **A-3** | 5F copy-back must NEVER move WRAM 68K-form +$CE/$D2/$D6/$DA into SDRAM. | **Step:** the render bridge / copy-back must copy only **position/scalar** fields (+$30/$34/$5A.. etc.), never the tile-pointer fields. Codify a field allow-list; assert SDRAM +$CE.. is only ever written by the SH2 5C path (SH2-form). |
| **A-4** | `object_type_dispatch` maps trap/oob nibbles (5,6,7,9–15) to $02; 68K would *trap* (DIVU/0 at $7AB2) — masking a divergence. | **Step:** at the cmd $3F dispatch step, before deleting the 68K collision call, add a **debug canary**: if a surface nibble ∈ {5,6,7,9–15} is ever classified, write a sentinel to a diagnostic SDRAM slot and halt the dual-path comparison for inspection. Only delete the 68K path after the canary stays clean over a full multi-track autoplay. |

---

## E. Verification & rollback plan

**Dual-path compare (the core safety net, mirrors Decision Log 2026-03-26 + §15.3):**
1. Keep 68K collision running (WRAM entity authoritative for render). Wire SH2 collision additive
   onto the SDRAM entity (no gating yet).
2. Each frame, dump the SH2-computed fields (SDRAM +$30/$34/+$55–$59/+$5A/$5C/$5E/+$32) to a
   diagnostic SDRAM block, and the 68K-computed fields (WRAM, via the existing DREQ/canary path or
   a temporary diagnostic copy) to an adjacent block.
3. Byte-compare for ≥100 frames per track (3 tracks). Any mismatch → stop, investigate.
   *(Note: the WRAM entity is currently FROZEN, so a naïve compare would diverge immediately. The
   compare is only meaningful AFTER the SDRAM entity drives rendering and the WRAM path is run for
   reference — this is itself a reason the bridge must come first; see §G.)*

**Profiling gates (Worker drives, headless):**
- `vrd_budget.py` with `VRD_PROFILE_PC=1 VRD_GATE_3D=1 VRD_SCENE=0x4CBC`: **Slave < 100%** after
  wiring (collision adds Master work, not Slave; verify no SDRAM-contention spillover, R-002).
- `fb_crc` / framebuffer-hash: in the 60 FPS target the 3 per-tick frames must become **unique**;
  for the 5F switchover (still 20 FPS), the gate is **no regression** in the per-frame hashes vs the
  pre-5F build (i.e. collision wiring doesn't corrupt rendering).
- 3600-frame autoplay (menus + 3 tracks + results), no crashes/hangs (§15.3).

**Incremental staging + revert path:**
- Each sub-phase is one additive, independently revertable commit (git, on the `60fps_project` /
  vr60 branch). Baseline tag `vr60-phase0-baseline` enables `git diff` at any point
  (Decision Log 2026-03-17).
- The $C8D2 gate is the master switch: with the bridge additive and the gate OFF for collision,
  reverting = leaving the 68K path authoritative. Flip collision authority only at the final step.

**Division of labor:** Matias drives emulator/visual A-B checks (he can see the screen); Worker
drives headless `vrd_budget.py`/`fb_crc`/autoplay + byte-compare dumps (per
`feedback_verification_split.md`).

---

## F. Risk registry & open questions specific to 5F

| ID | Risk / unknown | Severity | Mitigation / flag |
|----|----------------|----------|-------------------|
| 5F-1 | **The render bridge doesn't exist** — SH2 collision (and physics/AI) is shadow; wiring collision changes nothing visible. | **Blocking** | Build the bridge first (§G). This is the central finding. |
| 5F-2 | render_state_patch targets $0600CA00/$0600CCA0 but the doc lists entity-state at $0600CA60/CB20/CD30 — address provenance unverified (guessed?). | High | **MUST-RESOLVE before any bridge on these arrays.** Independently disassemble the Slave cmd $02 setup chain and confirm the *actual* per-entity state base the engine reads. Do NOT build on the patcher's literals. |
| 5F-3 | WRAM entity is frozen in SH2-physics mode (no copy-back); current behavioral fidelity vs stock 68K is uncharacterized. | High | Characterize the current build's racing behavior (lap times, collision response) vs a stock-physics build before trusting switchover. Matias visual + Worker headless lap-time compare. |
| 5F-4 | A-1 interaction: mid-race mode-0 cmd $3E stage overwrites SDRAM +$CE.. with 68K-form pointers → live track_boundary dereferences garbage. | Critical | Re-confirm $C8D2 gate; assert staging mode each frame (A-1 step in §D). |
| 5F-5 | A-4: trap-nibble divergence masked (SH2 returns $02, 68K traps). | Medium | Canary at dispatch (A-4 step). |
| 5F-6 | AI collision uses `+278` re-entry (surface-tracking only); 5D port exposes only the $303410 head. | Medium | Expose/label the `+278` SH2 entry, or do player-only collision first. |
| 5F-7 | SDRAM bus contention (R-002, OPEN): collision adds Master SDRAM traffic; Slave may stall. | Medium | Profile Slave before/after; collision math is mostly register/ROM-table, SDRAM touches are entity-field reads. |
| 5F-8 | Sound timing: collision sounds ($B1/$B2/$B4/$B8) relayed via globals+$2C→COMM6_HI — single-byte last-writer-wins; multiple collision sounds in one frame collide with physics sounds. | Medium | Audit the +$2C sound-byte arbitration when collision is added to the same relay (physics already uses it, cmd3f:264-276). |
| 5F-9 | 2-player mode (R-008): different entity/render paths, MOVEM block copy assumes same-CPU update. | Medium | 5F = 1P only (matches Phase 3). Defer 2P. |
| 5F-10 | Mode transitions (race↔results↔menu) re-stage / reset $C8D2; scene-init-once OBJ_COLL_GLOBALS must re-stage per scene. | Medium | Hook the scene-init stage into every racing-scene entry, not just first-ever. Verify across transitions in autoplay. |
| 5F-11 | Dual-entity reconciliation: no per-frame WRAM↔SDRAM sync; the two diverge. | High | The bridge must establish a single authoritative copy (SDRAM) for the rendered entity, eliminating the divergence rather than papering over it. |

---

## G. Recommended sub-phase breakdown for 5F (with go/no-go gates)

> **Honest conclusion:** "5F = wire collision into a working SH2 render path" (shape **X**) is **not**
> the current reality. Shape **Y** holds: **the SH2→render bridge is the real prerequisite.** I
> recommend renaming/rescoping 5F so its FIRST deliverable is the bridge, and only then the
> collision switchover. The collision ports (5A–5E) are correct and ready; they are not the
> blocker. **This arguably belongs partly with Phase 6/7 thinking** (the bridge is also what makes
> per-TV-frame logic, Phase 7, actually move the car), so 5F and the Phase 7 "AI/collision offload
> tail" should be planned together.

### 5F-0 (FIRST STEP) — Verify the real render input layout *(research only, no code)*
- **Do:** Disassemble the Slave cmd $02 setup chain ($06002FAE → main_coordinator_short $06003024)
  and the cmd $23 Huffman path ($06004AD0) to establish **exactly** which SDRAM/SRAM addresses the
  engine reads per entity for transform/position, and how $0600C800 (32×16B) is populated each frame
  (it's the DREQ landing of the 68K display objects). Resolve the $0600CA00 vs $0600CA60 discrepancy
  (5F-2).
- **Go/no-go:** GO to 5F-1 only if a single, cited "the engine reads entity transform input from
  ADDR, written each frame by WRITER" statement can be made. NO-GO (escalate) if the input turns out
  to be on-chip SRAM written by the Slave itself (Pipeline 1, H-9 — invisible to Master), which would
  make a Master-side bridge impossible and force a different intercept.

### 5F-1 — Build the SH2→render bridge (the real prerequisite)
- **Do:** Port `object_table_sprite_param_update` (Phase 2 §6.2, $0036DE, 216B, pure transform) to
  SH2 so the **Master produces the $0600C800 display/visibility records directly from the SDRAM
  entity**, OR (alternative) have cmd $3F write SH2-derived display objects into the DREQ landing
  area so the existing engine reads SH2 data. Keep 68K rendering running in parallel (additive).
- **Verify:** Worker byte-compares SH2-produced display records vs the 68K-produced ones for 100
  frames/track; Matias visual A-B. `fb_crc` no regression.
- **Go/no-go:** GO to 5F-2 only when SH2-derived display records are byte-identical to 68K's for all
  3 tracks. This is the gate that makes "the SDRAM entity is authoritative" *true*.

### 5F-2 — Flip rendering to the SDRAM entity (make SH2 physics visible)
- **Do:** Switch the display-object source to the SH2 path; the visible car now moves from SH2
  physics. (No collision yet — expect the car to clip walls, which is the *expected, informative*
  signal that the bridge works and collision is needed.)
- **Go/no-go:** GO only when the car visibly responds to SH2 physics (Matias) and Slave <100%,
  fb hashes unique-where-expected (Worker). Revert path: re-point display source to 68K.

### 5F-3 — Wire SH2 collision (player-only) additively + dual-path compare
- **Do:** JSR `collision_response_surface_tracking` ($02303410) after `.phys_f12`; stage
  OBJ_COLL_GLOBALS once at scene init; honor A-1/A-2/A-3; add the A-4 trap canary. Keep 68K
  collision running for reference (dual-path).
- **Verify:** byte-compare SH2 vs 68K collision outputs (+$55–$59/+$5A/$5C/$5E/+$32/+$30/$34) ≥100
  frames/track; canary clean.
- **Go/no-go:** GO to 5F-4 only on 0 mismatch + clean canary across 3 tracks.

### 5F-4 — Add object/proximity + AI collision
- **Do:** JSR `object_collision_detection` ($02303640) + `proximity_zone_loop`; locate/label the
  `+278` AI surface-tracking entry for the AI loop.
- **Go/no-go:** dual-path 0 mismatch incl. AI; sound-relay arbitration verified (5F-8).

### 5F-5 — Gate off the 68K collision path (switchover)
- **Do:** Extend the $C8D2 bypass to skip 68K `entity_pos_update`/collision now that the SDRAM
  entity is authoritative for render. Audit & confirm all +$30/$34/+$C0/+$89 consumers read the
  SH2-corrected values (§C).
- **Verify:** full 3600-frame autoplay, `vrd_budget.py` (Slave <100%, confirm 68K relief toward the
  Phase 7 ~10% goal), `fb_crc`.
- **Go/no-go:** ship only on clean autoplay + no behavioral regression (Matias) + measured 68K
  relief (Worker).

---

## Appendix: Load-bearing citations

- Shadow proof / 68K still renders: `vr60_physics_bypass_trampoline.asm:27-38`,
  `entity_render_pipeline.asm:24,43-44`, `entity_pos_update.asm:32,35,38`.
- Patcher no-op: `render_state_patcher.asm:131,166,307,310`; grep (zero readers in
  `disasm/sh2/3d_engine/`); `collision_response.asm:31-35`; `VR60_ROADMAP.md` changelog 2026-06-17.
- 3D engine inputs: `SH2_RENDERING_ARCHITECTURE.md:74,100-101,123,133`, `context_setup_short.asm:21-22`.
- cmd $3F sequence: `cmd3f_vr60_gameframe.asm:206-209,252-253,292-294,264-276`.
- Collision entry points: findings.md 5A–5E; `VR60_ROADMAP.md` §9.0b.
- A-1..A-4: `VR60_ROADMAP.md` §9.0b advisory block; R-019/R-008/R-002 §14.
- Staging model: Decision Log 2026-03-26; R-019.
- Address discrepancy (CA00 vs CA60): `SH2_RENDERING_ARCHITECTURE.md:138-141` vs
  `render_state_patcher.asm:307,310`.
