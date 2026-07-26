# VR60 Q020 cmd `$3E` Mode-0 Evidence

**Captured:** 2026-07-25
**Policy:** `VR60-Q020-mode0-gate-v2`
**Result:** PASS for the mode-0 sub-gate only; Q-020 remains open for mode 1

## Accepted scope

This evidence establishes only PicoDrive exact 320B mode0 transport + exact
gameplay/state/terminal chronology in fresh eligible lifecycles. It does not validate mode 1,
mode 2, cmd `$3F`, SH2 gameplay authority, real hardware, 60 Hz cadence, or an FPS/CPU budget.
The 68000 remains authoritative.

The exact source-built pair is:

```text
6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900  ACTIVE
75b5691a9dc11d39b19093e221a566cdd8a2d014520b1d7d88908122a94c4021  STAGE-CONTROL
14632a23804b6043921f0e66d3f9ff84cf2ae58c66c04617d933fd7874b93183  legacy default reference
```

Both mode-0 arms end with exact bytes `4E F9 00 88 4D 6A`. Their only pair delta is the
six-byte ACTIVE transfer call versus three CONTROL NOPs. Exact static bytes also bind the
source/staging routines, FIFO transfer, Master cmd `$3E` jump-table entry, complete SH2 handler,
mode 0, DAR0 `$0600F20C`, TCR0 `$A0`, and the cache-through sentinel.

## Frame-0 preflight

Each immutable VR60-011 source state was loaded through the accepted hook-bypass ROM. A
hash-pinned debugger script performed only:

```text
status
read 68k 0xFF0002 4
read 68k 0xFF7B40 1
read master 0x20004026 1
read master 0x2600FC00 4
status
quit
```

Both status records are session frame 0. The raw transcripts pin the frontend, core, ROM,
state, command script, and transcript identities and read scene `$00884CBC`, flag 0, mode 0,
and sentinel 0. No post-`PicoFrame` watch is used as preflight.

## Runtime result

The final matrix contains exactly 12 fresh slots: three immutable VR60-011 identities, ACTIVE
and STAGE-CONTROL, repetitions 1 and 2. Every same-arm repetition is byte-identical for complete
frame, watch, caller, write, and checkpoint artifacts.

All runs independently retain the VR60-011 lifecycle checks and exact accepted boundaries:

| Fixture | First hook H | Live source=stage | Terminal E | Results R | Active frames after warmup |
|---|---:|---:|---:|---:|---:|
| Big Forest | 0 | 1 | 11266 | 11713 | 10906 |
| Bay Bridge | 2 | 3 | 9623 | 10070 | 9263 |
| Acropolis | 2 | 3 | 11328 | 11775 | 10968 |

At frame 11, ACTIVE staging equals ACTIVE `$0600F20C`, ACTIVE staging equals paired CONTROL
staging, and ACTIVE destination differs from CONTROL destination. ACTIVE has a fresh
`$20004020` sentinel; CONTROL remains zero. Mode is 0, ACK bit 1 is clear, DREQ length is zero,
and COMM7 is idle. Each arm has exactly one flag write `0 -> 1` at PC `$0001C8CA`.

Caller and baseline-write chronology match accepted VR60-011 exactly without alias
normalization. The state-cycle writer is raw PC `$00884D6A`; terminal PC `$00006C38` remains
the legitimate low-alias writer at the accepted terminal frame.

The paired framebuffer comparison is exact at every sampled frame through the inclusive
terminal except:

- Big Forest: H+3, frame 3;
- Bay Bridge: no mismatch;
- Acropolis: H+3, frame 5.

Both exceptional samples are state 8, and equality resumes at H+4 and remains exact through the
terminal. This is a **one-frame sampled framebuffer divergence consistent with render/display
scheduling**. HBLK/FEN is inference not causal proof. Framebuffer CRC is corroboration only and
was not compared bit-for-bit against the hook-bypass archive.

COMM3_HI remains zero through each immutable results transition. Its later post-results reuse is
permitted only because the complete values are pair-identical. The initially frozen validator
incorrectly applied the mode-0 scope after results; its failed `result.json` is preserved.
After a separate approved scope correction, the same immutable captures passed and
`corrected-result.json` was written without recapture.

## Default promotion and historical reproducibility

The ordinary clean-build ROM is the complete validated ACTIVE image:

```text
6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900  build/vr_rebuild.32x
```

`make clean && make all` reproduced the preserved validated image byte-for-byte.
`make control-rom` now uses a separate source-built legacy target and still reproduces:

```text
14632a23804b6043921f0e66d3f9ff84cf2ae58c66c04617d933fd7874b93183  legacy live reference
6a4c89cffa7df47a946b340d39492df05f2be316c76343cf7e4e932a8ca17672  VR60-011 hook bypass
```

Mode 1 and the legacy relay are unreachable in the promoted default.

## Archive

The normalized archive uses sorted members, epoch timestamps, zero owner/group, directories
`0755`, files `0644`, and a zero gzip timestamp:

```text
8819117368f9b486a9ed925af86d26eddd0616ab30a39c4dcb40958494e9c5c9  artifacts.tar.gz
a619f3333dd5581170c7bad4ccf06ad3f633e5c4525c3b14df2f0d4dceb61895  manifest.json
145466ba02aa7a078f20772f6d4a477afeeefa1c058c59aa69f1c7bdf0d32d31  result.json (preserved failed policy)
81aa513873c47d921123d2a3dde248354f655bb29397d460d0249af84ae03a10  corrected-result.json (PASS)
```

Verify it with:

```bash
mkdir -p /tmp/vr60-q020-evidence-check
tar -xzf analysis/evidence/vr60-q020-mode0-gate/artifacts.tar.gz \
  -C /tmp/vr60-q020-evidence-check
cd /tmp/vr60-q020-evidence-check
sha256sum -c archive-members.sha256
```

## Remaining mode-1 blockers

Q-020 is only partially resolved. Before mode 1 can be enabled and tested independently:

1. define and validate scene reset/re-entry behavior for the one-shot `$FF7B40` flag;
2. resolve COMM ownership and add/verify the required SH2 same-address dummy-read where timing
   visibility matters;
3. instrument the DREQ FIFO FULL behavior at its four-word transfer granularity rather than
   assuming uninterrupted bulk writes.

These blockers carry forward unchanged; none is evidence that mode 1 is broken.
