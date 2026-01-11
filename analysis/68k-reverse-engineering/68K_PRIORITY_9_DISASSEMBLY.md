ROM loaded: 3145728 bytes

# Priority 9 Deep Disassembly Report

**Generated**: 2026-01-07
**Functions Analyzed**: 54

---

## Main Code 2 Region ($10000-$1FFFF)

49 functions

### func_109AE ($008909AE)

**File Offset**: $109AE
**Size**: 128 bytes
**Complete**: No (may continue)
**JSR Calls**: $008826C8, $008814BE, $008849AA

```asm
008909AE  33 FC                DC.W $33FC                     ; Unknown/data
008909B0  00 2C                DC.W $002C                     ; Unknown/data
008909B2  00 FF                DC.W $00FF                     ; Unknown/data
008909B4  00 08                DC.W $0008                     ; Unknown/data
008909B6  31 FC                DC.W $31FC                     ; Unknown/data
008909B8  00 2C                DC.W $002C                     ; Unknown/data
008909BA  C8 7A                DC.W $C87A                     ; Unknown/data
008909BC  08 B8                DC.W $08B8                     ; Unknown/data
008909BE  00 06                DC.W $0006                     ; Unknown/data
008909C0  C8 75                DC.W $C875                     ; Unknown/data
008909C2  3A B8                BPL.B $1097C                   ; Conditional branch (byte)
008909C4  C8 74                DC.W $C874                     ; Unknown/data
008909C6  33 FC                DC.W $33FC                     ; Unknown/data
008909C8  00 83                DC.W $0083                     ; Unknown/data
008909CA  00 A1                DC.W $00A1                     ; Unknown/data
008909CC  51 00                DC.W $5100                     ; Unknown/data
008909CE  02 39                DC.W $0239                     ; Unknown/data
008909D0  00 FC                DC.W $00FC                     ; Unknown/data
008909D2  00 A1                DC.W $00A1                     ; Unknown/data
008909D4  51 81                DC.W $5181                     ; Unknown/data
008909D6  4E B9 00 88 26 C8    JSR $008826C8                  ; Call subroutine
008909DC  20 3C 00 0A 09 07    MOVE.L #$000A0907,D0           ; Load immediate to data register
008909E2  4E B9 00 88 14 BE    JSR $008814BE                  ; Call subroutine
008909E8  11 FC                DC.W $11FC                     ; Unknown/data
008909EA  00 01                DC.W $0001                     ; Unknown/data
008909EC  C8 0D                DC.W $C80D                     ; Unknown/data
008909EE  70 00                MOVEQ #$00,D0                  ; Quick move immediate (0)
008909F0  41 F8                DC.W $41F8                     ; Unknown/data
008909F2  84 80                BCC.B $10974                   ; Conditional branch (byte)
008909F4  72 1F                MOVEQ #$1F,D1                  ; Quick move immediate (31)
008909F6  20 C0                DC.W $20C0                     ; Unknown/data
008909F8  51 C9                DC.W $51C9                     ; Unknown/data
008909FA  FF FC                BLE.B $109F8                   ; Conditional branch (byte)
008909FC  41 F9 00 FF 7B 80    LEA $00FF7B80,A0               ; Load absolute address
00890A02  72 7F                MOVEQ #$7F,D1                  ; Quick move immediate (127)
00890A04  20 C0                DC.W $20C0                     ; Unknown/data
00890A06  51 C9                DC.W $51C9                     ; Unknown/data
00890A08  FF FC                BLE.B $10A06                   ; Conditional branch (byte)
00890A0A  2A BC                BPL.B $109C8                   ; Conditional branch (byte)
00890A0C  60 00 00 02          BRA.W $10A10                   ; Branch always
00890A10  32 3C 17 FF          MOVE.W #$17FF,D1               ; Load immediate to data register
00890A14  2C 80                BGE.B $10996                   ; Conditional branch (byte)
00890A16  51 C9                DC.W $51C9                     ; Unknown/data
00890A18  FF FC                BLE.B $10A16                   ; Conditional branch (byte)
00890A1A  4E B9 00 88 49 AA    JSR $008849AA                  ; Call subroutine
00890A20  42 78                DC.W $4278                     ; Unknown/data
00890A22  C8 80                DC.W $C880                     ; Unknown/data
00890A24  42 78                DC.W $4278                     ; Unknown/data
00890A26  C8 82                DC.W $C882                     ; Unknown/data
00890A28  42 78                DC.W $4278                     ; Unknown/data
00890A2A  80 00                DC.W $8000                     ; Unknown/data
00890A2C  42 78                DC.W $4278                     ; Unknown/data
```

### func_11942 ($00891942)

**File Offset**: $11942
**Size**: 58 bytes
**Complete**: Yes
**Registers Saved**: D3, D4
**BSR Calls**: $1197E, $1199A, $1197E, $1199A, $1199A, $1197E

```asm
00891942  48 E7 18 00          MOVEM.L D3/D4,-(A7)            ; Save registers to stack
00891946  16 1A                BNE.B $11962                   ; Conditional branch (byte)
00891948  61 00 00 34          BSR.W $1197E                   ; Branch to subroutine (PC-relative)
0089194C  32 3C 00 0A          MOVE.W #$000A,D1               ; Load immediate to data register
00891950  61 00 00 48          BSR.W $1199A                   ; Branch to subroutine (PC-relative)
00891954  50 89                DC.W $5089                     ; Unknown/data
00891956  16 1A                BNE.B $11972                   ; Conditional branch (byte)
00891958  61 00 00 24          BSR.W $1197E                   ; Branch to subroutine (PC-relative)
0089195C  32 3C 00 0B          MOVE.W #$000B,D1               ; Load immediate to data register
00891960  61 00 00 38          BSR.W $1199A                   ; Branch to subroutine (PC-relative)
00891964  50 89                DC.W $5089                     ; Unknown/data
00891966  12 1A                DC.W $121A                     ; Unknown/data
00891968  02 41                DC.W $0241                     ; Unknown/data
0089196A  00 0F                DC.W $000F                     ; Unknown/data
0089196C  61 00 00 2C          BSR.W $1199A                   ; Branch to subroutine (PC-relative)
00891970  50 89                DC.W $5089                     ; Unknown/data
00891972  16 1A                BNE.B $1198E                   ; Conditional branch (byte)
00891974  61 00 00 08          BSR.W $1197E                   ; Branch to subroutine (PC-relative)
00891978  4C DF 00 18          MOVEM.L (A7)+,D3/D4            ; Restore registers from stack
0089197C  4E 75                RTS                            ; Return from subroutine
```

### func_14438 ($00894438)

**File Offset**: $14438
**Size**: 50 bytes
**Complete**: Yes

```asm
00894438  42 78                DC.W $4278                     ; Unknown/data
0089443A  C0 84                DC.W $C084                     ; Unknown/data
0089443C  42 78                DC.W $4278                     ; Unknown/data
0089443E  A0 08                DC.W $A008                     ; Unknown/data
00894440  58 78                DC.W $5878                     ; Unknown/data
00894442  C0 82                DC.W $C082                     ; Unknown/data
00894444  31 FC                DC.W $31FC                     ; Unknown/data
00894446  00 1E                DC.W $001E                     ; Unknown/data
00894448  A0 06                DC.W $A006                     ; Unknown/data
0089444A  31 FC                DC.W $31FC                     ; Unknown/data
0089444C  08 01                DC.W $0801                     ; Unknown/data
0089444E  A0 08                DC.W $A008                     ; Unknown/data
00894450  43 F9 00 90 E7 32    LEA $0090E732,A1               ; Load absolute address
00894456  22 3C 00 00 9A 00    MOVE.L #$00009A00,D1           ; Load immediate to data register
0089445C  4E BA                BGT.B $14418                   ; Conditional branch (byte)
0089445E  01 92                DC.W $0192                     ; Unknown/data
00894460  53 78                DC.W $5378                     ; Unknown/data
00894462  A0 06                DC.W $A006                     ; Unknown/data
00894464  6E 04                BGT.B $1446A                   ; Conditional branch (byte)
00894466  58 78                DC.W $5878                     ; Unknown/data
00894468  C0 82                DC.W $C082                     ; Unknown/data
0089446A  4E 75                RTS                            ; Return from subroutine
```

### func_14450 ($00894450)

**File Offset**: $14450
**Size**: 26 bytes
**Complete**: Yes

```asm
00894450  43 F9 00 90 E7 32    LEA $0090E732,A1               ; Load absolute address
00894456  22 3C 00 00 9A 00    MOVE.L #$00009A00,D1           ; Load immediate to data register
0089445C  4E BA                BGT.B $14418                   ; Conditional branch (byte)
0089445E  01 92                DC.W $0192                     ; Unknown/data
00894460  53 78                DC.W $5378                     ; Unknown/data
00894462  A0 06                DC.W $A006                     ; Unknown/data
00894464  6E 04                BGT.B $1446A                   ; Conditional branch (byte)
00894466  58 78                DC.W $5878                     ; Unknown/data
00894468  C0 82                DC.W $C082                     ; Unknown/data
0089446A  4E 75                RTS                            ; Return from subroutine
```

### func_1446C ($0089446C)

**File Offset**: $1446C
**Size**: 58 bytes
**Complete**: Yes

```asm
0089446C  4E BA                BGT.B $14428                   ; Conditional branch (byte)
0089446E  00 F8                DC.W $00F8                     ; Unknown/data
00894470  67 06                BEQ.B $14478                   ; Conditional branch (byte)
00894472  31 FC                DC.W $31FC                     ; Unknown/data
00894474  00 0F                DC.W $000F                     ; Unknown/data
00894476  C0 84                DC.W $C084                     ; Unknown/data
00894478  41 FA 01 B0          LEA $1462A(PC),A0              ; Load PC-relative address
0089447C  30 38                DC.W $3038                     ; Unknown/data
0089447E  C0 84                DC.W $C084                     ; Unknown/data
00894480  E5 40                BCS.B $144C2                   ; Conditional branch (byte)
00894482  22 70                DC.W $2270                     ; Unknown/data
00894484  00 00                DC.W $0000                     ; Unknown/data
00894486  22 3C 00 00 9A 00    MOVE.L #$00009A00,D1           ; Load immediate to data register
0089448C  4E BA                BGT.B $14448                   ; Conditional branch (byte)
0089448E  01 62                DC.W $0162                     ; Unknown/data
00894490  52 78                DC.W $5278                     ; Unknown/data
00894492  C0 84                DC.W $C084                     ; Unknown/data
00894494  0C 78                BGE.B $1450E                   ; Conditional branch (byte)
00894496  00 0F                DC.W $000F                     ; Unknown/data
00894498  C0 84                DC.W $C084                     ; Unknown/data
0089449A  6F 0A                BLE.B $144A6                   ; Conditional branch (byte)
0089449C  58 78                DC.W $5878                     ; Unknown/data
0089449E  C0 82                DC.W $C082                     ; Unknown/data
008944A0  31 FC                DC.W $31FC                     ; Unknown/data
008944A2  00 28                DC.W $0028                     ; Unknown/data
008944A4  A0 06                DC.W $A006                     ; Unknown/data
008944A6  4E 75                RTS                            ; Return from subroutine
```

### func_144A8 ($008944A8)

**File Offset**: $144A8
**Size**: 38 bytes
**Complete**: Yes

```asm
008944A8  43 F9 00 92 86 AE    LEA $009286AE,A1               ; Load absolute address
008944AE  22 3C 00 00 9A 00    MOVE.L #$00009A00,D1           ; Load immediate to data register
008944B4  4E BA                BGT.B $14470                   ; Conditional branch (byte)
008944B6  01 3A                DC.W $013A                     ; Unknown/data
008944B8  53 78                DC.W $5378                     ; Unknown/data
008944BA  A0 06                DC.W $A006                     ; Unknown/data
008944BC  6E 10                BGT.B $144CE                   ; Conditional branch (byte)
008944BE  58 78                DC.W $5878                     ; Unknown/data
008944C0  C0 82                DC.W $C082                     ; Unknown/data
008944C2  11 FC                DC.W $11FC                     ; Unknown/data
008944C4  00 F0                DC.W $00F0                     ; Unknown/data
008944C6  C8 22                DC.W $C822                     ; Unknown/data
008944C8  31 FC                DC.W $31FC                     ; Unknown/data
008944CA  08 02                DC.W $0802                     ; Unknown/data
008944CC  A0 08                DC.W $A008                     ; Unknown/data
008944CE  4E 75                RTS                            ; Return from subroutine
```

### func_144D0 ($008944D0)

**File Offset**: $144D0
**Size**: 32 bytes
**Complete**: Yes

```asm
008944D0  43 F9 00 92 86 AE    LEA $009286AE,A1               ; Load absolute address
008944D6  22 3C 00 00 9A 00    MOVE.L #$00009A00,D1           ; Load immediate to data register
008944DC  4E BA                BGT.B $14498                   ; Conditional branch (byte)
008944DE  01 12                DC.W $0112                     ; Unknown/data
008944E0  4A 78                BPL.B $1455A                   ; Conditional branch (byte)
008944E2  A0 08                DC.W $A008                     ; Unknown/data
008944E4  66 0A                BNE.B $144F0                   ; Conditional branch (byte)
008944E6  58 78                DC.W $5878                     ; Unknown/data
008944E8  C0 82                DC.W $C082                     ; Unknown/data
008944EA  31 FC                DC.W $31FC                     ; Unknown/data
008944EC  08 01                DC.W $0801                     ; Unknown/data
008944EE  A0 08                DC.W $A008                     ; Unknown/data
008944F0  4E 75                RTS                            ; Return from subroutine
```

### func_144F2 ($008944F2)

**File Offset**: $144F2
**Size**: 36 bytes
**Complete**: Yes

```asm
008944F2  43 F9 00 92 9C A6    LEA $00929CA6,A1               ; Load absolute address
008944F8  22 3C 00 00 20 00    MOVE.L #$00002000,D1           ; Load immediate to data register
008944FE  4E BA                BGT.B $144BA                   ; Conditional branch (byte)
00894500  00 F0                DC.W $00F0                     ; Unknown/data
00894502  4A 78                BPL.B $1457C                   ; Conditional branch (byte)
00894504  A0 08                DC.W $A008                     ; Unknown/data
00894506  66 0E                BNE.B $14516                   ; Conditional branch (byte)
00894508  42 78                DC.W $4278                     ; Unknown/data
0089450A  A0 08                DC.W $A008                     ; Unknown/data
0089450C  58 78                DC.W $5878                     ; Unknown/data
0089450E  C0 82                DC.W $C082                     ; Unknown/data
00894510  31 FC                DC.W $31FC                     ; Unknown/data
00894512  00 14                DC.W $0014                     ; Unknown/data
00894514  A0 06                DC.W $A006                     ; Unknown/data
00894516  4E 75                RTS                            ; Return from subroutine
```

### func_14518 ($00894518)

**File Offset**: $14518
**Size**: 38 bytes
**Complete**: Yes

```asm
00894518  43 F9 00 92 9C A6    LEA $00929CA6,A1               ; Load absolute address
0089451E  22 3C 00 00 20 00    MOVE.L #$00002000,D1           ; Load immediate to data register
00894524  4E BA                BGT.B $144E0                   ; Conditional branch (byte)
00894526  00 CA                DC.W $00CA                     ; Unknown/data
00894528  53 78                DC.W $5378                     ; Unknown/data
0089452A  A0 06                DC.W $A006                     ; Unknown/data
0089452C  6E 10                BGT.B $1453E                   ; Conditional branch (byte)
0089452E  58 78                DC.W $5878                     ; Unknown/data
00894530  C0 82                DC.W $C082                     ; Unknown/data
00894532  11 FC                DC.W $11FC                     ; Unknown/data
00894534  00 F0                DC.W $00F0                     ; Unknown/data
00894536  C8 22                DC.W $C822                     ; Unknown/data
00894538  31 FC                DC.W $31FC                     ; Unknown/data
0089453A  08 02                DC.W $0802                     ; Unknown/data
0089453C  A0 08                DC.W $A008                     ; Unknown/data
0089453E  4E 75                RTS                            ; Return from subroutine
```

### func_14540 ($00894540)

**File Offset**: $14540
**Size**: 30 bytes
**Complete**: No (may continue)

```asm
00894540  4A 78                BPL.B $145BA                   ; Conditional branch (byte)
00894542  A0 08                DC.W $A008                     ; Unknown/data
00894544  66 1E                BNE.B $14564                   ; Conditional branch (byte)
00894546  33 FC                DC.W $33FC                     ; Unknown/data
00894548  00 20                DC.W $0020                     ; Unknown/data
0089454A  00 FF                DC.W $00FF                     ; Unknown/data
0089454C  00 08                DC.W $0008                     ; Unknown/data
0089454E  11 FC                DC.W $11FC                     ; Unknown/data
00894550  00 00                DC.W $0000                     ; Unknown/data
00894552  C0 80                DC.W $C080                     ; Unknown/data
00894554  23 FC                DC.W $23FC                     ; Unknown/data
00894556  00 88                DC.W $0088                     ; Unknown/data
00894558  53 B0                DC.W $53B0                     ; Unknown/data
0089455A  00 FF                DC.W $00FF                     ; Unknown/data
0089455C  00 02                DC.W $0002                     ; Unknown/data
0089455E  4E F9 00 88 28 90    JMP $00882890                  ; Jump to address
```

### func_1466A ($0089466A)

**File Offset**: $1466A
**Size**: 42 bytes
**Complete**: Yes

```asm
0089466A  70 00                MOVEQ #$00,D0                  ; Quick move immediate (0)
0089466C  11 C0                DC.W $11C0                     ; Unknown/data
0089466E  C8 0D                DC.W $C80D                     ; Unknown/data
00894670  13 C0                DC.W $13C0                     ; Unknown/data
00894672  00 FF                DC.W $00FF                     ; Unknown/data
00894674  68 70                DC.W $6870                     ; Unknown/data
00894676  13 C0                DC.W $13C0                     ; Unknown/data
00894678  00 FF                DC.W $00FF                     ; Unknown/data
0089467A  68 A0                DC.W $68A0                     ; Unknown/data
0089467C  13 C0                DC.W $13C0                     ; Unknown/data
0089467E  00 FF                DC.W $00FF                     ; Unknown/data
00894680  68 20                DC.W $6820                     ; Unknown/data
00894682  13 C0                DC.W $13C0                     ; Unknown/data
00894684  00 FF                DC.W $00FF                     ; Unknown/data
00894686  68 50                DC.W $6850                     ; Unknown/data
00894688  13 C0                DC.W $13C0                     ; Unknown/data
0089468A  00 FF                DC.W $00FF                     ; Unknown/data
0089468C  68 30                DC.W $6830                     ; Unknown/data
0089468E  13 C0                DC.W $13C0                     ; Unknown/data
00894690  00 FF                DC.W $00FF                     ; Unknown/data
00894692  68 B0                DC.W $68B0                     ; Unknown/data
00894694  4E 75                RTS                            ; Return from subroutine
```

### func_14696 ($00894696)

**File Offset**: $14696
**Size**: 28 bytes
**Complete**: Yes
**Registers Saved**: D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, A2, A3, A4, A5, A6

```asm
00894696  11 FC                DC.W $11FC                     ; Unknown/data
00894698  00 01                DC.W $0001                     ; Unknown/data
0089469A  C8 0D                DC.W $C80D                     ; Unknown/data
0089469C  48 E7 FF FE          MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,-(A7) ; Save registers to stack
008946A0  46 FC                BNE.B $1469E                   ; Conditional branch (byte)
008946A2  27 00 4E B9          BEQ.W $1955D                   ; Conditional branch (word)
008946A6  00 88                DC.W $0088                     ; Unknown/data
008946A8  D1 D4                DC.W $D1D4                     ; Unknown/data
008946AA  46 FC                BNE.B $146A8                   ; Conditional branch (byte)
008946AC  23 00                DC.W $2300                     ; Unknown/data
008946AE  4C DF 7F FF          MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6 ; Restore registers from stack
008946B2  4E 75                RTS                            ; Return from subroutine
```

### func_1469C ($0089469C)

**File Offset**: $1469C
**Size**: 22 bytes
**Complete**: Yes
**Registers Saved**: D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, A2, A3, A4, A5, A6

```asm
0089469C  48 E7 FF FE          MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,-(A7) ; Save registers to stack
008946A0  46 FC                BNE.B $1469E                   ; Conditional branch (byte)
008946A2  27 00 4E B9          BEQ.W $1955D                   ; Conditional branch (word)
008946A6  00 88                DC.W $0088                     ; Unknown/data
008946A8  D1 D4                DC.W $D1D4                     ; Unknown/data
008946AA  46 FC                BNE.B $146A8                   ; Conditional branch (byte)
008946AC  23 00                DC.W $2300                     ; Unknown/data
008946AE  4C DF 7F FF          MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6 ; Restore registers from stack
008946B2  4E 75                RTS                            ; Return from subroutine
```

### func_146B4 ($008946B4)

**File Offset**: $146B4
**Size**: 6 bytes
**Complete**: Yes

```asm
008946B4  11 FC                DC.W $11FC                     ; Unknown/data
008946B6  00 01                DC.W $0001                     ; Unknown/data
008946B8  C3 0D                DC.W $C30D                     ; Unknown/data
008946BA  4E 75                RTS                            ; Return from subroutine
```

### func_146BC ($008946BC)

**File Offset**: $146BC
**Size**: 12 bytes
**Complete**: Yes

```asm
008946BC  08 F8                DC.W $08F8                     ; Unknown/data
008946BE  00 00                DC.W $0000                     ; Unknown/data
008946C0  C3 0E                DC.W $C30E                     ; Unknown/data
008946C2  31 F8                DC.W $31F8                     ; Unknown/data
008946C4  C0 96                DC.W $C096                     ; Unknown/data
008946C6  C0 7A                DC.W $C07A                     ; Unknown/data
008946C8  4E 75                RTS                            ; Return from subroutine
```

### func_146CA ($008946CA)

**File Offset**: $146CA
**Size**: 14 bytes
**Complete**: Yes
**BSR Calls**: $146DC

```asm
008946CA  70 01                MOVEQ #$01,D0                  ; Quick move immediate (1)
008946CC  D1 78                DC.W $D178                     ; Unknown/data
008946CE  C0 54                DC.W $C054                     ; Unknown/data
008946D0  33 F8                DC.W $33F8                     ; Unknown/data
008946D2  C0 54                DC.W $C054                     ; Unknown/data
008946D4  00 FF                DC.W $00FF                     ; Unknown/data
008946D6  61 04                BSR.B $146DC                   ; Branch to subroutine short
008946D8  4E 75                RTS                            ; Return from subroutine
```

### func_146DA ($008946DA)

**File Offset**: $146DA
**Size**: 14 bytes
**Complete**: Yes
**BSR Calls**: $146EC

```asm
008946DA  70 01                MOVEQ #$01,D0                  ; Quick move immediate (1)
008946DC  91 78                DC.W $9178                     ; Unknown/data
008946DE  C0 54                DC.W $C054                     ; Unknown/data
008946E0  33 F8                DC.W $33F8                     ; Unknown/data
008946E2  C0 54                DC.W $C054                     ; Unknown/data
008946E4  00 FF                DC.W $00FF                     ; Unknown/data
008946E6  61 04                BSR.B $146EC                   ; Branch to subroutine short
008946E8  4E 75                RTS                            ; Return from subroutine
```

### func_146EA ($008946EA)

**File Offset**: $146EA
**Size**: 14 bytes
**Complete**: Yes
**BSR Calls**: $146FE

```asm
008946EA  70 01                MOVEQ #$01,D0                  ; Quick move immediate (1)
008946EC  D1 78                DC.W $D178                     ; Unknown/data
008946EE  C0 56                DC.W $C056                     ; Unknown/data
008946F0  33 F8                DC.W $33F8                     ; Unknown/data
008946F2  C0 56                DC.W $C056                     ; Unknown/data
008946F4  00 FF                DC.W $00FF                     ; Unknown/data
008946F6  61 06                BSR.B $146FE                   ; Branch to subroutine short
008946F8  4E 75                RTS                            ; Return from subroutine
```

### func_146FA ($008946FA)

**File Offset**: $146FA
**Size**: 14 bytes
**Complete**: Yes
**BSR Calls**: $1470E

```asm
008946FA  70 01                MOVEQ #$01,D0                  ; Quick move immediate (1)
008946FC  91 78                DC.W $9178                     ; Unknown/data
008946FE  C0 56                DC.W $C056                     ; Unknown/data
00894700  33 F8                DC.W $33F8                     ; Unknown/data
00894702  C0 56                DC.W $C056                     ; Unknown/data
00894704  00 FF                DC.W $00FF                     ; Unknown/data
00894706  61 06                BSR.B $1470E                   ; Branch to subroutine short
00894708  4E 75                RTS                            ; Return from subroutine
```

### func_1470A ($0089470A)

**File Offset**: $1470A
**Size**: 14 bytes
**Complete**: Yes
**BSR Calls**: $1471C

```asm
0089470A  70 20                MOVEQ #$20,D0                  ; Quick move immediate (32)
0089470C  D1 78                DC.W $D178                     ; Unknown/data
0089470E  C0 54                DC.W $C054                     ; Unknown/data
00894710  33 F8                DC.W $33F8                     ; Unknown/data
00894712  C0 54                DC.W $C054                     ; Unknown/data
00894714  00 FF                DC.W $00FF                     ; Unknown/data
00894716  61 04                BSR.B $1471C                   ; Branch to subroutine short
00894718  4E 75                RTS                            ; Return from subroutine
```

### func_1471A ($0089471A)

**File Offset**: $1471A
**Size**: 14 bytes
**Complete**: Yes
**BSR Calls**: $1472C

```asm
0089471A  70 20                MOVEQ #$20,D0                  ; Quick move immediate (32)
0089471C  91 78                DC.W $9178                     ; Unknown/data
0089471E  C0 54                DC.W $C054                     ; Unknown/data
00894720  33 F8                DC.W $33F8                     ; Unknown/data
00894722  C0 54                DC.W $C054                     ; Unknown/data
00894724  00 FF                DC.W $00FF                     ; Unknown/data
00894726  61 04                BSR.B $1472C                   ; Branch to subroutine short
00894728  4E 75                RTS                            ; Return from subroutine
```

### func_1472A ($0089472A)

**File Offset**: $1472A
**Size**: 14 bytes
**Complete**: Yes
**BSR Calls**: $1473E

```asm
0089472A  70 20                MOVEQ #$20,D0                  ; Quick move immediate (32)
0089472C  D1 78                DC.W $D178                     ; Unknown/data
0089472E  C0 56                DC.W $C056                     ; Unknown/data
00894730  33 F8                DC.W $33F8                     ; Unknown/data
00894732  C0 56                DC.W $C056                     ; Unknown/data
00894734  00 FF                DC.W $00FF                     ; Unknown/data
00894736  61 06                BSR.B $1473E                   ; Branch to subroutine short
00894738  4E 75                RTS                            ; Return from subroutine
```

### func_1473A ($0089473A)

**File Offset**: $1473A
**Size**: 14 bytes
**Complete**: Yes
**BSR Calls**: $1474E

```asm
0089473A  70 20                MOVEQ #$20,D0                  ; Quick move immediate (32)
0089473C  91 78                DC.W $9178                     ; Unknown/data
0089473E  C0 56                DC.W $C056                     ; Unknown/data
00894740  33 F8                DC.W $33F8                     ; Unknown/data
00894742  C0 56                DC.W $C056                     ; Unknown/data
00894744  00 FF                DC.W $00FF                     ; Unknown/data
00894746  61 06                BSR.B $1474E                   ; Branch to subroutine short
00894748  4E 75                RTS                            ; Return from subroutine
```

### func_1474A ($0089474A)

**File Offset**: $1474A
**Size**: 8 bytes
**Complete**: Yes

```asm
0089474A  30 38                DC.W $3038                     ; Unknown/data
0089474C  C8 B0                DC.W $C8B0                     ; Unknown/data
0089474E  D1 78                DC.W $D178                     ; Unknown/data
00894750  C0 56                DC.W $C056                     ; Unknown/data
00894752  4E 75                RTS                            ; Return from subroutine
```

### func_14754 ($00894754)

**File Offset**: $14754
**Size**: 8 bytes
**Complete**: Yes

```asm
00894754  30 38                DC.W $3038                     ; Unknown/data
00894756  C8 B0                DC.W $C8B0                     ; Unknown/data
00894758  91 78                DC.W $9178                     ; Unknown/data
0089475A  C0 56                DC.W $C056                     ; Unknown/data
0089475C  4E 75                RTS                            ; Return from subroutine
```

### func_1475E ($0089475E)

**File Offset**: $1475E
**Size**: 8 bytes
**Complete**: Yes

```asm
0089475E  30 38                DC.W $3038                     ; Unknown/data
00894760  C8 B2                DC.W $C8B2                     ; Unknown/data
00894762  D1 78                DC.W $D178                     ; Unknown/data
00894764  C0 86                DC.W $C086                     ; Unknown/data
00894766  4E 75                RTS                            ; Return from subroutine
```

### func_14768 ($00894768)

**File Offset**: $14768
**Size**: 8 bytes
**Complete**: Yes

```asm
00894768  30 38                DC.W $3038                     ; Unknown/data
0089476A  C8 B2                DC.W $C8B2                     ; Unknown/data
0089476C  91 78                DC.W $9178                     ; Unknown/data
0089476E  C0 86                DC.W $C086                     ; Unknown/data
00894770  4E 75                RTS                            ; Return from subroutine
```

### func_14772 ($00894772)

**File Offset**: $14772
**Size**: 8 bytes
**Complete**: Yes

```asm
00894772  30 38                DC.W $3038                     ; Unknown/data
00894774  C8 B4                DC.W $C8B4                     ; Unknown/data
00894776  D1 78                DC.W $D178                     ; Unknown/data
00894778  C0 B0                DC.W $C0B0                     ; Unknown/data
0089477A  4E 75                RTS                            ; Return from subroutine
```

### func_1477C ($0089477C)

**File Offset**: $1477C
**Size**: 8 bytes
**Complete**: Yes

```asm
0089477C  30 38                DC.W $3038                     ; Unknown/data
0089477E  C8 B4                DC.W $C8B4                     ; Unknown/data
00894780  91 78                DC.W $9178                     ; Unknown/data
00894782  C0 B0                DC.W $C0B0                     ; Unknown/data
00894784  4E 75                RTS                            ; Return from subroutine
```

### func_14786 ($00894786)

**File Offset**: $14786
**Size**: 8 bytes
**Complete**: Yes

```asm
00894786  30 38                DC.W $3038                     ; Unknown/data
00894788  C8 B6                DC.W $C8B6                     ; Unknown/data
0089478A  D1 78                DC.W $D178                     ; Unknown/data
0089478C  C0 AE                DC.W $C0AE                     ; Unknown/data
0089478E  4E 75                RTS                            ; Return from subroutine
```

### func_14790 ($00894790)

**File Offset**: $14790
**Size**: 8 bytes
**Complete**: Yes

```asm
00894790  30 38                DC.W $3038                     ; Unknown/data
00894792  C8 B6                DC.W $C8B6                     ; Unknown/data
00894794  91 78                DC.W $9178                     ; Unknown/data
00894796  C0 AE                DC.W $C0AE                     ; Unknown/data
00894798  4E 75                RTS                            ; Return from subroutine
```

### func_1479A ($0089479A)

**File Offset**: $1479A
**Size**: 8 bytes
**Complete**: Yes

```asm
0089479A  30 38                DC.W $3038                     ; Unknown/data
0089479C  C8 B8                DC.W $C8B8                     ; Unknown/data
0089479E  D1 78                DC.W $D178                     ; Unknown/data
008947A0  C0 B2                DC.W $C0B2                     ; Unknown/data
008947A2  4E 75                RTS                            ; Return from subroutine
```

### func_147A4 ($008947A4)

**File Offset**: $147A4
**Size**: 8 bytes
**Complete**: Yes

```asm
008947A4  30 38                DC.W $3038                     ; Unknown/data
008947A6  C8 B8                DC.W $C8B8                     ; Unknown/data
008947A8  91 78                DC.W $9178                     ; Unknown/data
008947AA  C0 B2                DC.W $C0B2                     ; Unknown/data
008947AC  4E 75                RTS                            ; Return from subroutine
```

### func_147AE ($008947AE)

**File Offset**: $147AE
**Size**: 8 bytes
**Complete**: Yes

```asm
008947AE  30 38                DC.W $3038                     ; Unknown/data
008947B0  C8 BA                DC.W $C8BA                     ; Unknown/data
008947B2  D1 78                DC.W $D178                     ; Unknown/data
008947B4  C0 54                DC.W $C054                     ; Unknown/data
008947B6  4E 75                RTS                            ; Return from subroutine
```

### func_147B8 ($008947B8)

**File Offset**: $147B8
**Size**: 8 bytes
**Complete**: Yes

```asm
008947B8  30 38                DC.W $3038                     ; Unknown/data
008947BA  C8 BA                DC.W $C8BA                     ; Unknown/data
008947BC  91 78                DC.W $9178                     ; Unknown/data
008947BE  C0 54                DC.W $C054                     ; Unknown/data
008947C0  4E 75                RTS                            ; Return from subroutine
```

### func_147C2 ($008947C2)

**File Offset**: $147C2
**Size**: 36 bytes
**Complete**: Yes

```asm
008947C2  31 FC                DC.W $31FC                     ; Unknown/data
008947C4  00 00                DC.W $0000                     ; Unknown/data
008947C6  C0 86                DC.W $C086                     ; Unknown/data
008947C8  31 FC                DC.W $31FC                     ; Unknown/data
008947CA  F4 00 C0 54          BCC.W $10820                   ; Conditional branch (word)
008947CE  31 FC                DC.W $31FC                     ; Unknown/data
008947D0  34 00 C0 56          BCC.W $10828                   ; Conditional branch (word)
008947D4  31 FC                DC.W $31FC                     ; Unknown/data
008947D6  00 00                DC.W $0000                     ; Unknown/data
008947D8  C0 AE                DC.W $C0AE                     ; Unknown/data
008947DA  31 FC                DC.W $31FC                     ; Unknown/data
008947DC  08 00                DC.W $0800                     ; Unknown/data
008947DE  C0 B0                DC.W $C0B0                     ; Unknown/data
008947E0  31 FC                DC.W $31FC                     ; Unknown/data
008947E2  00 00                DC.W $0000                     ; Unknown/data
008947E4  C0 B2                DC.W $C0B2                     ; Unknown/data
008947E6  4E 75                RTS                            ; Return from subroutine
```

### func_147E8 ($008947E8)

**File Offset**: $147E8
**Size**: 36 bytes
**Complete**: Yes

```asm
008947E8  31 FC                DC.W $31FC                     ; Unknown/data
008947EA  00 80                DC.W $0080                     ; Unknown/data
008947EC  C8 B0                DC.W $C8B0                     ; Unknown/data
008947EE  31 FC                DC.W $31FC                     ; Unknown/data
008947F0  00 80                DC.W $0080                     ; Unknown/data
008947F2  C8 B2                DC.W $C8B2                     ; Unknown/data
008947F4  31 FC                DC.W $31FC                     ; Unknown/data
008947F6  00 80                DC.W $0080                     ; Unknown/data
008947F8  C8 B4                DC.W $C8B4                     ; Unknown/data
008947FA  31 FC                DC.W $31FC                     ; Unknown/data
008947FC  00 80                DC.W $0080                     ; Unknown/data
008947FE  C8 B6                DC.W $C8B6                     ; Unknown/data
00894800  31 FC                DC.W $31FC                     ; Unknown/data
00894802  00 80                DC.W $0080                     ; Unknown/data
00894804  C8 B8                DC.W $C8B8                     ; Unknown/data
00894806  31 FC                DC.W $31FC                     ; Unknown/data
00894808  00 80                DC.W $0080                     ; Unknown/data
0089480A  C8 BA                DC.W $C8BA                     ; Unknown/data
0089480C  4E 75                RTS                            ; Return from subroutine
```

### func_1480E ($0089480E)

**File Offset**: $1480E
**Size**: 6 bytes
**Complete**: Yes

```asm
0089480E  06 78                BNE.B $14888                   ; Conditional branch (byte)
00894810  04 00 90 3C          BCC.W $0D84E                   ; Conditional branch (word)
00894814  4E 75                RTS                            ; Return from subroutine
```

### func_14816 ($00894816)

**File Offset**: $14816
**Size**: 6 bytes
**Complete**: Yes

```asm
00894816  04 78                BCC.B $14890                   ; Conditional branch (byte)
00894818  04 00 90 3C          BCC.W $0D856                   ; Conditional branch (word)
0089481C  4E 75                RTS                            ; Return from subroutine
```

### func_1481E ($0089481E)

**File Offset**: $1481E
**Size**: 6 bytes
**Complete**: Yes

```asm
0089481E  06 78                BNE.B $14898                   ; Conditional branch (byte)
00894820  10 00                DC.W $1000                     ; Unknown/data
00894822  90 3C                DC.W $903C                     ; Unknown/data
00894824  4E 75                RTS                            ; Return from subroutine
```

### func_14826 ($00894826)

**File Offset**: $14826
**Size**: 6 bytes
**Complete**: Yes

```asm
00894826  06 78                BNE.B $148A0                   ; Conditional branch (byte)
00894828  20 00                DC.W $2000                     ; Unknown/data
0089482A  90 3C                DC.W $903C                     ; Unknown/data
0089482C  4E 75                RTS                            ; Return from subroutine
```

### func_1482E ($0089482E)

**File Offset**: $1482E
**Size**: 24 bytes
**Complete**: Yes

```asm
0089482E  20 38                DC.W $2038                     ; Unknown/data
00894830  C8 88                DC.W $C888                     ; Unknown/data
00894832  50 80                DC.W $5080                     ; Unknown/data
00894834  0C 80                BGE.B $147B6                   ; Conditional branch (byte)
00894836  00 FF                DC.W $00FF                     ; Unknown/data
00894838  FF FF                BLE.B $14839                   ; Conditional branch (byte)
0089483A  6F 06                BLE.B $14842                   ; Conditional branch (byte)
0089483C  20 3C 00 FF 00 00    MOVE.L #$00FF0000,D0           ; Load immediate to data register
00894842  21 C0                DC.W $21C0                     ; Unknown/data
00894844  C8 88                DC.W $C888                     ; Unknown/data
00894846  4E 75                RTS                            ; Return from subroutine
```

### func_14848 ($00894848)

**File Offset**: $14848
**Size**: 24 bytes
**Complete**: Yes

```asm
00894848  20 38                DC.W $2038                     ; Unknown/data
0089484A  C8 88                DC.W $C888                     ; Unknown/data
0089484C  51 80                DC.W $5180                     ; Unknown/data
0089484E  0C 80                BGE.B $147D0                   ; Conditional branch (byte)
00894850  00 FF                DC.W $00FF                     ; Unknown/data
00894852  60 00 6C 06          BRA.W $1B45A                   ; Branch always
00894856  20 3C 00 FF FF F7    MOVE.L #$00FFFFF7,D0           ; Load immediate to data register
0089485C  21 C0                DC.W $21C0                     ; Unknown/data
0089485E  C8 88                DC.W $C888                     ; Unknown/data
00894860  4E 75                RTS                            ; Return from subroutine
```

### func_14882 ($00894882)

**File Offset**: $14882
**Size**: 0 bytes
**Complete**: Yes

```asm
00894882  4E 75                RTS                            ; Return from subroutine
```

### func_14884 ($00894884)

**File Offset**: $14884
**Size**: 0 bytes
**Complete**: Yes

```asm
00894884  4E 75                RTS                            ; Return from subroutine
```

### func_14886 ($00894886)

**File Offset**: $14886
**Size**: 0 bytes
**Complete**: Yes

```asm
00894886  4E 75                RTS                            ; Return from subroutine
```

### func_15494 ($00895494)

**File Offset**: $15494
**Size**: 128 bytes
**Complete**: No (may continue)

```asm
00895494  00 00                DC.W $0000                     ; Unknown/data
00895496  00 00                DC.W $0000                     ; Unknown/data
00895498  00 B0                DC.W $00B0                     ; Unknown/data
0089549A  04 B8                BCC.B $15454                   ; Conditional branch (byte)
0089549C  00 00                DC.W $0000                     ; Unknown/data
0089549E  00 00                DC.W $0000                     ; Unknown/data
008954A0  00 00                DC.W $0000                     ; Unknown/data
008954A2  00 00                DC.W $0000                     ; Unknown/data
008954A4  00 00                DC.W $0000                     ; Unknown/data
008954A6  00 00                DC.W $0000                     ; Unknown/data
008954A8  00 B0                DC.W $00B0                     ; Unknown/data
008954AA  04 B8                BCC.B $15464                   ; Conditional branch (byte)
008954AC  00 C0                DC.W $00C0                     ; Unknown/data
008954AE  00 00                DC.W $0000                     ; Unknown/data
008954B0  00 00                DC.W $0000                     ; Unknown/data
008954B2  00 70                DC.W $0070                     ; Unknown/data
008954B4  00 00                DC.W $0000                     ; Unknown/data
008954B6  00 00                DC.W $0000                     ; Unknown/data
008954B8  01 00                DC.W $0100                     ; Unknown/data
008954BA  05 00 00 00          BCS.W $154BC                   ; Conditional branch (word)
008954BE  00 00                DC.W $0000                     ; Unknown/data
008954C0  00 00                DC.W $0000                     ; Unknown/data
008954C2  00 00                DC.W $0000                     ; Unknown/data
008954C4  00 00                DC.W $0000                     ; Unknown/data
008954C6  00 00                DC.W $0000                     ; Unknown/data
008954C8  01 00                DC.W $0100                     ; Unknown/data
008954CA  05 00 00 C0          BCS.W $1558C                   ; Conditional branch (word)
008954CE  00 00                DC.W $0000                     ; Unknown/data
008954D0  00 00                DC.W $0000                     ; Unknown/data
008954D2  00 70                DC.W $0070                     ; Unknown/data
008954D4  00 00                DC.W $0000                     ; Unknown/data
008954D6  00 00                DC.W $0000                     ; Unknown/data
008954D8  01 00                DC.W $0100                     ; Unknown/data
008954DA  04 00 00 00          BCC.W $154DC                   ; Conditional branch (word)
008954DE  00 00                DC.W $0000                     ; Unknown/data
008954E0  00 00                DC.W $0000                     ; Unknown/data
008954E2  00 00                DC.W $0000                     ; Unknown/data
008954E4  00 00                DC.W $0000                     ; Unknown/data
008954E6  00 00                DC.W $0000                     ; Unknown/data
008954E8  01 00                DC.W $0100                     ; Unknown/data
008954EA  04 00 00 C0          BCC.W $155AC                   ; Conditional branch (word)
008954EE  00 00                DC.W $0000                     ; Unknown/data
008954F0  00 00                DC.W $0000                     ; Unknown/data
008954F2  00 70                DC.W $0070                     ; Unknown/data
008954F4  00 89                DC.W $0089                     ; Unknown/data
008954F6  55 00 00 89          BCS.W $15581                   ; Conditional branch (word)
008954FA  55 20                BCS.B $1551C                   ; Conditional branch (byte)
008954FC  00 89                DC.W $0089                     ; Unknown/data
008954FE  55 40                BCS.B $15540                   ; Conditional branch (byte)
00895500  00 00                DC.W $0000                     ; Unknown/data
00895502  00 00                DC.W $0000                     ; Unknown/data
00895504  00 80                DC.W $0080                     ; Unknown/data
00895506  04 78                BCC.B $15580                   ; Conditional branch (byte)
00895508  00 00                DC.W $0000                     ; Unknown/data
0089550A  00 00                DC.W $0000                     ; Unknown/data
0089550C  00 00                DC.W $0000                     ; Unknown/data
0089550E  00 00                DC.W $0000                     ; Unknown/data
00895510  00 00                DC.W $0000                     ; Unknown/data
00895512  00 00                DC.W $0000                     ; Unknown/data
```

### func_154B4 ($008954B4)

**File Offset**: $154B4
**Size**: 128 bytes
**Complete**: No (may continue)

```asm
008954B4  00 00                DC.W $0000                     ; Unknown/data
008954B6  00 00                DC.W $0000                     ; Unknown/data
008954B8  01 00                DC.W $0100                     ; Unknown/data
008954BA  05 00 00 00          BCS.W $154BC                   ; Conditional branch (word)
008954BE  00 00                DC.W $0000                     ; Unknown/data
008954C0  00 00                DC.W $0000                     ; Unknown/data
008954C2  00 00                DC.W $0000                     ; Unknown/data
008954C4  00 00                DC.W $0000                     ; Unknown/data
008954C6  00 00                DC.W $0000                     ; Unknown/data
008954C8  01 00                DC.W $0100                     ; Unknown/data
008954CA  05 00 00 C0          BCS.W $1558C                   ; Conditional branch (word)
008954CE  00 00                DC.W $0000                     ; Unknown/data
008954D0  00 00                DC.W $0000                     ; Unknown/data
008954D2  00 70                DC.W $0070                     ; Unknown/data
008954D4  00 00                DC.W $0000                     ; Unknown/data
008954D6  00 00                DC.W $0000                     ; Unknown/data
008954D8  01 00                DC.W $0100                     ; Unknown/data
008954DA  04 00 00 00          BCC.W $154DC                   ; Conditional branch (word)
008954DE  00 00                DC.W $0000                     ; Unknown/data
008954E0  00 00                DC.W $0000                     ; Unknown/data
008954E2  00 00                DC.W $0000                     ; Unknown/data
008954E4  00 00                DC.W $0000                     ; Unknown/data
008954E6  00 00                DC.W $0000                     ; Unknown/data
008954E8  01 00                DC.W $0100                     ; Unknown/data
008954EA  04 00 00 C0          BCC.W $155AC                   ; Conditional branch (word)
008954EE  00 00                DC.W $0000                     ; Unknown/data
008954F0  00 00                DC.W $0000                     ; Unknown/data
008954F2  00 70                DC.W $0070                     ; Unknown/data
008954F4  00 89                DC.W $0089                     ; Unknown/data
008954F6  55 00 00 89          BCS.W $15581                   ; Conditional branch (word)
008954FA  55 20                BCS.B $1551C                   ; Conditional branch (byte)
008954FC  00 89                DC.W $0089                     ; Unknown/data
008954FE  55 40                BCS.B $15540                   ; Conditional branch (byte)
00895500  00 00                DC.W $0000                     ; Unknown/data
00895502  00 00                DC.W $0000                     ; Unknown/data
00895504  00 80                DC.W $0080                     ; Unknown/data
00895506  04 78                BCC.B $15580                   ; Conditional branch (byte)
00895508  00 00                DC.W $0000                     ; Unknown/data
0089550A  00 00                DC.W $0000                     ; Unknown/data
0089550C  00 00                DC.W $0000                     ; Unknown/data
0089550E  00 00                DC.W $0000                     ; Unknown/data
00895510  00 00                DC.W $0000                     ; Unknown/data
00895512  00 00                DC.W $0000                     ; Unknown/data
00895514  00 80                DC.W $0080                     ; Unknown/data
00895516  04 78                BCC.B $15590                   ; Conditional branch (byte)
00895518  00 C0                DC.W $00C0                     ; Unknown/data
0089551A  00 00                DC.W $0000                     ; Unknown/data
0089551C  00 00                DC.W $0000                     ; Unknown/data
0089551E  00 70                DC.W $0070                     ; Unknown/data
00895520  00 00                DC.W $0000                     ; Unknown/data
00895522  00 00                DC.W $0000                     ; Unknown/data
00895524  00 F0                DC.W $00F0                     ; Unknown/data
00895526  04 B6                BCC.B $154DE                   ; Conditional branch (byte)
00895528  00 00                DC.W $0000                     ; Unknown/data
0089552A  00 00                DC.W $0000                     ; Unknown/data
0089552C  00 00                DC.W $0000                     ; Unknown/data
0089552E  00 00                DC.W $0000                     ; Unknown/data
00895530  00 00                DC.W $0000                     ; Unknown/data
00895532  00 00                DC.W $0000                     ; Unknown/data
```

### func_154D4 ($008954D4)

**File Offset**: $154D4
**Size**: 128 bytes
**Complete**: No (may continue)

```asm
008954D4  00 00                DC.W $0000                     ; Unknown/data
008954D6  00 00                DC.W $0000                     ; Unknown/data
008954D8  01 00                DC.W $0100                     ; Unknown/data
008954DA  04 00 00 00          BCC.W $154DC                   ; Conditional branch (word)
008954DE  00 00                DC.W $0000                     ; Unknown/data
008954E0  00 00                DC.W $0000                     ; Unknown/data
008954E2  00 00                DC.W $0000                     ; Unknown/data
008954E4  00 00                DC.W $0000                     ; Unknown/data
008954E6  00 00                DC.W $0000                     ; Unknown/data
008954E8  01 00                DC.W $0100                     ; Unknown/data
008954EA  04 00 00 C0          BCC.W $155AC                   ; Conditional branch (word)
008954EE  00 00                DC.W $0000                     ; Unknown/data
008954F0  00 00                DC.W $0000                     ; Unknown/data
008954F2  00 70                DC.W $0070                     ; Unknown/data
008954F4  00 89                DC.W $0089                     ; Unknown/data
008954F6  55 00 00 89          BCS.W $15581                   ; Conditional branch (word)
008954FA  55 20                BCS.B $1551C                   ; Conditional branch (byte)
008954FC  00 89                DC.W $0089                     ; Unknown/data
008954FE  55 40                BCS.B $15540                   ; Conditional branch (byte)
00895500  00 00                DC.W $0000                     ; Unknown/data
00895502  00 00                DC.W $0000                     ; Unknown/data
00895504  00 80                DC.W $0080                     ; Unknown/data
00895506  04 78                BCC.B $15580                   ; Conditional branch (byte)
00895508  00 00                DC.W $0000                     ; Unknown/data
0089550A  00 00                DC.W $0000                     ; Unknown/data
0089550C  00 00                DC.W $0000                     ; Unknown/data
0089550E  00 00                DC.W $0000                     ; Unknown/data
00895510  00 00                DC.W $0000                     ; Unknown/data
00895512  00 00                DC.W $0000                     ; Unknown/data
00895514  00 80                DC.W $0080                     ; Unknown/data
00895516  04 78                BCC.B $15590                   ; Conditional branch (byte)
00895518  00 C0                DC.W $00C0                     ; Unknown/data
0089551A  00 00                DC.W $0000                     ; Unknown/data
0089551C  00 00                DC.W $0000                     ; Unknown/data
0089551E  00 70                DC.W $0070                     ; Unknown/data
00895520  00 00                DC.W $0000                     ; Unknown/data
00895522  00 00                DC.W $0000                     ; Unknown/data
00895524  00 F0                DC.W $00F0                     ; Unknown/data
00895526  04 B6                BCC.B $154DE                   ; Conditional branch (byte)
00895528  00 00                DC.W $0000                     ; Unknown/data
0089552A  00 00                DC.W $0000                     ; Unknown/data
0089552C  00 00                DC.W $0000                     ; Unknown/data
0089552E  00 00                DC.W $0000                     ; Unknown/data
00895530  00 00                DC.W $0000                     ; Unknown/data
00895532  00 00                DC.W $0000                     ; Unknown/data
00895534  00 F0                DC.W $00F0                     ; Unknown/data
00895536  04 B6                BCC.B $154EE                   ; Conditional branch (byte)
00895538  00 C0                DC.W $00C0                     ; Unknown/data
0089553A  00 00                DC.W $0000                     ; Unknown/data
0089553C  00 00                DC.W $0000                     ; Unknown/data
0089553E  00 70                DC.W $0070                     ; Unknown/data
00895540  00 00                DC.W $0000                     ; Unknown/data
00895542  00 00                DC.W $0000                     ; Unknown/data
00895544  00 F0                DC.W $00F0                     ; Unknown/data
00895546  04 78                BCC.B $155C0                   ; Conditional branch (byte)
00895548  00 00                DC.W $0000                     ; Unknown/data
0089554A  00 00                DC.W $0000                     ; Unknown/data
0089554C  00 00                DC.W $0000                     ; Unknown/data
0089554E  00 00                DC.W $0000                     ; Unknown/data
00895550  00 00                DC.W $0000                     ; Unknown/data
00895552  00 00                DC.W $0000                     ; Unknown/data
```


## Extended Region ($30000+)

5 functions

### func_407F0 ($008C07F0)

**File Offset**: $407F0
**Size**: 128 bytes
**Complete**: No (may continue)

```asm
008C07F0  4E 56 CE EE          LINK A6,#$-3112                ; Create stack frame (12562 bytes local)
008C07F4  DB 34                BMI.B $4082A                   ; Conditional branch (byte)
008C07F6  66 DC                BNE.B $407D4                   ; Conditional branch (byte)
008C07F8  BC D4                BGE.B $407CE                   ; Conditional branch (byte)
008C07FA  5D 53                BLT.B $4084F                   ; Conditional branch (byte)
008C07FC  DC 2E                BGE.B $4082C                   ; Conditional branch (byte)
008C07FE  EE 57                BGT.B $40857                   ; Conditional branch (byte)
008C0800  66 EA                BNE.B $407EC                   ; Conditional branch (byte)
008C0802  5C 36                BGE.B $4083A                   ; Conditional branch (byte)
008C0804  52 EE                DC.W $52EE                     ; Unknown/data
008C0806  B6 3A                BNE.B $40842                   ; Conditional branch (byte)
008C0808  DE 36                BGT.B $40840                   ; Conditional branch (byte)
008C080A  7D EF                BLT.B $407FB                   ; Conditional branch (byte)
008C080C  C6 65                BNE.B $40873                   ; Conditional branch (byte)
008C080E  EE 46                BGT.B $40856                   ; Conditional branch (byte)
008C0810  5D 25                BLT.B $40837                   ; Conditional branch (byte)
008C0812  EE 3C                BGT.B $40850                   ; Conditional branch (byte)
008C0814  41 C5                DC.W $41C5                     ; Unknown/data
008C0816  45 3D                BCS.B $40855                   ; Conditional branch (byte)
008C0818  4D 5E                BLT.B $40878                   ; Conditional branch (byte)
008C081A  D3 67                DC.W $D367                     ; Unknown/data
008C081C  0D E4                BLT.B $40802                   ; Conditional branch (byte)
008C081E  4D 5B                BLT.B $4087B                   ; Conditional branch (byte)
008C0820  96 4E                BNE.B $40870                   ; Conditional branch (byte)
008C0822  E0 15                DC.W $E015                     ; Unknown/data
008C0824  41 DE                DC.W $41DE                     ; Unknown/data
008C0826  C5 42                BCS.B $4086A                   ; Conditional branch (byte)
008C0828  5D 14                BLT.B $4083E                   ; Conditional branch (byte)
008C082A  0A 25                BPL.B $40851                   ; Conditional branch (byte)
008C082C  4D E4                BLT.B $40812                   ; Conditional branch (byte)
008C082E  6B 3C                BMI.B $4086C                   ; Conditional branch (byte)
008C0830  63 DE                DC.W $63DE                     ; Unknown/data
008C0832  E5 D5                BCS.B $40809                   ; Conditional branch (byte)
008C0834  54 BC                BCC.B $407F2                   ; Conditional branch (byte)
008C0836  C6 CC                BNE.B $40804                   ; Conditional branch (byte)
008C0838  46 DD                BNE.B $40817                   ; Conditional branch (byte)
008C083A  CD 56                BLT.B $40892                   ; Conditional branch (byte)
008C083C  2B E2                BMI.B $40820                   ; Conditional branch (byte)
008C083E  4B 30                BMI.B $40870                   ; Conditional branch (byte)
008C0840  45 DD                BCS.B $4081F                   ; Conditional branch (byte)
008C0842  55 BE                BCS.B $40802                   ; Conditional branch (byte)
008C0844  E5 7C                BCS.B $408C2                   ; Conditional branch (byte)
008C0846  F3 54                DC.W $F354                     ; Unknown/data
008C0848  CD 99                BLT.B $407E3                   ; Conditional branch (byte)
008C084A  D6 6A                BNE.B $408B6                   ; Conditional branch (byte)
008C084C  EB 6E                BMI.B $408BC                   ; Conditional branch (byte)
008C084E  35 64                BCS.B $408B4                   ; Conditional branch (byte)
008C0850  CB BD                BMI.B $4080F                   ; Conditional branch (byte)
008C0852  E5 63                BCS.B $408B7                   ; Conditional branch (byte)
008C0854  ED 46                BLT.B $4089C                   ; Conditional branch (byte)
008C0856  4C DD 57 EE          MOVEM.L (A5)+,D1/D2/D3/D5/D6/D7/A0/A1/A2/A4/A6 ; Restore registers from stack
008C085A  D1 6C                DC.W $D16C                     ; Unknown/data
008C085C  CE 64                BGT.B $408C2                   ; Conditional branch (byte)
008C085E  DE 55                BGT.B $408B5                   ; Conditional branch (byte)
008C0860  53 DD                DC.W $53DD                     ; Unknown/data
008C0862  A5 3D                BCS.B $408A1                   ; Conditional branch (byte)
008C0864  94 B3                BCC.B $40819                   ; Conditional branch (byte)
008C0866  A0 4D                DC.W $A04D                     ; Unknown/data
008C0868  A5 7E                BCS.B $408E8                   ; Conditional branch (byte)
008C086A  F6 65                BNE.B $408D1                   ; Conditional branch (byte)
008C086C  DD D5                BLT.B $40843                   ; Conditional branch (byte)
008C086E  BE 56                BGT.B $408C6                   ; Conditional branch (byte)
```

### func_4A943 ($008CA943)

**File Offset**: $4A943
**Size**: 128 bytes
**Complete**: No (may continue)

```asm
008CA943  4E 56 45 CC          LINK A6,#$45CC                 ; Create stack frame (-17868 bytes local)
008CA947  2C 5D                BGE.B $4A9A6                   ; Conditional branch (byte)
008CA949  EC B5                BGE.B $4A900                   ; Conditional branch (byte)
008CA94B  5E B5                BGT.B $4A902                   ; Conditional branch (byte)
008CA94D  64 CD                BCC.B $4A91C                   ; Conditional branch (byte)
008CA94F  D5 44                BCS.B $4A995                   ; Conditional branch (byte)
008CA951  6D EB                BLT.B $4A93E                   ; Conditional branch (byte)
008CA953  4D B4                BLT.B $4A909                   ; Conditional branch (byte)
008CA955  E0 74                DC.W $E074                     ; Unknown/data
008CA957  D5 BC                BCS.B $4A915                   ; Conditional branch (byte)
008CA959  53 ED                DC.W $53ED                     ; Unknown/data
008CA95B  5D 64                BLT.B $4A9C1                   ; Conditional branch (byte)
008CA95D  E3 4D                DC.W $E34D                     ; Unknown/data
008CA95F  D5 15                BCS.B $4A976                   ; Conditional branch (byte)
008CA961  6C D5                BGE.B $4A938                   ; Conditional branch (byte)
008CA963  4E D3                BGT.B $4A938                   ; Conditional branch (byte)
008CA965  DB 64                BMI.B $4A9CB                   ; Conditional branch (byte)
008CA967  EB 51                BMI.B $4A9BA                   ; Conditional branch (byte)
008CA969  65 DE                BCS.B $4A949                   ; Conditional branch (byte)
008CA96B  D6 4C                BNE.B $4A9B9                   ; Conditional branch (byte)
008CA96D  EC 64                BGE.B $4A9D3                   ; Conditional branch (byte)
008CA96F  DD E6                BLT.B $4A957                   ; Conditional branch (byte)
008CA971  6C CC                BGE.B $4A93F                   ; Conditional branch (byte)
008CA973  56 3D                BNE.B $4A9B2                   ; Conditional branch (byte)
008CA975  E4 3D                BCC.B $4A9B4                   ; Conditional branch (byte)
008CA977  4D C5                BLT.B $4A93E                   ; Conditional branch (byte)
008CA979  53 B2                DC.W $53B2                     ; Unknown/data
008CA97B  AD 34                BLT.B $4A9B1                   ; Conditional branch (byte)
008CA97D  55 CD                BCS.B $4A94C                   ; Conditional branch (byte)
008CA97F  15 3E                BCS.B $4A9BF                   ; Conditional branch (byte)
008CA981  DC 53                BGE.B $4A9D6                   ; Conditional branch (byte)
008CA983  DB 26                BMI.B $4A9AB                   ; Conditional branch (byte)
008CA985  6C DD                BGE.B $4A964                   ; Conditional branch (byte)
008CA987  5B D3                BMI.B $4A95C                   ; Conditional branch (byte)
008CA989  C2 5B                DC.W $C25B                     ; Unknown/data
008CA98B  DD 53                BLT.B $4A9E0                   ; Conditional branch (byte)
008CA98D  D4 65                BCC.B $4A9F4                   ; Conditional branch (byte)
008CA98F  CD 94                BLT.B $4A925                   ; Conditional branch (byte)
008CA991  5B EE                BMI.B $4A981                   ; Conditional branch (byte)
008CA993  A6 5E                BNE.B $4A9F3                   ; Conditional branch (byte)
008CA995  B5 65                BCS.B $4A9FC                   ; Conditional branch (byte)
008CA997  ED B6                BLT.B $4A94F                   ; Conditional branch (byte)
008CA999  5E DB                BGT.B $4A976                   ; Conditional branch (byte)
008CA99B  54 BE                BCC.B $4A95B                   ; Conditional branch (byte)
008CA99D  E6 54                BNE.B $4A9F3                   ; Conditional branch (byte)
008CA99F  5C 34                BGE.B $4A9D5                   ; Conditional branch (byte)
008CA9A1  C4 BD                BCC.B $4A960                   ; Conditional branch (byte)
008CA9A3  D2 4C                DC.W $D24C                     ; Unknown/data
008CA9A5  33 B3                DC.W $33B3                     ; Unknown/data
008CA9A7  54 44                BCC.B $4A9ED                   ; Conditional branch (byte)
008CA9A9  DB B4                BMI.B $4A95F                   ; Conditional branch (byte)
008CA9AB  4C DD A4 3D          MOVEM.L (A5)+,D0/D2/D3/D4/D5/A2/A5/A7 ; Restore registers from stack
008CA9AF  46 5C                BNE.B $4AA0D                   ; Conditional branch (byte)
008CA9B1  CA 30                BPL.B $4A9E3                   ; Conditional branch (byte)
008CA9B3  C4 DD                BCC.B $4A992                   ; Conditional branch (byte)
008CA9B5  15 D4                BCS.B $4A98B                   ; Conditional branch (byte)
008CA9B7  4D 44                BLT.B $4A9FD                   ; Conditional branch (byte)
008CA9B9  4C 35                BGE.B $4A9F0                   ; Conditional branch (byte)
008CA9BB  42 BC                DC.W $42BC                     ; Unknown/data
008CA9BD  BC CD                BGE.B $4A98C                   ; Conditional branch (byte)
008CA9BF  4C E6                BGE.B $4A9A7                   ; Conditional branch (byte)
008CA9C1  3B 65                BMI.B $4AA28                   ; Conditional branch (byte)
```

### func_52D6B ($008D2D6B)

**File Offset**: $52D6B
**Size**: 128 bytes
**Complete**: No (may continue)

```asm
008D2D6B  4E 56 DD 55          LINK A6,#$-22AB                ; Create stack frame (8875 bytes local)
008D2D6F  D4 7A                BCC.B $52DEB                   ; Conditional branch (byte)
008D2D71  FE CD                BGT.B $52D40                   ; Conditional branch (byte)
008D2D73  17 6D                BEQ.B $52DE2                   ; Conditional branch (byte)
008D2D75  D3 DD                DC.W $D3DD                     ; Unknown/data
008D2D77  14 DC                BCC.B $52D55                   ; Conditional branch (byte)
008D2D79  64 DA                BCC.B $52D55                   ; Conditional branch (byte)
008D2D7B  5B 46                BMI.B $52DC3                   ; Conditional branch (byte)
008D2D7D  5F ED                BLE.B $52D6C                   ; Conditional branch (byte)
008D2D7F  D5 76                BCS.B $52DF7                   ; Conditional branch (byte)
008D2D81  CD BC                BLT.B $52D3F                   ; Conditional branch (byte)
008D2D83  D9 BD                DC.W $D9BD                     ; Unknown/data
008D2D85  B6 5D                BNE.B $52DE4                   ; Conditional branch (byte)
008D2D87  A3 C5                DC.W $A3C5                     ; Unknown/data
008D2D89  7B FE                BMI.B $52D89                   ; Conditional branch (byte)
008D2D8B  DD 57                BLT.B $52DE4                   ; Conditional branch (byte)
008D2D8D  6E D5                BGT.B $52D64                   ; Conditional branch (byte)
008D2D8F  DD 4C                BLT.B $52DDD                   ; Conditional branch (byte)
008D2D91  E5 64                BCS.B $52DF7                   ; Conditional branch (byte)
008D2D93  D4 3C                BCC.B $52DD1                   ; Conditional branch (byte)
008D2D95  67 FF                BEQ.B $52D96                   ; Conditional branch (byte)
008D2D97  D9 B6                DC.W $D9B6                     ; Unknown/data
008D2D99  7C E9                BGE.B $52D84                   ; Conditional branch (byte)
008D2D9B  5C DC                BGE.B $52D79                   ; Conditional branch (byte)
008D2D9D  DE 75                BGT.B $52E14                   ; Conditional branch (byte)
008D2D9F  BC 4D                BGE.B $52DEE                   ; Conditional branch (byte)
008D2DA1  37 4F                BEQ.B $52DF2                   ; Conditional branch (byte)
008D2DA3  FA 44                BPL.B $52DE9                   ; Conditional branch (byte)
008D2DA5  76 EE                BNE.B $52D95                   ; Conditional branch (byte)
008D2DA7  44 D3                BCC.B $52D7C                   ; Conditional branch (byte)
008D2DA9  CE 36                BGT.B $52DE1                   ; Conditional branch (byte)
008D2DAB  6D D3                BLT.B $52D80                   ; Conditional branch (byte)
008D2DAD  16 6C                BNE.B $52E1B                   ; Conditional branch (byte)
008D2DAF  FF 63                BLE.B $52E14                   ; Conditional branch (byte)
008D2DB1  67 DF                BEQ.B $52D92                   ; Conditional branch (byte)
008D2DB3  36 AC                BNE.B $52D61                   ; Conditional branch (byte)
008D2DB5  DE D6                BGT.B $52D8D                   ; Conditional branch (byte)
008D2DB7  7C DD                BGE.B $52D96                   ; Conditional branch (byte)
008D2DB9  25 73                BCS.B $52E2E                   ; Conditional branch (byte)
008D2DBB  FF D5                BLE.B $52D92                   ; Conditional branch (byte)
008D2DBD  57 6F                BEQ.B $52E2E                   ; Conditional branch (byte)
008D2DBF  D6 4D                BNE.B $52E0E                   ; Conditional branch (byte)
008D2DC1  DE E6                BGT.B $52DA9                   ; Conditional branch (byte)
008D2DC3  79 EA                DC.W $79EA                     ; Unknown/data
008D2DC5  46 73                BNE.B $52E3A                   ; Conditional branch (byte)
008D2DC7  F8 56                DC.W $F856                     ; Unknown/data
008D2DC9  47 5F                BEQ.B $52E2A                   ; Conditional branch (byte)
008D2DCB  17 2E                BEQ.B $52DFB                   ; Conditional branch (byte)
008D2DCD  EE D6                BGT.B $52DA5                   ; Conditional branch (byte)
008D2DCF  73 ED                DC.W $73ED                     ; Unknown/data
008D2DD1  A6 75                BNE.B $52E48                   ; Conditional branch (byte)
008D2DD3  F8 57                DC.W $F857                     ; Unknown/data
008D2DD5  36 5F                BNE.B $52E36                   ; Conditional branch (byte)
008D2DD7  B7 4E                BEQ.B $52E27                   ; Conditional branch (byte)
008D2DD9  EE B6                BGT.B $52D91                   ; Conditional branch (byte)
008D2DDB  72 EE                MOVEQ #$EE,D1                  ; Quick move immediate (-18)
008D2DDD  56 65                BNE.B $52E44                   ; Conditional branch (byte)
008D2DDF  FF B7                BLE.B $52D98                   ; Conditional branch (byte)
008D2DE1  A6 3F                BNE.B $52E22                   ; Conditional branch (byte)
008D2DE3  07 4E                BEQ.B $52E33                   ; Conditional branch (byte)
008D2DE5  EF 37                BLE.B $52E1E                   ; Conditional branch (byte)
008D2DE7  7D DD                BLT.B $52DC6                   ; Conditional branch (byte)
008D2DE9  46 64                BNE.B $52E4F                   ; Conditional branch (byte)
```

### func_5B227 ($008DB227)

**File Offset**: $5B227
**Size**: 128 bytes
**Complete**: No (may continue)

```asm
008DB227  4E 56 64 DE          LINK A6,#$64DE                 ; Create stack frame (-25822 bytes local)
008DB22B  FE B5                BGT.B $5B1E2                   ; Conditional branch (byte)
008DB22D  5C DD                BGE.B $5B20C                   ; Conditional branch (byte)
008DB22F  46 65                BNE.B $5B296                   ; Conditional branch (byte)
008DB231  60 DC                BRA.B $5B20F                   ; Branch always (short)
008DB233  45 EF                BCS.B $5B224                   ; Conditional branch (byte)
008DB235  E3 36                DC.W $E336                     ; Unknown/data
008DB237  65 3D                BCS.B $5B276                   ; Conditional branch (byte)
008DB239  A6 65                BNE.B $5B2A0                   ; Conditional branch (byte)
008DB23B  2E FE                BGT.B $5B23B                   ; Conditional branch (byte)
008DB23D  C3 3C                DC.W $C33C                     ; Unknown/data
008DB23F  DB 56                BMI.B $5B297                   ; Conditional branch (byte)
008DB241  75 5C                BCS.B $5B29F                   ; Conditional branch (byte)
008DB243  CD C2                BLT.B $5B207                   ; Conditional branch (byte)
008DB245  DE FD                BGT.B $5B244                   ; Conditional branch (byte)
008DB247  46 65                BNE.B $5B2AE                   ; Conditional branch (byte)
008DB249  5B B5                BMI.B $5B200                   ; Conditional branch (byte)
008DB24B  66 4E                BNE.B $5B29B                   ; Conditional branch (byte)
008DB24D  FE E5                BGT.B $5B234                   ; Conditional branch (byte)
008DB24F  52 BC                DC.W $52BC                     ; Unknown/data
008DB251  55 66                BCS.B $5B2B9                   ; Conditional branch (byte)
008DB253  6B ED                BMI.B $5B242                   ; Conditional branch (byte)
008DB255  DA 9E                BPL.B $5B1F5                   ; Conditional branch (byte)
008DB257  FD A6                BLT.B $5B1FF                   ; Conditional branch (byte)
008DB259  66 5A                BNE.B $5B2B5                   ; Conditional branch (byte)
008DB25B  A2 66                DC.W $A266                     ; Unknown/data
008DB25D  5A FF                BPL.B $5B25E                   ; Conditional branch (byte)
008DB25F  D4 63                BCC.B $5B2C4                   ; Conditional branch (byte)
008DB261  DB 94                BMI.B $5B1F7                   ; Conditional branch (byte)
008DB263  66 6B                BNE.B $5B2D0                   ; Conditional branch (byte)
008DB265  CD ED                BLT.B $5B254                   ; Conditional branch (byte)
008DB267  22 EF                DC.W $22EF                     ; Unknown/data
008DB269  C5 75                BCS.B $5B2E0                   ; Conditional branch (byte)
008DB26B  45 C3                BCS.B $5B230                   ; Conditional branch (byte)
008DB26D  56 65                BNE.B $5B2D4                   ; Conditional branch (byte)
008DB26F  CF FD                BLE.B $5B26E                   ; Conditional branch (byte)
008DB271  45 CD                BCS.B $5B240                   ; Conditional branch (byte)
008DB273  19 66                DC.W $1966                     ; Unknown/data
008DB275  55 AC                BCS.B $5B223                   ; Conditional branch (byte)
008DB277  ED 95                BLT.B $5B20E                   ; Conditional branch (byte)
008DB279  CF EB                BLE.B $5B266                   ; Conditional branch (byte)
008DB27B  66 65                BNE.B $5B2E2                   ; Conditional branch (byte)
008DB27D  53 56                DC.W $5356                     ; Unknown/data
008DB27F  45 2E                BCS.B $5B2AF                   ; Conditional branch (byte)
008DB281  FF B5                BLE.B $5B238                   ; Conditional branch (byte)
008DB283  5D DC                BLT.B $5B261                   ; Conditional branch (byte)
008DB285  36 74                BNE.B $5B2FB                   ; Conditional branch (byte)
008DB287  44 CE                BCC.B $5B257                   ; Conditional branch (byte)
008DB289  E0 4D                DC.W $E04D                     ; Unknown/data
008DB28B  EE 56                BGT.B $5B2E3                   ; Conditional branch (byte)
008DB28D  65 5C                BCS.B $5B2EB                   ; Conditional branch (byte)
008DB28F  A6 65                BNE.B $5B2F6                   ; Conditional branch (byte)
008DB291  C4 EF                BCC.B $5B282                   ; Conditional branch (byte)
008DB293  FD 55                BLT.B $5B2EA                   ; Conditional branch (byte)
008DB295  BC A5                BGE.B $5B23C                   ; Conditional branch (byte)
008DB297  66 6A                BNE.B $5B303                   ; Conditional branch (byte)
008DB299  2C DD                BGE.B $5B278                   ; Conditional branch (byte)
008DB29B  CC ED                BGE.B $5B28A                   ; Conditional branch (byte)
008DB29D  D5 65                BCS.B $5B304                   ; Conditional branch (byte)
008DB29F  64 CC                BCC.B $5B26D                   ; Conditional branch (byte)
008DB2A1  66 39                BNE.B $5B2DC                   ; Conditional branch (byte)
008DB2A3  DE FE                BGT.B $5B2A3                   ; Conditional branch (byte)
008DB2A5  C4 32                BCC.B $5B2D9                   ; Conditional branch (byte)
```

### func_60D9C ($008E0D9C)

**File Offset**: $60D9C
**Size**: 128 bytes
**Complete**: No (may continue)

```asm
008E0D9C  4E 56 DD 53          LINK A6,#$-22AD                ; Create stack frame (8877 bytes local)
008E0DA0  EB 72                BMI.B $60E14                   ; Conditional branch (byte)
008E0DA2  FE 67                BGT.B $60E0B                   ; Conditional branch (byte)
008E0DA4  FF 57                BLE.B $60DFD                   ; Conditional branch (byte)
008E0DA6  CE C6                BGT.B $60D6E                   ; Conditional branch (byte)
008E0DA8  3E 46                BGT.B $60DF0                   ; Conditional branch (byte)
008E0DAA  DE 57                BGT.B $60E03                   ; Conditional branch (byte)
008E0DAC  CE 16                BGT.B $60DC4                   ; Conditional branch (byte)
008E0DAE  3E EC                BGT.B $60D9C                   ; Conditional branch (byte)
008E0DB0  6D EB                BLT.B $60D9D                   ; Conditional branch (byte)
008E0DB2  65 E0                BCS.B $60D94                   ; Conditional branch (byte)
008E0DB4  53 46                DC.W $5346                     ; Unknown/data
008E0DB6  DE 67                BGT.B $60E1F                   ; Conditional branch (byte)
008E0DB8  0F 57                BLE.B $60E11                   ; Conditional branch (byte)
008E0DBA  EF E7                BLE.B $60DA3                   ; Conditional branch (byte)
008E0DBC  EF D7                BLE.B $60D95                   ; Conditional branch (byte)
008E0DBE  9F 57                BLE.B $60E17                   ; Conditional branch (byte)
008E0DC0  6E E7                BGT.B $60DA9                   ; Conditional branch (byte)
008E0DC2  6E E6                BGT.B $60DAA                   ; Conditional branch (byte)
008E0DC4  6D D6                BLT.B $60D9C                   ; Conditional branch (byte)
008E0DC6  6E F5                BGT.B $60DBD                   ; Conditional branch (byte)
008E0DC8  6D FD                BLT.B $60DC7                   ; Conditional branch (byte)
008E0DCA  6C ED                BGE.B $60DB9                   ; Conditional branch (byte)
008E0DCC  4B 26                BMI.B $60DF4                   ; Conditional branch (byte)
008E0DCE  5D 47                BLT.B $60E17                   ; Conditional branch (byte)
008E0DD0  6C A6                BGE.B $60D78                   ; Conditional branch (byte)
008E0DD2  3D ED                BLT.B $60DC1                   ; Conditional branch (byte)
008E0DD4  3E F5                BGT.B $60DCB                   ; Conditional branch (byte)
008E0DD6  4D E6                BLT.B $60DBE                   ; Conditional branch (byte)
008E0DD8  7E F7                BGT.B $60DD1                   ; Conditional branch (byte)
008E0DDA  75 F5                BCS.B $60DD1                   ; Conditional branch (byte)
008E0DDC  74 ED                BCC.B $60DCB                   ; Conditional branch (byte)
008E0DDE  5D F3                BLT.B $60DD3                   ; Conditional branch (byte)
008E0DE0  3D D4                BLT.B $60DB6                   ; Conditional branch (byte)
008E0DE2  7C E5                BGE.B $60DC9                   ; Conditional branch (byte)
008E0DE4  50 DD                DC.W $50DD                     ; Unknown/data
008E0DE6  5B C4                BMI.B $60DAC                   ; Conditional branch (byte)
008E0DE8  6B E5                BMI.B $60DCF                   ; Conditional branch (byte)
008E0DEA  7D FD                BLT.B $60DE9                   ; Conditional branch (byte)
008E0DEC  75 FD                BCS.B $60DEB                   ; Conditional branch (byte)
008E0DEE  66 ED                BNE.B $60DDD                   ; Conditional branch (byte)
008E0DF0  64 F0                BCC.B $60DE2                   ; Conditional branch (byte)
008E0DF2  72 F0                MOVEQ #$F0,D1                  ; Quick move immediate (-16)
008E0DF4  76 DB                BNE.B $60DD1                   ; Conditional branch (byte)
008E0DF6  54 DE                BCC.B $60DD6                   ; Conditional branch (byte)
008E0DF8  CC DE                BGE.B $60DD8                   ; Conditional branch (byte)
008E0DFA  55 DD                BCS.B $60DD9                   ; Conditional branch (byte)
008E0DFC  45 AD                BCS.B $60DAB                   ; Conditional branch (byte)
008E0DFE  45 C9                BCS.B $60DC9                   ; Conditional branch (byte)
008E0E00  66 ED                BNE.B $60DEF                   ; Conditional branch (byte)
008E0E02  76 FF                BNE.B $60E03                   ; Conditional branch (byte)
008E0E04  77 FF                BEQ.B $60E05                   ; Conditional branch (byte)
008E0E06  57 CF                BEQ.B $60DD7                   ; Conditional branch (byte)
008E0E08  57 EF                BEQ.B $60DF9                   ; Conditional branch (byte)
008E0E0A  57 DF                BEQ.B $60DEB                   ; Conditional branch (byte)
008E0E0C  67 6F                BEQ.B $60E7D                   ; Conditional branch (byte)
008E0E0E  A6 6F                BNE.B $60E7F                   ; Conditional branch (byte)
008E0E10  E5 5D                BCS.B $60E6F                   ; Conditional branch (byte)
008E0E12  E5 5E                BCS.B $60E72                   ; Conditional branch (byte)
008E0E14  C5 5E                BCS.B $60E74                   ; Conditional branch (byte)
008E0E16  D6 6C                BNE.B $60E84                   ; Conditional branch (byte)
008E0E18  C7 6D                BEQ.B $60E87                   ; Conditional branch (byte)
008E0E1A  B5 4E                BCS.B $60E6A                   ; Conditional branch (byte)
```


## Summary Statistics

**Total Code Size**: 1980 bytes
**Unique JSR Targets**: 3
**Unique BSR Targets**: 10

### JSR Target Summary
- $008814BE: 1 call(s)
- $008826C8: 1 call(s)
- $008849AA: 1 call(s)
