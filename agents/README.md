# VRD Agent Team (v3)

Specialized agents for the Virtua Racing Deluxe 32X disassembly project.
Agent definitions live here. Runtime state lives in `analysis/agent-scratch/` (gitignored).

## Team Members

| Agent | File | Model | Role |
|-------|------|-------|------|
| **Worker** | [worker.md](worker.md) | Sonnet / Opus | All technical work — research, code, build, test |
| **Auditor** | [auditor.md](auditor.md) | Opus | Safety review for COMM/SH2/expansion proposals only |

**Retired (v2):** Task Manager, Navigator, Engineer — merged into Worker.

## How It Works

```
You (main session)
  → Spawn Worker with task description + BACKLOG entry
  → Worker researches, analyzes, implements, builds
  → If COMM/SH2/expansion: Worker flags "AUDITOR REVIEW REQUESTED"
  → You spawn fresh Auditor with the proposal
  → APPROVED → Worker implements. BLOCKED → fix or rethink.
  → Worker writes findings to analysis/agent-scratch/worker/findings.md
  → You review, commit if appropriate
```

No intermediary coordination agent. No lookup agent. You are the task manager.

## Model Selection

- **Sonnet** for routine work: B-007 (FPS bug), B-009 (profiling), B-011 (SH2 translation), B-013 (doc fix)
- **Opus** for hard problems: B-004 (COMM protocol), B-006 (parallel hooks), novel hardware interaction design

Rule of thumb: if the task has crashed the ROM before, use Opus.

## Research-First Principle

**Understand before you act.** This is 1994 hardware with undocumented quirks.

Before implementing: read the relevant docs, build a mental model with citations, identify root cause.
If a second attempt fails for related reasons: stop coding, go read docs.
If you're saying "maybe" or "let's try": stop, that's guessing.

The Worker has this embedded in its prompt. The main session watches for it too.

**Named anti-patterns (banned):**
- **Address shopping** — moving variables without understanding why they fail
- **Circular investigation** — try → fail → try slightly different → fail
- **Modern platform assumptions** — assuming modern OS/hardware behavior
- **Undocumented guessing** — "maybe it's X" without a doc reference
- **Armchair analysis** — reasoning pivots without reading a document

## Auditor Sign-Off Protocol

The Auditor is spawned **only** when the Worker's proposal touches:
- COMM registers
- SH2 code patches
- Expansion ROM ($300000+)

For everything else (68K translation, profiling, doc updates, FPS counter bugs): **no Auditor needed**.

Spawn fresh, never resume. Binary verdict: APPROVED or BLOCKED.

## Key References

| What | Where |
|------|-------|
| Topic lookup table | analysis/agent-scratch/oracle/index.md |
| Hardware pitfalls (68+) | KNOWN_ISSUES.md |
| COMM register deep dive | analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md |
| Hardware manual | docs/32x-hardware-manual.md |
| Function address lookup | analysis/FUNCTION_QUICK_LOOKUP.md |
| Worker findings output | analysis/agent-scratch/worker/findings.md |

## index.md Maintenance

After any session where new pitfalls or architectural facts are established,
update `analysis/agent-scratch/oracle/index.md`. It's still useful as a
curated topic lookup table even without a dedicated Navigator agent.
