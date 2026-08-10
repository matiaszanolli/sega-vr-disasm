# Q-020 CMDINT probe task 1

Status: **PASS as an isolated, non-promotable diagnostic probe.** This evidence
does not enable mode 1 or command `$3F`, transfer authority to SH2, establish
organic name-entry coverage, or authorize a default-ROM change.

## Scope and hardware contract

The 32X supplement requires one handler address for each odd/even external
vector pair and the FRT/TOCR corrective action inside every external interrupt
handler (`docs/32x-hardware-manual-supplement-2.md`, lines 14-42 and 316-381).
It also requires a same-address read after clearing an interrupt source because
the SH2 write buffer can otherwise let execution continue before the clear is
externally complete.  The SH7604 manual additionally requires at least one
instruction between that synchronization read and `RTE`
(`docs/sh7604-hardware-manual.md`, lines 1888-1892).

The probe therefore redirects all 16 Master external vectors to `$02303B00`,
toggles FRT TOCR bit 1 on entry, distinguishes the saved-SR interrupt level,
and accepts only CMD level 8 and unmaskable VRES level 14.  Stock Master code
enables no ordinary V/H/PWM route that can safely be delegated; any third level
records error `$7E` and hard-stops.  CMD handling preserves the complete system
mask word, masks only CMD, clears and reads back `$2000401A`, restores and reads
back the exact pre-mask word, and publishes terminal phase 2 only after both
readbacks succeed.  All system/COMM accesses use cache-through aliases, as
required by `analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md`, lines 167-212 and
380-427.

The normal and name-entry route installers target the same one-shot 68K wrapper.
The write trace, rather than the final handler value alone, pins the installer
PC: `$0088E0D4` for normal entry and `$00891822` for name-entry re-entry.

## Static identity

- Default ROM: `6f2768f2cffc85cdc815a67c9f13837112829edac3f0921a57454e79e2523900`
- Probe ROM: `8766714e5bdfc4cb9a8dcecb1a0ce23e1d3e67a54cdfc7473e3b9cbecb6a91e7`
- ISR binary (452 bytes): `be3e5a944ad46b48533bc80f76452e768fad0f3a929d1dcbb54b4caf30b621c3`
- Probe frontend: `626c2c148aa1dca10f2893bc6e9ac59dad237f5043763567ef73b0f9868bcc50`
- Probe PicoDrive core: `b2fe478891e8cb5299fefc22bb908a67b80a804df379f7724ed212c0e1b1a333`
- Canonical frontend, preserved: `cf93393318db52a1d0071b35c708bf10710ed6dfbc617c22e8e339eedac87e9f`
- Canonical core, preserved: `5677ea8e083f887b2b4e9cabf84dd559a9c6b1180adfa09f34a50023ff7548e8`

The verifier enumerates every SH2 `MOV.L @(disp,PC)` user of the modified
startup literal: the only user is file `$020438`, resolving to `$020480`.
The linked ELF pins `q020_cmdint_probe_init` at `$02303C50`.  It also enumerates
all literal users resolving into the ISR allocation, including the pre-existing
external user `$3039FC -> $303CB4`, whose `$FFFFFFFF` target is preserved.

## Runtime result

The fail-closed validator accepts this exact chronology:

1. Cold boot reaches stock Master initialization and its idle loop with trace
   phase 0 and `init_count=1`.
2. Normal entry is installed by 68K PC `$0088E0D4`; one CMD interrupt completes
   with phase 2, sequence 1, `CMD=1`, `VRES=0`, error 0, saved SR `$81`, and
   saved SPC `$06000460`.
3. One frontend `retro_reset` produces one VRES and the reset-flow CMD.  The
   final trace is phase 4, sequence 3, `CMD=2`, `VRES=1`, error 0; the Master is
   live at stock PC `$06000452` and the Slave is live at `$060003D0`.
4. `init_count` changes from 1 to 3 for that one VRES.  This is intentional and
   pinned: the stock VRES continuation first reaches the startup `JSR` at
   `$06000438` (count 2), then the reset-flow CMD delegates at `$060004E8` and
   reaches the same startup `JSR` a second time (count 3).
5. The seeded name-entry diagnostic executes the authentic installer at 68K PC
   `$00891822`, then produces the same phase-2 CMD result.

The name fixture is not an organic gameplay capture.  `runtime/run.json` pins
the source state hash and every transformation: all Master vectors and the
startup literal are rebound to the probe, the trace is initialized to one
completed startup, the fifth score slot is changed from the sentinel to
`$00010000`, `$A042` changes from 1 to 0, and the one-shot changes from 1 to 0.
The validator regenerates the fixture byte-for-byte and rejects any broader
claim through `organic_gameplay=false` and
`evidence_scope=diagnostic_route_feasibility`.

## PicoDrive parity and reset caveat

PicoDrive revision `26ecb2b6358fefba24e3d68b9eb2efba7f10d5ee` had optimized
68K byte/word writes to the 32X interrupt-control register that stored INTM but
did not run the canonical IRQ-recomputation side effect.  The tracked
`tools/libretro-profiling/libretro_q020_cmdint_irq_parity.patch` forwards both
fast paths to `p32x_reg_write8`.  `make q020-runtime-tools` idempotently applies
that exact patch only when its forward preimage matches, rejects ambiguous
source, clean-builds PicoDrive, writes only the separately named Q-020 tools,
and pins both output hashes.  The recorded build used GCC 15.2.0 and GNU Make
4.4.1.

A historical two-edge probe exposed the unpatched fast-path defect: probe ROM
`88df9065535c408f682f9ecbc71997e7d7819ee4db5ea658d649641417ce4605`
with canonical core `5677ea...` ended at phase 1, sequence 1, boot count 1,
diagnostic count 0, error 0, event 1, and one-shot 1; the second edge was absent.
That observation predates this artifact directory and its raw log was not
archived.  The redesigned one-edge current probe can pass on the canonical core
through a later IRQ recomputation, as the pinned comparison shows; that does
not disprove the source-level fast-path defect and is not used as immediate
edge-parity proof.

PicoDrive emits exactly
`ssh2 drc: unhandled op 4778 @ 0600063a` at the reset boundary.  The same line
is captured once at the same post-reset frame in
`runtime/default-reset-baseline.txt` using the accepted default ROM and
canonical core; both Master and Slave are live 30 frames later.  The probe VRES
capture demonstrates the same one-line baseline behavior and subsequent
dual-SH2 liveness.  The validator permits only that exact line, once, after the
pinned `retro_reset` command, in those two logs.  Any other `unhandled op`, any
`illegal opcode`, crash marker, non-terminal shutdown, debugger failure, probe
error, incomplete trace, or artifact mismatch is fatal.

## Reproduction

```bash
make clean
make all
make q020-cmdint-probe
make q020-runtime-tools

python3 tools/libretro-profiling/q020_cmdint_runtime.py capture \
  --rom build/vr60_q020_cmdint_probe.32x \
  --default build/vr_rebuild.32x \
  --frontend tools/libretro-profiling/q020_profiling_frontend \
  --core tools/libretro-profiling/q020_picodrive_libretro.so \
  --canonical-frontend tools/libretro-profiling/profiling_frontend \
  --canonical-core tools/libretro-profiling/picodrive_libretro.so \
  --name-source-state /tmp/q020_after_results.mds \
  --output-dir analysis/evidence/vr60-q020-cmdint-probe/runtime

python3 tools/libretro-profiling/q020_cmdint_runtime.py validate \
  analysis/evidence/vr60-q020-cmdint-probe/runtime/run.json \
  --result analysis/evidence/vr60-q020-cmdint-probe/runtime/result.json

python3 -m unittest \
  tools/libretro-profiling/test_verify_q020_cmdint_probe.py \
  tools/libretro-profiling/test_q020_cmdint_runtime.py -v
```

Capture requires the pinned name-source state.  The archived copy is
`runtime/name-source.mds`; reruns may pass that file as `--name-source-state`.
Because capture refuses an existing output directory and validation refuses an
existing result path, move the old directory aside before a full recapture.
