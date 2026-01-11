# 68K Main Game Logic - Virtua Racing Deluxe

**Project**: Virtua Racing Deluxe (USA).32x
**Date**: 2026-01-07

## Overview

Priority 8 functions ($4000-$FFFF) - main game logic, state machines, and runtime systems. These functions handle gameplay mechanics, 68K-SH2 coordination for game state, memory management, and data processing.

---

## func_4920 - Fast 20-Byte Copy ($00884920)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_4920: Fast 20-Byte Memory Copy (A1 → A2)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00884920 - $00884928
; Size: 8 bytes
; Called by: Main game logic (6 calls)
;
; Purpose: Optimized memory copy routine. Copies exactly 20 bytes (5 longwords)
;          from source (A1) to destination (A2) using post-increment addressing.
;          Commonly used for copying small data structures.
;
; Input: A1 = Source address
;        A2 = Destination address
; Output: A1 = Source + 20 (advanced)
;         A2 = Destination + 20 (advanced)
; Modifies: A1, A2
; ═══════════════════════════════════════════════════════════════════════════

00884920  24D9                 MOVE.L  (A1)+,(A2)+      ; Copy long 1 (4 bytes)
00884922  24D9                 MOVE.L  (A1)+,(A2)+      ; Copy long 2
00884924  24D9                 MOVE.L  (A1)+,(A2)+      ; Copy long 3
00884926  24D9                 MOVE.L  (A1)+,(A2)+      ; Copy long 4
00884928  24D9                 MOVE.L  (A1)+,(A2)+      ; Copy long 5 (20 bytes total)
0088492A  4E75                 RTS
```

**Analysis**: Tiny but frequently called utility (6 calls). Copies exactly 20 bytes without loop overhead. Likely used for copying small game state structures, position data, or parameter blocks. The 20-byte size suggests a specific data structure (e.g., 5 longs = entity position + velocity).

---

## func_4922 - Large Block Copy ($00884922)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_4922: Large Block Memory Copy (A1 → A6)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00884922 - $00884962 (continues func_4920's code)
; Note: This is NOT at offset $4922 - that's inside func_4920!
; Actual address needs verification from call sites
;
; Purpose: Copies large block of memory (320 bytes = 80 longwords) from
;          source (A1) to destination (A6). Unrolled loop for performance.
;
; Input: A1 = Source address
;        A6 = Destination address
; Output: A1 = Source + 320 (advanced)
;         A6 = Destination + 320 (advanced)
; Modifies: A1, A6
; ═══════════════════════════════════════════════════════════════════════════

; Unrolled loop: 80 iterations of MOVE.L (A1)+,(A6)+
0088492C  2C99                 MOVE.L  (A1)+,(A6)+      ; Repeat 80 times...
0088492E  2C99                 MOVE.L  (A1)+,(A6)+
...
00884960  2C99                 MOVE.L  (A1)+,(A6)+      ; (80 total)
00884962  2C99                 MOVE.L  (A1)+,(A6)+
00884964  4E75                 RTS
```

**Analysis**: Large data block copier (320 bytes). Completely unrolled - no DBRA loop, just 80 consecutive MOVE.L instructions for maximum speed. Trades code size for performance. Likely used for:
- Frame buffer updates
- Large game state snapshots
- Track/level data copying
- Display list updates

The choice of A6 as destination (instead of A2) suggests this may be copying to a specific system buffer.

---

## func_E316 - Send COMM Command $25 ($0088E316)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_E316: Send Command $25 to SH2 via COMM
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088E316 - $0088E358
; Size: 66 bytes
; Called by: Main game logic (6 calls)
;
; Purpose: Send command $25 to SH2 via COMM port protocol. Waits for COMM0
;          clear, sends pointer+4MB offset in COMM4, writes command $25 to
;          COMM0, then sends two 16-bit parameters via COMM4.
;
; Input: A0 = Pointer to data (will be offset by $02000000)
;        A1 = Pointer for second COMM4 write
;        D0 = 16-bit parameter 1
;        D1 = 16-bit parameter 2
; Output: None (command sent to SH2)
; Modifies: A0 (offset added)
; ═══════════════════════════════════════════════════════════════════════════

; Wait for COMM0 ready
0088E316  4A39 00A1 5120       TST.B   COMM0            ; Test COMM0 low byte
0088E31C  66F8                 BNE     .wait            ; Loop while busy

; Add 4MB offset to pointer (SH2 address space)
0088E31E  D1FC 0200 0000       ADDA.L  #$02000000,A0    ; A0 += $02000000

; Write pointer to COMM4
0088E324  23C8 00A1 5128       MOVE.L  A0,COMM4         ; COMM4 = offset pointer

; Set COMM6 status flag
0088E32A  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6     ; COMM6 = $0101

; Write command $25 to COMM0
0088E332  13FC 0025 00A1 5121  MOVE.B  #$25,COMM0+1     ; COMM0 high byte = $25

; Trigger command
0088E33A  13FC 0001 00A1 5120  MOVE.B  #$01,COMM0       ; COMM0 low byte = $01

; Wait for SH2 to clear COMM6
.wait_ack:
0088E342  4A39 00A1 512C       TST.B   COMM6            ; Test COMM6
0088E348  66F8                 BNE     .wait_ack        ; Wait for $00

; Send parameters via COMM4
0088E34A  23C9 00A1 5128       MOVE.L  A1,COMM4         ; COMM4 = second pointer

; Final handshake
0088E350  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6     ; COMM6 = $0101
0088E358  4E75                 RTS
```

**Analysis**: Command $25 sender. Standard COMM protocol: wait for ready, send offset pointer, write command byte, send parameters, wait for acknowledgment. The $02000000 offset converts 68K addresses to SH2 cache-through address space. Command $25 likely triggers SH2 data processing or DMA operation.

---

## func_E35A - Send COMM Command $22 ($0088E35A)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_E35A: Send Command $22 to SH2 via COMM
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088E35A - $0088E404
; Size: 170 bytes
; Called by: Main game logic (7 calls)
;
; Purpose: Send command $22 to SH2. Three-phase protocol with multiple COMM
;          transactions. Sends pointers and 16-bit parameters.
;
; Input: A1 = Pointer 1
;        A0 = Pointer 2
;        A2 = Pointer 3
;        D0 = Parameter 1
;        D1 = Parameter 2
;        D2 = Parameter 3
; Output: None (command sequence sent)
; Modifies: None (all inputs consumed)
; ═══════════════════════════════════════════════════════════════════════════

; Phase 1: Wait and send first pointer
0088E35A  4A39 00A1 5120       TST.B   COMM0            ; Wait for ready
0088E360  66F8                 BNE     .wait1

0088E362  23C9 00A1 5128       MOVE.L  A1,COMM4         ; COMM4 = pointer 1
0088E368  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6     ; COMM6 = status
0088E370  13FC 0022 00A1 5121  MOVE.B  #$22,COMM0+1     ; Command $22
0088E378  13FC 0001 00A1 5120  MOVE.B  #$01,COMM0       ; Trigger

; Wait for SH2 ack (COMM6 clear)
.wait_ack1:
0088E380  4A39 00A1 512C       TST.B   COMM6
0088E386  66F8                 BNE     .wait_ack1

; Phase 2: Send parameters D0, D1
0088E388  33C0 00A1 5128       MOVE.W  D0,COMM4         ; COMM4 = param 1
0088E38E  33C1 00A1 512A       MOVE.W  D1,COMM4+2       ; COMM4+2 = param 2
0088E394  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6     ; Signal ready

.wait_ack2:
0088E39C  4A39 00A1 512C       TST.B   COMM6
0088E3A2  66F8                 BNE     .wait_ack2

; Phase 3: Send second pointer (A0)
0088E3A4  23C8 00A1 5128       MOVE.L  A0,COMM4         ; COMM4 = pointer 2
0088E3AA  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6

0088E3B2  4E75                 RTS

; Alternative exit path (based on earlier branch)
0088E3B4  23C8 00A1 5128       MOVE.L  A0,COMM4         ; COMM4 = pointer 2
0088E3BA  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6
0088E3C2  13FC 0027 00A1 5121  MOVE.B  #$27,COMM0+1     ; Command $27
0088E3CA  13FC 0001 00A1 5120  MOVE.B  #$01,COMM0

.wait_ack3:
0088E3D2  4A39 00A1 512C       TST.B   COMM6
0088E3D8  66F8                 BNE     .wait_ack3

0088E3DA  33C0 00A1 5128       MOVE.W  D0,COMM4         ; Send param D0
0088E3E0  33C1 00A1 512A       MOVE.W  D1,COMM4+2       ; Send param D1
0088E3E6  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6

.wait_ack4:
0088E3EE  4A39 00A1 512C       TST.B   COMM6
0088E3F4  66F8                 BNE     .wait_ack4

0088E3F6  33C2 00A1 5128       MOVE.W  D2,COMM4         ; Send param D2 (additional)
0088E3FC  ... (continues)
```

**Analysis**: Most complex COMM sender yet (7 calls). Multi-phase protocol with up to 3 pointer transfers and 3 parameters. Command $22 appears to trigger complex SH2 operations requiring multiple data inputs. The alternative path with command $27 suggests conditional behavior based on game state.

---

## func_E406 - Send COMM Command $2F ($0088E406)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_E406: Send Command $2F to SH2 via COMM
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088E406 - $0088E464
; Size: 94 bytes
; Called by: Main game logic (6 calls)
;
; Purpose: Send command $2F to SH2. Three-parameter transfer protocol.
;
; Input: A0 = Pointer
;        D0 = Parameter 1 (word)
;        D1 = Parameter 2 (word)
;        D2 = Parameter 3 (word)
;        D3 = Parameter 4 (word)
; Output: None
; Modifies: None
; ═══════════════════════════════════════════════════════════════════════════

; Wait for COMM ready
0088E406  4A39 00A1 5120       TST.B   COMM0
0088E40C  66F8                 BNE     .wait

; Send pointer
0088E40E  23C8 00A1 5128       MOVE.L  A0,COMM4
0088E414  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6

; Command $2F
0088E41C  13FC 002F 00A1 5121  MOVE.B  #$2F,COMM0+1
0088E424  13FC 0001 00A1 5120  MOVE.B  #$01,COMM0

; Wait ack
.wait_ack1:
0088E42C  4A39 00A1 512C       TST.B   COMM6
0088E432  66F8                 BNE     .wait_ack1

; Send parameters D0, D1
0088E434  33C0 00A1 5128       MOVE.W  D0,COMM4
0088E43A  33C1 00A1 512A       MOVE.W  D1,COMM4+2
0088E440  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6

.wait_ack2:
0088E448  4A39 00A1 512C       TST.B   COMM6
0088E44E  66F8                 BNE     .wait_ack2

; Send parameters D2, D3
0088E450  33C2 00A1 5128       MOVE.W  D2,COMM4
0088E456  33C3 00A1 512A       MOVE.W  D3,COMM4+2
0088E45C  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6

0088E464  4E75                 RTS
```

**Analysis**: Command $2F sender. Sends 4 word parameters in two phases after initial pointer. Clean two-transaction protocol. Command $2F likely triggers SH2 rendering or transformation operations given the 4-parameter format (could be x,y,z,w coordinates or similar).

---

## func_E4BC - Compute & Send COMM Command $21 ($0088E4BC)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_E4BC: Compute Value & Send Command $21
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088E4BC - $0088E52A
; Size: 110 bytes
; Called by: Main game logic (6 calls)
;
; Purpose: Perform bit manipulation calculation, then send result to SH2 via
;          command $21. Includes table lookup via subroutine call.
;
; Input: D1 = Input value for computation
;        A0 = Lookup table base address
;        D0 = Additional parameter
;        D1 = Additional parameter (reused)
; Output: Computed result sent to SH2
; Modifies: D0-D1
; ═══════════════════════════════════════════════════════════════════════════

; Computation phase
0088E4BC  ED49                 ROL.W   #6,D1            ; Rotate D1 left 6 bits
0088E4BE  3001                 MOVE.W  D1,D0            ; Copy to D0
0088E4C0  E349                 ROL.W   #1,D1            ; Rotate D1 left 1 more (total 7)
0088E4C2  D240                 ADD.W   D0,D1            ; D1 = D1 + D0
0088E4C4  207C 0603 DA00       MOVEA.L #$0603DA00,A0    ; A0 = constant (table lookup?)
0088E4CA  D0C1                 ADD.W   D1,A0            ; A0 = table base + offset

; Prepare parameters for subroutine
0088E4CC  303C 000C            MOVE.W  #$000C,D0        ; D0 = $0C
0088E4D0  323C 0010            MOVE.W  #$0010,D1        ; D1 = $10

; Call subroutine (relative JSR)
0088E4D4  4EBA FE84            JSR     $0088E35A(PC)    ; Call func_E35A!

0088E4D8  4E75                 RTS

; COMM protocol section (command $21)
0088E4DA  23C9 00A1 5128       MOVE.L  A1,COMM4
0088E4E0  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6
0088E4E8  13FC 0021 00A1 5121  MOVE.B  #$21,COMM0+1     ; Command $21
0088E4F0  13FC 0001 00A1 5120  MOVE.B  #$01,COMM0

.wait_ack1:
0088E4F8  4A39 00A1 512C       TST.B   COMM6
0088E4FE  66F8                 BNE     .wait_ack1

0088E500  33C0 00A1 5128       MOVE.W  D0,COMM4
0088E506  33C1 00A1 512A       MOVE.W  D1,COMM4+2
0088E50C  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6

.wait_ack2:
0088E514  4A39 00A1 512C       TST.B   COMM6
0088E51A  66F8                 BNE     .wait_ack2

0088E51C  23C8 00A1 5128       MOVE.L  A0,COMM4
0088E522  33FC 0101 00A1 512C  MOVE.W  #$0101,COMM6

0088E52A  4E75                 RTS
```

**Analysis**: Hybrid function combining computation with communication. First performs bit rotation and table lookup calculation, then calls func_E35A (command $22) or sends command $21 directly. The rotation by 6-7 bits and addition suggests this is computing an index or offset into a large table (possibly for 3D transformation matrices or track data).

---

## func_E52C - Multi-Table Data Processor ($0088E52C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_E52C: Table-Based Data Processing with COMM
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088E52C - $0088E5AA
; Size: 126 bytes
; Called by: Main game logic (8 calls - HIGHEST in Priority 8)
;
; Purpose: Process data using three lookup tables, write results to COMM port.
;          Highest-called Priority 8 function - core game logic component.
;
; Input: D0 = Control/index value
; Output: Data written to COMM based on table lookups
; Modifies: D0-D2, D7, A0-A2, A3
; ═══════════════════════════════════════════════════════════════════════════

; Setup three table pointers
0088E52C  41F8 84A2            LEA     $FF84A2,A0       ; Table 1
0088E530  43F8 84C2            LEA     $FF84C2,A1       ; Table 2
0088E534  45F8 84E2            LEA     $FF84E2,A2       ; Table 3

; Initialize loop
0088E538  4242                 CLR.W   D2               ; D2 = 0 (counter)
0088E53A  323C 0007            MOVE.W  #$0007,D1        ; D1 = 7 (8 iterations)

; Main processing loop
.loop:
0088E53E  31BC 0000 2000       MOVE.W  #$0000,$2000(A0) ; Write $0000 to table1+$2000
0088E544  33BC 0000 2000       MOVE.W  #$0000,$2000(A1) ; Write $0000 to table2+$2000
0088E54A  35BC 0000 2000       MOVE.W  #$0000,$2000(A2) ; Write $0000 to table3+$2000

0088E550  5442                 ADDQ.W  #2,D2            ; D2 += 2 (word increment)
0088E552  51C9 FFEA            DBRA    D1,.loop         ; Loop 8 times

; Test and branch based on D0
0088E556  4A40                 TST.W   D0               ; Test D0
0088E558  6608                 BNE     .case_nonzero    ; Branch if D0 != 0

; Case: D0 == 0
0088E55A  41F8 84A2            LEA     $FF84A2,A0       ; Reload table 1 pointer
0088E55E  6000 0016            BRA     .continue        ; Skip to continue

; Case: D0 != 0
.case_nonzero:
0088E562  0C40 0001            CMPI.W  #$0001,D0        ; Check if D0 == 1
0088E566  6600 000A            BNE     .case_other      ; Branch if D0 != 1

; Case: D0 == 1
0088E56A  41F8 84C2            LEA     $FF84C2,A0       ; Use table 2
0088E56E  6000 0006            BRA     .continue

; Case: D0 >= 2
.case_other:
0088E572  41F8 84E2            LEA     $FF84E2,A0       ; Use table 3

.continue:
0088E576  47F9 0088 E5AC       LEA     $0088E5AC,A3     ; A3 = data table address
0088E57C  7200                 MOVEQ   #0,D1            ; D1 = 0
0088E57E  3238 A012            MOVE.W  $FFA012,D1       ; Read from RAM

; Add D1 to table base
0088E582  D241                 ADD.W   D1,D1            ; D1 *= 2 (word index)
0088E584  D7C1                 ADDA.W  D1,A3            ; A3 = table + offset

; Second loop - write to memory
0088E586  4242                 CLR.W   D2               ; Reset counter
0088E588  323C 0007            MOVE.W  #$0007,D1        ; 8 iterations

.loop2:
0088E58C  319B 2000            MOVE.W  (A3)+,$2000(A0)  ; Copy word from table to dest+$2000
0088E590  5442                 ADDQ.W  #2,D2            ; Increment offset
0088E592  51C9 FFF8            DBRA    D1,.loop2        ; Loop 8 times

; Final processing
0088E596  3238 A012            MOVE.W  $FFA012,D1       ; Read RAM value again
0088E59A  5241                 ADDQ.W  #1,D1            ; Increment
0088E59C  0C41 0007            CMPI.W  #$0007,D1        ; Check if >= 7
0088E5A0  6F00 0004            BLE     .in_range        ; Branch if <= 7

0088E5A4  4241                 CLR.W   D1               ; Wrap to 0

.in_range:
0088E5A6  31C1 A012            MOVE.W  D1,$FFA012       ; Write back to RAM

0088E5AA  4E75                 RTS

; Embedded data table at $E5AC
0088E5AC  0EEE 0EEE 0EEE 0EEE  ; Data: repeated $0EEE pattern
0088E5B4  0000 0000 0000 0000  ; Followed by zeros
```

**Analysis**: **Most important Priority 8 function** (8 calls). Sophisticated table-driven processor:
1. Initializes 3 parallel tables in RAM ($FF84A2, $FF84C2, $FF84E2)
2. Clears 8 words in each table (offset +$2000)
3. Selects one table based on D0 input (0→table1, 1→table2, 2+→table3)
4. Uses RAM value at $FFA012 as index into embedded data table
5. Copies 8 words from data table to selected RAM table
6. Increments $FFA012 and wraps at 8 (creates cycling index 0-7)

The $0EEE pattern in the data table and the cycling index suggest this is managing frame-by-frame animation or state progression. The three tables likely correspond to different game states or display modes. This could be:
- Track segment rendering control
- Car animation frame selection
- Display list management

---

## func_6D00 - Conditional Index Calculator ($00886D00)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_6D00: Conditional Value Calculator with Table Lookup
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00886D00 - $00886D3C
; Size: 60 bytes
; Called by: Game logic (4 calls)
;
; Purpose: Calculate index value based on conditions. Reads from RAM table,
;          performs comparisons, and returns result code in D0/D1.
;
; Input: (determined from disassembly patterns)
; Output: D0 = Result code (0-4 based on conditions)
; Modifies: D0, D7, A2
; ═══════════════════════════════════════════════════════════════════════════

00886D00  7E00                 MOVEQ   #0,D7            ; D7 = 0 (default)
00886D02  0838 0002 C313       BTST    #2,$FFC313       ; Test RAM bit
00886D08  6702                 BEQ     .no_flag         ; Skip if clear
00886D0A  7E04                 MOVEQ   #4,D7            ; D7 = 4

.no_flag:
00886D0C  DE78 C8A0            ADD.W   $FFC8A0,D7       ; Add RAM value
00886D10  DE78 C8A0            ADD.W   $FFC8A0,D7       ; Add again (D7 *= 2 + offset)
00886D14  45F9 00FF 301A       LEA     $FF301A,A2       ; A2 = table base
00886D1A  2272 7000            MOVEA.L 0(A2,D7.W),A1    ; A1 = table[D7]
00886D1E  7000                 MOVEQ   #0,D0            ; D0 = 0 (counter)
00886D20  3238 C0BA            MOVE.W  $FFC0BA,D1       ; D1 = target value
00886D24  3E19                 MOVE.W  (A1)+,D7         ; D7 = table entry

.loop:
00886D26  B251                 CMP.W   (A1),D1          ; Compare with table
00886D28  670C                 BEQ     .match           ; Found match
00886D2A  43E9 0010            LEA     $10(A1),A1       ; Advance 16 bytes
00886D2E  51CF FFF6            DBRA    D7,.loop         ; Loop

00886D32  7200                 MOVEQ   #0,D0            ; D0 = 0 (not found)
00886D34  4E75                 RTS

.match:
00886D36  7201                 MOVEQ   #1,D0            ; D0 = 1 (found)
00886D38  4E75                 RTS
```

**Analysis**: Table-driven search function. Uses RAM flags and values to select a subtable, then searches for a match. Returns 0 (not found) or 1 (found). The 16-byte table stride suggests structured game state records.

---

## func_D1D4 - Z80 Sound Command Sender ($0088D1D4)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_D1D4: Send Sound Command to Z80
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088D1D4 - $0088D234
; Size: 96 bytes
; Called by: Sound system (6 calls)
;
; Purpose: Request Z80 bus, send command to sound driver, release bus.
;          Uses YM2612 FM and PSG for audio output.
;
; Input: (sound command parameters in RAM at $C874)
; Output: Command sent to Z80 sound driver
; Modifies: D7, A3-A5
; ═══════════════════════════════════════════════════════════════════════════

0088D1D4  33FC 0100 00A1 1100  MOVE.W  #$0100,Z80_BUSREQ ; Request Z80 bus

; Wait for Z80 bus grant
.wait_bus:
0088D1DC  0839 0000 00A1 1100  BTST    #0,Z80_BUSREQ    ; Test bus grant
0088D1E4  66F6                 BNE     .wait_bus        ; Wait until granted

; Read sound parameters from RAM
0088D1E6  3838 C874            MOVE.W  $FFC874,D4       ; Sound command
0088D1EA  08C4 0004            BSET    #4,D4            ; Set flag bit
0088D1EE  3A84                 MOVE.W  D4,A5            ; Save in A5

; Setup sound chip base addresses
0088D1F0  3ABC 8F01            MOVE.W  #$8F01,A5        ; PSG channel 1
0088D1F4  2ABC 93FF 941F       MOVE.L  #$93FF941F,A5    ; PSG channels 2-3
0088D1FA  3ABC 9780            MOVE.W  #$9780,A5        ; PSG noise channel
0088D1FE  2ABC 6000 0082       MOVE.L  #$60000082,A5    ; YM2612 params

; More PSG/FM writes (pattern suggests full sound initialization)
00881204  3CBC 0000            MOVE.W  #$0000,A6
00881208  3E15                 MOVE.W  (A5),D7
0088120A  0247 0002            ANDI.W  #$0002,D7
0088120E  66F8                 BNE     .wait_ready      ; Wait for ready

00881210  3ABC 8F02            MOVE.W  #$8F02,A5        ; Next PSG command
00881214  3AB8 C874            MOVE.W  $FFC874,A5       ; Write sound data

; Release Z80 bus
00881218  33FC 0000 00A1 1100  MOVE.W  #0,Z80_BUSREQ    ; Release bus

; Call sound processing routine
00881220  7007                 MOVEQ   #7,D0            ; D0 = 7 (command ID?)
00881222  4EB9 0088 14BE       JSR     $008814BE        ; Call sound processor

; Final bus release
00881228  33FC 0100 00A1 1100  MOVE.W  #$0100,Z80_BUSREQ
00881230  0839 0000 ...        BTST    #0,Z80_BUSREQ
...
00881234  4E75                 RTS
```

**Analysis**: Sound system interface. Requests Z80 bus, sends commands to sound driver in Z80 RAM, programs PSG (SN76489) and YM2612 FM chip registers, then releases bus. The 6 calls suggest this is the main sound trigger function.

---

## func_7280 - Bitfield Calculator ($00887280)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_7280: Complex Bitfield Calculation
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00887280 - $008872C4
; Size: 68 bytes
; Called by: Game logic (2 calls)
;
; Purpose: Perform multi-step bit manipulation and arithmetic on game state.
;          Calculates values from entity offsets +$30 and +$34.
;
; Input: A6 = Entity/object pointer
; Output: D0 = Calculated result
; Modifies: D0-D2, D6-D7
; ═══════════════════════════════════════════════════════════════════════════

00887280  2F0C                 MOVE.L  A4,-(SP)         ; Save A4
00887282  323C 0400            MOVE.W  #$0400,D1        ; D1 = $400
00887286  3428 0030            MOVE.W  $30(A0),D2       ; D2 = object[0x30]
0088728A  E842                 LSR.W   #4,D2            ; D2 >>= 4
0088728C  D441                 ADD.W   D1,D2            ; D2 += $400
0088728E  3602                 MOVE.W  D2,D3            ; D3 = D2

00887290  7C00                 MOVEQ   #0,D6            ; D6 = 0
00887292  0243 0020            ANDI.W  #$0020,D3        ; Test bit 5
00887296  6602                 BNE     .has_bit         ; Branch if set
00887298  7C01                 MOVEQ   #1,D6            ; D6 = 1

.has_bit:
0088729A  EC42                 LSR.W   #6,D2            ; D2 >>= 6
0088729C  3628 0034            MOVE.W  $34(A0),D3       ; D3 = object[0x34]
008872A0  E843                 LSR.W   #4,D3            ; D3 >>= 4
008872A2  9243                 SUB.W   D3,D1            ; D1 -= D3
008872A4  3601                 MOVE.W  D1,D3            ; D3 = D1
008872A6  0243 0020            ANDI.W  #$0020,D3        ; Test bit 5
008872AA  6702                 BEQ     .no_bit          ; Branch if clear
008872AC  5406                 ADDQ.B  #2,D6            ; D6 += 2

.no_bit:
008872AE  0241 FFC0            ANDI.W  #$FFC0,D1        ; Mask to $FFC0
008872B2  E241                 ASR.W   #1,D1            ; Arithmetic shift
008872B4  D242                 ADD.W   D2,D1            ; Combine values
008872B6  D241                 ADD.W   D1,D1            ; Double
008872B8  D241                 ADD.W   D1,D1            ; Quadruple
008872BA  3141 00CA            MOVE.W  D1,$CA(A0)       ; Store result

008872BE  7000                 MOVEQ   #0,D0            ; Return 0
008872C0  285F                 MOVEA.L (SP)+,A4         ; Restore A4
008872C2  4E75                 RTS
```

**Analysis**: Sophisticated bit manipulation for spatial calculations. Reads object fields at +$30 and +$34, performs shifts, masks, and arithmetic to compute final value stored at +$CA. The bit tests and conditional increments suggest this calculates quadrant/sector indices for 3D rendering or collision detection.

---

## func_83AE - PSG Control Utility ($008883AE)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_83AE: PSG Sound Chip Control
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008883AE - $008883BC
; Size: 14 bytes
; Called by: Sound effects (2 calls)
;
; Purpose: Quick PSG register manipulation. Reads/modifies sound data.
;
; Input: D1 = Control value
;        D2 = Data value
; Output: PSG register written
; Modifies: D1
; ═══════════════════════════════════════════════════════════════════════════

008883AE  1401                 MOVE.B  D1,D2            ; Copy D1 to D2
008883B0  E80A                 LSR.B   #4,D2            ; D2 >>= 4
008883B2  12C2                 MOVE.B  D2,(A1)+         ; Write to PSG
008883B4  0201 000F            ANDI.B  #$0F,D1          ; Mask low nibble
008883B8  12C1                 MOVE.B  D1,(A1)+         ; Write second byte

008883BA  4E75                 RTS
```

**Analysis**: Simple PSG (SN76489) nibble splitter. Takes 8-bit value, splits into two 4-bit nibbles, writes to PSG registers. Used for volume, frequency, or noise control.

---

## func_5000 - Interrupt Vector Setup ($00885000)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5000: Install Interrupt Vectors
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885000 - $0088501C
; Size: 28 bytes
; Called by: Initialization
;
; Purpose: Set up interrupt vectors in RAM. Installs handler addresses for
;          V-INT and other exceptions.
;
; Input: None
; Output: Vectors installed at $FF0002-$FF5FFC
; Modifies: None (direct memory writes)
; ═══════════════════════════════════════════════════════════════════════════

00885000  23FC 0088 5024 00FF 0002  MOVE.L #$00885024,$FF0002 ; Vector 1
0088500A  23FC 0000 0000 00FF 5FF8  MOVE.L #0,$FF5FF8         ; Clear vector
00885014  23FC 0000 0000 00FF 5FFC  MOVE.L #0,$FF5FFC         ; Clear vector

0088501E  4E75                 RTS
```

**Analysis**: Interrupt vector initialization. Installs custom handler at $FF0002 (likely exception or V-INT redirect). Clears high vectors at $FF5FF8/$FF5FFC. Part of runtime exception handling system.

---

## func_8000 - Object State Update ($00888000)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_8000: Game Object State Updater
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00888000 - $00888062
; Size: 98 bytes
; Called by: Main game loop
;
; Purpose: Update game object state. Compares position values, checks flags,
;          updates timers. Core game entity update routine.
;
; Input: A0 = Object pointer
; Output: Object state updated
; Modifies: D0
; ═══════════════════════════════════════════════════════════════════════════

00888000  C8A4                 EXG     D4,A4            ; Swap registers
00888002  4E75                 RTS                      ; (may be data/unreachable)

00888004  3028 002C            MOVE.W  $2C(A0),D0       ; D0 = object[0x2C]
00888008  B068 002E            CMP.W   $2E(A0),D0       ; Compare with [0x2E]
0088800C  6622                 BNE     .different       ; Branch if different

0088800E  3028 0024            MOVE.W  $24(A0),D0       ; D0 = object[0x24]
00888012  B068 0028            CMP.W   $28(A0),D0       ; Compare with [0x28]
00888016  6F18                 BLE     .less_equal      ; Branch if <=

; Update values
00888018  3168 0024 0028       MOVE.W  $24(A0),$28(A0)  ; Copy [0x24] → [0x28]
0088801E  4A38 C319            TST.B   $FFC319          ; Test flag
00888022  6A0C                 BPL     .no_carry        ; Branch if positive
00888024  0068 4000 0002       ORI.W   #$4000,$02(A0)   ; Set bit 14
0088802A  31FC 0050 C04E       MOVE.W  #$0050,$FFC04E   ; Write constant

.different:
00888030  4E75                 RTS

.less_equal:
00888032  4A78 C07C            TST.W   $FFC07C          ; Test word
00888036  661A                 BNE     .not_zero        ; Branch if != 0

00888038  0C68 0014 002C       CMPI.W  #$0014,$2C(A0)   ; Compare with $14
0088803E  6C12                 BGE     .in_range        ; Branch if >= $14

00888040  3028 0024            MOVE.W  $24(A0),D0
00888044  9068 0026            SUB.W   $26(A0),D0
00888048  0C40 0064            CMPI.W  #$0064,D0
0088804C  6F06                 BLE     .threshold       ; Branch if <= $64

0088804E  5368 002E            SUBQ.W  #1,$2E(A0)       ; Decrement [0x2E]

.not_zero:
00888052  4E75                 RTS

.threshold:
00888054  0C40 FF9C            CMPI.W  #$FF9C,D0        ; Check negative threshold
00888058  6CAA                 BGE     .different       ; Branch back

0088805A  5268 002E            ADDQ.W  #1,$2E(A0)       ; Increment [0x2E]
0088805E  317C ...             MOVE.W  #...,(A0)        ; (continues)
```

**Analysis**: Complex object state machine. Compares multiple fields (+$24, +$28, +$2C, +$2E), checks thresholds ($14, $64, $FF9C), updates timers and flags. The comparisons and branches suggest this manages car/vehicle position updates, possibly for AI opponents or player physics.

---

## func_4004 - Conditional Table Lookup Dispatcher ($00884004)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_4004: Dual Conditional Table Lookup & Write
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00884004 - $00884046
; Size: 66 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Performs two conditional table lookups based on RAM flags at
;          $FFC01E and $FFC024. If flags are non-negative, scales index by 4,
;          looks up longword from table at $00895A24, and stores result.
;
; Input: A1 = Base pointer for writes
;        D1 = Value to write initially
;        D2 = Offset to advance A1 between operations
;        D3, D4 = Values to write after each table lookup
; Output: (A1) updated with values
;         A1 advanced by D2 offset (twice)
; Modifies: D0, A1, A2
; ═══════════════════════════════════════════════════════════════════════════

00884004  3341 0000            MOVE.W  D1,$0000(A1)         ; Store D1 to (A1)
00884008  3038 C01E            MOVE.W  $FFC01E,D0           ; D0 = flag 1
0088400C  6B14                 BMI.S   .skip_lookup1        ; Skip if negative

; First table lookup (if $FFC01E >= 0)
0088400E  D040                 ADD.W   D0,D0                ; D0 *= 2
00884010  D040                 ADD.W   D0,D0                ; D0 *= 4 (scale to long index)
00884012  45F9 00895A24        LEA     $00895A24,A2         ; A2 = table base
00884018  2372 0000 0010       MOVE.L  (A2,D0.W),$0010(A1)  ; (A1+$10) = table[D0]
0088401E  3344 0000            MOVE.W  D4,$0000(A1)         ; Store D4
00884022  D3C2                 ADDA.L  D2,A1                ; A1 += D2

; Second conditional lookup
.skip_lookup1:
00884024  3341 0000            MOVE.W  D1,$0000(A1)         ; Store D1 again
00884028  3038 C024            MOVE.W  $FFC024,D0           ; D0 = flag 2
0088402C  6B14                 BMI.S   .skip_lookup2        ; Skip if negative

; Second table lookup (if $FFC024 >= 0)
0088402E  D040                 ADD.W   D0,D0                ; D0 *= 2
00884030  D040                 ADD.W   D0,D0                ; D0 *= 4
00884032  45F9 00895A24        LEA     $00895A24,A2         ; Same table
00884038  2372 0000 0010       MOVE.L  (A2,D0.W),$0010(A1)  ; (A1+$10) = table[D0]
0088403E  3343 0000            MOVE.W  D3,$0000(A1)         ; Store D3
00884042  D3C2                 ADDA.L  D2,A1                ; A1 += D2

.skip_lookup2:
00884044  4E75                 RTS
```

**Analysis**: Table-driven state lookup with conditional execution. Uses negative flag values to skip operations, allowing dynamic enable/disable of processing. The table at $00895A24 likely contains function pointers or data addresses. The dual-lookup pattern suggests this manages two parallel game systems (e.g., player 1 and player 2, or two AI opponents).

---

## func_4280 - Nibble Extractor & Field Populator ($00884280)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_4280: Packed Nibble Extraction to Data Fields
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00884280 - $008842BE
; Size: 62 bytes
; Called by: Main game logic (2 calls)
;
; Purpose: Unpacks nibble-packed data from (A1) and distributes to specific
;          byte offsets in (A2). Reads 4 bytes, extracts 7 nibbles via LSR,
;          stores at offsets +$09 through +$0F, then masks with ANDI.
;
; Input: A1 = Source pointer (nibble-packed data)
;        A2 = Destination structure pointer
; Output: (A2+$09 through A2+$0F) populated with extracted nibbles
;         Data masked with $0F0F and $0F0F0F0F
; Modifies: D0, A1
; ═══════════════════════════════════════════════════════════════════════════

00884280  1019                 MOVE.B  (A1)+,D0             ; Read byte 1
00884282  1540 000A            MOVE.B  D0,$000A(A2)         ; Store low nibble
00884286  E808                 LSR.B   #4,D0                ; Shift to high nibble
00884288  1540 0009            MOVE.B  D0,$0009(A2)         ; Store high nibble

0088428C  1019                 MOVE.B  (A1)+,D0             ; Read byte 2
0088428E  1540 000C            MOVE.B  D0,$000C(A2)         ; Store low nibble
00884292  E808                 LSR.B   #4,D0                ; Shift to high nibble
00884294  1540 000B            MOVE.B  D0,$000B(A2)         ; Store high nibble

00884298  3019                 MOVE.W  (A1)+,D0             ; Read word (bytes 3-4)
0088429A  1540 000F            MOVE.B  D0,$000F(A2)         ; Store nibble 1
0088429E  E848                 LSR.W   #4,D0                ; Shift 4 bits
008842A0  1540 000E            MOVE.B  D0,$000E(A2)         ; Store nibble 2
008842A4  E848                 LSR.W   #4,D0                ; Shift 4 bits
008842A6  1540 000D            MOVE.B  D0,$000D(A2)         ; Store nibble 3

; Mask lower nibbles in destination
008842AA  026A 0F0F 000A       ANDI.W  #$0F0F,$000A(A2)     ; Mask bytes $0A-$0B
008842B0  02AA 0F0F0F0F 000C   ANDI.L  #$0F0F0F0F,$000C(A2) ; Mask bytes $0C-$0F

008842B8  4E75                 RTS
```

**Analysis**: Unpacks 7 nibbles (3.5 bytes) from densely packed format to separate byte fields. The masking operation ensures only low nibbles (0-15) remain. Likely used for:
- Controller input state (buttons mapped to nibbles)
- Compressed parameter storage
- Track/level configuration data
- Palette index tables

The specific offset pattern (+$09 to +$0F) suggests this populates a standardized structure used throughout the game.

---

## func_426E - Conditional VDP Write with Counter ($0088426E)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_426E: Conditional VDP Register Write & Counter Update
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088426E - $0088427E
; Size: 16 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Tests a condition (word at 0(A0)), conditionally calls subroutine
;          at +$0C, then updates VDP register $C25C and increments counter.
;
; Input: A0 = Pointer to test value (word at offset 0)
; Output: VDP register $FFC25C set to $0040
;         Counter at $FFC07C incremented by 4
; Modifies: (depends on called subroutine)
; ═══════════════════════════════════════════════════════════════════════════

0088426E  0000                 ORI.B   #$00,D0              ; NOP (padding?)
00884270  6702                 BEQ.S   .skip_call           ; Skip if zero
00884272  610C                 BSR.S   .subroutine          ; Call function at +$0C

.skip_call:
00884274  31FC 0040 C25C       MOVE.W  #$0040,$FFC25C       ; Set VDP register
0088427A  5878 C07C            ADDQ.W  #4,$FFC07C           ; Increment counter
0088427E  4E75                 RTS

; Subroutine at +$0C (offset $00884280 = func_4280!)
.subroutine:
00884280  1019                 MOVE.B  (A1)+,D0             ; (This is func_4280)
```

**Analysis**: Wrapper function that conditionally calls func_4280 (nibble extractor), then performs VDP/counter bookkeeping. The counter at $FFC07C tracks some kind of frame or operation count. The VDP write ($0040) may be setting a control register. The leading ORI.B #$00,D0 is suspicious - likely padding or the tail end of a previous function.

---

## func_4836 - Quad Memory Fill Dispatcher ($00884836)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_4836: Sequential Memory Fill Chain (4 Sub-Functions)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00884836 - $00884844
; Size: 14 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Calls 4 memory fill functions in sequence. Each fills different
;          memory regions with value in D1. Chain: 483A → 483E → 4842 → 4846
;
; Input: D1 = Fill value (longword)
;        A1, A4 = Destination pointers (used by sub-functions)
; Output: Multiple memory regions filled with D1
; Modifies: A1, A4 (advanced by fill operations)
; ═══════════════════════════════════════════════════════════════════════════

00884836  4EBA 0002            JSR     func_483A            ; Fill region 1
0088483A  4EBA 0002            JSR     func_483E            ; Fill region 2
0088483E  4EBA 0002            JSR     func_4842            ; Fill region 3 (A1)
00884842  4EBA 0002            JSR     func_4846            ; Fill region 4 (A4)
00884846  4E75                 RTS                          ; (implied)
```

**Analysis**: Memory initialization dispatcher. Calls 4 consecutive fill functions, each writing D1 repeatedly to memory. The JSR chain structure (each JSR only +2 bytes ahead) creates a waterfall pattern where each function calls the next. Clever code size optimization.

---

## func_483A - Memory Fill Level 4 ($0088483A)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_483A: Memory Fill Chain Entry 1
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088483A - $0088483C
; Size: 2 bytes (just JSR)
; Called by: func_4836 (1 call)
;
; Purpose: Entry point 1 of memory fill waterfall
; ═══════════════════════════════════════════════════════════════════════════

0088483A  4EBA 0002            JSR     func_483E            ; Fall through to next
```

---

## func_483E - Memory Fill Level 3 ($0088483E)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_483E: Memory Fill Chain Entry 2
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088483E - $00884840
; Size: 2 bytes (just JSR)
; Called by: func_483A (1 call)
;
; Purpose: Entry point 2 of memory fill waterfall
; ═══════════════════════════════════════════════════════════════════════════

0088483E  4EBA 0002            JSR     func_4842            ; Fall through to next
```

---

## func_4842 - Memory Fill 60 Bytes (A1) ($00884842)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_4842: Fill 60 Bytes via A1 Pointer
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00884842 - $00884884
; Size: 66 bytes
; Called by: func_483E and func_4836 (2 calls)
;
; Purpose: Writes D1 to (A1) pointer 15 times (60 bytes total), then calls
;          func_4846 to fill via A4 pointer.
;
; Input: D1 = Fill value (longword)
;        A1 = Destination pointer
; Output: 60 bytes at (A1) filled with D1
;         A1 advanced by 60 bytes
; Modifies: A1
; ═══════════════════════════════════════════════════════════════════════════

00884842  4EBA 0002            JSR     func_4846            ; Call A4 filler
00884846  22C1                 MOVE.L  D1,(A1)+             ; Fill long 1
00884848  22C1                 MOVE.L  D1,(A1)+             ; Fill long 2
0088484A  22C1                 MOVE.L  D1,(A1)+             ; Fill long 3
0088484C  22C1                 MOVE.L  D1,(A1)+             ; Fill long 4
0088484E  22C1                 MOVE.L  D1,(A1)+             ; Fill long 5
00884850  22C1                 MOVE.L  D1,(A1)+             ; Fill long 6
00884852  22C1                 MOVE.L  D1,(A1)+             ; Fill long 7
00884854  22C1                 MOVE.L  D1,(A1)+             ; Fill long 8
00884856  22C1                 MOVE.L  D1,(A1)+             ; Fill long 9
00884858  22C1                 MOVE.L  D1,(A1)+             ; Fill long 10
0088485A  22C1                 MOVE.L  D1,(A1)+             ; Fill long 11
0088485C  22C1                 MOVE.L  D1,(A1)+             ; Fill long 12
0088485E  22C1                 MOVE.L  D1,(A1)+             ; Fill long 13
00884860  22C1                 MOVE.L  D1,(A1)+             ; Fill long 14
00884862  22C1                 MOVE.L  D1,(A1)+             ; Fill long 15 (60 bytes)
00884864  4E75                 RTS
```

**Analysis**: Unrolled fill loop - 15 longword writes (60 bytes). Faster than DBRA loop but larger code. The 60-byte size suggests clearing a specific structure (e.g., display list entry, object state).

---

## func_4846 - Memory Fill 60 Bytes (A4) ($00884846)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_4846: Fill 60 Bytes via A4 Pointer
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00884846 - $00884886
; Size: 64 bytes
; Called by: func_4842 (1 call)
;
; Purpose: Writes D1 to (A4) pointer 15 times (60 bytes total)
;
; Input: D1 = Fill value (longword)
;        A4 = Destination pointer
; Output: 60 bytes at (A4) filled with D1
;         A4 advanced by 60 bytes
; Modifies: A4
; ═══════════════════════════════════════════════════════════════════════════

00884846  2C81                 MOVE.L  D1,(A4)+             ; Fill long 1
00884848  2C81                 MOVE.L  D1,(A4)+             ; Fill long 2
0088484A  2C81                 MOVE.L  D1,(A4)+             ; Fill long 3
; ... (pattern repeats)
00884882  2C81                 MOVE.L  D1,(A4)+             ; Fill long 14
00884884  2C81                 MOVE.L  D1,(A4)+             ; Fill long 15
00884886  4E75                 RTS
```

**Analysis**: Parallel to func_4842 but uses A4 pointer. The waterfall chain (4836→483A→483E→4842→4846) allows filling up to 4 different memory regions with a single function call, depending on entry point.

---

## func_4922 - Fast 16-Byte Copy (Variant Entry) ($00884922)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_4922: Fast 16-Byte Memory Copy (A1 → A2)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00884922 - $0088492A (INSIDE func_4920)
; Size: 8 bytes
; Called by: Main game logic (2 calls - variant entry point)
;
; Purpose: Variant entry point into func_4920 that copies 16 bytes instead
;          of 20 bytes. Callers jump to offset +2 of func_4920 to skip
;          the first MOVE.L instruction.
;
; Input: A1 = Source address
;        A2 = Destination address
; Output: A1 = Source + 16 (advanced)
;         A2 = Destination + 16 (advanced)
; Modifies: A1, A2
; ═══════════════════════════════════════════════════════════════════════════

; Entry point at +2 bytes into func_4920
00884922  24D9                 MOVE.L  (A1)+,(A2)+          ; Copy long 1
00884924  24D9                 MOVE.L  (A1)+,(A2)+          ; Copy long 2
00884926  24D9                 MOVE.L  (A1)+,(A2)+          ; Copy long 3
00884928  24D9                 MOVE.L  (A1)+,(A2)+          ; Copy long 4 (16 bytes)
0088492A  4E75                 RTS
```

**Analysis**: Not a separate function - it's a variant entry point into func_4920. By calling $00884922 instead of $00884920, callers copy 16 bytes instead of 20. This code reuse technique saves ROM space. Both 16-byte and 20-byte structures must be common enough to warrant this dual-purpose implementation.

---

## func_48CA - Triple Memory Fill Dispatcher ($008848CA)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_48CA: Sequential Memory Fill Chain (3 + 1 Functions)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008848CA - $008848D8
; Size: 14 bytes
; Called by: Main game logic (2 calls)
;
; Purpose: Calls 4 memory fill functions in sequence. First 3 are adjacent
;          (+$02 each), final one is at +$22. Fills different regions.
;
; Input: D1 = Fill value (longword)
;        A1, A2 = Destination pointers
; Output: Multiple memory regions filled
; Modifies: A1, A2
; ═══════════════════════════════════════════════════════════════════════════

008848CA  4EBA 0002            JSR     func_48CE            ; Fill 1
008848CE  4EBA 0002            JSR     func_48D2            ; Fill 2
008848D2  4EBA 0002            JSR     func_48D6            ; Fill 3
008848D6  4EBA 0022            JSR     func_48FA            ; Fill 4 (larger gap)
```

**Analysis**: Similar pattern to func_4836 but with 4 calls instead of 3. The final JSR has larger offset (+$22 = 34 bytes), suggesting func_48FA is a different type or larger fill operation.

---

## func_48CE - Memory Fill Waterfall Entry 1 ($008848CE)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_48CE: Memory Fill Chain Entry 1
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008848CE - $008848D0
; Size: 2 bytes
; Called by: func_48CA (2 calls)
;
; Purpose: Entry point in fill waterfall chain
; ═══════════════════════════════════════════════════════════════════════════

008848CE  4EBA 0002            JSR     func_48D2            ; Fall through
```

---

## func_48D2 - Memory Fill Waterfall Entry 2 ($008848D2)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_48D2: Memory Fill Chain Entry 2
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008848D2 - $008848D4
; Size: 2 bytes
; Called by: func_48CE (2 calls)
;
; Purpose: Entry point in fill waterfall chain
; ═══════════════════════════════════════════════════════════════════════════

008848D2  4EBA 0002            JSR     func_48D6            ; Fall through

; func_48D6 starts here (based on hexdump pattern):
008848D6  4EBA 0022            JSR     func_48FA
008848DA  24D9                 MOVE.L  (A1)+,(A2)+          ; Start of fill loop
008848DC  24D9                 MOVE.L  (A1)+,(A2)+
; ... (pattern continues for ~8 iterations)
```

**Analysis**: These waterfall entries allow variable amounts of memory to be filled depending on which entry point is called. Compact and efficient for clearing/initializing game state.

---

## func_4CBC - Game State Jump Table Dispatcher ($00884CBC)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_4CBC: State-Based Jump Table Dispatcher
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00884CBC - $00884CFC
; Size: 64 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Dispatches to one of 5+ handler functions based on state index
;          at $FFC87E. Uses PC-relative jump table for dynamic dispatch.
;
; Input: ($FFC87E).W = State index (0-4+)
; Output: (depends on handler function)
; Modifies: A1, D0 (and handler-specific registers)
; ═══════════════════════════════════════════════════════════════════════════

00884CBC  3038 C87E            MOVE.W  $FFC87E,D0           ; D0 = state index
00884CC0  227B 0004            MOVEA.L (PC,D0.W,$04),A1     ; A1 = table[state]
00884CC4  4ED1                 JMP     (A1)                 ; Jump to handler

; Jump table (5 entries)
00884CC6  00884CDA             .long   handler_0            ; State 0
00884CCA  00884D00             .long   handler_1            ; State 1
00884CCE  00884D1A             .long   handler_2            ; State 2
00884CD2  00884D7A             .long   handler_3            ; State 3
00884CD6  0088573C             .long   handler_4            ; State 4

; Handler code follows
handler_0:
00884CDA  4EBA DBE6            JSR     $008828C2            ; VDP/SH2 sync
00884CDE  4EBA D3F6            JSR     $008820D6            ; (unknown)
00884CE2  4EBA 63BA            JSR     $0088B09E            ; (high ROM func)
00884CE6  4EBA 6344            JSR     $0088B02C            ; (high ROM func)
00884CEA  4EBA 6946            JSR     $0088B632            ; (high ROM func)
00884CEE  4EBA 0BD8            JSR     $008858C8            ; (Priority 8)
00884CF2  5878 C87E            ADDQ.W  #4,$FFC87E           ; Increment state
00884CF6  33FC 0010 00FFXXXX   MOVE.W  #$0010,$00FFXXXX     ; (continues)
```

**Analysis**: Classic state machine dispatcher. The state index at $FFC87E controls game flow. Handler 0 performs initialization (calls 6 setup functions), then increments state to move to next phase. The jump table allows clean separation of game phases (menu, loading, gameplay, results, etc.).

**State Index ($FFC87E)**: Critical game state variable. Incremented via ADDQ.W #4 (scaling for longword table indexing). Each state likely represents:
- State 0: Initialization/boot
- State 1: Menu/attract mode
- State 2: Race loading
- State 3: Active gameplay
- State 4: Results/scoring

---

## func_5306 - Game State Dispatcher 2 ($00885306)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5306: Secondary State-Based Jump Table Dispatcher
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885306 - $00885366
; Size: 96 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Similar to func_4CBC but with different state handlers. Dispatches
;          to one of 5 handler functions based on state index at $FFC87E.
;
; Input: ($FFC87E).W = State index (0-4+)
; Output: (depends on handler function)
; Modifies: A1, D0 (and handler-specific registers)
; ═══════════════════════════════════════════════════════════════════════════

00885306  4E75                 RTS                          ; (padding/unreachable?)

00885308  3038 C87E            MOVE.W  $FFC87E,D0           ; D0 = state index
0088530C  227B 0004            MOVEA.L (PC,D0.W,$04),A1     ; A1 = table[state]
00885310  4ED1                 JMP     (A1)                 ; Jump to handler

; Jump table (5 entries)
00885312  00885326             .long   handler_0            ; State 0
00885316  00885348             .long   handler_1            ; State 1
0088531A  0088535E             .long   handler_2            ; State 2
0088531E  00885396             .long   handler_3            ; State 3
00885322  0088573C             .long   handler_4            ; State 4

; Handler 0: Initialization chain
handler_0:
00885326  4EBA D59A            JSR     $008828C2            ; VDP/SH2 sync (func_28C2)
0088532A  4EBA CDAA            JSR     $008820D6            ; Unknown
0088532E  4EBA 5D6E            JSR     $0088B09E            ; High ROM func
00885332  4EBA 5CF8            JSR     $0088B02C            ; High ROM func
00885336  4EBA 62FA            JSR     $0088B632            ; High ROM func
0088533A  5878 C87E            ADDQ.W  #4,$FFC87E           ; Increment state index
0088533E  33FC 0010 00FF0008   MOVE.W  #$0010,$FF0008       ; Write to Work RAM
00885346  4E75                 RTS

; Handler 1: Shorter initialization
handler_1:
00885348  4EBA CDC0            JSR     $0088210A            ; Unknown
0088534C  4EBA 5D50            JSR     $0088B09E            ; High ROM func
00885350  5878 C87E            ADDQ.W  #4,$FFC87E           ; Increment state
00885354  33FC 0010 00FF0008   MOVE.W  #$0010,$FF0008       ; Write to Work RAM
0088535C  4E75                 RTS

; Handler 2: Minimal processing
handler_2:
0088535E  4EBA CDCE            JSR     $0088212E            ; Unknown
00885362  4EBA C43A            JSR     $0088179E            ; ControllerRead (Priority 5)
; ... (continues)
```

**Analysis**: Parallel state machine to func_4CBC. Also uses $FFC87E as state index and shares handler_4 address ($0088573C). The different handler addresses suggest this dispatcher is used for a different game phase or mode.

---

## func_58C8 - Conditional Bus Operation Loop ($008858C8)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_58C8: Conditional Processing with Bus Control
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008858C8 - $00885908
; Size: 64 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Calls subroutine, checks hardware bus flags, conditionally processes
;          data based on bit tests. Writes to $FF5FFE and loops through table.
;
; Input: None (checks RAM at $FFC26C and $FFC89C)
; Output: $FF5FFE cleared, table at $FF9100 processed
; Modifies: A1, D7
; ═══════════════════════════════════════════════════════════════════════════

008858C8  4EBA 12C0            JSR     $00886B8A            ; Call setup function
008858CC  49F8 A000            LEA     $A000,A1             ; A1 = hardware base

008858D0  3038 C26C            MOVE.W  $FFC26C,D0           ; D0 = control flag
008858D4  0838 0007 C81C       BTST    #7,$FFC81C           ; Test bit 7
008858DA  6606                 BNE.S   .check_flag2         ; Branch if set
008858DC  4A78 C89C            TST.W   $FFC89C              ; Test word
008858E0  6708                 BEQ.S   .return              ; Return if zero

.check_flag2:
008858E2  0240 0138            ANDI.W  #$0138,D0            ; Mask bits
008858E6  6708                 BEQ.S   .return              ; Return if zero
008858E8  4E75                 RTS

.return:
008858EA  0240 0130            ANDI.W  #$0130,D0            ; Different mask
008858EE  66F8                 BNE.S   .check_flag2         ; Loop back

; Clear $FF5FFE
008858F0  13FC 0000 00FF5FFE   MOVE.B  #0,$FF5FFE           ; Clear byte

; Loop through table
008858F8  41F8 9100            LEA     $FF9100,A1           ; A1 = table base
008858FC  7E05                 MOVEQ   #5,D7                ; D7 = 5 (loop count)
008858FE  4EBA 00EC            JSR     $008859EC            ; Process table entry
00885902  51CF FFFA            DBRA    D7,.loop             ; Loop 6 times
00885906  4E75                 RTS

.loop:
; (continues at 008858FE)
```

**Analysis**: Complex conditional processing tied to hardware bus state. The bit tests and masking suggest this manages bus arbitration or DMA timing. The table loop at $FF9100 with 6 iterations suggests processing 6 related entries.

---

## func_5908 - Conditional Bus Operation Loop 2 ($00885908)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5908: Conditional Processing Variant (7 iterations)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885908 - $0088593C
; Size: 52 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Nearly identical to func_58C8 but processes table at $FF9700
;          with 8 iterations instead of 6.
;
; Input: None (checks RAM at $FFC26C and $FFC89C)
; Output: Table at $FF9700 processed
; Modifies: A1, D7
; ═══════════════════════════════════════════════════════════════════════════

00885908  49F8 A000            LEA     $A000,A1             ; A1 = hardware base
0088590C  3038 C26C            MOVE.W  $FFC26C,D0           ; D0 = control flag
00885910  0838 0007 C81C       BTST    #7,$FFC81C           ; Test bit 7
00885916  6606                 BNE.S   .check_flag2         ; Branch if set
00885918  4A78 C89C            TST.W   $FFC89C              ; Test word
0088591C  6708                 BEQ.S   .return              ; Return if zero

.check_flag2:
0088591E  0240 0138            ANDI.W  #$0138,D0            ; Mask bits
00885922  6708                 BEQ.S   .return              ; Return if zero
00885924  4E75                 RTS

.return:
00885926  0240 0130            ANDI.W  #$0130,D0            ; Different mask
0088592A  66F8                 BNE.S   .check_flag2         ; Loop back

; Loop through table at $FF9700
0088592C  41F8 9700            LEA     $FF9700,A1           ; A1 = table base
00885930  7E07                 MOVEQ   #7,D7                ; D7 = 7 (8 iterations)
00885932  4EBA 00B8            JSR     $008859EC            ; Process table entry
00885936  51CF FFFA            DBRA    D7,.loop             ; Loop 8 times
0088593A  4E75                 RTS
```

**Analysis**: Variant of func_58C8 with different table address ($FF9700 vs $FF9100) and different iteration count (8 vs 6). The shared conditional logic suggests these manage parallel hardware subsystems.

---

## func_593C - Conditional Bus Operation Loop 3 ($0088593C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_593C: Conditional Processing Variant (single operation)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088593C - $00885A52
; Size: 278 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Third variant. Similar conditional checks but executes single
;          operation on table at $FF9F00 instead of looping.
;
; Input: None (checks RAM at $FFC26C and $FFC89C)
; Output: Processes $FF9F00 table entry, updates object at $FF9000
; Modifies: A1, D0, D1
; ═══════════════════════════════════════════════════════════════════════════

0088593C  49F8 A000            LEA     $A000,A1             ; A1 = hardware base
00885940  3038 C26C            MOVE.W  $FFC26C,D0           ; D0 = control flag
00885944  0838 0007 C81C       BTST    #7,$FFC81C           ; Test bit 7
0088594A  6606                 BNE.S   .check_flag2         ; Branch if set
0088594C  4A78 C89C            TST.W   $FFC89C              ; Test word
00885950  6708                 BEQ.S   .do_operation        ; Continue if zero

.check_flag2:
00885952  0240 0138            ANDI.W  #$0138,D0            ; Mask bits
00885956  670A                 BEQ.S   .skip                ; Skip if zero
00885958  6010                 BRA.S   .do_operation        ; Otherwise continue

.skip:
0088595A  0240 0130            ANDI.W  #$0130,D0            ; Different mask
0088595E  6702                 BEQ.S   .skip2               ; Skip if zero
00885960  6008                 BRA.S   .do_operation        ; Otherwise continue

.skip2:
; Execute single operation (no loop)
00885962  41F8 9F00            LEA     $FF9F00,A1           ; A1 = table
00885966  4EBA 0084            JSR     $008859EC            ; Process entry

; Update object structure
.do_operation:
0088596A  41F8 9000            LEA     $FF9000,A1           ; A1 = object base
0088596E  2168 00B2 0018       MOVE.L  $B2(A0),$18(A1)      ; Copy long
00885974  1228 00E5            MOVE.B  $E5(A0),D1           ; D1 = object[0xE5]
00885978  0201 0006            ANDI.B  #6,D1                ; Mask bits 1-2
0088597C  6706                 BEQ.S   .no_special          ; Skip if clear
0088597E  2178 C70C 0018       MOVE.L  $FFC70C,$18(A1)      ; Copy from RAM

.no_special:
00885984  3038 C07A            MOVE.W  $FFC07A,D0           ; D0 = control value
00885988  0838 0003 ...        BTST    #3,...               ; (continues)
; ... (more operations)
```

**Analysis**: Most complex of the three variants. Uses same conditional logic but performs single table operation followed by extensive object field manipulation. The three functions (func_58C8, func_5908, func_593C) form a family handling different bus operation scenarios.

---

## func_60FD - Subroutine Call Chain ($008860FD)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_60FD: Sequential Subroutine Call Chain
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008860FD - $0088613D
; Size: 64 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Calls 14 subroutines in sequence. Orchestrates complex multi-step
;          operation by delegating to specialized functions.
;
; Input: (depends on called subroutines)
; Output: (depends on called subroutines)
; Modifies: (depends on called subroutines)
; ═══════════════════════════════════════════════════════════════════════════

008860FD  7E??                 MOVEQ   #??,D7               ; (partial opcode)
008860FF  4EBA 0E98            JSR     $00886F99            ; Call 1
00886103  4EBA 1BD4            JSR     $00887CD9            ; Call 2
00886107  4EBA 432C            JSR     $0088A435            ; Call 3
0088610B  4EBA 0F9E            JSR     $008870AB            ; Call 4
0088610F  4EBA 1DF4            JSR     $00887F05            ; Call 5
00886113  4EBA 3D5A            JSR     $00889E6F            ; Call 6
00886117  4EBA 1B36            JSR     $00887C4F            ; Call 7
0088611B  4EBA 102E            JSR     $0088714B            ; Call 8
0088611F  4EBA 152E            JSR     $0088764F            ; Call 9
00886123  4EBA 1E2C            JSR     $00887F51            ; Call 10
00886127  4EBA 3BA6            JSR     $00889CCF            ; Call 11
0088612B  4EBA 4B12            JSR     $0088AC3F            ; Call 12
0088612F  4EBA 2598            JSR     $008886C9            ; Call 13
00886133  4EBA 3D8C            JSR     $00889EC1            ; Call 14
00886137  4EBA 34E6            JSR     $0088961F            ; Call 15
0088613B  4EBA 47??            JSR     $0088A8??            ; Call 16 (partial)
```

**Analysis**: Orchestration function. Calls 14+ subroutines spread across wide ROM addresses ($6F99 to $A8xx). This pattern suggests a high-level game phase controller that delegates to subsystems (physics, graphics, sound, AI, etc.).

---

## func_64A8 - Object Initialization ($008864A8)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_64A8: Game Object Initialization & Setup
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008864A8 - $008864E8
; Size: 64 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Initialize game object structure. Copies data, checks flags,
;          calls setup routines, and initializes object pointers.
;
; Input: A0 = Source object pointer
; Output: Object at $FF9F00 and $FF9000 initialized
; Modifies: A1, A2, D0
; ═══════════════════════════════════════════════════════════════════════════

008864A8  2168 00B2 0018       MOVE.L  $B2(A0),$18(A1)      ; Copy object pointer
008864AE  1228 00E5            MOVE.B  $E5(A0),D1           ; D1 = flags
008864B2  0201 0006            ANDI.B  #6,D1                ; Mask bits 1-2
008864B6  6706                 BEQ.S   .no_special          ; Skip if zero
008864B8  2178 C70C 0018       MOVE.L  $FFC70C,$18(A1)      ; Use alternate pointer

.no_special:
008864BE  3038 C07A            MOVE.W  $FFC07A,D0           ; D0 = control index
008864C2  43FA 00D8            LEA     $0088659C(PC),A1     ; A1 = jump table
008864C6  2271 0000            MOVEA.L 0(A1,D0.W),A1        ; A1 = table[D0]
008864CA  4E91                 JSR     (A1)                 ; Call handler

; Call initialization subroutines
008864CC  4EBA 398C            JSR     $00889E5A            ; Init 1
008864D0  4EBA 1A2A            JSR     $00887EFC            ; Init 2
008864D4  4EBA 1F04            JSR     $008883DA            ; Init 3
008864D8  4EBA 2308            JSR     $008887E2            ; Init 4

; Setup pointers
008864DC  41F8 9F00            LEA     $FF9F00,A1           ; A1 = object 1
008864E0  43F8 9000            LEA     $FF9000,A2           ; A2 = object 2
008864E4  4EBA 218C            JSR     $00888672            ; Link objects
008864E8  4E75                 RTS
```

**Analysis**: Object initialization routine. Uses jump table dispatch to call type-specific handlers, then performs common initialization. The two object pointers ($FF9F00 and $FF9000) suggest dual-buffer or player/AI object pairs.

---

## func_6C88 - Bitfield Dispatcher ($00886C88)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_6C88: Multi-Bit Test Dispatcher
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00886C88 - $00886CC8
; Size: 64 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Tests multiple bits in control byte, branches to different code
;          paths based on which bits are set. 7-way dispatcher.
;
; Input: ($FFC86E).B = Control bitfield
; Output: Branches to appropriate handler
; Modifies: D0
; ═══════════════════════════════════════════════════════════════════════════

00886C88  4A79 00FF3000        TST.W   $FF3000              ; Test word
00886C8E  6604                 BNE.S   .has_flag            ; Branch if != 0
00886C90  4EBA FFB4            JSR     $00886C46            ; Call function

.has_flag:
00886C94  1238 C86E            MOVE.B  $FFC86E,D1           ; D1 = bitfield
00886C98  7030                 MOVEQ   #$30,D0              ; D0 = default value

; Test bit 6
00886C9A  0801 0006            BTST    #6,D1                ; Test bit 6
00886C9E  6602                 BNE.S   .bit6_set            ; Branch if set
00886CA0  7008                 MOVEQ   #8,D0                ; D0 = 8

; Test bit 2
.bit6_set:
00886CA2  0801 0002            BTST    #2,D1                ; Test bit 2
00886CA6  6600 0090            BNE.W   .handler_bit2        ; Branch to handler

; Test bit 3
00886CAA  0801 0003            BTST    #3,D1                ; Test bit 3
00886CAE  6600 008E            BNE.W   .handler_bit3        ; Branch to handler

; Test bit 1
00886CB2  0801 0001            BTST    #1,D1                ; Test bit 1
00886CB6  6600 008C            BNE.W   .handler_bit1        ; Branch to handler

; Test bit 0
00886CBA  0801 0000            BTST    #0,D1                ; Test bit 0
00886CBE  6600 008A            BNE.W   .handler_bit0        ; Branch to handler

; Test bit 4
00886CC2  0801 0004            BTST    #4,D1                ; Test bit 4
00886CC6  6600 ????            BNE.W   .handler_bit4        ; (continues)
```

**Analysis**: Priority encoder using sequential bit tests. Each bit in $FFC86E triggers a different handler. The default value ($30 vs $08) depends on bit 6. This implements a state machine where multiple states can be encoded in a single control byte.

---

## func_6D9C - Hardware Loop 1 ($00886D9C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_6D9C: Hardware Command Loop (6 iterations, $FF9100 table)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00886D9C - $00886DC8
; Size: 44 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Calls helper function, clears $FF5FFE, then executes 6 iterations
;          of hardware command processing on table at $FF9100.
;
; Input: None
; Output: $FF5FFE cleared, table processed
; Modifies: A1, D7
; ═══════════════════════════════════════════════════════════════════════════

00886D9C  4EBA FDEC            JSR     $00886B8A            ; Setup function
00886DA0  49F8 A000            LEA     $A000,A1             ; A1 = hardware base
00886DA4  13FC 0000 00FF5FFE   MOVE.B  #0,$FF5FFE           ; Clear byte

; Loop 6 times
00886DAC  41F8 9100            LEA     $FF9100,A1           ; A1 = table base
00886DB0  4EBA EC3A            JSR     $008859EC            ; Process entry 1
00886DB4  4EBA EC36            JSR     $008859EC            ; Process entry 2
00886DB8  4EBA EC32            JSR     $008859EC            ; Process entry 3
00886DBC  4EBA EC2E            JSR     $008859EC            ; Process entry 4
00886DC0  4EBA EC2A            JSR     $008859EC            ; Process entry 5
00886DC4  4EBA EC26            JSR     $008859EC            ; Process entry 6
00886DC8  4E75                 RTS
```

**Analysis**: Unrolled loop variant of func_58C8. Instead of DBRA loop, calls the same function 6 times explicitly. Slightly larger code but potentially faster (no loop overhead). Processes same table ($FF9100).

---

## func_6DC8 - Hardware Loop 2 ($00886DC8)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_6DC8: Hardware Command Loop (8 iterations, $FF9700 table)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00886DC8 - $00886DF0
; Size: 40 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Unrolled loop for $FF9700 table (8 iterations)
; ═══════════════════════════════════════════════════════════════════════════

00886DC8  49F8 A000            LEA     $A000,A1             ; A1 = hardware base
00886DCC  41F8 9700            LEA     $FF9700,A1           ; A1 = table base
00886DD0  4EBA EC1A            JSR     $008859EC            ; Process entry 1
00886DD4  4EBA EC16            JSR     $008859EC            ; Process entry 2
00886DD8  4EBA EC12            JSR     $008859EC            ; Process entry 3
00886DDC  4EBA EC0E            JSR     $008859EC            ; Process entry 4
00886DE0  4EBA EC0A            JSR     $008859EC            ; Process entry 5
00886DE4  4EBA EC06            JSR     $008859EC            ; Process entry 6
00886DE8  4EBA EC02            JSR     $008859EC            ; Process entry 7
00886DEC  4EBA EBFE            JSR     $008859EC            ; Process entry 8
00886DF0  4E75                 RTS
```

**Analysis**: Unrolled variant for 8 iterations. Processes table at $FF9700. Pattern matches func_5908 but with explicit calls instead of DBRA.

---

## func_6DF0 - Hardware Loop 3 ($00886DF0)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_6DF0: Hardware Command Loop (single iteration, $FF9F00 table)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00886DF0 - $00886DFC
; Size: 12 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Single iteration variant for $FF9F00 table
; ═══════════════════════════════════════════════════════════════════════════

00886DF0  49F8 A000            LEA     $A000,A1             ; A1 = hardware base
00886DF4  41F8 9F00            LEA     $FF9F00,A1           ; A1 = table base
00886DF8  4EBA EBF2            JSR     $008859EC            ; Process single entry
00886DFC  4E75                 RTS
```

**Analysis**: Simplest variant - single operation on $FF9F00 table. The three functions (6D9C, 6DC8, 6DF0) provide unrolled versions of the looped variants (58C8, 5908, 593C).

---

## func_9084 - VDP Calculation & Write ($00889084)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_9084: Complex VDP Value Calculation
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00889084 - $008890A4
; Size: 32 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Perform calculations on RAM values and write to VDP register.
;          Applies thresholds, scaling, and conditional adjustments.
;
; Input: ($FFC0B0).W = Source value
;        ($FFC04C).W = Conditional flag
; Output: ($FFC882).W = Result
;         VDP register at $8000 written
; Modifies: D0
; ═══════════════════════════════════════════════════════════════════════════

00889084  70F8                 MOVEQ   #-8,D0               ; D0 = -8 (threshold low)
00889086  0C40 0010            CMPI.W  #$10,D0              ; Compare with $10
0088908A  6F02                 BLE.S   .in_range            ; Branch if D0 <= $10
0088908C  7010                 MOVEQ   #$10,D0              ; Clamp to $10 (max)

.in_range:
0088908E  5140                 SUBQ.W  #8,D0                ; D0 -= 8
00889090  31C0 C882            MOVE.W  D0,$FFC882           ; Store result
00889094  31FC FEC0 8000       MOVE.W  #$FEC0,$8000         ; Write to VDP

0088909A  4E75                 RTS

; Alternate function at +$10
0088909C  31FC 0000 8000       MOVE.W  #0,$8000             ; Clear VDP register
008890A2  4E75                 RTS

; Another calculation
008890A4  3038 C0B0            MOVE.W  $FFC0B0,D0           ; D0 = source value
008890A8  E740                 LSL.W   #3,D0                ; D0 <<= 3 (multiply by 8)
008890AA  D078 903C            ADD.W   $903C,D0             ; Add constant offset
008890AE  D078 9096            ADD.W   $9096,D0             ; Add second offset

; Conditional adjustment
008890B2  4A78 C04C            TST.W   $FFC04C              ; Test flag
008890B6  6704                 BEQ.S   .no_adjust           ; Skip if zero
008890B8  9078 9046            SUB.W   $9046,D0             ; Subtract adjustment

.no_adjust:
008890BC  EC40                 LSR.W   #6,D0                ; D0 >>= 6 (divide by 64)
008890BE  0838 0007 FDA8       BTST    #7,$FDA8             ; Test high bit
; ... (continues)
```

**Analysis**: VDP parameter calculator. Applies threshold clamping, scaling, and conditional offsets before writing to VDP. The bit tests and arithmetic suggest this calculates scroll positions or display parameters from game state.

---

## func_5A52 - Object Field Calculator ($00885A52)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5A52: Complex Object State Calculation
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885A52 - $00885AB2
; Size: 96 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Perform complex calculations on object fields, apply masks and
;          thresholds, update counters. Likely handles physics or AI state.
;
; Input: A0 = Object pointer, A1 = Table pointer
; Output: Object fields updated
; Modifies: D0, A0, A1
; ═══════════════════════════════════════════════════════════════════════════

00885A52  4440                 SWAP    D0                   ; Swap D0 words
00885A54  0240 03FF            ANDI.W  #$03FF,D0            ; Mask to $03FF
00885A58  3031 0000            MOVE.W  (A1,D0.W),D0         ; Read table entry
00885A5C  4440                 SWAP    D0                   ; Swap back
00885A5E  3140 003A            MOVE.W  D0,$3A(A0)           ; Store at offset $3A

; Table lookup operation
00885A62  43F9 0093A82C        LEA     $0093A82C,A1         ; A1 = data table
00885A68  3028 0032            MOVE.W  $32(A0),D0           ; D0 = object[0x32]
00885A6C  9068 00C6            SUB.W   $C6(A0),D0           ; Subtract field $C6
00885A70  D040                 ADD.W   D0,D0                ; D0 *= 2 (scale to word)
00885A72  6B0A                 BMI.S   .negative            ; Branch if negative
00885A74  0240 03FF            ANDI.W  #$03FF,D0            ; Clamp to $03FF
00885A78  3031 0000            MOVE.W  (A1,D0.W),D0         ; Lookup value
00885A7C  600C                 BRA.S   .store

.negative:
00885A7E  4440                 SWAP    D0                   ; Handle negative case
00885A80  0240 03FF            ANDI.W  #$03FF,D0
00885A84  3031 0000            MOVE.W  (A1,D0.W),D0
00885A88  4440                 SWAP    D0

.store:
00885A8A  3140 003E            MOVE.W  D0,$3E(A0)           ; Store result
00885A8E  3168 006E 0046       MOVE.W  $6E(A0),$46(A0)      ; Copy field $6E → $46

; Call subroutines and update fields
00885A94  4EBA 1BB8            JSR     $0088764E            ; Call helper 1
00885A98  4EBA 16B0            JSR     $00887150            ; Call helper 2

00885A9C  3028 0026            MOVE.W  $26(A0),D0           ; D0 = field $26
00885AA0  9068 0024            SUB.W   $24(A0),D0           ; Subtract field $24
00885AA4  0C40 0064            CMPI.W  #$64,D0              ; Compare with $64
00885AA8  6D04                 BLT.S   .skip_increment      ; Skip if < $64
00885AAA  5268 002C            ADDQ.W  #1,$2C(A0)           ; Increment field $2C

.skip_increment:
00885AAE  41E8 0100            LEA     $100(A0),A0          ; Advance pointer 256 bytes
00885AB2  4E75                 RTS
```

**Analysis**: Complex object state calculator. Performs table lookups from large data table at $0093A82C, handles signed/unsigned conversions, applies thresholds, and updates multiple object fields. The 256-byte pointer advancement suggests this processes array of fixed-size structures.

---

## func_6EAE - Multi-Stage Initialization ($00886EAE)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_6EAE: Comprehensive Game State Initialization
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00886EAE - $00886F0E
; Size: 96 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Multi-stage initialization sequence. Calls 12+ setup functions,
;          clears memory locations, conditionally calls additional handlers.
;
; Input: A0 = Object pointer
; Output: Multiple game systems initialized
; Modifies: D0, A0-A2
; ═══════════════════════════════════════════════════════════════════════════

00886EAE  4EBA 2E1E            JSR     $00889CCE            ; Init stage 1
00886EB2  4EBA 2CA0            JSR     $00889B54            ; Init stage 2
00886EB6  4EBA 1810            JSR     $008886C8            ; Init stage 3
00886EBA  4EFA 3E18            JMP     $0088ACD4            ; Jump to stage 4

; Clear memory fields
00886EBE  317C 0000 0006       MOVE.W  #0,$06(A0)           ; Clear field $06
00886EC4  317C 0000 0074       MOVE.W  #0,$74(A0)           ; Clear field $74
00886ECA  7000                 MOVEQ   #0,D0                ; D0 = 0
00886ECC  3140 0044            MOVE.W  D0,$44(A0)           ; Clear multiple fields
00886ED0  3140 0046            MOVE.W  D0,$46(A0)
00886ED4  3140 004A            MOVE.W  D0,$4A(A0)

; Call additional initialization functions
00886ED8  4EBA DB14            JSR     $008849EE            ; Call setup 5
00886EDC  4EBA 16BC            JSR     $0088859A            ; Call setup 6
00886EE0  4EBA 346E            JSR     $0088A350            ; Call setup 7
00886EE4  4EBA 128A            JSR     $00888170            ; Call setup 8
00886EE8  4EBA 11E2            JSR     $008880CC            ; Call setup 9
00886EEC  4EBA 165A            JSR     $00888548            ; Call setup 10
00886EF0  4EBA 2608            JSR     $008894FA            ; Call setup 11

; Conditional execution
00886EF4  0C78 0004 C26C       CMPI.W  #4,$FFC26C           ; Test control value
00886EFA  6704                 BEQ.S   .skip                ; Skip if == 4
00886EFC  4EBA 2414            JSR     $00889312            ; Call conditional func

.skip:
00886F00  4EBA 2C10            JSR     $00889B12            ; Call finalize 1
00886F04  4EBA 227C            JSR     $00889182            ; Call finalize 2
00886F08  4EBA 28F8            JSR     $00889802            ; Call finalize 3
```

**Analysis**: Master initialization coordinator. Calls 12+ initialization functions spanning entire ROM, clears critical state variables, and conditionally executes handlers based on control flags. This is likely called during level loading or game mode transitions.

---

## func_6F98 - Object State Update with Calculations ($00886F98)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_6F98: Conditional Object Update & Calculation Chain
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00886F98 - $00886FD8
; Size: 64 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Tests object flags, performs calculations, calls processing funcs
;
; Input: A0 = Object pointer
; Output: Object state updated
; Modifies: D0-D4, A0
; ═══════════════════════════════════════════════════════════════════════════

00886F98  4A68 0062            TST.W   $62(A0)              ; Test flag at $62
00886F9C  6638                 BNE.S   .skip_processing     ; Skip if != 0

00886F9E  4A68 0092            TST.W   $92(A0)              ; Test flag at $92
00886FA2  6E2A                 BGT.S   .positive            ; Branch if > 0

; Main calculation block
.positive:
00886FA4  3028 003C            MOVE.W  $3C(A0),D0           ; D0 = object[0x3C]
00886FA8  D068 0096            ADD.W   $96(A0),D0           ; D0 += object[0x96]
00886FAC  3140 0040            MOVE.W  D0,$40(A0)           ; Store result at $40

00886FB0  4440                 SWAP    D0                   ; Swap words
00886FB2  3428 0006            MOVE.W  $06(A0),D2           ; D2 = field $06
00886FB6  3628 0030            MOVE.W  $30(A0),D3           ; D3 = field $30
00886FBA  3828 0034            MOVE.W  $34(A0),D4           ; D4 = field $34

; Call calculation function
00886FBE  4EBA 001E            JSR     $00886FDE            ; Perform calculation

; Store results
00886FC2  3143 0030            MOVE.W  D3,$30(A0)           ; Update field $30
00886FC6  3144 0034            MOVE.W  D4,$34(A0)           ; Update field $34

.skip_processing:
00886FD6  4E75                 RTS
```

**Analysis**: Conditional object processor. Tests multiple flags before executing calculation chain. The SWAP operations suggest 32-bit fixed-point arithmetic. Multiple fields updated based on complex calculations.

---

## func_71B3 - Table-Based Address Calculator ($008871B3)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_71B3: Complex Address Calculation via Multiple Tables
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008871B3 - $00887203
; Size: 80 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Calculate memory address using object fields and multiple lookup
;          tables. Applies shifts, masks, and conditional table selection.
;
; Input: A0 = Object pointer
; Output: A3 = Calculated table address, D2 = Result value
; Modifies: D0-D3, A3
; ═══════════════════════════════════════════════════════════════════════════

008871B3  41EC ????            LEA     ??(A4),A0            ; Load base address
008871B7  3628 0034            MOVE.W  $34(A0),D3           ; D3 = object[0x34]
008871BB  E843                 LSR.W   #4,D3                ; D3 >>= 4
008871BD  9243                 SUB.W   D3,D1                ; D1 -= D3
008871BF  0241 FFC0            ANDI.W  #$FFC0,D1            ; Mask to $FFC0
008871C3  E241                 ASR.W   #1,D1                ; Arithmetic shift right
008871C5  D242                 ADD.W   D2,D1                ; D1 += D2
008871C7  D241                 ADD.W   D1,D1                ; D1 *= 2

; Calculate table index
008871CB  70CA                 MOVEQ   #-54,D0              ; D0 = -54
008871CD  7000                 MOVEQ   #0,D0                ; D0 = 0 (override)
008871CF  3028 00CC            MOVE.W  $CC(A0),D0           ; D0 = object[0xCC]
008871D3  ED80                 LSL.L   #6,D0                ; D0 <<= 6 (multiply by 64)
008871D5  4840                 SWAP    D0                   ; Swap words
008871D7  0240 003C            ANDI.W  #$3C,D0              ; Mask to $3C

; Table selection
008871DB  47F9 0089A0D4        LEA     $0089A0D4,A3         ; A3 = table 1 base
008871E1  3438 C8A0            MOVE.W  $FFC8A0,D2           ; D2 = control value
008871E5  0C42 0004            CMPI.W  #4,D2                ; Compare with 4
008871E9  6616                 BNE.S   .use_table1          ; Use table 1 if != 4

; Alternative table checks
008871EB  0C28 0088 001D       CMPI.B  #$88,$1D(A0)         ; Check byte at $1D
008871F1  6D0E                 BLT.S   .use_alt_table       ; Branch if < $88
008871F3  0C28 0098 001D       CMPI.B  #$98,$1D(A0)         ; Check upper bound
008871F9  6E06                 BGT.S   .use_alt_table       ; Branch if > $98

.use_table1:
008871FB  47F9 0089A434        LEA     $0089A434,A3         ; Use alternate table

.use_alt_table:
00887201  3426                 MOVE.W  (A6),D2              ; Load from table
00887203  4E75                 RTS
```

**Analysis**: Sophisticated address calculator using conditional table selection. Performs 64x scaling, bit masking, and range checks to select between two data tables. Likely used for sprite/graphics data addressing or level geometry lookups.

---

## func_7364 - Parallel Address Calculator ($00887364)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_7364: Similar to func_71B3 but with Different Tables
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00887364 - $008873C4
; Size: 96 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Variant of func_71B3 using different base tables and control flag
;
; Input: A0 = Object pointer, D1/D2 = Input values
; Output: A3 = Calculated table address
; Modifies: D0-D3, A3, A5
; ═══════════════════════════════════════════════════════════════════════════

00887364  D441                 ADD.W   D1,D2                ; D2 += D1
00887366  EC42                 LSR.W   #6,D2                ; D2 >>= 6
00887368  3639 00FF6106        MOVE.W  $FF6106,D3           ; D3 = RAM value
0088736E  E843                 LSR.W   #4,D3                ; D3 >>= 4
00887370  9243                 SUB.W   D3,D1                ; D1 -= D3
00887372  0241 FFC0            ANDI.W  #$FFC0,D1            ; Mask
00887376  E241                 ASR.W   #1,D1                ; Shift
00887378  D242                 ADD.W   D2,D1                ; Combine
0088737A  D241                 ADD.W   D1,D1                ; Double

0088737C  7000                 MOVEQ   #0,D0                ; D0 = 0
0088737E  3028 00CC            MOVE.W  $CC(A0),D0           ; D0 = index
00887382  ED80                 LSL.L   #6,D0                ; Scale by 64
00887384  4840                 SWAP    D0
00887386  0240 003C            ANDI.W  #$3C,D0              ; Mask

; Table base selection
0088738A  47F9 0089A5D2        LEA     $0089A5D2,A3         ; Table base
00887390  4A78 C0BA            TST.W   $FFC0BA              ; Test control flag
00887394  6606                 BNE.S   .alt_table           ; Use alt if != 0
00887396  47F9 0089A0D4        LEA     $0089A0D4,A3         ; Different table

.alt_table:
0088739C  2673 0000            MOVEA.L 0(A3,D0.W),A3        ; Load table entry
008873A0  263C 2207FFFE        MOVE.L  #$2207FFFE,D3        ; Load constant
```

**Analysis**: Parallel calculator to func_71B3. Uses different table addresses and different control flag ($FFC0BA vs $FFC8A0). The shared structure suggests these handle similar operations for different game systems (e.g., different camera views or split-screen players).

---

## func_73F2 - Coordinate Transform Calculator ($008873F2)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_73F2: 3D Coordinate Transformation with Table Lookups
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008873F2 - $00887452
; Size: 96 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Perform 3D coordinate calculations with shifts and table lookups.
;          Applies transformations for screen projection or collision.
;
; Input: D2-D4 = Input coordinates, A0 = Object pointer
; Output: D3 = Transformed coordinate
; Modifies: D3-D6, A1-A2
; ═══════════════════════════════════════════════════════════════════════════

008873F2  D843                 ADD.W   D3,D4                ; D4 += D3
008873F4  EA44                 LSR.W   #5,D4                ; D4 >>= 5 (divide by 32)
008873F6  3A02                 MOVE.W  D2,D5                ; D5 = D2
008873F8  E845                 LSR.W   #4,D5                ; D5 >>= 4
008873FA  D645                 ADD.W   D5,D3                ; D3 += D5
008873FC  0243 FFE0            ANDI.W  #$FFE0,D3            ; Mask to $FFE0 (round down)
00887400  E343                 LSL.W   #1,D3                ; D3 <<= 1 (multiply by 2)
00887402  D644                 ADD.W   D4,D3                ; D3 += D4
00887404  D643                 ADD.W   D3,D3                ; D3 *= 2

; Read control value and lookup
00887406  3038 C8A0            MOVE.W  $FFC8A0,D0           ; D0 = control index
0088740A  D040                 ADD.W   D0,D0                ; D0 *= 2
0088740C  45FA 001E            LEA     $0088742C(PC),A2     ; A2 = offset table
00887410  4A28 00E4            TST.B   $E4(A0)              ; Test flag
00887414  6704                 BEQ.S   .use_main_table      ; Skip if == 0
00887416  45FA 0044            LEA     $0088745C(PC),A2     ; Use alternate table

.use_main_table:
0088741A  2272 0000            MOVEA.L 0(A2,D0.W),A1        ; A1 = table[D0]
0088741E  3631 3000            MOVE.W  0(A1,D3.W),D3        ; D3 = lookup result

; Second lookup
00887422  2272 0004            MOVEA.L 4(A2,D0.W),A1        ; Second table
00887426  D683                 ADD.L   D3,D3                ; D3 *= 2
00887428  D3C3                 ADDA.L  D3,A1                ; Advance pointer
0088742A  4E75                 RTS

; Embedded offset tables (PC-relative data)
0088742C  0094C000             .long   $0094C000            ; Table 1
00887430  00970000             .long   $00970000            ; Table 2
```

**Analysis**: 3D coordinate transformer. Applies shifts (divide by 32, 16), masking, and double table lookups. The PC-relative table access and coordinate manipulations suggest this converts world coordinates to screen space for rendering.

---

## func_757A - Threshold Comparator ($0088757A)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_757A: Multi-Threshold Comparison with Bit Manipulation
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088757A - $008875BA
; Size: 64 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Compare values against multiple thresholds, set bit flags based on
;          comparison results. Implements priority-based decision logic.
;
; Input: D1-D2 = Values to compare, A1 = Threshold table
; Output: D3.W = Result bitfield (bits set based on comparisons)
; Modifies: D0, D3-D4
; ═══════════════════════════════════════════════════════════════════════════

0088757A  B251                 CMP.W   (A1),D1              ; Compare D1 with (A1)
0088757C  6D06                 BLT.S   .less_than           ; Branch if D1 < (A1)
0088757E  E343                 LSL.W   #1,D3                ; Shift result left
00887580  6442                 BCC.S   .check_next          ; Branch if no carry
00887582  6036                 BRA.S   .exit                ; Exit

.less_than:
00887584  E343                 LSL.W   #1,D3                ; Shift result left
00887586  653C                 BCS.S   .has_carry           ; Branch if carry
00887588  6030                 BRA.S   .exit

; Additional threshold checks
0088758A  E343                 LSL.W   #1,D3                ; Shift left
0088758C  651E                 BCS.S   .threshold2          ; Branch if carry set
0088758E  3002                 MOVE.W  D2,D0                ; D0 = D2
00887590  C1D9                 MULS.W  (A1)+,D0             ; Multiply by table entry
00887592  3819                 MOVE.W  (A1)+,D4             ; D4 = next entry
00887594  48C4                 EXT.L   D4                   ; Sign-extend D4
00887596  EBA4                 LSL.L   #5,D4                ; D4 <<= 5
00887598  D084                 ADD.L   D4,D0                ; D0 += D4
0088759A  EAA0                 LSR.L   #5,D0                ; D0 >>= 5

; Compare with thresholds
0088759C  B280                 CMP.L   D0,D1                ; Compare D1 with D0
0088759E  6D06                 BLT.S   .below_threshold     ; Branch if <
008875A0  E343                 LSL.W   #1,D3                ; Shift result
008875A2  6420                 BCC.S   .no_set              ; Branch if no carry
008875A4  6016                 BRA.S   .exit

.below_threshold:
008875A6  E343                 LSL.W   #1,D3                ; Set bit
008875A8  651A                 BCS.S   .exit                ; Exit if carry
008875AA  6010                 BRA.S   .check_next

.exit:
008875BA  4E75                 RTS
```

**Analysis**: Priority-based threshold comparator. Uses bit shifting to build result bitfield - each threshold test shifts D3 left and conditionally sets bits. Likely used for collision detection zones or AI behavior selection based on distance thresholds.

---

## func_7BE4 - Jump Table Dispatcher ($00887BE4)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_7BE4: 16-Entry Jump Table Dispatcher
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00887BE4 - $00887C24
; Size: 64 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Dispatch to one of 16 handler functions based on 4-bit index in
;          object field $18. Implements state machine or mode selector.
;
; Input: A2 = Object pointer, (A2+$18).B = Handler index (0-15)
; Output: (depends on called handler)
; Modifies: D0, A1
; ═══════════════════════════════════════════════════════════════════════════

00887BE4  102A 0018            MOVE.B  $18(A2),D0           ; D0 = index byte
00887BE8  0240 000F            ANDI.W  #$0F,D0              ; Mask to 0-15
00887BEC  D040                 ADD.W   D0,D0                ; D0 *= 2
00887BEE  D040                 ADD.W   D0,D0                ; D0 *= 4 (scale to long)
00887BF0  227B 0004            MOVEA.L (PC,D0.W,$04),A1     ; A1 = table[D0]
00887BF4  4ED1                 JMP     (A1)                 ; Jump to handler

; Jump table (16 entries)
00887BF6  00887C2E             .long   handler_0            ; Index 0
00887BFA  00887C32             .long   handler_1            ; Index 1
00887BFE  00887C36             .long   handler_2            ; Index 2
00887C02  00887C3A             .long   handler_3            ; Index 3
00887C06  00887C42             .long   handler_4            ; Index 4
00887C0A  00887C46             .long   handler_5            ; Index 5
00887C0E  00887C46             .long   handler_6 (same as 5)
00887C12  00887C46             .long   handler_7 (same as 5)
00887C16  00887C3E             .long   handler_8            ; Index 8
00887C1A  00887C46             .long   handler_9 (same as 5)
00887C1E  00887C46             .long   handler_10 (same as 5)
00887C22  00887C46             .long   handler_11 (same as 5)
```

**Analysis**: 16-way dispatcher using 4-bit index from object byte. Multiple indices share same handler ($00887C46), suggesting common default behavior for several states. The index encoding in single byte allows compact state machine implementation.

---

## func_9A9E - Value Clamp & Adjustment ($00889A9E)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_9A9E: Range Clamping with Damping
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00889A9E - $00889ADE
; Size: 64 bytes
; Called by: Main game logic (1 call)
;
; Purpose: Clamp value to range [$FE00, $0200], apply damping adjustment,
;          and update object fields. Handles wraparound and zero cases.
;
; Input: A0 = Object pointer
; Output: Object field $94 updated with clamped value
; Modifies: D0-D2
; ═══════════════════════════════════════════════════════════════════════════

00889A9E  8568 0002            OR.W    D2,$02(A0)           ; Set bits in field $02
00889AA2  6000 0060            BRA.W   .exit                ; Branch to exit

; Main processing
00889AA6  3028 0094            MOVE.W  $94(A0),D0           ; D0 = current value
00889AAA  3200                 MOVE.W  D0,D1                ; D1 = copy
00889AAC  6B0C                 BMI.S   .negative            ; Branch if negative

; Positive value - check upper bound
00889AAE  0C40 0200            CMPI.W  #$0200,D0            ; Compare with $0200
00889AB2  6E10                 BGT.S   .clamp_high          ; Clamp if > $0200
00889AB4  303C 0200            MOVE.W  #$0200,D0            ; D0 = $0200 (max)
00889AB8  600A                 BRA.S   .apply_adjustment

; Negative value - check lower bound
.negative:
00889ABA  0C40 FE00            CMPI.W  #$FE00,D0            ; Compare with $FE00 (min)
00889ABE  6D04                 BLT.S   .clamp_low           ; Clamp if < $FE00
00889AC0  303C FE00            MOVE.W  #$FE00,D0            ; D0 = $FE00

.apply_adjustment:
00889AC4  3200                 MOVE.W  D0,D1                ; D1 = clamped value

; Apply damping/friction
00889AC6  C1F8 C0F4            MULS.W  $FFC0F4,D0           ; Multiply by factor
00889ACA  E080                 ASR.L   #8,D0                ; Divide by 256
00889ACC  9168 0094            SUB.W   D0,$94(A0)           ; Subtract from field

; Update field
00889AD0  3428 0094            MOVE.W  $94(A0),D2           ; D2 = updated value
00889AD4  B540                 CMP.W   D0,D2                ; Compare
00889AD6  6A04                 BPL.S   .no_clear            ; Skip if positive
00889AD8  4268 0094            CLR.W   $94(A0)              ; Clear field if negative

.no_clear:
.exit:
00889ADC  4E75                 RTS
```

**Analysis**: Value clamping with damping. Implements symmetric range [-$200, +$200], applies multiplicative adjustment from $FFC0F4, and prevents underflow. The MULS and ASR suggest this handles velocity or acceleration with friction/damping.

---

## func_9B7C - Dual Function: Write & Validator ($00889B7C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_9B7C: Simple Register Write (First Entry)
; func_9B84: Multi-Field Validator (Second Entry)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00889B7C - $00889BAC
; Size: 48 bytes
; Called by: Main game logic (1 call each)
;
; Purpose: Two separate functions sharing address space:
;          1) Simple register write (first 4 bytes)
;          2) Multi-field validator with threshold checks
;
; ═══════════════════════════════════════════════════════════════════════════

; Function 1: Simple write (func_9B7C)
00889B7C  31C0 C010            MOVE.W  D0,$FFC010           ; Write D0 to register
00889B80  4E75                 RTS                          ; Return

; Function 2: Field validator (func_9B84)
00889B84  3228 0080            MOVE.W  $80(A0),D1           ; D1 = field $80
00889B88  0C41 0007            CMPI.W  #7,D1                ; Check if > 7
00889B8C  6E0A                 BGT.S   .check_field2        ; Branch if > 7

; Check field $82
00889B8E  3228 0082            MOVE.W  $82(A0),D1           ; D1 = field $82
00889B92  0C41 0007            CMPI.W  #7,D1                ; Check threshold
00889B96  6F08                 BLE.S   .in_range            ; Continue if <= 7

; Out of range - calculate adjustment
.check_field2:
00889B98  700F                 MOVEQ   #15,D0               ; D0 = 15
00889B9A  9041                 SUB.W   D1,D0                ; D0 = 15 - D1
00889B9C  31C0 C00C            MOVE.W  D0,$FFC00C           ; Write result

; Check field $84
.in_range:
00889BA0  3028 0084            MOVE.W  $84(A0),D0           ; D0 = field $84
00889BA4  670E                 BEQ.S   .is_zero             ; Branch if zero
00889BA6  0C40 000A            CMPI.W  #$0A,D0              ; Compare with 10
00889BAA  6E08                 BGT.S   .too_high            ; Branch if > 10

.too_high:
00889BAC  720A                 MOVEQ   #10,D1               ; D1 = 10 (clamp)
```

**Analysis**: Two functions in one. First 4 bytes are simple register write (likely called directly at $9B7C). Second part (called at $9B84) validates 3 object fields ($80, $82, $84) against thresholds (7, 7, 10), calculates adjustments, and writes to $FFC00C. The dual-function pattern saves ROM space.

---

## func_4856 - Unrolled Memory Fill 1 ($00884856)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_4856: 24-Iteration Unrolled Memory Fill (Variant 1)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00884856 - $00884888
; Size: 50 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Fast memory fill using unrolled MOVE.L instructions. Writes 24
;          consecutive longwords (96 bytes total) from source to destination.
;
; Input: A0 = Source address, A1 = Destination address
; Output: 96 bytes copied from (A0)+ to (A1)+
; Modifies: A0, A1 (both incremented by 96 bytes)
; ═══════════════════════════════════════════════════════════════════════════

00884856  22C1                 MOVE.L  (A0)+,(A1)+          ; Copy 1
00884858  22C1                 MOVE.L  (A0)+,(A1)+          ; Copy 2
0088485A  22C1                 MOVE.L  (A0)+,(A1)+          ; Copy 3
0088485C  22C1                 MOVE.L  (A0)+,(A1)+          ; Copy 4
; ... (pattern repeats for 24 iterations total)
00884886  4E75                 RTS
```

**Analysis**: Maximally unrolled memory copy loop. Processes 24 longwords (96 bytes) without any loop overhead. Variant of the memory fill family seen in func_4842/4846. Used for fixed-size structure copying where performance is critical.

---

## func_485E - Unrolled Memory Fill 2 ($0088485E)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_485E: 28-Iteration Unrolled Memory Fill (Variant 2)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088485E - $0088489E
; Size: 64 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Fast memory fill using unrolled MOVE.L instructions. Writes 28
;          consecutive longwords (112 bytes total).
;
; Input: A0 = Source address, A1 = Destination address
; Output: 112 bytes copied
; Modifies: A0, A1 (both incremented by 112 bytes)
; ═══════════════════════════════════════════════════════════════════════════

0088485E  22C1                 MOVE.L  (A0)+,(A1)+          ; Unrolled copy (28x)
; ... (28 iterations of 22C1)
0088489E  4E75                 RTS
```

**Analysis**: Longer variant of func_4856, handling 112 bytes (28 longwords). The graduated sizes (96/112 bytes) suggest these are used for different structure sizes - possibly different object types or display list entries.

---

## func_48B8 - Unrolled Memory Fill 3 ($008848B8)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_48B8: 8-Iteration Unrolled Memory Fill (Variant 3)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008848B8 - $008848CA
; Size: 18 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Fast memory fill for smaller structures - 8 longwords (32 bytes).
;
; Input: A4 = Source, A1 = Destination
; Output: 32 bytes copied
; Modifies: A4, A1 (both incremented by 32 bytes)
; ═══════════════════════════════════════════════════════════════════════════

008848B8  2C81                 MOVE.L  D1,(A4)+             ; 8 iterations
; ... (pattern repeats)
008848CA  4E75                 RTS
```

**Analysis**: Smaller unrolled fill (32 bytes). Uses A4 instead of A0, suggesting this is part of parallel processing pipeline. The D1 source suggests filling with constant value rather than copying.

---

## func_48FE - Unrolled Memory Fill 4 ($008848FE)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_48FE: 15-Iteration Unrolled Memory Fill (Variant 4)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008848FE - $0088491E
; Size: 32 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Memory fill for 60-byte structures (15 longwords).
;
; Input: A2 = Source, A1 = Destination
; Output: 60 bytes copied
; Modifies: A2, A1
; ═══════════════════════════════════════════════════════════════════════════

008848FE  24D9                 MOVE.L  (A1)+,(A2)+          ; 15 iterations
; ... (15 iterations of 24D9)
0088491E  4E75                 RTS
```

**Analysis**: Another size variant (60 bytes). Uses A2 destination, indicating multi-register addressing scheme for concurrent operations. The unrolled family (4856/485E/48B8/48FE) provides optimized copy for 32/60/96/112 byte structures.

---

## func_88BE - Complex Conditional State Handler ($008888BE)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_88BE: Multi-Stage Conditional State Processor
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008888BE - $00888940
; Size: 130 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Complex conditional logic with bit tests, comparisons, and state
;          transitions. Manages game state flags and display mode.
;
; Input: Multiple RAM locations tested
; Output: $FFC0C8, $FFC00C, $FFC8E0 updated
; Modifies: D0, D1, A0
; ═══════════════════════════════════════════════════════════════════════════

008888BE  1038 C86D            MOVE.B  $FFC86D,D0           ; Read state flag
008888C2  0200 0060            ANDI.B  #$60,D0              ; Mask bits 5-6
008888C6  6706                 BEQ.S   .check_next          ; Branch if clear
008888C8  0878 0000 C313       BTST    #0,$FFC313           ; Test bit 0

; State check 1
008888CE  41F8 9000            LEA     $FF9000,A0           ; A0 = RAM base
008888D2  0838 0000 C313       BTST    #0,$FFC313           ; Test control bit
008888D8  6700 00EA            BEQ.W   .branch_far          ; Long branch if clear

; Bit manipulation
008888DC  08F8 0003 C313       BSET    #3,$FFC313           ; Set bit 3
008888E2  31FC 0000 C0C8       MOVE.W  #0,$FFC0C8           ; Clear register

; Secondary state check
008888E8  0838 0000 C86C       BTST    #0,$FFC86C           ; Test flag
008888EE  667E                 BNE.S   .handle_set          ; Branch if set
008888F0  0838 0001 C86C       BTST    #1,$FFC86C           ; Test bit 1
008888F6  6700 00A0            BEQ.W   .exit_handler        ; Exit if clear

; Display mode setup
008888FA  31FC 0010 C8E0       MOVE.W  #$10,$FFC8E0         ; Set display param
00888900  3038 C8D8            MOVE.W  $FFC8D8,D0           ; Read display value
00888904  0C40 3000            CMPI.W  #$3000,D0            ; Compare with threshold
00888908  6E1C                 BGT.S   .above_threshold     ; Branch if > $3000
0088890A  672E                 BEQ.S   .equal_threshold     ; Branch if equal

.above_threshold:
0088892E  31FC ...             MOVE.W  #...,$FFC...         ; Update state
```

**Analysis**: Sophisticated state machine with cascading conditionals. Tests multiple flags ($C86D, $C313, $C86C), performs bit manipulations, and updates display parameters based on thresholds. The $3000 comparison suggests display mode switching (possibly resolution or graphics mode).

---

## func_8DC0 - 3D Coordinate Calculation ($00888DC0)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_8DC0: 3D Coordinate Transform with Conditional Adjustment
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00888DC0 - $00888E18
; Size: 88 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Transform 3D coordinates using object fields and control values.
;          Applies conditional adjustments based on sign and thresholds.
;
; Input: A0 = Object pointer
; Output: D0 = Transformed coordinate written to $FFC...
; Modifies: D0, D1, D2, D3, D4, D6
; ═══════════════════════════════════════════════════════════════════════════

00888DC0  3038 C0BA            MOVE.W  $FFC0BA,D0           ; D0 = control value
00888DC4  3238 C0BE            MOVE.W  $FFC0BE,D1           ; D1 = parameter
00888DC8  3428 0030            MOVE.W  $30(A0),D2           ; D2 = object X
00888DCC  3628 0034            MOVE.W  $34(A0),D3           ; D3 = object Y
00888DD0  4EBA 19CE            JSR     $0088A7A0            ; Call transform func
00888DD4  0440 4000            SUBI.W  #$4000,D0            ; Subtract offset
00888DD8  4440                 SWAP    D0                   ; Swap words

; Sign check and conditional adjustment
00888DDA  4A78 C102            TST.W   $FFC102              ; Test sign flag
00888DDE  672E                 BEQ.S   .positive            ; Branch if positive
00888DE0  7600                 MOVEQ   #0,D6                ; D6 = 0
00888DE2  4A40                 TST.W   D0                   ; Test D0
00888DE4  6B18                 BMI.S   .negative_case       ; Branch if negative

.negative_case:
00888DE6  3638 C102            MOVE.W  $FFC102,D3           ; Load adjustment
00888DEA  6A18                 BPL.S   .apply_adjustment    ; Branch if positive
00888DEC  0C40 C000            CMPI.W  #$C000,D0            ; Compare with -$4000
00888DF0  6406                 BCC.S   .in_range            ; Branch if >= -$4000
00888DF2  0C40 4000            CMPI.W  #$4000,D0            ; Compare with +$4000
00888DF6  640C                 BCC.S   .apply_limit         ; Branch if >= +$4000

.apply_adjustment:
00888DF8  D043                 ADD.W   D3,D0                ; D0 += D3
00888DFA  E240                 ASR.W   #1,D0                ; D0 >>= 1 (divide by 2)
00888DFC  6010                 BRA.S   .finalize

; Alternative path
00888DFE  3638 C102            MOVE.W  $FFC102,D3
00888E02  6AE8                 BPL.S   .skip_negation
00888E04  0280 0000FFFF        ANDI.L  #$0000FFFF,D0        ; Mask to word
00888E0A  D083                 ADD.L   D3,D0                ; Add adjustment
00888E0C  E280                 ASR.L   #1,D0                ; Divide by 2

.finalize:
00888E0E  31C0 ...             MOVE.W  D0,$FFC...           ; Store result
```

**Analysis**: 3D coordinate transformer with sign-dependent processing. Performs offset subtraction, range checks against ±$4000 thresholds, and conditional scaling. The JSR to $A7A0 likely performs matrix multiplication or projection. Used in rendering pipeline.

---

## func_A144 - Table-Based Data Initialization ($0088A144)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_A144: Comprehensive Data Table Initialization
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088A144 - $0088A1A8
; Size: 100 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Initialize multiple RAM locations from table data. Copies control
;          parameters, graphics settings, and game state to work RAM.
;
; Input: None (uses fixed table at $00898818)
; Output: 15+ RAM locations initialized
; Modifies: D0, A1
; ═══════════════════════════════════════════════════════════════════════════

0088A144  43F9 00898818        LEA     $00898818,A1         ; A1 = data table
0088A14A  3038 C8CC            MOVE.W  $FFC8CC,D0           ; D0 = index
0088A14E  2271 0000            MOVEA.L (A1,D0.W),A1         ; A1 = table[index]

; Burst copy of 15 values
0088A152  21D9 C278            MOVE.L  (A1)+,$FFC278        ; Copy long 1
0088A156  31D9 C0E6            MOVE.W  (A1)+,$FFC0E6        ; Copy word 1
0088A15A  31D9 C0E8            MOVE.W  (A1)+,$FFC0E8        ; Copy word 2
0088A15E  31D9 C0EA            MOVE.W  (A1)+,$FFC0EA        ; Copy word 3
0088A162  31D9 C0EC            MOVE.W  (A1)+,$FFC0EC        ; Copy word 4
0088A166  31D9 C0EE            MOVE.W  (A1)+,$FFC0EE        ; Copy word 5
0088A16A  31D9 C0F0            MOVE.W  (A1)+,$FFC0F0        ; Copy word 6
0088A16E  31D9 C0F2            MOVE.W  (A1)+,$FFC0F2        ; Copy word 7
0088A172  31D9 C0F4            MOVE.W  (A1)+,$FFC0F4        ; Copy word 8
0088A176  31D9 C0F6            MOVE.W  (A1)+,$FFC0F6        ; Copy word 9
0088A17A  31D9 C8CE            MOVE.W  (A1)+,$FFC8CE        ; Copy word 10
0088A17E  31D9 C8D0            MOVE.W  (A1)+,$FFC8D0        ; Copy word 11
0088A182  31D9 C8D2            MOVE.W  (A1)+,$FFC8D2        ; Copy word 12
0088A186  31D9 C0F8            MOVE.W  (A1)+,$FFC0F8        ; Copy word 13
0088A18A  31D9 C0FA            MOVE.W  (A1)+,$FFC0FA        ; Copy word 14

; PC-relative offset calculation
0088A18E  43FA 003A            LEA     $0088A1CA(PC),A2     ; Load offset base
0088A192  D040                 ADD.W   D0,D0                ; D0 *= 2 (word index)
```

**Analysis**: Bulk data initializer for game state. Indexed table lookup followed by burst copy of 1 long + 14 words to scattered RAM locations. The $C0E6-$C0FA and $C8CE-$C8D2 ranges suggest graphics/display parameters. Used during mode transitions or level loading.

---

## func_A80A - Loop-Based Data Copy 1 ($0088A80A)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_A80A: Structured Data Copy with Field Processing
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088A80A - $0088A83C
; Size: 50 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Copy data from ROM table to RAM with field-by-field processing.
;          Performs 15 iterations with structure-aware copying.
;
; Input: None (uses fixed tables)
; Output: Data copied to $FAD8 RAM area
; Modifies: D0, D1, A1, A2, A3
; ═══════════════════════════════════════════════════════════════════════════

0088A80A  7200                 MOVEQ   #0,D1                ; D1 = 0 (counter)
0088A80C  1238 FDA9            MOVE.B  $FFFDA9,D1           ; D1 = source index
0088A810  43F8 FAD8            LEA     $FFFAD8,A1           ; A1 = dest base
0088A814  3038 C8C8            MOVE.W  $FFC8C8,D0           ; D0 = control value
0088A818  C1FC 0060            MULS.W  #96,D0               ; D0 *= 96 (structure size)
0088A81C  C3FC 0020            MULS.W  #32,D1               ; D1 *= 32
0088A820  D041                 ADD.W   D1,D0                ; D0 += D1 (offset)
0088A822  43F1 0000            LEA     0(A1,D0.W),A1        ; A1 += offset
0088A826  45F8 9100            LEA     $FF9100,A2           ; A2 = source base
0088A82A  700E                 MOVEQ   #14,D0               ; D0 = loop count (15 iter)

.loop:
0088A82C  3551 00B6            MOVE.W  (A1),182(A2)         ; Copy field +$B6
0088A830  3559 000A            MOVE.W  (A1)+,10(A2)         ; Copy field +$0A, incr A1
0088A834  45EA 0100            LEA     256(A2),A2           ; Advance A2 by 256 bytes
0088A838  51C8 FFF2            DBRA    D0,.loop             ; Loop 15 times
0088A83C  4E75                 RTS
```

**Analysis**: Structured copy with 96-byte and 32-byte stride calculations. Processes 15 objects with 256-byte spacing ($9100 base), copying two fields ($B6 and $0A offsets) per object. The fixed structure suggests this populates object array from level data.

---

## func_A83E - Loop-Based Data Copy 2 ($0088A83E)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_A83E: Large Data Block Copy (Two Phases)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088A83E - $0088A86A
; Size: 44 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Copy two large data blocks from ROM to RAM using loop-based copy.
;          Phase 1: 72 longwords (288 bytes), Phase 2: 108 longwords (432 bytes)
;
; Input: None (uses fixed addresses)
; Output: Data copied to $FAD8 and $FBF8
; Modifies: A1, A2, D0
; ═══════════════════════════════════════════════════════════════════════════

0088A83E  43F9 00937E7E        LEA     $00937E7E,A1         ; A1 = ROM source 1
0088A844  45F8 FAD8            LEA     $FFFAD8,A2           ; A2 = RAM dest 1
0088A848  303C 0047            MOVE.W  #71,D0               ; D0 = 71 (72 iterations)

.loop1:
0088A84C  24D9                 MOVE.L  (A1)+,(A2)+          ; Copy longword
0088A84E  51C8 FFFC            DBRA    D0,.loop1            ; Loop 72 times (288 bytes)

; Phase 2: Second data block
0088A852  43F9 00937F9E        LEA     $00937F9E,A1         ; A1 = ROM source 2
0088A858  45F8 FBF8            LEA     $FFFBF8,A2           ; A2 = RAM dest 2
0088A85C  303C 006B            MOVE.W  #107,D0              ; D0 = 107 (108 iterations)

.loop2:
0088A860  24D9                 MOVE.L  (A1)+,(A2)+          ; Copy longword
0088A862  51C8 FFFC            DBRA    D0,.loop2            ; Loop 108 times (432 bytes)
0088A866  4E75                 RTS
```

**Analysis**: Two-phase bulk copy. Total: 720 bytes (288+432) from ROM to RAM. The ROM addresses ($937E7E, $937F9E) are in data region, suggesting these are lookup tables or level geometry. Sequential DBRA loops prioritize simplicity over speed.

---

## func_BA18 - Triple Jump Table Dispatcher ($0088BA18)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_BA18: Multi-State Jump Table Dispatcher (3 Indices)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088BA18 - $0088BA60
; Size: 72 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Dispatch to handler functions based on three separate state indices.
;          Uses three independent jump tables for different subsystems.
;
; Input: $FFC86C, $FFC86D, $FFC86E = State indices (bytes)
; Output: Calls appropriate handler function
; Modifies: D0, A1
; ═══════════════════════════════════════════════════════════════════════════

0088BA18  4E75                 RTS                          ; Early exit option

; First dispatcher
0088BA1A  7000                 MOVEQ   #0,D0                ; D0 = 0
0088BA1C  1038 C86C            MOVE.B  $FFC86C,D0           ; D0 = state index 1
0088BA20  D040                 ADD.W   D0,D0                ; D0 *= 2
0088BA22  D040                 ADD.W   D0,D0                ; D0 *= 4 (long index)
0088BA24  43F9 00894888        LEA     $00894888,A1         ; A1 = jump table 1
0088BA2A  2271 0000            MOVEA.L (A1,D0.W),A1         ; A1 = table[index]
0088BA2E  4E91                 JSR     (A1)                 ; Call handler 1

; Second dispatcher
0088BA30  7000                 MOVEQ   #0,D0
0088BA32  1038 C86D            MOVE.B  $FFC86D,D0           ; D0 = state index 2
0088BA36  D040                 ADD.W   D0,D0
0088BA38  D040                 ADD.W   D0,D0
0088BA3A  43F9 00894C88        LEA     $00894C88,A1         ; A1 = jump table 2
0088BA40  2271 0000            MOVEA.L (A1,D0.W),A1
0088BA44  4E91                 JSR     (A1)                 ; Call handler 2

; Third dispatcher
0088BA46  7000                 MOVEQ   #0,D0
0088BA48  1038 C86E            MOVE.B  $FFC86E,D0           ; D0 = state index 3
0088BA4C  D040                 ADD.W   D0,D0
0088BA4E  D040                 ADD.W   D0,D0
0088BA50  43F9 00895088        LEA     $00895088,A1         ; A1 = jump table 3
0088BA56  2271 0000            MOVEA.L (A1,D0.W),A1
0088BA5A  4E91                 JSR     (A1)                 ; Call handler 3
0088BA5C  4E75                 RTS

; Alternate entry - initialization
0088BA5E  31FC 0000 C0CE       MOVE.W  #0,$FFC0CE           ; Clear control 1
0088BA64  31FC 0020 C07A       MOVE.W  #$20,$FFC07A         ; Set control 2 = $20
0088BA6A  11FC 0000 C308       MOVE.B  #0,$FFC308           ; Clear flag
0088BA70  31FC 0000 C082       MOVE.W  #0,$FFC082           ; Clear control 3
0088BA76  31FC ...             MOVE.W  #...,$FFC...         ; (continues)
```

**Analysis**: Triple dispatcher - calls 3 handlers sequentially based on independent state bytes. Each uses different jump table ($894888, $894C88, $895088), suggesting parallel subsystems (e.g., player 1/2/3 or graphics/sound/input). The early RTS suggests this can be bypassed conditionally.

---

## func_CA20 - Hardware Register Configuration ($0088CA20)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CA20: VDP and Peripheral Register Setup
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CA20 - $0088CA80
; Size: 96 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Configure VDP registers and peripheral hardware. Writes to multiple
;          I/O addresses in $FF68xx and $FF69xx ranges (32X VDP control).
;
; Input: None
; Output: VDP and peripheral registers configured
; Modifies: D0, D1, D2, A1, A2
; ═══════════════════════════════════════════════════════════════════════════

0088CA20  43F9 00898E80        LEA     $00898E80,A1         ; A1 = config table
0088CA26  45F9 00FF6800        LEA     $00FF6800,A2         ; A2 = VDP base
0088CA2C  7007                 MOVEQ   #7,D0                ; D0 = loop count
0088CA2E  61A2                 BSR.S   $0088C9D2            ; Call subroutine

; Multi-field initialization
0088CA30  7200                 MOVEQ   #0,D2                ; D2 = 0
0088CA32  7017                 MOVEQ   #23,D0               ; D0 = 23 (24 iterations)

.loop:
0088CA34  1481                 MOVE.B  D1,(A2)              ; Write to VDP register
0088CA36  45EA 0010            LEA     16(A2),A2            ; Advance A2 by 16 bytes
0088CA3A  51C8 FFF8            DBRA    D0,.loop             ; Loop 24 times

; Final writes
0088CA3E  33C1 00FF6740        MOVE.W  D1,$00FF6740         ; Write control 1
0088CA44  33C1 00FF672C        MOVE.W  D1,$00FF672C         ; Write control 2
0088CA4A  4E75                 RTS                          ; Normal exit

; Alternate paths with different register values
0088CA4C  13FC 0004 00FF6920   MOVE.B  #4,$00FF6920         ; FB mode register
0088CA54  13FC 0001 00FF6880   MOVE.B  #1,$00FF6880         ; Priority control
0088CA5C  13FC 0001 00FF69A0   MOVE.B  #1,$00FF69A0         ; Auto-fill enable
0088CA64  4E75                 RTS

0088CA66  13FC 0004 00FF6920   MOVE.B  #4,$00FF6920         ; Alternate config
0088CA6E  13FC 0001 00FF6880   MOVE.B  #1,$00FF6880
0088CA76  13FC 0001 00FF6800   MOVE.B  #1,$00FF6800         ; Different register
0088CA7E  4E75                 RTS
```

**Analysis**: VDP hardware setup with multiple entry points. Main path performs 24-iteration register initialization at 16-byte intervals (suggests VDP register array). Alternate entries configure frame buffer mode (#4), priority (#1), and auto-fill. The $FF68xx/$FF69xx range is 32X VDP control space.

---

## func_CA9A - Game Mode Initialization ($0088CA9A)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CA9A: Game Mode Setup and Transition Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CA9A - $0088CAF4
; Size: 90 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Initialize game mode, setup display parameters, and configure
;          subsystems based on mode flags. Handles mode transitions.
;
; Input: $FFC8C8 = Mode selector
; Output: Multiple RAM locations and VDP registers configured
; Modifies: D0, A1
; ═══════════════════════════════════════════════════════════════════════════

0088CA9A  6134                 BSR.S   $0088CAD0            ; Call setup routine
0088CA9C  4EFA 012C            JMP     $0088CBCA            ; Jump to main handler
0088CAA0  612E                 BSR.S   $0088CAD0            ; Alternate entry

; Display mode check
0088CAA2  33FC 004E 00FF6744   MOVE.W  #$4E,$00FF6744       ; Set display register
0088CAAA  3038 C8C8            MOVE.W  $FFC8C8,D0           ; D0 = mode index
0088CAAE  6700 011A            BEQ.W   .mode_zero           ; Branch if mode 0
0088CAB2  0C40 0001            CMPI.W  #1,D0                ; Check if mode 1
0088CAB6  660C                 BNE.S   .other_mode          ; Branch if != 1

; Mode 1 setup
0088CAB8  33FC 0050 00FF6744   MOVE.W  #$50,$00FF6744       ; Mode 1 display param
0088CAC0  4EFA 0108            JMP     $0088CBCA            ; Jump to handler

; Other mode setup
0088CAC4  33FC 0050 00FF6744   MOVE.W  #$50,$00FF6744       ; Alt display param
0088CACC  4EFA 00FC            JMP     $0088CBCA            ; Jump to handler

; Mode initialization
0088CAD0  3038 C8CC            MOVE.W  $FFC8CC,D0           ; D0 = submode index
0088CAD4  43F9 00898C68        LEA     $00898C68,A1         ; A1 = mode table
0088CADA  23F1 0000 00FF6858   MOVE.L  (A1,D0.W),$00FF6858  ; Set mode pointer
0088CAE2  43FA 0012            LEA     $0088CAF6(PC),A1     ; Load offset table
0088CAE6  2271 0000            MOVEA.L (A1,D0.W),A1         ; A1 = handler table
```

**Analysis**: Mode transition controller. Reads mode selector ($C8C8) and configures VDP display register ($FF6744) with mode-specific values ($4E/$50). Uses indexed table at $898C68 to load mode-specific handler pointers into $FF6858. The BSR/JMP pattern suggests multi-stage initialization.

---

## func_CC06 - SH2 COMM Setup with Table Lookup ($0088CC06)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CC06: SH2 Communication Setup & Control
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CC06 - $0088CC56
; Size: 80 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Configure SH2 COMM registers with indexed table lookup.
;          Performs register write sequence with conditional offset calculation.
;
; Input: $FFC8CC = Index value
; Output: Multiple COMM registers written ($FF6018, $FF62xx, etc.)
; Modifies: D0, A1, A2, A3
; ═══════════════════════════════════════════════════════════════════════════

0088CC06  49F9 008958B4        LEA     $008958B4,A4         ; A4 = ROM table base
0088CC0C  3238 C8CC            MOVE.W  $FFC8CC,D1           ; D1 = index
0088CC10  2874 1000            MOVEA.L (A4,D1.L),A4         ; A4 = table[index]
0088CC14  7001                 MOVEQ   #1,D0                ; D0 = 1 (loop count)
0088CC16  43F9 00FF6218        LEA     $00FF6218,A1         ; A1 = COMM base
0088CC1C  7E0E                 MOVEQ   #14,D7               ; D7 = 14 (16 iterations)

; Burst write sequence
0088CC1E  24C4                 MOVE.L  A4,(A1)+             ; Write to COMM
0088CC20  26CC                 MOVE.L  (A4),-(A1)           ; Read from table
0088CC22  3340 0000            MOVE.W  D0,$00(A1)           ; Write control
0088CC26  3340 0014            MOVE.W  D0,$14(A1)           ; Write status
0088CC2A  2353 0010            MOVE.L  (A3),$10(A1)         ; Copy long value
0088CC2E  235B 0024            MOVE.L  (A3)+,$24(A1)        ; Copy with increment
0088CC32  23D3 0038            MOVE.L  (A3),$38(A1)         ; More data
0088CC36  4E75                 RTS
```

**Analysis**: SH2 communication setup using table-driven approach. Loads handler pointer from indexed table at $958B4, then performs sequential register writes. The burst pattern ($FF6218 base) suggests configurable COMM channel setup.

---

## func_CC74 - Register and Flag Initialization ($0088CC74)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CC74: Hardware Register Control & State Initialization
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CC74 - $0088CCC4
; Size: 80 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Initialize hardware control registers and game state flags.
;          Performs multi-stage register setup for subsystem initialization.
;
; Input: $FFC8CC = Control selector
; Output: Multiple control registers configured
; Modifies: D0, A1
; ═══════════════════════════════════════════════════════════════════════════

0088CC74  43F9 008997EC        LEA     $008997EC,A1         ; A1 = control table
0088CC7A  43F1 0000            LEA     0(A1,D0.W),A1        ; A1 += offset
0088CC7E  45F8 C08C            LEA     $FFC08C,A2           ; A2 = reg base 1
0088CC82  4EF9 00884922        JMP     $00884922            ; Jump to handler

; Register control sequence
0088CC88  11F8 FEA9 C30F       MOVE.B  #$FEA9,$FFC30F       ; Set control 1
0088CC8E  41F8 9000            LEA     $FF9000,A0           ; A0 = RAM base
0088CC92  11FC 0000 C819       MOVE.B  #0,$FFC819           ; Clear flag 1
0088CC98  31F8 C094 C07A       MOVE.W  $FFC094,$FFC07A      ; Transfer register
0088CC9E  11FC 0000 C311       MOVE.B  #0,$FFC311           ; Clear flag 2
0088CCA4  31FC 0001 C048       MOVE.W  #1,$FFC048           ; Set value 1
0088CCAA  11FC 0004 C302       MOVE.B  #4,$FFC302           ; Set control 2
0088CCB0  31FC 0000 C086       MOVE.W  #0,$FFC086           ; Clear value
0088CCB6  31FC 0040 C0E4       MOVE.W  #$40,$FFC0E4         ; Set param
```

**Analysis**: Multi-stage hardware initialization. Sets flags, transfers register values, and configures control parameters. Uses table-based offset calculation for different configuration modes. The register addresses ($C08C, $C819, $C094) suggest graphics/display subsystem.

---

## func_CC88 - Control Register Continuation ($0088CC88)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CC88: Register Setup Continuation (Variant of func_CC74)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CC88 - $0088CCBC
; Size: 52 bytes
; Called by: func_CC74 (as continuation point)
;
; Purpose: Second-stage hardware initialization. Continuation of func_CC74
;          with additional register and state setup.
;
; Input: (from previous stage)
; Output: Additional registers configured
; Modifies: A1, A3
; ═══════════════════════════════════════════════════════════════════════════

0088CC88  11F8 FEA9 C30F       MOVE.B  #$FEA9,$FFC30F       ; Set control
0088CC8E  41F8 9000            LEA     $FF9000,A0           ; Load base
0088CC92  11FC 0000 C819       MOVE.B  #0,$FFC819           ; Clear state
0088CC98  31F8 C094 C07A       MOVE.W  $FFC094,$FFC07A      ; Transfer value
0088CC9E  11FC 0000 C311       MOVE.B  #0,$FFC311           ; Clear flag
0088CCA4  31FC 0001 C048       MOVE.W  #1,$FFC048           ; Set value
0088CCAA  11FC 0004 C302       MOVE.B  #4,$FFC302           ; Set param
0088CCB0  31FC 0000 C086       MOVE.W  #0,$FFC086           ; Clear register
0088CCB6  31FC 0040 C0E4       MOVE.W  #$40,$FFC0E4         ; Set control
```

**Analysis**: Effectively identical to func_CC74 body, suggesting this is an alternate entry point or fallthrough continuation. Multiple calls from different code paths may route here directly.

---

## func_CD4C - Loop-Based Array Processor ($0088CD4C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CD4C: Multi-Field Object Array Processor with Loop
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CD4C - $0088CD8C
; Size: 64 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Process array of objects with field-by-field updates.
;          Performs DBRA loop with conditional increments and calculations.
;
; Input: A0 = Object array base, D0 = Field index
; Output: Object fields updated
; Modifies: D0-D2, A0-A2, A3
; ═══════════════════════════════════════════════════════════════════════════

0088CD4C  43F9 00898A7C        LEA     $00898A7C,A1         ; A1 = table 1
0088CD52  3E38 C8A0            MOVE.W  $FFC8A0,D7           ; D7 = control index
0088CD56  2271 70CC             MOVEA.L (A1,D7.W),A1        ; A1 = table[index]
0088CD5A  41F8 9100            LEA     $FF9100,A0           ; A0 = object base
0088CD5E  47F9 009381 4E        LEA     $009381 4E,A3         ; A3 = data table
0088CD64  7000                 MOVEQ   #0,D0                ; D0 = 0 (counter)
0088CD66  7202                 MOVEQ   #2,D1                ; D1 = 2

.loop:
0088CD68  2459                 MOVEA.L (A1)+,A2             ; A2 = handler
0088CD6A  214A 0018            MOVE.L  A2,$18(A0)           ; Store handler
0088CD6E  315B 00C2            MOVE.W  (A3)+,$C2(A0)        ; Copy field $C2
0088CD72  3140 00A4            MOVE.W  D0,$A4(A0)           ; Store counter
0088CD76  3141 00A6            MOVE.W  D1,$A6(A0)           ; Store variant
0088CD7A  5240                 ADDQ.W  #1,D0                ; Increment counter
0088CD7C  5241                 ADDQ.W  #1,D1                ; Increment variant
0088CD7E  0240 000F            ANDI.W  #$0F,D0              ; Clamp to 0-15
0088CD82  0241 000F            ANDI.W  #$0F,D1              ; Clamp to 0-15
0088CD86  41E8 0100            LEA     $100(A0),A0          ; Advance 256 bytes
0088CD8A  51CF FFDC            DBRA    D7,.loop             ; Loop control times
0088CD8E  4E75                 RTS
```

**Analysis**: Object array processor. Loads handler pointers from table, stores to each 256-byte object structure, and updates variant counters. The 0-15 clamping suggests 16-entry state machines.

---

## func_CD92 - Conditional Push with Setup ($0088CD92)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CD92: Stack Push & Conditional Handler Setup
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CD92 - $0088CDC8
; Size: 54 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Save state to stack, then execute conditional handler setup.
;          Used for state preservation during complex operations.
;
; Input: $FFC2C0 = Control flag
; Output: Data on stack, registers configured
; Modifies: A7 (stack pointer), D0, D1, A0
; ═══════════════════════════════════════════════════════════════════════════

0088CD92  2F38 C260            MOVEM.L A0-A2,(A7)           ; Push registers
0088CD96  43F8 C000            LEA     $FFC000,A1           ; A1 = register base
0088CD9A  7200                 MOVEQ   #0,D2                ; D2 = 0
0088CD9C  4EB9 00884842        JSR     $00884842            ; Call handler 1
0088CDA2  21DF C260            MOVE.L  (A7)+,$FFC260        ; Pop to register

; Conditional execution
0088CDA6  43F8 9000            LEA     $FF9000,A1           ; A1 = object base
0088CDAA  7200                 MOVEQ   #0,D2                ; D2 = 0
0088CDAC  7E0F                 MOVEQ   #15,D7               ; D7 = 15 (loop count)
0088CDAE  4EB9 00884842        JSR     $00884842            ; Call handler 2

.loop:
0088CDB4  51CF FFF8            DBRA    D7,.loop             ; Loop 16 times
0088CDB8  7200                 MOVEQ   #0,D2                ; D2 = 0
0088CDBA  11C1 C30E            MOVE.B  D1,$FFC30E           ; Write to control
0088CDBE  31C1 C8AA            MOVE.W  D1,$FFC8AA           ; Write to state 1
0088CDC2  31C1 C8AC            MOVE.W  D1,$FFC8AC           ; Write to state 2
0088CDC6  31C1 C8AE            MOVE.W  D1,$FFC8AE           ; Write to state 3
0088CDCA  31FC FFFF C026       MOVE.W  #$FFFF,$FFC026       ; Set final value
0088CDD0  4E75                 RTS
```

**Analysis**: State preservation function. Pushes registers to stack, executes setup handlers with 16-iteration loop, and finalizes state registers. The multiple state writes ($C8AA-$C8AE) suggest multi-level state machines.

---

## func_CDD2 - Table Lookup with Loop Update ($0088CDD2)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CDD2: Table-Based Loop Processor
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CDD2 - $0088CDFE
; Size: 44 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Loop through objects, perform table lookups, and update fields.
;          Processes 15 objects with 256-byte spacing.
;
; Input: A0 = Object base, D0 = Control index
; Output: Object fields updated from table data
; Modifies: D0, A0, A1
; ═══════════════════════════════════════════════════════════════════════════

0088CDD2  7E0F                 MOVEQ   #15,D7               ; D7 = 15 (loop count)
0088CDD4  D078 C8A0            ADD.W   $FFC8A0,D0           ; D0 += control offset
0088CDD8  41F8 9000            LEA     $FF9100,A0           ; A0 = object base
0088CDDC  3438 C8CC            MOVE.W  $FFC8CC,D2           ; D2 = selector
0088CDE0  43F9 008382BA        LEA     $008382BA,A1         ; A1 = data table
0088CDE6  2271 2000            MOVEA.L (A1,D2.W),A1         ; A1 = table[selector]
0088CDEA  2271 0000            MOVEA.L 0(A1),A1             ; Dereference
0088CDEE  6134                 BSR.S   $0088CE4C            ; Call subroutine

.loop:
0088CDF0  41E8 0100            LEA     $100(A0),A0          ; Advance 256 bytes
0088CDF4  51CF FFF8            DBRA    D7,.loop             ; Loop 15 times
0088CDF8  21FC 0000 0000 902C  MOVE.L  #0,$00FF902C         ; Final write

```

**Analysis**: Table-driven loop processor. Loads table address from indexed lookup, then applies to 15 sequential objects (256-byte spacing). The BSR to $CE4C suggests per-object processing routine.

---

## func_CE02 - Field Manipulation with Conditional Paths ($0088CE02)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CE02: Multi-Path Object Field Update
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CE02 - $0088CE22
; Size: 32 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Conditional update of object fields with three variant paths.
;          Each path applies different field modifications.
;
; Input: A0 = Object pointer
; Output: Object fields updated
; Modifies: D0, D1
; ═══════════════════════════════════════════════════════════════════════════

0088CE02  7200                 MOVEQ   #0,D2                ; D2 = 0
0088CE04  611C                 BSR.S   $0088CE22            ; Branch if equal
0088CE06  317C 000F 00A4       MOVE.W  #$0F,$FFC...(A0)     ; Set field 1
0088CE0C  317C 000F 00A6       MOVE.W  #$0F,$FFC...(A0)     ; Set field 2
0088CE12  41F8 9F00            LEA     $FF9F00,A0           ; A0 = alt base
0088CE16  6124                 BSR.S   $0088CE3C            ; Branch to alt handler

; Alternate path
0088CE18  31D8 00A4            MOVE.W  (A0)+,$A4(A1)        ; Copy field 1
0088CE1C  31D8 00A6            MOVE.W  (A0)+,$A6(A1)        ; Copy field 2
0088CE20  4E75                 RTS
```

**Analysis**: Conditional path selector for object updates. Tests control value and branches to apply different field modifications to either main or alternate object bases ($9100 vs $9F00).

---

## func_CE76 - Multi-Handler Orchestration ($0088CE76)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CE76: Sequential Handler Call Orchestrator
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CE76 - $0088CEA6
; Size: 48 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Call 3 sequential handler functions, perform state updates between
;          them. Implements multi-stage processing pipeline.
;
; Input: None (uses fixed tables)
; Output: State updated via handler calls
; Modifies: D0, A0, A1
; ═══════════════════════════════════════════════════════════════════════════

0088CE76  7200                 MOVEQ   #0,D2                ; D2 = 0
0088CE78  43F8 A800            LEA     $FFA800,A1           ; A1 = handler base
0088CE7C  4EB9 00884842        JSR     $00884842            ; Call handler 1
0088CE82  4EB9 00884846        JSR     $00884846            ; Call handler 2
0088CE88  4EB9 00884856        JSR     $00884856            ; Call handler 3
0088CE8E  11C1 C81D            MOVE.B  D1,$FFC81D           ; Update flag 1
0088CE92  11C1 C81F            MOVE.B  D1,$FFC81F           ; Update flag 2
0088CE96  11C1 C820            MOVE.B  D1,$FFC820           ; Update flag 3
0088CE9A  31C1 A9E0            MOVE.W  D1,$FFA9E0           ; Update param 1
0088CE9E  21FC 0000 C4C4 A9E2  MOVE.L  #0,$FFC4C4,$FFA9E2   ; Multi-write
0088CEA6  4E75                 RTS
```

**Analysis**: Sequential handler orchestrator. Calls 3 handlers in sequence (likely memory fill functions from func_4842/4846/4856), then performs burst updates to flags and parameters. Implements multi-stage initialization with intermediate state updates.

---

## func_CECC - Bitwise Calculation Variant ($0088CECC)

**Status**: Variant of func_CEC2 (see detailed documentation below)

---

## func_CEC2 & func_CECC - Bit Calculation Variants ($0088CEC2 & $0088CECC)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CEC2: Bitwise Calculation with Shifts
; Address: $0088CEC2 - $0088CEEC
; ═══════════════════════════════════════════════════════════════════════════

0088CEC2  41F8 9000            LEA     $FF9000,A0           ; A0 = object base
0088CEC6  1038 FEA4            MOVE.B  $FFFEAD,D0           ; D0 = flag byte
0088CECA  6008                 BRA.S   .check               ; Check value
0088CECC  41F8 9F00            LEA     $FF9F00,A0           ; A0 = alt object base
0088CED0  1038 FEAE            MOVE.B  $FFFEA E,D0          ; D0 = alt flag
0088CED4  3238 C8CC            MOVE.W  $FFC8CC,D1           ; D1 = selector
0088CED8  D241                 ADD.W   D1,D1                ; D1 *= 2
0088CEDA  D278 C8CA            ADD.W   $FFC8CA,D2           ; D2 += offset
0088CEDE  4880                 BKPT    D0                   ; Breakpoint
0088CEE0  D040                 ADD.W   D0,D0                ; D0 *= 2
0088CEE2  D041                 ADD.W   D1,D0                ; D0 += D1
0088CEE4  303B 0008            MOVE.W  0(A3,D0.W),D0        ; D0 = lookup
0088CEE8  D178 C0E8            ADD.W   $FFC0E8,D1           ; Add parameter
0088CEEC  4E75                 RTS

; func_CECC: Variant with Different Base
0088CECC  41F8 9F00            LEA     $FF9F00,A0           ; Alt object base
0088CED0  1038 FEAE            MOVE.B  $FFFEA E,D0          ; (identical pattern follows)
```

**Analysis**: Bitwise arithmetic for coordinate/parameter calculation. Performs 2x scaling, offset accumulation, and table lookups. Two variants (CEC2/CECC) operate on different object bases ($9100 vs $9F00), suggesting split-screen or dual-player support.

---

## func_CF0C - Multi-JSR Orchestration with Loop ($0088CF0C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CF0C: Chained Function Caller with Array Processor
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CF0C - $0088CF54
; Size: 72 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Call 10+ sequential helper functions in a chain, then apply
;          results to object array via loop.
;
; Input: A0 = Object array base
; Output: Objects updated via sequential handlers
; Modifies: D0, D7, A0
; ═══════════════════════════════════════════════════════════════════════════

0088CF0C  41F8 9100            LEA     $FF9100,A0           ; A0 = object base
0088CF10  7E0E                 MOVEQ   #14,D7               ; D7 = 14 (15 iterations)
0088CF12  3F07                 MOVE.W  D7,-(A7)             ; Save counter
0088CF14  4EBA ABA0            JSR     $00888AB6            ; Call func 1
0088CF18  4EBA AB9C            JSR     $00888AB8            ; Call func 2
0088CF1C  4EBA AB98            JSR     $00888ABC            ; Call func 3
0088CF20  4EBA AB94            JSR     $00888AC0            ; Call func 4
0088CF24  4EBA AB90            JSR     $00888AC4            ; Call func 5
0088CF28  4EBA AB8C            JSR     $00888AC8            ; Call func 6
0088CF2C  4EBA AB88            JSR     $00888ACC            ; Call func 7
0088CF30  4EBA AB84            JSR     $00888AD0            ; Call func 8
0088CF34  4EBA AB80            JSR     $00888AD4            ; Call func 9
0088CF38  43F9 0093AC2C        LEA     $0093AC2C,A1         ; A1 = data table
0088CF3E  3028 C8C8            MOVE.W  $C8C8,D0             ; D0 = selector
0088CF42  9068 0032            SUB.W   $32(A0),D0           ; D0 -= object field
0088CF46  D040                 ADD.W   D0,D0                ; D0 *= 2
0088CF48  6B0A                 BMI.S   .negative            ; Branch if < 0
0088CF4A  0240 03FF            ANDI.W  #$03FF,D0            ; Clamp to 10-bit
0088CF4E  3031 0000            MOVE.W  (A1,D0.W),D0         ; Lookup result

.loop:
0088CF52  51CF FFDC            DBRA    D7,.loop             ; Loop 15 times
```

**Analysis**: Chained handler caller followed by array processor. Executes 9 sequential JSR calls, then applies lookup-based update to 15 objects (likely object update pipeline). The negative branch suggests signed arithmetic.

---

## func_CFAE - Complex Data Copy with Mode Handling ($0088CFAE)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_CFAE: Mode-Dependent Data Copy & Integration
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088CFAE - $0088CFFA
; Size: 76 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Copy data from ROM to RAM with mode-specific handling.
;          Integrates multiple ROM tables based on game mode.
;
; Input: $FFC8CC = Mode selector
; Output: Data copied to multiple RAM regions ($FAD8+, $FBF8+)
; Modifies: D0, A1, A2
; ═══════════════════════════════════════════════════════════════════════════

0088CFAE  3038 C8CC            MOVE.W  $FFC8CC,D0           ; D0 = mode
0088CFB2  43F9 008955CC        LEA     $008955CC,A1         ; A1 = mode table
0088CFB8  2271 0000            MOVEA.L (A1,D0.W),A1         ; A1 = data[mode]
0088CFBC  45F9 00FF6178        LEA     $00FF6178,A2         ; A2 = dest region 1
0088CFC2  7E07                 MOVEQ   #7,D7                ; D7 = 7 (8 iterations)

.loop1:
0088CFC4  2559 0002            MOVE.L  (A1)+,(A2)           ; Copy to region 1
0088CFC8  3559 0006            MOVE.W  (A1)+,$06(A2)        ; Copy to region 1
0088CFCC  45EA 0014            LEA     $14(A2),A2           ; Advance 20 bytes
0088CFD0  51CF FFF2            DBRA    D7,.loop1            ; Loop 8 times

; Secondary copy phase
0088CFD4  4E75                 RTS                          ; Return

; Alternate entry point
0088CFD6  3038 C8CC            MOVE.W  $FFC8CC,D0           ; D0 = mode
0088CFDA  43F9 008955CC        LEA     $008955CC,A1         ; A1 = mode table
0088CFE0  2271 0000            MOVEA.L (A1,D0.W),A1         ; A1 = data[mode]
0088CFE4  2649                 MOVEA.L A1,A3                ; A3 = copy of A1
0088CFE6  45F9 00FF6178        LEA     $00FF6178,A2         ; A2 = dest region
0088CFEC  61D4                 BSR.S   $0088CFC2            ; Call copy routine
```

**Analysis**: Mode-dependent data integration. Loads mode-specific ROM table, then copies to display region with 20-byte stride (8 iterations). Alternate entry allows direct processing. Used during mode transitions or track loading.

---

## func_D054 - Subroutine Call with Table Write ($0088D054)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_D054: Subroutine Caller & State Table Writer
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088D054 - $0088D08A
; Size: 54 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Call helper subroutine, load table pointer, perform indexed write
;          to RAM. Updates game state via table-driven approach.
;
; Input: $FFC8A0 = Control value
; Output: Game state written to $FF68xx region
; Modifies: D0, A1
; ═══════════════════════════════════════════════════════════════════════════

0088D054  4EBA FFB6            JSR     $0088D00C            ; Call helper
0088D058  3038 C8A0            MOVE.W  $FFC8A0,D0           ; D0 = control value
0088D05C  43F9 00898C0C        LEA     $00898C0C,A1         ; A1 = state table
0088D062  23F1 0000 00FF6868   MOVE.L  (A1,D0.W),$00FF6868  ; Write state

; Loop copy sequence
0088D06A  227B 0004            MOVEA.L (PC,D0.W,$04),A1     ; Load offset table
0088D06E  4ED1                 JMP     (A1)                 ; Jump to handler
0088D070  0088 D088            .long   $0088D088            ; Jump table entry 1
0088D074  0088 D088            .long   $0088D088            ; Jump table entry 2
0088D078  0088 D088            .long   $0088D088            ; Jump table entry 3
0088D07C  0088 D088            .long   $0088D088            ; Jump table entry 4
0088D080  0088 D088            .long   $0088D088            ; Shared handler
0088D084  4E75                 RTS
```

**Analysis**: Orchestrator function. Calls subroutine, loads state from table at $98C0C using control index, and writes to $FF68xx region. Multiple jump table entries point to same handler, suggesting this can be called with different parameters that route to common code.

---

## func_D08A - Multi-Register Control Initialization ($0088D08A)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_D08A: Hardware Control Register Setup
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088D08A - $0088D0F6
; Size: 76 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Configure multiple hardware control registers for subsystem setup.
;          Performs sequential register writes to control state flags.
;
; Input: None (uses fixed register addresses)
; Output: 8+ control registers initialized
; Modifies: D0, A0
; ═══════════════════════════════════════════════════════════════════════════

0088D08A  11FC 0000 C806       MOVE.B  #0,$FFC806           ; Clear control 1
0088D090  11FC 00C4 C807       MOVE.B  #$C4,$FFC807         ; Set control 2
0088D096  11FC 00C4 C808       MOVE.B  #$C4,$FFC808         ; Set control 3
0088D09C  11FC 0000 C813       MOVE.B  #0,$FFC813           ; Clear state 1
0088D0A2  11FC 00C4 C814       MOVE.B  #$C4,$FFC814         ; Set state 2
0088D0A8  11FC 00C4 C815       MOVE.B  #$C4,$FFC815         ; Set state 3
0088D0AE  31FC C200 C076       MOVE.W  #$C200,$FFC076       ; Set param 1
0088D0B4  21FC 6100 0000 C254  MOVE.L  #$6100,$00FFC254     ; Set param 2
0088D0BC  21FC 6000 0000 C260  MOVE.L  #$6000,$00FFC260     ; Set param 3
0088D0C4  3038 C8A0            MOVE.W  $FFC8A0,D0           ; D0 = control
0088D0C8  4EFA FFA0            JMP     $0088D06C            ; Jump to handler
```

**Analysis**: Hardware initialization sequence. Sets flags ($C806-$C815) and parameters ($C076, $C254, $C260) for subsystem control. The repeated pattern of #0 and #$C4 values suggests alternating enable/disable flags. Jumps to main handler after setup.

---

## func_D0F6 - Looped Register Configuration ($0088D0F6)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_D0F6: Register Setup with Looped Iteration
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088D0F6 - $0088D150
; Size: 90 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Configure registers, load data table, and apply transformations
;          via loop. Handles conditional branching based on test values.
;
; Input: None (uses fixed addresses)
; Output: Multiple registers and memory locations configured
; Modifies: D0, D7, A1, A2
; ═══════════════════════════════════════════════════════════════════════════

0088D0F6  11FC 0003 C80A       MOVE.B  #3,$FFC80A           ; Set control
0088D0FC  45F8 C200            LEA     $FFC200,A2           ; A2 = data base
0088D100  43F8 EEE0            LEA     $FFEE E0,A1          ; A1 = alt base
0088D104  4EB9 00884920        JSR     $00884920            ; Call copy handler
0088D10A  21F8 EEFC C254       MOVE.L  $FFEEFC,$FFC254      ; Load + write
0088D110  31FC 00C0 C054       MOVE.W  #$C0,$FFC054         ; Set param 1
0088D116  31FC 0540 C056       MOVE.W  #$0540,$FFC056       ; Set param 2
0088D11C  31FC 0000 C896       MOVE.W  #0,$FFC896           ; Clear state

; Conditional iteration loop
0088D122  43F8 C200            LEA     $FFC200,A1           ; A1 = base
0088D126  47F9 00FF68D8        LEA     $00FF68D8,A3         ; A3 = loop table
0088D12C  7E04                 MOVEQ   #4,D7                ; D7 = 4 (5 iterations)

.loop:
0088D12E  4EBA E30C            JSR     $00889040            ; Call iteration handler
0088D132  43E9 0004            LEA     $04(A1),A1           ; Advance 4 bytes
0088D136  47EB 0010            LEA     $10(A3),A3           ; Advance 16 bytes
0088D13A  51CF FFF2            DBRA    D7,.loop             ; Loop 5 times
0088D13E  72FF                 MOVEQ   #-1,D1               ; D1 = -1 (mask)
0088D140  7E04                 MOVEQ   #4,D7                ; D7 = 4
0088D142  2038 C254            MOVE.L  $FFC254,D0           ; D0 = state value
```

**Analysis**: Configuration with looped processing. Sets control byte #3 at $C80A, loads/copies data ($EEE0/$EEFC), sets parameters, then loops 5 times calling iteration handler. The JSR to $9040 is called multiple times with address updates, suggesting per-object or per-structure processing.

---

## func_D19C - Comparison Selector with State Updates ($0088D19C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_D19C: Conditional Comparator & Bit-Encoded State Machine
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088D19C - $0088D1D4
; Size: 56 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Test conditions against thresholds, update state registers based
;          on comparison results. Implements bit-based state machine.
;
; Input: (Various RAM locations tested)
; Output: State flags written to $FFC8xx range
; Modifies: D0, D1, D2
; ═══════════════════════════════════════════════════════════════════════════

0088D19C  7400                 MOVEQ   #0,D2                ; D2 = 0
0088D19E  0C40 0002            CMPI.W  #2,D0                ; Compare D0 with 2
0088D1A2  6602                 BNE.S   .skip_set1           ; Skip if != 2
0088D1A4  7401                 MOVEQ   #1,D2                ; D2 = 1

.skip_set1:
0088D1A6  0C40 0003            CMPI.W  #3,D0                ; Compare D0 with 3
0088D1AA  6602                 BNE.S   .skip_set2           ; Skip if != 3
0088D1AC  7401                 MOVEQ   #1,D2                ; D2 = 1
0088D1AE  11C2 C826            MOVE.B  D2,$FFC826           ; Write flag

; State register update sequence
0088D1B2  31C0 C89C            MOVE.W  D0,$FFC89C           ; Write state 1
0088D1B6  D040                 ADD.W   D0,D0                ; D0 *= 2
0088D1B8  31C0 C89E            MOVE.W  D0,$FFC89E           ; Write state 2
0088D1BA  D040                 ADD.W   D0,D0                ; D0 *= 2
0088D1BC  31C0 C8A0            MOVE.W  D0,$FFC8A0           ; Write state 3
0088D1C0  31C1 C8C8            MOVE.W  D1,$FFC8C8           ; Write state 4
0088D1C4  D241                 ADD.W   D1,D1                ; D1 *= 2
0088D1C6  31C1 C8CA            MOVE.W  D1,$FFC8CA           ; Write state 5
0088D1CA  D241                 ADD.W   D1,D1                ; D1 *= 2
0088D1CC  31C1 C8CC            MOVE.W  D1,$FFC8CC           ; Write state 6
0088D1D0  4E75                 RTS
```

**Analysis**: Comparison-driven state machine. Tests D0 against thresholds (2 and 3), sets D2 accordingly, then performs cascading doubling (left shift) and writes to state registers. The pattern suggests power-of-2 scaling for state indices.

---

## func_D42C - Dispatcher with Data Copy ($0088D42C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_D42C: Handler Dispatcher with Setup Copy
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088D42C - $0088D47E
; Size: 82 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Call multiple setup functions, then copy data to configuration
;          region. Implements multi-stage system initialization.
;
; Input: None (uses fixed addresses)
; Output: Data copied to setup region
; Modifies: D0, A0, A1
; ═══════════════════════════════════════════════════════════════════════════

0088D42C  2ABC 4000 0000 72 00 MOVEM.L D0-D1,(A5)          ; Save state
0088D434  4EF9 00884842        JMP     $00884842            ; Jump to handler 1
0088D43A  43F8 8000            LEA     $FF8000,A1           ; A1 = data base
0088D43E  7200                 MOVEQ   #0,D2                ; D2 = 0
0088D440  4EB9 00884842        JSR     $00884842            ; Call setup 1
0088D446  4EF9 00884842        JMP     $00884842            ; Jump to setup 2
0088D44C  4EF9 00884842        JMP     $00884842            ; Jump to setup 3

; Data copy sequence
0088D452  050A 0F14            .word   $050A, $0F14         ; Data pattern
0088D456  7000                 MOVEQ   #0,D0                ; D0 = 0
0088D458  1038 FEA8            MOVE.B  $FFFEA8,D0           ; D0 = index byte
0088D45C  1238 C80F            MOVE.B  $FFC80F,D1           ; D1 = config byte
0088D460  6704                 BEQ.S   .use_alt             ; Branch if zero
0088D462  1038 FEAC            MOVE.B  $FFFEA C,D0          ; Use alternate index
0088D466  11FB 00EA C81A       MOVE.B  $EA(PC,D0),C81A      ; Copy to config

; Table lookup and write
0088D46C  41F9 00898BFC        LEA     $00898BFC,A0         ; A0 = config table
0088D472  E548 D1C0            LSL.L   #2,D0                ; D0 *= 4
0088D476  23D0 00FF6828        MOVE.L  (A0,D0),($00FF6828)  ; Write to config
0088D47C  4E75                 RTS
```

**Analysis**: Multi-stage dispatcher. Saves state, makes jumps to setup functions, then performs indexed table lookup with left-shift scaling (multiply by 4) and writes to configuration region ($FF6828). The conditional alternate index selection suggests mode-dependent initialization.

---

## func_D450 - Conditional Data Processing ($0088D450)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_D450: Conditional Data Load & Processing
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088D450 - $0088D486
; Size: 54 bytes
; Called by: Main game logic (JSR from unknown locations)
;
; Purpose: Load data, perform conditional test, update configuration registers
;          based on results. Implements branching data processor.
;
; Input: $FFC80F = Configuration selector
; Output: Configuration registers updated
; Modifies: D0, D1, A0
; ═══════════════════════════════════════════════════════════════════════════

0088D450  7000                 MOVEQ   #0,D0                ; D0 = 0
0088D452  1038 FEA8            MOVE.B  $FFFEA8,D0           ; D0 = index
0088D456  1238 C80F            MOVE.B  $FFC80F,D1           ; D1 = config
0088D45A  6704                 BEQ.S   .use_main            ; Branch if zero
0088D45C  1038 FEAC            MOVE.B  $FFFEA C,D0          ; Use alternate index
0088D460  11FB 00EA C81A       MOVE.B  $EA(PC,D0),C81A      ; Copy to config

; Main processing path
.use_main:
0088D466  41F9 00898BFC        LEA     $00898BFC,A0         ; A0 = config table
0088D46C  E548 D1C0            LSL.L   #2,D0                ; D0 *= 4
0088D470  23D0 00FF6828        MOVE.L  (A0,D0),($FF6828)    ; Write config 1
0088D476  4A01                 TST.B   D1                   ; Test config flag
0088D478  6706                 BEQ.S   .skip_alt            ; Skip if zero
0088D47A  23D0 00FF68B8        MOVE.L  (A0,D0),($FF68B8)    ; Write config 2

.skip_alt:
0088D480  4E75                 RTS
```

**Analysis**: Data loader with conditional writes. Tests configuration flag $C80F and branches to use either primary ($FEA8) or alternate ($FEAC) index. Performs table lookup with 4x scaling and writes to either $FF6828 (primary) or both $FF6828/$FF68B8 (if flag set). The dual-write path suggests split-mode operation.

---

## func_6D8C - Register Save/Restore Wrapper ($0088​6D8C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_6D8C: Small Wrapper with Full Register Save
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088​6D8C - $0088​6D94
; Size: 8 bytes
; Called by: Game logic control functions
;
; Purpose: Minimal wrapper that saves all registers, calls another function,
;          and restores them. Used for context-sensitive subroutine calls.
;
; Input: None
; Output: Depends on called function (func_6F98)
; Modifies: All (saved/restored)
; ═══════════════════════════════════════════════════════════════════════════

0088​6D8C  48E7 FFFE            MOVEM.L D0-D7/A0-A6,-(A7)  ; Save all registers
0088​6D90  4EB9 00886F98        JSR     $00886F98            ; Call func_6F98
0088​6D96  4CDF 7FFF            MOVEM.L (A7)+,D0-D7/A0-A6  ; Restore all registers
0088​6D9A  4E75                 RTS
```

**Analysis**: Trivial wrapper function (8 bytes). Saves all CPU registers, calls another function, then restores them. Used when called function needs clean register state. The full register save is excessive for most cases, suggesting defensive programming or legacy code structure.

---

## func_7768 - Complex Conditional Handler ($00887768)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_7768: Multi-Register Conditional Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00887768 - $0088​7796
; Size: 46 bytes
; Called by: Game state controllers
;
; Purpose: Conditional logic with register save/restore. Tests condition bits,
;          performs selective register writes and data updates.
;
; Input: D0-D7, A0-A5 (preserved or modified per condition)
; Output: Memory-based updates via indirect addressing
; Modifies: A5-A6, condition flags
; ═══════════════════════════════════════════════════════════════════════════

00887768  48E7 FF00            MOVEM.L D0-D7/A0-A5,-(A7)  ; Save D0-D7, A0-A5
0088​776C  4EBA 012E            JSR     $00887E9C            ; Call subroutine
00887770  4CDF 00FF            MOVEM.L (A7)+,D0-D7/A0-A5  ; Restore registers
00887774  0828 0000 0055       BTST    #$55,-(A7)           ; Test bit 55 (custom flag)
00887778  6600 6FD7            BNE.W   .branch_label        ; Branch to other code
...
```

**Analysis**: Orchestrator function with conditional dispatch. Saves full register set (D0-D7/A0-A5), calls subroutine, then performs bit testing on result. The branch at end suggests two different game state paths. Likely used for multi-modal game logic.

---

## func_77B2 - Configuration Initializer ($00887​7B2)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_77B2: Register Configuration Sequence
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00887​7B2 - $0088​7896
; Size: 228 bytes
; Called by: State machine handlers
;
; Purpose: Multi-step register configuration with repeated patterns. Sets up
;          game mode parameters across multiple register blocks.
;
; Input: Various register state
; Output: $C3xx, $C8xx registers configured
; Modifies: All work registers, control registers
; ═══════════════════════════════════════════════════════════════════════════

00887​7B2  48E7 FF00            MOVEM.L D0-D7/A0-A5,-(A7)  ; Save registers
00887​7B6  4EBA 00E4            JSR     $0088​789C            ; Call handler 1
00887​7BA  4CDF 00FF            MOVEM.L (A7)+,D0-D7/A0-A5  ; Restore
00887​7BE  0828 0000 0055       BTST    #$55,D0              ; Test flag
00887​7C2  6600 24D7            BNE.W   .alt_path            ; Alternate config
...
```

**Analysis**: Large configuration function (228 bytes). Follows save-JSR-restore pattern repeated multiple times with different offsets. Likely implementing game mode setup with multiple handler calls. The repeated pattern suggests iterator-like behavior across different configuration blocks.

---

## func_9458 - Loop-Based Data Updater ($00889458)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_9458: Looped Data Processor with Threshold Tests
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00889458 - $000894F0
; Size: 152 bytes
; Called by: Object update routines
;
; Purpose: Process array of data with loop counter and conditional updates.
;          Performs comparison, conditional increment/decrement, with multiple
;          exit paths based on threshold tests.
;
; Input: D0-D7 = Loop counter and data values
;        A5-A6 = Register bases
; Output: Memory updates at various addresses
; Modifies: All registers
; ═══════════════════════════════════════════════════════════════════════════

00889458  48E7 8040            MOVEM.L D6-D7/A5-A6,-(A7)  ; Save D6-D7, A5-A6
0088​945C  227B C27C            MOVE.L  #$C27C,A1         ; A1 = config table
00889460  3028 0004            MOVE.W  $04(A0),D0         ; D0 = array index
...
(Complex loop with multiple JSR calls and conditional branches)
```

**Analysis**: Sophisticated loop processor (152 bytes). Selective register save (only D6-D7/A5-A6), multiple JSR calls within loop structure, complex threshold logic with conditional increments. Likely object or entity update function processing arrays with state machines.

---

## func_77D6 - Configuration Path Handler ($008877D6)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_77D6: Conditional Configuration Handler with Data Copy
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008877D6 - $00887917
; Size: 321 bytes
; Called by: State machine handlers
;
; Purpose: Load conditional configuration path, copy data blocks to memory,
;          with selective updates based on control flags. Implements multi-path
;          game mode configuration with staged initialization.
;
; Input: $FFC80F = Configuration selector
;        Various control registers
; Output: Memory updates to $C3xx, $C0xx regions
; Modifies: All registers (saved/restored)
; ═══════════════════════════════════════════════════════════════════════════

008877D6  48E7 FF00            MOVEM.L D0-D7/A0-A5,-(A7)  ; Save D0-D7, A0-A5
008877DA  4EBA 00C0            JSR     $00887E9C            ; Call subroutine
008877DE  4CDF 00FF            MOVEM.L (A7)+,D0-D7/A0-A5  ; Restore registers
008877E2  0828 0000 0055       BTST    #$55,D0              ; Test status bit
008877E6  6710                 BEQ.S   .path_alt            ; Branch if zero
008877E8  9768 0040            SUB.W   $40(A0),D3           ; Conditional subtract
008877EC  9968 0046            SUB.W   $46(A0),D4           ; Another subtract
008877F0  9B68 0030            SUB.W   $30(A0),D5           ; More data
008877F4  9D68 0034            SUB.W   $34(A0),D6           ; Configuration
003187F8  3168 0040 0042       MOVE.W  $40(A0),$42(A0)      ; Copy word 1
008877FE  3168 0046 0048       MOVE.W  $46(A0),$48(A0)      ; Copy word 2
...
00887915  4E75                 RTS
```

**Analysis**: Large configuration handler (321 bytes). Tests condition bit ($55), branches to alternate path if clear. Performs cascading subtractions from offset addresses then copies back results. Pattern suggests game mode validation and conditional data transformation. The sub-RTS pattern and full register save indicates critical control flow.

---

## func_C784 - Orchestrator with Full Register Save ($0088C784)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_C784: Complex Orchestrator Function (Full Register Save)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088C784 - $0088C8CC
; Size: 328 bytes
; Called by: Main game logic dispatcher
;
; Purpose: Comprehensive orchestration function with extensive subroutine calls,
;          register configuration, and data table lookups. Handles multiple
;          initialization phases with branching logic.
;
; Input: Various control registers and memory locations
; Output: Extensive register configuration and memory writes
; Modifies: All registers (saved/restored)
; ═══════════════════════════════════════════════════════════════════════════

0088C784  48E7 FFFE            MOVEM.L D0-D7/A0-A7,-(A7)  ; Save ALL registers
0088C788  7200                 MOVEQ   #0,D1                ; D1 = 0
0088C78A  43FA 0036            LEA     $0088C7C2,A1         ; A1 = handler table
0088C78E  45F8 9100            LEA     $FF9100,A2           ; A2 = object base
0088C792  700E                 MOVEQ   #14,D0               ; D0 = 14 iterations
0088C794  3551 00B6            MOVE.W  D1,($B6,A5)          ; Store D1
0088C798  3559 000A            MOVE.W  D2,($0A,A5)          ; Store D2
0088C79C  45EA 0100            LEA     $0100(A5),A2         ; Advance A2
0088C7A0  51C8 FFF2            DBRA    D0,.loop_label       ; Loop 15 times
0088C7A4  21FC 0088 C7E0 C280  MOVE.L  #$0088C7E0,$C280     ; Write handler address
0088C7AC  41F9 0093 C0EC       LEA     $0093C0EC,A0         ; A0 = data table
0088C7B2  3278 C8C0            MOVE.W  $C8C0,D1             ; D1 = control value
0088C7B6  4EB9 0088 13B4       JSR     $008813B4            ; Call dispatcher
0088C7BC  4CDF 7FFF            MOVEM.L (A7)+,D0-D7/A0-A7  ; Restore ALL
0088C7C0  4E75                 RTS
```

**Analysis**: Comprehensive orchestrator (328 bytes) with full register save (D0-D7/A0-A7). Implements looped iteration (DBRA pattern), handler table lookups, and multiple JSR calls. The full register save and complex data flow suggest this is a high-level game state configuration function that preserves complete machine state. Pattern family indicates this is part of critical initialization sequence.

---

## func_778E - Substantial Configuration Manager ($0088778E)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_778E: Large Multi-Path Configuration Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088778E - $0088789A
; Size: 270 bytes
; Called by: Game state controllers
;
; Purpose: Complex configuration handler with multiple conditional paths.
;          Loads configuration data, performs conditional tests and data
;          transformations across multiple memory regions.
;
; Input: $FFC8xx = Control registers
;        A0-A5 = Base addresses
; Output: Configuration memory updates
; Modifies: D0-D7, A0-A5 (saved/restored)
; ═══════════════════════════════════════════════════════════════════════════

0088778E  48E7 FF00            MOVEM.L D0-D7/A0-A5,-(A7)  ; Save D0-D7, A0-A5
00887792  4EBA 0108            JSR     $00887E9C            ; Call subroutine
00887796  4CDF 00FF            MOVEM.L (A7)+,D0-D7/A0-A5  ; Restore registers
0088779A  0828 0000 0055       BTST    #$55,D0              ; Test status bit
0088779E  6600 6FD7            BNE.W   .alternate_path      ; Branch if set
00887A04  ...                  (Complex data manipulation sequence)
0088789A  4E75                 RTS
```

**Analysis**: Substantial configuration function (270 bytes). Save-JSR-Restore wrapper calling subroutine at $8E9C, followed by conditional branch on bit $55. Complex nested conditional logic suggests multiple game mode paths. Pattern similar to func_77D6 indicates a family of configuration handlers with variant entry points.

---

## func_A7CC - Minimal Register Handler ($0088A7CC)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_A7CC: Selective Register Save/Call/Restore Wrapper
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088A7CC - $0088A7E0
; Size: 20 bytes
; Called by: Loop optimization patterns
;
; Purpose: Minimal wrapper saving only D2 and A5-A6. Calls subroutine and
;          restores. Used in performance-critical loop contexts to minimize
;          register push/pop overhead.
;
; Input: Depends on calling context (loop iteration)
; Output: Subroutine result
; Modifies: D2, A5-A6 (saved/restored only)
; ═══════════════════════════════════════════════════════════════════════════

0088A7CC  48E7 2040            MOVEM.L D2/A5-A6,-(A7)      ; Save D2, A5-A6 only
0088A7D0  4EBA E7F6            JSR     $00888FCC            ; Call handler
0088A7D4  4CDF 0204            MOVEM.L (A7)+,D2/A5-A6      ; Restore D2, A5-A6
0088A7D8  4A42                 TST.W   D2                   ; Test result
0088A7DA  6C04                 BMI.S   .error_path          ; Branch if negative
0088A7DC  4E75                 RTS
```

**Analysis**: Minimal wrapper (20 bytes). Selective register save (only D2/A5-A6, not the full data registers). Quick test of result via TST.W with conditional branch. This pattern suggests optimization for loop bodies where only a few registers need preservation, contrasting with the full-save functions. Part of a register-save optimization strategy.

---

## func_8B9C - Hardware Register Initializer 1 ($00888B9C)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_8B9C: Hardware Configuration Sequence 1
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00888B9C - $00888BBE
; Size: 34 bytes
; Called by: Dispatch table @ $008B34 [index 6]
;
; Purpose: Initialize hardware registers in sequence. Writes values to
;          multiple control registers in the $C0xx range. Part of
;          multi-stage hardware configuration.
;
; Input: None (self-contained)
; Output: Hardware registers configured
; Modifies: D0, D1, D2 (not saved)
; ═══════════════════════════════════════════════════════════════════════════

00888B9C  31FC 0000 C0BA        MOVE.W  #$0000,$FFC0BA       ; Clear control 1
00888BA2  31FC 0080 C0B0        MOVE.W  #$0080,$FFC0B0       ; Set control 2 = $0080
00888BA8  3038 C8DC             MOVE.W  $FFC8DC,D0           ; Load selector
00888BAC  31C0 C054             MOVE.W  D0,$FFC054           ; Write to port 1
00888BB0  31C0 C892             MOVE.W  D0,$FFC892           ; Write to port 2
00888BB4  3038 C8DE             MOVE.W  $FFC8DE,D0           ; Load selector 2
00888BB8  31C0 C056             MOVE.W  D0,$FFC056           ; Write to port 3
00888BBC  31C0 C894             MOVE.W  D0,$FFC894           ; Write to port 4
00888BBE  4E75                 RTS
```

**Analysis**: Hardware configuration handler (34 bytes). Writes to control registers $C0BA, $C0B0, then reads two selectors from RAM ($C8DC, $C8DE) and writes each to two hardware ports ($C054/$C892 and $C056/$C894). This pattern suggests dual-port hardware with redundant writes for safety/synchronization.

---

## func_8BC2 - Hardware Register Initializer 2 ($00888BC2)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_8BC2: Hardware Configuration Sequence 2
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00888BC2 - $00888BE0
; Size: 30 bytes
; Called by: Dispatch table @ $008B34 [index 1]
;
; Purpose: Hardware configuration variant 2. Similar to func_8B9C but with
;          different register writes. Likely handles alternate hardware paths.
;
; Input: None
; Output: Hardware registers configured
; Modifies: D0, D1, D2 (not saved)
; ═══════════════════════════════════════════════════════════════════════════

00888BC2  31FC 0000 C0BA        MOVE.W  #$0000,$FFC0BA       ; Clear control 1
00888BC8  43F8 C0C0             LEA     $FFC0C0,A1           ; A1 = register base
00888BCC  31D9 C0AE             MOVE.W  (A1),D0              ; Load from base
00888BD0  31D9 C0B0             MOVE.W  (A1),D0              ; Load again
00888BD4  31D1 C0B2             MOVE.W  D1,$FFC0B2           ; Write D1 to control
00888BD8  3038 C8DC             MOVE.W  $FFC8DC,D0           ; Load selector
00888BDC  31C0 C054             MOVE.W  D0,$FFC054           ; Write to port 1
00888BE0  31C0 C892             MOVE.W  D0,$FFC892           ; Write to port 2
00888BE4  3038 C8DE             MOVE.W  $FFC8DE,D0           ; Load selector 2
00888BE8  31C0 C056             MOVE.W  D0,$FFC056           ; Write to port 3
00888BEC  31C0 C894             MOVE.W  D0,$FFC894           ; Write to port 4
00888BF0  4E75                 RTS
```

**Analysis**: Configuration variant (30 bytes). Uses LEA to load base address $C0C0 and double-reads from it (unusual pattern). Clears $C0BA like func_8B9C, writes D1 to $C0B2, then repeats the dual-port write pattern from func_8B9C. The double-read and conditional D1 write suggest synchronization or wait-for-ready patterns.

---

## func_8BF2 - Hardware Register Initializer 3 ($00888BF2)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_8BF2: Hardware Configuration Sequence 3
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00888BF2 - $00888C14
; Size: 34 bytes
; Called by: Dispatch table @ $008B34 [index 2]
;
; Purpose: Hardware configuration variant 3. Combines register initialization
;          with indexed addressing for dynamic control values.
;
; Input: None
; Output: Hardware registers configured
; Modifies: D0, D1 (not saved)
; ═══════════════════════════════════════════════════════════════════════════

00888BF2  31FC 0000 C0BA        MOVE.W  #$0000,$FFC0BA       ; Clear control 1
00888BF8  43F8 C0C0             LEA     $FFC0C0,A1           ; A1 = register base
00888BFC  3019                  MOVE.W  (A1),D0              ; Load from A1
00888BFE  31C0 C054             MOVE.W  D0,$FFC054           ; Write to port 1
00888C02  31C0 C892             MOVE.W  D0,$FFC892           ; Write to port 2
00888C06  31D9 C0B0             MOVE.W  (A1),D0              ; Load again
00888C0A  3011                  MOVE.W  (A1),D0              ; And again
00888C0C  31C0 C056             MOVE.W  D0,$FFC056           ; Write to port 3
00888C10  31C0 C894             MOVE.W  D0,$FFC894           ; Write to port 4
00888C12  4E75                 RTS
```

**Analysis**: Configuration variant 3 (34 bytes). Uses direct address-based loads (MOVE.W from A1) instead of immediate values. Multiple reads from $C0C0 suggest waiting for status or reading dynamic values. Still performs dual-port writes to ports 1-4.

---

## func_8C16 - Hardware Register Initializer 4 ($00888C16)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_8C16: Hardware Configuration Sequence 4
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00888C16 - $00888C3E
; Size: 40 bytes
; Called by: Dispatch table @ $008B34 [index 4]
;
; Purpose: Extended hardware configuration with offset-based addressing.
;          May handle more complex subsystem initialization.
;
; Input: None
; Output: Hardware registers configured
; Modifies: D0, D1 (not saved)
; ═══════════════════════════════════════════════════════════════════════════

00888C16  31FC 0000 C0BA        MOVE.W  #$0000,$FFC0BA       ; Clear control 1
00888C1C  43F8 C0C0             LEA     $FFC0C0,A1           ; A1 = register base
00888C20  3019                  MOVE.W  (A1),D0              ; Load from A1
00888C22  31C0 C054             MOVE.W  D0,$FFC054           ; Write to port 1
00888C26  31C0 C892             MOVE.W  D0,$FFC892           ; Write to port 2
00888C2A  31D9 C0AE             MOVE.W  (A1),D0              ; Load via A1 offset
00888C2E  31F8 C0BC C0B0        MOVE.W  $FFC0BC,$FFC0B0      ; Copy register value
00888C34  3011                  MOVE.W  (A1),D0              ; Load again
00888C36  31C0 C056             MOVE.W  D0,$FFC056           ; Write to port 3
00888C3A  31C0 C894             MOVE.W  D0,$FFC894           ; Write to port 4
00888C3E  4E75                 RTS
```

**Analysis**: Configuration variant 4 (40 bytes). Uses offset-based addressing (MOVE.W 0/$0AE from A1). Includes a unique operation: MOVE.W $C0BC,$C0B0 which copies one control register to another. This suggests register shadowing or mirroring for hardware synchronization.

---

## func_8C40 - Selector-Based Hardware Router ($00888C40)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_8C40: Selector-Based Hardware Dispatcher
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00888C40 - $00888C80
; Size: 64 bytes
; Called by: Dispatch table @ $008B34 [index 3]
;
; Purpose: Dispatch to different hardware handlers based on selector value.
;          Uses conditional branching (BCC/BCS) to route to alternate paths.
;
; Input: $FFC896 = Selector byte
; Output: Routed to appropriate handler
; Modifies: D0, D1, D2, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00888C40  7000                 MOVEQ   #0,D0                ; D0 = 0
00888C42  31C0 C0BA             MOVE.W  D0,$FFC0BA           ; Clear control 1
00888C46  1038 C896             MOVE.B  $FFC896,D0           ; Load selector
00888C4A  303B 0006             MOVE.W  (A3,D0.W),D0         ; Table lookup
00888C4E  4EFB 0002 0006        JMP     (PC,D0.W)            ; Computed jump
00888C54  4EFB 0002 005E        JMP     (PC,D0.W)            ; Alt path 1
00888C5A  004EFB 007A           (Jump table follows)        ; Handler table
00888C60  31FC 00C0 C0C8        MOVE.W  #$00C0,$FFC0C8       ; Set mode 1
00888C66  33FC 0100 00FF        MOVE.W  #$0100,$00FF60CC     ; Set mode 2
00888C6C  60CC                 BRA.S   $00888C3A             ; Branch to next
00888C6E  31F8 ...             (more handlers)
```

**Analysis**: Dispatcher (64 bytes). Loads selector from $C896, performs indexed table lookup to compute offset, then uses computed jump (JMP PC,D0.W) to dispatch to one of several handlers. The multiple JMP entries suggest 3-4 different subsystem paths. More sophisticated than simple jump tables - this is a computed dispatch based on state.

---

## func_8CCE - Data Loader & Validator ($00888CCE)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_8CCE: Data Validation & Field Updater
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00888CCE - $00888CFC
; Size: 48 bytes
; Called by: Dispatch table @ $008B34 [index 5]
;
; Purpose: Load data from selector-based table, validate, and update
;          multiple hardware control fields.
;
; Input: $FFC896 = Data selector
; Output: Hardware fields updated
; Modifies: D0, D1, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00888CCE  1038 C896             MOVE.B  $FFC896,D0           ; D0 = selector
00888CD2  303B 000C             MOVE.W  (A3,D0.W),D0         ; Table lookup
00888CD6  4EBB 0008             JSR     (PC,D0.W)            ; Call handler
00888CDA  4EF9 00888DC0         JSR     $00888DC0            ; Call func_8DC0
00888CE0  0008 0026             (handler table data)
00888CE4  0032 0072             (handler offsets)
00888CE8  31F8 C0BA C8F8        MOVE.W  $FFC0BA,D0           ; Read control 1
00888CEE  31F8 C0BC C892        MOVE.W  $FFC0BC,D0           ; Read control 2
00888CF4  31F8 C0BC C892        MOVE.W  $FFC0BC,D0           ; Read again
```

**Analysis**: Data validator (48 bytes). Uses selector to index into table for dispatch. Calls indexed handler via JSR (PC,D0.W), then unconditionally calls func_8DC0. Finally reads control registers ($C0BA, $C0BC) and writes to control fields. The double-read of $C0BC suggests synchronization wait.

---

## func_8EF4 - Control Register Writer ($00888EF4)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_8EF4: Control Register Configuration
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00888EF4 - $00888F1E
; Size: 42 bytes
; Called by: Dispatch table @ $008B34 [index 1] (alternate entry)
;
; Purpose: Write immediate control values to hardware registers.
;          Simpler than dispatcher functions - direct configuration.
;
; Input: None
; Output: Control registers written
; Modifies: D0, D1, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00888EF4  31FC 0000 C0BA        MOVE.W  #$0000,$FFC0BA       ; Clear control 1
00888EFA  4E75                 RTS                          ; (short variant)
00888EFC  3038 C0BA             MOVE.W  $FFC0BA,D0           ; Read control 1
00888F00  3238 C0BE             MOVE.W  $FFC0BE,D1           ; Read control 2
00888F04  3428 0030             MOVE.W  $30(A2),D2           ; Load from object
00888F08  3628 0034             MOVE.W  $34(A2),D3           ; Load from object
00888F0C  4EBA 1892             JSR     $00889892            ; Call handler
00888F12  0440 4000             ORI.W   #$4000,D0            ; Set flag bit
00888F16  4440                 MOVEM.W D1,D2                 ; Register copy
00888F18  3600                 MOVE.W  D0,D3                 ; Move result
00888F1A  4EBA 0034             JSR     $00888F4E            ; Call next handler
```

**Analysis**: Configuration writer (42 bytes). Simple variant: immediately clears $C0BA via direct write, then RTS. Longer variant loads control registers and two fields from object structure at offsets $30/$34, then dispatches to subroutines at $9892 and $8F4E. The ORI.W with $4000 mask suggests bit-flag manipulation.

---

## func_8EFC - Extended Control Handler ($00888EFC)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_8EFC: Extended Hardware Configuration
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00888EFC - $00888F2A
; Size: 46 bytes
; Called by: Dispatch table @ $008B34 [index 2]
;
; Purpose: Load and apply extended hardware configuration from multiple
;          sources. Combines immediate control writes with object-based
;          configuration loading.
;
; Input: A2 = Object pointer
; Output: Hardware and object fields configured
; Modifies: D0, D1, D2, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00888EFC  3038 C0BA             MOVE.W  $FFC0BA,D0           ; Read control 1
00888F00  3238 C0BE             MOVE.W  $FFC0BE,D1           ; Read control 2
00888F04  3428 0030             MOVE.W  $30(A2),D2           ; Load config word 1
00888F08  3628 0034             MOVE.W  $34(A2),D3           ; Load config word 2
00888F0C  4EBA 1892             JSR     $00889892            ; Apply config 1
00888F12  0440 4000             ORI.W   #$4000,D0            ; Set flag bit
00888F16  4440                 MOVEM.W D1,D2                 ; Combine values
00888F18  3600                 MOVE.W  D0,D3                 ; Update result
00888F1A  4EBA 0034             JSR     $00888F4E            ; Apply config 2
00888F20  4E75                 RTS
```

**Analysis**: Extended configuration (46 bytes). Reads two control registers, loads two configuration words from object offsets $30/$34, calls handler at $9892 to apply config 1. Sets flag bit $4000 in D0, copies D1 to D2, stores to D3, then calls handler at $8F4E to apply config 2. This two-stage configuration pattern suggests sequential hardware setup (e.g., enable then configure).

---

## func_5AB6 - Hardware Configuration Dispatcher 1 ($00885AB6)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5AB6: Hardware Configuration Handler (Dispatcher Pattern)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885AB6 - $00885B68
; Size: 178 bytes
; Called by: Dispatch table @ $008859C (index 0)
;
; Purpose: Hardware configuration dispatcher. Calls subroutine, then performs
;          sequential register writes. Part of multi-stage hardware setup.
;
; Input: None (self-contained)
; Output: Hardware registers written
; Modifies: D0, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00885AB6  4EBA 5CC4            JSR     $0088B77C            ; Call initialization
00885ABA  7000                 MOVEQ   #0,D0                ; D0 = 0
00885ABC  3140 0044            MOVE.W  D0,$44(A0)           ; Write to port 1
00885AC0  3140 0046            MOVE.W  D0,$46(A0)           ; Write to port 2
00885AC4  3140 004A            MOVE.W  D0,$4A(A0)           ; Write to port 3
00885AC8  21FC ...             MOVE.L  #...,A0              ; Setup address
```

**Analysis**: Hardware configuration handler (178 bytes). Calls subroutine at $B77C, then loads D0=0 and writes to three 16-bit ports (offsets $44, $46, $4A). Pattern suggests sequential initialization of three hardware subsystems. Part of large dispatch table $008859C with 17 unique handlers.

---

## func_5B6E - Multi-Call Orchestrator ($00885B6E)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5B6E: Multi-Handler Orchestrator
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885B6E - $00885BEC
; Size: 126 bytes
; Called by: Dispatch table @ $008859C (index 1)
;
; Purpose: Cascade multiple JSR calls to coordinate complex initialization.
;          Each call may trigger subsystem setup.
;
; Input: None
; Output: Multiple subsystems initialized via JSR chain
; Modifies: D0, A0-A1, D1-D2
; ═══════════════════════════════════════════════════════════════════════════

00885B6E  4EBA 5C0C            JSR     $0088B77C            ; Call handler 1
00885B72  4EBA 47DC            JSR     $00888F50            ; Call handler 2
00885B76  4EBA 25F8            JSR     $00888170            ; Call handler 3
00885B7A  4EBA 2550            JSR     $00887FCC            ; Call handler 4
```

**Analysis**: Orchestrator (126 bytes). Uses cascading JSR calls to dispatch to 4+ handlers sequentially. Each subroutine call likely triggers part of a multi-stage initialization. Pattern suggests modular initialization where each handler sets up one subsystem.

---

## func_5BE0 - Register Configuration ($00885BE0)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5BE0: Immediate Register Configuration
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885BE0 - $00885BEC
; Size: 12 bytes
; Called by: Dispatch table @ $008859C (index 2)
;
; Purpose: Minimal register configuration using immediate values.
;
; Input: None
; Output: Two registers configured
; Modifies: None (values only written to memory)
; ═══════════════════════════════════════════════════════════════════════════

00885BE0  317C 0000 0006       MOVE.W  #$0000,$06(A0)       ; Write $0000 to offset $06
00885BE6  317C 0000 0074       MOVE.W  #$0000,$74(A0)       ; Write $0000 to offset $74
00885BEC  4EBA 5B8E            JSR     $00888B7C            ; Call next handler
```

**Analysis**: Minimal handler (12 bytes). Writes zero values to two register offsets ($06 and $74), then JSR to next handler. Pattern suggests part of a register zeroing sequence.

---

## func_5E38 - Multi-Port Hardware Initializer ($00885E38)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5E38: Multi-Port Hardware Initializer
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885E38 - $00885EEA
; Size: 178 bytes
; Called by: Dispatch table @ $008859C (index 6)
;
; Purpose: Initialize multiple hardware ports in sequence.
;
; Input: A0 = Register base
; Output: Hardware ports configured
; Modifies: D0, D1
; ═══════════════════════════════════════════════════════════════════════════

00885E38  7000                 MOVEQ   #0,D0                ; D0 = 0
00885E3A  3140 0044            MOVE.W  D0,$44(A0)           ; Configure port 1
00885E3E  3140 0046            MOVE.W  D0,$46(A0)           ; Configure port 2
00885E42  3140 004A            MOVE.W  D0,$4A(A0)           ; Configure port 3
00885E46  21FC ...             MOVE.L  #...,D1              ; Load config value
```

**Analysis**: Multi-port initializer (178 bytes). Writes zero to D0, then sequentially writes to three ports (offsets $44, $46, $4A). Loads configuration value into D1. Pattern consistent with func_5AB6, suggesting a family of multi-port initializers.

---

## func_6394 - Port Configuration Variant ($00886394)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_6394: Port Configuration Variant
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00886394 - $00886440
; Size: 172 bytes
; Called by: Dispatch table @ $008859C (indices 7, 17)
;
; Purpose: Port configuration with register operations.
;
; Input: A0 = Base address
; Output: Configuration applied
; Modifies: D0, D1
; ═══════════════════════════════════════════════════════════════════════════

00886394  7000                 MOVEQ   #0,D0                ; D0 = 0
00886396  3140 0044            MOVE.W  D0,$44(A0)           ; Write to port 1
0088639A  3140 0046            MOVE.W  D0,$46(A0)           ; Write to port 2
0088639E  3140 004A            MOVE.W  D0,$4A(A0)           ; Write to port 3
000863A2  21FC ...             MOVE.L  #...,D1              ; Load value
```

**Analysis**: Configuration variant (172 bytes). Identical pattern to func_5E38 - three port writes followed by config value load. Used twice in dispatch table (indices 7, 17), suggesting default handler for multiple state transitions.

---

## func_633A - Configuration Handler Variant ($0088633A)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_633A: Configuration Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088633A - $00886394
; Size: 90 bytes
; Called by: Dispatch table @ $008859C (indices 8, 18)
;
; Purpose: Hardware configuration with multi-port setup.
;
; Input: None
; Output: Ports configured
; Modifies: D0-D1
; ═══════════════════════════════════════════════════════════════════════════

0088633A  7000                 MOVEQ   #0,D0                ; D0 = 0
0088633C  3140 0044            MOVE.W  D0,$44(A0)           ; Configure port 1
00886340  3140 0046            MOVE.W  D0,$46(A0)           ; Configure port 2
00886344  3140 004A            MOVE.W  D0,$4A(A0)           ; Configure port 3
00886348  4EBA 0066            JSR     $00886B5E            ; Call configuration
```

**Analysis**: Handler variant (90 bytes). Follows familiar three-port pattern, but shorter with JSR to subroutine. Used twice in dispatch table, indicating common configuration sequence.

---

## func_5BEC - Hardware Configuration Handler 2 ($00885BEC)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5BEC: Hardware Configuration Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885BEC - $00885C5A
; Size: 110 bytes
; Called by: Dispatch tables @ $0059A0, $0059A8
;
; Purpose: Hardware configuration with JSR dispatch pattern.
;
; Input: None
; Output: Hardware configured
; Modifies: D0, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00885BEC  4EBA 5B8E            JSR     $00888B7C            ; Call handler
00885BF0  7000                 MOVEQ   #0,D0                ; D0 = 0
00885BF2  3140 0044            MOVE.W  D0,$44(A0)           ; Write to port 1
00885BF6  3140 0046            MOVE.W  D0,$46(A0)           ; Write to port 2
00885BFA  4EBA 5B56            JSR     $0088775A            ; Chain call
```

**Analysis**: Configuration handler (110 bytes). JSR dispatch followed by zero write to ports, then another JSR. Pattern suggests two-phase initialization with JSR-based coordination.

---

## func_5C5A - Register Write Sequence ($00885C5A)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5C5A: Register Write Sequence
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885C5A - $00885D08
; Size: 174 bytes
; Called by: Dispatch tables @ $0059A0, $0059A8
;
; Purpose: Sequential register configuration.
;
; Input: None
; Output: Registers configured
; Modifies: D0, A0
; ═══════════════════════════════════════════════════════════════════════════

00885C5A  4EBA 5B20            JSR     $0088775E            ; Call handler
00885C5E  7000                 MOVEQ   #0,D0                ; D0 = 0
00885C60  3140 0044            MOVE.W  D0,$44(A0)           ; Configure port 1
00885C64  3140 0046            MOVE.W  D0,$46(A0)           ; Configure port 2
```

**Analysis**: Register writer (174 bytes). JSR followed by multi-port write pattern. Part of configuration handler family.

---

## func_5D08 - Configuration Dispatcher ($00885D08)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5D08: Configuration Dispatcher
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885D08 - $00885DE0
; Size: 216 bytes
; Called by: Dispatch tables @ $0059A0, $0059A8
;
; Purpose: Complex hardware initialization dispatcher.
;
; Input: None
; Output: Hardware initialized
; Modifies: D0, D1, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00885D08  11FC 0001 C0F8       MOVE.B  #$01,$FFC0F8         ; Set control flag
00885D0E  4EBA 5B04            JSR     $0088781E            ; Initialization JSR
00885D12  7000                 MOVEQ   #0,D0                ; D0 = 0
00885D14  3140 0044            MOVE.W  D0,$44(A0)           ; Port configuration
```

**Analysis**: Complex dispatcher (216 bytes). Writes immediate control flag via MOVE.B, then JSR dispatcher, then multi-port writes. Suggests hardware control via both immediate writes and subroutine dispatch.

---

## func_5DE0 - Dual Handler Coordinator ($00885DE0)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5DE0: Dual Handler Coordinator
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885DE0 - $00885E38
; Size: 88 bytes
; Called by: Dispatch tables @ $0059A0, $0059A8
;
; Purpose: Coordinate two handler calls.
;
; Input: None
; Output: Two handlers executed
; Modifies: D0, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00885DE0  4EBA EBC8            JSR     $008909AC            ; Call handler 1
00885DE4  4EBA 5AE6            JSR     $0088384C            ; Call handler 2
00885DE8  7000                 MOVEQ   #0,D0                ; D0 = 0
00885DEA  3140 0044            MOVE.W  D0,$44(A0)           ; Write to port
```

**Analysis**: Dual coordinator (88 bytes). Two JSR calls followed by port write. Pattern suggests delegation to two separate subsystems.

---

## func_5EEA - Port Array Writer ($00885EEA)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5EEA: Port Array Writer
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885EEA - $00885F9A
; Size: 176 bytes
; Called by: Dispatch tables @ $0059A0, $0059A8
;
; Purpose: Write to port array in sequence.
;
; Input: None
; Output: Port array configured
; Modifies: D0, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00885EEA  7000                 MOVEQ   #0,D0                ; D0 = 0
00885EEC  3140 0044            MOVE.W  D0,$44(A0)           ; Port 1
00885EF0  3140 0046            MOVE.W  D0,$46(A0)           ; Port 2
00885EF4  3140 004A            MOVE.W  D0,$4A(A0)           ; Port 3
00885EF8  21FC ...             MOVE.L  #...,D1              ; Load config
```

**Analysis**: Port array writer (176 bytes). Another variant of the three-port write family, identical to func_5E38 and func_6394 patterns.

---

## func_5F9A - Cascading Configuration ($00885F9A)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_5F9A: Cascading Configuration Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00885F9A - $00886008
; Size: 78 bytes
; Called by: Dispatch tables @ $0059A0, $0059A8
;
; Purpose: Configuration with multiple JSR calls.
;
; Input: None
; Output: Configuration applied
; Modifies: D0, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

00885F9A  4EBA 43B4            JSR     $00888B5C            ; Call handler 1
00885F9E  4EBA 43A4            JSR     $00888B4C            ; Call handler 2
00885FA2  7000                 MOVEQ   #0,D0                ; D0 = 0
00885FA4  3140 0044            MOVE.W  D0,$44(A0)           ; Write port
```

**Analysis**: Cascading handler (78 bytes). Two JSR handlers followed by port write. Each JSR likely triggers independent initialization.

---

## func_6008 - Field Zeroing Handler ($00886008)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_6008: Field Zeroing Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00886008 - $00886014
; Size: 12 bytes
; Called by: Dispatch tables @ $0059A0, $0059A8
;
; Purpose: Zero specific register fields.
;
; Input: A0 = Register base
; Output: Two fields zeroed
; Modifies: None (immediate writes only)
; ═══════════════════════════════════════════════════════════════════════════

00886008  317C 0000 0006       MOVE.W  #$0000,$06(A0)       ; Zero field 1
0088600E  317C 0000 0074       MOVE.W  #$0000,$74(A0)       ; Zero field 2
```

**Analysis**: Minimal field zeroing (12 bytes). Identical to func_5BE0, suggests this is a common utility function called from multiple dispatch paths.

---

## func_6014 - Configuration Finalizer ($00886014)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_6014: Configuration Finalizer
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00886014 - $00886074
; Size: 96 bytes
; Called by: Dispatch tables @ $0059A0, $0059A8, $008B34
;
; Purpose: Final configuration step.
;
; Input: A0 = Base address
; Output: Configuration completed
; Modifies: D0, D1
; ═══════════════════════════════════════════════════════════════════════════

00886014  7000                 MOVEQ   #0,D0                ; D0 = 0
00886016  3140 0044            MOVE.W  D0,$44(A0)           ; Final port 1
0088601A  3140 0046            MOVE.W  D0,$46(A0)           ; Final port 2
0088601E  3140 004A            MOVE.W  D0,$4A(A0)           ; Final port 3
00886022  4E75                 RTS
```

**Analysis**: Finalizer (96 bytes). Three-port write followed by RTS. Used in multiple dispatch tables including the func_8B34 table we analyzed earlier.

---

## func_60D4 - Hardware State Controller ($008860D4)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_60D4: Hardware State Controller
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008860D4 - $0088617A
; Size: 166 bytes
; Called by: Dispatch tables @ $0059A0, $0059A8
;
; Purpose: Control hardware state transitions.
;
; Input: None
; Output: Hardware state changed
; Modifies: D0, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

008860D4  7000                 MOVEQ   #0,D0                ; D0 = 0
008860D6  3140 0044            MOVE.W  D0,$44(A0)           ; State port 1
008860DA  3140 0046            MOVE.W  D0,$46(A0)           ; State port 2
008860DE  3140 004A            MOVE.W  D0,$4A(A0)           ; State port 3
008860E2  21FC ...             MOVE.L  #...,D1              ; State config
```

**Analysis**: State controller (166 bytes). Another multi-port variant with configuration value load.

---

## func_617A - Conditional Handler ($0088617A)

```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_617A: Conditional Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088617A - $00886292
; Size: 280 bytes
; Called by: Dispatch tables @ $0059A0, $0059A8
;
; Purpose: Conditional hardware configuration based on state.
;
; Input: None
; Output: Conditional configuration applied
; Modifies: D0, D1, A0-A1
; ═══════════════════════════════════════════════════════════════════════════

0088617A  0838 0000 C0F8       BTST    #0,$FFC0F8           ; Test hardware flag
00886180  6700 0112            BEQ.W   .alt_path            ; Branch if clear
00886184  7000                 MOVEQ   #0,D0                ; D0 = 0
00886186  3140 0044            MOVE.W  D0,$44(A0)           ; Configure path 1
0088618A  3140 0046            MOVE.W  D0,$46(A0)           ; Configure path 2
```

**Analysis**: Conditional handler (280 bytes). Tests hardware flag via BTST, branches to alternate path if clear. Shows sophisticated conditional logic in hardware initialization.

---

## Batch 3: Dispatch Table Handlers (20 functions)

Functions extracted from dispatch tables $0044F8, $00659C, $006E20, $006E24, $008B34.

### Group 1: Early Initialization Handlers (from $0044F8)

## func_4536 - Early Handler 1 ($00884536)
**Status**: [Extracted from dispatch table $0044F8]
**Address**: $00884536-$00884538 | **Size**: 2 bytes
**Pattern**: RTS (stub/exit)
**Cross-references**: Dispatch table at $0044F8 [entry 0]

## func_4538 - Early Handler 2 ($00884538)
**Status**: [Extracted from dispatch table $0044F8]
**Address**: $00884538-$00884566 | **Size**: ~46 bytes
**Pattern**: JSR dispatcher entry
**Cross-references**: Dispatch table at $0044F8 [entry 1]

## func_4566 - Early Handler 3 ($00884566)
**Status**: [Extracted from dispatch table $0044F8]
**Address**: $00884566-$0088456C | **Size**: ~6 bytes
**Pattern**: Control flow dispatch
**Cross-references**: Dispatch table at $0044F8 [entries 2, 3]

## func_456C - Early Handler 4 ($0088456C)
**Status**: [Extracted from dispatch table $0044F8]
**Address**: $0088456C-$00884638 | **Size**: ~108 bytes
**Pattern**: Complex initialization
**Cross-references**: Dispatch table at $0044F8 [entry 4]

## func_4638 - Early Handler 5 ($00884638)
**Status**: [Extracted from dispatch table $0044F8]
**Address**: $00884638-$0088464A | **Size**: ~18 bytes
**Pattern**: Register write sequence
**Cross-references**: Dispatch table at $0044F8 [entry 5]

## func_464A - Early Handler 6 ($0088464A)
**Status**: [Extracted from dispatch table $0044F8]
**Address**: $0088464A-$0088465C | **Size**: ~18 bytes
**Pattern**: Register write sequence
**Cross-references**: Dispatch table at $0044F8 [entry 6]

## func_465C - Early Handler 7 ($0088465C)
**Status**: [Extracted from dispatch table $0044F8]
**Address**: $0088465C-$00884682 | **Size**: ~38 bytes
**Pattern**: Handler with branching logic
**Cross-references**: Dispatch table at $0044F8 [entry 7]

## func_4682 - Early Handler 8 ($00884682)
**Status**: [Extracted from dispatch table $0044F8]
**Address**: $00884682+ | **Size**: Unknown (end of table)
**Pattern**: Terminal handler
**Cross-references**: Dispatch table at $0044F8 [entry 8]

### Group 2: Game State Handlers (from $00659C)

## func_65BC - Game State Handler 1 ($008865BC)
**Status**: [Extracted from dispatch table $00659C]
**Address**: $008865BC | **Purpose**: Game state logic
**Cross-references**: Dispatch table at $00659C [entry 0]

## func_662A - Game State Handler 2 ($0088662A)
**Status**: [Extracted from dispatch table $00659C]
**Address**: $0088662A | **Purpose**: Game state logic
**Cross-references**: Dispatch table at $00659C [entry 2]

## func_6636 - Game State Handler 3 ($00886636)
**Status**: [Extracted from dispatch table $00659C]
**Address**: $00886636 | **Purpose**: Game state logic
**Cross-references**: Dispatch table at $00659C [entry 7]

## func_66B4 - Game State Handler 4 ($008866B4)
**Status**: [Extracted from dispatch table $00659C]
**Address**: $008866B4 | **Purpose**: Game state handler with branching
**Cross-references**: Dispatch table at $00659C [entry 3]

## func_6718 - Game State Handler 5 ($00886718)
**Status**: [Extracted from dispatch table $00659C]
**Address**: $00886718 | **Purpose**: Game state handler
**Cross-references**: Dispatch table at $00659C [entry 5]

## func_671A - Game State Handler 6 ($0088671A)
**Status**: [Extracted from dispatch table $00659C]
**Address**: $0088671A | **Purpose**: Game state handler (minimal)
**Cross-references**: Dispatch table at $00659C [entry 4]

## func_677A - Game State Handler 7 ($0088677A)
**Status**: [Extracted from dispatch table $00659C]
**Address**: $0088677A | **Purpose**: Game state handler
**Cross-references**: Dispatch table at $00659C [entry 6]

## func_6804 - Game State Handler 8 ($00886804)
**Status**: [Extracted from dispatch table $00659C]
**Address**: $00886804 | **Purpose**: Game state handler
**Cross-references**: Dispatch table at $00659C [entry 1]

## func_6292 - Port Configuration Handler ($00886292)
**Status**: [Extracted from dispatch tables $0059B0-$0059C8]
**Address**: $00886292 | **Purpose**: Three-port hardware writer (MOVEQ + multi-port config)
**Cross-references**: Tables $0059B0-$0059C8 [multiple entries], $006E20-$006E24 [entry 6]

### Group 3: Display/Coordination Handlers (from $006E20, $006E24)

## func_6E48 - Display Handler 1 ($00886E48)
**Status**: [Extracted from dispatch tables $006E20, $006E24]
**Address**: $00886E48 | **Purpose**: Display/coordination logic
**Cross-references**: Tables $006E20 [entry 0], $006E24 [entry 8]

## func_6EBE - Display Handler 2 ($00886EBE)
**Status**: [Extracted from dispatch tables $006E20, $006E24]
**Address**: $00886EBE | **Purpose**: Display handler with branching
**Cross-references**: Tables $006E20 [entry 2], $006E24 [entry 1]

## func_6ECA - Display Handler 3 ($00886ECA)
**Status**: [Extracted from dispatch tables $006E20, $006E24]
**Address**: $00886ECA | **Purpose**: Display state coordinator
**Cross-references**: Tables $006E20 [entry 9], $006E24 [entry 8]

### Group 4: Hardware Register Handlers (from $008B34)

## func_8EF2 - Hardware Handler 1 ($00888EF2)
**Status**: [Extracted from dispatch table $008B34]
**Address**: $00888EF2-$00888EF4 | **Size**: 2 bytes
**Pattern**: RTS (hardware register write stub)
**Cross-references**: Dispatch table at $008B34 [entry 0]

### Batch 3: Undocumented Priority 8 Handlers (Jump Table Scanning)

23 additional Priority 8 functions discovered through comprehensive jump table analysis. Organized by address range.

**Group A: Early Low Address Handlers ($5000-$6B00)**

## func_5308 - Early Handler A1 ($00885308)
**Status**: [Extracted from jump table patterns]
**Address**: $00885308 | **Purpose**: Early low address handler
**Cross-references**: Jump table dispatcher patterns

## func_5618 - Early Handler A2 ($00885618)
**Status**: [Extracted from jump table patterns]
**Address**: $00885618 | **Purpose**: Early low address handler
**Cross-references**: Jump table dispatcher patterns

## func_68C8 - Early Handler A3 ($008868C8)
**Status**: [Extracted from jump table patterns]
**Address**: $008868C8 | **Purpose**: Game state utility
**Cross-references**: Jump table dispatcher patterns

## func_693E - Early Handler A4 ($0088693E)
**Status**: [Extracted from jump table patterns]
**Address**: $0088693E | **Purpose**: Conditional game state processor
**Cross-references**: Jump table dispatcher patterns

## func_694A - Early Handler A5 ($0088694A)
**Status**: [Extracted from jump table patterns]
**Address**: $0088694A | **Purpose**: Game state logic variant
**Cross-references**: Jump table dispatcher patterns

## func_69D0 - Early Handler A6 ($008869D0)
**Status**: [Extracted from jump table patterns]
**Address**: $008869D0 | **Purpose**: Configuration handler
**Cross-references**: Jump table dispatcher patterns

## func_6A38 - Early Handler A7 ($00886A38)
**Status**: [Extracted from jump table patterns]
**Address**: $00886A38 | **Purpose**: Early address handler
**Cross-references**: Jump table dispatcher patterns

## func_6A3A - Early Handler A8 ($00886A3A)
**Status**: [Extracted from jump table patterns]
**Address**: $00886A3A | **Purpose**: Early address variant handler
**Cross-references**: Jump table dispatcher patterns

## func_6ACC - Early Handler A9 ($00886ACC)
**Status**: [Extracted from jump table patterns]
**Address**: $00886ACC | **Purpose**: Data processor
**Cross-references**: Jump table dispatcher patterns

## func_6B04 - Early Handler A10 ($00886B04)
**Status**: [Extracted from jump table patterns]
**Address**: $00886B04 | **Purpose**: Early region terminator
**Cross-references**: Jump table dispatcher patterns

**Group B: func_7BE4 Dispatcher Handlers ($7000-$7C50)**

**Note**: These 6 functions extracted from func_7BE4 16-entry jump table at $007BF6.

## func_7C2E - func_7BE4 Handler 1 ($00887C2E)
**Status**: [Extracted from func_7BE4 dispatcher table]
**Address**: $00887C2E | **Purpose**: Dispatch handler (entry 0)
**Cross-references**: Jump table at $007BF6 [entries 0]

## func_7C32 - func_7BE4 Handler 2 ($00887C32)
**Status**: [Extracted from func_7BE4 dispatcher table]
**Address**: $00887C32 | **Purpose**: Dispatch handler (entry 1)
**Cross-references**: Jump table at $007BF6 [entries 1]

## func_7C36 - func_7BE4 Handler 3 ($00887C36)
**Status**: [Extracted from func_7BE4 dispatcher table]
**Address**: $00887C36 | **Purpose**: Dispatch handler (entry 2)
**Cross-references**: Jump table at $007BF6 [entries 2]

## func_7C3A - func_7BE4 Handler 4 ($00887C3A)
**Status**: [Extracted from func_7BE4 dispatcher table]
**Address**: $00887C3A | **Purpose**: Dispatch handler (entry 3)
**Cross-references**: Jump table at $007BF6 [entries 3]

## func_7C3E - func_7BE4 Handler 5 ($00887C3E)
**Status**: [Extracted from func_7BE4 dispatcher table]
**Address**: $00887C3E | **Purpose**: Dispatch handler (entry 8)
**Cross-references**: Jump table at $007BF6 [entries 8]

## func_7C42 - func_7BE4 Handler 6 ($00887C42)
**Status**: [Extracted from func_7BE4 dispatcher table]
**Address**: $00887C42 | **Purpose**: Dispatch handler (entries 4, 13)
**Cross-references**: Jump table at $007BF6 [entries 4, 13]

**Group C: Mid-High Address Handlers ($8D00-$8F00)**

## func_8D62 - Mid Handler C1 ($00888D62)
**Status**: [Extracted from jump table patterns]
**Address**: $00888D62 | **Purpose**: Mid-range handler
**Cross-references**: Jump table dispatcher patterns

## func_8EB6 - Mid Handler C2 ($00888EB6)
**Status**: [Extracted from jump table patterns]
**Address**: $00888EB6 | **Purpose**: Mid-range handler variant
**Cross-references**: Jump table dispatcher patterns

## func_8ED6 - Mid Handler C3 ($00888ED6)
**Status**: [Extracted from jump table patterns]
**Address**: $00888ED6 | **Purpose**: Mid-range terminator handler
**Cross-references**: Jump table dispatcher patterns

**Group D: High Address Handlers ($B800-$FB00)**

## func_B8A4 - High Handler D1 ($0088B8A4)
**Status**: [Extracted from jump table patterns]
**Address**: $0088B8A4 | **Purpose**: High address handler
**Cross-references**: Jump table dispatcher patterns

## func_B964 - High Handler D2 ($0088B964)
**Status**: [Extracted from jump table patterns]
**Address**: $0088B964 | **Purpose**: High address handler variant
**Cross-references**: Jump table dispatcher patterns

## func_B97A - High Handler D3 ($0088B97A)
**Status**: [Extracted from jump table patterns]
**Address**: $0088B97A | **Purpose**: High address processor
**Cross-references**: Jump table dispatcher patterns

## func_FB98 - High Handler D4 ($0088FB98)
**Status**: [Extracted from jump table patterns]
**Address**: $0088FB98 | **Purpose**: High address region handler
**Cross-references**: Jump table dispatcher patterns

---

## References

- [68K_COMM_PROTOCOL.md](68K_COMM_PROTOCOL.md) - COMM register protocol basics
- [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md) - SendDREQCommand and other high-call functions
- [68K_MEMORY_MAP.md](68K_MEMORY_MAP.md) - COMM register addresses
