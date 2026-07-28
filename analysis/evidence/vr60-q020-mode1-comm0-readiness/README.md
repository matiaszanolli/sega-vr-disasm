# Q-020 mode-1 COMM0_LO readiness candidate

Date: 2026-07-28

Status: **static candidate only; runtime Gate B and reset fixtures remain blocked**

## Protocol

The 68K programs DREQ length/68S/mode, writes command index `$3E` to COMM0_LO,
and raises COMM0_HI once. It then polls only COMM0_LO. No FIFO word is written
before the trigger or before COMM0_LO becomes zero.

Master programs SAR0, DAR0, TCR0, and CHCR0=`$000044E1`, writes DMAOR.DME=1,
and reads DMAOR back. Only after that synchronization does it byte-clear
COMM0_LO, read the same byte back as zero, and require COMM0_HI to remain one.
The 68K then submits exactly eight FULL-checked groups of four FIFO words.

Both sides wait for DREQ length zero. Master additionally waits for CHCR0.TE=1,
writes CHCR0=`$000044E0`, reads back `IE:TE:DE=000`, clears COMM0_HI, and reads
the same byte back. Guard failures enter the local fail-stop loop. Neither CPU
accesses COMM1, COMM2, COMM7, or `func_084`; there is no retry or early COMM
write.

## Exact source-built witnesses

- 68K wrapper/helper: file `$1C914-$1C98F`, 124 bytes.
- Command-index write: PC `$0001C946`.
- Sole trigger: PC `$0001C94E`.
- COMM0_LO readiness poll: PC `$0001C956`.
- FULL read / FIFO write: PCs `$0001C96C` / `$0001C978`.
- 68K DREQ-zero poll: PC `$0001C982`.
- Master handler: file `$303A10-$303AA7`, SH2
  `$02303A10-$02303AA7`, 152 bytes.
- Master readiness publish/readback/HI guard: PCs
  `$02303A3E`, `$02303A40`, `$02303A46`.
- Master DREQ poll: PC `$02303A4E`.
- CHCR idle-state guard: PC `$02303A62`, opcode `$C807` (`TST #7`) so
  IE, TE, and DE are all covered.
- Completion write/readback: PCs `$02303A68`, `$02303A6A`.
- Literal pool: file `$303A78-$303AA7`.
- Handler SHA-256:
  `d1fc1dcb28db09f049bed70e3669cdd2de9cba285b79c64a6ec0130db89e68ee`.

Candidate ROM identities:

- ACTIVE:
  `844543609366dd76925865c89d848306ff7a619cda637275143c60fbb3066402`
- CONTROL:
  `715f11de6478b3d96239ff54b7e38ce6ec3dc9e321b5d392bd660323e4ebbd17`
- ordinary mode-0 default, unchanged:
  `6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900`

The ROM-pair verifier pins these bytes, ranges, hashes, literal users, forbidden
registers, and exact Gate-B PCs. The trace grammar independently requires the
command/trigger/readiness edge, eight four-word groups, both DREQ-zero
observations, and completion readback. These static properties do not make mode
1 eligible or promotable.

## Reproducible PicoDrive instrumentation chain

`third_party/` is intentionally ignored by the outer repository, so the local
PicoDrive checkout is not the canonical source of the trace changes. The
reproducible tracked chain is:

1. PicoDrive upstream commit
   `26ecb2b6358fefba24e3d68b9eb2efba7f10d5ee`.
2. Existing accepted instrumentation patch
   `tools/libretro-profiling/libretro_vrd_profiling_v4.patch`, SHA-256
   `b18ffc2bb490f5cc9a0fd3529d8d341e19e461a69cc7b64779b7419248a9faee`.
3. Incremental mode-1 MMIO patch
   `tools/libretro-profiling/libretro_vrd_mode1_mmio_overlay.patch`, SHA-256
   `76363ab8b336631dfc4082e9923f6fe8bf002d17a86a011d8038eb77a1b4a78a`.

The overlay contains only the mode-1 PC-range changes, COMM0_LO byte
read/write capture, mode-1-only Master LO event retention, and matching trace
header allowlist. In a detached clean worktree at the pinned commit, applying
v4 and then the overlay succeeded. The resulting relevant files were
byte-identical to the local build checkout:

- `platform/libretro/libretro.c`:
  `334d1107f8ad5def3062a64f189f1df6918d2f6225ae337c6fafd789cdaa1376`
- `pico/32x/memory.c`:
  `bfd0c5619cedd98e89476697820fe178fa57f27fcb6625310f1f28e73c15089a`

The accepted canonical runtime core is unchanged at SHA-256
`5677ea8e083f887b2b4e9cabf84dd559a9c6b1180adfa09f34a50023ff7548e8`.
This overlay has not produced a reviewed runtime-eligible core; Gate B remains
missing and perturbative.
