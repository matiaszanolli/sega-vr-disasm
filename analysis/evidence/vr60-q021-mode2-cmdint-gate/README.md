# VR60 Q-021 cmd `$3E` mode-2 validation archive

Status: **VALIDATION_STAGE_PASS**, isolated, non-promotable, and fresh-audited. This archive does
not enable mode 2 in the ordinary ROM, enable cmd `$3F`, transfer gameplay
authority, change cadence, prove organic gameplay, or prove real hardware.

## Exact transfer contract

- Authoritative 68000 AI table: `$FF9100-$FF9FFF`, 15 records × 256 bytes.
- Identically staged ACTIVE and STAGE-CONTROL source: `$FF6B40-$FF7A3F`.
- ACTIVE destination: `$06010000-$06010EFF`; terminal DAR: `$06010F00`.
- Payload: 3,840 bytes = 1,920 FIFO words = 480 full-checked groups × four
  words. The validators pin all three units independently.
- Transport uses DREQ/CMDINT only. The producer and ISR contain no COMM access.
- Sentinel: cache-through SDRAM trace `$2600BC20-$2600BC5F`, magic `Q22I`
  (`$51323249`) and inverse `$AECDCDB6`. ACTIVE requires exactly setup=1,
  completion=1, sequence=2, error=0; STAGE-CONTROL and non-racing route require
  zero transport counters.

## Same-frame payload evidence

The pinned autoplay route executes the one-shot transaction in frame 1259. The
debugger reads all 3,840 bytes at the first post-transfer boundary, frame 1260.
In both ACTIVE repeats:

```text
source SHA-256      70b543963a49274a1115e8e75210299c1ad10aa0167930557bb4430e664631c9
FIFO SHA-256        70b543963a49274a1115e8e75210299c1ad10aa0167930557bb4430e664631c9
destination SHA-256 70b543963a49274a1115e8e75210299c1ad10aa0167930557bb4430e664631c9
FIFO writes         1,920
```

Both STAGE-CONTROL repeats staged the identical source hash, recorded zero
transport events, and retained the deterministic non-source destination hash
`849a9fadb43ef55315614e08fbabb2a806ca84f7dcfbc28aa00dfb60a9c1e0cf`.

At that same boundary the Slave R15 is exactly `$06010000`; the Master R15 is
`$0600FF80` in ACTIVE and `$0600FF7C` in STAGE-CONTROL. The stock Slave startup
literal also sets R15 to `$06010000`. SH2 pushes use pre-decrement `@-R15`, so
the stack grows below the boundary while the AI destination grows upward from
it. A fresh Auditor assessed and approved this exact frame-1260 boundary. The
archive does not generalize it into a broader SDRAM-ownership claim. Later execution changes
the destination, which is why only the first post-transfer boundary proves the
transport payload.

## Fresh audit

The Auditor reproduced the clean build, complete nested mode-1/mode-2 gates,
all 14 focused tests, exact hashes and pair delta, literal ownership, raw
composition, and `git diff --check`, then returned **APPROVED**. The approval is
limited to the completed physical transport observed at frame 1260. The
unidentified later writer explicitly prevents persistent-allocation,
later-frame ownership, consumer, promotion, or authority claims.

## Matrix and lifecycle

`runtime/` contains two repeats of each arm × route combination:

- ACTIVE normal 1/2: one exact transaction and full source/FIFO/destination
  equality.
- STAGE-CONTROL normal 1/2: identical staging and lifecycle, zero transaction.
- ACTIVE and STAGE-CONTROL name/replay 1/2: wrapper lifecycle reaches replay,
  never the racing hook, and records zero transaction.
- `active-vres.*`: the accepted frame-1241 stock-safe VRES boundary records the
  expected VRES/stock-CMD continuation and trace reinitialization.
- `default-reset-baseline.*`: canonical-core comparison for that reset boundary.

Post-transport busy-Slave reset remains outside acceptance because the accepted
mode-1 work already established the PicoDrive baseline defect there. No freeze
causality is inferred from that limitation.

## Identities

```text
ordinary default  6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900
mode-1 ACTIVE     963658608b13a96981b8bca60c5e7225df7cf148b138cdf1a1d6982487ff4470
mode-1 CONTROL    391774569d17d2461decad5d002c9215914a84649b094b10a051b21b5348e9fd
mode-1 ISR        6316a0d228dc3db8a48ecdef3b34e0962e04db35c4ef085ec17aea8873146916
mode-2 ACTIVE     96d79e3fb4d2df8a69852917ac811f860935ae950fc87222d008fa45d47ee276
mode-2 CONTROL    da5ce4ec9ef8e050c7babeb113e26aa7335a3ff5285285e55a6606d2f96309b8
mode-2 ISR        b7fc5726dd503f35f08625a6159bed2cff06720ea85a89848bc2e70e64eaaaa7
```

The mode-2 ACTIVE/CONTROL ROMs differ only in the six-byte pair slot at file
`$01C8C4`: ACTIVE `4EB90001C922`, CONTROL `4E714E714E71` (five differing byte
positions because both start with `$4E`).

## Reproduction

```bash
make clean && make all
make mode1-gate-validate
make mode2-gate-validate
python3 -m unittest \
  tools/libretro-profiling/test_verify_mode2_rom_pair.py \
  tools/libretro-profiling/test_mode2_cmdint_runtime.py \
  tools/libretro-profiling/test_validate_mode2_gate_composition.py
```

The immutable capture is bound by `runtime/run.json`; `runtime/result.json` is
recomputed and compared byte-for-byte by the composition validator. The static
pair remains fail-closed (`runtime_evidence=MISSING_FAIL_CLOSED`) unless the
separate composition binds it to this archive and the still-valid mode-1 gate.
