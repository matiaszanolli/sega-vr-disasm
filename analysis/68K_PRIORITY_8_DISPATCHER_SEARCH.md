# Priority 8 Dispatcher Search Analysis

**Date**: 2026-01-07
**Purpose**: Locate the real game state dispatcher

---

## Dispatcher Candidates Analysis

Analyzing 5 primary candidates that match dispatcher characteristics:

### func_C784 ($0088C784)

**Dispatcher Score**: 15/50

**Characteristics**:
- Size: 62 bytes
- JSR calls: 1
- BSR calls: 0
- JMP calls: 0
- Conditional branches: 0
- Register save (MOVEM): Yes
- Link frame: No
- Table pattern: Yes

**First 10 Instructions**:

```
0088C784  func_C784:
0088C784  48E7  MOVEM (15 regs)
0088C788  7200  $7200
0088C78A  43FA  LEA (table?)
0088C78E  45F8  LEA (table?)
0088C792  700E  $700E
0088C794  3551  $3551
0088C796  00B6  $00B6
0088C798  3559  $3559
0088C79A  000A  $000A
0088C79C  45EA  LEA (table?)
... (14 more)
```

### func_CF0C ($0088CF0C)

**Dispatcher Score**: 27/50

**Characteristics**:
- Size: 162 bytes
- JSR calls: 0
- BSR calls: 0
- JMP calls: 1
- Conditional branches: 4
- Register save (MOVEM): No
- Link frame: No
- Table pattern: Yes

**First 10 Instructions**:

```
0088CF0C  func_CF0C:
0088CF0C  41F8  LEA (table?)
0088CF10  7E0E  $7E0E
0088CF12  3F07  $3F07
0088CF14  4EBA  $4EBA
0088CF16  ABA0  $ABA0
0088CF18  4EBA  $4EBA
0088CF1A  AB9C  $AB9C
0088CF1C  4EBA  $4EBA
0088CF1E  AB98  $AB98
0088CF20  4EBA  $4EBA
... (26 more)
```

### func_CE76 ($0088CE76)

**Dispatcher Score**: 19/50

**Characteristics**:
- Size: 76 bytes
- JSR calls: 3
- BSR calls: 0
- JMP calls: 0
- Conditional branches: 0
- Register save (MOVEM): No
- Link frame: No
- Table pattern: Yes

**First 10 Instructions**:

```
0088CE76  func_CE76:
0088CE76  7200  $7200
0088CE78  43F8  LEA (table?)
0088CE7C  4EB9  JSR $00884842
0088CE82  4EB9  JSR $00884846
0088CE88  4EB9  JSR $00884856
0088CE8E  11C1  $11C1
0088CE90  C81D  $C81D
0088CE92  11C1  $11C1
0088CE94  C81F  $C81F
0088CE96  11C1  $11C1
... (21 more)
```

### func_CC88 ($0088CC88)

**Dispatcher Score**: 12/50

**Characteristics**:
- Size: 196 bytes
- JSR calls: 2
- BSR calls: 0
- JMP calls: 0
- Conditional branches: 1
- Register save (MOVEM): No
- Link frame: No
- Table pattern: Yes

**First 10 Instructions**:

```
0088CC88  func_CC88:
0088CC88  11F8  $11F8
0088CC8A  FEA9  $FEA9
0088CC8C  C30F  $C30F
0088CC8E  41F8  LEA (table?)
0088CC92  11FC  $11FC
0088CC94  0000  $0000
0088CC96  C819  $C819
0088CC98  31F8  $31F8
0088CC9A  C094  $C094
0088CC9C  C07A  $C07A
... (28 more)
```

### func_CA9A ($0088CA9A)

**Dispatcher Score**: 38/50

**Characteristics**:
- Size: 92 bytes
- JSR calls: 0
- BSR calls: 2
- JMP calls: 1
- Conditional branches: 7
- Register save (MOVEM): No
- Link frame: No
- Table pattern: Yes

**First 10 Instructions**:

```
0088CA9A  func_CA9A:
0088CA9A  6134  BSR
0088CA9C  4EFA  $4EFA
0088CA9E  012C  $012C
0088CAA0  612E  BSR
0088CAA2  33FC  $33FC
0088CAA4  004E  $004E
0088CAA6  00FF  $00FF
0088CAA8  6744  Bcc
0088CAAA  3038  $3038
0088CAAC  C8C8  $C8C8
... (25 more)
```

---

## Dispatcher Likelihood Ranking

| Rank | Function | Score | JSR | BSR | Branches | Size |
|------|----------|-------|-----|-----|----------|------|
| 1 | func_CA9A | 38/50 | 0 | 2 | 7 | 92 |
| 2 | func_CF0C | 27/50 | 0 | 0 | 4 | 162 |
| 3 | func_CE76 | 19/50 | 3 | 0 | 0 | 76 |
| 4 | func_C784 | 15/50 | 1 | 0 | 0 | 62 |
| 5 | func_CC88 | 12/50 | 2 | 0 | 1 | 196 |

## Analysis

### Most Likely Dispatcher: func_CA9A

**Score**: 38/50
**Evidence**:
- Conditional branching (7) = state-based logic
- Table addressing pattern = jump table dispatch

**Recommended Next Steps**:
1. Deep disassemble func_CA9A completely
2. Map all JSR/BSR targets to game state handlers
3. Identify game state variable (likely in RAM)
4. Trace from main loop entry point

---

## Investigation Strategy

If above candidates don't match, dispatcher might be:

1. **Inlined in main loop** - Search Priority 7 for function entry patterns
2. **Jump table driven** - Search for address tables in data section
3. **In ROM patch area** - Check above $FE0000
4. **Compiler-generated** - Multiple small dispatchers instead of one main

**Search Patterns for Dispatcher**:
- Multiple JSR instructions in sequence
- CMP/TST followed by conditional branches
- LEA loading address tables
- Code that checks game state variable
- References to many game state handlers

---

**Generated**: 2026-01-07
**Status**: Dispatcher search analysis complete