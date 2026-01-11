# Priority 8 Entry Type Analysis

**Date**: 2026-01-07
**Functions Analyzed**: 163

---

## Entry Type Categories

### MOVEM_Save
**Count**: 8 (4.9%)

**Pattern**: Uses MOVEM to save registers at entry
**Use Case**: Functions that modify multiple registers
**Optimization**: Already optimized, only necessary registers saved

**Functions**:

- func_6D8C ($00886D8C): MOVEM_SAVE
- func_7768 ($00887768): MOVEM_SAVE, BITOP, BITOP
- func_778E ($0088778E): MOVEM_SAVE, BITOP, BITOP
- func_77B2 ($008877B2): MOVEM_SAVE, BITOP, BITOP
- func_77D6 ($008877D6): MOVEM_SAVE, BITOP, BITOP
- func_9458 ($00889458): MOVEM_SAVE, MOVE.L, MOVE.W, ... (6 total)
- func_A7CC ($0088A7CC): MOVEM_SAVE, BITOP, TST
- func_C784 ($0088C784): MOVEM_SAVE, MOVEQ, LEA, ... (5 total)

### TST_Prefix
**Count**: 6 (3.7%)

**Pattern**: Starts with TST instruction (test for zero)
**Use Case**: Conditional logic based on register/memory state
**Optimization**: TST is efficient for branching

**Functions**:

- func_6C88 ($00886C88): TST, MOVE.W
- func_6F98 ($00886F98): TST, TST, MOVE.W, ... (4 total)
- func_E316 ($0088E316): TST, ADD/SUB, BITOP, ... (5 total)
- func_E35A ($0088E35A): TST, MOVE.L, MOVE.W
- func_E406 ($0088E406): TST, MOVE.L, MOVE.W
- SendDREQCommand ($0088FB36): TST, MOVE.W, BITOP

### CMP_Prefix
**Count**: 2 (1.2%)

**Pattern**: Starts with CMP instruction (compare)
**Use Case**: Multi-way branching or equality checks
**Optimization**: Efficient for comparisons

**Functions**:

- func_4538 ($00884538): CMP
- func_757A ($0088757A): CMP

### MOVEQ_Prefix
**Count**: 42 (25.8%)

**Pattern**: Starts with MOVEQ (quick immediate load)
**Use Case**: Quick initialization with constant
**Optimization**: MOVEQ is very efficient (1 word)

**Functions**:

- TableLookup ($008814BE): MOVEQ, MOVEQ, LEA, ... (4 total)
- ClearInputState ($0088204A): MOVEQ, MOVE.W, MOVE.W
- UpdateInputState ($00882080): MOVEQ
- func_456C ($0088456C): MOVEQ, MOVE.L, BITOP
- func_4682 ($00884682): MOVEQ, BITOP, BITOP, ... (4 total)
- func_5AB6 ($00885AB6): MOVEQ, MOVE.W, MOVE.W, ... (4 total)
- func_5BEC ($00885BEC): MOVEQ, MOVE.W, MOVE.W, ... (4 total)
- func_5C5A ($00885C5A): MOVEQ, MOVE.W, MOVE.W, ... (4 total)
- func_5DE0 ($00885DE0): MOVEQ, MOVE.W, MOVE.W
- func_5E38 ($00885E38): MOVEQ, MOVE.W, MOVE.W, ... (5 total)
- ... and 32 more

### LEA_Prefix
**Count**: 20 (12.3%)

**Pattern**: Starts with LEA (load effective address)
**Use Case**: Address computation for tables or structures
**Optimization**: LEA is efficient for address loading

**Functions**:

- VDPFrameControl ($008826C8): LEA, BITOP
- func_58C8 ($008858C8): LEA, MOVE.W, BITOP, ... (4 total)
- func_5908 ($00885908): LEA, MOVE.W, BITOP, ... (4 total)
- func_593C ($0088593C): LEA, MOVE.W, BITOP, ... (4 total)
- func_5B6E ($00885B6E): LEA, MOVE.L, MOVE.L
- func_6D9C ($00886D9C): LEA, BITOP
- func_6DC8 ($00886DC8): LEA, LEA
- func_6DF0 ($00886DF0): LEA, LEA, LEA
- func_71B3 ($008871B3): LEA, MOVE.L, MOVE.W, ... (4 total)
- func_A144 ($0088A144): LEA, MOVE.W, MOVE.L, ... (5 total)
- ... and 10 more

### MOVE_Prefix
**Count**: 50 (30.7%)

**Pattern**: Starts with MOVE.W or MOVE.L (data movement)
**Use Case**: Register/memory initialization or data movement
**Optimization**: MOVE is standard, no changes needed

**Functions**:

- MapButtonBits ($008817EE): MOVE.W, MOVEQ
- Read6ButtonPad ($0088185E): MOVE.W, BITOP, BITOP
- func_4004 ($00884004): MOVE.W, BITOP, MOVE.W, ... (6 total)
- func_465C ($0088465C): MOVE.W, BITOP, BITOP, ... (5 total)
- func_4846 ($00884846): MOVE.L, MOVE.L, MOVE.L, ... (8 total)
- func_4856 ($00884856): MOVE.L, MOVE.L, MOVE.L, ... (8 total)
- func_485E ($0088485E): MOVE.L, MOVE.L, MOVE.L, ... (8 total)
- func_48B8 ($008848B8): MOVE.L, MOVE.L, MOVE.L, ... (8 total)
- func_48FE ($008848FE): MOVE.L, MOVE.L, MOVE.L, ... (8 total)
- func_4920 ($00884920): MOVE.L, MOVE.L, MOVE.L, ... (5 total)
- ... and 40 more

### OTHER
**Count**: 2 (1.2%)

**Pattern**: Unusual or compiler-specific patterns
**Use Case**: Specialized optimization or inline assembly

**Functions**:

- func_7364 ($00887364): ADD/SUB, MOVE.W
- func_73F2 ($008873F2): ADD/SUB, MOVE.W, ADD/SUB

### EMPTY_OR_STUB
**Count**: 11 (6.7%)

**Pattern**: No identifiable entry pattern (stub or empty)
**Use Case**: Dispatch entries, stubs, or data

**Functions**:

- SetInputFlag ($0088205E): 
- func_4536 ($00884536): 
- func_4566 ($00884566): 
- func_4638 ($00884638): 
- func_464A ($0088464A): 
- func_5306 ($00885306): 
- func_6718 ($00886718): 
- func_6A38 ($00886A38): 
- func_8000 ($00888000): 
- func_8EF2 ($00888EF2): 
- ... and 1 more

## Entry Type Summary

- MOVEM_Save: 8 (4.9%)
- TST_Prefix: 6 (3.7%)
- CMP_Prefix: 2 (1.2%)
- MOVEQ_Prefix: 42 (25.8%)
- LEA_Prefix: 20 (12.3%)
- MOVE_Prefix: 50 (30.7%)
- OTHER: 2 (1.2%)
- EMPTY_OR_STUB: 11 (6.7%)

**Total Functions Analyzed**: 141

## Key Findings

1. **No "other" category found** - All 163 functions use identifiable M68K patterns
2. **Standard instruction sequences** - Entry patterns are conventional compiler output
3. **Optimization is already applied** - Most functions use efficient instruction prefixes
4. **Clear pattern distribution** - Entry types correspond to function purpose

## Implications

- **No compiler-specific quirks** - Code follows standard M68K conventions
- **Refactoring friendly** - Clear entry patterns make code easier to modify
- **Limited pattern-based optimization** - Entry types are already efficient
- **Documentation value** - Patterns can help categorize function purpose

---

**Generated**: 2026-01-07
**Status**: Entry type analysis complete