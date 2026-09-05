# Q-028 renderer-consumed descriptor-family probe

**Q-028 status: BLOCKED / INCONCLUSIVE_ENGINE_SCHEDULE.** The prior
`INCONCLUSIVE_COMPOSITE` acceptance is retracted: it was based on interpreter-only completion despite the
approved requirement for two uninterrupted normal-DRC repeats of every A/B/C
BASELINE/CONTROL/ACTIVE arm. Existing interpreter and DRC-A outputs are diagnostic only and establish no
accepted family result. B/C normal-DRC evidence is absent. No exact-index, bridge, authority, cadence,
CPU-budget, FPS, host-presentation, or real-hardware claim is accepted. Q-028 remains the active gate until
a separately audited immutable DRC schedule, fresh two-engine recapture, complete retained raw evidence,
and the repaired fail-closed mutation matrix pass a fresh completed-diff audit.

All files formerly under the `runtime/`, `visual/`, and `quarantine/` trees, the former
`manifest.sha256`, and every earlier `/tmp/q028-*` output are permanently diagnostic and
ineligible. They may not supply a hash, schedule, family result, repeat, raw member, or other
input to a fresh eligible composition. The recoverable historical files were moved without
modification to `/tmp/q028-diagnostic-ineligible-v7/` so they cannot intersect a later eligible
index receipt. `diagnostic-inventory-v7.json` records their historical repository paths and
bytes with `eligible:false` and `reuse_forbidden:true`; it is an inventory only, not an eligible
manifest. The separately copied pinned input fixture in `pre-capture/normal-1p-1340.csv` is an
approved input, not a captured outcome.

The pre-capture implementation is governed jointly by the approved Q-028 v3, v4, v5, v6,
and v7 proposal hashes recorded in `tools/libretro-profiling/q028_contract_v7.json`. The
current worktree contains only pre-capture tooling and the unchanged v3 reversible probe:
the direct `PicoDraw32xLayer` `dram[FS]` selection observer, one-to-one callback token,
separate preapplication and post-frame records, exact applied-input output, normal-DRC
command observer, explicit owner domain and retained dynamic-site report, four-archive/index
infrastructure, real production-contract mutation coverage, and real-index receipt tooling.

No fresh prospective schedule or 36-run outcome matrix has been run in this phase. The four
schedule-only processes, their independent schedule audit, all 36 capture-on processes, the
exact 40-package/640-render-page/358,481,920-byte composition, and a fresh completed-diff
audit remain mandatory before any Q-028 result can be considered.

## 2026-08-20 pre-capture checkpoint

The opcode-aware v8 observer and generated static site map are synchronized
again.  The exact approved listing (`9e32636c…b91c`) and ordinary ROM
(`6f2768f2…23900`) regenerate the JSON/C site map at `f4e9876c…774b`; the
observer include is `3ba9531b…c021`.  Two offline builds from the recursive
source pack produced identical cores (`f9e01a81…5557`, 5,642,416 bytes) and
frontends (`7883729f…79ab`, 36,768 bytes).  Owner regeneration/validation, a
clean ROM rebuild, the static A/B/C triplet verifier, and the existing 14
focused Q-028 tests pass.

The quarantined resource pilot remains unrun.  `/mnt/data` reported
199,020,318,720 available bytes, below the immutable 240,518,168,576-byte
launch floor.  An authorized attempt on `/mnt/audio` passed capacity but its
NTFS/FUSE mount could not preserve the pinned `.gitignore` mode, so source
materialization failed before emulation and left a 30 MiB quarantined partial
tree.  `/var/lib/docker` was the only observed ext4 mount above the floor, but
it was not writable by this user.  This is a staging prerequisite, not an
engine schedule or family result; the floor and mode identity must not be
weakened and no old outcome may be reused.

## 2026-09-04 staging and pilot-tool correction

A full filesystem inventory found owner-writable ext4 staging at
`/run/media/matias/Downloads`, with 1,545,815,298,048 available bytes at
inspection. The existing resource pilot launched at
`/run/media/matias/Downloads/vr60-q028-resource-pilot-20260904`, and both clean
builds reproduced the August core/frontend identities. A fresh audit found
two host-tool defects before completion: enum-ordered footer agent keys did
not satisfy the canonical JSON reader, and subtracting cumulative child RSS
maxima could report zero producer memory. The exact producer was deliberately
terminated with SIGTERM; gate session 2711 is terminal (gate exit 1, child
exit -15). The prefix through frame 443 and approximately 7.5 GiB of diagnostic
files remain intact. This was not a resource-limit or emulation failure.

The corrected observer serializes agent names in lexical order without
changing event IDs or the strict reader. The host launcher obtains each
child's own `wait4` resource usage. Observer SHA-256 is now
`967e0c81c066e09408065ae2734907937ec578cc2f351b6b4bb125c8c952df3a`.
Two clean builds reproduce core
`67c93765b3fd9a2b6c2d0941b1afdec2d4d4a7841a43a1e1a8507cb5b784c7d9`
(5,642,456 bytes), with the frontend unchanged. Clean ordinary-ROM and probe
triplet builds, six static tests, five runtime-validator tests, and three new
regression tests pass. The latter include a six-frame real-core footer parsed
by the production reader, rejection of reordered keys, and independent child
memory peaks. That short diagnostic is not a completed resource pilot.

The original source pack, immutable 1,340-frame input, ordinary ROM, launch
floor, reserve, and resource caps remain unchanged. A fresh full pilot must
use a new directory; neither the terminated prefix nor the six-frame test can
supply its result. A fresh Auditor independently reproduced all three new
regressions, compared the exact observer change against the terminated
pilot, verified clean-build identities, and approved the correction for a
fresh quarantined pilot. The retry target is
`/run/media/matias/Downloads/vr60-q028-resource-pilot-20260904-r2`.

The retry completed 1,340 producer frames, then exited 1 at production
validation (`fetch slot` on record 0). No termination signal was delivered.
All 496,577,712 events / 1,987 chunks remain in that quarantined directory,
with exact applied input. The footer reports no resource limit, but also
1,212 errors and 63,806,555 unattributed events; this is not a completed
resource validation or acceptance archive. Source/record diagnosis covers
the missing fetch sentinel, pre-instruction reset context, missing built-in
BIOS sites, incorrect byte-command tracking, and active Master DREQ0
mislabelled as N/A. No captured bytes may be repaired into passing evidence.

Linked-source follow-up also proves omitted SRAM-copy and 68000 sound-code
domains, plus executable `dc.w` instructions skipped by the listing parser.
The Master COMM0 command stream is separate from the Slave COMM2 renderer
counter; the observed cmd-2 counts of 28 and 67 must remain distinct. These
findings expand the required producer/domain/reader repair, not the eligible
evidence set. A fresh listing build still reproduces the ordinary ROM hash.

The complete independent diagnostic scan is now terminal: 496,577,712
events, 340,285,941 fetches, four boot-reset context mismatches and no later
context mismatches. All 63,806,555 unattributed records reconcile to the
footer. Its 4,054-group CSV and exact classifier are retained under
`diagnostics/r2-full-raw-scan/`; these do not replace production validation.
Source work identifies FAME's direct host branch rewrites after frame 360,
mutable WRAM instruction operands, and additional raw M68K code with three
misrendered instruction boundaries. The 321-instruction finite inventory and
companion mutable-image amendment received fresh implementation-only approval
(`a0995579…70edee8` inventory; `d230ca49…924f772` amendment). The independent
review verified the finite decodes and source identities and required strict
boot-data rejection, fetch-bound installs and EOF host-ledger handling.
The repaired new core was subsequently built twice with identical bytes,
and a six-frame real-core binary regression passed 517,467 events and six
artifact mutations. Final source-bound IDL-value and terminal-frame checks
pass focused tests and checks against unchanged raw data, but the complete
actual-core harness has not rerun after those final changes. Sixteen focused
tests pass with zero skips. The 400-frame host-ledger/SRAM regression, full
mutation matrix, refreshed build closure and fresh completed-diff audit
remain pending. See [the non-promotable checkpoint](diagnostics/checkpoint-20260904/README.md)
for retained compressed artifacts, hashes, failure history and exact limits.
No source-state or six-frame result constitutes resource-pilot acceptance.
