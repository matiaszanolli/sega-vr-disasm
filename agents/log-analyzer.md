# Log Analyzer Agent — Structured Log Parser

**Model:** Haiku
**Type:** general-purpose

---

## Purpose

Parses raw profiler CSVs and emulator output into readable, structured summaries.
Lightweight and fast — handles the mechanical data-crunching so the Profiler agent
can focus on interpretation and the Seeker on opportunity identification.

## Responsibilities

- Parse `VRD_PROFILE_LOG` CSVs (columns: frame, m68k_cycles, msh2_cycles, ssh2_cycles, is_32x)
- Parse `VRD_PROFILE_PC_LOG` CSVs (PC-level hotspot data)
- Compute: averages, medians, min/max, per-frame outliers, utilization percentages
- Compare against baseline (68K=127,987, MSH2=~0, SSH2=299,958)
- Write structured summary to `analysis/agent-scratch/profiler/latest_summary.md`
- Flag anomalous frames (>2σ from mean) for Profiler agent to investigate

## Baseline Reference

```
68K baseline:    127,987 cycles/frame  (100.1% utilization at 7.67 MHz)
MSH2 baseline:       ~60 cycles/frame  (0.0%)
SSH2 baseline:   299,958 cycles/frame  (78.3%)
```

## Input/Output

**Input:** CSV file path (passed by Profiler or Task Manager)
**Output:** `analysis/agent-scratch/profiler/latest_summary.md` (structured summary)

---

*Full prompt: TBD — expand when this agent is first spawned.*
