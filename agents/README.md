# VRD Agent Team

Specialized agents for the Virtua Racing Deluxe 32X disassembly project.
Agent definitions live here. Runtime state lives in `analysis/agent-scratch/` (gitignored).

## Team Members

| Agent | File | Model | Role |
|-------|------|-------|------|
| **Task Manager** | [task-manager.md](task-manager.md) | Sonnet | Session coordinator — orients, delegates, manages Auditor gate |
| **Navigator** | [navigator.md](navigator.md) | Haiku | Fast index lookup — "where is X?" → file + section. Never answers from memory. |
| **Engineer** | [engineer.md](engineer.md) | Sonnet | All technical work — reads code, profiles, proposes patches, verifies encodings |
| **Auditor** | [auditor.md](auditor.md) | Opus | Pre-implementation safety reviewer — fresh spawn per proposal, binary verdict |

## Research-First Principle

**The #1 rule for this project: understand before you act.**

This is a 1994 hardware platform with undocumented quirks, bizarre address mirroring,
shared-bus hazards, and no memory protection. Assumptions from modern platforms do not
apply. The project has ~2,000 pages of hardware documentation in `docs/` and extensive
analysis in `analysis/`. These exist to be read, not skipped.

**Before implementing any fix or feature, the Engineer must:**
1. Identify what it doesn't understand about the system
2. Read the relevant primary documentation (hardware manual, analysis docs)
3. Build a mental model grounded in documented facts
4. Only then propose a solution

**The Task Manager enforces this** via the Research Gate (Step 2.5). If a task involves
unexplained behavior, no implementation proceeds until the root cause is documented.

**Named anti-patterns (banned):**
- **Address shopping** — moving variables around without understanding why they fail
- **Circular investigation** — try → fail → try slightly different → fail → ...
- **Modern platform assumptions** — assuming modern OS/hardware behavior
- **Undocumented guessing** — "maybe it's X" without a documentation reference
- **Armchair analysis** — reasoning about hardware from first principles instead of
  reading the manual. Symptom: chains of "But wait" / "Actually" pivots without reading
  a document in between. Rule: 2+ reasoning pivots without a doc read = circuit breaker

**Stuck/Guessing Circuit Breaker:** If we notice we're stuck and/or guessing, it's time
to research and plan again. Specifically: if a second attempt fails for related reasons,
or anyone starts "trying things" without documented justification, ALL implementation
stops and we return to the Research Phase. 2+ reasoning pivots ("But wait" / "Actually")
without reading a document in between is also a trigger. The Task Manager enforces this,
but any agent (or the user) can trigger it.

## Session Flow

```
Task Manager
  → Step 1: Spawn Navigator (Haiku, loads index.md — fast, cheap, respawn freely)
  → Step 2: Orient on task (read BACKLOG, present options if needed, user decides)
  → Step 2.5: Research Gate (for bugs/unexplained behavior)
       → Engineer reads documentation, builds mental model, identifies root cause
       → Task Manager verifies: every claim backed by documentation?
       → PASS → proceed to implementation
       → FAIL → more research needed
  → Step 3: Spawn Engineer (Sonnet, does all technical work)
       ↔ queries Navigator: "where is X?" → reads primary source directly
       → produces analysis, profiling, and/or a concrete proposal
  → Step 4: Spawn Auditor (Opus, fresh per proposal — NEVER resumed)
       → APPROVED → Engineer implements
       → BLOCKED  → fix required → user decides → retry
  → Step 5: Wrap up — draft BACKLOG + index updates, present to user for approval
```

## Invocation

**Task Manager** is the normal entry point. Invoke before any game code work.

- User-invoked: `/task-manager` skill, or "start the task manager"
- Auto-invoked: whenever a session is about to touch game code (CLAUDE.md trigger)

## Navigator Query Protocol

Any agent queries Navigator by resuming its session ID:

```python
nav_id = read("analysis/agent-scratch/navigator/session_id.txt").split("\n")[0]
answer = Task(
    subagent_type="general-purpose",
    model="haiku",
    resume=nav_id,
    prompt="Navigator: [where is X documented?]",
    description="Navigator: [topic]"
)
```

Navigator responds with `[file] § [section]`. The caller reads that file directly.
Navigator never summarizes or answers from memory.
If the session ID is stale, respawn from navigator.md — it loads one file.

## Auditor Sign-Off Protocol

Task Manager spawns a **fresh** Auditor with the complete proposal:

```python
verdict = Task(
    subagent_type="general-purpose",
    model="opus",
    prompt=<auditor startup prompt with proposal filled in>,
    description="Auditor: [B-XXX proposal review]"
)
```

Auditor is **never resumed**. Each spawn is an independent safety review.

## index.md Maintenance Rule

The Navigator's only source is `analysis/agent-scratch/oracle/index.md`.
After any session where new pitfalls or architectural facts are established,
update the index before closing. See [navigator.md](navigator.md) §index.md Maintenance.
