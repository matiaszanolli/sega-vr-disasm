# Slave SH2 Verification Results

## User's Critical Questions - ANSWERED

Date: 2026-01-20

---

### Question 1: Is the slave entering the idle loop immediately at boot, or only after a specific event?

**ANSWER**: The Slave follows this sequence:

1. **Entry at $020650**: Slave starts here after MARS handshake
2. **Handshake wait loop ($020656-$020660)**: Waits for Master to set a flag
   - Polls memory location pointed by R14
   - Compares against expected value in R1
   - **This has an EXIT condition** - NOT an infinite idle loop
3. **Continues to $020662**: After handshake completes
4. **Initialization ($020662-$020688)**: Stack setup, register initialization
5. **Work processing loop ($020688-$020698)**: **Calls JSR @R2 in a loop**

**Conclusion**: Slave does NOT immediately idle. It waits for Master handshake, then enters a work processing loop.

---

### Question 2: Is COMM3 read by any other component (68K or Master SH-2)?

**ANSWER**: YES - COMM3 is heavily used!

**SH2 Usage**: 12 references to COMM3 address (0x2000402C)
- Found at ROM offsets:
  - 0x0203D4, 0x024AF4, 0x024D1C, 0x025050, 0x0251EC, 0x025250
  - 0x0252B8, 0x0252E4, 0x02533C, 0x025668, 0x025B1C, 0x025B7C

**68K Usage**: 55+ references to COMM3 (0xA1512C)
- Found throughout 68K code from 0x0008B4 onwards
- Heavy usage in ranges: 0x00E330-0x00E528, 0x011AAC-0x013C7A

**Infinite COMM3 write loop found at $0203CC**:
```assembly
$0203CC: D101      MOV.L @(1,PC),R1    ; R1 = 0x2000402C (COMM3)
$0203CE: 2102      MOV.L R0,@R1        ; Write R0 to COMM3
$0203D0: AFFE      BRA -4 (→ $0203CE)  ; Loop forever
$0203D2: 0009      NOP
$0203D4: 2000402C  .long 0x2000402C   ; COMM3 address
```

**CRITICAL**: This loop is at $0203CC, which is **BEFORE** the Slave entry ($020650).
- This is likely **Master SH2 code** or an **error handler**
- NOT the Slave's main execution path

**Conclusion**: COMM3 is actively used for communication. The value written is read by other components.

---

### Question 3: Does the loop only write to COMM3, or does it poll/wait on conditions?

**ANSWER**: There are MULTIPLE loops with different behaviors:

#### Loop 1: Handshake Wait ($020656-$020660) - **HAS EXIT CONDITION**
```assembly
$020656: MOV.L @(0,R14),R0     ; Read flag from memory
$020658: MOV.L @(19,PC),R1     ; Load expected value
$02065A: CMP/EQ R1,R0          ; Compare
$02065C: BT +2 (→ $020662)     ; EXIT if equal
$02065E: BRA -12 (→ $020656)   ; Loop back if not
```
**Behavior**: Polls a flag, exits when Master sets it

#### Loop 2: Work Processing ($020688-$020696) - **HAS EXIT CONDITION**
```assembly
$020688: JSR @R2               ; Call work function pointed by R2
$02068A: MOV #0,R8             ; Reset counter (delay slot)
$02068C: CMP/GT R11,R10        ; Compare R10 > R11
$02068E: BT +6 (→ $020698)     ; EXIT when R10 > R11
$020690: ADD #1,R10            ; R10++
$020692: ADD #1,R8             ; R8++
$020694: BRA -12 (→ $02068A)   ; Loop back
```
**Behavior**: Processes work items from R10 to R11, calls function in R2

#### Loop 3: COMM3 Infinite Write ($0203CC) - **NO EXIT**
```assembly
$0203CC: MOV.L @(1,PC),R1      ; R1 = COMM3 address
$0203CE: MOV.L R0,@R1          ; Write R0 to COMM3
$0203D0: BRA -4                ; Loop forever
```
**Behavior**: Truly infinite, no polling, no exit
**Location**: BEFORE Slave entry - likely Master or error handler

**Conclusion**:
- Slave has TWO loops with exit conditions (handshake + work processing)
- The infinite COMM3 write loop is NOT part of normal Slave execution path
- Slave appears to poll and process work, NOT sit idle

---

## REVISED UNDERSTANDING

### Previous Analysis: ❌ INCORRECT
- Assumed Slave sits in infinite idle loop writing "OVRN"
- Concluded 99.7% CPU waste
- Location mismatch: COMM3 loop is in Master code section

### Corrected Analysis: ✅
1. **Slave Entry**: $020650 (confirmed)
2. **Handshake Loop**: $020656-$020660 (waits for Master signal)
3. **Work Loop**: $020688-$020696 (calls JSR @R2)
4. **COMM3 Infinite Loop**: $0203CC (MASTER code, not Slave)

### Critical Unknown: **What does R2 point to?**

Three possibilities:
1. **R2 → Real work function**: Slave actively processes work
2. **R2 → Empty stub (just RTS)**: Slave loops but does no useful work
3. **R2 → Invalid/NULL**: Slave would crash

**Next step**: Trace R2 initialization to determine actual Slave behavior.

---

## Search for R2 Initialization

**Need to find**:
1. Where R2 is loaded before work loop
2. What address/function it points to
3. Whether that function does real work or is a stub

**Possible locations**:
- During Slave init ($020662-$020688)
- Written by Master via shared memory during handshake
- Loaded from ROM data table
- Set during COMM register initialization

---

## Implications

If R2 points to actual rendering code:
- ✅ Slave IS active and doing work
- ❌ Our optimization target disappears
- Need different parallelization strategy

If R2 points to stub/RTS:
- ✅ Slave wastes cycles but in a controlled way
- ✅ Can replace stub with real work
- ✅ Original optimization plan valid

If R2 is invalid/NULL:
- ⚠️ Game would crash - not observed
- Unlikely scenario

---

**Status**: Verification in progress
**Confidence**: Medium - need R2 trace
**Next Action**: Find R2 initialization and target function
