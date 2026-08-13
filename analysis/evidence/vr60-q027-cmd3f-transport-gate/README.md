# Q-027 bounded cmd `$3F` transport/convergence gate

**Result:** the fresh post-approval archive passed the approved Q-027 v5 validator and a fresh
completed-diff audit on 2026-08-13. This gate is non-promotable and leaves the ordinary mode-0
ROM unchanged.

Q-027 proves one bounded Master-COMM0 invocation through the real stock table `$3F` target
`$02301500`. It uses the accepted Q-026/Q-020 320-byte player seed, executes the specialized
player-only handler in ACTIVE, and writes the fixed 16-byte proof mailbox at `$2600BC00`.
CONTROL exercises the same two-edge parking protocol without entering table `$3F` or changing
the player shadow.

## Static pair and frozen boundary

| Artifact | SHA-256 |
|---|---|
| ACTIVE ROM | `50c20e1a82ff8f1f6df49a86dfc51bdef8b2b435f365a16cab3dec0bf7834097` |
| STAGE-CONTROL ROM | `33bfdd8c0e4b44187f25b40bfb540e4d7aebcb5dda55cbebf51c7e674834e511` |
| Static manifest | `7082bfa90f3379ba7b6b7ee25a93306a99693db6311e91d39183decd04cc0f9c` |

The pair differs only at file `$3041A2-$3041A3`. Both arms retain the accepted ordinary,
mode-1, mode-2, Q-023, and Q-026 identities. The static verifier pins the 432-byte handler,
788-byte ISR cores, helper/vector/startup/table bytes, literal ownership, and these allocations:

- seed `$0600F20C-$0600F34B`;
- mailbox `$2600BC00-$2600BC0F`;
- trace `$2600BC60-$2600BC9F`;
- canary `$2600FB64-$2600FB67`;
- dedicated stack `$0600FB68-$0600FBFF`, top `$0600FC00`.

The 68000 saves SR and holds IPL7 for the complete transaction. Edge 1 is admitted only while
INTM is low, DREQ is idle/length zero, COMM0_HI is zero, and the Master is at one of the six
stock idle PCs. The parked Master makes no COMM access while the 68000 clears and reads back the
full COMM0 word, then publishes aligned `$013F`. Edge 2 consumes that exact word. The handler
preserves GBR, MACH, MACL, R8-R14, PR, and R15; ACTIVE clears COMM0 after the stock-table call,
while CONTROL clears it in the ISR. Neither arm publishes COMM1-7.

The fixed mailbox image is:

```text
51 32 37 4D 00 01 27 11 3F 01 A5 5A 51 32 37 43
```

The unchanged static verifier and all 13 static adversarial tests pass.

## Fresh v5 runtime archive

`runtime/run.json` is the immutable capture manifest, SHA-256
`80bb36ceaf8f1955d799dbdbbda59bf2a1e64ab5964f95a9078ab88787873e0f`.
`runtime/result.json` is the fail-closed candidate PASS, SHA-256
`0573ec8d88b71db81c20e4be01295175353fe33ce64660ac8e706f892929a7f5`.

The archive contains two fresh ACTIVE and two fresh CONTROL runs for each observer mode:

- exact-register interpreter: fixed `1262/60/18` debugger schedule over 1,340 frames;
- normal DRC: one uninterrupted `run 1340`, with no MMIO/register-PC observer.

The interpreter transaction frame is exactly `T_I=1264`. Every approved protocol, park,
dispatcher, context, stack, COMM, mailbox, canary, source/result, write-exclusion, lifecycle,
and terminal predicate passes. The source/preimage SHA-256 is
`2398c10d257a2129609e6ec502032dca0e223a0d3281a350555724e2d7795098`.
ACTIVE's result is Q-026-identical at
`4e4607a0de55c687050e0b622dae25372ece397d1442dc04f047ed4ffd0b724b`,
with changed byte offsets exactly
`[14,15,23,118,119,123,236,237,238,239,247]`. CONTROL preserves the preimage.

The interpreter does **not** have blanket framebuffer equality. It retains one exact displayed
buffer CRC mismatch at `T_I+2`, frame 1266:

| Frame | Relative | ACTIVE CRC | CONTROL CRC |
|---:|---:|---:|---:|
| 1266 | `T_I+2` | `344A67A6` | `D08BAC75` |

CRC equality resumes exactly at `T_I+3` and remains uninterrupted through terminal `T_I+75`.
Full profile equality resumes exactly at `T_I+6` and remains uninterrupted through terminal.
The complete Master/Slave cycle-delta positions and values are recorded in `result.json`; no
other profile field differs. Both repeats reproduce byte-identical profile, watch, MMIO,
register, write, and caller artifacts within each arm. The accepted interpreter profile hashes
are `3648dce1…c7c54` ACTIVE and `ddfd92d8…ca294` CONTROL.

Normal DRC records `T_D=1262`, no displayed CRC mismatch, and only the exact transaction-row
cycle deltas: Master `17125/15859` and Slave `306554/306574`. Full profile equality resumes at
`T_D+1` and continues through `T_D+77`. DRC profile hashes are `6ba77d00…f2ad` ACTIVE and
`2abd80e2…68b5` CONTROL. `$FFC80C`, cache-through FBCTL `$2000410A`, all five exact write
targets, and the full scene-handler caller trace are pair- and repeat-exact in both modes.

The runtime tool verifier pins the frontend (`626c2c…4097`), passive core
(`08a791db…9871`), PicoDrive source overlay, preparation script, command schedules, and runtime
tool (`c26e52fb…45f9`). Ten runtime test methods exercise 45 fail-closed mutations covering
fixture/tool policy, command splits, missing/reordered rows, every convergence boundary,
cycle/CRC values, common profile fields, display/swap/write/caller chronology, repeat
determinism, seed/protocol/mailbox evidence, diagnostic identities, and forbidden promotion,
authority, bridge, collision, cadence, CPU-budget, or FPS claims.

## Ineligible diagnostics

The capture manifest separately hash-binds all proposal-shaping evidence as ineligible:

- the failed v3 pilot and its exact command file;
- the v4 candidate2 strict-equality failure;
- DRC, split-DRC, Q-026 interpreter, 1,400-frame interpreter, late-interpreter,
  interpreter-convergence, and DRC-convergence diagnostics.

These files explain the design and failure history but cannot substitute for the fresh
post-approval runs. The v3 pilot records stock cmd `$02` retaining COMM0_LO=`$02`; candidate2
proved the v4 transport while correctly failing the old blanket paired-framebuffer predicate.

## Claim boundary

A candidate PASS proves only one bounded Master-COMM0, real-stock-table `$3F` player-shadow
invocation with exact deterministic convergence in the pinned PicoDrive fixture. It does not
validate render equivalence. The one interpreter-observed displayed-buffer mismatch is retained,
not suppressed.

There is no legacy shared-lane parameter transport, renderer bridge or descriptor consumption,
AI/collision execution, persistent authority, 68000 bypass, cadence/scaling change, CPU-budget
result, FPS result, real-hardware proof, or cmd `$3F` promotion. Consecutive emulated capture rows
prove no missing/reordered captured frame; they do not prove host presentation or physical TV
scanout.

## Reproduction

```sh
make q027-cmd3f-roms
make q027-runtime-tools
make q027-runtime-validate
python3 tools/libretro-profiling/test_verify_q027_cmd3f_rom_pair.py
python3 tools/libretro-profiling/test_q027_cmd3f_runtime.py
```

The runtime capture itself is intentionally new-directory-only. Re-capture requires the exact
ACTIVE/CONTROL ROMs, pinned frontend/core, all listed diagnostic sources, and the approved
1,340-frame schedules.
