Disassembling from offset 0x000838 (60 instructions)
================================================================================
00880838  49F9 00A1 5100       LEA     $00A15100,A4
0088083E  082C 0000            BTST    #0,-(A5)
00880842  0001 6720            BTST    #32,A0
00880846  082C 0001            BTST    #1,-(A5)
0088084A  0001 665A            BTST    #90,A0
0088084E  4BF9 00A1 0000       LEA     $00A10000,A5
00880854  287C                 MOVE.L  -(A7),A4
00880856  FFFF                 DC.W    $FFFF  ; Unknown
00880858  FFC0                 DC.W    $FFC0  ; Unknown
0088085A  3E3C                 MOVE.W  -(A7),D7
0088085C  0F3C                 BTST    D7,-(A7)
0088085E  43F9 0088 06E4       LEA     $008806E4,A1
00880864  4ED1                 JMP     (A1)
00880866  23FC 0000 0000       MOVE.L  -(A7),$00000000
0088086C  00A1 5128            BCLR    #40,A4
00880870  41F9 0088 0894       LEA     $00880894,A0
00880876  43F9 00FF 0000       LEA     $00FF0000,A1
0088087C  22D8                 MOVE.L  D3,(A1)+
0088087E  22D8                 MOVE.L  D3,(A1)+
00880880  22D8                 MOVE.L  D3,(A1)+
00880882  22D8                 MOVE.L  D3,(A1)+
00880884  22D8                 MOVE.L  D3,(A1)+
00880886  22D8                 MOVE.L  D3,(A1)+
00880888  22D8                 MOVE.L  D3,(A1)+
0088088A  22D8                 MOVE.L  D3,(A1)+
0088088C  41F9 00FF 0000       LEA     $00FF0000,A0
00880892  4ED0                 JMP     (A0)
00880894  197C 0001            MOVE.B  -(A7),$0001(A4)
00880898  0001 41F9            BTST    #249,A0
0088089C  0088 084E            BCLR    #78,D1
008808A0  D1FC                 DC.W    $D1FC  ; Unknown
008808A2  0088 0000            BCLR    #0,D1
008808A6  4ED0                 JMP     (A0)
008808A8  3E3C                 MOVE.W  -(A7),D7
008808AA  1000                 MOVE.B  D0,D0
008808AC  0CB9 5652            BCLR    #82,A7
008808B0  4553                 DC.W    $4553  ; Unknown
008808B2  00A1 512C            BCLR    #44,A4
008808B6  57CF FFF4            DBEQ    D7,$008808AC
008808BA  6700 00FA            BEQ     $008809B6
008808BE  4EBA                 DC.W    $4EBA  ; Unknown
008808C0  1D7E 0039            MOVE.B  <EA:3E>,$0039(A6)
008808C4  0003 00A1            BTST    #161,(A0)+
008808C8  5103                 DC.W    $5103  ; Unknown
008808CA  41F9 00A1 5120       LEA     $00A15120,A0
008808D0  0C90 4D5F            BCLR    #95,D2
008808D4  4F4B                 DC.W    $4F4B  ; Unknown
008808D6  66F8                 BNE     $008808D0
008808D8  0CA8 535F            BCLR    #95,D5
008808DC  4F4B                 DC.W    $4F4B  ; Unknown
008808DE  0004 66F6            BTST    #246,-(A0)
008808E2  20BC                 MOVE.L  -(A7),(A0)
008808E4  0000 0000            BTST    #0,D0
008808E8  40E7                 DC.W    $40E7  ; Unknown
008808EA  46FC                 DC.W    $46FC  ; Unknown
008808EC  2700                 MOVE.L  D0,-(A3)
008808EE  33FC 0100 00A1       MOVE.W  -(A7),$010000A1
008808F4  1100                 MOVE.B  D0,-(A0)
008808F6  33FC 0100 00A1       MOVE.W  -(A7),$010000A1
008808FC  1200                 MOVE.B  D0,D1

================================================================================
Code References Found:
  008808D0 (file offset: 0x0008D0)
  008809B6 (file offset: 0x0009B6)
