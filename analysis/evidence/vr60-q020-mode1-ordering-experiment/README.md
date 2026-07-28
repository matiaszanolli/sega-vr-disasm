# Q-020 mode-1 pre-arm FIFO ordering experiment

Date: 2026-07-28

Status: **REJECTED design; PicoDrive-only historical observation**

## Question

Does PicoDrive retain a four-word CPU-write DREQ FIFO group produced before
Master SH2 enables DMAC channel 0, then drain that group after DMAC is armed?

This was investigated while removing the unsafe mode-1 COMM1 acknowledgement.
The 32X hardware manual defines the four-word FIFO and its FULL discipline, but
does not guarantee that CPU-written words remain pending when written before
DMAC0 DE/DMAOR DME establish an eligible transfer. That missing hardware
guarantee makes pre-arm FIFO production unusable for the final candidate.

## Experiment

The temporary experiment:

1. configured CPU-write DREQ with length four;
2. wrote the fixed words `$A1B2,$C3D4,$E5F6,$0718` before the command trigger;
3. triggered cmd `$3E` exactly once;
4. performed no FIFO writes after the trigger;
5. let the Master handler arm DMAC0 for four words and wait for DREQ length zero.

The accepted Big Forest source state caches the old cmd `$3E` jump target
`$023016B0`. Therefore the temporary handler was assembled at both that cached
target and the isolated candidate target `$02303A10`. This is an experiment-only
accommodation, visible in `raw/experiment.patch`; it is not part of the final
candidate.

`raw/m68k-helper.objdump.txt` proves all four FIFO writes occur at
`$0001C94C/$0001C950/$0001C954/$0001C958`, before the trigger write at
`$0001C964`, with no post-trigger producer. `raw/master-handler.objdump.txt`
proves TCR0 is four, DMAC0 is armed only after handler entry, and the handler
does not access COMM1.

## Result

Two fresh repetitions produced the same guest-visible result:

- destination `$2600F30C` changed from zero to
  `A1 B2 C3 D4 E5 F6 07 18`;
- the remaining 56 destination bytes stayed zero;
- handler sentinel `$2600FC04` changed from zero to `$20004020`.

The only run-log difference is PicoDrive's host DRC allocation pointer. Because
the static producer has no post-trigger FIFO write, the exact destination bytes
cannot be explained by a post-arm producer. In the pinned PicoDrive model, the
pre-arm group was retained and drained when DMAC0 became eligible. This is an
emulator observation, not a hardware contract.

This matches the source model at pinned PicoDrive commit
`26ecb2b6358`: `pico/32x/memory.c:dreq0_write()` retains CPU-write words while
68S is set, and `pico/32x/sh2soc.c:dmac_trigger()` starts a retained FIFO batch
when channel 0 is enabled. The exact source hashes are in `raw/sha256.txt`.

## Scope

The pre-arm design is rejected. These artifacts are preserved only as historical
PicoDrive evidence; they do not establish a safe SH7604/32X ordering rule. They
also do not:

- prove the final 64-byte candidate transaction;
- satisfy the mode-1 MMIO Gate-B trace;
- satisfy normal-entry/name-entry reset fixtures;
- make mode 1 eligible or promotable.

The replacement candidate writes no FIFO word before the sole trigger. Master
arms DMAC0 and synchronizes DMAOR, then clears and reads back COMM0_LO as a
readiness signal while guarding COMM0_HI=1. The 68K starts all eight
FULL-checked four-word groups only after observing COMM0_LO=0. Neither CPU
accesses COMM1, COMM2, or COMM7.

## Artifacts

- `raw/experiment.patch` — complete temporary source delta.
- `raw/m68k-helper.objdump.txt` — producer ordering witness.
- `raw/master-handler.objdump.txt` — four-word DMAC consumer.
- `raw/handler-rom-bytes.txt` — cached-target ROM placement witness.
- `raw/run1.log`, `raw/run2.log` — independent debugger runs.
- `raw/sha256.txt` — ROM, state, replay, tools, source, and log identities.
