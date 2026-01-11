# 68K Pattern Reference Guide - Virtua Racing Deluxe

**Purpose**: Quick reference for common patterns and how to implement them
**Created**: 2026-01-07
**Audience**: Developers modifying or extending the codebase
**Coverage**: Practical examples and usage patterns

---

## Quick Navigation

- [Dispatcher Pattern](#dispatcher-pattern)
- [State Machine Pattern](#state-machine-pattern)
- [Memory Operations](#memory-operations)
- [Hardware Control](#hardware-control)
- [Synchronization Patterns](#synchronization-patterns)
- [Optimization Patterns](#optimization-patterns)
- [Anti-Patterns (What NOT to Do)](#anti-patterns)

---

## Dispatcher Pattern

### Pattern Type: Jump Table with Index

**When to Use**: Routing to one of multiple code paths based on index

**Basic Structure**:

```asm
; Input: D0 = index (0-15)
; A0 = will be destroyed

LEA table,A0            ; Load table address
ASL.L #2,D0             ; Scale index by 4 (32-bit pointers)
JSR (A0,D0.L)           ; Jump to handler[index]
```

**Full Example - func_7BE4**:

```asm
00887BE4  48E7 FF00     MOVEM.L D0-D7/A0-A5,-(A7)  ; Save registers
00887BE8  3238 C87A     MOVE.W  ($C87A),D1        ; Load state index
00887BEC  43F9 007BF6   LEA     $007BF6,A1        ; A1 = table
00887BF2  E349          LSL.L   #2,D1             ; D1 *= 4
00887BF4  4EB1          JSR     (A1,D1.L)         ; Jump to handler
00887BF6  [16 * 4-byte addresses follow]         ; Jump table
```

**Table Layout**:

```
Offset      Address         Handler
$007BF6     $00887C2E   → func_7C2E (entry 0)
$007BFA     $00887C32   → func_7C32 (entry 1)
...
$007C32     $70024E75   → func_6F7A4E75 (entry 15)
```

### Advanced Dispatcher - func_BA18 (Triple Table)

**Pattern**: Three dispatch tables for complex state routing

```asm
; Input: D0 = selector, D1 = state index
; Dispatch to func_BA18 with D0 = 0, 1, or 2 for different tables

LEA $14888,A0       ; Table 1 @ $14888
TST.B D0            ; Check selector
BNE.S .table2
JSR (A0,D1.L)       ; Jump via table 1
BRA.S .end

.table2:
LEA $14C88,A0       ; Table 2 @ $14C88
CMP.B #1,D0
BNE.S .table3
JSR (A0,D1.L)
BRA.S .end

.table3:
LEA $15088,A0       ; Table 3 @ $15088
JSR (A0,D1.L)

.end:
RTS
```

### When NOT to Use Dispatcher

❌ Only 2 possible values: Use conditional branch (BNE/BEQ)
❌ Values are sparse: Use table lookup differently
❌ New entries added at runtime: Use different routing method

---

## State Machine Pattern

### Basic State Handler Structure

**Pattern**: Each state gets its own handler function

```asm
; State handler entry point
; Input: A5 = pointer to state structure
; Output: D0 = next state (0-15)

00881000  48E7 FFF0    MOVEM.L D0-D7/A0-A5,-(A7) ; Save all
00881004  4EBA ...     JSR     main_logic         ; Do work
00881008  3C38 C87A    MOVE.W  D0,($C87A)        ; Update state index
0088100C  4CDF 0FFF    MOVEM.L (A7)+,D0-D7/A0-A5 ; Restore
00881010  4E75         RTS
```

**State Transition Pattern**:

```asm
; In game main loop:
; 1. Read current state from memory
; 2. Call state-specific handler
; 3. Handler updates state in memory
; 4. Loop continues with new state

LEA $C87A,A0        ; A0 = state index address
MOVE.W (A0),D0      ; D0 = current state
JSR func_BA18       ; Call dispatcher (routes to handler)
; func_BA18 will:
;   - Jump to handler[D0]
;   - Handler processes frame
;   - Handler may update ($C87A)
; Continue with new state on next frame
```

### V-INT State Machine Example

**16-State Handler Array** at func_16B2:

```
State 0: func_19FE  (default handler - doesn't change state)
State 1: func_19FE  (default - waits for SH2)
State 2: func_19FE  (default - processes data)
State 3: $18200     ❌ INVALID! (odd address causes exception)
State 4: (unused)
State 5: (SH2 comm handler)
State 6: (frame buffer handler)
...
State 15: (cleanup handler)
```

**Key Characteristic**: States execute EVERY V-INT (60Hz), so keep handlers SHORT

### Game State Handlers

**Pattern**: Different logic for different game phases

```
Game States (via func_BA18):
├─ State 0: Initialization phase
│  └─ Set up game objects, counters, etc.
├─ State 1: Running phase
│  └─ Update player, opponents, physics, etc.
├─ State 2: Pause/menu phase
│  └─ Handle UI, don't update game state
└─ State 3: Game over phase
   └─ Display results, wait for input
```

---

## Memory Operations

### Unrolled Copy Pattern

**When to Use**: Fast copying of known-size blocks (32, 60, 96, 112 bytes)

**Pattern**: Eliminate loop overhead by copying multiple items per iteration

```asm
; Copy 96 bytes without loop (24 longwords)
; Input: A1 = source, A2 = destination
; Clobbers: A1, A2

; Unrolled 24 times:
24D9                 MOVE.L  (A1)+,(A2)+      ; Copy word 1 (4 bytes)
24D9                 MOVE.L  (A1)+,(A2)+      ; Copy word 2
24D9                 MOVE.L  (A1)+,(A2)+      ; Copy word 3
...
24D9                 MOVE.L  (A1)+,(A2)+      ; Copy word 24
4E75                 RTS
```

**Performance**: ~2 cycles per byte (vs ~3-4 for loop)

**Existing Functions**:
- func_4856: 96-byte copy (24 longwords)
- func_485E: 112-byte copy (28 longwords)
- func_48B8: 32-byte copy (8 longwords)
- func_48FE: 60-byte copy (15 longwords)

### Loop-Based Copy (When Size Varies)

**Pattern**: Use DBRA for variable-size blocks

```asm
; Copy D0 longwords from A1 to A2
; Input: D0 = count (1-255), A1 = source, A2 = dest
; Output: A1, A2 updated to end of copy

.copy_loop:
24D9                 MOVE.L  (A1)+,(A2)+      ; Copy one longword
5380                 SUBQ.L  #1,D0            ; Decrement count
BNE.S   .copy_loop
4E75                 RTS
```

### Fill/Clear Pattern

**When to Use**: Initialize memory to a known value

```asm
; Clear D0 bytes starting at A1
; Input: D0 = byte count, A1 = start address

MOVEQ #0,D1              ; D1 = clear value (0)
.clear_loop:
1281                 MOVE.B  D1,(A1)+          ; Clear one byte
5380                 SUBQ.L  #1,D0             ; Decrement count
BNE.S   .clear_loop
RTS
```

---

## Hardware Control

### VDP Register Write Pattern

**When to Use**: Configuring video display processor

**Pattern**: Load register value, write to hardware address

```asm
; Set VDP mode register
31FC C200 FF68C076  MOVE.W  #$C200,$FF68C076  ; VDP mode = $C200

; Configure frame buffers
21FC 6100 0000 FF68C254  MOVE.L  #$61000000,$FF68C254  ; FB1 address
21FC 6000 0000 FF68C260  MOVE.L  #$60000000,$FF68C260  ; FB2 address
```

### COMM Protocol Pattern

**When to Use**: Communicating with SH2 processors

**Pattern**: Send command, wait for acknowledgment, read result

```asm
; Send DREQ command to SH2
; 1. Write command to COMM0
; 2. Poll COMM0 until SH2 responds
; 3. Read result from COMM0

SendDREQCommand:
11FC 0025 FFC800    MOVE.B  #$25,$FFC800      ; Command = $25
.wait_loop:
0C78 FFFF FFC000    CMP.W   #$FFFF,$FFC000   ; Wait for response
6FFA                BNE.S   .-4              ; Keep polling
; SH2 has responded
3238 FFC800        MOVE.W  $FFC800,D1        ; Read result
RTS
```

### Hardware Bus Iteration

**Pattern**: Process 6 sequential hardware registers

```asm
; For each of 6 registers:
;   1. Test if register is set
;   2. If set, decrement it
;   3. Call handler

MOVEQ #6,D0
.hw_loop:
4A68 0098           TST.W   $98(A0)          ; Test register
6F04                BLE.S   .skip            ; Skip if not set
5368 0098           SUB.W   #1,$98(A0)       ; Decrement
4EBA EC3A           JSR     handler          ; Call handler
.skip:
5340                SUBQ.W  #1,D0            ; Counter--
BNE.S   .hw_loop
RTS
```

---

## Synchronization Patterns

### V-Blank Wait Pattern

**When to Use**: Ensuring timing-critical operations complete before next frame

**Pattern**: Poll V-BLANK status until set

```asm
WaitForVBlank:
; Input: None
; Output: (A7) = call stack, nothing else modified

48E7 FF00           MOVEM.L D0-D7/A0-A5,-(A7) ; Save D/A regs
.vblank_loop:
4269 68A8           TST.W   $FF68A8          ; Test VDP status
6CFA                BNE.S   .-4              ; Wait for VBLANK bit set
4CDF 00FF           MOVEM.L (A7)+,D0-D7/A0-A5 ; Restore
4E75                RTS
```

### Frame Synchronization Pattern

**When to Use**: Ensuring game state updates synchronously

**Pattern**:
1. Wait for V-BLANK
2. Update game state
3. Notify display system
4. Return for next frame

```asm
; Main game loop:
.frame_loop:
4EB9 884998         JSR     WaitForVBlank    ; (1) Wait for VBLANK
4EB9 882080         JSR     UpdateInputState ; (2) Update input
4EB9 882066         JSR     UpdateGameState  ; (2) Update game
4EB9 8849AA         JSR     SetDisplayParams ; (3) Notify display
6CFE                BNE.S   .frame_loop     ; (4) Continue
```

---

## Optimization Patterns

### Selective Register Save

**For Performance-Critical Paths**: Save only needed registers

```asm
; Instead of saving all (48 cycles overhead):
48E7 FFFE           MOVEM.L D0-D7/A0-A7,-(A7) ; 12 bytes, 48 cycles

; Save only what you use (24 cycles overhead):
48E7 FF00           MOVEM.L D0-D7/A0-A5,-(A7) ; 10 bytes, 36 cycles

; Save minimal (12 cycles overhead):
48E7 2040           MOVEM.L D2/A5-A6,-(A7)    ; 6 bytes, 12 cycles

; When entering frequently-called function
```

### Table-Driven Instead of Conditionals

**Inefficient** (nested IFs):
```asm
CMP.B #0,D0
BNE .check1
; Handle case 0
BRA .end
.check1:
CMP.B #1,D0
BNE .check2
; Handle case 1
BRA .end
.check2:
; ... more checks
```

**Efficient** (table lookup):
```asm
LEA table,A0        ; A0 = table of handlers
MOVE.B D0,D1        ; D1 = index
ASL.L #2,D1         ; D1 *= 4
JSR (A0,D1.L)       ; Jump directly to handler

table:
DC.L handler_0, handler_1, handler_2, ...
```

### Bit Test vs Compare

**Slow** (compare):
```asm
CMP.B #$40,D0       ; 10 cycles
BNE .end
```

**Fast** (bit test):
```asm
BTST #6,D0          ; 4 cycles
BEQ .end
```

---

## Anti-Patterns (What NOT to Do)

### ❌ Anti-Pattern 1: Deeply Nested Conditionals

**BAD**:
```asm
TST.B D0
BEQ .alt1
  TST.B D1
  BEQ .alt1a
    TST.B D2
    BEQ .alt1a1
      ; Finally do work - hard to follow!
    BRA .end
  .alt1a1:
  .alt1a:
.alt1:
; Alternatives...
```

**GOOD**: Use jump table dispatcher instead

---

### ❌ Anti-Pattern 2: Register Clobbering Without Save

**BAD**:
```asm
; Caller expects D0-D7/A0-A6 to be preserved
JSR function_that_modifies_D0
; D0 is now wrong! Subtle bug

function_that_modifies_D0:
MOVE.L something,D0     ; Caller doesn't expect this!
RTS
```

**GOOD**: Document register use or save before calling

```asm
; Caller knows D0 will be modified
MOVEM.L D0,-(A7)
JSR function_that_modifies_D0
MOVEM.L (A7)+,D0
; D0 is safe
```

---

### ❌ Anti-Pattern 3: Infinite Loops in Critical Paths

**BAD**:
```asm
WaitForEvent:
.wait_loop:
TST.W $FF0000       ; Poll hardware
BEQ .wait_loop      ; Infinite if hardware never responds
RTS
```

**GOOD**: Add timeout

```asm
WaitForEvent:
MOVEQ #1000,D0      ; Timeout counter
.wait_loop:
TST.W $FF0000       ; Poll hardware
BNE .done           ; Success
SUBQ.L #1,D0        ; Decrement timeout
BNE .wait_loop      ; Try again if not timeout
; Handle timeout error
.done:
RTS
```

---

### ❌ Anti-Pattern 4: Inline Long Sequences

**BAD**:
```asm
; 200 lines of initialization code inline in EntryPoint
EntryPoint:
; ... initialize hardware register 1
; ... initialize hardware register 2
; ... initialize hardware register 3
; ... initialize hardware register 4
; ... hundreds of lines
```

**GOOD**: Factor into separate functions

```asm
EntryPoint:
JSR HardwareInit
JSR MemoryInit
JSR DisplayInit
JSR GameInit
RTS
```

---

### ❌ Anti-Pattern 5: Magic Numbers Without Documentation

**BAD**:
```asm
3038 C8A0           MOVE.W  $FFC8A0,D0      ; What is $FFC8A0?
E308                LSRL.L  #1,D0           ; Why shift?
1240                MOVE.B  D0,$FFE0        ; What does this control?
```

**GOOD**: Use named locations

```asm
; $FFC8A0 = GameState (0=init, 1=running, 2=paused)
; $FFE0 = DisplayMode register

MOVE.W GameState,D0     ; Read game state
LSL.L #1,D0             ; D0 = state * 2 (index scaling)
MOVE.B D0,DisplayMode   ; Update display for new state
```

---

## Choosing the Right Pattern

### Decision Tree

**Need to branch to many different handlers?**
→ Use Dispatcher Pattern (func_BA18 style)

**Need to track state across frames?**
→ Use State Machine Pattern (with persistent RAM location)

**Need to copy data quickly?**
→ Use Unrolled Copy (if size fixed) or Loop Copy (if size varies)

**Need to synchronize with hardware?**
→ Use Synchronization Pattern (poll with timeout)

**Need to handle multiple cases?**
→ Use Table-Driven Logic, not nested conditionals

**Hotspot function (called 10+ times/frame)?**
→ Use minimal register save (MOVEM.L D2/A5-A6)

**Rare function (called once per game)?**
→ Use full register save (MOVEM.L D0-D7/A0-A7)

---

## Pattern Checklist

Before implementing a function, verify:

- [ ] Register usage documented (which registers modified?)
- [ ] Call stack depth reasonable (avoid deep nesting)
- [ ] Performance appropriate (hot path vs cold path)
- [ ] Error handling present (what if hardware not ready?)
- [ ] State management clear (what changes? what persists?)
- [ ] Similar functions analyzed (reuse existing patterns?)
- [ ] Register save/restore balanced (MOVEM pairs match?)

---

**Generated**: 2026-01-07
**Ready for Use**: Pattern reference complete with examples and guidelines
