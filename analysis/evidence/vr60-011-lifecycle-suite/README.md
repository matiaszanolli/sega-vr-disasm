# VR60-011 DRC Lifecycle-Suite Evidence

VR60-011 closes the durable normal-1P control gate with three distinct, complete timed-race
lifecycles under the normal SH2 DRC execution mode. The strict v2 suite policy passes all three
fixtures independently:

| Fixture | Capture frames | Terminal entry `E` | Results write `R` | Counted active frames |
|---|---:|---:|---:|---:|
| Big Forest | 12,229 | 11,266 | 11,713 | 10,906 |
| Bay Bridge | 10,482 | 9,623 | 10,070 | 9,263 |
| Acropolis | 12,383 | 11,328 | 11,775 | 10,968 |

After the fixed 360-frame warmup, the suite contains **31,137 aggregate active frames**. The
longest active span is **10,968 frames**. These exceed the reviewed floors of three lifecycles,
1,800 active frames per lifecycle, one 3,960-frame span, and 18,000 aggregate frames.

The exact passing result is archived as `result.json`:

```text
passed=true
eligible_distinct_lifecycles=3
eligible_active_frames_per_lifecycle=[10906,9263,10968]
aggregate_eligible_active_frames=31137
longest_eligible_active_span=10968
```

## Execution mode and liveness proof

Every `run.json`, write-trace header, and caller-trace header independently attests:

```text
sh2_drc=1 profile_pc=0 profile_pc_env=0 m68k_batching=normal
instruction_start_hook=1 composed=1 max_hits=0
```

The capture environment did not contain `VRD_PROFILE_PC` or `VRD_PROFILE_PC_LOG`. The reviewed
core uses one FAME instruction-start owner that records the exact write PC and exact caller PC,
stack pointer, and return address, then preserves any previous callback. Every caller trace is
complete, uncapped, error-free, has zero drops, records PC `$00884D1A`, and observes return
address `$00FF0006`.

Master progress is proven without PC sampling. Every active 180-frame window contains the exact
ordered `$C87E` write cycle:

```text
$00884CF2  $0000->$0004
$00884D0C  $0004->$0008
$00884D6A  $0008->$000C
$0089C414  $000C->$0000
```

The final `$000C->$0000` write is the fresh Master-completion witness: the 68K V-INT path performs
it only after observing and acknowledging Master `func_084`'s COMM1 done signal. Slave executed
cycles are non-zero on every active frame. Master executed cycles are non-zero in every reviewed
window and substantial tail. Acropolis frame 3549 records an isolated Master zero while the
exact cycle advances `$0008->$000C` and completes `$000C->$0000` on the next frame; this is the
reviewed completed-Master COMM-poll idle case, not permission for a state-cycle stall.
COMM2/COMM7 and framebuffer liveness retain the reviewed limits. Sampled COMM0_HI longest-run
values (281, 692, and 722 frames) are reported as informational only; they are not raised
thresholds or failure criteria.

## Terminal classification and address notation

Coverage ends at the predeclared first exact word write `$0000->$0014` to `$FFC07C`. The
instruction is at source/file offset `$006C38`, and the exact tracer reports runtime PC
`$006C38` because this routine executes through the low cartridge-ROM alias. Its corresponding
high 68K mapping is `$00886C38`; these are mappings of the same ROM location, not conflicting
writers.

Each lifecycle then contains the exact `$14/$18/$1C/$20/$24/$28/$2C/$30` display sequence and the
unique `$008843D0` results-scene write `$00884CBC->$0088FB98`. The watched timeout counter shows
`$FFFF->$0000`, and all three lap-completion flags remain zero.

## Deterministic replay

Each accepted fixture was captured twice from the same pinned state/input/source replay. Raw
`frames.csv`, `watch.csv`, `caller.csv`, and `write.csv` are byte-identical between repetitions:

| Fixture | Frames SHA-256 | Watch SHA-256 | Caller SHA-256 | Write SHA-256 |
|---|---|---|---|---|
| Big Forest | `663a45b80bd8d95b2ac8946a0219223f062545e51b486b2902c3a24d216bd1e6` | `8ff12480b3a14281f7458849233915f4ae97d7a1ebbbb1884ee142e78722684c` | `900ae5d6897f7703bd3befb735c663f5e1abe1709fba8ff22a8bcbdb5d0f656c` | `9c31edab74f42c1d81658ba4e2b8c931e024d9f630d2e12f378ff8cba9173977` |
| Bay Bridge | `19f7d1776fa3b6cd00bf78392ace7ddae8704cc643d574d58966b8891bf6b459` | `0fe9e28f6a378b1c4c6777214e3c965d6f3140658e0a7898b8c7248c7bc66995` | `011a3ef118752052743355393d1befce0c9683680eb132dfa0f1e4e1e7256d05` | `e1d18f12d319de0ff6e9027a1835ad9e4c3dee5eee52f57936dd8dcc03656968` |
| Acropolis | `478b001e353b9faa67f9dca52b3a97bfcd171592203fcbdf83c0ac2a8ed9bbec` | `23aa02c270dec517881484568652f4ba251819b3691cacaf46c98c5a5f4d2afe` | `ffcea57c139c7153c4f50fdd7fd189125fbcae281240909c7cbc385a6ee36cf3` | `855f2e18596e1c590b3557042b7ecbca1f8eb17301d20a703d9d1566399c6c92` |

The frontend logs differ only in volatile absolute output paths and DRC allocation addresses;
they are not used for the deterministic chronology comparison.

## Tool identity and verification

The canonical core was rebuilt from PicoDrive HEAD `26ecb2b` plus only
`libretro_vrd_profiling_v4.patch`. Applying the tracked patch to a clean archived tree with its
pinned submodules and building independently produced the same core bytes:

```text
81945600a1245a37f00d3a1fcaa063202180c29609aeffa4611552b778f2f079  libretro_vrd_profiling_v4.patch
5677ea8e083f887b2b4e9cabf84dd559a9c6b1180adfa09f34a50023ff7548e8  picodrive_libretro.so
cf93393318db52a1d0071b35c708bf10710ed6dfbc617c22e8e339eedac87e9f  profiling_frontend
```

The normalized archive uses directories `0755`, files `0644`, owner/group `0`, sorted members,
epoch timestamps, and a zero gzip timestamp. It includes the raw three-fixture artifacts, exact
`suite.json`, `result.json`, source states, input CSVs, source replays, and a per-member checksum
file:

```text
d173e0bc7fe135e91513805dcb16cf02a84630e1eeb44e6751fd9b6660bcd348  artifacts.tar.gz
2ebd2689ef7a74a1a3ad3c140f835f80fb24621fb394a63d5e121138040b2716  suite.json
da3a20c32e2228ad48377f2a7e0c078278f78199ef928c8ff9d8198a0d468a64  result.json
```

To verify the archive:

```bash
mkdir -p /tmp/vr60-011-evidence-check
tar -xzf analysis/evidence/vr60-011-lifecycle-suite/artifacts.tar.gz \
  -C /tmp/vr60-011-evidence-check
cd /tmp/vr60-011-evidence-check
sha256sum -c archive-members.sha256
```

The archived `suite.json` and `run.json` preserve their original absolute capture paths as raw
provenance. The archive carries the exact pinned source bytes under `sources/`; it does not
rewrite the passing records after capture.
