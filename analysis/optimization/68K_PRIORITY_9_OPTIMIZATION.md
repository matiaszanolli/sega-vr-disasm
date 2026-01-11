# Priority 9 Optimization Recommendations

**Date**: 2026-01-07
**Scope**: 54 Priority 9 functions (49 Main Code 2 + 5 Extended)
**Purpose**: Actionable optimization guidance based on deep analysis

---

## Executive Summary

Priority 9 code is already highly optimized with minimal overhead. The main optimization opportunities are:

1. **Dispatcher Inlining** (Medium Impact): Inline 2-byte stub handlers
2. **BSR Chain Optimization** (Low Impact): Combine sequential BSR operations
3. **Table Consolidation** (Medium Impact): Merge similar handlers with data-driven logic

**Overall Assessment**: Limited optimization potential - code is already compact and efficient.

---

## Current Performance Profile

### Code Characteristics

| Metric | Value | Assessment |
|--------|-------|------------|
| Total P9 code size | 1,946 bytes | Very compact |
| Average function size | 39.7 bytes | Efficient |
| Functions with register save | 3 (6.1%) | Minimal overhead |
| Pure leaf functions | 33 (67.3%) | Excellent |
| External JSR calls | 5 | Minimal dependencies |

### Execution Profile

| Category | Functions | Cycle Impact |
|----------|-----------|--------------|
| Stub handlers (2 bytes) | 3 | ~4 cycles each |
| Small handlers (8-16 bytes) | 25 | ~10-30 cycles each |
| Medium handlers (20-60 bytes) | 18 | ~30-100 cycles each |
| Large handlers (256+ bytes) | 3 | ~200+ cycles each |

---

## Optimization Opportunities

### 1. Dispatcher Stub Inlining (Medium Impact)

**Problem**: Three 2-byte stub handlers (func_14882, func_14884, func_14886) add JSR/RTS overhead.

**Current Flow**:
```
func_BA18 → JSR stub_handler → RTS
                              ↑
                         8-10 cycles overhead
```

**Proposed Solution**: Inline stub content into dispatcher table or use direct data.

**Before**:
```asm
; func_BA18 dispatcher
JSR func_14886      ; 18 cycles
; func_14886
...                 ; 4 cycles (stub work)
RTS                 ; 16 cycles
; Total: 38 cycles
```

**After**:
```asm
; func_BA18 dispatcher (modified)
; Inline the 2-byte operation directly
MOVE.W D0,(A0)      ; 8 cycles
; Total: 8 cycles
```

**Savings**: ~30 cycles per call (if called 1000+ times/second = significant)

**Risk**: Low - stub handlers have no side effects
**Effort**: Medium - requires dispatcher modification
**Recommendation**: ⭐⭐⭐ Worth pursuing if profiling confirms hotspot

---

### 2. BSR Chain Optimization (Low Impact)

**Problem**: Handler variants ($146CA-$1473A) use BSR chains that could be consolidated.

**Current Pattern**:
```asm
func_146CA:
    MOVEQ #1,D0
    ... setup ...
    BSR $146DC      ; Branch to func_146DA body
    RTS

func_146DA:
    MOVEQ #1,D0
    ... setup ...
    BSR $146EC      ; Branch to func_146EA body
    RTS
```

**Proposed Solution**: Create shared subroutine with parameter.

**After**:
```asm
shared_handler:
    ; D0 = operation type
    ; A0 = target address
    ... common logic ...
    RTS

func_146CA:
    MOVEQ #1,D0
    LEA $C054,A0
    BRA shared_handler

func_146DA:
    MOVEQ #-1,D0     ; Decrement instead
    LEA $C054,A0
    BRA shared_handler
```

**Savings**: ~50 bytes code size, ~4 cycles per call
**Risk**: Low - operations are similar
**Effort**: Medium - requires rewrite of 8 handlers
**Recommendation**: ⭐⭐ Consider if code size is critical

---

### 3. State Handler Table (Low Impact)

**Problem**: 13 state handlers ($1474A-$147C2) are identical structure with different constants.

**Current Pattern**:
```asm
func_1474A:
    MOVE.W #$xxxx,($yyyy)
    RTS

func_14754:
    MOVE.W #$zzzz,($wwww)
    RTS
```

**Proposed Solution**: Single handler with table lookup.

**After**:
```asm
state_handler:
    ; D0 = state index (0-12)
    LEA state_table,A0
    MOVE.W (A0,D0.W*4),D1     ; Value
    MOVE.W 2(A0,D0.W*4),A1    ; Address
    MOVE.W D1,(A1)
    RTS

state_table:
    DC.W $xxxx,$yyyy   ; State 0
    DC.W $zzzz,$wwww   ; State 1
    ...
```

**Savings**: ~100 bytes code, slight cycle increase
**Risk**: Low - data-driven is maintainable
**Effort**: Low - straightforward refactor
**Recommendation**: ⭐⭐ Consider for maintainability

---

### 4. Large Handler Optimization (High Impact Potential)

**Problem**: Three handlers ($15494, $154B4, $154D4) are 256+ bytes each.

**Analysis Needed**: These functions likely contain:
- Loop unrolling that could use DBRA
- Repeated operations that could be factored
- Memory access patterns that could be optimized

**Proposed Investigation**:
1. Profile these functions during gameplay
2. Identify hot loops or repeated sequences
3. Consider MOVEM for bulk data operations
4. Check for cache-friendly access patterns

**Savings**: Potentially 50-100 cycles per call
**Risk**: Medium - complex logic
**Effort**: High - requires detailed disassembly
**Recommendation**: ⭐⭐⭐⭐ High value if profiling confirms hotspot

---

### 5. Register Allocation (Already Optimized)

**Current State**: 93.9% of functions have no register save.

**Assessment**: This is optimal. The code correctly uses:
- No save for leaf functions
- Partial save (D3-D4) for simple processing
- Full save only when calling external functions

**Recommendation**: ✅ No action needed - already optimal

---

## NOT Recommended

### ❌ Loop Unrolling in Small Handlers

Most handlers are already <20 bytes. Unrolling would:
- Increase code size
- Hurt instruction cache
- Provide negligible benefit

### ❌ Removing RTS Instructions

Some handlers end with RTS after simple operations. Replacing with fall-through would:
- Make debugging harder
- Risk subtle bugs
- Save only 2 bytes per function

### ❌ Assembly-Level Micro-optimizations

Changes like:
- `MOVEQ #0,D0` → `CLR.L D0` (same cycles)
- `BRA.S` → `BRA.B` (already used where applicable)

Would provide no measurable benefit.

---

## Implementation Priority

### High Priority (Do First)

| Optimization | Impact | Effort | Risk |
|--------------|--------|--------|------|
| Profile large handlers | Foundation | Low | None |
| Analyze $15494-$154D4 | Potential high | Medium | Low |

### Medium Priority (Consider)

| Optimization | Impact | Effort | Risk |
|--------------|--------|--------|------|
| Inline stub handlers | ~30 cycles/call | Medium | Low |
| Consolidate BSR chain | ~50 bytes | Medium | Low |

### Low Priority (Future)

| Optimization | Impact | Effort | Risk |
|--------------|--------|--------|------|
| State handler table | Maintainability | Low | Low |
| Code documentation | Understanding | Low | None |

---

## Performance Baseline

### Estimated P9 Overhead per Frame

```
Dispatcher call (func_BA18):      ~50 cycles
Average P9 handler:               ~40 cycles
Return to P8:                     ~16 cycles
                                  ────────
Total per dispatch:               ~106 cycles

At 60 Hz with ~5 dispatches/frame: ~530 cycles
CPU cycles available per frame:    ~386,667 cycles
P9 overhead:                       0.14%
```

**Conclusion**: P9 is NOT a performance bottleneck.

---

## Recommended Action Plan

### Phase 1: Baseline (1-2 hours)

1. ✅ Complete P9 disassembly (Done)
2. ✅ Document call graph (Done)
3. ✅ Analyze register usage (Done)
4. ⬜ Profile P9 during gameplay (Optional)

### Phase 2: Quick Wins (2-4 hours)

1. ⬜ Inline stub handlers if profiling confirms value
2. ⬜ Document large handlers ($15494-$154D4)
3. ⬜ Create test suite for P9 handlers

### Phase 3: Maintenance (Ongoing)

1. ⬜ Consolidate BSR chain handlers
2. ⬜ Create state handler table
3. ⬜ Update documentation as code changes

---

## Conclusion

**Priority 9 code is already well-optimized.** The original developers used:

- Minimal register saves (93.9% leaf functions)
- Compact handlers (average 39.7 bytes)
- Efficient dispatch via jump tables
- Shared code via BSR chains

The main optimization opportunities are:
1. **Large handler analysis** - Highest potential value
2. **Stub inlining** - Moderate value if high-frequency
3. **Code consolidation** - For maintainability

**Overall recommendation**: Focus optimization efforts on Priority 8 main logic or SH2 code, where the performance impact is likely much greater.

---

**Generated**: 2026-01-07
**Status**: Complete - Optimization recommendations documented

