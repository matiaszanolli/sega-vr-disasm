# Q-028 r2 full raw diagnostic scan

Diagnostic only; ineligible for Q-028 schedule, family, resource-PASS or FPS
acceptance. Original raw chunks remain unchanged at
`/run/media/matias/Downloads/vr60-q028-resource-pilot-20260904-r2`.

The classifier completed all 496,577,712 records from the 1,340-frame r2
run. It found 340,285,941 fetches (M68K 3,992,724; Master 88,399,779;
Slave 247,893,438), all with the producer's erroneous zero fetch slot.
Exactly four SH2 pre-instruction reset reads differ from normal instruction
context; there are no later context mismatches. Its grouping of all
63,806,555 unattributed records matches the footer exactly, in 4,054 groups.
This scanner's focused checks are not the strict production reader.

Independent comparison of changed M68K fetch words against the ordinary ROM
(and the normal FF0000 source template) accounts for all 32,785 changed
fetches at 41 sites: 66F6→73F6 (9,578), 66F8→73F8 (20,831), and
67F6→77F6 (2,376). Every pair matches the pinned FAME non-idle-handler
rewrite formula; there are zero unexplained pairs in this diagnostic set.
Forty sites are in ROM and one is FF0014. This corroborates the source model;
it does not narrow the approved ten-real-opcode/two-outcome model to observed
pairs or permit admission without the ordered host ledger.

Retained SHA-256 identities:

- `q028-r2-unattributed.csv` (312,030 bytes):
  `26cc17f2883992dae06d87cddf67dc62c9ef9802b006a9c9491b9ff2d91c242b`
- `q028_classify_raw.c`:
  `66cb855e4ebfcc05120a863d7bf0330d1381ec71678996cd4a581ac26fedb699`
- `q028_classify_raw`:
  `db4ed00f3fa02392da7b05e7c4e3c89465fbd61d4dc5707b70c3ee65fd2b2a53`
- `q028-m68k-finite-inventory.json`:
  `a09955793f72928a4c9133672aa9c7d2319c6e21d4933981a138afffb70edee8`

The finite inventory is an **implementation-approved source-review input**, with exact
ROM/decoder/listing/source/span/instruction identities. Its 321 instructions
include all 256 omitted diagnostic starts and 65 source-defined siblings.
It is not a runtime PC allowlist. See
`analysis/agent-scratch/worker/q028-m68k-finite-inventory-review.md` and
`q028-mutable-images-amendment.md` for scope, exclusions and fresh-audit
requirements. The fresh design audit approved amendment `d230ca49…924f772`
and this inventory for implementation only, not runtime/pilot acceptance.
The JSON's original proposal status is retained as part of its exact reviewed
identity. No original raw words or resource-policy bounds were changed.

## Standalone WRAM implementation check

`q028_wram_parity.py` (SHA-256
`6d0558033d70a9549c30c1beac20c8eac4b4ca4cddc4c406406ad0a9af91fbcb`)
compiles the exact current C `vrd_q028_wram_access` function with generated
source-bound tables and compares state transitions against the independent
Python WRAM model. The reviewed run passed 223 valid transitions and rejected
five malformed copy transactions. Cases cover all three installs, reinstalls,
partial/word/long mutable-field writes, 24-bit address aliasing, unrelated
writes and invalidation on immutable-byte writes. Function SHA-256 was
`0b229f64eed1e746a4f3701a3908db975d1eb30a6c09cbe8a3418547bfc51907`;
the complete observer file at that checkpoint was
`bf6bb5f686e32f2c459dc8eba4eed9a0e8fc89bec1078f0585897e419daf5351`.

Run from the repository workspace with `python3` and the pinned build tools.
The script reports the actual current function/file hashes; a later run is
not a reproduction of the recorded identity if those hashes change.

The post-`e180875` extension also compiles the exact host-RAM comparison block
with a small word-swapped host-memory stub. It passes 372 individual byte
mismatches across every allowed WRAM instruction start and 27 matching,
range and CPU/view controls. Every check preserves host bytes, model bytes
and active view; only the expected error counter changes. The extra installs
bring the transition count to 283, with the same five rejected copy mutations.
Exact comparison-block SHA-256:
`ac50cb371a184da5ff78a4dcddb2a02b6ef8e77ec16229edcb3d6693ee729395`;
observer SHA-256:
`0288b3a6067150fb1850b2c5473bbe8b7451c00249ad7fde36915718f753d30b`.
This tests the real C comparison against stubbed host memory, not a running
PicoDrive memory snapshot. Both versions remain **standalone validation**,
not actual-core binary-reader acceptance, a resource pilot or an FPS result.

## Standalone host restoration ordering

`q028_idle_restore_parity.py --source-root <retained-build-source>` extracts
the exact original `SekFinishIdleDet` from the hash-verified immutable source
pack and its exact reviewed post-overlay function from the supplied build.
It compiles both with host-memory/callback stubs. All 20 approved opcode
variants restore identical bytes, and each patched callback reports the
original word and final restored word in the original reverse-target order.
Two unmatched controls emit no callback; repeated teardown remains a no-op.
This verifies full-expression callback ordering, not actual-core ledger or
EOF acceptance. The original and patched normalized function hashes are
`ebff9a2d6f5c8e48f95327c02b38f0cfd64f5acaac9a8bc7cab3339320c268a2`
and `8621954f5ac53571743b26a50490a2ca88e5716d8798be755f2143bec2cb222b`.
The reviewed patched `pico/sek.c` hash is
`46777d9bce8d88d7e5034aff5e65ec2f158c18660d36cf7a53a9429f012c83d7`.

## Full execution-field comparison across the DT repair

`q028_compare_attribution.c` compares two captured streams, with arguments
`OLD_DIRECTORY NEW_DIRECTORY CHUNK_COUNT`. It permits only site-map header
identity changes and resolution of previously unattributed SH2 SRAM records:
attribution bit, site index and opcode hash. Every other record field and
every already-attributed record must remain byte-identical. It is a focused
diagnostic comparator, not a structural/semantic production validator.

Old `q028-v10-bounded-400-r1` versus new `q028-v10-dt-bounded-400-r1`, 544
chunks each, passed all 135,978,338 records. Exactly 219,125 Master and
317,966 Slave SRAM records gained attribution. Source SHA-256 is
`68cc351ae8bfa549f8749c9f5985effbdf3177accc7b982fd3a8250c789c7cd0`;
compiled binary SHA-256 is
`7ec58897b2c596060068c2376fcc5524dc16fcbabac750067567c83aae71e0dc`.
The receipt is `independent-execution-comparison.json` in the new run directory.
Neither this comparison nor the old failed capture supplies acceptance.
