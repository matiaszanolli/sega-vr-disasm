; ============================================================================
; Code_E000 ($E000-$10000)
; ============================================================================

        org     $00E000

Code_E000:
        dc.w    $4239                    ; 0088E000: dc.w $4239
        dc.w    $00A1                    ; 0088E002: dc.w $00A1
        dc.w    $5123                    ; 0088E004: dc.w $5123
        dc.w    $5878                    ; 0088E006: dc.w $5878
        dc.w    $C87E                    ; 0088E008: dc.w $C87E
        dc.w    $4E75                    ; 0088E00A: RTS
        dc.w    $4A38                    ; 0088E00C: dc.w $4A38
        dc.w    $A027                    ; 0088E00E: dc.w $A027
        dc.w    $6600, $000A            ; 0088E010: BNE.W $0088E01C
        dc.w    $11F8                    ; 0088E014: dc.w $11F8
        dc.w    $A019                    ; 0088E016: dc.w $A019
        dc.w    $A025                    ; 0088E018: dc.w $A025
        dc.w    $6006                    ; 0088E01A: BRA.S $0088E022
        dc.w    $11F8                    ; 0088E01C: dc.w $11F8
        dc.w    $A019                    ; 0088E01E: dc.w $A019
        dc.w    $A026                    ; 0088E020: dc.w $A026
        dc.w    $4A38                    ; 0088E022: dc.w $4A38
        dc.w    $A024                    ; 0088E024: dc.w $A024
        dc.w    $6718                    ; 0088E026: BEQ.S $0088E040
        dc.w    $0C38                    ; 0088E028: dc.w $0C38
        dc.w    $0001                    ; 0088E02A: dc.w $0001
        dc.w    $A024                    ; 0088E02C: dc.w $A024
        dc.w    $672A                    ; 0088E02E: BEQ.S $0088E05A
        dc.w    $11F8                    ; 0088E030: dc.w $11F8
        dc.w    $A025                    ; 0088E032: dc.w $A025
        dc.w    $FEAB                    ; 0088E034: dc.w $FEAB
        dc.w    $11F8                    ; 0088E036: dc.w $11F8
        dc.w    $A026                    ; 0088E038: dc.w $A026
        dc.w    $FEAC                    ; 0088E03A: dc.w $FEAC
        dc.w    $6000, $0028            ; 0088E03C: BRA.W $0088E066
        dc.w    $11F8                    ; 0088E040: dc.w $11F8
        dc.w    $A019                    ; 0088E042: dc.w $A019
        dc.w    $FEA5                    ; 0088E044: dc.w $FEA5
        dc.w    $0838                    ; 0088E046: dc.w $0838
        dc.w    $0007                    ; 0088E048: dc.w $0007
        dc.w    $FDA8                    ; 0088E04A: dc.w $FDA8
        dc.w    $6700, $0018            ; 0088E04C: BEQ.W $0088E066
        dc.w    $11F8                    ; 0088E050: dc.w $11F8
        dc.w    $A019                    ; 0088E052: dc.w $A019
        dc.w    $FEA6                    ; 0088E054: dc.w $FEA6
        dc.w    $6000, $000E            ; 0088E056: BRA.W $0088E066
        dc.w    $11F8                    ; 0088E05A: dc.w $11F8
        dc.w    $A025                    ; 0088E05C: dc.w $A025
        dc.w    $FEA7                    ; 0088E05E: dc.w $FEA7
        dc.w    $11F8                    ; 0088E060: dc.w $11F8
        dc.w    $A026                    ; 0088E062: dc.w $A026
        dc.w    $FEA8                    ; 0088E064: dc.w $FEA8
        dc.w    $31FC                    ; 0088E066: dc.w $31FC
        dc.w    $0000                    ; 0088E068: dc.w $0000
        dc.w    $C87E                    ; 0088E06A: dc.w $C87E
        dc.w    $23FC, $0088, $E5CE, $00FF, $0002  ; 0088E06C: MOVE.L #$0088E5CE,$00FF0002
        dc.w    $0C38                    ; 0088E076: dc.w $0C38
        dc.w    $0001                    ; 0088E078: dc.w $0001
        dc.w    $A024                    ; 0088E07A: dc.w $A024
        dc.w    $671C                    ; 0088E07C: BEQ.S $0088E09A
        dc.w    $0C38                    ; 0088E07E: dc.w $0C38
        dc.w    $0002                    ; 0088E080: dc.w $0002
        dc.w    $A024                    ; 0088E082: dc.w $A024
        dc.w    $6720                    ; 0088E084: BEQ.S $0088E0A6
        dc.w    $0838                    ; 0088E086: dc.w $0838
        dc.w    $0007                    ; 0088E088: dc.w $0007
        dc.w    $FDA8                    ; 0088E08A: dc.w $FDA8
        dc.w    $6722                    ; 0088E08C: BEQ.S $0088E0B0
        dc.w    $23FC, $0088, $E5E6, $00FF, $0002  ; 0088E08E: MOVE.L #$0088E5E6,$00FF0002
        dc.w    $6016                    ; 0088E098: BRA.S $0088E0B0
        dc.w    $23FC, $0088, $E5FE, $00FF, $0002  ; 0088E09A: MOVE.L #$0088E5FE,$00FF0002
        dc.w    $600A                    ; 0088E0A4: BRA.S $0088E0B0
        dc.w    $23FC, $0088, $F13C, $00FF, $0002  ; 0088E0A6: MOVE.L #$0088F13C,$00FF0002
        dc.w    $4A38                    ; 0088E0B0: dc.w $4A38
        dc.w    $A018                    ; 0088E0B2: dc.w $A018
        dc.w    $6660                    ; 0088E0B4: BNE.S $0088E116
        dc.w    $23FC, $0088, $4D98, $00FF, $0002  ; 0088E0B6: MOVE.L #$00884D98,$00FF0002
        dc.w    $0C38                    ; 0088E0C0: dc.w $0C38
        dc.w    $0001                    ; 0088E0C2: dc.w $0001
        dc.w    $A024                    ; 0088E0C4: dc.w $A024
        dc.w    $6700, $001A            ; 0088E0C6: BEQ.W $0088E0E2
        dc.w    $0C38                    ; 0088E0CA: dc.w $0C38
        dc.w    $0002                    ; 0088E0CC: dc.w $0002
        dc.w    $A024                    ; 0088E0CE: dc.w $A024
        dc.w    $6700, $002A            ; 0088E0D0: BEQ.W $0088E0FC
        dc.w    $23FC, $0088, $4A3E, $00FF, $0002  ; 0088E0D4: MOVE.L #$00884A3E,$00FF0002
        dc.w    $6000, $0036            ; 0088E0DE: BRA.W $0088E116
        dc.w    $08F8                    ; 0088E0E2: dc.w $08F8
        dc.w    $0005                    ; 0088E0E4: dc.w $0005
        dc.w    $C80E                    ; 0088E0E6: dc.w $C80E
        dc.w    $08B8                    ; 0088E0E8: dc.w $08B8
        dc.w    $0004                    ; 0088E0EA: dc.w $0004
        dc.w    $C80E                    ; 0088E0EC: dc.w $C80E
        dc.w    $23FC, $0088, $5100, $00FF, $0002  ; 0088E0EE: MOVE.L #$00885100,$00FF0002
        dc.w    $6000, $001C            ; 0088E0F8: BRA.W $0088E116
        dc.w    $08F8                    ; 0088E0FC: dc.w $08F8
        dc.w    $0004                    ; 0088E0FE: dc.w $0004
        dc.w    $C80E                    ; 0088E100: dc.w $C80E
        dc.w    $08B8                    ; 0088E102: dc.w $08B8
        dc.w    $0005                    ; 0088E104: dc.w $0005
        dc.w    $C80E                    ; 0088E106: dc.w $C80E
        dc.w    $23FC, $0088, $4D98, $00FF, $0002  ; 0088E108: MOVE.L #$00884D98,$00FF0002
        dc.w    $6000, $0002            ; 0088E112: BRA.W $0088E116
        dc.w    $4E75                    ; 0088E116: RTS
        dc.w    $7000                    ; 0088E118: MOVEQ #$00,D0
        dc.w    $4A38                    ; 0088E11A: dc.w $4A38
        dc.w    $A027                    ; 0088E11C: dc.w $A027
        dc.w    $6606                    ; 0088E11E: BNE.S $0088E126
        dc.w    $1038                    ; 0088E120: dc.w $1038
        dc.w    $A019                    ; 0088E122: dc.w $A019
        dc.w    $6004                    ; 0088E124: BRA.S $0088E12A
        dc.w    $1038                    ; 0088E126: dc.w $1038
        dc.w    $A025                    ; 0088E128: dc.w $A025
        dc.w    $43F9, $0088, $E19E    ; 0088E12A: LEA $0088E19E,A1
        dc.w    $D040                    ; 0088E130: dc.w $D040
        dc.w    $3200                    ; 0088E132: dc.w $3200
        dc.w    $D040                    ; 0088E134: dc.w $D040
        dc.w    $D041                    ; 0088E136: dc.w $D041
        dc.w    $2071                    ; 0088E138: dc.w $2071
        dc.w    $0000                    ; 0088E13A: dc.w $0000
        dc.w    $3031                    ; 0088E13C: dc.w $3031
        dc.w    $0004                    ; 0088E13E: dc.w $0004
        dc.w    $323C                    ; 0088E140: dc.w $323C
        dc.w    $0030                    ; 0088E142: dc.w $0030
        dc.w    $343C                    ; 0088E144: dc.w $343C
        dc.w    $0010                    ; 0088E146: dc.w $0010
        dc.w    $4EBA                    ; 0088E148: dc.w $4EBA
        dc.w    $026A                    ; 0088E14A: dc.w $026A
        dc.w    $7000                    ; 0088E14C: MOVEQ #$00,D0
        dc.w    $4A38                    ; 0088E14E: dc.w $4A38
        dc.w    $A027                    ; 0088E150: dc.w $A027
        dc.w    $6706                    ; 0088E152: BEQ.S $0088E15A
        dc.w    $1038                    ; 0088E154: dc.w $1038
        dc.w    $A019                    ; 0088E156: dc.w $A019
        dc.w    $6004                    ; 0088E158: BRA.S $0088E15E
        dc.w    $1038                    ; 0088E15A: dc.w $1038
        dc.w    $A026                    ; 0088E15C: dc.w $A026
        dc.w    $1600                    ; 0088E15E: dc.w $1600
        dc.w    $207C, $0401, $C010    ; 0088E160: MOVEA.L #$0401C010,A0
        dc.w    $D040                    ; 0088E166: dc.w $D040
        dc.w    $D040                    ; 0088E168: dc.w $D040
        dc.w    $D040                    ; 0088E16A: dc.w $D040
        dc.w    $3200                    ; 0088E16C: dc.w $3200
        dc.w    $D040                    ; 0088E16E: dc.w $D040
        dc.w    $D040                    ; 0088E170: dc.w $D040
        dc.w    $D040                    ; 0088E172: dc.w $D040
        dc.w    $D041                    ; 0088E174: dc.w $D041
        dc.w    $41F0                    ; 0088E176: dc.w $41F0
        dc.w    $0000                    ; 0088E178: dc.w $0000
        dc.w    $303C                    ; 0088E17A: dc.w $303C
        dc.w    $0049                    ; 0088E17C: dc.w $0049
        dc.w    $323C                    ; 0088E17E: dc.w $323C
        dc.w    $0010                    ; 0088E180: dc.w $0010
        dc.w    $343C                    ; 0088E182: dc.w $343C
        dc.w    $0010                    ; 0088E184: dc.w $0010
        dc.w    $4A03                    ; 0088E186: dc.w $4A03
        dc.w    $6706                    ; 0088E188: BEQ.S $0088E190
        dc.w    $303C                    ; 0088E18A: dc.w $303C
        dc.w    $0048                    ; 0088E18C: dc.w $0048
        dc.w    $5388                    ; 0088E18E: dc.w $5388
        dc.w    $4A39                    ; 0088E190: dc.w $4A39
        dc.w    $00A1                    ; 0088E192: dc.w $00A1
        dc.w    $5120                    ; 0088E194: dc.w $5120
        dc.w    $66F8                    ; 0088E196: BNE.S $0088E190
        dc.w    $4EBA                    ; 0088E198: dc.w $4EBA
        dc.w    $021A                    ; 0088E19A: dc.w $021A
        dc.w    $4E75                    ; 0088E19C: RTS
        dc.w    $0401                    ; 0088E19E: dc.w $0401
        dc.w    $4010                    ; 0088E1A0: dc.w $4010
        dc.w    $003A                    ; 0088E1A2: dc.w $003A
        dc.w    $0401                    ; 0088E1A4: dc.w $0401
        dc.w    $4049                    ; 0088E1A6: dc.w $4049
        dc.w    $003B                    ; 0088E1A8: dc.w $003B
        dc.w    $0401                    ; 0088E1AA: dc.w $0401
        dc.w    $4083                    ; 0088E1AC: dc.w $4083
        dc.w    $003A                    ; 0088E1AE: dc.w $003A
        dc.w    $0401                    ; 0088E1B0: dc.w $0401
        dc.w    $40BC                    ; 0088E1B2: dc.w $40BC
        dc.w    $003A                    ; 0088E1B4: dc.w $003A
        dc.w    $0401                    ; 0088E1B6: dc.w $0401
        dc.w    $40F5                    ; 0088E1B8: dc.w $40F5
        dc.w    $003B                    ; 0088E1BA: dc.w $003B
        dc.w    $3ABC                    ; 0088E1BC: dc.w $3ABC
        dc.w    $8F02                    ; 0088E1BE: dc.w $8F02
        dc.w    $2ABC                    ; 0088E1C0: dc.w $2ABC
        dc.w    $4000                    ; 0088E1C2: dc.w $4000
        dc.w    $0003                    ; 0088E1C4: dc.w $0003
        dc.w    $4240                    ; 0088E1C6: dc.w $4240
        dc.w    $761B                    ; 0088E1C8: MOVEQ #$1B,D3
        dc.w    $3200                    ; 0088E1CA: dc.w $3200
        dc.w    $E749                    ; 0088E1CC: dc.w $E749
        dc.w    $41F9, $0088, $E20C    ; 0088E1CE: LEA $0088E20C,A0
        dc.w    $41F0                    ; 0088E1D4: dc.w $41F0
        dc.w    $1000                    ; 0088E1D6: dc.w $1000
        dc.w    $383C                    ; 0088E1D8: dc.w $383C
        dc.w    $0005                    ; 0088E1DA: dc.w $0005
        dc.w    $3A3C                    ; 0088E1DC: dc.w $3A3C
        dc.w    $0007                    ; 0088E1DE: dc.w $0007
        dc.w    $7C00                    ; 0088E1E0: MOVEQ #$00,D6
        dc.w    $1C30                    ; 0088E1E2: dc.w $1C30
        dc.w    $5000                    ; 0088E1E4: dc.w $5000
        dc.w    $0646                    ; 0088E1E6: dc.w $0646
        dc.w    $02F0                    ; 0088E1E8: dc.w $02F0
        dc.w    $3C86                    ; 0088E1EA: dc.w $3C86
        dc.w    $51CD, $FFF2            ; 0088E1EC: DBRA D5,$0088E1E0
        dc.w    $51CC, $FFEA            ; 0088E1F0: DBRA D4,$0088E1DC
        dc.w    $383C                    ; 0088E1F4: dc.w $383C
        dc.w    $004F                    ; 0088E1F6: dc.w $004F
        dc.w    $3CBC                    ; 0088E1F8: dc.w $3CBC
        dc.w    $0000                    ; 0088E1FA: dc.w $0000
        dc.w    $51CC, $FFFA            ; 0088E1FC: DBRA D4,$0088E1F8
        dc.w    $5240                    ; 0088E200: dc.w $5240
        dc.w    $0240                    ; 0088E202: dc.w $0240
        dc.w    $0003                    ; 0088E204: dc.w $0003
        dc.w    $51CB, $FFC2            ; 0088E206: DBRA D3,$0088E1CA
        dc.w    $4E75                    ; 0088E20A: RTS
        dc.w    $0807                    ; 0088E20C: dc.w $0807
        dc.w    $0605                    ; 0088E20E: dc.w $0605
        dc.w    $0403                    ; 0088E210: dc.w $0403
        dc.w    $0201                    ; 0088E212: dc.w $0201
        dc.w    $1110                    ; 0088E214: dc.w $1110
        dc.w    $0F0E                    ; 0088E216: dc.w $0F0E
        dc.w    $0D0C                    ; 0088E218: dc.w $0D0C
        dc.w    $0B0A                    ; 0088E21A: dc.w $0B0A
        dc.w    $0403                    ; 0088E21C: dc.w $0403
        dc.w    $0201                    ; 0088E21E: dc.w $0201
        dc.w    $0807                    ; 0088E220: dc.w $0807
        dc.w    $0605                    ; 0088E222: dc.w $0605
        dc.w    $0D0C                    ; 0088E224: dc.w $0D0C
        dc.w    $0B0A                    ; 0088E226: dc.w $0B0A
        dc.w    $1110                    ; 0088E228: dc.w $1110
        dc.w    $0F0E                    ; 0088E22A: dc.w $0F0E
        dc.w    $2248                    ; 0088E22C: dc.w $2248
        dc.w    $E349                    ; 0088E22E: dc.w $E349
        dc.w    $EF4A                    ; 0088E230: dc.w $EF4A
        dc.w    $D242                    ; 0088E232: dc.w $D242
        dc.w    $41F0                    ; 0088E234: dc.w $41F0
        dc.w    $1000                    ; 0088E236: dc.w $1000
        dc.w    $0240                    ; 0088E238: dc.w $0240
        dc.w    $0003                    ; 0088E23A: dc.w $0003
        dc.w    $E148                    ; 0088E23C: dc.w $E148
        dc.w    $EB48                    ; 0088E23E: dc.w $EB48
        dc.w    $0640                    ; 0088E240: dc.w $0640
        dc.w    $0100                    ; 0088E242: dc.w $0100
        dc.w    $0880                    ; 0088E244: dc.w $0880
        dc.w    $000B                    ; 0088E246: dc.w $000B
        dc.w    $0880                    ; 0088E248: dc.w $0880
        dc.w    $000C                    ; 0088E24A: dc.w $000C
        dc.w    $7200                    ; 0088E24C: MOVEQ #$00,D1
        dc.w    $343C                    ; 0088E24E: dc.w $343C
        dc.w    $0006                    ; 0088E250: dc.w $0006
        dc.w    $D440                    ; 0088E252: dc.w $D440
        dc.w    $3082                    ; 0088E254: dc.w $3082
        dc.w    $D1FC                    ; 0088E256: dc.w $D1FC
        dc.w    $0000                    ; 0088E258: dc.w $0000
        dc.w    $0080                    ; 0088E25A: dc.w $0080
        dc.w    $343C                    ; 0088E25C: dc.w $343C
        dc.w    $0001                    ; 0088E25E: dc.w $0001
        dc.w    $3A04                    ; 0088E260: dc.w $3A04
        dc.w    $5745                    ; 0088E262: dc.w $5745
        dc.w    $4EBA                    ; 0088E264: dc.w $4EBA
        dc.w    $007E                    ; 0088E266: dc.w $007E
        dc.w    $3086                    ; 0088E268: dc.w $3086
        dc.w    $D1FC                    ; 0088E26A: dc.w $D1FC
        dc.w    $0000                    ; 0088E26C: dc.w $0000
        dc.w    $0080                    ; 0088E26E: dc.w $0080
        dc.w    $51CD, $FFF2            ; 0088E270: DBRA D5,$0088E264
        dc.w    $343C                    ; 0088E274: dc.w $343C
        dc.w    $0007                    ; 0088E276: dc.w $0007
        dc.w    $4EBA                    ; 0088E278: dc.w $4EBA
        dc.w    $006A                    ; 0088E27A: dc.w $006A
        dc.w    $30C6                    ; 0088E27C: dc.w $30C6
        dc.w    $343C                    ; 0088E27E: dc.w $343C
        dc.w    $0003                    ; 0088E280: dc.w $0003
        dc.w    $3A03                    ; 0088E282: dc.w $3A03
        dc.w    $5745                    ; 0088E284: dc.w $5745
        dc.w    $4EBA                    ; 0088E286: dc.w $4EBA
        dc.w    $005C                    ; 0088E288: dc.w $005C
        dc.w    $30C6                    ; 0088E28A: dc.w $30C6
        dc.w    $51CD, $FFF8            ; 0088E28C: DBRA D5,$0088E286
        dc.w    $08C0                    ; 0088E290: dc.w $08C0
        dc.w    $000B                    ; 0088E292: dc.w $000B
        dc.w    $08C0                    ; 0088E294: dc.w $08C0
        dc.w    $000C                    ; 0088E296: dc.w $000C
        dc.w    $343C                    ; 0088E298: dc.w $343C
        dc.w    $0005                    ; 0088E29A: dc.w $0005
        dc.w    $4EBA                    ; 0088E29C: dc.w $4EBA
        dc.w    $0046                    ; 0088E29E: dc.w $0046
        dc.w    $3086                    ; 0088E2A0: dc.w $3086
        dc.w    $91FC                    ; 0088E2A2: dc.w $91FC
        dc.w    $0000                    ; 0088E2A4: dc.w $0000
        dc.w    $0080                    ; 0088E2A6: dc.w $0080
        dc.w    $343C                    ; 0088E2A8: dc.w $343C
        dc.w    $0001                    ; 0088E2AA: dc.w $0001
        dc.w    $3A04                    ; 0088E2AC: dc.w $3A04
        dc.w    $5745                    ; 0088E2AE: dc.w $5745
        dc.w    $4EBA                    ; 0088E2B0: dc.w $4EBA
        dc.w    $0032                    ; 0088E2B2: dc.w $0032
        dc.w    $3086                    ; 0088E2B4: dc.w $3086
        dc.w    $91FC                    ; 0088E2B6: dc.w $91FC
        dc.w    $0000                    ; 0088E2B8: dc.w $0000
        dc.w    $0080                    ; 0088E2BA: dc.w $0080
        dc.w    $51CD, $FFF2            ; 0088E2BC: DBRA D5,$0088E2B0
        dc.w    $343C                    ; 0088E2C0: dc.w $343C
        dc.w    $0007                    ; 0088E2C2: dc.w $0007
        dc.w    $4EBA                    ; 0088E2C4: dc.w $4EBA
        dc.w    $001E                    ; 0088E2C6: dc.w $001E
        dc.w    $3086                    ; 0088E2C8: dc.w $3086
        dc.w    $5588                    ; 0088E2CA: dc.w $5588
        dc.w    $343C                    ; 0088E2CC: dc.w $343C
        dc.w    $0003                    ; 0088E2CE: dc.w $0003
        dc.w    $3A03                    ; 0088E2D0: dc.w $3A03
        dc.w    $5745                    ; 0088E2D2: dc.w $5745
        dc.w    $4EBA                    ; 0088E2D4: dc.w $4EBA
        dc.w    $000E                    ; 0088E2D6: dc.w $000E
        dc.w    $3086                    ; 0088E2D8: dc.w $3086
        dc.w    $5588                    ; 0088E2DA: dc.w $5588
        dc.w    $51CD, $FFF6            ; 0088E2DC: DBRA D5,$0088E2D4
        dc.w    $2049                    ; 0088E2E0: dc.w $2049
        dc.w    $4E75                    ; 0088E2E2: RTS
        dc.w    $3C02                    ; 0088E2E4: dc.w $3C02
        dc.w    $DC40                    ; 0088E2E6: dc.w $DC40
        dc.w    $DC41                    ; 0088E2E8: dc.w $DC41
        dc.w    $0841                    ; 0088E2EA: dc.w $0841
        dc.w    $0000                    ; 0088E2EC: dc.w $0000
        dc.w    $4E75                    ; 0088E2EE: RTS
        dc.w    $2ABC                    ; 0088E2F0: dc.w $2ABC
        dc.w    $6000, $0002            ; 0088E2F2: BRA.W $0088E2F6
        dc.w    $701B                    ; 0088E2F6: MOVEQ #$1B,D0
        dc.w    $323C                    ; 0088E2F8: dc.w $323C
        dc.w    $001F                    ; 0088E2FA: dc.w $001F
        dc.w    $2C98                    ; 0088E2FC: dc.w $2C98
        dc.w    $51C9, $FFFC            ; 0088E2FE: DBRA D1,$0088E2FC
        dc.w    $323C                    ; 0088E302: dc.w $323C
        dc.w    $001F                    ; 0088E304: dc.w $001F
        dc.w    $2CBC                    ; 0088E306: dc.w $2CBC
        dc.w    $0000                    ; 0088E308: dc.w $0000
        dc.w    $0000                    ; 0088E30A: dc.w $0000
        dc.w    $51C9, $FFF8            ; 0088E30C: DBRA D1,$0088E306
        dc.w    $51C8, $FFE6            ; 0088E310: DBRA D0,$0088E2F8
        dc.w    $4E75                    ; 0088E314: RTS

; --- Called 6x ---
func_E316:
        dc.w    $4A39                    ; 0088E316: dc.w $4A39
        dc.w    $00A1                    ; 0088E318: dc.w $00A1
        dc.w    $5120                    ; 0088E31A: dc.w $5120
        dc.w    $66F8                    ; 0088E31C: BNE.S $0088E316
        dc.w    $D1FC                    ; 0088E31E: dc.w $D1FC
        dc.w    $0200                    ; 0088E320: dc.w $0200
        dc.w    $0000                    ; 0088E322: dc.w $0000
        dc.w    $23C8                    ; 0088E324: dc.w $23C8
        dc.w    $00A1                    ; 0088E326: dc.w $00A1
        dc.w    $5128                    ; 0088E328: dc.w $5128
        dc.w    $33FC                    ; 0088E32A: dc.w $33FC
        dc.w    $0101                    ; 0088E32C: dc.w $0101
        dc.w    $00A1                    ; 0088E32E: dc.w $00A1
        dc.w    $512C                    ; 0088E330: dc.w $512C
        dc.w    $13FC                    ; 0088E332: dc.w $13FC
        dc.w    $0025                    ; 0088E334: dc.w $0025
        dc.w    $00A1                    ; 0088E336: dc.w $00A1
        dc.w    $5121                    ; 0088E338: dc.w $5121
        dc.w    $13FC                    ; 0088E33A: dc.w $13FC
        dc.w    $0001                    ; 0088E33C: dc.w $0001
        dc.w    $00A1                    ; 0088E33E: dc.w $00A1
        dc.w    $5120                    ; 0088E340: dc.w $5120
        dc.w    $4A39                    ; 0088E342: dc.w $4A39
        dc.w    $00A1                    ; 0088E344: dc.w $00A1
        dc.w    $512C                    ; 0088E346: dc.w $512C
        dc.w    $66F8                    ; 0088E348: BNE.S $0088E342
        dc.w    $23C9                    ; 0088E34A: dc.w $23C9
        dc.w    $00A1                    ; 0088E34C: dc.w $00A1
        dc.w    $5128                    ; 0088E34E: dc.w $5128
        dc.w    $33FC                    ; 0088E350: dc.w $33FC
        dc.w    $0101                    ; 0088E352: dc.w $0101
        dc.w    $00A1                    ; 0088E354: dc.w $00A1
        dc.w    $512C                    ; 0088E356: dc.w $512C
        dc.w    $4E75                    ; 0088E358: RTS

; --- Called 7x ---
func_E35A:
        dc.w    $4A39                    ; 0088E35A: dc.w $4A39
        dc.w    $00A1                    ; 0088E35C: dc.w $00A1
        dc.w    $5120                    ; 0088E35E: dc.w $5120
        dc.w    $66F8                    ; 0088E360: BNE.S $0088E35A
        dc.w    $23C9                    ; 0088E362: dc.w $23C9
        dc.w    $00A1                    ; 0088E364: dc.w $00A1
        dc.w    $5128                    ; 0088E366: dc.w $5128
        dc.w    $33FC                    ; 0088E368: dc.w $33FC
        dc.w    $0101                    ; 0088E36A: dc.w $0101
        dc.w    $00A1                    ; 0088E36C: dc.w $00A1
        dc.w    $512C                    ; 0088E36E: dc.w $512C
        dc.w    $13FC                    ; 0088E370: dc.w $13FC
        dc.w    $0022                    ; 0088E372: dc.w $0022
        dc.w    $00A1                    ; 0088E374: dc.w $00A1
        dc.w    $5121                    ; 0088E376: dc.w $5121
        dc.w    $13FC                    ; 0088E378: dc.w $13FC
        dc.w    $0001                    ; 0088E37A: dc.w $0001
        dc.w    $00A1                    ; 0088E37C: dc.w $00A1
        dc.w    $5120                    ; 0088E37E: dc.w $5120
        dc.w    $4A39                    ; 0088E380: dc.w $4A39
        dc.w    $00A1                    ; 0088E382: dc.w $00A1
        dc.w    $512C                    ; 0088E384: dc.w $512C
        dc.w    $66F8                    ; 0088E386: BNE.S $0088E380
        dc.w    $33C0                    ; 0088E388: dc.w $33C0
        dc.w    $00A1                    ; 0088E38A: dc.w $00A1
        dc.w    $5128                    ; 0088E38C: dc.w $5128
        dc.w    $33C1                    ; 0088E38E: dc.w $33C1
        dc.w    $00A1                    ; 0088E390: dc.w $00A1
        dc.w    $512A                    ; 0088E392: dc.w $512A
        dc.w    $33FC                    ; 0088E394: dc.w $33FC
        dc.w    $0101                    ; 0088E396: dc.w $0101
        dc.w    $00A1                    ; 0088E398: dc.w $00A1
        dc.w    $512C                    ; 0088E39A: dc.w $512C
        dc.w    $4A39                    ; 0088E39C: dc.w $4A39
        dc.w    $00A1                    ; 0088E39E: dc.w $00A1
        dc.w    $512C                    ; 0088E3A0: dc.w $512C
        dc.w    $66F8                    ; 0088E3A2: BNE.S $0088E39C
        dc.w    $23C8                    ; 0088E3A4: dc.w $23C8
        dc.w    $00A1                    ; 0088E3A6: dc.w $00A1
        dc.w    $5128                    ; 0088E3A8: dc.w $5128
        dc.w    $33FC                    ; 0088E3AA: dc.w $33FC
        dc.w    $0101                    ; 0088E3AC: dc.w $0101
        dc.w    $00A1                    ; 0088E3AE: dc.w $00A1
        dc.w    $512C                    ; 0088E3B0: dc.w $512C
        dc.w    $4E75                    ; 0088E3B2: RTS
        dc.w    $23C8                    ; 0088E3B4: dc.w $23C8
        dc.w    $00A1                    ; 0088E3B6: dc.w $00A1
        dc.w    $5128                    ; 0088E3B8: dc.w $5128
        dc.w    $33FC                    ; 0088E3BA: dc.w $33FC
        dc.w    $0101                    ; 0088E3BC: dc.w $0101
        dc.w    $00A1                    ; 0088E3BE: dc.w $00A1
        dc.w    $512C                    ; 0088E3C0: dc.w $512C
        dc.w    $13FC                    ; 0088E3C2: dc.w $13FC
        dc.w    $0027                    ; 0088E3C4: dc.w $0027
        dc.w    $00A1                    ; 0088E3C6: dc.w $00A1
        dc.w    $5121                    ; 0088E3C8: dc.w $5121
        dc.w    $13FC                    ; 0088E3CA: dc.w $13FC
        dc.w    $0001                    ; 0088E3CC: dc.w $0001
        dc.w    $00A1                    ; 0088E3CE: dc.w $00A1
        dc.w    $5120                    ; 0088E3D0: dc.w $5120
        dc.w    $4A39                    ; 0088E3D2: dc.w $4A39
        dc.w    $00A1                    ; 0088E3D4: dc.w $00A1
        dc.w    $512C                    ; 0088E3D6: dc.w $512C
        dc.w    $66F8                    ; 0088E3D8: BNE.S $0088E3D2
        dc.w    $33C0                    ; 0088E3DA: dc.w $33C0
        dc.w    $00A1                    ; 0088E3DC: dc.w $00A1
        dc.w    $5128                    ; 0088E3DE: dc.w $5128
        dc.w    $33C1                    ; 0088E3E0: dc.w $33C1
        dc.w    $00A1                    ; 0088E3E2: dc.w $00A1
        dc.w    $512A                    ; 0088E3E4: dc.w $512A
        dc.w    $33FC                    ; 0088E3E6: dc.w $33FC
        dc.w    $0101                    ; 0088E3E8: dc.w $0101
        dc.w    $00A1                    ; 0088E3EA: dc.w $00A1
        dc.w    $512C                    ; 0088E3EC: dc.w $512C
        dc.w    $4A39                    ; 0088E3EE: dc.w $4A39
        dc.w    $00A1                    ; 0088E3F0: dc.w $00A1
        dc.w    $512C                    ; 0088E3F2: dc.w $512C
        dc.w    $66F8                    ; 0088E3F4: BNE.S $0088E3EE
        dc.w    $33C2                    ; 0088E3F6: dc.w $33C2
        dc.w    $00A1                    ; 0088E3F8: dc.w $00A1
        dc.w    $5128                    ; 0088E3FA: dc.w $5128
        dc.w    $33FC                    ; 0088E3FC: dc.w $33FC
        dc.w    $0101                    ; 0088E3FE: dc.w $0101
        dc.w    $00A1                    ; 0088E400: dc.w $00A1
        dc.w    $512C                    ; 0088E402: dc.w $512C
        dc.w    $4E75                    ; 0088E404: RTS

; --- Called 6x ---
func_E406:
        dc.w    $4A39                    ; 0088E406: dc.w $4A39
        dc.w    $00A1                    ; 0088E408: dc.w $00A1
        dc.w    $5120                    ; 0088E40A: dc.w $5120
        dc.w    $66F8                    ; 0088E40C: BNE.S $0088E406
        dc.w    $23C8                    ; 0088E40E: dc.w $23C8
        dc.w    $00A1                    ; 0088E410: dc.w $00A1
        dc.w    $5128                    ; 0088E412: dc.w $5128
        dc.w    $33FC                    ; 0088E414: dc.w $33FC
        dc.w    $0101                    ; 0088E416: dc.w $0101
        dc.w    $00A1                    ; 0088E418: dc.w $00A1
        dc.w    $512C                    ; 0088E41A: dc.w $512C
        dc.w    $13FC                    ; 0088E41C: dc.w $13FC
        dc.w    $002F                    ; 0088E41E: dc.w $002F
        dc.w    $00A1                    ; 0088E420: dc.w $00A1
        dc.w    $5121                    ; 0088E422: dc.w $5121
        dc.w    $13FC                    ; 0088E424: dc.w $13FC
        dc.w    $0001                    ; 0088E426: dc.w $0001
        dc.w    $00A1                    ; 0088E428: dc.w $00A1
        dc.w    $5120                    ; 0088E42A: dc.w $5120
        dc.w    $4A39                    ; 0088E42C: dc.w $4A39
        dc.w    $00A1                    ; 0088E42E: dc.w $00A1
        dc.w    $512C                    ; 0088E430: dc.w $512C
        dc.w    $66F8                    ; 0088E432: BNE.S $0088E42C
        dc.w    $33C0                    ; 0088E434: dc.w $33C0
        dc.w    $00A1                    ; 0088E436: dc.w $00A1
        dc.w    $5128                    ; 0088E438: dc.w $5128
        dc.w    $33C1                    ; 0088E43A: dc.w $33C1
        dc.w    $00A1                    ; 0088E43C: dc.w $00A1
        dc.w    $512A                    ; 0088E43E: dc.w $512A
        dc.w    $33FC                    ; 0088E440: dc.w $33FC
        dc.w    $0101                    ; 0088E442: dc.w $0101
        dc.w    $00A1                    ; 0088E444: dc.w $00A1
        dc.w    $512C                    ; 0088E446: dc.w $512C
        dc.w    $4A39                    ; 0088E448: dc.w $4A39
        dc.w    $00A1                    ; 0088E44A: dc.w $00A1
        dc.w    $512C                    ; 0088E44C: dc.w $512C
        dc.w    $66F8                    ; 0088E44E: BNE.S $0088E448
        dc.w    $33C2                    ; 0088E450: dc.w $33C2
        dc.w    $00A1                    ; 0088E452: dc.w $00A1
        dc.w    $5128                    ; 0088E454: dc.w $5128
        dc.w    $33C3                    ; 0088E456: dc.w $33C3
        dc.w    $00A1                    ; 0088E458: dc.w $00A1
        dc.w    $512A                    ; 0088E45A: dc.w $512A
        dc.w    $33FC                    ; 0088E45C: dc.w $33FC
        dc.w    $0101                    ; 0088E45E: dc.w $0101
        dc.w    $00A1                    ; 0088E460: dc.w $00A1
        dc.w    $512C                    ; 0088E462: dc.w $512C
        dc.w    $4E75                    ; 0088E464: RTS
        dc.w    $121A                    ; 0088E466: dc.w $121A
        dc.w    $0241                    ; 0088E468: dc.w $0241
        dc.w    $000F                    ; 0088E46A: dc.w $000F
        dc.w    $6100, $004E            ; 0088E46C: BSR.W $0088E4BC
        dc.w    $5089                    ; 0088E470: dc.w $5089
        dc.w    $323C                    ; 0088E472: dc.w $323C
        dc.w    $000A                    ; 0088E474: dc.w $000A
        dc.w    $6100, $0044            ; 0088E476: BSR.W $0088E4BC
        dc.w    $5089                    ; 0088E47A: dc.w $5089
        dc.w    $141A                    ; 0088E47C: dc.w $141A
        dc.w    $6100, $0020            ; 0088E47E: BSR.W $0088E4A0
        dc.w    $323C                    ; 0088E482: dc.w $323C
        dc.w    $000B                    ; 0088E484: dc.w $000B
        dc.w    $6100, $0034            ; 0088E486: BSR.W $0088E4BC
        dc.w    $5089                    ; 0088E48A: dc.w $5089
        dc.w    $121A                    ; 0088E48C: dc.w $121A
        dc.w    $0241                    ; 0088E48E: dc.w $0241
        dc.w    $000F                    ; 0088E490: dc.w $000F
        dc.w    $6100, $0028            ; 0088E492: BSR.W $0088E4BC
        dc.w    $5089                    ; 0088E496: dc.w $5089
        dc.w    $141A                    ; 0088E498: dc.w $141A
        dc.w    $6100, $0004            ; 0088E49A: BSR.W $0088E4A0
        dc.w    $4E75                    ; 0088E49E: RTS
        dc.w    $1202                    ; 0088E4A0: dc.w $1202
        dc.w    $E809                    ; 0088E4A2: dc.w $E809
        dc.w    $0241                    ; 0088E4A4: dc.w $0241
        dc.w    $000F                    ; 0088E4A6: dc.w $000F
        dc.w    $6100, $0012            ; 0088E4A8: BSR.W $0088E4BC
        dc.w    $5089                    ; 0088E4AC: dc.w $5089
        dc.w    $3202                    ; 0088E4AE: dc.w $3202
        dc.w    $0241                    ; 0088E4B0: dc.w $0241
        dc.w    $000F                    ; 0088E4B2: dc.w $000F
        dc.w    $6100, $0006            ; 0088E4B4: BSR.W $0088E4BC
        dc.w    $5089                    ; 0088E4B8: dc.w $5089
        dc.w    $4E75                    ; 0088E4BA: RTS

; --- Called 6x ---
func_E4BC:
        dc.w    $ED49                    ; 0088E4BC: dc.w $ED49
        dc.w    $3001                    ; 0088E4BE: dc.w $3001
        dc.w    $E349                    ; 0088E4C0: dc.w $E349
        dc.w    $D240                    ; 0088E4C2: dc.w $D240
        dc.w    $207C, $0603, $DA00    ; 0088E4C4: MOVEA.L #$0603DA00,A0
        dc.w    $D0C1                    ; 0088E4CA: dc.w $D0C1
        dc.w    $303C                    ; 0088E4CC: dc.w $303C
        dc.w    $000C                    ; 0088E4CE: dc.w $000C
        dc.w    $323C                    ; 0088E4D0: dc.w $323C
        dc.w    $0010                    ; 0088E4D2: dc.w $0010
        dc.w    $4EBA                    ; 0088E4D4: dc.w $4EBA
        dc.w    $FE84                    ; 0088E4D6: dc.w $FE84
        dc.w    $4E75                    ; 0088E4D8: RTS
        dc.w    $23C9                    ; 0088E4DA: dc.w $23C9
        dc.w    $00A1                    ; 0088E4DC: dc.w $00A1
        dc.w    $5128                    ; 0088E4DE: dc.w $5128
        dc.w    $33FC                    ; 0088E4E0: dc.w $33FC
        dc.w    $0101                    ; 0088E4E2: dc.w $0101
        dc.w    $00A1                    ; 0088E4E4: dc.w $00A1
        dc.w    $512C                    ; 0088E4E6: dc.w $512C
        dc.w    $13FC                    ; 0088E4E8: dc.w $13FC
        dc.w    $0021                    ; 0088E4EA: dc.w $0021
        dc.w    $00A1                    ; 0088E4EC: dc.w $00A1
        dc.w    $5121                    ; 0088E4EE: dc.w $5121
        dc.w    $13FC                    ; 0088E4F0: dc.w $13FC
        dc.w    $0001                    ; 0088E4F2: dc.w $0001
        dc.w    $00A1                    ; 0088E4F4: dc.w $00A1
        dc.w    $5120                    ; 0088E4F6: dc.w $5120
        dc.w    $4A39                    ; 0088E4F8: dc.w $4A39
        dc.w    $00A1                    ; 0088E4FA: dc.w $00A1
        dc.w    $512C                    ; 0088E4FC: dc.w $512C
        dc.w    $66F8                    ; 0088E4FE: BNE.S $0088E4F8
        dc.w    $33C0                    ; 0088E500: dc.w $33C0
        dc.w    $00A1                    ; 0088E502: dc.w $00A1
        dc.w    $5128                    ; 0088E504: dc.w $5128
        dc.w    $33C1                    ; 0088E506: dc.w $33C1
        dc.w    $00A1                    ; 0088E508: dc.w $00A1
        dc.w    $512A                    ; 0088E50A: dc.w $512A
        dc.w    $33FC                    ; 0088E50C: dc.w $33FC
        dc.w    $0101                    ; 0088E50E: dc.w $0101
        dc.w    $00A1                    ; 0088E510: dc.w $00A1
        dc.w    $512C                    ; 0088E512: dc.w $512C
        dc.w    $4A39                    ; 0088E514: dc.w $4A39
        dc.w    $00A1                    ; 0088E516: dc.w $00A1
        dc.w    $512C                    ; 0088E518: dc.w $512C
        dc.w    $66F8                    ; 0088E51A: BNE.S $0088E514
        dc.w    $23C8                    ; 0088E51C: dc.w $23C8
        dc.w    $00A1                    ; 0088E51E: dc.w $00A1
        dc.w    $5128                    ; 0088E520: dc.w $5128
        dc.w    $33FC                    ; 0088E522: dc.w $33FC
        dc.w    $0101                    ; 0088E524: dc.w $0101
        dc.w    $00A1                    ; 0088E526: dc.w $00A1
        dc.w    $512C                    ; 0088E528: dc.w $512C
        dc.w    $4E75                    ; 0088E52A: RTS

; --- Called 8x ---
func_E52C:
        dc.w    $41F8                    ; 0088E52C: dc.w $41F8
        dc.w    $84A2                    ; 0088E52E: dc.w $84A2
        dc.w    $43F8                    ; 0088E530: dc.w $43F8
        dc.w    $84C2                    ; 0088E532: dc.w $84C2
        dc.w    $45F8                    ; 0088E534: dc.w $45F8
        dc.w    $84E2                    ; 0088E536: dc.w $84E2
        dc.w    $4242                    ; 0088E538: dc.w $4242
        dc.w    $323C                    ; 0088E53A: dc.w $323C
        dc.w    $0007                    ; 0088E53C: dc.w $0007
        dc.w    $31BC                    ; 0088E53E: dc.w $31BC
        dc.w    $0000                    ; 0088E540: dc.w $0000
        dc.w    $2000                    ; 0088E542: dc.w $2000
        dc.w    $33BC                    ; 0088E544: dc.w $33BC
        dc.w    $0000                    ; 0088E546: dc.w $0000
        dc.w    $2000                    ; 0088E548: dc.w $2000
        dc.w    $35BC                    ; 0088E54A: dc.w $35BC
        dc.w    $0000                    ; 0088E54C: dc.w $0000
        dc.w    $2000                    ; 0088E54E: dc.w $2000
        dc.w    $5442                    ; 0088E550: dc.w $5442
        dc.w    $51C9, $FFEA            ; 0088E552: DBRA D1,$0088E53E
        dc.w    $4A40                    ; 0088E556: dc.w $4A40
        dc.w    $6608                    ; 0088E558: BNE.S $0088E562
        dc.w    $41F8                    ; 0088E55A: dc.w $41F8
        dc.w    $84A2                    ; 0088E55C: dc.w $84A2
        dc.w    $6000, $0016            ; 0088E55E: BRA.W $0088E576
        dc.w    $0C40                    ; 0088E562: dc.w $0C40
        dc.w    $0001                    ; 0088E564: dc.w $0001
        dc.w    $6600, $000A            ; 0088E566: BNE.W $0088E572
        dc.w    $41F8                    ; 0088E56A: dc.w $41F8
        dc.w    $84C2                    ; 0088E56C: dc.w $84C2
        dc.w    $6000, $0006            ; 0088E56E: BRA.W $0088E576
        dc.w    $41F8                    ; 0088E572: dc.w $41F8
        dc.w    $84E2                    ; 0088E574: dc.w $84E2
        dc.w    $47F9, $0088, $E5AC    ; 0088E576: LEA $0088E5AC,A3
        dc.w    $7200                    ; 0088E57C: MOVEQ #$00,D1
        dc.w    $3238                    ; 0088E57E: dc.w $3238
        dc.w    $A012                    ; 0088E580: dc.w $A012
        dc.w    $D241                    ; 0088E582: dc.w $D241
        dc.w    $D7C1                    ; 0088E584: dc.w $D7C1
        dc.w    $4242                    ; 0088E586: dc.w $4242
        dc.w    $323C                    ; 0088E588: dc.w $323C
        dc.w    $0007                    ; 0088E58A: dc.w $0007
        dc.w    $319B                    ; 0088E58C: dc.w $319B
        dc.w    $2000                    ; 0088E58E: dc.w $2000
        dc.w    $5442                    ; 0088E590: dc.w $5442
        dc.w    $51C9, $FFF8            ; 0088E592: DBRA D1,$0088E58C
        dc.w    $3238                    ; 0088E596: dc.w $3238
        dc.w    $A012                    ; 0088E598: dc.w $A012
        dc.w    $5241                    ; 0088E59A: dc.w $5241
        dc.w    $0C41                    ; 0088E59C: dc.w $0C41
        dc.w    $0007                    ; 0088E59E: dc.w $0007
        dc.w    $6F00, $0004            ; 0088E5A0: BLE.W $0088E5A6
        dc.w    $4241                    ; 0088E5A4: dc.w $4241
        dc.w    $31C1                    ; 0088E5A6: dc.w $31C1
        dc.w    $A012                    ; 0088E5A8: dc.w $A012
        dc.w    $4E75                    ; 0088E5AA: RTS
        dc.w    $0EEE                    ; 0088E5AC: dc.w $0EEE
        dc.w    $0EEE                    ; 0088E5AE: dc.w $0EEE
        dc.w    $0EEE                    ; 0088E5B0: dc.w $0EEE
        dc.w    $0EEE                    ; 0088E5B2: dc.w $0EEE
        dc.w    $0000                    ; 0088E5B4: dc.w $0000
        dc.w    $0000                    ; 0088E5B6: dc.w $0000
        dc.w    $0000                    ; 0088E5B8: dc.w $0000
        dc.w    $0000                    ; 0088E5BA: dc.w $0000
        dc.w    $0EEE                    ; 0088E5BC: dc.w $0EEE
        dc.w    $0EEE                    ; 0088E5BE: dc.w $0EEE
        dc.w    $0EEE                    ; 0088E5C0: dc.w $0EEE
        dc.w    $0EEE                    ; 0088E5C2: dc.w $0EEE
        dc.w    $0000                    ; 0088E5C4: dc.w $0000
        dc.w    $0000                    ; 0088E5C6: dc.w $0000
        dc.w    $0000                    ; 0088E5C8: dc.w $0000
        dc.w    $0000                    ; 0088E5CA: dc.w $0000
        dc.w    $4E75                    ; 0088E5CC: RTS
        dc.w    $4238                    ; 0088E5CE: dc.w $4238
        dc.w    $A01F                    ; 0088E5D0: dc.w $A01F
        dc.w    $11F8                    ; 0088E5D2: dc.w $11F8
        dc.w    $FEA9                    ; 0088E5D4: dc.w $FEA9
        dc.w    $A01D                    ; 0088E5D6: dc.w $A01D
        dc.w    $11F8                    ; 0088E5D8: dc.w $11F8
        dc.w    $FEB1                    ; 0088E5DA: dc.w $FEB1
        dc.w    $A019                    ; 0088E5DC: dc.w $A019
        dc.w    $08B8                    ; 0088E5DE: dc.w $08B8
        dc.w    $0007                    ; 0088E5E0: dc.w $0007
        dc.w    $FDA8                    ; 0088E5E2: dc.w $FDA8
        dc.w    $6030                    ; 0088E5E4: BRA.S $0088E616
        dc.w    $4238                    ; 0088E5E6: dc.w $4238
        dc.w    $A01F                    ; 0088E5E8: dc.w $A01F
        dc.w    $11F8                    ; 0088E5EA: dc.w $11F8
        dc.w    $FEA9                    ; 0088E5EC: dc.w $FEA9
        dc.w    $A01D                    ; 0088E5EE: dc.w $A01D
        dc.w    $11F8                    ; 0088E5F0: dc.w $11F8
        dc.w    $FEB1                    ; 0088E5F2: dc.w $FEB1
        dc.w    $A019                    ; 0088E5F4: dc.w $A019
        dc.w    $08F8                    ; 0088E5F6: dc.w $08F8
        dc.w    $0007                    ; 0088E5F8: dc.w $0007
        dc.w    $FDA8                    ; 0088E5FA: dc.w $FDA8
        dc.w    $6018                    ; 0088E5FC: BRA.S $0088E616
        dc.w    $11FC                    ; 0088E5FE: dc.w $11FC
        dc.w    $0001                    ; 0088E600: dc.w $0001
        dc.w    $A01F                    ; 0088E602: dc.w $A01F
        dc.w    $11F8                    ; 0088E604: dc.w $11F8
        dc.w    $FEAA                    ; 0088E606: dc.w $FEAA
        dc.w    $A01D                    ; 0088E608: dc.w $A01D
        dc.w    $08B8                    ; 0088E60A: dc.w $08B8
        dc.w    $0007                    ; 0088E60C: dc.w $0007
        dc.w    $FDA8                    ; 0088E60E: dc.w $FDA8
        dc.w    $11F8                    ; 0088E610: dc.w $11F8
        dc.w    $FEB2                    ; 0088E612: dc.w $FEB2
        dc.w    $A019                    ; 0088E614: dc.w $A019
        dc.w    $33FC                    ; 0088E616: dc.w $33FC
        dc.w    $002C                    ; 0088E618: dc.w $002C
        dc.w    $00FF                    ; 0088E61A: dc.w $00FF
        dc.w    $0008                    ; 0088E61C: dc.w $0008
        dc.w    $31FC                    ; 0088E61E: dc.w $31FC
        dc.w    $002C                    ; 0088E620: dc.w $002C
        dc.w    $C87A                    ; 0088E622: dc.w $C87A
        dc.w    $08B8                    ; 0088E624: dc.w $08B8
        dc.w    $0006                    ; 0088E626: dc.w $0006
        dc.w    $C875                    ; 0088E628: dc.w $C875
        dc.w    $3AB8                    ; 0088E62A: dc.w $3AB8
        dc.w    $C874                    ; 0088E62C: dc.w $C874
        dc.w    $33FC                    ; 0088E62E: dc.w $33FC
        dc.w    $0083                    ; 0088E630: dc.w $0083
        dc.w    $00A1                    ; 0088E632: dc.w $00A1
        dc.w    $5100                    ; 0088E634: dc.w $5100
        dc.w    $0239                    ; 0088E636: dc.w $0239
        dc.w    $00FC                    ; 0088E638: dc.w $00FC
        dc.w    $00A1                    ; 0088E63A: dc.w $00A1
        dc.w    $5181                    ; 0088E63C: dc.w $5181
        dc.w    $4EB9, $0088, $26C8    ; 0088E63E: JSR $008826C8
        dc.w    $203C                    ; 0088E644: dc.w $203C
        dc.w    $000A                    ; 0088E646: dc.w $000A
        dc.w    $0907                    ; 0088E648: dc.w $0907
        dc.w    $4EB9, $0088, $14BE    ; 0088E64A: JSR $008814BE
        dc.w    $11FC                    ; 0088E650: dc.w $11FC
        dc.w    $0001                    ; 0088E652: dc.w $0001
        dc.w    $C80D                    ; 0088E654: dc.w $C80D
        dc.w    $7000                    ; 0088E656: MOVEQ #$00,D0
        dc.w    $41F8                    ; 0088E658: dc.w $41F8
        dc.w    $8480                    ; 0088E65A: dc.w $8480
        dc.w    $721F                    ; 0088E65C: MOVEQ #$1F,D1
        dc.w    $20C0                    ; 0088E65E: dc.w $20C0
        dc.w    $51C9, $FFFC            ; 0088E660: DBRA D1,$0088E65E
        dc.w    $41F9, $00FF, $7B80    ; 0088E664: LEA $00FF7B80,A0
        dc.w    $727F                    ; 0088E66A: MOVEQ #$7F,D1
        dc.w    $20C0                    ; 0088E66C: dc.w $20C0
        dc.w    $51C9, $FFFC            ; 0088E66E: DBRA D1,$0088E66C
        dc.w    $2ABC                    ; 0088E672: dc.w $2ABC
        dc.w    $6000, $0002            ; 0088E674: BRA.W $0088E678
        dc.w    $323C                    ; 0088E678: dc.w $323C
        dc.w    $17FF                    ; 0088E67A: dc.w $17FF
        dc.w    $2C80                    ; 0088E67C: dc.w $2C80
        dc.w    $51C9, $FFFC            ; 0088E67E: DBRA D1,$0088E67C
        dc.w    $4EB9, $0088, $49AA    ; 0088E682: JSR $008849AA
        dc.w    $4278                    ; 0088E688: dc.w $4278
        dc.w    $C880                    ; 0088E68A: dc.w $C880
        dc.w    $4278                    ; 0088E68C: dc.w $4278
        dc.w    $C882                    ; 0088E68E: dc.w $C882
        dc.w    $4278                    ; 0088E690: dc.w $4278
        dc.w    $8000                    ; 0088E692: dc.w $8000
        dc.w    $4278                    ; 0088E694: dc.w $4278
        dc.w    $8002                    ; 0088E696: dc.w $8002
        dc.w    $4278                    ; 0088E698: dc.w $4278
        dc.w    $A012                    ; 0088E69A: dc.w $A012
        dc.w    $4238                    ; 0088E69C: dc.w $4238
        dc.w    $A018                    ; 0088E69E: dc.w $A018
        dc.w    $4EB9, $0088, $49AA    ; 0088E6A0: JSR $008849AA
        dc.w    $21FC                    ; 0088E6A6: dc.w $21FC
        dc.w    $008B                    ; 0088E6A8: dc.w $008B
        dc.w    $B4FC                    ; 0088E6AA: dc.w $B4FC
        dc.w    $C96C                    ; 0088E6AC: dc.w $C96C
        dc.w    $11FC                    ; 0088E6AE: dc.w $11FC
        dc.w    $0001                    ; 0088E6B0: dc.w $0001
        dc.w    $C809                    ; 0088E6B2: dc.w $C809
        dc.w    $11FC                    ; 0088E6B4: dc.w $11FC
        dc.w    $0001                    ; 0088E6B6: dc.w $0001
        dc.w    $C80A                    ; 0088E6B8: dc.w $C80A
        dc.w    $08F8                    ; 0088E6BA: dc.w $08F8
        dc.w    $0006                    ; 0088E6BC: dc.w $0006
        dc.w    $C80E                    ; 0088E6BE: dc.w $C80E
        dc.w    $11FC                    ; 0088E6C0: dc.w $11FC
        dc.w    $0001                    ; 0088E6C2: dc.w $0001
        dc.w    $C802                    ; 0088E6C4: dc.w $C802
        dc.w    $31FC                    ; 0088E6C6: dc.w $31FC
        dc.w    $0001                    ; 0088E6C8: dc.w $0001
        dc.w    $A020                    ; 0088E6CA: dc.w $A020
        dc.w    $41F9, $00FF, $1000    ; 0088E6CC: LEA $00FF1000,A0
        dc.w    $303C                    ; 0088E6D2: dc.w $303C
        dc.w    $037F                    ; 0088E6D4: dc.w $037F
        dc.w    $4298                    ; 0088E6D6: dc.w $4298
        dc.w    $51C8, $FFFC            ; 0088E6D8: DBRA D0,$0088E6D6
        dc.w    $303C                    ; 0088E6DC: dc.w $303C
        dc.w    $0001                    ; 0088E6DE: dc.w $0001
        dc.w    $323C                    ; 0088E6E0: dc.w $323C
        dc.w    $0001                    ; 0088E6E2: dc.w $0001
        dc.w    $343C                    ; 0088E6E4: dc.w $343C
        dc.w    $0001                    ; 0088E6E6: dc.w $0001
        dc.w    $363C                    ; 0088E6E8: dc.w $363C
        dc.w    $0026                    ; 0088E6EA: dc.w $0026
        dc.w    $383C                    ; 0088E6EC: dc.w $383C
        dc.w    $0014                    ; 0088E6EE: dc.w $0014
        dc.w    $41F9, $00FF, $1000    ; 0088E6F0: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088E6F6: dc.w $4EBA
        dc.w    $FB34                    ; 0088E6F8: dc.w $FB34
        dc.w    $303C                    ; 0088E6FA: dc.w $303C
        dc.w    $0002                    ; 0088E6FC: dc.w $0002
        dc.w    $323C                    ; 0088E6FE: dc.w $323C
        dc.w    $0001                    ; 0088E700: dc.w $0001
        dc.w    $343C                    ; 0088E702: dc.w $343C
        dc.w    $0016                    ; 0088E704: dc.w $0016
        dc.w    $363C                    ; 0088E706: dc.w $363C
        dc.w    $0026                    ; 0088E708: dc.w $0026
        dc.w    $383C                    ; 0088E70A: dc.w $383C
        dc.w    $0005                    ; 0088E70C: dc.w $0005
        dc.w    $41F9, $00FF, $1000    ; 0088E70E: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088E714: dc.w $4EBA
        dc.w    $FB16                    ; 0088E716: dc.w $FB16
        dc.w    $41F9, $00FF, $1000    ; 0088E718: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088E71E: dc.w $4EBA
        dc.w    $FBD0                    ; 0088E720: dc.w $FBD0
        dc.w    $4EBA                    ; 0088E722: dc.w $4EBA
        dc.w    $FA98                    ; 0088E724: dc.w $FA98
        dc.w    $08B9                    ; 0088E726: dc.w $08B9
        dc.w    $0007                    ; 0088E728: dc.w $0007
        dc.w    $00A1                    ; 0088E72A: dc.w $00A1
        dc.w    $5181                    ; 0088E72C: dc.w $5181
        dc.w    $41F9, $00FF, $6E00    ; 0088E72E: LEA $00FF6E00,A0
        dc.w    $43F9, $008B, $A220    ; 0088E734: LEA $008BA220,A1
        dc.w    $2251                    ; 0088E73A: dc.w $2251
        dc.w    $303C                    ; 0088E73C: dc.w $303C
        dc.w    $007F                    ; 0088E73E: dc.w $007F
        dc.w    $30D9                    ; 0088E740: dc.w $30D9
        dc.w    $51C8, $FFFC            ; 0088E742: DBRA D0,$0088E740
        dc.w    $41F9, $00FF, $6E00    ; 0088E746: LEA $00FF6E00,A0
        dc.w    $D1FC                    ; 0088E74C: dc.w $D1FC
        dc.w    $0000                    ; 0088E74E: dc.w $0000
        dc.w    $0160                    ; 0088E750: dc.w $0160
        dc.w    $43F9, $0088, $E88C    ; 0088E752: LEA $0088E88C,A1
        dc.w    $303C                    ; 0088E758: dc.w $303C
        dc.w    $003F                    ; 0088E75A: dc.w $003F
        dc.w    $3219                    ; 0088E75C: dc.w $3219
        dc.w    $08C1                    ; 0088E75E: dc.w $08C1
        dc.w    $000F                    ; 0088E760: dc.w $000F
        dc.w    $30C1                    ; 0088E762: dc.w $30C1
        dc.w    $51C8, $FFF6            ; 0088E764: DBRA D0,$0088E75C
        dc.w    $41F9, $000E, $9680    ; 0088E768: LEA $000E9680,A0
        dc.w    $227C, $0603, $8000    ; 0088E76E: MOVEA.L #$06038000,A1
        dc.w    $4EBA                    ; 0088E774: dc.w $4EBA
        dc.w    $FBA0                    ; 0088E776: dc.w $FBA0
        dc.w    $41F9, $000E, $9450    ; 0088E778: LEA $000E9450,A0
        dc.w    $227C, $0603, $B600    ; 0088E77E: MOVEA.L #$0603B600,A1
        dc.w    $4EBA                    ; 0088E784: dc.w $4EBA
        dc.w    $FB90                    ; 0088E786: dc.w $FB90
        dc.w    $41F9, $000E, $90A0    ; 0088E788: LEA $000E90A0,A0
        dc.w    $227C, $0603, $D100    ; 0088E78E: MOVEA.L #$0603D100,A1
        dc.w    $4EBA                    ; 0088E794: dc.w $4EBA
        dc.w    $FB80                    ; 0088E796: dc.w $FB80
        dc.w    $41F9, $000E, $9240    ; 0088E798: LEA $000E9240,A0
        dc.w    $227C, $0603, $D800    ; 0088E79E: MOVEA.L #$0603D800,A1
        dc.w    $4EBA                    ; 0088E7A4: dc.w $4EBA
        dc.w    $FB70                    ; 0088E7A6: dc.w $FB70
        dc.w    $11F8                    ; 0088E7A8: dc.w $11F8
        dc.w    $A019                    ; 0088E7AA: dc.w $A019
        dc.w    $A01E                    ; 0088E7AC: dc.w $A01E
        dc.w    $4238                    ; 0088E7AE: dc.w $4238
        dc.w    $A01A                    ; 0088E7B0: dc.w $A01A
        dc.w    $33FC                    ; 0088E7B2: dc.w $33FC
        dc.w    $0080                    ; 0088E7B4: dc.w $0080
        dc.w    $00FF                    ; 0088E7B6: dc.w $00FF
        dc.w    $2000                    ; 0088E7B8: dc.w $2000
        dc.w    $33FC                    ; 0088E7BA: dc.w $33FC
        dc.w    $FF80                    ; 0088E7BC: dc.w $FF80
        dc.w    $00FF                    ; 0088E7BE: dc.w $00FF
        dc.w    $2002                    ; 0088E7C0: dc.w $2002
        dc.w    $33FC                    ; 0088E7C2: dc.w $33FC
        dc.w    $003C                    ; 0088E7C4: dc.w $003C
        dc.w    $00FF                    ; 0088E7C6: dc.w $00FF
        dc.w    $2004                    ; 0088E7C8: dc.w $2004
        dc.w    $33FC                    ; 0088E7CA: dc.w $33FC
        dc.w    $00BC                    ; 0088E7CC: dc.w $00BC
        dc.w    $00FF                    ; 0088E7CE: dc.w $00FF
        dc.w    $2006                    ; 0088E7D0: dc.w $2006
        dc.w    $33FC                    ; 0088E7D2: dc.w $33FC
        dc.w    $FF60                    ; 0088E7D4: dc.w $FF60
        dc.w    $00FF                    ; 0088E7D6: dc.w $00FF
        dc.w    $2008                    ; 0088E7D8: dc.w $2008
        dc.w    $33FC                    ; 0088E7DA: dc.w $33FC
        dc.w    $0044                    ; 0088E7DC: dc.w $0044
        dc.w    $00FF                    ; 0088E7DE: dc.w $00FF
        dc.w    $200A                    ; 0088E7E0: dc.w $200A
        dc.w    $33FC                    ; 0088E7E2: dc.w $33FC
        dc.w    $0080                    ; 0088E7E4: dc.w $0080
        dc.w    $00FF                    ; 0088E7E6: dc.w $00FF
        dc.w    $200C                    ; 0088E7E8: dc.w $200C
        dc.w    $33FC                    ; 0088E7EA: dc.w $33FC
        dc.w    $FF80                    ; 0088E7EC: dc.w $FF80
        dc.w    $00FF                    ; 0088E7EE: dc.w $00FF
        dc.w    $200E                    ; 0088E7F0: dc.w $200E
        dc.w    $33FC                    ; 0088E7F2: dc.w $33FC
        dc.w    $003C                    ; 0088E7F4: dc.w $003C
        dc.w    $00FF                    ; 0088E7F6: dc.w $00FF
        dc.w    $2010                    ; 0088E7F8: dc.w $2010
        dc.w    $4EB9, $0088, $204A    ; 0088E7FA: JSR $0088204A
        dc.w    $0239                    ; 0088E800: dc.w $0239
        dc.w    $00FC                    ; 0088E802: dc.w $00FC
        dc.w    $00A1                    ; 0088E804: dc.w $00A1
        dc.w    $5181                    ; 0088E806: dc.w $5181
        dc.w    $0039                    ; 0088E808: dc.w $0039
        dc.w    $0001                    ; 0088E80A: dc.w $0001
        dc.w    $00A1                    ; 0088E80C: dc.w $00A1
        dc.w    $5181                    ; 0088E80E: dc.w $5181
        dc.w    $33FC                    ; 0088E810: dc.w $33FC
        dc.w    $8083                    ; 0088E812: dc.w $8083
        dc.w    $00A1                    ; 0088E814: dc.w $00A1
        dc.w    $5100                    ; 0088E816: dc.w $5100
        dc.w    $08F8                    ; 0088E818: dc.w $08F8
        dc.w    $0006                    ; 0088E81A: dc.w $0006
        dc.w    $C875                    ; 0088E81C: dc.w $C875
        dc.w    $3AB8                    ; 0088E81E: dc.w $3AB8
        dc.w    $C874                    ; 0088E820: dc.w $C874
        dc.w    $33FC                    ; 0088E822: dc.w $33FC
        dc.w    $0020                    ; 0088E824: dc.w $0020
        dc.w    $00FF                    ; 0088E826: dc.w $00FF
        dc.w    $0008                    ; 0088E828: dc.w $0008
        dc.w    $4EB9, $0088, $4998    ; 0088E82A: JSR $00884998
        dc.w    $31FC                    ; 0088E830: dc.w $31FC
        dc.w    $0000                    ; 0088E832: dc.w $0000
        dc.w    $C87E                    ; 0088E834: dc.w $C87E
        dc.w    $23FC, $0088, $E90C, $00FF, $0002  ; 0088E836: MOVE.L #$0088E90C,$00FF0002
        dc.w    $11FC                    ; 0088E840: dc.w $11FC
        dc.w    $0081                    ; 0088E842: dc.w $0081
        dc.w    $C8A5                    ; 0088E844: dc.w $C8A5
        dc.w    $13FC                    ; 0088E846: dc.w $13FC
        dc.w    $0000                    ; 0088E848: dc.w $0000
        dc.w    $00FF                    ; 0088E84A: dc.w $00FF
        dc.w    $60D4                    ; 0088E84C: BRA.S $0088E822
        dc.w    $41F9, $00FF, $6100    ; 0088E84E: LEA $00FF6100,A0
        dc.w    $303C                    ; 0088E854: dc.w $303C
        dc.w    $007F                    ; 0088E856: dc.w $007F
        dc.w    $4298                    ; 0088E858: dc.w $4298
        dc.w    $4298                    ; 0088E85A: dc.w $4298
        dc.w    $4298                    ; 0088E85C: dc.w $4298
        dc.w    $4298                    ; 0088E85E: dc.w $4298
        dc.w    $4298                    ; 0088E860: dc.w $4298
        dc.w    $51C8, $FFF4            ; 0088E862: DBRA D0,$0088E858
        dc.w    $4A39                    ; 0088E866: dc.w $4A39
        dc.w    $00A1                    ; 0088E868: dc.w $00A1
        dc.w    $5120                    ; 0088E86A: dc.w $5120
        dc.w    $66F8                    ; 0088E86C: BNE.S $0088E866
        dc.w    $4239                    ; 0088E86E: dc.w $4239
        dc.w    $00A1                    ; 0088E870: dc.w $00A1
        dc.w    $5122                    ; 0088E872: dc.w $5122
        dc.w    $4239                    ; 0088E874: dc.w $4239
        dc.w    $00A1                    ; 0088E876: dc.w $00A1
        dc.w    $5123                    ; 0088E878: dc.w $5123
        dc.w    $13FC                    ; 0088E87A: dc.w $13FC
        dc.w    $0003                    ; 0088E87C: dc.w $0003
        dc.w    $00A1                    ; 0088E87E: dc.w $00A1
        dc.w    $5121                    ; 0088E880: dc.w $5121
        dc.w    $13FC                    ; 0088E882: dc.w $13FC
        dc.w    $0001                    ; 0088E884: dc.w $0001
        dc.w    $00A1                    ; 0088E886: dc.w $00A1
        dc.w    $5120                    ; 0088E888: dc.w $5120
        dc.w    $4E75                    ; 0088E88A: RTS
        dc.w    $4400                    ; 0088E88C: dc.w $4400
        dc.w    $44A3                    ; 0088E88E: dc.w $44A3
        dc.w    $4946                    ; 0088E890: dc.w $4946
        dc.w    $4DE9                    ; 0088E892: dc.w $4DE9
        dc.w    $1C00                    ; 0088E894: dc.w $1C00
        dc.w    $28A3                    ; 0088E896: dc.w $28A3
        dc.w    $3546                    ; 0088E898: dc.w $3546
        dc.w    $41E9                    ; 0088E89A: dc.w $41E9
        dc.w    $7FFF                    ; 0088E89C: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E89E: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E8A0: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E8A2: dc.w $7FFF
        dc.w    $1C00                    ; 0088E8A4: dc.w $1C00
        dc.w    $28A3                    ; 0088E8A6: dc.w $28A3
        dc.w    $3546                    ; 0088E8A8: dc.w $3546
        dc.w    $41E9                    ; 0088E8AA: dc.w $41E9
        dc.w    $4400                    ; 0088E8AC: dc.w $4400
        dc.w    $44A3                    ; 0088E8AE: dc.w $44A3
        dc.w    $4946                    ; 0088E8B0: dc.w $4946
        dc.w    $4DE9                    ; 0088E8B2: dc.w $4DE9
        dc.w    $7FFF                    ; 0088E8B4: dc.w $7FFF
        dc.w    $63F5                    ; 0088E8B6: BLS.S $0088E8AD
        dc.w    $7FFF                    ; 0088E8B8: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E8BA: dc.w $7FFF
        dc.w    $0010                    ; 0088E8BC: dc.w $0010
        dc.w    $14AF                    ; 0088E8BE: dc.w $14AF
        dc.w    $294E                    ; 0088E8C0: dc.w $294E
        dc.w    $3DED                    ; 0088E8C2: dc.w $3DED
        dc.w    $7FFF                    ; 0088E8C4: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E8C6: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E8C8: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E8CA: dc.w $7FFF
        dc.w    $77BA                    ; 0088E8CC: dc.w $77BA
        dc.w    $7BBC                    ; 0088E8CE: dc.w $7BBC
        dc.w    $779A                    ; 0088E8D0: dc.w $779A
        dc.w    $77BC                    ; 0088E8D2: dc.w $77BC
        dc.w    $6B36                    ; 0088E8D4: BMI.S $0088E90C
        dc.w    $6B37                    ; 0088E8D6: BMI.S $0088E90F
        dc.w    $6F58                    ; 0088E8D8: BLE.S $0088E932
        dc.w    $6F79                    ; 0088E8DA: BLE.S $0088E955
        dc.w    $739A                    ; 0088E8DC: dc.w $739A
        dc.w    $61E8                    ; 0088E8DE: BSR.S $0088E8C8
        dc.w    $7FFF                    ; 0088E8E0: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E8E2: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E8E4: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E8E6: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E8E8: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E8EA: dc.w $7FFF
        dc.w    $7FBC                    ; 0088E8EC: dc.w $7FBC
        dc.w    $7F7A                    ; 0088E8EE: dc.w $7F7A
        dc.w    $7FDE                    ; 0088E8F0: dc.w $7FDE
        dc.w    $7F9B                    ; 0088E8F2: dc.w $7F9B
        dc.w    $4445                    ; 0088E8F4: dc.w $4445
        dc.w    $512B                    ; 0088E8F6: dc.w $512B
        dc.w    $6212                    ; 0088E8F8: BHI.S $0088E90C
        dc.w    $6EF8                    ; 0088E8FA: BGT.S $0088E8F4
        dc.w    $7FFF                    ; 0088E8FC: dc.w $7FFF
        dc.w    $031F                    ; 0088E8FE: dc.w $031F
        dc.w    $7FFF                    ; 0088E900: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E902: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E904: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E906: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E908: dc.w $7FFF
        dc.w    $7FFF                    ; 0088E90A: dc.w $7FFF
        dc.w    $4EB9, $0088, $2080    ; 0088E90C: JSR $00882080
        dc.w    $3038                    ; 0088E912: dc.w $3038
        dc.w    $C87E                    ; 0088E914: dc.w $C87E
        dc.w    $227B                    ; 0088E916: dc.w $227B
        dc.w    $0004                    ; 0088E918: dc.w $0004
        dc.w    $4ED1                    ; 0088E91A: JMP (A1)
        dc.w    $0088                    ; 0088E91C: dc.w $0088
        dc.w    $E93A                    ; 0088E91E: dc.w $E93A
        dc.w    $0088                    ; 0088E920: dc.w $0088
        dc.w    $EDDA                    ; 0088E922: dc.w $EDDA
        dc.w    $0088                    ; 0088E924: dc.w $0088
        dc.w    $EEF2                    ; 0088E926: dc.w $EEF2
        dc.w    $4EBA                    ; 0088E928: dc.w $4EBA
        dc.w    $CD5A                    ; 0088E92A: dc.w $CD5A
        dc.w    $0838                    ; 0088E92C: dc.w $0838
        dc.w    $0006                    ; 0088E92E: dc.w $0006
        dc.w    $C80E                    ; 0088E930: dc.w $C80E
        dc.w    $6604                    ; 0088E932: BNE.S $0088E938
        dc.w    $5878                    ; 0088E934: dc.w $5878
        dc.w    $C87E                    ; 0088E936: dc.w $C87E
        dc.w    $4E75                    ; 0088E938: RTS
        dc.w    $207C, $0603, $8000    ; 0088E93A: MOVEA.L #$06038000,A0
        dc.w    $227C, $0401, $2010    ; 0088E940: MOVEA.L #$04012010,A1
        dc.w    $303C                    ; 0088E946: dc.w $303C
        dc.w    $0120                    ; 0088E948: dc.w $0120
        dc.w    $323C                    ; 0088E94A: dc.w $323C
        dc.w    $0030                    ; 0088E94C: dc.w $0030
        dc.w    $4EBA                    ; 0088E94E: dc.w $4EBA
        dc.w    $FA0A                    ; 0088E950: dc.w $FA0A
        dc.w    $207C, $0603, $B600    ; 0088E952: MOVEA.L #$0603B600,A0
        dc.w    $227C, $0401, $B010    ; 0088E958: MOVEA.L #$0401B010,A1
        dc.w    $303C                    ; 0088E95E: dc.w $303C
        dc.w    $0120                    ; 0088E960: dc.w $0120
        dc.w    $323C                    ; 0088E962: dc.w $323C
        dc.w    $0018                    ; 0088E964: dc.w $0018
        dc.w    $4EBA                    ; 0088E966: dc.w $4EBA
        dc.w    $F9F2                    ; 0088E968: dc.w $F9F2
        dc.w    $7000                    ; 0088E96A: MOVEQ #$00,D0
        dc.w    $4A38                    ; 0088E96C: dc.w $4A38
        dc.w    $A01A                    ; 0088E96E: dc.w $A01A
        dc.w    $6606                    ; 0088E970: BNE.S $0088E978
        dc.w    $1038                    ; 0088E972: dc.w $1038
        dc.w    $A019                    ; 0088E974: dc.w $A019
        dc.w    $6004                    ; 0088E976: BRA.S $0088E97C
        dc.w    $1038                    ; 0088E978: dc.w $1038
        dc.w    $A01E                    ; 0088E97A: dc.w $A01E
        dc.w    $3200                    ; 0088E97C: dc.w $3200
        dc.w    $D241                    ; 0088E97E: dc.w $D241
        dc.w    $D241                    ; 0088E980: dc.w $D241
        dc.w    $41F9, $00FF, $6E00    ; 0088E982: LEA $00FF6E00,A0
        dc.w    $43F9, $0088, $EACE    ; 0088E988: LEA $0088EACE,A1
        dc.w    $2271                    ; 0088E98E: dc.w $2271
        dc.w    $1000                    ; 0088E990: dc.w $1000
        dc.w    $323C                    ; 0088E992: dc.w $323C
        dc.w    $007F                    ; 0088E994: dc.w $007F
        dc.w    $30D9                    ; 0088E996: dc.w $30D9
        dc.w    $51C9, $FFFC            ; 0088E998: DBRA D1,$0088E996
        dc.w    $41F9, $0088, $EAC2    ; 0088E99C: LEA $0088EAC2,A0
        dc.w    $D040                    ; 0088E9A2: dc.w $D040
        dc.w    $D040                    ; 0088E9A4: dc.w $D040
        dc.w    $2070                    ; 0088E9A6: dc.w $2070
        dc.w    $0000                    ; 0088E9A8: dc.w $0000
        dc.w    $2038                    ; 0088E9AA: dc.w $2038
        dc.w    $A014                    ; 0088E9AC: dc.w $A014
        dc.w    $4E90                    ; 0088E9AE: dc.w $4E90
        dc.w    $0839                    ; 0088E9B0: dc.w $0839
        dc.w    $0001                    ; 0088E9B2: dc.w $0001
        dc.w    $00A1                    ; 0088E9B4: dc.w $00A1
        dc.w    $5123                    ; 0088E9B6: dc.w $5123
        dc.w    $67F6                    ; 0088E9B8: BEQ.S $0088E9B0
        dc.w    $08B9                    ; 0088E9BA: dc.w $08B9
        dc.w    $0001                    ; 0088E9BC: dc.w $0001
        dc.w    $00A1                    ; 0088E9BE: dc.w $00A1
        dc.w    $5123                    ; 0088E9C0: dc.w $5123
        dc.w    $43F9, $00FF, $60C8    ; 0088E9C2: LEA $00FF60C8,A1
        dc.w    $45F9, $00A1, $5112    ; 0088E9C8: LEA $00A15112,A2
        dc.w    $3E3C                    ; 0088E9CE: dc.w $3E3C
        dc.w    $0043                    ; 0088E9D0: dc.w $0043
        dc.w    $0839                    ; 0088E9D2: dc.w $0839
        dc.w    $0007                    ; 0088E9D4: dc.w $0007
        dc.w    $00A1                    ; 0088E9D6: dc.w $00A1
        dc.w    $5107                    ; 0088E9D8: dc.w $5107
        dc.w    $66F6                    ; 0088E9DA: BNE.S $0088E9D2
        dc.w    $3499                    ; 0088E9DC: dc.w $3499
        dc.w    $51CF, $FFF2            ; 0088E9DE: DBRA D7,$0088E9D2
        dc.w    $2038                    ; 0088E9E2: dc.w $2038
        dc.w    $A014                    ; 0088E9E4: dc.w $A014
        dc.w    $0680                    ; 0088E9E6: dc.w $0680
        dc.w    $0000                    ; 0088E9E8: dc.w $0000
        dc.w    $0080                    ; 0088E9EA: dc.w $0080
        dc.w    $0280                    ; 0088E9EC: dc.w $0280
        dc.w    $0000                    ; 0088E9EE: dc.w $0000
        dc.w    $FFFF                    ; 0088E9F0: dc.w $FFFF
        dc.w    $21C0                    ; 0088E9F2: dc.w $21C0
        dc.w    $A014                    ; 0088E9F4: dc.w $A014
        dc.w    $4240                    ; 0088E9F6: dc.w $4240
        dc.w    $1038                    ; 0088E9F8: dc.w $1038
        dc.w    $A01A                    ; 0088E9FA: dc.w $A01A
        dc.w    $6100, $FB2E            ; 0088E9FC: BSR.W $0088E52C
        dc.w    $4EB9, $0088, $179E    ; 0088EA00: JSR $0088179E
        dc.w    $4A78                    ; 0088EA06: dc.w $4A78
        dc.w    $A020                    ; 0088EA08: dc.w $A020
        dc.w    $6600, $00A8            ; 0088EA0A: BNE.W $0088EAB4
        dc.w    $1038                    ; 0088EA0E: dc.w $1038
        dc.w    $A019                    ; 0088EA10: dc.w $A019
        dc.w    $3238                    ; 0088EA12: dc.w $3238
        dc.w    $C86C                    ; 0088EA14: dc.w $C86C
        dc.w    $0801                    ; 0088EA16: dc.w $0801
        dc.w    $0003                    ; 0088EA18: dc.w $0003
        dc.w    $6726                    ; 0088EA1A: BEQ.S $0088EA42
        dc.w    $11FC                    ; 0088EA1C: dc.w $11FC
        dc.w    $00A9                    ; 0088EA1E: dc.w $00A9
        dc.w    $C8A4                    ; 0088EA20: dc.w $C8A4
        dc.w    $4A38                    ; 0088EA22: dc.w $4A38
        dc.w    $A01A                    ; 0088EA24: dc.w $A01A
        dc.w    $6700, $000C            ; 0088EA26: BEQ.W $0088EA34
        dc.w    $0C00                    ; 0088EA2A: dc.w $0C00
        dc.w    $0001                    ; 0088EA2C: dc.w $0001
        dc.w    $6C0E                    ; 0088EA2E: BGE.S $0088EA3E
        dc.w    $6000, $0008            ; 0088EA30: BRA.W $0088EA3A
        dc.w    $0C00                    ; 0088EA34: dc.w $0C00
        dc.w    $0002                    ; 0088EA36: dc.w $0002
        dc.w    $6C04                    ; 0088EA38: BGE.S $0088EA3E
        dc.w    $5200                    ; 0088EA3A: dc.w $5200
        dc.w    $6072                    ; 0088EA3C: BRA.S $0088EAB0
        dc.w    $4200                    ; 0088EA3E: dc.w $4200
        dc.w    $606E                    ; 0088EA40: BRA.S $0088EAB0
        dc.w    $0801                    ; 0088EA42: dc.w $0801
        dc.w    $0002                    ; 0088EA44: dc.w $0002
        dc.w    $6722                    ; 0088EA46: BEQ.S $0088EA6A
        dc.w    $11FC                    ; 0088EA48: dc.w $11FC
        dc.w    $00A9                    ; 0088EA4A: dc.w $00A9
        dc.w    $C8A4                    ; 0088EA4C: dc.w $C8A4
        dc.w    $4A00                    ; 0088EA4E: dc.w $4A00
        dc.w    $6F04                    ; 0088EA50: BLE.S $0088EA56
        dc.w    $5300                    ; 0088EA52: dc.w $5300
        dc.w    $605A                    ; 0088EA54: BRA.S $0088EAB0
        dc.w    $4A38                    ; 0088EA56: dc.w $4A38
        dc.w    $A01A                    ; 0088EA58: dc.w $A01A
        dc.w    $6700, $0008            ; 0088EA5A: BEQ.W $0088EA64
        dc.w    $103C                    ; 0088EA5E: dc.w $103C
        dc.w    $0001                    ; 0088EA60: dc.w $0001
        dc.w    $604C                    ; 0088EA62: BRA.S $0088EAB0
        dc.w    $103C                    ; 0088EA64: dc.w $103C
        dc.w    $0002                    ; 0088EA66: dc.w $0002
        dc.w    $6046                    ; 0088EA68: BRA.S $0088EAB0
        dc.w    $0801                    ; 0088EA6A: dc.w $0801
        dc.w    $0000                    ; 0088EA6C: dc.w $0000
        dc.w    $6700, $001C            ; 0088EA6E: BEQ.W $0088EA8C
        dc.w    $4A38                    ; 0088EA72: dc.w $4A38
        dc.w    $A01A                    ; 0088EA74: dc.w $A01A
        dc.w    $6738                    ; 0088EA76: BEQ.S $0088EAB0
        dc.w    $11FC                    ; 0088EA78: dc.w $11FC
        dc.w    $00A9                    ; 0088EA7A: dc.w $00A9
        dc.w    $C8A4                    ; 0088EA7C: dc.w $C8A4
        dc.w    $4238                    ; 0088EA7E: dc.w $4238
        dc.w    $A01A                    ; 0088EA80: dc.w $A01A
        dc.w    $11C0                    ; 0088EA82: dc.w $11C0
        dc.w    $A01D                    ; 0088EA84: dc.w $A01D
        dc.w    $1038                    ; 0088EA86: dc.w $1038
        dc.w    $A01E                    ; 0088EA88: dc.w $A01E
        dc.w    $6024                    ; 0088EA8A: BRA.S $0088EAB0
        dc.w    $0801                    ; 0088EA8C: dc.w $0801
        dc.w    $0001                    ; 0088EA8E: dc.w $0001
        dc.w    $6700, $001E            ; 0088EA90: BEQ.W $0088EAB0
        dc.w    $0C38                    ; 0088EA94: dc.w $0C38
        dc.w    $0001                    ; 0088EA96: dc.w $0001
        dc.w    $A01A                    ; 0088EA98: dc.w $A01A
        dc.w    $6C14                    ; 0088EA9A: BGE.S $0088EAB0
        dc.w    $11FC                    ; 0088EA9C: dc.w $11FC
        dc.w    $00A9                    ; 0088EA9E: dc.w $00A9
        dc.w    $C8A4                    ; 0088EAA0: dc.w $C8A4
        dc.w    $11FC                    ; 0088EAA2: dc.w $11FC
        dc.w    $0001                    ; 0088EAA4: dc.w $0001
        dc.w    $A01A                    ; 0088EAA6: dc.w $A01A
        dc.w    $11C0                    ; 0088EAA8: dc.w $11C0
        dc.w    $A01E                    ; 0088EAAA: dc.w $A01E
        dc.w    $1038                    ; 0088EAAC: dc.w $1038
        dc.w    $A01D                    ; 0088EAAE: dc.w $A01D
        dc.w    $11C0                    ; 0088EAB0: dc.w $11C0
        dc.w    $A019                    ; 0088EAB2: dc.w $A019
        dc.w    $5878                    ; 0088EAB4: dc.w $5878
        dc.w    $C87E                    ; 0088EAB6: dc.w $C87E
        dc.w    $33FC                    ; 0088EAB8: dc.w $33FC
        dc.w    $0020                    ; 0088EABA: dc.w $0020
        dc.w    $00FF                    ; 0088EABC: dc.w $00FF
        dc.w    $0008                    ; 0088EABE: dc.w $0008
        dc.w    $4E75                    ; 0088EAC0: RTS
        dc.w    $0088                    ; 0088EAC2: dc.w $0088
        dc.w    $EFC2                    ; 0088EAC4: dc.w $EFC2
        dc.w    $0088                    ; 0088EAC6: dc.w $0088
        dc.w    $F040                    ; 0088EAC8: dc.w $F040
        dc.w    $0088                    ; 0088EACA: dc.w $0088
        dc.w    $F0BE                    ; 0088EACC: dc.w $F0BE
        dc.w    $0088                    ; 0088EACE: dc.w $0088
        dc.w    $EADA                    ; 0088EAD0: dc.w $EADA
        dc.w    $0088                    ; 0088EAD2: dc.w $0088
        dc.w    $EBDA                    ; 0088EAD4: dc.w $EBDA
        dc.w    $0088                    ; 0088EAD6: dc.w $0088
        dc.w    $ECDA                    ; 0088EAD8: dc.w $ECDA
        dc.w    $0000                    ; 0088EADA: dc.w $0000
        dc.w    $8000                    ; 0088EADC: dc.w $8000
        dc.w    $8421                    ; 0088EADE: dc.w $8421
        dc.w    $8842                    ; 0088EAE0: dc.w $8842
        dc.w    $8C63                    ; 0088EAE2: dc.w $8C63
        dc.w    $9084                    ; 0088EAE4: dc.w $9084
        dc.w    $94A5                    ; 0088EAE6: dc.w $94A5
        dc.w    $98C6                    ; 0088EAE8: dc.w $98C6
        dc.w    $9CE7                    ; 0088EAEA: dc.w $9CE7
        dc.w    $A108                    ; 0088EAEC: dc.w $A108
        dc.w    $A529                    ; 0088EAEE: dc.w $A529
        dc.w    $A94A                    ; 0088EAF0: dc.w $A94A
        dc.w    $AD6B                    ; 0088EAF2: dc.w $AD6B
        dc.w    $B18C                    ; 0088EAF4: dc.w $B18C
        dc.w    $B5AD                    ; 0088EAF6: dc.w $B5AD
        dc.w    $B9CE                    ; 0088EAF8: dc.w $B9CE
        dc.w    $BDEF                    ; 0088EAFA: dc.w $BDEF
        dc.w    $C210                    ; 0088EAFC: dc.w $C210
        dc.w    $C631                    ; 0088EAFE: dc.w $C631
        dc.w    $CA52                    ; 0088EB00: dc.w $CA52
        dc.w    $CE73                    ; 0088EB02: dc.w $CE73
        dc.w    $D294                    ; 0088EB04: dc.w $D294
        dc.w    $D6B5                    ; 0088EB06: dc.w $D6B5
        dc.w    $DAD6                    ; 0088EB08: dc.w $DAD6
        dc.w    $DEF7                    ; 0088EB0A: dc.w $DEF7
        dc.w    $E318                    ; 0088EB0C: dc.w $E318
        dc.w    $E739                    ; 0088EB0E: dc.w $E739
        dc.w    $EB5A                    ; 0088EB10: dc.w $EB5A
        dc.w    $EF7B                    ; 0088EB12: dc.w $EF7B
        dc.w    $F39C                    ; 0088EB14: dc.w $F39C
        dc.w    $F7BD                    ; 0088EB16: dc.w $F7BD
        dc.w    $FBDE                    ; 0088EB18: dc.w $FBDE
        dc.w    $FFFF                    ; 0088EB1A: dc.w $FFFF
        dc.w    $800A                    ; 0088EB1C: dc.w $800A
        dc.w    $800B                    ; 0088EB1E: dc.w $800B
        dc.w    $800C                    ; 0088EB20: dc.w $800C
        dc.w    $800D                    ; 0088EB22: dc.w $800D
        dc.w    $800E                    ; 0088EB24: dc.w $800E
        dc.w    $800F                    ; 0088EB26: dc.w $800F
        dc.w    $8010                    ; 0088EB28: dc.w $8010
        dc.w    $8011                    ; 0088EB2A: dc.w $8011
        dc.w    $8012                    ; 0088EB2C: dc.w $8012
        dc.w    $8432                    ; 0088EB2E: dc.w $8432
        dc.w    $8C73                    ; 0088EB30: dc.w $8C73
        dc.w    $9094                    ; 0088EB32: dc.w $9094
        dc.w    $98D4                    ; 0088EB34: dc.w $98D4
        dc.w    $A536                    ; 0088EB36: dc.w $A536
        dc.w    $BC00                    ; 0088EB38: dc.w $BC00
        dc.w    $C800                    ; 0088EB3A: dc.w $C800
        dc.w    $D800                    ; 0088EB3C: dc.w $D800
        dc.w    $E000                    ; 0088EB3E: dc.w $E000
        dc.w    $E063                    ; 0088EB40: dc.w $E063
        dc.w    $E484                    ; 0088EB42: dc.w $E484
        dc.w    $E4C6                    ; 0088EB44: dc.w $E4C6
        dc.w    $E4E7                    ; 0088EB46: dc.w $E4E7
        dc.w    $E929                    ; 0088EB48: dc.w $E929
        dc.w    $F2B5                    ; 0088EB4A: dc.w $F2B5
        dc.w    $F718                    ; 0088EB4C: dc.w $F718
        dc.w    $8000                    ; 0088EB4E: dc.w $8000
        dc.w    $8000                    ; 0088EB50: dc.w $8000
        dc.w    $8000                    ; 0088EB52: dc.w $8000
        dc.w    $8000                    ; 0088EB54: dc.w $8000
        dc.w    $8000                    ; 0088EB56: dc.w $8000
        dc.w    $8000                    ; 0088EB58: dc.w $8000
        dc.w    $8000                    ; 0088EB5A: dc.w $8000
        dc.w    $8000                    ; 0088EB5C: dc.w $8000
        dc.w    $8000                    ; 0088EB5E: dc.w $8000
        dc.w    $8000                    ; 0088EB60: dc.w $8000
        dc.w    $8000                    ; 0088EB62: dc.w $8000
        dc.w    $8000                    ; 0088EB64: dc.w $8000
        dc.w    $94A0                    ; 0088EB66: dc.w $94A0
        dc.w    $8840                    ; 0088EB68: dc.w $8840
        dc.w    $8000                    ; 0088EB6A: dc.w $8000
        dc.w    $8840                    ; 0088EB6C: dc.w $8840
        dc.w    $9080                    ; 0088EB6E: dc.w $9080
        dc.w    $98C1                    ; 0088EB70: dc.w $98C1
        dc.w    $A103                    ; 0088EB72: dc.w $A103
        dc.w    $A945                    ; 0088EB74: dc.w $A945
        dc.w    $0000                    ; 0088EB76: dc.w $0000
        dc.w    $0000                    ; 0088EB78: dc.w $0000
        dc.w    $0000                    ; 0088EB7A: dc.w $0000
        dc.w    $0000                    ; 0088EB7C: dc.w $0000
        dc.w    $0000                    ; 0088EB7E: dc.w $0000
        dc.w    $0000                    ; 0088EB80: dc.w $0000
        dc.w    $0000                    ; 0088EB82: dc.w $0000
        dc.w    $0000                    ; 0088EB84: dc.w $0000
        dc.w    $0000                    ; 0088EB86: dc.w $0000
        dc.w    $0000                    ; 0088EB88: dc.w $0000
        dc.w    $0000                    ; 0088EB8A: dc.w $0000
        dc.w    $0000                    ; 0088EB8C: dc.w $0000
        dc.w    $0000                    ; 0088EB8E: dc.w $0000
        dc.w    $0000                    ; 0088EB90: dc.w $0000
        dc.w    $0000                    ; 0088EB92: dc.w $0000
        dc.w    $0000                    ; 0088EB94: dc.w $0000
        dc.w    $0000                    ; 0088EB96: dc.w $0000
        dc.w    $0000                    ; 0088EB98: dc.w $0000
        dc.w    $0000                    ; 0088EB9A: dc.w $0000
        dc.w    $0000                    ; 0088EB9C: dc.w $0000
        dc.w    $0000                    ; 0088EB9E: dc.w $0000
        dc.w    $0000                    ; 0088EBA0: dc.w $0000
        dc.w    $0000                    ; 0088EBA2: dc.w $0000
        dc.w    $0000                    ; 0088EBA4: dc.w $0000
        dc.w    $0000                    ; 0088EBA6: dc.w $0000
        dc.w    $0000                    ; 0088EBA8: dc.w $0000
        dc.w    $0000                    ; 0088EBAA: dc.w $0000
        dc.w    $0000                    ; 0088EBAC: dc.w $0000
        dc.w    $0000                    ; 0088EBAE: dc.w $0000
        dc.w    $0000                    ; 0088EBB0: dc.w $0000
        dc.w    $0000                    ; 0088EBB2: dc.w $0000
        dc.w    $0000                    ; 0088EBB4: dc.w $0000
        dc.w    $0000                    ; 0088EBB6: dc.w $0000
        dc.w    $0000                    ; 0088EBB8: dc.w $0000
        dc.w    $0000                    ; 0088EBBA: dc.w $0000
        dc.w    $0000                    ; 0088EBBC: dc.w $0000
        dc.w    $0000                    ; 0088EBBE: dc.w $0000
        dc.w    $0000                    ; 0088EBC0: dc.w $0000
        dc.w    $0000                    ; 0088EBC2: dc.w $0000
        dc.w    $0000                    ; 0088EBC4: dc.w $0000
        dc.w    $0000                    ; 0088EBC6: dc.w $0000
        dc.w    $0000                    ; 0088EBC8: dc.w $0000
        dc.w    $0000                    ; 0088EBCA: dc.w $0000
        dc.w    $0000                    ; 0088EBCC: dc.w $0000
        dc.w    $0000                    ; 0088EBCE: dc.w $0000
        dc.w    $0000                    ; 0088EBD0: dc.w $0000
        dc.w    $0000                    ; 0088EBD2: dc.w $0000
        dc.w    $0000                    ; 0088EBD4: dc.w $0000
        dc.w    $0000                    ; 0088EBD6: dc.w $0000
        dc.w    $0000                    ; 0088EBD8: dc.w $0000
        dc.w    $0000                    ; 0088EBDA: dc.w $0000
        dc.w    $8000                    ; 0088EBDC: dc.w $8000
        dc.w    $8421                    ; 0088EBDE: dc.w $8421
        dc.w    $8842                    ; 0088EBE0: dc.w $8842
        dc.w    $8C63                    ; 0088EBE2: dc.w $8C63
        dc.w    $9084                    ; 0088EBE4: dc.w $9084
        dc.w    $94A5                    ; 0088EBE6: dc.w $94A5
        dc.w    $98C6                    ; 0088EBE8: dc.w $98C6
        dc.w    $9CE7                    ; 0088EBEA: dc.w $9CE7
        dc.w    $A108                    ; 0088EBEC: dc.w $A108
        dc.w    $A529                    ; 0088EBEE: dc.w $A529
        dc.w    $A94A                    ; 0088EBF0: dc.w $A94A
        dc.w    $AD6B                    ; 0088EBF2: dc.w $AD6B
        dc.w    $B18C                    ; 0088EBF4: dc.w $B18C
        dc.w    $B5AD                    ; 0088EBF6: dc.w $B5AD
        dc.w    $B9CE                    ; 0088EBF8: dc.w $B9CE
        dc.w    $BDEF                    ; 0088EBFA: dc.w $BDEF
        dc.w    $C210                    ; 0088EBFC: dc.w $C210
        dc.w    $C631                    ; 0088EBFE: dc.w $C631
        dc.w    $CA52                    ; 0088EC00: dc.w $CA52
        dc.w    $CE73                    ; 0088EC02: dc.w $CE73
        dc.w    $D294                    ; 0088EC04: dc.w $D294
        dc.w    $D6B5                    ; 0088EC06: dc.w $D6B5
        dc.w    $DAD6                    ; 0088EC08: dc.w $DAD6
        dc.w    $DEF7                    ; 0088EC0A: dc.w $DEF7
        dc.w    $E318                    ; 0088EC0C: dc.w $E318
        dc.w    $E739                    ; 0088EC0E: dc.w $E739
        dc.w    $EB5A                    ; 0088EC10: dc.w $EB5A
        dc.w    $EF7B                    ; 0088EC12: dc.w $EF7B
        dc.w    $F39C                    ; 0088EC14: dc.w $F39C
        dc.w    $F7BD                    ; 0088EC16: dc.w $F7BD
        dc.w    $FBDE                    ; 0088EC18: dc.w $FBDE
        dc.w    $FFFF                    ; 0088EC1A: dc.w $FFFF
        dc.w    $9060                    ; 0088EC1C: dc.w $9060
        dc.w    $9481                    ; 0088EC1E: dc.w $9481
        dc.w    $9CC3                    ; 0088EC20: dc.w $9CC3
        dc.w    $A4E4                    ; 0088EC22: dc.w $A4E4
        dc.w    $AD26                    ; 0088EC24: dc.w $AD26
        dc.w    $AC61                    ; 0088EC26: dc.w $AC61
        dc.w    $B082                    ; 0088EC28: dc.w $B082
        dc.w    $B4A3                    ; 0088EC2A: dc.w $B4A3
        dc.w    $B8C4                    ; 0088EC2C: dc.w $B8C4
        dc.w    $BCE5                    ; 0088EC2E: dc.w $BCE5
        dc.w    $C106                    ; 0088EC30: dc.w $C106
        dc.w    $800A                    ; 0088EC32: dc.w $800A
        dc.w    $800C                    ; 0088EC34: dc.w $800C
        dc.w    $800E                    ; 0088EC36: dc.w $800E
        dc.w    $8010                    ; 0088EC38: dc.w $8010
        dc.w    $8431                    ; 0088EC3A: dc.w $8431
        dc.w    $8C72                    ; 0088EC3C: dc.w $8C72
        dc.w    $94B3                    ; 0088EC3E: dc.w $94B3
        dc.w    $9CF4                    ; 0088EC40: dc.w $9CF4
        dc.w    $8000                    ; 0088EC42: dc.w $8000
        dc.w    $8000                    ; 0088EC44: dc.w $8000
        dc.w    $8000                    ; 0088EC46: dc.w $8000
        dc.w    $8000                    ; 0088EC48: dc.w $8000
        dc.w    $8000                    ; 0088EC4A: dc.w $8000
        dc.w    $8000                    ; 0088EC4C: dc.w $8000
        dc.w    $8000                    ; 0088EC4E: dc.w $8000
        dc.w    $8000                    ; 0088EC50: dc.w $8000
        dc.w    $8000                    ; 0088EC52: dc.w $8000
        dc.w    $8000                    ; 0088EC54: dc.w $8000
        dc.w    $8000                    ; 0088EC56: dc.w $8000
        dc.w    $8000                    ; 0088EC58: dc.w $8000
        dc.w    $8000                    ; 0088EC5A: dc.w $8000
        dc.w    $8000                    ; 0088EC5C: dc.w $8000
        dc.w    $8000                    ; 0088EC5E: dc.w $8000
        dc.w    $8000                    ; 0088EC60: dc.w $8000
        dc.w    $8000                    ; 0088EC62: dc.w $8000
        dc.w    $8000                    ; 0088EC64: dc.w $8000
        dc.w    $8C60                    ; 0088EC66: dc.w $8C60
        dc.w    $8840                    ; 0088EC68: dc.w $8840
        dc.w    $8000                    ; 0088EC6A: dc.w $8000
        dc.w    $8840                    ; 0088EC6C: dc.w $8840
        dc.w    $9080                    ; 0088EC6E: dc.w $9080
        dc.w    $98C1                    ; 0088EC70: dc.w $98C1
        dc.w    $A103                    ; 0088EC72: dc.w $A103
        dc.w    $A945                    ; 0088EC74: dc.w $A945
        dc.w    $0000                    ; 0088EC76: dc.w $0000
        dc.w    $0000                    ; 0088EC78: dc.w $0000
        dc.w    $0000                    ; 0088EC7A: dc.w $0000
        dc.w    $0000                    ; 0088EC7C: dc.w $0000
        dc.w    $0000                    ; 0088EC7E: dc.w $0000
        dc.w    $0000                    ; 0088EC80: dc.w $0000
        dc.w    $0000                    ; 0088EC82: dc.w $0000
        dc.w    $0000                    ; 0088EC84: dc.w $0000
        dc.w    $0000                    ; 0088EC86: dc.w $0000
        dc.w    $0000                    ; 0088EC88: dc.w $0000
        dc.w    $0000                    ; 0088EC8A: dc.w $0000
        dc.w    $0000                    ; 0088EC8C: dc.w $0000
        dc.w    $0000                    ; 0088EC8E: dc.w $0000
        dc.w    $0000                    ; 0088EC90: dc.w $0000
        dc.w    $0000                    ; 0088EC92: dc.w $0000
        dc.w    $0000                    ; 0088EC94: dc.w $0000
        dc.w    $0000                    ; 0088EC96: dc.w $0000
        dc.w    $0000                    ; 0088EC98: dc.w $0000
        dc.w    $0000                    ; 0088EC9A: dc.w $0000
        dc.w    $0000                    ; 0088EC9C: dc.w $0000
        dc.w    $0000                    ; 0088EC9E: dc.w $0000
        dc.w    $0000                    ; 0088ECA0: dc.w $0000
        dc.w    $0000                    ; 0088ECA2: dc.w $0000
        dc.w    $0000                    ; 0088ECA4: dc.w $0000
        dc.w    $0000                    ; 0088ECA6: dc.w $0000
        dc.w    $0000                    ; 0088ECA8: dc.w $0000
        dc.w    $0000                    ; 0088ECAA: dc.w $0000
        dc.w    $0000                    ; 0088ECAC: dc.w $0000
        dc.w    $0000                    ; 0088ECAE: dc.w $0000
        dc.w    $0000                    ; 0088ECB0: dc.w $0000
        dc.w    $0000                    ; 0088ECB2: dc.w $0000
        dc.w    $0000                    ; 0088ECB4: dc.w $0000
        dc.w    $0000                    ; 0088ECB6: dc.w $0000
        dc.w    $0000                    ; 0088ECB8: dc.w $0000
        dc.w    $0000                    ; 0088ECBA: dc.w $0000
        dc.w    $0000                    ; 0088ECBC: dc.w $0000
        dc.w    $0000                    ; 0088ECBE: dc.w $0000
        dc.w    $0000                    ; 0088ECC0: dc.w $0000
        dc.w    $0000                    ; 0088ECC2: dc.w $0000
        dc.w    $0000                    ; 0088ECC4: dc.w $0000
        dc.w    $0000                    ; 0088ECC6: dc.w $0000
        dc.w    $0000                    ; 0088ECC8: dc.w $0000
        dc.w    $0000                    ; 0088ECCA: dc.w $0000
        dc.w    $0000                    ; 0088ECCC: dc.w $0000
        dc.w    $0000                    ; 0088ECCE: dc.w $0000
        dc.w    $0000                    ; 0088ECD0: dc.w $0000
        dc.w    $0000                    ; 0088ECD2: dc.w $0000
        dc.w    $0000                    ; 0088ECD4: dc.w $0000
        dc.w    $0000                    ; 0088ECD6: dc.w $0000
        dc.w    $0000                    ; 0088ECD8: dc.w $0000
        dc.w    $0000                    ; 0088ECDA: dc.w $0000
        dc.w    $8000                    ; 0088ECDC: dc.w $8000
        dc.w    $8421                    ; 0088ECDE: dc.w $8421
        dc.w    $8842                    ; 0088ECE0: dc.w $8842
        dc.w    $8C63                    ; 0088ECE2: dc.w $8C63
        dc.w    $9084                    ; 0088ECE4: dc.w $9084
        dc.w    $94A5                    ; 0088ECE6: dc.w $94A5
        dc.w    $98C6                    ; 0088ECE8: dc.w $98C6
        dc.w    $9CE7                    ; 0088ECEA: dc.w $9CE7
        dc.w    $A108                    ; 0088ECEC: dc.w $A108
        dc.w    $A529                    ; 0088ECEE: dc.w $A529
        dc.w    $A94A                    ; 0088ECF0: dc.w $A94A
        dc.w    $AD6B                    ; 0088ECF2: dc.w $AD6B
        dc.w    $B18C                    ; 0088ECF4: dc.w $B18C
        dc.w    $B5AD                    ; 0088ECF6: dc.w $B5AD
        dc.w    $B9CE                    ; 0088ECF8: dc.w $B9CE
        dc.w    $BDEF                    ; 0088ECFA: dc.w $BDEF
        dc.w    $C210                    ; 0088ECFC: dc.w $C210
        dc.w    $C631                    ; 0088ECFE: dc.w $C631
        dc.w    $CA52                    ; 0088ED00: dc.w $CA52
        dc.w    $CE73                    ; 0088ED02: dc.w $CE73
        dc.w    $D294                    ; 0088ED04: dc.w $D294
        dc.w    $D6B5                    ; 0088ED06: dc.w $D6B5
        dc.w    $DAD6                    ; 0088ED08: dc.w $DAD6
        dc.w    $DEF7                    ; 0088ED0A: dc.w $DEF7
        dc.w    $E318                    ; 0088ED0C: dc.w $E318
        dc.w    $E739                    ; 0088ED0E: dc.w $E739
        dc.w    $EB5A                    ; 0088ED10: dc.w $EB5A
        dc.w    $EF7B                    ; 0088ED12: dc.w $EF7B
        dc.w    $F39C                    ; 0088ED14: dc.w $F39C
        dc.w    $F7BD                    ; 0088ED16: dc.w $F7BD
        dc.w    $FBDE                    ; 0088ED18: dc.w $FBDE
        dc.w    $FFFF                    ; 0088ED1A: dc.w $FFFF
        dc.w    $9060                    ; 0088ED1C: dc.w $9060
        dc.w    $9481                    ; 0088ED1E: dc.w $9481
        dc.w    $9CC3                    ; 0088ED20: dc.w $9CC3
        dc.w    $A4E4                    ; 0088ED22: dc.w $A4E4
        dc.w    $AD26                    ; 0088ED24: dc.w $AD26
        dc.w    $8009                    ; 0088ED26: dc.w $8009
        dc.w    $800B                    ; 0088ED28: dc.w $800B
        dc.w    $800D                    ; 0088ED2A: dc.w $800D
        dc.w    $8010                    ; 0088ED2C: dc.w $8010
        dc.w    $8852                    ; 0088ED2E: dc.w $8852
        dc.w    $8C73                    ; 0088ED30: dc.w $8C73
        dc.w    $98D4                    ; 0088ED32: dc.w $98D4
        dc.w    $A535                    ; 0088ED34: dc.w $A535
        dc.w    $BC00                    ; 0088ED36: dc.w $BC00
        dc.w    $C400                    ; 0088ED38: dc.w $C400
        dc.w    $CC40                    ; 0088ED3A: dc.w $CC40
        dc.w    $D482                    ; 0088ED3C: dc.w $D482
        dc.w    $E0E5                    ; 0088ED3E: dc.w $E0E5
        dc.w    $E927                    ; 0088ED40: dc.w $E927
        dc.w    $8000                    ; 0088ED42: dc.w $8000
        dc.w    $8000                    ; 0088ED44: dc.w $8000
        dc.w    $8000                    ; 0088ED46: dc.w $8000
        dc.w    $8000                    ; 0088ED48: dc.w $8000
        dc.w    $8000                    ; 0088ED4A: dc.w $8000
        dc.w    $8000                    ; 0088ED4C: dc.w $8000
        dc.w    $8000                    ; 0088ED4E: dc.w $8000
        dc.w    $8000                    ; 0088ED50: dc.w $8000
        dc.w    $8000                    ; 0088ED52: dc.w $8000
        dc.w    $8000                    ; 0088ED54: dc.w $8000
        dc.w    $8000                    ; 0088ED56: dc.w $8000
        dc.w    $8000                    ; 0088ED58: dc.w $8000
        dc.w    $8000                    ; 0088ED5A: dc.w $8000
        dc.w    $8000                    ; 0088ED5C: dc.w $8000
        dc.w    $8000                    ; 0088ED5E: dc.w $8000
        dc.w    $8000                    ; 0088ED60: dc.w $8000
        dc.w    $8000                    ; 0088ED62: dc.w $8000
        dc.w    $8000                    ; 0088ED64: dc.w $8000
        dc.w    $8C60                    ; 0088ED66: dc.w $8C60
        dc.w    $8840                    ; 0088ED68: dc.w $8840
        dc.w    $8000                    ; 0088ED6A: dc.w $8000
        dc.w    $8840                    ; 0088ED6C: dc.w $8840
        dc.w    $9080                    ; 0088ED6E: dc.w $9080
        dc.w    $98C1                    ; 0088ED70: dc.w $98C1
        dc.w    $A103                    ; 0088ED72: dc.w $A103
        dc.w    $A945                    ; 0088ED74: dc.w $A945
        dc.w    $0000                    ; 0088ED76: dc.w $0000
        dc.w    $0000                    ; 0088ED78: dc.w $0000
        dc.w    $0000                    ; 0088ED7A: dc.w $0000
        dc.w    $0000                    ; 0088ED7C: dc.w $0000
        dc.w    $0000                    ; 0088ED7E: dc.w $0000
        dc.w    $0000                    ; 0088ED80: dc.w $0000
        dc.w    $0000                    ; 0088ED82: dc.w $0000
        dc.w    $0000                    ; 0088ED84: dc.w $0000
        dc.w    $0000                    ; 0088ED86: dc.w $0000
        dc.w    $0000                    ; 0088ED88: dc.w $0000
        dc.w    $0000                    ; 0088ED8A: dc.w $0000
        dc.w    $0000                    ; 0088ED8C: dc.w $0000
        dc.w    $0000                    ; 0088ED8E: dc.w $0000
        dc.w    $0000                    ; 0088ED90: dc.w $0000
        dc.w    $0000                    ; 0088ED92: dc.w $0000
        dc.w    $0000                    ; 0088ED94: dc.w $0000
        dc.w    $0000                    ; 0088ED96: dc.w $0000
        dc.w    $0000                    ; 0088ED98: dc.w $0000
        dc.w    $0000                    ; 0088ED9A: dc.w $0000
        dc.w    $0000                    ; 0088ED9C: dc.w $0000
        dc.w    $0000                    ; 0088ED9E: dc.w $0000
        dc.w    $0000                    ; 0088EDA0: dc.w $0000
        dc.w    $0000                    ; 0088EDA2: dc.w $0000
        dc.w    $0000                    ; 0088EDA4: dc.w $0000
        dc.w    $0000                    ; 0088EDA6: dc.w $0000
        dc.w    $0000                    ; 0088EDA8: dc.w $0000
        dc.w    $0000                    ; 0088EDAA: dc.w $0000
        dc.w    $0000                    ; 0088EDAC: dc.w $0000
        dc.w    $0000                    ; 0088EDAE: dc.w $0000
        dc.w    $0000                    ; 0088EDB0: dc.w $0000
        dc.w    $0000                    ; 0088EDB2: dc.w $0000
        dc.w    $0000                    ; 0088EDB4: dc.w $0000
        dc.w    $0000                    ; 0088EDB6: dc.w $0000
        dc.w    $0000                    ; 0088EDB8: dc.w $0000
        dc.w    $0000                    ; 0088EDBA: dc.w $0000
        dc.w    $0000                    ; 0088EDBC: dc.w $0000
        dc.w    $0000                    ; 0088EDBE: dc.w $0000
        dc.w    $0000                    ; 0088EDC0: dc.w $0000
        dc.w    $0000                    ; 0088EDC2: dc.w $0000
        dc.w    $0000                    ; 0088EDC4: dc.w $0000
        dc.w    $0000                    ; 0088EDC6: dc.w $0000
        dc.w    $0000                    ; 0088EDC8: dc.w $0000
        dc.w    $0000                    ; 0088EDCA: dc.w $0000
        dc.w    $0000                    ; 0088EDCC: dc.w $0000
        dc.w    $0000                    ; 0088EDCE: dc.w $0000
        dc.w    $0000                    ; 0088EDD0: dc.w $0000
        dc.w    $0000                    ; 0088EDD2: dc.w $0000
        dc.w    $0000                    ; 0088EDD4: dc.w $0000
        dc.w    $0000                    ; 0088EDD6: dc.w $0000
        dc.w    $0000                    ; 0088EDD8: dc.w $0000
        dc.w    $207C, $0603, $D100    ; 0088EDDA: MOVEA.L #$0603D100,A0
        dc.w    $227C, $0400, $4C68    ; 0088EDE0: MOVEA.L #$04004C68,A1
        dc.w    $303C                    ; 0088EDE6: dc.w $303C
        dc.w    $0070                    ; 0088EDE8: dc.w $0070
        dc.w    $323C                    ; 0088EDEA: dc.w $323C
        dc.w    $0010                    ; 0088EDEC: dc.w $0010
        dc.w    $4EBA                    ; 0088EDEE: dc.w $4EBA
        dc.w    $F56A                    ; 0088EDF0: dc.w $F56A
        dc.w    $4A39                    ; 0088EDF2: dc.w $4A39
        dc.w    $00A1                    ; 0088EDF4: dc.w $00A1
        dc.w    $5120                    ; 0088EDF6: dc.w $5120
        dc.w    $66F8                    ; 0088EDF8: BNE.S $0088EDF2
        dc.w    $6100, $0136            ; 0088EDFA: BSR.W $0088EF32
        dc.w    $207C, $0603, $D800    ; 0088EDFE: MOVEA.L #$0603D800,A0
        dc.w    $227C, $0401, $985C    ; 0088EE04: MOVEA.L #$0401985C,A1
        dc.w    $303C                    ; 0088EE0A: dc.w $303C
        dc.w    $0088                    ; 0088EE0C: dc.w $0088
        dc.w    $323C                    ; 0088EE0E: dc.w $323C
        dc.w    $0010                    ; 0088EE10: dc.w $0010
        dc.w    $4EBA                    ; 0088EE12: dc.w $4EBA
        dc.w    $F546                    ; 0088EE14: dc.w $F546
        dc.w    $4240                    ; 0088EE16: dc.w $4240
        dc.w    $1038                    ; 0088EE18: dc.w $1038
        dc.w    $A01A                    ; 0088EE1A: dc.w $A01A
        dc.w    $6100, $F70E            ; 0088EE1C: BSR.W $0088E52C
        dc.w    $4EBA                    ; 0088EE20: dc.w $4EBA
        dc.w    $C862                    ; 0088EE22: dc.w $C862
        dc.w    $4EBA                    ; 0088EE24: dc.w $4EBA
        dc.w    $C8B4                    ; 0088EE26: dc.w $C8B4
        dc.w    $0C78                    ; 0088EE28: dc.w $0C78
        dc.w    $0001                    ; 0088EE2A: dc.w $0001
        dc.w    $A020                    ; 0088EE2C: dc.w $A020
        dc.w    $6700, $008A            ; 0088EE2E: BEQ.W $0088EEBA
        dc.w    $0C78                    ; 0088EE32: dc.w $0C78
        dc.w    $0002                    ; 0088EE34: dc.w $0002
        dc.w    $A020                    ; 0088EE36: dc.w $A020
        dc.w    $6700, $0090            ; 0088EE38: BEQ.W $0088EECA
        dc.w    $3238                    ; 0088EE3C: dc.w $3238
        dc.w    $C86C                    ; 0088EE3E: dc.w $C86C
        dc.w    $0201                    ; 0088EE40: dc.w $0201
        dc.w    $00E0                    ; 0088EE42: dc.w $00E0
        dc.w    $6616                    ; 0088EE44: BNE.S $0088EE5C
        dc.w    $3238                    ; 0088EE46: dc.w $3238
        dc.w    $C86C                    ; 0088EE48: dc.w $C86C
        dc.w    $0201                    ; 0088EE4A: dc.w $0201
        dc.w    $0010                    ; 0088EE4C: dc.w $0010
        dc.w    $6608                    ; 0088EE4E: BNE.S $0088EE58
        dc.w    $5978                    ; 0088EE50: dc.w $5978
        dc.w    $C87E                    ; 0088EE52: dc.w $C87E
        dc.w    $6000, $008C            ; 0088EE54: BRA.W $0088EEE2
        dc.w    $50F8                    ; 0088EE58: dc.w $50F8
        dc.w    $A018                    ; 0088EE5A: dc.w $A018
        dc.w    $11FC                    ; 0088EE5C: dc.w $11FC
        dc.w    $00A8                    ; 0088EE5E: dc.w $00A8
        dc.w    $C8A4                    ; 0088EE60: dc.w $C8A4
        dc.w    $4A38                    ; 0088EE62: dc.w $4A38
        dc.w    $A01A                    ; 0088EE64: dc.w $A01A
        dc.w    $660A                    ; 0088EE66: BNE.S $0088EE72
        dc.w    $11F8                    ; 0088EE68: dc.w $11F8
        dc.w    $A019                    ; 0088EE6A: dc.w $A019
        dc.w    $A01E                    ; 0088EE6C: dc.w $A01E
        dc.w    $6000, $0008            ; 0088EE6E: BRA.W $0088EE78
        dc.w    $11F8                    ; 0088EE72: dc.w $11F8
        dc.w    $A019                    ; 0088EE74: dc.w $A019
        dc.w    $A01D                    ; 0088EE76: dc.w $A01D
        dc.w    $4A38                    ; 0088EE78: dc.w $4A38
        dc.w    $A01F                    ; 0088EE7A: dc.w $A01F
        dc.w    $660E                    ; 0088EE7C: BNE.S $0088EE8C
        dc.w    $11F8                    ; 0088EE7E: dc.w $11F8
        dc.w    $A01E                    ; 0088EE80: dc.w $A01E
        dc.w    $FEB1                    ; 0088EE82: dc.w $FEB1
        dc.w    $11F8                    ; 0088EE84: dc.w $11F8
        dc.w    $A01D                    ; 0088EE86: dc.w $A01D
        dc.w    $FEA9                    ; 0088EE88: dc.w $FEA9
        dc.w    $600C                    ; 0088EE8A: BRA.S $0088EE98
        dc.w    $11F8                    ; 0088EE8C: dc.w $11F8
        dc.w    $A01E                    ; 0088EE8E: dc.w $A01E
        dc.w    $FEB2                    ; 0088EE90: dc.w $FEB2
        dc.w    $11F8                    ; 0088EE92: dc.w $11F8
        dc.w    $A01D                    ; 0088EE94: dc.w $A01D
        dc.w    $FEAA                    ; 0088EE96: dc.w $FEAA
        dc.w    $11FC                    ; 0088EE98: dc.w $11FC
        dc.w    $0001                    ; 0088EE9A: dc.w $0001
        dc.w    $C809                    ; 0088EE9C: dc.w $C809
        dc.w    $11FC                    ; 0088EE9E: dc.w $11FC
        dc.w    $0001                    ; 0088EEA0: dc.w $0001
        dc.w    $C80A                    ; 0088EEA2: dc.w $C80A
        dc.w    $08F8                    ; 0088EEA4: dc.w $08F8
        dc.w    $0007                    ; 0088EEA6: dc.w $0007
        dc.w    $C80E                    ; 0088EEA8: dc.w $C80E
        dc.w    $11FC                    ; 0088EEAA: dc.w $11FC
        dc.w    $0001                    ; 0088EEAC: dc.w $0001
        dc.w    $C802                    ; 0088EEAE: dc.w $C802
        dc.w    $31FC                    ; 0088EEB0: dc.w $31FC
        dc.w    $0002                    ; 0088EEB2: dc.w $0002
        dc.w    $A020                    ; 0088EEB4: dc.w $A020
        dc.w    $6000, $0026            ; 0088EEB6: BRA.W $0088EEDE
        dc.w    $0838                    ; 0088EEBA: dc.w $0838
        dc.w    $0006                    ; 0088EEBC: dc.w $0006
        dc.w    $C80E                    ; 0088EEBE: dc.w $C80E
        dc.w    $661C                    ; 0088EEC0: BNE.S $0088EEDE
        dc.w    $4278                    ; 0088EEC2: dc.w $4278
        dc.w    $A020                    ; 0088EEC4: dc.w $A020
        dc.w    $6000, $0016            ; 0088EEC6: BRA.W $0088EEDE
        dc.w    $0838                    ; 0088EECA: dc.w $0838
        dc.w    $0007                    ; 0088EECC: dc.w $0007
        dc.w    $C80E                    ; 0088EECE: dc.w $C80E
        dc.w    $660C                    ; 0088EED0: BNE.S $0088EEDE
        dc.w    $4278                    ; 0088EED2: dc.w $4278
        dc.w    $A020                    ; 0088EED4: dc.w $A020
        dc.w    $5878                    ; 0088EED6: dc.w $5878
        dc.w    $C87E                    ; 0088EED8: dc.w $C87E
        dc.w    $6000, $0006            ; 0088EEDA: BRA.W $0088EEE2
        dc.w    $5978                    ; 0088EEDE: dc.w $5978
        dc.w    $C87E                    ; 0088EEE0: dc.w $C87E
        dc.w    $33FC                    ; 0088EEE2: dc.w $33FC
        dc.w    $0018                    ; 0088EEE4: dc.w $0018
        dc.w    $00FF                    ; 0088EEE6: dc.w $00FF
        dc.w    $0008                    ; 0088EEE8: dc.w $0008
        dc.w    $11FC                    ; 0088EEEA: dc.w $11FC
        dc.w    $0001                    ; 0088EEEC: dc.w $0001
        dc.w    $C821                    ; 0088EEEE: dc.w $C821
        dc.w    $4E75                    ; 0088EEF0: RTS
        dc.w    $4A39                    ; 0088EEF2: dc.w $4A39
        dc.w    $00A1                    ; 0088EEF4: dc.w $00A1
        dc.w    $5120                    ; 0088EEF6: dc.w $5120
        dc.w    $66F8                    ; 0088EEF8: BNE.S $0088EEF2
        dc.w    $4239                    ; 0088EEFA: dc.w $4239
        dc.w    $00A1                    ; 0088EEFC: dc.w $00A1
        dc.w    $5123                    ; 0088EEFE: dc.w $5123
        dc.w    $31FC                    ; 0088EF00: dc.w $31FC
        dc.w    $0000                    ; 0088EF02: dc.w $0000
        dc.w    $C87E                    ; 0088EF04: dc.w $C87E
        dc.w    $23FC, $0089, $26D2, $00FF, $0002  ; 0088EF06: MOVE.L #$008926D2,$00FF0002
        dc.w    $4A38                    ; 0088EF10: dc.w $4A38
        dc.w    $A018                    ; 0088EF12: dc.w $A018
        dc.w    $661A                    ; 0088EF14: BNE.S $0088EF30
        dc.w    $23FC, $0088, $D4A4, $00FF, $0002  ; 0088EF16: MOVE.L #$0088D4A4,$00FF0002
        dc.w    $4A38                    ; 0088EF20: dc.w $4A38
        dc.w    $A01F                    ; 0088EF22: dc.w $A01F
        dc.w    $660A                    ; 0088EF24: BNE.S $0088EF30
        dc.w    $23FC, $0088, $D48A, $00FF, $0002  ; 0088EF26: MOVE.L #$0088D48A,$00FF0002
        dc.w    $4E75                    ; 0088EF30: RTS
        dc.w    $7000                    ; 0088EF32: MOVEQ #$00,D0
        dc.w    $4A38                    ; 0088EF34: dc.w $4A38
        dc.w    $A01A                    ; 0088EF36: dc.w $A01A
        dc.w    $6606                    ; 0088EF38: BNE.S $0088EF40
        dc.w    $1038                    ; 0088EF3A: dc.w $1038
        dc.w    $A019                    ; 0088EF3C: dc.w $A019
        dc.w    $6004                    ; 0088EF3E: BRA.S $0088EF44
        dc.w    $1038                    ; 0088EF40: dc.w $1038
        dc.w    $A01E                    ; 0088EF42: dc.w $A01E
        dc.w    $43F9, $0088, $EFA4    ; 0088EF44: LEA $0088EFA4,A1
        dc.w    $D040                    ; 0088EF4A: dc.w $D040
        dc.w    $3200                    ; 0088EF4C: dc.w $3200
        dc.w    $D040                    ; 0088EF4E: dc.w $D040
        dc.w    $D041                    ; 0088EF50: dc.w $D041
        dc.w    $2071                    ; 0088EF52: dc.w $2071
        dc.w    $0000                    ; 0088EF54: dc.w $0000
        dc.w    $3031                    ; 0088EF56: dc.w $3031
        dc.w    $0004                    ; 0088EF58: dc.w $0004
        dc.w    $323C                    ; 0088EF5A: dc.w $323C
        dc.w    $0030                    ; 0088EF5C: dc.w $0030
        dc.w    $343C                    ; 0088EF5E: dc.w $343C
        dc.w    $0010                    ; 0088EF60: dc.w $0010
        dc.w    $4EBA                    ; 0088EF62: dc.w $4EBA
        dc.w    $F450                    ; 0088EF64: dc.w $F450
        dc.w    $7000                    ; 0088EF66: MOVEQ #$00,D0
        dc.w    $4A38                    ; 0088EF68: dc.w $4A38
        dc.w    $A01A                    ; 0088EF6A: dc.w $A01A
        dc.w    $6706                    ; 0088EF6C: BEQ.S $0088EF74
        dc.w    $1038                    ; 0088EF6E: dc.w $1038
        dc.w    $A019                    ; 0088EF70: dc.w $A019
        dc.w    $6004                    ; 0088EF72: BRA.S $0088EF78
        dc.w    $1038                    ; 0088EF74: dc.w $1038
        dc.w    $A01D                    ; 0088EF76: dc.w $A01D
        dc.w    $43F9, $0088, $EFB6    ; 0088EF78: LEA $0088EFB6,A1
        dc.w    $D040                    ; 0088EF7E: dc.w $D040
        dc.w    $3200                    ; 0088EF80: dc.w $3200
        dc.w    $D040                    ; 0088EF82: dc.w $D040
        dc.w    $D041                    ; 0088EF84: dc.w $D041
        dc.w    $2071                    ; 0088EF86: dc.w $2071
        dc.w    $0000                    ; 0088EF88: dc.w $0000
        dc.w    $3031                    ; 0088EF8A: dc.w $3031
        dc.w    $0004                    ; 0088EF8C: dc.w $0004
        dc.w    $323C                    ; 0088EF8E: dc.w $323C
        dc.w    $0018                    ; 0088EF90: dc.w $0018
        dc.w    $343C                    ; 0088EF92: dc.w $343C
        dc.w    $0010                    ; 0088EF94: dc.w $0010
        dc.w    $4A39                    ; 0088EF96: dc.w $4A39
        dc.w    $00A1                    ; 0088EF98: dc.w $00A1
        dc.w    $5120                    ; 0088EF9A: dc.w $5120
        dc.w    $66F8                    ; 0088EF9C: BNE.S $0088EF96
        dc.w    $4EBA                    ; 0088EF9E: dc.w $4EBA
        dc.w    $F414                    ; 0088EFA0: dc.w $F414
        dc.w    $4E75                    ; 0088EFA2: RTS
        dc.w    $0401                    ; 0088EFA4: dc.w $0401
        dc.w    $2010                    ; 0088EFA6: dc.w $2010
        dc.w    $0060                    ; 0088EFA8: dc.w $0060
        dc.w    $0401                    ; 0088EFAA: dc.w $0401
        dc.w    $206F                    ; 0088EFAC: dc.w $206F
        dc.w    $0061                    ; 0088EFAE: dc.w $0061
        dc.w    $0401                    ; 0088EFB0: dc.w $0401
        dc.w    $20CF                    ; 0088EFB2: dc.w $20CF
        dc.w    $0061                    ; 0088EFB4: dc.w $0061
        dc.w    $0401                    ; 0088EFB6: dc.w $0401
        dc.w    $B010                    ; 0088EFB8: dc.w $B010
        dc.w    $0091                    ; 0088EFBA: dc.w $0091
        dc.w    $0401                    ; 0088EFBC: dc.w $0401
        dc.w    $B0A0                    ; 0088EFBE: dc.w $B0A0
        dc.w    $0090                    ; 0088EFC0: dc.w $0090
        dc.w    $43F9, $00FF, $6100    ; 0088EFC2: LEA $00FF6100,A1
        dc.w    $337C                    ; 0088EFC8: dc.w $337C
        dc.w    $0001                    ; 0088EFCA: dc.w $0001
        dc.w    $0000                    ; 0088EFCC: dc.w $0000
        dc.w    $337C                    ; 0088EFCE: dc.w $337C
        dc.w    $0000                    ; 0088EFD0: dc.w $0000
        dc.w    $0002                    ; 0088EFD2: dc.w $0002
        dc.w    $3379                    ; 0088EFD4: dc.w $3379
        dc.w    $00FF                    ; 0088EFD6: dc.w $00FF
        dc.w    $2002                    ; 0088EFD8: dc.w $2002
        dc.w    $0004                    ; 0088EFDA: dc.w $0004
        dc.w    $3379                    ; 0088EFDC: dc.w $3379
        dc.w    $00FF                    ; 0088EFDE: dc.w $00FF
        dc.w    $2004                    ; 0088EFE0: dc.w $2004
        dc.w    $0006                    ; 0088EFE2: dc.w $0006
        dc.w    $3379                    ; 0088EFE4: dc.w $3379
        dc.w    $00FF                    ; 0088EFE6: dc.w $00FF
        dc.w    $2000                    ; 0088EFE8: dc.w $2000
        dc.w    $0008                    ; 0088EFEA: dc.w $0008
        dc.w    $3340                    ; 0088EFEC: dc.w $3340
        dc.w    $000A                    ; 0088EFEE: dc.w $000A
        dc.w    $337C                    ; 0088EFF0: dc.w $337C
        dc.w    $0000                    ; 0088EFF2: dc.w $0000
        dc.w    $000C                    ; 0088EFF4: dc.w $000C
        dc.w    $337C                    ; 0088EFF6: dc.w $337C
        dc.w    $0000                    ; 0088EFF8: dc.w $0000
        dc.w    $000E                    ; 0088EFFA: dc.w $000E
        dc.w    $237C                    ; 0088EFFC: dc.w $237C
        dc.w    $222B                    ; 0088EFFE: dc.w $222B
        dc.w    $DAE6                    ; 0088F000: dc.w $DAE6
        dc.w    $0010                    ; 0088F002: dc.w $0010
        dc.w    $D3FC                    ; 0088F004: dc.w $D3FC
        dc.w    $0000                    ; 0088F006: dc.w $0000
        dc.w    $0014                    ; 0088F008: dc.w $0014
        dc.w    $33FC                    ; 0088F00A: dc.w $33FC
        dc.w    $0044                    ; 0088F00C: dc.w $0044
        dc.w    $00A1                    ; 0088F00E: dc.w $00A1
        dc.w    $5110                    ; 0088F010: dc.w $5110
        dc.w    $13FC                    ; 0088F012: dc.w $13FC
        dc.w    $0004                    ; 0088F014: dc.w $0004
        dc.w    $00A1                    ; 0088F016: dc.w $00A1
        dc.w    $5107                    ; 0088F018: dc.w $5107
        dc.w    $4A39                    ; 0088F01A: dc.w $4A39
        dc.w    $00A1                    ; 0088F01C: dc.w $00A1
        dc.w    $5120                    ; 0088F01E: dc.w $5120
        dc.w    $66F8                    ; 0088F020: BNE.S $0088F01A
        dc.w    $13FC                    ; 0088F022: dc.w $13FC
        dc.w    $002A                    ; 0088F024: dc.w $002A
        dc.w    $00A1                    ; 0088F026: dc.w $00A1
        dc.w    $5121                    ; 0088F028: dc.w $5121
        dc.w    $13FC                    ; 0088F02A: dc.w $13FC
        dc.w    $0001                    ; 0088F02C: dc.w $0001
        dc.w    $00A1                    ; 0088F02E: dc.w $00A1
        dc.w    $5120                    ; 0088F030: dc.w $5120
        dc.w    $4E75                    ; 0088F032: RTS
        dc.w    $2228                    ; 0088F034: dc.w $2228
        dc.w    $1450                    ; 0088F036: dc.w $1450
        dc.w    $2228                    ; 0088F038: dc.w $2228
        dc.w    $155A                    ; 0088F03A: dc.w $155A
        dc.w    $2228                    ; 0088F03C: dc.w $2228
        dc.w    $1664                    ; 0088F03E: dc.w $1664
        dc.w    $43F9, $00FF, $6100    ; 0088F040: LEA $00FF6100,A1
        dc.w    $337C                    ; 0088F046: dc.w $337C
        dc.w    $0001                    ; 0088F048: dc.w $0001
        dc.w    $0000                    ; 0088F04A: dc.w $0000
        dc.w    $337C                    ; 0088F04C: dc.w $337C
        dc.w    $0000                    ; 0088F04E: dc.w $0000
        dc.w    $0002                    ; 0088F050: dc.w $0002
        dc.w    $3379                    ; 0088F052: dc.w $3379
        dc.w    $00FF                    ; 0088F054: dc.w $00FF
        dc.w    $2008                    ; 0088F056: dc.w $2008
        dc.w    $0004                    ; 0088F058: dc.w $0004
        dc.w    $3379                    ; 0088F05A: dc.w $3379
        dc.w    $00FF                    ; 0088F05C: dc.w $00FF
        dc.w    $200A                    ; 0088F05E: dc.w $200A
        dc.w    $0006                    ; 0088F060: dc.w $0006
        dc.w    $3379                    ; 0088F062: dc.w $3379
        dc.w    $00FF                    ; 0088F064: dc.w $00FF
        dc.w    $2006                    ; 0088F066: dc.w $2006
        dc.w    $0008                    ; 0088F068: dc.w $0008
        dc.w    $3340                    ; 0088F06A: dc.w $3340
        dc.w    $000A                    ; 0088F06C: dc.w $000A
        dc.w    $337C                    ; 0088F06E: dc.w $337C
        dc.w    $0000                    ; 0088F070: dc.w $0000
        dc.w    $000C                    ; 0088F072: dc.w $000C
        dc.w    $337C                    ; 0088F074: dc.w $337C
        dc.w    $0000                    ; 0088F076: dc.w $0000
        dc.w    $000E                    ; 0088F078: dc.w $000E
        dc.w    $237C                    ; 0088F07A: dc.w $237C
        dc.w    $222B                    ; 0088F07C: dc.w $222B
        dc.w    $EA76                    ; 0088F07E: dc.w $EA76
        dc.w    $0010                    ; 0088F080: dc.w $0010
        dc.w    $D3FC                    ; 0088F082: dc.w $D3FC
        dc.w    $0000                    ; 0088F084: dc.w $0000
        dc.w    $0014                    ; 0088F086: dc.w $0014
        dc.w    $33FC                    ; 0088F088: dc.w $33FC
        dc.w    $0044                    ; 0088F08A: dc.w $0044
        dc.w    $00A1                    ; 0088F08C: dc.w $00A1
        dc.w    $5110                    ; 0088F08E: dc.w $5110
        dc.w    $13FC                    ; 0088F090: dc.w $13FC
        dc.w    $0004                    ; 0088F092: dc.w $0004
        dc.w    $00A1                    ; 0088F094: dc.w $00A1
        dc.w    $5107                    ; 0088F096: dc.w $5107
        dc.w    $4A39                    ; 0088F098: dc.w $4A39
        dc.w    $00A1                    ; 0088F09A: dc.w $00A1
        dc.w    $5120                    ; 0088F09C: dc.w $5120
        dc.w    $66F8                    ; 0088F09E: BNE.S $0088F098
        dc.w    $13FC                    ; 0088F0A0: dc.w $13FC
        dc.w    $002A                    ; 0088F0A2: dc.w $002A
        dc.w    $00A1                    ; 0088F0A4: dc.w $00A1
        dc.w    $5121                    ; 0088F0A6: dc.w $5121
        dc.w    $13FC                    ; 0088F0A8: dc.w $13FC
        dc.w    $0001                    ; 0088F0AA: dc.w $0001
        dc.w    $00A1                    ; 0088F0AC: dc.w $00A1
        dc.w    $5120                    ; 0088F0AE: dc.w $5120
        dc.w    $4E75                    ; 0088F0B0: RTS
        dc.w    $2228                    ; 0088F0B2: dc.w $2228
        dc.w    $4FAA                    ; 0088F0B4: dc.w $4FAA
        dc.w    $2228                    ; 0088F0B6: dc.w $2228
        dc.w    $506C                    ; 0088F0B8: dc.w $506C
        dc.w    $2228                    ; 0088F0BA: dc.w $2228
        dc.w    $512E                    ; 0088F0BC: dc.w $512E
        dc.w    $43F9, $00FF, $6100    ; 0088F0BE: LEA $00FF6100,A1
        dc.w    $337C                    ; 0088F0C4: dc.w $337C
        dc.w    $0001                    ; 0088F0C6: dc.w $0001
        dc.w    $0000                    ; 0088F0C8: dc.w $0000
        dc.w    $337C                    ; 0088F0CA: dc.w $337C
        dc.w    $0000                    ; 0088F0CC: dc.w $0000
        dc.w    $0002                    ; 0088F0CE: dc.w $0002
        dc.w    $3379                    ; 0088F0D0: dc.w $3379
        dc.w    $00FF                    ; 0088F0D2: dc.w $00FF
        dc.w    $200E                    ; 0088F0D4: dc.w $200E
        dc.w    $0004                    ; 0088F0D6: dc.w $0004
        dc.w    $3379                    ; 0088F0D8: dc.w $3379
        dc.w    $00FF                    ; 0088F0DA: dc.w $00FF
        dc.w    $2010                    ; 0088F0DC: dc.w $2010
        dc.w    $0006                    ; 0088F0DE: dc.w $0006
        dc.w    $3379                    ; 0088F0E0: dc.w $3379
        dc.w    $00FF                    ; 0088F0E2: dc.w $00FF
        dc.w    $200C                    ; 0088F0E4: dc.w $200C
        dc.w    $0008                    ; 0088F0E6: dc.w $0008
        dc.w    $3340                    ; 0088F0E8: dc.w $3340
        dc.w    $000A                    ; 0088F0EA: dc.w $000A
        dc.w    $337C                    ; 0088F0EC: dc.w $337C
        dc.w    $0000                    ; 0088F0EE: dc.w $0000
        dc.w    $000C                    ; 0088F0F0: dc.w $000C
        dc.w    $337C                    ; 0088F0F2: dc.w $337C
        dc.w    $0000                    ; 0088F0F4: dc.w $0000
        dc.w    $000E                    ; 0088F0F6: dc.w $000E
        dc.w    $237C                    ; 0088F0F8: dc.w $237C
        dc.w    $222B                    ; 0088F0FA: dc.w $222B
        dc.w    $F710                    ; 0088F0FC: dc.w $F710
        dc.w    $0010                    ; 0088F0FE: dc.w $0010
        dc.w    $D3FC                    ; 0088F100: dc.w $D3FC
        dc.w    $0000                    ; 0088F102: dc.w $0000
        dc.w    $0014                    ; 0088F104: dc.w $0014
        dc.w    $33FC                    ; 0088F106: dc.w $33FC
        dc.w    $0044                    ; 0088F108: dc.w $0044
        dc.w    $00A1                    ; 0088F10A: dc.w $00A1
        dc.w    $5110                    ; 0088F10C: dc.w $5110
        dc.w    $13FC                    ; 0088F10E: dc.w $13FC
        dc.w    $0004                    ; 0088F110: dc.w $0004
        dc.w    $00A1                    ; 0088F112: dc.w $00A1
        dc.w    $5107                    ; 0088F114: dc.w $5107
        dc.w    $4A39                    ; 0088F116: dc.w $4A39
        dc.w    $00A1                    ; 0088F118: dc.w $00A1
        dc.w    $5120                    ; 0088F11A: dc.w $5120
        dc.w    $66F8                    ; 0088F11C: BNE.S $0088F116
        dc.w    $13FC                    ; 0088F11E: dc.w $13FC
        dc.w    $002A                    ; 0088F120: dc.w $002A
        dc.w    $00A1                    ; 0088F122: dc.w $00A1
        dc.w    $5121                    ; 0088F124: dc.w $5121
        dc.w    $13FC                    ; 0088F126: dc.w $13FC
        dc.w    $0001                    ; 0088F128: dc.w $0001
        dc.w    $00A1                    ; 0088F12A: dc.w $00A1
        dc.w    $5120                    ; 0088F12C: dc.w $5120
        dc.w    $4E75                    ; 0088F12E: RTS
        dc.w    $2228                    ; 0088F130: dc.w $2228
        dc.w    $819A                    ; 0088F132: dc.w $819A
        dc.w    $2228                    ; 0088F134: dc.w $2228
        dc.w    $825C                    ; 0088F136: dc.w $825C
        dc.w    $2228                    ; 0088F138: dc.w $2228
        dc.w    $831E                    ; 0088F13A: dc.w $831E
        dc.w    $08B8                    ; 0088F13C: dc.w $08B8
        dc.w    $0007                    ; 0088F13E: dc.w $0007
        dc.w    $FDA8                    ; 0088F140: dc.w $FDA8
        dc.w    $33FC                    ; 0088F142: dc.w $33FC
        dc.w    $002C                    ; 0088F144: dc.w $002C
        dc.w    $00FF                    ; 0088F146: dc.w $00FF
        dc.w    $0008                    ; 0088F148: dc.w $0008
        dc.w    $31FC                    ; 0088F14A: dc.w $31FC
        dc.w    $002C                    ; 0088F14C: dc.w $002C
        dc.w    $C87A                    ; 0088F14E: dc.w $C87A
        dc.w    $08B8                    ; 0088F150: dc.w $08B8
        dc.w    $0006                    ; 0088F152: dc.w $0006
        dc.w    $C875                    ; 0088F154: dc.w $C875
        dc.w    $3AB8                    ; 0088F156: dc.w $3AB8
        dc.w    $C874                    ; 0088F158: dc.w $C874
        dc.w    $33FC                    ; 0088F15A: dc.w $33FC
        dc.w    $0083                    ; 0088F15C: dc.w $0083
        dc.w    $00A1                    ; 0088F15E: dc.w $00A1
        dc.w    $5100                    ; 0088F160: dc.w $5100
        dc.w    $0239                    ; 0088F162: dc.w $0239
        dc.w    $00FC                    ; 0088F164: dc.w $00FC
        dc.w    $00A1                    ; 0088F166: dc.w $00A1
        dc.w    $5181                    ; 0088F168: dc.w $5181
        dc.w    $4EB9, $0088, $26C8    ; 0088F16A: JSR $008826C8
        dc.w    $203C                    ; 0088F170: dc.w $203C
        dc.w    $000A                    ; 0088F172: dc.w $000A
        dc.w    $0907                    ; 0088F174: dc.w $0907
        dc.w    $4EB9, $0088, $14BE    ; 0088F176: JSR $008814BE
        dc.w    $11FC                    ; 0088F17C: dc.w $11FC
        dc.w    $0001                    ; 0088F17E: dc.w $0001
        dc.w    $C80D                    ; 0088F180: dc.w $C80D
        dc.w    $7000                    ; 0088F182: MOVEQ #$00,D0
        dc.w    $41F8                    ; 0088F184: dc.w $41F8
        dc.w    $8480                    ; 0088F186: dc.w $8480
        dc.w    $721F                    ; 0088F188: MOVEQ #$1F,D1
        dc.w    $20C0                    ; 0088F18A: dc.w $20C0
        dc.w    $51C9, $FFFC            ; 0088F18C: DBRA D1,$0088F18A
        dc.w    $41F9, $00FF, $7B80    ; 0088F190: LEA $00FF7B80,A0
        dc.w    $727F                    ; 0088F196: MOVEQ #$7F,D1
        dc.w    $20C0                    ; 0088F198: dc.w $20C0
        dc.w    $51C9, $FFFC            ; 0088F19A: DBRA D1,$0088F198
        dc.w    $2ABC                    ; 0088F19E: dc.w $2ABC
        dc.w    $6000, $0002            ; 0088F1A0: BRA.W $0088F1A4
        dc.w    $323C                    ; 0088F1A4: dc.w $323C
        dc.w    $17FF                    ; 0088F1A6: dc.w $17FF
        dc.w    $2C80                    ; 0088F1A8: dc.w $2C80
        dc.w    $51C9, $FFFC            ; 0088F1AA: DBRA D1,$0088F1A8
        dc.w    $4EB9, $0088, $49AA    ; 0088F1AE: JSR $008849AA
        dc.w    $4278                    ; 0088F1B4: dc.w $4278
        dc.w    $C880                    ; 0088F1B6: dc.w $C880
        dc.w    $4278                    ; 0088F1B8: dc.w $4278
        dc.w    $C882                    ; 0088F1BA: dc.w $C882
        dc.w    $4278                    ; 0088F1BC: dc.w $4278
        dc.w    $8000                    ; 0088F1BE: dc.w $8000
        dc.w    $4278                    ; 0088F1C0: dc.w $4278
        dc.w    $8002                    ; 0088F1C2: dc.w $8002
        dc.w    $4278                    ; 0088F1C4: dc.w $4278
        dc.w    $A012                    ; 0088F1C6: dc.w $A012
        dc.w    $4238                    ; 0088F1C8: dc.w $4238
        dc.w    $A018                    ; 0088F1CA: dc.w $A018
        dc.w    $4EB9, $0088, $49AA    ; 0088F1CC: JSR $008849AA
        dc.w    $21FC                    ; 0088F1D2: dc.w $21FC
        dc.w    $008B                    ; 0088F1D4: dc.w $008B
        dc.w    $B4FC                    ; 0088F1D6: dc.w $B4FC
        dc.w    $C96C                    ; 0088F1D8: dc.w $C96C
        dc.w    $11FC                    ; 0088F1DA: dc.w $11FC
        dc.w    $0001                    ; 0088F1DC: dc.w $0001
        dc.w    $C809                    ; 0088F1DE: dc.w $C809
        dc.w    $11FC                    ; 0088F1E0: dc.w $11FC
        dc.w    $0001                    ; 0088F1E2: dc.w $0001
        dc.w    $C80A                    ; 0088F1E4: dc.w $C80A
        dc.w    $08F8                    ; 0088F1E6: dc.w $08F8
        dc.w    $0006                    ; 0088F1E8: dc.w $0006
        dc.w    $C80E                    ; 0088F1EA: dc.w $C80E
        dc.w    $11FC                    ; 0088F1EC: dc.w $11FC
        dc.w    $0001                    ; 0088F1EE: dc.w $0001
        dc.w    $C802                    ; 0088F1F0: dc.w $C802
        dc.w    $31FC                    ; 0088F1F2: dc.w $31FC
        dc.w    $0001                    ; 0088F1F4: dc.w $0001
        dc.w    $A024                    ; 0088F1F6: dc.w $A024
        dc.w    $41F9, $00FF, $1000    ; 0088F1F8: LEA $00FF1000,A0
        dc.w    $303C                    ; 0088F1FE: dc.w $303C
        dc.w    $037F                    ; 0088F200: dc.w $037F
        dc.w    $4298                    ; 0088F202: dc.w $4298
        dc.w    $51C8, $FFFC            ; 0088F204: DBRA D0,$0088F202
        dc.w    $303C                    ; 0088F208: dc.w $303C
        dc.w    $0001                    ; 0088F20A: dc.w $0001
        dc.w    $323C                    ; 0088F20C: dc.w $323C
        dc.w    $0001                    ; 0088F20E: dc.w $0001
        dc.w    $343C                    ; 0088F210: dc.w $343C
        dc.w    $0001                    ; 0088F212: dc.w $0001
        dc.w    $363C                    ; 0088F214: dc.w $363C
        dc.w    $0026                    ; 0088F216: dc.w $0026
        dc.w    $383C                    ; 0088F218: dc.w $383C
        dc.w    $0009                    ; 0088F21A: dc.w $0009
        dc.w    $41F9, $00FF, $1000    ; 0088F21C: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088F222: dc.w $4EBA
        dc.w    $F008                    ; 0088F224: dc.w $F008
        dc.w    $303C                    ; 0088F226: dc.w $303C
        dc.w    $0002                    ; 0088F228: dc.w $0002
        dc.w    $323C                    ; 0088F22A: dc.w $323C
        dc.w    $0001                    ; 0088F22C: dc.w $0001
        dc.w    $343C                    ; 0088F22E: dc.w $343C
        dc.w    $000B                    ; 0088F230: dc.w $000B
        dc.w    $363C                    ; 0088F232: dc.w $363C
        dc.w    $0013                    ; 0088F234: dc.w $0013
        dc.w    $383C                    ; 0088F236: dc.w $383C
        dc.w    $0010                    ; 0088F238: dc.w $0010
        dc.w    $41F9, $00FF, $1000    ; 0088F23A: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088F240: dc.w $4EBA
        dc.w    $EFEA                    ; 0088F242: dc.w $EFEA
        dc.w    $303C                    ; 0088F244: dc.w $303C
        dc.w    $0003                    ; 0088F246: dc.w $0003
        dc.w    $323C                    ; 0088F248: dc.w $323C
        dc.w    $0014                    ; 0088F24A: dc.w $0014
        dc.w    $343C                    ; 0088F24C: dc.w $343C
        dc.w    $000B                    ; 0088F24E: dc.w $000B
        dc.w    $363C                    ; 0088F250: dc.w $363C
        dc.w    $0013                    ; 0088F252: dc.w $0013
        dc.w    $383C                    ; 0088F254: dc.w $383C
        dc.w    $0010                    ; 0088F256: dc.w $0010
        dc.w    $41F9, $00FF, $1000    ; 0088F258: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088F25E: dc.w $4EBA
        dc.w    $EFCC                    ; 0088F260: dc.w $EFCC
        dc.w    $41F9, $00FF, $1000    ; 0088F262: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088F268: dc.w $4EBA
        dc.w    $F086                    ; 0088F26A: dc.w $F086
        dc.w    $4EBA                    ; 0088F26C: dc.w $4EBA
        dc.w    $EF4E                    ; 0088F26E: dc.w $EF4E
        dc.w    $08B9                    ; 0088F270: dc.w $08B9
        dc.w    $0007                    ; 0088F272: dc.w $0007
        dc.w    $00A1                    ; 0088F274: dc.w $00A1
        dc.w    $5181                    ; 0088F276: dc.w $5181
        dc.w    $41F9, $00FF, $6E00    ; 0088F278: LEA $00FF6E00,A0
        dc.w    $D1FC                    ; 0088F27E: dc.w $D1FC
        dc.w    $0000                    ; 0088F280: dc.w $0000
        dc.w    $0160                    ; 0088F282: dc.w $0160
        dc.w    $43F9, $0088, $F39C    ; 0088F284: LEA $0088F39C,A1
        dc.w    $303C                    ; 0088F28A: dc.w $303C
        dc.w    $003F                    ; 0088F28C: dc.w $003F
        dc.w    $3219                    ; 0088F28E: dc.w $3219
        dc.w    $08C1                    ; 0088F290: dc.w $08C1
        dc.w    $000F                    ; 0088F292: dc.w $000F
        dc.w    $30C1                    ; 0088F294: dc.w $30C1
        dc.w    $51C8, $FFF6            ; 0088F296: DBRA D0,$0088F28E
        dc.w    $41F9, $000E, $9680    ; 0088F29A: LEA $000E9680,A0
        dc.w    $227C, $0603, $8000    ; 0088F2A0: MOVEA.L #$06038000,A1
        dc.w    $4EBA                    ; 0088F2A6: dc.w $4EBA
        dc.w    $F06E                    ; 0088F2A8: dc.w $F06E
        dc.w    $41F9, $000E, $9F60    ; 0088F2AA: LEA $000E9F60,A0
        dc.w    $227C, $0603, $B600    ; 0088F2B0: MOVEA.L #$0603B600,A1
        dc.w    $4EBA                    ; 0088F2B6: dc.w $4EBA
        dc.w    $F05E                    ; 0088F2B8: dc.w $F05E
        dc.w    $41F9, $000E, $A080    ; 0088F2BA: LEA $000EA080,A0
        dc.w    $227C, $0603, $BC00    ; 0088F2C0: MOVEA.L #$0603BC00,A1
        dc.w    $4EBA                    ; 0088F2C6: dc.w $4EBA
        dc.w    $F04E                    ; 0088F2C8: dc.w $F04E
        dc.w    $41F9, $000E, $A240    ; 0088F2CA: LEA $000EA240,A0
        dc.w    $227C, $0603, $C400    ; 0088F2D0: MOVEA.L #$0603C400,A1
        dc.w    $4EBA                    ; 0088F2D6: dc.w $4EBA
        dc.w    $F03E                    ; 0088F2D8: dc.w $F03E
        dc.w    $41F9, $000E, $A340    ; 0088F2DA: LEA $000EA340,A0
        dc.w    $227C, $0603, $C880    ; 0088F2E0: MOVEA.L #$0603C880,A1
        dc.w    $4EBA                    ; 0088F2E6: dc.w $4EBA
        dc.w    $F02E                    ; 0088F2E8: dc.w $F02E
        dc.w    $41F9, $000E, $90A0    ; 0088F2EA: LEA $000E90A0,A0
        dc.w    $227C, $0603, $D780    ; 0088F2F0: MOVEA.L #$0603D780,A1
        dc.w    $4EBA                    ; 0088F2F6: dc.w $4EBA
        dc.w    $F01E                    ; 0088F2F8: dc.w $F01E
        dc.w    $41F9, $000E, $A5F0    ; 0088F2FA: LEA $000EA5F0,A0
        dc.w    $227C, $0603, $DE80    ; 0088F300: MOVEA.L #$0603DE80,A1
        dc.w    $4EBA                    ; 0088F306: dc.w $4EBA
        dc.w    $F00E                    ; 0088F308: dc.w $F00E
        dc.w    $41F9, $000E, $A710    ; 0088F30A: LEA $000EA710,A0
        dc.w    $227C, $0603, $F200    ; 0088F310: MOVEA.L #$0603F200,A1
        dc.w    $4EBA                    ; 0088F316: dc.w $4EBA
        dc.w    $EFFE                    ; 0088F318: dc.w $EFFE
        dc.w    $11F8                    ; 0088F31A: dc.w $11F8
        dc.w    $A01F                    ; 0088F31C: dc.w $A01F
        dc.w    $A019                    ; 0088F31E: dc.w $A019
        dc.w    $4238                    ; 0088F320: dc.w $4238
        dc.w    $A01B                    ; 0088F322: dc.w $A01B
        dc.w    $11F8                    ; 0088F324: dc.w $11F8
        dc.w    $FEB3                    ; 0088F326: dc.w $FEB3
        dc.w    $A019                    ; 0088F328: dc.w $A019
        dc.w    $11F8                    ; 0088F32A: dc.w $11F8
        dc.w    $FEB0                    ; 0088F32C: dc.w $FEB0
        dc.w    $A01A                    ; 0088F32E: dc.w $A01A
        dc.w    $11FC                    ; 0088F330: dc.w $11FC
        dc.w    $0001                    ; 0088F332: dc.w $0001
        dc.w    $A01C                    ; 0088F334: dc.w $A01C
        dc.w    $11F8                    ; 0088F336: dc.w $11F8
        dc.w    $FEAF                    ; 0088F338: dc.w $FEAF
        dc.w    $A020                    ; 0088F33A: dc.w $A020
        dc.w    $11F8                    ; 0088F33C: dc.w $11F8
        dc.w    $FEB0                    ; 0088F33E: dc.w $FEB0
        dc.w    $A022                    ; 0088F340: dc.w $A022
        dc.w    $11F8                    ; 0088F342: dc.w $11F8
        dc.w    $FEAD                    ; 0088F344: dc.w $FEAD
        dc.w    $A021                    ; 0088F346: dc.w $A021
        dc.w    $11F8                    ; 0088F348: dc.w $11F8
        dc.w    $FEAE                    ; 0088F34A: dc.w $FEAE
        dc.w    $A023                    ; 0088F34C: dc.w $A023
        dc.w    $4EB9, $0088, $204A    ; 0088F34E: JSR $0088204A
        dc.w    $0239                    ; 0088F354: dc.w $0239
        dc.w    $00FC                    ; 0088F356: dc.w $00FC
        dc.w    $00A1                    ; 0088F358: dc.w $00A1
        dc.w    $5181                    ; 0088F35A: dc.w $5181
        dc.w    $0039                    ; 0088F35C: dc.w $0039
        dc.w    $0001                    ; 0088F35E: dc.w $0001
        dc.w    $00A1                    ; 0088F360: dc.w $00A1
        dc.w    $5181                    ; 0088F362: dc.w $5181
        dc.w    $33FC                    ; 0088F364: dc.w $33FC
        dc.w    $8083                    ; 0088F366: dc.w $8083
        dc.w    $00A1                    ; 0088F368: dc.w $00A1
        dc.w    $5100                    ; 0088F36A: dc.w $5100
        dc.w    $08F8                    ; 0088F36C: dc.w $08F8
        dc.w    $0006                    ; 0088F36E: dc.w $0006
        dc.w    $C875                    ; 0088F370: dc.w $C875
        dc.w    $3AB8                    ; 0088F372: dc.w $3AB8
        dc.w    $C874                    ; 0088F374: dc.w $C874
        dc.w    $33FC                    ; 0088F376: dc.w $33FC
        dc.w    $0020                    ; 0088F378: dc.w $0020
        dc.w    $00FF                    ; 0088F37A: dc.w $00FF
        dc.w    $0008                    ; 0088F37C: dc.w $0008
        dc.w    $4EB9, $0088, $4998    ; 0088F37E: JSR $00884998
        dc.w    $31FC                    ; 0088F384: dc.w $31FC
        dc.w    $0000                    ; 0088F386: dc.w $0000
        dc.w    $C87E                    ; 0088F388: dc.w $C87E
        dc.w    $23FC, $0088, $F41C, $00FF, $0002  ; 0088F38A: MOVE.L #$0088F41C,$00FF0002
        dc.w    $11FC                    ; 0088F394: dc.w $11FC
        dc.w    $0081                    ; 0088F396: dc.w $0081
        dc.w    $C8A5                    ; 0088F398: dc.w $C8A5
        dc.w    $4E75                    ; 0088F39A: RTS
        dc.w    $4400                    ; 0088F39C: dc.w $4400
        dc.w    $44A3                    ; 0088F39E: dc.w $44A3
        dc.w    $4946                    ; 0088F3A0: dc.w $4946
        dc.w    $4DE9                    ; 0088F3A2: dc.w $4DE9
        dc.w    $1C00                    ; 0088F3A4: dc.w $1C00
        dc.w    $28A3                    ; 0088F3A6: dc.w $28A3
        dc.w    $3546                    ; 0088F3A8: dc.w $3546
        dc.w    $41E9                    ; 0088F3AA: dc.w $41E9
        dc.w    $7FFF                    ; 0088F3AC: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3AE: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3B0: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3B2: dc.w $7FFF
        dc.w    $1C00                    ; 0088F3B4: dc.w $1C00
        dc.w    $28A3                    ; 0088F3B6: dc.w $28A3
        dc.w    $3546                    ; 0088F3B8: dc.w $3546
        dc.w    $41E9                    ; 0088F3BA: dc.w $41E9
        dc.w    $4400                    ; 0088F3BC: dc.w $4400
        dc.w    $44A3                    ; 0088F3BE: dc.w $44A3
        dc.w    $4946                    ; 0088F3C0: dc.w $4946
        dc.w    $4DE9                    ; 0088F3C2: dc.w $4DE9
        dc.w    $7FFF                    ; 0088F3C4: dc.w $7FFF
        dc.w    $63F5                    ; 0088F3C6: BLS.S $0088F3BD
        dc.w    $7FFF                    ; 0088F3C8: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3CA: dc.w $7FFF
        dc.w    $0010                    ; 0088F3CC: dc.w $0010
        dc.w    $14AF                    ; 0088F3CE: dc.w $14AF
        dc.w    $294E                    ; 0088F3D0: dc.w $294E
        dc.w    $3DED                    ; 0088F3D2: dc.w $3DED
        dc.w    $7FFF                    ; 0088F3D4: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3D6: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3D8: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3DA: dc.w $7FFF
        dc.w    $77BA                    ; 0088F3DC: dc.w $77BA
        dc.w    $7BBC                    ; 0088F3DE: dc.w $7BBC
        dc.w    $779A                    ; 0088F3E0: dc.w $779A
        dc.w    $77BC                    ; 0088F3E2: dc.w $77BC
        dc.w    $6B36                    ; 0088F3E4: BMI.S $0088F41C
        dc.w    $6B37                    ; 0088F3E6: BMI.S $0088F41F
        dc.w    $6F58                    ; 0088F3E8: BLE.S $0088F442
        dc.w    $6F79                    ; 0088F3EA: BLE.S $0088F465
        dc.w    $739A                    ; 0088F3EC: dc.w $739A
        dc.w    $61E8                    ; 0088F3EE: BSR.S $0088F3D8
        dc.w    $7FFF                    ; 0088F3F0: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3F2: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3F4: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3F6: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3F8: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F3FA: dc.w $7FFF
        dc.w    $7FBC                    ; 0088F3FC: dc.w $7FBC
        dc.w    $7F7A                    ; 0088F3FE: dc.w $7F7A
        dc.w    $7FDE                    ; 0088F400: dc.w $7FDE
        dc.w    $7F9B                    ; 0088F402: dc.w $7F9B
        dc.w    $4445                    ; 0088F404: dc.w $4445
        dc.w    $512B                    ; 0088F406: dc.w $512B
        dc.w    $6212                    ; 0088F408: BHI.S $0088F41C
        dc.w    $6EF8                    ; 0088F40A: BGT.S $0088F404
        dc.w    $7FFF                    ; 0088F40C: dc.w $7FFF
        dc.w    $031F                    ; 0088F40E: dc.w $031F
        dc.w    $7FFF                    ; 0088F410: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F412: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F414: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F416: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F418: dc.w $7FFF
        dc.w    $7FFF                    ; 0088F41A: dc.w $7FFF
        dc.w    $4EB9, $0088, $2080    ; 0088F41C: JSR $00882080
        dc.w    $3038                    ; 0088F422: dc.w $3038
        dc.w    $C87E                    ; 0088F424: dc.w $C87E
        dc.w    $227B                    ; 0088F426: dc.w $227B
        dc.w    $0004                    ; 0088F428: dc.w $0004
        dc.w    $4ED1                    ; 0088F42A: JMP (A1)
        dc.w    $0088                    ; 0088F42C: dc.w $0088
        dc.w    $F44C                    ; 0088F42E: dc.w $F44C
        dc.w    $0088                    ; 0088F430: dc.w $0088
        dc.w    $F6E2                    ; 0088F432: dc.w $F6E2
        dc.w    $0088                    ; 0088F434: dc.w $0088
        dc.w    $F85C                    ; 0088F436: dc.w $F85C
        dc.w    $4EBA                    ; 0088F438: dc.w $4EBA
        dc.w    $C24A                    ; 0088F43A: dc.w $C24A
        dc.w    $0838                    ; 0088F43C: dc.w $0838
        dc.w    $0006                    ; 0088F43E: dc.w $0006
        dc.w    $C80E                    ; 0088F440: dc.w $C80E
        dc.w    $6606                    ; 0088F442: BNE.S $0088F44A
        dc.w    $5878                    ; 0088F444: dc.w $5878
        dc.w    $C87E                    ; 0088F446: dc.w $C87E
        dc.w    $4E71                    ; 0088F448: NOP
        dc.w    $4E75                    ; 0088F44A: RTS
        dc.w    $4240                    ; 0088F44C: dc.w $4240
        dc.w    $1038                    ; 0088F44E: dc.w $1038
        dc.w    $A01B                    ; 0088F450: dc.w $A01B
        dc.w    $6100, $0438            ; 0088F452: BSR.W $0088F88C
        dc.w    $4EB9, $0088, $179E    ; 0088F456: JSR $0088179E
        dc.w    $4A78                    ; 0088F45C: dc.w $4A78
        dc.w    $A024                    ; 0088F45E: dc.w $A024
        dc.w    $6600, $01E0            ; 0088F460: BNE.W $0088F642
        dc.w    $1038                    ; 0088F464: dc.w $1038
        dc.w    $A019                    ; 0088F466: dc.w $A019
        dc.w    $3238                    ; 0088F468: dc.w $3238
        dc.w    $C86C                    ; 0088F46A: dc.w $C86C
        dc.w    $0801                    ; 0088F46C: dc.w $0801
        dc.w    $0003                    ; 0088F46E: dc.w $0003
        dc.w    $6748                    ; 0088F470: BEQ.S $0088F4BA
        dc.w    $11FC                    ; 0088F472: dc.w $11FC
        dc.w    $00A9                    ; 0088F474: dc.w $00A9
        dc.w    $C8A4                    ; 0088F476: dc.w $C8A4
        dc.w    $4A38                    ; 0088F478: dc.w $4A38
        dc.w    $A01B                    ; 0088F47A: dc.w $A01B
        dc.w    $6700, $001A            ; 0088F47C: BEQ.W $0088F498
        dc.w    $0C38                    ; 0088F480: dc.w $0C38
        dc.w    $0001                    ; 0088F482: dc.w $0001
        dc.w    $A01B                    ; 0088F484: dc.w $A01B
        dc.w    $6700, $001E            ; 0088F486: BEQ.W $0088F4A6
        dc.w    $0C00                    ; 0088F48A: dc.w $0C00
        dc.w    $0004                    ; 0088F48C: dc.w $0004
        dc.w    $6D00, $0024            ; 0088F48E: BLT.W $0088F4B4
        dc.w    $4200                    ; 0088F492: dc.w $4200
        dc.w    $6000, $00E4            ; 0088F494: BRA.W $0088F57A
        dc.w    $0C00                    ; 0088F498: dc.w $0C00
        dc.w    $0002                    ; 0088F49A: dc.w $0002
        dc.w    $6D00, $0016            ; 0088F49C: BLT.W $0088F4B4
        dc.w    $4200                    ; 0088F4A0: dc.w $4200
        dc.w    $6000, $00D6            ; 0088F4A2: BRA.W $0088F57A
        dc.w    $0C00                    ; 0088F4A6: dc.w $0C00
        dc.w    $0001                    ; 0088F4A8: dc.w $0001
        dc.w    $6D00, $0008            ; 0088F4AA: BLT.W $0088F4B4
        dc.w    $4200                    ; 0088F4AE: dc.w $4200
        dc.w    $6000, $00C8            ; 0088F4B0: BRA.W $0088F57A
        dc.w    $5200                    ; 0088F4B4: dc.w $5200
        dc.w    $6000, $00C2            ; 0088F4B6: BRA.W $0088F57A
        dc.w    $0801                    ; 0088F4BA: dc.w $0801
        dc.w    $0002                    ; 0088F4BC: dc.w $0002
        dc.w    $673C                    ; 0088F4BE: BEQ.S $0088F4FC
        dc.w    $11FC                    ; 0088F4C0: dc.w $11FC
        dc.w    $00A9                    ; 0088F4C2: dc.w $00A9
        dc.w    $C8A4                    ; 0088F4C4: dc.w $C8A4
        dc.w    $4A00                    ; 0088F4C6: dc.w $4A00
        dc.w    $6F00, $0008            ; 0088F4C8: BLE.W $0088F4D2
        dc.w    $5300                    ; 0088F4CC: dc.w $5300
        dc.w    $6000, $00AA            ; 0088F4CE: BRA.W $0088F57A
        dc.w    $4A38                    ; 0088F4D2: dc.w $4A38
        dc.w    $A01B                    ; 0088F4D4: dc.w $A01B
        dc.w    $6700, $0014            ; 0088F4D6: BEQ.W $0088F4EC
        dc.w    $0C38                    ; 0088F4DA: dc.w $0C38
        dc.w    $0001                    ; 0088F4DC: dc.w $0001
        dc.w    $A01B                    ; 0088F4DE: dc.w $A01B
        dc.w    $6700, $0012            ; 0088F4E0: BEQ.W $0088F4F4
        dc.w    $103C                    ; 0088F4E4: dc.w $103C
        dc.w    $0004                    ; 0088F4E6: dc.w $0004
        dc.w    $6000, $0090            ; 0088F4E8: BRA.W $0088F57A
        dc.w    $103C                    ; 0088F4EC: dc.w $103C
        dc.w    $0002                    ; 0088F4EE: dc.w $0002
        dc.w    $6000, $0088            ; 0088F4F0: BRA.W $0088F57A
        dc.w    $103C                    ; 0088F4F4: dc.w $103C
        dc.w    $0001                    ; 0088F4F6: dc.w $0001
        dc.w    $6000, $0080            ; 0088F4F8: BRA.W $0088F57A
        dc.w    $0801                    ; 0088F4FC: dc.w $0801
        dc.w    $0000                    ; 0088F4FE: dc.w $0000
        dc.w    $6700, $003A            ; 0088F500: BEQ.W $0088F53C
        dc.w    $4A38                    ; 0088F504: dc.w $4A38
        dc.w    $A01B                    ; 0088F506: dc.w $A01B
        dc.w    $6700, $0070            ; 0088F508: BEQ.W $0088F57A
        dc.w    $11FC                    ; 0088F50C: dc.w $11FC
        dc.w    $00A9                    ; 0088F50E: dc.w $00A9
        dc.w    $C8A4                    ; 0088F510: dc.w $C8A4
        dc.w    $0C38                    ; 0088F512: dc.w $0C38
        dc.w    $0001                    ; 0088F514: dc.w $0001
        dc.w    $A01B                    ; 0088F516: dc.w $A01B
        dc.w    $6712                    ; 0088F518: BEQ.S $0088F52C
        dc.w    $11FC                    ; 0088F51A: dc.w $11FC
        dc.w    $0001                    ; 0088F51C: dc.w $0001
        dc.w    $A01B                    ; 0088F51E: dc.w $A01B
        dc.w    $11C0                    ; 0088F520: dc.w $11C0
        dc.w    $A021                    ; 0088F522: dc.w $A021
        dc.w    $1038                    ; 0088F524: dc.w $1038
        dc.w    $A020                    ; 0088F526: dc.w $A020
        dc.w    $6000, $0050            ; 0088F528: BRA.W $0088F57A
        dc.w    $4238                    ; 0088F52C: dc.w $4238
        dc.w    $A01B                    ; 0088F52E: dc.w $A01B
        dc.w    $11C0                    ; 0088F530: dc.w $11C0
        dc.w    $A020                    ; 0088F532: dc.w $A020
        dc.w    $1038                    ; 0088F534: dc.w $1038
        dc.w    $A01F                    ; 0088F536: dc.w $A01F
        dc.w    $6000, $0040            ; 0088F538: BRA.W $0088F57A
        dc.w    $0801                    ; 0088F53C: dc.w $0801
        dc.w    $0001                    ; 0088F53E: dc.w $0001
        dc.w    $6700, $0038            ; 0088F540: BEQ.W $0088F57A
        dc.w    $0C38                    ; 0088F544: dc.w $0C38
        dc.w    $0002                    ; 0088F546: dc.w $0002
        dc.w    $A01B                    ; 0088F548: dc.w $A01B
        dc.w    $6C00, $002E            ; 0088F54A: BGE.W $0088F57A
        dc.w    $11FC                    ; 0088F54E: dc.w $11FC
        dc.w    $00A9                    ; 0088F550: dc.w $00A9
        dc.w    $C8A4                    ; 0088F552: dc.w $C8A4
        dc.w    $4A38                    ; 0088F554: dc.w $4A38
        dc.w    $A01B                    ; 0088F556: dc.w $A01B
        dc.w    $6712                    ; 0088F558: BEQ.S $0088F56C
        dc.w    $11FC                    ; 0088F55A: dc.w $11FC
        dc.w    $0002                    ; 0088F55C: dc.w $0002
        dc.w    $A01B                    ; 0088F55E: dc.w $A01B
        dc.w    $11C0                    ; 0088F560: dc.w $11C0
        dc.w    $A020                    ; 0088F562: dc.w $A020
        dc.w    $1038                    ; 0088F564: dc.w $1038
        dc.w    $A021                    ; 0088F566: dc.w $A021
        dc.w    $6000, $0010            ; 0088F568: BRA.W $0088F57A
        dc.w    $11FC                    ; 0088F56C: dc.w $11FC
        dc.w    $0001                    ; 0088F56E: dc.w $0001
        dc.w    $A01B                    ; 0088F570: dc.w $A01B
        dc.w    $11C0                    ; 0088F572: dc.w $11C0
        dc.w    $A01F                    ; 0088F574: dc.w $A01F
        dc.w    $1038                    ; 0088F576: dc.w $1038
        dc.w    $A020                    ; 0088F578: dc.w $A020
        dc.w    $11C0                    ; 0088F57A: dc.w $11C0
        dc.w    $A019                    ; 0088F57C: dc.w $A019
        dc.w    $1038                    ; 0088F57E: dc.w $1038
        dc.w    $A01A                    ; 0088F580: dc.w $A01A
        dc.w    $3238                    ; 0088F582: dc.w $3238
        dc.w    $C86E                    ; 0088F584: dc.w $C86E
        dc.w    $0801                    ; 0088F586: dc.w $0801
        dc.w    $0003                    ; 0088F588: dc.w $0003
        dc.w    $6732                    ; 0088F58A: BEQ.S $0088F5BE
        dc.w    $11FC                    ; 0088F58C: dc.w $11FC
        dc.w    $00A9                    ; 0088F58E: dc.w $00A9
        dc.w    $C8A4                    ; 0088F590: dc.w $C8A4
        dc.w    $0C38                    ; 0088F592: dc.w $0C38
        dc.w    $0001                    ; 0088F594: dc.w $0001
        dc.w    $A01C                    ; 0088F596: dc.w $A01C
        dc.w    $6700, $0010            ; 0088F598: BEQ.W $0088F5AA
        dc.w    $0C00                    ; 0088F59C: dc.w $0C00
        dc.w    $0004                    ; 0088F59E: dc.w $0004
        dc.w    $6D00, $0016            ; 0088F5A0: BLT.W $0088F5B8
        dc.w    $4200                    ; 0088F5A4: dc.w $4200
        dc.w    $6000, $0096            ; 0088F5A6: BRA.W $0088F63E
        dc.w    $0C00                    ; 0088F5AA: dc.w $0C00
        dc.w    $0001                    ; 0088F5AC: dc.w $0001
        dc.w    $6D00, $0008            ; 0088F5AE: BLT.W $0088F5B8
        dc.w    $4200                    ; 0088F5B2: dc.w $4200
        dc.w    $6000, $0088            ; 0088F5B4: BRA.W $0088F63E
        dc.w    $5200                    ; 0088F5B8: dc.w $5200
        dc.w    $6000, $0082            ; 0088F5BA: BRA.W $0088F63E
        dc.w    $0801                    ; 0088F5BE: dc.w $0801
        dc.w    $0002                    ; 0088F5C0: dc.w $0002
        dc.w    $672C                    ; 0088F5C2: BEQ.S $0088F5F0
        dc.w    $11FC                    ; 0088F5C4: dc.w $11FC
        dc.w    $00A9                    ; 0088F5C6: dc.w $00A9
        dc.w    $C8A4                    ; 0088F5C8: dc.w $C8A4
        dc.w    $4A00                    ; 0088F5CA: dc.w $4A00
        dc.w    $6F00, $0008            ; 0088F5CC: BLE.W $0088F5D6
        dc.w    $5300                    ; 0088F5D0: dc.w $5300
        dc.w    $6000, $006A            ; 0088F5D2: BRA.W $0088F63E
        dc.w    $0C38                    ; 0088F5D6: dc.w $0C38
        dc.w    $0001                    ; 0088F5D8: dc.w $0001
        dc.w    $A01C                    ; 0088F5DA: dc.w $A01C
        dc.w    $6700, $000A            ; 0088F5DC: BEQ.W $0088F5E8
        dc.w    $103C                    ; 0088F5E0: dc.w $103C
        dc.w    $0004                    ; 0088F5E2: dc.w $0004
        dc.w    $6000, $0058            ; 0088F5E4: BRA.W $0088F63E
        dc.w    $103C                    ; 0088F5E8: dc.w $103C
        dc.w    $0001                    ; 0088F5EA: dc.w $0001
        dc.w    $6000, $0050            ; 0088F5EC: BRA.W $0088F63E
        dc.w    $0801                    ; 0088F5F0: dc.w $0801
        dc.w    $0000                    ; 0088F5F2: dc.w $0000
        dc.w    $6700, $0022            ; 0088F5F4: BEQ.W $0088F618
        dc.w    $0C38                    ; 0088F5F8: dc.w $0C38
        dc.w    $0001                    ; 0088F5FA: dc.w $0001
        dc.w    $A01C                    ; 0088F5FC: dc.w $A01C
        dc.w    $673E                    ; 0088F5FE: BEQ.S $0088F63E
        dc.w    $11FC                    ; 0088F600: dc.w $11FC
        dc.w    $00A9                    ; 0088F602: dc.w $00A9
        dc.w    $C8A4                    ; 0088F604: dc.w $C8A4
        dc.w    $11FC                    ; 0088F606: dc.w $11FC
        dc.w    $0001                    ; 0088F608: dc.w $0001
        dc.w    $A01C                    ; 0088F60A: dc.w $A01C
        dc.w    $11C0                    ; 0088F60C: dc.w $11C0
        dc.w    $A023                    ; 0088F60E: dc.w $A023
        dc.w    $1038                    ; 0088F610: dc.w $1038
        dc.w    $A022                    ; 0088F612: dc.w $A022
        dc.w    $6000, $0028            ; 0088F614: BRA.W $0088F63E
        dc.w    $0801                    ; 0088F618: dc.w $0801
        dc.w    $0001                    ; 0088F61A: dc.w $0001
        dc.w    $6700, $0020            ; 0088F61C: BEQ.W $0088F63E
        dc.w    $0C38                    ; 0088F620: dc.w $0C38
        dc.w    $0002                    ; 0088F622: dc.w $0002
        dc.w    $A01C                    ; 0088F624: dc.w $A01C
        dc.w    $6C00, $0016            ; 0088F626: BGE.W $0088F63E
        dc.w    $11FC                    ; 0088F62A: dc.w $11FC
        dc.w    $00A9                    ; 0088F62C: dc.w $00A9
        dc.w    $C8A4                    ; 0088F62E: dc.w $C8A4
        dc.w    $11FC                    ; 0088F630: dc.w $11FC
        dc.w    $0002                    ; 0088F632: dc.w $0002
        dc.w    $A01C                    ; 0088F634: dc.w $A01C
        dc.w    $11C0                    ; 0088F636: dc.w $11C0
        dc.w    $A022                    ; 0088F638: dc.w $A022
        dc.w    $1038                    ; 0088F63A: dc.w $1038
        dc.w    $A023                    ; 0088F63C: dc.w $A023
        dc.w    $11C0                    ; 0088F63E: dc.w $11C0
        dc.w    $A01A                    ; 0088F640: dc.w $A01A
        dc.w    $207C, $0603, $8000    ; 0088F642: MOVEA.L #$06038000,A0
        dc.w    $227C, $0400, $7010    ; 0088F648: MOVEA.L #$04007010,A1
        dc.w    $303C                    ; 0088F64E: dc.w $303C
        dc.w    $0120                    ; 0088F650: dc.w $0120
        dc.w    $323C                    ; 0088F652: dc.w $323C
        dc.w    $0030                    ; 0088F654: dc.w $0030
        dc.w    $4EBA                    ; 0088F656: dc.w $4EBA
        dc.w    $ED02                    ; 0088F658: dc.w $ED02
        dc.w    $45F9, $0088, $F682    ; 0088F65A: LEA $0088F682,A2
        dc.w    $343C                    ; 0088F660: dc.w $343C
        dc.w    $0007                    ; 0088F662: dc.w $0007
        dc.w    $205A                    ; 0088F664: dc.w $205A
        dc.w    $225A                    ; 0088F666: dc.w $225A
        dc.w    $301A                    ; 0088F668: dc.w $301A
        dc.w    $321A                    ; 0088F66A: dc.w $321A
        dc.w    $4EBA                    ; 0088F66C: dc.w $4EBA
        dc.w    $ECEC                    ; 0088F66E: dc.w $ECEC
        dc.w    $51CA, $FFF2            ; 0088F670: DBRA D2,$0088F664
        dc.w    $5878                    ; 0088F674: dc.w $5878
        dc.w    $C87E                    ; 0088F676: dc.w $C87E
        dc.w    $33FC                    ; 0088F678: dc.w $33FC
        dc.w    $0020                    ; 0088F67A: dc.w $0020
        dc.w    $00FF                    ; 0088F67C: dc.w $00FF
        dc.w    $0008                    ; 0088F67E: dc.w $0008
        dc.w    $4E75                    ; 0088F680: RTS
        dc.w    $0603                    ; 0088F682: dc.w $0603
        dc.w    $B600                    ; 0088F684: dc.w $B600
        dc.w    $0401                    ; 0088F686: dc.w $0401
        dc.w    $2024                    ; 0088F688: dc.w $2024
        dc.w    $0060                    ; 0088F68A: dc.w $0060
        dc.w    $0010                    ; 0088F68C: dc.w $0010
        dc.w    $0603                    ; 0088F68E: dc.w $0603
        dc.w    $BC00                    ; 0088F690: dc.w $BC00
        dc.w    $0401                    ; 0088F692: dc.w $0401
        dc.w    $4014                    ; 0088F694: dc.w $4014
        dc.w    $0080                    ; 0088F696: dc.w $0080
        dc.w    $0010                    ; 0088F698: dc.w $0010
        dc.w    $0603                    ; 0088F69A: dc.w $0603
        dc.w    $C400                    ; 0088F69C: dc.w $C400
        dc.w    $0401                    ; 0088F69E: dc.w $0401
        dc.w    $7030                    ; 0088F6A0: MOVEQ #$30,D0
        dc.w    $0048                    ; 0088F6A2: dc.w $0048
        dc.w    $0010                    ; 0088F6A4: dc.w $0010
        dc.w    $0603                    ; 0088F6A6: dc.w $0603
        dc.w    $C880                    ; 0088F6A8: dc.w $C880
        dc.w    $0401                    ; 0088F6AA: dc.w $0401
        dc.w    $9018                    ; 0088F6AC: dc.w $9018
        dc.w    $0078                    ; 0088F6AE: dc.w $0078
        dc.w    $0020                    ; 0088F6B0: dc.w $0020
        dc.w    $0603                    ; 0088F6B2: dc.w $0603
        dc.w    $B600                    ; 0088F6B4: dc.w $B600
        dc.w    $0401                    ; 0088F6B6: dc.w $0401
        dc.w    $20BC                    ; 0088F6B8: dc.w $20BC
        dc.w    $0060                    ; 0088F6BA: dc.w $0060
        dc.w    $0010                    ; 0088F6BC: dc.w $0010
        dc.w    $0603                    ; 0088F6BE: dc.w $0603
        dc.w    $BC00                    ; 0088F6C0: dc.w $BC00
        dc.w    $0401                    ; 0088F6C2: dc.w $0401
        dc.w    $40AC                    ; 0088F6C4: dc.w $40AC
        dc.w    $0080                    ; 0088F6C6: dc.w $0080
        dc.w    $0010                    ; 0088F6C8: dc.w $0010
        dc.w    $0603                    ; 0088F6CA: dc.w $0603
        dc.w    $C400                    ; 0088F6CC: dc.w $C400
        dc.w    $0401                    ; 0088F6CE: dc.w $0401
        dc.w    $70C8                    ; 0088F6D0: MOVEQ #$C8,D0
        dc.w    $0048                    ; 0088F6D2: dc.w $0048
        dc.w    $0010                    ; 0088F6D4: dc.w $0010
        dc.w    $0603                    ; 0088F6D6: dc.w $0603
        dc.w    $C880                    ; 0088F6D8: dc.w $C880
        dc.w    $0401                    ; 0088F6DA: dc.w $0401
        dc.w    $90B0                    ; 0088F6DC: dc.w $90B0
        dc.w    $0078                    ; 0088F6DE: dc.w $0078
        dc.w    $0020                    ; 0088F6E0: dc.w $0020
        dc.w    $4A39                    ; 0088F6E2: dc.w $4A39
        dc.w    $00A1                    ; 0088F6E4: dc.w $00A1
        dc.w    $5120                    ; 0088F6E6: dc.w $5120
        dc.w    $66F8                    ; 0088F6E8: BNE.S $0088F6E2
        dc.w    $6100, $022A            ; 0088F6EA: BSR.W $0088F916
        dc.w    $45F9, $0088, $F838    ; 0088F6EE: LEA $0088F838,A2
        dc.w    $343C                    ; 0088F6F4: dc.w $343C
        dc.w    $0002                    ; 0088F6F6: dc.w $0002
        dc.w    $205A                    ; 0088F6F8: dc.w $205A
        dc.w    $225A                    ; 0088F6FA: dc.w $225A
        dc.w    $301A                    ; 0088F6FC: dc.w $301A
        dc.w    $321A                    ; 0088F6FE: dc.w $321A
        dc.w    $4EBA                    ; 0088F700: dc.w $4EBA
        dc.w    $EC58                    ; 0088F702: dc.w $EC58
        dc.w    $51CA, $FFF2            ; 0088F704: DBRA D2,$0088F6F8
        dc.w    $4240                    ; 0088F708: dc.w $4240
        dc.w    $1038                    ; 0088F70A: dc.w $1038
        dc.w    $A01B                    ; 0088F70C: dc.w $A01B
        dc.w    $6100, $017C            ; 0088F70E: BSR.W $0088F88C
        dc.w    $4EBA                    ; 0088F712: dc.w $4EBA
        dc.w    $BF70                    ; 0088F714: dc.w $BF70
        dc.w    $4EBA                    ; 0088F716: dc.w $4EBA
        dc.w    $BFC2                    ; 0088F718: dc.w $BFC2
        dc.w    $0C78                    ; 0088F71A: dc.w $0C78
        dc.w    $0001                    ; 0088F71C: dc.w $0001
        dc.w    $A024                    ; 0088F71E: dc.w $A024
        dc.w    $6700, $00D6            ; 0088F720: BEQ.W $0088F7F8
        dc.w    $0C78                    ; 0088F724: dc.w $0C78
        dc.w    $0002                    ; 0088F726: dc.w $0002
        dc.w    $A024                    ; 0088F728: dc.w $A024
        dc.w    $6700, $00E0            ; 0088F72A: BEQ.W $0088F80C
        dc.w    $3238                    ; 0088F72E: dc.w $3238
        dc.w    $C86C                    ; 0088F730: dc.w $C86C
        dc.w    $0201                    ; 0088F732: dc.w $0201
        dc.w    $00E0                    ; 0088F734: dc.w $00E0
        dc.w    $6628                    ; 0088F736: BNE.S $0088F760
        dc.w    $3238                    ; 0088F738: dc.w $3238
        dc.w    $C86E                    ; 0088F73A: dc.w $C86E
        dc.w    $3401                    ; 0088F73C: dc.w $3401
        dc.w    $0202                    ; 0088F73E: dc.w $0202
        dc.w    $00E0                    ; 0088F740: dc.w $00E0
        dc.w    $661C                    ; 0088F742: BNE.S $0088F760
        dc.w    $0201                    ; 0088F744: dc.w $0201
        dc.w    $0010                    ; 0088F746: dc.w $0010
        dc.w    $6612                    ; 0088F748: BNE.S $0088F75C
        dc.w    $3238                    ; 0088F74A: dc.w $3238
        dc.w    $C86C                    ; 0088F74C: dc.w $C86C
        dc.w    $0201                    ; 0088F74E: dc.w $0201
        dc.w    $0010                    ; 0088F750: dc.w $0010
        dc.w    $6608                    ; 0088F752: BNE.S $0088F75C
        dc.w    $5978                    ; 0088F754: dc.w $5978
        dc.w    $C87E                    ; 0088F756: dc.w $C87E
        dc.w    $6000, $00CE            ; 0088F758: BRA.W $0088F828
        dc.w    $50F8                    ; 0088F75C: dc.w $50F8
        dc.w    $A018                    ; 0088F75E: dc.w $A018
        dc.w    $11FC                    ; 0088F760: dc.w $11FC
        dc.w    $00A8                    ; 0088F762: dc.w $00A8
        dc.w    $C8A4                    ; 0088F764: dc.w $C8A4
        dc.w    $4A38                    ; 0088F766: dc.w $4A38
        dc.w    $A01B                    ; 0088F768: dc.w $A01B
        dc.w    $671E                    ; 0088F76A: BEQ.S $0088F78A
        dc.w    $0C38                    ; 0088F76C: dc.w $0C38
        dc.w    $0001                    ; 0088F76E: dc.w $0001
        dc.w    $A01B                    ; 0088F770: dc.w $A01B
        dc.w    $672A                    ; 0088F772: BEQ.S $0088F79E
        dc.w    $11F8                    ; 0088F774: dc.w $11F8
        dc.w    $A01F                    ; 0088F776: dc.w $A01F
        dc.w    $FEB3                    ; 0088F778: dc.w $FEB3
        dc.w    $11F8                    ; 0088F77A: dc.w $11F8
        dc.w    $A020                    ; 0088F77C: dc.w $A020
        dc.w    $FEAF                    ; 0088F77E: dc.w $FEAF
        dc.w    $11F8                    ; 0088F780: dc.w $11F8
        dc.w    $A019                    ; 0088F782: dc.w $A019
        dc.w    $FEAD                    ; 0088F784: dc.w $FEAD
        dc.w    $6000, $0028            ; 0088F786: BRA.W $0088F7B0
        dc.w    $11F8                    ; 0088F78A: dc.w $11F8
        dc.w    $A019                    ; 0088F78C: dc.w $A019
        dc.w    $FEB3                    ; 0088F78E: dc.w $FEB3
        dc.w    $11F8                    ; 0088F790: dc.w $11F8
        dc.w    $A020                    ; 0088F792: dc.w $A020
        dc.w    $FEAF                    ; 0088F794: dc.w $FEAF
        dc.w    $11F8                    ; 0088F796: dc.w $11F8
        dc.w    $A021                    ; 0088F798: dc.w $A021
        dc.w    $FEAD                    ; 0088F79A: dc.w $FEAD
        dc.w    $6012                    ; 0088F79C: BRA.S $0088F7B0
        dc.w    $11F8                    ; 0088F79E: dc.w $11F8
        dc.w    $A01F                    ; 0088F7A0: dc.w $A01F
        dc.w    $FEB3                    ; 0088F7A2: dc.w $FEB3
        dc.w    $11F8                    ; 0088F7A4: dc.w $11F8
        dc.w    $A019                    ; 0088F7A6: dc.w $A019
        dc.w    $FEAF                    ; 0088F7A8: dc.w $FEAF
        dc.w    $11F8                    ; 0088F7AA: dc.w $11F8
        dc.w    $A021                    ; 0088F7AC: dc.w $A021
        dc.w    $FEAD                    ; 0088F7AE: dc.w $FEAD
        dc.w    $0C38                    ; 0088F7B0: dc.w $0C38
        dc.w    $0001                    ; 0088F7B2: dc.w $0001
        dc.w    $A01C                    ; 0088F7B4: dc.w $A01C
        dc.w    $670E                    ; 0088F7B6: BEQ.S $0088F7C6
        dc.w    $11F8                    ; 0088F7B8: dc.w $11F8
        dc.w    $A022                    ; 0088F7BA: dc.w $A022
        dc.w    $FEB0                    ; 0088F7BC: dc.w $FEB0
        dc.w    $11F8                    ; 0088F7BE: dc.w $11F8
        dc.w    $A01A                    ; 0088F7C0: dc.w $A01A
        dc.w    $FEAE                    ; 0088F7C2: dc.w $FEAE
        dc.w    $600C                    ; 0088F7C4: BRA.S $0088F7D2
        dc.w    $11F8                    ; 0088F7C6: dc.w $11F8
        dc.w    $A01A                    ; 0088F7C8: dc.w $A01A
        dc.w    $FEB0                    ; 0088F7CA: dc.w $FEB0
        dc.w    $11F8                    ; 0088F7CC: dc.w $11F8
        dc.w    $A023                    ; 0088F7CE: dc.w $A023
        dc.w    $FEAE                    ; 0088F7D0: dc.w $FEAE
        dc.w    $4238                    ; 0088F7D2: dc.w $4238
        dc.w    $A01E                    ; 0088F7D4: dc.w $A01E
        dc.w    $11FC                    ; 0088F7D6: dc.w $11FC
        dc.w    $0001                    ; 0088F7D8: dc.w $0001
        dc.w    $C809                    ; 0088F7DA: dc.w $C809
        dc.w    $11FC                    ; 0088F7DC: dc.w $11FC
        dc.w    $0001                    ; 0088F7DE: dc.w $0001
        dc.w    $C80A                    ; 0088F7E0: dc.w $C80A
        dc.w    $08F8                    ; 0088F7E2: dc.w $08F8
        dc.w    $0007                    ; 0088F7E4: dc.w $0007
        dc.w    $C80E                    ; 0088F7E6: dc.w $C80E
        dc.w    $11FC                    ; 0088F7E8: dc.w $11FC
        dc.w    $0001                    ; 0088F7EA: dc.w $0001
        dc.w    $C802                    ; 0088F7EC: dc.w $C802
        dc.w    $31FC                    ; 0088F7EE: dc.w $31FC
        dc.w    $0002                    ; 0088F7F0: dc.w $0002
        dc.w    $A024                    ; 0088F7F2: dc.w $A024
        dc.w    $6000, $002E            ; 0088F7F4: BRA.W $0088F824
        dc.w    $6100, $033C            ; 0088F7F8: BSR.W $0088FB36
        dc.w    $0838                    ; 0088F7FC: dc.w $0838
        dc.w    $0006                    ; 0088F7FE: dc.w $0006
        dc.w    $C80E                    ; 0088F800: dc.w $C80E
        dc.w    $6620                    ; 0088F802: BNE.S $0088F824
        dc.w    $4278                    ; 0088F804: dc.w $4278
        dc.w    $A024                    ; 0088F806: dc.w $A024
        dc.w    $6000, $001A            ; 0088F808: BRA.W $0088F824
        dc.w    $6100, $0328            ; 0088F80C: BSR.W $0088FB36
        dc.w    $0838                    ; 0088F810: dc.w $0838
        dc.w    $0007                    ; 0088F812: dc.w $0007
        dc.w    $C80E                    ; 0088F814: dc.w $C80E
        dc.w    $660C                    ; 0088F816: BNE.S $0088F824
        dc.w    $4278                    ; 0088F818: dc.w $4278
        dc.w    $A024                    ; 0088F81A: dc.w $A024
        dc.w    $5878                    ; 0088F81C: dc.w $5878
        dc.w    $C87E                    ; 0088F81E: dc.w $C87E
        dc.w    $6000, $0006            ; 0088F820: BRA.W $0088F828
        dc.w    $5978                    ; 0088F824: dc.w $5978
        dc.w    $C87E                    ; 0088F826: dc.w $C87E
        dc.w    $33FC                    ; 0088F828: dc.w $33FC
        dc.w    $0018                    ; 0088F82A: dc.w $0018
        dc.w    $00FF                    ; 0088F82C: dc.w $00FF
        dc.w    $0008                    ; 0088F82E: dc.w $0008
        dc.w    $11FC                    ; 0088F830: dc.w $11FC
        dc.w    $0001                    ; 0088F832: dc.w $0001
        dc.w    $C821                    ; 0088F834: dc.w $C821
        dc.w    $4E75                    ; 0088F836: RTS
        dc.w    $0603                    ; 0088F838: dc.w $0603
        dc.w    $D780                    ; 0088F83A: dc.w $D780
        dc.w    $0400                    ; 0088F83C: dc.w $0400
        dc.w    $4C68                    ; 0088F83E: dc.w $4C68
        dc.w    $0070                    ; 0088F840: dc.w $0070
        dc.w    $0010                    ; 0088F842: dc.w $0010
        dc.w    $0603                    ; 0088F844: dc.w $0603
        dc.w    $DE80                    ; 0088F846: dc.w $DE80
        dc.w    $0400                    ; 0088F848: dc.w $0400
        dc.w    $EC2C                    ; 0088F84A: dc.w $EC2C
        dc.w    $0048                    ; 0088F84C: dc.w $0048
        dc.w    $0010                    ; 0088F84E: dc.w $0010
        dc.w    $0603                    ; 0088F850: dc.w $0603
        dc.w    $F200                    ; 0088F852: dc.w $F200
        dc.w    $0400                    ; 0088F854: dc.w $0400
        dc.w    $ECC4                    ; 0088F856: dc.w $ECC4
        dc.w    $0048                    ; 0088F858: dc.w $0048
        dc.w    $0010                    ; 0088F85A: dc.w $0010
        dc.w    $4A39                    ; 0088F85C: dc.w $4A39
        dc.w    $00A1                    ; 0088F85E: dc.w $00A1
        dc.w    $5120                    ; 0088F860: dc.w $5120
        dc.w    $66F8                    ; 0088F862: BNE.S $0088F85C
        dc.w    $4239                    ; 0088F864: dc.w $4239
        dc.w    $00A1                    ; 0088F866: dc.w $00A1
        dc.w    $5123                    ; 0088F868: dc.w $5123
        dc.w    $31FC                    ; 0088F86A: dc.w $31FC
        dc.w    $0000                    ; 0088F86C: dc.w $0000
        dc.w    $C87E                    ; 0088F86E: dc.w $C87E
        dc.w    $23FC, $0089, $26D2, $00FF, $0002  ; 0088F870: MOVE.L #$008926D2,$00FF0002
        dc.w    $4A38                    ; 0088F87A: dc.w $4A38
        dc.w    $A018                    ; 0088F87C: dc.w $A018
        dc.w    $660A                    ; 0088F87E: BNE.S $0088F88A
        dc.w    $23FC, $0088, $D4B8, $00FF, $0002  ; 0088F880: MOVE.L #$0088D4B8,$00FF0002
        dc.w    $4E75                    ; 0088F88A: RTS
        dc.w    $41F8                    ; 0088F88C: dc.w $41F8
        dc.w    $84A2                    ; 0088F88E: dc.w $84A2
        dc.w    $43F8                    ; 0088F890: dc.w $43F8
        dc.w    $84C2                    ; 0088F892: dc.w $84C2
        dc.w    $45F8                    ; 0088F894: dc.w $45F8
        dc.w    $84E2                    ; 0088F896: dc.w $84E2
        dc.w    $4242                    ; 0088F898: dc.w $4242
        dc.w    $323C                    ; 0088F89A: dc.w $323C
        dc.w    $0007                    ; 0088F89C: dc.w $0007
        dc.w    $31BC                    ; 0088F89E: dc.w $31BC
        dc.w    $0000                    ; 0088F8A0: dc.w $0000
        dc.w    $2000                    ; 0088F8A2: dc.w $2000
        dc.w    $33BC                    ; 0088F8A4: dc.w $33BC
        dc.w    $0000                    ; 0088F8A6: dc.w $0000
        dc.w    $2000                    ; 0088F8A8: dc.w $2000
        dc.w    $5442                    ; 0088F8AA: dc.w $5442
        dc.w    $51C9, $FFF0            ; 0088F8AC: DBRA D1,$0088F89E
        dc.w    $41F8                    ; 0088F8B0: dc.w $41F8
        dc.w    $84C2                    ; 0088F8B2: dc.w $84C2
        dc.w    $4A40                    ; 0088F8B4: dc.w $4A40
        dc.w    $6604                    ; 0088F8B6: BNE.S $0088F8BC
        dc.w    $41F8                    ; 0088F8B8: dc.w $41F8
        dc.w    $84A2                    ; 0088F8BA: dc.w $84A2
        dc.w    $47F9, $0088, $F8F6    ; 0088F8BC: LEA $0088F8F6,A3
        dc.w    $7200                    ; 0088F8C2: MOVEQ #$00,D1
        dc.w    $3238                    ; 0088F8C4: dc.w $3238
        dc.w    $A012                    ; 0088F8C6: dc.w $A012
        dc.w    $D241                    ; 0088F8C8: dc.w $D241
        dc.w    $D7C1                    ; 0088F8CA: dc.w $D7C1
        dc.w    $4242                    ; 0088F8CC: dc.w $4242
        dc.w    $323C                    ; 0088F8CE: dc.w $323C
        dc.w    $0007                    ; 0088F8D0: dc.w $0007
        dc.w    $3193                    ; 0088F8D2: dc.w $3193
        dc.w    $2000                    ; 0088F8D4: dc.w $2000
        dc.w    $359B                    ; 0088F8D6: dc.w $359B
        dc.w    $2000                    ; 0088F8D8: dc.w $2000
        dc.w    $5442                    ; 0088F8DA: dc.w $5442
        dc.w    $51C9, $FFF4            ; 0088F8DC: DBRA D1,$0088F8D2
        dc.w    $3238                    ; 0088F8E0: dc.w $3238
        dc.w    $A012                    ; 0088F8E2: dc.w $A012
        dc.w    $5241                    ; 0088F8E4: dc.w $5241
        dc.w    $0C41                    ; 0088F8E6: dc.w $0C41
        dc.w    $0007                    ; 0088F8E8: dc.w $0007
        dc.w    $6F00, $0004            ; 0088F8EA: BLE.W $0088F8F0
        dc.w    $4241                    ; 0088F8EE: dc.w $4241
        dc.w    $31C1                    ; 0088F8F0: dc.w $31C1
        dc.w    $A012                    ; 0088F8F2: dc.w $A012
        dc.w    $4E75                    ; 0088F8F4: RTS
        dc.w    $0EEE                    ; 0088F8F6: dc.w $0EEE
        dc.w    $0EEE                    ; 0088F8F8: dc.w $0EEE
        dc.w    $0EEE                    ; 0088F8FA: dc.w $0EEE
        dc.w    $0EEE                    ; 0088F8FC: dc.w $0EEE
        dc.w    $0000                    ; 0088F8FE: dc.w $0000
        dc.w    $0000                    ; 0088F900: dc.w $0000
        dc.w    $0000                    ; 0088F902: dc.w $0000
        dc.w    $0000                    ; 0088F904: dc.w $0000
        dc.w    $0EEE                    ; 0088F906: dc.w $0EEE
        dc.w    $0EEE                    ; 0088F908: dc.w $0EEE
        dc.w    $0EEE                    ; 0088F90A: dc.w $0EEE
        dc.w    $0EEE                    ; 0088F90C: dc.w $0EEE
        dc.w    $0000                    ; 0088F90E: dc.w $0000
        dc.w    $0000                    ; 0088F910: dc.w $0000
        dc.w    $0000                    ; 0088F912: dc.w $0000
        dc.w    $0000                    ; 0088F914: dc.w $0000
        dc.w    $7000                    ; 0088F916: MOVEQ #$00,D0
        dc.w    $4A38                    ; 0088F918: dc.w $4A38
        dc.w    $A01B                    ; 0088F91A: dc.w $A01B
        dc.w    $6606                    ; 0088F91C: BNE.S $0088F924
        dc.w    $1038                    ; 0088F91E: dc.w $1038
        dc.w    $A019                    ; 0088F920: dc.w $A019
        dc.w    $6004                    ; 0088F922: BRA.S $0088F928
        dc.w    $1038                    ; 0088F924: dc.w $1038
        dc.w    $A01F                    ; 0088F926: dc.w $A01F
        dc.w    $43F9, $0088, $FB24    ; 0088F928: LEA $0088FB24,A1
        dc.w    $D040                    ; 0088F92E: dc.w $D040
        dc.w    $3200                    ; 0088F930: dc.w $3200
        dc.w    $D040                    ; 0088F932: dc.w $D040
        dc.w    $D041                    ; 0088F934: dc.w $D041
        dc.w    $2071                    ; 0088F936: dc.w $2071
        dc.w    $0000                    ; 0088F938: dc.w $0000
        dc.w    $3031                    ; 0088F93A: dc.w $3031
        dc.w    $0004                    ; 0088F93C: dc.w $0004
        dc.w    $323C                    ; 0088F93E: dc.w $323C
        dc.w    $0030                    ; 0088F940: dc.w $0030
        dc.w    $343C                    ; 0088F942: dc.w $343C
        dc.w    $0010                    ; 0088F944: dc.w $0010
        dc.w    $4EBA                    ; 0088F946: dc.w $4EBA
        dc.w    $EA6C                    ; 0088F948: dc.w $EA6C
        dc.w    $7000                    ; 0088F94A: MOVEQ #$00,D0
        dc.w    $0C38                    ; 0088F94C: dc.w $0C38
        dc.w    $0001                    ; 0088F94E: dc.w $0001
        dc.w    $A01B                    ; 0088F950: dc.w $A01B
        dc.w    $6624                    ; 0088F952: BNE.S $0088F978
        dc.w    $207C, $0401, $2024    ; 0088F954: MOVEA.L #$04012024,A0
        dc.w    $303C                    ; 0088F95A: dc.w $303C
        dc.w    $0060                    ; 0088F95C: dc.w $0060
        dc.w    $323C                    ; 0088F95E: dc.w $323C
        dc.w    $0010                    ; 0088F960: dc.w $0010
        dc.w    $343C                    ; 0088F962: dc.w $343C
        dc.w    $0010                    ; 0088F964: dc.w $0010
        dc.w    $4A39                    ; 0088F966: dc.w $4A39
        dc.w    $00A1                    ; 0088F968: dc.w $00A1
        dc.w    $5120                    ; 0088F96A: dc.w $5120
        dc.w    $66F8                    ; 0088F96C: BNE.S $0088F966
        dc.w    $4EBA                    ; 0088F96E: dc.w $4EBA
        dc.w    $EA44                    ; 0088F970: dc.w $EA44
        dc.w    $1038                    ; 0088F972: dc.w $1038
        dc.w    $A019                    ; 0088F974: dc.w $A019
        dc.w    $6004                    ; 0088F976: BRA.S $0088F97C
        dc.w    $1038                    ; 0088F978: dc.w $1038
        dc.w    $A020                    ; 0088F97A: dc.w $A020
        dc.w    $207C, $0401, $4014    ; 0088F97C: MOVEA.L #$04014014,A0
        dc.w    $4A00                    ; 0088F982: dc.w $4A00
        dc.w    $6606                    ; 0088F984: BNE.S $0088F98C
        dc.w    $303C                    ; 0088F986: dc.w $303C
        dc.w    $0048                    ; 0088F988: dc.w $0048
        dc.w    $600A                    ; 0088F98A: BRA.S $0088F996
        dc.w    $D1FC                    ; 0088F98C: dc.w $D1FC
        dc.w    $0000                    ; 0088F98E: dc.w $0000
        dc.w    $0047                    ; 0088F990: dc.w $0047
        dc.w    $303C                    ; 0088F992: dc.w $303C
        dc.w    $0039                    ; 0088F994: dc.w $0039
        dc.w    $323C                    ; 0088F996: dc.w $323C
        dc.w    $0010                    ; 0088F998: dc.w $0010
        dc.w    $343C                    ; 0088F99A: dc.w $343C
        dc.w    $0010                    ; 0088F99C: dc.w $0010
        dc.w    $4A39                    ; 0088F99E: dc.w $4A39
        dc.w    $00A1                    ; 0088F9A0: dc.w $00A1
        dc.w    $5120                    ; 0088F9A2: dc.w $5120
        dc.w    $66F8                    ; 0088F9A4: BNE.S $0088F99E
        dc.w    $4EBA                    ; 0088F9A6: dc.w $4EBA
        dc.w    $EA0C                    ; 0088F9A8: dc.w $EA0C
        dc.w    $7000                    ; 0088F9AA: MOVEQ #$00,D0
        dc.w    $0C38                    ; 0088F9AC: dc.w $0C38
        dc.w    $0002                    ; 0088F9AE: dc.w $0002
        dc.w    $A01B                    ; 0088F9B0: dc.w $A01B
        dc.w    $6642                    ; 0088F9B2: BNE.S $0088F9F6
        dc.w    $207C, $0401, $7030    ; 0088F9B4: MOVEA.L #$04017030,A0
        dc.w    $303C                    ; 0088F9BA: dc.w $303C
        dc.w    $0048                    ; 0088F9BC: dc.w $0048
        dc.w    $323C                    ; 0088F9BE: dc.w $323C
        dc.w    $0010                    ; 0088F9C0: dc.w $0010
        dc.w    $343C                    ; 0088F9C2: dc.w $343C
        dc.w    $0010                    ; 0088F9C4: dc.w $0010
        dc.w    $4A39                    ; 0088F9C6: dc.w $4A39
        dc.w    $00A1                    ; 0088F9C8: dc.w $00A1
        dc.w    $5120                    ; 0088F9CA: dc.w $5120
        dc.w    $66F8                    ; 0088F9CC: BNE.S $0088F9C6
        dc.w    $4EBA                    ; 0088F9CE: dc.w $4EBA
        dc.w    $E9E4                    ; 0088F9D0: dc.w $E9E4
        dc.w    $207C, $0401, $9018    ; 0088F9D2: MOVEA.L #$04019018,A0
        dc.w    $303C                    ; 0088F9D8: dc.w $303C
        dc.w    $0078                    ; 0088F9DA: dc.w $0078
        dc.w    $323C                    ; 0088F9DC: dc.w $323C
        dc.w    $0010                    ; 0088F9DE: dc.w $0010
        dc.w    $343C                    ; 0088F9E0: dc.w $343C
        dc.w    $0010                    ; 0088F9E2: dc.w $0010
        dc.w    $4A39                    ; 0088F9E4: dc.w $4A39
        dc.w    $00A1                    ; 0088F9E6: dc.w $00A1
        dc.w    $5120                    ; 0088F9E8: dc.w $5120
        dc.w    $66F8                    ; 0088F9EA: BNE.S $0088F9E4
        dc.w    $4EBA                    ; 0088F9EC: dc.w $4EBA
        dc.w    $E9C6                    ; 0088F9EE: dc.w $E9C6
        dc.w    $1038                    ; 0088F9F0: dc.w $1038
        dc.w    $A019                    ; 0088F9F2: dc.w $A019
        dc.w    $6004                    ; 0088F9F4: BRA.S $0088F9FA
        dc.w    $1038                    ; 0088F9F6: dc.w $1038
        dc.w    $A021                    ; 0088F9F8: dc.w $A021
        dc.w    $1400                    ; 0088F9FA: dc.w $1400
        dc.w    $207C, $0401, $B018    ; 0088F9FC: MOVEA.L #$0401B018,A0
        dc.w    $D040                    ; 0088FA02: dc.w $D040
        dc.w    $D040                    ; 0088FA04: dc.w $D040
        dc.w    $D040                    ; 0088FA06: dc.w $D040
        dc.w    $3200                    ; 0088FA08: dc.w $3200
        dc.w    $D040                    ; 0088FA0A: dc.w $D040
        dc.w    $D041                    ; 0088FA0C: dc.w $D041
        dc.w    $41F0                    ; 0088FA0E: dc.w $41F0
        dc.w    $0000                    ; 0088FA10: dc.w $0000
        dc.w    $303C                    ; 0088FA12: dc.w $303C
        dc.w    $0018                    ; 0088FA14: dc.w $0018
        dc.w    $4A02                    ; 0088FA16: dc.w $4A02
        dc.w    $6700, $0008            ; 0088FA18: BEQ.W $0088FA22
        dc.w    $5388                    ; 0088FA1C: dc.w $5388
        dc.w    $303C                    ; 0088FA1E: dc.w $303C
        dc.w    $0019                    ; 0088FA20: dc.w $0019
        dc.w    $323C                    ; 0088FA22: dc.w $323C
        dc.w    $0010                    ; 0088FA24: dc.w $0010
        dc.w    $343C                    ; 0088FA26: dc.w $343C
        dc.w    $0010                    ; 0088FA28: dc.w $0010
        dc.w    $4A39                    ; 0088FA2A: dc.w $4A39
        dc.w    $00A1                    ; 0088FA2C: dc.w $00A1
        dc.w    $5120                    ; 0088FA2E: dc.w $5120
        dc.w    $66F8                    ; 0088FA30: BNE.S $0088FA2A
        dc.w    $4EBA                    ; 0088FA32: dc.w $4EBA
        dc.w    $E980                    ; 0088FA34: dc.w $E980
        dc.w    $7000                    ; 0088FA36: MOVEQ #$00,D0
        dc.w    $0C38                    ; 0088FA38: dc.w $0C38
        dc.w    $0001                    ; 0088FA3A: dc.w $0001
        dc.w    $A01C                    ; 0088FA3C: dc.w $A01C
        dc.w    $6624                    ; 0088FA3E: BNE.S $0088FA64
        dc.w    $207C, $0401, $20BC    ; 0088FA40: MOVEA.L #$040120BC,A0
        dc.w    $303C                    ; 0088FA46: dc.w $303C
        dc.w    $0060                    ; 0088FA48: dc.w $0060
        dc.w    $323C                    ; 0088FA4A: dc.w $323C
        dc.w    $0010                    ; 0088FA4C: dc.w $0010
        dc.w    $343C                    ; 0088FA4E: dc.w $343C
        dc.w    $0010                    ; 0088FA50: dc.w $0010
        dc.w    $4A39                    ; 0088FA52: dc.w $4A39
        dc.w    $00A1                    ; 0088FA54: dc.w $00A1
        dc.w    $5120                    ; 0088FA56: dc.w $5120
        dc.w    $66F8                    ; 0088FA58: BNE.S $0088FA52
        dc.w    $4EBA                    ; 0088FA5A: dc.w $4EBA
        dc.w    $E958                    ; 0088FA5C: dc.w $E958
        dc.w    $1038                    ; 0088FA5E: dc.w $1038
        dc.w    $A01A                    ; 0088FA60: dc.w $A01A
        dc.w    $6004                    ; 0088FA62: BRA.S $0088FA68
        dc.w    $1038                    ; 0088FA64: dc.w $1038
        dc.w    $A022                    ; 0088FA66: dc.w $A022
        dc.w    $207C, $0401, $40AC    ; 0088FA68: MOVEA.L #$040140AC,A0
        dc.w    $4A00                    ; 0088FA6E: dc.w $4A00
        dc.w    $6606                    ; 0088FA70: BNE.S $0088FA78
        dc.w    $303C                    ; 0088FA72: dc.w $303C
        dc.w    $0048                    ; 0088FA74: dc.w $0048
        dc.w    $600A                    ; 0088FA76: BRA.S $0088FA82
        dc.w    $D1FC                    ; 0088FA78: dc.w $D1FC
        dc.w    $0000                    ; 0088FA7A: dc.w $0000
        dc.w    $0047                    ; 0088FA7C: dc.w $0047
        dc.w    $303C                    ; 0088FA7E: dc.w $303C
        dc.w    $0039                    ; 0088FA80: dc.w $0039
        dc.w    $323C                    ; 0088FA82: dc.w $323C
        dc.w    $0010                    ; 0088FA84: dc.w $0010
        dc.w    $343C                    ; 0088FA86: dc.w $343C
        dc.w    $0010                    ; 0088FA88: dc.w $0010
        dc.w    $4A39                    ; 0088FA8A: dc.w $4A39
        dc.w    $00A1                    ; 0088FA8C: dc.w $00A1
        dc.w    $5120                    ; 0088FA8E: dc.w $5120
        dc.w    $66F8                    ; 0088FA90: BNE.S $0088FA8A
        dc.w    $4EBA                    ; 0088FA92: dc.w $4EBA
        dc.w    $E920                    ; 0088FA94: dc.w $E920
        dc.w    $7000                    ; 0088FA96: MOVEQ #$00,D0
        dc.w    $0C38                    ; 0088FA98: dc.w $0C38
        dc.w    $0002                    ; 0088FA9A: dc.w $0002
        dc.w    $A01C                    ; 0088FA9C: dc.w $A01C
        dc.w    $6642                    ; 0088FA9E: BNE.S $0088FAE2
        dc.w    $207C, $0401, $70C8    ; 0088FAA0: MOVEA.L #$040170C8,A0
        dc.w    $303C                    ; 0088FAA6: dc.w $303C
        dc.w    $0048                    ; 0088FAA8: dc.w $0048
        dc.w    $323C                    ; 0088FAAA: dc.w $323C
        dc.w    $0010                    ; 0088FAAC: dc.w $0010
        dc.w    $343C                    ; 0088FAAE: dc.w $343C
        dc.w    $0010                    ; 0088FAB0: dc.w $0010
        dc.w    $4A39                    ; 0088FAB2: dc.w $4A39
        dc.w    $00A1                    ; 0088FAB4: dc.w $00A1
        dc.w    $5120                    ; 0088FAB6: dc.w $5120
        dc.w    $66F8                    ; 0088FAB8: BNE.S $0088FAB2
        dc.w    $4EBA                    ; 0088FABA: dc.w $4EBA
        dc.w    $E8F8                    ; 0088FABC: dc.w $E8F8
        dc.w    $207C, $0401, $90B0    ; 0088FABE: MOVEA.L #$040190B0,A0
        dc.w    $303C                    ; 0088FAC4: dc.w $303C
        dc.w    $0078                    ; 0088FAC6: dc.w $0078
        dc.w    $323C                    ; 0088FAC8: dc.w $323C
        dc.w    $0010                    ; 0088FACA: dc.w $0010
        dc.w    $343C                    ; 0088FACC: dc.w $343C
        dc.w    $0010                    ; 0088FACE: dc.w $0010
        dc.w    $4A39                    ; 0088FAD0: dc.w $4A39
        dc.w    $00A1                    ; 0088FAD2: dc.w $00A1
        dc.w    $5120                    ; 0088FAD4: dc.w $5120
        dc.w    $66F8                    ; 0088FAD6: BNE.S $0088FAD0
        dc.w    $4EBA                    ; 0088FAD8: dc.w $4EBA
        dc.w    $E8DA                    ; 0088FADA: dc.w $E8DA
        dc.w    $1038                    ; 0088FADC: dc.w $1038
        dc.w    $A01A                    ; 0088FADE: dc.w $A01A
        dc.w    $6004                    ; 0088FAE0: BRA.S $0088FAE6
        dc.w    $1038                    ; 0088FAE2: dc.w $1038
        dc.w    $A023                    ; 0088FAE4: dc.w $A023
        dc.w    $1400                    ; 0088FAE6: dc.w $1400
        dc.w    $207C, $0401, $B0B0    ; 0088FAE8: MOVEA.L #$0401B0B0,A0
        dc.w    $D040                    ; 0088FAEE: dc.w $D040
        dc.w    $D040                    ; 0088FAF0: dc.w $D040
        dc.w    $D040                    ; 0088FAF2: dc.w $D040
        dc.w    $3200                    ; 0088FAF4: dc.w $3200
        dc.w    $D040                    ; 0088FAF6: dc.w $D040
        dc.w    $D041                    ; 0088FAF8: dc.w $D041
        dc.w    $41F0                    ; 0088FAFA: dc.w $41F0
        dc.w    $0000                    ; 0088FAFC: dc.w $0000
        dc.w    $303C                    ; 0088FAFE: dc.w $303C
        dc.w    $0018                    ; 0088FB00: dc.w $0018
        dc.w    $4A02                    ; 0088FB02: dc.w $4A02
        dc.w    $6700, $0008            ; 0088FB04: BEQ.W $0088FB0E
        dc.w    $5388                    ; 0088FB08: dc.w $5388
        dc.w    $303C                    ; 0088FB0A: dc.w $303C
        dc.w    $0019                    ; 0088FB0C: dc.w $0019
        dc.w    $323C                    ; 0088FB0E: dc.w $323C
        dc.w    $0010                    ; 0088FB10: dc.w $0010
        dc.w    $343C                    ; 0088FB12: dc.w $343C
        dc.w    $0010                    ; 0088FB14: dc.w $0010
        dc.w    $4A39                    ; 0088FB16: dc.w $4A39
        dc.w    $00A1                    ; 0088FB18: dc.w $00A1
        dc.w    $5120                    ; 0088FB1A: dc.w $5120
        dc.w    $66F8                    ; 0088FB1C: BNE.S $0088FB16
        dc.w    $4EBA                    ; 0088FB1E: dc.w $4EBA
        dc.w    $E894                    ; 0088FB20: dc.w $E894
        dc.w    $4E75                    ; 0088FB22: RTS
        dc.w    $0400                    ; 0088FB24: dc.w $0400
        dc.w    $7010                    ; 0088FB26: MOVEQ #$10,D0
        dc.w    $0060                    ; 0088FB28: dc.w $0060
        dc.w    $0400                    ; 0088FB2A: dc.w $0400
        dc.w    $706F                    ; 0088FB2C: MOVEQ #$6F,D0
        dc.w    $0061                    ; 0088FB2E: dc.w $0061
        dc.w    $0400                    ; 0088FB30: dc.w $0400
        dc.w    $70CF                    ; 0088FB32: MOVEQ #$CF,D0
        dc.w    $0061                    ; 0088FB34: dc.w $0061

; ============================================================================
; SendDREQCommand - Send DMA Request to SH2
; ============================================================================
; Sends a DMA request command to the SH2 CPU via MARS COMM registers.
; Initializes DMA parameters and waits for completion. This is the primary
; interface for requesting DMA operations from 68K to SH2.
;
; Used by: Frame buffer operations, sprite transfers, graphics uploads
; Called by: SetDisplayParams, other graphics functions (17 calls total)
;
; MARS Register Map:
;   $00A15120 - COMM0 (REN/SH2 ready)
;   $00A15107 - DREQ Control Register
;   $00A15110 - DREQ Length Register
;   $00A15121 - COMM1 (DMA parameters)
;   $00A15123 - COMM4 (status/control)
;
; Notes:
;   - Waits for SH2 to be ready before sending request
;   - Configures DMA length ($001C bytes typical)
;   - Sets control bits for DMA operation
;   - Polls DREQ busy flag before transfer
;   - Includes loop to wait for completion
; ============================================================================
SendDREQCommand:
.wait_ready:
        tst.l   ($00A15120).l            ; 0088FB36: Wait for COMM0 ready
        bne.s   .wait_ready              ; 0088FB3C: Loop if busy
        move.w  #$001C,($00A15110).w     ; 0088FB3E: Set DREQ length
        move.b  #$04,($00A15107).w       ; 0088FB44: Set DREQ control
        clr.w   ($00A15123).w            ; 0088FB4A: Clear COMM4 status
        move.b  #$2D,($00A15121).w       ; 0088FB50: Set COMM1 params
        move.b  #$01,($00A15120).w       ; 0088FB56: Set COMM0 trigger
.wait_busy:
        btst    #$01,($00A15123).w       ; 0088FB5C: Test COMM4 busy bit
        beq.s   .wait_busy               ; 0088FB62: Loop if busy
        bset    #$01,($00A15123).w       ; 0088FB64: Set status bit
        lea     ($00FF60C8).l,a1         ; 0088FB6A: Load frame buffer addr
        lea     ($00A15112).l,a2         ; 0088FB70: Load DREQ addr
        move.w  #$001B,d7                ; 0088FB76: Init loop counter
.transfer_loop:
        btst    #$07,($00A15107).w       ; 0088FB7A: Check busy flag
        bne.s   .transfer_loop           ; 0088FB80: Loop if still busy
        move.w  (a2),d3                  ; 0088FB82: Read from DMA source
        dbra    d7,.transfer_loop        ; 0088FB86: Loop 27 times
        rts                              ; 0088FB8A: Return
        dc.w    $33FC                    ; 0088FB98: dc.w $33FC
        dc.w    $002C                    ; 0088FB9A: dc.w $002C
        dc.w    $00FF                    ; 0088FB9C: dc.w $00FF
        dc.w    $0008                    ; 0088FB9E: dc.w $0008
        dc.w    $31FC                    ; 0088FBA0: dc.w $31FC
        dc.w    $002C                    ; 0088FBA2: dc.w $002C
        dc.w    $C87A                    ; 0088FBA4: dc.w $C87A
        dc.w    $08B8                    ; 0088FBA6: dc.w $08B8
        dc.w    $0006                    ; 0088FBA8: dc.w $0006
        dc.w    $C875                    ; 0088FBAA: dc.w $C875
        dc.w    $3AB8                    ; 0088FBAC: dc.w $3AB8
        dc.w    $C874                    ; 0088FBAE: dc.w $C874
        dc.w    $33FC                    ; 0088FBB0: dc.w $33FC
        dc.w    $0083                    ; 0088FBB2: dc.w $0083
        dc.w    $00A1                    ; 0088FBB4: dc.w $00A1
        dc.w    $5100                    ; 0088FBB6: dc.w $5100
        dc.w    $0239                    ; 0088FBB8: dc.w $0239
        dc.w    $00FC                    ; 0088FBBA: dc.w $00FC
        dc.w    $00A1                    ; 0088FBBC: dc.w $00A1
        dc.w    $5181                    ; 0088FBBE: dc.w $5181
        dc.w    $4EB9, $0088, $26C8    ; 0088FBC0: JSR $008826C8
        dc.w    $203C                    ; 0088FBC6: dc.w $203C
        dc.w    $000A                    ; 0088FBC8: dc.w $000A
        dc.w    $0907                    ; 0088FBCA: dc.w $0907
        dc.w    $4EB9, $0088, $14BE    ; 0088FBCC: JSR $008814BE
        dc.w    $11FC                    ; 0088FBD2: dc.w $11FC
        dc.w    $0001                    ; 0088FBD4: dc.w $0001
        dc.w    $C80D                    ; 0088FBD6: dc.w $C80D
        dc.w    $31FC                    ; 0088FBD8: dc.w $31FC
        dc.w    $0000                    ; 0088FBDA: dc.w $0000
        dc.w    $A014                    ; 0088FBDC: dc.w $A014
        dc.w    $0838                    ; 0088FBDE: dc.w $0838
        dc.w    $0004                    ; 0088FBE0: dc.w $0004
        dc.w    $C80E                    ; 0088FBE2: dc.w $C80E
        dc.w    $6600, $017E            ; 0088FBE4: BNE.W $0088FD64
        dc.w    $0838                    ; 0088FBE8: dc.w $0838
        dc.w    $0005                    ; 0088FBEA: dc.w $0005
        dc.w    $C80E                    ; 0088FBEC: dc.w $C80E
        dc.w    $6600, $0174            ; 0088FBEE: BNE.W $0088FD64
        dc.w    $0838                    ; 0088FBF2: dc.w $0838
        dc.w    $0007                    ; 0088FBF4: dc.w $0007
        dc.w    $FDA8                    ; 0088FBF6: dc.w $FDA8
        dc.w    $6600, $016A            ; 0088FBF8: BNE.W $0088FD64
        dc.w    $2038                    ; 0088FBFC: dc.w $2038
        dc.w    $C260                    ; 0088FBFE: dc.w $C260
        dc.w    $0C80                    ; 0088FC00: dc.w $0C80
        dc.w    $6000, $0000            ; 0088FC02: BRA.W $0088FC04
        dc.w    $6C00, $00D6            ; 0088FC06: BGE.W $0088FCDE
        dc.w    $11FC                    ; 0088FC0A: dc.w $11FC
        dc.w    $0000                    ; 0088FC0C: dc.w $0000
        dc.w    $A021                    ; 0088FC0E: dc.w $A021
        dc.w    $3038                    ; 0088FC10: dc.w $3038
        dc.w    $C0A2                    ; 0088FC12: dc.w $C0A2
        dc.w    $3238                    ; 0088FC14: dc.w $3238
        dc.w    $C0A4                    ; 0088FC16: dc.w $C0A4
        dc.w    $B240                    ; 0088FC18: dc.w $B240
        dc.w    $6500, $000A            ; 0088FC1A: BCS.W $0088FC26
        dc.w    $11FC                    ; 0088FC1E: dc.w $11FC
        dc.w    $0001                    ; 0088FC20: dc.w $0001
        dc.w    $A021                    ; 0088FC22: dc.w $A021
        dc.w    $3001                    ; 0088FC24: dc.w $3001
        dc.w    $3238                    ; 0088FC26: dc.w $3238
        dc.w    $C0A6                    ; 0088FC28: dc.w $C0A6
        dc.w    $B240                    ; 0088FC2A: dc.w $B240
        dc.w    $6500, $000A            ; 0088FC2C: BCS.W $0088FC38
        dc.w    $11FC                    ; 0088FC30: dc.w $11FC
        dc.w    $0002                    ; 0088FC32: dc.w $0002
        dc.w    $A021                    ; 0088FC34: dc.w $A021
        dc.w    $3001                    ; 0088FC36: dc.w $3001
        dc.w    $3238                    ; 0088FC38: dc.w $3238
        dc.w    $C0A8                    ; 0088FC3A: dc.w $C0A8
        dc.w    $B240                    ; 0088FC3C: dc.w $B240
        dc.w    $6500, $0008            ; 0088FC3E: BCS.W $0088FC48
        dc.w    $11FC                    ; 0088FC42: dc.w $11FC
        dc.w    $0003                    ; 0088FC44: dc.w $0003
        dc.w    $A021                    ; 0088FC46: dc.w $A021
        dc.w    $7000                    ; 0088FC48: MOVEQ #$00,D0
        dc.w    $7200                    ; 0088FC4A: MOVEQ #$00,D1
        dc.w    $1038                    ; 0088FC4C: dc.w $1038
        dc.w    $FEB1                    ; 0088FC4E: dc.w $FEB1
        dc.w    $670C                    ; 0088FC50: BEQ.S $0088FC5E
        dc.w    $5340                    ; 0088FC52: dc.w $5340
        dc.w    $0681                    ; 0088FC54: dc.w $0681
        dc.w    $0000                    ; 0088FC56: dc.w $0000
        dc.w    $03C0                    ; 0088FC58: dc.w $03C0
        dc.w    $51C8, $FFF8            ; 0088FC5A: DBRA D0,$0088FC54
        dc.w    $41F8                    ; 0088FC5E: dc.w $41F8
        dc.w    $EF08                    ; 0088FC60: dc.w $EF08
        dc.w    $D1C1                    ; 0088FC62: dc.w $D1C1
        dc.w    $7000                    ; 0088FC64: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088FC66: dc.w $1038
        dc.w    $FEA5                    ; 0088FC68: dc.w $FEA5
        dc.w    $D040                    ; 0088FC6A: dc.w $D040
        dc.w    $D040                    ; 0088FC6C: dc.w $D040
        dc.w    $D040                    ; 0088FC6E: dc.w $D040
        dc.w    $D040                    ; 0088FC70: dc.w $D040
        dc.w    $3200                    ; 0088FC72: dc.w $3200
        dc.w    $D040                    ; 0088FC74: dc.w $D040
        dc.w    $D040                    ; 0088FC76: dc.w $D040
        dc.w    $D041                    ; 0088FC78: dc.w $D041
        dc.w    $D040                    ; 0088FC7A: dc.w $D040
        dc.w    $D1C0                    ; 0088FC7C: dc.w $D1C0
        dc.w    $2038                    ; 0088FC7E: dc.w $2038
        dc.w    $C260                    ; 0088FC80: dc.w $C260
        dc.w    $B0A8                    ; 0088FC82: dc.w $B0A8
        dc.w    $009C                    ; 0088FC84: dc.w $009C
        dc.w    $6200, $0056            ; 0088FC86: BHI.W $0088FCDE
        dc.w    $7200                    ; 0088FC8A: MOVEQ #$00,D1
        dc.w    $343C                    ; 0088FC8C: dc.w $343C
        dc.w    $0013                    ; 0088FC8E: dc.w $0013
        dc.w    $1A38                    ; 0088FC90: dc.w $1A38
        dc.w    $A021                    ; 0088FC92: dc.w $A021
        dc.w    $B0B0                    ; 0088FC94: dc.w $B0B0
        dc.w    $1004                    ; 0088FC96: dc.w $1004
        dc.w    $6500, $000C            ; 0088FC98: BCS.W $0088FCA6
        dc.w    $5041                    ; 0088FC9C: dc.w $5041
        dc.w    $51CA, $FFF4            ; 0088FC9E: DBRA D2,$0088FC94
        dc.w    $6000, $003A            ; 0088FCA2: BRA.W $0088FCDE
        dc.w    $11FC                    ; 0088FCA6: dc.w $11FC
        dc.w    $0001                    ; 0088FCA8: dc.w $0001
        dc.w    $A014                    ; 0088FCAA: dc.w $A014
        dc.w    $363C                    ; 0088FCAC: dc.w $363C
        dc.w    $0013                    ; 0088FCAE: dc.w $0013
        dc.w    $9642                    ; 0088FCB0: dc.w $9642
        dc.w    $31C3                    ; 0088FCB2: dc.w $31C3
        dc.w    $A022                    ; 0088FCB4: dc.w $A022
        dc.w    $21C8                    ; 0088FCB6: dc.w $21C8
        dc.w    $A018                    ; 0088FCB8: dc.w $A018
        dc.w    $0281                    ; 0088FCBA: dc.w $0281
        dc.w    $0000                    ; 0088FCBC: dc.w $0000
        dc.w    $FFFF                    ; 0088FCBE: dc.w $FFFF
        dc.w    $D3B8                    ; 0088FCC0: dc.w $D3B8
        dc.w    $A018                    ; 0088FCC2: dc.w $A018
        dc.w    $2630                    ; 0088FCC4: dc.w $2630
        dc.w    $1000                    ; 0088FCC6: dc.w $1000
        dc.w    $2830                    ; 0088FCC8: dc.w $2830
        dc.w    $1004                    ; 0088FCCA: dc.w $1004
        dc.w    $2185                    ; 0088FCCC: dc.w $2185
        dc.w    $1000                    ; 0088FCCE: dc.w $1000
        dc.w    $2180                    ; 0088FCD0: dc.w $2180
        dc.w    $1004                    ; 0088FCD2: dc.w $1004
        dc.w    $2004                    ; 0088FCD4: dc.w $2004
        dc.w    $2A03                    ; 0088FCD6: dc.w $2A03
        dc.w    $5041                    ; 0088FCD8: dc.w $5041
        dc.w    $51CA, $FFE8            ; 0088FCDA: DBRA D2,$0088FCC4
        dc.w    $41F8                    ; 0088FCDE: dc.w $41F8
        dc.w    $C200                    ; 0088FCE0: dc.w $C200
        dc.w    $203C                    ; 0088FCE2: dc.w $203C
        dc.w    $6000, $0000            ; 0088FCE4: BRA.W $0088FCE6
        dc.w    $363C                    ; 0088FCE8: dc.w $363C
        dc.w    $0013                    ; 0088FCEA: dc.w $0013
        dc.w    $2218                    ; 0088FCEC: dc.w $2218
        dc.w    $6706                    ; 0088FCEE: BEQ.S $0088FCF6
        dc.w    $B081                    ; 0088FCF0: dc.w $B081
        dc.w    $6F02                    ; 0088FCF2: BLE.S $0088FCF6
        dc.w    $2001                    ; 0088FCF4: dc.w $2001
        dc.w    $0682                    ; 0088FCF6: dc.w $0682
        dc.w    $0000                    ; 0088FCF8: dc.w $0000
        dc.w    $0D80                    ; 0088FCFA: dc.w $0D80
        dc.w    $51CB, $FFEE            ; 0088FCFC: DBRA D3,$0088FCEC
        dc.w    $2400                    ; 0088FD00: dc.w $2400
        dc.w    $41F8                    ; 0088FD02: dc.w $41F8
        dc.w    $FA48                    ; 0088FD04: dc.w $FA48
        dc.w    $7000                    ; 0088FD06: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088FD08: dc.w $1038
        dc.w    $FEB1                    ; 0088FD0A: dc.w $FEB1
        dc.w    $D040                    ; 0088FD0C: dc.w $D040
        dc.w    $D040                    ; 0088FD0E: dc.w $D040
        dc.w    $D040                    ; 0088FD10: dc.w $D040
        dc.w    $3200                    ; 0088FD12: dc.w $3200
        dc.w    $D040                    ; 0088FD14: dc.w $D040
        dc.w    $D041                    ; 0088FD16: dc.w $D041
        dc.w    $D040                    ; 0088FD18: dc.w $D040
        dc.w    $D1C0                    ; 0088FD1A: dc.w $D1C0
        dc.w    $7000                    ; 0088FD1C: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088FD1E: dc.w $1038
        dc.w    $FEA5                    ; 0088FD20: dc.w $FEA5
        dc.w    $D040                    ; 0088FD22: dc.w $D040
        dc.w    $D040                    ; 0088FD24: dc.w $D040
        dc.w    $D040                    ; 0088FD26: dc.w $D040
        dc.w    $5840                    ; 0088FD28: dc.w $5840
        dc.w    $B4B0                    ; 0088FD2A: dc.w $B4B0
        dc.w    $0000                    ; 0088FD2C: dc.w $0000
        dc.w    $6200, $001C            ; 0088FD2E: BHI.W $0088FD4C
        dc.w    $5438                    ; 0088FD32: dc.w $5438
        dc.w    $A014                    ; 0088FD34: dc.w $A014
        dc.w    $21C8                    ; 0088FD36: dc.w $21C8
        dc.w    $A01C                    ; 0088FD38: dc.w $A01C
        dc.w    $0280                    ; 0088FD3A: dc.w $0280
        dc.w    $0000                    ; 0088FD3C: dc.w $0000
        dc.w    $FFFF                    ; 0088FD3E: dc.w $FFFF
        dc.w    $D1B8                    ; 0088FD40: dc.w $D1B8
        dc.w    $A01C                    ; 0088FD42: dc.w $A01C
        dc.w    $59B8                    ; 0088FD44: dc.w $59B8
        dc.w    $A01C                    ; 0088FD46: dc.w $A01C
        dc.w    $2182                    ; 0088FD48: dc.w $2182
        dc.w    $0000                    ; 0088FD4A: dc.w $0000
        dc.w    $21F8                    ; 0088FD4C: dc.w $21F8
        dc.w    $C260                    ; 0088FD4E: dc.w $C260
        dc.w    $A032                    ; 0088FD50: dc.w $A032
        dc.w    $2038                    ; 0088FD52: dc.w $2038
        dc.w    $C260                    ; 0088FD54: dc.w $C260
        dc.w    $0C80                    ; 0088FD56: dc.w $0C80
        dc.w    $6000, $0000            ; 0088FD58: BRA.W $0088FD5A
        dc.w    $6C00, $0006            ; 0088FD5C: BGE.W $0088FD64
        dc.w    $6000, $00A2            ; 0088FD60: BRA.W $0088FE04
        dc.w    $41F8                    ; 0088FD64: dc.w $41F8
        dc.w    $C200                    ; 0088FD66: dc.w $C200
        dc.w    $303C                    ; 0088FD68: dc.w $303C
        dc.w    $0013                    ; 0088FD6A: dc.w $0013
        dc.w    $4A90                    ; 0088FD6C: dc.w $4A90
        dc.w    $6700, $0008            ; 0088FD6E: BEQ.W $0088FD78
        dc.w    $5888                    ; 0088FD72: dc.w $5888
        dc.w    $51C8, $FFF6            ; 0088FD74: DBRA D0,$0088FD6C
        dc.w    $42B8                    ; 0088FD78: dc.w $42B8
        dc.w    $A032                    ; 0088FD7A: dc.w $A032
        dc.w    $41F8                    ; 0088FD7C: dc.w $41F8
        dc.w    $A032                    ; 0088FD7E: dc.w $A032
        dc.w    $43F8                    ; 0088FD80: dc.w $43F8
        dc.w    $C200                    ; 0088FD82: dc.w $C200
        dc.w    $343C                    ; 0088FD84: dc.w $343C
        dc.w    $0013                    ; 0088FD86: dc.w $0013
        dc.w    $0600                    ; 0088FD88: dc.w $0600
        dc.w    $0000                    ; 0088FD8A: dc.w $0000
        dc.w    $1028                    ; 0088FD8C: dc.w $1028
        dc.w    $0003                    ; 0088FD8E: dc.w $0003
        dc.w    $1229                    ; 0088FD90: dc.w $1229
        dc.w    $0003                    ; 0088FD92: dc.w $0003
        dc.w    $C101                    ; 0088FD94: dc.w $C101
        dc.w    $1140                    ; 0088FD96: dc.w $1140
        dc.w    $0003                    ; 0088FD98: dc.w $0003
        dc.w    $1028                    ; 0088FD9A: dc.w $1028
        dc.w    $0002                    ; 0088FD9C: dc.w $0002
        dc.w    $1229                    ; 0088FD9E: dc.w $1229
        dc.w    $0002                    ; 0088FDA0: dc.w $0002
        dc.w    $C101                    ; 0088FDA2: dc.w $C101
        dc.w    $1200                    ; 0088FDA4: dc.w $1200
        dc.w    $0200                    ; 0088FDA6: dc.w $0200
        dc.w    $000F                    ; 0088FDA8: dc.w $000F
        dc.w    $1140                    ; 0088FDAA: dc.w $1140
        dc.w    $0002                    ; 0088FDAC: dc.w $0002
        dc.w    $E809                    ; 0088FDAE: dc.w $E809
        dc.w    $0600                    ; 0088FDB0: dc.w $0600
        dc.w    $0000                    ; 0088FDB2: dc.w $0000
        dc.w    $1028                    ; 0088FDB4: dc.w $1028
        dc.w    $0001                    ; 0088FDB6: dc.w $0001
        dc.w    $C101                    ; 0088FDB8: dc.w $C101
        dc.w    $1229                    ; 0088FDBA: dc.w $1229
        dc.w    $0001                    ; 0088FDBC: dc.w $0001
        dc.w    $C101                    ; 0088FDBE: dc.w $C101
        dc.w    $6400, $0012            ; 0088FDC0: BCC.W $0088FDD4
        dc.w    $0600                    ; 0088FDC4: dc.w $0600
        dc.w    $0000                    ; 0088FDC6: dc.w $0000
        dc.w    $123C                    ; 0088FDC8: dc.w $123C
        dc.w    $0040                    ; 0088FDCA: dc.w $0040
        dc.w    $C101                    ; 0088FDCC: dc.w $C101
        dc.w    $123C                    ; 0088FDCE: dc.w $123C
        dc.w    $0001                    ; 0088FDD0: dc.w $0001
        dc.w    $6018                    ; 0088FDD2: BRA.S $0088FDEC
        dc.w    $4201                    ; 0088FDD4: dc.w $4201
        dc.w    $0C00                    ; 0088FDD6: dc.w $0C00
        dc.w    $0060                    ; 0088FDD8: dc.w $0060
        dc.w    $6500, $0010            ; 0088FDDA: BCS.W $0088FDEC
        dc.w    $0600                    ; 0088FDDE: dc.w $0600
        dc.w    $0000                    ; 0088FDE0: dc.w $0000
        dc.w    $123C                    ; 0088FDE2: dc.w $123C
        dc.w    $0060                    ; 0088FDE4: dc.w $0060
        dc.w    $8101                    ; 0088FDE6: dc.w $8101
        dc.w    $123C                    ; 0088FDE8: dc.w $123C
        dc.w    $0001                    ; 0088FDEA: dc.w $0001
        dc.w    $1140                    ; 0088FDEC: dc.w $1140
        dc.w    $0001                    ; 0088FDEE: dc.w $0001
        dc.w    $0600                    ; 0088FDF0: dc.w $0600
        dc.w    $0000                    ; 0088FDF2: dc.w $0000
        dc.w    $1010                    ; 0088FDF4: dc.w $1010
        dc.w    $C101                    ; 0088FDF6: dc.w $C101
        dc.w    $1211                    ; 0088FDF8: dc.w $1211
        dc.w    $C101                    ; 0088FDFA: dc.w $C101
        dc.w    $1080                    ; 0088FDFC: dc.w $1080
        dc.w    $5889                    ; 0088FDFE: dc.w $5889
        dc.w    $51CA, $FF86            ; 0088FE00: DBRA D2,$0088FD88
        dc.w    $4A38                    ; 0088FE04: dc.w $4A38
        dc.w    $A014                    ; 0088FE06: dc.w $A014
        dc.w    $6600, $0024            ; 0088FE08: BNE.W $0088FE2E
        dc.w    $31FC                    ; 0088FE0C: dc.w $31FC
        dc.w    $0000                    ; 0088FE0E: dc.w $0000
        dc.w    $C87E                    ; 0088FE10: dc.w $C87E
        dc.w    $33FC                    ; 0088FE12: dc.w $33FC
        dc.w    $0020                    ; 0088FE14: dc.w $0020
        dc.w    $00FF                    ; 0088FE16: dc.w $00FF
        dc.w    $0008                    ; 0088FE18: dc.w $0008
        dc.w    $23FC, $0089, $09AE, $00FF, $0002  ; 0088FE1A: MOVE.L #$008909AE,$00FF0002
        dc.w    $4239                    ; 0088FE24: dc.w $4239
        dc.w    $00A1                    ; 0088FE26: dc.w $00A1
        dc.w    $5123                    ; 0088FE28: dc.w $5123
        dc.w    $6000, $0256            ; 0088FE2A: BRA.W $00890082
        dc.w    $7000                    ; 0088FE2E: MOVEQ #$00,D0
        dc.w    $41F8                    ; 0088FE30: dc.w $41F8
        dc.w    $8480                    ; 0088FE32: dc.w $8480
        dc.w    $721F                    ; 0088FE34: MOVEQ #$1F,D1
        dc.w    $20C0                    ; 0088FE36: dc.w $20C0
        dc.w    $51C9, $FFFC            ; 0088FE38: DBRA D1,$0088FE36
        dc.w    $41F9, $00FF, $7B80    ; 0088FE3C: LEA $00FF7B80,A0
        dc.w    $727F                    ; 0088FE42: MOVEQ #$7F,D1
        dc.w    $20C0                    ; 0088FE44: dc.w $20C0
        dc.w    $51C9, $FFFC            ; 0088FE46: DBRA D1,$0088FE44
        dc.w    $2ABC                    ; 0088FE4A: dc.w $2ABC
        dc.w    $6000, $0002            ; 0088FE4C: BRA.W $0088FE50
        dc.w    $323C                    ; 0088FE50: dc.w $323C
        dc.w    $17FF                    ; 0088FE52: dc.w $17FF
        dc.w    $2C80                    ; 0088FE54: dc.w $2C80
        dc.w    $51C9, $FFFC            ; 0088FE56: DBRA D1,$0088FE54
        dc.w    $4EB9, $0088, $49AA    ; 0088FE5A: JSR $008849AA
        dc.w    $4278                    ; 0088FE60: dc.w $4278
        dc.w    $C880                    ; 0088FE62: dc.w $C880
        dc.w    $4278                    ; 0088FE64: dc.w $4278
        dc.w    $C882                    ; 0088FE66: dc.w $C882
        dc.w    $4278                    ; 0088FE68: dc.w $4278
        dc.w    $8000                    ; 0088FE6A: dc.w $8000
        dc.w    $4278                    ; 0088FE6C: dc.w $4278
        dc.w    $8002                    ; 0088FE6E: dc.w $8002
        dc.w    $4278                    ; 0088FE70: dc.w $4278
        dc.w    $A012                    ; 0088FE72: dc.w $A012
        dc.w    $4EB9, $0088, $49AA    ; 0088FE74: JSR $008849AA
        dc.w    $21FC                    ; 0088FE7A: dc.w $21FC
        dc.w    $008B                    ; 0088FE7C: dc.w $008B
        dc.w    $B4FC                    ; 0088FE7E: dc.w $B4FC
        dc.w    $C96C                    ; 0088FE80: dc.w $C96C
        dc.w    $11FC                    ; 0088FE82: dc.w $11FC
        dc.w    $0001                    ; 0088FE84: dc.w $0001
        dc.w    $C809                    ; 0088FE86: dc.w $C809
        dc.w    $11FC                    ; 0088FE88: dc.w $11FC
        dc.w    $0001                    ; 0088FE8A: dc.w $0001
        dc.w    $C80A                    ; 0088FE8C: dc.w $C80A
        dc.w    $08F8                    ; 0088FE8E: dc.w $08F8
        dc.w    $0006                    ; 0088FE90: dc.w $0006
        dc.w    $C80E                    ; 0088FE92: dc.w $C80E
        dc.w    $11FC                    ; 0088FE94: dc.w $11FC
        dc.w    $0001                    ; 0088FE96: dc.w $0001
        dc.w    $C802                    ; 0088FE98: dc.w $C802
        dc.w    $31FC                    ; 0088FE9A: dc.w $31FC
        dc.w    $0001                    ; 0088FE9C: dc.w $0001
        dc.w    $A036                    ; 0088FE9E: dc.w $A036
        dc.w    $41F9, $00FF, $1000    ; 0088FEA0: LEA $00FF1000,A0
        dc.w    $303C                    ; 0088FEA6: dc.w $303C
        dc.w    $037F                    ; 0088FEA8: dc.w $037F
        dc.w    $4298                    ; 0088FEAA: dc.w $4298
        dc.w    $51C8, $FFFC            ; 0088FEAC: DBRA D0,$0088FEAA
        dc.w    $303C                    ; 0088FEB0: dc.w $303C
        dc.w    $0001                    ; 0088FEB2: dc.w $0001
        dc.w    $323C                    ; 0088FEB4: dc.w $323C
        dc.w    $0001                    ; 0088FEB6: dc.w $0001
        dc.w    $343C                    ; 0088FEB8: dc.w $343C
        dc.w    $0001                    ; 0088FEBA: dc.w $0001
        dc.w    $363C                    ; 0088FEBC: dc.w $363C
        dc.w    $0026                    ; 0088FEBE: dc.w $0026
        dc.w    $383C                    ; 0088FEC0: dc.w $383C
        dc.w    $001A                    ; 0088FEC2: dc.w $001A
        dc.w    $41F9, $00FF, $1000    ; 0088FEC4: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088FECA: dc.w $4EBA
        dc.w    $E360                    ; 0088FECC: dc.w $E360
        dc.w    $41F9, $00FF, $1000    ; 0088FECE: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088FED4: dc.w $4EBA
        dc.w    $E41A                    ; 0088FED6: dc.w $E41A
        dc.w    $4EBA                    ; 0088FED8: dc.w $4EBA
        dc.w    $E2E2                    ; 0088FEDA: dc.w $E2E2
        dc.w    $08B9                    ; 0088FEDC: dc.w $08B9
        dc.w    $0007                    ; 0088FEDE: dc.w $0007
        dc.w    $00A1                    ; 0088FEE0: dc.w $00A1
        dc.w    $5181                    ; 0088FEE2: dc.w $5181
        dc.w    $41F9, $00FF, $6E00    ; 0088FEE4: LEA $00FF6E00,A0
        dc.w    $D1FC                    ; 0088FEEA: dc.w $D1FC
        dc.w    $0000                    ; 0088FEEC: dc.w $0000
        dc.w    $0160                    ; 0088FEEE: dc.w $0160
        dc.w    $43F9, $0089, $00A8    ; 0088FEF0: LEA $008900A8,A1
        dc.w    $303C                    ; 0088FEF6: dc.w $303C
        dc.w    $003F                    ; 0088FEF8: dc.w $003F
        dc.w    $3219                    ; 0088FEFA: dc.w $3219
        dc.w    $08C1                    ; 0088FEFC: dc.w $08C1
        dc.w    $000F                    ; 0088FEFE: dc.w $000F
        dc.w    $30C1                    ; 0088FF00: dc.w $30C1
        dc.w    $51C8, $FFF6            ; 0088FF02: DBRA D0,$0088FEFA
        dc.w    $41F9, $000F, $3D80    ; 0088FF06: LEA $000F3D80,A0
        dc.w    $227C, $0601, $4000    ; 0088FF0C: MOVEA.L #$06014000,A1
        dc.w    $4EBA                    ; 0088FF12: dc.w $4EBA
        dc.w    $E402                    ; 0088FF14: dc.w $E402
        dc.w    $41F9, $000E, $CC90    ; 0088FF16: LEA $000ECC90,A0
        dc.w    $227C, $0601, $9000    ; 0088FF1C: MOVEA.L #$06019000,A1
        dc.w    $4EBA                    ; 0088FF22: dc.w $4EBA
        dc.w    $E3F2                    ; 0088FF24: dc.w $E3F2
        dc.w    $7000                    ; 0088FF26: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088FF28: dc.w $1038
        dc.w    $FEB1                    ; 0088FF2A: dc.w $FEB1
        dc.w    $D080                    ; 0088FF2C: dc.w $D080
        dc.w    $D080                    ; 0088FF2E: dc.w $D080
        dc.w    $41F9, $0089, $0084    ; 0088FF30: LEA $00890084,A0
        dc.w    $2070                    ; 0088FF36: dc.w $2070
        dc.w    $0000                    ; 0088FF38: dc.w $0000
        dc.w    $227C, $0601, $9700    ; 0088FF3A: MOVEA.L #$06019700,A1
        dc.w    $4EBA                    ; 0088FF40: dc.w $4EBA
        dc.w    $E3D4                    ; 0088FF42: dc.w $E3D4
        dc.w    $7000                    ; 0088FF44: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088FF46: dc.w $1038
        dc.w    $FEA5                    ; 0088FF48: dc.w $FEA5
        dc.w    $D080                    ; 0088FF4A: dc.w $D080
        dc.w    $D080                    ; 0088FF4C: dc.w $D080
        dc.w    $41F9, $0089, $0090    ; 0088FF4E: LEA $00890090,A0
        dc.w    $2070                    ; 0088FF54: dc.w $2070
        dc.w    $0000                    ; 0088FF56: dc.w $0000
        dc.w    $227C, $0601, $9C80    ; 0088FF58: MOVEA.L #$06019C80,A1
        dc.w    $4EBA                    ; 0088FF5E: dc.w $4EBA
        dc.w    $E3B6                    ; 0088FF60: dc.w $E3B6
        dc.w    $41F9, $000F, $4620    ; 0088FF62: LEA $000F4620,A0
        dc.w    $227C, $0601, $A200    ; 0088FF68: MOVEA.L #$0601A200,A1
        dc.w    $4EBA                    ; 0088FF6E: dc.w $4EBA
        dc.w    $E3A6                    ; 0088FF70: dc.w $E3A6
        dc.w    $41F9, $000E, $BB40    ; 0088FF72: LEA $000EBB40,A0
        dc.w    $227C, $0602, $0000    ; 0088FF78: MOVEA.L #$06020000,A1
        dc.w    $4EBA                    ; 0088FF7E: dc.w $4EBA
        dc.w    $E396                    ; 0088FF80: dc.w $E396
        dc.w    $41F9, $000E, $B980    ; 0088FF82: LEA $000EB980,A0
        dc.w    $227C, $0602, $3200    ; 0088FF88: MOVEA.L #$06023200,A1
        dc.w    $4EBA                    ; 0088FF8E: dc.w $4EBA
        dc.w    $E386                    ; 0088FF90: dc.w $E386
        dc.w    $41F9, $000F, $4E40    ; 0088FF92: LEA $000F4E40,A0
        dc.w    $227C, $0602, $4000    ; 0088FF98: MOVEA.L #$06024000,A1
        dc.w    $4EBA                    ; 0088FF9E: dc.w $4EBA
        dc.w    $E376                    ; 0088FFA0: dc.w $E376
        dc.w    $11FC                    ; 0088FFA2: dc.w $11FC
        dc.w    $0000                    ; 0088FFA4: dc.w $0000
        dc.w    $A020                    ; 0088FFA6: dc.w $A020
        dc.w    $31FC                    ; 0088FFA8: dc.w $31FC
        dc.w    $0041                    ; 0088FFAA: dc.w $0041
        dc.w    $A024                    ; 0088FFAC: dc.w $A024
        dc.w    $31FC                    ; 0088FFAE: dc.w $31FC
        dc.w    $0000                    ; 0088FFB0: dc.w $0000
        dc.w    $A026                    ; 0088FFB2: dc.w $A026
        dc.w    $31FC                    ; 0088FFB4: dc.w $31FC
        dc.w    $0000                    ; 0088FFB6: dc.w $0000
        dc.w    $A028                    ; 0088FFB8: dc.w $A028
        dc.w    $11FC                    ; 0088FFBA: dc.w $11FC
        dc.w    $00FF                    ; 0088FFBC: dc.w $00FF
        dc.w    $A02A                    ; 0088FFBE: dc.w $A02A
        dc.w    $11FC                    ; 0088FFC0: dc.w $11FC
        dc.w    $0000                    ; 0088FFC2: dc.w $0000
        dc.w    $A02B                    ; 0088FFC4: dc.w $A02B
        dc.w    $11FC                    ; 0088FFC6: dc.w $11FC
        dc.w    $0001                    ; 0088FFC8: dc.w $0001
        dc.w    $A02C                    ; 0088FFCA: dc.w $A02C
        dc.w    $11FC                    ; 0088FFCC: dc.w $11FC
        dc.w    $0000                    ; 0088FFCE: dc.w $0000
        dc.w    $A02D                    ; 0088FFD0: dc.w $A02D
        dc.w    $31FC                    ; 0088FFD2: dc.w $31FC
        dc.w    $000E                    ; 0088FFD4: dc.w $000E
        dc.w    $A02E                    ; 0088FFD6: dc.w $A02E
        dc.w    $31FC                    ; 0088FFD8: dc.w $31FC
        dc.w    $004A                    ; 0088FFDA: dc.w $004A
        dc.w    $A030                    ; 0088FFDC: dc.w $A030
        dc.w    $0838                    ; 0088FFDE: dc.w $0838
        dc.w    $0000                    ; 0088FFE0: dc.w $0000
        dc.w    $A014                    ; 0088FFE2: dc.w $A014
        dc.w    $6700, $0018            ; 0088FFE4: BEQ.W $0088FFFE
        dc.w    $2078                    ; 0088FFE8: dc.w $2078
        dc.w    $A018                    ; 0088FFEA: dc.w $A018
        dc.w    $117C                    ; 0088FFEC: dc.w $117C
        dc.w    $0020                    ; 0088FFEE: dc.w $0020
        dc.w    $0000                    ; 0088FFF0: dc.w $0000
        dc.w    $117C                    ; 0088FFF2: dc.w $117C
        dc.w    $0020                    ; 0088FFF4: dc.w $0020
        dc.w    $0001                    ; 0088FFF6: dc.w $0001
        dc.w    $117C                    ; 0088FFF8: dc.w $117C
        dc.w    $0020                    ; 0088FFFA: dc.w $0020
        dc.w    $0002                    ; 0088FFFC: dc.w $0002
        dc.w    $0838                    ; 0088FFFE: dc.w $0838

