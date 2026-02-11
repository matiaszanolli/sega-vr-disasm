# Motorola M68000 Family Programmer's Reference Manual

**Document ID:** M68000PM/AD REV. 1  
**Copyright:** ©MOTOROLA INC., 1992  
**Includes CPU32 Instructions**

---

## Table of Contents

*[Will be populated as conversion progresses...]*

---

**NOTE:** This is a 646-page technical reference manual. Conversion in progress.

---

## Section 2: Addressing Capabilities

Most operations take a source operand and destination operand, compute them, and store the result in the destination location. Single-operand operations take a destination operand, compute it, and store the result in the destination location. External microprocessor references to memory are either program references that refer to program space or data references that refer to data space. They access either instruction words or operands (data items) for an instruction. Program space is the section of memory that contains the program instructions and any immediate data operands residing in the instruction stream. Data space is the section of memory that contains the program data. Data items in the instruction stream can be accessed with the program counter relative addressing modes; these accesses classify as program references.

### 2.1 Instruction Format

M68000 family instructions consist of at least one word; some have as many as 11 words. Figure 2-1 illustrates the general composition of an instruction. The first word of the instruction, called the simple effective address operation word, specifies the length of the instruction, the effective addressing mode, and the operation to be performed. The remaining words, called brief and full extension words, further specify the instruction and operands. These words can be floating-point command words, conditional predicates, immediate operands, extensions to the effective addressing mode specified in the simple effective address operation word, branch displacements, bit number or bit field specifications, special register specifications, trap operands, pack/unpack constants, or argument counts.

#### Figure 2-1. Instruction Word General Format

```
 15                                                              0
+----------------------------------------------------------------+
| SINGLE EFFECTIVE ADDRESS OPERATION WORD                        |
| (ONE WORD, SPECIFIES OPERATION AND MODES)                      |
+----------------------------------------------------------------+
| SPECIAL OPERAND SPECIFIERS                                     |
| (IF ANY, ONE OR TWO WORDS)                                     |
+----------------------------------------------------------------+
| IMMEDIATE OPERAND OR SOURCE EFFECTIVE ADDRESS EXTENSION        |
| (IF ANY, ONE TO SIX WORDS)                                     |
+----------------------------------------------------------------+
| DESTINATION EFFECTIVE ADDRESS EXTENSION                        |
| (IF ANY, ONE TO SIX WORDS)                                     |
+----------------------------------------------------------------+
```

An instruction specifies the function to be performed with an operation code and defines the location of every operand. Instructions specify an operand location by register specification, the instruction's register field holds the register's number; by effective address, the instruction's effective address field contains addressing mode information; or by implicit reference, the definition of the instruction implies the use of specific registers.

The single effective address operation word format is the basic instruction word (see Figure 2-2). The encoding of the mode field selects the addressing mode. The register field contains the general register number or a value that selects the addressing mode when the mode field contains opcode 111. Some indexed or indirect addressing modes use a combination of the simple effective address operation word followed by a brief extension word. Other indexed or indirect addressing modes consist of the simple effective address operation word and a full extension word. The longest instruction is a MOVE instruction with a full extension word for both the source and destination effective addresses and eight other extension words. It also contains 32-bit base displacements and 32-bit outer displacements for both source and destination addresses. Figure 2-2 illustrates the three formats used in an instruction word; Table 2-1 lists the field definitions for these three formats.

#### Figure 2-2. Instruction Word Specification Formats

**Single Effective Address Operation Word Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| X | X | X | X | X | X | X | X | X | X |  MODE |  REGISTER   |
|   |   |   |   |   |   |   |   |   |   | (3b)  |    (3b)     |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
                                        |  EFFECTIVE ADDRESS    |
```

**Brief Extension Word Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|D/A|  REGISTER | W/L|  SCALE  | 0 |      DISPLACEMENT         |
|   |   (3b)    |    |  (2b)   |   |         (8b)               |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Full Extension Word Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|D/A|  REGISTER | W/L|  SCALE  | 1 | BS| IS| BD SIZE | 0 | I/IS|
|   |   (3b)    |    |  (2b)   |   |   |   |  (2b)   |   | (3b)|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|              BASE DISPLACEMENT (0, 1, OR 2 WORDS)             |
+----------------------------------------------------------------+
|             OUTER DISPLACEMENT (0, 1, OR 2 WORDS)             |
+----------------------------------------------------------------+
```

#### Table 2-1. Instruction Word Format Field Definitions

**Instruction fields:**

| Field | Definition |
|-------|-----------|
| Mode | Addressing Mode |
| Register | General Register Number |

**Extension fields:**

| Field | Definition |
|-------|-----------|
| D/A | Index Register Type: 0 = Dn, 1 = An |
| W/L | Word/Long-Word Index Size: 0 = Sign-Extended Word, 1 = Long Word |
| Scale | Scale Factor: 00 = 1, 01 = 2, 10 = 4, 11 = 8 |
| BS | Base Register Suppress: 0 = Base Register Added, 1 = Base Register Suppressed |
| IS | Index Suppress: 0 = Evaluate and Add Index Operand, 1 = Suppress Index Operand |
| BD SIZE | Base Displacement Size: 00 = Reserved, 01 = Null Displacement, 10 = Word Displacement, 11 = Long Displacement |
| I/IS | Index/Indirect Selection -- Indirect and Indexing Operand Determined in Conjunction with Bit 6 (Index Suppress) |

For effective addresses that use a full extension word format, the index suppress (IS) bit and the index/indirect selection (I/IS) field determine the type of indexing and indirect action. Table 2-2 lists the index and indirect operations corresponding to all combinations of IS and I/IS values.

#### Table 2-2. IS-I/IS Memory Indirect Action Encodings

| IS | Index/Indirect | Operation |
|----|---------------|-----------|
| 0 | 000 | No Memory Indirect Action |
| 0 | 001 | Indirect Preindexed with Null Outer Displacement |
| 0 | 010 | Indirect Preindexed with Word Outer Displacement |
| 0 | 011 | Indirect Preindexed with Long Outer Displacement |
| 0 | 100 | Reserved |
| 0 | 101 | Indirect Postindexed with Null Outer Displacement |
| 0 | 110 | Indirect Postindexed with Word Outer Displacement |
| 0 | 111 | Indirect Postindexed with Long Outer Displacement |
| 1 | 000 | No Memory Indirect Action |
| 1 | 001 | Memory Indirect with Null Outer Displacement |
| 1 | 010 | Memory Indirect with Word Outer Displacement |
| 1 | 011 | Memory Indirect with Long Outer Displacement |
| 1 | 100-111 | Reserved |

---

### 2.2 Effective Addressing Modes

Besides the operation code, which specifies the function to be performed, an instruction defines the location of every operand for the function. Instructions specify an operand location in one of three ways. A register field within an instruction can specify the register to be used; an instruction's effective address field can contain addressing mode information; or the instruction's definition can imply the use of a specific register. Other fields within the instruction specify whether the register selected is an address or data register and how the register is to be used. **Section 1 Introduction** contains detailed register descriptions.

An instruction's addressing mode specifies the value of an operand, a register that contains the operand, or how to derive the effective address of an operand in memory. Each addressing mode has an assembler syntax. Some instructions imply the addressing mode for an operand. These instructions include the appropriate fields for operands that use only one addressing mode.

#### 2.2.1 Data Register Direct Mode

In the data register direct mode, the effective address field specifies the data register containing the operand.

```
GENERATION:                 EA = Dn
ASSEMBLER SYNTAX:           Dn
EA MODE FIELD:              000
EA REGISTER FIELD:          REG. NO.
NUMBER OF EXTENSION WORDS:  0

+--------------------------------------+
| DATA REGISTER  -->  | OPERAND        |
+--------------------------------------+
```

#### 2.2.2 Address Register Direct Mode

In the address register direct mode, the effective address field specifies the address register containing the operand.

```
GENERATION:                 EA = An
ASSEMBLER SYNTAX:           An
EA MODE FIELD:              001
EA REGISTER FIELD:          REG. NO.
NUMBER OF EXTENSION WORDS:  0

+--------------------------------------+
| ADDRESS REGISTER -->| OPERAND        |
+--------------------------------------+
```

#### 2.2.3 Address Register Indirect Mode

In the address register indirect mode, the operand is in memory. The effective address field specifies the address register containing the address of the operand in memory.

```
GENERATION:                 EA = (An)
ASSEMBLER SYNTAX:           (An)
EA MODE FIELD:              010
EA REGISTER FIELD:          REG. NO.
NUMBER OF EXTENSION WORDS:  0

                        31                        0
ADDRESS REGISTER  ----> | OPERAND POINTER          |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.4 Address Register Indirect with Postincrement Mode

In the address register indirect with postincrement mode, the operand is in memory. The effective address field specifies the address register containing the address of the operand in memory. After the operand address is used, it is incremented by one, two, or four depending on the size of the operand: byte, word, or long word, respectively. Coprocessors may support incrementing for any operand size, up to 255 bytes. If the address register is the stack pointer and the operand size is byte, the address is incremented by two to keep the stack pointer aligned to a word boundary.

```
GENERATION:                 EA = (An) + SIZE
ASSEMBLER SYNTAX:           (An)+
EA MODE FIELD:              011
EA REGISTER FIELD:          REG. NO.
NUMBER OF EXTENSION WORDS:  0

                        31                        0
ADDRESS REGISTER  ----> | CONTENTS                 |
                          |
                          v
OPERAND LENGTH (1,2,4)  | SIZE |-->(+)
                        31       v                0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.5 Address Register Indirect with Predecrement Mode

In the address register indirect with predecrement mode, the operand is in memory. The effective address field specifies the address register containing the address of the operand in memory. Before the operand address is used, it is decremented by one, two, or four depending on the operand size: byte, word, or long word, respectively. Coprocessors may support decrementing for any operand size up to 255 bytes. If the address register is the stack pointer and the operand size is byte, the address is decremented by two to keep the stack pointer aligned to a word boundary.

```
GENERATION:                 EA = (An) - SIZE
ASSEMBLER SYNTAX:           -(An)
EA MODE FIELD:              100
EA REGISTER FIELD:          REG. NO.
NUMBER OF EXTENSION WORDS:  0

                        31                        0
ADDRESS REGISTER  ----> | CONTENTS                 |
                          |
                          v
OPERAND LENGTH (1,2,4)  | SIZE |-->(-)
                        31       v                0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.6 Address Register Indirect with Displacement Mode

In the address register indirect with displacement mode, the operand is in memory. The sum of the address in the address register, which the effective address specifies, plus the sign-extended 16-bit displacement integer in the extension word is the operand's address in memory. Displacements are always sign-extended to 32 bits prior to being used in effective address calculations.

```
GENERATION:                 EA = (An) + d16
ASSEMBLER SYNTAX:           (d16,An)
EA MODE FIELD:              101
EA REGISTER FIELD:          REG. NO.
NUMBER OF EXTENSION WORDS:  1

                        31                        0
ADDRESS REGISTER  ----> | CONTENTS                 |
                          |                     v
                  31        15                0
DISPLACEMENT  --> |SIGN EXTENDED|  INTEGER     |-->(+)
                        31       v                0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.7 Address Register Indirect with Index (8-Bit Displacement) Mode

This addressing mode requires one extension word that contains an index register indicator and an 8-bit displacement. The index register indicator includes size and scale information. In this mode, the operand is in memory. The operand's address is the sum of the address register's contents; the sign-extended displacement value in the extension word's low-order eight bits; and the index register's sign-extended contents (possibly scaled). The user must specify the address register, the displacement, and the index register in this mode.

```
GENERATION:                 EA = (An) + (Xn) + d8
ASSEMBLER SYNTAX:           (d8,An,Xn.SIZE*SCALE)
EA MODE FIELD:              110
EA REGISTER FIELD:          REG. NO.
NUMBER OF EXTENSION WORDS:  1

                        31                        0
ADDRESS REGISTER  ----> | CONTENTS                 |
                          |                     v
                  31         7              0
DISPLACEMENT  --> |SIGN EXTENDED| INTEGER   |-->(+)
                  31                          0     |
INDEX REGISTER -> | SIGN-EXTENDED VALUE        |    |
                                               v    v
SCALE  ---------> | SCALE VALUE |--->(x)---->(+)
                        31                        0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.8 Address Register Indirect with Index (Base Displacement) Mode

This addressing mode requires an index register indicator and an optional 16- or 32-bit sign-extended base displacement. The index register indicator includes size and scaling information. The operand is in memory. The operand's address is the sum of the contents of the address register, the base displacement, and the scaled contents of the sign-extended index register.

In this mode, the address register, the index register, and the displacement are all optional. The effective address is zero if there is no specification. This mode provides a data register indirect address when there is no specific address register and the index register is a data register.

```
GENERATION:                 EA = (An) + (Xn) + bd
ASSEMBLER SYNTAX:           (bd,An,Xn.SIZE*SCALE)
EA MODE FIELD:              110
EA REGISTER FIELD:          REG. NO.
NUMBER OF EXTENSION WORDS:  1, 2, OR 3

                        31                        0
ADDRESS REGISTER  ----> | CONTENTS                 |
                          |                     v
                  31                          0
BASE DISPLACEMENT --> | SIGN-EXTENDED VALUE    |-->(+)
                  31                          0     |
INDEX REGISTER -----> | SIGN-EXTENDED VALUE    |    |
                                               v    v
SCALE  ------------> | SCALE VALUE |--->(x)-->(+)
                        31                        0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.9 Memory Indirect Postindexed Mode

In this mode, both the operand and its address are in memory. The processor calculates an intermediate indirect memory address using a base address register and base displacement. The processor accesses a long word at this address and adds the index operand (Xn.SIZE\*SCALE) and the outer displacement to yield the effective address. Both displacements and the index register contents are sign-extended to 32 bits.

In the syntax for this mode, brackets enclose the values used to calculate the intermediate memory address. All four user-specified values are optional. Both the base and outer displacements may be null, word, or long word. When omitting a displacement or suppressing an element, its value is zero in the effective address calculation.

```
GENERATION:                 EA = (An + bd) + Xn.SIZE*SCALE + od
ASSEMBLER SYNTAX:           ([bd,An],Xn.SIZE*SCALE,od)
EA MODE FIELD:              110
EA REGISTER FIELD:          REG. NO.
NUMBER OF EXTENSION WORDS:  1, 2, 3, 4, OR 5

                        31                        0
ADDRESS REGISTER  ----> | CONTENTS                 |
                          |                     v
                  31                          0
BASE DISPLACEMENT --> | SIGN-EXTENDED VALUE    |-->(+)
                        31                        0
INTERMEDIATE ADDRESS -> | CONTENTS                 |
                          |
                     POINTS TO
                        31                        0
MEMORY  --------------> | VALUE AT INDIRECT MEM ADDR|
                  31                          0     |
INDEX REGISTER -----> | SIGN-EXTENDED VALUE    |    |
                                               v    v
SCALE  ------------> | SCALE VALUE |--->(x)-->(+)
                  31                          0     |
OUTER DISPLACEMENT -> | SIGN-EXTENDED VALUE    |-->(+)
                        31                        0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.10 Memory Indirect Preindexed Mode

In this mode, both the operand and its address are in memory. The processor calculates an intermediate indirect memory address using a base address register, a base displacement, and the index operand (Xn.SIZE\*SCALE). The processor accesses a long word at this address and adds the outer displacement to yield the effective address. Both displacements and the index register contents are sign-extended to 32 bits.

In the syntax for this mode, brackets enclose the values used to calculate the intermediate memory address. All four user-specified values are optional. Both the base and outer displacements may be null, word, or long word. When omitting a displacement or suppressing an element, its value is zero in the effective address calculation.

```
GENERATION:                 EA = (bd + An) + Xn.SIZE*SCALE + od
ASSEMBLER SYNTAX:           ([bd,An,Xn.SIZE*SCALE],od)
EA MODE FIELD:              110
EA REGISTER FIELD:          REG. NO.
NUMBER OF EXTENSION WORDS:  1, 2, 3, 4, OR 5

                        31                        0
ADDRESS REGISTER  ----> | CONTENTS                 |
                          |                     v
                  31                          0
BASE DISPLACEMENT --> | SIGN-EXTENDED VALUE    |-->(+)
                  31                          0     |
INDEX REGISTER -----> | SIGN-EXTENDED VALUE    |    |
                                               v    v
SCALE  ------------> | SCALE VALUE |--->(x)-->(+)
                        31                        0
INTERMEDIATE ADDRESS -> | INDIRECT MEMORY ADDRESS  |
                          |
                     POINTS TO
                        31                        0
MEMORY  --------------> | VALUE AT INDIRECT MEM ADDR|
                  31                          0     |
OUTER DISPLACEMENT -> | SIGN-EXTENDED VALUE    |-->(+)
                        31                        0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.11 Program Counter Indirect with Displacement Mode

In this mode, the operand is in memory. The address of the operand is the sum of the address in the program counter (PC) and the sign-extended 16-bit displacement integer in the extension word. The value in the PC is the address of the extension word. This is a program reference allowed only for reads.

```
GENERATION:                 EA = (PC) + d16
ASSEMBLER SYNTAX:           (d16,PC)
EA MODE FIELD:              111
EA REGISTER FIELD:          010
NUMBER OF EXTENSION WORDS:  1

                        31                        0
PROGRAM COUNTER  -----> | CONTENTS                 |
                          |                     v
                  31        15                0
DISPLACEMENT  --> |SIGN EXTENDED|  INTEGER     |-->(+)
                        31       v                0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.12 Program Counter Indirect with Index (8-Bit Displacement) Mode

This mode is similar to the mode described in **2.2.7 Address Register Indirect with Index (8-Bit Displacement) Mode**, except the PC is the base register. The operand is in memory. The operand's address is the sum of the address in the PC, the sign-extended displacement integer in the extension word's lower eight bits, and the sized, scaled, and sign-extended index operand. The value in the PC is the address of the extension word. This is a program reference allowed only for reads. The user must include the displacement, the PC, and the index register when specifying this addressing mode.

```
GENERATION:                 EA = (PC) + (Xn) + d8
ASSEMBLER SYNTAX:           (d8,PC,Xn.SIZE*SCALE)
EA MODE FIELD:              111
EA REGISTER FIELD:          011
NUMBER OF EXTENSION WORDS:  1

                        31                        0
PROGRAM COUNTER  -----> | CONTENTS                 |
                          |                     v
                  31         7              0
DISPLACEMENT  --> |SIGN EXTENDED| INTEGER   |-->(+)
                  31                          0     |
INDEX REGISTER -> | SIGN-EXTENDED VALUE        |    |
                                               v    v
SCALE  ---------> | SCALE VALUE |--->(x)---->(+)
                        31                        0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.13 Program Counter Indirect with Index (Base Displacement) Mode

This mode is similar to the mode described in **2.2.8 Address Register Indirect with Index (Base Displacement) Mode**, except the PC is the base register. It requires an index register indicator and an optional 16- or 32-bit sign-extended base displacement. The operand is in memory. The operand's address is the sum of the contents of the PC, the base displacement, and the scaled contents of the sign-extended index register. The value of the PC is the address of the first extension word. This is a program reference allowed only for reads.

In this mode, the PC, the displacement, and the index register are optional. The user must supply the assembler notation ZPC (a zero value PC) to show that the PC is not used. This allows the user to access the program space without using the PC in calculating the effective address. The user can access the program space with a data register indirect access by placing ZPC in the instruction and specifying a data register as the index register.

```
GENERATION:                 EA = (PC) + (Xn) + bd
ASSEMBLER SYNTAX:           (bd,PC,Xn.SIZE*SCALE)
EA MODE FIELD:              111
EA REGISTER FIELD:          011
NUMBER OF EXTENSION WORDS:  1, 2, OR 3

                        31                        0
PROGRAM COUNTER  -----> | CONTENTS                 |
                          |                     v
                  31                          0
DISPLACEMENT -------> | SIGN-EXTENDED VALUE    |-->(+)
                  31                          0     |
INDEX REGISTER -----> | SIGN-EXTENDED VALUE    |    |
                                               v    v
SCALE  ------------> | SCALE VALUE |--->(x)-->(+)
                        31                        0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.14 Program Counter Memory Indirect Postindexed Mode

This mode is similar to the mode described in **2.2.9 Memory Indirect Postindexed Mode**, but the PC is the base register. Both the operand and operand address are in memory. The processor calculates an intermediate indirect memory address by adding a base displacement to the PC contents. The processor accesses a long word at that address and adds the scaled contents of the index register and the optional outer displacement to yield the effective address. The value of the PC used in the calculation is the address of the first extension word. This is a program reference allowed only for reads.

In the syntax for this mode, brackets enclose the values used to calculate the intermediate memory address. All four user-specified values are optional. The user must supply the assembler notation ZPC to show the PC is not used. This allows the user to access the program space without using the PC in calculating the effective address. The base and outer displacements may be null, word, or long word. When omitting a displacement or suppressing an element, its value is zero in the effective address calculation.

```
GENERATION:                 EA = (bd + PC) + Xn.SIZE*SCALE + od
ASSEMBLER SYNTAX:           ([bd,PC],Xn.SIZE*SCALE,od)
EA MODE FIELD:              111
EA REGISTER FIELD:          011
NUMBER OF EXTENSION WORDS:  1, 2, 3, 4, or 5

                        31                        0
PROGRAM COUNTER  -----> | CONTENTS                 |
                          |                     v
                  31                          0
BASE DISPLACEMENT --> | SIGN-EXTENDED VALUE    |-->(+)
                        31                        0
INTERMEDIATE ADDRESS -> | CONTENTS                 |
                          |
                     POINTS TO
                        31                        0
MEMORY  --------------> | VALUE AT INDIRECT MEM ADDR IN PROG. SPACE |
                  31                          0     |
INDEX REGISTER -----> | SIGN-EXTENDED VALUE    |    |
                                               v    v
SCALE  ------------> | SCALE VALUE |--->(x)-->(+)
                  31                          0     |
OUTER DISPLACEMENT -> | SIGN-EXTENDED VALUE    |-->(+)
                        31                        0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.15 Program Counter Memory Indirect Preindexed Mode

This mode is similar to the mode described in **2.2.10 Memory Indirect Preindexed Mode**, but the PC is the base register. Both the operand and operand address are in memory. The processor calculates an intermediate indirect memory address by adding the PC contents, a base displacement, and the scaled contents of an index register. The processor accesses a long word at immediate indirect memory address and adds the optional outer displacement to yield the effective address. The value of the PC is the address of the first extension word. This is a program reference allowed only for reads.

In the syntax for this mode, brackets enclose the values used to calculate the intermediate memory address. All four user-specified values are optional. The user must supply the assembler notation ZPC showing that the PC is not used. This allows the user to access the program space without using the PC in calculating the effective address. Both the base and outer displacements may be null, word, or long word. When omitting a displacement or suppressing an element, its value is zero in the effective address calculation.

```
GENERATION:                 EA = (bd + PC) + Xn.SIZE*SCALE + od
ASSEMBLER SYNTAX:           ([bd,PC,Xn.SIZE*SCALE],od)
EA MODE FIELD:              111
EA REGISTER FIELD:          011
NUMBER OF EXTENSION WORDS:  1, 2, 3, 4, or 5

                        31                        0
PROGRAM COUNTER  -----> | CONTENTS                 |
                          |                     v
                  31                          0
BASE DISPLACEMENT --> | SIGN-EXTENDED VALUE    |-->(+)
                  31                          0     |
INDEX REGISTER -----> | SIGN-EXTENDED VALUE    |    |
                                               v    v
SCALE  ------------> | SCALE VALUE |--->(x)-->(+)
                        31                        0
INTERMEDIATE ADDRESS -> | INDIRECT MEMORY ADDRESS  |
                          |
                     POINTS TO
                        31                        0
MEMORY  --------------> | VALUE AT INDIRECT MEM ADDR IN PROG. SPACE |
                  31                          0     |
OUTER DISPLACEMENT -> | SIGN-EXTENDED VALUE    |-->(+)
                        31                        0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.16 Absolute Short Addressing Mode

In this addressing mode, the operand is in memory, and the address of the operand is in the extension word. The 16-bit address is sign-extended to 32 bits before it is used.

```
GENERATION:                 EA GIVEN
ASSEMBLER SYNTAX:           (xxx).W
EA MODE FIELD:              111
EA REGISTER FIELD:          000
NUMBER OF EXTENSION WORDS:  1

                  31        15                0
EXTENSION WORD -> |SIGN-EXTENDED| EXTENSION VALUE |
                        31       v                0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.17 Absolute Long Addressing Mode

In this addressing mode, the operand is in memory, and the operand's address occupies the two extension words following the instruction word in memory. The first extension word contains the high-order part of the address; the second contains the low-order part of the address.

```
GENERATION:                 EA GIVEN
ASSEMBLER SYNTAX:           (xxx).L
EA MODE FIELD:              111
EA REGISTER FIELD:          001
NUMBER OF EXTENSION WORDS:  2

                        15                    0
FIRST EXTENSION WORD -> | ADDRESS HIGH         |
                        15                    0
SECOND EXTENSION WORD > | ADDRESS LOW          |
                        31       v                0
OPERAND POINTER  -----> | CONTENTS                 |
                          |
                     POINTS TO
                          v
MEMORY  --------------> | OPERAND                  |
```

#### 2.2.18 Immediate Data

In this addressing mode, the operand is in one or two extension words. Table 2-3 lists the location of the operand within the instruction word format. The immediate data format is as follows:

```
GENERATION:                 OPERAND GIVEN
ASSEMBLER SYNTAX:           #<xxx>
EA MODE FIELD:              111
EA REGISTER FIELD:          100
NUMBER OF EXTENSION WORDS:  1, 2, 4, OR 6, EXCEPT FOR PACKED DECIMAL REAL OPERANDS
```

#### Table 2-3. Immediate Operand Location

| Operation Length | Location |
|-----------------|----------|
| Byte | Low-order byte of the extension word. |
| Word | The entire extension word. |
| Long Word | High-order word of the operand is in the first extension word; the low-order word is in the second extension word. |
| Single-Precision | In two extension words. |
| Double-Precision | In four extension words. |
| Extended-Precision | In six extension words. |
| Packed-Decimal Real | In six extension words. |

---

### 2.3 Effective Addressing Mode Summary

Effective addressing modes are grouped according to the use of the mode. Data addressing modes refer to data operands. Memory addressing modes refer to memory operands. Alterable addressing modes refer to alterable (writable) operands. Control addressing modes refer to memory operands without an associated size.

These categories sometimes combine to form new categories that are more restrictive. Two combined classifications are alterable memory (addressing modes that are both alterable and memory addresses) and data alterable (addressing modes that are both alterable and data). Table 2-4 lists a summary of effective addressing modes and their categories.

#### Table 2-4. Effective Addressing Modes and Categories

| Addressing Modes | Syntax | Mode Field | Reg. Field | Data | Memory | Control | Alterable |
|-----------------|--------|-----------|-----------|------|--------|---------|-----------|
| **Register Direct** | | | | | | | |
| Data | Dn | 000 | reg. no. | X | -- | -- | X |
| Address | An | 001 | reg. no. | -- | -- | -- | X |
| **Register Indirect** | | | | | | | |
| Address | (An) | 010 | reg. no. | X | X | X | X |
| Address with Postincrement | (An)+ | 011 | reg. no. | X | X | -- | X |
| Address with Predecrement | -(An) | 100 | reg. no. | X | X | -- | X |
| Address with Displacement | (d16,An) | 101 | reg. no. | X | X | X | X |
| **Address Register Indirect with Index** | | | | | | | |
| 8-Bit Displacement | (d8,An,Xn) | 110 | reg. no. | X | X | X | X |
| Base Displacement | (bd,An,Xn) | 110 | reg. no. | X | X | X | X |
| **Memory Indirect** | | | | | | | |
| Postindexed | ([bd,An],Xn,od) | 110 | reg. no. | X | X | X | X |
| Preindexed | ([bd,An,Xn],od) | 110 | reg. no. | X | X | X | X |
| **Program Counter Indirect** | | | | | | | |
| with Displacement | (d16,PC) | 111 | 010 | X | X | X | -- |
| **Program Counter Indirect with Index** | | | | | | | |
| 8-Bit Displacement | (d8,PC,Xn) | 111 | 011 | X | X | X | -- |
| Base Displacement | (bd,PC,Xn) | 111 | 011 | X | X | X | -- |
| **Program Counter Memory Indirect** | | | | | | | |
| Postindexed | ([bd,PC],Xn,od) | 111 | 011 | X | X | X | X |
| Preindexed | ([bd,PC,Xn],od) | 111 | 011 | X | X | X | X |
| **Absolute Data Addressing** | | | | | | | |
| Short | (xxx).W | 111 | 000 | X | X | X | -- |
| Long | (xxx).L | 111 | 000 | X | X | X | -- |
| **Immediate** | #\<xxx\> | 111 | 100 | X | X | -- | -- |

---

### 2.4 Brief Extension Word Format Compatibility

Programs can be easily transported from one member of the M68000 family to another in an upward-compatible fashion. The user object code of each early member of the family, which is upward compatible with newer members, can be executed on the newer microprocessor without change. Brief extension word formats are encoded with information that allows the CPU32, MC68020, MC68030, and MC68040 to distinguish the basic M68000 family architecture's new address extensions. Figure 2-3 illustrates these brief extension word formats. The encoding for SCALE used by the CPU32, MC68020, MC68030, and MC68040 is a compatible extension of the M68000 family architecture. A value of zero for SCALE is the same encoding for both extension words. Software that uses this encoding is compatible with all processors in the M68000 family. Both brief extension word formats do not contain the other values of SCALE. Software can be easily migrated in an upward-compatible direction, with downward support only for nonscaled addressing. If the MC68000 were to execute an instruction that encoded a scaling factor, the scaling factor would be ignored and would not access the desired memory address. The earlier microprocessors do not recognize the brief extension word formats implemented by newer processors. Although they can detect illegal instructions, they do not decode invalid encodings of the brief extension word formats as exceptions.

#### Figure 2-3. M68000 Family Brief Extension Word Formats

**(a) MC68000, MC68008, and MC68010:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|D/A|  REGISTER | W/L| 0 | 0 | 0 |    DISPLACEMENT INTEGER     |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**(b) CPU32, MC68020, MC68030, and MC68040:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|D/A|  REGISTER | W/L|  SCALE  | 0 |    DISPLACEMENT INTEGER     |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

---

### 2.5 Full Extension Addressing Modes

The full extension word format provides additional addressing modes for the MC68020, MC68030, and MC68040. There are four elements common to these full extension addressing modes: a base register (BR), an index register (Xn), a base displacement (bd), and an outer displacement (od). Each of these four elements can be suppressed independently of each other. However, at least one element must be active and not suppressed. When an element is suppressed, it has an effective value of zero.

BR can be suppressed through the BS field of the full extension word format. The encoding of bits 0-5 in the single effective address word format (see Figure 2-2) selects BR as either the PC when using program relative addressing modes, or An when using non-program relative addressing modes. The value of the PC is the address of the extension word. For the non-program relative addressing modes, BR is the contents of a selected An.

SIZE and SCALE can be used to modify Xn. The W/L field in the full extension format selects the size of Xn as a word or long word. The SCALE field selects the scaling factor, shifts the value of the Xn left multiplying the value by 1, 2, 4, or 8, respectively, without actually changing the value. Scaling can be used to calculate the address of arrayed structures. Figure 2-4 illustrates the scaling of an Xn.

The bd and od can be either word or long word. The size of od is selected through the encoding of the I/IS field in the full extension word format (refer to Table 2-2). There are two main modes of operation that use these four elements in different ways: no memory indirect action and memory indirect. The od is provided only for using memory indirect addressing modes of which there are three types: with preindex, with postindex, and with index suppressed.

#### Figure 2-4. Addressing Array Items

```
SYNTAX: MOVE.B (A5, A6.L*SCALE),(A7)
WHERE:
    A5 = ADDRESS OF ARRAY STRUCTURE
    A6 = INDEX NUMBER OF ARRAY ITEM
    A7 = STACK POINTER

SIMPLE ARRAY (SCALE = 1):        RECORD OF 2 BYTES (SCALE = 2):
+---+                            +-------+
| 0 | <-- A6=0                   |   0   | <-- A6=0
+---+                            +-------+
| 1 |                            |   1   |
+---+                            +-------+
| 2 |                            ...
+---+
| 3 |
+---+
...

RECORD OF 4 BYTES (SCALE = 4):  RECORD OF 8 BYTES (SCALE = 8):
+-----------+                    +-------------------+
|     0     | <-- A6=0           |         0         | <-- A6=0
+-----------+                    +-------------------+
|     1     |                    |         1         |
+-----------+                    +-------------------+
...                              ...

NOTE: Regardless of array structure, software increments
      index by the appropriate amount to point to next record.
```

#### 2.5.1 No Memory Indirect Action Mode

No memory indirect action mode uses BR, Xn with its modifiers, and bd to calculate the address of the required operand. Data register indirect (Dn) and absolute address with index (bd,Xn.SIZE\*SCALE) are examples of the no memory indirect action mode. Figure 2-5 illustrates the no memory indirect action mode.

| BR | Xn | bd | Addressing Mode |
|----|----|----|----------------|
| S | S | S | Not Applicable |
| S | S | A | Absolute Addressing Mode |
| S | A | S | Register Indirect |
| S | A | A | Register Indirect with Constant Index |
| An | S | S | Address Register Indirect |
| An | S | A | Address Register Indirect with Constant Index |
| An | A | S | Address Register Indirect with Variable Index |
| An | A | A | Address Register Indirect with Constant and Variable Index |
| PC | S | S | PC Relative |
| PC | S | A | PC Relative with Constant Index |
| PC | A | S | PC Relative with Variable Index |
| PC | A | A | PC Relative with Constant and Variable Index |

NOTE: S indicates suppressed and A indicates active.

#### Figure 2-5. No Memory Indirect Action

```
+------------------+
| An or PC ------> |
|                  |
|    bd.BD SIZE    |
|        |         |
|        v         |
|   Xn.SIZE*SCALE  |
|        |         |
|        v         |
|     OPERAND      |
+------------------+
```

#### 2.5.2 Memory Indirect Modes

Memory indirect modes fetch two operands from memory. The BR and bd evaluate the address of the first operand, intermediate memory pointer (IMP). The value of IMP and the od evaluates the address of the second operand.

There are three types of memory indirect modes: pre-index, post-index, and index register suppressed. Xn and its modifiers can be allocated to determine either the address of the IMP (pre-index) or to the address of the second operand (post-index).

##### 2.5.2.1 Memory Indirect with Preindex

The Xn is allocated to determine the address of the IMP. Figure 2-6 illustrates the memory indirect with pre-indexing mode.

| BR | Xn | bd | od | IMP Addressing Mode | Operand Addressing Mode |
|----|----|----|----|--------------------|------------------------|
| S | A | S | S | Register Indirect | Memory Pointer Directly to Data Operand |
| S | A | S | A | Register Indirect | Memory Pointer as Base with Displacement to Data Operand |
| S | A | A | S | Register Indirect with Constant Index | Memory Pointer Directly to Data Operand |
| S | A | A | A | Register Indirect with Constant Index | Memory Pointer as Base with Displacement to Data Operand |
| An | A | S | S | Address Register Indirect with Variable Index | Memory Pointer Directly to Data Operand |
| An | A | S | A | Address Register Indirect with Variable Index | Memory Pointer as Base with Displacement to Data Operand |
| An | A | A | S | Address Register Indirect with Constant and Variable Index | Memory Pointer Directly to Data Operand |
| An | A | A | A | Address Register Indirect with Constant and Variable Index | Memory Pointer as Base with Displacement to Data Operand |
| PC | A | S | S | PC Relative with Variable Index | Memory Pointer Directly to Data Operand |
| PC | A | S | A | PC Relative with Variable Index | Memory Pointer as Base with Displacement to Data Operand |
| PC | A | A | S | PC Relative with Constant and Variable Index | Memory Pointer Directly to Data Operand |
| PC | A | A | A | PC Relative with Constant and Variable Index | Memory Pointer as Base with Displacement to Data Operand |

NOTE: S indicates suppressed and A indicates active.

#### Figure 2-6. Memory Indirect with Preindex

```
+------------------+     +------------------+
| An or PC ------> |     |                  |
|                  |     |   od.OD SIZE     |
|    bd.BD SIZE    |     |       |          |
|        |         |     |       v          |
|        v         |     |    OPERAND       |
|   Xn.SIZE*SCALE  |     +------------------+
|        |         |
|        v         |
|       IMP -------+----->
+------------------+
```

##### 2.5.2.2 Memory Indirect with Postindex

The Xn is allocated to evaluate the address of the second operand. Figure 2-7 illustrates the memory indirect with post-indexing mode.

| BR | Xn | bd | od | IMP Addressing Mode | Operand Addressing Mode |
|----|----|----|----|--------------------|------------------------|
| S | A | S | S | -- | -- |
| S | A | S | A | -- | -- |
| S | A | A | S | Absolute Addressing Mode | Memory Pointer with Variable Index to Data Operand |
| S | A | A | A | Absolute Addressing Mode | Memory Pointer with Constant and Variable Index to Data Operand |
| An | A | S | S | Address Register Indirect | Memory Pointer with Variable Index to Data Operand |
| An | A | S | A | Address Register Indirect | Memory Pointer with Constant and Variable Index to Data Operand |
| An | A | A | S | Address Register Indirect with Constant Index | Memory Pointer with Variable Index to Data Operand |
| An | A | A | A | Address Register Indirect with Constant Index | Memory Pointer with Constant and Variable Index to Data Operand |
| PC | A | S | S | PC Relative | Memory Pointer with Variable Index to Data Operand |
| PC | A | S | A | PC Relative | Memory Pointer with Constant and Variable Index to Data Operand |
| PC | A | A | S | PC Relative with Constant Index | Memory Pointer with Variable Index to Data Operand |
| PC | A | A | A | PC Relative with Constant Index | Memory Pointer with Constant and Variable Index to Data Operand |

NOTE: S indicates suppressed and A indicates active.

#### Figure 2-7. Memory Indirect with Postindex

```
+------------------+     +------------------+
| An or PC ------> |     |   Xn.SIZE*SCALE  |
|                  |     |       |          |
|    bd.BD SIZE    |     |       v          |
|        |         |     |   od.OD SIZE     |
|        v         |     |       |          |
|       IMP -------+---->|       v          |
+------------------+     |    OPERAND       |
                          +------------------+
```

##### 2.5.2.3 Memory Indirect with Index Suppressed

The Xn is suppressed. Figure 2-8 illustrates the memory indirect with index suppressed mode.

| BR | Xn | bd | od | IMP Addressing Mode | Operand Addressing Mode |
|----|----|----|----|--------------------|------------------------|
| S | S | S | S | -- | -- |
| S | S | S | A | -- | -- |
| S | S | A | S | Absolute Addressing Mode | Memory Pointer Directly to Data Operand |
| S | S | A | A | Absolute Addressing Mode | Memory Pointer as Base with Displacement to Data Operand |
| An | S | S | S | Address Register Indirect | Memory Pointer Directly to Data Operand |
| An | S | S | A | Address Register Indirect | Memory Pointer as Base with Displacement to Data Operand |
| An | S | A | S | Address Register Indirect with Constant Index | Memory Pointer Directly to Data Operand |
| An | S | A | A | Address Register Indirect with Constant Index | Memory Pointer as Base with Displacement to Data Operand |
| PC | S | S | S | PC Relative | Memory Pointer Directly to Data Operand |
| PC | S | S | A | PC Relative | Memory Pointer as Base with Displacement to Data Operand |
| PC | S | A | S | PC Relative with Constant Index | Memory Pointer Directly to Data Operand |
| PC | S | A | A | PC Relative with Constant Index | Memory Pointer as Base with Displacement to Data Operand |

NOTE: S indicates suppressed and A indicates active.

#### Figure 2-8. Memory Indirect with Index Suppress

```
+------------------+     +------------------+
| An or PC ------> |     |   od.OD SIZE     |
|                  |     |       |          |
|    bd.BD SIZE    |     |       v          |
|        |         |     |    OPERAND       |
|        v         |     +------------------+
|       IMP -------+----->
+------------------+
```

---

### 2.6 Other Data Structures

Stacks and queues are common data structures. The M68000 family implements a system stack and instructions that support user stacks and queues.

#### 2.6.1 System Stack

Address register seven (A7) is the system stack pointer. Either the user stack pointer (USP), the interrupt stack pointer (ISP), or the master stack pointer (MSP) is active at any one time. Refer to **Section 1 Introduction** for details on these stack pointers. To keep data on the system stack aligned for maximum efficiency, the active stack pointer is automatically decremented or incremented by two for all byte-size operands moved to or from the stack. In long-word-organized memory, aligning the stack pointer on a long-word address significantly increases the efficiency of stacking exception frames, subroutine calls and returns, and other stacking operations.

The user can implement stacks with the address register indirect with postincrement and predecrement addressing modes. With an address register the user can implement a stack that fills either from high memory to low memory or from low memory to high memory. Important considerations are:

- Use the predecrement mode to decrement the register before using its contents as the pointer to the stack.
- Use the postincrement mode to increment the register after using its contents as the pointer to the stack.
- Maintain the stack pointer correctly when byte, word, and long-word items mix in these stacks.

To implement stack growth from high memory to low memory, use -(An) to push data on the stack and (An)+ to pull data from the stack. For this type of stack, after either a push or a pull operation, the address register points to the top item on the stack.

```
Stack: High-to-Low Memory Growth

+------------------+
|   LOW MEMORY     |
|     (FREE)       |
| An --> TOP OF STACK |
|       ...        |
|  BOTTOM OF STACK |
|   HIGH MEMORY    |
+------------------+
```

To implement stack growth from low memory to high memory, use (An)+ to push data on the stack and -(An) to pull data from the stack. After either a push or pull operation, the address register points to the next available space on the stack.

```
Stack: Low-to-High Memory Growth

+------------------+
|   LOW MEMORY     |
|  BOTTOM OF STACK |
|       ...        |
|   TOP OF STACK   |
| An --> (FREE)    |
|   HIGH MEMORY    |
+------------------+
```

#### 2.6.2 Queues

The user can implement queues, groups of information waiting to be processed, with the address register indirect with postincrement or predecrement addressing modes. Using a pair of address registers, the user implements a queue that fills either from high memory to low memory or from low memory to high memory. Two registers are used because queues get pushed from one end and pulled from the other. One address register contains the put pointer; the other register the get pointer. To implement growth of the queue from low memory to high memory, use the put address register to put data into the queue and the get address register to get data from the queue.

After a put operation, the put address register points to the next available space in the queue; the unchanged get address register points to the next item to be removed from the queue. After a get operation, the get address register points to the next item to be removed from the queue; the unchanged put address register points to the next available space in the queue.

```
Queue: Low-to-High Memory Growth

+------------------+
|   LOW MEMORY     |
| LAST GET (FREE)  |
| GET (Am) --> NEXT GET |
|       ...        |
|    LAST PUT      |
| PUT (An) --> (FREE) |
|   HIGH MEMORY    |
+------------------+
```

To implement the queue as a circular buffer, the relevant address register should be checked and adjusted. If necessary, do this before performing the put or get operation. Subtracting the buffer length (in bytes) from the register adjusts the address register. To implement growth of the queue from high memory to low memory, use the put address register indirect to put data into the queue and get address register indirect to get data from the queue.

---

## Section 3: Instruction Set Summary

This section briefly describes the M68000 family instruction set, using Motorola's assembly language syntax and notation. It includes instruction set details such as notation and format, selected instruction examples, and an integer condition code discussion. The section concludes with a discussion of floating-point details such as computational accuracy, conditional test definitions, an explanation of the operation table, and a discussion of not-a-numbers (NANs) and postprocessing.

### 3.1 Instruction Summary

Instructions form a set of tools that perform the following types of operations:

| | |
|---|---|
| Data Movement | Program Control |
| Integer Arithmetic | System Control |
| Logical Operations | Cache Maintenance |
| Shift and Rotate Operations | Multiprocessor Communications |
| Bit Manipulation | Memory Management |
| Bit Field Manipulation | Floating-Point Arithmetic |
| Binary-Coded Decimal Arithmetic | |

The following paragraphs describe in detail the instruction for each type of operation. Table 3-1 lists the notations used throughout this manual. In the operand syntax statements of the instruction definitions, the operand on the right is the destination operand.

#### Table 3-1. Notational Conventions

**Single- And Double-Operand Operations**

| Symbol | Description |
|--------|-------------|
| + | Arithmetic addition or postincrement indicator. |
| -- | Arithmetic subtraction or predecrement indicator. |
| x | Arithmetic multiplication. |
| / | Arithmetic division or conjunction symbol. |
| ~ | Invert; operand is logically complemented. |
| AND | Logical AND |
| V | Logical OR |
| XOR | Logical exclusive OR |
| -> | Source operand is moved to destination operand. |
| <-> | Two operands are exchanged. |
| \<op\> | Any double-operand operation. |
| \<operand\>tested | Operand is compared to zero and the condition codes are set appropriately. |
| sign-extended | All bits of the upper portion are made equal to the high-order bit of the lower portion. |

**Other Operations**

| Symbol | Description |
|--------|-------------|
| TRAP | Equivalent to: Format/Offset Word -> (SSP); SSP - 2 -> SSP; PC -> (SSP); SSP - 4 -> SSP; SR -> (SSP); SSP - 2 -> SSP; (Vector) -> PC |
| STOP | Enter the stopped state, waiting for interrupts. |
| \<operand\>10 | The operand is BCD; operations are performed in decimal. |
| If \<condition\> then \<operations\> else \<operations\> | Test the condition. If true, the operations after "then" are performed. If the condition is false and the optional "else" clause is present, the operations after "else" are performed. If the condition is false and else is omitted, the instruction performs no operation. Refer to the Bcc instruction description as an example. |

**Register Specifications**

| Symbol | Description |
|--------|-------------|
| An | Any Address Register n (example: A3 is address register 3) |
| Ax, Ay | Source and destination address registers, respectively. |
| Dc | Data register D7-D0, used during compare. |
| Dh, Dl | Data register's high- or low-order 32 bits of product. |
| Dn | Any Data Register n (example: D5 is data register 5) |
| Dr, Dq | Data register's remainder or quotient of divide. |
| Du | Data register D7-D0, used during update. |
| Dx, Dy | Source and destination data registers, respectively. |
| MRn | Any Memory Register n. |
| Rn | Any Address or Data Register |
| Rx, Ry | Any source and destination registers, respectively. |
| Xn | Index Register |

**Data Format And Type**

| Symbol | Description |
|--------|-------------|
| + inf | Positive Infinity |
| \<fmt\> | Operand Data Format: Byte (B), Word (W), Long (L), Single (S), Double (D), Extended (X), or Packed (P). |
| B, W, L | Specifies a signed integer data type (twos complement) of byte, word, or long word. |
| D | Double-precision real data format (64 bits). |
| k | A twos complement signed integer (-64 to +17) specifying a number's format to be stored in the packed decimal format. |
| P | Packed BCD real data format (96 bits, 12 bytes). |
| S | Single-precision real data format (32 bits). |
| X | Extended-precision real data format (96 bits, 16 bits unused). |
| - inf | Negative Infinity |

**Subfields and Qualifiers**

| Symbol | Description |
|--------|-------------|
| #\<xxx\> or #\<data\> | Immediate data following the instruction word(s). |
| ( ) | Identifies an indirect address in a register. |
| [ ] | Identifies an indirect address in memory. |
| bd | Base Displacement |
| ccc | Index into the MC68881/MC68882 Constant ROM |
| dn | Displacement Value, n Bits Wide (example: d16 is a 16-bit displacement). |
| LSB | Least Significant Bit |
| LSW | Least Significant Word |
| MSB | Most Significant Bit |
| MSW | Most Significant Word |
| od | Outer Displacement |
| SCALE | A scale factor (1, 2, 4, or 8 for no-word, word, long-word, or quad-word scaling, respectively). |
| SIZE | The index register's size (W for word, L for long word). |
| {offset:width} | Bit field selection. |

**Register Names**

| Symbol | Description |
|--------|-------------|
| CCR | Condition Code Register (lower byte of status register) |
| DFC | Destination Function Code Register |
| FPcr | Any Floating-Point System Control Register (FPCR, FPSR, or FPIAR) |
| FPm, FPn | Any Floating-Point Data Register specified as the source or destination, respectively. |
| IC, DC, IC/DC | Instruction, Data, or Both Caches |
| MMUSR | MMU Status Register |
| PC | Program Counter |
| Rc | Any Non Floating-Point Control Register |
| SFC | Source Function Code Register |
| SR | Status Register |

**Register Codes**

| Symbol | Description |
|--------|-------------|
| \* | General Case |
| C | Carry Bit in CCR |
| cc | Condition Codes from CCR |
| FC | Function Code |
| N | Negative Bit in CCR |
| U | Undefined, Reserved for Motorola Use. |
| V | Overflow Bit in CCR |
| X | Extend Bit in CCR |
| Z | Zero Bit in CCR |
| -- | Not Affected or Applicable. |

**Stack Pointers**

| Symbol | Description |
|--------|-------------|
| ISP | Supervisor/Interrupt Stack Pointer |
| MSP | Supervisor/Master Stack Pointer |
| SP | Active Stack Pointer |
| SSP | Supervisor (Master or Interrupt) Stack Pointer |
| USP | User Stack Pointer |

**Miscellaneous**

| Symbol | Description |
|--------|-------------|
| \<ea\> | Effective Address |
| \<label\> | Assemble Program Label |
| \<list\> | List of registers, for example D3-D0. |
| LB | Lower Bound |
| m | Bit m of an Operand |
| m-n | Bits m through n of Operand |
| UB | Upper Bound |

---

#### 3.1.1 Data Movement Instructions

The MOVE and FMOVE instructions with their associated addressing modes are the basic means of transferring and storing addresses and data. MOVE instructions transfer byte, word, and long-word operands from memory to memory, memory to register, register to memory, and register to register. MOVE instructions transfer word and long-word operands and ensure that only valid address manipulations are executed. In addition to the general MOVE instructions, there are several special data movement instructions: MOVE16, MOVEM, MOVEP, MOVEQ, EXG, LEA, PEA, LINK, and UNLK. The MOVE16 instruction is an MC68040 extension to the M68000 instruction set.

The FMOVE instructions move operands into, out of, and between floating-point data registers. FMOVE also moves operands to and from the floating-point control register (FPCR), floating-point status register (FPSR), and floating-point instruction address register (FPIAR). For operands moved into a floating-point data register, FSMOVE and FDMOVE explicitly select single- and double-precision rounding of the result, respectively. FMOVEM moves any combination of either floating-point data registers or floating-point control registers. Table 3-2 lists the general format of these integer and floating-point data movement instructions.

#### Table 3-2. Data Movement Operation Format

| Instruction | Operand Syntax | Operand Size | Operation |
|-------------|---------------|-------------|-----------|
| EXG | Rn, Rn | 32 | Rn <-> Rn |
| FMOVE | FPm,FPn | X | Source -> Destination |
| | \<ea\>,FPn | B, W, L, S, D, X, P | |
| | FPm,\<ea\> | B, W, L, S, D, X, P | |
| | \<ea\>,FPcr | 32 | |
| | FPcr,\<ea\> | 32 | |
| FSMOVE, FDMOVE | FPm,FPn | X | Source -> Destination; round destination to single or double precision. |
| | \<ea\>,FPn | B, W, L, S, D, X | |
| FMOVEM | \<ea\>,\<list\> | 32, X | Listed Registers -> Destination |
| | \<ea\>,Dn | X | |
| | \<list\>,\<ea\> | 32, X | Source -> Listed Registers |
| | Dn,\<ea\> | X | |
| LEA | \<ea\>,An | 32 | \<ea\> -> An |
| LINK | An,#\<d\> | 16, 32 | SP - 4 -> SP; An -> (SP); SP -> An, SP + D -> SP |
| MOVE | \<ea\>,\<ea\> | 8, 16, 32 | Source -> Destination |
| MOVE16 | \<ea\>,\<ea\> | 16 bytes | Aligned 16-Byte Block -> Destination |
| MOVEA | \<ea\>,An | 16, 32 -> 32 | |
| MOVEM | list,\<ea\> | 16, 32 | Listed Registers -> Destination |
| | \<ea\>,list | 16, 32 -> 32 | Source -> Listed Registers |
| MOVEP | Dn, (d16,An) | 16, 32 | Dn 31-24 -> (An + dn); Dn 23-16 -> (An + dn + 2); Dn 15-8 -> (An + dn + 4); Dn 7-0 -> (An + dn + 6) |
| | (d16,An),Dn | 16, 32 | (An + dn) -> Dn 31-24; (An + dn + 2) -> Dn 23-16; (An + dn + 4) -> Dn 15-8; (An + dn + 6) -> Dn 7-0 |
| MOVEQ | #\<data\>,Dn | 8 -> 32 | Immediate Data -> Destination |
| PEA | \<ea\> | 32 | SP - 4 -> SP; \<ea\> -> (SP) |
| UNLK | An | 32 | An -> SP; (SP) -> An; SP + 4 -> SP |

NOTE: A register list includes any combination of the eight floating-point data registers or any combination of the three control registers (FPCR, FPSR, and FPIAR). If a register list mask resides in a data register, only floating-point data registers may be specified.

---

#### 3.1.2 Integer Arithmetic Instructions

The integer arithmetic operations include four basic operations: ADD, SUB, MUL, and DIV. They also include CMP, CMPM, CMP2, CLR, and NEG. The instruction set includes ADD, CMP, and SUB instructions for both address and data operations with all operand sizes valid for data operations. Address operands consist of 16 or 32 bits. The CLR and NEG instructions apply to all sizes of data operands. Signed and unsigned MUL and DIV instructions include:

- Word multiply to produce a long-word product.
- Long-word multiply to produce a long-word or quad-word product.
- Long word divided by a word divisor (word quotient and word remainder).
- Long word or quad word divided by a long-word divisor (long-word quotient and long-word remainder).

A set of extended instructions provides multiprecision and mixed-size arithmetic: ADDX, SUBX, EXT, and NEGX. Refer to Table 3-3 for a summary of the integer arithmetic operations. In Table 3-3, X refers to the X-bit in the CCR.

#### Table 3-3. Integer Arithmetic Operation Format

| Instruction | Operand Syntax | Operand Size | Operation |
|-------------|---------------|-------------|-----------|
| ADD | Dn,\<ea\> | 8, 16, 32 | Source + Destination -> Destination |
| | \<ea\>,Dn | 8, 16, 32 | |
| ADDA | \<ea\>,An | 16, 32 | |
| ADDI | #\<data\>,\<ea\> | 8, 16, 32 | Immediate Data + Destination -> Destination |
| ADDQ | #\<data\>,\<ea\> | 8, 16, 32 | |
| ADDX | Dn,Dn | 8, 16, 32 | Source + Destination + X -> Destination |
| | -(An), -(An) | 8, 16, 32 | |
| CLR | \<ea\> | 8, 16, 32 | 0 -> Destination |
| CMP | \<ea\>,Dn | 8, 16, 32 | Destination - Source |
| CMPA | \<ea\>,An | 16, 32 | |
| CMPI | #\<data\>,\<ea\> | 8, 16, 32 | Destination - Immediate Data |
| CMPM | (An)+,(An)+ | 8, 16, 32 | Destination - Source |
| CMP2 | \<ea\>,Rn | 8, 16, 32 | Lower Bound -> Rn -> Upper Bound |
| DIVS/DIVU | \<ea\>,Dn | 32 / 16 -> 16,16 | Destination / Source -> Destination (Signed or Unsigned Quotient, Remainder) |
| | \<ea\>,Dr-Dq | 64 / 32 -> 32,32 | |
| | \<ea\>,Dq | 32 / 32 -> 32 | |
| DIVSL/DIVUL | \<ea\>,Dr-Dq | 32 / 32 -> 32,32 | |
| EXT | Dn | 8 -> 16 | Sign-Extended Destination -> Destination |
| | Dn | 16 -> 32 | |
| EXTB | Dn | 8 -> 32 | |
| MULS/MULU | \<ea\>,Dn | 16 x 16 -> 32 | Source x Destination -> Destination (Signed or Unsigned) |
| | \<ea\>,Dl | 32 x 32 -> 32 | |
| | \<ea\>,Dh-Dl | 32 x 32 -> 64 | |
| NEG | \<ea\> | 8, 16, 32 | 0 - Destination -> Destination |
| NEGX | \<ea\> | 8, 16, 32 | 0 - Destination - X -> Destination |
| SUB | \<ea\>,Dn | 8, 16, 32 | Destination - Source -> Destination |
| | Dn,\<ea\> | 8, 16, 32 | |
| SUBA | \<ea\>,An | 16, 32 | |
| SUBI | #\<data\>,\<ea\> | 8, 16, 32 | Destination - Immediate Data -> Destination |
| SUBQ | #\<data\>,\<ea\> | 8, 16, 32 | |
| SUBX | Dn,Dn | 8, 16, 32 | Destination - Source - X -> Destination |
| | -(An), -(An) | 8, 16, 32 | |

---

#### 3.1.3 Logical Instructions

The logical operation instructions (AND, OR, EOR, and NOT) perform logical operations with all sizes of integer data operands. A similar set of immediate instructions (ANDI, ORI, and EORI) provides these logical operations with all sizes of immediate data. Table 3-4 summarizes the logical operations.

#### Table 3-4. Logical Operation Format

| Instruction | Operand Syntax | Operand Size | Operation |
|-------------|---------------|-------------|-----------|
| AND | \<ea\>,Dn | 8, 16, 32 | Source AND Destination -> Destination |
| | Dn,\<ea\> | 8, 16, 32 | |
| ANDI | #\<data\>,\<ea\> | 8, 16, 32 | Immediate Data AND Destination -> Destination |
| EOR | Dn,\<ea\> | 8, 16, 32 | Source XOR Destination -> Destination |
| EORI | #\<data\>,\<ea\> | 8, 16, 32 | Immediate Data XOR Destination -> Destination |
| NOT | \<ea\> | 8, 16, 32 | ~ Destination -> Destination |
| OR | \<ea\>,Dn | 8, 16, 32 | Source V Destination -> Destination |
| | Dn,\<ea\> | 8, 16, 32 | |
| ORI | #\<data\>,\<ea\> | 8, 16, 32 | Immediate Data V Destination -> Destination |

---

#### 3.1.4 Shift and Rotate Instructions

The ASR, ASL, LSR, and LSL instructions provide shift operations in both directions. The ROR, ROL, ROXR, and ROXL instructions perform rotate (circular shift) operations, with and without the CCR extend bit (X-bit). All shift and rotate operations can be performed on either registers or memory.

Register shift and rotate operations shift all operand sizes. The shift count can be specified in the instruction operation word (to shift from 1-8 places) or in a register (modulo 64 shift count).

Memory shift and rotate operations shift word operands one bit position only. The SWAP instruction exchanges the 16-bit halves of a register. Fast byte swapping is possible by using the ROR and ROL instructions with a shift count of eight, enhancing the performance of the shift/rotate instructions. Table 3-5 is a summary of the shift and rotate operations. In Table 3-5, C and X refer to the C-bit and X-bit in the CCR.

#### Table 3-5. Shift and Rotate Operation Format

| Instruction | Operand Syntax | Operand Size | Operation |
|-------------|---------------|-------------|-----------|
| ASL | Dn, Dn | 8, 16, 32 | `[X/C] <-- [operand] <-- 0` |
| | #\<data\>, Dn | 8, 16, 32 | |
| | \<ea\> | 16 | |
| ASR | Dn, Dn | 8, 16, 32 | `[operand] --> [X/C]` (MSB replicated) |
| | #\<data\>, Dn | 8, 16, 32 | |
| | \<ea\> | 16 | |
| LSL | Dn, Dn | 8, 16, 32 | `[X/C] <-- [operand] <-- 0` |
| | #\<data\>, Dn | 8, 16, 32 | |
| | \<ea\> | 16 | |
| LSR | Dn, Dn | 8, 16, 32 | `0 --> [operand] --> [X/C]` |
| | #\<data\>, Dn | 8, 16, 32 | |
| | \<ea\> | 16 | |
| ROL | Dn, Dn | 8, 16, 32 | `[C] <-- [operand] <--` (MSB wraps to LSB) |
| | #\<data\>, Dn | 8, 16, 32 | |
| | \<ea\> | 16 | |
| ROR | Dn, Dn | 8, 16, 32 | `--> [operand] --> [C]` (LSB wraps to MSB) |
| | #\<data\>, Dn | 8, 16, 32 | |
| | \<ea\> | 16 | |
| ROXL | Dn, Dn | 8, 16, 32 | `[C] <-- [operand] <-- [X]` (X wraps through) |
| | #\<data\>, Dn | 8, 16, 32 | |
| | \<ea\> | 16 | |
| ROXR | Dn, Dn | 8, 16, 32 | `[X] --> [operand] --> [C]` (C wraps through X) |
| | #\<data\>, Dn | 8, 16, 32 | |
| | \<ea\> | 16 | |
| SWAP | Dn | 32 | MSW <-> LSW of register |

NOTE: X indicates the extend bit and C the carry bit in the CCR.

---

#### 3.1.5 Bit Manipulation Instructions

BTST, BSET, BCLR, and BCHG are bit manipulation instructions. All bit manipulation operations can be performed on either registers or memory. The bit number is specified either as immediate data or in the contents of a data register. Register operands are 32 bits long, and memory operands are 8 bits long. Table 3-6 summarizes bit manipulation operations; Z refers to the zero bit of the CCR.

#### Table 3-6. Bit Manipulation Operation Format

| Instruction | Operand Syntax | Operand Size | Operation |
|-------------|---------------|-------------|-----------|
| BCHG | Dn,\<ea\> | 8, 32 | ~ (\<Bit Number\> of Destination) -> Z -> Bit of Destination |
| | #\<data\>,\<ea\> | 8, 32 | |
| BCLR | Dn,\<ea\> | 8, 32 | ~ (\<Bit Number\> of Destination) -> Z; 0 -> Bit of Destination |
| | #\<data\>,\<ea\> | 8, 32 | |
| BSET | Dn,\<ea\> | 8, 32 | ~ (\<Bit Number\> of Destination) -> Z; 1 -> Bit of Destination |
| | #\<data\>,\<ea\> | 8, 32 | |
| BTST | Dn,\<ea\> | 8, 32 | ~ (\<Bit Number\> of Destination) -> Z |
| | #\<data\>,\<ea\> | 8, 32 | |

---

#### 3.1.6 Bit Field Instructions

The M68000 family architecture supports variable-length bit field operations on fields of up to 32 bits. The BFINS instruction inserts a value into a bit field. BFEXTU and BFEXTS extract a value from the field. BFFFO finds the first set bit in a bit field. Also included are instructions analogous to the bit manipulation operations: BFTST, BFSET, BFCLR, and BFCHG. Table 3-7 summarizes bit field operations.

#### Table 3-7. Bit Field Operation Format

| Instruction | Operand Syntax | Operand Size | Operation |
|-------------|---------------|-------------|-----------|
| BFCHG | \<ea\> {offset:width} | 1-32 | ~ Field -> Field |
| BFCLR | \<ea\> {offset:width} | 1-32 | 0's -> Field |
| BFEXTS | \<ea\> {offset:width}, Dn | 1-32 | Field -> Dn; Sign-Extended |
| BFEXTU | \<ea\> {offset:width}, Dn | 1-32 | Field -> Dn; Zero-Extended |
| BFFFO | \<ea\> {offset:width}, Dn | 1-32 | Scan for First Bit Set in Field; Offset -> Dn. |
| BFINS | Dn,\<ea\> {offset:width} | 1-32 | Dn -> Field |
| BFSET | \<ea\> {offset:width} | 1-32 | 1's -> Field |
| BFTST | \<ea\> {offset:width} | 1-32 | Field MSB -> N; ~ (OR of All Bits in Field) -> Z |

NOTE: All bit field instructions set the CCR N and Z bits as shown for BFTST before performing the specified operation.

---

#### 3.1.7 Binary-Coded Decimal Instructions

Five instructions support operations on binary-coded decimal (BCD) numbers. The arithmetic operations on packed BCD numbers are ABCD, SBCD, and NBCD. PACK and UNPK instructions aid in the conversion of byte-encoded numeric data, such as ASCII or EBCDIC strings to BCD data and vice versa. Table 3-8 summarizes BCD operations. In Table 3-8, X refers to the X-bit in the CCR.

#### Table 3-8. Binary-Coded Decimal Operation Format

| Instruction | Operand Syntax | Operand Size | Operation |
|-------------|---------------|-------------|-----------|
| ABCD | Dn,Dn | 8 | Source10 + Destination10 + X -> Destination |
| | -(An), -(An) | 8 | |
| NBCD | \<ea\> | 8 | 0 - Destination10 - X -> Destination |
| PACK | -(An), -(An) #\<data\> | 16 -> 8 | Unpackaged Source + Immediate Data -> Packed Destination |
| | Dn,Dn,#\<data\> | 16 -> 8 | |
| SBCD | Dn,Dn | 8 | Destination10 - Source10 - X -> Destination |
| | -(An), -(An) | 8 | |
| UNPK | -(An),-(An) #\<data\> | 8 -> 16 | Packed Source -> Unpacked Source |
| | Dn,Dn,#\<data\> | 8 -> 16 | Unpacked Source + Immediate Data -> Unpacked Destination |

---

#### 3.1.8 Program Control Instructions

A set of subroutine call and return instructions and conditional and unconditional branch instructions perform program control operations. Also included are test operand instructions (TST and FTST), which set the integer or floating-point condition codes for use by other program and system control instructions. NOP forces synchronization of the internal pipelines. Table 3-9 summarizes these instructions.

#### Table 3-9. Program Control Operation Format

| Instruction | Operand Syntax | Operand Size | Operation |
|-------------|---------------|-------------|-----------|
| **Integer and Floating-Point Conditional** | | | |
| Bcc, FBcc | \<label\> | 8, 16, 32 | If Condition True, Then PC + dn -> PC |
| DBcc, FDBcc | Dn,\<label\> | 16 | If Condition False, Then Dn - 1 -> Dn; If Dn != -1, Then PC + dn -> PC |
| Scc, FScc | \<ea\> | 8 | If Condition True, Then 1's -> Destination; Else 0's -> Destination |
| **Unconditional** | | | |
| BRA | \<label\> | 8, 16, 32 | PC + dn -> PC |
| BSR | \<label\> | 8, 16, 32 | SP - 4 -> SP; PC -> (SP); PC + dn -> PC |
| JMP | \<ea\> | none | Destination -> PC |
| JSR | \<ea\> | none | SP - 4 -> SP; PC -> (SP); Destination -> PC |
| NOP | none | none | PC + 2 -> PC (Integer Pipeline Synchronized) |
| FNOP | none | none | PC + 4 -> PC (FPU Pipeline Synchronized) |
| **Returns** | | | |
| RTD | #\<data\> | 16 | (SP) -> PC; SP + 4 + dn -> SP |
| RTR | none | none | (SP) -> CCR; SP + 2 -> SP; (SP) -> PC; SP + 4 -> SP |
| RTS | none | none | (SP) -> PC; SP + 4 -> SP |
| **Test Operand** | | | |
| TST | \<ea\> | 8, 16, 32 | Set Integer Condition Codes |
| FTST | \<ea\> | B, W, L, S, D, X, P | Set Floating-Point Condition Codes |
| | FPn | X | |

Letters cc in the integer instruction mnemonics Bcc, DBcc, and Scc specify testing one of the following conditions:

| Mnemonic | Condition | Mnemonic | Condition |
|----------|-----------|----------|-----------|
| CC | Carry clear | GE | Greater than or equal |
| LS | Lower or same | PL | Plus |
| CS | Carry set | GT | Greater than |
| LT | Less than | T | Always true\* |
| EQ | Equal | HI | Higher |
| MI | Minus | VC | Overflow clear |
| F | Never true\* | LE | Less than or equal |
| NE | Not equal | VS | Overflow set |

\*Not applicable to the Bcc instructions.

---

#### 3.1.9 System Control Instructions

Privileged and trapping instructions as well as instructions that use or modify the CCR provide system control operations. FSAVE and FRESTORE save and restore the nonuser visible portion of the FPU during context switches in a virtual memory or multitasking system. The conditional trap instructions, which use the same conditional tests as their corresponding program control instructions, allow an optional 16- or 32-bit immediate operand to be included as part of the instruction for passing parameters to the operating system. These instructions cause the processor to flush the instruction pipe. Table 3-10 summarizes these instructions. See 3.2 Integer Unit Condition Code Computation for more details on condition codes.

#### Table 3-10. System Control Operation Format

| Instruction | Operand Syntax | Operand Size | Operation |
|-------------|---------------|-------------|-----------|
| **Privileged** | | | |
| ANDI to SR | #\<data\>,SR | 16 | Immediate Data AND SR -> SR |
| EORI to SR | #\<data\>,SR | 16 | Immediate Data XOR SR -> SR |
| FRESTORE | \<ea\> | none | State Frame -> Internal Floating-Point Registers |
| FSAVE | \<ea\> | none | Internal Floating-Point Registers -> State Frame |
| MOVE to SR | \<ea\>,SR | 16 | Source -> SR |
| MOVE from SR | SR,\<ea\> | 16 | SR -> Destination |
| MOVE USP | USP,An | 32 | USP -> An |
| | An,USP | 32 | An -> USP |
| MOVEC | Rc,Rn | 32 | Rc -> Rn |
| | Rn,Rc | 32 | Rn -> Rc |
| MOVES | Rn,\<ea\> | 8, 16, 32 | Rn -> Destination Using DFC |
| | \<ea\>,Rn | | Source Using SFC -> Rn |
| ORI to SR | #\<data\>,SR | 16 | Immediate Data V SR -> SR |
| RESET | none | none | Assert Reset Output |
| RTE | none | none | (SP) -> SR; SP + 2 -> SP; (SP) -> PC; SP + 4 -> SP; Restore Stack According to Format |
| STOP | #\<data\> | 16 | Immediate Data -> SR; STOP |
| **Trap Generating** | | | |
| BKPT | #\<data\> | none | Run Breakpoint Cycle |
| CHK | \<ea\>,Dn | 16, 32 | If Dn < 0 or Dn > (\<ea\>), Then CHK Exception |
| CHK2 | \<ea\>,Rn | 8, 16, 32 | If Rn < Lower Bound or Rn > Upper Bound, Then CHK Exception |
| ILLEGAL | none | none | SSP - 2 -> SSP; Vector Offset -> (SSP); SSP - 4 -> SSP; PC -> (SSP); SSP - 2 -> SSP; SR -> (SSP); Illegal Instruction Vector Address -> PC |
| TRAP | #\<data\> | none | SSP - 2 -> SSP; Format and Vector Offset -> (SSP); SSP - 4 -> SSP; PC -> (SSP); SSP - 2 -> SSP; SR -> (SSP); Vector Address -> PC |
| TRAPcc | none | none | If cc True, Then Trap Exception |
| | #\<data\> | 16, 32 | |
| FTRAPcc | none | none | If Floating-Point cc True, Then Trap Exception |
| | #\<data\> | 16, 32 | |
| TRAPV | none | none | If V, Then Take Overflow Trap Exception |
| **Condition Code Register** | | | |
| ANDI to SR | #\<data\>,CCR | 8 | Immediate Data AND CCR -> CCR |
| EORI to SR | #\<data\>,CCR | 8 | Immediate Data XOR CCR -> CCR |
| MOVE to SR | \<ea\>,CCR | 16 | Source -> CCR |
| MOVE from SR | CCR,\<ea\> | 16 | CCR -> Destination |
| ORI to SR | #\<data\>,CCR | 8 | Immediate Data V CCR -> CCR |

Letters cc in the TRAPcc and FTRAPcc specify testing for a condition.

---

#### 3.1.10 Cache Control Instructions (MC68040)

The cache instructions provide maintenance functions for managing the instruction and data caches. CINV invalidates cache entries in both caches, and CPUSH pushes dirty data from the data cache to update memory. Both instructions can operate on either or both caches and can select a single cache line, all lines in a page, or the entire cache. Table 3-11 summarizes these instructions.

#### Table 3-11. Cache Control Operation Format

| Instruction | Operand Syntax | Operand Size | Operation |
|-------------|---------------|-------------|-----------|
| CINVL | caches,(An) | none | Invalidate cache line |
| CINVP | caches, (An) | none | Invalidate cache page |
| CINVA | caches | none | Invalidate entire cache |
| CPUSHL | caches,(An) | none | Push selected dirty data cache lines, then invalidate selected cache lines |
| CPUSHP | caches, (An) | none | |
| CPUSHA | caches | none | |

---

#### 3.1.11 Multiprocessor Instructions

The TAS, CAS, and CAS2 instructions coordinate the operations of processors in multiprocessing systems. These instructions use read-modify-write bus cycles to ensure uninterrupted updating of memory. Coprocessor instructions control the coprocessor operations. Table 3-12 summarizes these instructions.

#### Table 3-12. Multiprocessor Operations

| Instruction | Operand Syntax | Operand Size | Operation |
|-------------|---------------|-------------|-----------|
| **Read-Write-Modify** | | | |
| CAS | Dc,Du,\<ea\> | 8, 16, 32 | Destination - Dc -> CC; If Z, Then Du -> Destination; Else Destination -> Dc |
| CAS2 | Dc1-Dc2, Du1-Du2, (Rn)-(Rn) | 16, 32 | Dual Operand CAS |
| TAS | \<ea\> | 8 | Destination - 0; Set Condition Codes; 1 -> Destination [7] |
| **Coprocessor** | | | |
| cpBcc | \<label\> | 16, 32 | If cpcc True, Then PC + dn -> PC |
| cpDBcc | \<label\>,Dn | 16 | If cpcc False, Then Dn - 1 -> Dn; If Dn != -1, Then PC + dn -> PC |
| cpGEN | User Defined | User Defined | Operand -> Coprocessor |
| cpRESTORE | \<ea\> | none | Restore Coprocessor State from \<ea\> |
| cpSAVE | \<ea\> | none | Save Coprocessor State at \<ea\> |
| cpScc | \<ea\> | 8 | If cpcc True, Then 1's -> Destination; Else 0's -> Destination |
| cpTRAPcc | none | none | If cpcc True, Then TRAPcc Exception |
| | #\<data\> | 16, 32 | |

---

#### 3.1.12 Memory Management Unit (MMU) Instructions

The PFLUSH instructions flush the address translation caches (ATCs) and can optionally select only nonglobal entries for flushing. PTEST performs a search of the address translation tables, stores the results in the MMU status register, and loads the entry into the ATC. Table 3-13 summarizes these instructions.

#### Table 3-13. MMU Operation Format

| Instruction | Processor | Operand Syntax | Operand Size | Operation |
|-------------|-----------|---------------|-------------|-----------|
| PBcc | MC68851 | \<label\> | none | Branch on PMMU Condition |
| PDBcc | MC68851 | Dn,\<label\> | none | Test, Decrement, and Branch |
| PFLUSHA | MC68030, MC68040, MC68851 | none | none | Invalidate All ATC Entries |
| PFLUSH | MC68040 | (An) | none | Invalidate ATC Entries at Effective Address |
| PFLUSHN | MC68040 | (An) | none | Invalidate Nonglobal ATC Entries at Effective Address |
| PFLUSHAN | MC68040 | none | none | Invalidate All Nonglobal ATC Entries |
| PFLUSHS | MC68851 | none | none | Invalidate All Shared/Global ATC Entries |
| PFLUSHR | MC68851 | \<ea\> | none | Invalidate ATC and RPT Entries |
| PLOAD | MC68030, MC68851 | FC,\<ea\> | none | Load an Entry into the ATC |
| PMOVE | MC68030, MC68851 | MRn,\<ea\> | 8,16,32,64 | Move to/from MMU Registers |
| | | \<ea\>,MRn | | |
| PRESTORE | MC68851 | \<ea\> | none | PMMU Restore Function |
| PSAVE | MC68851 | \<ea\> | none | PMMU Save Function |
| PScc | MC68851 | \<ea\> | 8 | Set on PMMU Condition |
| PTEST | MC68030, MC68040, MC68851 | (An) | none | Information About Logical Address -> MMU Status Register |
| PTRAPcc | MC68851 | #\<data\> | 16,32 | Trap on PMMU Condition |

---

#### 3.1.13 Floating-Point Arithmetic Instructions

The following paragraphs describe the floating-point instructions, organized into two categories of operation: dyadic (requiring two operands) and monadic (requiring one operand).

The dyadic floating-point instructions provide several arithmetic functions that require two input operands, such as add and subtract. For these operations, the first operand can be located in memory, an integer data register, or a floating-point data register. The second operand is always located in a floating-point data register. The results of the operation store in the register specified as the second operand. All FPU operations support all data formats. Results are rounded to either extended-, single-, or double-precision format. Table 3-14 gives the general format of dyadic instructions, and Table 3-15 lists the available operations.

#### Table 3-14. Dyadic Floating-Point Operation Format

| Instruction | Operand Syntax | Operand Format | Operation |
|-------------|---------------|---------------|-----------|
| F\<dop\> | \<ea\>,FPn | B, W, L, S, D, X, P | FPn \<Function\> Source -> FPn |
| | FPm,FPn | X | |

NOTE: \<dop\> is any one of the dyadic operation specifiers.

#### Table 3-15. Dyadic Floating-Point Operations

| Instruction | Operation |
|-------------|-----------|
| FADD, FSADD, FDADD | Add |
| FCMP | Compare |
| FDIV, FSDIV, FDDIV | Divide |
| FMOD | Modulo Remainder |
| FMUL, FSMUL, FDMUL | Multiply |
| FREM | IEEE Remainder |
| FSCALE | Scale Exponent |
| FSUB, FSSUB, FDSUB | Subtract |
| FSGLDIV, FSGLMUL | Single-Precision Divide, Multiply |

The monadic floating-point instructions provide several arithmetic functions requiring only one input operand. Unlike the integer counterparts to these functions (e.g., NEG \<ea\>), a source and a destination can be specified. The operation is performed on the source operand and the result is stored in the destination, which is always a floating-point data register. When the source is not a floating-point data register, all data formats are supported. The data format is always extended precision for register-to-register operations. Table 3-16 lists the general format of these instructions, and Table 3-17 lists the available operations.

#### Table 3-16. Monadic Floating-Point Operation Format

| Instruction | Operand Syntax | Operand Format | Operation |
|-------------|---------------|---------------|-----------|
| F\<mop\> | \<ea\>,FPn | B, W, L, S, D, X, P | Source -> Function -> FPn |
| | FPm,FPn | X | |
| | FPn | X | FPn -> Function -> FPn |

NOTE: \<mop\> is any one of the monadic operation specifiers.

#### Table 3-17. Monadic Floating-Point Operations

| Instruction | Operation | Instruction | Operation |
|-------------|-----------|-------------|-----------|
| FABS | Absolute Value | FLOGN | ln(x) |
| FACOS | Arc Cosine | FLOGNP1 | ln(x + 1) |
| FASIN | Arc Sine | FLOG10 | Log10(x) |
| FATAN | Hyperbolic Arc Tangent | FLOG2 | Log2(x) |
| FCOS | Cosine | FNEG | Negate |
| FCOSH | Hyperbolic Cosine | FSIN | Sine |
| FETOX | e^x | FSINH | Hyperbolic Sine |
| FETOXM1 | e^x - 1 | FSQRT | Square Root |
| FGETEXP | Extract Exponent | FTAN | Tangent |
| FGETMAN | Extract Mantissa | FTANH | Hyperbolic Tangent |
| FINT | Extract Integer Part | FTENTOX | 10^x |
| FINTRZ | Extract Integer Part, Rounded-to-Zero | FTWOTOX | 2^x |

---

### 3.2 Integer Unit Condition Code Computation

Many integer instructions affect the CCR to indicate the instruction's results. Program and system control instructions also use certain combinations of these bits to control program and system flow. The condition codes meet consistency criteria across instructions, uses, and instances. They also meet the criteria of meaningful results, where no change occurs unless it provides useful information. Refer to **Section 1 Introduction** for details concerning the CCR.

Table 3-18 lists the integer condition code computations for instructions and Table 3-19 lists the condition names, encodings, and tests for the conditional branch and set instructions. The test associated with each condition is a logical formula using the current states of the condition codes. If this formula evaluates to one, the condition is true. If the formula evaluates to zero, the condition is false. For example, the T condition is always true, and the EQ condition is true only if the Z-bit condition code is currently true.

#### Table 3-18. Integer Unit Condition Code Computations

| Operations | X | N | Z | V | C | Special Definition |
|-----------|---|---|---|---|---|-------------------|
| ABCD | \* | U | ? | U | ? | C = Decimal Carry; Z = Z AND Rm AND ... AND R0 |
| ADD, ADDI, ADDQ | \* | \* | \* | ? | ? | V = Sm AND Dm AND Rm V Sm AND Dm AND Rm; C = Sm AND Dm V Rm AND Dm V Sm AND Rm |
| ADDX | \* | \* | ? | ? | ? | V = Sm AND Dm AND Rm V Sm AND Dm AND Rm; C = Sm AND Dm V Rm AND Dm V Sm AND Rm; Z = Z AND Rm AND ... AND R0 |
| AND, ANDI, EOR, EORI, MOVEQ, MOVE, OR, ORI, CLR, EXT, EXTB, NOT, TAS, TST | -- | \* | \* | 0 | 0 | |
| CHK | -- | \* | U | U | U | |
| CHK2, CMP2 | -- | U | ? | U | ? | Z = (R = LB) V (R = UB); C = (LB <= UB) AND (IR < LB) V (R > UB)) V (UB < LB) AND (R > UB) AND (R < LB) |
| SUB, SUBI, SUBQ | \* | \* | \* | ? | ? | V = Sm AND Dm V Rm V Sm AND Dm AND Rm; C = Sm AND Dm V Rm AND Dm V Sm AND Rm |
| SUBX | \* | \* | ? | ? | ? | V = Sm AND Dm AND Rm V Sm AND Dm AND Rm; C = Sm AND Dm V Rm AND Dm V Sm AND Rm; Z = Z AND Rm AND ... AND R0 |
| CAS, CAS2, CMP, CMPA, CMPI, CMPM | -- | \* | \* | ? | ? | V = Sm AND Dm AND Rm V Sm AND Dm AND Rm; C = Sm AND Dm V Rm AND Dm V Sm AND Rm |
| DIVS, DIVU | -- | \* | \* | ? | 0 | V = Division Overflow |
| MULS, MULU | -- | \* | \* | ? | 0 | V = Multiplication Overflow |
| SBCD, NBCD | \* | U | ? | U | ? | C = Decimal Borrow; Z = Z AND Rm AND ... AND R0 |
| NEG | \* | \* | \* | ? | ? | V = Dm AND Rm; C = Dm V Rm |
| NEGX | \* | \* | ? | ? | ? | V = Dm AND Rm; C = Dm V Rm; Z = Z AND Rm AND ... AND R0 |
| BTST, BCHG, BSET, BCLR | -- | -- | ? | -- | -- | Z = Dn (bit tested) |
| BFTST, BFCHG, BFSET, BFCLR | -- | ? | ? | 0 | 0 | N = Dm; Z = Dn AND Dm-1 AND ... AND D0 |
| BFEXTS, BFEXTU, BFFFO | -- | ? | ? | 0 | 0 | N = Sm; Z = Sm AND Sm-1 AND ... AND S0 |
| BFINS | -- | ? | ? | 0 | 0 | N = Dm; Z = Dm AND Dm-1 AND ... AND D0 |
| ASL | \* | \* | \* | ? | ? | V = Dm AND Dm-1 V...V Dm-r V Dm AND (Dm-1 V ...+ Dm - r); C = Dm-r+1 |
| ASL (r = 0) | -- | \* | \* | 0 | 0 | |
| LSL, ROXL | \* | \* | \* | 0 | ? | C = Dm - r + 1 |
| LSR (r = 0) | -- | \* | \* | 0 | 0 | |
| ROXL (r = 0) | -- | \* | \* | 0 | ? | X = C |
| ROL | -- | \* | \* | 0 | ? | C = Dm - r + 1 |
| ROL (r = 0) | -- | \* | \* | 0 | 0 | |
| ASR, LSR, ROXR | \* | \* | \* | 0 | ? | C = Dr - 1 |
| ASR, LSR (r = 0) | -- | \* | \* | 0 | 0 | |
| ROXR (r = 0) | -- | \* | \* | 0 | ? | X = C |
| ROR | -- | \* | \* | 0 | ? | C = Dr - 1 |
| ROR (r = 0) | -- | \* | \* | 0 | 0 | |

**Legend:**
- ? = Other -- See Special Definition
- N = Result Operand (MSB)
- Rm = Result Operand (MSB)
- Rm (overbar) = Not Result Operand (MSB)
- Z = Rm AND ... AND R0
- R = Register Tested
- Sm = Source Operand (MSB)
- r = Shift Count
- Dm = Destination Operand (MSB)

---

#### Table 3-19. Conditional Tests

| Mnemonic | Condition | Encoding | Test |
|----------|-----------|----------|------|
| T\* | True | 0000 | 1 |
| F\* | False | 0001 | 0 |
| HI | High | 0010 | NOT C AND NOT Z |
| LS | Low or Same | 0011 | C V Z |
| CC(HI) | Carry Clear | 0100 | NOT C |
| CS(LO) | Carry Set | 0101 | C |
| NE | Not Equal | 0110 | NOT Z |
| EQ | Equal | 0111 | Z |
| VC | Overflow Clear | 1000 | NOT V |
| VS | Overflow Set | 1001 | V |
| PL | Plus | 1010 | NOT N |
| MI | Minus | 1011 | N |
| GE | Greater or Equal | 1100 | N AND V V NOT N AND NOT V |
| LT | Less Than | 1101 | N AND NOT V V NOT N AND V |
| GT | Greater Than | 1110 | N AND V AND NOT Z V NOT N AND NOT V AND NOT Z |
| LE | Less or Equal | 1111 | Z V N AND NOT V V NOT N AND V |

NOTES:
- NOT N = Logical Not N
- NOT V = Logical Not V
- NOT Z = Logical Not Z
- \*Not available for the Bcc instruction.

---

### 3.3 Instruction Examples

The following paragraphs provide examples of how to use selected instructions.

#### 3.3.1 Using the Cas and Cas2 Instructions

The CAS instruction compares the value in a memory location with the value in a data register, and copies a second data register into the memory location if the compared values are equal. This provides a means of updating system counters, history information, and globally shared pointers. The instruction uses an indivisible read-modify-write cycle. After CAS reads the memory location, no other instruction can change that location before CAS has written the new value. This provides security in single-processor systems, in multitasking environments, and in multiprocessor environments. In a single-processor system, the operation is protected from instructions of an interrupt routine. In a multitasking environment, no other task can interfere with writing the new value of a system variable. In a multiprocessor environment, the other processors must wait until the CAS instruction completes before accessing a global pointer.

#### 3.3.2 Using the Moves Instruction

This instruction moves the byte, word, or long-word operand from the specified general register to a location within the address space specified by the destination function code (DFC) register. It also moves the byte, word, or long-word operand from a location within the address space specified by the source function code (SFC) register to the specified general register.

#### 3.3.3 Nested Subroutine Calls

The LINK instruction pushes an address onto the stack, saves the stack address at which the address is stored, and reserves an area of the stack. Using this instruction in a series of subroutine calls results in a linked list of stack frames.

The UNLK instruction removes a stack frame from the end of the list by loading an address into the stack pointer and pulling the value at that address from the stack. When the operand of the instruction is the address of the link address at the bottom of a stack frame, the effect is to remove the stack frame from the stack and from the linked list.

#### 3.3.4 Bit Field Instructions

One of the data types provided by the MC68030 is the bit field, consisting of as many as 32 consecutive bits. An offset from an effective address and a width value defines a bit field. The offset is a value in the range of -231 through 231 - 1 from the most significant bit (bit 7) at the effective address. The width is a positive number, 1 through 32. The most significant bit of a bit field is bit 0. The bits number in a direction opposite to the bits of an integer.

The instruction set includes eight instructions that have bit field operands. The insert bit field (BFINS) instruction inserts a bit field stored in a register into a bit field. The extract bit field signed (BFEXTS) instruction loads a bit field into the least significant bits of a register and extends the sign to the left, filling the register. The extract bit field unsigned (BFEXTU) also loads a bit field, but zero fills the unused portion of the destination register.

The set bit field (BFSET) instruction sets all the bits of a field to ones. The clear bit field (BFCLR) instruction clears a field. The change bit field (BFCHG) instruction complements all the bits in a bit field. These three instructions all test the previous value of the bit field, setting the condition codes accordingly. The test bit field (BFTST) instruction tests the value in the field, setting the condition codes appropriately without altering the bit field. The find first one in bit field (BFFFO) instruction scans a bit field from bit 0 to the right until it finds a bit set to one and loads the bit offset of the first set bit into the specified data register. If no bits in the field are set, the field offset and the field width is loaded into the register.

An important application of bit field instructions is the manipulation of the exponent field in a floating-point number. In the IEEE standard format, the most significant bit is the sign bit of the mantissa. The exponent value begins at the next most significant bit position; the exponent field does not begin on a byte boundary. The extract bit field (BFEXTU) instruction and the BFTST instruction are the most useful for this application, but other bit field instructions can also be used.

Programming of input and output operations to peripherals requires testing, setting, and inserting of bit fields in the control registers of the peripherals. This is another application for bit field instructions. However, control register locations are not memory locations; therefore, it is not always possible to insert or extract bit fields of a register without affecting other fields within the register.

Another widely used application for bit field instructions is bit-mapped graphics. Because byte boundaries are ignored in these areas of memory, the field definitions used with bit field instructions are very helpful.

#### 3.3.5 Pipeline Synchronization with the Nop Instruction

Although the no operation (NOP) instruction performs no visible operation, it serves an important purpose. It forces synchronization of the integer unit pipeline by waiting for all pending bus cycles to complete. All previous integer instructions and floating-point external operand accesses complete execution before the NOP begins. The NOP instruction does not synchronize the FPU pipeline -- floating-point instructions with floating-point register operand destinations can be executing when the NOP begins. NOP is considered a change of flow instruction and traps for trace on change of flow. A single-cycle nonsynchronizing operation can be affected with the TRAPF instruction.

---

### 3.4 Floating-Point Instruction Details

The following paragraphs describe the operation tables used in the instruction descriptions and the conditional tests that can be used to change program flow based on floating-point conditions. Details on NANs and floating-point condition codes are also discussed. The IEEE 754 standard specifies that each data format must support add, subtract, multiply, divide, remainder, square root, integer part, and compare. In addition to these arithmetic functions, software supports remainder and integer part; the FPU also supports the nontranscendental operations of absolute value, negate, and test.

Most floating-point instruction descriptions include an operation table. This table lists the resulting data types for the instruction based on the operand's input. Table 3-20 is an operation table example for the FADD instruction. The operation table lists the source operand type along the top, and the destination operand type along the side. In-range numbers are normalized, denormalized, unnormalized real numbers, or integers that are converted to normalized or denormalized extended-precision numbers upon entering the FPU.

#### Table 3-20. Operation Table Example (FADD Instruction)

| DESTINATION | | In Range | +Zero / -Zero | +Infinity / -Infinity |
|-------------|------|---------|--------------|---------------------|
| **In Range** | +/- | ADD | ADD | +inf / -inf |
| **Zero** | +/- | ADD | +0.0 / -0.0 (note 2) | +inf / -inf |
| **Infinity** | + | +inf | +inf | +inf / NAN (note 3) |
| | - | -inf | -inf | NAN (note 3) / -inf |

NOTES:
1. If either operand is a NAN, refer to **1.6.5 NANs** for more information.
2. Returns +0.0 in rounding modes RN, RZ, and RP; returns -0.0 in RM.
3. Sets the OPERR bit in the FPSR exception byte.

For example, Table 3-20 illustrates that if both the source and destination operand are positive zero, the result is also a positive zero. If the source operand is a positive zero and the destination operand is an in-range number, then the ADD algorithm is executed to obtain the result. If a label such as ADD appears in the table, it indicates that the FPU performs the indicated operation and returns the correct result. Since the result of such an operation is undefined, a NAN is returned as the result, and the OPERR bit is set in the FPSR EXC byte.

In addition to the data types covered in the operation tables for each floating-point instruction, NANs can also be used as inputs to an arithmetic operation. The operation tables do not contain a row and column for NANs because NANs are handled the same way for all operations. If either operand, but not both operands, of an operation is a nonsignaling NAN, then that NAN is returned as the result. If both operands are nonsignaling NANs, then the destination operand nonsignaling NAN is returned as the result.

If either operand to an operation is a signaling NAN (SNAN), then the SNAN bit is set in the FPSR EXC byte. If the SNAN exception enable bit is set in the FPCR ENABLE byte, then the exception is taken and the destination is not modified. If the SNAN exception enable bit is not set, setting the SNAN bit in the operand to a one converts the SNAN to a nonsignaling NAN. The operation then continues as described in the preceding paragraph for nonsignaling NANs.

---

### 3.5 Floating-Point Computational Accuracy

Representing a real number in a binary format of finite precision is problematic. If the number cannot be represented exactly, a round-off error occurs. Furthermore, when two of these inexact numbers are used in a calculation, the result becomes even more inexact. The IEEE 754 standard defines the error bounds for calculating binary floating-point values so that the result obtained by any conforming device can be predicted exactly for a particular precision and rounding mode. The error bound defined by the IEEE 754 standard is one-half unit in the last place of the destination data format in the RN mode, and one unit in last place in the other rounding modes. The operation's data format must have the same input values, rounding mode, and precision. The standard also specifies the maximum allowable error that can be introduced during a calculation and the manner in which rounding of the result is performed.

The single- and double-precision formats provide emulation for devices that only support those precisions. The execution speed of all instructions is the same whether using single- or double-precision rounding. When using these two data formats, the FPU produces the same results as any other device that conforms to the IEEE standard but does not support extended precision. The results are the same when performing the same operation in extended precision and storing the results in single- or double-precision format.

The FPU performs all floating-point internal operations in extended-precision. It supports mixed-mode arithmetic by converting single- and double-precision operands to extended-precision values before performing the specified operation. The FPU converts all memory data formats to the extended-precision data format and stores the value in a floating-point register or uses it as the source operand for an arithmetic operation. The FPU also converts extended-precision data formats in a floating-point data register to any data format and either stores it in a memory destination or in an integer data register.

Additionally if the external operand is a denormalized number, the number is normalized before an operation is performed. However, an external denormalized number moved into a floating-point data register is stored as a denormalized number. The number is first normalized and then denormalized before it is stored in the designated floating-point data register. This method simplifies the handling of all other data formats and types.

If an external operand is an unnormalized number, the number is normalized before it is used in an arithmetic operation. If the external operand is an unnormalized zero (i.e., with a mantissa of all zeros), the number is converted to a normalized zero before the specified operation is performed. The regular use of unnormalized inputs not only defeats the purpose of the IEEE 754 standard, but also can produce gross inaccuracies in the results.

#### 3.5.1 Intermediate Result

All FPU calculations use an intermediate result. When the FPU performs any operation, the calculation is carried out using extended-precision inputs, and the intermediate result is calculated as if to produce infinite precision. After the calculation is complete, the intermediate result is rounded to the selected precision and stored in the destination.

Figure 3-1 illustrates the intermediate result format. The intermediate result's exponent for some dyadic operations (i.e., multiply and divide) can easily overflow or underflow the 15-bit exponent of the designation floating-point register. To simplify the overflow and underflow detection, intermediate results in the FPU maintain a 16-bit (17 bits for the MC68881 and MC68882), twos complement, integer exponent. Detection of an overflow or underflow intermediate result always converts the 16-bit exponent into a 15-bit biased exponent before being stored in a floating-point data register. The FPU internally maintains the 67-bit mantissa for rounding purposes. The mantissa is always rounded to 64 bits (or less, depending on the selected rounding precision) before it is stored in a floating-point data register.

#### Figure 3-1. Intermediate Result Format

```
+------------------+---+----------------------------------------------+
| 16-BIT EXPONENT  | I |            63-BIT MANTISSA                   |:GRS
+------------------+---+----------------------------------------------+
                    ^                                          LSB OF FRACTION
                    |                                              GUARD BIT
               INTEGER BIT                                         ROUND BIT
               OVERFLOW BIT                                        STICKY BIT
```

If the destination is a floating-point data register, the result is in the extended-precision format and is rounded to the precision specified by the FPSR PREC bits before being stored. All mantissa bits beyond the selected precision are zero. If the single- or double-precision mode is selected, the exponent value is in the correct range even if it is stored in extended-precision format. If the destination is a memory location, the FPSR PREC bits are ignored. In this case, a number in the extended-precision format is taken from the source floating-point data register, rounded to the destination format precision, and then written to memory.

Depending on the selected rounding mode or destination data format in effect, the location of the least significant bit of the mantissa and the locations of the guard, round, and sticky bits in the 67-bit intermediate result mantissa varies. The guard and round bits are always calculated exactly. The sticky bit is used to create the illusion of an infinitely wide intermediate result. As the arrow illustrates in Figure 3-1, the sticky bit is the logical OR of all the bits in the infinitely precise result to the right of the round bit. During the calculation stage of an arithmetic operation, any non-zero bits generated that are to the right of the round bit set the sticky bit to one. Because of the sticky bit, the rounded intermediate result for all required IEEE arithmetic operations in the RN mode is in error by no more than one half unit in the last place.

#### 3.5.2 Rounding the Result

The FPU supports the four rounding modes specified by the IEEE 754 standard. These modes are round to nearest (RN), round toward zero (RZ), round toward plus infinity (RP), and round toward minus infinity (RM). The RM and RP rounding modes are often referred to as "directed rounding modes" and are useful in interval arithmetic. Rounding is accomplished through the intermediate result. Single-precision results are rounded to a 24-bit boundary; double-precision results are rounded to a 53-bit boundary; and extended-precision results are rounded to a 64-bit boundary. Table 3-21 lists the encodings for the FPCR that denote the rounding and precision modes.

#### Table 3-21. FPCR Encodings

| Rounding Mode (RND Field) | Encoding | Rounding Precision (PREC Field) |
|--------------------------|----------|-------------------------------|
| To Nearest (RN) | 00 | Extend (X) |
| To Zero (RZ) | 01 | Single (S) |
| To Minus Infinity (RM) | 10 | Double (D) |
| To Plus Infinity (RP) | 11 | Undefined |

Rounding the intermediate result's mantissa to the specified precision and checking the 16-bit intermediate exponent to ensure that it is within the representable range of the selected rounding precision accomplishes range control. Range control is a method used to assure correct emulation of a device that only supports single- or double-precision arithmetic. If the intermediate result's exponent exceeds the range of the selected precision, the exponent value appropriate for an underflow or overflow is stored as the result in the 16-bit extended-precision format exponent. For example, if the data format and rounding precision RM and the result of an arithmetic operation overflows the magnitude of the single-precision format, the largest normalized single-precision value in the destination floating-point data register is stored as an extended-precision number (i.e., an unbiased 15-bit exponent of $00FF and a mantissa of $FFFFFF0000000000). If an infinity result for an underflow or overflow, the infinity value for the destination data format is stored as the result (i.e., an exponent with the maximum value and a mantissa of zero).

#### Figure 3-2. Rounding Algorithm Flowchart

```
                          ENTRY
                            |
                            v
              GUARD, ROUND, AND STICKY BITS = 0?
             /                                   \
           NO                                    YES
            |                                      |
    INEX2 = 1                                EXACT RESULT
            |                                      |
    SELECT ROUNDING MODE                           |
   /        |         \          \                 |
  RN        RM         RP        RZ                |
  |         |  \       |  \       |                |
  |       POS  NEG   NEG  POS    |                |
  |         |    |     |    |     |                |
  |    INTERMEDIATE  INTERMEDIATE |                |
  |      RESULT      RESULT      |                |
  |         |          |         GUARD, ROUND,     |
 GUARD AND LSB=1,    ADD 1    AND STICKY ARE      |
 ROUND AND STICKY=0   TO       CHOPPED            |
    OR               LSB                           |
 GUARD=1                                           |
 ROUND OR STICKY=1                                 |
  |                                                |
 ADD 1 TO LSB                                      |
  |                                                |
  +----------+-----+-----+---+----+               |
             |                                     |
       OVERFLOW = 1?                               |
      /             \                              |
    YES              NO                            |
     |                |                            |
 SHIFT MANTISSA       |                            |
 RIGHT 1 BIT,         |                            |
 ADD 1 TO EXPONENT    |                            |
     |                |                            |
 GUARD = 0            |                            |
 ROUND = 0            |                            |
 STICKY = 0           |                            |
     |                |                            |
     v                v                            v
    EXIT             EXIT                         EXIT
```

The three additional bits beyond the extended-precision format, the difference between the intermediate result's 67-bit mantissa and the storing result's 64-bit mantissa, allow the FPU to perform all calculations as though it were performing calculations using a float engine with infinite bit precision. The result is always correct for the specified destination's data format before performing rounding (unless an overflow or underflow error occurs). The specified rounding operation then produces a number that is as close as possible to the infinitely precise intermediate value and still representable in the destination format.

---

### 3.6 Floating-Point Postprocessing

Most operations end with a postprocessing step. The FPU provides two steps in postprocessing. First, the condition code bits in the FPSR are set or cleared at the end of each arithmetic operation or move operation to a single floating-point data register. The condition code bits are consistently set based on the result of the operation. Second, the FPU supports 32 conditional tests that allow floating-point conditional instructions to test floating-point conditions in exactly the same way as the integer conditional instructions test the integer condition code. The combination of consistently set condition code bits and the simple programming of conditional instructions gives the processor a very flexible, high-performance method of altering program flow based on floating-point results. While reading the summary for each instruction, it should be assumed that an instruction performs postprocessing unless the summary specifically states that the instruction does not do so. The following paragraphs describe postprocessing in detail.

#### 3.6.1 Underflow, Round, Overflow

During the calculation of an arithmetic result, the FPU arithmetic logic unit (ALU) has more precision and range than the 80-bit extended precision format. However, the final result of these operations is an extended-precision floating-point value. In some cases, an intermediate result becomes either smaller or larger than can be represented in extended precision. Also, the operation can generate a larger exponent or more bits of precision than can be represented in the chosen rounding precision. For these reasons, every arithmetic instruction ends by rounding the result and checking for overflow and underflow.

At the completion of an arithmetic operation, the intermediate result is checked to see if it is too small to be represented as a normalized number in the selected precision. If so, the underflow (UNFL) bit is set in the FPSR EXC byte. It is also denormalized unless denormalization provides a zero value. Denormalizing a number causes a loss of accuracy, but a zero is not returned unless absolutely necessary. If a number is grossly underflowed, the FPU returns a zero or the smallest denormalized number with the correct sign, depending on the rounding mode in effect.

If no underflow occurs, the intermediate result is rounded according to the user-selected rounding precision and rounding mode. After rounding, the inexact bit (INEX2) is set appropriately. Lastly, the magnitude of the result is checked to see if it is too large to be represented in the current rounding precision. If so, the overflow (OVFL) bit is set and a correctly signed infinity or correctly signed largest normalized number is returned, depending on the rounding mode in effect.

#### 3.6.2 Conditional Testing

Unlike the integer arithmetic condition codes, an instruction either always sets the floating-point condition codes in the same way or it does not change them at all. Therefore, the instruction descriptions do not include floating-point condition code settings. The following paragraphs describe how floating-point condition codes are set for all instructions that modify condition codes.

The condition code bits differ slightly from the integer condition codes. Unlike the operation type dependent integer condition codes, examining the result at the end of the operation sets or clears the floating-point condition codes accordingly. The M68000 family integer condition codes bits N and Z have this characteristic, but the V and C bits are set differently for different instructions. The data type of the operation's result determines how the four condition code bits are set. Table 3-22 lists the condition code bit setting for each data type. Loading the FPCC with one of the other combinations and executing a conditional instruction can produce an unexpected branch condition.

#### Table 3-22. FPCC Encodings

| Data Type | N | Z | I | NAN |
|-----------|---|---|---|-----|
| + Normalized or Denormalized | 0 | 0 | 0 | 0 |
| - Normalized or Denormalized | 1 | 0 | 0 | 0 |
| + 0 | 0 | 1 | 0 | 0 |
| - 0 | 1 | 1 | 0 | 0 |
| + Infinity | 0 | 0 | 1 | 0 |
| - Infinity | 1 | 0 | 1 | 0 |
| + NAN | 0 | 0 | 0 | 1 |
| - NAN | 1 | 0 | 0 | 1 |

The inclusion of the NAN data type in the IEEE floating-point number system requires each conditional test to include the NAN condition code bit in its Boolean equation. Because a comparison of a NAN with any other data type is unordered (i.e., it is impossible to determine if a NAN is bigger or smaller than an in-range number), the compare instruction sets the NAN condition code bit when an unordered compare is attempted. All arithmetic instructions also set the NAN bit if the result of an operation is a NAN. The conditional instructions interpret the NAN condition code bit equal to one as the unordered condition.

The IEEE 754 standard defines four conditions: equal to (EQ), greater than (GT), less than (LT), and unordered (UN). In addition, the standard only requires the generation of the condition codes as a result of a floating-point compare operation. The FPU can test these conditions at the end of any operation affecting the condition codes. For purposes of the floating-point conditional branch, set byte on condition, decrement and branch on condition, and trap on condition instructions, the processor logically combines the four FPCC condition codes to form 32 conditional tests. There are three main categories of conditional tests: IEEE nonaware tests, IEEE aware tests, and miscellaneous. The set of IEEE nonaware tests is best used:

- when porting a program from a system that does not support the IEEE standard to a conforming system, or
- when generating high-level language code that does not support IEEE floating-point concepts (i.e., the unordered condition).

The 32 conditional tests are separated into two groups; 16 that cause an exception if an unordered condition is present when the conditional test is attempted and 16 that do not cause an exception. An unordered condition occurs when one or both of the operands in a floating-point compare operation The inclusion of the unordered condition in floating-point branches destroys the familiar trichotomy relationship (greater than, equal, less than) that exists for integers. For example, the opposite of floating-point branch greater than (FBGT) is not floating-point branch less than or equal (FBLE). Rather, the opposite condition is floating-point branch not greater than (FBNGT). If the result of the previous instruction was unordered, FBNGT is true; whereas, both FBGT and FBLE would be false since unordered fails both of these tests (and sets BSUN). Compiler programmers should be particularly careful of the lack of trichotomy in the floating-point branches since it is common for compilers to invert the sense of conditions.

When using the IEEE nonaware tests, the user receives a BSUN exception whenever a branch is attempted and the NAN condition code bit is set, unless the branch is an FBEQ or an FBNE. If the BSUN exception is enabled in the FPCR, the exception causes another exception. Therefore, the IEEE nonaware program is interrupted if an unexpected condition occurs. Compilers and programmers who are knowledgeable of the IEEE 754 standard should use the IEEE aware tests in programs that contain ordered and unordered conditions. Since the ordered or unordered attribute is explicitly included in the conditional test, the BSUN bit is not set in the FPSR EXC byte when the unordered condition occurs. Table 3-23 summarizes the conditional mnemonics, definitions, equations, predicates, and whether the BSUN bit is set in the FPSR EXC byte for the 32 floating-point conditional tests. The equation column lists the combination of FPCC bits for each test in the form of an equation. All condition codes with an overbar indicate cleared bits; all other bits are set.

#### Table 3-23. Floating-Point Conditional Tests

**IEEE Nonaware Tests**

| Mnemonic | Definition | Equation | Predicate | BSUN Bit Set |
|----------|-----------|----------|-----------|-------------|
| EQ | Equal | Z | 000001 | No |
| NE | Not Equal | NOT Z | 001110 | No |
| GT | Greater Than | NAN V Z V NOT N | 010010 | Yes |
| NGT | Not Greater Than | NAN V Z V N | 011101 | Yes |
| GE | Greater Than or Equal | Z V (NOT NAN AND NOT N) | 010011 | Yes |
| NGE | Not Greater Than or Equal | NAN V (N AND NOT Z) | 011100 | Yes |
| LT | Less Than | N AND (NOT NAN AND NOT Z) | 010100 | Yes |
| NLT | Not Less Than | NAN V (Z V NOT N) | 011011 | Yes |
| LE | Less Than or Equal | Z V (N AND NAN) | 010101 | Yes |
| NLE | Not Less Than or Equal | NAN V (NOT N AND NOT Z) | 011010 | Yes |
| GL | Greater or Less Than | NOT NAN AND NOT Z | 010110 | Yes |
| NGL | Not Greater or Less Than | NAN V Z | 011001 | Yes |
| GLE | Greater, Less or Equal | NOT NAN | 010111 | Yes |
| NGLE | Not Greater, Less or Equal | NAN | 011000 | Yes |

**IEEE Aware Tests**

| Mnemonic | Definition | Equation | Predicate | BSUN Bit Set |
|----------|-----------|----------|-----------|-------------|
| EQ | Equal | Z | 000001 | No |
| NE | Not Equal | NOT Z | 001110 | No |
| OGT | Ordered Greater Than | NOT NAN AND NOT Z AND NOT N | 000010 | No |
| ULE | Unordered or Less or Equal | NAN V Z V N | 001101 | No |
| OGE | Ordered Greater Than or Equal | Z V (NOT NAN AND NOT N) | 000011 | No |
| ULT | Unordered or Less Than | NAN V (N AND NOT Z) | 001100 | No |
| OLT | Ordered Less Than | N AND (NOT NAN AND NOT Z) | 000100 | No |
| UGE | Unordered or Greater or Equal | NAN V Z V N | 001011 | No |
| OLE | Ordered Less Than or Equal | Z V (N AND NAN) | 000101 | No |
| UGT | Unordered or Greater Than | NAN V (NOT N AND NOT Z) | 001010 | No |
| OGL | Ordered Greater or Less Than | NOT NAN AND NOT Z | 000110 | No |
| UEQ | Unordered or Equal | NAN V Z | 001001 | No |
| OR | Ordered | NOT NAN | 000111 | No |
| UN | Unordered | NAN | 001000 | No |

**Miscellaneous Tests**

| Mnemonic | Definition | Equation | Predicate | BSUN Bit Set |
|----------|-----------|----------|-----------|-------------|
| F | False | False | 000000 | No |
| T | True | True | 001111 | No |
| SF | Signaling False | False | 010000 | Yes |
| ST | Signaling True | True | 011111 | Yes |
| SEQ | Signaling Equal | Z | 010001 | Yes |
| SNE | Signaling Not Equal | NOT Z | 011110 | Yes |

---

### 3.7 Instruction Descriptions

Section 4, 5, 6, and 7 contain detailed information about each instruction in the M68000 family instruction set. Each section arranges the instruction in alphabetical order by instruction mnemonic and includes descriptions of the instruction's notation and format. Figure 3-3 illustrates the format of the instruction descriptions. Note that the illustration is an amalgamation of the various parts that make up an instruction description. Instruction descriptions for the integer unit differ slightly from those for the floating-point unit; i.e. there are no operation tables included for integer unit instruction descriptions.

The size attribute line specifies the size of the operands of an instruction. When an instruction uses operands of more than one size, the mnemonic of the instruction includes a suffix such as:

- .B -- Byte Operands
- .W -- Word Operands
- .L -- Long-Word Operands
- .S -- Single-Precision Real Operands
- .D -- Double-Precision Real Operands
- .X -- Extended-Precision Real Operands
- .P -- Packed BCD Real Operands

The instruction format specifies the bit pattern and fields of the operation and command words, and any other words that are always part of the instruction. The effective address extensions are not explicitly illustrated. The extension words, if any, follow immediately after the illustrated portions of the instructions.

---

## Section 4: Integer Instructions (D-L)

### DBcc — Test Condition, Decrement, and Branch

**(M68000 Family)**

**Operation:** If Condition False Then (Dn - 1 -> Dn; If Dn != -1 Then PC + dn -> PC)

**Assembler Syntax:** `DBcc Dn,<label>`

**Attributes:** Size = (Word)

**Description:** Controls a loop of instructions. The parameters are a condition code, a data register (counter), and a displacement value. The instruction first tests the condition for termination; if it is true, no operation is performed. If the termination condition is not true, the low-order 16 bits of the counter data register decrement by one. If the result is -1, execution continues with the next instruction. If the result is not equal to -1, execution continues at the location indicated by the current value of the program counter plus the sign-extended 16-bit displacement. The value in the program counter is the address of the instruction word of the DBcc instruction plus two. The displacement is a twos complement integer that represents the relative distance in bytes from the current program counter to the destination program counter. Condition code cc specifies one of the following conditional tests:

| Mnemonic | Condition | Mnemonic | Condition |
|----------|-----------|----------|-----------|
| CC(HI) | Carry Clear | LS | Low or Same |
| CS(LO) | Carry Set | LT | Less Than |
| EQ | Equal | MI | Minus |
| F | False | NE | Not Equal |
| GE | Greater or Equal | PL | Plus |
| GT | Greater Than | T | True |
| HI | High | VC | Overflow Clear |
| LE | Less or Equal | VS | Overflow Set |

**Condition Codes:** Not affected.

**Instruction Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 1 |   CONDITION    | 1 | 1 | 0 | 0 | 1 | REGISTER|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|                    16-BIT DISPLACEMENT                         |
+---------------------------------------------------------------+
```

**Instruction Fields:**

- **Condition field** -- The binary code for one of the conditions listed in the table.
- **Register field** -- Specifies the data register used as the counter.
- **Displacement field** -- Specifies the number of bytes to branch.

> **NOTE:** The terminating condition is similar to the UNTIL loop clauses of high-level languages. For example: DBMI can be stated as "decrement and branch until minus". Most assemblers accept DBRA for DBF for use when only a count terminates the loop (no condition is tested). A program can enter a loop at the beginning or by branching to the trailing DBcc instruction. Entering the loop at the beginning is useful for indexed addressing modes and dynamically specified bit operations. In this case, the control index count must be one less than the desired number of loop executions. However, when entering a loop by branching directly to the trailing DBcc instruction, the control count should equal the loop execution count. In this case, if a zero count occurs, the DBcc instruction does not branch, and the main loop is not executed.

---

### DIVS, DIVSL — Signed Divide

**(M68000 Family)**

**Operation:** Destination / Source -> Destination

**Assembler Syntax:**

```
DIVS.W  <ea>,Dn          32/16 -> 16r-16q
*DIVS.L  <ea>,Dq          32/32 -> 32q
*DIVS.L  <ea>,Dr:Dq       64/32 -> 32r-32q
*DIVSL.L <ea>,Dr:Dq       32/32 -> 32r-32q
```

*\*Applies to MC68020, MC68030, MC68040, CPU32 only.*

**Attributes:** Size = (Word, Long)

**Description:** Divides the signed destination operand by the signed source operand and stores the signed result in the destination. The instruction uses one of four forms. The word form of the instruction divides a long word by a word. The result is a quotient in the lower word (least significant 16 bits) and a remainder in the upper word (most significant 16 bits). The sign of the remainder is the same as the sign of the dividend.

The first long form divides a long word by a long word. The result is a long quotient; the remainder is discarded.

The second long form divides a quad word (in any two data registers) by a long word. The result is a long-word quotient and a long-word remainder.

The third long form divides a long word by a long word. The result is a long-word quotient and a long-word remainder.

Two special conditions may arise during the operation:

1. Division by zero causes a trap.
2. Overflow may be detected and set before the instruction completes. If the instruction detects an overflow, it sets the overflow condition code, and the operands are unaffected.

**Condition Codes:**

| X | N | Z | V | C |
|---|---|---|---|---|
| -- | * | * | * | 0 |

- **X** -- Not affected.
- **N** -- Set if the quotient is negative; cleared otherwise; undefined if overflow or divide by zero occurs.
- **Z** -- Set if the quotient is zero; cleared otherwise; undefined if overflow or divide by zero occurs.
- **V** -- Set if division overflow occurs; undefined if divide by zero occurs; cleared otherwise.
- **C** -- Always cleared.

**Instruction Format (Word):**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 1 | 0 | 0 | 0 | REGISTER  | 1 | 1 | 1 |  MODE |  REGISTER   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Format (Long):**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 1 |  MODE |  REGISTER   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | REGISTER Dq | 1 |SIZE| 0 | 0 | 0 | 0 | 0 | 0 |REGISTER Dr|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Fields (Word):**

- **Register field** -- Specifies any of the eight data registers. This field always specifies the destination operand.
- **Effective Address field** -- Specifies the source operand. Only data alterable addressing modes can be used as listed in the following table:

| Addressing Mode | Mode | Register | Addressing Mode | Mode | Register |
|-----------------|------|----------|-----------------|------|----------|
| Dn | 000 | reg. number:Dn | (xxx).W | 111 | 000 |
| An | -- | -- | (xxx).L | 111 | 001 |
| (An) | 010 | reg. number:An | #\<data\> | 111 | 100 |
| (An)+ | 011 | reg. number:An | | | |
| -(An) | 100 | reg. number:An | | | |
| (d16,An) | 101 | reg. number:An | (d16,PC) | 111 | 010 |
| (d8,An,Xn) | 110 | reg. number:An | (d8,PC,Xn) | 111 | 011 |

*MC68020, MC68030, and MC68040 only:*

| (bd,An,Xn) | 110 | reg. number:An | (bd,PC,Xn) | 111 | 011 |
|-------------|-----|----------------|-------------|-----|-----|
| ([bd,An,Xn],od) | 110 | reg. number:An | ([bd,PC,Xn],od) | 111 | 011 |
| ([bd,An],Xn,od) | 110 | reg. number:An | ([bd,PC],Xn,od) | 111 | 011 |

> **NOTE:** Overflow occurs if the quotient is larger than a 16-bit signed integer.

**Instruction Fields (Long):**

- **Effective Address field** -- Specifies the source operand. Same addressing modes as the word form (MC68020, MC68030, MC68040 only).
- **Register Dq field** -- Specifies a data register for the destination operand. The low-order 32 bits of the dividend comes from this register, and the 32-bit quotient is loaded into this register.
- **Size field** -- Selects a 32- or 64-bit division operation.
  - 0 -- 32-bit dividend is in register Dq.
  - 1 -- 64-bit dividend is in Dr-Dq.
- **Register Dr field** -- After the division, this register contains the 32-bit remainder. If Dr and Dq are the same register, only the quotient is returned. If the size field is 1, this field also specifies the data register that contains the high-order 32 bits of the dividend.

> **NOTE:** Overflow occurs if the quotient is larger than a 32-bit signed integer.

---

### DIVU, DIVUL — Unsigned Divide

**(M68000 Family)**

**Operation:** Destination / Source -> Destination

**Assembler Syntax:**

```
DIVU.W  <ea>,Dn          32/16 -> 16r-16q
*DIVU.L  <ea>,Dq          32/32 -> 32q
*DIVU.L  <ea>,Dr:Dq       64/32 -> 32r-32q
*DIVUL.L <ea>,Dr:Dq       32/32 -> 32r-32q
```

*\*Applies to MC68020, MC68030, MC68040, CPU32 only.*

**Attributes:** Size = (Word, Long)

**Description:** Divides the unsigned destination operand by the unsigned source operand and stores the unsigned result in the destination. The instruction uses one of four forms. The word form of the instruction divides a long word by a word. The result is a quotient in the lower word (least significant 16 bits) and a remainder in the upper word (most significant 16 bits).

The first long form divides a long word by a long word. The result is a long quotient; the remainder is discarded.

The second long form divides a quad word (in any two data registers) by a long word. The result is a long-word quotient and a long-word remainder.

The third long form divides a long word by a long word. The result is a long-word quotient and a long-word remainder.

Two special conditions may arise during the operation:

1. Division by zero causes a trap.
2. Overflow may be detected and set before the instruction completes. If the instruction detects an overflow, it sets the overflow condition code, and the operands are unaffected.

**Condition Codes:**

| X | N | Z | V | C |
|---|---|---|---|---|
| -- | * | * | * | 0 |

- **X** -- Not affected.
- **N** -- Set if the quotient is negative; cleared otherwise; undefined if overflow or divide by zero occurs.
- **Z** -- Set if the quotient is zero; cleared otherwise; undefined if overflow or divide by zero occurs.
- **V** -- Set if division overflow occurs; cleared otherwise; undefined if divide by zero occurs.
- **C** -- Always cleared.

**Instruction Format (Word):**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 1 | 0 | 0 | 0 | REGISTER  | 0 | 1 | 1 |  MODE |  REGISTER   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Format (Long):**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 1 |  MODE |  REGISTER   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | REGISTER Dq | 0 |SIZE| 0 | 0 | 0 | 0 | 0 | 0 |REGISTER Dr|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Fields (Word):**

- **Register field** -- Specifies any of the eight data registers; this field always specifies the destination operand.
- **Effective Address field** -- Specifies the source operand. Only data addressing modes can be used as listed in the following table:

| Addressing Mode | Mode | Register | Addressing Mode | Mode | Register |
|-----------------|------|----------|-----------------|------|----------|
| Dn | 000 | reg. number:Dn | (xxx).W | 111 | 000 |
| An | -- | -- | (xxx).L | 111 | 001 |
| (An) | 010 | reg. number:An | #\<data\> | 111 | 100 |
| (An)+ | 011 | reg. number:An | | | |
| -(An) | 100 | reg. number:An | | | |
| (d16,An) | 101 | reg. number:An | (d16,PC) | 111 | 010 |
| (d8,An,Xn) | 110 | reg. number:An | (d8,PC,Xn) | 111 | 011 |

*MC68020, MC68030, and MC68040 only:*

| (bd,An,Xn)\* | 110 | reg. number:An | (bd,PC,Xn)\* | 111 | 011 |
|-------------|-----|----------------|-------------|-----|-----|
| ([bd,An,Xn],od) | 110 | reg. number:An | ([bd,PC,Xn],od) | 111 | 011 |
| ([bd,An],Xn,od) | 110 | reg. number:An | ([bd,PC],Xn,od) | 111 | 011 |

*\*Can be used with CPU32.*

> **NOTE:** Overflow occurs if the quotient is larger than a 16-bit unsigned integer.

**Instruction Fields (Long):**

- **Effective Address field** -- Specifies the source operand. Same addressing modes as the word form (MC68020, MC68030, MC68040 only).
- **Register Dq field** -- Specifies a data register for the destination operand. The low-order 32 bits of the dividend comes from this register, and the 32-bit quotient is loaded into this register.
- **Size field** -- Selects a 32- or 64-bit division operation.
  - 0 -- 32-bit dividend is in register Dq.
  - 1 -- 64-bit dividend is in Dr-Dq.
- **Register Dr field** -- After the division, this register contains the 32-bit remainder. If Dr and Dq are the same register, only the quotient is returned. If the size field is 1, this field also specifies the data register that contains the high-order 32 bits of the dividend.

> **NOTE:** Overflow occurs if the quotient is larger than a 32-bit unsigned integer.

---

### EOR — Exclusive-OR Logical

**(M68000 Family)**

**Operation:** Source XOR Destination -> Destination

**Assembler Syntax:** `EOR Dn,<ea>`

**Attributes:** Size = (Byte, Word, Long)

**Description:** Performs an exclusive-OR operation on the destination operand using the source operand and stores the result in the destination location. The size of the operation may be specified to be byte, word, or long. The source operand must be a data register. The destination operand is specified in the effective address field.

**Condition Codes:**

| X | N | Z | V | C |
|---|---|---|---|---|
| -- | * | * | 0 | 0 |

- **X** -- Not affected.
- **N** -- Set if the most significant bit of the result is set; cleared otherwise.
- **Z** -- Set if the result is zero; cleared otherwise.
- **V** -- Always cleared.
- **C** -- Always cleared.

**Instruction Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 1 | 0 | 1 | 1 | REGISTER  |  OPMODE   |  MODE |  REGISTER   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Fields:**

- **Register field** -- Specifies any of the eight data registers.
- **Opmode field:**

| Byte | Word | Long | Operation |
|------|------|------|-----------|
| 100 | 101 | 110 | \<ea\> XOR Dn -> \<ea\> |

- **Effective Address field** -- Specifies the destination operand. Only data alterable addressing modes can be used:

| Addressing Mode | Mode | Register | Addressing Mode | Mode | Register |
|-----------------|------|----------|-----------------|------|----------|
| Dn | 000 | reg. number:Dn | (xxx).W | 111 | 000 |
| An | -- | -- | (xxx).L | 111 | 001 |
| (An) | 010 | reg. number:An | #\<data\> | -- | -- |
| (An)+ | 011 | reg. number:An | | | |
| -(An) | 100 | reg. number:An | | | |
| (d16,An) | 101 | reg. number:An | (d16,PC) | -- | -- |
| (d8,An,Xn) | 110 | reg. number:An | (d8,PC,Xn) | -- | -- |

*MC68020, MC68030, and MC68040 only:*

| (bd,An,Xn)\* | 110 | reg. number:An | (bd,PC,Xn)\* | -- | -- |
|-------------|-----|----------------|-------------|-----|-----|
| ([bd,An,Xn],od) | 110 | reg. number:An | ([bd,PC,Xn],od) | -- | -- |
| ([bd,An],Xn,od) | 110 | reg. number:An | ([bd,PC],Xn,od) | -- | -- |

*\*Can be used with CPU32.*

> **NOTE:** Memory-to-data-register operations are not allowed. Most assemblers use EORI when the source is immediate data.

---

### EORI — Exclusive-OR Immediate

**(M68000 Family)**

**Operation:** Immediate Data XOR Destination -> Destination

**Assembler Syntax:** `EORI #<data>,<ea>`

**Attributes:** Size = (Byte, Word, Long)

**Description:** Performs an exclusive-OR operation on the destination operand using the immediate data and the destination operand and stores the result in the destination location. The size of the operation may be specified as byte, word, or long. The size of the immediate data matches the operation size.

**Condition Codes:**

| X | N | Z | V | C |
|---|---|---|---|---|
| -- | * | * | 0 | 0 |

- **X** -- Not affected.
- **N** -- Set if the most significant bit of the result is set; cleared otherwise.
- **Z** -- Set if the result is zero; cleared otherwise.
- **V** -- Always cleared.
- **C** -- Always cleared.

**Instruction Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 0 | 0 | 0 | 1 | 0 | 1 | 0 |  SIZE |  MODE |  REGISTER   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|            16-BIT WORD DATA             |  8-BIT BYTE DATA    |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|                       32-BIT LONG DATA                        |
+---------------------------------------------------------------+
```

**Instruction Fields:**

- **Size field** -- Specifies the size of the operation.
  - 00 -- Byte operation
  - 01 -- Word operation
  - 10 -- Long operation
- **Effective Address field** -- Specifies the destination operand. Only data alterable addressing modes can be used:

| Addressing Mode | Mode | Register | Addressing Mode | Mode | Register |
|-----------------|------|----------|-----------------|------|----------|
| Dn | 000 | reg. number:Dn | (xxx).W | 111 | 000 |
| An | -- | -- | (xxx).L | 111 | 001 |
| (An) | 010 | reg. number:An | #\<data\> | -- | -- |
| (An)+ | 011 | reg. number:An | | | |
| -(An) | 100 | reg. number:An | | | |
| (d16,An) | 101 | reg. number:An | (d16,PC) | -- | -- |
| (d8,An,Xn) | 110 | reg. number:An | (d8,PC,Xn) | -- | -- |

*MC68020, MC68030, and MC68040 only:*

| (bd,An,Xn)\* | 110 | reg. number:An | (bd,PC,Xn)\* | -- | -- |
|-------------|-----|----------------|-------------|-----|-----|
| ([bd,An,Xn],od) | 110 | reg. number:An | ([bd,PC,Xn],od) | -- | -- |
| ([bd,An],Xn,od) | 110 | reg. number:An | ([bd,PC],Xn,od) | -- | -- |

*\*Can be used with CPU32.*

- **Immediate field** -- Data immediately following the instruction.
  - If size = 00, the data is the low-order byte of the immediate word.
  - If size = 01, the data is the entire immediate word.
  - If size = 10, the data is next two immediate words.

---

### EORI to CCR — Exclusive-OR Immediate to Condition Code

**(M68000 Family)**

**Operation:** Source XOR CCR -> CCR

**Assembler Syntax:** `EORI #<data>,CCR`

**Attributes:** Size = (Byte)

**Description:** Performs an exclusive-OR operation on the condition code register using the immediate operand and stores the result in the condition code register (low-order byte of the status register). All implemented bits of the condition code register are affected.

**Condition Codes:**

| X | N | Z | V | C |
|---|---|---|---|---|
| * | * | * | * | * |

- **X** -- Changed if bit 4 of immediate operand is one; unchanged otherwise.
- **N** -- Changed if bit 3 of immediate operand is one; unchanged otherwise.
- **Z** -- Changed if bit 2 of immediate operand is one; unchanged otherwise.
- **V** -- Changed if bit 1 of immediate operand is one; unchanged otherwise.
- **C** -- Changed if bit 0 of immediate operand is one; unchanged otherwise.

**Instruction Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 0 | 0 |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |       8-BIT BYTE DATA       |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

---

### EXG — Exchange Registers

**(M68000 Family)**

**Operation:** Rx <-> Ry

**Assembler Syntax:**

```
EXG Dx,Dy
EXG Ax,Ay
EXG Dx,Ay
```

**Attributes:** Size = (Long)

**Description:** Exchanges the contents of two 32-bit registers. The instruction performs three types of exchanges:

1. Exchange data registers.
2. Exchange address registers.
3. Exchange a data register and an address register.

**Condition Codes:** Not affected.

**Instruction Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 1 | 1 | 0 | 0 | REGISTER Rx | 1 |    OPMODE     | REGISTER Ry |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Fields:**

- **Register Rx field** -- Specifies either a data register or an address register depending on the mode. If the exchange is between data and address registers, this field always specifies the data register.
- **Opmode field** -- Specifies the type of exchange.
  - 01000 -- Data registers
  - 01001 -- Address registers
  - 10001 -- Data register and address register
- **Register Ry field** -- Specifies either a data register or an address register depending on the mode. If the exchange is between data and address registers, this field always specifies the address register.

---

### EXT, EXTB — Sign-Extend

**(M68000 Family)**

**Operation:** Destination Sign-Extended -> Destination

**Assembler Syntax:**

```
EXT.W  Dn     extend byte to word
EXT.L  Dn     extend word to long word
EXTB.L Dn     extend byte to long word (MC68020, MC68030, MC68040, CPU32)
```

**Attributes:** Size = (Word, Long)

**Description:** Extends a byte in a data register to a word or a long word, or a word in a data register to a long word, by replicating the sign bit to the left. If the operation extends a byte to a word, bit 7 of the designated data register is copied to bits 15-8 of that data register. If the operation extends a word to a long word, bit 15 of the designated data register is copied to bits 31-16 of the data register. The EXTB form copies bit 7 of the designated register to bits 31-8 of the data register.

**Condition Codes:**

| X | N | Z | V | C |
|---|---|---|---|---|
| -- | * | * | 0 | 0 |

- **X** -- Not affected.
- **N** -- Set if the result is negative; cleared otherwise.
- **Z** -- Set if the result is zero; cleared otherwise.
- **V** -- Always cleared.
- **C** -- Always cleared.

**Instruction Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 0 | 1 | 0 | 0 |  OPMODE   | 0 | 0 | 0 | REGISTER|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Fields:**

- **Opmode field** -- Specifies the size of the sign-extension operation.
  - 010 -- Sign-extend low-order byte of data register to word.
  - 011 -- Sign-extend low-order word of data register to long.
  - 111 -- Sign-extend low-order byte of data register to long.
- **Register field** -- Specifies the data register to be sign-extended.

---

### ILLEGAL — Take Illegal Instruction Trap

**(M68000 Family)**

**Operation:** \*SSP - 2 -> SSP; Vector Offset -> (SSP); SSP - 4 -> SSP; PC -> (SSP); SSP - 2 -> SSP; SR -> (SSP); Illegal Instruction Vector Address -> PC

*\*The MC68000 and MC68008 cannot write the vector offset and format code to the system stack.*

**Assembler Syntax:** `ILLEGAL`

**Attributes:** Unsized

**Description:** Forces an illegal instruction exception, vector number 4. All other illegal instruction bit patterns are reserved for future extension of the instruction set and should not be used to force an exception.

**Condition Codes:** Not affected.

**Instruction Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 0 | 1 | 0 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 0 | 0 |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

---

### JMP — Jump

**(M68000 Family)**

**Operation:** Destination Address -> PC

**Assembler Syntax:** `JMP <ea>`

**Attributes:** Unsized

**Description:** Program execution continues at the effective address specified by the instruction. The addressing mode for the effective address must be a control addressing mode.

**Condition Codes:** Not affected.

**Instruction Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 0 | 1 | 1 | 1 | 0 | 1 | 1 |  MODE |  REGISTER   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Field:**

- **Effective Address field** -- Specifies the address of the next instruction. Only control addressing modes can be used:

| Addressing Mode | Mode | Register | Addressing Mode | Mode | Register |
|-----------------|------|----------|-----------------|------|----------|
| Dn | -- | -- | (xxx).W | 111 | 000 |
| An | -- | -- | (xxx).L | 111 | 001 |
| (An) | 010 | reg. number:An | #\<data\> | -- | -- |
| (An)+ | -- | -- | | | |
| -(An) | -- | -- | | | |
| (d16,An) | 101 | reg. number:An | (d16,PC) | 111 | 010 |
| (d8,An,Xn) | 110 | reg. number:An | (d8,PC,Xn) | 111 | 011 |

*MC68020, MC68030, and MC68040 only:*

| (bd,An,Xn)\* | 110 | reg. number:An | (bd,PC,Xn)\* | 111 | 011 |
|-------------|-----|----------------|-------------|-----|-----|
| ([bd,An,Xn],od) | 110 | reg. number:An | ([bd,PC,Xn],od) | 111 | 011 |
| ([bd,An],Xn,od) | 110 | reg. number:An | ([bd,PC],Xn,od) | 111 | 011 |

*\*Can be used with CPU32.*

---

### JSR — Jump to Subroutine

**(M68000 Family)**

**Operation:** SP - 4 -> SP; PC -> (SP); Destination Address -> PC

**Assembler Syntax:** `JSR <ea>`

**Attributes:** Unsized

**Description:** Pushes the long-word address of the instruction immediately following the JSR instruction onto the system stack. Program execution then continues at the address specified in the instruction.

**Condition Codes:** Not affected.

**Instruction Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 0 | 1 | 1 | 1 | 0 | 1 | 0 |  MODE |  REGISTER   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Field:**

- **Effective Address field** -- Specifies the address of the next instruction. Only control addressing modes can be used:

| Addressing Mode | Mode | Register | Addressing Mode | Mode | Register |
|-----------------|------|----------|-----------------|------|----------|
| Dn | -- | -- | (xxx).W | 111 | 000 |
| An | -- | -- | (xxx).L | 111 | 001 |
| (An) | 010 | reg. number:An | #\<data\> | -- | -- |
| (An)+ | -- | -- | | | |
| -(An) | -- | -- | | | |
| (d16,An) | 101 | reg. number:An | (d16,PC) | 111 | 010 |
| (d8,An,Xn) | 110 | reg. number:An | (d8,PC,Xn) | 111 | 011 |

*MC68020, MC68030, and MC68040 only:*

| (bd,An,Xn)\* | 110 | reg. number:An | (bd,PC,Xn)\* | 111 | 011 |
|-------------|-----|----------------|-------------|-----|-----|
| ([bd,An,Xn],od) | 110 | reg. number:An | ([bd,PC,Xn],od) | 111 | 011 |
| ([bd,An],Xn,od) | 110 | reg. number:An | ([bd,PC],Xn,od) | 111 | 011 |

*\*Can be used with CPU32.*

---

### LEA — Load Effective Address

**(M68000 Family)**

**Operation:** \<ea\> -> An

**Assembler Syntax:** `LEA <ea>,An`

**Attributes:** Size = (Long)

**Description:** Loads the effective address into the specified address register. All 32 bits of the address register are affected by this instruction.

**Condition Codes:** Not affected.

**Instruction Format:**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 0 | REGISTER  | 1 | 1 | 1 |  MODE |  REGISTER   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Fields:**

- **Register field** -- Specifies the address register to be updated with the effective address.
- **Effective Address field** -- Specifies the address to be loaded into the address register. Only control addressing modes can be used:

| Addressing Mode | Mode | Register | Addressing Mode | Mode | Register |
|-----------------|------|----------|-----------------|------|----------|
| Dn | -- | -- | (xxx).W | 111 | 000 |
| An | -- | -- | (xxx).L | 111 | 001 |
| (An) | 010 | reg. number:An | #\<data\> | -- | -- |
| (An)+ | -- | -- | | | |
| -(An) | -- | -- | | | |
| (d16,An) | 101 | reg. number:An | (d16,PC) | 111 | 010 |
| (d8,An,Xn) | 110 | reg. number:An | (d8,PC,Xn) | 111 | 011 |

*MC68020, MC68030, and MC68040 only:*

| (bd,An,Xn) | 110 | reg. number:An | (bd,PC,Xn)\* | 111 | 011 |
|-------------|-----|----------------|-------------|-----|-----|
| ([bd,An,Xn],od) | 110 | reg. number:An | ([bd,PC,Xn],od) | 111 | 011 |
| ([bd,An],Xn,od) | 110 | reg. number:An | ([bd,PC],Xn,od) | 111 | 011 |

*\*Can be used with CPU32.*

---

### LINK — Link and Allocate

**(M68000 Family)**

**Operation:** SP - 4 -> SP; An -> (SP); SP -> An; SP + dn -> SP

**Assembler Syntax:** `LINK An,#<displacement>`

**Attributes:** Size = (Word, Long\*)

*\*MC68020, MC68030, MC68040 and CPU32 only.*

**Description:** Pushes the contents of the specified address register onto the stack. Then loads the updated stack pointer into the address register. Finally, adds the displacement value to the stack pointer. For word-size operation, the displacement is the sign-extended word following the operation word. For long size operation, the displacement is the long word following the operation word. The address register occupies one long word on the stack. The user should specify a negative displacement in order to allocate stack area.

**Condition Codes:** Not affected.

**Instruction Format (Word):**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 0 | 1 | 1 | 1 | 0 | 0 | 1 | 0 | 1 | 0 | REGISTER|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|                    WORD DISPLACEMENT                          |
+---------------------------------------------------------------+
```

**Instruction Format (Long):**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | REGISTER|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
|                   HIGH-ORDER DISPLACEMENT                     |
+---------------------------------------------------------------+
|                   LOW-ORDER DISPLACEMENT                      |
+---------------------------------------------------------------+
```

**Instruction Fields:**

- **Register field** -- Specifies the address register for the link.
- **Displacement field** -- Specifies the twos complement integer to be added to the stack pointer.

> **NOTE:** LINK and UNLK can be used to maintain a linked list of local data and parameter areas on the stack for nested subroutine calls.

---

### LSL, LSR — Logical Shift

**(M68000 Family)**

**Operation:** Destination Shifted By Count -> Destination

**Assembler Syntax:**

```
LSd  Dx,Dy
LSd  #<data>,Dy
LSd  <ea>
where d is direction, L or R
```

**Attributes:** Size = (Byte, Word, Long)

**Description:** Shifts the bits of the operand in the direction specified (L or R). The carry bit receives the last bit shifted out of the operand. The shift count for the shifting of a register is specified in two different ways:

1. Immediate -- The shift count (1-8) is specified in the instruction.
2. Register -- The shift count is the value in the data register specified in the instruction modulo 64.

The size of the operation for register destinations may be specified as byte, word, or long. The contents of memory, \<ea\>, can be shifted one bit only, and the operand size is restricted to a word.

The **LSL** instruction shifts the operand to the left the number of positions specified as the shift count. Bits shifted out of the high-order bit go to both the carry and the extend bits; zeros are shifted into the low-order bit.

```
          .------------------------------.
 C <---| OPERAND                      |<--- 0
          '------------------------------'
          |
          v
          X
```

The **LSR** instruction shifts the operand to the right the number of positions specified as the shift count. Bits shifted out of the low-order bit go to both the carry and the extend bits; zeros are shifted into the high-order bit.

```
                .------------------------------.
 0 --->| OPERAND                      |---> C
                '------------------------------'
                                                |
                                                v
                                                X
```

**Condition Codes:**

| X | N | Z | V | C |
|---|---|---|---|---|
| * | * | * | 0 | * |

- **X** -- Set according to the last bit shifted out of the operand; unaffected for a shift count of zero.
- **N** -- Set if the result is negative; cleared otherwise.
- **Z** -- Set if the result is zero; cleared otherwise.
- **V** -- Always cleared.
- **C** -- Set according to the last bit shifted out of the operand; cleared for a shift count of zero.

**Instruction Format (Register Shifts):**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 1 | 1 | 1 | 0 | COUNT/    | dr|  SIZE | i/r | 0 | 1 | REGISTER|
|   |   |   |   | REGISTER  |   |       |     |   |   |         |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Fields (Register Shifts):**

- **Count/Register field:**
  - If i/r = 0, this field contains the shift count. The values 1-7 represent shifts of 1-7; value of zero specifies a shift count of eight.
  - If i/r = 1, the data register specified in this field contains the shift count (modulo 64).
- **dr field** -- Specifies the direction of the shift.
  - 0 -- Shift right
  - 1 -- Shift left
- **Size field** -- Specifies the size of the operation.
  - 00 -- Byte operation
  - 01 -- Word operation
  - 10 -- Long operation
- **i/r field:**
  - If i/r = 0, specifies immediate shift count.
  - If i/r = 1, specifies register shift count.
- **Register field** -- Specifies a data register to be shifted.

**Instruction Format (Memory Shifts):**

```
 15  14  13  12  11  10   9   8   7   6   5   4   3   2   1   0
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 1 | 1 | 1 | 0 | 0 | 0 | 1 | dr| 1 | 1 |  MODE |  REGISTER   |
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
```

**Instruction Fields (Memory Shifts):**

- **dr field** -- Specifies the direction of the shift.
  - 0 -- Shift right
  - 1 -- Shift left
- **Effective Address field** -- Specifies the operand to be shifted. Only memory alterable addressing modes can be used:

| Addressing Mode | Mode | Register | Addressing Mode | Mode | Register |
|-----------------|------|----------|-----------------|------|----------|
| Dn | -- | -- | (xxx).W | 111 | 000 |
| An | -- | -- | (xxx).L | 111 | 001 |
| (An) | 010 | reg. number:An | #\<data\> | -- | -- |
| (An)+ | 011 | reg. number:An | | | |
| -(An) | 100 | reg. number:An | | | |
| (d16,An) | 101 | reg. number:An | (d16,PC) | -- | -- |
| (d8,An,Xn) | 110 | reg. number:An | (d8,PC,Xn) | -- | -- |

*MC68020, MC68030, and MC68040 only:*

| (bd,An,Xn)\* | 110 | reg. number:An | (bd,PC,Xn)\* | -- | -- |
|-------------|-----|----------------|-------------|-----|-----|
| ([bd,An,Xn],od) | 110 | reg. number:An | ([bd,PC,Xn],od) | -- | -- |
| ([bd,An],Xn,od) | 110 | reg. number:An | ([bd,PC],Xn,od) | -- | -- |

*\*Can be used with CPU32.*

