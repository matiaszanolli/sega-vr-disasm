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
not a reproduction of the recorded identity if those hashes change. This is
**standalone source-state validation**, not a full core build, actual host-RAM
snapshot test, binary-reader acceptance, resource pilot, or FPS result.
