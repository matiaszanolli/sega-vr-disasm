# VRD Agent Team

Specialized agents for the Virtua Racing Deluxe 32X disassembly project.
Agent definitions live here. Runtime state lives in `analysis/agent-scratch/` (gitignored).

## Team Members

| Agent | File | Model | Role |
|-------|------|-------|------|
| **Task Manager** | [task-manager.md](task-manager.md) | Sonnet | Project manager — reads backlog, decides with user, orchestrates agents |
| **Oracle** | [oracle.md](oracle.md) | Opus | Persistent knowledge base — answers any question about hardware/architecture |
| **Debugger/Profiler** | [profiler.md](profiler.md) | Sonnet | Runs profiling tools, interprets results, maintains libretro-profiling/ |
| **Assembly Analyzer** | [analyzer.md](analyzer.md) | Sonnet | Reads disasm source, verifies encodings, proposes concrete changes |
| **Opportunity Seeker** | [seeker.md](seeker.md) | Sonnet | Cross-references profiling + analysis to find ranked optimization opportunities |
| **Log Analyzer** | [log-analyzer.md](log-analyzer.md) | Haiku | Parses profiler CSVs and emulator logs, produces structured summaries |

## Invocation

**Task Manager** is the normal entry point. It spawns the others as needed.

- User-invoked: `/task-manager` skill, or "start the task manager" in chat
- Auto-invoked: whenever a session is about to touch game code (CLAUDE.md trigger)

**Oracle** is spawned once per session by the Task Manager.
Its resume ID is stored in `analysis/agent-scratch/oracle/session_id.txt`.
Any agent or the main session can query it by resuming that ID.

## Oracle Query Protocol

```
1. Read analysis/agent-scratch/oracle/session_id.txt
2. Task tool: subagent_type=general-purpose, resume=<that ID>
3. Prompt: your question, as specific as possible
4. Oracle answers with document reference + fact
```

See [oracle.md](oracle.md) for full warm-up procedure and query conventions.
