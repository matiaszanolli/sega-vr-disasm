# VR60-009 Exact-Write Evidence

VR60-009 resolves the apparent normal-1P state-order failure reported by VR60-008. The
end-of-frame sample at frame 4536 did not represent one `$C87E` write from `$0000` to `$0008`.
The exact trace records two ordinary state-handler writes during that emulated frame:

```csv
4536,0x884CF2,0xFFC87E,2,0xFFC87E,2,0x0000,0x0004
4536,0x884D0C,0xFFC87E,2,0xFFC87E,2,0x0004,0x0008
```

No state handler was skipped. The first instruction is the state-0 `addq.w` in
`state_disp_004cb8`; the second is the state-4 `addq.w` in
`call_subs_advance_game_state`. The validator samples only after `PicoFrame()`, so it saw the
last value and compressed both writes into an apparent `$0000 -> $0008` transition.

The same trace identifies the later scene-pointer writer exactly:

```csv
5128,0x8843D0,0xFF0002,4,0xFF0002,4,0x00884CBC,0x0088FB98
```

`$8843D0` is the state-12 entry of the 13-state display controller. It deliberately installs
the `$88FB98` results scene. This is a timed-race finish, not a VR60 fault.

## Accepted captures

Three runs are decision-grade:

1. `/tmp/vr60-009-hook-diagnostic-HIBBX9` proved that the final FAME instruction-start hook is
   non-perturbing. With exact tracing active, `frames.csv` and `watch.csv` were byte-identical
   to the trace-disabled control. Their SHA-256 values are respectively
   `bdd698141da2fa54e4221818b324ebfc618862108471d7cba4ca194ba2d9019e` and
   `1008f83c1d741cf48ad16d8fc1f70fd5b6abd15ae56208212e1add37eda5df76`.
2. `/tmp/vr60-009-finish-classification-Zkf6vn0C` repeated the same 5,160-frame replay with an
   expanded watch set that classifies the finish state. Its `frames.csv` is byte-identical to
   both the first accepted trace and the 5,160-frame prefix of the archived VR60-008 run.
3. `/tmp/vr60-009-no-overwrite-final-J6vEX0` repeated the exact expanded capture after the
   init-only fail-closed trace-output fix. Its instrumented core SHA-256 is
   `027123c697d70ef33f259d6740cb451df58cb2a04f34f1ca6336450a0c0c4e09`. The six
   deterministic artifacts match capture 2 byte for byte, and the frontend logs match after
   normalizing only their absolute temporary roots and process-specific DRC allocation address.

All three accepted write traces end with:

```text
# COMPLETE frames=5160 events=5136 errors=0
```

All three caller traces end with 1,282 hits, 1,282 logged, and zero dropped. The earlier
single-instruction-*batch* tracer is rejected: changing FAME execution into one-instruction
batches shifted the scene transition to frame 4981. Its output is not in this archive and must
not be used as acceptance evidence. The accepted implementation instead adds a nullable callback
immediately before FAME opcode fetch while leaving the normal approximately 32-cycle profiler
batching unchanged.

## Finish classification

The expanded `watch.csv` establishes the following sequence:

- At frame 0, `$FF0002 = $00884CBC`, `$C80E` bit 4 is clear, `$FDA9 = 1`, and the timed-race
  counter `$C050` is `$004B`.
- `$C050` reaches `$FFFF` at frame 4533. At frame 4534,
  `conditional_scroll_state_init` has reset it to zero, set `$C07C = $0014`, and changed
  `$C30E` from `$10` to `$11`. Source/file offset `$006C38` is the unique static write of
  `$0014` to `$C07C`, and the exact tracer reports runtime PC `$006C38` through the low
  cartridge-ROM alias. Its corresponding high 68K mapping is `$00886C38`.
- Lap-completion fields `$EF07`, `$FEB7`, and `$FDA8` remain zero. This excludes the lap-bit
  completion route and identifies deterministic timer expiry.
- The display-state samples advance through `$C07C = $14` at frame 4534, `$18` at 4538,
  `$1C` at 4542, `$20` at 4637, `$24` at 4876, `$28` at 4924, `$2C` at 5084, and `$30`
  at 5124.
- `$C07C = $30` selects state 12 in `display_state_disp_004084`. Its `$8843D0` entry writes
  `$FF0002 = $0088FB98` at frame 5128, producing the intentional timeout/results transition.

COMM, render, hook, and framebuffer stalls sampled after that transition are out-of-scene
observations. They are not defects in the normal-1P race scene and are not caused by a skipped
state 4.

## Exact final capture command

The command ran from `/tmp/vr60-009-finish-classification-Zkf6vn0C` with a sterile environment.
`VRD_INPUT_SCRIPT` takes precedence over the otherwise inert `VRD_HOLD_INPUT` value.

```bash
env -i PATH=/usr/local/bin:/usr/bin:/bin \
  VRD_PROFILE_LOG=/tmp/vr60-009-finish-classification-Zkf6vn0C/frames.csv \
  VRD_PROFILE_FRAMES=5160 \
  VRD_PROFILE_PC=1 \
  VRD_PROFILE_PC_LOG=/tmp/vr60-009-finish-classification-Zkf6vn0C/pc.csv \
  VRD_FB_CRC=1 \
  VRD_SCENE_ADDR=0xFFC87E \
  VRD_WATCH='0xFF0002:4,0xFFC87E:2,0xFFC07C:2,0xFFC8C4:1,0xFFC8C5:1,0xFFC80E:1,0xFFC30E:1,0xFFC305:1,0xFFC04E:2,0xFFC8AA:2,0xFFC050:2,0xFFC30D:1,0xFFEF07:1,0xFFFEB7:1,0xFF6940:1,0xFFC89C:2,0xFFC8A0:2,0xFFFDA8:1,0xFFFDA9:1,0xFFC310:1,0x20004020:1,0x20004023:1,0x20004024:1,0x2000402E:2,0xFF0008:2,0xFFC87A:2,0xFFC8C8:2,0xFFC800:1,0xFFC802:1,0xFFC809:1,0xFFC80A:1,0xFFC822:1' \
  VRD_WATCH_LOG=/tmp/vr60-009-finish-classification-Zkf6vn0C/watch.csv \
  VRD_CALLER_TRACE=0x00884D1A \
  VRD_CALLER_TRACE_LOG=/tmp/vr60-009-finish-classification-Zkf6vn0C/caller.csv \
  VRD_CALLER_TRACE_MAX=0 \
  VRD_HOLD_INPUT=0x80 \
  VRD_WRITE_TRACE=0xFFC87E:2,0xFF0002:4 \
  VRD_WRITE_TRACE_LOG=/tmp/vr60-009-finish-classification-Zkf6vn0C/write.csv \
  VRD_LOAD_STATE=/tmp/vr60-009-finish-classification-Zkf6vn0C/vr60_control_bypass.mds \
  VRD_INPUT_SCRIPT=/tmp/vr60-009-finish-classification-Zkf6vn0C/replay-prefix.csv \
  ./profiling_frontend \
  /tmp/vr60-009-finish-classification-Zkf6vn0C/vr60_control_bypass.32x 5160 \
  > /tmp/vr60-009-finish-classification-Zkf6vn0C/frontend.log 2>&1
```

## Post-fix no-overwrite revalidation

The revised core refuses an existing `VRD_WRITE_TRACE_LOG` through a libretro VFS existence
check before the write-mode open. This changes initialization only; it does not change trace or
emulation behavior for a fresh output path. Exactly one fresh 5,160-frame capture was run from
`/tmp/vr60-009-no-overwrite-final-J6vEX0` with the same sterile environment, fixture, replay,
watch set, and limits shown above.

Raw `cmp` succeeded for `caller.csv`, `frames.csv`, `pc.csv`, `replay-prefix.csv`, `watch.csv`,
and `write.csv`. Their hashes are exactly the six corresponding hashes in the archive table
below. The fresh raw `frontend.log` hash is
`6d1da58006c6f766e093d25ccc1c1e567d3103f8c80f96f5b9581ca56f7c4e8c`; literal equality
with the archived log is impossible because the frontend writes the absolute capture root on
five lines and PicoDrive writes the process-specific hexadecimal address returned for the DRC
allocation. The accepted raw log is durable in the archive below; the fresh raw log remains at
the named temporary capture path for this session, and its SHA-256 is recorded here.

Only those two known-volatile fields were normalized. These are the exact normalization and
comparison commands used:

```bash
sed -E \
  -e 's#/tmp/vr60-009-finish-classification-Zkf6vn0C#@TMP_ROOT@#g' \
  -e 's#(drc_cmn_init: )0x[0-9A-Fa-f]+#\1@DRC_ADDR@#' \
  /tmp/vr60-009-finish-classification-Zkf6vn0C/frontend.log \
  > /tmp/vr60-009-no-overwrite-final-J6vEX0/frontend.accepted.normalized.log
sed -E \
  -e 's#/tmp/vr60-009-no-overwrite-final-J6vEX0#@TMP_ROOT@#g' \
  -e 's#(drc_cmn_init: )0x[0-9A-Fa-f]+#\1@DRC_ADDR@#' \
  /tmp/vr60-009-no-overwrite-final-J6vEX0/frontend.log \
  > /tmp/vr60-009-no-overwrite-final-J6vEX0/frontend.fresh.normalized.log
cmp /tmp/vr60-009-no-overwrite-final-J6vEX0/frontend.accepted.normalized.log \
  /tmp/vr60-009-no-overwrite-final-J6vEX0/frontend.fresh.normalized.log
```

`cmp` returned zero. Both normalized logs have SHA-256
`68d036dead3656a47e3c7de768e75bcfbc48f506f7b696a23b8d413f3c9e685e`. Because all
decision-grade content matches, the reviewed archive was deliberately left byte-identical at
`24c991d41df0a41ec6434057e9a473d6029d6df6c9016bfa70a3ee6d780fcc27`.

## Archived members

`artifacts.tar.gz` contains only the seven decision-grade text artifacts. Its metadata is
normalized to sorted member order, owner/group `0`, mode `0644`, timestamp Unix epoch zero, and
gzip header timestamp zero. Building it twice from the preserved capture produced identical
bytes.

```text
24c991d41df0a41ec6434057e9a473d6029d6df6c9016bfa70a3ee6d780fcc27  artifacts.tar.gz
```

Exact archive construction:

```bash
tar --sort=name --owner=0 --group=0 --numeric-owner --mode=0644 --mtime=@0 \
  --use-compress-program='gzip -n' \
  -C /tmp/vr60-009-finish-classification-Zkf6vn0C \
  -cf analysis/evidence/vr60-009-write-trace/artifacts.tar.gz \
  caller.csv frames.csv frontend.log pc.csv replay-prefix.csv watch.csv write.csv
```

| Member | Bytes | Physical lines | Data rows | SHA-256 |
|---|---:|---:|---:|---|
| `caller.csv` | 29,344 | 1,285 | 1,282 hits | `b54fe2ba4d2087dcb98711a42eede4aa06767d87d1d2bd955169ccbaa1533839` |
| `frames.csv` | 371,836 | 5,161 | 5,160 frames | `bdd698141da2fa54e4221818b324ebfc618862108471d7cba4ca194ba2d9019e` |
| `frontend.log` | 464,001 | 8,489 | n/a | `07e4ba14e423aeb01a9555f4e46d3ea3319211fc8bdd9e87e077befe877e0856` |
| `pc.csv` | 25,662 | 640 | 639 histogram/summary rows | `1711456c0d544665744c827d5dd761b4bcc2f8ac4b502193143faa3db8a3d5a6` |
| `replay-prefix.csv` | 60,821 | 5,161 | 5,160 input rows | `c23e024cce35b8bae64e951f7a2e0b68a11824f8c6a701b9ceecfba672ef518b` |
| `watch.csv` | 735,625 | 5,161 | 5,160 frames | `899b774afe3bfbe9eace151db23e51e5097585ce88e7c4ea9582f9651c69d578` |
| `write.csv` | 256,005 | 5,141 | 5,136 events | `bcc68cd3169f1494fbc7ad2e82408d3cf050ad72d963a90a76592ab9fdac151e` |

The capture deliberately excludes duplicate executables and fixture data. Their identities are:

| Excluded file | Bytes | SHA-256 |
|---|---:|---|
| `picodrive_libretro.so` | 2,096,560 | `b9e591dcc2495c5d41735b0892c3c286881ff25c0736032bd2398e1d274c84f2` |
| `profiling_frontend` | 31,552 | `cf93393318db52a1d0071b35c708bf10710ed6dfbc617c22e8e339eedac87e9f` |
| `vr60_control_bypass.32x` | 4,128,768 | `6a4c89cffa7df47a946b340d39492df05f2be316c76343cf7e4e932a8ca17672` |
| `vr60_control_bypass.mds` | 678,514 | `16a007b460f8f568615e7f6c13a3d22f06d82a5acbfa8011e23929f8861eb1cb` |

## Decision and next issue

VR60-009 changes no validator threshold or policy. End-of-frame state samples remain useful for
window liveness but must not be described as exact write chronology; use the complete exact-write
tracer for that diagnosis, or define a sampling-safe state-liveness rule in a separate issue.

The present savestate/replay is retired as an 18,360-frame control fixture because it
deterministically reaches the timed-race results sequence. It remains valid for bounded diagnostics
that end before the transition. The optional continuous VR60-010 route must capture a new
normal-1P fixture and deterministic input that remain in `$FF0002 = $00884CBC` for all 18,360
frames, then run the unchanged full validator. The continuous VR60-008 route remains blocked by
VR60-010; VR60-011 later cleared the baseline with three accepted complete lifecycles.

To verify the archive:

```bash
mkdir -p /tmp/vr60-009-evidence-check
tar -xzf analysis/evidence/vr60-009-write-trace/artifacts.tar.gz \
  -C /tmp/vr60-009-evidence-check
sha256sum /tmp/vr60-009-evidence-check/*
```
