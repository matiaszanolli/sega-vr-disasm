# Priority 9 Deep Analysis Report

**Date**: 2026-01-07
**Scope**: 49 Main Code 2 functions (54 total - 5 extended)

---

## Entry Type Distribution

### Move Start (19 functions)

- **func_109AE** ($008909AE): size=256 bytes
- **func_14696** ($00894696): size=30 bytes
- **func_146B4** ($008946B4): size=8 bytes
- **func_1474A** ($0089474A): size=10 bytes
- **func_14754** ($00894754): size=10 bytes
- **func_1475E** ($0089475E): size=10 bytes
- **func_14768** ($00894768): size=10 bytes
- **func_14772** ($00894772): size=10 bytes
- **func_1477C** ($0089477C): size=10 bytes
- **func_14786** ($00894786): size=10 bytes
- ... and 9 more

### Quick Load (9 functions)

- **func_1466A** ($0089466A): size=44 bytes
- **func_146CA** ($008946CA): size=16 bytes
- **func_146DA** ($008946DA): size=16 bytes
- **func_146EA** ($008946EA): size=16 bytes
- **func_146FA** ($008946FA): size=16 bytes
- **func_1470A** ($0089470A): size=16 bytes
- **func_1471A** ($0089471A): size=16 bytes
- **func_1472A** ($0089472A): size=16 bytes
- **func_1473A** ($0089473A): size=16 bytes

### Other (8 functions)

- **func_146BC** ($008946BC): size=14 bytes
- **func_1480E** ($0089480E): size=8 bytes
- **func_14816** ($00894816): size=8 bytes
- **func_1481E** ($0089481E): size=8 bytes
- **func_14826** ($00894826): size=8 bytes
- **func_15494** ($00895494): size=256 bytes
- **func_154B4** ($008954B4): size=256 bytes
- **func_154D4** ($008954D4): size=256 bytes

### Lea Start (5 functions)

- **func_14450** ($00894450): size=28 bytes
- **func_144A8** ($008944A8): size=40 bytes
- **func_144D0** ($008944D0): size=34 bytes
- **func_144F2** ($008944F2): size=38 bytes
- **func_14518** ($00894518): size=40 bytes

### Unknown (4 functions)

- **func_1446C** ($0089446C): size=60 bytes
- **func_14882** ($00894882): size=2 bytes
- **func_14884** ($00894884): size=2 bytes
- **func_14886** ($00894886): size=2 bytes

### Standard Save (2 functions)

- **func_11942** ($00891942): size=60 bytes
- **func_1469C** ($0089469C): size=24 bytes

### Clear Start (1 functions)

- **func_14438** ($00894438): size=52 bytes

### Test Start (1 functions)

- **func_14540** ($00894540): size=36 bytes

## Register Save Analysis

### Functions with Full Register Save (MOVEM all)

- **func_14696** ($00894696): D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, A2, A3, A4, A5, A6
- **func_1469C** ($0089469C): D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, A2, A3, A4, A5, A6

### Functions with Partial Register Save

- **func_11942** ($00891942): D3, D4

### Functions without Register Save (Leaf-like)

- **func_109AE** ($008909AE): entry_type=move_start
- **func_14438** ($00894438): entry_type=clear_start
- **func_14450** ($00894450): entry_type=lea_start
- **func_1446C** ($0089446C): entry_type=unknown
- **func_144A8** ($008944A8): entry_type=lea_start
- **func_144D0** ($008944D0): entry_type=lea_start
- **func_144F2** ($008944F2): entry_type=lea_start
- **func_14518** ($00894518): entry_type=lea_start
- **func_14540** ($00894540): entry_type=test_start
- **func_1466A** ($0089466A): entry_type=quick_load
- **func_146B4** ($008946B4): entry_type=move_start
- **func_146BC** ($008946BC): entry_type=other
- **func_146CA** ($008946CA): entry_type=quick_load
- **func_146DA** ($008946DA): entry_type=quick_load
- **func_146EA** ($008946EA): entry_type=quick_load
- ... and 31 more

## Call Graph (JSR/BSR Targets)

### func_109AE ($008909AE)
  JSR targets:
    - $008826C8 (P1-P7 - Core)
    - $008814BE (P1-P7 - Core)
    - $008849AA (P8 - Main Logic)
    - $008849AA (P8 - Main Logic)

### func_11942 ($00891942)
  BSR targets:
    - $0089197E (nearby code)
    - $0089199A (nearby code)
    - $0089197E (nearby code)
    - $0089199A (nearby code)
    - $0089199A (nearby code)
    - $0089197E (nearby code)

### func_14540 ($00894540)
  JSR targets:
    - $00882890 (P1-P7 - Core)

### func_14696 ($00894696)
  JSR targets:
    - $0088D1D4 (P8 - Main Logic)

### func_1469C ($0089469C)
  JSR targets:
    - $0088D1D4 (P8 - Main Logic)

### func_146CA ($008946CA)
  BSR targets:
    - $008946DC (nearby code)

### func_146DA ($008946DA)
  BSR targets:
    - $008946EC (nearby code)

### func_146EA ($008946EA)
  BSR targets:
    - $008946FE (nearby code)

### func_146FA ($008946FA)
  BSR targets:
    - $0089470E (nearby code)

### func_1470A ($0089470A)
  BSR targets:
    - $0089471C (nearby code)

### func_1471A ($0089471A)
  BSR targets:
    - $0089472C (nearby code)

### func_1472A ($0089472A)
  BSR targets:
    - $0089473E (nearby code)

### func_1473A ($0089473A)
  BSR targets:
    - $0089474E (nearby code)

## Summary Statistics

**Total Functions Analyzed**: 49

| Entry Type | Count | Percentage |
|------------|-------|------------|
| Move Start | 19 | 38.8% |
| Quick Load | 9 | 18.4% |
| Other | 8 | 16.3% |
| Lea Start | 5 | 10.2% |
| Unknown | 4 | 8.2% |
| Standard Save | 2 | 4.1% |
| Clear Start | 1 | 2.0% |
| Test Start | 1 | 2.0% |

| Register Save Pattern | Count | Percentage |
|----------------------|-------|------------|
| Full save (14+ regs) | 2 | 4.1% |
| Partial save | 1 | 2.0% |
| No save (leaf-like) | 46 | 93.9% |

**Total Code Size**: 1946 bytes (1.9 KB)
**Average Function Size**: 39.7 bytes

### External Dependencies (JSR targets)

- **P8 (Main Logic) calls**: 2
  - $008849AA
  - $0088D1D4
- **Core (P1-P7) calls**: 3
  - $008814BE
  - $008826C8
  - $00882890
- **P9 internal calls**: 0
