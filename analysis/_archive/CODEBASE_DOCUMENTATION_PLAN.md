# Virtua Racing 32X - Codebase Documentation Plan

## Philosophy

**Understand before optimizing.** We need to:
1. Know what each function does
2. Understand calling conventions and data flow
3. Identify critical vs safe-to-modify code
4. Build a mental model of the system

## Current State

We have:
- ✅ 95% readable SH2 disassembly in `disassembly/`
- ✅ Complete 3D engine analysis
- ✅ Bottleneck analysis (VDP polling, func_065, etc.)
- ❌ No systematic function documentation
- ❌ No call graph
- ❌ Generic function names (func_001, func_065, etc.)
- ❌ Unknown register conventions

## Documentation Goals

### Phase 1: Foundational Analysis (Week 1-2)

**1.1 Create Master Function Index**
- List all functions in SH2 code
- Initial categorization (init, render, game logic, util)
- Call frequency (from profiling data if available)
- Size and complexity metrics

**1.2 Document Register Conventions**
- Identify calling conventions:
  - Which registers are caller-saved vs callee-saved?
  - Parameter passing (R0-R7?)
  - Return values (R0?)
  - Frame pointer usage (R14?)
  - Stack pointer (R15)
- Document global register usage:
  - R9 = frame buffer pointer (we know this)
  - R10 = table base (we know this)
  - R13 = stride value (we think this, need to verify)
  - Others?

**1.3 Map Initialization Sequence**
- Find entry point (where does SH2 start?)
- Trace initialization code
- Identify one-time vs repeated setup
- Document hardware initialization (VDP, cache, interrupts)

**Why this matters:** We crashed because we modified code that's called during init when assumptions don't hold yet.

### Phase 2: Function-Level Documentation (Week 2-4)

**2.1 High-Priority Functions (Hotspots)**

Start with the bottlenecks we already identified:

| Function | Priority | What We Know | Documentation Needed |
|----------|----------|--------------|---------------------|
| func_065 | 🔥 HIGH | Rasterization, writes to frame buffer, uses R9/R10/R13 | Full analysis, parameters, when called, can it be modified? |
| func_016 | 🔥 HIGH | 3D transformation (we have analysis) | Verify analysis, document parameters |
| VDP polling | 🔥 HIGH | Busy-waits at ROM 0x243E2, 0x2441E, 0x2443A, 0x24482 | Why polling? Can we interrupt-drive it? |
| Slave CPU entry | 🔥 HIGH | 99.97% idle, entry point? | Where is it? How to activate? |

**2.2 Documentation Template**

For each function, create:

```markdown
## func_XXX / [Descriptive Name]

**Location:** ROM 0xXXXXX, SH2 address 0xXXXXXXXX
**Size:** XXX bytes
**Type:** [init/render/logic/util/interrupt]
**Called from:** [list of callers]
**Calls:** [list of callees]

### Purpose
[1-2 sentence description of what this function does]

### Parameters
- R0: [description]
- R1: [description]
...

### Return Value
- R0: [description] (if applicable)

### Registers Modified
[List of clobbers beyond return value]

### Side Effects
[Memory writes, hardware access, global state changes]

### Timing
- Cycles: ~XXX (measured/estimated)
- Called: [once/per-frame/per-object/etc.]

### Safety
- ✅ Safe to modify / ⚠️ Timing-sensitive / ❌ Untouchable
- Reason: [why]

### Notes
[Any important observations, quirks, optimization opportunities]

### Code
```asm
[Annotated assembly listing]
```
```

**2.3 Systematic Analysis Process**

For each function:
1. **Static analysis:**
   - Disassemble with annotations
   - Identify loops, branches, data accesses
   - Track register usage
   - Note hardware I/O

2. **Dynamic analysis** (if possible with emulator):
   - Set breakpoints
   - Watch register values
   - Profile call frequency
   - Measure execution time

3. **Reverse engineering:**
   - Infer purpose from code patterns
   - Match against known algorithms (3D math, rasterization, etc.)
   - Compare with other games if similar

4. **Documentation:**
   - Fill out template above
   - Add inline comments to disassembly
   - Update call graph

### Phase 3: Data Structure Analysis (Week 3-5)

**3.1 Memory Map**
- Identify major data structures in SDRAM (0x22000000)
- Find frame buffer layout
- Locate lookup tables (we know func_065 uses one at R10)
- Document global variables

**3.2 Frame Buffer Analysis**
- Pixel format (we know: 15-bit RGB, direct color mode likely)
- Resolution
- Single/double buffering
- Write patterns

**3.3 Lookup Tables**
- R10 points to what? (used in func_065)
- Size, format, purpose
- How is it indexed?

### Phase 4: Control Flow & Architecture (Week 4-6)

**4.1 Call Graph**
- Build complete call graph
- Identify hot paths (most executed chains)
- Find recursion (if any)
- Spot inefficiencies (unnecessary indirection)

**4.2 Execution Flow**
- Main loop structure
- Frame timing
- Interrupt handlers (V-blank, H-blank, etc.)
- 68000 ↔ SH2 synchronization points

**4.3 Slave CPU Investigation**
- Where is Slave entry point?
- What's it waiting for?
- How does Master/Slave communication work?
- What work can be offloaded?

### Phase 5: Refactoring & Renaming (Week 5-7)

**5.1 Function Naming Convention**

Replace generic names with descriptive ones:

```
func_001 → sh2_master_init
func_016 → transform_3d_vertex
func_065 → rasterize_scanline  (or whatever it actually does)
```

**Naming scheme:**
- `[cpu]_[module]_[action]_[object]`
- Examples:
  - `sh2_render_draw_polygon`
  - `sh2_math_multiply_fixed16`
  - `sh2_vdp_wait_vblank`
  - `68k_sound_play_effect`

**5.2 Create Annotated Disassembly**

Turn this:
```asm
func_065:
    4018        SHLL8 R0
    4001        SHLR R0
    30AC        ADD R10,R0
    6193        MOV R9,R1
```

Into this:
```asm
rasterize_scanline:
    ; Parameters:
    ;   R0 = scanline index (0-223)
    ;   R9 = frame buffer base pointer
    ;   R10 = scanline data table base
    ;   R13 = destination stride (bytes between writes)
    ; Returns:
    ;   None (modifies frame buffer via R9)

    ; Calculate source data address: table_base + (index * 128)
    4018        SHLL8 R0           ; R0 *= 256
    4001        SHLR R0            ; R0 /= 2  → R0 *= 128
    30AC        ADD R10,R0         ; R0 = source address

    ; Initialize destination pointer
    6193        MOV R9,R1          ; R1 = frame buffer dest

    ; [rest of function]
```

**5.3 Create Module Structure**

Organize code into logical modules:
```
/disassembly/
  /sh2_master/
    init.asm
    render/
      rasterizer.asm
      3d_transform.asm
      clipping.asm
    game_logic/
      physics.asm
      collision.asm
    utils/
      math.asm
      memory.asm
  /sh2_slave/
    entry.asm
    [mostly empty - needs investigation]
  /68000/
    main.asm
    sound.asm
    input.asm
```

### Phase 6: Knowledge Base (Ongoing)

**6.1 Algorithm Documentation**
- 3D transformation pipeline
- Rasterization algorithm
- Fixed-point math precision
- Clipping techniques

**6.2 Performance Characteristics**
- Cycle counts for critical paths
- Frame budget breakdown
- Memory bandwidth usage
- Cache hit/miss patterns

**6.3 Optimization Opportunities**
- Document each opportunity WITH context
- Mark safety level (safe/risky/impossible)
- Estimate impact
- List prerequisites

## Tools & Processes

### Analysis Tools
- ✅ Gens KMod emulator (with GDB support)
- ✅ Python scripts for ROM analysis
- ✅ vasmm68k disassembler (68000)
- ✅ SH2 disassembler (in tools/)
- ⏳ Create call graph generator
- ⏳ Create register usage tracker
- ⏳ Create cycle counter (static analysis)

### Documentation Tools
- Markdown for analysis docs
- Comments in disassembly files
- Call graph visualizer (Graphviz?)
- Spreadsheets for function inventory

### Workflow
1. Pick next function from priority list
2. Perform static analysis
3. Test with emulator/debugger if needed
4. Document using template
5. Update call graph
6. Rename function in all files
7. Commit changes with detailed message

## Success Metrics

We'll know we're ready to optimize when:
- ✅ Every function in hot path is documented
- ✅ Call graph is complete and accurate
- ✅ Register conventions are understood
- ✅ Init vs runtime code is clearly separated
- ✅ We can explain why MINIMAL-NOP crashed
- ✅ We know which functions are safe to modify
- ✅ Slave CPU activation is understood

## Immediate Next Steps

### Week 1 Action Items

**Day 1-2: Foundation**
- [ ] Create function inventory (scan disassembly, list all functions)
- [ ] Identify entry points (SH2 Master, SH2 Slave, 68000)
- [ ] Map initialization sequence

**Day 3-4: Critical Functions**
- [ ] Document func_065 completely
- [ ] Document VDP polling loops
- [ ] Analyze why MINIMAL-NOP crashed

**Day 5-7: Architecture**
- [ ] Build initial call graph
- [ ] Document register conventions
- [ ] Locate Slave CPU entry point and understand why it's idle

### Tools to Build

**1. Function Scanner**
```python
# Scan disassembly, extract all function definitions
# Output: CSV with name, address, size, type
```

**2. Call Graph Generator**
```python
# Parse BSR/JSR instructions
# Build directed graph
# Output: Graphviz DOT file
```

**3. Register Usage Analyzer**
```python
# Track register reads/writes per function
# Identify calling conventions
# Output: Register usage table
```

## Long-Term Vision

After documentation is complete:
1. **Optimize with confidence** - know what's safe to change
2. **Easier debugging** - understand execution flow
3. **Future development** - can add features, not just optimize
4. **Community contribution** - well-documented code is shareable
5. **Reference implementation** - becomes definitive Virtua Racing analysis

## Philosophy Reminder

> "Weeks of coding can save you hours of planning." - Anonymous

We just learned this the hard way. Even a simple 2-byte NOP crashed because we didn't understand the context. Let's build that understanding now.
