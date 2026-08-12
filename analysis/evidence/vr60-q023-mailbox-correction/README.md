# VR60 Q-023 cmd `$3F` mailbox-correction evidence

Q-023 is a **static, source-built isolation gate**. It corrects the dormant
cmd `$3F` handler's mailbox literal from cache-through cartridge ROM
`$2200BC00` to cache-through SDRAM `$2600BC00` in a validation-only ACTIVE
image. It does not execute or promote cmd `$3F`.

## Proven boundary

- Both handler artifacts are 428 bytes at file `$301500-$3016AB`.
- The handler load at relative `$012` remains opcode `$D449`
  (`MOV.L @($49,PC),R4`) and resolves to the 4-byte-aligned literal at relative
  `$138`, file `$301638`.
- A complete scan of the executable handler range finds exactly that one
  PC-relative user of the literal.
- ACTIVE and STAGE-CONTROL differ at exactly file `$301638`, byte `$22->$26`.
- STAGE-CONTROL is byte-identical to the accepted ordinary mode-0 default.
- The cmd `$3F` jump-table entry remains `$02301500`.
- The accepted default and all three mode-1 and mode-2 identities remain exact.

## Identities

| Artifact | SHA-256 |
|---|---|
| Q-023 ACTIVE ROM | `8709aed4fc16d548b06694a92361a240537fbae7f987ee5f00a62c3c995a59ef` |
| Q-023 STAGE-CONTROL ROM | `6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900` |
| Ordinary default ROM | `6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900` |
| Legacy handler | `1927dd8fb011634913888e9d250abbb202a530e22ccf059e53cb28570e9a69e5` |
| Corrected handler | `ec64257c82b599508b428b515e22d3090a24894964c046b7d636ef87b6b2c163` |
| Mode-1 ACTIVE / CONTROL / ISR | `963658608b13a96981b8bca60c5e7225df7cf148b138cdf1a1d6982487ff4470` / `391774569d17d2461decad5d002c9215914a84649b094b10a051b21b5348e9fd` / `6316a0d228dc3db8a48ecdef3b34e0962e04db35c4ef085ec17aea8873146916` |
| Mode-2 ACTIVE / CONTROL / ISR | `96d79e3fb4d2df8a69852917ac811f860935ae950fc87222d008fa45d47ee276` / `da5ce4ec9ef8e050c7babeb113e26aa7335a3ff5285285e55a6606d2f96309b8` / `b7fc5726dd503f35f08625a6159bed2cff06720ea85a89848bc2e70e64eaaaa7` |
| Static manifest | `23ca15647ffe283c3b2a9169545791f80c81b624246431c1d90ee8ab38352199` |

The canonical manifest is
[`tools/libretro-profiling/q023_mailbox_rom_pair.json`](../../../tools/libretro-profiling/q023_mailbox_rom_pair.json).
It records `static_eligible: true` for the structural gate but `eligible: false`
and `promotable: false`, because neither artifact executes cmd `$3F`.

## Reproduction

```bash
make clean
make all
make mode1-gate-validate
make mode2-gate-validate
make q023-mailbox-roms
python3 -m unittest tools/libretro-profiling/test_verify_q023_mailbox_rom_pair.py
```

The clean default build reproduced `6f2768f2…2523900`; both composed prior
gates passed; Q-023 passed with 11 focused test methods covering wrong mailbox
data, extra ROM deltas, accepted-identity drift, jump-table drift, opcode and
literal-owner drift, source-build guard removal, Q-023 leakage into the 68K
hook, and accidental cmd `$3F` enablement.

## Explicit exclusions

No Q-023 artifact enables the normal-1P cmd `$3F` trigger. Therefore this gate
does not prove mailbox contents at runtime, COMM ownership or ordering, SH2
physics/AI correctness, persistent AI-buffer ownership, Slave retrigger safety,
renderer integration, authority transfer, cadence, FPS, reset safety, or real
hardware. Those belong to the next independent observable-shadow gate.
