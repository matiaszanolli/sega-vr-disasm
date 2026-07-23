# VR60-008 Full-Control Evidence

This directory preserves the complete failed VR60-008 validator output. The archive contains the
exact seven files written under `/tmp/vr60-008-full-control-zVO1uD/artifacts`; it was not produced
by rerunning the emulator or validator.

`artifacts.tar.gz` is a deterministic archive with normalized member order, ownership,
permissions, and timestamp. Rebuilding it twice from the surviving source directory produced the
same SHA-256:

```text
8bd15a1836686d9fcd9e027e2991bcc14ee794a1337fc6ff3f375ba5c9ef00b3  artifacts.tar.gz
```

## Exact validator command

```bash
python3 tools/libretro-profiling/validate_1p_control.py \
  build/vr60_control_bypass.32x \
  --reference-rom build/vr60_live_reference.32x \
  --savestate /home/matias/.picodrive/mds/vr60_control_bypass.mds \
  --input-script tools/libretro-profiling/fixtures/vr60_006_control_replay.csv \
  --warmup-frames 360 \
  --frames 18000 \
  --output-dir /tmp/vr60-008-full-control-zVO1uD/artifacts
```

No diagnostic, offline-analysis, input, threshold, or policy override was present. The frontend
completed 18,360 frames; the validator exited 1 with `passed: false` and 300 findings. `run.json`
records the complete provenance, fixed thresholds, and reviewed tool/input identities.

## Archived members

| Member | Bytes | Physical lines | Data rows | SHA-256 |
|---|---:|---:|---:|---|
| `caller.csv` | 29,345 | 1,285 | 1,282 caller hits | `900a40890318bd4039601fb094840cdfbbf3a8ecb31570a17c115c6bec72d851` |
| `frames.csv` | 1,277,796 | 18,361 | 18,360 frames | `b0ea95391434e49543d98f85b37953a6aee475dd9e3a221629ae4728272c822d` |
| `frontend.log` | 1,955,313 | 35,720 | n/a | `151e6e7458c1e222a93a4e7b86934381bb65683046862203980c660b4faf3c55` |
| `pc.csv` | 25,869 | 640 | 639 histogram rows | `b7b781321e74a6941dd85910ffd27dfd3cbdddf4aa0d2fed10e852f6ff67eeef` |
| `result.json` | 36,430 | 1,221 | n/a | `bcdaf92a44749a3ade515d7c4ae052ecbb89a96226ecbeaaa3e89563ef02d991` |
| `run.json` | 3,656 | 76 | n/a | `361104d02e876e2dff7c69aeb980f06e196d0c63b6e9097dc22a8c82e5794cca` |
| `watch.csv` | 558,109 | 18,361 | 18,360 frames | `d199920d2f2899e324ea7d820586f0c93c90c813b8a5cfd0e1634c5a6c51f10d` |

The exact caller footer is:

```text
# COMPLETE frames=18360 hits=1282 logged=1282 dropped=0
```

## Raw chronological excerpts

`frames.csv` first departs from the expected `$0000/$0004/$0008/$000C` state order at frame
4536, while its sampled scene low word remains `$4CBC`:

```csv
frame,m68k_cycles,msh2_cycles,ssh2_cycles,m68k_useful,msh2_useful,ssh2_useful,active,fb_crc,scene,state,is_32x
4531,127994,2321,307272,16186,1150,0,1,0x6EDB27D7,0x4CBC,0x0000,1
4532,127981,257116,307118,68128,257116,213569,1,0xF233A115,0x4CBC,0x0004,1
4533,127995,218032,306640,62047,218032,275110,1,0xD8FEF9F7,0x4CBC,0x0008,1
4534,127978,15185,307015,39908,14117,282577,1,0x31FE2C69,0x4CBC,0x000C,1
4535,127994,2321,307272,16178,1150,0,1,0xF5CEBF79,0x4CBC,0x0000,1
4536,127980,257116,307118,11956,257116,213569,1,0xF233A115,0x4CBC,0x0008,1
4537,127993,216891,306623,18120,216891,275097,1,0x2B7914DC,0x4CBC,0x0008,1
```

`watch.csv` places the later sampled events in this order. `$20004020` is the watched COMM0_HI
byte:

```csv
frame,0xFF0002,0x20004020,0x20004023,0x20004024,0x2000402E
4538,0x884CBC,0x0,0x1,0x0,0x0
4539,0x884CBC,0x1,0x0,0x0,0x0
5127,0x884CBC,0x1,0x0,0x2,0x0
5128,0x88FB98,0x1,0x0,0x1,0x0
5129,0x88FB98,0x1,0x0,0x1,0x0
5130,0x88FB98,0x0,0x0,0x0,0x0
5134,0x8909AE,0x0,0x0,0x0,0x0
5150,0x891122,0x0,0x1,0x0,0x0
```

These samples establish observation order only: state-order discontinuity at frame 4536,
continuous sampled COMM0_HI non-zero beginning at frame 4539, and the first scene-pointer change
at frame 5128. They do not establish the writer, gameplay condition, root cause, or a causal link
among the state, COMM, scene, hook, framebuffer, and Slave-SH2 findings.

## Verification

Extract into a new temporary directory, then compare each member against the table above:

```bash
mkdir -p /tmp/vr60-008-evidence-check
tar -xzf analysis/evidence/vr60-008-full-control/artifacts.tar.gz \
  -C /tmp/vr60-008-evidence-check
sha256sum /tmp/vr60-008-evidence-check/artifacts/*
```
