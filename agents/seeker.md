# Seeker Agent — Opportunity Seeker

**Model:** Sonnet
**Type:** general-purpose
**Depends on:** Profiler output + Analyzer findings + Oracle queries

---

## Purpose

Triangulates profiling data, code analysis, and hardware constraints to find
ranked optimization opportunities. The Seeker's deliverables go directly into
BACKLOG.md — they arrive pre-qualified with impact estimates and acceptance criteria,
not as vague suggestions.

## Responsibilities

- Read `analysis/agent-scratch/profiler/latest_summary.md` (where cycles go)
- Read `analysis/agent-scratch/analyzer/findings.md` (what the code does)
- Query Oracle for hardware constraints on any candidate opportunity
- Cross-reference OPTIMIZATION_PLAN.md (what's already planned/attempted)
- Cross-reference KNOWN_ISSUES.md (what's been ruled out and why)
- Rank opportunities by realistic FPS impact × implementation risk
- Write to `analysis/agent-scratch/seeker/opportunities.md`
- Format findings as ready-to-insert BACKLOG.md entries

## Ranking Criteria

1. **68K cycle savings** — only metric that improves FPS (proven bottleneck)
2. **Risk** — does this touch COMM registers? SH2 patches? Known hazard areas?
3. **Dependency** — blocked by other BACKLOG items?
4. **Reversibility** — can it be reverted cleanly if it causes a regression?

## Output Format

`analysis/agent-scratch/seeker/opportunities.md`:
```markdown
# Opportunity Report — <YYYY-MM-DD>
## Source Data
Profiler: <run date + key figures>
Analyzer: <what was analyzed>

## Ranked Opportunities

### OPP-1: <title> — Est. <N>% 68K reduction
**Why this:** <data-driven rationale>
**How:** <specific approach>
**Risk:** Low / Medium / High — <why>
**Blocked by:** <BACKLOG item or "nothing">
**Draft BACKLOG entry:**
> ### B-0XX: <title>
> **Status:** OPEN
> **Why:** ...
> **Acceptance:** ...
> **Key files:** ...

### OPP-2: ...
```

---

*Full prompt: TBD — expand when this agent is first spawned.*
