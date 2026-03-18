# VRD Agent Team (v4 — VR60)

Specialized agents for the VR60 architectural redesign of Virtua Racing Deluxe (32X).
Agent definitions live here. Runtime state lives in `analysis/agent-scratch/` (gitignored).

## Team Members

| Agent | File | Model | Role |
|-------|------|-------|------|
| **Worker** | [worker.md](worker.md) | Opus (default) | All technical work — 68K→SH2 porting, SDRAM integration, build, test |
| **Auditor** | [auditor.md](auditor.md) | Opus | Safety review — COMM, SDRAM addressing, bus contention, double-buffer races |

## How It Works

```
You (main session)
  → Pick phase from VR60_ROADMAP.md
  → Resolve open questions (Q-xxx) for that phase BEFORE spawning Worker
  → Spawn Worker with phase description + relevant roadmap section
  → Worker researches, analyzes, implements, builds
  → Worker flags "AUDITOR REVIEW REQUESTED" (ALL VR60 work touches SH2)
  → You spawn fresh Auditor with the proposal
  → APPROVED → Worker implements. BLOCKED → fix or rethink.
  → Worker writes findings to analysis/agent-scratch/worker/findings.md
  → You review findings, update VR60_ROADMAP.md (decisions, risks, lessons)
  → You commit if appropriate
```

No intermediary coordination agent. You are the task manager.

## Model Selection

**Opus is the default for all VR60 work.** Every phase involves SH2 code, COMM protocol,
expansion ROM, and SDRAM addressing — exactly the domain where subtle encoding errors
and hardware race conditions are most dangerous.

Use Sonnet only for: documentation updates, profiling runs, 68K-only changes that
don't interact with SH2.

## Research-First Principle

**Understand before you act.** This is 1994 hardware with undocumented quirks.

Before implementing: read the relevant docs, build a mental model with citations.
If a second attempt fails for related reasons: stop coding, go read docs.
If you're saying "maybe" or "let's try": stop, that's guessing.

**Named anti-patterns (banned):**
- **Address shopping** — moving variables without understanding why they fail
- **Circular investigation** — try → fail → try slightly different → fail
- **Modern platform assumptions** — assuming modern OS/hardware behavior
- **Undocumented guessing** — "maybe it's X" without a doc reference
- **Armchair analysis** — reasoning pivots without reading a document

## VR60 Architecture Context

All agents must understand the target architecture:

| CPU | Current Role | VR60 Role | Target Util |
|-----|-------------|-----------|-------------|
| 68K | ALL game logic (100.1%) | Thin coordinator: I/O, sound, VDP | <30% |
| Master SH2 | Block copies (33%) | Game logic engine: physics, AI, collision | 40-60% |
| Slave SH2 | ALL rendering (78%) | Rendering engine (unchanged) | 50-78% |

Key infrastructure:
- **cmd $3F handler** at expansion ROM $301500 (jump table $3F → $02301500)
- **SDRAM mailbox** at $0600BC00 (controller input, scene cmds, sound queue)
- **Entity tables** relocating from 68K WRAM $FF9000 → SDRAM $06008000
- **Data transfer** via SDRAM direct writes (no COMM for bulk data)

## Key References

| What | Where |
|------|-------|
| **Living roadmap** | VR60_ROADMAP.md |
| Hardware constraints (13) | VR60_ROADMAP.md §3 |
| Open questions (9+) | VR60_ROADMAP.md §12 |
| Risk registry (9+) | VR60_ROADMAP.md §14 |
| Topic lookup table | analysis/agent-scratch/oracle/index.md |
| Hardware pitfalls (68+) | KNOWN_ISSUES.md |
| COMM register deep dive | analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md |
| Physics architecture | analysis/PHYSICS_SYSTEM_ARCHITECTURE.md |
| AI architecture | analysis/AI_SYSTEM_ARCHITECTURE.md |
| Collision architecture | analysis/COLLISION_SYSTEM_ARCHITECTURE.md |
| Entity architecture | analysis/ENTITY_OBJECT_ARCHITECTURE.md |
| Worker findings output | analysis/agent-scratch/worker/findings.md |

## Roadmap Maintenance

After every session:
1. Update `VR60_ROADMAP.md` — open questions, decisions, risks, lessons learned
2. Update `analysis/agent-scratch/oracle/index.md` if new architectural facts established
3. Update phase status (NOT STARTED → IN PROGRESS → COMPLETE)
