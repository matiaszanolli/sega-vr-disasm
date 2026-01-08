; ============================================================================
; Code Section ($1000-$1FFF)
; ============================================================================
; Contains various game code and utility functions.
; ============================================================================

        org     $001000

Code_1000:
        dc.w    $66F6                    ; 00881000: BNE.S $00880FF8
        dc.w    $4EBA                    ; 00881002: dc.w $4EBA
        dc.w    $08D4                    ; 00881004: dc.w $08D4
        dc.w    $33FC                    ; 00881006: dc.w $33FC
        dc.w    $0000                    ; 00881008: dc.w $0000
        dc.w    $00A1                    ; 0088100A: dc.w $00A1
        dc.w    $1100                    ; 0088100C: dc.w $1100
        dc.w    $46DF                    ; 0088100E: dc.w $46DF
        dc.w    $41FA                    ; 00881010: dc.w $41FA
        dc.w    $0022                    ; 00881012: dc.w $0022
        dc.w    $11FC                    ; 00881014: dc.w $11FC
        dc.w    $0081                    ; 00881016: dc.w $0081
        dc.w    $C874                    ; 00881018: dc.w $C874
        dc.w    $11E8                    ; 0088101A: dc.w $11E8
        dc.w    $0001                    ; 0088101C: dc.w $0001
        dc.w    $C875                    ; 0088101E: dc.w $C875
        dc.w    $303C                    ; 00881020: dc.w $303C
        dc.w    $8000                    ; 00881022: dc.w $8000
        dc.w    $7E12                    ; 00881024: MOVEQ #$12,D7
        dc.w    $1018                    ; 00881026: dc.w $1018
        dc.w    $3A80                    ; 00881028: dc.w $3A80
        dc.w    $0640                    ; 0088102A: dc.w $0640
        dc.w    $0100                    ; 0088102C: dc.w $0100
        dc.w    $51CF, $FFF6            ; 0088102E: DBRA D7,$00881026
        dc.w    $4E75                    ; 00881032: RTS
        dc.w    $0424                    ; 00881034: dc.w $0424
        dc.w    $283C                    ; 00881036: dc.w $283C
        dc.w    $0679                    ; 00881038: dc.w $0679
        dc.w    $0000                    ; 0088103A: dc.w $0000
        dc.w    $0000                    ; 0088103C: dc.w $0000
        dc.w    $0700                    ; 0088103E: dc.w $0700
        dc.w    $813B                    ; 00881040: dc.w $813B
        dc.w    $0002                    ; 00881042: dc.w $0002
        dc.w    $0300                    ; 00881044: dc.w $0300
        dc.w    $0000                    ; 00881046: dc.w $0000
        dc.w    $40E7                    ; 00881048: dc.w $40E7
        dc.w    $46FC, $2700            ; 0088104A: MOVE.W #$2700,SR
        dc.w    $33FC                    ; 0088104E: dc.w $33FC
        dc.w    $0100                    ; 00881050: dc.w $0100
        dc.w    $00A1                    ; 00881052: dc.w $00A1
        dc.w    $1100                    ; 00881054: dc.w $1100
        dc.w    $0839                    ; 00881056: dc.w $0839
        dc.w    $0000                    ; 00881058: dc.w $0000
        dc.w    $00A1                    ; 0088105A: dc.w $00A1
        dc.w    $1100                    ; 0088105C: dc.w $1100
        dc.w    $66F6                    ; 0088105E: BNE.S $00881056
        dc.w    $3838                    ; 00881060: dc.w $3838
        dc.w    $C874                    ; 00881062: dc.w $C874
        dc.w    $08C4                    ; 00881064: dc.w $08C4
        dc.w    $0004                    ; 00881066: dc.w $0004
        dc.w    $3A84                    ; 00881068: dc.w $3A84
        dc.w    $3ABC                    ; 0088106A: dc.w $3ABC
        dc.w    $8F01                    ; 0088106C: dc.w $8F01
        dc.w    $2ABC                    ; 0088106E: dc.w $2ABC
        dc.w    $93FF                    ; 00881070: dc.w $93FF
        dc.w    $94FF                    ; 00881072: dc.w $94FF
        dc.w    $3ABC                    ; 00881074: dc.w $3ABC
        dc.w    $9780                    ; 00881076: dc.w $9780
        dc.w    $2ABC                    ; 00881078: dc.w $2ABC
        dc.w    $4000                    ; 0088107A: dc.w $4000
        dc.w    $0080                    ; 0088107C: dc.w $0080
        dc.w    $3CBC                    ; 0088107E: dc.w $3CBC
        dc.w    $0000                    ; 00881080: dc.w $0000
        dc.w    $3E15                    ; 00881082: dc.w $3E15
        dc.w    $0247                    ; 00881084: dc.w $0247
        dc.w    $0002                    ; 00881086: dc.w $0002
        dc.w    $66F8                    ; 00881088: BNE.S $00881082
        dc.w    $3ABC                    ; 0088108A: dc.w $3ABC
        dc.w    $8F02                    ; 0088108C: dc.w $8F02
        dc.w    $3AB8                    ; 0088108E: dc.w $3AB8
        dc.w    $C874                    ; 00881090: dc.w $C874
        dc.w    $33FC                    ; 00881092: dc.w $33FC
        dc.w    $0000                    ; 00881094: dc.w $0000
        dc.w    $00A1                    ; 00881096: dc.w $00A1
        dc.w    $1100                    ; 00881098: dc.w $1100
        dc.w    $46DF                    ; 0088109A: dc.w $46DF
        dc.w    $4EBA                    ; 0088109C: dc.w $4EBA
        dc.w    $000E                    ; 0088109E: dc.w $000E
        dc.w    $2ABC                    ; 008810A0: dc.w $2ABC
        dc.w    $4000                    ; 008810A2: dc.w $4000
        dc.w    $0010                    ; 008810A4: dc.w $0010
        dc.w    $7200                    ; 008810A6: MOVEQ #$00,D1
        dc.w    $4EFA                    ; 008810A8: dc.w $4EFA
        dc.w    $37FE                    ; 008810AA: dc.w $37FE
        dc.w    $2ABC                    ; 008810AC: dc.w $2ABC
        dc.w    $C000                    ; 008810AE: dc.w $C000
        dc.w    $0000                    ; 008810B0: dc.w $0000
        dc.w    $7200                    ; 008810B2: MOVEQ #$00,D1
        dc.w    $4EFA                    ; 008810B4: dc.w $4EFA
        dc.w    $37D2                    ; 008810B6: dc.w $37D2
        dc.w    $7200                    ; 008810B8: MOVEQ #$00,D1
        dc.w    $2ABC                    ; 008810BA: dc.w $2ABC
        dc.w    $7200                    ; 008810BC: MOVEQ #$00,D1
        dc.w    $0003                    ; 008810BE: dc.w $0003
        dc.w    $2C81                    ; 008810C0: dc.w $2C81
        dc.w    $4E75                    ; 008810C2: RTS
        dc.w    $283C                    ; 008810C4: dc.w $283C
        dc.w    $0100                    ; 008810C6: dc.w $0100
        dc.w    $0000                    ; 008810C8: dc.w $0000
        dc.w    $2A80                    ; 008810CA: dc.w $2A80
        dc.w    $3601                    ; 008810CC: dc.w $3601
        dc.w    $3C98                    ; 008810CE: dc.w $3C98
        dc.w    $51CB, $FFFC            ; 008810D0: DBRA D3,$008810CE
        dc.w    $D084                    ; 008810D4: dc.w $D084
        dc.w    $51CA, $FFF2            ; 008810D6: DBRA D2,$008810CA
        dc.w    $4E75                    ; 008810DA: RTS
        dc.w    $283C                    ; 008810DC: dc.w $283C
        dc.w    $0100                    ; 008810DE: dc.w $0100
        dc.w    $0000                    ; 008810E0: dc.w $0000
        dc.w    $2A80                    ; 008810E2: dc.w $2A80
        dc.w    $3A01                    ; 008810E4: dc.w $3A01
        dc.w    $3C83                    ; 008810E6: dc.w $3C83
        dc.w    $51CD, $FFFC            ; 008810E8: DBRA D5,$008810E6
        dc.w    $D084                    ; 008810EC: dc.w $D084
        dc.w    $51CA, $FFF2            ; 008810EE: DBRA D2,$008810E2
        dc.w    $4E75                    ; 008810F2: RTS
        dc.w    $48E7, $FFDC            ; 008810F4: MOVEM.L regs,-(SP)
        dc.w    $47F9, $0088, $11B8    ; 008810F8: LEA $008811B8,A3
        dc.w    $49F9, $00C0, $0000    ; 008810FE: LEA $00C00000,A4
        dc.w    $600A                    ; 00881104: BRA.S $00881110
        dc.w    $48E7, $FFDC            ; 00881106: MOVEM.L regs,-(SP)
        dc.w    $47F9, $0088, $11CE    ; 0088110A: LEA $008811CE,A3
        dc.w    $43F9, $00FF, $7E00    ; 00881110: LEA $00FF7E00,A1
        dc.w    $3418                    ; 00881116: dc.w $3418
        dc.w    $E34A                    ; 00881118: dc.w $E34A
        dc.w    $6404                    ; 0088111A: BCC.S $00881120
        dc.w    $D6FC                    ; 0088111C: dc.w $D6FC
        dc.w    $000A                    ; 0088111E: dc.w $000A
        dc.w    $E54A                    ; 00881120: dc.w $E54A
        dc.w    $3A42                    ; 00881122: dc.w $3A42
        dc.w    $7608                    ; 00881124: MOVEQ #$08,D3
        dc.w    $7400                    ; 00881126: MOVEQ #$00,D2
        dc.w    $7800                    ; 00881128: MOVEQ #$00,D4
        dc.w    $6100, $00B8            ; 0088112A: BSR.W $008811E4
        dc.w    $1A18                    ; 0088112E: dc.w $1A18
        dc.w    $E145                    ; 00881130: dc.w $E145
        dc.w    $1A18                    ; 00881132: dc.w $1A18
        dc.w    $3C3C                    ; 00881134: dc.w $3C3C
        dc.w    $0010                    ; 00881136: dc.w $0010
        dc.w    $6106                    ; 00881138: BSR.S $00881140
        dc.w    $4CDF, $3BFF            ; 0088113A: MOVEM.L (SP)+,regs
        dc.w    $4E75                    ; 0088113E: RTS

; --- RLE/bit-packed decompressor ---
RLEDecompressor:
        dc.w    $3E06                    ; 00881140: dc.w $3E06
        dc.w    $5147                    ; 00881142: dc.w $5147
        dc.w    $3205                    ; 00881144: dc.w $3205
        dc.w    $EE69                    ; 00881146: dc.w $EE69
        dc.w    $0C01                    ; 00881148: dc.w $0C01
        dc.w    $00FC                    ; 0088114A: dc.w $00FC
        dc.w    $643E                    ; 0088114C: BCC.S $0088118C
        dc.w    $0241                    ; 0088114E: dc.w $0241
        dc.w    $00FF                    ; 00881150: dc.w $00FF
        dc.w    $D241                    ; 00881152: dc.w $D241
        dc.w    $1031                    ; 00881154: dc.w $1031
        dc.w    $1000                    ; 00881156: dc.w $1000
        dc.w    $4880                    ; 00881158: dc.w $4880
        dc.w    $9C40                    ; 0088115A: dc.w $9C40
        dc.w    $0C46                    ; 0088115C: dc.w $0C46
        dc.w    $0009                    ; 0088115E: dc.w $0009
        dc.w    $6406                    ; 00881160: BCC.S $00881168
        dc.w    $5046                    ; 00881162: dc.w $5046
        dc.w    $E145                    ; 00881164: dc.w $E145
        dc.w    $1A18                    ; 00881166: dc.w $1A18
        dc.w    $1231                    ; 00881168: dc.w $1231
        dc.w    $1001                    ; 0088116A: dc.w $1001
        dc.w    $3001                    ; 0088116C: dc.w $3001
        dc.w    $0241                    ; 0088116E: dc.w $0241
        dc.w    $000F                    ; 00881170: dc.w $000F
        dc.w    $0240                    ; 00881172: dc.w $0240
        dc.w    $00F0                    ; 00881174: dc.w $00F0
        dc.w    $E848                    ; 00881176: dc.w $E848
        dc.w    $E98C                    ; 00881178: dc.w $E98C
        dc.w    $8801                    ; 0088117A: dc.w $8801
        dc.w    $5343                    ; 0088117C: dc.w $5343
        dc.w    $6606                    ; 0088117E: BNE.S $00881186
        dc.w    $4ED3                    ; 00881180: JMP (A3)
        dc.w    $7800                    ; 00881182: MOVEQ #$00,D4
        dc.w    $7608                    ; 00881184: MOVEQ #$08,D3
        dc.w    $51C8, $FFF0            ; 00881186: DBRA D0,$00881178
        dc.w    $60B4                    ; 0088118A: BRA.S $00881140
        dc.w    $5D46                    ; 0088118C: dc.w $5D46
        dc.w    $0C46                    ; 0088118E: dc.w $0C46
        dc.w    $0009                    ; 00881190: dc.w $0009
        dc.w    $6406                    ; 00881192: BCC.S $0088119A
        dc.w    $5046                    ; 00881194: dc.w $5046
        dc.w    $E145                    ; 00881196: dc.w $E145
        dc.w    $1A18                    ; 00881198: dc.w $1A18
        dc.w    $5F46                    ; 0088119A: dc.w $5F46
        dc.w    $3205                    ; 0088119C: dc.w $3205
        dc.w    $EC69                    ; 0088119E: dc.w $EC69
        dc.w    $3001                    ; 008811A0: dc.w $3001
        dc.w    $0241                    ; 008811A2: dc.w $0241
        dc.w    $000F                    ; 008811A4: dc.w $000F
        dc.w    $0240                    ; 008811A6: dc.w $0240
        dc.w    $0070                    ; 008811A8: dc.w $0070
        dc.w    $0C46                    ; 008811AA: dc.w $0C46
        dc.w    $0009                    ; 008811AC: dc.w $0009
        dc.w    $64C6                    ; 008811AE: BCC.S $00881176
        dc.w    $5046                    ; 008811B0: dc.w $5046
        dc.w    $E145                    ; 008811B2: dc.w $E145
        dc.w    $1A18                    ; 008811B4: dc.w $1A18
        dc.w    $60BE                    ; 008811B6: BRA.S $00881176
        dc.w    $2884                    ; 008811B8: dc.w $2884
        dc.w    $534D                    ; 008811BA: dc.w $534D
        dc.w    $380D                    ; 008811BC: dc.w $380D
        dc.w    $66C2                    ; 008811BE: BNE.S $00881182
        dc.w    $4E75                    ; 008811C0: RTS
        dc.w    $B982                    ; 008811C2: dc.w $B982
        dc.w    $2882                    ; 008811C4: dc.w $2882
        dc.w    $534D                    ; 008811C6: dc.w $534D
        dc.w    $380D                    ; 008811C8: dc.w $380D
        dc.w    $66B6                    ; 008811CA: BNE.S $00881182
        dc.w    $4E75                    ; 008811CC: RTS
        dc.w    $28C4                    ; 008811CE: dc.w $28C4
        dc.w    $534D                    ; 008811D0: dc.w $534D
        dc.w    $380D                    ; 008811D2: dc.w $380D
        dc.w    $66AC                    ; 008811D4: BNE.S $00881182
        dc.w    $4E75                    ; 008811D6: RTS
        dc.w    $B982                    ; 008811D8: dc.w $B982
        dc.w    $28C2                    ; 008811DA: dc.w $28C2
        dc.w    $534D                    ; 008811DC: dc.w $534D
        dc.w    $380D                    ; 008811DE: dc.w $380D
        dc.w    $66A0                    ; 008811E0: BNE.S $00881182
        dc.w    $4E75                    ; 008811E2: RTS

; --- Byte stream with $FF term ---
ByteStreamDecoder:
        dc.w    $1018                    ; 008811E4: dc.w $1018
        dc.w    $0C00                    ; 008811E6: dc.w $0C00
        dc.w    $00FF                    ; 008811E8: dc.w $00FF
        dc.w    $6602                    ; 008811EA: BNE.S $008811EE
        dc.w    $4E75                    ; 008811EC: RTS
        dc.w    $3E00                    ; 008811EE: dc.w $3E00
        dc.w    $1018                    ; 008811F0: dc.w $1018
        dc.w    $0C00                    ; 008811F2: dc.w $0C00
        dc.w    $0080                    ; 008811F4: dc.w $0080
        dc.w    $64EE                    ; 008811F6: BCC.S $008811E6
        dc.w    $1200                    ; 008811F8: dc.w $1200
        dc.w    $0247                    ; 008811FA: dc.w $0247
        dc.w    $000F                    ; 008811FC: dc.w $000F
        dc.w    $0241                    ; 008811FE: dc.w $0241
        dc.w    $0070                    ; 00881200: dc.w $0070
        dc.w    $8E41                    ; 00881202: dc.w $8E41
        dc.w    $0240                    ; 00881204: dc.w $0240
        dc.w    $000F                    ; 00881206: dc.w $000F
        dc.w    $1200                    ; 00881208: dc.w $1200
        dc.w    $E149                    ; 0088120A: dc.w $E149
        dc.w    $8E41                    ; 0088120C: dc.w $8E41
        dc.w    $7208                    ; 0088120E: MOVEQ #$08,D1
        dc.w    $9240                    ; 00881210: dc.w $9240
        dc.w    $660A                    ; 00881212: BNE.S $0088121E
        dc.w    $1018                    ; 00881214: dc.w $1018
        dc.w    $D040                    ; 00881216: dc.w $D040
        dc.w    $3387                    ; 00881218: dc.w $3387
        dc.w    $0000                    ; 0088121A: dc.w $0000
        dc.w    $60D2                    ; 0088121C: BRA.S $008811F0
        dc.w    $1018                    ; 0088121E: dc.w $1018
        dc.w    $E368                    ; 00881220: dc.w $E368
        dc.w    $D040                    ; 00881222: dc.w $D040
        dc.w    $7A01                    ; 00881224: MOVEQ #$01,D5
        dc.w    $E36D                    ; 00881226: dc.w $E36D
        dc.w    $5345                    ; 00881228: dc.w $5345
        dc.w    $3387                    ; 0088122A: dc.w $3387
        dc.w    $0000                    ; 0088122C: dc.w $0000
        dc.w    $5440                    ; 0088122E: dc.w $5440
        dc.w    $51CD, $FFF8            ; 00881230: DBRA D5,$0088122A
        dc.w    $60BA                    ; 00881234: BRA.S $008811F0
        dc.w    $48E7, $FF7C            ; 00881236: MOVEM.L regs,-(SP)
        dc.w    $3640                    ; 0088123A: dc.w $3640
        dc.w    $1018                    ; 0088123C: dc.w $1018
        dc.w    $4880                    ; 0088123E: dc.w $4880
        dc.w    $3A40                    ; 00881240: dc.w $3A40
        dc.w    $1818                    ; 00881242: dc.w $1818
        dc.w    $E70C                    ; 00881244: dc.w $E70C
        dc.w    $3458                    ; 00881246: dc.w $3458
        dc.w    $D4CB                    ; 00881248: dc.w $D4CB
        dc.w    $3858                    ; 0088124A: dc.w $3858
        dc.w    $D8CB                    ; 0088124C: dc.w $D8CB
        dc.w    $1A18                    ; 0088124E: dc.w $1A18
        dc.w    $E145                    ; 00881250: dc.w $E145
        dc.w    $1A18                    ; 00881252: dc.w $1A18
        dc.w    $7C10                    ; 00881254: MOVEQ #$10,D6
        dc.w    $7007                    ; 00881256: MOVEQ #$07,D0
        dc.w    $3E06                    ; 00881258: dc.w $3E06
        dc.w    $9E40                    ; 0088125A: dc.w $9E40
        dc.w    $3205                    ; 0088125C: dc.w $3205
        dc.w    $EE69                    ; 0088125E: dc.w $EE69
        dc.w    $0241                    ; 00881260: dc.w $0241
        dc.w    $007F                    ; 00881262: dc.w $007F
        dc.w    $3401                    ; 00881264: dc.w $3401
        dc.w    $0C41                    ; 00881266: dc.w $0C41
        dc.w    $0040                    ; 00881268: dc.w $0040
        dc.w    $6404                    ; 0088126A: BCC.S $00881270
        dc.w    $7006                    ; 0088126C: MOVEQ #$06,D0
        dc.w    $E24A                    ; 0088126E: dc.w $E24A
        dc.w    $6100, $0132            ; 00881270: BSR.W $008813A4
        dc.w    $0242                    ; 00881274: dc.w $0242
        dc.w    $000F                    ; 00881276: dc.w $000F
        dc.w    $E849                    ; 00881278: dc.w $E849
        dc.w    $D241                    ; 0088127A: dc.w $D241
        dc.w    $4EFB                    ; 0088127C: dc.w $4EFB
        dc.w    $104E                    ; 0088127E: dc.w $104E
        dc.w    $32CA                    ; 00881280: dc.w $32CA
        dc.w    $524A                    ; 00881282: dc.w $524A
        dc.w    $51CA, $FFFA            ; 00881284: DBRA D2,$00881280
        dc.w    $60CC                    ; 00881288: BRA.S $00881256
        dc.w    $32CC                    ; 0088128A: dc.w $32CC
        dc.w    $51CA, $FFFC            ; 0088128C: DBRA D2,$0088128A
        dc.w    $60C4                    ; 00881290: BRA.S $00881256
        dc.w    $6100, $0060            ; 00881292: BSR.W $008812F4
        dc.w    $32C1                    ; 00881296: dc.w $32C1
        dc.w    $51CA, $FFFC            ; 00881298: DBRA D2,$00881296
        dc.w    $60B8                    ; 0088129C: BRA.S $00881256
        dc.w    $6100, $0054            ; 0088129E: BSR.W $008812F4
        dc.w    $32C1                    ; 008812A2: dc.w $32C1
        dc.w    $5241                    ; 008812A4: dc.w $5241
        dc.w    $51CA, $FFFA            ; 008812A6: DBRA D2,$008812A2
        dc.w    $60AA                    ; 008812AA: BRA.S $00881256
        dc.w    $6100, $0046            ; 008812AC: BSR.W $008812F4
        dc.w    $32C1                    ; 008812B0: dc.w $32C1
        dc.w    $5341                    ; 008812B2: dc.w $5341
        dc.w    $51CA, $FFFA            ; 008812B4: DBRA D2,$008812B0
        dc.w    $609C                    ; 008812B8: BRA.S $00881256
        dc.w    $0C42                    ; 008812BA: dc.w $0C42
        dc.w    $000F                    ; 008812BC: dc.w $000F
        dc.w    $671C                    ; 008812BE: BEQ.S $008812DC
        dc.w    $6100, $0032            ; 008812C0: BSR.W $008812F4
        dc.w    $32C1                    ; 008812C4: dc.w $32C1
        dc.w    $51CA, $FFF8            ; 008812C6: DBRA D2,$008812C0
        dc.w    $608A                    ; 008812CA: BRA.S $00881256
        dc.w    $60B2                    ; 008812CC: BRA.S $00881280
        dc.w    $60B0                    ; 008812CE: BRA.S $00881280
        dc.w    $60B8                    ; 008812D0: BRA.S $0088128A
        dc.w    $60B6                    ; 008812D2: BRA.S $0088128A
        dc.w    $60BC                    ; 008812D4: BRA.S $00881292
        dc.w    $60C6                    ; 008812D6: BRA.S $0088129E
        dc.w    $60D2                    ; 008812D8: BRA.S $008812AC
        dc.w    $60DE                    ; 008812DA: BRA.S $008812BA
        dc.w    $5348                    ; 008812DC: dc.w $5348
        dc.w    $0C46                    ; 008812DE: dc.w $0C46
        dc.w    $0010                    ; 008812E0: dc.w $0010
        dc.w    $6602                    ; 008812E2: BNE.S $008812E6
        dc.w    $5348                    ; 008812E4: dc.w $5348
        dc.w    $3008                    ; 008812E6: dc.w $3008
        dc.w    $E248                    ; 008812E8: dc.w $E248
        dc.w    $6402                    ; 008812EA: BCC.S $008812EE
        dc.w    $5248                    ; 008812EC: dc.w $5248
        dc.w    $4CDF, $3EFF            ; 008812EE: MOVEM.L (SP)+,regs
        dc.w    $4E75                    ; 008812F2: RTS

; --- Bit field with bitmask table ---
BitFieldExtractor:
        dc.w    $360B                    ; 008812F4: dc.w $360B
        dc.w    $1204                    ; 008812F6: dc.w $1204
        dc.w    $D201                    ; 008812F8: dc.w $D201
        dc.w    $640A                    ; 008812FA: BCC.S $00881306
        dc.w    $5346                    ; 008812FC: dc.w $5346
        dc.w    $0D05                    ; 008812FE: dc.w $0D05
        dc.w    $6704                    ; 00881300: BEQ.S $00881306
        dc.w    $0043                    ; 00881302: dc.w $0043
        dc.w    $8000                    ; 00881304: dc.w $8000
        dc.w    $D201                    ; 00881306: dc.w $D201
        dc.w    $640A                    ; 00881308: BCC.S $00881314
        dc.w    $5346                    ; 0088130A: dc.w $5346
        dc.w    $0D05                    ; 0088130C: dc.w $0D05
        dc.w    $6704                    ; 0088130E: BEQ.S $00881314
        dc.w    $0643                    ; 00881310: dc.w $0643
        dc.w    $4000                    ; 00881312: dc.w $4000
        dc.w    $D201                    ; 00881314: dc.w $D201
        dc.w    $640A                    ; 00881316: BCC.S $00881322
        dc.w    $5346                    ; 00881318: dc.w $5346
        dc.w    $0D05                    ; 0088131A: dc.w $0D05
        dc.w    $6704                    ; 0088131C: BEQ.S $00881322
        dc.w    $0643                    ; 0088131E: dc.w $0643
        dc.w    $2000                    ; 00881320: dc.w $2000
        dc.w    $D201                    ; 00881322: dc.w $D201
        dc.w    $640A                    ; 00881324: BCC.S $00881330
        dc.w    $5346                    ; 00881326: dc.w $5346
        dc.w    $0D05                    ; 00881328: dc.w $0D05
        dc.w    $6704                    ; 0088132A: BEQ.S $00881330
        dc.w    $0043                    ; 0088132C: dc.w $0043
        dc.w    $1000                    ; 0088132E: dc.w $1000
        dc.w    $D201                    ; 00881330: dc.w $D201
        dc.w    $640A                    ; 00881332: BCC.S $0088133E
        dc.w    $5346                    ; 00881334: dc.w $5346
        dc.w    $0D05                    ; 00881336: dc.w $0D05
        dc.w    $6704                    ; 00881338: BEQ.S $0088133E
        dc.w    $0043                    ; 0088133A: dc.w $0043
        dc.w    $0800                    ; 0088133C: dc.w $0800
        dc.w    $3205                    ; 0088133E: dc.w $3205
        dc.w    $3E06                    ; 00881340: dc.w $3E06
        dc.w    $9E4D                    ; 00881342: dc.w $9E4D
        dc.w    $6428                    ; 00881344: BCC.S $0088136E
        dc.w    $3C07                    ; 00881346: dc.w $3C07
        dc.w    $0646                    ; 00881348: dc.w $0646
        dc.w    $0010                    ; 0088134A: dc.w $0010
        dc.w    $4447                    ; 0088134C: dc.w $4447
        dc.w    $EF69                    ; 0088134E: dc.w $EF69
        dc.w    $1A10                    ; 00881350: dc.w $1A10
        dc.w    $EF3D                    ; 00881352: dc.w $EF3D
        dc.w    $DE47                    ; 00881354: dc.w $DE47
        dc.w    $CA7B                    ; 00881356: dc.w $CA7B
        dc.w    $702A                    ; 00881358: MOVEQ #$2A,D0
        dc.w    $D245                    ; 0088135A: dc.w $D245
        dc.w    $300D                    ; 0088135C: dc.w $300D
        dc.w    $D040                    ; 0088135E: dc.w $D040
        dc.w    $C27B                    ; 00881360: dc.w $C27B
        dc.w    $0020                    ; 00881362: dc.w $0020
        dc.w    $D243                    ; 00881364: dc.w $D243
        dc.w    $1A18                    ; 00881366: dc.w $1A18
        dc.w    $E14D                    ; 00881368: dc.w $E14D
        dc.w    $1A18                    ; 0088136A: dc.w $1A18
        dc.w    $4E75                    ; 0088136C: RTS
        dc.w    $6710                    ; 0088136E: BEQ.S $00881380
        dc.w    $EE69                    ; 00881370: dc.w $EE69
        dc.w    $300D                    ; 00881372: dc.w $300D
        dc.w    $D040                    ; 00881374: dc.w $D040
        dc.w    $C27B                    ; 00881376: dc.w $C27B
        dc.w    $000A                    ; 00881378: dc.w $000A
        dc.w    $D243                    ; 0088137A: dc.w $D243
        dc.w    $300D                    ; 0088137C: dc.w $300D
        dc.w    $6024                    ; 0088137E: BRA.S $008813A4
        dc.w    $7C10                    ; 00881380: MOVEQ #$10,D6
        dc.w    $60D8                    ; 00881382: BRA.S $0088135C
        dc.w    $0001                    ; 00881384: dc.w $0001
        dc.w    $0003                    ; 00881386: dc.w $0003
        dc.w    $0007                    ; 00881388: dc.w $0007
        dc.w    $000F                    ; 0088138A: dc.w $000F
        dc.w    $001F                    ; 0088138C: dc.w $001F
        dc.w    $003F                    ; 0088138E: dc.w $003F
        dc.w    $007F                    ; 00881390: dc.w $007F
        dc.w    $00FF                    ; 00881392: dc.w $00FF
        dc.w    $01FF                    ; 00881394: dc.w $01FF
        dc.w    $03FF                    ; 00881396: dc.w $03FF
        dc.w    $07FF                    ; 00881398: dc.w $07FF
        dc.w    $0FFF                    ; 0088139A: dc.w $0FFF
        dc.w    $1FFF                    ; 0088139C: dc.w $1FFF
        dc.w    $3FFF                    ; 0088139E: dc.w $3FFF
        dc.w    $7FFF                    ; 008813A0: dc.w $7FFF
        dc.w    $FFFF                    ; 008813A2: dc.w $FFFF

; --- Bit buffer helper ---
BitBufferRefill:
        dc.w    $9C40                    ; 008813A4: dc.w $9C40
        dc.w    $0C46                    ; 008813A6: dc.w $0C46
        dc.w    $0009                    ; 008813A8: dc.w $0009
        dc.w    $6406                    ; 008813AA: BCC.S $008813B2
        dc.w    $5046                    ; 008813AC: dc.w $5046
        dc.w    $E145                    ; 008813AE: dc.w $E145
        dc.w    $1A18                    ; 008813B0: dc.w $1A18
        dc.w    $4E75                    ; 008813B2: RTS

; --- Stack-based LZ77-like decoder ---
LZ77Decoder:
        dc.w    $558F                    ; 008813B4: dc.w $558F
        dc.w    $1F58                    ; 008813B6: dc.w $1F58
        dc.w    $0001                    ; 008813B8: dc.w $0001
        dc.w    $1E98                    ; 008813BA: dc.w $1E98
        dc.w    $3A17                    ; 008813BC: dc.w $3A17
        dc.w    $780F                    ; 008813BE: MOVEQ #$0F,D4
        dc.w    $E24D                    ; 008813C0: dc.w $E24D
        dc.w    $40C6                    ; 008813C2: dc.w $40C6
        dc.w    $51CC, $000C            ; 008813C4: DBRA D4,$008813D2
        dc.w    $1F58                    ; 008813C8: dc.w $1F58
        dc.w    $0001                    ; 008813CA: dc.w $0001
        dc.w    $1E98                    ; 008813CC: dc.w $1E98
        dc.w    $3A17                    ; 008813CE: dc.w $3A17
        dc.w    $780F                    ; 008813D0: MOVEQ #$0F,D4
        dc.w    $44C6                    ; 008813D2: dc.w $44C6
        dc.w    $6404                    ; 008813D4: BCC.S $008813DA
        dc.w    $12D8                    ; 008813D6: dc.w $12D8
        dc.w    $60E6                    ; 008813D8: BRA.S $008813C0
        dc.w    $7600                    ; 008813DA: MOVEQ #$00,D3
        dc.w    $E24D                    ; 008813DC: dc.w $E24D
        dc.w    $40C6                    ; 008813DE: dc.w $40C6
        dc.w    $51CC, $000C            ; 008813E0: DBRA D4,$008813EE
        dc.w    $1F58                    ; 008813E4: dc.w $1F58
        dc.w    $0001                    ; 008813E6: dc.w $0001
        dc.w    $1E98                    ; 008813E8: dc.w $1E98
        dc.w    $3A17                    ; 008813EA: dc.w $3A17
        dc.w    $780F                    ; 008813EC: MOVEQ #$0F,D4
        dc.w    $44C6                    ; 008813EE: dc.w $44C6
        dc.w    $652C                    ; 008813F0: BCS.S $0088141E
        dc.w    $E24D                    ; 008813F2: dc.w $E24D
        dc.w    $51CC, $000C            ; 008813F4: DBRA D4,$00881402
        dc.w    $1F58                    ; 008813F8: dc.w $1F58
        dc.w    $0001                    ; 008813FA: dc.w $0001
        dc.w    $1E98                    ; 008813FC: dc.w $1E98
        dc.w    $3A17                    ; 008813FE: dc.w $3A17
        dc.w    $780F                    ; 00881400: MOVEQ #$0F,D4
        dc.w    $E353                    ; 00881402: dc.w $E353
        dc.w    $E24D                    ; 00881404: dc.w $E24D
        dc.w    $51CC, $000C            ; 00881406: DBRA D4,$00881414
        dc.w    $1F58                    ; 0088140A: dc.w $1F58
        dc.w    $0001                    ; 0088140C: dc.w $0001
        dc.w    $1E98                    ; 0088140E: dc.w $1E98
        dc.w    $3A17                    ; 00881410: dc.w $3A17
        dc.w    $780F                    ; 00881412: MOVEQ #$0F,D4
        dc.w    $E353                    ; 00881414: dc.w $E353
        dc.w    $5243                    ; 00881416: dc.w $5243
        dc.w    $74FF                    ; 00881418: MOVEQ #$FF,D2
        dc.w    $1418                    ; 0088141A: dc.w $1418
        dc.w    $6016                    ; 0088141C: BRA.S $00881434
        dc.w    $1018                    ; 0088141E: dc.w $1018
        dc.w    $1218                    ; 00881420: dc.w $1218
        dc.w    $74FF                    ; 00881422: MOVEQ #$FF,D2
        dc.w    $1401                    ; 00881424: dc.w $1401
        dc.w    $EB4A                    ; 00881426: dc.w $EB4A
        dc.w    $1400                    ; 00881428: dc.w $1400
        dc.w    $0241                    ; 0088142A: dc.w $0241
        dc.w    $0007                    ; 0088142C: dc.w $0007
        dc.w    $6710                    ; 0088142E: BEQ.S $00881440
        dc.w    $1601                    ; 00881430: dc.w $1601
        dc.w    $5243                    ; 00881432: dc.w $5243
        dc.w    $1031                    ; 00881434: dc.w $1031
        dc.w    $2000                    ; 00881436: dc.w $2000
        dc.w    $12C0                    ; 00881438: dc.w $12C0
        dc.w    $51CB, $FFF8            ; 0088143A: DBRA D3,$00881434
        dc.w    $6080                    ; 0088143E: BRA.S $008813C0
        dc.w    $1218                    ; 00881440: dc.w $1218
        dc.w    $670C                    ; 00881442: BEQ.S $00881450
        dc.w    $0C01                    ; 00881444: dc.w $0C01
        dc.w    $0001                    ; 00881446: dc.w $0001
        dc.w    $6700, $FF76            ; 00881448: BEQ.W $008813C0
        dc.w    $1601                    ; 0088144C: dc.w $1601
        dc.w    $60E4                    ; 0088144E: BRA.S $00881434
        dc.w    $548F                    ; 00881450: dc.w $548F
        dc.w    $4E75                    ; 00881452: RTS
        dc.w    $48A7                    ; 00881454: dc.w $48A7
        dc.w    $8300                    ; 00881456: dc.w $8300
        dc.w    $0280                    ; 00881458: dc.w $0280
        dc.w    $00FF                    ; 0088145A: dc.w $00FF
        dc.w    $FFFF                    ; 0088145C: dc.w $FFFF
        dc.w    $3C00                    ; 0088145E: dc.w $3C00
        dc.w    $0286                    ; 00881460: dc.w $0286
        dc.w    $0000                    ; 00881462: dc.w $0000
        dc.w    $3FFF                    ; 00881464: dc.w $3FFF
        dc.w    $0046                    ; 00881466: dc.w $0046
        dc.w    $4000                    ; 00881468: dc.w $4000
        dc.w    $4846                    ; 0088146A: dc.w $4846
        dc.w    $7E0E                    ; 0088146C: MOVEQ #$0E,D7
        dc.w    $EE68                    ; 0088146E: dc.w $EE68
        dc.w    $8086                    ; 00881470: dc.w $8086
        dc.w    $40E7                    ; 00881472: dc.w $40E7
        dc.w    $46FC, $2700            ; 00881474: MOVE.W #$2700,SR
        dc.w    $2A80                    ; 00881478: dc.w $2A80
        dc.w    $46DF                    ; 0088147A: dc.w $46DF
        dc.w    $4C9F                    ; 0088147C: dc.w $4C9F
        dc.w    $00C1                    ; 0088147E: dc.w $00C1
        dc.w    $4E75                    ; 00881480: RTS
        dc.w    $3F00                    ; 00881482: dc.w $3F00
        dc.w    $0280                    ; 00881484: dc.w $0280
        dc.w    $0000                    ; 00881486: dc.w $0000
        dc.w    $3FFF                    ; 00881488: dc.w $3FFF
        dc.w    $0040                    ; 0088148A: dc.w $0040
        dc.w    $4000                    ; 0088148C: dc.w $4000
        dc.w    $4840                    ; 0088148E: dc.w $4840
        dc.w    $0640                    ; 00881490: dc.w $0640
        dc.w    $0010                    ; 00881492: dc.w $0010
        dc.w    $40E7                    ; 00881494: dc.w $40E7
        dc.w    $46FC, $2700            ; 00881496: MOVE.W #$2700,SR
        dc.w    $2A80                    ; 0088149A: dc.w $2A80
        dc.w    $46DF                    ; 0088149C: dc.w $46DF
        dc.w    $301F                    ; 0088149E: dc.w $301F
        dc.w    $4E75                    ; 008814A0: RTS
        dc.w    $3F00                    ; 008814A2: dc.w $3F00
        dc.w    $0280                    ; 008814A4: dc.w $0280
        dc.w    $0000                    ; 008814A6: dc.w $0000
        dc.w    $007F                    ; 008814A8: dc.w $007F
        dc.w    $0640                    ; 008814AA: dc.w $0640
        dc.w    $C000                    ; 008814AC: dc.w $C000
        dc.w    $4840                    ; 008814AE: dc.w $4840
        dc.w    $40E7                    ; 008814B0: dc.w $40E7
        dc.w    $46FC, $2700            ; 008814B2: MOVE.W #$2700,SR
        dc.w    $2A80                    ; 008814B6: dc.w $2A80
        dc.w    $46DF                    ; 008814B8: dc.w $46DF
        dc.w    $301F                    ; 008814BA: dc.w $301F
        dc.w    $4E75                    ; 008814BC: RTS

; --- Indexed table access (12 calls) ---
TableLookup:
        dc.w    $7403                    ; 008814BE: MOVEQ #$03,D2
        dc.w    $7200                    ; 008814C0: MOVEQ #$00,D1
        dc.w    $1200                    ; 008814C2: dc.w $1200
        dc.w    $6712                    ; 008814C4: BEQ.S $008814D8
        dc.w    $E749                    ; 008814C6: dc.w $E749
        dc.w    $41FA                    ; 008814C8: dc.w $41FA
        dc.w    $0016                    ; 008814CA: dc.w $0016
        dc.w    $2AB0                    ; 008814CC: dc.w $2AB0
        dc.w    $10F8                    ; 008814CE: dc.w $10F8
        dc.w    $2070                    ; 008814D0: dc.w $2070
        dc.w    $10FC                    ; 008814D2: dc.w $10FC
        dc.w    $4EBA                    ; 008814D4: dc.w $4EBA
        dc.w    $FC1E                    ; 008814D6: dc.w $FC1E
        dc.w    $E098                    ; 008814D8: dc.w $E098
        dc.w    $51CA, $FFE4            ; 008814DA: DBRA D2,$008814C0
        dc.w    $4E75                    ; 008814DE: RTS
        dc.w    $4000                    ; 008814E0: dc.w $4000
        dc.w    $0000                    ; 008814E2: dc.w $0000
        dc.w    $0000                    ; 008814E4: dc.w $0000
        dc.w    $0000                    ; 008814E6: dc.w $0000
        dc.w    $4220                    ; 008814E8: dc.w $4220
        dc.w    $0000                    ; 008814EA: dc.w $0000
        dc.w    $0092                    ; 008814EC: dc.w $0092
        dc.w    $AC0C                    ; 008814EE: dc.w $AC0C
        dc.w    $4220                    ; 008814F0: dc.w $4220
        dc.w    $0000                    ; 008814F2: dc.w $0000
        dc.w    $0092                    ; 008814F4: dc.w $0092
        dc.w    $ACCC                    ; 008814F6: dc.w $ACCC
        dc.w    $4220                    ; 008814F8: dc.w $4220
        dc.w    $0000                    ; 008814FA: dc.w $0000
        dc.w    $0092                    ; 008814FC: dc.w $0092
        dc.w    $AD78                    ; 008814FE: dc.w $AD78
        dc.w    $4000                    ; 00881500: dc.w $4000
        dc.w    $0000                    ; 00881502: dc.w $0000
        dc.w    $0000                    ; 00881504: dc.w $0000
        dc.w    $0000                    ; 00881506: dc.w $0000
        dc.w    $4000                    ; 00881508: dc.w $4000
        dc.w    $0000                    ; 0088150A: dc.w $0000
        dc.w    $0000                    ; 0088150C: dc.w $0000
        dc.w    $0000                    ; 0088150E: dc.w $0000
        dc.w    $4020                    ; 00881510: dc.w $4020
        dc.w    $0000                    ; 00881512: dc.w $0000
        dc.w    $008B                    ; 00881514: dc.w $008B
        dc.w    $F000                    ; 00881516: dc.w $F000
        dc.w    $4220                    ; 00881518: dc.w $4220
        dc.w    $0000                    ; 0088151A: dc.w $0000
        dc.w    $0090                    ; 0088151C: dc.w $0090
        dc.w    $3B8E                    ; 0088151E: dc.w $3B8E
        dc.w    $6000, $0000            ; 00881520: BRA.W $00881522
        dc.w    $0090                    ; 00881524: dc.w $0090
        dc.w    $E6DA                    ; 00881526: dc.w $E6DA
        dc.w    $5E00                    ; 00881528: dc.w $5E00
        dc.w    $0001                    ; 0088152A: dc.w $0001
        dc.w    $0090                    ; 0088152C: dc.w $0090
        dc.w    $E58E                    ; 0088152E: dc.w $E58E
        dc.w    $7403                    ; 00881530: MOVEQ #$03,D2
        dc.w    $7200                    ; 00881532: MOVEQ #$00,D1
        dc.w    $1200                    ; 00881534: dc.w $1200
        dc.w    $670E                    ; 00881536: BEQ.S $00881546
        dc.w    $E749                    ; 00881538: dc.w $E749
        dc.w    $207B                    ; 0088153A: dc.w $207B
        dc.w    $100A                    ; 0088153C: dc.w $100A
        dc.w    $287B                    ; 0088153E: dc.w $287B
        dc.w    $100A                    ; 00881540: dc.w $100A
        dc.w    $4EBA                    ; 00881542: dc.w $4EBA
        dc.w    $FBC2                    ; 00881544: dc.w $FBC2
        dc.w    $E098                    ; 00881546: dc.w $E098
        dc.w    $51CA, $FFE8            ; 00881548: DBRA D2,$00881532
        dc.w    $4E75                    ; 0088154C: RTS
        dc.w    $0000                    ; 0088154E: dc.w $0000
        dc.w    $0000                    ; 00881550: dc.w $0000
        dc.w    $0000                    ; 00881552: dc.w $0000
        dc.w    $0000                    ; 00881554: dc.w $0000
        dc.w    $0000                    ; 00881556: dc.w $0000
        dc.w    $0000                    ; 00881558: dc.w $0000
        dc.w    $0000                    ; 0088155A: dc.w $0000
        dc.w    $0000                    ; 0088155C: dc.w $0000

; --- Called 2x from init ---
func_155E:
        dc.w    $7403                    ; 0088155E: MOVEQ #$03,D2
        dc.w    $7000                    ; 00881560: MOVEQ #$00,D0
        dc.w    $1001                    ; 00881562: dc.w $1001
        dc.w    $6714                    ; 00881564: BEQ.S $0088157A
        dc.w    $C0FC                    ; 00881566: dc.w $C0FC
        dc.w    $000A                    ; 00881568: dc.w $000A
        dc.w    $41FB                    ; 0088156A: dc.w $41FB
        dc.w    $001A                    ; 0088156C: dc.w $001A
        dc.w    $3020                    ; 0088156E: dc.w $3020
        dc.w    $2260                    ; 00881570: dc.w $2260
        dc.w    $2620                    ; 00881572: dc.w $2620
        dc.w    $2043                    ; 00881574: dc.w $2043
        dc.w    $4EBA                    ; 00881576: dc.w $4EBA
        dc.w    $FCBE                    ; 00881578: dc.w $FCBE
        dc.w    $E099                    ; 0088157A: dc.w $E099
        dc.w    $51CA, $FFE2            ; 0088157C: DBRA D2,$00881560
        dc.w    $46FC, $2300            ; 00881580: MOVE.W #$2300,SR
        dc.w    $4E75                    ; 00881584: RTS
        dc.w    $0090                    ; 00881586: dc.w $0090
        dc.w    $0000                    ; 00881588: dc.w $0000
        dc.w    $00FF                    ; 0088158A: dc.w $00FF
        dc.w    $1000                    ; 0088158C: dc.w $1000
        dc.w    $0011                    ; 0088158E: dc.w $0011
        dc.w    $0000                    ; 00881590: dc.w $0000
        dc.w    $0000                    ; 00881592: dc.w $0000
        dc.w    $0000                    ; 00881594: dc.w $0000
        dc.w    $0000                    ; 00881596: dc.w $0000
        dc.w    $0000                    ; 00881598: dc.w $0000
        dc.w    $0000                    ; 0088159A: dc.w $0000
        dc.w    $0000                    ; 0088159C: dc.w $0000
        dc.w    $0000                    ; 0088159E: dc.w $0000
        dc.w    $0000                    ; 008815A0: dc.w $0000
        dc.w    $0000                    ; 008815A2: dc.w $0000
        dc.w    $0090                    ; 008815A4: dc.w $0090
        dc.w    $23A4                    ; 008815A6: dc.w $23A4
        dc.w    $00FF                    ; 008815A8: dc.w $00FF
        dc.w    $1000                    ; 008815AA: dc.w $1000
        dc.w    $0011                    ; 008815AC: dc.w $0011
        dc.w    $0090                    ; 008815AE: dc.w $0090
        dc.w    $05B2                    ; 008815B0: dc.w $05B2
        dc.w    $00FF                    ; 008815B2: dc.w $00FF
        dc.w    $1000                    ; 008815B4: dc.w $1000
        dc.w    $0011                    ; 008815B6: dc.w $0011
        dc.w    $0090                    ; 008815B8: dc.w $0090
        dc.w    $0A7C                    ; 008815BA: dc.w $0A7C
        dc.w    $00FF                    ; 008815BC: dc.w $00FF
        dc.w    $1000                    ; 008815BE: dc.w $1000
        dc.w    $0011                    ; 008815C0: dc.w $0011
        dc.w    $0090                    ; 008815C2: dc.w $0090
        dc.w    $102A                    ; 008815C4: dc.w $102A
        dc.w    $00FF                    ; 008815C6: dc.w $00FF
        dc.w    $1000                    ; 008815C8: dc.w $1000
        dc.w    $0011                    ; 008815CA: dc.w $0011
        dc.w    $0090                    ; 008815CC: dc.w $0090
        dc.w    $3A74                    ; 008815CE: dc.w $3A74
        dc.w    $00FF                    ; 008815D0: dc.w $00FF
        dc.w    $1000                    ; 008815D2: dc.w $1000
        dc.w    $0011                    ; 008815D4: dc.w $0011
        dc.w    $0090                    ; 008815D6: dc.w $0090
        dc.w    $3ADE                    ; 008815D8: dc.w $3ADE
        dc.w    $00FF                    ; 008815DA: dc.w $00FF
        dc.w    $1000                    ; 008815DC: dc.w $1000
        dc.w    $0011                    ; 008815DE: dc.w $0011
        dc.w    $0090                    ; 008815E0: dc.w $0090
        dc.w    $3B3C                    ; 008815E2: dc.w $3B3C
        dc.w    $00FF                    ; 008815E4: dc.w $00FF
        dc.w    $1000                    ; 008815E6: dc.w $1000
        dc.w    $0011                    ; 008815E8: dc.w $0011

; --- Called 1x from init ---
func_15EA:
        dc.w    $7403                    ; 008815EA: MOVEQ #$03,D2
        dc.w    $7200                    ; 008815EC: MOVEQ #$00,D1
        dc.w    $1200                    ; 008815EE: dc.w $1200
        dc.w    $6716                    ; 008815F0: BEQ.S $00881608
        dc.w    $E749                    ; 008815F2: dc.w $E749
        dc.w    $207B                    ; 008815F4: dc.w $207B
        dc.w    $1012                    ; 008815F6: dc.w $1012
        dc.w    $227B                    ; 008815F8: dc.w $227B
        dc.w    $1012                    ; 008815FA: dc.w $1012
        dc.w    $48E7, $A000            ; 008815FC: MOVEM.L regs,-(SP)
        dc.w    $4EBA                    ; 00881600: dc.w $4EBA
        dc.w    $FDB2                    ; 00881602: dc.w $FDB2
        dc.w    $4CDF, $0005            ; 00881604: MOVEM.L (SP)+,regs
        dc.w    $E098                    ; 00881608: dc.w $E098
        dc.w    $51CA, $FFE0            ; 0088160A: DBRA D2,$008815EC
        dc.w    $4E75                    ; 0088160E: RTS
        dc.w    $0090                    ; 00881610: dc.w $0090
        dc.w    $3B8E                    ; 00881612: dc.w $3B8E
        dc.w    $00FF                    ; 00881614: dc.w $00FF
        dc.w    $1000                    ; 00881616: dc.w $1000
        dc.w    $0090                    ; 00881618: dc.w $0090
        dc.w    $5A7E                    ; 0088161A: dc.w $5A7E
        dc.w    $00FF                    ; 0088161C: dc.w $00FF
        dc.w    $1000                    ; 0088161E: dc.w $1000
        dc.w    $0090                    ; 00881620: dc.w $0090
        dc.w    $77CE                    ; 00881622: dc.w $77CE
        dc.w    $00FF                    ; 00881624: dc.w $00FF
        dc.w    $1000                    ; 00881626: dc.w $1000
        dc.w    $0090                    ; 00881628: dc.w $0090
        dc.w    $992E                    ; 0088162A: dc.w $992E
        dc.w    $00FF                    ; 0088162C: dc.w $00FF
        dc.w    $1000                    ; 0088162E: dc.w $1000
        dc.w    $0090                    ; 00881630: dc.w $0090
        dc.w    $C30E                    ; 00881632: dc.w $C30E
        dc.w    $00FF                    ; 00881634: dc.w $00FF
        dc.w    $1000                    ; 00881636: dc.w $1000
        dc.w    $46FC, $2700            ; 00881638: MOVE.W #$2700,SR
        dc.w    $7403                    ; 0088163C: MOVEQ #$03,D2
        dc.w    $7200                    ; 0088163E: MOVEQ #$00,D1
        dc.w    $1200                    ; 00881640: dc.w $1200
        dc.w    $671C                    ; 00881642: BEQ.S $00881660
        dc.w    $C2FC                    ; 00881644: dc.w $C2FC
        dc.w    $000C                    ; 00881646: dc.w $000C
        dc.w    $48E7, $E000            ; 00881648: MOVEM.L regs,-(SP)
        dc.w    $41FB                    ; 0088164C: dc.w $41FB
        dc.w    $101E                    ; 0088164E: dc.w $101E
        dc.w    $3420                    ; 00881650: dc.w $3420
        dc.w    $3220                    ; 00881652: dc.w $3220
        dc.w    $2020                    ; 00881654: dc.w $2020
        dc.w    $2060                    ; 00881656: dc.w $2060
        dc.w    $4EBA                    ; 00881658: dc.w $4EBA
        dc.w    $FA6A                    ; 0088165A: dc.w $FA6A
        dc.w    $4CDF, $0007            ; 0088165C: MOVEM.L (SP)+,regs
        dc.w    $E098                    ; 00881660: dc.w $E098
        dc.w    $51CA, $FFDA            ; 00881662: DBRA D2,$0088163E
        dc.w    $46FC, $2300            ; 00881666: MOVE.W #$2300,SR
        dc.w    $4E75                    ; 0088166A: RTS
        dc.w    $00FF                    ; 0088166C: dc.w $00FF
        dc.w    $1000                    ; 0088166E: dc.w $1000
        dc.w    $659C                    ; 00881670: BCS.S $0088160E
        dc.w    $0002                    ; 00881672: dc.w $0002
        dc.w    $000D                    ; 00881674: dc.w $000D
        dc.w    $0003                    ; 00881676: dc.w $0003
        dc.w    $00FF                    ; 00881678: dc.w $00FF
        dc.w    $1000                    ; 0088167A: dc.w $1000
        dc.w    $6000, $0002            ; 0088167C: BRA.W $00881680
        dc.w    $0027                    ; 00881680: dc.w $0027
        dc.w    $001B                    ; 00881682: dc.w $001B

; ============================================================================
; V_INT_Handler - Vertical Blank Interrupt Handler
; ============================================================================
; Called every frame (~60Hz NTSC). Implements state machine for game sync.
;
; RAM Usage:
;   ($C87A).W - V-INT state: 0=disabled, 1-15=call handler from table
;   ($C964).W - Frame counter (incremented every V-INT)
;
; Flow:
;   1. Check if V-INT processing enabled (state != 0)
;   2. If enabled: save regs, call state handler, increment frame, restore
;   3. Return from exception
; ============================================================================
V_INT_Handler:
        tst.w   ($C87A).w               ; 00881684: Check V-INT state flag
        beq.s   .vint_disabled          ; 00881688: Skip if state == 0
        move.w  #$2700,sr               ; 0088168A: Disable all interrupts
        movem.l d0-d7/a0-a6,-(sp)       ; 0088168E: Save all registers
        move.w  ($C87A).w,d0            ; 00881692: Get state number (0-15)
        move.w  #$0000,($C87A).w        ; 00881696: Clear state (one-shot)
        movea.l (pc,d0.w*4),a1          ; 0088169C: Load handler from VINTStateTable
        jsr     (a1)                    ; 008816A0: Call state handler
        addq.w  #1,($C964).w            ; 008816A2: Increment frame counter
        movem.l (sp)+,d0-d7/a0-a6       ; 008816A6: Restore all registers
        move.w  #$2300,sr               ; 008816AA: Re-enable interrupts (level 3)
        rte                             ; 008816AE: Return from exception
.vint_disabled:
        rte                             ; 008816B0: Return immediately

; --- V-INT jump table (16 entries) ---
VINTStateTable:
        dc.w    $0088                    ; 008816B2: dc.w $0088
        dc.w    $19FE                    ; 008816B4: dc.w $19FE
        dc.w    $0088                    ; 008816B6: dc.w $0088
        dc.w    $19FE                    ; 008816B8: dc.w $19FE
        dc.w    $0088                    ; 008816BA: dc.w $0088
        dc.w    $19FE                    ; 008816BC: dc.w $19FE
        dc.w    $0001                    ; 008816BE: dc.w $0001
        dc.w    $8200                    ; 008816C0: dc.w $8200
        dc.w    $0088                    ; 008816C2: dc.w $0088
        dc.w    $1A6E                    ; 008816C4: dc.w $1A6E
        dc.w    $0088                    ; 008816C6: dc.w $0088
        dc.w    $1A72                    ; 008816C8: dc.w $1A72
        dc.w    $0088                    ; 008816CA: dc.w $0088
        dc.w    $1C66                    ; 008816CC: dc.w $1C66
        dc.w    $0088                    ; 008816CE: dc.w $0088
        dc.w    $1ACA                    ; 008816D0: dc.w $1ACA

; --- Default handler ---
VINTState0:
        dc.w    $0088                    ; 008816D2: dc.w $0088
        dc.w    $19FE                    ; 008816D4: dc.w $19FE

; --- Default handler ---
VINTState1:
        dc.w    $0088                    ; 008816D6: dc.w $0088
        dc.w    $1E42                    ; 008816D8: dc.w $1E42

; --- Default handler ---
VINTState2:
        dc.w    $0088                    ; 008816DA: dc.w $0088
        dc.w    $1B14                    ; 008816DC: dc.w $1B14

; --- INVALID - odd address ---
VINTState3:
        dc.w    $0088                    ; 008816DE: dc.w $0088
        dc.w    $1A64                    ; 008816E0: dc.w $1A64

; --- Handler ---
VINTState4:
        dc.w    $0088                    ; 008816E2: dc.w $0088
        dc.w    $1BA8                    ; 008816E4: dc.w $1BA8

; --- SH2 COMM0 wait ---
VINTState5:
        dc.w    $0088                    ; 008816E6: dc.w $0088
        dc.w    $1E94                    ; 008816E8: dc.w $1E94

; --- Frame buffer ops ---
VINTState6:
        dc.w    $0088                    ; 008816EA: dc.w $0088
        dc.w    $1F4A                    ; 008816EC: dc.w $1F4A

; --- SH2 COMM0 wait ---
VINTState7:
        dc.w    $0088                    ; 008816EE: dc.w $0088
        dc.w    $2010                    ; 008816F0: dc.w $2010

; --- Default handler ---
VINTState8:
        dc.w    $0000                    ; 008816F2: dc.w $0000
        dc.w    $0001                    ; 008816F4: dc.w $0001

; --- Palette init ---
VINTState9:
        dc.w    $0088                    ; 008816F6: dc.w $0088
        dc.w    $1DBE                    ; 008816F8: dc.w $1DBE

; --- SH2 COMM0 wait ---
VINTState10:
        dc.w    $0000                    ; 008816FA: dc.w $0000
        dc.w    $0001                    ; 008816FC: dc.w $0001

; --- External $20C6 ---
VINTState11:
        dc.w    $0000                    ; 008816FE: dc.w $0000
        dc.w    $0001                    ; 00881700: dc.w $0001

; --- SH2 COMM0 wait ---
VINTState12:
        dc.w    $0000                    ; 00881702: dc.w $0000
        dc.w    $0001                    ; 00881704: dc.w $0001

; --- Frame buffer ops ---
VINTState13:
        dc.w    $0088                    ; 00881706: dc.w $0088
        dc.w    $1D0C                    ; 00881708: dc.w $1D0C

; ============================================================================
; H_INT_Handler - Horizontal Blank Interrupt Handler
; ============================================================================
; Unused in Virtua Racing Deluxe - immediate return from exception.
; H-blank could be used for raster effects but this game doesn't use them.
; ============================================================================
H_INT_Handler:
        rte                             ; 0088170A: Return immediately (unused)
        dc.w    $11FC                    ; 0088170C: dc.w $11FC
        dc.w    $0000                    ; 0088170E: dc.w $0000
        dc.w    $FE92                    ; 00881710: dc.w $FE92
        dc.w    $11FC                    ; 00881712: dc.w $11FC
        dc.w    $0000                    ; 00881714: dc.w $0000
        dc.w    $FE93                    ; 00881716: dc.w $FE93
        dc.w    $43F8                    ; 00881718: dc.w $43F8
        dc.w    $FE82                    ; 0088171A: dc.w $FE82
        dc.w    $12FC                    ; 0088171C: dc.w $12FC
        dc.w    $0004                    ; 0088171E: dc.w $0004
        dc.w    $12FC                    ; 00881720: dc.w $12FC
        dc.w    $0006                    ; 00881722: dc.w $0006
        dc.w    $12FC                    ; 00881724: dc.w $12FC
        dc.w    $0001                    ; 00881726: dc.w $0001
        dc.w    $12FC                    ; 00881728: dc.w $12FC
        dc.w    $0000                    ; 0088172A: dc.w $0000
        dc.w    $12FC                    ; 0088172C: dc.w $12FC
        dc.w    $0005                    ; 0088172E: dc.w $0005
        dc.w    $12FC                    ; 00881730: dc.w $12FC
        dc.w    $000A                    ; 00881732: dc.w $000A
        dc.w    $12FC                    ; 00881734: dc.w $12FC
        dc.w    $0009                    ; 00881736: dc.w $0009
        dc.w    $12FC                    ; 00881738: dc.w $12FC
        dc.w    $0008                    ; 0088173A: dc.w $0008
        dc.w    $12FC                    ; 0088173C: dc.w $12FC
        dc.w    $0004                    ; 0088173E: dc.w $0004
        dc.w    $12FC                    ; 00881740: dc.w $12FC
        dc.w    $0006                    ; 00881742: dc.w $0006
        dc.w    $12FC                    ; 00881744: dc.w $12FC
        dc.w    $0001                    ; 00881746: dc.w $0001
        dc.w    $12FC                    ; 00881748: dc.w $12FC
        dc.w    $0000                    ; 0088174A: dc.w $0000
        dc.w    $12FC                    ; 0088174C: dc.w $12FC
        dc.w    $0005                    ; 0088174E: dc.w $0005
        dc.w    $12FC                    ; 00881750: dc.w $12FC
        dc.w    $000A                    ; 00881752: dc.w $000A
        dc.w    $12FC                    ; 00881754: dc.w $12FC
        dc.w    $0009                    ; 00881756: dc.w $0009
        dc.w    $12BC                    ; 00881758: dc.w $12BC
        dc.w    $0008                    ; 0088175A: dc.w $0008
        dc.w    $43F8                    ; 0088175C: dc.w $43F8
        dc.w    $FE94                    ; 0088175E: dc.w $FE94
        dc.w    $47FA                    ; 00881760: dc.w $47FA
        dc.w    $0034                    ; 00881762: dc.w $0034
        dc.w    $0838                    ; 00881764: dc.w $0838
        dc.w    $0000                    ; 00881766: dc.w $0000
        dc.w    $C818                    ; 00881768: dc.w $C818
        dc.w    $6604                    ; 0088176A: BNE.S $00881770
        dc.w    $47FA                    ; 0088176C: dc.w $47FA
        dc.w    $0020                    ; 0088176E: dc.w $0020
        dc.w    $4EBA                    ; 00881770: dc.w $4EBA
        dc.w    $0012                    ; 00881772: dc.w $0012
        dc.w    $47FA                    ; 00881774: dc.w $47FA
        dc.w    $0020                    ; 00881776: dc.w $0020
        dc.w    $0838                    ; 00881778: dc.w $0838
        dc.w    $0001                    ; 0088177A: dc.w $0001
        dc.w    $C818                    ; 0088177C: dc.w $C818
        dc.w    $6604                    ; 0088177E: BNE.S $00881784
        dc.w    $47FA                    ; 00881780: dc.w $47FA
        dc.w    $000C                    ; 00881782: dc.w $000C
        dc.w    $7E07                    ; 00881784: MOVEQ #$07,D7
        dc.w    $12DB                    ; 00881786: MOVE.B (A3)+,(A1)+
        dc.w    $51CF, $FFFC            ; 00881788: DBRA D7,$00881786
        dc.w    $4E75                    ; 0088178C: RTS
        dc.w    $0406                    ; 0088178E: dc.w $0406
        dc.w    $0100                    ; 00881790: dc.w $0100
        dc.w    $0500                    ; 00881792: dc.w $0500
        dc.w    $0000                    ; 00881794: dc.w $0000
        dc.w    $0406                    ; 00881796: dc.w $0406
        dc.w    $0100                    ; 00881798: dc.w $0100
        dc.w    $050A                    ; 0088179A: dc.w $050A
        dc.w    $0908                    ; 0088179C: dc.w $0908

; --- Read controller ports (16 calls) ---
ControllerRead:
        dc.w    $0C38                    ; 0088179E: dc.w $0C38
        dc.w    $000D                    ; 008817A0: dc.w $000D
        dc.w    $C810                    ; 008817A2: dc.w $C810
        dc.w    $6630                    ; 008817A4: BNE.S $008817D6
        dc.w    $41F8                    ; 008817A6: dc.w $41F8
        dc.w    $C86C                    ; 008817A8: dc.w $C86C
        dc.w    $23D0                    ; 008817AA: dc.w $23D0
        dc.w    $00FF                    ; 008817AC: dc.w $00FF
        dc.w    $60D0                    ; 008817AE: BRA.S $00881780
        dc.w    $43F9, $00A1, $0003    ; 008817B0: LEA $00A10003,A1
        dc.w    $45F8                    ; 008817B6: dc.w $45F8
        dc.w    $C970                    ; 008817B8: dc.w $C970
        dc.w    $47F8                    ; 008817BA: dc.w $47F8
        dc.w    $FE82                    ; 008817BC: dc.w $FE82
        dc.w    $4EBA                    ; 008817BE: dc.w $4EBA
        dc.w    $009E                    ; 008817C0: dc.w $009E
        dc.w    $4EBA                    ; 008817C2: dc.w $4EBA
        dc.w    $002A                    ; 008817C4: dc.w $002A
        dc.w    $0C38                    ; 008817C6: dc.w $0C38
        dc.w    $000D                    ; 008817C8: dc.w $000D
        dc.w    $C811                    ; 008817CA: dc.w $C811
        dc.w    $6716                    ; 008817CC: BEQ.S $008817E4
        dc.w    $11FC                    ; 008817CE: dc.w $11FC
        dc.w    $0000                    ; 008817D0: dc.w $0000
        dc.w    $C86E                    ; 008817D2: dc.w $C86E
        dc.w    $4E75                    ; 008817D4: RTS
        dc.w    $11FC                    ; 008817D6: dc.w $11FC
        dc.w    $0000                    ; 008817D8: dc.w $0000
        dc.w    $C86C                    ; 008817DA: dc.w $C86C
        dc.w    $11FC                    ; 008817DC: dc.w $11FC
        dc.w    $0000                    ; 008817DE: dc.w $0000
        dc.w    $C86E                    ; 008817E0: dc.w $C86E
        dc.w    $4E75                    ; 008817E2: RTS
        dc.w    $43F9, $00A1, $0005    ; 008817E4: LEA $00A10005,A1
        dc.w    $4EBA                    ; 008817EA: dc.w $4EBA
        dc.w    $0072                    ; 008817EC: dc.w $0072

; --- Map hardware to game buttons ---
MapButtonBits:
        dc.w    $1410                    ; 008817EE: dc.w $1410
        dc.w    $3200                    ; 008817F0: dc.w $3200
        dc.w    $B102                    ; 008817F2: dc.w $B102
        dc.w    $C002                    ; 008817F4: dc.w $C002
        dc.w    $10C1                    ; 008817F6: dc.w $10C1
        dc.w    $10C0                    ; 008817F8: dc.w $10C0
        dc.w    $7C00                    ; 008817FA: MOVEQ #$00,D6
        dc.w    $8C01                    ; 008817FC: dc.w $8C01
        dc.w    $0206                    ; 008817FE: dc.w $0206
        dc.w    $000C                    ; 00881800: dc.w $000C
        dc.w    $1E1B                    ; 00881802: dc.w $1E1B
        dc.w    $0F01                    ; 00881804: dc.w $0F01
        dc.w    $6704                    ; 00881806: BEQ.S $0088180C
        dc.w    $08C6                    ; 00881808: dc.w $08C6
        dc.w    $0004                    ; 0088180A: dc.w $0004
        dc.w    $1E1B                    ; 0088180C: dc.w $1E1B
        dc.w    $0F01                    ; 0088180E: dc.w $0F01
        dc.w    $6704                    ; 00881810: BEQ.S $00881816
        dc.w    $08C6                    ; 00881812: dc.w $08C6
        dc.w    $0006                    ; 00881814: dc.w $0006
        dc.w    $1E1B                    ; 00881816: dc.w $1E1B
        dc.w    $0F01                    ; 00881818: dc.w $0F01
        dc.w    $6704                    ; 0088181A: BEQ.S $00881820
        dc.w    $08C6                    ; 0088181C: dc.w $08C6
        dc.w    $0001                    ; 0088181E: dc.w $0001
        dc.w    $1E1B                    ; 00881820: dc.w $1E1B
        dc.w    $0F01                    ; 00881822: dc.w $0F01
        dc.w    $6704                    ; 00881824: BEQ.S $0088182A
        dc.w    $08C6                    ; 00881826: dc.w $08C6
        dc.w    $0000                    ; 00881828: dc.w $0000
        dc.w    $1E1B                    ; 0088182A: dc.w $1E1B
        dc.w    $0F01                    ; 0088182C: dc.w $0F01
        dc.w    $6704                    ; 0088182E: BEQ.S $00881834
        dc.w    $08C6                    ; 00881830: dc.w $08C6
        dc.w    $000A                    ; 00881832: dc.w $000A
        dc.w    $1E1B                    ; 00881834: dc.w $1E1B
        dc.w    $0F01                    ; 00881836: dc.w $0F01
        dc.w    $6704                    ; 00881838: BEQ.S $0088183E
        dc.w    $08C6                    ; 0088183A: dc.w $08C6
        dc.w    $0005                    ; 0088183C: dc.w $0005
        dc.w    $1E1B                    ; 0088183E: dc.w $1E1B
        dc.w    $0F01                    ; 00881840: dc.w $0F01
        dc.w    $6704                    ; 00881842: BEQ.S $00881848
        dc.w    $08C6                    ; 00881844: dc.w $08C6
        dc.w    $0009                    ; 00881846: dc.w $0009
        dc.w    $1E1B                    ; 00881848: dc.w $1E1B
        dc.w    $0F01                    ; 0088184A: dc.w $0F01
        dc.w    $6704                    ; 0088184C: BEQ.S $00881852
        dc.w    $08C6                    ; 0088184E: dc.w $08C6
        dc.w    $0008                    ; 00881850: dc.w $0008
        dc.w    $3412                    ; 00881852: dc.w $3412
        dc.w    $34C6                    ; 00881854: dc.w $34C6
        dc.w    $BD42                    ; 00881856: dc.w $BD42
        dc.w    $CC42                    ; 00881858: dc.w $CC42
        dc.w    $34C6                    ; 0088185A: dc.w $34C6
        dc.w    $4E75                    ; 0088185C: RTS

; --- 6-button detection via TH ---
Read6ButtonPad:
        dc.w    $33FC                    ; 0088185E: dc.w $33FC
        dc.w    $0100                    ; 00881860: dc.w $0100
        dc.w    $00A1                    ; 00881862: dc.w $00A1
        dc.w    $1100                    ; 00881864: dc.w $1100
        dc.w    $0839                    ; 00881866: dc.w $0839
        dc.w    $0000                    ; 00881868: dc.w $0000
        dc.w    $00A1                    ; 0088186A: dc.w $00A1
        dc.w    $1100                    ; 0088186C: dc.w $1100
        dc.w    $66F6                    ; 0088186E: BNE.S $00881866
        dc.w    $12BC                    ; 00881870: dc.w $12BC
        dc.w    $0040                    ; 00881872: dc.w $0040
        dc.w    $7C00                    ; 00881874: MOVEQ #$00,D6
        dc.w    $723F                    ; 00881876: MOVEQ #$3F,D1
        dc.w    $C211                    ; 00881878: dc.w $C211
        dc.w    $1286                    ; 0088187A: dc.w $1286
        dc.w    $7E40                    ; 0088187C: MOVEQ #$40,D7
        dc.w    $7030                    ; 0088187E: MOVEQ #$30,D0
        dc.w    $C011                    ; 00881880: dc.w $C011
        dc.w    $E508                    ; 00881882: dc.w $E508
        dc.w    $8041                    ; 00881884: dc.w $8041
        dc.w    $1287                    ; 00881886: dc.w $1287
        dc.w    $4E71                    ; 00881888: NOP
        dc.w    $4E71                    ; 0088188A: NOP
        dc.w    $4E71                    ; 0088188C: NOP
        dc.w    $4E71                    ; 0088188E: NOP
        dc.w    $1211                    ; 00881890: dc.w $1211
        dc.w    $1286                    ; 00881892: dc.w $1286
        dc.w    $3A3C                    ; 00881894: dc.w $3A3C
        dc.w    $00FF                    ; 00881896: dc.w $00FF
        dc.w    $1211                    ; 00881898: dc.w $1211
        dc.w    $1287                    ; 0088189A: dc.w $1287
        dc.w    $1211                    ; 0088189C: dc.w $1211
        dc.w    $1286                    ; 0088189E: dc.w $1286
        dc.w    $4E71                    ; 008818A0: NOP
        dc.w    $4E71                    ; 008818A2: NOP
        dc.w    $4E71                    ; 008818A4: NOP
        dc.w    $720F                    ; 008818A6: MOVEQ #$0F,D1
        dc.w    $C211                    ; 008818A8: dc.w $C211
        dc.w    $661C                    ; 008818AA: BNE.S $008818C8
        dc.w    $1287                    ; 008818AC: dc.w $1287
        dc.w    $4E71                    ; 008818AE: NOP
        dc.w    $4E71                    ; 008818B0: NOP
        dc.w    $4E71                    ; 008818B2: NOP
        dc.w    $720F                    ; 008818B4: MOVEQ #$0F,D1
        dc.w    $C211                    ; 008818B6: dc.w $C211
        dc.w    $E149                    ; 008818B8: dc.w $E149
        dc.w    $8041                    ; 008818BA: dc.w $8041
        dc.w    $4640                    ; 008818BC: dc.w $4640
        dc.w    $33FC                    ; 008818BE: dc.w $33FC
        dc.w    $0000                    ; 008818C0: dc.w $0000
        dc.w    $00A1                    ; 008818C2: dc.w $00A1
        dc.w    $1100                    ; 008818C4: dc.w $1100
        dc.w    $4E75                    ; 008818C6: RTS
        dc.w    $4640                    ; 008818C8: dc.w $4640
        dc.w    $C045                    ; 008818CA: dc.w $C045
        dc.w    $1287                    ; 008818CC: dc.w $1287
        dc.w    $33FC                    ; 008818CE: dc.w $33FC
        dc.w    $0000                    ; 008818D0: dc.w $0000
        dc.w    $00A1                    ; 008818D2: dc.w $00A1
        dc.w    $1100                    ; 008818D4: dc.w $1100
        dc.w    $4E75                    ; 008818D6: RTS
        dc.w    $7000                    ; 008818D8: MOVEQ #$00,D0
        dc.w    $6100, $00B6            ; 008818DA: BSR.W $00881992
        dc.w    $11C0                    ; 008818DE: dc.w $11C0
        dc.w    $C810                    ; 008818E0: dc.w $C810
        dc.w    $7001                    ; 008818E2: MOVEQ #$01,D0
        dc.w    $6100, $00AC            ; 008818E4: BSR.W $00881992
        dc.w    $11C0                    ; 008818E8: dc.w $11C0
        dc.w    $C811                    ; 008818EA: dc.w $C811
        dc.w    $7002                    ; 008818EC: MOVEQ #$02,D0
        dc.w    $6100, $00A2            ; 008818EE: BSR.W $00881992
        dc.w    $11C0                    ; 008818F2: dc.w $11C0
        dc.w    $C812                    ; 008818F4: dc.w $C812
        dc.w    $33FC                    ; 008818F6: dc.w $33FC
        dc.w    $0100                    ; 008818F8: dc.w $0100
        dc.w    $00A1                    ; 008818FA: dc.w $00A1
        dc.w    $1100                    ; 008818FC: dc.w $1100
        dc.w    $0839                    ; 008818FE: dc.w $0839
        dc.w    $0000                    ; 00881900: dc.w $0000
        dc.w    $00A1                    ; 00881902: dc.w $00A1
        dc.w    $1100                    ; 00881904: dc.w $1100
        dc.w    $66F6                    ; 00881906: BNE.S $008818FE
        dc.w    $7040                    ; 00881908: MOVEQ #$40,D0
        dc.w    $13C0                    ; 0088190A: dc.w $13C0
        dc.w    $00A1                    ; 0088190C: dc.w $00A1
        dc.w    $0009                    ; 0088190E: dc.w $0009
        dc.w    $13C0                    ; 00881910: dc.w $13C0
        dc.w    $00A1                    ; 00881912: dc.w $00A1
        dc.w    $000B                    ; 00881914: dc.w $000B
        dc.w    $13C0                    ; 00881916: dc.w $13C0
        dc.w    $00A1                    ; 00881918: dc.w $00A1
        dc.w    $000D                    ; 0088191A: dc.w $000D
        dc.w    $303C                    ; 0088191C: dc.w $303C
        dc.w    $00C0                    ; 0088191E: dc.w $00C0
        dc.w    $13C0                    ; 00881920: dc.w $13C0
        dc.w    $00A1                    ; 00881922: dc.w $00A1
        dc.w    $0003                    ; 00881924: dc.w $0003
        dc.w    $13C0                    ; 00881926: dc.w $13C0
        dc.w    $00A1                    ; 00881928: dc.w $00A1
        dc.w    $0005                    ; 0088192A: dc.w $0005
        dc.w    $13C0                    ; 0088192C: dc.w $13C0
        dc.w    $00A1                    ; 0088192E: dc.w $00A1
        dc.w    $0007                    ; 00881930: dc.w $0007
        dc.w    $33FC                    ; 00881932: dc.w $33FC
        dc.w    $0000                    ; 00881934: dc.w $0000
        dc.w    $00A1                    ; 00881936: dc.w $00A1
        dc.w    $1100                    ; 00881938: dc.w $1100
        dc.w    $3E3C                    ; 0088193A: dc.w $3E3C
        dc.w    $1400                    ; 0088193C: dc.w $1400
        dc.w    $51CF, $FFFE            ; 0088193E: DBRA D7,$0088193E
        dc.w    $11FC                    ; 00881942: dc.w $11FC
        dc.w    $0000                    ; 00881944: dc.w $0000
        dc.w    $C818                    ; 00881946: dc.w $C818
        dc.w    $43F9, $00A1, $0003    ; 00881948: LEA $00A10003,A1
        dc.w    $4EBA                    ; 0088194E: dc.w $4EBA
        dc.w    $FF0E                    ; 00881950: dc.w $FF0E
        dc.w    $0800                    ; 00881952: dc.w $0800
        dc.w    $000F                    ; 00881954: dc.w $000F
        dc.w    $6706                    ; 00881956: BEQ.S $0088195E
        dc.w    $08F8                    ; 00881958: dc.w $08F8
        dc.w    $0000                    ; 0088195A: dc.w $0000
        dc.w    $C818                    ; 0088195C: dc.w $C818
        dc.w    $43F9, $00A1, $0005    ; 0088195E: LEA $00A10005,A1
        dc.w    $4EBA                    ; 00881964: dc.w $4EBA
        dc.w    $FEF8                    ; 00881966: dc.w $FEF8
        dc.w    $0800                    ; 00881968: dc.w $0800
        dc.w    $000F                    ; 0088196A: dc.w $000F
        dc.w    $6706                    ; 0088196C: BEQ.S $00881974
        dc.w    $08F8                    ; 0088196E: dc.w $08F8
        dc.w    $0001                    ; 00881970: dc.w $0001
        dc.w    $C818                    ; 00881972: dc.w $C818
        dc.w    $0C38                    ; 00881974: dc.w $0C38
        dc.w    $000D                    ; 00881976: dc.w $000D
        dc.w    $C810                    ; 00881978: dc.w $C810
        dc.w    $6706                    ; 0088197A: BEQ.S $00881982
        dc.w    $08F8                    ; 0088197C: dc.w $08F8
        dc.w    $0002                    ; 0088197E: dc.w $0002
        dc.w    $C818                    ; 00881980: dc.w $C818
        dc.w    $0C38                    ; 00881982: dc.w $0C38
        dc.w    $000D                    ; 00881984: dc.w $000D
        dc.w    $C811                    ; 00881986: dc.w $C811
        dc.w    $6706                    ; 00881988: BEQ.S $00881990
        dc.w    $08F8                    ; 0088198A: dc.w $08F8
        dc.w    $0003                    ; 0088198C: dc.w $0003
        dc.w    $C818                    ; 0088198E: dc.w $C818
        dc.w    $4E75                    ; 00881990: RTS

; --- Called 3x from init ---
func_1992:
        dc.w    $33FC                    ; 00881992: dc.w $33FC
        dc.w    $0100                    ; 00881994: dc.w $0100
        dc.w    $00A1                    ; 00881996: dc.w $00A1
        dc.w    $1100                    ; 00881998: dc.w $1100
        dc.w    $0839                    ; 0088199A: dc.w $0839
        dc.w    $0000                    ; 0088199C: dc.w $0000
        dc.w    $00A1                    ; 0088199E: dc.w $00A1
        dc.w    $1100                    ; 008819A0: dc.w $1100
        dc.w    $66F6                    ; 008819A2: BNE.S $0088199A
        dc.w    $48E7, $6040            ; 008819A4: MOVEM.L regs,-(SP)
        dc.w    $D040                    ; 008819A8: dc.w $D040
        dc.w    $D040                    ; 008819AA: dc.w $D040
        dc.w    $41FA                    ; 008819AC: dc.w $41FA
        dc.w    $0044                    ; 008819AE: dc.w $0044
        dc.w    $2070                    ; 008819B0: dc.w $2070
        dc.w    $0000                    ; 008819B2: dc.w $0000
        dc.w    $43FA                    ; 008819B4: dc.w $43FA
        dc.w    $0034                    ; 008819B6: dc.w $0034
        dc.w    $1151                    ; 008819B8: dc.w $1151
        dc.w    $0006                    ; 008819BA: dc.w $0006
        dc.w    $7000                    ; 008819BC: MOVEQ #$00,D0
        dc.w    $7208                    ; 008819BE: MOVEQ #$08,D1
        dc.w    $1099                    ; 008819C0: dc.w $1099
        dc.w    $4E71                    ; 008819C2: NOP
        dc.w    $4E71                    ; 008819C4: NOP
        dc.w    $4E71                    ; 008819C6: NOP
        dc.w    $4E71                    ; 008819C8: NOP
        dc.w    $1410                    ; 008819CA: dc.w $1410
        dc.w    $C419                    ; 008819CC: dc.w $C419
        dc.w    $6700, $0004            ; 008819CE: BEQ.W $008819D4
        dc.w    $8001                    ; 008819D2: dc.w $8001
        dc.w    $E209                    ; 008819D4: dc.w $E209
        dc.w    $66E8                    ; 008819D6: BNE.S $008819C0
        dc.w    $4228                    ; 008819D8: dc.w $4228
        dc.w    $0006                    ; 008819DA: dc.w $0006
        dc.w    $4CDF, $0206            ; 008819DC: MOVEM.L (SP)+,regs
        dc.w    $33FC                    ; 008819E0: dc.w $33FC
        dc.w    $0000                    ; 008819E2: dc.w $0000
        dc.w    $00A1                    ; 008819E4: dc.w $00A1
        dc.w    $1100                    ; 008819E6: dc.w $1100
        dc.w    $4E75                    ; 008819E8: RTS
        dc.w    $400C                    ; 008819EA: dc.w $400C
        dc.w    $4003                    ; 008819EC: dc.w $4003
        dc.w    $000C                    ; 008819EE: dc.w $000C
        dc.w    $0003                    ; 008819F0: dc.w $0003
        dc.w    $00A1                    ; 008819F2: dc.w $00A1
        dc.w    $0003                    ; 008819F4: dc.w $0003
        dc.w    $00A1                    ; 008819F6: dc.w $00A1
        dc.w    $0005                    ; 008819F8: dc.w $0005
        dc.w    $00A1                    ; 008819FA: dc.w $00A1
        dc.w    $0007                    ; 008819FC: dc.w $0007
        dc.w    $3015                    ; 008819FE: dc.w $3015
        dc.w    $2ABC                    ; 00881A00: dc.w $2ABC
        dc.w    $6C00, $0003            ; 00881A02: BGE.W $00881A07
        dc.w    $3CB8                    ; 00881A06: dc.w $3CB8
        dc.w    $8000                    ; 00881A08: dc.w $8000
        dc.w    $3CB8                    ; 00881A0A: dc.w $3CB8
        dc.w    $8002                    ; 00881A0C: dc.w $8002
        dc.w    $2ABC                    ; 00881A0E: dc.w $2ABC
        dc.w    $4000                    ; 00881A10: dc.w $4000
        dc.w    $0010                    ; 00881A12: dc.w $0010
        dc.w    $3CB8                    ; 00881A14: dc.w $3CB8
        dc.w    $C880                    ; 00881A16: dc.w $C880
        dc.w    $3CB8                    ; 00881A18: dc.w $3CB8
        dc.w    $C882                    ; 00881A1A: dc.w $C882
        dc.w    $33FC                    ; 00881A1C: dc.w $33FC
        dc.w    $0100                    ; 00881A1E: dc.w $0100
        dc.w    $00A1                    ; 00881A20: dc.w $00A1
        dc.w    $1100                    ; 00881A22: dc.w $1100
        dc.w    $0839                    ; 00881A24: dc.w $0839
        dc.w    $0000                    ; 00881A26: dc.w $0000
        dc.w    $00A1                    ; 00881A28: dc.w $00A1
        dc.w    $1100                    ; 00881A2A: dc.w $1100
        dc.w    $66F6                    ; 00881A2C: BNE.S $00881A24
        dc.w    $3838                    ; 00881A2E: dc.w $3838
        dc.w    $C874                    ; 00881A30: dc.w $C874
        dc.w    $08C4                    ; 00881A32: dc.w $08C4
        dc.w    $0004                    ; 00881A34: dc.w $0004
        dc.w    $3A84                    ; 00881A36: dc.w $3A84
        dc.w    $2ABC                    ; 00881A38: dc.w $2ABC
        dc.w    $9340                    ; 00881A3A: dc.w $9340
        dc.w    $9400                    ; 00881A3C: dc.w $9400
        dc.w    $2ABC                    ; 00881A3E: dc.w $2ABC
        dc.w    $9540                    ; 00881A40: dc.w $9540
        dc.w    $96C2                    ; 00881A42: dc.w $96C2
        dc.w    $3ABC                    ; 00881A44: dc.w $3ABC
        dc.w    $977F                    ; 00881A46: dc.w $977F
        dc.w    $3ABC                    ; 00881A48: dc.w $3ABC
        dc.w    $C000                    ; 00881A4A: dc.w $C000
        dc.w    $31FC                    ; 00881A4C: dc.w $31FC
        dc.w    $0080                    ; 00881A4E: dc.w $0080
        dc.w    $C876                    ; 00881A50: dc.w $C876
        dc.w    $3AB8                    ; 00881A52: dc.w $3AB8
        dc.w    $C876                    ; 00881A54: dc.w $C876
        dc.w    $3AB8                    ; 00881A56: dc.w $3AB8
        dc.w    $C874                    ; 00881A58: dc.w $C874
        dc.w    $33FC                    ; 00881A5A: dc.w $33FC
        dc.w    $0000                    ; 00881A5C: dc.w $0000
        dc.w    $00A1                    ; 00881A5E: dc.w $00A1
        dc.w    $1100                    ; 00881A60: dc.w $1100
        dc.w    $4E75                    ; 00881A62: RTS
        dc.w    $31FC                    ; 00881A64: dc.w $31FC
        dc.w    $002C                    ; 00881A66: dc.w $002C
        dc.w    $C87A                    ; 00881A68: dc.w $C87A
        dc.w    $4EFA                    ; 00881A6A: dc.w $4EFA
        dc.w    $065A                    ; 00881A6C: dc.w $065A
        dc.w    $3015                    ; 00881A6E: dc.w $3015
        dc.w    $4E75                    ; 00881A70: RTS
        dc.w    $3015                    ; 00881A72: dc.w $3015
        dc.w    $2ABC                    ; 00881A74: dc.w $2ABC
        dc.w    $4000                    ; 00881A76: dc.w $4000
        dc.w    $0010                    ; 00881A78: dc.w $0010
        dc.w    $3CB8                    ; 00881A7A: dc.w $3CB8
        dc.w    $C880                    ; 00881A7C: dc.w $C880
        dc.w    $3CB8                    ; 00881A7E: dc.w $3CB8
        dc.w    $C882                    ; 00881A80: dc.w $C882
        dc.w    $33FC                    ; 00881A82: dc.w $33FC
        dc.w    $0100                    ; 00881A84: dc.w $0100
        dc.w    $00A1                    ; 00881A86: dc.w $00A1
        dc.w    $1100                    ; 00881A88: dc.w $1100
        dc.w    $0839                    ; 00881A8A: dc.w $0839
        dc.w    $0000                    ; 00881A8C: dc.w $0000
        dc.w    $00A1                    ; 00881A8E: dc.w $00A1
        dc.w    $1100                    ; 00881A90: dc.w $1100
        dc.w    $66F6                    ; 00881A92: BNE.S $00881A8A
        dc.w    $3838                    ; 00881A94: dc.w $3838
        dc.w    $C874                    ; 00881A96: dc.w $C874
        dc.w    $08C4                    ; 00881A98: dc.w $08C4
        dc.w    $0004                    ; 00881A9A: dc.w $0004
        dc.w    $3A84                    ; 00881A9C: dc.w $3A84
        dc.w    $2ABC                    ; 00881A9E: dc.w $2ABC
        dc.w    $9340                    ; 00881AA0: dc.w $9340
        dc.w    $9400                    ; 00881AA2: dc.w $9400
        dc.w    $2ABC                    ; 00881AA4: dc.w $2ABC
        dc.w    $9540                    ; 00881AA6: dc.w $9540
        dc.w    $96C2                    ; 00881AA8: dc.w $96C2
        dc.w    $3ABC                    ; 00881AAA: dc.w $3ABC
        dc.w    $977F                    ; 00881AAC: dc.w $977F
        dc.w    $3ABC                    ; 00881AAE: dc.w $3ABC
        dc.w    $C000                    ; 00881AB0: dc.w $C000
        dc.w    $31FC                    ; 00881AB2: dc.w $31FC
        dc.w    $0080                    ; 00881AB4: dc.w $0080
        dc.w    $C876                    ; 00881AB6: dc.w $C876
        dc.w    $3AB8                    ; 00881AB8: dc.w $3AB8
        dc.w    $C876                    ; 00881ABA: dc.w $C876
        dc.w    $3AB8                    ; 00881ABC: dc.w $3AB8
        dc.w    $C874                    ; 00881ABE: dc.w $C874
        dc.w    $33FC                    ; 00881AC0: dc.w $33FC
        dc.w    $0000                    ; 00881AC2: dc.w $0000
        dc.w    $00A1                    ; 00881AC4: dc.w $00A1
        dc.w    $1100                    ; 00881AC6: dc.w $1100
        dc.w    $4E75                    ; 00881AC8: RTS
        dc.w    $3015                    ; 00881ACA: dc.w $3015
        dc.w    $33FC                    ; 00881ACC: dc.w $33FC
        dc.w    $0100                    ; 00881ACE: dc.w $0100
        dc.w    $00A1                    ; 00881AD0: dc.w $00A1
        dc.w    $1100                    ; 00881AD2: dc.w $1100
        dc.w    $0839                    ; 00881AD4: dc.w $0839
        dc.w    $0000                    ; 00881AD6: dc.w $0000
        dc.w    $00A1                    ; 00881AD8: dc.w $00A1
        dc.w    $1100                    ; 00881ADA: dc.w $1100
        dc.w    $66F6                    ; 00881ADC: BNE.S $00881AD4
        dc.w    $3838                    ; 00881ADE: dc.w $3838
        dc.w    $C874                    ; 00881AE0: dc.w $C874
        dc.w    $08C4                    ; 00881AE2: dc.w $08C4
        dc.w    $0004                    ; 00881AE4: dc.w $0004
        dc.w    $3A84                    ; 00881AE6: dc.w $3A84
        dc.w    $2ABC                    ; 00881AE8: dc.w $2ABC
        dc.w    $9380                    ; 00881AEA: dc.w $9380
        dc.w    $9401                    ; 00881AEC: dc.w $9401
        dc.w    $2ABC                    ; 00881AEE: dc.w $2ABC
        dc.w    $951E                    ; 00881AF0: dc.w $951E
        dc.w    $96C0                    ; 00881AF2: dc.w $96C0
        dc.w    $3ABC                    ; 00881AF4: dc.w $3ABC
        dc.w    $977F                    ; 00881AF6: dc.w $977F
        dc.w    $3ABC                    ; 00881AF8: dc.w $3ABC
        dc.w    $6C3C                    ; 00881AFA: BGE.S $00881B38
        dc.w    $31FC                    ; 00881AFC: dc.w $31FC
        dc.w    $0083                    ; 00881AFE: dc.w $0083
        dc.w    $C876                    ; 00881B00: dc.w $C876
        dc.w    $3AB8                    ; 00881B02: dc.w $3AB8
        dc.w    $C876                    ; 00881B04: dc.w $C876
        dc.w    $3AB8                    ; 00881B06: dc.w $3AB8
        dc.w    $C874                    ; 00881B08: dc.w $C874
        dc.w    $33FC                    ; 00881B0A: dc.w $33FC
        dc.w    $0000                    ; 00881B0C: dc.w $0000
        dc.w    $00A1                    ; 00881B0E: dc.w $00A1
        dc.w    $1100                    ; 00881B10: dc.w $1100
        dc.w    $4E75                    ; 00881B12: RTS
        dc.w    $3015                    ; 00881B14: dc.w $3015
        dc.w    $2ABC                    ; 00881B16: dc.w $2ABC
        dc.w    $6C00, $0003            ; 00881B18: BGE.W $00881B1D
        dc.w    $3CB8                    ; 00881B1C: dc.w $3CB8
        dc.w    $8000                    ; 00881B1E: dc.w $8000
        dc.w    $3CB8                    ; 00881B20: dc.w $3CB8
        dc.w    $8002                    ; 00881B22: dc.w $8002
        dc.w    $2ABC                    ; 00881B24: dc.w $2ABC
        dc.w    $4000                    ; 00881B26: dc.w $4000
        dc.w    $0010                    ; 00881B28: dc.w $0010
        dc.w    $3CB8                    ; 00881B2A: dc.w $3CB8
        dc.w    $C880                    ; 00881B2C: dc.w $C880
        dc.w    $3CB8                    ; 00881B2E: dc.w $3CB8
        dc.w    $C882                    ; 00881B30: dc.w $C882
        dc.w    $33FC                    ; 00881B32: dc.w $33FC
        dc.w    $0100                    ; 00881B34: dc.w $0100
        dc.w    $00A1                    ; 00881B36: dc.w $00A1
        dc.w    $1100                    ; 00881B38: dc.w $1100
        dc.w    $0839                    ; 00881B3A: dc.w $0839
        dc.w    $0000                    ; 00881B3C: dc.w $0000
        dc.w    $00A1                    ; 00881B3E: dc.w $00A1
        dc.w    $1100                    ; 00881B40: dc.w $1100
        dc.w    $66F6                    ; 00881B42: BNE.S $00881B3A
        dc.w    $3838                    ; 00881B44: dc.w $3838
        dc.w    $C874                    ; 00881B46: dc.w $C874
        dc.w    $08C4                    ; 00881B48: dc.w $08C4
        dc.w    $0004                    ; 00881B4A: dc.w $0004
        dc.w    $3A84                    ; 00881B4C: dc.w $3A84
        dc.w    $2ABC                    ; 00881B4E: dc.w $2ABC
        dc.w    $9380                    ; 00881B50: dc.w $9380
        dc.w    $9403                    ; 00881B52: dc.w $9403
        dc.w    $2ABC                    ; 00881B54: dc.w $2ABC
        dc.w    $9500                    ; 00881B56: dc.w $9500
        dc.w    $9688                    ; 00881B58: dc.w $9688
        dc.w    $3ABC                    ; 00881B5A: dc.w $3ABC
        dc.w    $977F                    ; 00881B5C: dc.w $977F
        dc.w    $3ABC                    ; 00881B5E: dc.w $3ABC
        dc.w    $6000, $31FC            ; 00881B60: BRA.W $00884D5E
        dc.w    $0082                    ; 00881B64: dc.w $0082
        dc.w    $C876                    ; 00881B66: dc.w $C876
        dc.w    $3AB8                    ; 00881B68: dc.w $3AB8
        dc.w    $C876                    ; 00881B6A: dc.w $C876
        dc.w    $3AB8                    ; 00881B6C: dc.w $3AB8
        dc.w    $C874                    ; 00881B6E: dc.w $C874
        dc.w    $3838                    ; 00881B70: dc.w $3838
        dc.w    $C874                    ; 00881B72: dc.w $C874
        dc.w    $08C4                    ; 00881B74: dc.w $08C4
        dc.w    $0004                    ; 00881B76: dc.w $0004
        dc.w    $3A84                    ; 00881B78: dc.w $3A84
        dc.w    $2ABC                    ; 00881B7A: dc.w $2ABC
        dc.w    $9340                    ; 00881B7C: dc.w $9340
        dc.w    $9400                    ; 00881B7E: dc.w $9400
        dc.w    $2ABC                    ; 00881B80: dc.w $2ABC
        dc.w    $9540                    ; 00881B82: dc.w $9540
        dc.w    $96C2                    ; 00881B84: dc.w $96C2
        dc.w    $3ABC                    ; 00881B86: dc.w $3ABC
        dc.w    $977F                    ; 00881B88: dc.w $977F
        dc.w    $3ABC                    ; 00881B8A: dc.w $3ABC
        dc.w    $C000                    ; 00881B8C: dc.w $C000
        dc.w    $31FC                    ; 00881B8E: dc.w $31FC
        dc.w    $0080                    ; 00881B90: dc.w $0080
        dc.w    $C876                    ; 00881B92: dc.w $C876
        dc.w    $3AB8                    ; 00881B94: dc.w $3AB8
        dc.w    $C876                    ; 00881B96: dc.w $C876
        dc.w    $3AB8                    ; 00881B98: dc.w $3AB8
        dc.w    $C874                    ; 00881B9A: dc.w $C874
        dc.w    $33FC                    ; 00881B9C: dc.w $33FC
        dc.w    $0000                    ; 00881B9E: dc.w $0000
        dc.w    $00A1                    ; 00881BA0: dc.w $00A1
        dc.w    $1100                    ; 00881BA2: dc.w $1100
        dc.w    $4EFA                    ; 00881BA4: dc.w $4EFA
        dc.w    $FBF8                    ; 00881BA6: dc.w $FBF8
        dc.w    $3015                    ; 00881BA8: dc.w $3015
        dc.w    $33FC                    ; 00881BAA: dc.w $33FC
        dc.w    $0100                    ; 00881BAC: dc.w $0100
        dc.w    $00A1                    ; 00881BAE: dc.w $00A1
        dc.w    $1100                    ; 00881BB0: dc.w $1100
        dc.w    $0839                    ; 00881BB2: dc.w $0839
        dc.w    $0000                    ; 00881BB4: dc.w $0000
        dc.w    $00A1                    ; 00881BB6: dc.w $00A1
        dc.w    $1100                    ; 00881BB8: dc.w $1100
        dc.w    $66F6                    ; 00881BBA: BNE.S $00881BB2
        dc.w    $3838                    ; 00881BBC: dc.w $3838
        dc.w    $C874                    ; 00881BBE: dc.w $C874
        dc.w    $08C4                    ; 00881BC0: dc.w $08C4
        dc.w    $0004                    ; 00881BC2: dc.w $0004
        dc.w    $3A84                    ; 00881BC4: dc.w $3A84
        dc.w    $2ABC                    ; 00881BC6: dc.w $2ABC
        dc.w    $9380                    ; 00881BC8: dc.w $9380
        dc.w    $9403                    ; 00881BCA: dc.w $9403
        dc.w    $2ABC                    ; 00881BCC: dc.w $2ABC
        dc.w    $9500                    ; 00881BCE: dc.w $9500
        dc.w    $9688                    ; 00881BD0: dc.w $9688
        dc.w    $3ABC                    ; 00881BD2: dc.w $3ABC
        dc.w    $977F                    ; 00881BD4: dc.w $977F
        dc.w    $3ABC                    ; 00881BD6: dc.w $3ABC
        dc.w    $6000, $31FC            ; 00881BD8: BRA.W $00884DD6
        dc.w    $0082                    ; 00881BDC: dc.w $0082
        dc.w    $C876                    ; 00881BDE: dc.w $C876
        dc.w    $3AB8                    ; 00881BE0: dc.w $3AB8
        dc.w    $C876                    ; 00881BE2: dc.w $C876
        dc.w    $3AB8                    ; 00881BE4: dc.w $3AB8
        dc.w    $C874                    ; 00881BE6: dc.w $C874
        dc.w    $3838                    ; 00881BE8: dc.w $3838
        dc.w    $C874                    ; 00881BEA: dc.w $C874
        dc.w    $08C4                    ; 00881BEC: dc.w $08C4
        dc.w    $0004                    ; 00881BEE: dc.w $0004
        dc.w    $3A84                    ; 00881BF0: dc.w $3A84
        dc.w    $2ABC                    ; 00881BF2: dc.w $2ABC
        dc.w    $9380                    ; 00881BF4: dc.w $9380
        dc.w    $9403                    ; 00881BF6: dc.w $9403
        dc.w    $2ABC                    ; 00881BF8: dc.w $2ABC
        dc.w    $9580                    ; 00881BFA: dc.w $9580
        dc.w    $968B                    ; 00881BFC: dc.w $968B
        dc.w    $3ABC                    ; 00881BFE: dc.w $3ABC
        dc.w    $977F                    ; 00881C00: dc.w $977F
        dc.w    $3ABC                    ; 00881C02: dc.w $3ABC
        dc.w    $4000                    ; 00881C04: dc.w $4000
        dc.w    $31FC                    ; 00881C06: dc.w $31FC
        dc.w    $0083                    ; 00881C08: dc.w $0083
        dc.w    $C876                    ; 00881C0A: dc.w $C876
        dc.w    $3AB8                    ; 00881C0C: dc.w $3AB8
        dc.w    $C876                    ; 00881C0E: dc.w $C876
        dc.w    $3AB8                    ; 00881C10: dc.w $3AB8
        dc.w    $C874                    ; 00881C12: dc.w $C874
        dc.w    $3838                    ; 00881C14: dc.w $3838
        dc.w    $C874                    ; 00881C16: dc.w $C874
        dc.w    $08C4                    ; 00881C18: dc.w $08C4
        dc.w    $0004                    ; 00881C1A: dc.w $0004
        dc.w    $3A84                    ; 00881C1C: dc.w $3A84
        dc.w    $2ABC                    ; 00881C1E: dc.w $2ABC
        dc.w    $9340                    ; 00881C20: dc.w $9340
        dc.w    $9400                    ; 00881C22: dc.w $9400
        dc.w    $2ABC                    ; 00881C24: dc.w $2ABC
        dc.w    $9540                    ; 00881C26: dc.w $9540
        dc.w    $96C2                    ; 00881C28: dc.w $96C2
        dc.w    $3ABC                    ; 00881C2A: dc.w $3ABC
        dc.w    $977F                    ; 00881C2C: dc.w $977F
        dc.w    $3ABC                    ; 00881C2E: dc.w $3ABC
        dc.w    $C000                    ; 00881C30: dc.w $C000
        dc.w    $31FC                    ; 00881C32: dc.w $31FC
        dc.w    $0080                    ; 00881C34: dc.w $0080
        dc.w    $C876                    ; 00881C36: dc.w $C876
        dc.w    $3AB8                    ; 00881C38: dc.w $3AB8
        dc.w    $C876                    ; 00881C3A: dc.w $C876
        dc.w    $3AB8                    ; 00881C3C: dc.w $3AB8
        dc.w    $C874                    ; 00881C3E: dc.w $C874
        dc.w    $33FC                    ; 00881C40: dc.w $33FC
        dc.w    $0000                    ; 00881C42: dc.w $0000
        dc.w    $00A1                    ; 00881C44: dc.w $00A1
        dc.w    $1100                    ; 00881C46: dc.w $1100
        dc.w    $2ABC                    ; 00881C48: dc.w $2ABC
        dc.w    $6C00, $0003            ; 00881C4A: BGE.W $00881C4F
        dc.w    $3CB8                    ; 00881C4E: dc.w $3CB8
        dc.w    $8000                    ; 00881C50: dc.w $8000
        dc.w    $3CB8                    ; 00881C52: dc.w $3CB8
        dc.w    $8002                    ; 00881C54: dc.w $8002
        dc.w    $2ABC                    ; 00881C56: dc.w $2ABC
        dc.w    $4000                    ; 00881C58: dc.w $4000
        dc.w    $0010                    ; 00881C5A: dc.w $0010
        dc.w    $3CB8                    ; 00881C5C: dc.w $3CB8
        dc.w    $C880                    ; 00881C5E: dc.w $C880
        dc.w    $3CB8                    ; 00881C60: dc.w $3CB8
        dc.w    $C882                    ; 00881C62: dc.w $C882
        dc.w    $4E75                    ; 00881C64: RTS
        dc.w    $3015                    ; 00881C66: dc.w $3015
        dc.w    $2ABC                    ; 00881C68: dc.w $2ABC
        dc.w    $6C00, $0003            ; 00881C6A: BGE.W $00881C6F
        dc.w    $3CB8                    ; 00881C6E: dc.w $3CB8
        dc.w    $8000                    ; 00881C70: dc.w $8000
        dc.w    $3CB8                    ; 00881C72: dc.w $3CB8
        dc.w    $8002                    ; 00881C74: dc.w $8002
        dc.w    $2ABC                    ; 00881C76: dc.w $2ABC
        dc.w    $4000                    ; 00881C78: dc.w $4000
        dc.w    $0010                    ; 00881C7A: dc.w $0010
        dc.w    $3CB8                    ; 00881C7C: dc.w $3CB8
        dc.w    $C880                    ; 00881C7E: dc.w $C880
        dc.w    $3CB8                    ; 00881C80: dc.w $3CB8
        dc.w    $C882                    ; 00881C82: dc.w $C882
        dc.w    $33FC                    ; 00881C84: dc.w $33FC
        dc.w    $0100                    ; 00881C86: dc.w $0100
        dc.w    $00A1                    ; 00881C88: dc.w $00A1
        dc.w    $1100                    ; 00881C8A: dc.w $1100
        dc.w    $0839                    ; 00881C8C: dc.w $0839
        dc.w    $0000                    ; 00881C8E: dc.w $0000
        dc.w    $00A1                    ; 00881C90: dc.w $00A1
        dc.w    $1100                    ; 00881C92: dc.w $1100
        dc.w    $66F6                    ; 00881C94: BNE.S $00881C8C
        dc.w    $3838                    ; 00881C96: dc.w $3838
        dc.w    $C874                    ; 00881C98: dc.w $C874
        dc.w    $08C4                    ; 00881C9A: dc.w $08C4
        dc.w    $0004                    ; 00881C9C: dc.w $0004
        dc.w    $3A84                    ; 00881C9E: dc.w $3A84
        dc.w    $2ABC                    ; 00881CA0: dc.w $2ABC
        dc.w    $9340                    ; 00881CA2: dc.w $9340
        dc.w    $9400                    ; 00881CA4: dc.w $9400
        dc.w    $2ABC                    ; 00881CA6: dc.w $2ABC
        dc.w    $9540                    ; 00881CA8: dc.w $9540
        dc.w    $96C2                    ; 00881CAA: dc.w $96C2
        dc.w    $3ABC                    ; 00881CAC: dc.w $3ABC
        dc.w    $977F                    ; 00881CAE: dc.w $977F
        dc.w    $3ABC                    ; 00881CB0: dc.w $3ABC
        dc.w    $C000                    ; 00881CB2: dc.w $C000
        dc.w    $31FC                    ; 00881CB4: dc.w $31FC
        dc.w    $0080                    ; 00881CB6: dc.w $0080
        dc.w    $C876                    ; 00881CB8: dc.w $C876
        dc.w    $3AB8                    ; 00881CBA: dc.w $3AB8
        dc.w    $C876                    ; 00881CBC: dc.w $C876
        dc.w    $3AB8                    ; 00881CBE: dc.w $3AB8
        dc.w    $C874                    ; 00881CC0: dc.w $C874
        dc.w    $33FC                    ; 00881CC2: dc.w $33FC
        dc.w    $0000                    ; 00881CC4: dc.w $0000
        dc.w    $00A1                    ; 00881CC6: dc.w $00A1
        dc.w    $1100                    ; 00881CC8: dc.w $1100
        dc.w    $4A39                    ; 00881CCA: dc.w $4A39
        dc.w    $00A1                    ; 00881CCC: dc.w $00A1
        dc.w    $5120                    ; 00881CCE: dc.w $5120
        dc.w    $6638                    ; 00881CD0: BNE.S $00881D0A
        dc.w    $08B9                    ; 00881CD2: dc.w $08B9
        dc.w    $0007                    ; 00881CD4: dc.w $0007
        dc.w    $00A1                    ; 00881CD6: dc.w $00A1
        dc.w    $5100                    ; 00881CD8: dc.w $5100
        dc.w    $0839                    ; 00881CDA: dc.w $0839
        dc.w    $0007                    ; 00881CDC: dc.w $0007
        dc.w    $00A1                    ; 00881CDE: dc.w $00A1
        dc.w    $518A                    ; 00881CE0: dc.w $518A
        dc.w    $67F6                    ; 00881CE2: BEQ.S $00881CDA
        dc.w    $4EBA                    ; 00881CE4: dc.w $4EBA
        dc.w    $0B92                    ; 00881CE6: dc.w $0B92
        dc.w    $0878                    ; 00881CE8: dc.w $0878
        dc.w    $0000                    ; 00881CEA: dc.w $0000
        dc.w    $C80C                    ; 00881CEC: dc.w $C80C
        dc.w    $660A                    ; 00881CEE: BNE.S $00881CFA
        dc.w    $08F9                    ; 00881CF0: dc.w $08F9
        dc.w    $0000                    ; 00881CF2: dc.w $0000
        dc.w    $00A1                    ; 00881CF4: dc.w $00A1
        dc.w    $518B                    ; 00881CF6: dc.w $518B
        dc.w    $6008                    ; 00881CF8: BRA.S $00881D02
        dc.w    $08B9                    ; 00881CFA: dc.w $08B9
        dc.w    $0000                    ; 00881CFC: dc.w $0000
        dc.w    $00A1                    ; 00881CFE: dc.w $00A1
        dc.w    $518B                    ; 00881D00: dc.w $518B
        dc.w    $08F9                    ; 00881D02: dc.w $08F9
        dc.w    $0007                    ; 00881D04: dc.w $0007
        dc.w    $00A1                    ; 00881D06: dc.w $00A1
        dc.w    $5100                    ; 00881D08: dc.w $5100
        dc.w    $4E75                    ; 00881D0A: RTS
        dc.w    $3015                    ; 00881D0C: dc.w $3015
        dc.w    $2ABC                    ; 00881D0E: dc.w $2ABC
        dc.w    $6C00, $0003            ; 00881D10: BGE.W $00881D15
        dc.w    $3CB8                    ; 00881D14: dc.w $3CB8
        dc.w    $8000                    ; 00881D16: dc.w $8000
        dc.w    $3CB8                    ; 00881D18: dc.w $3CB8
        dc.w    $8002                    ; 00881D1A: dc.w $8002
        dc.w    $2ABC                    ; 00881D1C: dc.w $2ABC
        dc.w    $4000                    ; 00881D1E: dc.w $4000
        dc.w    $0010                    ; 00881D20: dc.w $0010
        dc.w    $3CB8                    ; 00881D22: dc.w $3CB8
        dc.w    $C880                    ; 00881D24: dc.w $C880
        dc.w    $3CB8                    ; 00881D26: dc.w $3CB8
        dc.w    $C882                    ; 00881D28: dc.w $C882
        dc.w    $33FC                    ; 00881D2A: dc.w $33FC
        dc.w    $0100                    ; 00881D2C: dc.w $0100
        dc.w    $00A1                    ; 00881D2E: dc.w $00A1
        dc.w    $1100                    ; 00881D30: dc.w $1100
        dc.w    $0839                    ; 00881D32: dc.w $0839
        dc.w    $0000                    ; 00881D34: dc.w $0000
        dc.w    $00A1                    ; 00881D36: dc.w $00A1
        dc.w    $1100                    ; 00881D38: dc.w $1100
        dc.w    $66F6                    ; 00881D3A: BNE.S $00881D32
        dc.w    $3838                    ; 00881D3C: dc.w $3838
        dc.w    $C874                    ; 00881D3E: dc.w $C874
        dc.w    $08C4                    ; 00881D40: dc.w $08C4
        dc.w    $0004                    ; 00881D42: dc.w $0004
        dc.w    $3A84                    ; 00881D44: dc.w $3A84
        dc.w    $2ABC                    ; 00881D46: dc.w $2ABC
        dc.w    $9340                    ; 00881D48: dc.w $9340
        dc.w    $9400                    ; 00881D4A: dc.w $9400
        dc.w    $2ABC                    ; 00881D4C: dc.w $2ABC
        dc.w    $9540                    ; 00881D4E: dc.w $9540
        dc.w    $96C2                    ; 00881D50: dc.w $96C2
        dc.w    $3ABC                    ; 00881D52: dc.w $3ABC
        dc.w    $977F                    ; 00881D54: dc.w $977F
        dc.w    $3ABC                    ; 00881D56: dc.w $3ABC
        dc.w    $C000                    ; 00881D58: dc.w $C000
        dc.w    $31FC                    ; 00881D5A: dc.w $31FC
        dc.w    $0080                    ; 00881D5C: dc.w $0080
        dc.w    $C876                    ; 00881D5E: dc.w $C876
        dc.w    $3AB8                    ; 00881D60: dc.w $3AB8
        dc.w    $C876                    ; 00881D62: dc.w $C876
        dc.w    $3AB8                    ; 00881D64: dc.w $3AB8
        dc.w    $C874                    ; 00881D66: dc.w $C874
        dc.w    $33FC                    ; 00881D68: dc.w $33FC
        dc.w    $0000                    ; 00881D6A: dc.w $0000
        dc.w    $00A1                    ; 00881D6C: dc.w $00A1
        dc.w    $1100                    ; 00881D6E: dc.w $1100
        dc.w    $0839                    ; 00881D70: dc.w $0839
        dc.w    $0000                    ; 00881D72: dc.w $0000
        dc.w    $00A1                    ; 00881D74: dc.w $00A1
        dc.w    $5123                    ; 00881D76: dc.w $5123
        dc.w    $6742                    ; 00881D78: BEQ.S $00881DBC
        dc.w    $08B9                    ; 00881D7A: dc.w $08B9
        dc.w    $0000                    ; 00881D7C: dc.w $0000
        dc.w    $00A1                    ; 00881D7E: dc.w $00A1
        dc.w    $5123                    ; 00881D80: dc.w $5123
        dc.w    $31FC                    ; 00881D82: dc.w $31FC
        dc.w    $0000                    ; 00881D84: dc.w $0000
        dc.w    $C87E                    ; 00881D86: dc.w $C87E
        dc.w    $08B9                    ; 00881D88: dc.w $08B9
        dc.w    $0007                    ; 00881D8A: dc.w $0007
        dc.w    $00A1                    ; 00881D8C: dc.w $00A1
        dc.w    $5100                    ; 00881D8E: dc.w $5100
        dc.w    $0839                    ; 00881D90: dc.w $0839
        dc.w    $0007                    ; 00881D92: dc.w $0007
        dc.w    $00A1                    ; 00881D94: dc.w $00A1
        dc.w    $518A                    ; 00881D96: dc.w $518A
        dc.w    $67F6                    ; 00881D98: BEQ.S $00881D90
        dc.w    $0878                    ; 00881D9A: dc.w $0878
        dc.w    $0000                    ; 00881D9C: dc.w $0000
        dc.w    $C80C                    ; 00881D9E: dc.w $C80C
        dc.w    $660A                    ; 00881DA0: BNE.S $00881DAC
        dc.w    $08F9                    ; 00881DA2: dc.w $08F9
        dc.w    $0000                    ; 00881DA4: dc.w $0000
        dc.w    $00A1                    ; 00881DA6: dc.w $00A1
        dc.w    $518B                    ; 00881DA8: dc.w $518B
        dc.w    $6008                    ; 00881DAA: BRA.S $00881DB4
        dc.w    $08B9                    ; 00881DAC: dc.w $08B9
        dc.w    $0000                    ; 00881DAE: dc.w $0000
        dc.w    $00A1                    ; 00881DB0: dc.w $00A1
        dc.w    $518B                    ; 00881DB2: dc.w $518B
        dc.w    $08F9                    ; 00881DB4: dc.w $08F9
        dc.w    $0007                    ; 00881DB6: dc.w $0007
        dc.w    $00A1                    ; 00881DB8: dc.w $00A1
        dc.w    $5100                    ; 00881DBA: dc.w $5100
        dc.w    $4E75                    ; 00881DBC: RTS
        dc.w    $3015                    ; 00881DBE: dc.w $3015
        dc.w    $3E3C                    ; 00881DC0: dc.w $3E3C
        dc.w    $0063                    ; 00881DC2: dc.w $0063
        dc.w    $4E71                    ; 00881DC4: NOP
        dc.w    $51CF, $FFFC            ; 00881DC6: DBRA D7,$00881DC4
        dc.w    $2ABC                    ; 00881DCA: dc.w $2ABC
        dc.w    $6C00, $0003            ; 00881DCC: BGE.W $00881DD1
        dc.w    $3CB8                    ; 00881DD0: dc.w $3CB8
        dc.w    $8000                    ; 00881DD2: dc.w $8000
        dc.w    $3CB8                    ; 00881DD4: dc.w $3CB8
        dc.w    $8002                    ; 00881DD6: dc.w $8002
        dc.w    $2ABC                    ; 00881DD8: dc.w $2ABC
        dc.w    $4000                    ; 00881DDA: dc.w $4000
        dc.w    $0010                    ; 00881DDC: dc.w $0010
        dc.w    $3CB8                    ; 00881DDE: dc.w $3CB8
        dc.w    $C880                    ; 00881DE0: dc.w $C880
        dc.w    $3CB8                    ; 00881DE2: dc.w $3CB8
        dc.w    $C882                    ; 00881DE4: dc.w $C882
        dc.w    $0839                    ; 00881DE6: dc.w $0839
        dc.w    $0000                    ; 00881DE8: dc.w $0000
        dc.w    $00A1                    ; 00881DEA: dc.w $00A1
        dc.w    $5123                    ; 00881DEC: dc.w $5123
        dc.w    $6750                    ; 00881DEE: BEQ.S $00881E40
        dc.w    $08B9                    ; 00881DF0: dc.w $08B9
        dc.w    $0000                    ; 00881DF2: dc.w $0000
        dc.w    $00A1                    ; 00881DF4: dc.w $00A1
        dc.w    $5123                    ; 00881DF6: dc.w $5123
        dc.w    $0C38                    ; 00881DF8: dc.w $0C38
        dc.w    $0018                    ; 00881DFA: dc.w $0018
        dc.w    $C8C5                    ; 00881DFC: dc.w $C8C5
        dc.w    $6606                    ; 00881DFE: BNE.S $00881E06
        dc.w    $31FC                    ; 00881E00: dc.w $31FC
        dc.w    $0000                    ; 00881E02: dc.w $0000
        dc.w    $C87E                    ; 00881E04: dc.w $C87E
        dc.w    $11FC                    ; 00881E06: dc.w $11FC
        dc.w    $0000                    ; 00881E08: dc.w $0000
        dc.w    $C8C4                    ; 00881E0A: dc.w $C8C4
        dc.w    $08B9                    ; 00881E0C: dc.w $08B9
        dc.w    $0007                    ; 00881E0E: dc.w $0007
        dc.w    $00A1                    ; 00881E10: dc.w $00A1
        dc.w    $5100                    ; 00881E12: dc.w $5100
        dc.w    $0839                    ; 00881E14: dc.w $0839
        dc.w    $0007                    ; 00881E16: dc.w $0007
        dc.w    $00A1                    ; 00881E18: dc.w $00A1
        dc.w    $518A                    ; 00881E1A: dc.w $518A
        dc.w    $67F6                    ; 00881E1C: BEQ.S $00881E14
        dc.w    $0878                    ; 00881E1E: dc.w $0878
        dc.w    $0000                    ; 00881E20: dc.w $0000
        dc.w    $C80C                    ; 00881E22: dc.w $C80C
        dc.w    $660A                    ; 00881E24: BNE.S $00881E30
        dc.w    $08F9                    ; 00881E26: dc.w $08F9
        dc.w    $0000                    ; 00881E28: dc.w $0000
        dc.w    $00A1                    ; 00881E2A: dc.w $00A1
        dc.w    $518B                    ; 00881E2C: dc.w $518B
        dc.w    $6008                    ; 00881E2E: BRA.S $00881E38
        dc.w    $08B9                    ; 00881E30: dc.w $08B9
        dc.w    $0000                    ; 00881E32: dc.w $0000
        dc.w    $00A1                    ; 00881E34: dc.w $00A1
        dc.w    $518B                    ; 00881E36: dc.w $518B
        dc.w    $08F9                    ; 00881E38: dc.w $08F9
        dc.w    $0007                    ; 00881E3A: dc.w $0007
        dc.w    $00A1                    ; 00881E3C: dc.w $00A1
        dc.w    $5100                    ; 00881E3E: dc.w $5100
        dc.w    $4E75                    ; 00881E40: RTS
        dc.w    $3015                    ; 00881E42: dc.w $3015
        dc.w    $2ABC                    ; 00881E44: dc.w $2ABC
        dc.w    $6C00, $0003            ; 00881E46: BGE.W $00881E4B
        dc.w    $3CB8                    ; 00881E4A: dc.w $3CB8
        dc.w    $8000                    ; 00881E4C: dc.w $8000
        dc.w    $3CB8                    ; 00881E4E: dc.w $3CB8
        dc.w    $8002                    ; 00881E50: dc.w $8002
        dc.w    $2ABC                    ; 00881E52: dc.w $2ABC
        dc.w    $4000                    ; 00881E54: dc.w $4000
        dc.w    $0010                    ; 00881E56: dc.w $0010
        dc.w    $3CB8                    ; 00881E58: dc.w $3CB8
        dc.w    $C880                    ; 00881E5A: dc.w $C880
        dc.w    $3CB8                    ; 00881E5C: dc.w $3CB8
        dc.w    $C882                    ; 00881E5E: dc.w $C882
        dc.w    $31FC                    ; 00881E60: dc.w $31FC
        dc.w    $0000                    ; 00881E62: dc.w $0000
        dc.w    $C87E                    ; 00881E64: dc.w $C87E
        dc.w    $0878                    ; 00881E66: dc.w $0878
        dc.w    $0000                    ; 00881E68: dc.w $0000
        dc.w    $C80C                    ; 00881E6A: dc.w $C80C
        dc.w    $660A                    ; 00881E6C: BNE.S $00881E78
        dc.w    $08F9                    ; 00881E6E: dc.w $08F9
        dc.w    $0000                    ; 00881E70: dc.w $0000
        dc.w    $00A1                    ; 00881E72: dc.w $00A1
        dc.w    $518B                    ; 00881E74: dc.w $518B
        dc.w    $6008                    ; 00881E76: BRA.S $00881E80
        dc.w    $08B9                    ; 00881E78: dc.w $08B9
        dc.w    $0000                    ; 00881E7A: dc.w $0000
        dc.w    $00A1                    ; 00881E7C: dc.w $00A1
        dc.w    $518B                    ; 00881E7E: dc.w $518B
        dc.w    $41F8                    ; 00881E80: dc.w $41F8
        dc.w    $A100                    ; 00881E82: dc.w $A100
        dc.w    $43F9, $00A1, $5200    ; 00881E84: LEA $00A15200,A1
        dc.w    $707F                    ; 00881E8A: MOVEQ #$7F,D0
        dc.w    $22D8                    ; 00881E8C: MOVE.L (A0)+,(A1)+
        dc.w    $51C8, $FFFC            ; 00881E8E: DBRA D0,$00881E8C
        dc.w    $4E75                    ; 00881E92: RTS
        dc.w    $3015                    ; 00881E94: dc.w $3015
        dc.w    $33FC                    ; 00881E96: dc.w $33FC
        dc.w    $0100                    ; 00881E98: dc.w $0100
        dc.w    $00A1                    ; 00881E9A: dc.w $00A1
        dc.w    $1100                    ; 00881E9C: dc.w $1100
        dc.w    $0839                    ; 00881E9E: dc.w $0839
        dc.w    $0000                    ; 00881EA0: dc.w $0000
        dc.w    $00A1                    ; 00881EA2: dc.w $00A1
        dc.w    $1100                    ; 00881EA4: dc.w $1100
        dc.w    $66F6                    ; 00881EA6: BNE.S $00881E9E
        dc.w    $3838                    ; 00881EA8: dc.w $3838
        dc.w    $C874                    ; 00881EAA: dc.w $C874
        dc.w    $08C4                    ; 00881EAC: dc.w $08C4
        dc.w    $0004                    ; 00881EAE: dc.w $0004
        dc.w    $3A84                    ; 00881EB0: dc.w $3A84
        dc.w    $2ABC                    ; 00881EB2: dc.w $2ABC
        dc.w    $9320                    ; 00881EB4: dc.w $9320
        dc.w    $9400                    ; 00881EB6: dc.w $9400
        dc.w    $2ABC                    ; 00881EB8: dc.w $2ABC
        dc.w    $9500                    ; 00881EBA: dc.w $9500
        dc.w    $96D8                    ; 00881EBC: dc.w $96D8
        dc.w    $3ABC                    ; 00881EBE: dc.w $3ABC
        dc.w    $977F                    ; 00881EC0: dc.w $977F
        dc.w    $3ABC                    ; 00881EC2: dc.w $3ABC
        dc.w    $C000                    ; 00881EC4: dc.w $C000
        dc.w    $31FC                    ; 00881EC6: dc.w $31FC
        dc.w    $0080                    ; 00881EC8: dc.w $0080
        dc.w    $C876                    ; 00881ECA: dc.w $C876
        dc.w    $3AB8                    ; 00881ECC: dc.w $3AB8
        dc.w    $C876                    ; 00881ECE: dc.w $C876
        dc.w    $3AB8                    ; 00881ED0: dc.w $3AB8
        dc.w    $C874                    ; 00881ED2: dc.w $C874
        dc.w    $33FC                    ; 00881ED4: dc.w $33FC
        dc.w    $0000                    ; 00881ED6: dc.w $0000
        dc.w    $00A1                    ; 00881ED8: dc.w $00A1
        dc.w    $1100                    ; 00881EDA: dc.w $1100
        dc.w    $0839                    ; 00881EDC: dc.w $0839
        dc.w    $0000                    ; 00881EDE: dc.w $0000
        dc.w    $00A1                    ; 00881EE0: dc.w $00A1
        dc.w    $5123                    ; 00881EE2: dc.w $5123
        dc.w    $6762                    ; 00881EE4: BEQ.S $00881F48
        dc.w    $08B9                    ; 00881EE6: dc.w $08B9
        dc.w    $0000                    ; 00881EE8: dc.w $0000
        dc.w    $00A1                    ; 00881EEA: dc.w $00A1
        dc.w    $5123                    ; 00881EEC: dc.w $5123
        dc.w    $0C38                    ; 00881EEE: dc.w $0C38
        dc.w    $0018                    ; 00881EF0: dc.w $0018
        dc.w    $C8C5                    ; 00881EF2: dc.w $C8C5
        dc.w    $6606                    ; 00881EF4: BNE.S $00881EFC
        dc.w    $31FC                    ; 00881EF6: dc.w $31FC
        dc.w    $0000                    ; 00881EF8: dc.w $0000
        dc.w    $C87E                    ; 00881EFA: dc.w $C87E
        dc.w    $11FC                    ; 00881EFC: dc.w $11FC
        dc.w    $0000                    ; 00881EFE: dc.w $0000
        dc.w    $C8C4                    ; 00881F00: dc.w $C8C4
        dc.w    $08B9                    ; 00881F02: dc.w $08B9
        dc.w    $0007                    ; 00881F04: dc.w $0007
        dc.w    $00A1                    ; 00881F06: dc.w $00A1
        dc.w    $5100                    ; 00881F08: dc.w $5100
        dc.w    $0839                    ; 00881F0A: dc.w $0839
        dc.w    $0007                    ; 00881F0C: dc.w $0007
        dc.w    $00A1                    ; 00881F0E: dc.w $00A1
        dc.w    $518A                    ; 00881F10: dc.w $518A
        dc.w    $67F6                    ; 00881F12: BEQ.S $00881F0A
        dc.w    $43F8                    ; 00881F14: dc.w $43F8
        dc.w    $B400                    ; 00881F16: dc.w $B400
        dc.w    $45F9, $00A1, $5200    ; 00881F18: LEA $00A15200,A2
        dc.w    $4EBA                    ; 00881F1E: dc.w $4EBA
        dc.w    $29B6                    ; 00881F20: dc.w $29B6
        dc.w    $4EBA                    ; 00881F22: dc.w $4EBA
        dc.w    $29B6                    ; 00881F24: dc.w $29B6
        dc.w    $0878                    ; 00881F26: dc.w $0878
        dc.w    $0000                    ; 00881F28: dc.w $0000
        dc.w    $C80C                    ; 00881F2A: dc.w $C80C
        dc.w    $660A                    ; 00881F2C: BNE.S $00881F38
        dc.w    $08F9                    ; 00881F2E: dc.w $08F9
        dc.w    $0000                    ; 00881F30: dc.w $0000
        dc.w    $00A1                    ; 00881F32: dc.w $00A1
        dc.w    $518B                    ; 00881F34: dc.w $518B
        dc.w    $6008                    ; 00881F36: BRA.S $00881F40
        dc.w    $08B9                    ; 00881F38: dc.w $08B9
        dc.w    $0000                    ; 00881F3A: dc.w $0000
        dc.w    $00A1                    ; 00881F3C: dc.w $00A1
        dc.w    $518B                    ; 00881F3E: dc.w $518B
        dc.w    $08F9                    ; 00881F40: dc.w $08F9
        dc.w    $0007                    ; 00881F42: dc.w $0007
        dc.w    $00A1                    ; 00881F44: dc.w $00A1
        dc.w    $5100                    ; 00881F46: dc.w $5100
        dc.w    $4E75                    ; 00881F48: RTS
        dc.w    $3015                    ; 00881F4A: dc.w $3015
        dc.w    $2ABC                    ; 00881F4C: dc.w $2ABC
        dc.w    $6C00, $0003            ; 00881F4E: BGE.W $00881F53
        dc.w    $3CB8                    ; 00881F52: dc.w $3CB8
        dc.w    $8000                    ; 00881F54: dc.w $8000
        dc.w    $3CB8                    ; 00881F56: dc.w $3CB8
        dc.w    $8002                    ; 00881F58: dc.w $8002
        dc.w    $2ABC                    ; 00881F5A: dc.w $2ABC
        dc.w    $4000                    ; 00881F5C: dc.w $4000
        dc.w    $0010                    ; 00881F5E: dc.w $0010
        dc.w    $3CB8                    ; 00881F60: dc.w $3CB8
        dc.w    $C880                    ; 00881F62: dc.w $C880
        dc.w    $3CB8                    ; 00881F64: dc.w $3CB8
        dc.w    $C882                    ; 00881F66: dc.w $C882
        dc.w    $33FC                    ; 00881F68: dc.w $33FC
        dc.w    $0100                    ; 00881F6A: dc.w $0100
        dc.w    $00A1                    ; 00881F6C: dc.w $00A1
        dc.w    $1100                    ; 00881F6E: dc.w $1100
        dc.w    $0839                    ; 00881F70: dc.w $0839
        dc.w    $0000                    ; 00881F72: dc.w $0000
        dc.w    $00A1                    ; 00881F74: dc.w $00A1
        dc.w    $1100                    ; 00881F76: dc.w $1100
        dc.w    $66F6                    ; 00881F78: BNE.S $00881F70
        dc.w    $3838                    ; 00881F7A: dc.w $3838
        dc.w    $C874                    ; 00881F7C: dc.w $C874
        dc.w    $08C4                    ; 00881F7E: dc.w $08C4
        dc.w    $0004                    ; 00881F80: dc.w $0004
        dc.w    $3A84                    ; 00881F82: dc.w $3A84
        dc.w    $2ABC                    ; 00881F84: dc.w $2ABC
        dc.w    $9320                    ; 00881F86: dc.w $9320
        dc.w    $9400                    ; 00881F88: dc.w $9400
        dc.w    $2ABC                    ; 00881F8A: dc.w $2ABC
        dc.w    $9540                    ; 00881F8C: dc.w $9540
        dc.w    $96C2                    ; 00881F8E: dc.w $96C2
        dc.w    $3ABC                    ; 00881F90: dc.w $3ABC
        dc.w    $977F                    ; 00881F92: dc.w $977F
        dc.w    $3ABC                    ; 00881F94: dc.w $3ABC
        dc.w    $C000                    ; 00881F96: dc.w $C000
        dc.w    $31FC                    ; 00881F98: dc.w $31FC
        dc.w    $0080                    ; 00881F9A: dc.w $0080
        dc.w    $C876                    ; 00881F9C: dc.w $C876
        dc.w    $3AB8                    ; 00881F9E: dc.w $3AB8
        dc.w    $C876                    ; 00881FA0: dc.w $C876
        dc.w    $3AB8                    ; 00881FA2: dc.w $3AB8
        dc.w    $C874                    ; 00881FA4: dc.w $C874
        dc.w    $33FC                    ; 00881FA6: dc.w $33FC
        dc.w    $0000                    ; 00881FA8: dc.w $0000
        dc.w    $00A1                    ; 00881FAA: dc.w $00A1
        dc.w    $1100                    ; 00881FAC: dc.w $1100
        dc.w    $0839                    ; 00881FAE: dc.w $0839
        dc.w    $0000                    ; 00881FB0: dc.w $0000
        dc.w    $00A1                    ; 00881FB2: dc.w $00A1
        dc.w    $5123                    ; 00881FB4: dc.w $5123
        dc.w    $6756                    ; 00881FB6: BEQ.S $0088200E
        dc.w    $08B9                    ; 00881FB8: dc.w $08B9
        dc.w    $0000                    ; 00881FBA: dc.w $0000
        dc.w    $00A1                    ; 00881FBC: dc.w $00A1
        dc.w    $5123                    ; 00881FBE: dc.w $5123
        dc.w    $31FC                    ; 00881FC0: dc.w $31FC
        dc.w    $0000                    ; 00881FC2: dc.w $0000
        dc.w    $C87E                    ; 00881FC4: dc.w $C87E
        dc.w    $08B9                    ; 00881FC6: dc.w $08B9
        dc.w    $0007                    ; 00881FC8: dc.w $0007
        dc.w    $00A1                    ; 00881FCA: dc.w $00A1
        dc.w    $5100                    ; 00881FCC: dc.w $5100
        dc.w    $0839                    ; 00881FCE: dc.w $0839
        dc.w    $0007                    ; 00881FD0: dc.w $0007
        dc.w    $00A1                    ; 00881FD2: dc.w $00A1
        dc.w    $518A                    ; 00881FD4: dc.w $518A
        dc.w    $67F6                    ; 00881FD6: BEQ.S $00881FCE
        dc.w    $43F9, $00FF, $6E00    ; 00881FD8: LEA $00FF6E00,A1
        dc.w    $45F9, $00A1, $5200    ; 00881FDE: LEA $00A15200,A2
        dc.w    $4EBA                    ; 00881FE4: dc.w $4EBA
        dc.w    $28F0                    ; 00881FE6: dc.w $28F0
        dc.w    $4EBA                    ; 00881FE8: dc.w $4EBA
        dc.w    $28F0                    ; 00881FEA: dc.w $28F0
        dc.w    $0878                    ; 00881FEC: dc.w $0878
        dc.w    $0000                    ; 00881FEE: dc.w $0000
        dc.w    $C80C                    ; 00881FF0: dc.w $C80C
        dc.w    $660A                    ; 00881FF2: BNE.S $00881FFE
        dc.w    $08F9                    ; 00881FF4: dc.w $08F9
        dc.w    $0000                    ; 00881FF6: dc.w $0000
        dc.w    $00A1                    ; 00881FF8: dc.w $00A1
        dc.w    $518B                    ; 00881FFA: dc.w $518B
        dc.w    $6008                    ; 00881FFC: BRA.S $00882006
        dc.w    $08B9                    ; 00881FFE: dc.w $08B9

