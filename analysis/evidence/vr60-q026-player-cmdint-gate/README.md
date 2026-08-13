# Q-026 bounded player-physics CMDINT gate

**Result:** validation-stage PASS on 2026-08-12. This gate is deliberately
non-promotable. It proves one bounded, direct Master-CMDINT invocation of the
existing player-physics sequence on the trustworthy normal-1P boot fixture. It
does not enable cmd `$3F`, transfer authority, validate collision or a render
bridge, change cadence, or establish an FPS result.

## Static pair

- ACTIVE ROM: `c9358ad4ff04d7420c7bef1f45c163afb4506efae4990c4b48a475188e0b76f8`
- STAGE-CONTROL: `240dfd0a8df87a8118982849f354bc720b0011d480221f2031e3ceeb6dc1a66d`
- The sole pair delta is the exact eight-byte file interval
  `$01C8EC-$01C8F3`: ACTIVE's `ORI.B #1,$00A15103` versus four CONTROL NOPs.
- Player handler: `5f9cf17e9e00faef062c45d21e49971216a06c39b1c628e40928724a883bccdd`
- Unified external ISR: `288b56336f79c74cdbb7a53adc7dbae5d1429928cd23ba12173cbbd7ff1e4ee3`
- Static manifest: `tools/libretro-profiling/q026_player_rom_pair.json`, SHA-256
  `a1267c452d1577c2f486368d92fd6628e92a4d9800bd3e38bf0108db519ac235`.

The verifier pins the ordinary default and accepted Q-020/Q-021/Q-023
identities, allocation/padding/literal ownership, exact stack frames, live-SR
classification, direct call graph, field/write allowlists, cache-through
addresses, immediate write readbacks, source mutual exclusion, and the sole
pair edge. Its 13 adversarial tests pass, including removal of the
admission-local canary refresh.

## Runtime pair

`runtime/run.json` is the immutable four-run capture manifest (ACTIVE and
CONTROL, two repeats each), SHA-256
`2589fe921b53fea881099d32d1b7268740a7ed205b6067d8ee9732600a7223fc`.
`runtime/result.json` is the fail-closed PASS result, SHA-256
`b181c7a9f1141459fca377c9dc143c97be3e5d98aef8d889ed5469ea893a71c4`.

Every run reaches exactly one accepted 320-byte mode-0 seed. ACTIVE records
exactly one CMD edge, ISR entry, and completion; CONTROL records none. The
handler input equals the accepted `$FF6A00 -> $0600F20C` seed byte-for-byte.
ACTIVE changes only enumerated entity/global fields and preserves `+$CE`,
`+$D2`, `+$D6`, and `+$DA`; CONTROL leaves the record unchanged. Ordered trace,
sentinel, admission-local canary, stock-stack, dedicated-stack, system-register,
SDRAM, and framebuffer write observations all pass their exact allowlists.

At the exact ACTIVE admission edge, COMM1/COMM2/COMM7 are
`0101/003A/0000` before and after direct work, so COMM2_HI is zero there and no
mailbox value changes. Pair/repeat framebuffer CRC, scene/state, caller/write
chronology, lifecycle, and terminal dual-SH2 state are exact. The passive
recorder core is SHA-256
`17d16aa506cef1bc215b290b20248b458b22b54374ae342a72eb2f3c2033e906`; a
fresh `make q026-runtime-tools` reproduces it byte-for-byte. Six runtime
adversarial tests pass and reject identity tampering, COMM snapshot mismatch,
out-of-range direct writes, canary corruption, and CONTROL direct work.

## Retained failed pilot and limitation

The original startup-only canary assumption failed closed because
`$2600FB90` was zero by racing. The raw diagnostic remains in the runtime
archive as `q026-active-watch.csv` (SHA-256
`5b506f2d4da0079293f1735bc059eefffa21257517b86d83be265f169306d427`)
and `q026-active-pilot.txt` (SHA-256
`b56f839bee2af09953c83dd85fdc0cc8912c65710a1b599189099417c42f2e6b`).
The approved correction writes and immediately reads the canary at CMD
admission before the first dedicated-stack write, then checks it again after
return.

COMM2_HI is proven zero at the exact admission edge. Unrelated stock renderer
traffic can legitimately make it non-zero at other frame-boundary samples; no
broader “always idle” claim is made. Cmd `$3F` shadow work, bridge, collision
equivalence, authority, cadence/scaling, real hardware, and 60 FPS remain open.

## Reproduction

```sh
make q026-runtime-tools
make q026-runtime-validate
python3 -m unittest \
  tools/libretro-profiling/test_verify_q026_player_rom_pair.py \
  tools/libretro-profiling/test_q026_player_runtime.py
```
