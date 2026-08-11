# Q-020 mode-1 CMDINT Gate B

## Result and scope

**Validation-stage PASS in PicoDrive for this isolated ACTIVE/STAGE-CONTROL
pair.** The machine-checked claim is [`composition.json`](composition.json),
which hash-pins and revalidates the static pair, lifecycle/reset reference,
raw runtime capture, archived validator result, and excluded busy-reset
diagnostic as one unit. This is not the ordinary default, a promotion decision, organic
name-entry gameplay evidence, SH2 gameplay authority, or real-hardware proof.
Mode 2 and command `$3F` remain disabled. The accepted default remains exactly
`6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900`.

The frozen pair is:

- ACTIVE: `963658608b13a96981b8bca60c5e7225df7cf148b138cdf1a1d6982487ff4470`
- STAGE-CONTROL: `391774569d17d2461decad5d002c9215914a84649b094b10a051b21b5348e9fd`
- Master ISR image: 1052 bytes at ROM `$303B00-$303F1B`,
  `6316a0d228dc3db8a48ecdef3b34e0962e04db35c4ef085ec17aea8873146916`
- Runtime frontend: `626c2c148aa1dca10f2893bc6e9ac59dad237f5043763567ef73b0f9868bcc50`
- Runtime PicoDrive core: `aaaa57f0190759e581ca116ab35ab7e1e090fcd93ccadd046242d7532ebbff79`

The complete static policy, all 60 `MOV.L @(disp,PC)` users touching the ISR
allocation, fixed `$3039FC -> $303CB4` external literal ownership, explicit
`RTE` delay-slot NOP, startup-shim symbol, and exact protocol slices are pinned
in [`mode1_rom_pair.json`](../../../tools/libretro-profiling/mode1_rom_pair.json).
That manifest is deliberately static-only; its runtime evidence is supplied by
the composition rather than represented as a stale missing-evidence blocker.

## Hardware model

The implementation follows these primary-source requirements:

- communication-port read/write overlap is undefined, so the mode-1
  transaction makes **zero COMM0-COMM7 accesses**
  ([32X manual §3.3](../../../docs/32x-hardware-manual.md#L707),
  [project hardware analysis](../../COMM_REGISTERS_HARDWARE_ANALYSIS.md#L132));
- INTM raises the Master CMD interrupt and the SH2 clears it through the CMD
  clear register
  ([32X manual](../../../docs/32x-hardware-manual.md#L719));
- DREQ CPU-write mode starts with `68S=1`, automatically clears `68S` on end,
  counts words in four-word units, and exposes actual LEN
  ([32X manual](../../../docs/32x-hardware-manual.md#L413));
- CPU-write FIFO FULL is checked before every four words
  ([32X manual restriction 4](../../../docs/32x-hardware-manual.md#L1454));
- DMAC0 uses the fixed DREQ FIFO source and prescribed channel-0 register
  shape ([32X manual](../../../docs/32x-hardware-manual.md#L1476));
- CHCR.TE is accepted only after `TCR=0` and is acknowledged by read-1 then
  write-0 before re-arm
  ([SH7604 manual](../../../docs/sh7604-hardware-manual.md#L4072));
- every external ISR toggles FRT TOCR bit 1 before dispatch
  ([32X supplement 2](../../../docs/32x-hardware-manual-supplement-2.md#L350)).

The 68K issues two CMD edges without touching COMM. Before the setup edge it
publishes DREQ `68S=1`, LEN `$20`, and encoded destination `$00:F30C`, which
semantically maps to SH2 SDRAM `$0600F30C`. The Master accepts setup only when
`setup_count == completion_count`, TCR0 is zero, and saved SPC is one of the
exact disassembled stock idle or quiescent-finalization instruction
boundaries. It then performs prior-TE acknowledgement if needed, writes
SAR0/DAR0/TCR0/CHCR0/DMAOR, synchronizes DMAOR, clears CMD, and restores the
exact mask word.

After eight FULL-checked groups of four FIFO words, the 68K waits for LEN zero
and automatic `68S` clear, then raises the completion CMD. Completion is not
SPC-restricted: it instead requires the stronger unique in-flight ownership
proof `setup_count == completion_count + 1`, exact SAR, bounded DAR/TCR,
CHCR `$44E1/$44E3`, and DMAOR `1`. Terminal DAR `$0600F34C`, TCR `0`, and TE
`1` are required before read-1/write-0 acknowledgement and CMD clear.

Cold startup reaches stock initialization through the fixed `$02303E60`
shim. VRES delegates to stock, and only the phase-pinned reset-flow CMD may
delegate afterward. All other CMD signatures and all unexpected external
levels fail-stop.

## Runtime evidence

[`runtime/run.json`](runtime/run.json) is the immutable `CAPTURE_COMPLETE`
47-artifact input; it does not claim PASS. The separately archived
[`runtime/result.json`](runtime/result.json) binds that capture manifest by
SHA-256 and records the fail-closed validator result. The lifecycle/reset
reference in
[`mode1_reset_fixtures.json`](../../../tools/libretro-profiling/mode1_reset_fixtures.json)
pins both files, the eight-run matrix, safe VRES scope, and the separate reset
diagnostic. The validator proves:

- two fresh captures per arm for normal entry and seeded name-entry re-entry;
- normal route `$0088E0D4 -> $0089C914`, wrapper flag `0->0`, stock install
  `$00884C6A -> $00884CBC`, composed caller execution of `$00884CBC`, and exact
  hook writer `$0001C8CA` changing the one-shot `0->1`;
- six complete ACTIVE transactions in each normal repeat, with identical
  transaction count and payloads; STAGE-CONTROL has zero transport events;
- canonical cross-CPU MMIO order for each transaction, eight FULL reads,
  32 FIFO word writes, exact 64-byte `$FF6B00 -> $0600F30C` equality,
  prior-TE handling, DMAC0 setup, terminal TE acknowledgement, and exact mask /
  CMD-clear synchronization;
- zero COMM0-COMM7 accesses, no trace drops/errors/overflow, and direct recorder
  ownership/coverage counters in every run;
- final Q21I setup SPC `$0600443A` is in the exact safe set and observed
  completion SPC `$06003D04` is recorded without treating that PicoDrive value
  as a hardware allowlist;
- seeded name route `$00891822 -> $0089C914`, real wrapper one-shot `1->0`,
  stock bit-3 route `$00884C98 -> $00885618`, composed replay caller liveness,
  final one-shot zero, no racing-hook writer, and zero transport events in both
  arms and repeats;
- clean VRES delegation at the deterministic frame-1241 stock-safe boundary:
  phase `0->3->4`, sequence `0->2`, VRES count `1`, stock reset-CMD count `1`,
  and startup init count `1->3`. One reset produces two post-reset startup-shim
  calls: the direct VRES continuation and the reset-flow CMD continuation.

The name fixture is diagnostic and explicitly not organic gameplay. It retains
the pinned source one-shot preimage `1`, rebinds this pair's Master vectors and
startup literal, initializes Q21I, seeds the otherwise-sentinel fifth score
slot, and changes only the required A042 route precondition. The validator
regenerates it from the archived source and requires byte identity.

## VRES boundary limitation

Reset at frame 1280, when the Slave is at on-chip renderer PC `$C00000B4`,
reproducibly strands the Slave at `$06000638` with repeated unsupported sysreg
accesses. The same fault occurs in ACTIVE, STAGE-CONTROL, and the accepted
default using its canonical core, so it is not a mode-1 DMAC residual.

The exact non-acceptance triad is hash-pinned in
[`reset-diagnostics/run.json`](reset-diagnostics/run.json). These logs are
outside the PASS artifact set and are never whitelisted or consumed as passing
evidence. Consequently, arbitrary/busy-Slave VRES remains unproven because of
this PicoDrive reset-boundary defect; only the explicit frame-1241 stock-safe
boundary is validated.

## Reproduction

```sh
make mode1-roms
make mode1-gate-validate
make mode1-runtime-tools
python3 tools/libretro-profiling/mode1_cmdint_runtime.py capture \
  --active build/vr60_mode1_active.32x \
  --control build/vr60_mode1_stage_control.32x \
  --default build/vr_rebuild.32x \
  --frontend tools/libretro-profiling/mode1_profiling_frontend \
  --core tools/libretro-profiling/mode1_picodrive_libretro.so \
  --canonical-core tools/libretro-profiling/picodrive_libretro.so \
  --name-source-state analysis/evidence/vr60-q020-cmdint-probe/runtime/name-source.mds \
  --output-dir /tmp/vr60-mode1-runtime
python3 tools/libretro-profiling/mode1_cmdint_runtime.py validate \
  /tmp/vr60-mode1-runtime/run.json \
  --result /tmp/vr60-mode1-runtime/result.json
python3 -m unittest \
  tools/libretro-profiling/test_verify_mode1_rom_pair.py \
  tools/libretro-profiling/test_mode1_cmdint_runtime.py \
  tools/libretro-profiling/test_validate_mode1_reset_fixtures.py \
  tools/libretro-profiling/test_validate_mode1_gate_composition.py
```

The separate diagnostic is reproduced with the same six binary arguments and:

```sh
python3 tools/libretro-profiling/mode1_cmdint_runtime.py \
  capture-reset-diagnostic --output-dir /tmp/vr60-mode1-reset-diagnostic \
  --active build/vr60_mode1_active.32x \
  --control build/vr60_mode1_stage_control.32x \
  --default build/vr_rebuild.32x \
  --frontend tools/libretro-profiling/mode1_profiling_frontend \
  --core tools/libretro-profiling/mode1_picodrive_libretro.so \
  --canonical-core tools/libretro-profiling/picodrive_libretro.so
```
