# User-requested Q-028 implementation checkpoint

This checkpoint is **non-promotable work in progress**, not Q-028 acceptance,
a resource-pilot PASS, a renderer bridge, authority transfer or a 60 FPS result.
The original 68000 path remains authoritative. No commit/push of runtime
success beyond the checks below is implied.

## Verified at freeze

- Clean ordinary build passes with unchanged SHA-256
  `6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900`.
- Three table/instruction presentation corrections preserve every ROM byte.
- Sixteen focused tests pass with zero skips. The exact-C WRAM parity check
  separately passes 223 transitions and five rejected malformed copies.
- Two clean repaired cores match at
  `b3bd2d5551e7f6152e6c71a1057cd8619039f68084d323b3b4419ecfaceb69b7`
  (6,708,912 bytes); frontend remains
  `7883729f53b03b363e5ef1d1cea57efaa5a048283c0a2ea67ab4f50ce6c579ab`.
- The retained six-frame diagnostic consumes 517,467 records through the
  binary reader, IDL, COMM and empty host ledger, with zero observer errors,
  unknown/unattributed records or skips, and passes six declared artifact
  mutations. This short run contains no SRAM installs or host rewrites.
- Subsequent stricter checks bind every IDL source value to the accepted ROM
  and require raw frames below the actual footer terminal. Focused tests and
  checks of the unchanged six-frame raw data pass, but the complete real-core
  harness has not rerun after those final reader changes.

The first repaired core compile failed on libretro's `fprintf` macro mapping;
only the terminal diagnostic was changed to `dprintf(2, ...)`. The first
six-frame binary reader passed, then the old IDL predicate failed because it
used incorrect bases. A fresh Auditor approved deriving the exact bases
`02020000 -> 06000000`, length `C000`, from the hash-bound ROM header, and
checking source words against the ROM. Failed builds/captures remain intact
outside git and were not rewritten into passing evidence.

## Retained snapshots

- `generated-map-v10.tar.gz`: the four exact files from the staged generated
  map at `/tmp/q028-v10-sites-45hm_7e8`. The uncompressed site JSON is about
  659 MiB; its SHA-256 is
  `e2b6c45e06278270828da2207f498304d766ca1fd5a75b7efaa5dce01d8fe102`.
- `six-frame-v10.tar.gz`: complete `/tmp/q028-v10-smoke-r3` diagnostic,
  including original chunks, metadata, receipts and mutated copies.
- `review-and-build-v10.tar.gz`: exact approved proposals, Worker findings,
  build-pair receipt/logs and actual input snapshots. The build receipt's
  original absolute paths describe the original build locations.
- `manifest.sha256`: hashes of these three retained archives.

Extract archives only into a new diagnostic directory. They do not promote
the canonical pre-capture JSON. That older JSON remains an untracked local
generated file and intentionally differs from the staged new C include;
canonical output promotion is still pending. Do not silently substitute one
for the other. The compressed staged map preserves the new bytes without
adding the stale 474 MiB JSON to git.

## Required next work

Finish the approved actual-artifact mutation matrix, including terminal/raw
frame and ledger boundaries, omissions/reordering/orphans/EOF, interrupted
and wrong-CPU WRAM copies, actual producer RAM/model mismatch and restoration
expression ordering. Run the full 400-frame binary/ledger/SRAM regression.
Refresh final tool-input snapshots and two-build closure: the recorded build
pair predates the final reader/harness changes. Require fresh completed-diff
approval before another 1,340-frame resource pilot. Preserve all caps and
quarantine rules; later campaign schedules and all 40 packages remain open.
