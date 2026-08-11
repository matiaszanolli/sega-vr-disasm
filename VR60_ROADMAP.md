# VR60 Roadmap — Ground-Up Architectural Redesign

**Created:** 2026-03-17
**Branch:** `60fps_project` (original byte-identical baseline: `v5.0-freeze`)
**Goal:** Redesign the game's core for true 60 Hz game logic and display while preserving real-time behavior
**Pace:** Methodical. Every decision backed by evidence. No rushing.

---

## Canonical status (2026-08-11)

The project is in **integration and validation**, not “one blocker from 60 FPS.” The current
normal-1P path still uses the original 68000 physics, AI, collision, and render preparation as
the authority. The 1P state-8 hook is valid and executes at about 20 Hz. Q-020's player-entity
mode-0 sub-gate has passed all three accepted lifecycles twice per arm and is now the promoted
ordinary default. Globals mode 1 is disabled/unreachable in that default. Commit `6597d3d`
replaced the rejected COMM1 ACK with a diagnostic CMDINT direction. A fresh isolated mode-1
ACTIVE/STAGE-CONTROL pair has now passed its PicoDrive validation stage using two Master CMD
edges and zero COMM0-COMM7 accesses. Its exact Gate-B transport, eight route captures, safe
frame-1241 VRES boundary, and fail-closed evidence composition are approved; it is not promoted
into the ordinary default. AI staging (mode 2), cmd `$3F`, and the 68000 physics bypass are
disabled. Therefore
the assembled SH2 physics/AI/collision ports do not currently control normal 1P gameplay.

The last apparent long-run baseline is invalid: `savestate_1p_gp_racing.bin` eventually stops
advancing `$C87E` even with the 1P hook physically bypassed. The earlier “724 unique hashes”
comparison and its attribution of freezes to AI transfer/cmd `$3F` are retracted. Those stages
are **unverified**, not proven broken.

The fresh normal-1P state required by VR60-005 now exists and passes a 360-frame-warmup plus
1,800-frame diagnostic on every liveness signal, and VR60-006 has captured its complete
deterministic replay. VR60-007 then confirmed the exact-prefix bounded preflight. VR60-008 ran the
unchanged full 18,000-frame control and failed. VR60-009's non-perturbing exact write trace proves
that the apparent frame-4536 `$C87E` `$0000 -> $0008` transition is an end-of-frame sampling
alias: PCs `$884CF2` and `$884D0C` perform `$0000 -> $0004 -> $0008` during the same emulated
frame. The fixture's timed-race counter had expired, its display controller intentionally entered
the finish sequence, and state 12 wrote the results scene at frame 5128. VR60-010 now has an
interpreter-matched replacement candidate whose exact 2,160-frame prefix passed every bounded
functional check; it still needs a full 18,360-frame input that remains in normal 1P throughout.
VR60-008 remains blocked until that unchanged control passes. Q-020 modes 0 and 1 have now
passed their separately scoped gates; continue one independent stage at a time: AI transfer
mode 2, cmd `$3F` in shadow
mode, a bridge into the renderer-consumed
C128/C178/C254 descriptors, and only then subsystem authority/bypass changes.
Cadence and fixed-step scaling for true 60 Hz come after the data path is proven.

See [`VR60_STATUS.md`](VR60_STATUS.md) for the concise status matrix and definition of done.

### Milestone 1 tooling and fixture update (2026-07-22)

The deterministic control **validator is implemented**, and the exact-prefix VR60-007 preflight
satisfied every bounded liveness check. Its result still failed by policy because it was short;
the unchanged VR60-008 full run subsequently failed because the fixture reaches timed results, so
no full 18,000-frame control has passed yet. VR60-009 closed the apparent frame-4536 state-order
fault without changing the validator: exact writes prove no skipped handler, and the frame-5128
scene exit is intentional gameplay.
`tools/libretro-profiling/validate_1p_control.py` accepts a complete per-frame input replay and
records/checks the full normal-1P scene
pointer, contiguous frames, every `$C87E` cycle window, an unlimited exact state-8 caller trace,
framebuffer liveness, non-stuck COMM0/COMM2/COMM7 lanes, and non-idle work on both SH2s. The
tracked v4 PicoDrive patch is now the canonical source for caller tracing; traces have an explicit
completion footer and are unlimited by default instead of silently stopping after 50 hits.

The gate is deliberately unable to accept the current branch ROM: a control requires the original
two-JSR hook bypass at file `$4D62`, while the branch ROM contains the live VR60 jump. The
validator now requires both ROMs and proves they are byte-identical outside that exact eight-byte
delta, recording both hashes. Acceptance addresses, thresholds, 180-frame window, and canonical
fixture blacklist are fixed; offline analysis and every diagnostic override force failure. It also
rejects `savestate_1p_gp_racing.bin` by SHA-256 from `control_fixtures.json`. The reviewed
assembly-built bypass/reference pair, a new 1P state, its full deterministic replay, and the
exact-prefix preflight now exist; the attempted full control failed and VR60-009 proved the state
sample was an alias inside an expiring timed-race session. VR60-010 was opened to replace that
fixture for the unchanged continuous gate; the later accepted VR60-011 lifecycle suite closed
Q-019, so VR60-010 is now an optional stronger evidence shape. In a
diagnostic 1,800-frame run of the known invalid
combination, `$C87E` omitted state `$000C` in every later 180-frame window and COMM0_HI remained
non-zero for 1,755 consecutive frames; the caller trace itself completed with 595 hits and zero
drops. A normal PASS requires at least 18,000 frames; shorter diagnostics are permanently marked
failing. This is a fixture/control failure, not evidence about later offload stages.

### PicoDrive debugger foundation (2026-07-21)

The historical `_archive/pdcore` executable is not the repaired debugger: its `pd_load_rom()`
still returns `Not implemented`, and its green tests use bridge stubs rather than the emulated
32X. The supported debugger now lives in the same libretro/PicoDrive path as profiling. Running
`profiling_frontend <rom> --debug` (or `--debug-script`) boots the real ROM and provides the
first deliberately bounded slice: frame advance, Master/Slave register inspection, 68K/SH2
memory reads, and matching savestate save/load. `debugger_smoke.commands` advances 120 frames,
observes live Master PC `$0600424E` and Slave PC `$06000592`, reads all three address spaces,
and round-trips a state. Memory/register writes, execution breakpoints, input recording, and
disassembly were not part of that foundation. Input capture is the independently tested slice
described below; memory/register writes, execution breakpoints, and disassembly remain separate.

### Deterministic debugger input capture (2026-07-21)

VR60-003 is complete. Debugger command `joypad <mask>` selects an explicit P1 mask for
subsequent frames, while `record start <path>` / `record stop` capture the exact mask exposed to
PicoDrive as one local zero-based `frame,mask` row per completed frame. Input is resolved once
immediately before `core_run`; a loaded `VRD_INPUT_SCRIPT` cannot be overridden and debugger
advance fails before the first frame beyond the replay instead of falling back to held/default
input. Recordings refuse to overwrite an existing file, flush every row, and are deleted unless
explicitly finalized.

`test_frontend_input_recording.py` drives the real core through six non-zero mask segments over
exactly 600 frames, verifies rows `0..599`, replays the resulting CSV in a second process, and
re-records it byte-for-byte. It also verifies replay exhaustion, script-error/EOF/quit cleanup,
and overwrite refusal. This changes frontend input orchestration only; no game assembly or core
debug ABI changed.

### Assembly-built hook-bypass control ROM (2026-07-21)

VR60-004 is complete. `make control-rom` first builds and preserves the default live ROM, then
defines `VR60_CONTROL_ROM` for a second vasm pass. The source selector in
`game_frame_orch_013.asm` emits the original PC-relative `JSR animated_seq_player+10` / `JSR
object_update` pair instead of the live `JMP vr60_1p_staging_hook` / `NOP`; both branches occupy
exactly eight bytes. No built ROM is raw-patched.

`verify_control_rom.py` imports the validator's fixed ROM-pair policy and atomically records the
result in `control_rom_pair.json`. The preserved live reference is SHA-256
`14632a23804b6043921f0e66d3f9ff84cf2ae58c66c04617d933fd7874b93183`; the hook-bypass
candidate is `6a4c89cffa7df47a946b340d39492df05f2be316c76343cf7e4e932a8ca17672`.
Both are 4,128,768 bytes, their hook bytes are respectively `4EF90001C8B04E71` and
`4EBA69764EBA691C`, and the validator found zero differences outside file `$4D62-$4D69`.
The candidate also boots and passes the existing 120-frame real-core debugger smoke. A real
180-frame diagnostic recorded `control_rom_eligible: true` for this pair, then exited non-zero as
required for the forced short run and blocked fixture (with the known state-order and COMM0
failures); no ROM-policy failure was present. VR60-005 subsequently supplied the fresh state,
VR60-006 supplied its complete replay, and VR60-007 supplied the exact-prefix preflight described
below. VR60-008 then ran the complete unchanged control and failed; VR60-009 classified the
fixture's timed finish, and VR60-010 is now next.

### Fresh normal-1P candidate fixture (2026-07-22)

VR60-005 is complete. PicoDrive state
`/home/matias/.picodrive/mds/vr60_control_bypass.mds` is 678,514 bytes with SHA-256
`16a007b460f8f568615e7f6c13a3d22f06d82a5acbfa8011e23929f8861eb1cb`. It is distinct from
the blacklisted fixture and loaded the full normal-1P scene pointer `$00884CBC`.

A diagnostic beginning at state-load frame zero found COMM0_HI non-zero for frames 7-205. A
second run changed no code, threshold, ROM, state, or input: it classified the first 360 frames as
fixture warmup and validated the following 1,800 frames. That window passed all functional
signals and failed only the mandatory short-run rule. Metrics were: state maximum stall 1; 450
exact hook hits, maximum gap 4, zero drops; 1,039 framebuffer hashes, maximum stall 1; COMM0,
COMM2, and COMM7 maximum non-zero runs 3, 2, and 0; and useful work on both SH2s. This demonstrates
that the fixed warmup is sufficient for bounded candidate qualification. It does not prove why the initial cmd
`$02`/COMM0 interval lasts 199 sampled frames, so no generic COMM claim or threshold change is
accepted from this result.

The full replay covers warmup plus validation: exactly 18,360 `frame,mask` rows numbered
`0..18359`. VR60-007 used the exact first 2,160-row prefix (360 warmup + 1,800 validation);
VR60-008 used the complete replay (360 warmup + 18,000 validation) and exposed the later failure
documented below.

### Deterministic full replay (2026-07-22)

VR60-006 is complete. The real frontend loaded the VR60-005 state, selected the same held-A mask
`0x0100` used by the qualifying diagnostic, and recorded 18,360 completed frames to
`tools/libretro-profiling/fixtures/vr60_006_control_replay.csv`. The tracked artifact is 227,581
bytes with SHA-256 `07e71d174468de98f3327efdfd70116ae92500add08911b376aaa40b12994ab5`.
It has the exact `frame,mask` header and one ordered row for every frame `0..18359`; the fixed
validator parser accepted it.

A second real-frontend session loaded the CSV through `VRD_INPUT_SCRIPT`, replayed all 18,360
frames, and re-recorded the resolved input. The re-recording was byte-for-byte identical and had
the same SHA-256. This establishes complete deterministic capture and replay only. VR60-007
subsequently established bounded scene, state, hook, framebuffer, SH2, and COMM liveness for the
`0x0100` recipe; VR60-008 then established that the same recipe is not durable for the full run.

### Exact-prefix liveness preflight (2026-07-22)

VR60-007 is complete. An untracked temporary input file was derived as the exact header plus first
2,160 data rows of the committed VR60-006 replay. It covered frames `0..2159`, contained only
`0x0100`, passed the fixed parser, and had SHA-256
`d71ac7f484b7ed15978425b3f7ab18256a2a2860918dd5060f623cb8d244a87a`. Hashing the first
2,161 physical lines of the committed replay produced the same value; a redundant tracked prefix
was therefore not added.

The exact command was:

```bash
python3 tools/libretro-profiling/validate_1p_control.py \
  build/vr60_control_bypass.32x \
  --reference-rom build/vr60_live_reference.32x \
  --savestate /home/matias/.picodrive/mds/vr60_control_bypass.mds \
  --input-script /tmp/vr60-007-prefix-anjn0C.csv \
  --warmup-frames 360 --frames 1800 \
  --output-dir /tmp/vr60-007-preflight-Snp1v2/artifacts \
  --diagnose-short-run
```

The validator exited 1 as required, and `result.json` contained only `short_control_window`.
Result SHA-256 was `8330e40e43168e782bbe1604f472dfebc622e441c13a9e35878ef19765c938d8`;
`run.json` SHA-256 was `d63455872b9f6a0e27ae3758f83e7637a330ced0a4eac03601b8cd0383e2f7ea`.
The validation range was `360..2159`: ten complete 180-frame windows, full scene pointer
`$00884CBC` throughout, 450 visits to each expected state in correct order, maximum state stall
1, 450 exact hook hits with maximum gap 4, 1,039 unique framebuffer hashes with maximum stall 1,
COMM0/COMM2/COMM7 maximum non-zero runs 3/2/0, Master useful work on all 1,800 frames, and Slave
useful work on 1,350 frames (135 in every window). The caller footer reported 2,160 frames, 539
hits logged, and zero drops. These are bounded liveness results only; VR60-008 subsequently tested
the same artifacts over all 18,000 validation frames without changing code, policy, thresholds, or
input and failed as documented below.

### Full-control failure and VR60-009 classification (2026-07-22)

The continuous VR60-008 route remains blocked by VR60-010; VR60-011 later cleared the baseline
with its accepted lifecycle suite. VR60-008 ran the exact artifacts above with no code, policy, threshold, input,
diagnostic, or offline-analysis override:

```bash
python3 tools/libretro-profiling/validate_1p_control.py \
  build/vr60_control_bypass.32x \
  --reference-rom build/vr60_live_reference.32x \
  --savestate /home/matias/.picodrive/mds/vr60_control_bypass.mds \
  --input-script tools/libretro-profiling/fixtures/vr60_006_control_replay.csv \
  --warmup-frames 360 \
  --frames 18000 \
  --output-dir /tmp/vr60-008-full-control-zVO1uD/artifacts
```

The frontend completed all 18,360 frames and the caller trace footer reported 1,282 hits logged
with zero drops, but the validator exited 1 with `passed: false` and 300 findings. The complete
output is preserved in the tracked
[VR60-008 evidence archive](analysis/evidence/vr60-008-full-control/README.md), whose deterministic
`artifacts.tar.gz` SHA-256 is
`8bd15a1836686d9fcd9e027e2991bcc14ee794a1337fc6ff3f375ba5c9ef00b3`. Within it, `run.json`
SHA-256 is `361104d02e876e2dff7c69aeb980f06e196d0c63b6e9097dc22e8c82e5794cca` and `result.json`
SHA-256 is `bcdaf92a44749a3ade515d7c4ae052ecbb89a96226ecbeaaa3e89563ef02d991`.

VR60-009 corrected the chronological interpretation. The validator's state value is sampled only
after each frame. The exact trace records PC `$884CF2` writing `$C87E` `$0000 -> $0004` and PC
`$884D0C` writing `$0004 -> $0008` during frame 4536, so no handler was skipped. The fixture is a
timed 1P race: `$C050` expires, `conditional_scroll_state_init` selects display state `$14`, and
the display sequence advances through `$18/$1C/$20/$24/$28/$2C/$30`. Lap-completion flags remain
clear. At frame 5128, state 12 PC `$8843D0` deliberately writes `$FF0002` `$00884CBC ->
$0088FB98`. COMM, hook, framebuffer, and Slave-SH2 findings after that point are out-of-scene
observations, not skipped-state fallout. Full evidence is in
[the VR60-009 archive](analysis/evidence/vr60-009-write-trace/README.md).

### VR60-010 visual replay bridge and bounded replacement preflight (updated 2026-07-25)

VR60-010 is in progress and the validator remains unchanged. The installed RetroArch 1.22.2
build can record visual controller input from an entry savestate, but its v2 replay is not itself
an acceptance artifact. The reviewed host-only
`tools/libretro-profiling/retroarch_replay_to_csv.py` bridge is pinned to RetroArch commit
`4c3793f36c`. It requires the v2 magic/version and requested frame count, parses the complete
stream to exact EOF, accepts only one P1 joypad-mask event followed by a neutral P2 mask per
regular frame, and rejects checkpoints, keyboard events, malformed back-references, unexpected
devices/IDs/padding, a replay/control-ROM CRC32 mismatch, and existing output paths. It requires
the exact control ROM and raw state, then publishes canonical `frame,mask` CSV plus a manifest
binding their hashes to the replay, reviewed source identity, and output. It changes no ROM,
core, validator, policy, or threshold.

A real 899-frame capture, replay SHA-256
`665d710f5cf47a97e3a8bf130919d4ed20d3c3bf6f35b2e55118a6cdad0f1724`, converted to 899
ordered rows with CSV SHA-256
`6c51ad27ee7ee137e61d848161d63f631910cc5d56d025325dd44f88a4e8cf08`.
The canonical `profiling_frontend` loaded the matching raw state, replayed those rows, and
re-recorded byte-identical CSV. This qualifies the bridge only.

The candidate-state inventory did not produce a durable replacement. The two Jul-13 normal-1P
states with raw hashes `67f715cd…9bb` and `7047ebe4…11dc` leave `$00884CBC` at frames 4877 and
5025 under their qualifying held input; the third candidate starts in `$00884A3E`. A new visual
state was then saved in the correct scene but its thumbnail and memory established that it was
already 32 seconds into Big Forest with `$C050 = $0035`. Its first complete visual preflight had
4,680 frames: replay SHA-256 `6e519f48…a8be`, converted CSV SHA-256 `bca70d72…84d0`.
The unchanged validator correctly failed and first observed the scene exit at frame 3984. That
state and input remain temporary rejected diagnostics. A later setup window produced no state.

A new slot-0 capture produced a valid 3,526-frame RetroArch v2 replay (SHA-256
`32246bf733195a7deb0a83381dea40525730d3d240335488d2e4f9577ca91bc0`) and 3,526-row
canonical CSV (SHA-256
`393b6f85ec74688ba31a06e91cad1735c2eda5db169731a003a0932679f23481`). Its content
CRC32 matched the exact hook-bypass ROM. RetroArch's standalone state was a `RASTATE` container;
the exact `MEM ` payload, SHA-256
`c74277f2e3b635ed0e542d8ea9ca752b83df80516ef30b8d77289d4ad1a06993`, loaded through
the canonical frontend.

The source replay stayed in `$00884CBC` for its tested 3,526 frames, but COMM0_HI remained
non-zero through sampled frame 896. A first derived-state attempt used the DRC and was rejected:
when the unchanged validator forced the interpreter for exact PC tracing, that state followed a
different `$C87E`/COMM trajectory and failed. The interpreter-matched bounded-candidate
derivation therefore replayed the same input with `VRD_PROFILE_PC=1`, selected the first
post-interval sample at frame 897, advanced exactly `K = 898` frames, and read back
`$FF0002 = $00884CBC`, `$C87E = $000C`, and `$C050 = $003D` immediately before saving.
The raw derived state has SHA-256
`c6640c78630db838aa878ab1f4e5ddf580c7f335bffdb2bde24413b628fd5216`.
The following 2,160 masks were reindexed to `0..2159`, SHA-256
`d0d2d4821f4e3ef5b1b548402f486e0fe098213d3153fd4b13aa8cd6091856ad`, and replayed
from that state into a byte-identical recording.

The unchanged 360-frame-warmup + 1,800-frame validator then failed only with
`short_control_window`, as required. The ten validation windows recorded state stall 1; 450 exact
hook hits with maximum gap 4; 456 framebuffer hashes with maximum stall 1; COMM0/COMM2/COMM7
maximum non-zero runs 3/2/0; and useful work on both SH2s. `run.json` SHA-256 is
`e2f59cd2254320be9f09a1ef2f4d989009bd076c609667c3ed2040fa6fb829a8`; `result.json`
SHA-256 is `4386fea24cea3cab23a42d4247e7b10b5ba0dd1ed24207b82e59a70d9771919d`.

This is a successful bounded preflight, not a control PASS. The next step is a full
18,360-frame visual capture from the exact interpreter-derived state, followed by strict
conversion, byte-replay, and the unchanged full validator. The driving input must keep the timed
race in `$00884CBC` for all 100 validation windows. No temporary artifact is promoted until that
PASS. Any `RASTATE` wrapper used for the visual capture must extract to a `MEM ` payload
byte-identical to the derived raw state
`c6640c78630db838aa878ab1f4e5ddf580c7f335bffdb2bde24413b628fd5216`.

### Near-term issue queue

The baseline blocker is split into small issues. Each issue has one output and one closing
test; do not combine it with the next issue just because both are convenient in one worktree.

| Issue | Scope | Close only when | Status |
|---|---|---|---|
| VR60-001 | Build the fail-closed validator, deterministic input replay, and tracked full-window profiler trace | Focused tests pass, the known-bad state fails diagnostically, and the active-hook ROM cannot produce a control PASS | **Done** |
| VR60-002 | Restore a minimum debugger on the real libretro/PicoDrive execution path | The current ROM advances 120 frames; both SH2 register sets and 68K/SH2 memory are readable; a matching state saves and reloads from a tracked command script | **Done** |
| VR60-003 | Add debugger joypad control and exact input recording | A scripted 600-frame session records one `frame,mask` row per frame, and replaying it produces the same input sequence with no sparse/default frames | **Done** |
| VR60-004 | Produce one assembly-built control ROM from a preserved live branch ROM, changing only the eight-byte 1P hook site | The validator proves the candidate/reference pair is identical outside file offset `$4D62-$4D69` and records both hashes | **Done** |
| VR60-005 | Capture one fresh normal-1P GP savestate | A short diagnostic loads it at `$FF0002 = $00884CBC`; its SHA-256 is recorded and it is not the blocked fixture | **Done** |
| VR60-006 | Capture one complete 18,360-frame controller replay for that state (360 warmup + 18,000 validation) | The `frame,mask` CSV covers frames `0..18359` exactly once, passes parser validation, and its SHA-256 is recorded | **Done** |
| VR60-007 | Run a 360-frame-warmup + 1,800-frame preflight using VR60-004/005 and the exact first 2,160-row prefix of VR60-006 | Scene, state order, hook cadence, framebuffer, SH2 work, and COMM lanes are healthy; the run still exits non-zero because short diagnostics can never qualify as a control | **Done** |
| VR60-008 | Run the full control without changing code or thresholds | The exact same ROM/state and complete replay pass all 360 warmup + 18,000 validation frames and 100 fixed validation windows | **Historical continuous route blocked by VR60-010; baseline cleared by VR60-011** |
| VR60-009 | Add complete emulator-side memory-write tracing for both `$C87E` and `$FF0002`, then run the deterministic replay only through the historical frame-4536 and frame-5128 boundaries | The non-perturbing trace identifies both ordinary frame-4536 state writes and the intentional frame-5128 results-scene writer; the timed-finish relationship and fixture remedy are preserved in a deterministic evidence archive | **Done** |
| VR60-010 | Replace the timed-race fixture and rerun the unchanged full control | A new normal-1P state plus deterministic 18,360-frame input stay in `$FF0002 = $00884CBC` throughout, exercise the expected state/hook/render/COMM/SH2 liveness, and pass the existing validator without policy, threshold, or diagnostic overrides | **Paused optional stronger shape — interpreter-matched bounded preflight qualified** |
| VR60-011 | Add a separate lifecycle-aware aggregate control without changing VR60-010 | Fresh complete lifecycle captures use exact immutable provenance and the reviewed timeout/results signature; at least 3 distinct lifecycles, 1,800 active frames each, one 3,960-frame contiguous span, and 18,000 aggregate active frames pass every per-window/tail check | **Done — 3/3 DRC lifecycles PASS; 31,137 aggregate active frames; evidence archived** |

VR60-009 and VR60-011 are closed. VR60-010 remains an optional continuous alternative that
replaces only the fixture/input and reruns the unchanged validator; do not combine it with
profiler policy, threshold, or game-code changes. VR60-011 is an
independent alternative acceptance policy: it cannot reinterpret VR60-010 artifacts, count
post-terminal frames, average a bad lifecycle into good runs, or trust per-fixture summaries.
Its active boundary and results transition must be predeclared from a prior diagnostic replay.
The accepted Big Forest, Bay Bridge, and Acropolis fixtures now satisfy that complete
provenance/signature under DRC with 10,906/9,263/10,968 active frames. Their 31,137-frame
aggregate and deterministic replay evidence are archived under
`analysis/evidence/vr60-011-lifecycle-suite/`.
The cmd `$3E` mode-0 sub-gate and isolated mode-1 validation stage are complete. The next issue
is independent mode-2 AI-transfer validation, followed separately by the cmd `$3F` mailbox
correction, cmd `$3F` shadow execution,
and each renderer/authority transition become separate issues with their own sentinel and
control comparison.

### Q-020 mode-1 gate update (2026-07-27)

The validation-only ACTIVE/STAGE-CONTROL pair is source-built and statically isolated. `make
mode1-roms` and 40 focused ROM-pair/MMIO/reset/Gate-A tests pass. The active, control, and
unchanged ordinary-default SHA-256 values are `f0cdb1a7…e4c3c`, `2a958af7…da10`, and
`6f2768f2…2523900`.

This is not a runtime or safety pass. A fresh Auditor returned **BLOCKED** because the 68000
polls `COMM1_LO` while the Master SH2 reads, modifies, writes, and flushes the same byte. The
hardware rule at `docs/32x-hardware-manual.md:713-717` makes read-during-write undefined; a
same-address SH2 readback drains the write buffer but does not exclude the concurrent 68000
read or atomically protect system bit 0 from V-INT. COMM2, COMM7, SDRAM range, cache-through
MMIO, DMAC configuration, alignment, and literal-pool isolation passed the static review.

Runtime evidence is still absent: `mode1_rom_pair.json` remains non-promotable with
`runtime_evidence: "MISSING"`, and `mode1_reset_fixtures.json` has no captures for either
normal entry or name-entry re-entry. The reset manifest's current status value is also missing
from the JSON schema enum, so schema validation would reject the checked-in placeholder even
though the custom tests pass. No tracked producer currently emits the required five-event
reset trace.

The manuals establish CPU-write DREQ activation (`68S=1`), a four-word FIFO, and `FULL`
backpressure checked every four words. They do not explicitly state that data written before
SH2 DMAC channel 0 is armed will be retained. The original game arms DMAC and then publishes a
COMM1 ACK, so it cannot serve as proof of an ACK-free pre-arm ordering. Do not implement that
ordering by inference; obtain an authoritative answer or introduce a separately reviewed
hardware/emulator experiment first.

### Q-020 CMDINT feasibility update (2026-08-10)

The immediate interrupt-handshake experiment is **APPROVED strictly as a diagnostic feasibility
probe**. It is isolated behind `VR60_Q020_CMDINT_PROBE`, mutually exclusive with mode-1 builds,
and leaves the promoted default byte-identical at `6f2768f2…2523900`. The probe ROM is
`8766714e…6a91e7`; mode 1, mode 2, cmd `$3F`, and SH2 gameplay authority remain disabled.

The hash-pinned runtime evidence proves cold initialization, the normal route writer at
`$0088E0D4`, one Master level-8 CMD interrupt, VRES and the stock reset-flow CMD, dual-SH2
liveness, and the name-entry writer at `$00891822`. The common ISR toggles FRT TOCR bit 1,
accepts only CMD/VRES, masks only CMD, performs same-address clear/readback, restores and reads
back the exact pre-mask word, and fail-stops unexpected external levels. Literal-pool ownership,
the `$02303C50` startup shim, allowed ROM deltas, canonical/probe tool hashes, and an exact
15-artifact archive are fail-closed. Twenty focused tests pass. Evidence:
`analysis/evidence/vr60-q020-cmdint-probe/`.

Limits are part of the result. The name-entry fixture is deliberately seeded and is not organic
gameplay; runtime proof is PicoDrive-only and uses a separate core with a pinned IRQ fast-path
parity patch. PicoDrive's one reset-boundary Slave warning is accepted only because the exact
line and subsequent dual-SH2 liveness reproduce under the accepted default/canonical core. The
probe also checks that the CMD-clear register reads back as zero, which is stricter than the
manual's documented synchronization requirement and must not be copied into a real-hardware
design without confirming read semantics.

Next, build a fresh isolated mode-1 ACTIVE/STAGE-CONTROL pair around this interrupt handshake.
Promotion remains blocked until canonical Gate-B ordering proves exact 64-byte
`$FF6B00 -> $0600F30C` transport, eight FULL-checked four-word groups, DMAC0 TE
read-1/write-0/re-arm, two fresh captures per route per arm, deterministic lifecycle
equivalence, and the unchanged accepted mode-0 hash. Do not advance to mode 2 or cmd `$3F`.

### Q-020 mode-1 validation-stage acceptance (2026-08-11)

The fresh isolated CMDINT ACTIVE/STAGE-CONTROL pair is **APPROVED strictly as a PicoDrive
validation-stage result**. ACTIVE is `96365860…ff4470`, STAGE-CONTROL is
`39177456…34e9fd`, and the 1052-byte Master ISR is `6316a0d2…146916`. The accepted ordinary
default remains byte-identical at `6f2768f2…2523900`; mode 1 is not promoted there, and mode 2,
cmd `$3F`, and SH2 gameplay authority remain disabled.

The producer uses two Master CMD interrupt edges and zero COMM0-COMM7 accesses. Both ACTIVE
normal repeats contain six identical transactions with canonical Gate-B order, exact 64-byte
`$FF6B00 -> $0600F30C` payloads, eight FULL checks before eight four-word FIFO groups, exact
DMAC0 arm/DMAOR synchronization, terminal TE read-1/write-0 acknowledgement, repeated re-arm,
CMD same-address clear/read, and exact mask restoration. Both controls contain zero transport.
The setup ISR accepts only exact stock idle/quiescent SPCs; completion instead requires the
unique in-flight count and full DREQ/DMAC identity before omitting an SPC restriction.

All eight required route captures pass. Normal entry installs `$00884CBC`, executes its
composed caller, and reaches the mode-1 producer. Source research corrected the name-route
expectation: the authentic `$00891822` writer sets `C80E.bit3`, so stock `$00884C98` installs
replay `$00885618`; the explicitly seeded, non-organic fixture therefore proves `1 -> 0`, replay
liveness, and zero racing-hook transport in both arms. Clearing the stock bit or inventing a
second transport call was rejected.

VRES passes only at the deterministic frame-1241 stock-safe boundary, including stock reset-CMD
delegation and init count `1 -> 3`. At frame 1280, when the Slave is in its on-chip renderer, the
same PicoDrive sysreg failure occurs in ACTIVE, CONTROL, and the accepted default. That exact
triad is hash-pinned separately as non-acceptance evidence and is never whitelisted; arbitrary
or busy-Slave VRES remains unproven.

The static pair, 47-artifact raw capture, archived validator result, lifecycle manifest, and
busy-reset diagnostic are hash-bound by `composition.json`; `make mode1-gate-validate` rebuilds
and validates the complete chain. A fresh Auditor reproduced clean builds, runtime tool hashes,
both validators, JSON Schema validation, 36 adversarial tests twice, and a clean diff with no
ignored evidence. This closes the requested mode-1 validation stage without making a promotion,
organic-name, arbitrary-reset, authority-transfer, cadence, FPS, real-hardware, or CPU-budget
claim. The next independent stage is cmd `$3E` AI transfer mode 2; do not combine it with
cmd `$3F`.

The dated sections below are a **historical correction log**. They deliberately preserve false
starts, but no older “COMPLETE,” “ACTIVE,” FPS, utilization, or causality claim overrides this
canonical status.

---

## ⚠ CRITICAL CORRECTION (2026-07-06) — read before trusting any Phase 3–5 status below

**The entire cmd `$3F` VR60 pipeline (Phases 3–8: physics, AI, collision, the render bridge)
was wired into `state_disp_005020` — the 2-PLAYER split-screen race dispatcher — not the
normal 1-player interactive dispatcher (`state_disp_004cb8`) used by manual GP play and
saved-state 1P profiling. Autoplay instead parks in scene `$5586`. cmd `$3F` has never fired
during any 1P racing session measured on this
branch.** Full evidence: `analysis/VR60_IMPLEMENTATION_AUDIT.md` +
`analysis/VR60_DISPATCHER_ROUTING.md`. Discovered via three render-bridge validation probes
(5F-1b) that produced zero visible effect, tracked down with headless watches of COMM0, the
SDRAM entity, an execution sentinel, the `$C8D2` staging gate, and the live `$FF0002` scene
handler.

- **Mis-targeted from the start** (commit `b5bd8a3`, 2026-06-17), not a regression — and
  self-contradictory with Q-009/R-008 (already correctly identified `gfx_2_player_entity_
  frame_orch`, which `state_disp_005020` calls, as 2P-only and deferred).
- **Player physics is NOT currently bypassed** — the current 1P hook leaves the bypass off,
  so the unmodified 68000 physics chain remains authoritative.
- **Open, unresolved:** whether the Phase 3/4/5 "measured improvement" profiling deltas
  recorded below were ever real in 1P, given cmd `$3F` + the bypass trampolines are no-ops
  there. Not yet re-investigated — treat every "ACTIVE"/"done" status below as **unvalidated
  in 1-player racing** until re-checked.
- No universal fix exists — 1P, Free Run, and GP/split each need their own hook into their own
  dispatcher's heavy-frame handler; 2P is the only one already wired (and unvalidated itself —
  no 2P profiling run exists).

---

## ⚠ HISTORICAL STATUS UPDATE (2026-07-13) — later superseded in this log

An approved plan (`/home/matias/.claude/plans/eventual-greeting-wadler.md`) began wiring 1P
racing (`game_frame_orch_013.asm`, via `state_disp_004cb8`'s state 8) with staging + DREQ
transfer + a cmd `$3F` trigger, mirroring the 2P `state4_epilogue` pattern. **All of that wiring
was fully reverted at that point** — `vr60_1p_staging_hook.asm` briefly became an inert
passthrough. Modes 0/1 were later reintroduced with bounded, 1P-exclusive helpers; see the
later correction and canonical status above. See Q-017, R-020, R-021, and
`analysis/VR60_PHASE1_CMD3E_ACK_HANG.md` §13 for the full
story: a retry-based fix for a suspected cmd `$3E` ACK race was headlessly "verified" but the
verification never exercised real GP racing (`--autoplay` can't reach it — it parks in Free Run
instead), and when tested against real GP racing it hard-hung the 68K (black screen). The two
independently hardware-manual-justified SH2 bugfixes in `cmd3e_entity_transfer.asm` (DMAOR write
width, CHCR0 address-mode fields) were kept since they don't depend on the reverted retry logic.
Before resuming: get a real GP-racing savestate (`VRD_LOAD_STATE` now supports this), and bound
any retry logic with a hard attempt cap.

## ⚠ RETRACTED INTERIM CONCLUSION (2026-07-13) — the hook was incorrectly called dead code

Following up on the above with real GP-racing savestates (finally obtained — see R-021), extensive
`VRD_PROFILE_PC=1` histogram testing across four independent savestates/conditions (mid-race,
near-countdown-end, from-loading with and without held input) and up to 28.5 million sampled 68K
instructions found **zero execution** of `game_frame_orch_013`'s "Path A" (state 8) — the exact
function the entire Phase 1 plan hooks into. State `$C87E` apparently transits 0→4→8→12 at most
**once**, very early (likely during scene init, before `state_disp_004cb8` even becomes the active
scene handler — `race_scene_data_loader.asm` sets `$FF0002` to yet a third handler,
`$00894262`, as part of loading), then sticks at Path B (state `$0C`) for the entire rest of the
race. Path B is itself lightweight (sound/controller/frame-counter/AI-buffer only) and is **not**
the real per-frame game-logic driver either.

**The actual per-frame entity/physics/AI driver was traced (partially) to
`race_frame_main_dispatch_entity_updates`** (`disasm/modules/68k/game/race/
race_frame_main_dispatch_entity_updates.asm`, ROM `$006D9C-$006F98`) via `race_entity_update_loop`,
which shows heavy, confirmed execution (thousands of PC samples) in every real-racing histogram
this session. Its exact recurring per-frame trigger is not yet fully pinned down — its only found
static caller (`race_scene_data_loader.asm:45`) is itself inside a one-time loading sequence, not
an obviously-recurring call site. **This needs its own dedicated tracing session.**

**Bottom line: the entire original Phase 1 plan's insertion point (`game_frame_orch_013`'s state-8
"Path A") must be abandoned — it is provably unreachable during real gameplay, in every tested
scenario.** Any future 1P SH2-offload attempt needs a hook into `race_frame_main_dispatch_entity_
updates` (or whichever of its internal entry points turns out to be the real per-frame call site)
instead. Full writeup: `analysis/VR60_PHASE1_CMD3E_ACK_HANG.md` §15.

## ⚠ FULL CORRECTION AND RESOLUTION (2026-07-13, later same session) — Path A is fine, dead-code claim retracted

The "Path A is dead code" conclusion directly above was a **false negative**, fully investigated
and resolved in the same session. A new `VRD_CALLER_TRACE` capability (exact JSR-return-address
counter, not a truncated histogram) proved `game_frame_orch_013` (`$884D1A`, "Path A", state 8) is
hit repeatedly and reliably — **exactly once every 3 frames (20 Hz at a 60 Hz display)**, precisely
matching CLAUDE.md's documented "1 state per V-INT, 20 FPS game logic" model. The earlier "zero
PC-histogram hits" claim was purely an artifact of the histogram being top-200/cycle-sorted (this
address executes cheaply enough per-hit to fall outside that cutoff). The mechanism is simple and
was never actually mysterious: `state_disp_004cb8` (the constant, unchanging scene handler at
`$FF0002`) dispatches to its states via `JMP` (not `JSR`), so `$C87E` genuinely cycles
0→4→8→12→reset→0→... every ~3 frames as designed, exactly as the original VR60 Phase 1 plan
assumed. **No architectural problem was ever real here** — only a histogram-truncation false
negative and an overcomplicated intermediate hypothesis, both now fully resolved. Full writeup:
`analysis/VR60_PHASE1_CMD3E_ACK_HANG.md` §17-§20.

**Practical conclusion: `game_frame_orch_013`'s Path A (state 8) is a valid, reliable, ~20 Hz hook
location — the original Phase 1 plan's insertion point stands.** This was subsequently implemented
with bounded, 1P-exclusive helpers. The promoted current build reaches only the accepted cmd
`$3E` mode-0 path; mode 1, AI transfer mode 2, and the cmd `$3F` trigger are disabled. The
insertion point and exact mode-0 transport are proven only within the Q-020 evidence scope.
**Standing rule for all future sessions**: do not trust "dead code"/"never executes" claims from a
`VRD_PROFILE_PC` histogram alone — always cross-check with `VRD_CALLER_TRACE` (exact, non-
truncated) before concluding a code path doesn't run.

## ⚠ IMPLEMENTATION STATUS (2026-07-16, corrected 2026-07-21) — bounded integration retained; behavioral validation RETRACTED

`vr60_1p_staging_hook.asm` was populated with four new 1P-exclusive files
(`vr60_1p_entity_transfer.asm`, `vr60_1p_ai_entity_transfer.asm`, `vr60_1p_globals_transfer.asm`,
`vr60_1p_comm_trigger.asm`), each with a bounded (max 16 attempt) retry, never touching the shared
`vr60_*_transfer.asm`/`vr60_comm_trigger.asm` files. AI entity transfer (cmd `$3E` mode 2) and the
cmd `$3F` trigger are disabled (commented out with inline notes); entity+globals transfer (cmd
`$3E` modes 0/1) was active in that legacy configuration. The promoted build now makes only
mode 0 reachable; mode 1 must be reintroduced behind its own gate. A follow-up session found
the `fb_crc`-based verification this status banner
originally reported (724 unique hashes, "matches baseline") **does not reproduce**, and traced
the freeze it was comparing against to a savestate-loading artifact, not any VR60 code: with the
entire 1P hook physically removed (bypassed via the original two JSRs it replaces), the exact
same `fb_crc` freeze still reproduces against `savestate_1p_gp_racing.bin`. The game's own state
dispatcher (`$C87E`) cycles cleanly for almost exactly one lap after the savestate loads, then
permanently stops advancing — independent of any VR60 code being reachable at all. Full writeup:
`analysis/VR60_PHASE1_CMD3E_ACK_HANG.md` §22 (retracts §21's isolation conclusions about AI
transfer/cmd `$3F` specifically, though the *code* §21 shipped — bounded retries, both disabled —
has bounded failure behavior and remains the least invasive integration state; its long-run
behavioral correctness has not been established).

**Practical upshot**: AI transfer (cmd `$3E` mode 2) and cmd `$3F` are neither proven safe nor
proven unsafe — §21's "both cause a freeze" conclusion doesn't hold up, because the reference
baseline it was compared against was never real for this test harness. They stay disabled, not
because of new evidence against them, but because nothing can currently be verified against this
savestate. **Before any further headless testing of this hook**, get a savestate that survives a
full `VRD_LOAD_STATE` run with `$C87E` cycling cleanly throughout — check that first, before
trusting any `fb_crc` uniqueness number from `savestate_1p_gp_racing.bin` again.

**Tooling note**: `VRD_WATCH` routes any address `>= 0x400000` through the SH2 memory bus, not
the 68K bus — 68K-side COMM addresses (`$A15120` etc.) get silently misrouted and return garbage.
Use the SH2-space cache-through COMM addresses instead (`$20004020`=COMM0_HI, etc. — see
`analysis/VR60_PHASE1_CMD3E_ACK_HANG.md` §22 for the full COMM offset table).

---

## Table of Contents

1. [Current State Baseline](#1-current-state-baseline)
2. [Target Architecture](#2-target-architecture)
3. [Hard Hardware Constraints](#3-hard-hardware-constraints)
4. [Phase 0: Infrastructure](#4-phase-0-infrastructure)
5. [Phase 1: SDRAM Path Validation](#5-phase-1-sdram-path-validation)
6. [Phase 2: Async Producer-Consumer Pipeline](#6-phase-2-async-producer-consumer-pipeline)
7. [Phase 3: Physics Port](#7-phase-3-physics-port)
8. [Phase 4: AI Port](#8-phase-4-ai-port)
9. [Phase 5: Collision Port](#9-phase-5-collision-port)
10. [Phase 6: Pipeline Overlap](#10-phase-6-pipeline-overlap)
11. [Phase 7: 60 FPS Game Logic](#11-phase-7-60-fps-game-logic)
12. [Open Questions & Unknowns](#12-open-questions--unknowns)
13. [Decision Log](#13-decision-log)
14. [Risk Registry](#14-risk-registry)
15. [Measurement Protocol](#15-measurement-protocol)
16. [Lessons Learned](#16-lessons-learned)

---

## 1. Current State Baseline

### 1.1 Historical CPU Utilization (Profiled March 2026, camera-interpolation experiment)

> **Historical only.** This predates the dispatcher-routing correction and is not the current
> 1P acceptance baseline.

| CPU | Clock | Budget/Frame | Used/Frame | Utilization | Role |
|-----|-------|-------------|-----------|-------------|------|
| 68K | 7.67 MHz | 127,833 | 127,987 | **100.1%** | ALL game logic + I/O + sound |
| Master SH2 | 23.01 MHz | 383,333 | 127,061 | **33%** | Command router + block copies |
| Slave SH2 | 23.01 MHz | 383,333 | 299,926 | **78%** | ALL 3D rendering |

**Evidence:** `analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md`, `analysis/profiling/68K_BOTTLENECK_ANALYSIS.md`

### 1.1b Historical Racing-Isolated Profile (2026-06-17, scene `0x4CBC`)

Measured with the rebuilt VRD profiler (Tier 1+2: exact idle/useful split, SH2 PC
capture fixed via DRC-off, 3D + scene gating). It superseded §1.1 at the time, but **does not
serve as the current integration baseline**: cmd `$3F` was not active in this 1P route, so the
recorded Master-SH2 work cannot be attributed to the VR60 physics/AI pipeline as the old notes do.
Tooling + recipes: [tools/libretro-profiling/VRD_PROFILING.md](tools/libretro-profiling/VRD_PROFILING.md).

| CPU | Useful/Frame | % of budget | Notes |
|-----|-------------|-------------|-------|
| 68K | 45,481 (36.6% of frame) | — | **63% V-blank idle**; `sh2_send_cmd` sync-wait negligible in racing |
| Master SH2 | 158,977 (99.7% of executed) | ~41% | Historical total; old cmd `$3F` attribution is invalid |
| Slave SH2 | 231,056 (75.3% of executed) | ~60% | ~80% util — busiest CPU; **renders every TV frame** |

**Historical interpretation:** racing appeared **neither compute-bound nor sync-bound**. The 20 FPS cap is
the **state machine (one state per V-INT, 0→4→8 = 3 TV-frames per game-tick)** while the
68K idles 63%/frame and the Slave already renders every TV frame (states 0/8 produce
changing images; state 4 is a constant framebuffer; effective display ≈ 45 FPS). The
~13% `sh2_send_cmd` wait seen in **mixed-mode** profiling is a **car-select/attract
artifact**, NOT racing — always scene-isolate (`VRD_SCENE=0x4CBC`). Re-measure after the
validation gate in `VR60_STATUS.md` is satisfied.

### 1.2 Historical Mixed-Scene 68K Profile — Not a Racing Baseline

This March profile mixed menus/attract with gameplay. Its 14-call and 10.52% attribution is
retained as research history only; scene-isolated racing later disproved it as a current normal-1P
bottleneck. Re-profile after the fixture gate.

| Component | Cycles | % | Source |
|-----------|--------|---|--------|
| V-blank STOP spin | 66,243 | 51.89% | Idle wait — unavoidable frame barrier |
| COMM0_HI handshake wait | 13,437 | 10.52% | historical 14-call mixed-scene attribution |
| Physics integration | 2,438 | 1.91% | entity_force_integration |
| Angle normalize + visibility | 2,953 | 2.31% | Trig lookups |
| Collision avoidance | 1,712 | 1.34% | AI speed calc |
| All other game logic | ~41,204 | 32.03% | Entity mgmt, state, rendering prep, sound |

**Historical interpretation (retracted for racing):** the old run called 62% “wasted waiting.”
**Evidence:** mixed-scene `tools/libretro-profiling/` PC-level profile, March 2026

### 1.3 Slave SH2 Rendering Breakdown

| Function | Cycles | % of Slave | Status |
|----------|--------|-----------|--------|
| Rasterization (total) | 154,000 | 52% | Core bottleneck |
| coord_transform | 35,600 | 12% | S-6 inlined (was 17%) |
| frustum_cull_short | 35,600 | 12% | Optimization target |
| span_filler_short | 24,000 | 8% | Tight inner loop |
| matrix_multiply | 18,000 | 6% | MAC unit |
| Idle delay loop | 478M/719M | 66.5% | Architectural idle |

**Evidence:** `analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md`, PC profiling at $06000608

### 1.4 Historical 2P-Targeted Communication Profile

This profile describes `state4_epilogue` under `state_disp_005020`, the 2-player path. It is
not a current normal-1P measurement: normal 1P uses `state_disp_004cb8`, and its cmd `$3F`
trigger is disabled. The values remain useful as historical implementation evidence only.

**CORRECTED (Phase 2A, 2026-03-17):** Only 2 `sh2_send_cmd` calls per 2P-path race tick, not
14. `sh2_cmd_27` was not observed in that racing profile.

| Sync Point | Who Blocks | Duration | Fundamental? |
|-----------|-----------|----------|-------------|
| COMM0_HI (sh2_send_cmd ×2, state 4 only) | 68K on Master | ~4,000 + ~9,200 cyc | **Mostly fundamental** — 68K waits for SH2 copy execution, not handshake overhead |
| COMM1_LO bit 0 (frame done) | 68K V-INT on Master | 0-1000 cyc | **Fundamental** — frame sync |
| COMM0 (mars_dma_xfer_vdp_fill ×2) | 68K on Master | ~200 cyc each | DREQ trigger, fast |
| COMM0 (vr60_comm_trigger ×1) | 68K on Master | ~100 cyc | Phase 1B relay, fast |

**10.52% breakdown:** Call #1 waits ~4K cyc for Master to finish DREQ DMA processing. Call #2 waits ~9.2K cyc for geometry copy (288×48=13,824 bytes). Total ~13.4K cycles. This is SH2 EXECUTION TIME, not handshake overhead. Cannot be eliminated without pipeline overlap.

**Evidence:** `code_2200.asm:145-154` (only 2 calls), `code_e200.asm:306-329` (function), Phase 2A timing analysis

### 1.5 Current Normal-1P Data Flow

```
68K WRAM $FF9000 (entity tables, 25 entities × 256B)
  → [68K: physics, AI, collision @ 7.67 MHz]
  → 68K WRAM display/camera state
  → [68K: object_table_sprite_param_update]
  → 68K WRAM $FF6000 (2560B FIFO source)
  → [68K: mars_dma_xfer_vdp_fill via DREQ FIFO]
  → SH2 SDRAM descriptor families C128 / C178 / C254
  → [Slave: Pipeline 1 (SRAM) + Pipeline 2 (SDRAM)]
  → Frame Buffer $04000000

state 8: 1P hook → cmd $3E mode 0 transport (accepted ordinary default)
                    cmd $3E mode 1 disabled
                    cmd $3E mode 2 disabled
                    cmd $3F disabled
```

The 68000 remains authoritative for gameplay and render preparation. The staging copies are
experimental inputs with no active SH2 gameplay consumer; `render_state_patcher` is a no-op.
**Evidence:** `analysis/ENTITY_OBJECT_ARCHITECTURE.md` §7, `analysis/RENDERING_PIPELINE.md`

---

## 2. Target Architecture

### 2.1 New CPU Roles

| CPU | New Role | Target Util | Evidence for Feasibility |
|-----|---------|------------|--------------------------|
| **68K** | Thin coordinator: I/O, sound, VDP, scene state | <30% | Sound driver MUST stay on 68K (YM2612/PSG/Z80 are 68K peripherals). VDP is 68K-addressed. Controller ports are 68K-only. Everything else can move. |
| **Master SH2** | Game logic engine: physics, AI, collision, entity management, camera | 40-60% | 256K cycles/frame idle. 48K 68K cycles = ~16K SH2-equivalent (3× clock). All game logic uses integer arithmetic + ROM table lookups — fully portable to SH2. |
| **Slave SH2** | Rendering engine (unchanged role) | 50-78% | Already works. Fed data from SDRAM (same as now, but Master writes directly instead of FIFO). |

### 2.2 Key Design Changes

| Change | Current | Proposed | Why |
|--------|---------|----------|-----|
| Entity table location | 68K WRAM $FF9000 | SDRAM $0600F20C | SH2 can't access WRAM. SDRAM accessible by both SH2s. Original $06008000 BLOCKED by gradient strip B at $060086D4. |
| Data transfer to SH2 | DREQ FIFO + 14× COMM handshake | Master writes SDRAM directly | Eliminates 10.52% COMM bottleneck entirely |
| Game logic CPU | 68K @ 7.67 MHz | Master SH2 @ 23 MHz | 3× clock, plus MAC unit for multiply-heavy physics |
| Master→Slave signaling | Via 68K relay (COMM2) | Master writes SDRAM, then COMM2 trigger | One handshake instead of 14 |
| Frame sync | COMM1_LO bit 0 checked by 68K V-INT | Same (unchanged) | This is fundamental, keep it |

### 2.3 New Data Flow

```
68K: read controllers → write SDRAM mailbox → trigger Master (1 COMM write)
  ↓
Master SH2: read mailbox → physics → AI → collision → entity update
  → write display objects directly to SDRAM
  → trigger Slave render (1 COMM2 write)
  ↓
Slave SH2: read SDRAM → render → frame buffer
  → set COMM1_LO bit 0 ("done")
  ↓
68K V-INT: poll COMM1_LO → frame swap
```

**Zero COMM data transfer.** All bulk data flows through SDRAM.

---

## 3. Hard Hardware Constraints

Every constraint below is verified against hardware documentation. **These cannot be designed around — they are physics of the hardware.**

| # | Constraint | Source | Impact on Design |
|---|-----------|--------|-----------------|
| H-1 | COMM read-during-write = undefined | `analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md` | All COMM access must use handshakes on separate registers |
| H-2 | SH2 write buffer: COMM writes async | SH7604 manual §7.11.2 | Dummy-read after COMM writes to force visibility |
| H-3 | SDRAM shared bus, Master has priority | HW manual §5 | Slave stalls when Master accesses SDRAM simultaneously |
| H-4 | No cache coherency between SH2s | SH7604 design | Must use cache-through ($20xxxxxx) for shared data |
| H-5 | SH2 cannot access 68K WRAM | HW manual memory map | Entity tables MUST move to SDRAM or COMM |
| H-6 | FS bit writes deferred to VBlank | HW manual §4.2 | Frame swap timing unchanged — 68K V-INT handles it |
| H-7 | FM bit = immediate VDP preemption | HW manual §1.5 | Must not toggle FM during 68K VDP access |
| H-8 | Sound hardware (YM2612/PSG/Z80) 68K-only | Hardware address map | Sound driver cannot move to SH2 |
| H-9 | On-chip SRAM is CPU-private | SH7604 design | Pipeline 1 data written by Slave is invisible to Master |
| H-10 | COMM1_LO bit 0 = system "done" signal | Game architecture | Multiple consumers poll this — cannot repurpose |
| H-11 | COMM7 = Slave doorbell namespace | B-006 crash analysis | Game cmd bytes must never be written to COMM7 |
| H-12 | SDRAM access: 2-6 wait states per read | HW manual Table 5.7 | Entity field access slower than WRAM (0 wait). Budget accordingly. |
| H-13 | SH2 ROM access blocked when RV=1 | HW manual DREQ ctrl | VRD never sets RV=1, but avoid ROM→VRAM DMA |

**Evidence for each:** See cited documents + `KNOWN_ISSUES.md` (68+ pitfalls, 3 failed B-003 attempts proving H-5)

---

## 4. Phase 0: Infrastructure

**Status: STRUCTURALLY BUILT; MAILBOX ADDRESS FIX REQUIRED** (corrected 2026-07-21)

### 4.1 What Was Built

| Component | Location | Size | Purpose |
|-----------|----------|------|---------|
| cmd $3F handler | $301500 (expansion ROM) | 428 bytes | Built; current 1P trigger disabled |
| Jump table patch | ROM file `$02087C` → runtime SDRAM `$0600087C` | 4 bytes | Entry $3F → $02301500 |
| Intended SDRAM mailbox | $0600BC00 | 16 bytes | **Not usable yet:** handler literal is invalid ROM alias `$2200BC00`; fix to `$2600BC00` before enable |
| Makefile rules | Makefile lines 559-562, 2211-2225 | — | Full asm→bin→inc pipeline |

### 4.2 Verification

| Check | Method | Result |
|-------|--------|--------|
| Jump table entry | `python3` ROM byte check at $02087C | $02301500 ✓ |
| Handler prologue | ROM byte check at $301500 | $4F22 (STS.L PR,@-R15) ✓ |
| Mailbox backing bytes zeroed | ROM byte check at $02BC00 | Structural only; does not validate current `$2200BC00` runtime writes |
| Full ROM builds | `make clean && make all` | 4MB ROM, clean ✓ |

### 4.3 Design Decisions Made

| Decision | Rationale | Alternative Considered |
|----------|-----------|----------------------|
| Use cmd $3F (not $40) | 16 unused slots ($30-$3F) in existing 64-entry jump table. Zero dispatch loop changes. | Cmd $40 would require dispatch loop modification (range check + trampoline). Higher risk, no benefit. |
| Mailbox at $0600BC00 | Currently zero-filled ROM data region. No SH2 code references it. Part of boot IDL copy (auto-zeroed). | $0600F000 area also free, but farther from entity data. |
| Inline COMM cleanup | Matches cmd22/cmd25 pattern (proven, 2 active handlers use it). | JSR func_084 — adds call overhead, no benefit for new handler. |

### 4.4 What Was NOT Built (Deferred)

- [ ] Trustworthy live cmd `$3F` trigger/fixture (current 1P call disabled)
- [ ] Correct handler mailbox access to `$2600BC00`; the 68000 cannot write SDRAM directly
- [ ] Controller input relay to mailbox (not needed until Phase 2)

---

## 5. Phase 1: SDRAM Path Validation

**Status: PARTIALLY INTEGRATED IN 1P; RUNTIME ACCEPTANCE BLOCKED** (corrected 2026-07-21)
**Prerequisite:** Phase 0 structural pieces built; mailbox alias correction still blocks cmd `$3F`
**Baseline tag:** `vr60-phase0-baseline`

### 5.1 Goal (Revised)

Validate that the Master SH2 can read and write entity data at the new SDRAM location. Split into two sub-phases:
- **Phase 1A:** Master SH2 copies existing cmd $02 entity data to new SDRAM area (validates addressing)
- **Phase 1B:** 68K writes controller input to SDRAM mailbox (validates communication path)

The underlying handlers and bounded 1P-exclusive transfers are built. In the current 1P hook,
cmd `$3E` mode 0 is accepted and reachable; modes 1/2 are disabled. The original broad
acceptance claim is no longer valid because the saved-state fixture freezes independently of
the hook. Treat Q-020 mode 1 as the current gate, regardless of older completion text.

**Key insight (Phase 1 planning):** DREQ FIFO is unnecessary for entity tables. The Master SH2 will own them directly in SDRAM once game logic is ported (Phases 3-5). During migration, Master reads from the existing cmd $02 DMA landing area ($0600C000+).

### 5.2 SDRAM Memory Map (Corrected)

**BLOCKED: $06008000-$0600BFFF** — Gradient strip B at $060086D4-$06008743 (112 bytes) is read by span_filler every polygon. Overwriting = rendering corruption.

**SAFE: $0600F20C-$06017FFF** (36.3 KB free) — between render state flags ($0600F20B) and display list ($06018000). Verified: zero SH2 code references, rendering pipeline never writes here.

| Range | Size | Purpose |
|-------|------|---------|
| $0600F20C-$0600F80B | 1536B | Entity render data mirror (buffer A) |
| $0600F80C-$0600FBFF | 1012B | Reserved (buffer A expansion, Phases 3-5) |
| $0600FC00-$0600FC0F | 16B | Validation canary |
| $06010000-$06017FFF | 32KB | Reserved (buffer B, Phase 6 double-buffer) |

### 5.3 Resolved Unknowns

| Question | Answer | Evidence |
|----------|--------|----------|
| Q-001: Can DREQ FIFO target $06008000? | **Moot** — entity tables don't need FIFO. Master SH2 copies from existing cmd $02 area. FIFO destination is SH2 DMAC-controlled (DAR0 at $FFFFFF84), not 68K-controlled. | HW manual §DREQ, agent research 2026-03-17 |
| SDRAM conflict at $06008000? | **YES** — Gradient strip B at $060086D4. | Agent grep: span_filler reads $060086D4. Zero refs to $0600F20C+. |
| cmd $02 landing addresses? | $0600C000 (Huffman), $0600C800 (entity visibility, 32×16B) | `analysis/sh2-analysis/SH2_COMMAND_HANDLER_REFERENCE.md` |

### 5.4 Phase 1A Steps

| Step | Description | Files | Risk |
|------|-------------|-------|------|
| 1A-1 | Update this roadmap (SDRAM addresses, lessons) | VR60_ROADMAP.md | None |
| 1A-2 | Historical plan: memcpy from `$2600C800` → `$2600F20C` + canary | cmd3f_vr60_gameframe.asm | Low |
| 1A-3 | Rebuild: `make sh2-assembly && make all` | Makefile (update size) | Low |
| 1A-4 | Add 68K test trigger after mars_dma_xfer_vdp_fill | TBD racing module | Medium |
| 1A-5 | Autoplay 3600 frames + canary verify + profile | — | Low |

### 5.5 Phase 1B Steps

Q-010 resolved: 68K CANNOT write SDRAM directly ($88xxxx = ROM, read-only). Must use COMM relay.

| Step | Description | Risk |
|------|-------------|------|
| 1B-1 | 68K writes controller input + game state to COMM2-6 as part of cmd $3F trigger | Low (proven COMM pattern) |
| 1B-2 | Fix cmd `$3F` mailbox literal from invalid ROM alias `$2200BC00` to SDRAM cache-through `$2600BC00`, then copy COMM2-6 | Blocking before cmd `$3F` enable |
| 1B-3 | Verify controller input arrives at `$2600BC00` via diagnostic dump | Low |

**COMM2-6 layout for cmd $3F (10 usable bytes):**

| Register | 68K Address | Byte Offset from R8 | Content |
|----------|------------|---------------------|---------|
| COMM2_HI | $A15124 | +4 | **MUST STAY $00** (Slave polls this!) |
| COMM2_LO | $A15125 | +5 | controller_p1 buttons (byte) |
| COMM3 | $A15126 | +6,7 | controller_p1 d-pad + controller_p2 buttons (2 bytes) |
| COMM4 | $A15128 | +8,9 | game_state $C87E (word) |
| COMM5 | $A1512A | +10,11 | frame_counter $C964 (word) |
| COMM6 | $A1512C | +12,13 | race_substate $C8CC (word) |

**CRITICAL: COMM2_HI must remain $00.** Slave SH2 polls COMM2_HI as its work command selector. Any non-zero value triggers spurious Slave dispatch. The 68K must write COMM2_LO via byte write, never COMM2 via word write.

### 5.6 Acceptance Criteria

- [ ] Canary $DEADBEEF present at $0600FC00 after autoplay
- [ ] Entity data at $0600F20C matches $0600C800 source
- [ ] Game runs identically (no visual/behavioral changes)
- [ ] 3600-frame autoplay passes without crashes
- [ ] cmd $3F handler overhead <2000 SH2 cycles/frame
- [ ] Controller input visible in SDRAM mailbox (Phase 1B)

---

## 6. Phase 2: Async Producer-Consumer Pipeline

**Status: IMPLEMENTED IN THE HISTORICAL 2P-TARGETED PATH; NOT ACTIVE IN CURRENT 1P** (corrected 2026-07-21)
**Full architecture:** [analysis/ASYNC_PIPELINE_ARCHITECTURE.md](analysis/ASYNC_PIPELINE_ARCHITECTURE.md)
**Design decisions:** Producer-consumer pipeline + frame fence (lock-free) + display-objects-only transfer

### 6.0 Architecture Pivot (Phase 2A → 2B)

Phase 2A found that block copy consolidation saves ~0% — the 10.52% hotspot is SH2 copy execution time, not handshake overhead. Incremental porting within the synchronous model hits the same wall.

Phase 2B conducted 7 independent research investigations (R1-R7) covering frame buffers, COMM1 lifecycle, state data flow, all sh2_send_cmd call sites (45+), mode transitions (4 hazards found), memory region overlap, and dropped frame recovery. All findings consolidated in ASYNC_PIPELINE_ARCHITECTURE.md.

**The breakthrough:** The V-INT $54 handler already implements the exact synchronization gate we need — it stalls the state machine at state 8 until COMM1_LO bit 0 is set. This protects against COMM0 collisions, mode transition races, and dropped frames. We don't need new synchronization; we just need to trust the existing one and make block copies fire-and-forget.

### 6.0a Phase 2A Research Summary (Preserved)

### 6.1 Phase 2A Research Summary

Only **2** sh2_send_cmd calls per race frame (not 14). Both in state4_epilogue with constant params. sh2_cmd_27 = 0 during racing. camera_interpolation_60fps.asm is untracked (not in build).

**Timing analysis (why consolidation fails):**
- Current: 2 COMM round-trips. Call #1 blocks ~4K cyc (DREQ wait). Call #2 blocks ~9.2K cyc (copy #1 wait). Total: ~13.4K. The 68K interleaves param setup with copy execution.
- Consolidated: 1 COMM trigger + COMM1_LO poll for both copies. Total: ~17.9K. WORSE because both copies run sequentially in one handler, blocking 68K for full combined duration.

**The only way to eliminate this 10.52%** is pipeline overlap: fire-and-forget the copies and overlap them with game logic in state 8. This is Phase 6 territory, not Phase 2.

Entity projection port deferred to Phase 3+ (saves only 0.1%, requires entity data in SDRAM).

### 6.2 Source Function Analysis

| Property | Value | Source |
|----------|-------|--------|
| 68K function | `object_table_sprite_param_update` | `disasm/modules/68k/game/render/object_table_sprite_param_update.asm` |
| ROM address | $0036DE-$0037B4 | Module header |
| Size | 216 bytes (68K) | Module header |
| Estimated SH2 size | ~300 bytes | 68K→SH2 typically 30-40% larger |
| Side effects | None — pure data transform | No sound, no state mutation, no I/O |
| Inputs | Entity table (+$30, +$32, +$34, +$3A, +$3C, +$3E, +$6E, +$BC, +$C1, +$C4, +$E5) | `analysis/ENTITY_OBJECT_ARCHITECTURE.md` §7 |
| Outputs | Display objects ($FF6218, 60B stride × 15 entries) | `analysis/ENTITY_OBJECT_ARCHITECTURE.md` §7 |
| ROM tables | Sprite definitions at $008958E4 (SH2: $020958E4) | Module source |

### 6.3 What Needs to Happen

| Step | Description |
|------|-------------|
| 2a | Port `object_table_sprite_param_update` to SH2 assembly (expansion ROM) |
| 2b | Master SH2 cmd $3F handler calls the ported function after reading entity data from SDRAM |
| 2c | Historical 2P design: Master SH2 absorbs the two `state4_epilogue` block copies |
| 2d | Remove only the calls proven to belong to the validated target path; normal 1P must be re-profiled first |
| 2e | Byte-comparison gate: verify SH2 output matches 68K output for 100 frames |

### 6.4 Unknowns to Resolve

| Unknown | How to Resolve |
|---------|---------------|
| How does the block copy destination (frame buffer) get addressed from Master SH2? | Currently cmd $22 uses $04xxxxxx (cached frame buffer). Master can write to same addresses. Verify FM bit is set (SH2 has VDP access). |
| Can Master SH2 perform all 14 block copies in time? | Current Master budget: 256K cycles idle. Each copy: 3K-8K cycles. 14 copies: 42K-112K. Fits easily. Verify with profiling. |
| What's the stride ($0200) source? | Block copy uses $0200 stride (frame buffer row spacing). This is a constant, not derived from entity data. Hard-code in SH2 handler. |

### 6.5 Acceptance Criteria

- [ ] Display objects at SDRAM $0600B900 are byte-identical to what 68K produced
- [ ] Block copies complete successfully (frame buffer content unchanged)
- [ ] sh2_send_cmd no longer called during racing (verify via COMM0 profiling)
- [ ] 3600-frame autoplay passes
- [ ] 68K utilization drops by ~10% (from 100.1% to ~90%)
- [ ] No visual differences (A/B comparison screenshots)

### 6.6 Historical Phase 2B Design: Async Fire-and-Forget Block Copies

This section records the implementation built around the 2P `state4_epilogue`. It is not the
current normal-1P data flow and its autoplay-based live claims are not acceptance evidence.

**The concrete change:** Remove the two `sh2_send_cmd` calls and inline frame swap from `state4_epilogue`. Reorder: camera re-DMA BEFORE cmd $3F. cmd $3F becomes fire-and-forget (last COMM0 command in frame). cmd $3F handler does the block copies in background while 68K runs state 8 game logic.

**New state4_epilogue:**
```asm
; --- Camera interpolation and re-DMA (uses COMM0, must complete before cmd $3F) ---
        jsr     camera_avg_and_redma(pc)
; --- Fire-and-forget: async block copies via cmd $3F ---
        jsr     vr60_comm_trigger           ; COMM3=fence, trigger cmd $3F
; --- State advance (68K continues immediately) ---
        addq.w  #4,($FFFFC87E).w
        move.w  #$001C,$00FF0008
        rts
```

**cmd $3F handler (SH2 expansion, expanded):**
1. Read COMM3-5 (frame fence + game state + toggle)
2. Clear COMM0_LO (params consumed)
3. Geometry copy: $2200[3]8000 → $04012010, 288×48
4. Sprite copy: $2200[3]B600 → $0401B010, 288×24
5. Historical entity-copy plan: `$2600C800` → `$2600F20C` (not current acceptance evidence)
6. Write canary $DEADBEEF
7. Clear COMM1, set COMM1_LO bit 0 ("frame done")
8. Clear COMM0_HI (idle)

**Timing guarantee:** Block copies take ~0.9 ms. State 8 game logic takes ~1.4 ms. V-INT $54 fires after state 8. By then, cmd $3F has finished ~0.5 ms ago. COMM0_HI is clear. State 0's DREQ DMA is safe.

**Research findings that validate safety (R1-R7):**

| # | Finding | Impact |
|---|---------|--------|
| R1 | 68K ONLY controls FS bit (8 locations). SH2 never writes it. | Frame swap is purely 68K-side. Moving copies to SH2 doesn't affect swap timing. |
| R2 | COMM1_LO bit 0 = universal "done" signal. Same pattern across ALL modes. | cmd $3F uses identical signal — no mode-specific hazards. |
| R3 | State 0→4→8 strict pipeline. State 4 always advances. State 8 = sync gate. | V-INT $54 stalls at state 8 until copies done. Natural protection. |
| R4 | 45+ sh2_send_cmd call sites across all modes. | Async only targets racing state4_epilogue (2 calls). All other modes unchanged. |
| R5 | mars_dma_xfer_vdp_fill has no COMM0 idle check — but V-INT gate prevents collision. | State 0's DMA can't fire while cmd $3F runs (state stalls at 8). |
| R6 | No memory overlap between Master copies and Slave rendering. Time-separated. | Safe for concurrent execution. |
| R7 | Dropped frames: V-INT $54 skips swap, stalls state machine. Existing graceful degradation. | Unchanged by async — same COMM1_LO gate. |

**Resolved open questions:**

| # | Question | Resolution |
|---|----------|-----------|
| U-006 | Does removing inline frame swap break first race frame? | **No** — V-INT $54 handles ALL frame swaps. Inline swap was latency optimization, not requirement. |
| U-007 | Does camera_avg_and_redma depend on block copies? | **No** — reads WRAM ($FF6080/$FF6090), not framebuffer. No dependency. |
| U-008 | Data dependencies in reordered state4_epilogue? | **None** — camera avg reads WRAM, copies read SDRAM. Independent data sources. |

### 6.7 Historical Phase 2B Implementation Record

| Step | Description | Files | Status |
|------|-------------|-------|--------|
| 2B-1 | Modify state4_epilogue: remove sh2_send_cmd ×2 + inline frame swap. Reorder: camera before cmd $3F. | code_2200.asm | **DONE** — 102B→24B, 96B padding |
| 2B-2 | Expand cmd $3F handler: add geometry + sprite block copy loops (reuse cmd $22 algorithm) | cmd3f_vr60_gameframe.asm | **DONE** — 100B→172B (longword copy, stride $0200) |
| 2B-3 | Update Makefile expected size for expanded cmd $3F | Makefile | **N/A** — no size assertion exists |
| 2B-4 | Build: `make clean && make all` | — | **DONE** — clean build, 4.0M ROM |
| 2B-5 | Autoplay regression: 3600 frames | — | **HISTORICAL SMOKE ONLY** — autoplay did not exercise the 2P path and its `racing` label was frame-count based |
| 2B-6 | Profile: verify sh2_send_cmd drops from 10.52% to ~0% | — | **INVALID ATTRIBUTION** — mixed-scene/autoplay data did not validate this path |
| 2B-7 | Visual comparison: A/B screenshots at same frame count | — | **DEFERRED** — requires manual emulator comparison |

### 6.8 Historical Phase 2B Acceptance Record — Live Claims Reopened

- [x] state4_epilogue has zero sh2_send_cmd calls (verified: binary at $003738 has no $4EB9 $0000E35A)
- [x] cmd $3F handler performs both block copies + entity data copy + canary (172 bytes, 10 pool entries)
- [ ] V-INT $54 / cmd `$3F` interaction validated while the intended 2P path is actually active
- [ ] Long-run 2P regression passes with scene, state, COMM, and framebuffer liveness observed
- [ ] sh2_send_cmd hotspot drops from 10.52% to <1% in **racing-only** profiling (overall profile: 10.52%→10.29%, delta is menu-masked; racing-only profiler not available)
- [ ] Intended mode transitions validated on the 2P path
- [ ] Game-logic cadence measured from real state/caller counters, not autoplay timing labels

**Profiling note:** The binary proves the two calls were removed from `state4_epilogue`; it does
not prove a runtime improvement. The 10.52%→10.29% mixed-autoplay result is retained only as a
historical measurement and must not be projected onto normal 1P or unmeasured 2P racing.

---

## 7. Phase 3: Physics Port

**Status: PORT BUILT; CMD `$3F` AND 1P AUTHORITY SWITCH DISABLED** (corrected 2026-07-21)
**Prerequisite: Phase 2 (done)**

### 7.0 Implementation Status

**What's built (13 functions, ~2,440B SH2 code; historical addresses/statuses):**

| Component | ROM Address | Size | Status |
|-----------|------------|------|--------|
| cmd $3F (game frame + physics + sound relay) | $301500 | 428B | BUILT/JT-INSTALLED; 1P trigger disabled |
| cmd $3E (DREQ entity+globals, three modes) | $3016B0 | 176B | BUILT; 1P mode 0 accepted/reachable, modes 1/2 disabled |
| physics_divide (sdiv16 + reciprocal tables) | $301760 | 80B | BUILT; reached only through disabled cmd `$3F` in 1P |
| physics_group1 (f1+f5+f2+f3) | $3017C0 | 884B | BUILT; reached only through disabled cmd `$3F` in 1P |
| physics_group2_accel (f6+f7) | $301B40 | 496B | BUILT; reached only through disabled cmd `$3F` in 1P |
| physics_timers (5 timer/guard functions) | $301D40 | 284B | BUILT; reached only through disabled cmd `$3F` in 1P |
| physics_pos_update (16.16 fixed-point) | $301E60 | 184B | BUILT; reached only through disabled cmd `$3F` in 1P |

**Current 1P mode:** 68000-authoritative. The SH2-only description below records the intended
and historically 2P-targeted integration; the 1P cmd `$3F` call and physics bypass are disabled.

**Profiling (March 2026, Phase 3D complete):**

| Metric | Baseline | Phase 3D | Change |
|--------|----------|----------|--------|
| 68K STOP spin | 51.9% | 63.1% | +11.2% (more idle = less work) |
| 68K active time | 48.1% | 36.9% | -11.2% (physics offloaded) |
| Physics integration hotspot | 1.91% | 0.76% | -60% (only AI entities remain) |
| sine_cosine lookups | 2.31% | 0.36% | -84% (player entity on SH2) |
| sh2_send_cmd wait | 10.29% | 10.29% | Unchanged (menu-dominated) |

**Phase 3C COMPLETE** (2026-03-27): Functions 8-11 (drift_physics, suspension_damping, lateral_drift_A/B) ported. 1,716B SH2 code. Player entity now drifts, spins out, and has camera follow distance computed on SH2. Viewport shimmer relayed via COMM4/5.

### 7.1 Goal

Move the physics pipeline to Master SH2. Corrected scope: **13 functions** (not 9 — see §7.2).

### 7.2 Source Functions (Verified from entity_render_pipeline Variant A)

The orchestrator at $005AB6 calls these physics functions in order (lines 27-42). The roadmap previously listed 9 functions; 3 were missing, and the call chain was incorrectly described.

**Core pipeline (called directly by orchestrator):**

| # | Function | ROM Range | Size | Entry | Notes |
|---|----------|-----------|------|-------|-------|
| 1 | `speed_degrade_calc` | $00859A-$0085C4 | 42B | Direct | Leaf — pure arithmetic |
| 2 | `steering_input_processing_and_velocity_update` | $0094F4-$00961E | 298B | **+6** (skips data prefix) | Reads controller from WRAM |
| 3 | `entity_force_integration_and_speed_calc` | $009300-$009458 | 344B | **+18** (skips alternate entry) | Calls #4; contains DIVS D0,D1 + DIVS #$0190 |
| 4 | — `speed_calc_multiplier_chain` | $009458-$0094F4 | 156B | Called by #3 | Calls `speed_modifier` (34B, inlineable) |
| 5 | `entity_speed_clamp` | $009B12-$009B32 | 32B | Direct | Leaf; in `game/entity/` not `game/physics/` |
| 6 | `entity_speed_acceleration_and_braking` | $009182-$009300 | 382B | Direct | Contains DIVU (gear table lookup) |
| 7 | `tilt_adjust` | $00961E-$009688 | 106B | Direct | Leaf |
| 8 | `drift_physics_and_camera_offset_calc` | $009688-$009802 | **378B** | Direct | **PREVIOUSLY UNLISTED.** Camera follow + heading drift. Contains DIVS #$0497. |
| 9 | `suspension_steering_damping` | $009802-$00987E | **124B** | Direct | **PREVIOUSLY UNLISTED.** 3-entry jump table dispatches #10/#11 by $C8CC. |

**Dispatched via suspension_steering_damping jump table:**

| # | Function | ROM Range | Size | Dispatch | Notes |
|---|----------|-----------|------|----------|-------|
| 10 | `lateral_drift_velocity_processing_A` | $00987E-$0099AA | 300B | $C8CC state 2 | Grip reduction, spin-out ($B2 sound) |
| 11 | `lateral_drift_velocity_processing_B` | $0099AA-$009B10 | **358B** | $C8CC state 1 | AI variant: different math (mul-then-div), AI boost, viewport shimmer, ±$200 damping, 2× display |

**Position update + shared utility:**

| # | Function | ROM Range | Size | Notes |
|---|----------|-----------|------|-------|
| 12 | `entity_pos_update` | $006F98-$006FFA | 98B | 3× JMP to collision (NO RTS exit). Calls #13. |
| 13 | `sine_cosine_quadrant_lookup` | $008F4E-$008F88 | 58B | Shared utility (also used by camera, AI) |

**Total: ~2,700B 68K → estimated ~3,800B SH2** (corrected from 1,760/2,500B; variant B = 358B verified)

**Timer/guard functions (co-ported to SH2 in Phase 3B-5):**
- `tire_squeal_check` (L27) — stays on 68K (writes globals $FFC8A4, not entity fields)
- `effect_timer_mgmt` (L29) — **CO-PORTED** (writes +$02, +$0E, +$14, +$6A, +$6C, +$6E)
- `object_timer_expire_speed_param_reset` (L30) — **CO-PORTED** (writes +$40, +$62, +$92; simplified for entity 0)
- `field_check_guard` (L31) — **CO-PORTED** (reads +$8C, sets R2 for caller)
- `timer_decrement_multi` (L32) — **CO-PORTED** (decrements 8 timers: +$80-$86, +$98-$9A, +$E6-$E8)
- `object_anim_timer_speed_clear+6` (L40) — **CO-PORTED** (clears +$06; frame counter at entity+$F0)

**Design decision: CO-PORT** — All entity-modifying timer/guard functions are implemented on
SH2 alongside physics. They are dormant while cmd `$3F` is disabled; the current 1P build keeps
the 68000/WRAM entity authoritative. If live equivalence is established, the intended ownership
model can switch to initial-only staging. See §7.8.

### 7.3 Critical Translation Issues (Verified)

| Issue | Detail | Resolution |
|-------|--------|------------|
| **DIVU (gear table)** | `entity_speed_accel` L78: `DIVU $00(A1,D2.W),D1`. Divisor from 6-entry ROM table at $88A1F0: {171, 192, 205, 213, 219, 224}. Input: raw_speed << 8 (max $426800). | **6-entry reciprocal table** in expansion ROM. `MULU.L reciprocal >> 24`. Precision: verified max error ≤1 LSB for all input/gear combinations. |
| **DIVS D0,D1 (runtime)** | `entity_force_integration` L110: `DIVS D0,D1` where D0 = max_speed threshold from RAM $FFBBB2. Divisor is NOT a constant. | **SH2 software signed divide subroutine** (~16 iterations, ~64 cycles). No reciprocal table possible. |
| **DIVS #$0190** | `entity_force_integration` L131: `DIVS #$0190,D1` (÷400, slope increment). | Reciprocal: floor(2^24 / 400) = 41943 ($A3D7). `MULS.L * 41943 >> 24`. |
| **DIVS #$0497** | `drift_physics_and_camera_offset_calc` L27: `DIVS #$0497,D1` (÷1175, speed normalization). | Reciprocal: floor(2^24 / 1175) = 14281 ($37C9). `MULS.L * 14281 >> 24`. |
| **~~DIVS #103~~** | ~~`speed_interpolation` divides by 103.~~ | **REMOVED** — `speed_interpolation` is NOT in the physics pipeline. It's a separate subsystem. |
| **+offset entries** | Orchestrator calls `steering+6` and `force_integration+18`, skipping preambles. | SH2 port uses the main entry points directly. The skipped code (force=-51 default, data prefix) is handled differently in the SH2 version. |
| **entity_pos_update boundary** | ALL 3 exit paths are unconditional JMPs to collision (no RTS). Cannot insert bare RTS. | **Port position calculation only** — replace the 3 JMPs with RTS in the SH2 version. Collision stays on 68K (Phase 5). The 68K orchestrator must call collision separately after SH2 physics returns. |
| **suspension_steering_damping dispatch** | Uses $C8CC (race_substate_b) as jump table index to select lateral_drift variant. | Relocate $C8CC to SDRAM globals block. SH2 reads it to choose variant A or B. |
| **Sound triggers** | 5 writes to $FFC8A4 (orig `#$B2,(-14172).W`): $B1 (2×), $B4 (3×), $B2 (1×). All 15-frame timer gated. Single-byte last-writer-wins. | SDRAM sound byte at globals **+$2C** (not +$0F). SH2 physics writes it, cmd $3F relays to COMM6_HI, 68K reads each frame. |
| **Controller input** | `steering_input` reads $FFC000/$FFC00A/$FFC010/$FFC018 (68K WRAM). | Relocate to SDRAM globals block. 68K writes per-frame from V-INT input scan. |

### 7.4 RAM Variables to Relocate (Verified — 44 bytes)

**SDRAM globals block at $0600BF00 (64 bytes allocated):**

| Offset | 68K Address | Size | Name | Written By | Read By |
|--------|-------------|------|------|-----------|---------|
| +$00 | $FFC0AC | word | track_tilt | Scene init | tilt_adjust |
| +$02 | $FFC0E6 | word | track_speed_factor | Scene init | speed_calc_multiplier_chain |
| +$04 | $FFC0F8 | word | upper_accel_limit | Scene init | (reserved — not in pipeline) |
| +$06 | $FFC0FA | word | lower_accel_limit | Scene init | (reserved — not in pipeline) |
| +$08 | $FFC27C | long | speed_table_ptr | Scene init | speed_calc_multiplier_chain |
| +$0C | $FFC048 | long | gear_table_ptr | Scene init | entity_force_integration, entity_speed_accel |
| +$10 | $FFC0D4 | byte | surface_drivability | Scene init | entity_speed_accel |
| +$11 | $FFC31B | byte | wind_active | Scene handler | speed_calc_multiplier_chain |
| +$12 | $FFC826 | byte | has_boost_flag | Scene handler | speed_calc_multiplier_chain |
| +$13 | $FFC971 | byte | banking_direction | Per-frame | tilt_adjust |
| +$14 | $FFC000 | word | steering_velocity | Per-frame | steering_input_processing |
| +$16 | $FFC00A | word | steering_direction | Per-frame | steering_input_processing |
| +$18 | $FFC010 | byte | input_state | Per-frame | steering_input_processing |
| +$19 | $FFC018 | byte | ai_control_flag | Per-frame | steering_input_processing |
| +$1A | $FFC8C8 | word | mode_flag | Per-frame | speed_calculation |
| +$1C | $FFC8CC | word | race_substate_b | Per-frame | suspension_steering_damping |
| +$1E | $FFBBA0 | word | heading_correction | Track init | lateral_drift |
| +$20 | $FFBBA2 | word | lateral_drag | Track init | lateral_drift |
| +$22 | $FFBBA4 | word | spin_threshold | Track init | lateral_drift |
| +$24 | $FFBBA6 | word | high_vel_threshold | Track init | lateral_drift |
| +$26 | $FFBBA8 | word | drift_divisor | Track init | lateral_drift |
| +$28 | $FFBBB0 | word | min_speed_threshold | Track init | lateral_drift |
| +$2A | $FFBBB2 | word | max_speed_threshold | Track init | entity_force_integration (DIVS runtime divisor) |
| +$2C | $FFC8A4 | byte | sound_trigger_out | Physics output | 68K sound dispatch |
| +$2D | $FFBFC0 | byte | ai_control_flag | Scene init | lateral_drift_B (AI boost gate, bit 4) |
| +$2E | $FFBF7B | byte | slide_indicator | lateral_drift_A output | (display feedback) |
| +$2F | — | byte | (padding) | — | — |

**Total used: 48 bytes** (16 bytes free in 64B block)

**Viewport output addresses** (lateral_drift_B writes, 68K reads for display):
- $FF617A (word) — left viewport scale
- $FF618E (word) — right viewport scale
- These are WRAM display registers, NOT relocated to SDRAM. SH2 writes to SDRAM mirror; 68K copies to WRAM per frame.

### 7.5 Entity Field Access Summary (38 Offsets)

Across all 13 physics functions, 38 distinct entity offsets are accessed. Key groups:

| Category | Offsets | Access |
|----------|---------|--------|
| Position | +$30 (X), +$34 (Y), +$3C (heading mirror), +$40 (heading) | RW |
| Speed | +$04, +$06 (display), +$16 (calc), +$74 (raw), +$7E (target) | RW |
| Dynamics | +$0E (force), +$10 (drag), +$78 (grip), +$7A (gear), +$8A (boost mod) | RW |
| Drift | +$4C (slip), +$8E (steer vel), +$90 (drift rate), +$92 (slide), +$94/$96 (lateral), +$AA (accum) | RW |
| Flags | +$02 (status), +$54 (steer mode), +$58/$59 (contact), +$62 (collision), +$6A (lateral), +$8C (lateral flag), +$A8 (speed state), +$AE (table offset) | R mostly |
| Timers | +$14 (boost), +$80 (sound), +$82/$84 (brake), +$98/$9A/+$E6/$E8 (screech) | RW |
| Camera | +$1E (ref angle), +$5A/$5C (trail), +$76 (cam dist) | R/RW |

**Full entity record: 256 bytes per entity, 25 entities = 6,400 bytes.**
Once physics runs on SH2, entity tables must be in SDRAM (already allocated at $0600F20C per Phase 1).

### 7.6 ROM Table References (8 Tables)

| Table | 68K Address | SH2 Address | Size | Used By |
|-------|------------|-------------|------|---------|
| Drag (road surface) | $0093910E | $0213910E | ~128W | entity_force_integration |
| Drag (off-road) | $00938FCE | $02138FCE | ~128W | entity_force_integration |
| Gear ratios | $0088A1F0 (file $A1F0) | $0200A1F0 | 6W (12B) | entity_speed_accel |
| Upshift thresholds | $0088A1E2 (file $A1E2) | $0200A1E2 | 6W (12B) | entity_speed_accel |
| Downshift thresholds | file $139EDE | $02139EDE | 6W (12B) | entity_speed_accel |
| Speed table base | ptr at $FFC27C | ptr relocated to globals | ~384W | speed_calc_multiplier_chain |
| Sine/cosine | file $130000 | $02130000 | 257W | entity_pos_update, drift_physics |
| Sine table (alt) | $00A2D8 (file $A2D8) | $0200A2D8 | 64W (128B) | physics_lookup_tables, effect_timer |

**SH2 ROM access:** All tables are in ROM below $300000. SH2 accesses ROM at `$02000000 + file_offset`. ROM reads from SH2 are cached (1-2 wait states first access, 0 thereafter if in cache). Table locality is good for caching.

> **Address-audit correction (2026-06-17):** The SH2 column above is the authority — verified against actual ROM bytes. Earlier revisions of this table (and the code derived from them) carried two error classes:
> 1. **Dropped-zero literals** — `$020A1F0`/`$020A1E2`/`$0202A2D8` were written with a missing/extra digit, resolving *below* the `$02000000` ROM window (e.g. `0x020A1F0` parses as `$0020A1F0` = garbage). Found and fixed in `physics_group2_accel.asm`, `ai_orchestrator.asm`, `physics_timers.asm`. **Any 7-hex-digit `0x020xxxxx` literal in SH2 source is almost certainly this bug** — it should be 8 digits (`0x0200xxxx`).
> 2. **Mislabeled 68K addresses** — the `$0093xxxx`/`$00A2D8` *68K* labels were wrong; the tables actually live at file offsets `$13xxxx`/`$A2D8`. The SH2 literals (`$0213xxxx`) were nonetheless correct because they were derived to point at the real file offset. Verify table identity by ROM content, not by the 68K label.

### 7.7 Historical Phase 3 Acceptance Record

The checked boxes below record what the 2026-03 experiment claimed at the time. They do not
establish current 1P execution or authority; the live-integration criteria are reopened below.

- [x] All 7 physics functions assembled and linked into expansion ROM (884B + 496B)
- [x] 5 timer/guard functions co-ported (284B, interleaved in correct orchestrator order)
- [x] DIVU reciprocal accuracy verified: exact for all 6 gear ratios (zero diff)
- [x] 3600-frame autoplay in dual-path mode — no crashes
- [x] cmd $3F calls physics in correct order with GBR/R13 setup
- [x] Grip clamp bug found and fixed (ratio check before subtraction, not after)
- [x] Frame counter persistence bug found and fixed (entity+$F0, not globals+$30)
- [x] Hardware-level review: GBR range, COMM safety, SDRAM cache, DMAC state — all clear
- [x] SH2-only physics enabled (orchestrator bypass via trampoline in code_1c200)
- [x] Sound triggers reach 68K via COMM6_HI (relay in cmd $3F + pickup in state4_epilogue)
- [x] 68K utilization measured: STOP spin 51.9% → 63.1% (+11.2% idle = physics offloaded)
- [x] 16.16 fixed-point position update (entity+$F2/+$F4 fractional, +$30/+$34 integer, 60 FPS ready)
- [x] Initial-frame-only entity staging ($C8D2 flag, cmd $3E dual mode)
- [x] 3600-frame autoplay with SH2-only physics — no crashes, clean shutdown

**Current live-integration criteria:**

- [ ] cmd `$3F` observed executing in the intended 1P scene over a trustworthy fixture
- [ ] SH2 and 68000 physics outputs compared frame-by-frame while the 68000 remains authoritative
- [ ] Renderer shown to consume SH2-derived state through a verified descriptor bridge
- [ ] 68000 bypass enabled only after equivalence, collision, and long-run behavior pass

### 7.8 Entity Ownership Resolution

**Problem (identified 2026-03-26):** The entity staging function copies 256B from WRAM ($FF9000) to SDRAM ($0600F20C) every frame. When SH2 physics writes results to SDRAM, the next frame's staging OVERWRITES them with stale WRAM data. Physics fields are accumulated (speed, position, grip) — resetting them breaks the simulation.

**Intended solution (not active in current 1P): Co-port all entity-modifying functions to SH2.**
Only after physics + timer/guard functions and the render bridge are validated can the SDRAM
entity become authoritative. The current 1P build keeps the 68000/WRAM entity authoritative.
The planned staging model is:

- **First racing frame:** Full 256B WRAM → SDRAM copy (seed initial state)
- **Subsequent frames:** Entity persists in SDRAM, modified only by SH2 physics+timers
- **Per-frame globals:** Still staged every frame via DREQ (controller input, mode flags)

**Timer/guard fields resolved:**

| Function | Offset Written | Conflict With Physics | Resolution |
|----------|---------------|----------------------|------------|
| effect_timer_mgmt | +$02, +$0E, +$14, +$6A, +$6C, +$6E | +$0E read by force_integration | Co-ported, runs before physics |
| timer_expire_reset | +$40, +$62, +$92 | +$40 read by entity_pos_update | Co-ported, runs before steering |
| timer_decrement_multi | +$80-$86, +$98-$9A, +$E6-$E8 | Timers gate sound triggers | Co-ported, runs before force_integration |
| field_check_guard | reads +$8C | Guards lateral physics | Co-ported, runs before timer_decrement |
| anim_timer_speed_clear | +$06 | +$06 read by speed_clamp | Co-ported, runs after tilt_adjust |

**Known simplifications:**
- `timer_expire_reset`: Type check chain (object_id $69-$6F range) skipped. For entity 0 (player), object_id is always $00 < $69, so the check always exits to .set_speed. **Only safe for entity 0.**
- `anim_timer_speed_clear`: JMP to `conditional_return_on_state_match` replaced with RTS. The fallthrough path handles edge-case state transitions that don't occur during normal player racing. **Only safe for entity 0.**
- `anim_timer_speed_clear`: Frame counter stored at entity+$F0 (unused entity field) instead of WRAM $C02A. This avoids the globals staging wipe issue.

### 7.9 SH2 Register Convention (Established Phase 3B)

| Register | Role | Set By | Lifespan |
|----------|------|--------|----------|
| GBR | Entity base ($0600F20C) | cmd $3F via `LDC R0,GBR` | Entire physics pipeline |
| R13 | Globals base ($0600F30C) | cmd $3F via `MOV.L @pool,R13` | Entire physics pipeline |
| R14 | Entity base (for @(R0,R14) indexed access) | cmd $3F (same value as GBR) | Entire physics pipeline |
| R8 | COMM base ($20004020) | Dispatch loop (preserved) | Entire handler |
| R0-R7, R9-R12 | Scratch | Per-function | Function-local |
| R15 | Stack pointer | System | Always |

**Addressing patterns:**
- Entity field ≤ offset 30: `MOV.W @(offset,R14),R0` (displacement, any dest for Rn form)
- Entity field ≤ offset 510: `MOV.W @(offset,GBR),R0` (GBR, **R0 only** for dest/source)
- Entity field > offset 510: not needed (entity is 256B)
- Globals field: `MOV #offset,R0; MOV.W @(R0,R13),Rn` (indexed, R0 must be index)
- ROM table: `MOV.L @pool,Rn; MOV.W @(R0,Rn),Rm` (literal pool + indexed)

### 7.10 Expansion ROM Memory Layout (Phase 4)

```
$301300-$30148F  coord_transform_batched (388B)       — ACTIVE (S-6 Phase B)
$301500-$3016AB  cmd $3F (428B)                       — BUILT/JT-INSTALLED; 1P trigger disabled
$3016B0-$30175F  cmd $3E (176B)                       — BUILT; 1P mode 0 accepted/reachable, modes 1/2 disabled
$301760-$3017AF  physics_divide (80B)                 — BUILT; dormant in current 1P
$3017C0-$301B33  physics_group1 (884B)                — BUILT; dormant in current 1P
$301B40-$301D2F  physics_group2_accel (496B)          — BUILT; dormant in current 1P
$301D40-$301E5B  physics_timers (284B)                — BUILT; dormant in current 1P
$301E60-$301F17  physics_pos_update (184B)            — BUILT; dormant in current 1P
$301F20-$3025D3  physics_drift (1716B)                — BUILT; dormant in current 1P
$3025E0-$3026EF  ai_steering (272B)                   — BUILT; dormant in current 1P
$302700-$3029EB  ai_orchestrator (748B)               — BUILT; dormant in current 1P
$302B00-$302C7F  render_state_patcher (384B)          — NO-OP (Phase 7 dead-end; writes addresses renderer never reads)
$302D00-$303013  collision_leaf (788B)                — ASSEMBLED ONLY (Phase 5A: angle_normalize×3 + plane_eval×2 + rotational_offset_calc; not yet wired to cmd $3F)
$303100-$3031EF  collision_track_data (240B)          — ASSEMBLED ONLY (Phase 5B: track_data_index_calc + track_data_extract_033; pointer-translation convention defined; ref-model verified 0 mismatch; not yet wired to cmd $3F)
$303200-$303407  collision_boundary (520B)            — ASSEMBLED ONLY (Phase 5C: object_type_dispatch $303200 + track_boundary_collision_detection $303250; puzzle resolved [trap nibbles -> $02 per dispatch_b]; A2-capture fix [store angle_normalize advanced A2, not input tile]; packer globals +$38/+$3A WIRED; ref-model verified 0 mismatch incl. A2 fidelity 63,219 cases; cmd $3F dispatch DEFERRED)
$303410-$30361F  collision_response (528B)            — ASSEMBLED ONLY (Phase 5D: collision_response_surface_tracking $303410; 4-iter binary search + EMA surface tracking; calls track_boundary $303250 5x + plane_eval_signed $302F3A 4x; deltas+iter on stack across calls; reads COLL_POS $06011030 + tile ptrs +$CE/$D2/$D6/$DA; verify_5d.py 0 mismatch [bin search 60k + EMA 160k]; cmd $3F dispatch DEFERRED — authoritative-copy unresolved, render_state_patcher no-op)
$303640-$3039D7  collision_object (920B)              — ASSEMBLED ONLY (Phase 5E: object_collision_detection $303640 + position_separation $303768 + zone_check_inner $3037C4 + proximity_zone_loop $303964; entity-TABLE layer over SDRAM copies [player $0600F20C, AI $06010000+(i-1)*$100, entity-15 $06010E00]; $C268 = SAME ptr as 5C track_seg_base → reuses globals +$3A; OBJ_COLL_GLOBALS $06011050 [thresholds+bounds]; sound $B8 → globals +$2C; directional_collision_probe EXCLUDED [dead]; 5E bug-fix: pass-2 A2-clobber [.zc_zb_bytes] + neg.w exts.w; verify_5e.py 0 mismatch w/ teeth-proofs A=316/B=5105; cmd $3F dispatch DEFERRED)
$3039E0-$303A03  bridge_probe (36B)                    — ASSEMBLED, corrected C254 Run C; dormant
$303A10-$3EFFFF  Free (~966KB)                         — ROM padded to $3F0000

SDRAM TRACK_WORK region (native): $06011000 work buf (24B) / $06011020 surf-type
/ $06011021 surf-cnt / $06011024 A4 scratch (8B) / $06011030 coll-pos (20B) /
$06011050 OBJ_COLL_GLOBALS (20B: 5E object thresholds + zone bounds). AI entities
end $06010F00 → region free (grep-verified).
```

**Total VR60 SH2 code: ~7,268 bytes** (24 functions + AI entity loop + infrastructure)

**Phase 5A note:** `collision_leaf` holds 3 register-parameter pure-math leaves
(zero addressing risk). `position_separation` / `proximity_zone_loop` are
**deferred to Phase 5E** — they iterate the entity table and need the SDRAM
entity-iteration convention settled first. 5A is additive: the functions are
assembled and byte-verified (100k randomized cases vs a 68K reference model)
but NOT dispatched from cmd $3F.

---

## 8. Phase 4: AI Port

**Status: CORE PORT BUILT; 1P AI TRANSFER AND CMD `$3F` DISABLED** (corrected 2026-07-21)
**Prerequisite: Phase 3 (done)**

### 8.0 Implementation Status

**What's built (4 SH2 modules, ~1,800B SH2 code):**

| Component | ROM Address | Size | Status |
|-----------|------------|------|--------|
| ai_steering + atan2 | $3025E0 | 272B | BUILT; not reached by current 1P path |
| ai_orchestrator (3 entries) | $302700 | 748B | BUILT; not reached by current 1P path |
| cmd $3F AI entity loop | (inline) | ~60B | BUILT; 1P cmd `$3F` trigger disabled |
| Variant B bypass trampoline | code_1c200 | ~30B | BUILT; bypass disabled in current 1P path |

**AI entity SDRAM:** $06010000 (15 × 256B = 3,840B, first-frame DREQ staging)
**AI globals:** $0600FC10 (16B: countdown, visibility, race_counter, slot table)

**Total entities on Master SH2:** 16 (1 player + 15 AI)
**Estimated Master SH2 utilization:** ~38% (from 33% at Phase 3)

**Remaining (not yet ported):**
- collision_avoidance_speed_calc (502B) — Manhattan distance + speed table lookup. Falls through to physics. Currently AI entities skip this path (orchestrator handles speed directly).
- ai_state_dispatch + external state handlers — global 15-state machine. Ticks independently, can stay on 68K for now.
- Supporting micro-functions (timers, flags, buffer setup) — small, can be ported incrementally.

### 8.1 Goal

Move the 15-state AI machine to Master SH2.

### 8.2 Key Dependency (RESOLVED)

`collision_avoidance_speed_calc` ($A470) **falls through to** `physics_integration` ($A666) with no RTS. Phase 3 put physics on SH2, making this the natural AI integration point. The orchestrator now chains into the existing SH2 physics pipeline.

**Phase 4 depends on Phase 3 — SATISFIED.**

### 8.3 Functions to Port

| Function | ROM Address | Size | Notes |
|----------|-----------|------|-------|
| `ai_entity_main_update_orch` | $00A972 | 716B | Orchestrator — largest single function |
| `ai_state_dispatch` | $00BE50 | 116B | 15-entry jump table |
| `collision_avoidance_speed_calc` | $00A470 | 502B | Falls through to physics_integration |
| `ai_opponent_select` | $00A434 | 60B | Gated activation |
| `ai_steering_calc` | $00A7A0 | 66B | atan2 approximation (shared with camera) |
| `ai_scene_interpolation` | $00BD2A | 116B | Attract mode keyframes |
| 18 supporting functions | various | ~400B total | State advance, timer, buffer setup |

**Total:** ~1,976 bytes 68K → estimated ~2,700 bytes SH2

### 8.4 State to Relocate

| Variable | 68K Address | Purpose | Strategy |
|----------|------------|---------|----------|
| AI state index | $FFA0EA | State machine position (0-56) | SDRAM globals block |
| AI timer | $FFA0EC | 120-frame advancement timer | SDRAM globals block |
| Race slot table | $FFC03C | 4 slots × word state | SDRAM globals block |
| Entity +$A4/+$A6 | Per-entity | Target indices (opponent tracking) | Already in entity table (relocated in Phase 1) |
| Entity +$AE | Per-entity | Type dispatch index | Already in entity table |

### 8.5 Acceptance Criteria

- [ ] AI opponents behave identically (steering, avoidance, spawn timing)
- [ ] All 15 AI states cycle correctly (verify via diagnostic counter)
- [ ] Opponent selection activates at correct speed/mode thresholds
- [ ] collision_avoidance → physics_integration fall-through works on SH2
- [ ] 3600-frame autoplay — no behavior changes visible

---

## 9. Phase 5: Collision Port

**Status: 5A–5E ADDITIVE PORT BUILT/REFERENCE-TESTED; NOT DISPATCHED.
5F-0's C218 “GO” IS SUPERSEDED; C128/C178/C254 ARE THE LIVE DESCRIPTOR FAMILIES.**
KEY FINDING: Phases 3–5 are built but dormant in current 1P. When cmd `$3F` is enabled,
they must first run as observable shadow computation while the 68K WRAM entity drives the
screen. The render bridge, not collision wiring, is 5F's real
prerequisite. See §9.0b 5F + `analysis/VR60_PHASE5F_SCOPING.md` + `VR60_PHASE5F0_RENDER_INPUT.md`.
Function inventory + addresses verified against disassembly and ROM bytes.
5A leaf-math ported to SH2 $302D00 (2c0f603). 5B track-data addressing layer ported to
SH2 $303100, ~60k-case verified, Auditor APPROVED. 5C boundary detection
(object_type_dispatch + track_boundary) ported to SH2 $303200 (520B), packer globals
+$38/+$3A wired, verify_5c.py 0 mismatch (incl. A2-fidelity 63,219 cases — see
bug-fix note below). Auditor APPROVED. Prerequisite Phase 3 satisfied.
**Prerequisite: Phase 3 (entity_pos_update on SH2 — done)**

### 9.0 Scoping Results (verified 2026-06-17)

**Current integration point (corrected).** Collision is **NOT missing** — it currently
runs on the **68K**. In SH2-physics mode the bypass trampoline jumps to
`entity_render_pipeline_position_ai` (`entity_render_pipeline.asm:44`), and line 45
`jsr entity_pos_update` still executes; the 68K `entity_pos_update` tail-JMPs into
`collision_response_surface_tracking` on all three exits
(`entity_pos_update.asm:32/35/38`). `cmd $3F` calls **no** collision function. So Phase 5
= **port collision to SH2 (call it from cmd $3F after `.phys_f12`) and remove the
redundant 68K call** — this is the ~10% 68K relief Phase 7 needs (§11).

**§9.2 addresses/sizes: all 9 verified CORRECT** (ROM byte spot-checks). No glitchy-doc
address error in this list (contrast §7.6).

**Hidden callees omitted by §9.2 — must also be ported (~660B extra 68K):**

| Callee | File / SH2 addr | Size | Notes |
|--------|----------------|------|-------|
| `angle_normalize` (+24=$74A4, +168=$7534 entries) | $748C / $0200748C | 316B | Pure math, no WRAM, no DIV — clean |
| `plane_eval` (+24=$75E0) | $75C8 / $020075C8 | 54B | Pure math, A2-relative reads, no DIV |
| `object_type_dispatch` | $7A40 / $02007A40 | 78B | 14-entry PC-rel jump table @ $7A52 → 68K-addr handlers; table must be rebuilt for SH2 |
| `zone_check_inner` | $AE06 / $0200AE06 | 210B | used by object_collision; reads $C268 (68K-addr ptr) |

**No DIVU/DIVS anywhere in the 9 functions or 4 callees** — all shift/MULS-based. Unlike
Phase 3, no reciprocal tables or software-divide needed.

**Keystone risk:** 68K-CPU-address tile pointers from `track_data_index_calc` (stored in
entity +$CE/$D2/$D6/$DA) must be `+$01780000`-translated at every SH2 dereference. See §9.3.

**WRAM globals to relocate to the SDRAM globals block (SH2 can't reach 68K WRAM):**
`$FFC0D0-$C0E2` (probe x/y scratch), `$FFC02E-$C044` (probe offsets + extract033 work buf),
`$FFC319/$C31A` (surface type), `$FFC268` (track base ptr — store pre-translated),
`$FFC8A0` (race_state), `$FFC8CE/$C8D0` (object-collision thresholds). Already handled:
`$FFC8CC` (globals +$1C), `$FFC8A4` sound (globals +$2C → COMM6_HI). object_collision /
proximity must iterate the **SDRAM** entity copies ($0600F20C player, $06010000 AI), not WRAM.

**Open question for 5F (not a blocker for 5A–5E):** in SH2-physics mode `entity_pos_update`
runs on *both* SH2 (cmd $3F) and 68K (line 45) — trace the authoritative-copy / copy-back
model before deleting the 68K collision call.

### 9.0b Sub-Phase Plan (incremental, mirrors Phase 3: build group → dual-path verify → switch)

- **5A — Leaf math foundation (zero addressing risk). ✅ DONE 2c0f603.** Ported `angle_normalize`
  (+24/+168), `plane_eval` (+24), `rotational_offset_calc` ($764E, uses already-ported
  sine) to SH2 $302D00 (collision_leaf.asm). Unit-verified vs 68K (100k cases).
  **CORRECTION (2026-06-18):** an earlier draft of this entry claimed 5A also ported
  `position_separation` ($AFFE) and `proximity_zone_loop` ($877A). It did NOT — those
  iterate the entity table and were DEFERRED to 5E precisely because the SDRAM
  entity-iteration convention had to be settled first (§7.10 Phase-5A note records the
  deferral: "position_separation / proximity_zone_loop are deferred to Phase 5E").
  They are done in 5E (below), NOT 5A. collision_leaf.asm contains neither function.
- **5B — Track-data addressing layer (keystone). ✅ DONE (Auditor APPROVED).** Ported
  `track_data_extract_033` + `track_data_index_calc_table_lookup` to SH2 $303100 (240B).
  **Convention:** translate table CONTENTS by +$01780000 once at pointer formation, store
  SH2-ready (PC-rel table bases $0200742C/$0200745C need NO translation). Safe in dual-path
  because SH2 uses the SDRAM entity copy, 68K uses WRAM. **Proposed SDRAM layout (to wire in
  5C):** globals +$38 (word)=race_state, globals +$3A (long)=track_seg_base PRE-TRANSLATED
  by packer; intra-frame SH2-only scratch TRACK_WORK_BUF at $06011000 (native, verified free).
- **5C — Boundary detection. ✅ DONE (2026-06-17), ASSEMBLED + ref-verified; cmd $3F
  dispatch DEFERRED.** Ported `object_type_dispatch` (SH2 $303200, flat-rebuilt; the
  $7AB2 DIVU-/0 trap nibbles 5,6,7,9,10,11,12,14,15 → default $02 per the identical
  twin `object_type_dispatch_b`/$7C46 — unreachable for track-boundary surfaces) and
  `track_boundary_collision_detection` (SH2 $303250, center + 4 probes; 520B total).
  Packer WIRED: globals +$38 race_state ($C8A0), +$3A track_seg_base ($C268
  pre-translated, ROM-verified). WRAM relocated to TRACK_WORK ($06011000+: workbuf =
  exactly extract_033's 8 words; surf-type/cnt; A4 scratch; coll-pos for 5D).
  verify_5c.py: object_type_dispatch (256 cases) + probe orchestration (32 combos) +
  workbuf correspondence → 0 mismatch. Live cmd-$3F dual-path compare deferred (would
  interact with A-1 $C8D2 staging + 5F authoritative-copy question); wiring plan in
  findings.md (JSR after `.phys_f12`). Old dual-path-compare target (+$55-$59,
  +$CE/$D2/$D6/$DA/$DE) carries to that step.
  **Auditor advisories carried from 5B (MUST honor):**
  - *A-1:* keep cmd $3E player-entity staging initial-frame-only ($C8D2-gated). A mid-race
    mode-0 stage overwrites SDRAM entity +$CE/$D2/$D6/$DA with 68K-form pointer garbage →
    collision corruption. Re-confirm the gate hasn't regressed before storing SH2 pointers.
  - *A-2:* the packer must write globals +$3A as `$C268_runtime + $01780000` (full longword).
    $C268 is set at scene init (stable across frame) — stage it once at scene transition,
    not per-frame, and sample it where the 68K collision uses it.
  - *A-3:* 5F copy-back must NEVER move WRAM +$CE/$D2/$D6/$DA into SDRAM (68K-form would
    overwrite SH2-form). Verify when tracing the authoritative-copy model.
  **New advisory from 5C Auditor (MUST honor at cmd-$3F dispatch):**
  - *A-4:* object_type_dispatch maps the trap/oob nibbles (5,6,7,9-15) to D0=$02. The
    "these never occur on track-boundary surfaces" claim is inferred, not exhaustively
    proven. When wiring live: a nibble in that set makes the 68K *trap* (DIVU/0 at $7AB2)
    while SH2 silently returns $02 — masking a divergence. Add a debug canary/assert at
    the dispatch step BEFORE deleting the 68K collision path.
  **5C correctness lesson (record):** first cut stored the *input* tile ptr where the 68K
  uses `angle_normalize`'s *advanced output* A2 (= input+2 + $1C×found-groups for full/+24;
  = input for alt). Fixed by capturing R9 (SH2 A2) after each angle call. verify_5c.py was
  extended to model A2 fidelity (63,219 cases, 0 mismatch; a simulated pre-fix port mismatches
  4472/4472 center hits — the test now has teeth). Lesson: when porting a callee whose
  *register side-effects* (not just return value) are consumed by the caller, the
  reference model MUST assert those side-effects, not only the documented return.
- **5D — Surface response. ✅ DONE (2026-06-18), ASSEMBLED + ref-verified; cmd $3F
  dispatch DEFERRED.** Ported `collision_response_surface_tracking` (68K $7700, 412B)
  to SH2 **$303410 (528B)**. 4-iter binary search (1/4-step deltas via ASR.W #2;
  reset-to-prev; advance/revert/stop using track_boundary's +$55 bit0 as oracle) +
  EMA surface tracking (4 probes +$D2/$D6/$DA/$CE -> plane_eval_signed -> EMA into
  +$5A/$5C/$5E/$32; probe4 +$DE unused; dead `jsr` at $7818 not ported). Callees
  confirmed: track_boundary $02303250 (clobbers R0-R12 -> deltas+iter stashed on
  stack, GBR re-stc'd), plane_eval_signed **$02302F3A** (R9=tile ptr, R1=x, R2=y,
  out R1; BLE -> `cmp/pl r1; bf`). COLL_POS $06011030 mapping re-verified (center
  $C0D0=slot+$00, NOT $C090). verify_5d.py: bin search 60k + EMA 160k + BLE +
  mapping -> **0 mismatch**.
  **Authoritative-copy investigation (advances 5F):** `render_state_patch` READS the
  SDRAM entity +$30/$34 to build a camera delta into $0600CA00/$0600CCA0 — but that
  patcher is a **proven no-op** (3D engine reads $06003xxx/$06004xxx, not those
  arrays). So the SH2 entity position drives nothing visible; the on-screen car is
  the 68K WRAM entity (68K collision intact). cmd $3F runs no collision today.
  **WIRING DECISION: ADDITIVE / DEFERRED** — wiring 5D live writes an unread entity
  (no benefit) and interacts with A-1 staging (mid-race mode-0 stage could feed
  track_boundary 68K-form +$CE.. garbage); 5F's authoritative/copy-back model is
  unresolved. Safe-wiring plan: JSR $02303410 after `.phys_f12` (it calls
  track_boundary itself, so 5C needs no separate dispatch); preconditions = A-1 gate
  re-confirm + authoritative-copy resolved + A-4 trap canary. 5D honors A-3 (reads
  SH2-form ptrs, writes only position/EMA scalars — no pointer writes).
- **5E — Object/proximity collision. ✅ DONE (2026-06-18), ASSEMBLED + ref-verified;
  cmd $3F dispatch DEFERRED.** Ported 4 functions (920B) to SH2 $303640
  (collision_object.asm): `object_collision_detection` ($AF18 → $303640, player vs
  entity-15), `position_separation` ($AFFE → $303768), `zone_check_inner` ($AE06 →
  $3037C4, 2-pass angle/bounds), `proximity_zone_loop` ($877A → $303964, 15-entity zone).
  **5E bug-fix pass (2026-06-18):** Finding A — pass-2 `lea zone_check_data(pc),A2`
  clobbers the read pointer (post-hit iters read zone_check_data+k*$800), now
  replicated bit-exactly via `.zc_zb_bytes` {$00FF,$0010,$0003} + R12 mode flag.
  Finding B — both abs `neg` sites now `exts.w` (68K neg.w word semantics, -$8000).
  Finding C — verify_5e.py now transliterates the corrected asm and the true 68K
  (incl. the clobber); teeth-proofs confirm it FAILS against the pre-fix logic
  (Finding A: 316 divergent cases, Finding B: 5105). 0 mismatch post-fix.
  `directional_collision_probe` ($7AD6) EXCLUDED — dead in this build (grep: zero
  jsr/bsr/jump-table/data refs; the `dc.w $7AD6` hits are coincidental data words).
  **Settled SDRAM entity-iteration convention** (§7.10 deferred this): player (entity 0)
  = $0600F20C; AI entity i (1..15) = $06010000+(i-1)*$100 (stride $100); WRAM
  entity-15 ($FF9F00) = SDRAM $06010E00. Evidence: vr60_ai_entity_stage DREQs WRAM
  $FF9100 (entity 1) → SDRAM $06010000 intact; cmd $3F AI loop iterates the same.
  **$C268 finding:** zone_check's "$C268 angle table" is the SAME single WRAM longword
  as 5B/5C's track_seg_base (scene_camera_init.asm:84; the "angle table" label is a
  mislabel) → REUSES 5C's pre-translated globals +$3A, no separate relocation.
  **Globals:** the staged window is FULL, so 5E's scene-stable thresholds ($C8CE/$C8D0)
  + zone bounds ($C8E4-$C8F2, 8 words) relocate to OBJ_COLL_GLOBALS $06011050 in
  TRACK_WORK (staged once at scene init when wired in 5F; A-2). Sound $B8 → globals +$2C
  → COMM6_HI (existing relay). proximity center+thresholds = caller-supplied registers.
  **Translations:** ASR.W#1/#2/#5 (exts.w+shar), sub.w/neg.w word-wrap (exts.w retrunc),
  BSET-to-mem (shift-loop 1<<zone; SH2 has no SHLD), ORI-to-mem (RMW), EXG (temp).
  **WIRING DECISION: ADDITIVE / DEFERRED** (matches 5C/5D) — render_state_patch no-op,
  SH2 entity unread; wiring writes flags on unread entities + interacts with A-1.
  Safe-wiring plan (5F): JSR object_collision after .phys_f12 (GBR=player; it loads
  A1=$06010E00); stage OBJ_COLL_GLOBALS once at scene init; re-confirm A-1 $C8D2 gate.
  verify_5e.py: position_separation 40k + proximity 20k×15 + zone_check 20k + object_
  collision 40k → **0 mismatch**. Auditor review pending.
- **5F — Switchover. RECAST after 5F-0 scoping+trace (2026-06-18).** Scoping
  (`analysis/VR60_PHASE5F_SCOPING.md`) established the load-bearing fact: **Phases 3–5
  are built but dormant in current 1P; their next valid mode is SHADOW computation** — the
  on-screen car is driven entirely by the 68K
  WRAM entity; the SH2 SDRAM entity ($0600F20C/$06010000) reaches nothing visible
  (`sh2_render_state_patch` is a verified no-op; the Phase 3 bypass re-enters at
  `entity_render_pipeline_position_ai`, so the 68K still builds display objects from
  WRAM). **Therefore wiring collision alone changes nothing on screen — the SH2→render
  bridge is the real prerequisite.** Collision ports 5A–5E are correct + ready but inert
  until the bridge lands.
  - **5F-0/5F-1a — HISTORICAL, C218 inference superseded.** These reports correctly found
    that the patcher's CA00/CCA0 writes were ineffective, but they followed the non-racing
    `$06000DC8` transform and incorrectly promoted C218 as the per-frame racing descriptor
    input. Preserve them as evidence, not as an implementation specification.
  - **5F-1b diagnosis — static target family corrected.** Decoding the actual cmd `$02`
    handler `$06000FA8` shows that its entity loop consumes descriptors from **C128 (4),
    C178 (8), and C254 (56)** with `$14` stride. C218 is absent from that handler and is
    used by other render modes. See `analysis/VR60_PHASE5F1B_PROBE_DIAGNOSIS.md`.
  - **Corrected bridge probe — BUILT BUT DORMANT.** `bridge_probe.asm` implements reversible
    Run C by clearing the C254 visibility words through cache-through `$2600C254`. The current
    cmd `$3F` binary still calls `.patcher_addr`, not `.bridge_addr`, and the 1P cmd `$3F`
    trigger is disabled. After the trustworthy-baseline and shadow-cmd-`$3F` gates pass,
    select the probe and visually identify which live descriptor batch contains the cars.
  - **5F-2 — Wire collision + gate 68K path (AFTER the bridge is live).** Now meaningful:
    JSR collision after `.phys_f12` (5D entry covers 5C+5D; object_collision per §5E plan;
    stage OBJ_COLL_GLOBALS); $C8D2-gate the 68K collision tail off. Honor A-1/A-2/A-3/A-4.
  - **5F-3 — AI remnants + re-profile.** Co-port §11 remnants (`collision_avoidance_speed_calc`,
    AI `physics_integration`/`ai_steering` callers); re-profile (`vrd_budget.py` + `fb_crc`):
    Slave <100%, all frames unique, confirm 68K relief. This is also the gateway to Phase 7
    (the same render bridge is what makes per-TV-frame logic actually move the car).

### 9.1 Goal

Move collision detection to Master SH2. This is the most complex port — binary search over track tiles with 5-point probing.

### 9.2 Functions to Port

| Function | ROM Address | Size | Complexity |
|----------|-----------|------|-----------|
| `collision_response_surface_tracking` | $007700 | 412B | High — 4-iteration binary search |
| `track_boundary_collision_detection` | $00789C | 420B | High — center + 4 directional probes |
| `track_data_index_calc_table_lookup` | $0073E8 | 68B | Medium — 2-level ROM table lookup |
| `track_data_extract_033` | $0076A2 | 94B | Medium — 4-page geometry extraction |
| `object_collision_detection` | $00AF18 | 170B | Medium — weighted speed avg |
| `directional_collision_probe` | $007AD6 | 214B | Medium — forward + adjacent |
| `proximity_zone_loop` | $00877A | 104B | Low — 15-entity Manhattan |
| `position_separation` | $00AFFE | 44B | Low — push-apart |
| `rotational_offset_calc` | $00764E | 84B | Low — 2D rotation |

**Total:** ~1,610 bytes 68K → estimated ~2,300 bytes SH2

### 9.3 Track Data Access

Collision uses `track_data_index_calc_table_lookup`, which reads **PC-relative** pointer tables at file `$742C`/`$745C` (the tables themselves are SH2 `$0200742C`/`$0200745C`). The table *contents* are **68K CPU addresses** (e.g. `$0094C000`, `$009D0000`) that must be translated at dereference time.

**RESOLVED (verified 2026-06-17, ROM content checked):** SH2 address = `68K_addr − $880000 + $02000000` (= `68K_addr + $01780000`). Worked example: `$0094C000 − $880000 = file $CC000` → SH2 `$020CC000` (data present in ROM). Highest track-data base referenced is `$009D0000` → file `$150000` → SH2 `$02150000`, well within the 4MB ROM (`$3F0000`). No banking/mirroring involved. **The earlier "$0294C000 / file $C4000" values in this section were wrong arithmetic** ($0094C000 is **not** $02000000+$0094C000, and $94C000−$880000 is **not** $C4000). See Q-002.

**Porting hazard (the keystone risk):** `track_data_index_calc` returns A1/A2 as **68K CPU addresses** (`adda.l D3,A1` onto a base read from the 68K-addr table). These are stored into entity +$CE/$D2/$D6/$DA and re-dereferenced by `collision_response_surface_tracking`. On SH2 **every such pointer must be +$01780000-translated at dereference** (or the table base pre-translated once at scene init). Getting it wrong reads 68K code as tile data → garbage collision.

### 9.4 Sound Triggers from Collision

| Collision Event | Sound Byte | Trigger |
|-----------------|-----------|---------|
| Skid/deceleration | $B1 | Force exceeds threshold |
| Spin-out | $B2 | Lateral velocity exceeds limit |
| Tire squeal / gear shift | $B4 | Grip loss or upshift at high speed |
| Object collision | $B8 | Entity-vs-entity proximity |

All written to SDRAM sound queue. 68K reads and plays.

### 9.5 Acceptance Criteria

- [~] Track boundary detection produces identical collision flags (+$55-$59) — 5C ref-verified; live compare deferred to 5F
- [~] Binary search resolves identical positions (compare +$30/+$34) — 5D ref-model 0 mismatch (60k cases); live 1000-frame compare deferred to 5F
- [~] Surface tracking EMA produces identical heights (+$5A/+$5C/+$5E/+$32) — 5D ref-model 0 mismatch (160k cases); live compare deferred to 5F
- [~] Object-to-object collision triggers correctly (sound $B8, speed averaging) — 5E ref-model 0 mismatch (object_collision 40k + zone_check 20k + position_separation 40k + proximity 20k×15); live compare deferred to 5F
- [ ] All 3 tracks work (Beginner, Medium, Expert — different tile tables)
- [ ] 3600-frame autoplay — no behavior changes

---

## 10. Phase 6: Pipeline Overlap

**Status: DEPRIORITIZED for racing (2026-06-17).** Racing-isolated profiling (§1.1b)
shows the 68K is NOT blocked on the Master SH2 during racing — the `sh2_send_cmd`
sync-wait is negligible and the 68K is 63% V-blank idle. Pipeline overlap removes a
barrier that is not the racing bottleneck. Retain as a future/non-racing option; it is
**not** the 60 FPS lever (Phase 7 is — see §11).
**Prerequisite: Phases 2-5 complete (all game logic on Master SH2)**

### 10.1 Goal

Master computes frame N+1 while Slave renders frame N. Double-buffered entity tables.

### 10.2 Double-Buffer Design

| Buffer | Entity Tables | Display Objects | Size |
|--------|--------------|----------------|------|
| **A** | $06008000-$0600B8FF | $0600B900-$0600BBFF | ~15KB |
| **B** | $0600F000-$060167FF | $06016800-$06016AFF | ~15KB |

Swap index stored at $0600BC10 (mailbox). Master writes to buffer[swap_index], Slave reads from buffer[1 - swap_index].

### 10.3 Synchronization Protocol

```
Frame N:
  Master: compute game logic → write buffer A
        → set swap_index = 0
        → write COMM2_HI = render_cmd (trigger Slave)
        → immediately begin frame N+1 (write buffer B)
  Slave:  read buffer A → render → write frame buffer
        → set COMM1_LO bit 0 ("done")
  68K:    V-INT polls COMM1_LO → frame swap

Frame N+1:
  Master: compute game logic → write buffer B
        → set swap_index = 1
        → write COMM2_HI = render_cmd
        → immediately begin frame N+2 (write buffer A)
  Slave:  read buffer B → render
  ...
```

### 10.4 SDRAM Bus Contention Strategy

| Time Slot | Master | Slave | Contention |
|-----------|--------|-------|-----------|
| T1: Slave Pipeline 1 | Writes entity tables (SDRAM) | On-chip SRAM (zero SDRAM) | **None** |
| T2: Slave Pipeline 2 | ROM table lookups (cached) | SDRAM reads | **Minimal** (Master on ROM, not SDRAM) |
| T3: Block copies | SDRAM → Frame Buffer | Idle (render complete) | **None** |

**Key insight:** Pipeline 1 (on-chip SRAM, 40% of Slave time) creates a natural window where Master can write SDRAM without contention.

### 10.5 Risks

| Risk | Severity | Mitigation |
|------|----------|-----------|
| Sound timing desync | High | Sound queue is timestamp-tagged. 68K plays sounds at correct V-INT, regardless of which frame generated them. |
| Scene transitions during double-buffer | High | Scene commands (pause, menu) flush both buffers and reset to single-buffer mode until new scene stabilizes. |
| Slave reads partially-written buffer | Critical | Master writes complete buffer, THEN triggers Slave. Slave never reads during Master write. Swap index is the atomic gate. |
| 68K controller input lag (1 frame) | Low | Already 1-frame lag in current architecture. No change. |

### 10.6 Acceptance Criteria

- [ ] Dual-buffer swap works correctly for 10,000 frames
- [ ] No torn rendering (Slave never reads partial buffer)
- [ ] Sound plays at correct timing (not early/late by 1 frame)
- [ ] Scene transitions (pause, menu, race end) work correctly
- [ ] Profiling shows Master and Slave executing in parallel (overlapping cycle ranges)
- [ ] FPS measurement shows improvement (target: 40→60 FPS display)

---

## 11. Phase 7: 60 FPS Game Logic

**Status: FINAL OBJECTIVE; NOT READY TO ACTIVATE.** The state-machine cadence remains the
architectural lever for true 60 Hz logic, but the June CPU budgets and cmd `$3F` attribution
are not a trusted current baseline. Before changing cadence, complete the validation and
ownership sequence: durable 1P control fixture → accepted cmd `$3E` mode 0 → mode 1 → AI staging → cmd
`$3F` shadow execution → renderer-consumed descriptor bridge → collision → output equivalence
→ authority/bypass. Re-profile only then. Framebuffer hashes must be paired with `$C87E`,
scene, hook, and COMM liveness checks; uniqueness alone is not acceptance evidence.

### 11.1 Goal

Run physics/AI/collision at 60 FPS instead of 20 FPS. True 60 FPS gameplay.

### 11.2 What Changes

All physics constants tuned for 20 FPS must be scaled by 1/3:

| Constant | Current (20 FPS) | Target (60 FPS) | Subsystem |
|----------|-----------------|-----------------|-----------|
| Speed deltas | per-frame values | ÷3 | Physics |
| Force integration | drag/friction per frame | ÷3 | Physics |
| Position integration | dx/dy per frame | ÷3 | Physics |
| AI timer | 120 frames | 360 frames | AI |
| Spawn timer | 120 frames | 360 frames | AI |
| Drift accumulator decay | 8/frame | ~3/frame | Physics |
| Boost timer increment | $738/frame | $270/frame | Physics |

### 11.3 Why This Failed Before (S-4)

S-4 attempted 30 FPS by skipping state 4 (scaling ×2). It failed because:
- Constants scattered across 20+ 68K modules — each fix broke something else
- No delta-time system — hard-coded frame assumptions everywhere
- Physics/collision/checkpoints/music all coupled to frame count
- "Fragile equilibrium" — each constant depends on others

**Why it might succeed now:**
- All game logic will be on SH2 in one codebase (not scattered across 20+ 68K files)
- Can implement proper delta-time (scale factor in one register, applied everywhere)
- Only attempted AFTER all logic is ported (Phase 7, not Phase 1)

### 11.4 Acceptance Criteria

- [ ] Physics feel identical at 60 FPS (speed, steering, drift match 20 FPS behavior scaled correctly)
- [ ] All 3 tracks playable with correct collision response
- [ ] AI behavior unchanged (just smoother)
- [ ] Lap times within 1% of 20 FPS lap times (same physics, more samples)
- [ ] No timer overflow or underflow from ×3 multiplication

---

## 12. Open Questions & Unknowns

These must be resolved before their respective phases. Add new questions as they arise.

| # | Question | Affects Phase | Status | Resolution |
|---|----------|--------------|--------|------------|
| Q-001 | Can DREQ FIFO target arbitrary SDRAM addresses ($06008000)? | Phase 1 | **RESOLVED (moot)** | DREQ FIFO destination is SH2 DMAC-controlled (DAR0 at $FFFFFF84). Entity tables don't need FIFO — Master SH2 copies from existing cmd $02 landing area. |
| Q-002 | What is the SH2 address for ROM data above $300000 (e.g., $0094C000 track tiles)? | Phase 5 | **RESOLVED: 68K CPU addresses** | All collision ROM refs are 68K CPU addresses ($0088xxxx+). Formula: `SH2_addr = 68K_addr + $01780000` (= 68K - $880000 + $02000000). Example (corrected 2026-06-17): $0094C000 → file offset **$CC000** → SH2 **$020CC000** (verified in ROM). Highest base ref: $009D0000 → file **$150000** → SH2 $02150000 (within 4MB, $3F0000). *Prior "$C4000/$020C4000/$0294C000" and "$00970000→$0EF000" figures were arithmetic errors — recompute, don't copy.* R-005 mitigated. |
| Q-003 | Can Master SH2 write to frame buffer ($04xxxxxx) when FM=1? | Phase 2 | **RESOLVED: YES, time-separated** | FM=1 gives both SH2s access. BUT current design prevents simultaneous access: Slave writes SDRAM during state 0, Master writes framebuffer during state 4. They never write the same memory at the same time. HW manual §4.2: both SH2s CAN write framebuffer concurrently (same bus), but must not write the same bank simultaneously. |
| Q-004 | Does SDRAM bus contention degrade Slave rendering measurably? | Phase 6 | **OPEN** | Profile Slave utilization before and after Master SDRAM writes. Compare render times. |
| Q-005 | Is the `entity_type_dispatch` RAM table at $C05C written only during scene init? | Phase 4 | **RESOLVED: init-only** | No MOVE/CLR writes to $C05C found in any per-frame code. Used as LEA base in 3 functions (entity_type_dispatch_tables, effect_countdown, hw_reg_init). Table is populated during scene init. Can be snapshot once to SDRAM. |
| Q-006 | How does camera_snapshot_wrapper (A-1 hook) interact with the new architecture? | Phase 2 | **RECLASSIFIED: HISTORICAL 2P HOOK** | A-1 belongs to the `state_disp_005020`/2P experiment, not the current normal-1P path. It is therefore N/A to the present 1P integration. Any future generalized camera interpolation needs a fresh per-dispatcher dependency analysis. |
| Q-007 | What happens to the 68K entity render pipeline variants (A/B/C/D, 2P)? | Phase 2 | **RESOLVED: phase 3 = Variant A only** | Variant A (player entity, all 9 physics steps) ports to SH2. Variants B/C/D (AI, replay) continue on 68K — they use reduced physics subsets. Variant selection driven by entity_type_dispatch_tables (indexes jump table at $C05C), stays on 68K. |
| Q-008 | Can we keep menus on 68K while racing logic is on SH2? | All | **PARTIALLY REFUTED (2026-07-06) — see correction banner** | Menu/racing separation claim stands (menu WRAM is separate, no conflicts). But **"`state_disp_005020` = active racing" is FALSE** — it is the 2-player dispatcher; interactive 1P racing uses `state_disp_004cb8` (`race_scene_init_004a32`). Its later 1P hook contains a cmd `$3F` call, but that call is currently disabled and has never fired during an accepted 1P run. Root-caused in `analysis/VR60_IMPLEMENTATION_AUDIT.md` + `VR60_DISPATCHER_ROUTING.md`. Each race dispatcher still needs explicit coverage; there is no single universal choke point. |
| Q-009 | What about the 2-player mode? | Phase 2+ | **RESOLVED: defer to post-Phase 3** | 2P uses Table 3 ($FF9F00) — single 256B entity record (NOT a 15-entry table). Same physics functions as 1P (A0-parameterized). Split-screen viewport at $FF6178. MOVEM block copy in `gfx_2_player_entity_frame_orch` assumes both entities updated on same CPU. Phase 3 = 1P racing only. Porting both players requires either: (A) both on SH2 (2× physics cost) or (B) explicit DMA synchronization barrier. R-008 updated. |
| Q-010 | Can 68K write to SDRAM at $88BC00 (adapter-mapped)? | Phase 1B | **RESOLVED: NO** | $880000-$8FFFFF = cartridge ROM (read-only). SDRAM is SH2-exclusive (HW manual §2, §3.1). Must use COMM relay: 68K writes COMM2-6, cmd $3F copies to SDRAM. |
| Q-011 | Where exactly does cmd $02 write entity visibility data in SDRAM? | Phase 1A | **RESOLVED: $0600C800** | Confirmed: 32 entries × 16 bytes = 512B at `$0600C800` (`$2600C800` cache-through). The old `$2200xxxx` aliases were cartridge ROM and cannot validate an SDRAM copy. |
| Q-012 | Can the cmd $3F trigger be inserted after mars_dma_xfer_vdp_fill? | Phase 1A | **RESOLVED ONLY FOR THE 2P PATH** | `vr60_comm_trigger` is inserted in `state4_epilogue`, reached by `state_disp_005020` (2P). It is built but does not validate normal 1P. The separate 1P cmd `$3F` call is currently disabled. |
| Q-013 | How many gears does the game use? | Phase 3 | **RESOLVED: 6** | Gear ratio ROM table at $88A1F0 has 6 entries: {171, 192, 205, 213, 219, 224}. 7th slot is code, not data. Gear index +$7A ranges 0-5. |
| Q-014 | Does the DIVU use constant or runtime divisors? | Phase 3 | **RESOLVED: table lookup** | DIVU in entity_speed_accel uses 6 known gear ratios from ROM table. Pre-computable reciprocals. DIVS D0,D1 in entity_force_integration IS runtime (max_speed from RAM). |
| Q-015 | What are the interleaved timer/guard dependencies between physics calls? | Phase 3 | **DESIGN RESOLVED; LIVE UNVERIFIED** | Two writers (`object_timer_expire_speed_param_reset`, `object_anim_timer_speed_clear+6`) made split ownership unsafe, so the SH2 design co-ports the five entity-modifying guard/timer routines in original order. Those ports are currently dormant because cmd `$3F` is disabled; the 68000 routines remain authoritative. |
| Q-016 | Is lateral_drift_velocity_B ($0099AA) structurally different from A ($00987E)? | Phase 3 | **RESOLVED: YES, fundamentally different** | B = 358B (not ~300B). Different math: force calc order (mul-then-div vs div-first), AI boost logic (speed > $C8 + AI flag → extra grip loss from +$0E), different grip clamp range ([$40,$FF] vs [$7F,∞]), 2× damping threshold (±$200 vs ±$100), viewport shimmer ($FF617A/$FF618E writes), 2× display scaling. 3 extra entity fields (+$04, +$0E, +$80), 1 extra global ($FFBFC0 AI control flag). Both variants must be ported independently. SH2 estimate: ~420B. |
| Q-017 | Does `--autoplay` actually reach real 1P GP racing (`state_disp_004cb8`, scene `$4CBC`)? | Phase 1 (1P wiring) | **RESOLVED: NO** | It settles in scene `$5586`; its `[racing]` label is only frame-count based. `VRD_LOAD_STATE` was added to reach GP, but the available `savestate_1p_gp_racing.bin` later stops advancing `$C87E` even with the VR60 hook bypassed, so it is useful for short traces—not a valid long-run baseline. |
| Q-018 | Does `game_frame_orch_013` state 8 recur during real 1P racing? | Phase 1 | **RESOLVED: YES, ABOUT 20 HZ** | Exact `VRD_CALLER_TRACE` found a regular one-hit-per-three-TV-frame cadence. The earlier zero-hit top-200 PC histogram was a false negative; the current hook location is valid. |
| Q-019 | Can we produce a deterministic 1P fixture that stays live for the full validation window? | All live integration | **RESOLVED FOR THE BASELINE BY VR60-011; CONTINUOUS SHAPE OPTIONAL** | Three complete, predeclared DRC lifecycles pass independently with 31,137 aggregate active frames and a 10,968-frame longest span. VR60-010 remains open only if a single continuous 18,360-frame shape is desired. |
| Q-020 | Are cmd `$3E` modes 0/1 correct over a trustworthy 1P run? | Phase 1 | **RESOLVED WITH SEPARATELY SCOPED PASSES** | Mode 0 passed 12 fresh lifecycle runs and is the ordinary default (`6f2768f2…2523900`). The isolated mode-1 CMDINT pair passed canonical Gate B, exact 64B/FULL/TE/re-arm transport, eight normal/seeded-name route captures, and safe-boundary VRES (`96365860…ff4470` / `39177456…34e9fd`). Mode 1 remains unpromoted; name evidence is seeded/replay-only, arbitrary busy-Slave VRES and real hardware are unproven, and mode 2/cmd `$3F` remain disabled. |
| Q-021 | Are AI transfer mode 2 and cmd `$3F` safe in 1P? | Phases 1, 3, 4 | **OPEN; NEITHER PROVEN SAFE NOR UNSAFE** | §21's freeze attribution is retracted by §22. Enable one stage at a time only after Q-019; keep the 68000 authoritative while cmd `$3F` first runs as observable shadow computation. |
| Q-022 | Which racing descriptor block should carry the SH2-authoritative car state? | Phase 5F | **PARTIALLY RESOLVED** | Static decode proves cmd `$02` reads C128/C178/C254, not C218. The C254 probe is built but dormant because current cmd `$3F` still calls the no-op patcher and the 1P trigger is disabled. Run reversible A/B/C probes after Q-019/Q-021. |
| Q-023 | Is cmd `$3F`'s COMM mailbox actually in SDRAM? | Phase 1B/3 | **RESOLVED: NO; FIX REQUIRED BEFORE ENABLE** | The current literal is `$2200BC00`, the cache-through cartridge-ROM alias, so its writes are ineffective. Change to `$2600BC00` (or native `$0600BC00` where coherent), then observe the data directly. |
| Q-024 | Why does the exact full replay skip `$0004` at frame 4536 while the normal-1P scene is still active? | All live integration | **RESOLVED — END-OF-FRAME SAMPLING ALIAS DURING TIMED FINISH** | It does not skip state 4. The exact trace records PC `$884CF2` writing `$0000 -> $0004` and PC `$884D0C` writing `$0004 -> $0008` in frame 4536. `$C050` had expired and `conditional_scroll_state_init` launched the intentional display/results sequence; state 12 PC `$8843D0` changes `$FF0002` at frame 5128. End-of-frame samples establish liveness, not intra-frame write chronology. |
| Q-025 | Can reviewed complete lifecycles satisfy the separate VR60-011 aggregate gate? | Baseline validation | **RESOLVED — PASS** | Big Forest, Bay Bridge, and Acropolis pass as three distinct normal-1P DRC lifecycles with 10,906/9,263/10,968 active frames, 31,137 aggregate frames, and a 10,968-frame longest span. Two fresh runs per fixture byte-match for frame/watch/caller/write chronology. The exact suite/result and source bytes are archived in `analysis/evidence/vr60-011-lifecycle-suite/`. |

---

## 13. Decision Log

Record every significant design decision here. Include date, what was decided, why, and what alternatives were rejected.

| Date | Decision | Rationale | Alternatives Rejected |
|------|----------|-----------|----------------------|
| 2026-03-17 | Use cmd $3F (not $40) for VR60 handler | Fits in existing 64-entry jump table. Zero dispatch loop changes. Same approach as B-004/B-005 (proven). | Cmd $40 requires dispatch loop trampoline (6-instruction patch, medium risk). |
| 2026-03-17 | SDRAM mailbox at $0600BC00 | Zero-filled in ROM, no SH2 code references, auto-zeroed by boot IDL copy. | $0600F000 (also free, but farther from entity data). |
| 2026-03-17 | Inline COMM cleanup in cmd $3F handler | Matches cmd22/cmd25 proven pattern. No func_084 call overhead. | JSR func_084 — adds 4 cycles, no safety benefit. |
| 2026-03-17 | Port entity projection BEFORE physics | Pure data transform, no side effects, easiest to verify. Immediate 10.52% benefit. | Port physics first — higher impact per function but harder to verify. |
| 2026-03-18 | Producer-consumer pipeline (not event-driven inversion) | Keep working 68K game logic, decouple from rendering via async. Lower risk than porting all game logic to SH2. | Event-driven inversion (Master SH2 as main loop) — higher reward but requires full game logic rewrite. |
| 2026-03-18 | Frame fence (lock-free, not explicit handshake) | Monotonic counter in COMM3, no blocking on either side. Resilient to timing jitter. | Explicit handshake — re-introduces blocking. Triple-buffer — 12KB WRAM cost for marginal benefit. |
| 2026-03-18 | Display objects only (not entity table transfer) | Entity tables stay in 68K WRAM. Only finished display objects transfer via existing DREQ (900B, already working). Eliminates the need for SDRAM entity table migration. | Full entity table transfer (4KB per frame via extended DREQ) — unnecessary if 68K keeps game logic. |
| 2026-03-18 | Fire-and-forget last COMM0 cmd only | The V-INT $54 gate provides natural synchronization. Making cmd $3F the last COMM0 command ensures state 0's DMA can't fire until cmd $3F completes. | Fire-and-forget all copies — COMM0 collision with re-DMA. |
| 2026-03-17 | Entity tables at $0600F20C (not $06008000) | $06008000 blocked by gradient strip B at $060086D4 (span_filler reads every polygon). $0600F20C-$06017FFF verified free (36.3 KB, zero SH2 code refs). | $06008000 (original plan, conflict with rendering data). |
| 2026-03-17 | Skip DREQ FIFO for entity tables | Master SH2 will own entity tables directly once game logic is ported. During migration, copy from existing cmd $02 landing area. FIFO destination is SH2 DMAC-controlled (not 68K), making redirection complex. | DREQ FIFO with DMAC reconfiguration (complex, unnecessary). |
| 2026-03-17 | Use git tag (not duplicate codebase) for baseline comparison | `vr60-phase0-baseline` tag enables `git diff` at any time. Simpler than maintaining parallel codebase. | Separate codebase clone (maintenance overhead, divergence risk). |
| 2026-03-24 | SDRAM globals block at $0600BF00 (64 bytes) | Between mailbox ($0600BC00) and entity data ($0600C000). 46 bytes used, 18 reserved. Close to existing SDRAM allocations. | $0600F200 (near entity mirror, but crossing into allocated range). |
| 2026-03-24 | SH2 software divide for runtime DIVS | entity_force_integration's DIVS D0,D1 has runtime divisor (max_speed threshold from RAM). No pre-computation possible. ~64 SH2 cycles vs 140 68K cycles for DIVS. | Reciprocal lookup table — would need 65K entries for full 16-bit range. |
| 2026-03-24 | Reciprocal multiply for constant DIVS | DIVS #$0190 and DIVS #$0497 are compile-time constants. Reciprocal at 2^24 precision gives exact results for all signed 16-bit inputs. Zero runtime overhead beyond MULS+shift. | SH2 software divide — correct but unnecessarily slow for known constants. |
| 2026-03-24 | entity_pos_update: replace JMPs with RTS for SH2 port | The 3 JMP exits into collision are the Phase 5 boundary. SH2 version returns after position update; 68K orchestrator calls collision separately. | Keep entity_pos_update on 68K — wastes the opportunity to run position math on SH2. |
| 2026-03-26 | GBR as entity base pointer (not R14-only) | GBR `MOV.W @(disp,GBR),R0` has 8-bit disp × 2 = 0-510 byte range. Entity is 256B — ALL fields reachable. Eliminates the R0+Rn indexed workaround for offsets > 30. Verified against SH2 ISA docs. | R14-only with indexed addressing — requires `MOV #offset,R0; EXTU.B R0,R0; MOV.W @(R0,R14),R0` for every field > offset 30 (3 instructions vs 1). |
| 2026-03-26 | Co-port timer/guard functions to SH2 (not keep on 68K) | Solves entity ownership: entity lives permanently in SDRAM, no per-frame WRAM→SDRAM staging. 5 functions, 284B SH2 code. Interleaved in cmd $3F matching 68K orchestrator order. | Keep on 68K with selective field staging — requires identifying exactly which bytes to copy per frame, complex, error-prone. COMM relay — 16 bytes too small for 20+ bytes of timer-modified fields. |
| 2026-03-26 | Dedicated cmd $3E for entity transfer (not DREQ extension) | Independent DMAC channel 0 configuration. Doesn't modify shared `mars_dma_xfer_vdp_fill`. 68K pushes 320B to FIFO, SH2 DMAC drains to $0600F20C. Clean separation of concerns. | Extend existing DREQ (modify shared function, affects all modes). |
| 2026-03-26 | Frame counter at entity+$F0 (not globals+$30) | globals+$30 is cleared every frame by `vr60_globals_stage`. Entity field +$F0 is unused (last documented field is +$E8) and persists across frames. | Store in globals — broken (wiped each frame). Store in WRAM — SH2 can't access. Separate SDRAM slot — adds complexity. |
| 2026-03-26 | Dual-path verification before SH2-only activation | Both 68K and SH2 run physics simultaneously. Game uses 68K results. SH2 results can be compared for correctness without risk. Only disable 68K physics after SH2 output is verified. | Direct switchover — high risk, no fallback if SH2 output is wrong. |
| 2026-07-13 | Full revert of the cmd $3E/$3F retry fix from `vr60_entity_transfer.asm`/`vr60_ai_entity_transfer.asm`/`vr60_globals_transfer.asm`/`vr60_comm_trigger.asm`, back to `HEAD` (original synchronous `wait_ack`) | The retry fix (force 0→1 transition on COMM0_HI, retry until ACK) was headlessly "verified working" but that verification never exercised real GP racing (Q-017) — it only ran against Free Run, which never calls these functions' 1P caller at all. When Matias tested real GP racing manually, the game hard-hung (black screen, 68K frozen, audio still running) — the unbounded retry loop spinning forever. These 4 functions are also called unconditionally by the always-active 2P path (`state4_epilogue`), so the unverified change broke already-working functionality, not just the dormant 1P hook. | Keep the "fixed" retry version live and just bound the loop — rejected: the underlying race-condition theory itself was never proven against the real failing context, so patching the symptom (unbounded loop) without re-deriving the actual fix risks another silent failure mode. Full revert to the known-shipped baseline is the only safe starting point. |
| 2026-07-13 | Added `VRD_LOAD_STATE=path` to `tools/libretro-profiling/profiling_frontend.c` (loads a real savestate via `retro_unserialize` before the frame loop starts) | `--autoplay` cannot reach real GP racing (Q-017), so headless verification of any 1P-specific fix needs a manually-captured savestate. Confirmed format-compatible with standalone PicoDrive's own savestates (both funnel through the same `PicoStateFP`/`pico_state_internal` serialization in `pico/state.c`; standalone only differs by an optional `.gz` wrapper). | Fixing the `--autoplay` input script instead — rejected for now (higher effort, still headless-only guesswork until visually confirmed); savestate loading is faster and lets Matias capture the exact scenario visually. |
| 2026-07-21 | Make `VR60_STATUS.md` and this dated status block authoritative; reclassify phase work as built, active, authoritative, and validated separately | Dispatcher routing and the invalid saved-state baseline showed that “present in ROM,” “executed,” and “proven” had been conflated. The current build must be described without inheriting obsolete phase completion claims. | Continue appending corrections without a canonical status — rejected because readers encountered stale conclusions before their retractions. |
| 2026-07-21 | Require a control fixture with continuing `$C87E` cycles before any new 1P offload validation | The existing GP savestate freezes independently of VR60 code and invalidates framebuffer-hash causality. | Treat the freeze as a cmd `$3F` or AI regression — rejected by the hook-bypass control. |
| 2026-07-25 | Accept and promote only cmd `$3E` mode 0 through a separate exact ACTIVE/STAGE-CONTROL gate | All 12 fresh runs retained VR60-011 chronology, exact 320-byte transport, raw `$00884D6A`, deterministic repeats, and the reviewed paired-framebuffer rule. The clean default is the entire validated ACTIVE image; mode 1/relay remain unreachable. | Promote the prior combined mode0/1 hook, infer causality from framebuffer CRC, normalize low/high PCs, or reuse duplicate/short captures. |
| 2026-07-27 | Block the current mode-1 validation ACK and preserve the accepted mode-0 default | Fresh review found that the 68000 polls `COMM1_LO` while Master SH2 writes the same byte; the hardware manual defines that overlap as undefined. Same-address readback is a write-buffer flush, not mutual exclusion. Static isolation/build success cannot substitute for protocol safety or missing runtime/reset evidence. | Promote the validation pair, treat the original game's ACK convention as proof of safety, or remove the ACK by assuming pre-arm FIFO retention that the checked documentation does not explicitly guarantee. |
| 2026-08-10 | Accept the isolated Q-020 CMDINT experiment only as diagnostic feasibility | Cold boot, normal writer, level-8 CMD, VRES plus stock reset CMD, and a seeded name-route writer passed with exact ROM/tool identities, fail-closed ISR sequencing, literal ownership, dual-SH2 liveness, and 15 archived artifacts. The default is unchanged and mode 1 remains disabled. | Promote the probe, call the seeded name route organic, infer real-hardware readiness from PicoDrive, reuse the clear-register zero-value check without confirming hardware semantics, or proceed to mode 2/cmd `$3F` before a fresh mode-1 pair passes Gate B and reset/lifecycle gates. |
| 2026-08-11 | Accept the fresh Q-020 mode-1 CMDINT pair strictly as an isolated validation-stage pass | Canonical Gate B, exact 64B/FULL/DMAC/TE/re-arm chronology, two normal and seeded-name captures per arm, safe-boundary VRES, unchanged mode-0 default, and a fail-closed composed archive passed fresh audit. The authentic name route installs replay and correctly has no transport. | Promote mode 1 into the ordinary default, clear the stock name-route bit, count busy-Slave VRES as passing, infer real-hardware or organic-name coverage, or combine the next mode-2 test with cmd `$3F`. |
| 2026-07-21 | Make the 1P control validator's acceptance policy immutable and prove the control ROM's exact isolation | A control must not run the code it isolates or contain unrelated changes. The validator enforces the canonical fixture blacklist, fixed scene/hook/threshold/window policy, and an exact comparison: the reference has live bytes `4EF90001C8B04E71`, the candidate has stock bytes `4EBA69764EBA691C`, and all bytes outside file `$4D62-$4D69` match. Offline analysis and diagnostic overrides always inject failure. | Trust filenames, inspect only the candidate hook bytes, accept user-relaxed thresholds/addresses, promote stale CSV, accept the active-hook ROM, or infer late liveness from a 50-hit trace — all can produce a false baseline. |
| 2026-07-21 | Build the 1P control pair from one conditional assembly source and verify it automatically | A raw-patched candidate or an unpreserved reference cannot prove isolation. `make control-rom` preserves the live build, assembles the stock two-JSR branch with `VR60_CONTROL_ROM`, and records the validator comparison plus both hashes. | Manually patch eight bytes after assembly, keep an unverified copy by filename, or maintain a second drifting source tree. |
| 2026-07-22 | Preserve the failed VR60-008 run and diagnose its first chronological signal before retrying or patching | Raw samples place the `$C87E` state-order discontinuity at frame 4536, before continuous COMM0 busy and the scene transition. Later hook/framebuffer/Slave stalls are additional findings whose causal relationship is unknown; changing thresholds or addressing them independently would destroy chronological evidence. | Retry unchanged without diagnosis, loosen the validator, infer chronology from finding-list order, address-shop for a patch, or treat every later finding as a separate defect. |
| 2026-07-22 | Retire the VR60-005/006 timed-race state/replay as a full-window control and create VR60-010 for fixture replacement | VR60-009 proves that the apparent state skip is a sampling alias and the later scene exit is the game's intentional timeout/results sequence. A control cannot accept post-race output or weaken scene invariance. The existing artifacts remain useful for bounded diagnostics. | Loosen the scene rule, accept post-race liveness, patch game code to suppress the finish, or change validator policy inside the diagnosis issue. |
| 2026-07-23 | Use a pinned, fail-closed RetroArch v2 replay converter only as the visual-input bridge for VR60-010 | The canonical frontend is headless, while a visual race needs manual control. A real 899-frame replay converted and re-recorded byte-identically; strict event-shape/EOF checks, ROM CRC32 verification, and replay/raw-state/ROM/CSV hashes prevent ambiguity from reaching the validator. The replay's embedded state is not acceptance evidence. | Add GUI/video behavior to the validator, accept arbitrary replay variants, loosen the CSV parser, or treat a successful conversion as gameplay liveness. |
| 2026-07-25 | Keep VR60-010's continuous gate unchanged and implement lifecycle aggregation as separate VR60-011 policy | Complete timed lifecycles can contribute legitimate active-racing coverage only when the terminal route is proven exactly and post-terminal frames contribute zero. Reviewed floors are 3 distinct lifecycles, 1,800 active frames each, one 3,960-frame span, and 18,000 aggregate active frames; 3,960 is 22×180 and below the measured 4,174-frame VR60-009 span after warmup. | Loosen `validate_1p_control.py`, average failed windows, count finish-display/results frames, accept a scene writer without the timer/display/lap exclusion signature, discover and bless terminal frames in the same acceptance run, or trust self-asserted summaries. |
| 2026-07-25 | Accept the v2 VR60-011 DRC lifecycle suite as the durable baseline and move next to cmd `$3E` mode 0 | Three independently passing lifecycles provide 31,137 aggregate active frames and deterministic exact chronology. Raw headers prove DRC=1, PC profiling absent, normal batching, a composed exact hook, and zero caller drops; exact `$C87E` cycles plus the V-INT `$000C->$0000` write prove fresh Master completion. | Continue treating interpreter-only `*_useful` counters as required DRC evidence, fail sampled COMM0 runs despite exact Master completion, count pre-race or post-terminal frames, or keep the validated baseline blocked on the optional continuous VR60-010 shape. |

---

## 14. Risk Registry

| ID | Risk | Severity | Phase | Status | Mitigation |
|----|------|----------|-------|--------|-----------|
| R-001 | DREQ FIFO cannot target $06008000 | Blocking | Phase 1 | **RESOLVED** | Moot — entity tables don't use FIFO. Master copies from cmd $02 landing area. |
| R-002 | SDRAM bus contention degrades Slave | High | Phase 6 | **OPEN** | Pipeline writes during Slave Pipeline 1 (on-chip SRAM period). Measure before/after. |
| R-003 | DIVU/DIVS reciprocal rounding mismatch | Medium | Phase 3 | **RESOLVED** | Gear reciprocal table verified exact for all 6 ratios (zero diff). DIVS #$0190 and #$0497 reciprocals verified at 2^24 precision. Software divide sh2_sdiv16 uses same shift-subtract algorithm as hardware. |
| R-004 | Entity field access slower on SDRAM (2-6 wait states vs 0) | Medium | Phase 1 | **OPEN** | SH2 clock is 3× faster, compensating for wait states. Profile to verify net effect. |
| R-005 | Track tile ROM addresses are 68K-relative (not file offsets) | Blocking | Phase 5 | **RESOLVED** | Confirmed: all collision ROM refs are 68K CPU addresses. SH2 conversion: `addr + $01780000`. Highest base ref `$009D0000` = file offset `$150000` = SH2 `$02150000` (within the 4MB ROM). Pointer tables at $742C/$745C contain mode-indexed segment-map/base-data pairs. |
| R-006 | Camera interpolation (A-1) conflicts with new architecture | High | Phase 2 | **DEFERRED / HISTORICAL** | A-1 is a 2P-path experiment and does not cover normal 1P. Re-evaluate camera ownership only after the 1P fixture and shadow integration are trustworthy. |
| R-007 | Scene transitions corrupt double-buffer state | High | Phase 6 | **OPEN** | Flush both buffers on mode change. Single-buffer fallback during transitions. |
| R-008 | 2-player mode has different entity/render paths | Medium | All | **CHARACTERIZED** | 2P uses same physics (A0-parameterized), Table 3 ($FF9F00, 1 entity), split-screen viewport. MOVEM block copy in `gfx_2_player_entity_frame_orch` assumes same-CPU update. Phase 3 = 1P only. 2P requires either both players on SH2 or explicit sync barrier. Defer to post-Phase 3. |
| R-009 | Sound timing drift when game logic runs ahead of display | Medium | Phase 6 | **OPEN** | Timestamp sound events in SDRAM queue. 68K plays at correct V-INT timing. |
| R-010 | Gradient strip B ($060086D4) invalidated original SDRAM address plan | Medium | Phase 1 | **RESOLVED** | All addresses moved to $0600F20C+. Always grep before allocating SDRAM. |
| R-011 | cmd $3F trigger in state 4 adds COMM0_HI blocking time | Low | Phase 1A | **HISTORICAL 2P PATH; LIVE UNVERIFIED** | The state-4 trigger belongs to `state_disp_005020`. Current 1P uses a separate state-8 hook whose cmd `$3F` call is disabled. Re-measure the intended path before reasoning about blocking time. |
| R-012 | 68K→SDRAM direct write at $88xxxx may be read-only ROM mapping | Medium | Phase 1B | **RESOLVED: confirmed ROM (read-only)** | $88xxxx = cartridge ROM per HW manual §3.1. COMM relay is the ONLY option. |
| R-013 | Physics port scope 50% larger than estimated (2,642B vs 1,760B) | Medium | Phase 3 | **IDENTIFIED** | 3 previously unlisted functions: drift_physics_and_camera_offset_calc (378B), suspension_steering_damping (124B), lateral_drift_B (~300B). Budget SH2 expansion space accordingly (~3,700B). |
| R-014 | Runtime DIVS in entity_force_integration — no reciprocal possible | Low | Phase 3 | **MITIGATED** | SH2 software signed divide (~64 cycles). Called once per entity per frame. Total overhead: 25 entities × 64 cycles = 1,600 cycles/frame. Negligible vs 383K cycle budget. |
| R-015 | 2 timer/guard functions write physics-input fields (+$40, +$06) | Low | Phase 3 | **DESIGN RESOLVED; LIVE UNVERIFIED** | All five entity-modifying timer/guard routines were co-ported in original order. The ports are dormant while cmd `$3F` is disabled, so this resolves the design dependency—not current runtime authority. |
| R-016 | entity_pos_update JMP→collision boundary creates split-CPU execution | Medium | Phase 3/5 | **OPEN** | Position update on SH2, collision on 68K. 68K must call collision after reading SH2-updated position from SDRAM. Adds ~1 frame latency to collision response unless pipelined. |
| R-017 | SH2 timer_expire_reset simplified for entity 0 only | Low | Phase 3B | **ACCEPTED** | Object type check chain ($C89C/$C8C8/object_id $69-$6F) skipped. For entity 0, object_id=$00 < $69 always reaches .set_speed. If called for other entities, would produce incorrect behavior. Safe: cmd $3F only processes entity 0. |
| R-018 | SH2 anim_timer_speed_clear lacks conditional_return_on_state_match fallthrough | Low | Phase 3B | **ACCEPTED** | 68K JMPs to a state-check function that either returns or falls through. SH2 always returns (RTS). The fallthrough path handles edge-case state transitions during animation timer expiry — not observed during normal player racing. Monitor during extended testing. |
| R-019 | Entity staging overwrites SH2 physics results | Critical | Phase 3B | **DESIGN RESOLVED; LIVE UNVERIFIED** | Initial-only entity staging plus co-ported writers is the intended ownership model. It has not been validated live; current 1P keeps WRAM/68000 authoritative and cmd `$3F` disabled. |
| R-020 | Unbounded retry loops on a COMM ACK can hard-hang the 68K if the underlying race theory is wrong | Critical | Phase 1 (1P wiring) | **RESOLVED (reverted)** | A retry fix for a suspected Master-SH2 poll-detection race (`.retrigger: ... beq.s .retrigger`, no attempt cap) was applied to `vr60_entity_transfer.asm` and 3 siblings, "verified" headlessly, but that verification never actually exercised the real GP-racing call path (Q-017). Real GP racing hard-hung (black screen, frozen 68K). Fully reverted to `HEAD`. If retried: bound every retry loop with a hard attempt cap (give up and skip the frame's SH2 offload rather than loop forever), and implement any new logic in 1P-exclusive copies of these functions — they are also called unconditionally by the always-active 2P path (`state4_epilogue`), so editing them for "1P" silently changes 2P/demo behavior too. |
| R-021 | `--autoplay` cannot reach real GP racing, and the available GP savestate is not a valid long-run control | Critical | Phase 1 (1P wiring) | **MITIGATED BY ACCEPTED VR60-011 BASELINE; VR60-010 OPTIONAL** | `VRD_LOAD_STATE` solves scene access. The validators block the old state by canonical SHA, and the source-built hook-bypass candidate remains isolated. VR60-009 proves the newer state/replay reaches a legitimate timed finish and is bounded-only. VR60-011 now supplies three accepted complete DRC lifecycles with 31,137 active frames. VR60-010 remains the optional stronger continuous-run shape, not a blocker for cmd `$3E` mode 0. See Q-017/Q-019/Q-024/Q-025. |
| R-022 | Historical status/profiling claims can be misread as current 1P behavior | High | All | **MITIGATED; audit continuously** | `VR60_STATUS.md` is canonical. Phase documents keep their evidence but must carry correction banners; tables must distinguish built, active, authoritative, and validated. |
| R-023 | A healthy short replay prefix can hide a deterministic later state/scene transition | Critical | Baseline validation | **MITIGATED BY COMPLETE VR60-011 LIFECYCLES; VR60-010 OPTIONAL** | The full run and exact trace exposed a deterministic timed finish hidden beyond the preflight. VR60-011 preserves complete hash-verified artifacts, predeclares the terminal/results boundary, and validates every active window plus the full finish signature. Never promote prefix health into durability. VR60-010 remains an optional continuous 18,360-frame proof. |
| R-024 | End-of-frame state samples can alias multiple legitimate writes within one emulated frame | High | Baseline validation | **MITIGATED IN LIFECYCLE V2; CONTINUOUS POLICY UNCHANGED** | Do not describe sampled transitions as exact write chronology. VR60-011 lifecycle v2 requires the complete version-3 writer trace and the exact ordered `$C87E` cycle in every window/tail, including the fresh `$000C->$0000` Master-completion witness. The separate VR60-010 continuous validator retains its original sampled-state policy. |
| R-025 | Lifecycle aggregation could inflate coverage with duplicate fixtures, bad windows, or post-finish frames | Critical | Baseline validation | **MITIGATED; ACCEPTED SUITE ARCHIVED** | Hash-pin exact ROM/tool/state/input/source/raw artifacts and the canonical `control_fixtures.json` policy; reject blacklisted or duplicate fixtures; require every lifecycle to pass independently; check aligned windows plus the final rolling window/tail; stop coverage at the predeclared tracer PC/source offset `$006C38` (`$00886C38` high mapping) `$C07C=$14` write; require the full PC/access/old/new timeout/results chain. The v2 DRC suite passed all rules on 3 distinct fixtures and is archived. |
| R-026 | Mode-0 one-shot state or DREQ/COMM assumptions could be reused unsafely for mode 1 | Critical | Q-020 mode 1 | **MITIGATED IN ISOLATED VALIDATION; DEFAULT UNCHANGED** | The accepted mode-1 pair uses two CMD edges and zero COMM0-COMM7 accesses, fail-closes setup on exact stock SPCs, owns completion through counts plus exact DREQ/DMAC identity, and proves exact 64B/FULL/TE/re-arm behavior across repeated captures. This does not authorize promotion or reuse of the protocol outside the hash-pinned pair. |
| R-027 | PicoDrive VRES can strand a busy Slave in unsupported sysreg accesses | High | Validation/reset coverage | **OPEN TOOLING LIMITATION; EXCLUDED FROM ACCEPTANCE** | Frame-1280 reset fails identically in mode-1 ACTIVE, CONTROL, and the accepted default when the Slave is at `$C00000B4`, then stalls at `$06000638`. The exact triad is hash-pinned as non-acceptance evidence. Only frame-1241 stock-safe VRES is validated; do not claim arbitrary-reset or real-hardware coverage. |

---

## 15. Measurement Protocol

### 15.1 Baseline Measurements (Before Any Changes)

**Historical recipe (not valid for normal 1P):**

```bash
# Frame-level profiling (1800 frames, 30 seconds)
cd tools/libretro-profiling
./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay

# PC-level hotspot profiling (2400 frames)
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=baseline_vr60.csv \
  ./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay
python3 analyze_pc_profile.py baseline_vr60.csv
```

`--autoplay` reaches Free Run/TT (`$5586`), not normal 1P GP (`$4CBC`). For a new
decision-grade baseline, first reproduce the reviewed pair with `make control-rom`, then run
`tools/libretro-profiling/validate_1p_control.py` with a fresh state and replay using
`build/vr60_control_bypass.32x` against `build/vr60_live_reference.32x`. The tracked manifest
records their hashes and proves byte equality outside the eight-byte hook delta. The validator
must pass all 180-frame windows across at least 18,000 frames. Its
end-of-frame COMM watches establish
non-stuck lanes only; direct `$3E`/`$3F` command execution remains a separate later-stage sentinel
requirement.

**Record:**
- 68K cycles/frame (total, active, STOP)
- Master SH2 cycles/frame (total, active, idle)
- Slave SH2 cycles/frame (total, active, idle)
- sh2_send_cmd COMM0_HI wait cycles
- Display FPS (frame swap count / elapsed frames)

### 15.2 Per-Phase Measurements

After each phase:
1. Run same 1800-frame + 2400-frame profiles
2. Compare against baseline
3. Record delta for each metric
4. If Slave utilization increased >2%, investigate SDRAM contention
5. If any CPU exceeds 90%, investigate bottleneck before proceeding

### 15.3 Correctness Verification

**Byte-comparison protocol for ported functions:**

1. Run 68K version, dump entity table fields to diagnostic SDRAM block after processing
2. Run SH2 version, dump same fields to adjacent SDRAM block
3. Compare blocks. If any byte differs, stop and investigate.
4. Run for 100 frames minimum before declaring correctness.

**Generic autoplay smoke test (Free Run/TT, not 1P GP acceptance):**

```bash
./profiling_frontend ../../build/vr_rebuild.32x 3600 --autoplay
# Must complete without crashes or hangs
# Check only the modes actually reached; confirm scene values in the log
```

---

## 16. Lessons Learned

Record discoveries, gotchas, and insights as the project progresses. These help future phases avoid repeating mistakes.

| Date | Phase | Lesson | Impact |
|------|-------|--------|--------|
| (Pre-VR60) | B-003 | SH2 CANNOT access 68K Work RAM at ANY address. Three failed attempts before reading HW manual. | Entity tables MUST be in SDRAM (H-5). |
| (Pre-VR60) | B-005 | COMM0_HI is the game's frame synchronization barrier. Removing it causes display corruption. | Frame sync via COMM1_LO bit 0 is fundamental. Cannot eliminate without replacement barrier. |
| (Pre-VR60) | B-006 | Game command namespace and COMM7 signal namespace must NEVER overlap. Writing game cmd $27 to COMM7 triggers Slave crash. | COMM7 is reserved for Slave doorbell. New architecture must use COMM0 for Master triggers, COMM2 for Slave triggers. |
| (Pre-VR60) | S-1 | Entity descriptors at $0600C344 are unused during racing. Huffman renderer uses different data at $0600C800. | LOD culling at $0600C344 is a dead end. |
| (Pre-VR60) | S-4 | Physics constant scaling (20→30 FPS) created "fragile equilibrium" across 20+ files. | Only attempt frame-rate scaling AFTER all logic is in one codebase on SH2 (Phase 7, not Phase 1). |
| (Pre-VR60) | B-016 | Small functions called frequently cannot justify COMM overhead. angle_normalize (8×/frame, ~1,500 cycles) became 23% SLOWER under COMM dispatch. | Rule: computation_time >> handshake_overhead × call_count. Never COMM-offload small functions. The new architecture eliminates COMM for data entirely. |
| 2026-03-17 | Phase 0 | 16 unused jump table slots ($30-$3F) available. No dispatch loop modification needed for new commands. | Use existing slots for all new Master SH2 commands. |
| 2026-03-17 | Phase 1 planning | **Always grep SDRAM addresses before allocating.** Gradient strip B at $060086D4 was invisible until scanning all SH2 code. | All future SDRAM allocations must be verified with grep across disasm/. |
| 2026-03-17 | Phase 1 planning | **DREQ FIFO destination is SH2-controlled (DMAC DAR0).** 68K can only write data to the FIFO register — it cannot choose where data lands. | Don't plan around 68K-controlled FIFO destinations. Either reconfigure DMAC or bypass FIFO. |
| 2026-03-17 | Phase 1 planning | **Entity tables don't need FIFO transfer.** Master SH2 will own them directly once game logic is ported. During migration, read from existing cmd $02 DMA area. | Simplifies Phases 1-2: no DREQ reconfiguration, no 68K FIFO streaming code. |
| 2026-03-17 | Phase 1B (Q-010) | **68K CANNOT write SDRAM at any address.** $880000-$8FFFFF = cartridge ROM (read-only, HW manual §2 + §3.1). SDRAM is SH2-exclusive. The only 68K→SH2 shared memory is COMM (16B) + Frame Buffer (FM-controlled). | All 68K→SH2 data must go through COMM registers. For bulk data, the DREQ FIFO is the only mechanism (68K writes FIFO, SH2 DMAC drains to SDRAM). For small params (<10 bytes), COMM relay is simplest. |
| 2026-03-17 | Phase 2A | **Only 2 sh2_send_cmd calls per race frame, NOT 14.** Both in state4_epilogue, both with CONSTANT params. sh2_cmd_27 = 0 calls during racing (21×/frame was menus/attract). camera_interpolation_60fps.asm is untracked and not in the build. | The "14×" was stale. Corrected all roadmap references. |
| 2026-03-17 | Phase 2A | **Block copy consolidation saves ~0%, not ~10%.** The 10.52% sh2_send_cmd hotspot is SH2 COPY EXECUTION TIME (waiting for 288×48+288×24 byte copies to complete), not handshake overhead. Consolidating into cmd $3F is +33% SLOWER because it removes interleaving. | Never assume profiling hotspots are "overhead" — they may be fundamental execution waits. The only fix is pipeline overlap (Phase 6). |
| 2026-03-17 | Phase 2A | **COMM0 contention prevents async copies.** mars_dma_xfer_vdp_fill and cmd $3F both use COMM0. They cannot overlap. This means the 68K must wait for cmd $3F completion before re-DMA. | Any architecture with multiple COMM0 users must serialize them. Future design should minimize COMM0 usage. |
| 2026-03-17 | Phase 2A | **Always re-verify profiling numbers before planning optimizations.** The "14× sh2_send_cmd" and "21× sh2_cmd_27" figures were from old profiling or non-racing modes. Fresh profiling with the current build is essential. | Re-profile after every phase before planning the next one. |
| 2026-03-18 | Phase 2B | **The V-INT $54 handler is the natural async synchronization gate.** It stalls the state machine at state 8 until COMM1_LO bit 0 is set. This means fire-and-forget is safe: the gate prevents state 0's DREQ DMA from firing while cmd $3F is still running. No new synchronization needed. | The existing architecture already has the primitive we need. We just needed 7 research investigations to see it. |
| 2026-03-18 — **RECLASSIFIED 2026-07-21** | Phase 2B | `camera_avg_and_redma` produced no visible change in the historical 2P experiment, but the intended dispatcher/consumer path was not proved. “The SH2 does not re-render” was an unsupported causal leap. | Preserve the observation only. Any future interpolation test must trace the live DREQ consumer, render trigger, descriptor changes, and framebuffer liveness. |
| 2026-03-18 | Phase 2B | **45+ sh2_send_cmd call sites exist across ALL game modes.** Not just racing. Menus have 1-7 per frame, HUD has per-digit calls, name entry has 10+. Async only targets racing state4_epilogue (the 2 largest calls). All other modes stay synchronous. | Never assume a "global" change — always map all call sites first. |
| 2026-03-18 | Phase 2B | **4 mode transition hazards found but all protected by V-INT gate.** mars_dma_xfer_vdp_fill has no COMM0 idle check, but can't fire while cmd $3F runs (state stalls at 8). Handler replacement is deferred to next frame. C8A8 reset only happens during menu transitions (not racing). | The synchronous model's implicit barriers protect the async model too. |
| 2026-03-24 | Phase 3 research | **Physics pipeline has 13 functions, not 9.** Three were missing from the roadmap: `drift_physics_and_camera_offset_calc` (378B, contains DIVS #$0497), `suspension_steering_damping` (124B, jump table dispatches lateral_drift variants), and `lateral_drift_velocity_B` (~300B, AI variant). Total: 2,642B 68K → ~3,700B SH2. | Always trace the orchestrator call-by-call before planning ports. The roadmap's function list was assembled from documentation, not from reading the actual orchestrator source. |
| 2026-03-24 | Phase 3 research | **Orchestrator uses +offset entry points** (`steering+6`, `force_integration+18`) to skip initialization preambles. The SH2 port must handle these entry semantics — either by implementing the same skip or by restructuring the SH2 functions. | When porting, read the CALL SITE (orchestrator), not just the function itself. Entry offsets change the effective interface. |
| 2026-03-24 | Phase 3 research | **`drift_physics_and_camera_offset_calc` is NOT `lateral_drift_velocity`.** The orchestrator calls drift_physics first (camera follow + heading drift), then suspension_steering_damping (which dispatches to lateral_drift via jump table). Two separate functions with different purposes. | Function names in the roadmap were assumed from PHYSICS_SYSTEM_ARCHITECTURE.md descriptions, not verified against actual call sites. Always read the orchestrator. |
| 2026-03-24 | Phase 3 research | **Gear ratio table has 6 entries, not 7.** Values: {171, 192, 205, 213, 219, 224} at ROM $88A1F0. The 7th position contains code (MOVE.W instruction), not data. 68K→SH2 ROM offset mapping: subtract $880000 from 68K absolute address to get file offset, then add $02000000 for SH2. | Always read ROM data bytes directly instead of assuming table sizes from documentation or function analysis. |
| 2026-03-24 | Phase 3 research | **DIVS #103 (speed_interpolation) is NOT in the physics pipeline.** It's a separate subsystem. Only 4 divisions exist in the actual pipeline: DIVU gear_table (6 constants), DIVS D0 (runtime), DIVS #$0190, DIVS #$0497. The "DIVS #103" claim was from a stale roadmap entry that listed speed_interpolation as a physics function. | Always verify function membership by reading the orchestrator, not by searching for "physics" in filenames. |
| 2026-03-24 | Phase 3 research | **Timer/guard functions between physics calls: 3 safe, 2 write physics inputs.** object_timer_expire_speed_param_reset writes +$40 (heading), object_anim_timer_speed_clear writes +$06 (speed). Both run BEFORE physics in orchestrator call order. No co-porting needed — keep on 68K, natural ordering ensures correct values reach SH2 physics. | When analyzing function dependencies for CPU migration, check WRITE→READ ordering, not just which fields are accessed. Same-CPU ordering is free synchronization. |
| 2026-03-24 | Phase 3 research | **lateral_drift_velocity_B is structurally different from A — NOT a subset.** Different math (mul-then-div vs div-first), different grip range ([$40,$FF] vs [$7F,∞]), AI boost logic (speed-gated), viewport shimmer writes, 2× damping, 2× display scaling. 358B (not ~300B). Must port independently. | Never assume "variant" means "minor parameter change." Read both implementations fully before estimating scope. |
| 2026-03-24 | Phase 3 research | **$C05C entity_type_dispatch table is init-only.** No per-frame writes found. Can be snapshot once to SDRAM during scene init. Confirms Phase 4 (AI port) can use a static copy. | Verified by grep: no MOVE/CLR writes to $C05C in any per-frame code path. |
| 2026-03-24 | Q-002 | **All collision ROM addresses are 68K CPU addresses, not file offsets.** Conversion: `SH2_addr = 68K_addr + $01780000`. Highest base reference: `$009D0000` → file offset `$150000` → SH2 `$02150000` (within 4MB). Track pointer tables at $742C/$745C contain mode-indexed segment-map/base-data address pairs. | R-005 resolved. No ROM boundary issues. Phase 5 collision port can proceed with simple address arithmetic. |
| 2026-03-24 | Q-008 — **SUPERSEDED 2026-07-06** | The historical decision called `state_disp_005020` active 1P racing and placed cmd `$3F` there. It is actually the 2P split-screen dispatcher. | Current 1P uses `state_disp_004cb8`; its separate hook reaches only accepted cmd `$3E` mode 0. Do not reuse the old mode-gate conclusion. |
| 2026-03-24 | Q-009 | **2P uses identical physics functions as 1P (A0-parameterized).** Table 3 ($FF9F00) is a single 256B entity, not a 15-entity table. `gfx_2_player_entity_frame_orch` MOVEM block copy assumes both entities updated on same CPU — splitting P1/P2 across CPUs creates race conditions in display DMA. | Phase 3 = 1P only. 2P deferred. When porting 2P, either both players on SH2 or add explicit sync barrier. |
| 2026-03-26 | Phase 3B | **GBR as entity base: 510-byte displacement covers the entire 256B entity record.** `MOV.W @(disp,GBR),R0` uses 8-bit disp × 2 = 0-510 byte range. Every entity field is reachable in a single instruction. The constraint: only R0 can be source/destination for GBR access. Work around by `MOV R0,Rn` after load or `MOV Rn,R0` before store. | SH2 ISA docs §6 (displacement modes). The Rn-displacement form (`MOV.W @(disp,Rn),R0`) has only 4-bit disp × 2 = 0-30 byte range — grossly insufficient for entity fields. GBR is the correct choice. |
| 2026-03-26 | Phase 3B | **SH2 CMP/PL = strictly > 0, not >= 0.** "Compare PLus" sets T=1 when Rn > 0 (signed). This matches 68K TST+BLE exactly (BLE branches when value ≤ 0, fall-through when > 0). A code review agent flagged this as a bug, but verification against the ISA docs confirmed correctness. | Always verify SH2 instruction semantics against the primary source (sh1-sh2-cpu-core-architecture.md), not agent reasoning. Subtle instruction names like "PL" (plus) can mislead — it means "positive", not "plus-or-zero". |
| 2026-03-26 | Phase 3B | **Entity ownership problem: staging overwrites SH2 physics results.** Full WRAM→SDRAM entity copy every frame destroys accumulated SH2 values (speed, position, grip). Solution: co-port timer/guard functions to SH2 so entity lives permanently in SDRAM. Initial-frame staging seeds the entity; subsequent frames persist it. | The problem was not obvious during Phase 3A design because dual-path mode masks it (68K keeps WRAM correct, so staging sends valid data). Only becomes visible when 68K physics is bypassed. |
| 2026-03-26 | Phase 3B | **Grip clamp logic must cap the RATIO, not the GRIP.** 68K: `DIVS D0,D1; SUB.W D1,grip; CMPI.W #$80,D1; BLE .done; MOVE.W #$80,grip`. The CMPI checks D1 (ratio), not the subtracted grip. SH2 translation initially checked grip after subtraction — produces different results when ratio < 128. | When translating multi-step arithmetic with conditional overrides, trace which REGISTER each instruction operates on. The 68K's register-based flow (D0 vs D1 vs memory) is easy to conflate in SH2 where R0 is heavily reused. |
| 2026-03-26 | Phase 3B | **Persistent data cannot live in the globals staging block.** `vr60_globals_stage` clears +$30 to +$3F every frame. The anim_timer frame counter was stored at globals+$30 and got wiped. Moved to entity+$F0 (unused field, within GBR range). | Before storing persistent data in any SDRAM region, verify what else writes to that region. The globals staging function is a silent data destroyer for any slot it touches. |
| 2026-03-26 | Phase 3B | **SH2 gas assembler GBR word displacement expects BYTE OFFSETS, divides by 2 internally.** Writing `@(53,gbr)` means byte offset 53, which is ODD → "misaligned offset" error. Must use actual entity byte offsets: `@(0x6A,gbr)` for field +$6A (106). Gas computes disp = 106/2 = 53 for the encoding. | The gas manual is unclear on this. Test: `@(4,gbr)` works because 4/2 = 2 (integer). `@(5,gbr)` would fail for word access. Always use hex entity offsets directly. |
| 2026-03-26 | Phase 3B | **SH2 indexed store `MOV.W Rm,@(R0,Rn)` requires R0 as INDEX, not as VALUE.** When storing a value to an indexed address, the value must be in Rm (any register), and the offset MUST be in R0. If R0 holds the value to store, swap: put value in R1, offset in R0, then `MOV.W R1,@(R0,R13)`. | This constraint applies to ALL indexed addressing modes on SH2, both loads and stores. R0 is always the index register in `@(R0,Rn)` forms. Plan register allocation accordingly. |
| 2026-06-17 | Profiling | **Always scene-isolate racing data (`VRD_SCENE=0x4CBC`).** Mixed 3D-gated profiling lumps car-select/attract/name-entry (heavy `sh2_send_cmd` callers) with racing and skews the budget. The "~13% `sh2_send_cmd` sync-wait" was a car-select artifact; in racing it's negligible. | A wrong conclusion (attack the sync barrier → Phase 6) was drawn from mixed data and only reversed after scene-isolation. Isolate the actual scene before concluding. |
| 2026-06-17 | Profiling | **Racing 68K is 63% V-blank idle — not compute-bound, not sync-bound.** The 20 FPS cap is the state-machine structure (1 state/V-INT). 60 FPS = run logic per-TV-frame (Phase 7), not pipeline overlap (Phase 6) or a big compute offload. | Redirected the 60 FPS plan onto Phase 7 with a measured ~10% offload, not a guessed 25-30%. |
| 2026-06-17 | Profiling | **`render_state_patcher` is a no-op.** It writes `$0600CA00`/`$0600CCA0` — addresses the 3D engine never reads (it reads context-relative from `$06003xxx`/`$06004xxx`). Target map came from stale docs (address-shopping). Empirically: 0% change in Slave render load. | Verify a consumer actually READS an address (watch/dump tools) before building on it. |
| 2026-06-17 | Profiling | **Profiler accuracy requires: idle/useful split (not raw util), no top-N truncation, SH2 interpreter (DRC bypasses PC sampling), distinguishing 68K compute from sync-wait, and scene-isolation.** "68K 100% / Slave 78%" frame-level util is mostly the V-blank STOP + mixed scenes — misleading. | The rebuilt VRD tooling (Tier 1+2) gives the real per-CPU compute budget. See `tools/libretro-profiling/VRD_PROFILING.md`. |
| 2026-06-18 | Phase 5D | **Wiring collision live is gated by the render_state_patcher no-op, not just the 5F authoritative-copy question.** `render_state_patch` does read the SDRAM entity +$30/$34, so it *looks* like the SH2 car drives the camera — but the patcher writes arrays the 3D engine never reads (no-op, 2026-06-17). So the SH2 entity is invisible and 5D wiring would change an unread copy: zero benefit, nonzero A-1 risk. Kept 5D additive/deferred like 5C. | Before wiring a "behavioral" SH2 write live, trace the full consumer chain to a *rendered* output — a reader existing isn't enough if that reader is itself dead. |
| 2026-06-18 | Phase 5D | **SH2 displacement-addressing limits bite the obvious transliteration.** `mov.w @(disp,Rn),Rm` needs Rm=R0 (so COLL_POS x/y reads went through indexed `mov #slot,r0; mov.w @(r0,r2)`); `and/tst #imm` are R0-only (BTST #0 became `mov #1,r2; and r2,r1; tst`); mov.w disp max is 30 so +$32 needs indexing. GAS also auto-relaxed an out-of-range `bt` into `bf 1f; bra; 1:` (benign). | Don't hand-count SH2 addressing modes from the 68K shape — assemble early and let GAS surface the R0-only / disp-range constraints. |
| 2026-06-18 | Phase 5E | **The SDRAM entity-iteration convention is just "reuse the AI staging map".** WRAM entity i (1..15) ↔ SDRAM $06010000+(i-1)*$100 because vr60_ai_entity_stage DREQs the WRAM $FF9100 block intact to $06010000; entity-15 ($FF9F00) = $06010E00. Player = $0600F20C. 5E iterates with the same base/stride/count the cmd $3F AI physics loop already uses. | When porting entity-table code, don't invent an addressing scheme — find the existing staging copy and mirror its base+stride; the mapping is already fixed by the DREQ. |
| 2026-06-18 | Phase 5E | **zone_check's "$C268 angle lookup table" is a MISLABEL — it is the SAME road-segment base as 5B/5C's track_seg_base.** One WRAM longword ($FFC268, set once at scene_camera_init.asm:84), read by both extract_033 and zone_check. So 5E reuses 5C's pre-translated globals +$3A; no new relocation/translation. | Verify a pointer's identity by its single write site + content, not by a comment's label — module comments can be wrong. |
| 2026-06-18 | Phase 5E | **`directional_collision_probe` ($7AD6) is dead — excluded from the port.** grep over disasm/ finds no jsr/bsr/jump-table/data ref; the `dc.w $7AD6` hits are coincidental opcode words at file offset $xx7AD6 in 47 data-region mirror copies. SH2 has no SHLD (SH3+), so `bset Dn,mem` ported as a 1<<zone shift loop. | Confirm "dead code" by checking refs are real call/jump-table targets, not value coincidences at a matching low offset across mirrored data banks. |
| 2026-07-13 | Phase 1 (1P wiring) | **A passing headless test is not evidence the tested code path executed at all.** `profiling_frontend`'s `[racing]` progress label is a naive frame-count heuristic (`frame < 1200 ? "menus" : "racing"`), not derived from real game state. `--autoplay` actually parks the game in Free Run (`$5586`) and never reaches GP (`$4CBC`) — confirmed by watching `$FF0004` directly, not by trusting the label. Every "verified working" headless result for the 1P hook this session was measured against Free Run, which never calls the hooked function. | Always confirm the scene/state word directly for any scenario-specific headless test; never trust a frame-count-based label or an assumption about what an autoplay script reaches. |
| 2026-07-13 | Phase 1 (1P wiring) | **Editing a function shared by a working caller and an experimental caller risks breaking the working one.** `vr60_entity_transfer.asm` and 3 siblings are called both by the untested 1P hook AND by the always-active, already-working `state4_epilogue` (2P/demo path). A retry-loop "fix" scoped mentally to "fix 1P" was actually a live change to 2P's behavior, and hard-hung the 68K in real GP racing (unbounded retry, no ACK ever arriving in that real context). Fully reverted to `HEAD`. | Before changing a shared function for one caller's problem, check every caller. If a fix is genuinely caller-specific, implement it as a caller-specific copy rather than editing the shared function. |
| 2026-07-13 | Tooling | **`VRD_LOAD_STATE=path` added to `profiling_frontend.c`** — loads a real savestate (`retro_unserialize`) before the frame loop, letting headless tests target scenes `--autoplay` can't reach. Confirmed compatible with standalone PicoDrive's own savestate files (same underlying `pico/state.c` serialization; standalone only adds an optional `.gz` wrapper). | Use this for any future 1P-specific (or other autoplay-unreachable) headless verification — capture the scenario once manually, then iterate headlessly against the saved state. |
| 2026-07-13 | Phase 1 (1P wiring), later same session — **RETRACTED** | A top-200 PC histogram appeared to show state-8 Path A was dead. Exact `VRD_CALLER_TRACE` subsequently proved it recurs once per about three TV frames (20 Hz). | Never infer non-execution from a truncated ranking. Use exact address/caller counters; `game_frame_orch_013` remains the valid 1P hook. |
| 2026-07-13 | Tooling | **`VRD_HOLD_INPUT=mask` added to `profiling_frontend.c`** — holds a joypad bitmask from frame 0, independent of `--autoplay`'s menu-navigation timing logic (which assumes frame 0 = boot, not frame 0 = savestate resume). Used to rule out "does reaching this code path require player input" as a hypothesis. | Use for any headless test resuming from a savestate where sustained input (e.g. holding accelerate) needs to start immediately, not 1200 frames in. |
| 2026-07-13 | Profiling methodology | **The PC histogram CSV has a `WRAM_CALLER` category (JSR return addresses from self-modified WRAM code) separate from the plain `68K` category** — filtering on `$1=="68K"` alone silently discards it, and its addresses are return-addresses-after-a-call, not necessarily inside the function you think they are (verify against the actual source, e.g. Path B vs Path A confusion this session). | Always `cut -d',' -f1 file.csv \| sort -u` to see every category present before drawing conclusions from a PC histogram. |
| 2026-07-21 | Control methodology | **Plausible stock bytes at the hook are not sufficient proof of an isolated control ROM.** A candidate could contain unrelated changes, while configurable thresholds or offline CSV analysis could still manufacture an apparent PASS. | Preserve the live branch ROM, require exact equality outside the reviewed hook delta, record both hashes, keep acceptance policy immutable, and make every offline/diagnostic path fail closed. |
| 2026-07-21 | Tooling | **The archived PDCORE was a stub test harness, not a PicoDrive debugger.** `pd_load_rom()` returns `Not implemented`; its passing tests never execute the real dual-SH2 game. | Keep it archived. Add debugger capabilities incrementally to the canonical libretro/PicoDrive path and close each slice with a real-ROM command script. |
| 2026-07-21 | Tooling | **Debugger input is now resolved once per emulated frame and can be captured exactly.** The 600-frame acceptance fixture replays and re-records byte-for-byte; replay exhaustion cannot silently fall through to another input source. | Use `joypad` plus explicit `record start`/`record stop` for new controller captures. Keep each capture complete and feed the resulting `frame,mask` file directly to `VRD_INPUT_SCRIPT`. |
| 2026-07-21 | Control methodology | **The source-built control pair is exact and reproducible.** vasm emits either the live eight-byte jump or the original equal-size two-JSR sequence; the reviewed policy found zero differences elsewhere and recorded both hashes. | Use `make control-rom` and the tracked manifest. Never raw-patch the ROM or compare against an unpreserved reference. |
| 2026-07-22 | Control methodology | **A bounded preflight establishes only early liveness.** The exact replay remained healthy through frame 2159, but the full run later reached its deterministic timed finish. The apparent frame-4536 state skip was subsequently resolved as two writes in one sampled frame. | Preserve full-run artifacts and diagnose the earliest observation. Do not promote a prefix to durable control or fix later findings independently. |
| 2026-07-22 | Profiling methodology | **An end-of-frame sample is not an intra-frame write trace.** At frame 4536, `$C87E` was sampled as `$0008` after being `$0000` on the prior frame, but exact PCs `$884CF2` and `$884D0C` wrote `$0004` and then `$0008` during that frame. | Use sampled state for window liveness and the exact writer tracer for chronology. If acceptance needs a sampling-safe rule, change it in a separate reviewed issue without weakening fail-closed policy. |
| 2026-07-22 | Emulator instrumentation | **Single-instruction execution batches perturb this timing-sensitive fixture.** The rejected tracer shifted the scene transition to frame 4981. A nullable pre-opcode-fetch FAME callback preserved normal batching and byte-matched the trace-disabled 5,160-frame control. | Instrument instruction boundaries inside the existing execution loop; never treat a timing-shifted diagnostic run as acceptance evidence. |
| 2026-07-22 | Fixture methodology | **Deterministic input can deterministically finish the race.** The VR60-005/006 artifacts are reproducible and healthy over a prefix, yet `$C050` expires and the display controller deliberately enters results at frame 5128. | Keep the fixture for bounded diagnostics; VR60-010 must capture enough race time/input to remain in `$00884CBC` for every full-control frame. |
| 2026-07-23 | Fixture methodology | **Capture time is part of fixture eligibility.** A visually correct normal-1P state was still unusable because it was saved 32 seconds into Big Forest with only `$0035` on the timer; its input replay left the scene at frame 3984. | Inspect the saved thumbnail, scene pointer, and timer immediately. Save at the first live race frame, qualify a bounded exact replay, and only then record the full horizon. |
| 2026-07-23 | Tooling | **RetroArch v2 visual replays can be bridged without modifying the canonical frontend or validator.** The strict converter's 899-row smoke replay re-recorded byte-for-byte through `VRD_INPUT_SCRIPT`. | Keep the converter pinned to the reviewed RetroArch source identity, reject unrecognized events/checkpoints/trailing data or a wrong ROM CRC32, and preserve replay/raw-state/ROM/CSV hashes in its manifest. |
| 2026-07-25 | Control methodology | **Aggregate lifecycle coverage is not equivalent to one continuous run.** A legitimate finish can bound a useful active epoch, but only pre-terminal frames count, every lifecycle/window/tail must pass alone, duplicate provenance must not inflate coverage, and both per-lifecycle and longest-contiguous floors must remain visible beside the aggregate. | Use the separate VR60-011 manifest/capture/validator. Keep VR60-010 intact, predeclare both terminal frames from prior diagnostics, and require the exact `$C050`/lap-flag/`$C07C`/scene-writer signature before accepting a lifecycle boundary. |
| 2026-07-25 | DRC acceptance instrumentation | **Execution mode is part of raw evidence, and exact write chronology can replace unavailable PC-derived “useful” counters.** The accepted core records DRC/no-PC/normal-batching/composed-hook provenance in both traces. Exact ordered `$C87E` writes prove state progress; V-INT's `$000C->$0000` write is a fresh Master-completion witness. Slave execution must remain non-zero every active frame. A completed Master may legitimately spend an isolated frame in PicoDrive's COMM-poll idle state, so Master execution is required per reviewed window/tail and the exact state cycle must continue. | Never infer DRC liveness from zero `msh2_useful/ssh2_useful`, never enable `VRD_PROFILE_PC` in this acceptance path, never accept a Master-zero interval with a missing/reordered/stalled exact cycle, and keep sampled COMM0 longest-run values informational rather than silently raising the old threshold. |
| 2026-07-25 | Q-020 mode 0 | **A command-mode register can be stage-scoped even when the game legitimately reuses it after the immutable results transition.** The initially frozen validator caught identical post-results COMM3_HI=`2` reuse in every arm; the failed result was preserved, a separate audit bounded mode 0 through R inclusive, and the unchanged captures then passed with exact paired post-results chronology. | Predeclare the semantic boundary, preserve failed evidence, and compare both arms after it. Do not retroactively shorten R, require a global register to retain racing semantics forever, or silently relax a failed policy. |
| 2026-08-11 | Q-020 mode 1 | **An interrupt handshake can remove COMM overlap, but acceptance still depends on proving unique ownership at both edges.** Exact setup SPCs safely bound the first CMD; the second CMD may interrupt stock code only because counts and the complete DREQ/DMAC terminal identity prove it belongs to the in-flight mode-1 transaction. The authentic name-entry route also demonstrated that a required lifecycle may correctly produce zero transport. | Keep setup and completion predicates distinct, record the interrupted SPC even when it is not an allowlist, derive route expectations from stock control flow, and compose raw captures, validator results, lifecycle policy, and excluded diagnostics under one fail-closed manifest. |

---

*This document is a living roadmap. Update it after every session. Add to Open Questions when uncertainties arise. Add to Decision Log when choices are made. Add to Lessons Learned when things surprise us. Add to Risk Registry when new dangers are identified.*
