# func_016 Inlining Infeasibility Analysis

**Date**: January 2026
**Status**: INFEASIBLE - Architectural Constraints

---

## Executive Summary

Investigation into inlining func_016 at its 4 call sites revealed that the caller functions (func_017, func_018, func_019) are **not independent functions** but rather a tightly coupled state machine with shared code paths. This discovery, combined with BSR range limitations and lack of slack space, makes traditional inlining impractical.

---

## Key Discovery: State Machine Architecture

### Code Structure Analysis

The disassembly reveals the callers share a complex control flow:

```
02223386  RTS                        ; func_016 ends
02223388  MOV.L R4,@($34,R14)        ; func_016's delay slot = first caller instruction
0222338A  STS.L PR,@-R15             ; func_017 entry point
0222338C  BSR   $02223368            ; func_017 calls func_016
...
02223394  BF    $022233A4            ; func_017 branches INTO func_018's body
...
022233A0  RTS                        ; func_017 exit
022233A2  NOP                        ; func_017's delay slot = func_018 entry point
```

### Shared Elements

1. **Delay Slot Sharing**
   - func_016's RTS uses delay slot at 0x02223388
   - This instruction is also the first operation of the caller state machine
   - func_017's RTS uses delay slot at 0x022233A2
   - That NOP is also func_018's entry point

2. **Cross-Function Branching**
   - func_017 @ 0x02223394: `BF $022233A4` branches INTO func_018's body
   - func_018/019 share exit path at 0x0222339E
   - Multiple functions converge on common cleanup code

3. **Embedded Data Literals**
   - Literal pools between function segments (0x02223410: `$FF00`, 0x0222344C: `$00FF00FF`)
   - These appear inline within the code stream

---

## Why Inlining Fails

### Constraint 1: No Clean Entry Points

Creating trampolines at func_017/018/019 entry points would break cross-function branches:
- A trampoline at 0x0222338A would disrupt the branch at 0x02223394
- func_018/019 jump back into func_017's loop (0x02223390)
- Modifying any entry point breaks the state machine

### Constraint 2: BSR Range Limitation

The SH2 BSR instruction has a range of PC ± 4KB (±2048 words):
- func_016 callers are at ~0x0222338A
- Expansion space starts at ~0x02300000
- Distance: ~0x100000 (1MB) - **far exceeds BSR range**

To reach expansion space would require:
```assembly
MOV.L  @(disp,PC),R0    ; 2 bytes, 1 cycle - load expansion address
JMP    @R0              ; 2 bytes, 2 cycles
NOP                     ; 2 bytes, 1 cycle - delay slot
```
This adds 4+ cycles overhead, **negating the 6-cycle savings** from eliminating BSR/RTS.

### Constraint 3: No Slack Space

Inlining func_016 (30 bytes) at each call site would expand code by:
- 30 bytes code - 4 bytes BSR+delay = 26 bytes per site
- 26 bytes × 4 sites = 104 bytes expansion needed

The original ROM has **zero slack bytes** - every byte is used for code or data.

### Constraint 4: Code Density Optimization

The original developers applied extreme code density optimizations:
- Delay slot sharing between unrelated functions
- Branch targets that land mid-function
- State machine patterns spanning multiple "functions"

This is **space-optimized code**, not **speed-optimized code**.

---

## Attempted Approaches

| Approach | Result | Why It Failed |
|----------|--------|---------------|
| In-place inlining | FAILED | No room, would overwrite adjacent code |
| Trampoline to expansion | FAILED | Adds more overhead than it saves |
| Caller relocation to expansion | FAILED | Cross-function branches would break |
| Full block relocation | TOO RISKY | Would require replicating complex state machine |

---

## Recommendations

### Short Term
1. **Document these findings** for future reference
2. **Focus on simpler targets** (func_065 already converted, MAC.L loops)
3. **Accept func_016 overhead** as architectural cost

### Long Term
If func_016 optimization remains a priority:
1. **Full rewrite** of func_017-020 complex as a single optimized unit
2. **Relocate entire polygon pipeline** to expansion space
3. **Extensive testing** required due to complexity

This would be a major undertaking requiring deep understanding of the polygon processing state machine.

---

## Lessons Learned

1. **Hand-optimized assembly is fragile**: The original code trades maintainability for space
2. **Function boundaries are illusions**: Call graph analysis can't reveal shared code paths
3. **Range limitations matter**: SH2's limited branch range constrains optimization options
4. **Space vs speed tradeoff**: Original game chose space, limiting our speed options

---

## References

- [SH2_3D_FUNCTION_REFERENCE.md](../sh2-analysis/SH2_3D_FUNCTION_REFERENCE.md)
- [SH2_3D_CALL_GRAPH.md](../sh2-analysis/SH2_3D_CALL_GRAPH.md)
- [OPTIMIZATION_OPPORTUNITIES.md](OPTIMIZATION_OPPORTUNITIES.md)
- Disassembly: `disasm/sh2_3d_engine_annotated.asm`
