# SuperH RISC Engine SH-1/SH-2 Programming Manual

**Hitachi America Ltd.**
**Published:** September 3, 1996

---

## Notice

When using this document, keep the following in mind:

1. This document may, wholly or partially, be subject to change without notice.

2. All rights are reserved: No one is permitted to reproduce or duplicate, in any form, the whole or part of this document without Hitachi's permission.

3. Hitachi will not be held responsible for any damage to the user that may result from accidents or any other reasons during operation of the user's unit according to this document.

4. Circuitry and other examples described herein are meant merely to indicate the characteristics and performance of Hitachi's semiconductor products. Hitachi assumes no responsibility for any intellectual property claims or other problems that may result from applications based on the examples described herein.

5. No license is granted by implication or otherwise under any patents or other rights of any third party or Hitachi, Ltd.

6. MEDICAL APPLICATIONS: Hitachi's products are not authorized for use in MEDICAL APPLICATIONS without the written consent of the appropriate officer of Hitachi's sales company. Such use includes, but is not limited to, use in life support systems. Buyers of Hitachi's products are requested to notify the relevant Hitachi sales offices when planning to use the products in MEDICAL APPLICATIONS.

---

## Introduction

The SuperH RISC engine family incorporates a RISC (Reduced Instruction Set Computer) type CPU. A basic instruction can be executed in one clock cycle, realizing high performance operation. A built-in multiplier can execute multiplication and addition as quickly as DSP.

The SuperH RISC engine has SH-1 CPU, SH-2 CPU, and SH-3 CPU cores.

The SH-1 CPU, SH-2 CPU and SH-3 CPU have an instruction system with upward compatibility at the binary level.

```
┌─────────────────────────────────────────────────────────────┐
│                                                             │
│  SH-3 CPU                              MMU support:        │
│                                        68 instructions      │
│  SH-2 CPU              Operation instruction               │
│                        enhancement:                         │
│  SH-1 CPU              62 instructions                     │
│  56 basic instructions                                      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

Refer to the programming manual for the method of executing the instructions or for the architecture. You can also refer to this programming manual to know the operation of the pipe line, which is one of the features of the RISC CPU.

This programming manual describes in detail the instructions for the SH-1 CPU and SH-2 CPU instructions. For the SH-3 CPU, refer to the separate volume of SH-3 CPU programming manual.

For the hardware, refer to individual hardware manuals for each unit.

---

## Organization of This Manual

Table 1 describes how this manual is organized. Table 2 lists the relationships between the items and the sections listed within this manual that cover those items.

### Table 1: Manual Organization

| Category | Section Title | Contents |
|----------|--------------|----------|
| Introduction | 1. Features | CPU features |
| Architecture (1) | 2. Register Configuration | Types and configuration of general registers, control registers and system registers |
| | 3. Data Formats | Data formats for registers and memory |
| Introduction to instructions | 4. Instruction Features | Instruction features, addressing modes, and instruction formats |
| | 5. Instruction Sets | Summary of instructions by category and list in alphabetic order |
| Detailed information on instructions | 6. Instruction Descriptions | Operation of each instruction in alphabetical order |
| Architecture (2) | 7. Pipeline Operation | Pipeline flow, and pipeline flows with operation for each instruction |
| Instruction code | Appendixes: Instruction Code | Operation code map |

---

### Table 2: Subjects and Corresponding Sections

| Category | Topic | Section Title |
|----------|-------|---------------|
| Introduction and features | CPU features | 1. Features |
| | Instruction features | 4.1 RISC-Type Instruction Set |
| | Pipelines | 7.1 Basic Configuration of Pipelines |
| | | 7.2 Slot and Pipeline Flow |
| Architecture | Register configuration | 2. Register Configuration |
| | Data formats | 3. Data Formats |
| | Pipeline operation | 7. Pipeline Operation |
| Introduction to instructions | Instruction features | 4. Instruction Features |
| | Addressing modes | 4.2 Addressing Modes |
| | Instruction formats | 4.3 Instruction Formats |
| List of instructions | Instruction sets | 5.1 Instruction Set by Classification |
| | | 5.2 Instruction Set in Alphabetical Order |
| | | Appendix A.1 Instruction Set by Addressing Mode |
| | | Appendix A.2 Instruction Set by Instruction Format |
| | Instruction code | Appendix A.3 Instruction Set in Order by Instruction Code |
| | | Appendix A.4 Operation Code Map |
| Detailed information on instructions | Detailed information on instruction operation | 6. Instruction Description |
| | | 7.7 Instruction Pipeline Operations |
| | Number of instruction execution states | 7.3 Number of Instruction Execution States |

---

## Functions Listed by CPU Type

This manual is common for both the SH-1 and SH-2 CPU. However, not all CPUs can use all the instructions and functions. Table 3 lists the usable functions by CPU type.

### Table 3: Functions by CPU Type

| Item | | SH-1 CPU | SH-2 CPU |
|------|----------|----------|----------|
| Instructions | BF/S | No | Yes |
| | BRAF | No | Yes |
| | BSRF | No | Yes |
| | BT/S | No | Yes |
| | DMULS.L | No | Yes |
| | DMULU.L | No | Yes |
| | DT | No | Yes |
| | MAC.L | No | Yes |
| | MAC.W*¹ (MAC)*² | 16 x 16 + 42 → 42 | 16 x 16 + 64 → 64 |
| | MUL.L | No | Yes |
| | All others | Yes | Yes |
| States for multiplication operation | 16 x 16 → 32 (MULS.W, MULU.W)*² | Executed in 1–3*³ states | Executed in 1–3*³ states |
| | 32 x 32 → 32 (MUL.L) | No | Executed in 2–4 *³ states |
| | 32 x 32 → 64 (DMULS.L, DMULU.L) | No | Executed in 2–4 *³ states |
| States for multiply and accumulate operation | 16 x 16 + 42 → 42 (SH-1, MAC.W) | Executed in 3/(2)*³ states | No |
| | 16 x 16 + 64 → 64 (SH-2, MAC.W) | No | Executed in states 3/(2)*³ |
| | 32 x 32 + 64 → 64 (MAC.L) | No | Executed in 2–4 states 3/(2–4)*³ |

**Notes:**
1. MAC.W works differently on different LSIs.
2. MAC and MAC.W are the same. MULS is also the same as MULS.W and MULU the same as MULU.W.
3. The normal minimum number of execution cycles (The number in parentheses in the number in contention with preceding/following instructions).

---

## Contents

### Section 1: Features ........................................................................................................................ 14

### Section 2: Register Configuration.......................................................................................................... 16
- 2.1 General Registers............................................................................................................................................. 16
- 2.2 Control Registers............................................................................................................................................. 16
- 2.3 System Registers.............................................................................................................................................. 19
- 2.4 Initial Values of Registers............................................................................................................................. 19

### Section 3: Data Formats............................................................................................................................... 21
- 3.1 Data Format in Registers............................................................................................................................... 21
- 3.2 Data Format in Memory................................................................................................................................. 21
- 3.3 Immediate Data Format.................................................................................................................................. 22

### Section 4: Instruction Features................................................................................................................. 23
- 4.1 RISC-Type Instruction Set............................................................................................................................ 23
  - 4.1.1 16-Bit Fixed Length....................................................................................................................... 23
  - 4.1.2 One Instruction/Cycle.................................................................................................................... 23
  - 4.1.3 Data Length...................................................................................................................................... 23
  - 4.1.4 Load-Store Architecture................................................................................................................. 23
  - 4.1.5 Delayed Branch Instructions......................................................................................................... 23
  - 4.1.6 Multiplication/Accumulation Operation................................................................................ 24
  - 4.1.7 T Bit................................................................................................................................................... 24
  - 4.1.8 Immediate Data................................................................................................................................ 25
  - 4.1.9 Absolute Address............................................................................................................................. 25
  - 4.1.10 16-Bit/32-Bit Displacement......................................................................................................... 25
- 4.2 Addressing Modes............................................................................................................................................ 26
- 4.3 Instruction Format............................................................................................................................................ 29

### Section 5: Instruction Set............................................................................................................................. 34
- 5.1 Instruction Set by Classification.................................................................................................................. 34
  - 5.1.1 Data Transfer Instructions............................................................................................................. 39
  - 5.1.2 Arithmetic Instructions.................................................................................................................. 42
  - 5.1.3 Logic Operation Instructions........................................................................................................ 44
  - 5.1.4 Shift Instructions............................................................................................................................. 45
  - 5.1.5 Branch Instructions......................................................................................................................... 46
  - 5.1.6 System Control Instructions......................................................................................................... 47
- 5.2 Instruction Set in Alphabetical Order........................................................................................................ 48

### Section 6: Instruction Descriptions........................................................................................................ 57
- 6.1 Sample Description (Name): Classification......................................................................................... 57
- 6.2 ADD (ADD Binary): Arithmetic Instruction......................................................................................... 60
- 6.3 ADDC (ADD with Carry): Arithmetic Instruction............................................................................... 61
- 6.4 ADDV (ADD with V Flag Overflow Check): Arithmetic Instruction........................................ 62
- 6.5 AND (AND Logical): Logic Operation Instruction........................................................................... 63
- 6.6 BF (Branch if False): Branch Instruction............................................................................................. 65
- 6.7 BF/S (Branch if False with Delay Slot): Branch Instruction (SH-2 CPU)........................... 66
- 6.8 BRA (Branch): Branch Instruction......................................................................................................... 68
- 6.9 BRAF (Branch Far): Branch Instruction (SH-2 CPU)..................................................................... 70
- 6.10 BSR (Branch to Subroutine): Branch Instruction............................................................................ 72
- 6.11 BSRF (Branch to Subroutine Far): Branch Instruction (SH-2 CPU)..................................... 74
- 6.12 BT (Branch if True): Branch Instruction............................................................................................. 75
- 6.13 BT/S (Branch if True with Delay Slot): Branch Instruction (SH-2 CPU)........................... 76
- 6.14 CLRMAC (Clear MAC Register): System Control Instruction.................................................. 78
- 6.15 CLRT (Clear T Bit): System Control Instruction............................................................................ 79
- 6.16 CMP/cond (Compare Conditionally): Arithmetic Instruction.................................................... 80
- 6.17 DIV0S (Divide Step 0 as Signed): Arithmetic Instruction......................................................... 84
- 6.18 DIV0U (Divide Step 0 as Unsigned): Arithmetic Instruction.................................................... 85
- 6.19 DIV1 (Divide Step 1): Arithmetic Instruction.................................................................................. 86
- 6.20 DMULS.L (Double-Length Multiply as Signed): Arithmetic Instruction (SH-2 CPU).. 91
- 6.21 DMULU.L (Double-Length Multiply as Unsigned): Arithmetic Instruction (SH-2 CPU)............................................................................................................................................ 93
- 6.22 DT (Decrement and Test): Arithmetic Instruction (SH-2 CPU)............................................... 95
- 6.23 EXTS (Extend as Signed): Arithmetic Instruction.......................................................................... 96
- 6.24 EXTU (Extend as Unsigned): Arithmetic Instruction.................................................................... 97
- 6.25 JMP (Jump): Branch Instruction........................................................................................................... 98
- 6.26 JSR (Jump to Subroutine): Branch Instruction................................................................................. 99
- 6.27 LDC (Load to Control Register): System Control Instruction................................................... 101
- 6.28 LDS (Load to System Register): System Control Instruction..................................................... 103
- 6.29 MAC.L (Multiply and Accumulate Long): Arithmetic Instruction (SH-2 CPU)............... 105
- 6.30 MAC (Multiply and Accumulate): Arithmetic Instruction (SH-1 CPU).............................. 108
- 6.31 MAC.W (Multiply and Accumulate Word): Arithmetic Instruction....................................... 109
- 6.32 MOV (Move Data): Data Transfer Instruction.................................................................................. 112
- 6.33 MOV (Move Immediate Data): Data Transfer Instruction........................................................... 117
- 6.34 MOV (Move Peripheral Data): Data Transfer Instruction............................................................ 119
- 6.35 MOV (Move Structure Data): Data Transfer Instruction.............................................................. 122
- 6.36 MOVA (Move Effective Address): Data Transfer Instruction.................................................... 125
- 6.37 MOVT (Move T Bit): Data Transfer Instruction.............................................................................. 126
- 6.38 MUL.L (Multiply Long): Arithmetic Instruction (SH-2 CPU)................................................... 127
- 6.39 MULS.W (Multiply as Signed Word): Arithmetic Instruction.................................................... 128
- 6.40 MULU.W (Multiply as Unsigned Word): Arithmetic Instruction............................................. 129
- 6.41 NEG (Negate): Arithmetic Instruction............................................................................................... 130
- 6.42 NEGC (Negate with Carry): Arithmetic Instruction....................................................................... 131
- 6.43 NOP (No Operation): System Control Instruction.......................................................................... 132
- 6.44 NOT (NOT—Logical Complement): Logic Operation Instruction........................................... 133
- 6.45 OR (OR Logical) Logic Operation Instruction................................................................................ 134
- 6.46 ROTCL (Rotate with Carry Left): Shift Instruction........................................................................ 136
- 6.47 ROTCR (Rotate with Carry Right): Shift Instruction.................................................................... 137
- 6.48 ROTL (Rotate Left): Shift Instruction................................................................................................. 138
- 6.49 ROTR (Rotate Right): Shift Instruction.............................................................................................. 139
- 6.50 RTE (Return from Exception): System Control Instruction........................................................ 140
- 6.51 RTS (Return from Subroutine): Branch Instruction....................................................................... 141
- 6.52 SETT (Set T Bit): System Control Instruction.................................................................................. 143
- 6.53 SHAL (Shift Arithmetic Left): Shift Instruction.............................................................................. 144
- 6.54 SHAR (Shift Arithmetic Right): Shift Instruction.......................................................................... 145
- 6.55 SHLL (Shift Logical Left): Shift Instruction.................................................................................... 146
- 6.56 SHLLn (Shift Logical Left n Bits): Shift Instruction..................................................................... 147
- 6.57 SHLR (Shift Logical Right): Shift Instruction................................................................................. 149
- 6.58 SHLRn (Shift Logical Right n Bits): Shift Instruction.................................................................. 150
- 6.59 SLEEP (Sleep): System Control Instruction..................................................................................... 152
- 6.60 STC (Store Control Register): System Control Instruction......................................................... 153
- 6.61 STS (Store System Register): System Control Instruction.......................................................... 155
- 6.62 SUB (Subtract Binary): Arithmetic Instruction................................................................................ 157
- 6.63 SUBC (Subtract with Carry): Arithmetic Instruction..................................................................... 158
- 6.64 SUBV (Subtract with V Flag Underflow Check): Arithmetic Instruction............................. 159
- 6.65 SWAP (Swap Register Halves): Data Transfer Instruction......................................................... 160
- 6.66 TAS (Test and Set): Logic Operation Instruction............................................................................ 161
- 6.67 TRAPA (Trap Always): System Control Instruction...................................................................... 162
- 6.68 TST (Test Logical): Logic Operation Instruction............................................................................ 163
- 6.69 XOR (Exclusive OR Logical): Logic Operation Instruction....................................................... 165
- 6.70 XTRCT (Extract): Data Transfer Instruction.................................................................................... 167

### Section 7: Pipeline Operation..................................................................................................................... 168
- 7.1 Basic Configuration of Pipelines........................................................................................................... 168
- 7.2 Slot and Pipeline Flow.................................................................................................................................. 169
  - 7.2.1 Instruction Execution...................................................................................................................... 169
  - 7.2.2 Slot Sharing...................................................................................................................................... 169
  - 7.2.3 Slot Length........................................................................................................................................ 170
- 7.3 Number of Instruction Execution States................................................................................................. 171
- 7.4 Contention Between Instruction Fetch (IF) and Memory Access (MA)................................. 172
  - 7.4.1 Basic Operation When IF and MA are in Contention...................................................... 172
  - 7.4.2 The Relationship Between IF and the Location of Instructions in On-Chip ROM/RAM or On-Chip Memory.............................................................................................. 173
  - 7.4.3 Relationship Between Position of Instructions Located in On-Chip ROM/RAM or On-Chip Memory and Contention Between IF and MA............. 174
- 7.5 Effects of Memory Load Instructions on Pipelines........................................................................... 175
- 7.6 Programming Guide....................................................................................................................................... 176
- 7.7 Operation of Instruction Pipelines........................................................................................................... 177
  - 7.7.1 Data Transfer Instructions............................................................................................................. 184
  - 7.7.2 Arithmetic Instructions.................................................................................................................. 186
  - 7.7.3 Logic Operation Instructions........................................................................................................ 237
  - 7.7.4 Shift Instructions............................................................................................................................. 238
  - 7.7.5 Branch Instructions......................................................................................................................... 239
  - 7.7.6 System Control Instructions......................................................................................................... 242
  - 7.7.7 Exception Processing..................................................................................................................... 248

### Appendix A: Instruction Code................................................................................................................. 251
- A.1 Instruction Set by Addressing Mode....................................................................................................... 251
  - A.1.1 No Operand...................................................................................................................................... 253
  - A.1.2 Direct Register Addressing.......................................................................................................... 254
  - A.1.3 Indirect Register Addressing....................................................................................................... 257
  - A.1.4 Post Increment Indirect Register Addressing....................................................................... 257
  - A.1.5 Pre Decrement Indirect Register Addressing........................................................................ 258
  - A.1.6 Indirect Register Addressing with Displacement............................................................... 259
  - A.1.7 Indirect Indexed Register Addressing..................................................................................... 259
  - A.1.8 Indirect GBR Addressing with Displacement....................................................................... 260
  - A.1.9 Indirect Indexed GBR Addressing............................................................................................ 260
  - A.1.10 PC Relative Addressing with Displacement........................................................................ 260
  - A.1.11 PC Relative Addressing with Rm........................................................................................... 261
  - A.1.12 PC Relative Addressing............................................................................................................. 261
  - A.1.13 Immediate....................................................................................................................................... 262
- A.2 Instruction Sets by Instruction Format.................................................................................................... 262
  - A.2.1 0 Format............................................................................................................................................ 264
  - A.2.2 n Format............................................................................................................................................ 265
  - A.2.3 m Format.......................................................................................................................................... 267
  - A.2.4 nm Format......................................................................................................................................... 269
  - A.2.5 md Format......................................................................................................................................... 272
  - A.2.6 nd4 Format........................................................................................................................................ 272
  - A.2.7 nmd Format...................................................................................................................................... 272
  - A.2.8 d Format............................................................................................................................................ 273
  - A.2.9 d12 Format........................................................................................................................................ 274
  - A.2.10 nd8 Format...................................................................................................................................... 274
  - A.2.11 i Format........................................................................................................................................... 274
  - A.2.12 ni Format......................................................................................................................................... 275
- A.3 Instruction Set in Order by Instruction Code...................................................................................... 276
- A.4 Operation Code Map..................................................................................................................................... 284
- Appendix B Pipeline Operation and Contention......................................................................................... 288

---

## Figures

- Figure 2.1 General Registers............................................................................................................................. 16
- Figure 2.2 Control Registers............................................................................................................................. 18
- Figure 2.3 System Registers.............................................................................................................................. 19
- Figure 3.1 Longword Operand.......................................................................................................................... 21
- Figure 3.2 Byte, Word, and Longword Alignment................................................................................... 21
- Figure 3.3 Byte, Word, and Longword in little endian format (SH7604 only)... 22
- Figure 6.1 Using R0 after MOV...................................................................................................................... 119
- Figure 6.2 Using R0 after MOV...................................................................................................................... 122
- Figure 6.3 Rotate with Carry Left.................................................................................................................... 136
- Figure 6.4 Rotate with Carry Right................................................................................................................. 137
- Figure 6.5 Rotate Left.......................................................................................................................................... 138
- Figure 6.6 Rotate Right....................................................................................................................................... 139
- Figure 6.7 Shift Arithmetic Left....................................................................................................................... 144
- Figure 6.8 Shift Arithmetic Right..................................................................................................................... 145
- Figure 6.9 Shift Logical Left............................................................................................................................. 146
- Figure 6.10 Shift Logical Left n Bits.............................................................................................................. 147
- Figure 6.11 Shift Logical Right........................................................................................................................ 149
- Figure 6.12 Shift Logical Right n Bits........................................................................................................... 150
- Figure 6.13 Extract............................................................................................................................................... 167
- Figure 7.1 Basic Structure of Pipeline Flow................................................................................................. 168
- Figure 7.2 Impossible Pipeline Flow 1.......................................................................................................... 169
- Figure 7.3 Impossible Pipeline Flow 2.......................................................................................................... 169
- Figure 7.4 Slots Requiring Multiple Cycles................................................................................................. 170
- Figure 7.5 How Instruction Execution States Are Counted.................................................................. 171
- Figure 7.6 Operation When IF and MA Are in Contention................................................................... 172
- Figure 7.7 Relationship Between IF and Location of Instructions in On-Chip Memory....... 174
- Figure 7.8 Relationship Between the Location of Instructions in On-Chip Memory and Contention Between IF and MA................................................................................................... 175
- Figure 7.9 Effects of Memory Load Instructions on the Pipeline.................................................... 176
- Figure 7.10 Register-Register Transfer Instruction Pipeline............................................................... 184
- Figure 7.11 Memory Load Instruction Pipeline.......................................................................................... 185
- Figure 7.12 Memory Store Instruction Pipeline........................................................................................ 186
- Figure 7.13 Pipeline for Arithmetic Instructions between Registers Except Multiplication Instructions...................................................................................................................... 187
- Figure 7.14 Multiply/Accumulate Instruction Pipeline......................................................................... 188
- Figure 7.15 Unrelated Instructions between MAC.W Instructions................................................... 189
- Figure 7.16 Consecutive MAC.Ws without Increment............................................................................ 189
- Figure 7.17 MA and IF Contention................................................................................................................. 190
- Figure 7.18 MULS.W Instruction Immediately After a MAC.W Instruction................................. 191
- Figure 7.19 STS (Register) Instruction Immediately After a MAC.W Instruction.................. 192
- Figure 7.20 STS.L (Memory) Instruction Immediately After a MAC.W Instruction............... 193
- Figure 7.21 LDS (Register) Instruction Immediately After a MAC.W Instruction.................. 194
- Figure 7.22 LDS.L (Memory) Instruction Immediately After a MAC.W Instruction............... 195
- Figure 7.23 Multiply/Accumulate Instruction Pipeline......................................................................... 196
- Figure 7.24 MAC.W Instruction That Immediately Follows Another MAC.W instruction.. 197
- Figure 7.25 Consecutive MAC.Ws with Displacement........................................................................... 197
- Figure 7.26 MA and IF Contention................................................................................................................. 198
- Figure 7.27 MAC.L Instructions Immediately After a MAC.W Instruction................................. 198
- Figure 7.28 MULS.W Instruction Immediately After a MAC.W Instruction.............................. 199
- Figure 7.29 DMULS.L Instructions Immediately After a MAC.W Instruction........................... 199
- Figure 7.30 STS (Register) Instruction Immediately After a MAC.W Instruction.................... 200
- Figure 7.31 STS.L (Memory) Instruction Immediately After a MAC.W Instruction............... 201
- Figure 7.32 LDS (Register) Instruction Immediately After a MAC.W Instruction................... 202
- Figure 7.33 LDS.L (Memory) Instruction Immediately After a MAC.W Instruction............... 203
- Figure 7.34 Multiply/Accumulate Instruction Pipeline......................................................................... 204
- Figure 7.35 MAC.L Instruction Immediately After Another MAC.L Instruction....................... 205
- Figure 7.36 Consecutive MAC.Ls with Displacement............................................................................. 205
- Figure 7.37 MA and IF Contention................................................................................................................. 206
- Figure 7.38 MAC.W Instruction Immediately After a MAC.L Instruction................................... 207
- Figure 7.39 DMULS.L Instruction Immediately After a MAC.L Instruction................................ 208
- Figure 7.40 MULS.W Instruction Immediately After a MAC.L Instruction................................. 209
- Figure 7.41 STS (Register) Instruction Immediately After a MAC.L Instruction..................... 210
- Figure 7.42 STS.L (Memory) Instruction Immediately After a MAC.L Instruction................. 211
- Figure 7.43 LDS (Register) Instruction Immediately After a MAC.L Instruction..................... 212
- Figure 7.44 LDS.L (Memory) Instruction Immediately After a MAC.L Instruction................. 213
- Figure 7.45 Multiplication Instruction Pipeline......................................................................................... 214
- Figure 7.46 MAC.W Instruction Immediately After a MULS.W Instruction.............................. 215
- Figure 7.47 MULS.W Instruction Immediately After Another MULS.W Instruction.............. 216
- Figure 7.48 MULS.W Instruction Immediately After Another MULS.W Instruction (IF and MA Contention)...................................................................................................................... 217
- Figure 7.49 STS (Register) Instruction Immediately After a MULS.W Instruction................ 218
- Figure 7.50 STS.L (Memory) Instruction Immediately After a MULS.W Instruction............ 219
- Figure 7.51 LDS (Register) Instruction Immediately After a MULS.W Instruction................ 220
- Figure 7.52 LDS.L (Memory) Instruction Immediately After a MULS.W Instruction............ 221
- Figure 7.53 Multiplication Instruction Pipeline......................................................................................... 222
- Figure 7.54 MAC.W Instruction Immediately After a MULS.W Instruction.............................. 223
- Figure 7.55 MAC.L Instruction Immediately After a MULS.W Instruction................................. 223
- Figure 7.56 MULS.W Instruction Immediately After Another MULS.W Instruction.............. 224
- Figure 7.57 MULS.W Instruction Immediately After Another MULS.W Instruction (IF and MA contention)............................................................................................................................ 224
- Figure 7.58 DMULS.L Instruction Immediately After a MULS.W Instruction........................... 225
- Figure 7.59 STS (Register) Instruction Immediately After a MULS.W Instruction................. 226
- Figure 7.60 STS.L (Memory) Instruction Immediately After a MULS.W Instruction............ 227
- Figure 7.61 LDS (Register) Instruction Immediately After a MULS.W Instruction................ 228
- Figure 7.62 LDS.L (Memory) Instruction Immediately After a MULS.W Instruction............ 229
- Figure 7.63 Multiplication Instruction Pipeline......................................................................................... 229
- Figure 7.64 MAC.L Instruction Immediately After a DMULS.L Instruction............................... 231
- Figure 7.65 MAC.W Instruction Immediately After a DMULS.L Instruction............................. 231
- Figure 7.66 DMULS.L Instruction Immediately After Another DMULS.L Instruction........... 232
- Figure 7.67 DMULS.L Instruction Immediately After Another DMULS.L Instruction (IF and MA Contention)...................................................................................................................... 233
- Figure 7.68 MULS.W Instruction Immediately After a DMULS.L Instruction........................... 233
- Figure 7.69 MULS.W Instruction Immediately After a DMULS.L Instruction (IF and MA Contention).............................................................................................................................. 234
- Figure 7.70 STS (Register) Instruction Immediately After a DMULS.L Instruction............... 234
- Figure 7.71 STS.L (Memory) Instruction Immediately After a DMULS.L Instruction........... 235
- Figure 7.72 LDS (Register) Instruction Immediately After a DMULS.L Instruction............... 236
- Figure 7.73 LDS.L (Memory) Instruction Immediately After a DMULS.L Instruction.......... 237
- Figure 7.74 Register-Register Logic Operation Instruction Pipeline.............................................. 237
- Figure 7.75 Memory Logic Operation Instruction Pipeline.................................................................. 238
- Figure 7.76 TAS Instruction Pipeline............................................................................................................. 238
- Figure 7.77 Shift Instruction Pipeline............................................................................................................ 239
- Figure 7.78 Branch Instruction When Condition is Satisfied............................................................... 240
- Figure 7.79 Branch Instruction When Condition is Not Satisfied.................................................... 240
- Figure 7.80 Branch Instruction When Condition is Satisfied............................................................. 241
- Figure 7.81 Branch Instruction When Condition is Not Satisfied.................................................... 241
- Figure 7.82 Unconditional Branch Instruction Pipeline........................................................................ 242
- Figure 7.83 System Control ALU Instruction Pipeline........................................................................... 243
- Figure 7.84 LDC.L Instruction Pipeline........................................................................................................ 243
- Figure 7.85 STC.L Instruction Pipeline......................................................................................................... 243
- Figure 7.86 LDS.L Instruction (PR) Pipeline.............................................................................................. 244
- Figure 7.87 STS.L Instruction (PR) Pipeline.............................................................................................. 244
- Figure 7.88 Register → MAC Transfer Instruction Pipeline............................................................... 245
- Figure 7.89 Memory → MAC Transfer Instruction Pipeline................................................................ 245
- Figure 7.90 MAC → Register Transfer Instruction Pipeline............................................................... 246
- Figure 7.91 MAC → Memory Transfer Instruction Pipeline............................................................... 246
- Figure 7.92 RTE Instruction Pipeline............................................................................................................. 247
- Figure 7.93 TRAP Instruction Pipeline......................................................................................................... 247
- Figure 7.94 SLEEP Instruction Pipeline....................................................................................................... 248
- Figure 7.95 Interrupt Exception Processing Pipeline.............................................................................. 248
- Figure 7.96 Address Error Exception Processing Pipeline................................................................... 249
- Figure 7.97 Illegal Instruction Exception Processing Pipeline.......................................................... 249

---

## Tables

- Table 1 Manual Organization............................................................................................................................ 2
- Table 2 Subjects and Corresponding Sections............................................................................................ 3
- Table 3 Functions by CPU Type...................................................................................................................... 4
- Table 1.1 SH-1 and SH-2 CPU Features....................................................................................................... 15
- Table 2.1 Initial Values of Registers.............................................................................................................. 20
- Table 4.1 Sign Extension of Word Data......................................................................................................... 23
- Table 4.2 Delayed Branch Instructions............................................................................................................ 24
- Table 4.3 T Bit....................................................................................................................................................... 24
- Table 4.4 Immediate Data Accessing.............................................................................................................. 25
- Table 4.5 Absolute Address................................................................................................................................ 25
- Table 4.6 Displacement Accessing.................................................................................................................... 26
- Table 4.7 Addressing Modes and Effective Addresses............................................................................. 26
- Table 4.8 Instruction Formats............................................................................................................................ 30
- Table 5.1 Classification of Instructions.......................................................................................................... 34
- Table 5.2 Instruction Code Format................................................................................................................... 38
- Table 5.3 Data Transfer Instructions................................................................................................................ 40
- Table 5.4 Arithmetic Instructions...................................................................................................................... 42
- Table 5.5 Logic Operation Instructions........................................................................................................... 44
- Table 5.5 Logic Operation Instructions (cont)............................................................................................. 45
- Table 5.6 Shift Instructions................................................................................................................................. 45
- Table 5.7 Branch Instructions............................................................................................................................ 46
- Table 5.8 System Control Instructions............................................................................................................ 47
- Table 5.9 Instruction Set...................................................................................................................................... 49
- Table 6.1 CMP Mnemonics................................................................................................................................ 81
- Table 7.1 Format for the Number of Stages and Execution States for Instructions.................... 177
- Table 7.2 Number of Instruction Stages and Execution States............................................................ 177
- Table A.1 Instruction Set by Addressing Mode......................................................................................... 252
- Table A.2 No Operand......................................................................................................................................... 253
- Table A.3 Destination Operand Only............................................................................................................... 254
- Table A.4 Source and Destination Operands............................................................................................... 254
- Table A.5 Load and Store with Control Register or System Register.............................................. 256
- Table A.6 Destination Operand Only............................................................................................................... 257
- Table A.7 Data Transfer with Direct Register Addressing..................................................................... 257
- Table A.8 Multiply/Accumulate Operation.................................................................................................. 257
- Table A.9 Data Transfer from Direct Register Addressing..................................................................... 258
- Table A.10 Load to Control Register or System Register....................................................................... 258
- Table A.11 Data Transfer from Direct Register Addressing.................................................................. 258
- Table A.12 Store from Control Register or System Register................................................................ 259
- Table A.13 Indirect Register Addressing....................................................................................................... 259
- Table A.14 Indirect Indexed Register Addressing..................................................................................... 259
- Table A.15 Indirect GBR Addressing with Displacement....................................................................... 260
- Table A.16 Indirect Indexed GBR Addressing............................................................................................. 260
- Table A.17 PC Relative Addressing with Displacement......................................................................... 260
- Table A.18 PC Relative Addressing with Rm.............................................................................................. 261
- Table A.19 PC Relative Addressing................................................................................................................ 261
- Table A.20 Arithmetic Logical Operation with Direct Register Addressing................................. 262
- Table A.21 Specify Exception Processing Vector...................................................................................... 262
- Table A.22 Instruction Sets by Format........................................................................................................... 263
- Table A.23 0 Format............................................................................................................................................. 264
- Table A.24 Direct Register Addressing........................................................................................................... 265
- Table A.25 Direct Register Addressing (Store with Control and System Registers)................ 265
- Table A.26 Indirect Register Addressing....................................................................................................... 266
- Table A.27 Pre Decrement Indirect Register............................................................................................... 266
- Table A.28 Direct Register Addressing (Load Control and System Registers)................. 267
- Table A.29 Indirect Register.............................................................................................................................. 267
- Table A.30 Post Increment Indirect Register............................................................................................... 267
- Table A.31 PC Relative Addressing with Rm.............................................................................................. 268
- Table A.32 Direct Register Addressing........................................................................................................... 269
- Table A.33 Indirect Register Addressing....................................................................................................... 271
- Table A.34 Post Increment Indirect Register (Multiply/Accumulate Operation)........................ 271
- Table A.35 Post Increment Indirect Register............................................................................................... 271
- Table A.36 Pre Decrement Indirect Register............................................................................................... 271
- Table A.37 Indirect Indexed Register.............................................................................................................. 272
- Table A.38 md Format......................................................................................................................................... 272
- Table A.39 nd4 Format........................................................................................................................................ 272
- Table A.40 nmd Format....................................................................................................................................... 272
- Table A.41 Indirect GBR with Displacement............................................................................................... 273
- Table A.42 PC Relative with Displacement.................................................................................................. 273
- Table A.43 PC Relative Addressing................................................................................................................ 273
- Table A.44 d12 Format........................................................................................................................................ 274
- Table A.45 nd8 Format........................................................................................................................................ 274
- Table A.46 Indirect Indexed GBR Addressing............................................................................................. 274
- Table A.47 Immediate Addressing (Arithmetic Logical Operation with Direct Register)..... 275
- Table A.48 Immediate Addressing (Specify Exception Processing Vector)................................. 275
- Table A.49 ni Format............................................................................................................................................ 275
- Table A.50 Instruction Set by Instruction Code......................................................................................... 276
- Table A.51 Operation Code Map...................................................................................................................... 284
- Table B.1 Instructions and Their Contention Patterns............................................................................. 289

---

# Section 1: Features

The SH-1 and SH-2 CPU have RISC-type instruction sets. Basic instructions are executed in one clock cycle, which dramatically improves instruction execution speed. The CPU also has an internal 32-bit architecture for enhanced data processing ability. Table 1.1 lists the SH-1 and SH-2 CPU features.

## Table 1.1: SH-1 and SH-2 CPU Features

| Item | Feature |
|------|---------|
| Architecture | • Original Hitachi architecture<br>• 32-bit internal data paths |
| General-register machine | • Sixteen 32-bit general registers<br>• Three 32-bit control registers<br>• Four 32-bit system registers |
| Instruction set | • Instruction length: 16-bit fixed length for improved code efficiency<br>• Load-store architecture (basic arithmetic and logic operations are executed between registers)<br>• Delayed branch system used for reduced pipeline disruption<br>• Instruction set optimized for C language |
| Instruction execution time | • One instruction/cycle for basic instructions |
| Address space | • Architecture makes 4 Gbytes available |
| On-chip multiplier (SH-1 CPU) | • Multiplication operations (16 bits × 16 bits → 32 bits) executed in 1 to 3 cycles, and multiplication/accumulation operations (16 bits × 16 bits + 42 bits → 42 bits) executed in 3/(2)* cycles |
| On-chip multiplier (SH-2 CPU) | • Multiplication operations executed in 1 to 2 cycles (16 bits ×16 bits → 32 bits) or 2 to 4 cycles (32 bits × 32 bits → 64 bits), and multiplication/accumulation operations executed in 3/(2)* cycles (16 bits × 16 bits + 64 bits → 64 bits) or 3/(2 to 4)* cycles (32 bits × 32 bits + 64 bits → 64 bits) |
| Pipeline | • Five-stage pipeline |
| Processing states | • Reset state<br>• Exception processing state<br>• Program execution state<br>• Power-down state<br>• Bus release state |
| Power-down states | • Sleep mode<br>• Standby mode |

**Note:** The normal minimum number of execution cycles (The number in parentheses in the number in contention with preceding/following instructions).

---

# Section 2: Register Configuration

The register set consists of sixteen 32-bit general registers, three 32-bit control registers and four 32-bit system registers.

## 2.1 General Registers

There are 16 general registers (Rn) numbered R0–R15, which are 32 bits in length (figure 2.1). General registers are used for data processing and address calculation. R0 is also used as an index register. Several instructions use R0 as a fixed source or destination register. R15 is used as the hardware stack pointer (SP). Saving and recovering the status register (SR) and program counter (PC) in exception processing is accomplished by referencing the stack using R15.

```
31                                    0
┌─────────────────────────────────────┐
│              R0*¹                   │ 1. R0 functions as an index register in the
├─────────────────────────────────────┤    indirect indexed register addressing
│              R1                     │    mode and indirect indexed GBR
├─────────────────────────────────────┤    addressing mode. In some instructions,
│              R2                     │    R0 functions as a fixed source register
├─────────────────────────────────────┤    or destination register.
│              R3                     │
├─────────────────────────────────────┤
│              R4                     │
├─────────────────────────────────────┤
│              R5                     │
├─────────────────────────────────────┤
│              R6                     │
├─────────────────────────────────────┤
│              R7                     │
├─────────────────────────────────────┤
│              R8                     │
├─────────────────────────────────────┤
│              R9                     │
├─────────────────────────────────────┤
│             R10                     │
├─────────────────────────────────────┤
│             R11                     │
├─────────────────────────────────────┤
│             R12                     │
├─────────────────────────────────────┤
│             R13                     │
├─────────────────────────────────────┤
│             R14                     │
├─────────────────────────────────────┤
│ R15, SP (hardware stack pointer) *² │ 2. R15 functions as a hardware stack
└─────────────────────────────────────┘    pointer (SP) during exception
                                            processing.
```

**Figure 2.1: General Registers**

## 2.2 Control Registers

The 32-bit control registers consist of the 32-bit status register (SR), global base register (GBR), and vector base register (VBR) (figure 2.2). The status register indicates processing states. The global base register functions as a base address for the indirect GBR addressing mode to transfer data to the registers of on-chip peripheral modules. The vector base register functions as the base address of the exception processing vector area (including interrupts).

```
31                9 8 7 6 5 4 3 2 1 0
SR │ ─────────── MQ I3 I2 I1 I0 ── S T │ SR: Status register
   │             │                │    │
   │             │                │    └─▶T bit: The MOVT, CMP/cond, TAS, TST,
   │             │                │       BT (BT/S), BF (BF/S), SETT, and CLRT
   │             │                │       instructions use the T bit to indicate
   │             │                │       true (1) or false (0). The ADDV/C,
   │             │                │       SUBV/C, DIV0U/S, DIV1, NEGC,
   │             │                │       SHAR/L, SHLR/L, ROTR/L, and
   │             │                │       ROTCR/L instructions also use bit T
   │             │                │       to indicate carry/borrow or overflow/
   │             │                │       underflow
   │             │                └──▶S bit: Used by the multiply/accumulate
   │             │                    instruction.
   │             └───────────────▶Reserved bits: Always reads as 0, and should
   │                              always be written with 0.
   └──────────────────────────▶Bits I3–I0: Interrupt mask bits.
                              ▶M and Q bits: Used by the DIV0U/S and
                               DIV1 instructions.

31                                 0│ Global base register (GBR):
│            GBR                    │ Indicates the base address of the indirect
                                    │ GBR addressing mode. The indirect GBR
                                    │ addressing mode is used in data transfer
                                    │ for on-chip peripheral module register
                                    │ areas and in logic operations.

31                                 0│ Vector base register (VBR):
│            VBR                    │ Indicates the base address of the exception
                                    │ processing vector area.




                                                SW J04
```

**Figure 2.2: Control Registers**

## 2.3 System Registers

The system registers consist of four 32-bit registers: high and low multiply and accumulate registers (MACH and MACL), the procedure register (PR), and the program counter (PC) (figure 2.3). The multiply and accumulate registers store the results of multiply and accumulate operations. The procedure register stores the return address from the subroutine procedure. The program counter stores program addresses to control the flow of the processing.

```
        31                     9          0
(SH-1 CPU) │   (sign extended)     │   MACH   │  Multiply and accumulate (MAC)
           │                 MACL           │  registers high and low (MACH/L):
                                            │  Store the results of multiply and
        31                                 0│  accumulate operations. In the
(SH-2 CPU) │            MACH                │  SH-1 CPU, MACH is sign-extended
           │                                │  to 32 bits when read because only
           │            MACL                │  the lowest 10 bits are valid. In the
                                            │  SH-2 CPU, all 32 bits of MACH are
                                            │  valid.
        31                                 0│
           │             PR                 │  Procedure register (PR): Stores a
                                            │  return address from a subroutine
                                            │  procedure.
        31                                 0│  Program counter (PC): Indicates the
           │             PC                 │  fourth byte (second instruction) after
                                            │  the current instruction.
```

**Figure 2.3: System Registers**

## 2.4 Initial Values of Registers

Table 2.1 lists the values of the registers after reset.

### Table 2.1: Initial Values of Registers

| Classification | Register | Initial Value |
|----------------|----------|---------------|
| General register | R0–R14 | Undefined |
| | R15 (SP) | Value of the stack pointer in the vector address table |
| Control register | SR | Bits I3–I0 are 1111 (H'F), reserved bits are 0, and other bits are undefined |
| | GBR | Undefined |
| | VBR | H'00000000 |
| System register | MACH, MACL, PR | Undefined |
| | PC | Value of the program counter in the vector address table |

---

# Section 3: Data Formats

## 3.1 Data Format in Registers

Register operands are always longwords (32 bits) (figure 3.1). When the memory operand is only a byte (8 bits) or a word (16 bits), it is sign-extended into a longword when loaded into a register.

```
31                                0
│          Longword               │
```

**Figure 3.1: Longword Operand**

## 3.2 Data Format in Memory

Memory data formats are classified into bytes, words, and longwords. Byte data can be accessed from any address, but an address error will occur if you try to access word data starting from an address other than 2n or longword data starting from an address other than 4n. In such cases, the data accessed cannot be guaranteed (figure 3.2). The hardware stack area, which is referred to by the hardware stack pointer (SP, R15), uses only longword data starting from address 4n because this area holds the program counter and status register. See the *SH Hardware Manual* for more information on address errors.

```
                         Address m + 1  Address m + 3
                           │               │
                  Address m│   Address m + 2│
                  ┌─31M    23 ▼   15 ▼  7 ▼ 0┐
                  │ Byte │ Byte │ Byte │ Byte │
   Address 2n──▶  │  Word    │  Word    │
   Address 4n──▶  │      Longword           │
                  │                          │
                  └▶      Big endian        ┘
```

**Figure 3.2: Byte, Word, and Longword Alignment**

SH7604 has a function that allows access of CS2 space (area 2) in little endian format, which enables memory to be shared with processors that access memory in little endian format (figure 3.3). Byte data is arranged differently for little endian and the usual big endian.

```
                  Address m + 2   Address m
                      │               │
         Address m + 3│   Address m + 1│
         ┌─31M    23 ▼   15 ▼  7 ▼ 0┐
         │ Byte │ Byte │ Byte │ Byte │
         │  Word    │  Word    │ ◀─ Address 2n
         │      Longword           │ ◀─ Address 4n
         │                          │
         └▶     Little endian*     ┘

         Note : Only CS2 space of SH7604 can be set.
```

**Figure 3.3: Byte, Word, and Longword Alignment in little endian format (SH7604 only)**

## 3.3 Immediate Data Format

Byte immediate data is located in an instruction code. Immediate data accessed by the MOV, ADD, and CMP/EQ instructions is sign-extended and calculated with registers and longword data. Immediate data accessed by the TST, AND, OR, and XOR instructions is zero-extended and calculated with longword data. Consequently, AND instructions with immediate data always clear the upper 24 bits of the destination register.

Word or longword immediate data is not located in the instruction code. Rather, it is stored in a memory table. The memory table is accessed by an immediate data transfer instruction (MOV) using the PC relative addressing mode with displacement. Specific examples are given in section 4.1.8, Immediate Data.

---

# Section 4: Instruction Features

## 4.1 RISC-Type Instruction Set

All instructions are RISC type. Their features are detailed in this section.

### 4.1.1 16-Bit Fixed Length

All instructions are 16 bits long, increasing program coding efficiency.

### 4.1.2 One Instruction/Cycle

Basic instructions can be executed in one cycle using the pipeline system. Instructions are executed in 50 ns at 20 MHz, in 35 ns at 28.7MHz.

### 4.1.3 Data Length

Longword is the standard data length for all operations. Memory can be accessed in bytes, words, or longwords. Byte or word data accessed from memory is sign-extended and calculated with longword data (table 4.1). Immediate data is sign-extended for arithmetic operations or zero-extended for logic operations. It also is calculated with longword data.

#### Table 4.1: Sign Extension of Word Data

| SH-1/SH-2 CPU | | Description | Example for Other CPU | |
|---------------|---|-------------|----------------------|---|
| MOV.W @(disp,PC),R1 | | Data is sign-extended to 32 bits, and R1 becomes H'00001234. It is next operated upon by an ADD instruction. | ADD.W #H'1234,R0 | |
| ADD R1,R0 | | | | |
| ......... | | | | |
| .DATA.W H'1234 | | | | |

**Note:** The address of the immediate data is accessed by @(disp, PC).

### 4.1.4 Load-Store Architecture

Basic operations are executed between registers. For operations that involve memory access, data is loaded to the registers and executed (load-store architecture). Instructions such as AND that manipulate bits, however, are executed directly in memory.

### 4.1.5 Delayed Branch Instructions

Unconditional branch instructions are delayed. Pipeline disruption during branching is reduced by first executing the instruction that follows the branch instruction, and then branching (table 4.2). With delayed branching, branching occurs after execution of the slot instruction. However, instructions such as register changes etc. are executed in the order of delayed branch instruction, then delay slot instruction. For example, even if the register in which the branch destination address has been loaded is changed by the delay slot instruction, the branch will still be made using the value of the register prior to the change as the branch destination address.

#### Table 4.2: Delayed Branch Instructions

| SH-1/SH-2 CPU | | Description | Example for Other CPU | |
|---------------|---|-------------|----------------------|---|
| BRA TRGET | | Executes an ADD before branching to TRGET. | ADD.W R1,R0 | |
| ADD R1,R0 | | | BRA TRGET | |

### 4.1.6 Multiplication/Accumulation Operation

**SH-1 CPU:** 16bit × 16bit → 32-bit multiplication operations are executed in one to three cycles. 16bit × 16bit + 42bit → 42-bit multiplication/accumulation operations are executed in two to three cycles.

**SH-2 CPU:** 16bit × 16bit → 32-bit multiplication operations are executed in one to two cycles. 16bit × 16bit + 64bit → 64-bit multiplication/accumulation operations are executed in two to three cycles. 32bit × 32bit → 64-bit multiplication and 32bit × 32bit + 64bit → 64-bit multiplication/accumulation operations are executed in two to four cycles.

### 4.1.7 T Bit

The T bit in the status register changes according to the result of the comparison, and in turn is the condition (true/false) that determines if the program will branch (table 4.3). The number of instructions after T bit in the status register is kept to a minimum to improve the processing speed.

#### Table 4.3: T Bit

| SH-1/SH-2 CPU | | Description | Example for Other CPU | |
|---------------|---|-------------|----------------------|---|
| CMP/GE R1,R0 | | T bit is set when R0 ≥ R1. The program branches to TRGET0 when R0 ≥ R1 and to TRGET1 when R0 < R1. | CMP.W R1,R0 | |
| BT TRGET0 | | | BGE TRGET0 | |
| BF TRGET1 | | | BLT TRGET1 | |
| ADD #−1,R0 | | T bit is not changed by ADD. T bit is set when R0 = 0. The program branches if R0 = 0. | SUB.W #1,R0 | |
| CMP/EQ #0,R0 | | | BEQ TRGET | |
| BT TRGET | | | | |

### 4.1.8 Immediate Data

Byte immediate data is located in instruction code. Word or longword immediate data is not input via instruction codes but is stored in a memory table. The memory table is accessed by an immediate data transfer instruction (MOV) using the PC relative addressing mode with displacement (table 4.4).

#### Table 4.4: Immediate Data Accessing

| Classification | SH-1/SH-2 CPU | | Example for Other CPU | |
|----------------|---------------|---|----------------------|---|
| 8-bit immediate | MOV #H'12,R0 | | MOV.B #H'12,R0 | |
| 16-bit immediate | MOV.W @(disp,PC),R0 | | MOV.W #H'1234,R0 | |
| | ................. | | | |
| | .DATA.W H'1234 | | | |
| 32-bit immediate | MOV.L @(disp,PC),R0 | | MOV.L #H'12345678,R0 | |
| | ................. | | | |
| | .DATA.L H'12345678 | | | |

**Note:** The address of the immediate data is accessed by @(disp, PC).

### 4.1.9 Absolute Address

When data is accessed by absolute address, the value already in the absolute address is placed in the memory table. Loading the immediate data when the instruction is executed transfers that value to the register and the data is accessed in the indirect register addressing mode.

#### Table 4.5: Absolute Address

| Classification | SH-1/SH-2 CPU | | Example for Other CPU | |
|----------------|---------------|---|----------------------|---|
| Absolute address | MOV.L @(disp,PC),R1 | | MOV.B @H'12345678,R0 | |
| | MOV.B @R1,R0 | | | |
| | .................. | | | |
| | .DATA.L H'12345678 | | | |

### 4.1.10 16-Bit/32-Bit Displacement

When data is accessed by 16-bit or 32-bit displacement, the pre-existing displacement value is placed in the memory table. Loading the immediate data when the instruction is executed transfers that value to the register and the data is accessed in the indirect indexed register addressing mode.

#### Table 4.6: Displacement Accessing

| Classification | SH-1/SH-2 CPU | | Example for Other CPU | |
|----------------|---------------|---|----------------------|---|
| 16-bit displacement | MOV.W @(disp,PC),R0 | | MOV.W @(H'1234,R1),R2 | |
| | MOV.W @(R0,R1),R2 | | | |
| | ................. | | | |
| | .DATA.W H'1234 | | | |

## 4.2 Addressing Modes

Addressing modes and effective address calculation are described in table 4.7.

### Table 4.7: Addressing Modes and Effective Addresses

| Addressing Mode | Instruction Format | Effective Addresses Calculation | Formula |
|-----------------|-------------------|----------------------------------|---------|
| Direct register addressing | Rn | The effective address is register Rn. (The operand is the contents of register Rn.) | — |
| Indirect register addressing | @Rn | The effective address is the content of register Rn.<br><br>Rn → Rn | Rn |
| Post-increment indirect register addressing | @Rn+ | The effective address is the content of register Rn. A constant is added to the content of Rn after the instruction is executed. 1 is added for a byte operation, 2 for a word operation, or 4 for a longword operation.<br><br>Rn → Rn + 1/2/4 → 1/2/4 | Rn<br>(After the instruction is executed)<br>Byte: Rn + 1 → Rn<br>Word: Rn + 2 → Rn<br>Longword: Rn + 4 → Rn |
| Pre-decrement indirect register addressing | @−Rn | The effective address is the value obtained by subtracting a constant from Rn. 1 is subtracted for a byte operation, 2 for a word operation, or 4 for a longword operation.<br><br>Rn → Rn − 1/2/4 → 1/2/4 → Rn − 1/2/4 | Byte: Rn − 1 → Rn<br>Word: Rn − 2 → Rn<br>Longword: Rn − 4 → Rn<br>(Instruction executed with Rn after calculation) |
| Indirect register addressing with displacement | @(disp,Rn) | The effective address is obtained by adding a 4-bit displacement (disp) to Rn. The value of disp is zero-extended, and disp×1 is used for a byte operation, disp×2 for a word operation, or disp×4 for a longword operation.<br><br>Rn + disp×1/2/4 | Byte: Rn + disp<br>Word: Rn + disp × 2<br>Longword: Rn + disp × 4 |
| Indirect indexed register addressing | @(R0,Rn) | The effective address is the value obtained by adding R0 and Rn. | Rn + R0 |
| Indirect GBR addressing with displacement | @(disp,GBR) | The effective address is obtained by adding an 8-bit displacement (disp) to GBR. The value of disp is zero-extended, and disp×1 is used for a byte operation, disp×2 for a word operation, or disp×4 for a longword operation.<br><br>GBR + disp×1/2/4 | Byte: GBR + disp<br>Word: GBR + disp × 2<br>Longword: GBR + disp × 4 |
| Indirect indexed GBR addressing | @(R0,GBR) | The effective address is the value obtained by adding R0 and GBR. | GBR + R0 |
| PC relative addressing with displacement | @(disp,PC) | The effective address is obtained by adding an 8-bit displacement (disp) to PC. The value of disp is zero-extended, and disp×2 is used for a word operation or disp×4 for a longword operation. For a longword operation, the lowest two bits of the PC are fixed at 00.<br><br>PC + disp×2/4 | Word: PC + disp × 2<br>Longword: (PC & H'FFFFFFFC) + disp × 4 |
| PC relative addressing | disp | The effective address is obtained by adding an 8-bit or 12-bit displacement (disp) to PC. For BRA and BSR instructions disp is multiplied by 2 after being sign-extended, and for BRAF and BSRF instructions the value of Rn is added to PC. For TRAPA instructions, disp is multiplied by 4 after being zero-extended. For MOVA instructions, disp is multiplied by 4 after being zero-extended, and the lowest two bits of PC are fixed at 00.<br><br>BRA: PC + sign extension (disp)×2<br>BSR: PC + sign extension (disp)×2<br>BRAF: PC + Rn<br>BSRF: PC + Rn<br>TRAPA: (PC & H'FFFFFFFC) + disp×4<br>MOVA: (PC & H'FFFFFFFC) + disp×4 | BRA, BSR: PC + disp × 2<br>BRAF, BSRF: PC + Rn<br>TRAPA, MOVA: (PC & H'FFFFFFFC) + disp × 4 |
| Immediate | #imm | The operand is an 8-bit immediate value (imm). An immediate value is sign-extended for arithmetic operations, and zero-extended for logic operations. | Byte: imm<br>Word, Longword: sign extension (imm) |

**Notes:**
- In the above table, values of 1/2/4 or disp×1/2/4 indicate the values for byte/word/longword operations.
- PC is the address of the starting location of an instruction. (In the CPU, the value of PC is four bytes ahead of an instruction for pipelining.)

## 4.3 Instruction Format

The instruction format table, table 4.8, refers to the source operand and the destination operand. The meaning of the operand depends on the instruction code. The symbols are used as follows:

- xxxx: Instruction code
- mmmm: Source register
- nnnn: Destination register
- iiii: Immediate data
- dddd: Displacement

### Table 4.8: Instruction Formats

| Instruction Format | Bit Pattern | Source Operand | Destination Operand | Example |
|-------------------|-------------|----------------|---------------------|---------|
| **0 format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│xxxx│xxxx│xxxx│` | — | — | NOP |
| **n format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│nnnn│xxxx│xxxx│` | — | nnnn: Direct register | MOVT Rn |
| | | Control register or system register | nnnn: Direct register | STS MACH,Rn |
| **n format (cont)** | | Control register or system register | nnnn: Indirect pre-decrement register | STC.L SR,@-Rn |
| **m format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│mmmm│xxxx│xxxx│` | mmmm: Direct register | Control register or system register | LDC Rm,SR |
| | | mmmm: Indirect post-increment register | Control register or system register | LDC.L @Rm+,SR |
| | | mmmm: Direct register | — | JMP @Rm |
| | | mmmm: PC relative using Rm | — | BRAF Rm |
| **nm format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│nnnn│mmmm│xxxx│` | mmmm: Direct register | nnnn: Direct register | ADD Rm,Rn |
| | | mmmm: Direct register | nnnn: Indirect register | MOV.L Rm,@Rn |
| | | mmmm: Indirect post-increment register (multiply/accumulate) | MACH, MACL | MAC.W @Rm+,@Rn+ |
| | | nnnn: Indirect post-increment register (multiply/accumulate) | | |
| | | mmmm: Indirect post-increment register | nnnn: Direct register | MOV.L @Rm+,Rn |
| | | mmmm: Direct register | nnnn: Indirect pre-decrement register | MOV.L Rm,@-Rn |
| | | mmmm: Direct register | nnnn: Indirect indexed register | MOV.L Rm,@(R0,Rn) |
| **md format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│xxxx│mmmm│dddd│` | mmmmddd: R0 (Direct register) indirect register with displacement | R0 (Direct register) | MOV.B @(disp,Rm),R0 |
| **nd4 format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│xxxx│nnnn│dddd│` | R0 (Direct register) | nnnndddd: Indirect register with displacement | MOV.B R0,@(disp,Rn) |
| **nmd format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│nnnn│mmmm│dddd│` | mmmm: Direct register | nnnndddd: Indirect register with displacement | MOV.L Rm,@(disp,Rn) |
| | | mmmmddd: Indirect register with displacement | nnnn: Direct register | MOV.L @(disp,Rm),Rn |
| **d format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│xxxx│dddd│dddd│` | dddddddd: Indirect GBR with displacement | R0 (Direct register) | MOV.L @(disp,GBR),R0 |
| | | R0(Direct register) | dddddddd: Indirect GBR with displacement | MOV.L R0,@(disp,GBR) |
| | | dddddddd: PC relative with displacement | R0 (Direct register) | MOVA @(disp,PC),R0 |
| | | dddddddd: PC relative | — | BF label |
| **d12 format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│dddd│dddd│dddd│` | dddddddddddd: PC relative | — | BRA label<br>(label = disp + PC) |
| **nd8 format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│nnnn│dddd│dddd│` | dddddddd: PC relative with displacement | nnnn: Direct register | MOV.L @(disp,PC),Rn |
| **i format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│xxxx│iiii│iiii│` | iiiiiiii: Immediate | Indirect indexed GBR | AND.B #imm,@(R0,GBR) |
| | | iiiiiiii: Immediate | R0 (Direct register) | AND #imm,R0 |
| | | iiiiiiii: Immediate | — | TRAPA #imm |
| **ni format** | `15┌────┬────┬────┬────┐0`<br>`│xxxx│nnnn│iiii│iiii│` | iiiiiiii: Immediate | nnnn: Direct register | ADD #imm,Rn |

**Note:** In multiply/accumulate instructions, nnnn is the source register.

---

# Section 5: Instruction Set

## 5.1 Instruction Set by Classification

Table 5.1 lists instructions by classification.

### Table 5.1: Classification of Instructions

|  |  |  |  | **Applicable Instructions** |  |
|---|---|---|---|---|---|
| **Classification** | **Types** | **Operation Code** | **Function** | **SH-2** | **SH-1** | **No. of Instructions** |
| Data transfer | 5 | MOV | Data transfer<br>Immediate data transfer<br>Peripheral module data transfer<br>Structure data transfer | X | X | 39 |
| | | MOVA | Effective address transfer | X | X | |
| | | MOVT | T-bit transfer | X | X | |
| | | SWAP | Swap of upper and lower bytes | X | X | |
| | | XTRCT | Extraction of the middle of registers connected | X | X | |
| Arithmetic operations | 21 | ADD | Binary addition | X | X | 33 |
| | | ADDC | Binary addition with carry | X | X | |
| | | ADDV | Binary addition with overflow check | X | X | |
| | | CMP/cond | Comparison | X | X | |
| | | DIV1 | Division | X | X | |
| | | DIV0S | Initialization of signed division | X | X | |
| | | DIV0U | Initialization of unsigned division | X | X | |
| | | DMULS | Signed double-length multiplication | X | | |
| | | DMULU | Unsigned double-length multiplication | X | | |
| | | DT | Decrement and test | X | | |
| | | EXTS | Sign extension | X | X | |
| | | EXTU | Zero extension | X | X | |
| | | MAC | Multiply/accumulate, double-length multiply/accumulate operation*¹ | X | X | |
| | | MUL | Double-length multiplication | X | | |
| | | MULS | Signed multiplication | X | X | |
| | | MULU | Unsigned multiplication | X | X | |
| | | NEG | Negation | X | X | |
| | | NEGC | Negation with borrow | X | X | |
| | | SUB | Binary subtraction | X | X | |
| | | SUBC | Binary subtraction with borrow | X | X | |
| | | SUBV | Binary subtraction with underflow check | X | X | |
| Logic operations | 6 | AND | Logical AND | X | X | 14 |
| | | NOT | Bit inversion | X | X | |
| | | OR | Logical OR | X | X | |
| | | TAS | Memory test and bit set | X | X | |
| | | TST | Logical AND and T-bit set | X | X | |
| | | XOR | Exclusive OR | X | X | |
| Shift | 10 | ROTL | One-bit left rotation | X | X | 14 |
| | | ROTR | One-bit right rotation | X | X | |
| | | ROTCL | One-bit left rotation with T bit | X | X | |
| | | ROTCR | One-bit right rotation with T bit | X | X | |
| | | SHAL | One-bit arithmetic left shift | X | X | |
| | | SHAR | One-bit arithmetic right shift | X | X | |
| | | SHLL | One-bit logical left shift | X | X | |
| | | SHLLn | n-bit logical left shift | X | X | |
| | | SHLR | One-bit logical right shift | X | X | |
| | | SHLRn | n-bit logical right shift | X | X | |
| Branch | 9 | BF | Conditional branch, conditional branch with delay*² (T = 0) | X | X | 11 |
| | | BT | Conditional branch, conditional branch with delay*² (T = 1) | X | X | |
| | | BRA | Unconditional branch | X | X | |
| | | BRAF | Unconditional branch | X | | |
| | | BSR | Branch to subroutine procedure | X | X | |
| | | BSRF | Branch to subroutine procedure | X | | |
| | | JMP | Unconditional branch | X | X | |
| | | JSR | Branch to subroutine procedure | X | X | |
| | | RTS | Return from subroutine procedure | X | X | |
| System control | 11 | CLRT | T-bit clear | X | X | 31 |
| | | CLRMAC | MAC register clear | X | X | |
| | | LDC | Load to control register | X | X | |
| | | LDS | Load to system register | X | X | |
| | | NOP | No operation | X | X | |
| | | RTE | Return from exception processing | X | X | |
| | | SETT | T-bit set | X | X | |
| | | SLEEP | Shift into power-down mode | X | X | |
| | | STC | Storing control register data | X | X | |
| | | STS | Storing system register data | X | X | |
| | | TRAPA | Trap exception processing | X | X | |
| **Total: 62** | | | | | | **142** |

**Notes:**
1. Double-length multiply/accumulate is an SH-2 function.
2. Conditional branch with delay is an SH-2 CPU function.

---

Instruction codes, operation, and execution states are listed in table 5.2 in order by classification.

### Table 5.2: Instruction Code Format

| Item | Format | Explanation |
|------|--------|-------------|
| Instruction mnemonic | OP.Sz SRC,DEST | OP: Operation code<br>Sz: Size<br>SRC: Source<br>DEST: Destination<br>Rm: Source register<br>Rn: Destination register<br>imm: Immediate data<br>disp: Displacement* |
| Instruction code | MSB ↔ LSB | mmmm: Source register<br>nnnn: Destination register<br>0000: R0<br>0001: R1<br>⋮<br>1111: R15<br>iiii: Immediate data<br>dddd: Displacement |
| Operation summary | →, ←<br>(xx)<br>M/Q/T<br>&<br>\|<br>^<br>~<br><<n, >>n | Direction of transfer<br>Memory operand<br>Flag bits in the SR<br>Logical AND of each bit<br>Logical OR of each bit<br>Exclusive OR of each bit<br>Logical NOT of each bit<br>n-bit left/right shift |
| Execution cycle | | Value when no wait states are inserted |
| Instruction execution cycles | | The execution cycles shown in the table are minimums. The actual number of cycles may be increased:<br>1. When contention occurs between instruction fetches and data access, or<br>2. When the destination register of the load instruction (memory → register) and the register used by the next instruction are the same. |
| T bit | | Value of T bit after instruction is executed |
| — | | No change |

**Note:** Scaling (x1, x2, x4) is performed according to the instruction operand size. See "6. Instruction Descriptions" for details.

---

### 5.1.1 Data Transfer Instructions

Tables 5.3 to 5.8 list the minimum number of clock states required for execution.

#### Table 5.3: Data Transfer Instructions

| Instruction | Instruction Code | Operation | Execution State | T Bit |
|-------------|------------------|-----------|-----------------|-------|
| MOV #imm,Rn | 1110nnnnii iiiii | imm → Sign extension → Rn | 1 | — |
| MOV.W @(disp,PC),Rn | 1001nnnndddddddd | (disp × 2 + PC) → Sign extension → Rn | 1 | — |
| MOV.L @(disp,PC),Rn | 1101nnnndddddddd | (disp × 4 + PC) → Rn | 1 | — |
| MOV Rm,Rn | 0110nnnnmmmm0011 | Rm → Rn | 1 | — |
| MOV.B Rm,@Rn | 0010nnnnmmmm0000 | Rm → (Rn) | 1 | — |
| MOV.W Rm,@Rn | 0010nnnnmmmm0001 | Rm → (Rn) | 1 | — |
| MOV.L Rm,@Rn | 0010nnnnmmmm0010 | Rm → (Rn) | 1 | — |
| MOV.B @Rm,Rn | 0110nnnnmmmm0000 | (Rm) → Sign extension → Rn | 1 | — |
| MOV.W @Rm,Rn | 0110nnnnmmmm0001 | (Rm) → Sign extension → Rn | 1 | — |
| MOV.L @Rm,Rn | 0110nnnnmmmm0010 | (Rm) → Rn | 1 | — |
| MOV.B Rm,@−Rn | 0010nnnnmmmm0100 | Rn−1 → Rn, Rm → (Rn) | 1 | — |
| MOV.W Rm,@−Rn | 0010nnnnmmmm0101 | Rn−2 → Rn, Rm → (Rn) | 1 | — |
| MOV.L Rm,@−Rn | 0010nnnnmmmm0110 | Rn−4 → Rn, Rm → (Rn) | 1 | — |
| MOV.B @Rm+,Rn | 0110nnnnmmmm0100 | (Rm) → Sign extension → Rn,Rm + 1 → Rm | 1 | — |
| MOV.W @Rm+,Rn | 0110nnnnmmmm0101 | (Rm) → Sign extension → Rn,Rm + 2 → Rm | 1 | — |
| MOV.L @Rm+,Rn | 0110nnnnmmmm0110 | (Rm) → Rn,Rm + 4 → Rm | 1 | — |
| MOV.L Rm,@(R0,Rn) | 0000nnnnmmmm0110 | Rm → (R0 + Rn) | 1 | — |
| MOV.W Rm,@(R0,Rn) | 0000nnnnmmmm0101 | Rm → (R0 + Rn) | 1 | — |
| MOV.L Rm,@(disp,Rn) | 0001nnnnmmmmdddd | Rm → (disp + Rn) | 1 | — |
| MOV.B R0,@(disp,Rn) | 10000000nnnndddd | R0 → (disp + Rn) | 1 | — |
| MOV.W R0,@(disp,Rn) | 10000001nnnndddd | R0 → (disp × 2 + Rn) | 1 | — |
| MOV.L Rm,@(disp,Rn) | 0001nnnnmmmmdddd | Rm → (disp × 4 + Rn) | 1 | — |
| MOV.B @(disp,Rm),R0 | 10000100mmmmdddd | (disp + Rm) → Sign extension → R0 | 1 | — |
| MOV.W @(disp,Rm),R0 | 10000101mmmmdddd | (disp × 2 + Rm) → Sign extension → R0 | 1 | — |
| MOV.L @(disp,Rm),Rn | 0101nnnnmmmmdddd | (disp × 4 + Rm) → Rn | 1 | — |
| MOV.B Rm,@(R0,Rn) | 0000nnnnmmmm0100 | Rm → (R0 + Rn) | 1 | — |
| MOV.W Rm,@(R0,Rn) | 0000nnnnmmmm0101 | Rm → (R0 + Rn) | 1 | — |
| MOV.L Rm,@(R0,Rn) | 0000nnnnmmmm0110 | Rm → (R0 + Rn) | 1 | — |
| MOV.B @(R0,Rm),Rn | 0000nnnnmmmm1100 | (R0 + Rm) → Sign extension → Rn | 1 | — |
| MOV.W @(R0,Rm),Rn | 0000nnnnmmmm1101 | (R0 + Rm) → Sign extension → Rn | 1 | — |
| MOV.L @(R0,Rm),Rn | 0000nnnnmmmm1110 | (R0 + Rm) → Rn | 1 | — |
| MOV.B R0,@(disp,GBR) | 11000000dddddddd | R0 → (disp + GBR) | 1 | — |
| MOV.W R0,@(disp,GBR) | 11000001dddddddd | R0 → (disp × 2 + GBR) | 1 | — |
| MOV.L R0,@(disp,GBR) | 11000010dddddddd | R0 → (disp × 4+ GBR) | 1 | — |
| MOV.B @(disp,GBR),R0 | 11000100dddddddd | (disp + GBR) → Sign extension → R0 | 1 | — |
| MOV.W @(disp,GBR),R0 | 11000101dddddddd | (disp × 2 + GBR) → Sign extension → R0 | 1 | — |
| MOV.L @(disp,GBR),R0 | 11000110dddddddd | (disp × 4 + GBR) → R0 | 1 | — |
| MOVA @(disp,PC),R0 | 11000111dddddddd | disp × 4 + PC → R0 | 1 | — |
| MOVT Rn | 0000nnnn00101001 | T → Rn | 1 | — |
| SWAP.B Rm,Rn | 01101nnnmmmm1000 | Rm → Swap upper and lower 2 bytes → Rn | 1 | — |
| SWAP.W Rm,Rn | 01101nnnmmmm1001 | Rm → Swap upper and lower word → Rn | 1 | — |
| XTRCT Rm,Rn | 0010nnnnmmmm1101 | Center 32 bits of Rm and Rn → Rn | 1 | — |

---

### 5.1.2 Arithmetic Instructions

#### Table 5.4: Arithmetic Instructions

| Instruction | Instruction Code | Operation | Execution State | T Bit |
|-------------|------------------|-----------|-----------------|-------|
| ADD Rm,Rn | 0011nnnnmmmm1100 | Rn + Rm → Rn | 1 | — |
| ADD #imm,Rn | 0111nnnniiiiiiii | Rn + imm → Rn | 1 | — |
| ADDC Rm,Rn | 0011nnnnmmmm1110 | Rn + Rm + T → Rn, Carry → T | 1 | Carry |
| ADDV Rm,Rn | 0011nnnnmmmm1111 | Rn + Rm → Rn, Overflow → T | 1 | Overflow |
| CMP/EQ #imm,R0 | 10001000iiiiiiii | If R0 = imm, 1 → T | 1 | Comparison result |
| CMP/EQ Rm,Rn | 0011nnnnmmmm0000 | If Rn = Rm, 1 → T | 1 | Comparison result |
| CMP/HS Rm,Rn | 0011nnnnmmmm0010 | If Rn ≥Rm with unsigned data, 1 → T | 1 | Comparison result |
| CMP/GE Rm,Rn | 0011nnnnmmmm0011 | If Rn ≥ Rm with signed data, 1 → T | 1 | Comparison result |
| CMP/HI Rm,Rn | 0011nnnnmmmm0110 | If Rn > Rm with unsigned data, 1 → T | 1 | Comparison result |
| CMP/GT Rm,Rn | 0011nnnnmmmm0111 | If Rn > Rm with signed data, 1 → T | 1 | Comparison result |
| CMP/PL Rn | 0100nnnn00010101 | If Rn > 0, 1 → T | 1 | Comparison result |
| CMP/PZ Rn | 0100nnnn00010001 | If Rn ≥ 0, 1 → T | 1 | Comparison result |
| CMP/STR Rm,Rn | 0010nnnnmmmm1100 | If Rn and Rm have an equivalent byte, 1 → T | 1 | Comparison result |
| DIV1 Rm,Rn | 0011nnnnmmmm0100 | Single-step division (Rn/Rm) | 1 | Calculation result |
| DIV0S Rm,Rn | 0010nnnnmmmm0111 | MSB of Rn → Q, MSB of Rm → M, M ^ Q → T | 1 | Calculation result |
| DIV0U | 0000000000011001 | 0 → M/Q/T | 1 | 0 |
| DMULS.L Rm,Rn*² | 0011nnnnmmmm1101 | Signed operation of Rn x Rm → MACH, MACL<br>32 x 32 → 64 bits | 2 to 4*¹ | — |
| DMULU.L Rm,Rn*² | 0011nnnnmmmm0101 | Unsigned operation of Rn x Rm → MACH, MACL<br>32 x 32 → 64 bits | 2 to 4*¹ | — |
| DT Rn*² | 0100nnnn00010000 | Rn - 1 → Rn, when Rn is 0, 1 → T. When Rn is nonzero, 0 → T | 1 | Comparison result |
| EXTS.B Rm,Rn | 0110nnnnmmmm1110 | A byte in Rm is sign-extended → Rn | 1 | — |
| EXTS.W Rm,Rn | 0110nnnnmmmm1111 | A word in Rm is sign-extended → Rn | 1 | — |
| EXTU.B Rm,Rn | 0110nnnnmmmm1100 | A byte in Rm is zero-extended → Rn | 1 | — |
| EXTU.W Rm,Rn | 0110nnnnmmmm1101 | A word in Rm is zero-extended → Rn | 1 | — |
| MAC.L @Rm+,@Rn+*² | 0000nnnnmmmm1111 | Signed operation of (Rn) x (Rm) + MAC → MAC<br>32 x 32 + 64 → 64 bits | 3/(2 to 4)*¹ | — |
| MAC.W @Rm+,@Rn+ | 0100nnnnmmmm1111 | Signed operation of (Rn) x (Rm) + MAC → MAC<br>(SH-2 CPU) 16 x 16 + 64 → 64 bits<br>(SH-1 CPU) 16 x 16 + 42 → 42 bits | 3/(2)*¹ | — |
| MUL.L Rm,Rn*² | 0000nnnnmmmm0111 | Rn x Rm → MACL, 32 x 32 → 32 bits | 2 to 4*¹ | — |
| MULS.W Rm,Rn | 0010nnnnmmmm1111 | Signed operation of Rn x Rm → MAC<br>16 x 16 → 32 bits | 1 to 3*¹ | — |
| MULU.W Rm,Rn | 0010nnnnmmmm1110 | Unsigned operation of Rn x Rm → MAC<br>16 x 16 → 32 bits | 1 to 3*¹ | — |
| NEG Rm,Rn | 0110nnnnmmmm1011 | 0−Rm → Rn | 1 | — |
| NEGC Rm,Rn | 0110nnnnmmmm1010 | 0−Rm−T → Rn, Borrow → T | 1 | Borrow |
| SUB Rm,Rn | 0011nnnnmmmm1000 | Rn−Rm → Rn | 1 | — |
| SUBC Rm,Rn | 0011nnnnmmmm1010 | Rn−Rm−T → Rn, Borrow → T | 1 | Borrow |
| SUBV Rm,Rn | 0011nnnnmmmm1011 | Rn−Rm → Rn, Underflow → T | 1 | Underflow |

**Notes:**
1. The normal minimum number of execution states (The number in parentheses is the number of states when there is contention with preceding/following instructions)
2. SH-2 CPU instructions

---

### 5.1.3 Logic Operation Instructions

#### Table 5.5: Logic Operation Instructions

| Instruction | Instruction Code | Operation | Execution State | T Bit |
|-------------|------------------|-----------|-----------------|-------|
| AND Rm,Rn | 0010nnnnmmmm1001 | Rn & Rm → Rn | 1 | — |
| AND #imm,R0 | 11001001iiiiiiii | R0 & imm → R0 | 1 | — |
| AND.B #imm,@(R0,GBR) | 11001101iiiiiiii | (R0 + GBR) & imm → (R0 + GBR) | 3 | — |
| NOT Rm,Rn | 0110nnnnmmmm0111 | ~Rm → Rn | 1 | — |
| OR Rm,Rn | 0010nnnnmmmm1011 | Rn \| Rm → Rn | 1 | — |
| OR #imm,R0 | 11001011iiiiiiii | R0 \| imm → R0 | 1 | — |
| OR.B #imm,@(R0,GBR) | 11001111iiiiiiii | (R0 + GBR) \| imm → (R0 + GBR) | 3 | — |
| TAS.B @Rn | 0100nnnn00011011 | If (Rn) is 0, 1 → T; 1 → MSB of (Rn) | 4 | Test result |
| TST Rm,Rn | 0010nnnnmmmm1000 | Rn & Rm; if the result is 0, 1 → T | 1 | Test result |
| TST #imm,R0 | 11001000iiiiiiii | R0 & imm; if the result is 0, 1 → T | 1 | Test result |
| TST.B #imm,@(R0,GBR) | 11001100iiiiiiii | (R0 + GBR) & imm; if the result is 0, 1 → T | 3 | Test result |
| XOR Rm,Rn | 0010nnnnmmmm1010 | Rn ^ Rm → Rn | 1 | — |
| XOR #imm,R0 | 11001010iiiiiiii | R0 ^ imm → R0 | 1 | — |
| XOR.B #imm,@(R0,GBR) | 11001110iiiiiiii | (R0 + GBR) ^ imm → (R0 + GBR) | 3 | — |

---

### 5.1.4 Shift Instructions

#### Table 5.6: Shift Instructions

| Instruction | Instruction Code | Operation | Execution State | T Bit |
|-------------|------------------|-----------|-----------------|-------|
| ROTL Rn | 0100nnnn00000100 | T ← Rn ← MSB | 1 | MSB |
| ROTR Rn | 0100nnnn00000101 | LSB → Rn → T | 1 | LSB |
| ROTCL Rn | 0100nnnn00100100 | T ← Rn ← T | 1 | MSB |
| ROTCR Rn | 0100nnnn00100101 | T → Rn → T | 1 | LSB |
| SHAL Rn | 0100nnnn00100000 | T ← Rn ← 0 | 1 | MSB |
| SHAR Rn | 0100nnnn00100001 | MSB → Rn → T | 1 | LSB |
| SHLL Rn | 0100nnnn00000000 | T ← Rn ← 0 | 1 | MSB |
| SHLR Rn | 0100nnnn00000001 | 0 → Rn → T | 1 | LSB |
| SHLL2 Rn | 0100nnnn00001000 | Rn<<2 → Rn | 1 | — |
| SHLR2 Rn | 0100nnnn00001001 | Rn>>2 → Rn | 1 | — |
| SHLL8 Rn | 0100nnnn00011000 | Rn<<8 → Rn | 1 | — |
| SHLR8 Rn | 0100nnnn00011001 | Rn>>8 → Rn | 1 | — |
| SHLL16 Rn | 0100nnnn00101000 | Rn<<16 → Rn | 1 | — |
| SHLR16 Rn | 0100nnnn00101001 | Rn>>16 → Rn | 1 | — |

---

### 5.1.5 Branch Instructions

#### Table 5.7: Branch Instructions

| Instruction | Instruction Code | Operation | Execution State | T Bit |
|-------------|------------------|-----------|-----------------|-------|
| BF label | 10001011dddddddd | If T = 0, disp × 2 + PC → PC; if T = 1, nop (where label is disp × 2 + PC) | 3/1*³ | — |
| BF/S label*² | 10001111dddddddd | Delayed branch, if T = 0, disp × 2 + PC → PC; if T = 1, nop | 2/1*³ | — |
| BT label | 10001001dddddddd | If T = 1, disp × 2 + PC → PC; if T = 0, nop (where label is disp + PC) | 3/1*³ | — |
| BT/S label*² | 10001101dddddddd | Delayed branch, if T = 1, disp × 2 + PC → PC; if T = 0, nop | 2/1*³ | — |
| BRA label | 1010dddddddddddd | Delayed branch, disp × 2 + PC → PC | 2 | — |
| BRAF Rm*² | 0000mmmm00100011 | Delayed branch, Rm + PC → PC | 2 | — |
| BSR label | 1011dddddddddddd | Delayed branch, PC → PR, disp × 2 + PC → PC | 2 | — |
| BSRF Rm*² | 0000mmmm00000011 | Delayed branch, PC → PR, Rm + PC → PC | 2 | — |
| JMP @Rm | 0100mmmm00101011 | Delayed branch, Rm → PC | 2 | — |
| JSR @Rm | 0100mmmm00001011 | Delayed branch, PC → PR, Rm → PC | 2 | — |
| RTS | 0000000000001011 | Delayed branch, PR → PC | 2 | — |

**Notes:**
2. SH-2 CPU instruction
3. One state when it does not branch

---

### 5.1.6 System Control Instructions

#### Table 5.8: System Control Instructions

| Instruction | Instruction Code | Operation | Execution State | T Bit |
|-------------|------------------|-----------|-----------------|-------|
| CLRT | 0000000000001000 | 0 → T | 1 | 0 |
| CLRMAC | 0000000000101000 | 0 → MACH, MACL | 1 | — |
| LDC Rm,SR | 0100mmmm00001110 | Rm → SR | 1 | LSB |
| LDC Rm,GBR | 0100mmmm00011110 | Rm → GBR | 1 | — |
| LDC Rm,VBR | 0100mmmm00101110 | Rm → VBR | 1 | — |
| LDC.L @Rm+,SR | 0100mmmm00000111 | (Rm) → SR, Rm + 4 → Rm | 3 | LSB |
| LDC.L @Rm+,GBR | 0100mmmm00010111 | (Rm) → GBR, Rm + 4 → Rm | 3 | — |
| LDC.L @Rm+,VBR | 0100mmmm00100111 | (Rm) → VBR, Rm + 4 → Rm | 3 | — |
| LDS Rm,MACH | 0100mmmm00001010 | Rm → MACH | 1 | — |
| LDS Rm,MACL | 0100mmmm00011010 | Rm → MACL | 1 | — |
| LDS Rm,PR | 0100mmmm00101010 | Rm → PR | 1 | — |
| LDS.L @Rm+,MACH | 0100mmmm00000110 | (Rm) → MACH, Rm + 4 → Rm | 1 | — |
| LDS.L @Rm+,MACL | 0100mmmm00010110 | (Rm) → MACL, Rm + 4 → Rm | 1 | — |
| LDS.L @Rm+,PR | 0100mmmm00100110 | (Rm) → PR, Rm + 4 → Rm | 1 | — |
| NOP | 0000000000001001 | No operation | 1 | — |
| RTE | 0000000000101011 | Delayed branch, stack area → PC/SR | 4 | LSB |
| SETT | 0000000000011000 | 1 → T | 1 | 1 |
| SLEEP | 0000000000011011 | Sleep | 3*⁴ | — |
| STC SR,Rn | 0000nnnn00000010 | SR → Rn | 1 | — |
| STC GBR,Rn | 0000nnnn00010010 | GBR → Rn | 1 | — |
| STC VBR,Rn | 0000nnnn00100010 | VBR → Rn | 1 | — |
| STC.L SR,@−Rn | 0100nnnn00000011 | Rn−4 → Rn, SR → (Rn) | 2 | — |
| STC.L GBR,@−Rn | 0100nnnn00010011 | Rn−4 → Rn, GBR → (Rn) | 2 | — |
| STC.L VBR,@−Rn | 0100nnnn00100011 | Rn−4 → Rn, VBR → (Rn) | 2 | — |
| STS MACH,Rn | 0000nnnn00001010 | MACH → Rn | 1 | — |
| STS MACL,Rn | 0000nnnn00011010 | MACL → Rn | 1 | — |
| STS PR,Rn | 0000nnnn00101010 | PR → Rn | 1 | — |
| STS.L MACH,@−Rn | 0100nnnn00000010 | Rn−4 → Rn, MACH → (Rn) | 1 | — |
| STS.L MACL,@−Rn | 0100nnnn00010010 | Rn−4 → Rn, MACL → (Rn) | 1 | — |
| STS.L PR,@−Rn | 0100nnnn00100010 | Rn−4 → Rn, PR → (Rn) | 1 | — |
| TRAPA #imm | 11000011iiiiiiii | PC/SR → stack area, (imm × 4 + VBR) → PC | 8 | — |

**Notes:**
4. The number of execution states before the chip enters the sleep state
5. The above table lists the minimum number of execution cycles. In practice, the number of execution cycles increases when the instruction fetch is in contention with data access or when the destination register of a load instruction (memory → register) is the same as the register used by the next instruction.

---

## 5.2 Instruction Set in Alphabetical Order

Table 5.9 alphabetically lists instruction codes and number of execution cycles for each instruction.

### Table 5.9: Instruction Set

| Instruction | Instruction Code | Operation | Execution State | T Bit |
|-------------|------------------|-----------|-----------------|-------|
| ADD #imm,Rn | 0111nnnniiiiiiii | Rn + imm → Rn | 1 | — |
| ADD Rm,Rn | 0011nnnnmmmm1100 | Rn + Rm → Rn | 1 | — |
| ADDC Rm,Rn | 0011nnnnmmmm1110 | Rn + Rm + T → Rn, Carry → T | 1 | Carry |
| ADDV Rm,Rn | 0011nnnnmmmm1111 | Rn + Rm → Rn, Overflow → T | 1 | Overflow |
| AND #imm,R0 | 11001001iiiiiiii | R0 & imm → R0 | 1 | — |
| AND Rm,Rn | 0010nnnnmmmm1001 | Rn & Rm → Rn | 1 | — |
| AND.B #imm,@(R0,GBR) | 11001101iiiiiiii | (R0 + GBR) & imm → (R0 + GBR) | 3 | — |
| BF label | 10001011dddddddd | If T = 0, disp × 2 + PC → PC; If T = 1, nop | 3/1*³ | — |
| BF/S label*² | 10001111dddddddd | If T = 0, disp × 2+ PC → PC; If T = 1, nop | 2/1*³ | — |
| BRA label | 1010dddddddddddd | Delayed branch, disp × 2 + PC → PC | 2 | — |
| BRAF Rm*² | 0000mmmm00100011 | Delayed branch, Rm + PC → PC | 2 | — |
| BSR label | 1011dddddddddddd | Delayed branch, PC → PR, disp × 2 + PC → PC | 2 | — |
| BSRF Rm*² | 0000mmmm00000011 | Delayed branch, PC → PR, Rm + PC → PC | 2 | — |
| BT label | 10001001dddddddd | If T = 1, disp × 2+ PC → PC; if T = 0, nop | 3/1*³ | — |
| BT/S label*² | 10001101dddddddd | If T = 1, disp × 2 + PC → PC; if T = 0, nop | 2/1*³ | — |
| CLRMAC | 0000000000101000 | 0 → MACH, MACL | 1 | — |
| CLRT | 0000000000001000 | 0 → T | 1 | 0 |
| CMP/EQ #imm,R0 | 10001000iiiiiiii | If R0 = imm, 1 → T | 1 | Comparison result |
| CMP/EQ Rm,Rn | 0011nnnnmmmm0000 | If Rn = Rm, 1 → T | 1 | Comparison result |
| CMP/GE Rm,Rn | 0011nnnnmmmm0011 | If Rn ≥ Rm with signed data, 1 → T | 1 | Comparison result |
| CMP/GT Rm,Rn | 0011nnnnmmmm0111 | If Rn > Rm with signed data, 1 → T | 1 | Comparison result |
| CMP/HI Rm,Rn | 0011nnnnmmmm0110 | If Rn > Rm with unsigned data, 1 → T | 1 | Comparison result |
| CMP/HS Rm,Rn | 0011nnnnmmmm0010 | If Rn ≥ Rm with unsigned data, 1 → T | 1 | Comparison result |
| CMP/PL Rn | 0100nnnn00010101 | If Rn>0, 1 → T | 1 | Comparison result |
| CMP/PZ Rn | 0100nnnn00010001 | If Rn ≥ 0, 1 → T | 1 | Comparison result |
| CMP/STR Rm,Rn | 0010nnnnmmmm1100 | If Rn and Rm have an equivalent byte, 1 → T | 1 | Comparison result |
| DIV0S Rm,Rn | 0010nnnnmmmm0111 | MSB of Rn → Q, MSB of Rm → M, M ^ Q → T | 1 | Calculation result |
| DIV0U | 0000000000011001 | 0 → M/Q/T | 1 | 0 |
| DIV1 Rm,Rn | 0011nnnnmmmm0100 | Single-step division (Rn/Rm) | 1 | Calculation result |
| DMULS.L Rm,Rn*² | 0011nnnnmmmm1101 | Signed operation of Rn x Rm → MACH, MACL | 2 to 4*¹ | — |
| DMULU.L Rm,Rn*² | 0011nnnnmmmm0101 | Unsigned operation of Rn x Rm → MACH, MACL | 2 to 4*¹ | — |
| DT Rn*² | 0100nnnn00010000 | Rn - 1 → Rn, when Rn is 0, 1 → T. When Rn is nonzero, 0 → T | 1 | Comparison result |
| EXTS.B Rm,Rn | 0110nnnnmmmm1110 | A byte in Rm is sign-extended → Rn | 1 | — |
| EXTS.W Rm,Rn | 0110nnnnmmmm1111 | A word in Rm is sign-extended → Rn | 1 | — |
| EXTU.B Rm,Rn | 0110nnnnmmmm1100 | A byte in Rm is zero-extended → Rn | 1 | — |
| EXTU.W Rm,Rn | 0110nnnnmmmm1101 | A word in Rm is zero-extended → Rn | 1 | — |
| JMP @Rm | 0100mmmm00101011 | Delayed branch, Rm → PC | 2 | — |
| JSR @Rm | 0100mmmm00001011 | Delayed branch, PC → PR, Rm → PC | 2 | — |
| LDC Rm,GBR | 0100mmmm00011110 | Rm → GBR | 1 | — |
| LDC Rm,SR | 0100mmmm00001110 | Rm → SR | 1 | LSB |
| LDC Rm,VBR | 0100mmmm00101110 | Rm → VBR | 1 | — |
| LDC.L @Rm+,GBR | 0100mmmm00010111 | (Rm) → GBR, Rm + 4 → Rm | 3 | — |
| LDC.L @Rm+,SR | 0100mmmm00000111 | (Rm) → SR, Rm + 4 → Rm | 3 | LSB |
| LDC.L @Rm+,VBR | 0100mmmm00100111 | (Rm) → VBR, Rm + 4 → Rm | 3 | — |
| LDS Rm,MACH | 0100mmmm00001010 | Rm → MACH | 1 | — |
| LDS Rm,MACL | 0100mmmm00011010 | Rm → MACL | 1 | — |
| LDS Rm,PR | 0100mmmm00101010 | Rm → PR | 1 | — |
| LDS.L @Rm+,MACH | 0100mmmm00000110 | (Rm) → MACH, Rm + 4 → Rm | 1 | — |
| LDS.L @Rm+,MACL | 0100mmmm00010110 | (Rm) → MACL, Rm + 4 → Rm | 1 | — |
| LDS.L @Rm+,PR | 0100mmmm00100110 | (Rm) → PR, Rm + 4 → Rm | 1 | — |
| MAC.L @Rm+,@Rn+*² | 0000nnnnmmmm1111 | Signed operation of (Rn) x (Rm) + MAC → MAC | 3/(2 to 4)*¹ | — |
| MAC.W @Rm+,@Rn+ | 0100nnnnmmmm1111 | Signed operation of (Rn) x (Rm) + MAC → MAC | 3/(2)*¹ | — |
| MOV #imm,Rn | 1110nnnniiiiiiii | imm → Sign extension → Rn | 1 | — |
| MOV Rm,Rn | 0110nnnnmmmm0011 | Rm → Rn | 1 | — |
| MOV.B @(disp,GBR),R0 | 11000100dddddddd | (disp + GBR) → Sign extension → R0 | 1 | — |
| MOV.B @(disp,Rm),R0 | 10000100mmmmdddd | (disp + Rm) → Sign extension → R0 | 1 | — |
| MOV.B @(R0,Rm),Rn | 0000nnnnmmmm1100 | (R0 + Rm) → Sign extension → Rn | 1 | — |
| MOV.B @Rm+,Rn | 0110nnnnmmmm0100 | (Rm) → Sign extension → Rn, Rm + 1 → Rm | 1 | — |
| MOV.B @Rm,Rn | 0110nnnnmmmm0000 | (Rm) → Sign extension → Rn | 1 | — |
| MOV.B R0,@(disp,GBR) | 11000000dddddddd | R0 → (disp + GBR) | 1 | — |
| MOV.B R0,@(disp,Rn) | 10000000nnnndddd | R0 → (disp + Rn) | 1 | — |
| MOV.B Rm,@(R0,Rn) | 0000nnnnmmmm0100 | Rm → (R0 + Rn) | 1 | — |
| MOV.B Rm,@−Rn | 0010nnnnmmmm0100 | Rn−1 → Rn, Rm → (Rn) | 1 | — |
| MOV.B Rm,@Rn | 0010nnnnmmmm0000 | Rm → (Rn) | 1 | — |
| MOV.L @(disp,GBR),R0 | 11000110dddddddd | (disp × 4 + GBR) → R0 | 1 | — |
| MOV.L @(disp,PC),Rn | 1101nnnndddddddd | (disp × 4 + PC) → Rn | 1 | — |
| MOV.L @(disp,Rm),Rn | 0101nnnnmmmmdddd | (disp × 4 + Rm) → Rn | 1 | — |
| MOV.L @(R0,Rm),Rn | 0000nnnnmmmm1110 | (R0 + Rm) → Rn | 1 | — |
| MOV.L @Rm+,Rn | 0110nnnnmmmm0110 | (Rm) → Rn, Rm + 4 → Rm | 1 | — |
| MOV.L @Rm,Rn | 0110nnnnmmmm0010 | (Rm) → Rn | 1 | — |
| MOV.L R0,@(disp,GBR) | 11000010dddddddd | R0 → (disp × 4 + GBR) | 1 | — |
| MOV.L Rm,@(disp,Rn) | 0001nnnnmmmmdddd | Rm → (disp × 4 + Rn) | 1 | — |
| MOV.L Rm,@(R0,Rn) | 0000nnnnmmmm0110 | Rm → (R0 + Rn) | 1 | — |
| MOV.L Rm,@−Rn | 0010nnnnmmmm0110 | Rn−4 → Rn, Rm → (Rn) | 1 | — |
| MOV.L Rm,@Rn | 0010nnnnmmmm0010 | Rm → (Rn) | 1 | — |
| MOV.W @(disp,GBR),R0 | 11000101dddddddd | (disp × 2 + GBR) → Sign extension → R0 | 1 | — |
| MOV.W @(disp,PC),Rn | 1001nnnndddddddd | (disp × 2 + PC) → Sign extension → Rn | 1 | — |
| MOV.W @(disp,Rm),R0 | 10000101mmmmdddd | (disp × 2 + Rm) → Sign extension → R0 | 1 | — |
| MOV.W @(R0,Rm),Rn | 0000nnnnmmmm1101 | (R0 + Rm) → Sign extension → Rn | 1 | — |
| MOV.W @Rm+,Rn | 0110nnnnmmmm0101 | (Rm) → Sign extension → Rn, Rm + 2 → Rm | 1 | — |
| MOV.W @Rm,Rn | 0110nnnnmmmm0001 | (Rm) → Sign extension → Rn | 1 | — |
| MOV.W R0,@(disp,GBR) | 11000001dddddddd | R0 → (disp × 2+ GBR) | 1 | — |
| MOV.W R0,@(disp,Rn) | 10000001nnnndddd | R0 → (disp × 2 + Rn) | 1 | — |
| MOV.W Rm,@(R0,Rn) | 0000nnnnmmmm0101 | Rm → (R0 + Rn) | 1 | — |
| MOV.W Rm,@−Rn | 0010nnnnmmmm0101 | Rn−2 → Rn, Rm → (Rn) | 1 | — |
| MOV.W Rm,@Rn | 0010nnnnmmmm0001 | Rm → (Rn) | 1 | — |
| MOVA @(disp,PC),R0 | 11000111dddddddd | disp × 4 + PC → R0 | 1 | — |
| MOVT Rn | 0000nnnn00101001 | T → Rn | 1 | — |
| MUL.L Rm,Rn*² | 0000nnnnmmmm0111 | Rn x Rm → MACL | 2 to 4*¹ | — |
| MULS.W Rm,Rn | 0010nnnnmmmm1111 | Signed operation of Rn x Rm → MAC | 1 to 3*¹ | — |
| MULU.W Rm,Rn | 0010nnnnmmmm1110 | Unsigned operation of Rn x Rm → MAC | 1 to 3*¹ | — |
| NEG Rm,Rn | 0110nnnnmmmm1011 | 0−Rm → Rn | 1 | — |
| NEGC Rm,Rn | 0110nnnnmmmm1010 | 0−Rm−T → Rn, Borrow → T | 1 | Borrow |
| NOP | 0000000000001001 | No operation | 1 | — |
| NOT Rm,Rn | 0110nnnnmmmm0111 | ~Rm → Rn | 1 | — |
| OR #imm,R0 | 11001011iiiiiiii | R0 \| imm → R0 | 1 | — |
| OR Rm,Rn | 0010nnnnmmmm1011 | Rn \| Rm → Rn | 1 | — |
| OR.B #imm,@(R0,GBR) | 11001111iiiiiiii | (R0 + GBR) \| imm → (R0 + GBR) | 3 | — |
| ROTCL Rn | 0100nnnn00100100 | T ← Rn ← T | 1 | MSB |
| ROTCR Rn | 0100nnnn00100101 | T → Rn → T | 1 | LSB |
| ROTL Rn | 0100nnnn00000100 | T ← Rn ← MSB | 1 | MSB |
| ROTR Rn | 0100nnnn00000101 | LSB → Rn → T | 1 | LSB |
| RTE | 0000000000101011 | Delayed branch, stack area → PC/SR | 4 | LSB |
| RTS | 0000000000001011 | Delayed branch, PR → PC | 2 | — |
| SETT | 0000000000011000 | 1 → T | 1 | 1 |
| SHAL Rn | 0100nnnn00100000 | T ← Rn ← 0 | 1 | MSB |
| SHAR Rn | 0100nnnn00100001 | MSB → Rn → T | 1 | LSB |
| SHLL Rn | 0100nnnn00000000 | T ← Rn ← 0 | 1 | MSB |
| SHLL2 Rn | 0100nnnn00001000 | Rn<<2 → Rn | 1 | — |
| SHLL8 Rn | 0100nnnn00011000 | Rn<<8 → Rn | 1 | — |
| SHLL16 Rn | 0100nnnn00101000 | Rn<<16 → Rn | 1 | — |
| SHLR Rn | 0100nnnn00000001 | 0 → Rn → T | 1 | LSB |
| SHLR2 Rn | 0100nnnn00001001 | Rn>>2 → Rn | 1 | — |
| SHLR8 Rn | 0100nnnn00011001 | Rn>>8 → Rn | 1 | — |
| SHLR16 Rn | 0100nnnn00101001 | Rn>>16 → Rn | 1 | — |
| SLEEP | 0000000000011011 | Sleep | 3*⁴ | — |
| STC GBR,Rn | 0000nnnn00010010 | GBR → Rn | 1 | — |
| STC SR,Rn | 0000nnnn00000010 | SR → Rn | 1 | — |
| STC VBR,Rn | 0000nnnn00100010 | VBR → Rn | 1 | — |
| STC.L GBR,@−Rn | 0100nnnn00010011 | Rn−4 → Rn, GBR → (Rn) | 2 | — |
| STC.L SR,@−Rn | 0100nnnn00000011 | Rn−4 → Rn, SR → (Rn) | 2 | — |
| STC.L VBR,@−Rn | 0100nnnn00100011 | Rn−4 → Rn, VBR → (Rn) | 2 | — |
| STS MACH,Rn | 0000nnnn00001010 | MACH → Rn | 1 | — |
| STS MACL,Rn | 0000nnnn00011010 | MACL → Rn | 1 | — |
| STS PR,Rn | 0000nnnn00101010 | PR → Rn | 1 | — |
| STS.L MACH,@−Rn | 0100nnnn00000010 | Rn−4 → Rn, MACH → (Rn) | 1 | — |
| STS.L MACL,@−Rn | 0100nnnn00010010 | Rn−4 → Rn, MACL → (Rn) | 1 | — |
| STS.L PR,@−Rn | 0100nnnn00100010 | Rn−4 → Rn, PR → (Rn) | 1 | — |
| SUB Rm,Rn | 0011nnnnmmmm1000 | Rn−Rm → Rn | 1 | — |
| SUBC Rm,Rn | 0011nnnnmmmm1010 | Rn−Rm−T → Rn, Borrow → T | 1 | Borrow |
| SUBV Rm,Rn | 0011nnnnmmmm1011 | Rn−Rm → Rn, Underflow → T | 1 | Underflow |
| SWAP.B Rm,Rn | 0110nnnnmmmm1000 | Rm → Swap upper and lower 2 bytes→ Rn | 1 | — |
| SWAP.W Rm,Rn | 0110nnnnmmmm1001 | Rm → Swap upper and lower word → Rn | 1 | — |
| TAS.B @Rn | 0100nnnn00011011 | If (Rn) is 0, 1 → T; 1 → MSB of (Rn) | 4 | Test result |
| TRAPA #imm | 11000011iiiiiiii | PC/SR → stack area, (imm × 4 + VBR) → PC | 8 | — |
| TST #imm,R0 | 11001000iiiiiiii | R0 & imm; if the result is 0, 1 → T | 1 | Test result |
| TST Rm,Rn | 0010nnnnmmmm1000 | Rn & Rm; if the result is 0, 1 → T | 1 | Test result |
| TST.B #imm,@(R0,GBR) | 11001100iiiiiiii | (R0 + GBR) & imm; if the result is 0, 1 → T | 3 | Test result |
| XOR #imm,R0 | 11001010iiiiiiii | R0 ^ imm → R0 | 1 | — |
| XOR Rm,Rn | 0010nnnnmmmm1010 | Rn ^ Rm → Rn | 1 | — |
| XOR.B #imm,@(R0,GBR) | 11001110iiiiiiii | (R0 + GBR) ^ imm → (R0 + GBR) | 3 | — |
| XTRCT Rm,Rn | 0010nnnnmmmm1101 | Center 32 bits of Rm and Rn → Rn | 1 | — |

**Notes:**
1. The normal minimum number of execution states (the number in parentheses is the number of states when there is contention with preceding/following instructions)
2. SH-2 CPU instructions
3. One state when it does not branch
4. The number of execution states before the chip enters the sleep state

---

## Appendix A: Instruction Code

See "6. Instruction Descriptions" for details.

### A.1 Instruction Set by Addressing Mode

Table A.1 lists instruction codes and execution states by addressing modes.

**Table A.1 Instruction Set by Addressing Mode**

| Addressing Mode | Category | Sample Instruction | | SH-2 Types | SH-1 Types |
|---|---|---|---|---|---|
| No operand | -- | `NOP` | | 8 | 8 |
| Direct register addressing | Destination operand only | `MOVT` | `Rn` | 18 | 17 |
| | Source and destination operand | `ADD` | `Rm,Rn` | 34 | 31 |
| | Load and store with control register or system register | `LDC` | `Rm,SR` | 12 | 12 |
| | | `STS` | `MACH,Rn` | | |
| Indirect register addressing | Source operand only | `JMP` | `@Rm` | 2 | 2 |
| | Destination operand only | `TAS.B` | `@Rn` | 1 | 1 |
| | Data transfer with direct register addressing | `MOV.L` | `Rm,@Rn` | 6 | 6 |
| Post increment indirect register addressing | Multiply/accumulate operation | `MAC.W` | `@Rm+,@Rn+` | 2 | 1 |
| | Data transfer from direct register addressing | `MOV.L` | `@Rm+,Rn` | 3 | 3 |
| | Load to control register or system register | `LDC.L` | `@Rm+,SR` | 6 | 6 |
| Pre decrement indirect register addressing | Data transfer from direct register addressing | `MOV.L` | `Rm,@-Rn` | 3 | 3 |
| | Store from control register or system register | `STC.L` | `SR,@-Rn` | 6 | 6 |
| Indirect register addressing with displacement | Data transfer with direct register addressing | `MOV.L` | `Rm,@(disp,Rn)` | 6 | 6 |
| Indirect indexed register addressing | Data transfer with direct register addressing | `MOV.L` | `Rm,@(R0,Rn)` | 6 | 6 |
| Indirect GBR addressing with displacement | Data transfer with direct register addressing | `R,@(disp,GBR)` | | 6 | 6 |
| Indirect indexed GBR addressing | Immediate data transfer | `AND.B` | `#imm,@(R0,GBR)` | 4 | 4 |
| PC relative addressing with displacement | Data transfer to direct register addressing | `MOV.L` | `@(disp,PC),Rn` | 3 | 3 |
| PC relative addressing with Rm | Branch instruction | `BRAF` | `Rm` | 2 | 0 |
| PC relative addressing | Branch instruction | `BRA` | `label` | 6 | 4 |
| Immediate addressing | Arithmetic logical operations with direct register addressing | `ADD` | `#imm,Rn` | 7 | 7 |
| | Specify exception processing vector | `TRAPA` | `#imm` | 1 | 1 |
| | | | **Total:** | **142** | **133** |

#### A.1.1 No Operand

**Table A.2 No Operand**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `CLRT` | 0000000000001000 | 0 -> T | 1 | 0 |
| `CLRMAC` | 0000000000101000 | 0 -> MACH, MACL | 1 | -- |
| `DIV0U` | 0000000000011001 | 0 -> M/Q/T | 1 | 0 |
| `NOP` | 0000000000001001 | No operation | 1 | -- |
| `RTE` | 0000000000101011 | Delayed branch, Stack area -> PC/SR | 4 | LSB |
| `RTS` | 0000000000001011 | Delayed branch, PR -> PC | 2 | -- |
| `SETT` | 0000000000011000 | 1 -> T | 1 | 1 |
| `SLEEP` | 0000000000011011 | Sleep | 3 | -- |

#### A.1.2 Direct Register Addressing

**Table A.3 Destination Operand Only**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `CMP/PL Rn` | 0100nnnn00010101 | Rn > 0, 1 -> T | 1 | Comparison result |
| `CMP/PZ Rn` | 0100nnnn00010001 | Rn >= 0, 1 -> T | 1 | Comparison result |
| `DT Rn` | 0100nnnn00010000 | Rn - 1 -> Rn; if Rn is 0, 1 -> T; if Rn is nonzero, 0 -> T | 1 | Comparison result |
| `MOVT Rn` | 0000nnnn00101001 | T -> Rn | 1 | -- |
| `ROTL Rn` | 0100nnnn00000100 | T <- Rn <- MSB | 1 | MSB |
| `ROTR Rn` | 0100nnnn00000101 | LSB -> Rn -> T | 1 | LSB |
| `ROTCL Rn` | 0100nnnn00100100 | T <- Rn <- T | 1 | MSB |
| `ROTCR Rn` | 0100nnnn00100101 | T -> Rn -> T | 1 | LSB |
| `SHAL Rn` | 0100nnnn00100000 | T <- Rn <- 0 | 1 | MSB |
| `SHAR Rn` | 0100nnnn00100001 | MSB -> Rn -> T | 1 | LSB |
| `SHLL Rn` | 0100nnnn00000000 | T <- Rn <- 0 | 1 | MSB |
| `SHLR Rn` | 0100nnnn00000001 | 0 -> Rn -> T | 1 | LSB |
| `SHLL2 Rn` | 0100nnnn00001000 | Rn<<2 -> Rn | 1 | -- |
| `SHLR2 Rn` | 0100nnnn00001001 | Rn>>2 -> Rn | 1 | -- |
| `SHLL8 Rn` | 0100nnnn00011000 | Rn<<8 -> Rn | 1 | -- |
| `SHLR8 Rn` | 0100nnnn00011001 | Rn>>8 -> Rn | 1 | -- |
| `SHLL16 Rn` | 0100nnnn00101000 | Rn<<16 -> Rn | 1 | -- |
| `SHLR16 Rn` | 0100nnnn00101001 | Rn>>16 -> Rn | 1 | -- |

Note: DT is SH-2 CPU instruction

**Table A.4 Source and Destination Operand**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `ADD Rm,Rn` | 0011nnnnmmmm1100 | Rn + Rm -> Rn | 1 | -- |
| `ADDC Rm,Rn` | 0011nnnnmmmm1110 | Rn + Rm + T -> Rn, carry -> T | 1 | Carry |
| `ADDV Rm,Rn` | 0011nnnnmmmm1111 | Rn + Rm -> Rn, overflow -> T | 1 | Overflow |
| `AND Rm,Rn` | 0010nnnnmmmm1001 | Rn & Rm -> Rn | 1 | -- |
| `CMP/EQ Rm,Rn` | 0011nnnnmmmm0000 | When Rn = Rm, 1 -> T | 1 | Comparison result |
| `CMP/HS Rm,Rn` | 0011nnnnmmmm0010 | When unsigned and Rn >= Rm, 1 -> T | 1 | Comparison result |
| `CMP/GE Rm,Rn` | 0011nnnnmmmm0011 | When signed and Rn >= Rm, 1 -> T | 1 | Comparison result |
| `CMP/HI Rm,Rn` | 0011nnnnmmmm0110 | When unsigned and Rn > Rm, 1 -> T | 1 | Comparison result |
| `CMP/GT Rm,Rn` | 0011nnnnmmmm0111 | When signed and Rn > Rm, 1 -> T | 1 | Comparison result |
| `CMP/STR Rm,Rn` | 0010nnnnmmmm1100 | When a byte in Rn equals bytes in Rm, 1 -> T | 1 | Comparison result |
| `DIV1 Rm,Rn` | 0011nnnnmmmm0100 | 1-step division (Rn / Rm) | 1 | Calculation result |
| `DIV0S Rm,Rn` | 0010nnnnmmmm0111 | MSB of Rn -> Q, MSB of Rm -> M, M ^ Q -> T | 1 | Calculation result |
| `DMULS.L Rm,Rn`\* | 0011nnnnmmmm1101 | Signed, Rn x Rm -> MACH, MACL | 2 to 4 | -- |
| `DMULU.L Rm,Rn`\* | 0011nnnnmmmm0101 | Unsigned, Rn x Rm -> MACH, MACL | 2 to 4 | -- |
| `EXTS.B Rm,Rn` | 0110nnnnmmmm1110 | Sign-extends Rm from byte -> Rn | 1 | -- |
| `EXTS.W Rm,Rn` | 0110nnnnmmmm1111 | Sign-extends Rm from word -> Rn | 1 | -- |
| `EXTU.B Rm,Rn` | 0110nnnnmmmm1100 | Zero-extends Rm from byte -> Rn | 1 | -- |
| `EXTU.W Rm,Rn` | 0110nnnnmmmm1101 | Zero-extends Rm from word -> Rn | 1 | -- |
| `MOV Rm,Rn` | 0110nnnnmmmm0011 | Rm -> Rn | 1 | -- |
| `MUL.L Rm,Rn`\* | 0000nnnnmmmm0111 | Rn x Rm -> MACL | 2 to 4 | -- |
| `MULS.W Rm,Rn` | 0010nnnnmmmm1111 | Signed, Rn x Rm -> MAC | 1 to 3 | -- |
| `MULU.W Rm,Rn` | 0010nnnnmmmm1110 | Unsigned, Rn x Rm -> MAC | 1 to 3 | -- |
| `NEG Rm,Rn` | 0110nnnnmmmm1011 | 0 - Rm -> Rn | 1 | -- |
| `NEGC Rm,Rn` | 0110nnnnmmmm1010 | 0 - Rm - T -> Rn, Borrow -> T | 1 | Borrow |
| `NOT Rm,Rn` | 0110nnnnmmmm0111 | ~Rm -> Rn | 1 | -- |
| `OR Rm,Rn` | 0010nnnnmmmm1011 | Rn \| Rm -> Rn | 1 | -- |
| `SUB Rm,Rn` | 0011nnnnmmmm1000 | Rn - Rm -> Rn | 1 | -- |
| `SUBC Rm,Rn` | 0011nnnnmmmm1010 | Rn - Rm - T -> Rn, Borrow -> T | 1 | Borrow |
| `SUBV Rm,Rn` | 0011nnnnmmmm1011 | Rn - Rm -> Rn, Underflow -> T | 1 | Underflow |
| `SWAP.B Rm,Rn` | 0110nnnnmmmm1000 | Rm -> Swap upper and lower halves of lower 2 bytes -> Rn | 1 | -- |
| `SWAP.W Rm,Rn` | 0110nnnnmmmm1001 | Rm -> Swap upper and lower word -> Rn | 1 | -- |
| `TST Rm,Rn` | 0010nnnnmmmm1000 | Rn & Rm, when result is 0, 1 -> T | 1 | Test results |
| `XOR Rm,Rn` | 0010nnnnmmmm1010 | Rn ^ Rm -> Rn | 1 | -- |
| `XTRCT Rm,Rn` | 0010nnnnmmmm1101 | Center 32 bits of Rm and Rn -> Rn | 1 | -- |

Notes: \* SH-2 CPU instruction. State counts are the normal minimum number of execution states.

**Table A.5 Load and Store with Control Register or System Register**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `LDC Rm,SR` | 0100mmmm00001110 | Rm -> SR | 1 | LSB |
| `LDC Rm,GBR` | 0100mmmm00011110 | Rm -> GBR | 1 | -- |
| `LDC Rm,VBR` | 0100mmmm00101110 | Rm -> VBR | 1 | -- |
| `LDS Rm,MACH` | 0100mmmm00001010 | Rm -> MACH | 1 | -- |
| `LDS Rm,MACL` | 0100mmmm00011010 | Rm -> MACL | 1 | -- |
| `LDS Rm,PR` | 0100mmmm00101010 | Rm -> PR | 1 | -- |
| `STC SR,Rn` | 0000nnnn00000010 | SR -> Rn | 1 | -- |
| `STC GBR,Rn` | 0000nnnn00010010 | GBR -> Rn | 1 | -- |
| `STC VBR,Rn` | 0000nnnn00100010 | VBR -> Rn | 1 | -- |
| `STS MACH,Rn` | 0000nnnn00001010 | MACH -> Rn | 1 | -- |
| `STS MACL,Rn` | 0000nnnn00011010 | MACL -> Rn | 1 | -- |
| `STS PR,Rn` | 0000nnnn00101010 | PR -> Rn | 1 | -- |

#### A.1.3 Indirect Register Addressing

**Table A.6 Destination Operand Only**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `JMP @Rm` | 0100mmmm00101011 | Delayed branch, Rm -> PC | 2 | -- |
| `JSR @Rm` | 0100mmmm00001011 | Delayed branch, PC -> PR, Rm -> PC | 2 | -- |
| `TAS.B @Rn` | 0100nnnn00011011 | When (Rn) is 0, 1 -> T, 1 -> MSB of (Rn) | 4 | Test results |

**Table A.7 Data Transfer with Direct Register Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B Rm,@Rn` | 0010nnnnmmmm0000 | Rm -> (Rn) | 1 | -- |
| `MOV.W Rm,@Rn` | 0010nnnnmmmm0001 | Rm -> (Rn) | 1 | -- |
| `MOV.L Rm,@Rn` | 0010nnnnmmmm0010 | Rm -> (Rn) | 1 | -- |
| `MOV.B @Rm,Rn` | 0110nnnnmmmm0000 | (Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.W @Rm,Rn` | 0110nnnnmmmm0001 | (Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.L @Rm,Rn` | 0110nnnnmmmm0010 | (Rm) -> Rn | 1 | -- |

#### A.1.4 Post Increment Indirect Register Addressing

**Table A.8 Multiply/Accumulate Operation**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MAC.L @Rm+,@Rn+`\* | 0000nnnnmmmm1111 | Signed, (Rn) x (Rm) + MAC -> MAC | 3/(2 to 4) | -- |
| `MAC.W @Rm+,@Rn+` | 0100nnnnmmmm1111 | Signed, (Rn) x (Rm) + MAC -> MAC | 3/(2) | -- |

Notes: \* SH-2 CPU instruction. The number in parentheses is the number of states when there is contention with preceding/following instructions.

**Table A.9 Data Transfer from Direct Register Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B @Rm+,Rn` | 0110nnnnmmmm0100 | (Rm) -> sign extension -> Rn, Rm + 1 -> Rm | 1 | -- |
| `MOV.W @Rm+,Rn` | 0110nnnnmmmm0101 | (Rm) -> sign extension -> Rn, Rm + 2 -> Rm | 1 | -- |
| `MOV.L @Rm+,Rn` | 0110nnnnmmmm0110 | (Rm) -> Rn, Rm + 4 -> Rm | 1 | -- |

**Table A.10 Load to Control Register or System Register**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `LDC.L @Rm+,SR` | 0100mmmm00000111 | (Rm) -> SR, Rm + 4 -> Rm | 3 | LSB |
| `LDC.L @Rm+,GBR` | 0100mmmm00010111 | (Rm) -> GBR, Rm + 4 -> Rm | 3 | -- |
| `LDC.L @Rm+,VBR` | 0100mmmm00100111 | (Rm) -> VBR, Rm + 4 -> Rm | 3 | -- |
| `LDS.L @Rm+,MACH` | 0100mmmm00000110 | (Rm) -> MACH, Rm + 4 -> Rm | 1 | -- |
| `LDS.L @Rm+,MACL` | 0100mmmm00010110 | (Rm) -> MACL, Rm + 4 -> Rm | 1 | -- |
| `LDS.L @Rm+,PR` | 0100mmmm00100110 | (Rm) -> PR, Rm + 4 -> Rm | 1 | -- |

#### A.1.5 Pre Decrement Indirect Register Addressing

**Table A.11 Data Transfer from Direct Register Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B Rm,@-Rn` | 0010nnnnmmmm0100 | Rn - 1 -> Rn, Rm -> (Rn) | 1 | -- |
| `MOV.W Rm,@-Rn` | 0010nnnnmmmm0101 | Rn - 2 -> Rn, Rm -> (Rn) | 1 | -- |
| `MOV.L Rm,@-Rn` | 0010nnnnmmmm0110 | Rn - 4 -> Rn, Rm -> (Rn) | 1 | -- |

**Table A.12 Store from Control Register or System Register**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `STC.L SR,@-Rn` | 0100nnnn00000011 | Rn - 4 -> Rn, SR -> (Rn) | 2 | -- |
| `STC.L GBR,@-Rn` | 0100nnnn00010011 | Rn - 4 -> Rn, GBR -> (Rn) | 2 | -- |
| `STC.L VBR,@-Rn` | 0100nnnn00100011 | Rn - 4 -> Rn, VBR -> (Rn) | 2 | -- |
| `STS.L MACH,@-Rn` | 0100nnnn00000010 | Rn - 4 -> Rn, MACH -> (Rn) | 1 | -- |
| `STS.L MACL,@-Rn` | 0100nnnn00010010 | Rn - 4 -> Rn, MACL -> (Rn) | 1 | -- |
| `STS.L PR,@-Rn` | 0100nnnn00100010 | Rn - 4 -> Rn, PR -> (Rn) | 1 | -- |

#### A.1.6 Indirect Register Addressing with Displacement

**Table A.13 Indirect Register Addressing with Displacement**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B R0,@(disp,Rn)` | 10000000nnnndddd | R0 -> (disp + Rn) | 1 | -- |
| `MOV.W R0,@(disp,Rn)` | 10000001nnnndddd | R0 -> (disp x 2 + Rn) | 1 | -- |
| `MOV.L Rm,@(disp,Rn)` | 0001nnnnmmmmdddd | Rm -> (disp x 4 + Rn) | 1 | -- |
| `MOV.B @(disp,Rm),R0` | 10000100mmmmdddd | (disp + Rm) -> sign extension -> R0 | 1 | -- |
| `MOV.W @(disp,Rm),R0` | 10000101mmmmdddd | (disp x 2 + Rm) -> sign extension -> R0 | 1 | -- |
| `MOV.L @(disp,Rm),Rn` | 0101nnnnmmmmdddd | (disp x 4 + Rm) -> Rn | 1 | -- |

#### A.1.7 Indirect Indexed Register Addressing

**Table A.14 Indirect Indexed Register Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B Rm,@(R0,Rn)` | 0000nnnnmmmm0100 | Rm -> (R0 + Rn) | 1 | -- |
| `MOV.W Rm,@(R0,Rn)` | 0000nnnnmmmm0101 | Rm -> (R0 + Rn) | 1 | -- |
| `MOV.L Rm,@(R0,Rn)` | 0000nnnnmmmm0110 | Rm -> (R0 + Rn) | 1 | -- |
| `MOV.B @(R0,Rm),Rn` | 0000nnnnmmmm1100 | (R0 + Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.W @(R0,Rm),Rn` | 0000nnnnmmmm1101 | (R0 + Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.L @(R0,Rm),Rn` | 0000nnnnmmmm1110 | (R0 + Rm) -> Rn | 1 | -- |

#### A.1.8 Indirect GBR Addressing with Displacement

**Table A.15 Indirect GBR Addressing with Displacement**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B R0,@(disp,GBR)` | 11000000dddddddd | R0 -> (disp + GBR) | 1 | -- |
| `MOV.W R0,@(disp,GBR)` | 11000001dddddddd | R0 -> (disp x 2 + GBR) | 1 | -- |
| `MOV.L R0,@(disp,GBR)` | 11000010dddddddd | R0 -> (disp x 4 + GBR) | 1 | -- |
| `MOV.B @(disp,GBR),R0` | 11000100dddddddd | (disp + GBR) -> sign extension -> R0 | 1 | -- |
| `MOV.W @(disp,GBR),R0` | 11000101dddddddd | (disp x 2 + GBR) -> sign extension -> R0 | 1 | -- |
| `MOV.L @(disp,GBR),R0` | 11000110dddddddd | (disp x 4 + GBR) -> R0 | 1 | -- |

#### A.1.9 Indirect Indexed GBR Addressing

**Table A.16 Indirect Indexed GBR Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `AND.B #imm,@(R0,GBR)` | 11001101iiiiiiii | (R0 + GBR) & imm -> (R0 + GBR) | 3 | -- |
| `OR.B #imm,@(R0,GBR)` | 11001111iiiiiiii | (R0 + GBR) \| imm -> (R0 + GBR) | 3 | -- |
| `TST.B #imm,@(R0,GBR)` | 11001100iiiiiiii | (R0 + GBR) & imm, when result is 0, 1 -> T | 3 | Test results |
| `XOR.B #imm,@(R0,GBR)` | 11001110iiiiiiii | (R0 + GBR) ^ imm -> (R0 + GBR) | 3 | -- |

#### A.1.10 PC Relative Addressing with Displacement

**Table A.17 PC Relative Addressing with Displacement**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.W @(disp,PC),Rn` | 1001nnnndddddddd | (disp x 2 + PC) -> sign extension -> Rn | 1 | -- |
| `MOV.L @(disp,PC),Rn` | 1101nnnndddddddd | (disp x 4 + PC) -> Rn | 1 | -- |
| `MOVA @(disp,PC),R0` | 11000111dddddddd | disp x 4 + PC -> R0 | 1 | -- |

#### A.1.11 PC Relative Addressing with Rm

**Table A.18 PC Relative Addressing with Rm**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `BRAF Rm`\* | 0000mmmm00100011 | Delayed branch, Rm + PC -> PC | 2 | -- |
| `BSRF Rm`\* | 0000mmmm00000011 | Delayed branch, PC -> PR, Rm + PC -> PC | 2 | -- |

Note: \* SH-2 CPU instruction

#### A.1.12 PC Relative Addressing

**Table A.19 PC Relative Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `BF label` | 10001011dddddddd | When T = 0, disp x 2 + PC -> PC; When T = 1, nop | 3/1 | -- |
| `BF/S label`\* | 10001111dddddddd | When T = 0, disp x 2 + PC -> PC; When T = 1, nop | 2/1 | -- |
| `BT label` | 10001001dddddddd | When T = 1, disp x 2 + PC -> PC; When T = 0, nop | 3/1 | -- |
| `BT/S label`\* | 10001101dddddddd | When T = 1, disp x 2 + PC -> PC; When T = 0, nop | 2/1 | -- |
| `BRA label` | 1010dddddddddddd | Delayed branch, disp x 2 + PC -> PC | 2 | -- |
| `BSR label` | 1011dddddddddddd | Delayed branch, PC -> PR, disp x 2 + PC -> PC | 2 | -- |

Notes: \* SH-2 CPU instruction. State x/y = branch taken/not taken.

#### A.1.13 Immediate

**Table A.20 Arithmetic Logical Operation with Direct Register Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `ADD #imm,Rn` | 0111nnnniiiiiiii | Rn + imm -> Rn | 1 | -- |
| `AND #imm,R0` | 11001001iiiiiiii | R0 & imm -> R0 | 1 | -- |
| `CMP/EQ #imm,R0` | 10001000iiiiiiii | When R0 = imm, 1 -> T | 1 | Comparison result |
| `MOV #imm,Rn` | 1110nnnniiiiiiii | imm -> sign extension -> Rn | 1 | -- |
| `OR #imm,R0` | 11001011iiiiiiii | R0 \| imm -> R0 | 1 | -- |
| `TST #imm,R0` | 11001000iiiiiiii | R0 & imm, when result is 0, 1 -> T | 1 | Test results |
| `XOR #imm,R0` | 11001010iiiiiiii | R0 ^ imm -> R0 | 1 | -- |

**Table A.21 Specify Exception Processing Vector**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `TRAPA #imm` | 11000011iiiiiiii | PC/SR -> Stack area, (imm x 4 + VBR) -> PC | 8 | -- |

---

### A.2 Instruction Sets by Instruction Format

Tables A.22 to A.49 list instruction codes and execution states by instruction formats.

**Table A.22 Instruction Sets by Format**

| Format | Category | Sample Instruction | | SH-2 Types | SH-1 Types |
|---|---|---|---|---|---|
| 0 | -- | `NOP` | | 8 | 8 |
| n | Direct register addressing | `MOVT` | `Rn` | 18 | 17 |
| | Direct register addressing (store with control or system registers) | `STS` | `MACH,Rn` | 6 | 6 |
| | Indirect register addressing | `TAS.B` | `@Rn` | 1 | 1 |
| | Pre decrement indirect register addressing | `STC.L` | `SR,@-Rn` | 6 | 6 |
| m | Direct register addressing (load with control or system registers) | `LDC` | `Rm,SR` | 6 | 6 |
| | PC relative addressing with Rn | `BRAF` | `Rm` | 2 | 0 |
| | Direct register addressing | `JMP` | `@Rm` | 2 | 2 |
| | Post increment indirect register addressing | `LDC.L` | `@Rm+,SR` | 6 | 6 |
| nm | Direct register addressing | `ADD` | `Rm,Rn` | 34 | 31 |
| | Indirect register addressing | `MOV.L` | `Rm,@Rn` | 6 | 6 |
| | Post increment indirect register addressing (multiply/accumulate operation) | `MAC.W` | `@Rm+,@Rn+` | 2 | 1 |
| | Post increment indirect register addressing | `MOV.L` | `@Rm+,Rn` | 3 | 3 |
| | Pre decrement indirect register addressing | `MOV.L` | `Rm,@-Rn` | 3 | 3 |
| | Indirect indexed register addressing | `MOV.L` | `Rm,@(R0,Rn)` | 6 | 6 |
| md | Indirect register addressing with displacement | `MOV.B` | `@(disp,Rm),R0` | 2 | 2 |
| nd4 | Indirect register addressing with displacement | `MOV.B` | `R0,@(disp,Rn)` | 2 | 2 |
| nmd | Indirect register addressing with displacement | `MOV.L` | `Rm,@(disp,Rn)` | 2 | 2 |
| d | Indirect GBR addressing with displacement | `MOV.L` | `R0,@(disp,GBR)` | 6 | 6 |
| | Indirect PC addressing with displacement | `MOVA` | `@(disp,PC),R0` | 1 | 1 |
| | PC relative addressing | `BF` | `label` | 4 | 2 |
| d12 | PC relative addressing | `BRA` | `label` | 2 | 2 |
| nd8 | PC relative addressing with displacement | `MOV.L` | `@(disp,PC),Rn` | 2 | 2 |
| i | Indirect indexed GBR addressing | `AND.B` | `#imm,@(R0,GBR)` | 4 | 4 |
| | Immediate addressing (arithmetic and logical operations with direct register) | `AND` | `#imm,R0` | 5 | 5 |
| | Immediate addressing (specify exception processing vector) | `TRAPA` | `#imm` | 1 | 1 |
| ni | Immediate addressing (direct register arithmetic operations and data transfers) | `ADD` | `#imm,Rn` | 2 | 2 |
| | | | **Total:** | **142** | **133** |

#### A.2.1 0 Format

**Table A.23 0 Format**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `CLRT` | 0000000000001000 | 0 -> T | 1 | 0 |
| `CLRMAC` | 0000000000101000 | 0 -> MACH, MACL | 1 | -- |
| `DIV0U` | 0000000000011001 | 0 -> M/Q/T | 1 | 0 |
| `NOP` | 0000000000001001 | No operation | 1 | -- |
| `RTE` | 0000000000101011 | Delayed branching, stack area -> PC/SR | 4 | LSB |
| `RTS` | 0000000000001011 | Delayed branching, PR -> PC | 2 | -- |
| `SETT` | 0000000000011000 | 1 -> T | 1 | 1 |
| `SLEEP` | 0000000000011011 | Sleep | 3 | -- |

Note: SLEEP state count is the number of states until a transition is made to the Sleep state.

#### A.2.2 n Format

**Table A.24 Direct Register Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `CMP/PL Rn` | 0100nnnn00010101 | Rn > 0, 1 -> T | 1 | Comparison result |
| `CMP/PZ Rn` | 0100nnnn00010001 | Rn >= 0, 1 -> T | 1 | Comparison result |
| `DT Rn`\* | 0100nnnn00010000 | Rn - 1 -> Rn; if Rn is 0, 1 -> T; if Rn is nonzero, 0 -> T | 1 | Comparison result |
| `MOVT Rn` | 0000nnnn00101001 | T -> Rn | 1 | -- |
| `ROTL Rn` | 0100nnnn00000100 | T <- Rn <- MSB | 1 | MSB |
| `ROTR Rn` | 0100nnnn00000101 | LSB -> Rn -> T | 1 | LSB |
| `ROTCL Rn` | 0100nnnn00100100 | T <- Rn <- T | 1 | MSB |
| `ROTCR Rn` | 0100nnnn00100101 | T -> Rn -> T | 1 | LSB |
| `SHAL Rn` | 0100nnnn00100000 | T <- Rn <- 0 | 1 | MSB |
| `SHAR Rn` | 0100nnnn00100001 | MSB -> Rn -> T | 1 | LSB |
| `SHLL Rn` | 0100nnnn00000000 | T <- Rn <- 0 | 1 | MSB |
| `SHLR Rn` | 0100nnnn00000001 | 0 -> Rn -> T | 1 | LSB |
| `SHLL2 Rn` | 0100nnnn00001000 | Rn<<2 -> Rn | 1 | -- |
| `SHLR2 Rn` | 0100nnnn00001001 | Rn>>2 -> Rn | 1 | -- |
| `SHLL8 Rn` | 0100nnnn00011000 | Rn<<8 -> Rn | 1 | -- |
| `SHLR8 Rn` | 0100nnnn00011001 | Rn>>8 -> Rn | 1 | -- |
| `SHLL16 Rn` | 0100nnnn00101000 | Rn<<16 -> Rn | 1 | -- |
| `SHLR16 Rn` | 0100nnnn00101001 | Rn>>16 -> Rn | 1 | -- |

Note: \* SH-2 CPU instruction.

**Table A.25 Direct Register Addressing (Store with Control and System Registers)**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `STC SR,Rn` | 0000nnnn00000010 | SR -> Rn | 1 | -- |
| `STC GBR,Rn` | 0000nnnn00010010 | GBR -> Rn | 1 | -- |
| `STC VBR,Rn` | 0000nnnn00100010 | VBR -> Rn | 1 | -- |
| `STS MACH,Rn` | 0000nnnn00001010 | MACH -> Rn | 1 | -- |
| `STS MACL,Rn` | 0000nnnn00011010 | MACL -> Rn | 1 | -- |
| `STS PR,Rn` | 0000nnnn00101010 | PR -> Rn | 1 | -- |

**Table A.26 Indirect Register Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `TAS.B @Rn` | 0100nnnn00011011 | When (Rn) is 0, 1 -> T, 1 -> MSB of (Rn) | 4 | Test results |

**Table A.27 Pre Decrement Indirect Register**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `STC.L SR,@-Rn` | 0100nnnn00000011 | Rn - 4 -> Rn, SR -> (Rn) | 2 | -- |
| `STC.L GBR,@-Rn` | 0100nnnn00010011 | Rn - 4 -> Rn, GBR -> (Rn) | 2 | -- |
| `STC.L VBR,@-Rn` | 0100nnnn00100011 | Rn - 4 -> Rn, VBR -> (Rn) | 2 | -- |
| `STS.L MACH,@-Rn` | 0100nnnn00000010 | Rn - 4 -> Rn, MACH -> (Rn) | 1 | -- |
| `STS.L MACL,@-Rn` | 0100nnnn00010010 | Rn - 4 -> Rn, MACL -> (Rn) | 1 | -- |
| `STS.L PR,@-Rn` | 0100nnnn00100010 | Rn - 4 -> Rn, PR -> (Rn) | 1 | -- |

#### A.2.3 m Format

**Table A.28 Direct Register Addressing (Load with Control and System Registers)**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `LDC Rm,SR` | 0100mmmm00001110 | Rm -> SR | 1 | LSB |
| `LDC Rm,GBR` | 0100mmmm00011110 | Rm -> GBR | 1 | -- |
| `LDC Rm,VBR` | 0100mmmm00101110 | Rm -> VBR | 1 | -- |
| `LDS Rm,MACH` | 0100mmmm00001010 | Rm -> MACH | 1 | -- |
| `LDS Rm,MACL` | 0100mmmm00011010 | Rm -> MACL | 1 | -- |
| `LDS Rm,PR` | 0100mmmm00101010 | Rm -> PR | 1 | -- |

**Table A.29 Indirect Register**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `JMP @Rm` | 0100mmmm00101011 | Delayed branch, Rm -> PC | 2 | -- |
| `JSR @Rm` | 0100mmmm00001011 | Delayed branch, PC -> PR, Rm -> PC | 2 | -- |

**Table A.30 Post Increment Indirect Register**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `LDC.L @Rm+,SR` | 0100mmmm00000111 | (Rm) -> SR, Rm + 4 -> Rm | 3 | LSB |
| `LDC.L @Rm+,GBR` | 0100mmmm00010111 | (Rm) -> GBR, Rm + 4 -> Rm | 3 | -- |
| `LDC.L @Rm+,VBR` | 0100mmmm00100111 | (Rm) -> VBR, Rm + 4 -> Rm | 3 | -- |
| `LDS.L @Rm+,MACH` | 0100mmmm00000110 | (Rm) -> MACH, Rm + 4 -> Rm | 1 | -- |
| `LDS.L @Rm+,MACL` | 0100mmmm00010110 | (Rm) -> MACL, Rm + 4 -> Rm | 1 | -- |
| `LDS.L @Rm+,PR` | 0100mmmm00100110 | (Rm) -> PR, Rm + 4 -> Rm | 1 | -- |

**Table A.31 PC Relative Addressing with Rm**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `BRAF Rm`\* | 0000mmmm00100011 | Delayed branch, Rm + PC -> PC | 2 | -- |
| `BSRF Rm`\* | 0000mmmm00000011 | Delayed branch, PC -> PR, Rm + PC -> PC | 2 | -- |

Note: \* SH-2 CPU instruction

#### A.2.4 nm Format

**Table A.32 Direct Register Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `ADD Rm,Rn` | 0011nnnnmmmm1100 | Rn + Rm -> Rn | 1 | -- |
| `ADDC Rm,Rn` | 0011nnnnmmmm1110 | Rn + Rm + T -> Rn, carry -> T | 1 | Carry |
| `ADDV Rm,Rn` | 0011nnnnmmmm1111 | Rn + Rm -> Rn, overflow -> T | 1 | Overflow |
| `AND Rm,Rn` | 0010nnnnmmmm1001 | Rn & Rm -> Rn | 1 | -- |
| `CMP/EQ Rm,Rn` | 0011nnnnmmmm0000 | When Rn = Rm, 1 -> T | 1 | Comparison result |
| `CMP/HS Rm,Rn` | 0011nnnnmmmm0010 | When unsigned and Rn >= Rm, 1 -> T | 1 | Comparison result |
| `CMP/GE Rm,Rn` | 0011nnnnmmmm0011 | When signed and Rn >= Rm, 1 -> T | 1 | Comparison result |
| `CMP/HI Rm,Rn` | 0011nnnnmmmm0110 | When unsigned and Rn > Rm, 1 -> T | 1 | Comparison result |
| `CMP/GT Rm,Rn` | 0011nnnnmmmm0111 | When signed and Rn > Rm, 1 -> T | 1 | Comparison result |
| `CMP/STR Rm,Rn` | 0010nnnnmmmm1100 | When a byte in Rn equals a byte in Rm, 1 -> T | 1 | Comparison result |
| `DIV1 Rm,Rn` | 0011nnnnmmmm0100 | 1-step division (Rn / Rm) | 1 | Calculation result |
| `DIV0S Rm,Rn` | 0010nnnnmmmm0111 | MSB of Rn -> Q, MSB of Rm -> M, M ^ Q -> T | 1 | Calculation result |
| `DMULS.L Rm,Rn`\* | 0011nnnnmmmm1101 | Signed, Rn x Rm -> MACH, MACL | 2 to 4 | -- |
| `DMULU.L Rm,Rn`\* | 0011nnnnmmmm0101 | Unsigned, Rn x Rm -> MACH, MACL | 2 to 4 | -- |
| `EXTS.B Rm,Rn` | 0110nnnnmmmm1110 | Sign-extends Rm from byte -> Rn | 1 | -- |
| `EXTS.W Rm,Rn` | 0110nnnnmmmm1111 | Sign-extends Rm from word -> Rn | 1 | -- |
| `EXTU.B Rm,Rn` | 0110nnnnmmmm1100 | Zero-extends Rm from byte -> Rn | 1 | -- |
| `EXTU.W Rm,Rn` | 0110nnnnmmmm1101 | Zero-extends Rm from word -> Rn | 1 | -- |
| `MOV Rm,Rn` | 0110nnnnmmmm0011 | Rm -> Rn | 1 | -- |
| `MUL.L Rm,Rn`\* | 0000nnnnmmmm0111 | Rn x Rm -> MACL | 2 to 4 | -- |
| `MULS.W Rm,Rn` | 0010nnnnmmmm1111 | Signed, Rn x Rm -> MAC | 1 to 3 | -- |
| `MULU.W Rm,Rn` | 0010nnnnmmmm1110 | Unsigned, Rn x Rm -> MAC | 1 to 3 | -- |
| `NEG Rm,Rn` | 0110nnnnmmmm1011 | 0 - Rm -> Rn | 1 | -- |
| `NEGC Rm,Rn` | 0110nnnnmmmm1010 | 0 - Rm - T -> Rn, borrow -> T | 1 | Borrow |
| `NOT Rm,Rn` | 0110nnnnmmmm0111 | ~Rm -> Rn | 1 | -- |
| `OR Rm,Rn` | 0010nnnnmmmm1011 | Rn \| Rm -> Rn | 1 | -- |
| `SUB Rm,Rn` | 0011nnnnmmmm1000 | Rn - Rm -> Rn | 1 | -- |
| `SUBC Rm,Rn` | 0011nnnnmmmm1010 | Rn - Rm - T -> Rn, borrow -> T | 1 | Borrow |
| `SUBV Rm,Rn` | 0011nnnnmmmm1011 | Rn - Rm -> Rn, underflow -> T | 1 | Underflow |
| `SWAP.B Rm,Rn` | 0110nnnnmmmm1000 | Rm -> Swap upper and lower halves of lower 2 bytes -> Rn | 1 | -- |
| `SWAP.W Rm,Rn` | 0110nnnnmmmm1001 | Rm -> Swap upper and lower word -> Rn | 1 | -- |
| `TST Rm,Rn` | 0010nnnnmmmm1000 | Rn & Rm, when result is 0, 1 -> T | 1 | Test results |
| `XOR Rm,Rn` | 0010nnnnmmmm1010 | Rn ^ Rm -> Rn | 1 | -- |
| `XTRCT Rm,Rn` | 0010nnnnmmmm1101 | Center 32 bits of Rm and Rn -> Rn | 1 | -- |

Notes: \* SH-2 CPU instructions. State counts are the normal minimum number of execution cycles.

**Table A.33 Indirect Register Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B Rm,@Rn` | 0010nnnnmmmm0000 | Rm -> (Rn) | 1 | -- |
| `MOV.W Rm,@Rn` | 0010nnnnmmmm0001 | Rm -> (Rn) | 1 | -- |
| `MOV.L Rm,@Rn` | 0010nnnnmmmm0010 | Rm -> (Rn) | 1 | -- |
| `MOV.B @Rm,Rn` | 0110nnnnmmmm0000 | (Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.W @Rm,Rn` | 0110nnnnmmmm0001 | (Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.L @Rm,Rn` | 0110nnnnmmmm0010 | (Rm) -> Rn | 1 | -- |

**Table A.34 Post Increment Indirect Register (Multiply/Accumulate Operation)**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MAC.L @Rm+,@Rn+`\* | 0000nnnnmmmm1111 | Signed, (Rn) x (Rm) + MAC -> MAC | 3/(2 to 4) | -- |
| `MAC.W @Rm+,@Rn+` | 0100nnnnmmmm1111 | Signed, (Rn) x (Rm) + MAC -> MAC | 3/(2) | -- |

Notes: \* SH-2 CPU instruction. The number in parentheses is the number of states when there is contention with preceding/following instructions.

**Table A.35 Post Increment Indirect Register**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B @Rm+,Rn` | 0110nnnnmmmm0100 | (Rm) -> sign extension -> Rn, Rm + 1 -> Rm | 1 | -- |
| `MOV.W @Rm+,Rn` | 0110nnnnmmmm0101 | (Rm) -> sign extension -> Rn, Rm + 2 -> Rm | 1 | -- |
| `MOV.L @Rm+,Rn` | 0110nnnnmmmm0110 | (Rm) -> Rn, Rm + 4 -> Rm | 1 | -- |

**Table A.36 Pre Decrement Indirect Register**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B Rm,@-Rn` | 0010nnnnmmmm0100 | Rn - 1 -> Rn, Rm -> (Rn) | 1 | -- |
| `MOV.W Rm,@-Rn` | 0010nnnnmmmm0101 | Rn - 2 -> Rn, Rm -> (Rn) | 1 | -- |
| `MOV.L Rm,@-Rn` | 0010nnnnmmmm0110 | Rn - 4 -> Rn, Rm -> (Rn) | 1 | -- |

**Table A.37 Indirect Indexed Register**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B Rm,@(R0,Rn)` | 0000nnnnmmmm0100 | Rm -> (R0 + Rn) | 1 | -- |
| `MOV.W Rm,@(R0,Rn)` | 0000nnnnmmmm0101 | Rm -> (R0 + Rn) | 1 | -- |
| `MOV.L Rm,@(R0,Rn)` | 0000nnnnmmmm0110 | Rm -> (R0 + Rn) | 1 | -- |
| `MOV.B @(R0,Rm),Rn` | 0000nnnnmmmm1100 | (R0 + Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.W @(R0,Rm),Rn` | 0000nnnnmmmm1101 | (R0 + Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.L @(R0,Rm),Rn` | 0000nnnnmmmm1110 | (R0 + Rm) -> Rn | 1 | -- |

#### A.2.5 md Format

**Table A.38 md Format**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B @(disp,Rm),R0` | 10000100mmmmdddd | (disp + Rm) -> sign extension -> R0 | 1 | -- |
| `MOV.W @(disp,Rm),R0` | 10000101mmmmdddd | (disp x 2 + Rm) -> sign extension -> R0 | 1 | -- |

#### A.2.6 nd4 Format

**Table A.39 nd4 Format**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B R0,@(disp,Rn)` | 10000000nnnndddd | R0 -> (disp + Rn) | 1 | -- |
| `MOV.W R0,@(disp,Rn)` | 10000001nnnndddd | R0 -> (disp x 2 + Rn) | 1 | -- |

#### A.2.7 nmd Format

**Table A.40 nmd Format**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.L Rm,@(disp,Rn)` | 0001nnnnmmmmdddd | Rm -> (disp x 4 + Rn) | 1 | -- |
| `MOV.L @(disp,Rm),Rn` | 0101nnnnmmmmdddd | (disp x 4 + Rm) -> Rn | 1 | -- |

#### A.2.8 d Format

**Table A.41 Indirect GBR with Displacement**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.B R0,@(disp,GBR)` | 11000000dddddddd | R0 -> (disp + GBR) | 1 | -- |
| `MOV.W R0,@(disp,GBR)` | 11000001dddddddd | R0 -> (disp x 2 + GBR) | 1 | -- |
| `MOV.L R0,@(disp,GBR)` | 11000010dddddddd | R0 -> (disp x 4 + GBR) | 1 | -- |
| `MOV.B @(disp,GBR),R0` | 11000100dddddddd | (disp + GBR) -> sign extension -> R0 | 1 | -- |
| `MOV.W @(disp,GBR),R0` | 11000101dddddddd | (disp x 2 + GBR) -> sign extension -> R0 | 1 | -- |
| `MOV.L @(disp,GBR),R0` | 11000110dddddddd | (disp x 4 + GBR) -> R0 | 1 | -- |

**Table A.42 PC Relative with Displacement**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOVA @(disp,PC),R0` | 11000111dddddddd | disp x 4 + PC -> R0 | 1 | -- |

**Table A.43 PC Relative Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `BF label` | 10001011dddddddd | When T = 0, disp x 2 + PC -> PC; When T = 1, nop | 3/1 | -- |
| `BF/S label`\* | 10001111dddddddd | When T = 0, disp x 2 + PC -> PC; When T = 1, nop | 2/1 | -- |
| `BT label` | 10001001dddddddd | When T = 1, disp x 2 + PC -> PC; When T = 0, nop | 3/1 | -- |
| `BT/S label`\* | 10001101dddddddd | When T = 1, disp x 2 + PC -> PC; When T = 0, nop | 2/1 | -- |

Notes: \* SH-2 CPU instruction. State x/y = branch taken/not taken.

#### A.2.9 d12 Format

**Table A.44 d12 Format**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `BRA label` | 1010dddddddddddd | Delayed branch, disp x 2 + PC -> PC | 2 | -- |
| `BSR label` | 1011dddddddddddd | Delayed branching, PC -> PR, disp x 2 + PC -> PC | 2 | -- |

#### A.2.10 nd8 Format

**Table A.45 nd8 Format**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `MOV.W @(disp,PC),Rn` | 1001nnnndddddddd | (disp x 2 + PC) -> sign extension -> Rn | 1 | -- |
| `MOV.L @(disp,PC),Rn` | 1101nnnndddddddd | (disp x 4 + PC) -> Rn | 1 | -- |

#### A.2.11 i Format

**Table A.46 Indirect Indexed GBR Addressing**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `AND.B #imm,@(R0,GBR)` | 11001101iiiiiiii | (R0 + GBR) & imm -> (R0 + GBR) | 3 | -- |
| `OR.B #imm,@(R0,GBR)` | 11001111iiiiiiii | (R0 + GBR) \| imm -> (R0 + GBR) | 3 | -- |
| `TST.B #imm,@(R0,GBR)` | 11001100iiiiiiii | (R0 + GBR) & imm, when result is 0, 1 -> T | 3 | Test results |
| `XOR.B #imm,@(R0,GBR)` | 11001110iiiiiiii | (R0 + GBR) ^ imm -> (R0 + GBR) | 3 | -- |

**Table A.47 Immediate Addressing (Arithmetic Logical Operation with Direct Register)**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `AND #imm,R0` | 11001001iiiiiiii | R0 & imm -> R0 | 1 | -- |
| `CMP/EQ #imm,R0` | 10001000iiiiiiii | When R0 = imm, 1 -> T | 1 | Comparison results |
| `OR #imm,R0` | 11001011iiiiiiii | R0 \| imm -> R0 | 1 | -- |
| `TST #imm,R0` | 11001000iiiiiiii | R0 & imm, when result is 0, 1 -> T | 1 | Test results |
| `XOR #imm,R0` | 11001010iiiiiiii | R0 ^ imm -> R0 | 1 | -- |

**Table A.48 Immediate Addressing (Specify Exception Processing Vector)**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `TRAPA #imm` | 11000011iiiiiiii | PC/SR -> Stack area, (imm x 4 + VBR) -> PC | 8 | -- |

#### A.2.12 ni Format

**Table A.49 ni Format**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `ADD #imm,Rn` | 0111nnnniiiiiiii | Rn + imm -> Rn | 1 | -- |
| `MOV #imm,Rn` | 1110nnnniiiiiiii | imm -> sign extension -> Rn | 1 | -- |

---

### A.3 Instruction Set in Order by Instruction Code

Table A.50 lists instruction codes and execution states in order by instruction code.

**Table A.50 Instruction Set by Instruction Code**

| Instruction | Code | Operation | State | T Bit |
|---|---|---|---|---|
| `CLRT` | 0000000000001000 | 0 -> T | 1 | 0 |
| `NOP` | 0000000000001001 | No operation | 1 | -- |
| `RTS` | 0000000000001011 | Delayed branch, PR -> PC | 2 | -- |
| `SETT` | 0000000000011000 | 1 -> T | 1 | 1 |
| `DIV0U` | 0000000000011001 | 0 -> M/Q/T | 1 | 0 |
| `SLEEP` | 0000000000011011 | Sleep | 3 | -- |
| `CLRMAC` | 0000000000101000 | 0 -> MACH, MACL | 1 | -- |
| `RTE` | 0000000000101011 | Delayed branch, stack area -> PC/SR | 4 | LSB |
| `STC SR,Rn` | 0000nnnn00000010 | SR -> Rn | 1 | -- |
| `BSRF Rm`\* | 0000mmmm00000011 | Delayed branch, PC -> PR, Rm + PC -> PC | 2 | -- |
| `STS MACH,Rn` | 0000nnnn00001010 | MACH -> Rn | 1 | -- |
| `STC GBR,Rn` | 0000nnnn00010010 | GBR -> Rn | 1 | -- |
| `STS MACL,Rn` | 0000nnnn00011010 | MACL -> Rn | 1 | -- |
| `STC VBR,Rn` | 0000nnnn00100010 | VBR -> Rn | 1 | -- |
| `BRAF Rm`\* | 0000mmmm00100011 | Delayed branch, Rm + PC -> PC | 2 | -- |
| `MOVT Rn` | 0000nnnn00101001 | T -> Rn | 1 | -- |
| `STS PR,Rn` | 0000nnnn00101010 | PR -> Rn | 1 | -- |
| `MOV.B Rm,@(R0,Rn)` | 0000nnnnmmmm0100 | Rm -> (R0 + Rn) | 1 | -- |
| `MOV.W Rm,@(R0,Rn)` | 0000nnnnmmmm0101 | Rm -> (R0 + Rn) | 1 | -- |
| `MOV.L Rm,@(R0,Rn)` | 0000nnnnmmmm0110 | Rm -> (R0 + Rn) | 1 | -- |
| `MUL.L Rm,Rn`\* | 0000nnnnmmmm0111 | Rn x Rm -> MACL | 2 (to 4) | -- |
| `MOV.B @(R0,Rm),Rn` | 0000nnnnmmmm1100 | (R0 + Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.W @(R0,Rm),Rn` | 0000nnnnmmmm1101 | (R0 + Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.L @(R0,Rm),Rn` | 0000nnnnmmmm1110 | (R0 + Rm) -> Rn | 1 | -- |
| `MAC.L @Rm+,@Rn+`\* | 0000nnnnmmmm1111 | Signed, (Rn) x (Rm) + MAC -> MAC | 3/(2 to 4) | -- |
| `MOV.L Rm,@(disp,Rn)` | 0001nnnnmmmmdddd | Rm -> (disp x 4 + Rn) | 1 | -- |
| `MOV.B Rm,@Rn` | 0010nnnnmmmm0000 | Rm -> (Rn) | 1 | -- |
| `MOV.W Rm,@Rn` | 0010nnnnmmmm0001 | Rm -> (Rn) | 1 | -- |
| `MOV.L Rm,@Rn` | 0010nnnnmmmm0010 | Rm -> (Rn) | 1 | -- |
| `MOV.B Rm,@-Rn` | 0010nnnnmmmm0100 | Rn - 1 -> Rn, Rm -> (Rn) | 1 | -- |
| `MOV.W Rm,@-Rn` | 0010nnnnmmmm0101 | Rn - 2 -> Rn, Rm -> (Rn) | 1 | -- |
| `MOV.L Rm,@-Rn` | 0010nnnnmmmm0110 | Rn - 4 -> Rn, Rm -> (Rn) | 1 | -- |
| `DIV0S Rm,Rn` | 0010nnnnmmmm0111 | MSB of Rn -> Q, MSB of Rm -> M, M ^ Q -> T | 1 | Calculation result |
| `TST Rm,Rn` | 0010nnnnmmmm1000 | Rn & Rm, when result is 0, 1 -> T | 1 | Test results |
| `AND Rm,Rn` | 0010nnnnmmmm1001 | Rn & Rm -> Rn | 1 | -- |
| `XOR Rm,Rn` | 0010nnnnmmmm1010 | Rn ^ Rm -> Rn | 1 | -- |
| `OR Rm,Rn` | 0010nnnnmmmm1011 | Rn \| Rm -> Rn | 1 | -- |
| `CMP/STR Rm,Rn` | 0010nnnnmmmm1100 | When a byte in Rn equals a byte in Rm, 1 -> T | 1 | Comparison result |
| `XTRCT Rm,Rn` | 0010nnnnmmmm1101 | Center 32 bits of Rm and Rn -> Rn | 1 | -- |
| `MULU.W Rm,Rn` | 0010nnnnmmmm1110 | Unsigned, Rn x Rm -> MAC | 1 to 3 | -- |
| `MULS.W Rm,Rn` | 0010nnnnmmmm1111 | Signed, Rn x Rm -> MAC | 1 to 3 | -- |
| `CMP/EQ Rm,Rn` | 0011nnnnmmmm0000 | When Rn = Rm, 1 -> T | 1 | Comparison result |
| `CMP/HS Rm,Rn` | 0011nnnnmmmm0010 | When unsigned and Rn >= Rm, 1 -> T | 1 | Comparison result |
| `CMP/GE Rm,Rn` | 0011nnnnmmmm0011 | When signed and Rn >= Rm, 1 -> T | 1 | Comparison result |
| `DIV1 Rm,Rn` | 0011nnnnmmmm0100 | 1-step division (Rn / Rm) | 1 | Calculation result |
| `DMULU.L Rm,Rn`\* | 0011nnnnmmmm0101 | Unsigned, Rn x Rm -> MACH, MACL | 2 to 4 | -- |
| `CMP/HI Rm,Rn` | 0011nnnnmmmm0110 | When unsigned and Rn > Rm, 1 -> T | 1 | Comparison result |
| `CMP/GT Rm,Rn` | 0011nnnnmmmm0111 | When signed and Rn > Rm, 1 -> T | 1 | Comparison result |
| `SUB Rm,Rn` | 0011nnnnmmmm1000 | Rn - Rm -> Rn | 1 | -- |
| `SUBC Rm,Rn` | 0011nnnnmmmm1010 | Rn - Rm - T -> Rn, borrow -> T | 1 | Borrow |
| `SUBV Rm,Rn` | 0011nnnnmmmm1011 | Rn - Rm -> Rn, underflow -> T | 1 | Underflow |
| `ADD Rm,Rn` | 0011nnnnmmmm1100 | Rm + Rn -> Rn | 1 | -- |
| `DMULS.L Rm,Rn`\* | 0011nnnnmmmm1101 | Signed, Rn x Rm -> MACH, MACL | 2 to 4 | -- |
| `ADDC Rm,Rn` | 0011nnnnmmmm1110 | Rn + Rm + T -> Rn, carry -> T | 1 | Carry |
| `ADDV Rm,Rn` | 0011nnnnmmmm1111 | Rn + Rm -> Rn, overflow -> T | 1 | Overflow |
| `SHLL Rn` | 0100nnnn00000000 | T <- Rn <- 0 | 1 | MSB |
| `SHLR Rn` | 0100nnnn00000001 | 0 -> Rn -> T | 1 | LSB |
| `STS.L MACH,@-Rn` | 0100nnnn00000010 | Rn - 4 -> Rn, MACH -> (Rn) | 1 | -- |
| `STC.L SR,@-Rn` | 0100nnnn00000011 | Rn - 4 -> Rn, SR -> (Rn) | 2 | -- |
| `ROTL Rn` | 0100nnnn00000100 | T <- Rn <- MSB | 1 | MSB |
| `ROTR Rn` | 0100nnnn00000101 | LSB -> Rn -> T | 1 | LSB |
| `LDS.L @Rm+,MACH` | 0100mmmm00000110 | (Rm) -> MACH, Rm + 4 -> Rm | 1 | -- |
| `LDC.L @Rm+,SR` | 0100mmmm00000111 | (Rm) -> SR, Rm + 4 -> Rm | 3 | LSB |
| `SHLL2 Rn` | 0100nnnn00001000 | Rn<<2 -> Rn | 1 | -- |
| `SHLR2 Rn` | 0100nnnn00001001 | Rn>>2 -> Rn | 1 | -- |
| `LDS Rm,MACH` | 0100mmmm00001010 | Rm -> MACH | 1 | -- |
| `JSR @Rm` | 0100mmmm00001011 | Delayed branch, PC -> PR, Rm -> PC | 2 | -- |
| `LDC Rm,SR` | 0100mmmm00001110 | Rm -> SR | 1 | LSB |
| `DT Rn`\* | 0100nnnn00010000 | Rn - 1 -> Rn; if Rn is 0, 1 -> T; if Rn is nonzero, 0 -> T | 1 | Comparison result |
| `CMP/PZ Rn` | 0100nnnn00010001 | Rn >= 0, 1 -> T | 1 | Comparison result |
| `STS.L MACL,@-Rn` | 0100nnnn00010010 | Rn - 4 -> Rn, MACL -> (Rn) | 1 | -- |
| `STC.L GBR,@-Rn` | 0100nnnn00010011 | Rn - 4 -> Rn, GBR -> (Rn) | 2 | -- |
| `CMP/PL Rn` | 0100nnnn00010101 | Rn > 0, 1 -> T | 1 | Comparison result |
| `LDS.L @Rm+,MACL` | 0100mmmm00010110 | (Rm) -> MACL, Rm + 4 -> Rm | 1 | -- |
| `LDC.L @Rm+,GBR` | 0100mmmm00010111 | (Rm) -> GBR, Rm + 4 -> Rm | 3 | -- |
| `SHLL8 Rn` | 0100nnnn00011000 | Rn<<8 -> Rn | 1 | -- |
| `SHLR8 Rn` | 0100nnnn00011001 | Rn>>8 -> Rn | 1 | -- |
| `LDS Rm,MACL` | 0100mmmm00011010 | Rm -> MACL | 1 | -- |
| `TAS.B @Rn` | 0100nnnn00011011 | When (Rn) is 0, 1 -> T, 1 -> MSB of (Rn) | 4 | Test results |
| `LDC Rm,GBR` | 0100mmmm00011110 | Rm -> GBR | 1 | -- |
| `SHAL Rn` | 0100nnnn00100000 | T <- Rn <- 0 | 1 | MSB |
| `SHAR Rn` | 0100nnnn00100001 | MSB -> Rn -> T | 1 | LSB |
| `STS.L PR,@-Rn` | 0100nnnn00100010 | Rn - 4 -> Rn, PR -> (Rn) | 1 | -- |
| `STC.L VBR,@-Rn` | 0100nnnn00100011 | Rn - 4 -> Rn, VBR -> (Rn) | 2 | -- |
| `ROTCL Rn` | 0100nnnn00100100 | T <- Rn <- T | 1 | MSB |
| `ROTCR Rn` | 0100nnnn00100101 | T -> Rn -> T | 1 | LSB |
| `LDS.L @Rm+,PR` | 0100mmmm00100110 | (Rm) -> PR, Rm + 4 -> Rm | 1 | -- |
| `LDC.L @Rm+,VBR` | 0100mmmm00100111 | (Rm) -> VBR, Rm + 4 -> Rm | 3 | -- |
| `SHLL16 Rn` | 0100nnnn00101000 | Rn<<16 -> Rn | 1 | -- |
| `SHLR16 Rn` | 0100nnnn00101001 | Rn>>16 -> Rn | 1 | -- |
| `LDS Rm,PR` | 0100mmmm00101010 | Rm -> PR | 1 | -- |
| `JMP @Rm` | 0100mmmm00101011 | Delayed branch, Rm -> PC | 2 | -- |
| `LDC Rm,VBR` | 0100mmmm00101110 | Rm -> VBR | 1 | -- |
| `MAC.W @Rm+,@Rn+` | 0100nnnnmmmm1111 | Signed, (Rn) x (Rm) + MAC -> MAC | 3/(2) | -- |
| `MOV.L @(disp,Rm),Rn` | 0101nnnnmmmmdddd | (disp x 4 + Rm) -> Rn | 1 | -- |
| `MOV.B @Rm,Rn` | 0110nnnnmmmm0000 | (Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.W @Rm,Rn` | 0110nnnnmmmm0001 | (Rm) -> sign extension -> Rn | 1 | -- |
| `MOV.L @Rm,Rn` | 0110nnnnmmmm0010 | (Rm) -> Rn | 1 | -- |
| `MOV Rm,Rn` | 0110nnnnmmmm0011 | Rm -> Rn | 1 | -- |
| `MOV.B @Rm+,Rn` | 0110nnnnmmmm0100 | (Rm) -> sign extension -> Rn, Rm + 1 -> Rm | 1 | -- |
| `MOV.W @Rm+,Rn` | 0110nnnnmmmm0101 | (Rm) -> sign extension -> Rn, Rm + 2 -> Rm | 1 | -- |
| `MOV.L @Rm+,Rn` | 0110nnnnmmmm0110 | (Rm) -> Rn, Rm + 4 -> Rm | 1 | -- |
| `NOT Rm,Rn` | 0110nnnnmmmm0111 | ~Rm -> Rn | 1 | -- |
| `SWAP.B Rm,Rn` | 0110nnnnmmmm1000 | Rm -> Swap upper and lower halves of lower 2 bytes -> Rn | 1 | -- |
| `SWAP.W Rm,Rn` | 0110nnnnmmmm1001 | Rm -> Swap upper and lower word -> Rn | 1 | -- |
| `NEGC Rm,Rn` | 0110nnnnmmmm1010 | 0 - Rm - T -> Rn, borrow -> T | 1 | Borrow |
| `NEG Rm,Rn` | 0110nnnnmmmm1011 | 0 - Rm -> Rn | 1 | -- |
| `EXTU.B Rm,Rn` | 0110nnnnmmmm1100 | Zero-extends Rm from byte -> Rn | 1 | -- |
| `EXTU.W Rm,Rn` | 0110nnnnmmmm1101 | Zero-extends Rm from word -> Rn | 1 | -- |
| `EXTS.B Rm,Rn` | 0110nnnnmmmm1110 | Sign-extends Rm from byte -> Rn | 1 | -- |
| `EXTS.W Rm,Rn` | 0110nnnnmmmm1111 | Sign-extends Rm from word -> Rn | 1 | -- |
| `ADD #imm,Rn` | 0111nnnniiiiiiii | Rn + imm -> Rn | 1 | -- |
| `MOV.B R0,@(disp,Rn)` | 10000000nnnndddd | R0 -> (disp + Rn) | 1 | -- |
| `MOV.W R0,@(disp,Rn)` | 10000001nnnndddd | R0 -> (disp x 2 + Rn) | 1 | -- |
| `MOV.B @(disp,Rm),R0` | 10000100mmmmdddd | (disp + Rm) -> sign extension -> R0 | 1 | -- |
| `MOV.W @(disp,Rm),R0` | 10000101mmmmdddd | (disp x 2 + Rm) -> sign extension -> R0 | 1 | -- |
| `CMP/EQ #imm,R0` | 10001000iiiiiiii | When R0 = imm, 1 -> T | 1 | Comparison results |
| `BT label` | 10001001dddddddd | When T = 1, disp x 2 + PC -> PC; When T = 0, nop | 3/1 | -- |
| `BT/S label`\* | 10001101dddddddd | When T = 1, disp x 2 + PC -> PC; When T = 0, nop | 2/1 | -- |
| `BF label` | 10001011dddddddd | When T = 0, disp x 2 + PC -> PC; When T = 1, nop | 3/1 | -- |
| `BF/S label`\* | 10001111dddddddd | When T = 0, disp x 2 + PC -> PC; When T = 1, nop | 2/1 | -- |
| `MOV.W @(disp,PC),Rn` | 1001nnnndddddddd | (disp x 2 + PC) -> sign extension -> Rn | 1 | -- |
| `BRA label` | 1010dddddddddddd | Delayed branch, disp x 2 + PC -> PC | 2 | -- |
| `BSR label` | 1011dddddddddddd | Delayed branch, PC -> PR, disp x 2 + PC -> PC | 2 | -- |
| `MOV.B R0,@(disp,GBR)` | 11000000dddddddd | R0 -> (disp + GBR) | 1 | -- |
| `MOV.W R0,@(disp,GBR)` | 11000001dddddddd | R0 -> (disp x 2 + GBR) | 1 | -- |
| `MOV.L R0,@(disp,GBR)` | 11000010dddddddd | R0 -> (disp x 4 + GBR) | 1 | -- |
| `TRAPA #imm` | 11000011iiiiiiii | PC/SR -> Stack area, (imm x 4 + VBR) -> PC | 8 | -- |
| `MOV.B @(disp,GBR),R0` | 11000100dddddddd | (disp + GBR) -> sign extension -> R0 | 1 | -- |
| `MOV.W @(disp,GBR),R0` | 11000101dddddddd | (disp x 2 + GBR) -> sign extension -> R0 | 1 | -- |
| `MOV.L @(disp,GBR),R0` | 11000110dddddddd | (disp x 4 + GBR) -> R0 | 1 | -- |
| `MOVA @(disp,PC),R0` | 11000111dddddddd | disp x 4 + PC -> R0 | 1 | -- |
| `TST #imm,R0` | 11001000iiiiiiii | R0 & imm, when result is 0, 1 -> T | 1 | Test results |
| `AND #imm,R0` | 11001001iiiiiiii | R0 & imm -> R0 | 1 | -- |
| `XOR #imm,R0` | 11001010iiiiiiii | R0 ^ imm -> R0 | 1 | -- |
| `OR #imm,R0` | 11001011iiiiiiii | R0 \| imm -> R0 | 1 | -- |
| `TST.B #imm,@(R0,GBR)` | 11001100iiiiiiii | (R0 + GBR) & imm, when result is 0, 1 -> T | 3 | Test results |
| `AND.B #imm,@(R0,GBR)` | 11001101iiiiiiii | (R0 + GBR) & imm -> (R0 + GBR) | 3 | -- |
| `XOR.B #imm,@(R0,GBR)` | 11001110iiiiiiii | (R0 + GBR) ^ imm -> (R0 + GBR) | 3 | -- |
| `OR.B #imm,@(R0,GBR)` | 11001111iiiiiiii | (R0 + GBR) \| imm -> (R0 + GBR) | 3 | -- |
| `MOV.L @(disp,PC),Rn` | 1101nnnndddddddd | (disp x 4 + PC) -> Rn | 1 | -- |
| `MOV #imm,Rn` | 1110nnnniiiiiiii | imm -> sign extension -> Rn | 1 | -- |

Notes:
1. State counts are the normal minimum number of execution states (the number in parentheses is the number of states when there is contention with preceding/following instructions)
2. \* = SH-2 CPU instruction
3. State x/y = branch taken/not taken

---

### A.4 Operation Code Map

Table A.51 is an operation code map. This is **the critical lookup table for dc.w -> mnemonic translation**.

The 16-bit instruction word is decoded as: `MSB[15:12] | Rn/Rm[11:8] | Fx/Rm[7:4] | LSB[3:0]`

Where columns represent the function code (Fx) bits [3:2] and mode (MD) bits [1:0]:
- **Fx: 0000** = MD: 00
- **Fx: 0001** = MD: 01
- **Fx: 0010** = MD: 10
- **Fx: 0011-1111** = MD: 11

**Table A.51 Operation Code Map**

```
MSB   | Rn   | Fx   | LSB  | Fx:0000 (MD:00)      | Fx:0001 (MD:01)      | Fx:0010 (MD:10)      | Fx:0011-1111 (MD:11)
------+------+------+------+----------------------+----------------------+----------------------+----------------------
0000  | Rn   | Fx   | 0000 |                      |                      |                      |
0000  | Rn   | Fx   | 0001 |                      |                      |                      |
0000  | Rn   | Fx   | 0010 | STC    SR,Rn*        | STC    GBR,Rn        | STC    VBR,Rn        |
0000  | Rn   | Fx   | 0011 | BSRF   Rm*           |                      | BRAF   Rm*           |
0000  | Rn   | Rm   | 01MD | MOV.B  Rm,@(R0,Rn)  | MOV.W  Rm,@(R0,Rn)  | MOV.L  Rm,@(R0,Rn)  | MUL.L  Rm,Rn*
0000  | 0000 | Fx   | 1000 | CLRT                 | SETT                 | CLRMAC               |
0000  | 0000 | Fx   | 1001 | NOP                  | DIV0U                |                      |
0000  | 0000 | Fx   | 1010 |                      |                      |                      |
0000  | 0000 | Fx   | 1011 | RTS                  | SLEEP                | RTE                  |
0000  | Rn   | Fx   | 1000 |                      |                      |                      |
0000  | Rn   | Fx   | 1001 |                      | MOVT   Rn            |                      |
0000  | Rn   | Fx   | 1010 | STS    MACH,Rn       | STS    MACL,Rn       | STS    PR,Rn         |
0000  | Rn   | Fx   | 1011 |                      |                      |                      |
0000  | Rn   | Rm   | 11MD | MOV.B  @(R0,Rm),Rn  | MOV.W  @(R0,Rm),Rn  | MOV.L  @(R0,Rm),Rn  | MAC.L  @Rm+,@Rn+*
------+------+------+------+----------------------+----------------------+----------------------+----------------------
0001  | Rn   | Rm   | disp | MOV.L  Rm,@(disp:4,Rn)
------+------+------+------+----------------------+----------------------+----------------------+----------------------
0010  | Rn   | Rm   | 00MD | MOV.B  Rm,@Rn        | MOV.W  Rm,@Rn        | MOV.L  Rm,@Rn        |
0010  | Rn   | Rm   | 01MD | MOV.B  Rm,@-Rn       | MOV.W  Rm,@-Rn       | MOV.L  Rm,@-Rn       | DIV0S  Rm,Rn
0010  | Rn   | Rm   | 10MD | TST    Rm,Rn         | AND    Rm,Rn         | XOR    Rm,Rn         | OR     Rm,Rn
0010  | Rn   | Rm   | 11MD | CMP/STR Rm,Rn        | XTRCT  Rm,Rn         | MULU.W Rm,Rn         | MULS.W Rm,Rn
------+------+------+------+----------------------+----------------------+----------------------+----------------------
0011  | Rn   | Rm   | 00MD | CMP/EQ Rm,Rn         |                      | CMP/HS Rm,Rn         | CMP/GE Rm,Rn
0011  | Rn   | Rm   | 01MD | DIV1   Rm,Rn         | DMULU.L Rm,Rn*       | CMP/HI Rm,Rn         | CMP/GT Rm,Rn
0011  | Rn   | Rm   | 10MD | SUB    Rm,Rn         |                      | SUBC   Rm,Rn         | SUBV   Rm,Rn
0011  | Rn   | Rm   | 11MD | ADD    Rm,Rn         | DMULS.L Rm,Rn*       | ADDC   Rm,Rn         | ADDV   Rm,Rn
------+------+------+------+----------------------+----------------------+----------------------+----------------------
0100  | Rn   | Fx   | 0000 | SHLL   Rn            | DT     Rn*           | SHAL   Rn            |
0100  | Rn   | Fx   | 0001 | SHLR   Rn            | CMP/PZ Rn            | SHAR   Rn            |
0100  | Rn   | Fx   | 0010 | STS.L  MACH,@-Rn     | STS.L  MACL,@-Rn     | STS.L  PR,@-Rn       |
0100  | Rn   | Fx   | 0011 | STC.L  SR,@-Rn       | STC.L  GBR,@-Rn      | STC.L  VBR,@-Rn      |
0100  | Rn   | Fx   | 0100 | ROTL   Rn            |                      | ROTCL  Rn            |
0100  | Rn   | Fx   | 0101 | ROTR   Rn            | CMP/PL Rn            | ROTCR  Rn            |
0100  | Rm   | Fx   | 0110 | LDS.L  @Rm+,MACH    | LDS.L  @Rm+,MACL     | LDS.L  @Rm+,PR       |
0100  | Rm   | Fx   | 0111 | LDC.L  @Rm+,SR       | LDC.L  @Rm+,GBR      | LDC.L  @Rm+,VBR      |
0100  | Rn   | Fx   | 1000 | SHLL2  Rn            | SHLL8  Rn            | SHLL16 Rn            |
0100  | Rn   | Fx   | 1001 | SHLR2  Rn            | SHLR8  Rn            | SHLR16 Rn            |
0100  | Rm   | Fx   | 1010 | LDS    Rm,MACH       | LDS    Rm,MACL       | LDS    Rm,PR         |
0100  | Rm/Rn| Fx   | 1011 | JSR    @Rm           | TAS.B  @Rn           | JMP    @Rm           |
0100  | Rm   | Fx   | 1100 |                      |                      |                      |
0100  | Rm   | Fx   | 1101 |                      |                      |                      |
0100  | Rn   | Fx   | 1110 | LDC    Rm,SR         | LDC    Rm,GBR        | LDC    Rm,VBR        |
0100  | Rn   | Rm   | 1111 | MAC.W  @Rm+,@Rn+    |                      |                      |
------+------+------+------+----------------------+----------------------+----------------------+----------------------
0101  | Rn   | Rm   | disp | MOV.L  @(disp:4,Rm),Rn
------+------+------+------+----------------------+----------------------+----------------------+----------------------
0110  | Rn   | Rm   | 00MD | MOV.B  @Rm,Rn        | MOV.W  @Rm,Rn        | MOV.L  @Rm,Rn        | MOV    Rm,Rn
0110  | Rn   | Rm   | 01MD | MOV.B  @Rm+,Rn       | MOV.W  @Rm+,Rn       | MOV.L  @Rm+,Rn       | NOT    Rm,Rn
0110  | Rn   | Rm   | 10MD | SWAP.B Rm,Rn         | SWAP.W Rm,Rn         | NEGC   Rm,Rn         | NEG    Rm,Rn
0110  | Rn   | Rm   | 11MD | EXTU.B Rm,Rn         | EXTU.W Rm,Rn         | EXTS.B Rm,Rn         | EXTS.W Rm,Rn
------+------+------+------+----------------------+----------------------+----------------------+----------------------
0111  | Rn   |      | imm  | ADD    #imm:8,Rn
------+------+------+------+----------------------+----------------------+----------------------+----------------------
1000  | 00MD | Rn   | disp | MOV.B  R0,@(disp:4,Rn) | MOV.W  R0,@(disp:4,Rn)
1000  | 01MD | Rm   | disp | MOV.B  @(disp:4,Rm),R0 | MOV.W  @(disp:4,Rm),R0
1000  | 10MD |      |imm/d | CMP/EQ #imm:8,R0     | BT     label:8       |                      | BF     label:8
1000  | 11MD |      |imm/d |                      | BT/S   label:8*      |                      | BF/S   label:8*
------+------+------+------+----------------------+----------------------+----------------------+----------------------
1001  | Rn   |      | disp | MOV.W  @(disp:8,PC),Rn
------+------+------+------+----------------------+----------------------+----------------------+----------------------
1010  |      |      | disp | BRA    label:12
------+------+------+------+----------------------+----------------------+----------------------+----------------------
1011  |      |      | disp | BSR    label:12
------+------+------+------+----------------------+----------------------+----------------------+----------------------
1100  | 00MD |      |imm/d | MOV.B  R0,@(disp:8,GBR) | MOV.W  R0,@(disp:8,GBR) | MOV.L  R0,@(disp:8,GBR) | TRAPA  #imm:8
1100  | 01MD |      | disp | MOV.B  @(disp:8,GBR),R0 | MOV.W  @(disp:8,GBR),R0 | MOV.L  @(disp:8,GBR),R0 | MOVA   @(disp:8,PC),R0
1100  | 10MD |      | imm  | TST    #imm:8,R0     | AND    #imm:8,R0     | XOR    #imm:8,R0     | OR     #imm:8,R0
1100  | 11MD |      | imm  | TST.B  #imm:8,@(R0,GBR) | AND.B  #imm:8,@(R0,GBR) | XOR.B  #imm:8,@(R0,GBR) | OR.B   #imm:8,@(R0,GBR)
------+------+------+------+----------------------+----------------------+----------------------+----------------------
1101  | Rn   |      | disp | MOV.L  @(disp:8,PC),Rn
------+------+------+------+----------------------+----------------------+----------------------+----------------------
1110  | Rn   |      | imm  | MOV    #imm:8,Rn
------+------+------+------+----------------------+----------------------+----------------------+----------------------
1111  |      |      | ...  | (reserved / FPU on later SH variants)
```

Note: \* = SH-2 CPU instruction (not available on SH-1)

**Quick Decode Guide:** To decode a `dc.w $XYZW` value:
1. Convert hex to binary: bits[15:12] = MSB row selector
2. For MSB 0000-0110: bits[11:8] = Rn, bits[7:4] = Rm or Fx, bits[3:0] = function/mode
3. For MSB 0111: bits[11:8] = Rn, bits[7:0] = 8-bit immediate
4. For MSB 1000: bits[11:10] = sub-operation, bits[9:8]+[7:4] = register, bits[3:0] = displacement
5. For MSB 1001: bits[11:8] = Rn, bits[7:0] = 8-bit displacement
6. For MSB 1010-1011: bits[11:0] = 12-bit displacement (BRA/BSR)
7. For MSB 1100: bits[11:10] = sub-operation, bits[9:8] = mode, bits[7:0] = immediate/displacement
8. For MSB 1101: bits[11:8] = Rn, bits[7:0] = 8-bit displacement
9. For MSB 1110: bits[11:8] = Rn, bits[7:0] = 8-bit immediate

---
