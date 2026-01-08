; ============================================================================
; Code_C000 ($C000-$E000)
; ============================================================================

        org     $00C000

Code_C000:
        dc.w    $6602                    ; 0088C000: BNE.S $0088C004
        dc.w    $7000                    ; 0088C002: MOVEQ #$00,D0
        dc.w    $D241                    ; 0088C004: dc.w $D241
        dc.w    $D241                    ; 0088C006: dc.w $D241
        dc.w    $3401                    ; 0088C008: dc.w $3401
        dc.w    $D241                    ; 0088C00A: dc.w $D241
        dc.w    $D241                    ; 0088C00C: dc.w $D241
        dc.w    $D242                    ; 0088C00E: dc.w $D242
        dc.w    $43F9, $00FF, $6900    ; 0088C010: LEA $00FF6900,A1
        dc.w    $43F1                    ; 0088C016: dc.w $43F1
        dc.w    $1000                    ; 0088C018: dc.w $1000
        dc.w    $3280                    ; 0088C01A: dc.w $3280
        dc.w    $4E75                    ; 0088C01C: RTS
        dc.w    $5878                    ; 0088C01E: dc.w $5878
        dc.w    $A0EA                    ; 0088C020: dc.w $A0EA
        dc.w    $4278                    ; 0088C022: dc.w $4278
        dc.w    $A0EC                    ; 0088C024: dc.w $A0EC
        dc.w    $4E75                    ; 0088C026: RTS
        dc.w    $7000                    ; 0088C028: MOVEQ #$00,D0
        dc.w    $43F9, $00FF, $6800    ; 0088C02A: LEA $00FF6800,A1
        dc.w    $1340                    ; 0088C030: dc.w $1340
        dc.w    $0000                    ; 0088C032: dc.w $0000
        dc.w    $43F9, $00FF, $6810    ; 0088C034: LEA $00FF6810,A1
        dc.w    $1340                    ; 0088C03A: dc.w $1340
        dc.w    $0000                    ; 0088C03C: dc.w $0000
        dc.w    $43F9, $00FF, $6820    ; 0088C03E: LEA $00FF6820,A1
        dc.w    $1340                    ; 0088C044: dc.w $1340
        dc.w    $0000                    ; 0088C046: dc.w $0000
        dc.w    $43F9, $00FF, $6900    ; 0088C048: LEA $00FF6900,A1
        dc.w    $7205                    ; 0088C04E: MOVEQ #$05,D1
        dc.w    $4251                    ; 0088C050: dc.w $4251
        dc.w    $43E9                    ; 0088C052: dc.w $43E9
        dc.w    $0014                    ; 0088C054: dc.w $0014
        dc.w    $51C9, $FFF8            ; 0088C056: DBRA D1,$0088C050
        dc.w    $4E75                    ; 0088C05A: RTS
        dc.w    $0402                    ; 0088C05C: dc.w $0402
        dc.w    $C030                    ; 0088C05E: dc.w $C030
        dc.w    $0402                    ; 0088C060: dc.w $0402
        dc.w    $E030                    ; 0088C062: dc.w $E030
        dc.w    $0403                    ; 0088C064: dc.w $0403
        dc.w    $0030                    ; 0088C066: dc.w $0030
        dc.w    $0403                    ; 0088C068: dc.w $0403
        dc.w    $2030                    ; 0088C06A: dc.w $2030
        dc.w    $0403                    ; 0088C06C: dc.w $0403
        dc.w    $4030                    ; 0088C06E: dc.w $4030
        dc.w    $43F9, $00FF, $6800    ; 0088C070: LEA $00FF6800,A1
        dc.w    $7210                    ; 0088C076: MOVEQ #$10,D1
        dc.w    $700F                    ; 0088C078: MOVEQ #$0F,D0
        dc.w    $4251                    ; 0088C07A: dc.w $4251
        dc.w    $D2C1                    ; 0088C07C: dc.w $D2C1
        dc.w    $51C8, $FFFA            ; 0088C07E: DBRA D0,$0088C07A
        dc.w    $3438                    ; 0088C082: dc.w $3438
        dc.w    $C0FC                    ; 0088C084: dc.w $C0FC
        dc.w    $6700, $0054            ; 0088C086: BEQ.W $0088C0DC
        dc.w    $6B0A                    ; 0088C08A: BMI.S $0088C096
        dc.w    $4278                    ; 0088C08C: dc.w $4278
        dc.w    $C0FE                    ; 0088C08E: dc.w $C0FE
        dc.w    $08F8                    ; 0088C090: dc.w $08F8
        dc.w    $0007                    ; 0088C092: dc.w $0007
        dc.w    $C0FC                    ; 0088C094: dc.w $C0FC
        dc.w    $5342                    ; 0088C096: dc.w $5342
        dc.w    $0242                    ; 0088C098: dc.w $0242
        dc.w    $0007                    ; 0088C09A: dc.w $0007
        dc.w    $D442                    ; 0088C09C: dc.w $D442
        dc.w    $D442                    ; 0088C09E: dc.w $D442
        dc.w    $45F9, $0089, $ACF0    ; 0088C0A0: LEA $0089ACF0,A2
        dc.w    $2472                    ; 0088C0A6: dc.w $2472
        dc.w    $2000                    ; 0088C0A8: dc.w $2000
        dc.w    $43F9, $00FF, $6800    ; 0088C0AA: LEA $00FF6800,A1
        dc.w    $321A                    ; 0088C0B0: dc.w $321A
        dc.w    $32DA                    ; 0088C0B2: dc.w $32DA
        dc.w    $361A                    ; 0088C0B4: dc.w $361A
        dc.w    $4259                    ; 0088C0B6: dc.w $4259
        dc.w    $22DA                    ; 0088C0B8: dc.w $22DA
        dc.w    $22DA                    ; 0088C0BA: dc.w $22DA
        dc.w    $4299                    ; 0088C0BC: dc.w $4299
        dc.w    $9678                    ; 0088C0BE: dc.w $9678
        dc.w    $C0FE                    ; 0088C0C0: dc.w $C0FE
        dc.w    $6B14                    ; 0088C0C2: BMI.S $0088C0D8
        dc.w    $0C43                    ; 0088C0C4: dc.w $0C43
        dc.w    $0050                    ; 0088C0C6: dc.w $0050
        dc.w    $6F04                    ; 0088C0C8: BLE.S $0088C0CE
        dc.w    $363C                    ; 0088C0CA: dc.w $363C
        dc.w    $0050                    ; 0088C0CC: dc.w $0050
        dc.w    $D643                    ; 0088C0CE: dc.w $D643
        dc.w    $D643                    ; 0088C0D0: dc.w $D643
        dc.w    $48C3                    ; 0088C0D2: dc.w $48C3
        dc.w    $D7A9                    ; 0088C0D4: dc.w $D7A9
        dc.w    $FFF4                    ; 0088C0D6: dc.w $FFF4
        dc.w    $51C9, $FFD8            ; 0088C0D8: DBRA D1,$0088C0B2
        dc.w    $5078                    ; 0088C0DC: dc.w $5078
        dc.w    $C0FE                    ; 0088C0DE: dc.w $C0FE
        dc.w    $0C78                    ; 0088C0E0: dc.w $0C78
        dc.w    $7FFF                    ; 0088C0E2: dc.w $7FFF
        dc.w    $C0FE                    ; 0088C0E4: dc.w $C0FE
        dc.w    $6F06                    ; 0088C0E6: BLE.S $0088C0EE
        dc.w    $31FC                    ; 0088C0E8: dc.w $31FC
        dc.w    $7FFF                    ; 0088C0EA: dc.w $7FFF
        dc.w    $C0FE                    ; 0088C0EC: dc.w $C0FE
        dc.w    $4E75                    ; 0088C0EE: RTS
        dc.w    $46FC, $2700            ; 0088C0F0: MOVE.W #$2700,SR
        dc.w    $08B8                    ; 0088C0F4: dc.w $08B8
        dc.w    $0006                    ; 0088C0F6: dc.w $0006
        dc.w    $C875                    ; 0088C0F8: dc.w $C875
        dc.w    $3AB8                    ; 0088C0FA: dc.w $3AB8
        dc.w    $C874                    ; 0088C0FC: dc.w $C874
        dc.w    $33FC                    ; 0088C0FE: dc.w $33FC
        dc.w    $0083                    ; 0088C100: dc.w $0083
        dc.w    $00A1                    ; 0088C102: dc.w $00A1
        dc.w    $5100                    ; 0088C104: dc.w $5100
        dc.w    $0239                    ; 0088C106: dc.w $0239
        dc.w    $00FC                    ; 0088C108: dc.w $00FC
        dc.w    $00A1                    ; 0088C10A: dc.w $00A1
        dc.w    $5181                    ; 0088C10C: dc.w $5181
        dc.w    $4EB9, $0088, $270A    ; 0088C10E: JSR $0088270A
        dc.w    $11FC                    ; 0088C114: dc.w $11FC
        dc.w    $0001                    ; 0088C116: dc.w $0001
        dc.w    $C80D                    ; 0088C118: dc.w $C80D
        dc.w    $0238                    ; 0088C11A: dc.w $0238
        dc.w    $0009                    ; 0088C11C: dc.w $0009
        dc.w    $C80E                    ; 0088C11E: dc.w $C80E
        dc.w    $08F8                    ; 0088C120: dc.w $08F8
        dc.w    $0003                    ; 0088C122: dc.w $0003
        dc.w    $C80E                    ; 0088C124: dc.w $C80E
        dc.w    $7000                    ; 0088C126: MOVEQ #$00,D0
        dc.w    $7200                    ; 0088C128: MOVEQ #$00,D1
        dc.w    $103C                    ; 0088C12A: dc.w $103C
        dc.w    $0000                    ; 0088C12C: dc.w $0000
        dc.w    $123C                    ; 0088C12E: dc.w $123C
        dc.w    $0000                    ; 0088C130: dc.w $0000
        dc.w    $4EBA                    ; 0088C132: dc.w $4EBA
        dc.w    $1068                    ; 0088C134: dc.w $1068
        dc.w    $1038                    ; 0088C136: dc.w $1038
        dc.w    $C8C9                    ; 0088C138: dc.w $C8C9
        dc.w    $5200                    ; 0088C13A: dc.w $5200
        dc.w    $13C0                    ; 0088C13C: dc.w $13C0
        dc.w    $00A1                    ; 0088C13E: dc.w $00A1
        dc.w    $5122                    ; 0088C140: dc.w $5122
        dc.w    $31FC                    ; 0088C142: dc.w $31FC
        dc.w    $0103                    ; 0088C144: dc.w $0103
        dc.w    $C8A8                    ; 0088C146: dc.w $C8A8
        dc.w    $13F8                    ; 0088C148: dc.w $13F8
        dc.w    $C8A9                    ; 0088C14A: dc.w $C8A9
        dc.w    $00A1                    ; 0088C14C: dc.w $00A1
        dc.w    $5121                    ; 0088C14E: dc.w $5121
        dc.w    $13F8                    ; 0088C150: dc.w $13F8
        dc.w    $C8A8                    ; 0088C152: dc.w $C8A8
        dc.w    $00A1                    ; 0088C154: dc.w $00A1
        dc.w    $5120                    ; 0088C156: dc.w $5120
        dc.w    $11FC                    ; 0088C158: dc.w $11FC
        dc.w    $0000                    ; 0088C15A: dc.w $0000
        dc.w    $C80F                    ; 0088C15C: dc.w $C80F
        dc.w    $31FC                    ; 0088C15E: dc.w $31FC
        dc.w    $0000                    ; 0088C160: dc.w $0000
        dc.w    $C8BC                    ; 0088C162: dc.w $C8BC
        dc.w    $4EB9, $0088, $D1D4    ; 0088C164: JSR $0088D1D4
        dc.w    $4EB9, $0088, $D42C    ; 0088C16A: JSR $0088D42C
        dc.w    $41F9, $008B, $A220    ; 0088C170: LEA $008BA220,A0
        dc.w    $3038                    ; 0088C176: dc.w $3038
        dc.w    $C8A0                    ; 0088C178: dc.w $C8A0
        dc.w    $2470                    ; 0088C17A: dc.w $2470
        dc.w    $0000                    ; 0088C17C: dc.w $0000
        dc.w    $4EB9, $0088, $284C    ; 0088C17E: JSR $0088284C
        dc.w    $41F9, $008B, $AE38    ; 0088C184: LEA $008BAE38,A0
        dc.w    $3038                    ; 0088C18A: dc.w $3038
        dc.w    $C8CC                    ; 0088C18C: dc.w $C8CC
        dc.w    $2470                    ; 0088C18E: dc.w $2470
        dc.w    $0000                    ; 0088C190: dc.w $0000
        dc.w    $4EB9, $0088, $2862    ; 0088C192: JSR $00882862
        dc.w    $33FC                    ; 0088C198: dc.w $33FC
        dc.w    $0010                    ; 0088C19A: dc.w $0010
        dc.w    $00FF                    ; 0088C19C: dc.w $00FF
        dc.w    $0008                    ; 0088C19E: dc.w $0008
        dc.w    $31FC                    ; 0088C1A0: dc.w $31FC
        dc.w    $0000                    ; 0088C1A2: dc.w $0000
        dc.w    $C8AA                    ; 0088C1A4: dc.w $C8AA
        dc.w    $4EB9, $0088, $49AA    ; 0088C1A6: JSR $008849AA
        dc.w    $4EBA                    ; 0088C1AC: dc.w $4EBA
        dc.w    $0BE4                    ; 0088C1AE: dc.w $0BE4
        dc.w    $11FC                    ; 0088C1B0: dc.w $11FC
        dc.w    $0000                    ; 0088C1B2: dc.w $0000
        dc.w    $C314                    ; 0088C1B4: dc.w $C314
        dc.w    $0838                    ; 0088C1B6: dc.w $0838
        dc.w    $0000                    ; 0088C1B8: dc.w $0000
        dc.w    $C818                    ; 0088C1BA: dc.w $C818
        dc.w    $6706                    ; 0088C1BC: BEQ.S $0088C1C4
        dc.w    $11FC                    ; 0088C1BE: dc.w $11FC
        dc.w    $0001                    ; 0088C1C0: dc.w $0001
        dc.w    $C314                    ; 0088C1C2: dc.w $C314
        dc.w    $7000                    ; 0088C1C4: MOVEQ #$00,D0
        dc.w    $4EBA                    ; 0088C1C6: dc.w $4EBA
        dc.w    $0AAC                    ; 0088C1C8: dc.w $0AAC
        dc.w    $4EBA                    ; 0088C1CA: dc.w $4EBA
        dc.w    $06A4                    ; 0088C1CC: dc.w $06A4
        dc.w    $4EBA                    ; 0088C1CE: dc.w $4EBA
        dc.w    $0820                    ; 0088C1D0: dc.w $0820
        dc.w    $4EBA                    ; 0088C1D2: dc.w $4EBA
        dc.w    $0E38                    ; 0088C1D4: dc.w $0E38
        dc.w    $11FC                    ; 0088C1D6: dc.w $11FC
        dc.w    $0005                    ; 0088C1D8: dc.w $0005
        dc.w    $C310                    ; 0088C1DA: dc.w $C310
        dc.w    $11FC                    ; 0088C1DC: dc.w $11FC
        dc.w    $0000                    ; 0088C1DE: dc.w $0000
        dc.w    $C30F                    ; 0088C1E0: dc.w $C30F
        dc.w    $41F8                    ; 0088C1E2: dc.w $41F8
        dc.w    $9000                    ; 0088C1E4: dc.w $9000
        dc.w    $4EBA                    ; 0088C1E6: dc.w $4EBA
        dc.w    $0AAA                    ; 0088C1E8: dc.w $0AAA
        dc.w    $7200                    ; 0088C1EA: MOVEQ #$00,D1
        dc.w    $4EBA                    ; 0088C1EC: dc.w $4EBA
        dc.w    $0C68                    ; 0088C1EE: dc.w $0C68
        dc.w    $4EBA                    ; 0088C1F0: dc.w $4EBA
        dc.w    $0B5A                    ; 0088C1F2: dc.w $0B5A
        dc.w    $4EB9, $0088, $A80A    ; 0088C1F4: JSR $0088A80A
        dc.w    $4EB9, $0088, $A144    ; 0088C1FA: JSR $0088A144
        dc.w    $41F8                    ; 0088C200: dc.w $41F8
        dc.w    $9000                    ; 0088C202: dc.w $9000
        dc.w    $4EBA                    ; 0088C204: dc.w $4EBA
        dc.w    $DFF6                    ; 0088C206: dc.w $DFF6
        dc.w    $4EBA                    ; 0088C208: dc.w $4EBA
        dc.w    $076A                    ; 0088C20A: dc.w $076A
        dc.w    $4EBA                    ; 0088C20C: dc.w $4EBA
        dc.w    $0CFE                    ; 0088C20E: dc.w $0CFE
        dc.w    $4EBA                    ; 0088C210: dc.w $4EBA
        dc.w    $09F4                    ; 0088C212: dc.w $09F4
        dc.w    $4EBA                    ; 0088C214: dc.w $4EBA
        dc.w    $0D98                    ; 0088C216: dc.w $0D98
        dc.w    $31FC                    ; 0088C218: dc.w $31FC
        dc.w    $0000                    ; 0088C21A: dc.w $0000
        dc.w    $C87E                    ; 0088C21C: dc.w $C87E
        dc.w    $31FC                    ; 0088C21E: dc.w $31FC
        dc.w    $0000                    ; 0088C220: dc.w $0000
        dc.w    $C8F4                    ; 0088C222: dc.w $C8F4
        dc.w    $08B8                    ; 0088C224: dc.w $08B8
        dc.w    $0007                    ; 0088C226: dc.w $0007
        dc.w    $FEB7                    ; 0088C228: dc.w $FEB7
        dc.w    $08B8                    ; 0088C22A: dc.w $08B8
        dc.w    $0000                    ; 0088C22C: dc.w $0000
        dc.w    $C81C                    ; 0088C22E: dc.w $C81C
        dc.w    $31FC                    ; 0088C230: dc.w $31FC
        dc.w    $C9A0                    ; 0088C232: dc.w $C9A0
        dc.w    $C8C0                    ; 0088C234: dc.w $C8C0
        dc.w    $11FC                    ; 0088C236: dc.w $11FC
        dc.w    $0002                    ; 0088C238: dc.w $0002
        dc.w    $C80A                    ; 0088C23A: dc.w $C80A
        dc.w    $4EBA                    ; 0088C23C: dc.w $4EBA
        dc.w    $049C                    ; 0088C23E: dc.w $049C
        dc.w    $4EBA                    ; 0088C240: dc.w $4EBA
        dc.w    $9686                    ; 0088C242: dc.w $9686
        dc.w    $4EBA                    ; 0088C244: dc.w $4EBA
        dc.w    $96C2                    ; 0088C246: dc.w $96C2
        dc.w    $4EBA                    ; 0088C248: dc.w $4EBA
        dc.w    $96F2                    ; 0088C24A: dc.w $96F2
        dc.w    $0239                    ; 0088C24C: dc.w $0239
        dc.w    $00FC                    ; 0088C24E: dc.w $00FC
        dc.w    $00A1                    ; 0088C250: dc.w $00A1
        dc.w    $5181                    ; 0088C252: dc.w $5181
        dc.w    $0039                    ; 0088C254: dc.w $0039
        dc.w    $0001                    ; 0088C256: dc.w $0001
        dc.w    $00A1                    ; 0088C258: dc.w $00A1
        dc.w    $5181                    ; 0088C25A: dc.w $5181
        dc.w    $33FC                    ; 0088C25C: dc.w $33FC
        dc.w    $8083                    ; 0088C25E: dc.w $8083
        dc.w    $00A1                    ; 0088C260: dc.w $00A1
        dc.w    $5100                    ; 0088C262: dc.w $5100
        dc.w    $4EB9, $0088, $204A    ; 0088C264: JSR $0088204A
        dc.w    $4EB9, $0088, $20C6    ; 0088C26A: JSR $008820C6
        dc.w    $08F8                    ; 0088C270: dc.w $08F8
        dc.w    $0006                    ; 0088C272: dc.w $0006
        dc.w    $C875                    ; 0088C274: dc.w $C875
        dc.w    $3AB8                    ; 0088C276: dc.w $3AB8
        dc.w    $C874                    ; 0088C278: dc.w $C874
        dc.w    $4EB9, $0088, $4998    ; 0088C27A: JSR $00884998
        dc.w    $31FC                    ; 0088C280: dc.w $31FC
        dc.w    $0080                    ; 0088C282: dc.w $0080
        dc.w    $A000                    ; 0088C284: dc.w $A000
        dc.w    $11FC                    ; 0088C286: dc.w $11FC
        dc.w    $00C5                    ; 0088C288: dc.w $00C5
        dc.w    $C8A4                    ; 0088C28A: dc.w $C8A4
        dc.w    $4EB9, $0088, $2080    ; 0088C28C: JSR $00882080
        dc.w    $4EB9, $0088, $4998    ; 0088C292: JSR $00884998
        dc.w    $5378                    ; 0088C298: dc.w $5378
        dc.w    $A000                    ; 0088C29A: dc.w $A000
        dc.w    $66EE                    ; 0088C29C: BNE.S $0088C28C
        dc.w    $3038                    ; 0088C29E: dc.w $3038
        dc.w    $C8A0                    ; 0088C2A0: dc.w $C8A0
        dc.w    $41F9, $008B, $B1C4    ; 0088C2A2: LEA $008BB1C4,A0
        dc.w    $21F0                    ; 0088C2A8: dc.w $21F0
        dc.w    $0000                    ; 0088C2AA: dc.w $0000
        dc.w    $C96C                    ; 0088C2AC: dc.w $C96C
        dc.w    $11FC                    ; 0088C2AE: dc.w $11FC
        dc.w    $0001                    ; 0088C2B0: dc.w $0001
        dc.w    $C809                    ; 0088C2B2: dc.w $C809
        dc.w    $08F8                    ; 0088C2B4: dc.w $08F8
        dc.w    $0006                    ; 0088C2B6: dc.w $0006
        dc.w    $C80E                    ; 0088C2B8: dc.w $C80E
        dc.w    $11FC                    ; 0088C2BA: dc.w $11FC
        dc.w    $0001                    ; 0088C2BC: dc.w $0001
        dc.w    $C802                    ; 0088C2BE: dc.w $C802
        dc.w    $0839                    ; 0088C2C0: dc.w $0839
        dc.w    $0000                    ; 0088C2C2: dc.w $0000
        dc.w    $00A1                    ; 0088C2C4: dc.w $00A1
        dc.w    $5123                    ; 0088C2C6: dc.w $5123
        dc.w    $67F6                    ; 0088C2C8: BEQ.S $0088C2C0
        dc.w    $08B9                    ; 0088C2CA: dc.w $08B9
        dc.w    $0000                    ; 0088C2CC: dc.w $0000
        dc.w    $00A1                    ; 0088C2CE: dc.w $00A1
        dc.w    $5123                    ; 0088C2D0: dc.w $5123
        dc.w    $31FC                    ; 0088C2D2: dc.w $31FC
        dc.w    $0102                    ; 0088C2D4: dc.w $0102
        dc.w    $C8A8                    ; 0088C2D6: dc.w $C8A8
        dc.w    $11FC                    ; 0088C2D8: dc.w $11FC
        dc.w    $009C                    ; 0088C2DA: dc.w $009C
        dc.w    $C8A5                    ; 0088C2DC: dc.w $C8A5
        dc.w    $4EB9, $0088, $2080    ; 0088C2DE: JSR $00882080
        dc.w    $4EB9, $0088, $4998    ; 0088C2E4: JSR $00884998
        dc.w    $23FC, $0088, $C30A, $00FF, $0002  ; 0088C2EA: MOVE.L #$0088C30A,$00FF0002
        dc.w    $23FC, $0000, $0000, $00FF, $5FF8  ; 0088C2F4: MOVE.L #$00000000,$00FF5FF8
        dc.w    $23FC, $0000, $0000, $00FF, $5FFC  ; 0088C2FE: MOVE.L #$00000000,$00FF5FFC
        dc.w    $4E75                    ; 0088C308: RTS
        dc.w    $3038                    ; 0088C30A: dc.w $3038
        dc.w    $C87E                    ; 0088C30C: dc.w $C87E
        dc.w    $227B                    ; 0088C30E: dc.w $227B
        dc.w    $0004                    ; 0088C310: dc.w $0004
        dc.w    $4ED1                    ; 0088C312: JMP (A1)
        dc.w    $0088                    ; 0088C314: dc.w $0088
        dc.w    $C328                    ; 0088C316: dc.w $C328
        dc.w    $0088                    ; 0088C318: dc.w $0088
        dc.w    $C368                    ; 0088C31A: dc.w $C368
        dc.w    $0088                    ; 0088C31C: dc.w $0088
        dc.w    $C390                    ; 0088C31E: dc.w $C390
        dc.w    $0088                    ; 0088C320: dc.w $0088
        dc.w    $C3FC                    ; 0088C322: dc.w $C3FC
        dc.w    $0088                    ; 0088C324: dc.w $0088
        dc.w    $C45E                    ; 0088C326: dc.w $C45E
        dc.w    $4EB9, $0088, $28C2    ; 0088C328: JSR $008828C2
        dc.w    $4EB9, $0088, $21CA    ; 0088C32E: JSR $008821CA
        dc.w    $3F38                    ; 0088C334: dc.w $3F38
        dc.w    $C86C                    ; 0088C336: dc.w $C86C
        dc.w    $31FC                    ; 0088C338: dc.w $31FC
        dc.w    $FF00                    ; 0088C33A: dc.w $FF00
        dc.w    $C86C                    ; 0088C33C: dc.w $C86C
        dc.w    $0838                    ; 0088C33E: dc.w $0838
        dc.w    $0000                    ; 0088C340: dc.w $0000
        dc.w    $C81C                    ; 0088C342: dc.w $C81C
        dc.w    $6606                    ; 0088C344: BNE.S $0088C34C
        dc.w    $4EB9, $0088, $88BE    ; 0088C346: JSR $008888BE
        dc.w    $31DF                    ; 0088C34C: dc.w $31DF
        dc.w    $C86C                    ; 0088C34E: dc.w $C86C
        dc.w    $4EB9, $0088, $58C8    ; 0088C350: JSR $008858C8
        dc.w    $5238                    ; 0088C356: dc.w $5238
        dc.w    $C886                    ; 0088C358: dc.w $C886
        dc.w    $5878                    ; 0088C35A: dc.w $5878
        dc.w    $C87E                    ; 0088C35C: dc.w $C87E
        dc.w    $33FC                    ; 0088C35E: dc.w $33FC
        dc.w    $0010                    ; 0088C360: dc.w $0010
        dc.w    $00FF                    ; 0088C362: dc.w $00FF
        dc.w    $0008                    ; 0088C364: dc.w $0008
        dc.w    $4E75                    ; 0088C366: RTS
        dc.w    $4EB9, $0088, $21CA    ; 0088C368: JSR $008821CA
        dc.w    $4EB9, $0088, $25B0    ; 0088C36E: JSR $008825B0
        dc.w    $4EBA                    ; 0088C374: dc.w $4EBA
        dc.w    $F6A2                    ; 0088C376: dc.w $F6A2
        dc.w    $4EB9, $0088, $5908    ; 0088C378: JSR $00885908
        dc.w    $5238                    ; 0088C37E: dc.w $5238
        dc.w    $C886                    ; 0088C380: dc.w $C886
        dc.w    $5878                    ; 0088C382: dc.w $5878
        dc.w    $C87E                    ; 0088C384: dc.w $C87E
        dc.w    $33FC                    ; 0088C386: dc.w $33FC
        dc.w    $0010                    ; 0088C388: dc.w $0010
        dc.w    $00FF                    ; 0088C38A: dc.w $00FF
        dc.w    $0008                    ; 0088C38C: dc.w $0008
        dc.w    $4E75                    ; 0088C38E: RTS
        dc.w    $4EB9, $0088, $21CA    ; 0088C390: JSR $008821CA
        dc.w    $4EB9, $0088, $179E    ; 0088C396: JSR $0088179E
        dc.w    $5278                    ; 0088C39C: dc.w $5278
        dc.w    $C080                    ; 0088C39E: dc.w $C080
        dc.w    $5278                    ; 0088C3A0: dc.w $5278
        dc.w    $C8AA                    ; 0088C3A2: dc.w $C8AA
        dc.w    $21FC                    ; 0088C3A4: dc.w $21FC
        dc.w    $FFFF                    ; 0088C3A6: dc.w $FFFF
        dc.w    $0000                    ; 0088C3A8: dc.w $0000
        dc.w    $C970                    ; 0088C3AA: dc.w $C970
        dc.w    $3078                    ; 0088C3AC: dc.w $3078
        dc.w    $C8C0                    ; 0088C3AE: dc.w $C8C0
        dc.w    $1018                    ; 0088C3B0: dc.w $1018
        dc.w    $1200                    ; 0088C3B2: dc.w $1200
        dc.w    $0200                    ; 0088C3B4: dc.w $0200
        dc.w    $005C                    ; 0088C3B6: dc.w $005C
        dc.w    $11C0                    ; 0088C3B8: dc.w $11C0
        dc.w    $C971                    ; 0088C3BA: dc.w $C971
        dc.w    $0201                    ; 0088C3BC: dc.w $0201
        dc.w    $0003                    ; 0088C3BE: dc.w $0003
        dc.w    $11C1                    ; 0088C3C0: dc.w $11C1
        dc.w    $C973                    ; 0088C3C2: dc.w $C973
        dc.w    $31C8                    ; 0088C3C4: dc.w $31C8
        dc.w    $C8C0                    ; 0088C3C6: dc.w $C8C0
        dc.w    $4EB9, $0088, $593C    ; 0088C3C8: JSR $0088593C
        dc.w    $4EB9, $0088, $24CA    ; 0088C3CE: JSR $008824CA
        dc.w    $4EBA                    ; 0088C3D4: dc.w $4EBA
        dc.w    $F304                    ; 0088C3D6: dc.w $F304
        dc.w    $4EBA                    ; 0088C3D8: dc.w $4EBA
        dc.w    $F2AA                    ; 0088C3DA: dc.w $F2AA
        dc.w    $5238                    ; 0088C3DC: dc.w $5238
        dc.w    $C886                    ; 0088C3DE: dc.w $C886
        dc.w    $5878                    ; 0088C3E0: dc.w $5878
        dc.w    $C87E                    ; 0088C3E2: dc.w $C87E
        dc.w    $33FC                    ; 0088C3E4: dc.w $33FC
        dc.w    $0038                    ; 0088C3E6: dc.w $0038
        dc.w    $00FF                    ; 0088C3E8: dc.w $00FF
        dc.w    $0008                    ; 0088C3EA: dc.w $0008
        dc.w    $4EBA                    ; 0088C3EC: dc.w $4EBA
        dc.w    $0028                    ; 0088C3EE: dc.w $0028
        dc.w    $4EBA                    ; 0088C3F0: dc.w $4EBA
        dc.w    $01BC                    ; 0088C3F2: dc.w $01BC
        dc.w    $4EBA                    ; 0088C3F4: dc.w $4EBA
        dc.w    $FC7A                    ; 0088C3F6: dc.w $FC7A
        dc.w    $4EFA                    ; 0088C3F8: dc.w $4EFA
        dc.w    $0268                    ; 0088C3FA: dc.w $0268
        dc.w    $4EB9, $0088, $21CA    ; 0088C3FC: JSR $008821CA
        dc.w    $4EB9, $0088, $179E    ; 0088C402: JSR $0088179E
        dc.w    $5238                    ; 0088C408: dc.w $5238
        dc.w    $C886                    ; 0088C40A: dc.w $C886
        dc.w    $33FC                    ; 0088C40C: dc.w $33FC
        dc.w    $0038                    ; 0088C40E: dc.w $0038
        dc.w    $00FF                    ; 0088C410: dc.w $00FF
        dc.w    $0008                    ; 0088C412: dc.w $0008
        dc.w    $4E75                    ; 0088C414: RTS
        dc.w    $7000                    ; 0088C416: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088C418: dc.w $1038
        dc.w    $C8F5                    ; 0088C41A: dc.w $C8F5
        dc.w    $303B                    ; 0088C41C: dc.w $303B
        dc.w    $002E                    ; 0088C41E: dc.w $002E
        dc.w    $B078                    ; 0088C420: dc.w $B078
        dc.w    $C080                    ; 0088C422: dc.w $C080
        dc.w    $6624                    ; 0088C424: BNE.S $0088C44A
        dc.w    $4EB9, $0088, $49AA    ; 0088C426: JSR $008849AA
        dc.w    $31FC                    ; 0088C42C: dc.w $31FC
        dc.w    $0010                    ; 0088C42E: dc.w $0010
        dc.w    $C87E                    ; 0088C430: dc.w $C87E
        dc.w    $31FC                    ; 0088C432: dc.w $31FC
        dc.w    $0C00                    ; 0088C434: dc.w $0C00
        dc.w    $C8C4                    ; 0088C436: dc.w $C8C4
        dc.w    $11FC                    ; 0088C438: dc.w $11FC
        dc.w    $0004                    ; 0088C43A: dc.w $0004
        dc.w    $C082                    ; 0088C43C: dc.w $C082
        dc.w    $5438                    ; 0088C43E: dc.w $5438
        dc.w    $C8F5                    ; 0088C440: dc.w $C8F5
        dc.w    $33FC                    ; 0088C442: dc.w $33FC
        dc.w    $0044                    ; 0088C444: dc.w $0044
        dc.w    $00FF                    ; 0088C446: dc.w $00FF
        dc.w    $0008                    ; 0088C448: dc.w $0008
        dc.w    $4E75                    ; 0088C44A: RTS
        dc.w    $0089                    ; 0088C44C: dc.w $0089
        dc.w    $0117                    ; 0088C44E: dc.w $0117
        dc.w    $016A                    ; 0088C450: dc.w $016A
        dc.w    $01E0                    ; 0088C452: dc.w $01E0
        dc.w    $025E                    ; 0088C454: dc.w $025E
        dc.w    $02E2                    ; 0088C456: dc.w $02E2
        dc.w    $034D                    ; 0088C458: dc.w $034D
        dc.w    $1000                    ; 0088C45A: dc.w $1000
        dc.w    $1000                    ; 0088C45C: dc.w $1000
        dc.w    $4EB9, $0088, $21CA    ; 0088C45E: JSR $008821CA
        dc.w    $7000                    ; 0088C464: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088C466: dc.w $1038
        dc.w    $C8C4                    ; 0088C468: dc.w $C8C4
        dc.w    $227B                    ; 0088C46A: dc.w $227B
        dc.w    $0004                    ; 0088C46C: dc.w $0004
        dc.w    $4ED1                    ; 0088C46E: JMP (A1)
        dc.w    $0088                    ; 0088C470: dc.w $0088
        dc.w    $C480                    ; 0088C472: dc.w $C480
        dc.w    $0088                    ; 0088C474: dc.w $0088
        dc.w    $C4A4                    ; 0088C476: dc.w $C4A4
        dc.w    $0088                    ; 0088C478: dc.w $0088
        dc.w    $C4C2                    ; 0088C47A: dc.w $C4C2
        dc.w    $0088                    ; 0088C47C: dc.w $0088
        dc.w    $C53C                    ; 0088C47E: dc.w $C53C
        dc.w    $4EB9, $0088, $28C2    ; 0088C480: JSR $008828C2
        dc.w    $4EB9, $0088, $25B0    ; 0088C486: JSR $008825B0
        dc.w    $4EB9, $0088, $6D9C    ; 0088C48C: JSR $00886D9C
        dc.w    $5238                    ; 0088C492: dc.w $5238
        dc.w    $C886                    ; 0088C494: dc.w $C886
        dc.w    $5838                    ; 0088C496: dc.w $5838
        dc.w    $C8C4                    ; 0088C498: dc.w $C8C4
        dc.w    $33FC                    ; 0088C49A: dc.w $33FC
        dc.w    $0010                    ; 0088C49C: dc.w $0010
        dc.w    $00FF                    ; 0088C49E: dc.w $00FF
        dc.w    $0008                    ; 0088C4A0: dc.w $0008
        dc.w    $4E75                    ; 0088C4A2: RTS
        dc.w    $4EB9, $0088, $BA18    ; 0088C4A4: JSR $0088BA18
        dc.w    $4EB9, $0088, $6DC8    ; 0088C4AA: JSR $00886DC8
        dc.w    $5238                    ; 0088C4B0: dc.w $5238
        dc.w    $C886                    ; 0088C4B2: dc.w $C886
        dc.w    $5838                    ; 0088C4B4: dc.w $5838
        dc.w    $C8C4                    ; 0088C4B6: dc.w $C8C4
        dc.w    $33FC                    ; 0088C4B8: dc.w $33FC
        dc.w    $0010                    ; 0088C4BA: dc.w $0010
        dc.w    $00FF                    ; 0088C4BC: dc.w $00FF
        dc.w    $0008                    ; 0088C4BE: dc.w $0008
        dc.w    $4E75                    ; 0088C4C0: RTS
        dc.w    $4EB9, $0088, $179E    ; 0088C4C2: JSR $0088179E
        dc.w    $5278                    ; 0088C4C8: dc.w $5278
        dc.w    $C080                    ; 0088C4CA: dc.w $C080
        dc.w    $5278                    ; 0088C4CC: dc.w $5278
        dc.w    $C8AA                    ; 0088C4CE: dc.w $C8AA
        dc.w    $21FC                    ; 0088C4D0: dc.w $21FC
        dc.w    $FFFF                    ; 0088C4D2: dc.w $FFFF
        dc.w    $0000                    ; 0088C4D4: dc.w $0000
        dc.w    $C970                    ; 0088C4D6: dc.w $C970
        dc.w    $3078                    ; 0088C4D8: dc.w $3078
        dc.w    $C8C0                    ; 0088C4DA: dc.w $C8C0
        dc.w    $1018                    ; 0088C4DC: dc.w $1018
        dc.w    $1200                    ; 0088C4DE: dc.w $1200
        dc.w    $0200                    ; 0088C4E0: dc.w $0200
        dc.w    $005C                    ; 0088C4E2: dc.w $005C
        dc.w    $11C0                    ; 0088C4E4: dc.w $11C0
        dc.w    $C971                    ; 0088C4E6: dc.w $C971
        dc.w    $0201                    ; 0088C4E8: dc.w $0201
        dc.w    $0003                    ; 0088C4EA: dc.w $0003
        dc.w    $11C1                    ; 0088C4EC: dc.w $11C1
        dc.w    $C973                    ; 0088C4EE: dc.w $C973
        dc.w    $31C8                    ; 0088C4F0: dc.w $31C8
        dc.w    $C8C0                    ; 0088C4F2: dc.w $C8C0
        dc.w    $4EB9, $0088, $6DF0    ; 0088C4F4: JSR $00886DF0
        dc.w    $4EB9, $0088, $24CA    ; 0088C4FA: JSR $008824CA
        dc.w    $5238                    ; 0088C500: dc.w $5238
        dc.w    $C886                    ; 0088C502: dc.w $C886
        dc.w    $5838                    ; 0088C504: dc.w $5838
        dc.w    $C8C4                    ; 0088C506: dc.w $C8C4
        dc.w    $33FC                    ; 0088C508: dc.w $33FC
        dc.w    $0044                    ; 0088C50A: dc.w $0044
        dc.w    $00FF                    ; 0088C50C: dc.w $00FF
        dc.w    $0008                    ; 0088C50E: dc.w $0008
        dc.w    $7000                    ; 0088C510: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088C512: dc.w $1038
        dc.w    $C082                    ; 0088C514: dc.w $C082
        dc.w    $227B                    ; 0088C516: dc.w $227B
        dc.w    $0014                    ; 0088C518: dc.w $0014
        dc.w    $4E91                    ; 0088C51A: dc.w $4E91
        dc.w    $4EBA                    ; 0088C51C: dc.w $4EBA
        dc.w    $FB52                    ; 0088C51E: dc.w $FB52
        dc.w    $4EBA                    ; 0088C520: dc.w $4EBA
        dc.w    $F1B8                    ; 0088C522: dc.w $F1B8
        dc.w    $4EBA                    ; 0088C524: dc.w $4EBA
        dc.w    $F15E                    ; 0088C526: dc.w $F15E
        dc.w    $4EFA                    ; 0088C528: dc.w $4EFA
        dc.w    $0138                    ; 0088C52A: dc.w $0138
        dc.w    $0088                    ; 0088C52C: dc.w $0088
        dc.w    $C542                    ; 0088C52E: dc.w $C542
        dc.w    $0088                    ; 0088C530: dc.w $0088
        dc.w    $C544                    ; 0088C532: dc.w $C544
        dc.w    $0088                    ; 0088C534: dc.w $0088
        dc.w    $C586                    ; 0088C536: dc.w $C586
        dc.w    $0088                    ; 0088C538: dc.w $0088
        dc.w    $C592                    ; 0088C53A: dc.w $C592
        dc.w    $5238                    ; 0088C53C: dc.w $5238
        dc.w    $C886                    ; 0088C53E: dc.w $C886
        dc.w    $4E75                    ; 0088C540: RTS
        dc.w    $4E75                    ; 0088C542: RTS
        dc.w    $5838                    ; 0088C544: dc.w $5838
        dc.w    $C082                    ; 0088C546: dc.w $C082
        dc.w    $7000                    ; 0088C548: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088C54A: dc.w $1038
        dc.w    $C8F5                    ; 0088C54C: dc.w $C8F5
        dc.w    $E248                    ; 0088C54E: dc.w $E248
        dc.w    $5340                    ; 0088C550: dc.w $5340
        dc.w    $11FB                    ; 0088C552: dc.w $11FB
        dc.w    $0016                    ; 0088C554: dc.w $0016
        dc.w    $C083                    ; 0088C556: dc.w $C083
        dc.w    $D040                    ; 0088C558: dc.w $D040
        dc.w    $31FB                    ; 0088C55A: dc.w $31FB
        dc.w    $0018                    ; 0088C55C: dc.w $0018
        dc.w    $C0FC                    ; 0088C55E: dc.w $C0FC
        dc.w    $33FC                    ; 0088C560: dc.w $33FC
        dc.w    $0034                    ; 0088C562: dc.w $0034
        dc.w    $00FF                    ; 0088C564: dc.w $00FF
        dc.w    $0008                    ; 0088C566: dc.w $0008
        dc.w    $4E75                    ; 0088C568: RTS
        dc.w    $283C                    ; 0088C56A: dc.w $283C
        dc.w    $6464                    ; 0088C56C: BCC.S $0088C5D2
        dc.w    $6450                    ; 0088C56E: BCC.S $0088C5C0
        dc.w    $6478                    ; 0088C570: BCC.S $0088C5EA
        dc.w    $5000                    ; 0088C572: dc.w $5000
        dc.w    $0001                    ; 0088C574: dc.w $0001
        dc.w    $0002                    ; 0088C576: dc.w $0002
        dc.w    $0003                    ; 0088C578: dc.w $0003
        dc.w    $0004                    ; 0088C57A: dc.w $0004
        dc.w    $0005                    ; 0088C57C: dc.w $0005
        dc.w    $0006                    ; 0088C57E: dc.w $0006
        dc.w    $0007                    ; 0088C580: dc.w $0007
        dc.w    $0008                    ; 0088C582: dc.w $0008
        dc.w    $0000                    ; 0088C584: dc.w $0000
        dc.w    $5338                    ; 0088C586: dc.w $5338
        dc.w    $C083                    ; 0088C588: dc.w $C083
        dc.w    $6604                    ; 0088C58A: BNE.S $0088C590
        dc.w    $5838                    ; 0088C58C: dc.w $5838
        dc.w    $C082                    ; 0088C58E: dc.w $C082
        dc.w    $4E75                    ; 0088C590: RTS
        dc.w    $33FC                    ; 0088C592: dc.w $33FC
        dc.w    $003C                    ; 0088C594: dc.w $003C
        dc.w    $00FF                    ; 0088C596: dc.w $00FF
        dc.w    $0008                    ; 0088C598: dc.w $0008
        dc.w    $11FC                    ; 0088C59A: dc.w $11FC
        dc.w    $0000                    ; 0088C59C: dc.w $0000
        dc.w    $C082                    ; 0088C59E: dc.w $C082
        dc.w    $31FC                    ; 0088C5A0: dc.w $31FC
        dc.w    $0000                    ; 0088C5A2: dc.w $0000
        dc.w    $C0FC                    ; 0088C5A4: dc.w $C0FC
        dc.w    $11FC                    ; 0088C5A6: dc.w $11FC
        dc.w    $0018                    ; 0088C5A8: dc.w $0018
        dc.w    $C8C5                    ; 0088C5AA: dc.w $C8C5
        dc.w    $4E75                    ; 0088C5AC: RTS
        dc.w    $3038                    ; 0088C5AE: dc.w $3038
        dc.w    $C080                    ; 0088C5B0: dc.w $C080
        dc.w    $0C40                    ; 0088C5B2: dc.w $0C40
        dc.w    $03E3                    ; 0088C5B4: dc.w $03E3
        dc.w    $6D00, $00A8            ; 0088C5B6: BLT.W $0088C660
        dc.w    $0C40                    ; 0088C5BA: dc.w $0C40
        dc.w    $03E3                    ; 0088C5BC: dc.w $03E3
        dc.w    $6658                    ; 0088C5BE: BNE.S $0088C618
        dc.w    $08F8                    ; 0088C5C0: dc.w $08F8
        dc.w    $0000                    ; 0088C5C2: dc.w $0000
        dc.w    $C81C                    ; 0088C5C4: dc.w $C81C
        dc.w    $31FC                    ; 0088C5C6: dc.w $31FC
        dc.w    $00C0                    ; 0088C5C8: dc.w $00C0
        dc.w    $C0C8                    ; 0088C5CA: dc.w $C0C8
        dc.w    $33FC                    ; 0088C5CC: dc.w $33FC
        dc.w    $0100                    ; 0088C5CE: dc.w $0100
        dc.w    $00FF                    ; 0088C5D0: dc.w $00FF
        dc.w    $60CC                    ; 0088C5D2: BRA.S $0088C5A0
        dc.w    $31F8                    ; 0088C5D4: dc.w $31F8
        dc.w    $C8DA                    ; 0088C5D6: dc.w $C8DA
        dc.w    $C0AE                    ; 0088C5D8: dc.w $C0AE
        dc.w    $31FC                    ; 0088C5DA: dc.w $31FC
        dc.w    $0000                    ; 0088C5DC: dc.w $0000
        dc.w    $C0B0                    ; 0088C5DE: dc.w $C0B0
        dc.w    $31FC                    ; 0088C5E0: dc.w $31FC
        dc.w    $0000                    ; 0088C5E2: dc.w $0000
        dc.w    $C0B2                    ; 0088C5E4: dc.w $C0B2
        dc.w    $31F8                    ; 0088C5E6: dc.w $31F8
        dc.w    $C8DC                    ; 0088C5E8: dc.w $C8DC
        dc.w    $C054                    ; 0088C5EA: dc.w $C054
        dc.w    $31F8                    ; 0088C5EC: dc.w $31F8
        dc.w    $C8DE                    ; 0088C5EE: dc.w $C8DE
        dc.w    $C056                    ; 0088C5F0: dc.w $C056
        dc.w    $31FC                    ; 0088C5F2: dc.w $31FC
        dc.w    $0000                    ; 0088C5F4: dc.w $0000
        dc.w    $C0C6                    ; 0088C5F6: dc.w $C0C6
        dc.w    $31FC                    ; 0088C5F8: dc.w $31FC
        dc.w    $0000                    ; 0088C5FA: dc.w $0000
        dc.w    $C0BA                    ; 0088C5FC: dc.w $C0BA
        dc.w    $08F8                    ; 0088C5FE: dc.w $08F8
        dc.w    $0001                    ; 0088C600: dc.w $0001
        dc.w    $C313                    ; 0088C602: dc.w $C313
        dc.w    $08B8                    ; 0088C604: dc.w $08B8
        dc.w    $0003                    ; 0088C606: dc.w $0003
        dc.w    $C313                    ; 0088C608: dc.w $C313
        dc.w    $11FC                    ; 0088C60A: dc.w $11FC
        dc.w    $0000                    ; 0088C60C: dc.w $0000
        dc.w    $C896                    ; 0088C60E: dc.w $C896
        dc.w    $31FC                    ; 0088C610: dc.w $31FC
        dc.w    $0008                    ; 0088C612: dc.w $0008
        dc.w    $C0FC                    ; 0088C614: dc.w $C0FC
        dc.w    $4E75                    ; 0088C616: RTS
        dc.w    $5478                    ; 0088C618: dc.w $5478
        dc.w    $C0C6                    ; 0088C61A: dc.w $C0C6
        dc.w    $0C78                    ; 0088C61C: dc.w $0C78
        dc.w    $0030                    ; 0088C61E: dc.w $0030
        dc.w    $C0C6                    ; 0088C620: dc.w $C0C6
        dc.w    $6F06                    ; 0088C622: BLE.S $0088C62A
        dc.w    $31FC                    ; 0088C624: dc.w $31FC
        dc.w    $0030                    ; 0088C626: dc.w $0030
        dc.w    $C0C6                    ; 0088C628: dc.w $C0C6
        dc.w    $0678                    ; 0088C62A: dc.w $0678
        dc.w    $0080                    ; 0088C62C: dc.w $0080
        dc.w    $C0B0                    ; 0088C62E: dc.w $C0B0
        dc.w    $0C78                    ; 0088C630: dc.w $0C78
        dc.w    $1000                    ; 0088C632: dc.w $1000
        dc.w    $C0B0                    ; 0088C634: dc.w $C0B0
        dc.w    $6F06                    ; 0088C636: BLE.S $0088C63E
        dc.w    $31FC                    ; 0088C638: dc.w $31FC
        dc.w    $1000                    ; 0088C63A: dc.w $1000
        dc.w    $C0B0                    ; 0088C63C: dc.w $C0B0
        dc.w    $0C78                    ; 0088C63E: dc.w $0C78
        dc.w    $04D9                    ; 0088C640: dc.w $04D9
        dc.w    $C080                    ; 0088C642: dc.w $C080
        dc.w    $6606                    ; 0088C644: BNE.S $0088C64C
        dc.w    $4EB9, $0088, $2066    ; 0088C646: JSR $00882066
        dc.w    $0C78                    ; 0088C64C: dc.w $0C78
        dc.w    $0510                    ; 0088C64E: dc.w $0510
        dc.w    $C080                    ; 0088C650: dc.w $C080
        dc.w    $6D0C                    ; 0088C652: BLT.S $0088C660
        dc.w    $4A38                    ; 0088C654: dc.w $4A38
        dc.w    $C8F4                    ; 0088C656: dc.w $C8F4
        dc.w    $6606                    ; 0088C658: BNE.S $0088C660
        dc.w    $11FC                    ; 0088C65A: dc.w $11FC
        dc.w    $0004                    ; 0088C65C: dc.w $0004
        dc.w    $C8F4                    ; 0088C65E: dc.w $C8F4
        dc.w    $4E75                    ; 0088C660: RTS
        dc.w    $7000                    ; 0088C662: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088C664: dc.w $1038
        dc.w    $C8F4                    ; 0088C666: dc.w $C8F4
        dc.w    $227B                    ; 0088C668: dc.w $227B
        dc.w    $0004                    ; 0088C66A: dc.w $0004
        dc.w    $4ED1                    ; 0088C66C: JMP (A1)
        dc.w    $0088                    ; 0088C66E: dc.w $0088
        dc.w    $C67E                    ; 0088C670: dc.w $C67E
        dc.w    $0088                    ; 0088C672: dc.w $0088
        dc.w    $C680                    ; 0088C674: dc.w $C680
        dc.w    $0088                    ; 0088C676: dc.w $0088
        dc.w    $C6A4                    ; 0088C678: dc.w $C6A4
        dc.w    $0088                    ; 0088C67A: dc.w $0088
        dc.w    $C6B6                    ; 0088C67C: dc.w $C6B6
        dc.w    $4E75                    ; 0088C67E: RTS
        dc.w    $11FC                    ; 0088C680: dc.w $11FC
        dc.w    $0001                    ; 0088C682: dc.w $0001
        dc.w    $C809                    ; 0088C684: dc.w $C809
        dc.w    $11FC                    ; 0088C686: dc.w $11FC
        dc.w    $0001                    ; 0088C688: dc.w $0001
        dc.w    $C80A                    ; 0088C68A: dc.w $C80A
        dc.w    $08F8                    ; 0088C68C: dc.w $08F8
        dc.w    $0007                    ; 0088C68E: dc.w $0007
        dc.w    $C80E                    ; 0088C690: dc.w $C80E
        dc.w    $11FC                    ; 0088C692: dc.w $11FC
        dc.w    $0001                    ; 0088C694: dc.w $0001
        dc.w    $C802                    ; 0088C696: dc.w $C802
        dc.w    $11FC                    ; 0088C698: dc.w $11FC
        dc.w    $00F3                    ; 0088C69A: dc.w $00F3
        dc.w    $C822                    ; 0088C69C: dc.w $C822
        dc.w    $5838                    ; 0088C69E: dc.w $5838
        dc.w    $C8F4                    ; 0088C6A0: dc.w $C8F4
        dc.w    $4E75                    ; 0088C6A2: RTS
        dc.w    $0838                    ; 0088C6A4: dc.w $0838
        dc.w    $0007                    ; 0088C6A6: dc.w $0007
        dc.w    $C80E                    ; 0088C6A8: dc.w $C80E
        dc.w    $6608                    ; 0088C6AA: BNE.S $0088C6B4
        dc.w    $3ABC                    ; 0088C6AC: dc.w $3ABC
        dc.w    $8B00                    ; 0088C6AE: dc.w $8B00
        dc.w    $5838                    ; 0088C6B0: dc.w $5838
        dc.w    $C8F4                    ; 0088C6B2: dc.w $C8F4
        dc.w    $4E75                    ; 0088C6B4: RTS
        dc.w    $11FC                    ; 0088C6B6: dc.w $11FC
        dc.w    $0000                    ; 0088C6B8: dc.w $0000
        dc.w    $C8F4                    ; 0088C6BA: dc.w $C8F4
        dc.w    $08B8                    ; 0088C6BC: dc.w $08B8
        dc.w    $0007                    ; 0088C6BE: dc.w $0007
        dc.w    $C81C                    ; 0088C6C0: dc.w $C81C
        dc.w    $23FC, $0089, $4262, $00FF, $0002  ; 0088C6C2: MOVE.L #$00894262,$00FF0002
        dc.w    $33FC                    ; 0088C6CC: dc.w $33FC
        dc.w    $0020                    ; 0088C6CE: dc.w $0020
        dc.w    $00FF                    ; 0088C6D0: dc.w $00FF
        dc.w    $0008                    ; 0088C6D2: dc.w $0008
        dc.w    $4EF9, $0088, $2890    ; 0088C6D4: JMP $00882890
        dc.w    $43F9, $008B, $B45C    ; 0088C6DA: LEA $008BB45C,A1
        dc.w    $45F8                    ; 0088C6E0: dc.w $45F8
        dc.w    $B000                    ; 0088C6E2: dc.w $B000
        dc.w    $4EBA                    ; 0088C6E4: dc.w $4EBA
        dc.w    $8204                    ; 0088C6E6: dc.w $8204
        dc.w    $43F9, $008B, $AFC4    ; 0088C6E8: LEA $008BAFC4,A1
        dc.w    $45F8                    ; 0088C6EE: dc.w $45F8
        dc.w    $B400                    ; 0088C6F0: dc.w $B400
        dc.w    $4EBA                    ; 0088C6F2: dc.w $4EBA
        dc.w    $81DE                    ; 0088C6F4: dc.w $81DE
        dc.w    $43F9, $008B, $A220    ; 0088C6F6: LEA $008BA220,A1
        dc.w    $3038                    ; 0088C6FC: dc.w $3038
        dc.w    $C8A0                    ; 0088C6FE: dc.w $C8A0
        dc.w    $2271                    ; 0088C700: dc.w $2271
        dc.w    $0000                    ; 0088C702: dc.w $0000
        dc.w    $45F9, $00FF, $6E00    ; 0088C704: LEA $00FF6E00,A2
        dc.w    $4EBA                    ; 0088C70A: dc.w $4EBA
        dc.w    $81C6                    ; 0088C70C: dc.w $81C6
        dc.w    $43F9, $008B, $AE38    ; 0088C70E: LEA $008BAE38,A1
        dc.w    $3038                    ; 0088C714: dc.w $3038
        dc.w    $C8CC                    ; 0088C716: dc.w $C8CC
        dc.w    $2271                    ; 0088C718: dc.w $2271
        dc.w    $0000                    ; 0088C71A: dc.w $0000
        dc.w    $45F9, $00FF, $6E40    ; 0088C71C: LEA $00FF6E40,A2
        dc.w    $4EBA                    ; 0088C722: dc.w $4EBA
        dc.w    $81C6                    ; 0088C724: dc.w $81C6
        dc.w    $11FC                    ; 0088C726: dc.w $11FC
        dc.w    $0003                    ; 0088C728: dc.w $0003
        dc.w    $C80A                    ; 0088C72A: dc.w $C80A
        dc.w    $45F8                    ; 0088C72C: dc.w $45F8
        dc.w    $C200                    ; 0088C72E: dc.w $C200
        dc.w    $43F8                    ; 0088C730: dc.w $43F8
        dc.w    $EEE0                    ; 0088C732: dc.w $EEE0
        dc.w    $4EB9, $0088, $4920    ; 0088C734: JSR $00884920
        dc.w    $21F8                    ; 0088C73A: dc.w $21F8
        dc.w    $EEFC                    ; 0088C73C: dc.w $EEFC
        dc.w    $C254                    ; 0088C73E: dc.w $C254
        dc.w    $31FC                    ; 0088C740: dc.w $31FC
        dc.w    $00C0                    ; 0088C742: dc.w $00C0
        dc.w    $C054                    ; 0088C744: dc.w $C054
        dc.w    $31FC                    ; 0088C746: dc.w $31FC
        dc.w    $0540                    ; 0088C748: dc.w $0540
        dc.w    $C056                    ; 0088C74A: dc.w $C056
        dc.w    $31FC                    ; 0088C74C: dc.w $31FC
        dc.w    $0000                    ; 0088C74E: dc.w $0000
        dc.w    $C896                    ; 0088C750: dc.w $C896
        dc.w    $4EBA                    ; 0088C752: dc.w $4EBA
        dc.w    $A808                    ; 0088C754: dc.w $A808
        dc.w    $4EBA                    ; 0088C756: dc.w $4EBA
        dc.w    $C166                    ; 0088C758: dc.w $C166
        dc.w    $31FC                    ; 0088C75A: dc.w $31FC
        dc.w    $00C0                    ; 0088C75C: dc.w $00C0
        dc.w    $C0C8                    ; 0088C75E: dc.w $C0C8
        dc.w    $31FC                    ; 0088C760: dc.w $31FC
        dc.w    $07D0                    ; 0088C762: dc.w $07D0
        dc.w    $C8D4                    ; 0088C764: dc.w $C8D4
        dc.w    $31FC                    ; 0088C766: dc.w $31FC
        dc.w    $0600                    ; 0088C768: dc.w $0600
        dc.w    $C8D6                    ; 0088C76A: dc.w $C8D6
        dc.w    $31FC                    ; 0088C76C: dc.w $31FC
        dc.w    $3000                    ; 0088C76E: dc.w $3000
        dc.w    $C8D8                    ; 0088C770: dc.w $C8D8
        dc.w    $31FC                    ; 0088C772: dc.w $31FC
        dc.w    $0000                    ; 0088C774: dc.w $0000
        dc.w    $C8DA                    ; 0088C776: dc.w $C8DA
        dc.w    $31FC                    ; 0088C778: dc.w $31FC
        dc.w    $00C0                    ; 0088C77A: dc.w $00C0
        dc.w    $C8DC                    ; 0088C77C: dc.w $C8DC
        dc.w    $31FC                    ; 0088C77E: dc.w $31FC
        dc.w    $0540                    ; 0088C780: dc.w $0540
        dc.w    $C8DE                    ; 0088C782: dc.w $C8DE
        dc.w    $48E7, $FFFE            ; 0088C784: MOVEM.L regs,-(SP)
        dc.w    $7200                    ; 0088C788: MOVEQ #$00,D1
        dc.w    $43FA                    ; 0088C78A: dc.w $43FA
        dc.w    $0036                    ; 0088C78C: dc.w $0036
        dc.w    $45F8                    ; 0088C78E: dc.w $45F8
        dc.w    $9100                    ; 0088C790: dc.w $9100
        dc.w    $700E                    ; 0088C792: MOVEQ #$0E,D0
        dc.w    $3551                    ; 0088C794: dc.w $3551
        dc.w    $00B6                    ; 0088C796: dc.w $00B6
        dc.w    $3559                    ; 0088C798: dc.w $3559
        dc.w    $000A                    ; 0088C79A: dc.w $000A
        dc.w    $45EA                    ; 0088C79C: dc.w $45EA
        dc.w    $0100                    ; 0088C79E: dc.w $0100
        dc.w    $51C8, $FFF2            ; 0088C7A0: DBRA D0,$0088C794
        dc.w    $21FC                    ; 0088C7A4: dc.w $21FC
        dc.w    $0088                    ; 0088C7A6: dc.w $0088
        dc.w    $C7E0                    ; 0088C7A8: dc.w $C7E0
        dc.w    $C280                    ; 0088C7AA: dc.w $C280
        dc.w    $41F9, $0093, $C0EC    ; 0088C7AC: LEA $0093C0EC,A0
        dc.w    $3278                    ; 0088C7B2: dc.w $3278
        dc.w    $C8C0                    ; 0088C7B4: dc.w $C8C0
        dc.w    $4EB9, $0088, $13B4    ; 0088C7B6: JSR $008813B4
        dc.w    $4CDF, $7FFF            ; 0088C7BC: MOVEM.L (SP)+,regs
        dc.w    $4E75                    ; 0088C7C0: RTS
        dc.w    $04A9                    ; 0088C7C2: dc.w $04A9
        dc.w    $0483                    ; 0088C7C4: dc.w $0483
        dc.w    $0471                    ; 0088C7C6: dc.w $0471
        dc.w    $046E                    ; 0088C7C8: dc.w $046E
        dc.w    $0462                    ; 0088C7CA: dc.w $0462
        dc.w    $0456                    ; 0088C7CC: dc.w $0456
        dc.w    $0444                    ; 0088C7CE: dc.w $0444
        dc.w    $0433                    ; 0088C7D0: dc.w $0433
        dc.w    $0429                    ; 0088C7D2: dc.w $0429
        dc.w    $040E                    ; 0088C7D4: dc.w $040E
        dc.w    $03F3                    ; 0088C7D6: dc.w $03F3
        dc.w    $03E2                    ; 0088C7D8: dc.w $03E2
        dc.w    $03D7                    ; 0088C7DA: dc.w $03D7
        dc.w    $03C1                    ; 0088C7DC: dc.w $03C1
        dc.w    $03C0                    ; 0088C7DE: dc.w $03C0
        dc.w    $003A                    ; 0088C7E0: dc.w $003A
        dc.w    $0050                    ; 0088C7E2: dc.w $0050
        dc.w    $0064                    ; 0088C7E4: dc.w $0064
        dc.w    $0083                    ; 0088C7E6: dc.w $0083
        dc.w    $41F9, $0089, $AF3C    ; 0088C7E8: LEA $0089AF3C,A0
        dc.w    $43F8                    ; 0088C7EE: dc.w $43F8
        dc.w    $EF08                    ; 0088C7F0: dc.w $EF08
        dc.w    $4EB9, $0088, $13B4    ; 0088C7F2: JSR $008813B4
        dc.w    $43F9, $0089, $B6AC    ; 0088C7F8: LEA $0089B6AC,A1
        dc.w    $45F8                    ; 0088C7FE: dc.w $45F8
        dc.w    $FA48                    ; 0088C800: dc.w $FA48
        dc.w    $4EBA                    ; 0088C802: dc.w $4EBA
        dc.w    $80E6                    ; 0088C804: dc.w $80E6
        dc.w    $4EBA                    ; 0088C806: dc.w $4EBA
        dc.w    $811A                    ; 0088C808: dc.w $811A
        dc.w    $43F9, $0089, $B73C    ; 0088C80A: LEA $0089B73C,A1
        dc.w    $45F8                    ; 0088C810: dc.w $45F8
        dc.w    $FDAA                    ; 0088C812: dc.w $FDAA
        dc.w    $7E35                    ; 0088C814: MOVEQ #$35,D7
        dc.w    $24D9                    ; 0088C816: dc.w $24D9
        dc.w    $51CF, $FFFC            ; 0088C818: DBRA D7,$0088C816
        dc.w    $7000                    ; 0088C81C: MOVEQ #$00,D0
        dc.w    $11C0                    ; 0088C81E: dc.w $11C0
        dc.w    $FEA5                    ; 0088C820: dc.w $FEA5
        dc.w    $11C0                    ; 0088C822: dc.w $11C0
        dc.w    $FEA6                    ; 0088C824: dc.w $FEA6
        dc.w    $11C0                    ; 0088C826: dc.w $11C0
        dc.w    $FEAB                    ; 0088C828: dc.w $FEAB
        dc.w    $11C0                    ; 0088C82A: dc.w $11C0
        dc.w    $FEA7                    ; 0088C82C: dc.w $FEA7
        dc.w    $11C0                    ; 0088C82E: dc.w $11C0
        dc.w    $FDA8                    ; 0088C830: dc.w $FDA8
        dc.w    $11C0                    ; 0088C832: dc.w $11C0
        dc.w    $EF07                    ; 0088C834: dc.w $EF07
        dc.w    $11C0                    ; 0088C836: dc.w $11C0
        dc.w    $FEB7                    ; 0088C838: dc.w $FEB7
        dc.w    $11C0                    ; 0088C83A: dc.w $11C0
        dc.w    $FEB1                    ; 0088C83C: dc.w $FEB1
        dc.w    $11FC                    ; 0088C83E: dc.w $11FC
        dc.w    $0002                    ; 0088C840: dc.w $0002
        dc.w    $FEAD                    ; 0088C842: dc.w $FEAD
        dc.w    $11FC                    ; 0088C844: dc.w $11FC
        dc.w    $0002                    ; 0088C846: dc.w $0002
        dc.w    $FEAE                    ; 0088C848: dc.w $FEAE
        dc.w    $11FC                    ; 0088C84A: dc.w $11FC
        dc.w    $00FF                    ; 0088C84C: dc.w $00FF
        dc.w    $FEA4                    ; 0088C84E: dc.w $FEA4
        dc.w    $11FC                    ; 0088C850: dc.w $11FC
        dc.w    $0000                    ; 0088C852: dc.w $0000
        dc.w    $C825                    ; 0088C854: dc.w $C825
        dc.w    $4EF9, $0088, $A83E    ; 0088C856: JMP $0088A83E
        dc.w    $7200                    ; 0088C85C: MOVEQ #$00,D1
        dc.w    $43F9, $00FF, $6000    ; 0088C85E: LEA $00FF6000,A1
        dc.w    $4EB9, $0088, $4836    ; 0088C864: JSR $00884836
        dc.w    $4EF9, $0088, $483E    ; 0088C86A: JMP $0088483E
        dc.w    $61EA                    ; 0088C870: BSR.S $0088C85C
        dc.w    $3038                    ; 0088C872: dc.w $3038
        dc.w    $C8CC                    ; 0088C874: dc.w $C8CC
        dc.w    $43F9, $0089, $5488    ; 0088C876: LEA $00895488,A1
        dc.w    $2271                    ; 0088C87C: dc.w $2271
        dc.w    $0000                    ; 0088C87E: dc.w $0000
        dc.w    $4A38                    ; 0088C880: dc.w $4A38
        dc.w    $C80F                    ; 0088C882: dc.w $C80F
        dc.w    $6720                    ; 0088C884: BEQ.S $0088C8A6
        dc.w    $43F9, $0089, $5560    ; 0088C886: LEA $00895560,A1
        dc.w    $2271                    ; 0088C88C: dc.w $2271
        dc.w    $0000                    ; 0088C88E: dc.w $0000
        dc.w    $45F9, $00FF, $6330    ; 0088C890: LEA $00FF6330,A2
        dc.w    $4EB9, $0088, $4920    ; 0088C896: JSR $00884920
        dc.w    $43F9, $0089, $54F4    ; 0088C89C: LEA $008954F4,A1
        dc.w    $2271                    ; 0088C8A2: dc.w $2271
        dc.w    $0000                    ; 0088C8A4: dc.w $0000
        dc.w    $45F9, $00FF, $6100    ; 0088C8A6: LEA $00FF6100,A2
        dc.w    $4EB9, $0088, $4920    ; 0088C8AC: JSR $00884920
        dc.w    $31D9                    ; 0088C8B2: dc.w $31D9
        dc.w    $C054                    ; 0088C8B4: dc.w $C054
        dc.w    $31D9                    ; 0088C8B6: dc.w $31D9
        dc.w    $C056                    ; 0088C8B8: dc.w $C056
        dc.w    $21D9                    ; 0088C8BA: dc.w $21D9
        dc.w    $C0C8                    ; 0088C8BC: dc.w $C0C8
        dc.w    $31D9                    ; 0088C8BE: dc.w $31D9
        dc.w    $C0CC                    ; 0088C8C0: dc.w $C0CC
        dc.w    $33D1                    ; 0088C8C2: dc.w $33D1
        dc.w    $00FF                    ; 0088C8C4: dc.w $00FF
        dc.w    $60CC                    ; 0088C8C6: BRA.S $0088C894
        dc.w    $33FC                    ; 0088C8C8: dc.w $33FC
        dc.w    $0070                    ; 0088C8CA: dc.w $0070
        dc.w    $00FF                    ; 0088C8CC: dc.w $00FF
        dc.w    $60CE                    ; 0088C8CE: BRA.S $0088C89E
        dc.w    $43F8                    ; 0088C8D0: dc.w $43F8
        dc.w    $C0AE                    ; 0088C8D2: dc.w $C0AE
        dc.w    $7200                    ; 0088C8D4: MOVEQ #$00,D1
        dc.w    $22C1                    ; 0088C8D6: dc.w $22C1
        dc.w    $22C1                    ; 0088C8D8: dc.w $22C1
        dc.w    $2281                    ; 0088C8DA: dc.w $2281
        dc.w    $21FC                    ; 0088C8DC: dc.w $21FC
        dc.w    $00FF                    ; 0088C8DE: dc.w $00FF
        dc.w    $9000                    ; 0088C8E0: dc.w $9000
        dc.w    $C888                    ; 0088C8E2: dc.w $C888
        dc.w    $4E75                    ; 0088C8E4: RTS
        dc.w    $5400                    ; 0088C8E6: dc.w $5400
        dc.w    $5500                    ; 0088C8E8: dc.w $5500
        dc.w    $5A00                    ; 0088C8EA: dc.w $5A00
        dc.w    $5B00                    ; 0088C8EC: dc.w $5B00
        dc.w    $4A00                    ; 0088C8EE: dc.w $4A00
        dc.w    $4B00                    ; 0088C8F0: dc.w $4B00
        dc.w    $3038                    ; 0088C8F2: dc.w $3038
        dc.w    $C8CC                    ; 0088C8F4: dc.w $C8CC
        dc.w    $33FB                    ; 0088C8F6: dc.w $33FB
        dc.w    $00EE                    ; 0088C8F8: dc.w $00EE
        dc.w    $00FF                    ; 0088C8FA: dc.w $00FF
        dc.w    $6122                    ; 0088C8FC: BSR.S $0088C920
        dc.w    $33FB                    ; 0088C8FE: dc.w $33FB
        dc.w    $00E8                    ; 0088C900: dc.w $00E8
        dc.w    $00FF                    ; 0088C902: dc.w $00FF
        dc.w    $6352                    ; 0088C904: BLS.S $0088C958
        dc.w    $43F9, $0089, $57A0    ; 0088C906: LEA $008957A0,A1
        dc.w    $6154                    ; 0088C90C: BSR.S $0088C962
        dc.w    $43F9, $00FF, $6114    ; 0088C90E: LEA $00FF6114,A1
        dc.w    $49F9, $0089, $57A0    ; 0088C914: LEA $008957A0,A4
        dc.w    $616A                    ; 0088C91A: BSR.S $0088C986
        dc.w    $4EBA                    ; 0088C91C: dc.w $4EBA
        dc.w    $0090                    ; 0088C91E: dc.w $0090
        dc.w    $43F9, $00FF, $6218    ; 0088C920: LEA $00FF6218,A1
        dc.w    $49F9, $0089, $57A0    ; 0088C926: LEA $008957A0,A4
        dc.w    $6158                    ; 0088C92C: BSR.S $0088C986
        dc.w    $23F8                    ; 0088C92E: dc.w $23F8
        dc.w    $C754                    ; 0088C930: dc.w $C754
        dc.w    $00FF                    ; 0088C932: dc.w $00FF
        dc.w    $6228                    ; 0088C934: BHI.S $0088C95E
        dc.w    $43F9, $00FF, $6344    ; 0088C936: LEA $00FF6344,A1
        dc.w    $49F9, $0089, $57A0    ; 0088C93C: LEA $008957A0,A4
        dc.w    $6142                    ; 0088C942: BSR.S $0088C986
        dc.w    $6168                    ; 0088C944: BSR.S $0088C9AE
        dc.w    $23F8                    ; 0088C946: dc.w $23F8
        dc.w    $C754                    ; 0088C948: dc.w $C754
        dc.w    $00FF                    ; 0088C94A: dc.w $00FF
        dc.w    $6354                    ; 0088C94C: BLS.S $0088C9A2
        dc.w    $43F9, $00FF, $6448    ; 0088C94E: LEA $00FF6448,A1
        dc.w    $49F9, $0089, $57A0    ; 0088C954: LEA $008957A0,A4
        dc.w    $602A                    ; 0088C95A: BRA.S $0088C986
        dc.w    $43F9, $0089, $56C8    ; 0088C95C: LEA $008956C8,A1
        dc.w    $3038                    ; 0088C962: dc.w $3038
        dc.w    $C8CC                    ; 0088C964: dc.w $C8CC
        dc.w    $2271                    ; 0088C966: dc.w $2271
        dc.w    $0000                    ; 0088C968: dc.w $0000
        dc.w    $45F8                    ; 0088C96A: dc.w $45F8
        dc.w    $C710                    ; 0088C96C: dc.w $C710
        dc.w    $4EF9, $0088, $48FE    ; 0088C96E: JMP $008848FE
        dc.w    $61E6                    ; 0088C974: BSR.S $0088C95C
        dc.w    $43F9, $00FF, $6114    ; 0088C976: LEA $00FF6114,A1
        dc.w    $6102                    ; 0088C97C: BSR.S $0088C980
        dc.w    $602E                    ; 0088C97E: BRA.S $0088C9AE
        dc.w    $49F9, $0089, $56C8    ; 0088C980: LEA $008956C8,A4
        dc.w    $2678                    ; 0088C986: dc.w $2678
        dc.w    $C734                    ; 0088C988: dc.w $C734
        dc.w    $3038                    ; 0088C98A: dc.w $3038
        dc.w    $C8CC                    ; 0088C98C: dc.w $C8CC
        dc.w    $2874                    ; 0088C98E: dc.w $2874
        dc.w    $0000                    ; 0088C990: dc.w $0000
        dc.w    $7001                    ; 0088C992: MOVEQ #$01,D0
        dc.w    $3280                    ; 0088C994: dc.w $3280
        dc.w    $43E9                    ; 0088C996: dc.w $43E9
        dc.w    $0010                    ; 0088C998: dc.w $0010
        dc.w    $22DC                    ; 0088C99A: dc.w $22DC
        dc.w    $6104                    ; 0088C99C: BSR.S $0088C9A2
        dc.w    $6102                    ; 0088C99E: BSR.S $0088C9A2
        dc.w    $4E71                    ; 0088C9A0: NOP
        dc.w    $32C0                    ; 0088C9A2: dc.w $32C0
        dc.w    $22DB                    ; 0088C9A4: dc.w $22DB
        dc.w    $32DB                    ; 0088C9A6: dc.w $32DB
        dc.w    $5089                    ; 0088C9A8: dc.w $5089
        dc.w    $22DC                    ; 0088C9AA: dc.w $22DC
        dc.w    $4E75                    ; 0088C9AC: RTS
        dc.w    $3280                    ; 0088C9AE: dc.w $3280
        dc.w    $235C                    ; 0088C9B0: dc.w $235C
        dc.w    $0010                    ; 0088C9B2: dc.w $0010
        dc.w    $4E75                    ; 0088C9B4: RTS
        dc.w    $43F9, $0089, $8C80    ; 0088C9B6: LEA $00898C80,A1
        dc.w    $0838                    ; 0088C9BC: dc.w $0838
        dc.w    $0003                    ; 0088C9BE: dc.w $0003
        dc.w    $C80E                    ; 0088C9C0: dc.w $C80E
        dc.w    $6706                    ; 0088C9C2: BEQ.S $0088C9CA
        dc.w    $43F9, $0089, $8F00    ; 0088C9C4: LEA $00898F00,A1
        dc.w    $45F9, $00FF, $6800    ; 0088C9CA: LEA $00FF6800,A2
        dc.w    $701F                    ; 0088C9D0: MOVEQ #$1F,D0
        dc.w    $24D9                    ; 0088C9D2: dc.w $24D9
        dc.w    $24D9                    ; 0088C9D4: dc.w $24D9
        dc.w    $24D9                    ; 0088C9D6: dc.w $24D9
        dc.w    $24D9                    ; 0088C9D8: dc.w $24D9
        dc.w    $51C8, $FFF6            ; 0088C9DA: DBRA D0,$0088C9D2
        dc.w    $4E75                    ; 0088C9DE: RTS
        dc.w    $43F9, $0089, $9500    ; 0088C9E0: LEA $00899500,A1
        dc.w    $45F9, $00FF, $6800    ; 0088C9E6: LEA $00FF6800,A2
        dc.w    $701F                    ; 0088C9EC: MOVEQ #$1F,D0
        dc.w    $60E2                    ; 0088C9EE: BRA.S $0088C9D2
        dc.w    $43F9, $0089, $9100    ; 0088C9F0: LEA $00899100,A1
        dc.w    $45F9, $00FF, $6800    ; 0088C9F6: LEA $00FF6800,A2
        dc.w    $701F                    ; 0088C9FC: MOVEQ #$1F,D0
        dc.w    $60D2                    ; 0088C9FE: BRA.S $0088C9D2
        dc.w    $43F9, $0089, $9300    ; 0088CA00: LEA $00899300,A1
        dc.w    $45F9, $00FF, $6800    ; 0088CA06: LEA $00FF6800,A2
        dc.w    $701F                    ; 0088CA0C: MOVEQ #$1F,D0
        dc.w    $60C2                    ; 0088CA0E: BRA.S $0088C9D2
        dc.w    $43F9, $0089, $9700    ; 0088CA10: LEA $00899700,A1
        dc.w    $45F9, $00FF, $6800    ; 0088CA16: LEA $00FF6800,A2
        dc.w    $7007                    ; 0088CA1C: MOVEQ #$07,D0
        dc.w    $60B2                    ; 0088CA1E: BRA.S $0088C9D2
        dc.w    $43F9, $0089, $8E80    ; 0088CA20: LEA $00898E80,A1
        dc.w    $45F9, $00FF, $6800    ; 0088CA26: LEA $00FF6800,A2
        dc.w    $7007                    ; 0088CA2C: MOVEQ #$07,D0
        dc.w    $61A2                    ; 0088CA2E: BSR.S $0088C9D2
        dc.w    $7200                    ; 0088CA30: MOVEQ #$00,D1
        dc.w    $7017                    ; 0088CA32: MOVEQ #$17,D0
        dc.w    $1481                    ; 0088CA34: dc.w $1481
        dc.w    $45EA                    ; 0088CA36: dc.w $45EA
        dc.w    $0010                    ; 0088CA38: dc.w $0010
        dc.w    $51C8, $FFF8            ; 0088CA3A: DBRA D0,$0088CA34
        dc.w    $33C1                    ; 0088CA3E: dc.w $33C1
        dc.w    $00FF                    ; 0088CA40: dc.w $00FF
        dc.w    $6740                    ; 0088CA42: BEQ.S $0088CA84
        dc.w    $33C1                    ; 0088CA44: dc.w $33C1
        dc.w    $00FF                    ; 0088CA46: dc.w $00FF
        dc.w    $672C                    ; 0088CA48: BEQ.S $0088CA76
        dc.w    $4E75                    ; 0088CA4A: RTS
        dc.w    $13FC                    ; 0088CA4C: dc.w $13FC
        dc.w    $0004                    ; 0088CA4E: dc.w $0004
        dc.w    $00FF                    ; 0088CA50: dc.w $00FF
        dc.w    $6920                    ; 0088CA52: BVS.S $0088CA74
        dc.w    $13FC                    ; 0088CA54: dc.w $13FC
        dc.w    $0001                    ; 0088CA56: dc.w $0001
        dc.w    $00FF                    ; 0088CA58: dc.w $00FF
        dc.w    $6880                    ; 0088CA5A: BVC.S $0088C9DC
        dc.w    $13FC                    ; 0088CA5C: dc.w $13FC
        dc.w    $0001                    ; 0088CA5E: dc.w $0001
        dc.w    $00FF                    ; 0088CA60: dc.w $00FF
        dc.w    $69A0                    ; 0088CA62: BVS.S $0088CA04
        dc.w    $4E75                    ; 0088CA64: RTS
        dc.w    $13FC                    ; 0088CA66: dc.w $13FC
        dc.w    $0004                    ; 0088CA68: dc.w $0004
        dc.w    $00FF                    ; 0088CA6A: dc.w $00FF
        dc.w    $6920                    ; 0088CA6C: BVS.S $0088CA8E
        dc.w    $13FC                    ; 0088CA6E: dc.w $13FC
        dc.w    $0001                    ; 0088CA70: dc.w $0001
        dc.w    $00FF                    ; 0088CA72: dc.w $00FF
        dc.w    $6880                    ; 0088CA74: BVC.S $0088C9F6
        dc.w    $13FC                    ; 0088CA76: dc.w $13FC
        dc.w    $0001                    ; 0088CA78: dc.w $0001
        dc.w    $00FF                    ; 0088CA7A: dc.w $00FF
        dc.w    $6800, $4E75            ; 0088CA7C: BVC.W $008918F3
        dc.w    $13FC                    ; 0088CA80: dc.w $13FC
        dc.w    $0004                    ; 0088CA82: dc.w $0004
        dc.w    $00FF                    ; 0088CA84: dc.w $00FF
        dc.w    $6910                    ; 0088CA86: BVS.S $0088CA98
        dc.w    $13FC                    ; 0088CA88: dc.w $13FC
        dc.w    $0001                    ; 0088CA8A: dc.w $0001
        dc.w    $00FF                    ; 0088CA8C: dc.w $00FF
        dc.w    $6870                    ; 0088CA8E: BVC.S $0088CB00
        dc.w    $13FC                    ; 0088CA90: dc.w $13FC
        dc.w    $0001                    ; 0088CA92: dc.w $0001
        dc.w    $00FF                    ; 0088CA94: dc.w $00FF
        dc.w    $69D0                    ; 0088CA96: BVS.S $0088CA68
        dc.w    $4E75                    ; 0088CA98: RTS
        dc.w    $6134                    ; 0088CA9A: BSR.S $0088CAD0
        dc.w    $4EFA                    ; 0088CA9C: dc.w $4EFA
        dc.w    $012C                    ; 0088CA9E: dc.w $012C
        dc.w    $612E                    ; 0088CAA0: BSR.S $0088CAD0
        dc.w    $33FC                    ; 0088CAA2: dc.w $33FC
        dc.w    $004E                    ; 0088CAA4: dc.w $004E
        dc.w    $00FF                    ; 0088CAA6: dc.w $00FF
        dc.w    $6744                    ; 0088CAA8: BEQ.S $0088CAEE
        dc.w    $3038                    ; 0088CAAA: dc.w $3038
        dc.w    $C8C8                    ; 0088CAAC: dc.w $C8C8
        dc.w    $6700, $011A            ; 0088CAAE: BEQ.W $0088CBCA
        dc.w    $0C40                    ; 0088CAB2: dc.w $0C40
        dc.w    $0001                    ; 0088CAB4: dc.w $0001
        dc.w    $660C                    ; 0088CAB6: BNE.S $0088CAC4
        dc.w    $33FC                    ; 0088CAB8: dc.w $33FC
        dc.w    $0050                    ; 0088CABA: dc.w $0050
        dc.w    $00FF                    ; 0088CABC: dc.w $00FF
        dc.w    $6744                    ; 0088CABE: BEQ.S $0088CB04
        dc.w    $4EFA                    ; 0088CAC0: dc.w $4EFA
        dc.w    $0108                    ; 0088CAC2: dc.w $0108
        dc.w    $33FC                    ; 0088CAC4: dc.w $33FC
        dc.w    $0050                    ; 0088CAC6: dc.w $0050
        dc.w    $00FF                    ; 0088CAC8: dc.w $00FF
        dc.w    $6744                    ; 0088CACA: BEQ.S $0088CB10
        dc.w    $4EFA                    ; 0088CACC: dc.w $4EFA
        dc.w    $00FC                    ; 0088CACE: dc.w $00FC
        dc.w    $3038                    ; 0088CAD0: dc.w $3038
        dc.w    $C8CC                    ; 0088CAD2: dc.w $C8CC
        dc.w    $43F9, $0089, $8C68    ; 0088CAD4: LEA $00898C68,A1
        dc.w    $23F1                    ; 0088CADA: dc.w $23F1
        dc.w    $0000                    ; 0088CADC: dc.w $0000
        dc.w    $00FF                    ; 0088CADE: dc.w $00FF
        dc.w    $6858                    ; 0088CAE0: BVC.S $0088CB3A
        dc.w    $43FA                    ; 0088CAE2: dc.w $43FA
        dc.w    $0012                    ; 0088CAE4: dc.w $0012
        dc.w    $2271                    ; 0088CAE6: dc.w $2271
        dc.w    $0000                    ; 0088CAE8: dc.w $0000
        dc.w    $45F9, $00FF, $6740    ; 0088CAEA: LEA $00FF6740,A2
        dc.w    $4EF9, $0088, $4920    ; 0088CAF0: JMP $00884920
        dc.w    $0088                    ; 0088CAF6: dc.w $0088
        dc.w    $CB02                    ; 0088CAF8: dc.w $CB02
        dc.w    $0088                    ; 0088CAFA: dc.w $0088
        dc.w    $CB16                    ; 0088CAFC: dc.w $CB16
        dc.w    $0088                    ; 0088CAFE: dc.w $0088
        dc.w    $CB2A                    ; 0088CB00: dc.w $CB2A
        dc.w    $0001                    ; 0088CB02: dc.w $0001
        dc.w    $FF6C                    ; 0088CB04: dc.w $FF6C
        dc.w    $0036                    ; 0088CB06: dc.w $0036
        dc.w    $0000                    ; 0088CB08: dc.w $0000
        dc.w    $0000                    ; 0088CB0A: dc.w $0000
        dc.w    $0000                    ; 0088CB0C: dc.w $0000
        dc.w    $0800                    ; 0088CB0E: dc.w $0800
        dc.w    $0087                    ; 0088CB10: dc.w $0087
        dc.w    $2229                    ; 0088CB12: dc.w $2229
        dc.w    $59D6                    ; 0088CB14: dc.w $59D6
        dc.w    $0001                    ; 0088CB16: dc.w $0001
        dc.w    $FF6C                    ; 0088CB18: dc.w $FF6C
        dc.w    $0038                    ; 0088CB1A: dc.w $0038
        dc.w    $0000                    ; 0088CB1C: dc.w $0000
        dc.w    $0000                    ; 0088CB1E: dc.w $0000
        dc.w    $0000                    ; 0088CB20: dc.w $0000
        dc.w    $0800                    ; 0088CB22: dc.w $0800
        dc.w    $0084                    ; 0088CB24: dc.w $0084
        dc.w    $2229                    ; 0088CB26: dc.w $2229
        dc.w    $59D6                    ; 0088CB28: dc.w $59D6
        dc.w    $0001                    ; 0088CB2A: dc.w $0001
        dc.w    $FF6F                    ; 0088CB2C: dc.w $FF6F
        dc.w    $0038                    ; 0088CB2E: dc.w $0038
        dc.w    $0000                    ; 0088CB30: dc.w $0000
        dc.w    $0000                    ; 0088CB32: dc.w $0000
        dc.w    $0000                    ; 0088CB34: dc.w $0000
        dc.w    $0800                    ; 0088CB36: dc.w $0800
        dc.w    $0084                    ; 0088CB38: dc.w $0084
        dc.w    $2229                    ; 0088CB3A: dc.w $2229
        dc.w    $59D6                    ; 0088CB3C: dc.w $59D6
        dc.w    $3038                    ; 0088CB3E: dc.w $3038
        dc.w    $C8CC                    ; 0088CB40: dc.w $C8CC
        dc.w    $43F9, $0089, $8C74    ; 0088CB42: LEA $00898C74,A1
        dc.w    $23F1                    ; 0088CB48: dc.w $23F1
        dc.w    $0000                    ; 0088CB4A: dc.w $0000
        dc.w    $00FF                    ; 0088CB4C: dc.w $00FF
        dc.w    $6858                    ; 0088CB4E: BVC.S $0088CBA8
        dc.w    $23F1                    ; 0088CB50: dc.w $23F1
        dc.w    $0000                    ; 0088CB52: dc.w $0000
        dc.w    $00FF                    ; 0088CB54: dc.w $00FF
        dc.w    $69B8                    ; 0088CB56: BVS.S $0088CB10
        dc.w    $43FA                    ; 0088CB58: dc.w $43FA
        dc.w    $0028                    ; 0088CB5A: dc.w $0028
        dc.w    $2271                    ; 0088CB5C: dc.w $2271
        dc.w    $0000                    ; 0088CB5E: dc.w $0000
        dc.w    $45F9, $00FF, $631C    ; 0088CB60: LEA $00FF631C,A2
        dc.w    $4EB9, $0088, $4920    ; 0088CB66: JSR $00884920
        dc.w    $43FA                    ; 0088CB6C: dc.w $43FA
        dc.w    $0014                    ; 0088CB6E: dc.w $0014
        dc.w    $2271                    ; 0088CB70: dc.w $2271
        dc.w    $0000                    ; 0088CB72: dc.w $0000
        dc.w    $45F9, $00FF, $654C    ; 0088CB74: LEA $00FF654C,A2
        dc.w    $4EB9, $0088, $4920    ; 0088CB7A: JSR $00884920
        dc.w    $6048                    ; 0088CB80: BRA.S $0088CBCA
        dc.w    $0088                    ; 0088CB82: dc.w $0088
        dc.w    $CB8E                    ; 0088CB84: dc.w $CB8E
        dc.w    $0088                    ; 0088CB86: dc.w $0088
        dc.w    $CBA2                    ; 0088CB88: dc.w $CBA2
        dc.w    $0088                    ; 0088CB8A: dc.w $0088
        dc.w    $CBB6                    ; 0088CB8C: dc.w $CBB6
        dc.w    $0001                    ; 0088CB8E: dc.w $0001
        dc.w    $FF72                    ; 0088CB90: dc.w $FF72
        dc.w    $002B                    ; 0088CB92: dc.w $002B
        dc.w    $0000                    ; 0088CB94: dc.w $0000
        dc.w    $0000                    ; 0088CB96: dc.w $0000
        dc.w    $0000                    ; 0088CB98: dc.w $0000
        dc.w    $0800                    ; 0088CB9A: dc.w $0800
        dc.w    $006C                    ; 0088CB9C: dc.w $006C
        dc.w    $2229                    ; 0088CB9E: dc.w $2229
        dc.w    $59D6                    ; 0088CBA0: dc.w $59D6
        dc.w    $0001                    ; 0088CBA2: dc.w $0001
        dc.w    $FF6C                    ; 0088CBA4: dc.w $FF6C
        dc.w    $002C                    ; 0088CBA6: dc.w $002C
        dc.w    $0000                    ; 0088CBA8: dc.w $0000
        dc.w    $0000                    ; 0088CBAA: dc.w $0000
        dc.w    $0000                    ; 0088CBAC: dc.w $0000
        dc.w    $0800                    ; 0088CBAE: dc.w $0800
        dc.w    $0072                    ; 0088CBB0: dc.w $0072
        dc.w    $2229                    ; 0088CBB2: dc.w $2229
        dc.w    $59D6                    ; 0088CBB4: dc.w $59D6
        dc.w    $0001                    ; 0088CBB6: dc.w $0001
        dc.w    $FF73                    ; 0088CBB8: dc.w $FF73
        dc.w    $002C                    ; 0088CBBA: dc.w $002C
        dc.w    $0000                    ; 0088CBBC: dc.w $0000
        dc.w    $0000                    ; 0088CBBE: dc.w $0000
        dc.w    $0000                    ; 0088CBC0: dc.w $0000
        dc.w    $0800                    ; 0088CBC2: dc.w $0800
        dc.w    $006B                    ; 0088CBC4: dc.w $006B
        dc.w    $2229                    ; 0088CBC6: dc.w $2229
        dc.w    $59D6                    ; 0088CBC8: dc.w $59D6
        dc.w    $3038                    ; 0088CBCA: dc.w $3038
        dc.w    $C8A0                    ; 0088CBCC: dc.w $C8A0
        dc.w    $E548                    ; 0088CBCE: dc.w $E548
        dc.w    $43F9, $0089, $5668    ; 0088CBD0: LEA $00895668,A1
        dc.w    $43F1                    ; 0088CBD6: dc.w $43F1
        dc.w    $0000                    ; 0088CBD8: dc.w $0000
        dc.w    $45F9, $00FF, $672C    ; 0088CBDA: LEA $00FF672C,A2
        dc.w    $357C                    ; 0088CBE0: dc.w $357C
        dc.w    $0001                    ; 0088CBE2: dc.w $0001
        dc.w    $0000                    ; 0088CBE4: dc.w $0000
        dc.w    $2559                    ; 0088CBE6: dc.w $2559
        dc.w    $0002                    ; 0088CBE8: dc.w $0002
        dc.w    $3559                    ; 0088CBEA: dc.w $3559
        dc.w    $0006                    ; 0088CBEC: dc.w $0006
        dc.w    $3559                    ; 0088CBEE: dc.w $3559
        dc.w    $000E                    ; 0088CBF0: dc.w $000E
        dc.w    $2551                    ; 0088CBF2: dc.w $2551
        dc.w    $0010                    ; 0088CBF4: dc.w $0010
        dc.w    $0838                    ; 0088CBF6: dc.w $0838
        dc.w    $0007                    ; 0088CBF8: dc.w $0007
        dc.w    $FDA8                    ; 0088CBFA: dc.w $FDA8
        dc.w    $6706                    ; 0088CBFC: BEQ.S $0088CC04
        dc.w    $066A                    ; 0088CBFE: dc.w $066A
        dc.w    $0020                    ; 0088CC00: dc.w $0020
        dc.w    $0002                    ; 0088CC02: dc.w $0002
        dc.w    $4E75                    ; 0088CC04: RTS
        dc.w    $49F9, $0089, $58B4    ; 0088CC06: LEA $008958B4,A4
        dc.w    $3238                    ; 0088CC0C: dc.w $3238
        dc.w    $C8CC                    ; 0088CC0E: dc.w $C8CC
        dc.w    $2874                    ; 0088CC10: dc.w $2874
        dc.w    $1000                    ; 0088CC12: dc.w $1000
        dc.w    $7001                    ; 0088CC14: MOVEQ #$01,D0
        dc.w    $43F9, $00FF, $6218    ; 0088CC16: LEA $00FF6218,A1
        dc.w    $7E0E                    ; 0088CC1C: MOVEQ #$0E,D7
        dc.w    $2478                    ; 0088CC1E: dc.w $2478
        dc.w    $C73C                    ; 0088CC20: dc.w $C73C
        dc.w    $264C                    ; 0088CC22: dc.w $264C
        dc.w    $3340                    ; 0088CC24: dc.w $3340
        dc.w    $0000                    ; 0088CC26: dc.w $0000
        dc.w    $3340                    ; 0088CC28: dc.w $3340
        dc.w    $0014                    ; 0088CC2A: dc.w $0014
        dc.w    $3340                    ; 0088CC2C: dc.w $3340
        dc.w    $0028                    ; 0088CC2E: dc.w $0028
        dc.w    $235B                    ; 0088CC30: dc.w $235B
        dc.w    $0010                    ; 0088CC32: dc.w $0010
        dc.w    $235B                    ; 0088CC34: dc.w $235B
        dc.w    $0024                    ; 0088CC36: dc.w $0024
        dc.w    $2353                    ; 0088CC38: dc.w $2353
        dc.w    $0038                    ; 0088CC3A: dc.w $0038
        dc.w    $235A                    ; 0088CC3C: dc.w $235A
        dc.w    $0016                    ; 0088CC3E: dc.w $0016
        dc.w    $335A                    ; 0088CC40: dc.w $335A
        dc.w    $001A                    ; 0088CC42: dc.w $001A
        dc.w    $235A                    ; 0088CC44: dc.w $235A
        dc.w    $002A                    ; 0088CC46: dc.w $002A
        dc.w    $3352                    ; 0088CC48: dc.w $3352
        dc.w    $002E                    ; 0088CC4A: dc.w $002E
        dc.w    $43E9                    ; 0088CC4C: dc.w $43E9
        dc.w    $003C                    ; 0088CC4E: dc.w $003C
        dc.w    $51CF, $FFCC            ; 0088CC50: DBRA D7,$0088CC1E
        dc.w    $43F9, $00FF, $6226    ; 0088CC54: LEA $00FF6226,A1
        dc.w    $45F9, $0093, $816C    ; 0088CC5A: LEA $0093816C,A2
        dc.w    $2472                    ; 0088CC60: dc.w $2472
        dc.w    $1000                    ; 0088CC62: dc.w $1000
        dc.w    $7E0E                    ; 0088CC64: MOVEQ #$0E,D7
        dc.w    $329A                    ; 0088CC66: dc.w $329A
        dc.w    $43E9                    ; 0088CC68: dc.w $43E9
        dc.w    $003C                    ; 0088CC6A: dc.w $003C
        dc.w    $51CF, $FFF8            ; 0088CC6C: DBRA D7,$0088CC66
        dc.w    $4E75                    ; 0088CC70: RTS
        dc.w    $4E75                    ; 0088CC72: RTS
        dc.w    $43F9, $0089, $97EC    ; 0088CC74: LEA $008997EC,A1
        dc.w    $43F1                    ; 0088CC7A: dc.w $43F1
        dc.w    $0000                    ; 0088CC7C: dc.w $0000
        dc.w    $45F8                    ; 0088CC7E: dc.w $45F8
        dc.w    $C08C                    ; 0088CC80: dc.w $C08C
        dc.w    $4EF9, $0088, $4922    ; 0088CC82: JMP $00884922
        dc.w    $11F8                    ; 0088CC88: dc.w $11F8
        dc.w    $FEA9                    ; 0088CC8A: dc.w $FEA9
        dc.w    $C30F                    ; 0088CC8C: dc.w $C30F
        dc.w    $41F8                    ; 0088CC8E: dc.w $41F8
        dc.w    $9000                    ; 0088CC90: dc.w $9000
        dc.w    $11FC                    ; 0088CC92: dc.w $11FC
        dc.w    $0000                    ; 0088CC94: dc.w $0000
        dc.w    $C819                    ; 0088CC96: dc.w $C819
        dc.w    $31F8                    ; 0088CC98: dc.w $31F8
        dc.w    $C094                    ; 0088CC9A: dc.w $C094
        dc.w    $C07A                    ; 0088CC9C: dc.w $C07A
        dc.w    $11FC                    ; 0088CC9E: dc.w $11FC
        dc.w    $0000                    ; 0088CCA0: dc.w $0000
        dc.w    $C311                    ; 0088CCA2: dc.w $C311
        dc.w    $31FC                    ; 0088CCA4: dc.w $31FC
        dc.w    $0001                    ; 0088CCA6: dc.w $0001
        dc.w    $C048                    ; 0088CCA8: dc.w $C048
        dc.w    $11FC                    ; 0088CCAA: dc.w $11FC
        dc.w    $0004                    ; 0088CCAC: dc.w $0004
        dc.w    $C302                    ; 0088CCAE: dc.w $C302
        dc.w    $31FC                    ; 0088CCB0: dc.w $31FC
        dc.w    $0000                    ; 0088CCB2: dc.w $0000
        dc.w    $C086                    ; 0088CCB4: dc.w $C086
        dc.w    $31FC                    ; 0088CCB6: dc.w $31FC
        dc.w    $0040                    ; 0088CCB8: dc.w $0040
        dc.w    $C0E4                    ; 0088CCBA: dc.w $C0E4
        dc.w    $43F9, $0089, $8A04    ; 0088CCBC: LEA $00898A04,A1
        dc.w    $3038                    ; 0088CCC2: dc.w $3038
        dc.w    $C89C                    ; 0088CCC4: dc.w $C89C
        dc.w    $C0FC                    ; 0088CCC6: dc.w $C0FC
        dc.w    $0014                    ; 0088CCC8: dc.w $0014
        dc.w    $D3C0                    ; 0088CCCA: dc.w $D3C0
        dc.w    $45F8                    ; 0088CCCC: dc.w $45F8
        dc.w    $C700                    ; 0088CCCE: dc.w $C700
        dc.w    $4EB9, $0088, $4922    ; 0088CCD0: JSR $00884922
        dc.w    $2151                    ; 0088CCD6: dc.w $2151
        dc.w    $0018                    ; 0088CCD8: dc.w $0018
        dc.w    $2151                    ; 0088CCDA: dc.w $2151
        dc.w    $00B2                    ; 0088CCDC: dc.w $00B2
        dc.w    $43F9, $0093, $0612    ; 0088CCDE: LEA $00930612,A1
        dc.w    $3038                    ; 0088CCE4: dc.w $3038
        dc.w    $C8CC                    ; 0088CCE6: dc.w $C8CC
        dc.w    $2271                    ; 0088CCE8: dc.w $2271
        dc.w    $0000                    ; 0088CCEA: dc.w $0000
        dc.w    $21C9                    ; 0088CCEC: dc.w $21C9
        dc.w    $C268                    ; 0088CCEE: dc.w $C268
        dc.w    $43F9, $0093, $05D6    ; 0088CCF0: LEA $009305D6,A1
        dc.w    $2271                    ; 0088CCF6: dc.w $2271
        dc.w    $0000                    ; 0088CCF8: dc.w $0000
        dc.w    $45F8                    ; 0088CCFA: dc.w $45F8
        dc.w    $C8E4                    ; 0088CCFC: dc.w $C8E4
        dc.w    $4EB9, $0088, $4922    ; 0088CCFE: JSR $00884922
        dc.w    $317C                    ; 0088CD04: dc.w $317C
        dc.w    $0001                    ; 0088CD06: dc.w $0001
        dc.w    $002A                    ; 0088CD08: dc.w $002A
        dc.w    $317C                    ; 0088CD0A: dc.w $317C
        dc.w    $0001                    ; 0088CD0C: dc.w $0001
        dc.w    $00A6                    ; 0088CD0E: dc.w $00A6
        dc.w    $317C                    ; 0088CD10: dc.w $317C
        dc.w    $000F                    ; 0088CD12: dc.w $000F
        dc.w    $00A4                    ; 0088CD14: dc.w $00A4
        dc.w    $317C                    ; 0088CD16: dc.w $317C
        dc.w    $0003                    ; 0088CD18: dc.w $0003
        dc.w    $00AC                    ; 0088CD1A: dc.w $00AC
        dc.w    $317C                    ; 0088CD1C: dc.w $317C
        dc.w    $0100                    ; 0088CD1E: dc.w $0100
        dc.w    $0076                    ; 0088CD20: dc.w $0076
        dc.w    $317C                    ; 0088CD22: dc.w $317C
        dc.w    $0100                    ; 0088CD24: dc.w $0100
        dc.w    $0078                    ; 0088CD26: dc.w $0078
        dc.w    $7000                    ; 0088CD28: MOVEQ #$00,D0
        dc.w    $31FC                    ; 0088CD2A: dc.w $31FC
        dc.w    $001E                    ; 0088CD2C: dc.w $001E
        dc.w    $C0AC                    ; 0088CD2E: dc.w $C0AC
        dc.w    $11FC                    ; 0088CD30: dc.w $11FC
        dc.w    $0014                    ; 0088CD32: dc.w $0014
        dc.w    $C824                    ; 0088CD34: dc.w $C824
        dc.w    $0C78                    ; 0088CD36: dc.w $0C78
        dc.w    $0001                    ; 0088CD38: dc.w $0001
        dc.w    $C8C8                    ; 0088CD3A: dc.w $C8C8
        dc.w    $6606                    ; 0088CD3C: BNE.S $0088CD44
        dc.w    $11FC                    ; 0088CD3E: dc.w $11FC
        dc.w    $001E                    ; 0088CD40: dc.w $001E
        dc.w    $C824                    ; 0088CD42: dc.w $C824
        dc.w    $31FC                    ; 0088CD44: dc.w $31FC
        dc.w    $FFFF                    ; 0088CD46: dc.w $FFFF
        dc.w    $C05A                    ; 0088CD48: dc.w $C05A
        dc.w    $4E75                    ; 0088CD4A: RTS
        dc.w    $43F9, $0089, $8A7C    ; 0088CD4C: LEA $00898A7C,A1
        dc.w    $3E38                    ; 0088CD52: dc.w $3E38
        dc.w    $C8A0                    ; 0088CD54: dc.w $C8A0
        dc.w    $2271                    ; 0088CD56: dc.w $2271
        dc.w    $7000                    ; 0088CD58: MOVEQ #$00,D0
        dc.w    $7E0E                    ; 0088CD5A: MOVEQ #$0E,D7
        dc.w    $41F8                    ; 0088CD5C: dc.w $41F8
        dc.w    $9100                    ; 0088CD5E: dc.w $9100
        dc.w    $47F9, $0093, $814E    ; 0088CD60: LEA $0093814E,A3
        dc.w    $7000                    ; 0088CD66: MOVEQ #$00,D0
        dc.w    $7202                    ; 0088CD68: MOVEQ #$02,D1
        dc.w    $2459                    ; 0088CD6A: dc.w $2459
        dc.w    $214A                    ; 0088CD6C: dc.w $214A
        dc.w    $0018                    ; 0088CD6E: dc.w $0018
        dc.w    $315B                    ; 0088CD70: dc.w $315B
        dc.w    $00C2                    ; 0088CD72: dc.w $00C2
        dc.w    $3140                    ; 0088CD74: dc.w $3140
        dc.w    $00A4                    ; 0088CD76: dc.w $00A4
        dc.w    $3141                    ; 0088CD78: dc.w $3141
        dc.w    $00A6                    ; 0088CD7A: dc.w $00A6
        dc.w    $5240                    ; 0088CD7C: dc.w $5240
        dc.w    $5241                    ; 0088CD7E: dc.w $5241
        dc.w    $0240                    ; 0088CD80: dc.w $0240
        dc.w    $000F                    ; 0088CD82: dc.w $000F
        dc.w    $0241                    ; 0088CD84: dc.w $0241
        dc.w    $000F                    ; 0088CD86: dc.w $000F
        dc.w    $41E8                    ; 0088CD88: dc.w $41E8
        dc.w    $0100                    ; 0088CD8A: dc.w $0100
        dc.w    $51CF, $FFDC            ; 0088CD8C: DBRA D7,$0088CD6A
        dc.w    $4E75                    ; 0088CD90: RTS
        dc.w    $2F38                    ; 0088CD92: dc.w $2F38
        dc.w    $C260                    ; 0088CD94: dc.w $C260
        dc.w    $43F8                    ; 0088CD96: dc.w $43F8
        dc.w    $C000                    ; 0088CD98: dc.w $C000
        dc.w    $7200                    ; 0088CD9A: MOVEQ #$00,D1
        dc.w    $4EB9, $0088, $483A    ; 0088CD9C: JSR $0088483A
        dc.w    $21DF                    ; 0088CDA2: dc.w $21DF
        dc.w    $C260                    ; 0088CDA4: dc.w $C260
        dc.w    $43F8                    ; 0088CDA6: dc.w $43F8
        dc.w    $9000                    ; 0088CDA8: dc.w $9000
        dc.w    $7200                    ; 0088CDAA: MOVEQ #$00,D1
        dc.w    $7E0F                    ; 0088CDAC: MOVEQ #$0F,D7
        dc.w    $4EB9, $0088, $4842    ; 0088CDAE: JSR $00884842
        dc.w    $51CF, $FFF8            ; 0088CDB4: DBRA D7,$0088CDAE
        dc.w    $7200                    ; 0088CDB8: MOVEQ #$00,D1
        dc.w    $11C1                    ; 0088CDBA: dc.w $11C1
        dc.w    $C30E                    ; 0088CDBC: dc.w $C30E
        dc.w    $31C1                    ; 0088CDBE: dc.w $31C1
        dc.w    $C8AA                    ; 0088CDC0: dc.w $C8AA
        dc.w    $31C1                    ; 0088CDC2: dc.w $31C1
        dc.w    $C8AC                    ; 0088CDC4: dc.w $C8AC
        dc.w    $31C1                    ; 0088CDC6: dc.w $31C1
        dc.w    $C8AE                    ; 0088CDC8: dc.w $C8AE
        dc.w    $31FC                    ; 0088CDCA: dc.w $31FC
        dc.w    $FFFF                    ; 0088CDCC: dc.w $FFFF
        dc.w    $C026                    ; 0088CDCE: dc.w $C026
        dc.w    $4E75                    ; 0088CDD0: RTS
        dc.w    $7E0F                    ; 0088CDD2: MOVEQ #$0F,D7
        dc.w    $D078                    ; 0088CDD4: dc.w $D078
        dc.w    $C8A0                    ; 0088CDD6: dc.w $C8A0
        dc.w    $41F8                    ; 0088CDD8: dc.w $41F8
        dc.w    $9000                    ; 0088CDDA: dc.w $9000
        dc.w    $3438                    ; 0088CDDC: dc.w $3438
        dc.w    $C8CC                    ; 0088CDDE: dc.w $C8CC
        dc.w    $43F9, $0093, $82BA    ; 0088CDE0: LEA $009382BA,A1
        dc.w    $2271                    ; 0088CDE6: dc.w $2271
        dc.w    $2000                    ; 0088CDE8: dc.w $2000
        dc.w    $2271                    ; 0088CDEA: dc.w $2271
        dc.w    $0000                    ; 0088CDEC: dc.w $0000
        dc.w    $614C                    ; 0088CDEE: BSR.S $0088CE3C
        dc.w    $41E8                    ; 0088CDF0: dc.w $41E8
        dc.w    $0100                    ; 0088CDF2: dc.w $0100
        dc.w    $51CF, $FFF8            ; 0088CDF4: DBRA D7,$0088CDEE
        dc.w    $21FC                    ; 0088CDF8: dc.w $21FC
        dc.w    $0000                    ; 0088CDFA: dc.w $0000
        dc.w    $0000                    ; 0088CDFC: dc.w $0000
        dc.w    $902C                    ; 0088CDFE: dc.w $902C
        dc.w    $4E75                    ; 0088CE00: RTS
        dc.w    $7200                    ; 0088CE02: MOVEQ #$00,D1
        dc.w    $611C                    ; 0088CE04: BSR.S $0088CE22
        dc.w    $317C                    ; 0088CE06: dc.w $317C
        dc.w    $000F                    ; 0088CE08: dc.w $000F
        dc.w    $00A4                    ; 0088CE0A: dc.w $00A4
        dc.w    $317C                    ; 0088CE0C: dc.w $317C
        dc.w    $000F                    ; 0088CE0E: dc.w $000F
        dc.w    $00A6                    ; 0088CE10: dc.w $00A6
        dc.w    $41F8                    ; 0088CE12: dc.w $41F8
        dc.w    $9F00                    ; 0088CE14: dc.w $9F00
        dc.w    $6124                    ; 0088CE16: BSR.S $0088CE3C
        dc.w    $3141                    ; 0088CE18: dc.w $3141
        dc.w    $00A4                    ; 0088CE1A: dc.w $00A4
        dc.w    $3141                    ; 0088CE1C: dc.w $3141
        dc.w    $00A6                    ; 0088CE1E: dc.w $00A6
        dc.w    $4E75                    ; 0088CE20: RTS
        dc.w    $41F8                    ; 0088CE22: dc.w $41F8
        dc.w    $9000                    ; 0088CE24: dc.w $9000
        dc.w    $D078                    ; 0088CE26: dc.w $D078
        dc.w    $C8A0                    ; 0088CE28: dc.w $C8A0
        dc.w    $3438                    ; 0088CE2A: dc.w $3438
        dc.w    $C8CC                    ; 0088CE2C: dc.w $C8CC
        dc.w    $43F9, $0093, $82BA    ; 0088CE2E: LEA $009382BA,A1
        dc.w    $2271                    ; 0088CE34: dc.w $2271
        dc.w    $2000                    ; 0088CE36: dc.w $2000
        dc.w    $2271                    ; 0088CE38: dc.w $2271
        dc.w    $0000                    ; 0088CE3A: dc.w $0000
        dc.w    $3159                    ; 0088CE3C: dc.w $3159
        dc.w    $0030                    ; 0088CE3E: dc.w $0030
        dc.w    $3159                    ; 0088CE40: dc.w $3159
        dc.w    $0032                    ; 0088CE42: dc.w $0032
        dc.w    $3159                    ; 0088CE44: dc.w $3159
        dc.w    $0034                    ; 0088CE46: dc.w $0034
        dc.w    $3151                    ; 0088CE48: dc.w $3151
        dc.w    $003C                    ; 0088CE4A: dc.w $003C
        dc.w    $3159                    ; 0088CE4C: dc.w $3159
        dc.w    $0040                    ; 0088CE4E: dc.w $0040
        dc.w    $2141                    ; 0088CE50: dc.w $2141
        dc.w    $002C                    ; 0088CE52: dc.w $002C
        dc.w    $4E75                    ; 0088CE54: RTS
        dc.w    $7E0F                    ; 0088CE56: MOVEQ #$0F,D7
        dc.w    $41F8                    ; 0088CE58: dc.w $41F8
        dc.w    $9000                    ; 0088CE5A: dc.w $9000
        dc.w    $43F9, $0093, $8EAE    ; 0088CE5C: LEA $00938EAE,A1
        dc.w    $61D8                    ; 0088CE62: BSR.S $0088CE3C
        dc.w    $41E8                    ; 0088CE64: dc.w $41E8
        dc.w    $0100                    ; 0088CE66: dc.w $0100
        dc.w    $51CF, $FFF8            ; 0088CE68: DBRA D7,$0088CE62
        dc.w    $21FC                    ; 0088CE6C: dc.w $21FC
        dc.w    $0000                    ; 0088CE6E: dc.w $0000
        dc.w    $0000                    ; 0088CE70: dc.w $0000
        dc.w    $902C                    ; 0088CE72: dc.w $902C
        dc.w    $4E75                    ; 0088CE74: RTS
        dc.w    $7200                    ; 0088CE76: MOVEQ #$00,D1
        dc.w    $43F8                    ; 0088CE78: dc.w $43F8
        dc.w    $A800                    ; 0088CE7A: dc.w $A800
        dc.w    $4EB9, $0088, $4842    ; 0088CE7C: JSR $00884842
        dc.w    $4EB9, $0088, $4846    ; 0088CE82: JSR $00884846
        dc.w    $4EB9, $0088, $4856    ; 0088CE88: JSR $00884856
        dc.w    $11C1                    ; 0088CE8E: dc.w $11C1
        dc.w    $C81D                    ; 0088CE90: dc.w $C81D
        dc.w    $11C1                    ; 0088CE92: dc.w $11C1
        dc.w    $C81F                    ; 0088CE94: dc.w $C81F
        dc.w    $11C1                    ; 0088CE96: dc.w $11C1
        dc.w    $C820                    ; 0088CE98: dc.w $C820
        dc.w    $31C1                    ; 0088CE9A: dc.w $31C1
        dc.w    $A9E0                    ; 0088CE9C: dc.w $A9E0
        dc.w    $21FC                    ; 0088CE9E: dc.w $21FC
        dc.w    $0000                    ; 0088CEA0: dc.w $0000
        dc.w    $C4C4                    ; 0088CEA2: dc.w $C4C4
        dc.w    $A9E2                    ; 0088CEA4: dc.w $A9E2
        dc.w    $21FC                    ; 0088CEA6: dc.w $21FC
        dc.w    $0000                    ; 0088CEA8: dc.w $0000
        dc.w    $C4C4                    ; 0088CEAA: dc.w $C4C4
        dc.w    $A9E6                    ; 0088CEAC: dc.w $A9E6
        dc.w    $11FC                    ; 0088CEAE: dc.w $11FC
        dc.w    $0000                    ; 0088CEB0: dc.w $0000
        dc.w    $C819                    ; 0088CEB2: dc.w $C819
        dc.w    $31FC                    ; 0088CEB4: dc.w $31FC
        dc.w    $0000                    ; 0088CEB6: dc.w $0000
        dc.w    $C8BE                    ; 0088CEB8: dc.w $C8BE
        dc.w    $11F8                    ; 0088CEBA: dc.w $11F8
        dc.w    $C81A                    ; 0088CEBC: dc.w $C81A
        dc.w    $C310                    ; 0088CEBE: dc.w $C310
        dc.w    $4E75                    ; 0088CEC0: RTS
        dc.w    $41F8                    ; 0088CEC2: dc.w $41F8
        dc.w    $9000                    ; 0088CEC4: dc.w $9000
        dc.w    $1038                    ; 0088CEC6: dc.w $1038
        dc.w    $FEAD                    ; 0088CEC8: dc.w $FEAD
        dc.w    $6008                    ; 0088CECA: BRA.S $0088CED4
        dc.w    $41F8                    ; 0088CECC: dc.w $41F8
        dc.w    $9F00                    ; 0088CECE: dc.w $9F00
        dc.w    $1038                    ; 0088CED0: dc.w $1038
        dc.w    $FEAE                    ; 0088CED2: dc.w $FEAE
        dc.w    $3238                    ; 0088CED4: dc.w $3238
        dc.w    $C8CC                    ; 0088CED6: dc.w $C8CC
        dc.w    $D241                    ; 0088CED8: dc.w $D241
        dc.w    $D278                    ; 0088CEDA: dc.w $D278
        dc.w    $C8CA                    ; 0088CEDC: dc.w $C8CA
        dc.w    $4880                    ; 0088CEDE: dc.w $4880
        dc.w    $D040                    ; 0088CEE0: dc.w $D040
        dc.w    $D041                    ; 0088CEE2: dc.w $D041
        dc.w    $303B                    ; 0088CEE4: dc.w $303B
        dc.w    $0008                    ; 0088CEE6: dc.w $0008
        dc.w    $D178                    ; 0088CEE8: dc.w $D178
        dc.w    $C0E8                    ; 0088CEEA: dc.w $C0E8
        dc.w    $4E75                    ; 0088CEEC: RTS
        dc.w    $001E                    ; 0088CEEE: dc.w $001E
        dc.w    $000F                    ; 0088CEF0: dc.w $000F
        dc.w    $0000                    ; 0088CEF2: dc.w $0000
        dc.w    $FFF1                    ; 0088CEF4: dc.w $FFF1
        dc.w    $FFE2                    ; 0088CEF6: dc.w $FFE2
        dc.w    $001E                    ; 0088CEF8: dc.w $001E
        dc.w    $000F                    ; 0088CEFA: dc.w $000F
        dc.w    $0000                    ; 0088CEFC: dc.w $0000
        dc.w    $FFF1                    ; 0088CEFE: dc.w $FFF1
        dc.w    $FFE2                    ; 0088CF00: dc.w $FFE2
        dc.w    $001E                    ; 0088CF02: dc.w $001E
        dc.w    $000F                    ; 0088CF04: dc.w $000F
        dc.w    $0000                    ; 0088CF06: dc.w $0000
        dc.w    $FFF1                    ; 0088CF08: dc.w $FFF1
        dc.w    $FFE2                    ; 0088CF0A: dc.w $FFE2
        dc.w    $41F8                    ; 0088CF0C: dc.w $41F8
        dc.w    $9100                    ; 0088CF0E: dc.w $9100
        dc.w    $7E0E                    ; 0088CF10: MOVEQ #$0E,D7
        dc.w    $3F07                    ; 0088CF12: dc.w $3F07
        dc.w    $4EBA                    ; 0088CF14: dc.w $4EBA
        dc.w    $ABA0                    ; 0088CF16: dc.w $ABA0
        dc.w    $4EBA                    ; 0088CF18: dc.w $4EBA
        dc.w    $AB9C                    ; 0088CF1A: dc.w $AB9C
        dc.w    $4EBA                    ; 0088CF1C: dc.w $4EBA
        dc.w    $AB98                    ; 0088CF1E: dc.w $AB98
        dc.w    $4EBA                    ; 0088CF20: dc.w $4EBA
        dc.w    $AB94                    ; 0088CF22: dc.w $AB94
        dc.w    $4EBA                    ; 0088CF24: dc.w $4EBA
        dc.w    $AB90                    ; 0088CF26: dc.w $AB90
        dc.w    $4EBA                    ; 0088CF28: dc.w $4EBA
        dc.w    $AB8C                    ; 0088CF2A: dc.w $AB8C
        dc.w    $4EBA                    ; 0088CF2C: dc.w $4EBA
        dc.w    $AB88                    ; 0088CF2E: dc.w $AB88
        dc.w    $4EBA                    ; 0088CF30: dc.w $4EBA
        dc.w    $AB84                    ; 0088CF32: dc.w $AB84
        dc.w    $4EBA                    ; 0088CF34: dc.w $4EBA
        dc.w    $AB80                    ; 0088CF36: dc.w $AB80
        dc.w    $43F9, $0093, $AC2C    ; 0088CF38: LEA $0093AC2C,A1
        dc.w    $3028                    ; 0088CF3E: dc.w $3028
        dc.w    $00C8                    ; 0088CF40: dc.w $00C8
        dc.w    $9068                    ; 0088CF42: dc.w $9068
        dc.w    $0032                    ; 0088CF44: dc.w $0032
        dc.w    $D040                    ; 0088CF46: dc.w $D040
        dc.w    $6B0A                    ; 0088CF48: BMI.S $0088CF54
        dc.w    $0240                    ; 0088CF4A: dc.w $0240
        dc.w    $03FF                    ; 0088CF4C: dc.w $03FF
        dc.w    $3031                    ; 0088CF4E: dc.w $3031
        dc.w    $0000                    ; 0088CF50: dc.w $0000
        dc.w    $600C                    ; 0088CF52: BRA.S $0088CF60
        dc.w    $4440                    ; 0088CF54: dc.w $4440
        dc.w    $0240                    ; 0088CF56: dc.w $0240
        dc.w    $03FF                    ; 0088CF58: dc.w $03FF
        dc.w    $3031                    ; 0088CF5A: dc.w $3031
        dc.w    $0000                    ; 0088CF5C: dc.w $0000
        dc.w    $4440                    ; 0088CF5E: dc.w $4440
        dc.w    $3140                    ; 0088CF60: dc.w $3140
        dc.w    $003A                    ; 0088CF62: dc.w $003A
        dc.w    $43F9, $0093, $A82C    ; 0088CF64: LEA $0093A82C,A1
        dc.w    $3028                    ; 0088CF6A: dc.w $3028
        dc.w    $0032                    ; 0088CF6C: dc.w $0032
        dc.w    $9068                    ; 0088CF6E: dc.w $9068
        dc.w    $00C6                    ; 0088CF70: dc.w $00C6
        dc.w    $D040                    ; 0088CF72: dc.w $D040
        dc.w    $6B0A                    ; 0088CF74: BMI.S $0088CF80
        dc.w    $0240                    ; 0088CF76: dc.w $0240
        dc.w    $03FF                    ; 0088CF78: dc.w $03FF
        dc.w    $3031                    ; 0088CF7A: dc.w $3031
        dc.w    $0000                    ; 0088CF7C: dc.w $0000
        dc.w    $600C                    ; 0088CF7E: BRA.S $0088CF8C
        dc.w    $4440                    ; 0088CF80: dc.w $4440
        dc.w    $0240                    ; 0088CF82: dc.w $0240
        dc.w    $03FF                    ; 0088CF84: dc.w $03FF
        dc.w    $3031                    ; 0088CF86: dc.w $3031
        dc.w    $0000                    ; 0088CF88: dc.w $0000
        dc.w    $4440                    ; 0088CF8A: dc.w $4440
        dc.w    $4EBA                    ; 0088CF8C: dc.w $4EBA
        dc.w    $A6C0                    ; 0088CF8E: dc.w $A6C0
        dc.w    $4EBA                    ; 0088CF90: dc.w $4EBA
        dc.w    $A1B8                    ; 0088CF92: dc.w $A1B8
        dc.w    $3140                    ; 0088CF94: dc.w $3140
        dc.w    $003E                    ; 0088CF96: dc.w $003E
        dc.w    $3168                    ; 0088CF98: dc.w $3168
        dc.w    $006E                    ; 0088CF9A: dc.w $006E
        dc.w    $0046                    ; 0088CF9C: dc.w $0046
        dc.w    $41E8                    ; 0088CF9E: dc.w $41E8
        dc.w    $0100                    ; 0088CFA0: dc.w $0100
        dc.w    $3E1F                    ; 0088CFA2: dc.w $3E1F
        dc.w    $51CF, $FF6C            ; 0088CFA4: DBRA D7,$0088CF12
        dc.w    $4EF9, $0088, $36DE    ; 0088CFA8: JMP $008836DE
        dc.w    $3038                    ; 0088CFAE: dc.w $3038
        dc.w    $C8CC                    ; 0088CFB0: dc.w $C8CC
        dc.w    $43F9, $0089, $55CC    ; 0088CFB2: LEA $008955CC,A1
        dc.w    $2271                    ; 0088CFB8: dc.w $2271
        dc.w    $0000                    ; 0088CFBA: dc.w $0000
        dc.w    $45F9, $00FF, $6178    ; 0088CFBC: LEA $00FF6178,A2
        dc.w    $7E07                    ; 0088CFC2: MOVEQ #$07,D7
        dc.w    $2559                    ; 0088CFC4: dc.w $2559
        dc.w    $0002                    ; 0088CFC6: dc.w $0002
        dc.w    $3559                    ; 0088CFC8: dc.w $3559
        dc.w    $0006                    ; 0088CFCA: dc.w $0006
        dc.w    $45EA                    ; 0088CFCC: dc.w $45EA
        dc.w    $0014                    ; 0088CFCE: dc.w $0014
        dc.w    $51CF, $FFF2            ; 0088CFD0: DBRA D7,$0088CFC4
        dc.w    $4E75                    ; 0088CFD4: RTS
        dc.w    $3038                    ; 0088CFD6: dc.w $3038
        dc.w    $C8CC                    ; 0088CFD8: dc.w $C8CC
        dc.w    $43F9, $0089, $55CC    ; 0088CFDA: LEA $008955CC,A1
        dc.w    $2271                    ; 0088CFE0: dc.w $2271
        dc.w    $0000                    ; 0088CFE2: dc.w $0000
        dc.w    $2649                    ; 0088CFE4: dc.w $2649
        dc.w    $45F9, $00FF, $6178    ; 0088CFE6: LEA $00FF6178,A2
        dc.w    $61D4                    ; 0088CFEC: BSR.S $0088CFC2
        dc.w    $224B                    ; 0088CFEE: dc.w $224B
        dc.w    $45F9, $00FF, $627C    ; 0088CFF0: LEA $00FF627C,A2
        dc.w    $61CA                    ; 0088CFF6: BSR.S $0088CFC2
        dc.w    $224B                    ; 0088CFF8: dc.w $224B
        dc.w    $45F9, $00FF, $63A8    ; 0088CFFA: LEA $00FF63A8,A2
        dc.w    $61C0                    ; 0088D000: BSR.S $0088CFC2
        dc.w    $224B                    ; 0088D002: dc.w $224B
        dc.w    $45F9, $00FF, $64AC    ; 0088D004: LEA $00FF64AC,A2
        dc.w    $60B6                    ; 0088D00A: BRA.S $0088CFC2
        dc.w    $43F8                    ; 0088D00C: dc.w $43F8
        dc.w    $C806                    ; 0088D00E: dc.w $C806
        dc.w    $12FC                    ; 0088D010: dc.w $12FC
        dc.w    $0000                    ; 0088D012: dc.w $0000
        dc.w    $12FC                    ; 0088D014: dc.w $12FC
        dc.w    $00C4                    ; 0088D016: dc.w $00C4
        dc.w    $12BC                    ; 0088D018: dc.w $12BC
        dc.w    $00C4                    ; 0088D01A: dc.w $00C4
        dc.w    $31FC                    ; 0088D01C: dc.w $31FC
        dc.w    $C200                    ; 0088D01E: dc.w $C200
        dc.w    $C076                    ; 0088D020: dc.w $C076
        dc.w    $0838                    ; 0088D022: dc.w $0838
        dc.w    $0003                    ; 0088D024: dc.w $0003
        dc.w    $C80E                    ; 0088D026: dc.w $C80E
        dc.w    $6610                    ; 0088D028: BNE.S $0088D03A
        dc.w    $21FC                    ; 0088D02A: dc.w $21FC
        dc.w    $6100, $0000            ; 0088D02C: BSR.W $0088D02E
        dc.w    $C254                    ; 0088D030: dc.w $C254
        dc.w    $21FC                    ; 0088D032: dc.w $21FC
        dc.w    $6000, $0000            ; 0088D034: BRA.W $0088D036
        dc.w    $C260                    ; 0088D038: dc.w $C260
        dc.w    $43FA                    ; 0088D03A: dc.w $43FA
        dc.w    $0014                    ; 0088D03C: dc.w $0014
        dc.w    $7000                    ; 0088D03E: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088D040: dc.w $1038
        dc.w    $FDA9                    ; 0088D042: dc.w $FDA9
        dc.w    $11F1                    ; 0088D044: dc.w $11F1
        dc.w    $0000                    ; 0088D046: dc.w $0000
        dc.w    $C051                    ; 0088D048: dc.w $C051
        dc.w    $4E75                    ; 0088D04A: RTS
        dc.w    $5041                    ; 0088D04C: dc.w $5041
        dc.w    $4100                    ; 0088D04E: dc.w $4100
        dc.w    $504B                    ; 0088D050: dc.w $504B
        dc.w    $4600                    ; 0088D052: dc.w $4600
        dc.w    $4EBA                    ; 0088D054: dc.w $4EBA
        dc.w    $FFB6                    ; 0088D056: dc.w $FFB6
        dc.w    $3038                    ; 0088D058: dc.w $3038
        dc.w    $C8A0                    ; 0088D05A: dc.w $C8A0
        dc.w    $43F9, $0089, $8C0C    ; 0088D05C: LEA $00898C0C,A1
        dc.w    $23F1                    ; 0088D062: dc.w $23F1
        dc.w    $0000                    ; 0088D064: dc.w $0000
        dc.w    $00FF                    ; 0088D066: dc.w $00FF
        dc.w    $6868                    ; 0088D068: BVC.S $0088D0D2
        dc.w    $227B                    ; 0088D06A: dc.w $227B
        dc.w    $0004                    ; 0088D06C: dc.w $0004
        dc.w    $4ED1                    ; 0088D06E: JMP (A1)
        dc.w    $0088                    ; 0088D070: dc.w $0088
        dc.w    $D088                    ; 0088D072: dc.w $D088
        dc.w    $0088                    ; 0088D074: dc.w $0088
        dc.w    $D088                    ; 0088D076: dc.w $D088
        dc.w    $0088                    ; 0088D078: dc.w $0088
        dc.w    $D088                    ; 0088D07A: dc.w $D088
        dc.w    $0088                    ; 0088D07C: dc.w $0088
        dc.w    $D088                    ; 0088D07E: dc.w $D088
        dc.w    $0088                    ; 0088D080: dc.w $0088
        dc.w    $D088                    ; 0088D082: dc.w $D088
        dc.w    $0088                    ; 0088D084: dc.w $0088
        dc.w    $D088                    ; 0088D086: dc.w $D088
        dc.w    $4E75                    ; 0088D088: RTS
        dc.w    $11FC                    ; 0088D08A: dc.w $11FC
        dc.w    $0000                    ; 0088D08C: dc.w $0000
        dc.w    $C806                    ; 0088D08E: dc.w $C806
        dc.w    $11FC                    ; 0088D090: dc.w $11FC
        dc.w    $00C4                    ; 0088D092: dc.w $00C4
        dc.w    $C807                    ; 0088D094: dc.w $C807
        dc.w    $11FC                    ; 0088D096: dc.w $11FC
        dc.w    $00C4                    ; 0088D098: dc.w $00C4
        dc.w    $C808                    ; 0088D09A: dc.w $C808
        dc.w    $11FC                    ; 0088D09C: dc.w $11FC
        dc.w    $0000                    ; 0088D09E: dc.w $0000
        dc.w    $C813                    ; 0088D0A0: dc.w $C813
        dc.w    $11FC                    ; 0088D0A2: dc.w $11FC
        dc.w    $00C4                    ; 0088D0A4: dc.w $00C4
        dc.w    $C814                    ; 0088D0A6: dc.w $C814
        dc.w    $11FC                    ; 0088D0A8: dc.w $11FC
        dc.w    $00C4                    ; 0088D0AA: dc.w $00C4
        dc.w    $C815                    ; 0088D0AC: dc.w $C815
        dc.w    $31FC                    ; 0088D0AE: dc.w $31FC
        dc.w    $C200                    ; 0088D0B0: dc.w $C200
        dc.w    $C076                    ; 0088D0B2: dc.w $C076
        dc.w    $21FC                    ; 0088D0B4: dc.w $21FC
        dc.w    $6100, $0000            ; 0088D0B6: BSR.W $0088D0B8
        dc.w    $C254                    ; 0088D0BA: dc.w $C254
        dc.w    $21FC                    ; 0088D0BC: dc.w $21FC
        dc.w    $6000, $0000            ; 0088D0BE: BRA.W $0088D0C0
        dc.w    $C260                    ; 0088D0C2: dc.w $C260
        dc.w    $3038                    ; 0088D0C4: dc.w $3038
        dc.w    $C8A0                    ; 0088D0C6: dc.w $C8A0
        dc.w    $4EFA                    ; 0088D0C8: dc.w $4EFA
        dc.w    $FFA0                    ; 0088D0CA: dc.w $FFA0
        dc.w    $43F8                    ; 0088D0CC: dc.w $43F8
        dc.w    $FDAA                    ; 0088D0CE: dc.w $FDAA
        dc.w    $3238                    ; 0088D0D0: dc.w $3238
        dc.w    $C89C                    ; 0088D0D2: dc.w $C89C
        dc.w    $EB49                    ; 0088D0D4: dc.w $EB49
        dc.w    $D278                    ; 0088D0D6: dc.w $D278
        dc.w    $C8A0                    ; 0088D0D8: dc.w $C8A0
        dc.w    $3038                    ; 0088D0DA: dc.w $3038
        dc.w    $C8C8                    ; 0088D0DC: dc.w $C8C8
        dc.w    $E748                    ; 0088D0DE: dc.w $E748
        dc.w    $D078                    ; 0088D0E0: dc.w $D078
        dc.w    $C8CC                    ; 0088D0E2: dc.w $C8CC
        dc.w    $D240                    ; 0088D0E4: dc.w $D240
        dc.w    $43F1                    ; 0088D0E6: dc.w $43F1
        dc.w    $1000                    ; 0088D0E8: dc.w $1000
        dc.w    $45F9, $00FF, $68E0    ; 0088D0EA: LEA $00FF68E0,A2
        dc.w    $4EF9, $0088, $4280    ; 0088D0F0: JMP $00884280
        dc.w    $11FC                    ; 0088D0F6: dc.w $11FC
        dc.w    $0003                    ; 0088D0F8: dc.w $0003
        dc.w    $C80A                    ; 0088D0FA: dc.w $C80A
        dc.w    $45F8                    ; 0088D0FC: dc.w $45F8
        dc.w    $C200                    ; 0088D0FE: dc.w $C200
        dc.w    $43F8                    ; 0088D100: dc.w $43F8
        dc.w    $EEE0                    ; 0088D102: dc.w $EEE0
        dc.w    $4EB9, $0088, $4920    ; 0088D104: JSR $00884920
        dc.w    $21F8                    ; 0088D10A: dc.w $21F8
        dc.w    $EEFC                    ; 0088D10C: dc.w $EEFC
        dc.w    $C254                    ; 0088D10E: dc.w $C254
        dc.w    $31FC                    ; 0088D110: dc.w $31FC
        dc.w    $00C0                    ; 0088D112: dc.w $00C0
        dc.w    $C054                    ; 0088D114: dc.w $C054
        dc.w    $31FC                    ; 0088D116: dc.w $31FC
        dc.w    $0540                    ; 0088D118: dc.w $0540
        dc.w    $C056                    ; 0088D11A: dc.w $C056
        dc.w    $31FC                    ; 0088D11C: dc.w $31FC
        dc.w    $0000                    ; 0088D11E: dc.w $0000
        dc.w    $C896                    ; 0088D120: dc.w $C896
        dc.w    $43F8                    ; 0088D122: dc.w $43F8
        dc.w    $C200                    ; 0088D124: dc.w $C200
        dc.w    $47F9, $00FF, $68D8    ; 0088D126: LEA $00FF68D8,A3
        dc.w    $7E04                    ; 0088D12C: MOVEQ #$04,D7
        dc.w    $4EBA                    ; 0088D12E: dc.w $4EBA
        dc.w    $E30C                    ; 0088D130: dc.w $E30C
        dc.w    $43E9                    ; 0088D132: dc.w $43E9
        dc.w    $0004                    ; 0088D134: dc.w $0004
        dc.w    $47EB                    ; 0088D136: dc.w $47EB
        dc.w    $0010                    ; 0088D138: dc.w $0010
        dc.w    $51CF, $FFF2            ; 0088D13A: DBRA D7,$0088D12E
        dc.w    $72FF                    ; 0088D13E: MOVEQ #$FF,D1
        dc.w    $7E04                    ; 0088D140: MOVEQ #$04,D7
        dc.w    $2038                    ; 0088D142: dc.w $2038
        dc.w    $C254                    ; 0088D144: dc.w $C254
        dc.w    $43F8                    ; 0088D146: dc.w $43F8
        dc.w    $C200                    ; 0088D148: dc.w $C200
        dc.w    $5241                    ; 0088D14A: dc.w $5241
        dc.w    $B099                    ; 0088D14C: dc.w $B099
        dc.w    $57CF                    ; 0088D14E: dc.w $57CF
        dc.w    $FFFA                    ; 0088D150: dc.w $FFFA
        dc.w    $E949                    ; 0088D152: dc.w $E949
        dc.w    $43F9, $00FF, $68D0    ; 0088D154: LEA $00FF68D0,A1
        dc.w    $43F1                    ; 0088D15A: dc.w $43F1
        dc.w    $1000                    ; 0088D15C: dc.w $1000
        dc.w    $137C                    ; 0088D15E: dc.w $137C
        dc.w    $0001                    ; 0088D160: dc.w $0001
        dc.w    $0001                    ; 0088D162: dc.w $0001
        dc.w    $21C9                    ; 0088D164: dc.w $21C9
        dc.w    $C960                    ; 0088D166: dc.w $C960
        dc.w    $4EBA                    ; 0088D168: dc.w $4EBA
        dc.w    $9ADC                    ; 0088D16A: dc.w $9ADC
        dc.w    $4EBA                    ; 0088D16C: dc.w $4EBA
        dc.w    $B750                    ; 0088D16E: dc.w $B750
        dc.w    $31FC                    ; 0088D170: dc.w $31FC
        dc.w    $00C0                    ; 0088D172: dc.w $00C0
        dc.w    $C0C8                    ; 0088D174: dc.w $C0C8
        dc.w    $31FC                    ; 0088D176: dc.w $31FC
        dc.w    $07D0                    ; 0088D178: dc.w $07D0
        dc.w    $C8D4                    ; 0088D17A: dc.w $C8D4
        dc.w    $31FC                    ; 0088D17C: dc.w $31FC
        dc.w    $0600                    ; 0088D17E: dc.w $0600
        dc.w    $C8D6                    ; 0088D180: dc.w $C8D6
        dc.w    $31FC                    ; 0088D182: dc.w $31FC
        dc.w    $3000                    ; 0088D184: dc.w $3000
        dc.w    $C8D8                    ; 0088D186: dc.w $C8D8
        dc.w    $31FC                    ; 0088D188: dc.w $31FC
        dc.w    $0000                    ; 0088D18A: dc.w $0000
        dc.w    $C8DA                    ; 0088D18C: dc.w $C8DA
        dc.w    $31FC                    ; 0088D18E: dc.w $31FC
        dc.w    $00C0                    ; 0088D190: dc.w $00C0
        dc.w    $C8DC                    ; 0088D192: dc.w $C8DC
        dc.w    $31FC                    ; 0088D194: dc.w $31FC
        dc.w    $0540                    ; 0088D196: dc.w $0540
        dc.w    $C8DE                    ; 0088D198: dc.w $C8DE
        dc.w    $4E75                    ; 0088D19A: RTS
        dc.w    $7400                    ; 0088D19C: MOVEQ #$00,D2
        dc.w    $0C40                    ; 0088D19E: dc.w $0C40
        dc.w    $0002                    ; 0088D1A0: dc.w $0002
        dc.w    $6602                    ; 0088D1A2: BNE.S $0088D1A6
        dc.w    $7401                    ; 0088D1A4: MOVEQ #$01,D2
        dc.w    $0C40                    ; 0088D1A6: dc.w $0C40
        dc.w    $0003                    ; 0088D1A8: dc.w $0003
        dc.w    $6602                    ; 0088D1AA: BNE.S $0088D1AE
        dc.w    $7401                    ; 0088D1AC: MOVEQ #$01,D2
        dc.w    $11C2                    ; 0088D1AE: dc.w $11C2
        dc.w    $C826                    ; 0088D1B0: dc.w $C826
        dc.w    $31C0                    ; 0088D1B2: dc.w $31C0
        dc.w    $C89C                    ; 0088D1B4: dc.w $C89C
        dc.w    $D040                    ; 0088D1B6: dc.w $D040
        dc.w    $31C0                    ; 0088D1B8: dc.w $31C0
        dc.w    $C89E                    ; 0088D1BA: dc.w $C89E
        dc.w    $D040                    ; 0088D1BC: dc.w $D040
        dc.w    $31C0                    ; 0088D1BE: dc.w $31C0
        dc.w    $C8A0                    ; 0088D1C0: dc.w $C8A0
        dc.w    $31C1                    ; 0088D1C2: dc.w $31C1
        dc.w    $C8C8                    ; 0088D1C4: dc.w $C8C8
        dc.w    $D241                    ; 0088D1C6: dc.w $D241
        dc.w    $31C1                    ; 0088D1C8: dc.w $31C1
        dc.w    $C8CA                    ; 0088D1CA: dc.w $C8CA
        dc.w    $D241                    ; 0088D1CC: dc.w $D241
        dc.w    $31C1                    ; 0088D1CE: dc.w $31C1
        dc.w    $C8CC                    ; 0088D1D0: dc.w $C8CC
        dc.w    $4E75                    ; 0088D1D2: RTS

; --- Called 6x ---
func_D1D4:
        dc.w    $33FC                    ; 0088D1D4: dc.w $33FC
        dc.w    $0100                    ; 0088D1D6: dc.w $0100
        dc.w    $00A1                    ; 0088D1D8: dc.w $00A1
        dc.w    $1100                    ; 0088D1DA: dc.w $1100
        dc.w    $0839                    ; 0088D1DC: dc.w $0839
        dc.w    $0000                    ; 0088D1DE: dc.w $0000
        dc.w    $00A1                    ; 0088D1E0: dc.w $00A1
        dc.w    $1100                    ; 0088D1E2: dc.w $1100
        dc.w    $66F6                    ; 0088D1E4: BNE.S $0088D1DC
        dc.w    $3838                    ; 0088D1E6: dc.w $3838
        dc.w    $C874                    ; 0088D1E8: dc.w $C874
        dc.w    $08C4                    ; 0088D1EA: dc.w $08C4
        dc.w    $0004                    ; 0088D1EC: dc.w $0004
        dc.w    $3A84                    ; 0088D1EE: dc.w $3A84
        dc.w    $3ABC                    ; 0088D1F0: dc.w $3ABC
        dc.w    $8F01                    ; 0088D1F2: dc.w $8F01
        dc.w    $2ABC                    ; 0088D1F4: dc.w $2ABC
        dc.w    $93FF                    ; 0088D1F6: dc.w $93FF
        dc.w    $941F                    ; 0088D1F8: dc.w $941F
        dc.w    $3ABC                    ; 0088D1FA: dc.w $3ABC
        dc.w    $9780                    ; 0088D1FC: dc.w $9780
        dc.w    $2ABC                    ; 0088D1FE: dc.w $2ABC
        dc.w    $6000, $0082            ; 0088D200: BRA.W $0088D284
        dc.w    $3CBC                    ; 0088D204: dc.w $3CBC
        dc.w    $0000                    ; 0088D206: dc.w $0000
        dc.w    $3E15                    ; 0088D208: dc.w $3E15
        dc.w    $0247                    ; 0088D20A: dc.w $0247
        dc.w    $0002                    ; 0088D20C: dc.w $0002
        dc.w    $66F8                    ; 0088D20E: BNE.S $0088D208
        dc.w    $3ABC                    ; 0088D210: dc.w $3ABC
        dc.w    $8F02                    ; 0088D212: dc.w $8F02
        dc.w    $3AB8                    ; 0088D214: dc.w $3AB8
        dc.w    $C874                    ; 0088D216: dc.w $C874
        dc.w    $33FC                    ; 0088D218: dc.w $33FC
        dc.w    $0000                    ; 0088D21A: dc.w $0000
        dc.w    $00A1                    ; 0088D21C: dc.w $00A1
        dc.w    $1100                    ; 0088D21E: dc.w $1100
        dc.w    $7007                    ; 0088D220: MOVEQ #$07,D0
        dc.w    $4EB9, $0088, $14BE    ; 0088D222: JSR $008814BE
        dc.w    $33FC                    ; 0088D228: dc.w $33FC
        dc.w    $0100                    ; 0088D22A: dc.w $0100
        dc.w    $00A1                    ; 0088D22C: dc.w $00A1
        dc.w    $1100                    ; 0088D22E: dc.w $1100
        dc.w    $0839                    ; 0088D230: dc.w $0839
        dc.w    $0000                    ; 0088D232: dc.w $0000
        dc.w    $00A1                    ; 0088D234: dc.w $00A1
        dc.w    $1100                    ; 0088D236: dc.w $1100
        dc.w    $66F6                    ; 0088D238: BNE.S $0088D230
        dc.w    $3838                    ; 0088D23A: dc.w $3838
        dc.w    $C874                    ; 0088D23C: dc.w $C874
        dc.w    $08C4                    ; 0088D23E: dc.w $08C4
        dc.w    $0004                    ; 0088D240: dc.w $0004
        dc.w    $3A84                    ; 0088D242: dc.w $3A84
        dc.w    $2ABC                    ; 0088D244: dc.w $2ABC
        dc.w    $9340                    ; 0088D246: dc.w $9340
        dc.w    $9400                    ; 0088D248: dc.w $9400
        dc.w    $2ABC                    ; 0088D24A: dc.w $2ABC
        dc.w    $9540                    ; 0088D24C: dc.w $9540
        dc.w    $96C2                    ; 0088D24E: dc.w $96C2
        dc.w    $3ABC                    ; 0088D250: dc.w $3ABC
        dc.w    $977F                    ; 0088D252: dc.w $977F
        dc.w    $3ABC                    ; 0088D254: dc.w $3ABC
        dc.w    $C000                    ; 0088D256: dc.w $C000
        dc.w    $31FC                    ; 0088D258: dc.w $31FC
        dc.w    $0080                    ; 0088D25A: dc.w $0080
        dc.w    $C876                    ; 0088D25C: dc.w $C876
        dc.w    $3AB8                    ; 0088D25E: dc.w $3AB8
        dc.w    $C876                    ; 0088D260: dc.w $C876
        dc.w    $3AB8                    ; 0088D262: dc.w $3AB8
        dc.w    $C874                    ; 0088D264: dc.w $C874
        dc.w    $33FC                    ; 0088D266: dc.w $33FC
        dc.w    $0000                    ; 0088D268: dc.w $0000
        dc.w    $00A1                    ; 0088D26A: dc.w $00A1
        dc.w    $1100                    ; 0088D26C: dc.w $1100
        dc.w    $3038                    ; 0088D26E: dc.w $3038
        dc.w    $C8A0                    ; 0088D270: dc.w $C8A0
        dc.w    $41FA                    ; 0088D272: dc.w $41FA
        dc.w    $0188                    ; 0088D274: dc.w $0188
        dc.w    $2030                    ; 0088D276: dc.w $2030
        dc.w    $0000                    ; 0088D278: dc.w $0000
        dc.w    $4EB9, $0088, $15EA    ; 0088D27A: JSR $008815EA
        dc.w    $33FC                    ; 0088D280: dc.w $33FC
        dc.w    $0100                    ; 0088D282: dc.w $0100
        dc.w    $00A1                    ; 0088D284: dc.w $00A1
        dc.w    $1100                    ; 0088D286: dc.w $1100
        dc.w    $0839                    ; 0088D288: dc.w $0839
        dc.w    $0000                    ; 0088D28A: dc.w $0000
        dc.w    $00A1                    ; 0088D28C: dc.w $00A1
        dc.w    $1100                    ; 0088D28E: dc.w $1100
        dc.w    $66F6                    ; 0088D290: BNE.S $0088D288
        dc.w    $3838                    ; 0088D292: dc.w $3838
        dc.w    $C874                    ; 0088D294: dc.w $C874
        dc.w    $08C4                    ; 0088D296: dc.w $08C4
        dc.w    $0004                    ; 0088D298: dc.w $0004
        dc.w    $3A84                    ; 0088D29A: dc.w $3A84
        dc.w    $2ABC                    ; 0088D29C: dc.w $2ABC
        dc.w    $9300                    ; 0088D29E: dc.w $9300
        dc.w    $9420                    ; 0088D2A0: dc.w $9420
        dc.w    $2ABC                    ; 0088D2A2: dc.w $2ABC
        dc.w    $9500                    ; 0088D2A4: dc.w $9500
        dc.w    $9688                    ; 0088D2A6: dc.w $9688
        dc.w    $3ABC                    ; 0088D2A8: dc.w $3ABC
        dc.w    $977F                    ; 0088D2AA: dc.w $977F
        dc.w    $3ABC                    ; 0088D2AC: dc.w $3ABC
        dc.w    $4220                    ; 0088D2AE: dc.w $4220
        dc.w    $31FC                    ; 0088D2B0: dc.w $31FC
        dc.w    $0080                    ; 0088D2B2: dc.w $0080
        dc.w    $C876                    ; 0088D2B4: dc.w $C876
        dc.w    $3AB8                    ; 0088D2B6: dc.w $3AB8
        dc.w    $C876                    ; 0088D2B8: dc.w $C876
        dc.w    $3AB8                    ; 0088D2BA: dc.w $3AB8
        dc.w    $C874                    ; 0088D2BC: dc.w $C874
        dc.w    $33FC                    ; 0088D2BE: dc.w $33FC
        dc.w    $0000                    ; 0088D2C0: dc.w $0000
        dc.w    $00A1                    ; 0088D2C2: dc.w $00A1
        dc.w    $1100                    ; 0088D2C4: dc.w $1100
        dc.w    $3238                    ; 0088D2C6: dc.w $3238
        dc.w    $C89C                    ; 0088D2C8: dc.w $C89C
        dc.w    $E549                    ; 0088D2CA: dc.w $E549
        dc.w    $41FA                    ; 0088D2CC: dc.w $41FA
        dc.w    $0146                    ; 0088D2CE: dc.w $0146
        dc.w    $2230                    ; 0088D2D0: dc.w $2230
        dc.w    $1000                    ; 0088D2D2: dc.w $1000
        dc.w    $4EB9, $0088, $155E    ; 0088D2D4: JSR $0088155E
        dc.w    $3ABC                    ; 0088D2DA: dc.w $3ABC
        dc.w    $8B00                    ; 0088D2DC: dc.w $8B00
        dc.w    $7000                    ; 0088D2DE: MOVEQ #$00,D0
        dc.w    $72F8                    ; 0088D2E0: MOVEQ #$F8,D1
        dc.w    $4A38                    ; 0088D2E2: dc.w $4A38
        dc.w    $C80F                    ; 0088D2E4: dc.w $C80F
        dc.w    $6742                    ; 0088D2E6: BEQ.S $0088D32A
        dc.w    $7000                    ; 0088D2E8: MOVEQ #$00,D0
        dc.w    $7200                    ; 0088D2EA: MOVEQ #$00,D1
        dc.w    $43F9, $00FF, $1400    ; 0088D2EC: LEA $00FF1400,A1
        dc.w    $45F9, $00FF, $1000    ; 0088D2F2: LEA $00FF1000,A2
        dc.w    $4EB9, $0088, $48CA    ; 0088D2F8: JSR $008848CA
        dc.w    $4EB9, $0088, $48CE    ; 0088D2FE: JSR $008848CE
        dc.w    $4EB9, $0088, $48D2    ; 0088D304: JSR $008848D2
        dc.w    $43F9, $00FF, $1200    ; 0088D30A: LEA $00FF1200,A1
        dc.w    $4EB9, $0088, $48CA    ; 0088D310: JSR $008848CA
        dc.w    $4EB9, $0088, $48CE    ; 0088D316: JSR $008848CE
        dc.w    $4EB9, $0088, $48D2    ; 0088D31C: JSR $008848D2
        dc.w    $3ABC                    ; 0088D322: dc.w $3ABC
        dc.w    $8B03                    ; 0088D324: dc.w $8B03
        dc.w    $6100, $0112            ; 0088D326: BSR.W $0088D43A
        dc.w    $33FC                    ; 0088D32A: dc.w $33FC
        dc.w    $0100                    ; 0088D32C: dc.w $0100
        dc.w    $00A1                    ; 0088D32E: dc.w $00A1
        dc.w    $1100                    ; 0088D330: dc.w $1100
        dc.w    $0839                    ; 0088D332: dc.w $0839
        dc.w    $0000                    ; 0088D334: dc.w $0000
        dc.w    $00A1                    ; 0088D336: dc.w $00A1
        dc.w    $1100                    ; 0088D338: dc.w $1100
        dc.w    $66F6                    ; 0088D33A: BNE.S $0088D332
        dc.w    $3838                    ; 0088D33C: dc.w $3838
        dc.w    $C874                    ; 0088D33E: dc.w $C874
        dc.w    $08C4                    ; 0088D340: dc.w $08C4
        dc.w    $0004                    ; 0088D342: dc.w $0004
        dc.w    $3A84                    ; 0088D344: dc.w $3A84
        dc.w    $2ABC                    ; 0088D346: dc.w $2ABC
        dc.w    $9300                    ; 0088D348: dc.w $9300
        dc.w    $940E                    ; 0088D34A: dc.w $940E
        dc.w    $2ABC                    ; 0088D34C: dc.w $2ABC
        dc.w    $9500                    ; 0088D34E: dc.w $9500
        dc.w    $9688                    ; 0088D350: dc.w $9688
        dc.w    $3ABC                    ; 0088D352: dc.w $3ABC
        dc.w    $977F                    ; 0088D354: dc.w $977F
        dc.w    $3ABC                    ; 0088D356: dc.w $3ABC
        dc.w    $4000                    ; 0088D358: dc.w $4000
        dc.w    $31FC                    ; 0088D35A: dc.w $31FC
        dc.w    $0083                    ; 0088D35C: dc.w $0083
        dc.w    $C876                    ; 0088D35E: dc.w $C876
        dc.w    $3AB8                    ; 0088D360: dc.w $3AB8
        dc.w    $C876                    ; 0088D362: dc.w $C876
        dc.w    $3AB8                    ; 0088D364: dc.w $3AB8
        dc.w    $C874                    ; 0088D366: dc.w $C874
        dc.w    $33FC                    ; 0088D368: dc.w $33FC
        dc.w    $0000                    ; 0088D36A: dc.w $0000
        dc.w    $00A1                    ; 0088D36C: dc.w $00A1
        dc.w    $1100                    ; 0088D36E: dc.w $1100
        dc.w    $0838                    ; 0088D370: dc.w $0838
        dc.w    $0003                    ; 0088D372: dc.w $0003
        dc.w    $C80E                    ; 0088D374: dc.w $C80E
        dc.w    $6762                    ; 0088D376: BEQ.S $0088D3DA
        dc.w    $7200                    ; 0088D378: MOVEQ #$00,D1
        dc.w    $243C                    ; 0088D37A: dc.w $243C
        dc.w    $0000                    ; 0088D37C: dc.w $0000
        dc.w    $00B0                    ; 0088D37E: dc.w $00B0
        dc.w    $7E1B                    ; 0088D380: MOVEQ #$1B,D7
        dc.w    $43F9, $00FF, $1A50    ; 0088D382: LEA $00FF1A50,A1
        dc.w    $4EB9, $0088, $485E    ; 0088D388: JSR $0088485E
        dc.w    $D3C2                    ; 0088D38E: dc.w $D3C2
        dc.w    $51CF, $FFF6            ; 0088D390: DBRA D7,$0088D388
        dc.w    $33FC                    ; 0088D394: dc.w $33FC
        dc.w    $0100                    ; 0088D396: dc.w $0100
        dc.w    $00A1                    ; 0088D398: dc.w $00A1
        dc.w    $1100                    ; 0088D39A: dc.w $1100
        dc.w    $0839                    ; 0088D39C: dc.w $0839
        dc.w    $0000                    ; 0088D39E: dc.w $0000
        dc.w    $00A1                    ; 0088D3A0: dc.w $00A1
        dc.w    $1100                    ; 0088D3A2: dc.w $1100
        dc.w    $66F6                    ; 0088D3A4: BNE.S $0088D39C
        dc.w    $3838                    ; 0088D3A6: dc.w $3838
        dc.w    $C874                    ; 0088D3A8: dc.w $C874
        dc.w    $08C4                    ; 0088D3AA: dc.w $08C4
        dc.w    $0004                    ; 0088D3AC: dc.w $0004
        dc.w    $3A84                    ; 0088D3AE: dc.w $3A84
        dc.w    $2ABC                    ; 0088D3B0: dc.w $2ABC
        dc.w    $9300                    ; 0088D3B2: dc.w $9300
        dc.w    $940E                    ; 0088D3B4: dc.w $940E
        dc.w    $2ABC                    ; 0088D3B6: dc.w $2ABC
        dc.w    $9500                    ; 0088D3B8: dc.w $9500
        dc.w    $968D                    ; 0088D3BA: dc.w $968D
        dc.w    $3ABC                    ; 0088D3BC: dc.w $3ABC
        dc.w    $977F                    ; 0088D3BE: dc.w $977F
        dc.w    $3ABC                    ; 0088D3C0: dc.w $3ABC
        dc.w    $6000, $31FC            ; 0088D3C2: BRA.W $008905C0
        dc.w    $0082                    ; 0088D3C6: dc.w $0082
        dc.w    $C876                    ; 0088D3C8: dc.w $C876
        dc.w    $3AB8                    ; 0088D3CA: dc.w $3AB8
        dc.w    $C876                    ; 0088D3CC: dc.w $C876
        dc.w    $3AB8                    ; 0088D3CE: dc.w $3AB8
        dc.w    $C874                    ; 0088D3D0: dc.w $C874
        dc.w    $33FC                    ; 0088D3D2: dc.w $33FC
        dc.w    $0000                    ; 0088D3D4: dc.w $0000
        dc.w    $00A1                    ; 0088D3D6: dc.w $00A1
        dc.w    $1100                    ; 0088D3D8: dc.w $1100
        dc.w    $31FC                    ; 0088D3DA: dc.w $31FC
        dc.w    $FFFC                    ; 0088D3DC: dc.w $FFFC
        dc.w    $C880                    ; 0088D3DE: dc.w $C880
        dc.w    $31C1                    ; 0088D3E0: dc.w $31C1
        dc.w    $C882                    ; 0088D3E2: dc.w $C882
        dc.w    $31C0                    ; 0088D3E4: dc.w $31C0
        dc.w    $8000                    ; 0088D3E6: dc.w $8000
        dc.w    $31C0                    ; 0088D3E8: dc.w $31C0
        dc.w    $8002                    ; 0088D3EA: dc.w $8002
        dc.w    $2ABC                    ; 0088D3EC: dc.w $2ABC
        dc.w    $4000                    ; 0088D3EE: dc.w $4000
        dc.w    $0010                    ; 0088D3F0: dc.w $0010
        dc.w    $3CB8                    ; 0088D3F2: dc.w $3CB8
        dc.w    $C880                    ; 0088D3F4: dc.w $C880
        dc.w    $3CB8                    ; 0088D3F6: dc.w $3CB8
        dc.w    $C882                    ; 0088D3F8: dc.w $C882
        dc.w    $4E75                    ; 0088D3FA: RTS
        dc.w    $0000                    ; 0088D3FC: dc.w $0000
        dc.w    $0001                    ; 0088D3FE: dc.w $0001
        dc.w    $0000                    ; 0088D400: dc.w $0000
        dc.w    $0002                    ; 0088D402: dc.w $0002
        dc.w    $0000                    ; 0088D404: dc.w $0000
        dc.w    $0003                    ; 0088D406: dc.w $0003
        dc.w    $0000                    ; 0088D408: dc.w $0000
        dc.w    $0005                    ; 0088D40A: dc.w $0005
        dc.w    $0000                    ; 0088D40C: dc.w $0000
        dc.w    $0004                    ; 0088D40E: dc.w $0004
        dc.w    $0000                    ; 0088D410: dc.w $0000
        dc.w    $0004                    ; 0088D412: dc.w $0004
        dc.w    $0000                    ; 0088D414: dc.w $0000
        dc.w    $0001                    ; 0088D416: dc.w $0001
        dc.w    $0000                    ; 0088D418: dc.w $0000
        dc.w    $0005                    ; 0088D41A: dc.w $0005
        dc.w    $0000                    ; 0088D41C: dc.w $0000
        dc.w    $0006                    ; 0088D41E: dc.w $0006
        dc.w    $0000                    ; 0088D420: dc.w $0000
        dc.w    $0004                    ; 0088D422: dc.w $0004
        dc.w    $0000                    ; 0088D424: dc.w $0000
        dc.w    $0007                    ; 0088D426: dc.w $0007
        dc.w    $0000                    ; 0088D428: dc.w $0000
        dc.w    $0007                    ; 0088D42A: dc.w $0007
        dc.w    $2ABC                    ; 0088D42C: dc.w $2ABC
        dc.w    $4000                    ; 0088D42E: dc.w $4000
        dc.w    $0000                    ; 0088D430: dc.w $0000
        dc.w    $7200                    ; 0088D432: MOVEQ #$00,D1
        dc.w    $4EF9, $0088, $48B8    ; 0088D434: JMP $008848B8
        dc.w    $43F8                    ; 0088D43A: dc.w $43F8
        dc.w    $8000                    ; 0088D43C: dc.w $8000
        dc.w    $7200                    ; 0088D43E: MOVEQ #$00,D1
        dc.w    $4EB9, $0088, $483E    ; 0088D440: JSR $0088483E
        dc.w    $4EF9, $0088, $4842    ; 0088D446: JMP $00884842
        dc.w    $050A                    ; 0088D44C: dc.w $050A
        dc.w    $0F14                    ; 0088D44E: dc.w $0F14
        dc.w    $7000                    ; 0088D450: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088D452: dc.w $1038
        dc.w    $FEA8                    ; 0088D454: dc.w $FEA8
        dc.w    $1238                    ; 0088D456: dc.w $1238
        dc.w    $C80F                    ; 0088D458: dc.w $C80F
        dc.w    $6704                    ; 0088D45A: BEQ.S $0088D460
        dc.w    $1038                    ; 0088D45C: dc.w $1038
        dc.w    $FEAC                    ; 0088D45E: dc.w $FEAC
        dc.w    $11FB                    ; 0088D460: dc.w $11FB
        dc.w    $00EA                    ; 0088D462: dc.w $00EA
        dc.w    $C81A                    ; 0088D464: dc.w $C81A
        dc.w    $41F9, $0089, $8BFC    ; 0088D466: LEA $00898BFC,A0
        dc.w    $E548                    ; 0088D46C: dc.w $E548
        dc.w    $D1C0                    ; 0088D46E: dc.w $D1C0
        dc.w    $23D0                    ; 0088D470: dc.w $23D0
        dc.w    $00FF                    ; 0088D472: dc.w $00FF
        dc.w    $6828                    ; 0088D474: BVC.S $0088D49E
        dc.w    $4A01                    ; 0088D476: dc.w $4A01
        dc.w    $6706                    ; 0088D478: BEQ.S $0088D480
        dc.w    $23D0                    ; 0088D47A: dc.w $23D0
        dc.w    $00FF                    ; 0088D47C: dc.w $00FF
        dc.w    $68B8                    ; 0088D47E: BVC.S $0088D438
        dc.w    $4E75                    ; 0088D480: RTS
        dc.w    $0088                    ; 0088D482: dc.w $0088
        dc.w    $0088                    ; 0088D484: dc.w $0088
        dc.w    $00DC                    ; 0088D486: dc.w $00DC
        dc.w    $0130                    ; 0088D488: dc.w $0130
        dc.w    $4238                    ; 0088D48A: dc.w $4238
        dc.w    $A024                    ; 0088D48C: dc.w $A024
        dc.w    $11F8                    ; 0088D48E: dc.w $11F8
        dc.w    $FEA5                    ; 0088D490: dc.w $FEA5
        dc.w    $A019                    ; 0088D492: dc.w $A019
        dc.w    $0838                    ; 0088D494: dc.w $0838
        dc.w    $0007                    ; 0088D496: dc.w $0007
        dc.w    $FDA8                    ; 0088D498: dc.w $FDA8
        dc.w    $672E                    ; 0088D49A: BEQ.S $0088D4CA
        dc.w    $11F8                    ; 0088D49C: dc.w $11F8
        dc.w    $FEA6                    ; 0088D49E: dc.w $FEA6
        dc.w    $A019                    ; 0088D4A0: dc.w $A019
        dc.w    $6026                    ; 0088D4A2: BRA.S $0088D4CA
        dc.w    $11FC                    ; 0088D4A4: dc.w $11FC
        dc.w    $0001                    ; 0088D4A6: dc.w $0001
        dc.w    $A024                    ; 0088D4A8: dc.w $A024
        dc.w    $11F8                    ; 0088D4AA: dc.w $11F8
        dc.w    $FEA7                    ; 0088D4AC: dc.w $FEA7
        dc.w    $A019                    ; 0088D4AE: dc.w $A019
        dc.w    $11F8                    ; 0088D4B0: dc.w $11F8
        dc.w    $FEA8                    ; 0088D4B2: dc.w $FEA8
        dc.w    $A026                    ; 0088D4B4: dc.w $A026
        dc.w    $6012                    ; 0088D4B6: BRA.S $0088D4CA
        dc.w    $11F8                    ; 0088D4B8: dc.w $11F8
        dc.w    $FEAB                    ; 0088D4BA: dc.w $FEAB
        dc.w    $A019                    ; 0088D4BC: dc.w $A019
        dc.w    $11F8                    ; 0088D4BE: dc.w $11F8
        dc.w    $FEAC                    ; 0088D4C0: dc.w $FEAC
        dc.w    $A026                    ; 0088D4C2: dc.w $A026
        dc.w    $11FC                    ; 0088D4C4: dc.w $11FC
        dc.w    $0002                    ; 0088D4C6: dc.w $0002
        dc.w    $A024                    ; 0088D4C8: dc.w $A024
        dc.w    $33FC                    ; 0088D4CA: dc.w $33FC
        dc.w    $002C                    ; 0088D4CC: dc.w $002C
        dc.w    $00FF                    ; 0088D4CE: dc.w $00FF
        dc.w    $0008                    ; 0088D4D0: dc.w $0008
        dc.w    $31FC                    ; 0088D4D2: dc.w $31FC
        dc.w    $002C                    ; 0088D4D4: dc.w $002C
        dc.w    $C87A                    ; 0088D4D6: dc.w $C87A
        dc.w    $08B8                    ; 0088D4D8: dc.w $08B8
        dc.w    $0006                    ; 0088D4DA: dc.w $0006
        dc.w    $C875                    ; 0088D4DC: dc.w $C875
        dc.w    $3AB8                    ; 0088D4DE: dc.w $3AB8
        dc.w    $C874                    ; 0088D4E0: dc.w $C874
        dc.w    $33FC                    ; 0088D4E2: dc.w $33FC
        dc.w    $0083                    ; 0088D4E4: dc.w $0083
        dc.w    $00A1                    ; 0088D4E6: dc.w $00A1
        dc.w    $5100                    ; 0088D4E8: dc.w $5100
        dc.w    $0239                    ; 0088D4EA: dc.w $0239
        dc.w    $00FC                    ; 0088D4EC: dc.w $00FC
        dc.w    $00A1                    ; 0088D4EE: dc.w $00A1
        dc.w    $5181                    ; 0088D4F0: dc.w $5181
        dc.w    $4EB9, $0088, $26C8    ; 0088D4F2: JSR $008826C8
        dc.w    $203C                    ; 0088D4F8: dc.w $203C
        dc.w    $000A                    ; 0088D4FA: dc.w $000A
        dc.w    $0907                    ; 0088D4FC: dc.w $0907
        dc.w    $4EB9, $0088, $14BE    ; 0088D4FE: JSR $008814BE
        dc.w    $11FC                    ; 0088D504: dc.w $11FC
        dc.w    $0001                    ; 0088D506: dc.w $0001
        dc.w    $C80D                    ; 0088D508: dc.w $C80D
        dc.w    $41F9, $0088, $D832    ; 0088D50A: LEA $0088D832,A0
        dc.w    $43F9, $00FF, $2000    ; 0088D510: LEA $00FF2000,A1
        dc.w    $303C                    ; 0088D516: dc.w $303C
        dc.w    $0004                    ; 0088D518: dc.w $0004
        dc.w    $32D8                    ; 0088D51A: dc.w $32D8
        dc.w    $32D8                    ; 0088D51C: dc.w $32D8
        dc.w    $32D8                    ; 0088D51E: dc.w $32D8
        dc.w    $32D8                    ; 0088D520: dc.w $32D8
        dc.w    $32D8                    ; 0088D522: dc.w $32D8
        dc.w    $51C8, $FFF4            ; 0088D524: DBRA D0,$0088D51A
        dc.w    $7000                    ; 0088D528: MOVEQ #$00,D0
        dc.w    $41F8                    ; 0088D52A: dc.w $41F8
        dc.w    $8480                    ; 0088D52C: dc.w $8480
        dc.w    $721F                    ; 0088D52E: MOVEQ #$1F,D1
        dc.w    $20C0                    ; 0088D530: dc.w $20C0
        dc.w    $51C9, $FFFC            ; 0088D532: DBRA D1,$0088D530
        dc.w    $41F9, $00FF, $7B80    ; 0088D536: LEA $00FF7B80,A0
        dc.w    $727F                    ; 0088D53C: MOVEQ #$7F,D1
        dc.w    $20C0                    ; 0088D53E: dc.w $20C0
        dc.w    $51C9, $FFFC            ; 0088D540: DBRA D1,$0088D53E
        dc.w    $2ABC                    ; 0088D544: dc.w $2ABC
        dc.w    $6000, $0002            ; 0088D546: BRA.W $0088D54A
        dc.w    $323C                    ; 0088D54A: dc.w $323C
        dc.w    $17FF                    ; 0088D54C: dc.w $17FF
        dc.w    $2C80                    ; 0088D54E: dc.w $2C80
        dc.w    $51C9, $FFFC            ; 0088D550: DBRA D1,$0088D54E
        dc.w    $4EB9, $0088, $49AA    ; 0088D554: JSR $008849AA
        dc.w    $4278                    ; 0088D55A: dc.w $4278
        dc.w    $C880                    ; 0088D55C: dc.w $C880
        dc.w    $4278                    ; 0088D55E: dc.w $4278
        dc.w    $C882                    ; 0088D560: dc.w $C882
        dc.w    $4278                    ; 0088D562: dc.w $4278
        dc.w    $8000                    ; 0088D564: dc.w $8000
        dc.w    $4278                    ; 0088D566: dc.w $4278
        dc.w    $8002                    ; 0088D568: dc.w $8002
        dc.w    $4278                    ; 0088D56A: dc.w $4278
        dc.w    $A012                    ; 0088D56C: dc.w $A012
        dc.w    $4238                    ; 0088D56E: dc.w $4238
        dc.w    $A018                    ; 0088D570: dc.w $A018
        dc.w    $4EB9, $0088, $49AA    ; 0088D572: JSR $008849AA
        dc.w    $21FC                    ; 0088D578: dc.w $21FC
        dc.w    $008B                    ; 0088D57A: dc.w $008B
        dc.w    $B4FC                    ; 0088D57C: dc.w $B4FC
        dc.w    $C96C                    ; 0088D57E: dc.w $C96C
        dc.w    $11FC                    ; 0088D580: dc.w $11FC
        dc.w    $0001                    ; 0088D582: dc.w $0001
        dc.w    $C809                    ; 0088D584: dc.w $C809
        dc.w    $11FC                    ; 0088D586: dc.w $11FC
        dc.w    $0001                    ; 0088D588: dc.w $0001
        dc.w    $C80A                    ; 0088D58A: dc.w $C80A
        dc.w    $08F8                    ; 0088D58C: dc.w $08F8
        dc.w    $0006                    ; 0088D58E: dc.w $0006
        dc.w    $C80E                    ; 0088D590: dc.w $C80E
        dc.w    $11FC                    ; 0088D592: dc.w $11FC
        dc.w    $0001                    ; 0088D594: dc.w $0001
        dc.w    $C802                    ; 0088D596: dc.w $C802
        dc.w    $31FC                    ; 0088D598: dc.w $31FC
        dc.w    $0001                    ; 0088D59A: dc.w $0001
        dc.w    $A02C                    ; 0088D59C: dc.w $A02C
        dc.w    $41F9, $00FF, $1000    ; 0088D59E: LEA $00FF1000,A0
        dc.w    $303C                    ; 0088D5A4: dc.w $303C
        dc.w    $037F                    ; 0088D5A6: dc.w $037F
        dc.w    $4298                    ; 0088D5A8: dc.w $4298
        dc.w    $51C8, $FFFC            ; 0088D5AA: DBRA D0,$0088D5A8
        dc.w    $4EBA                    ; 0088D5AE: dc.w $4EBA
        dc.w    $0C0C                    ; 0088D5B0: dc.w $0C0C
        dc.w    $08B9                    ; 0088D5B2: dc.w $08B9
        dc.w    $0007                    ; 0088D5B4: dc.w $0007
        dc.w    $00A1                    ; 0088D5B6: dc.w $00A1
        dc.w    $5181                    ; 0088D5B8: dc.w $5181
        dc.w    $41F9, $00FF, $6E00    ; 0088D5BA: LEA $00FF6E00,A0
        dc.w    $D1FC                    ; 0088D5C0: dc.w $D1FC
        dc.w    $0000                    ; 0088D5C2: dc.w $0000
        dc.w    $0160                    ; 0088D5C4: dc.w $0160
        dc.w    $43F9, $0088, $D7B2    ; 0088D5C6: LEA $0088D7B2,A1
        dc.w    $303C                    ; 0088D5CC: dc.w $303C
        dc.w    $003F                    ; 0088D5CE: dc.w $003F
        dc.w    $3219                    ; 0088D5D0: dc.w $3219
        dc.w    $08C1                    ; 0088D5D2: dc.w $08C1
        dc.w    $000F                    ; 0088D5D4: dc.w $000F
        dc.w    $30C1                    ; 0088D5D6: dc.w $30C1
        dc.w    $51C8, $FFF6            ; 0088D5D8: DBRA D0,$0088D5D0
        dc.w    $41F9, $000E, $8000    ; 0088D5DC: LEA $000E8000,A0
        dc.w    $227C, $0603, $7000    ; 0088D5E2: MOVEA.L #$06037000,A1
        dc.w    $6100, $0D2C            ; 0088D5E8: BSR.W $0088E316
        dc.w    $0838                    ; 0088D5EC: dc.w $0838
        dc.w    $0007                    ; 0088D5EE: dc.w $0007
        dc.w    $FDA8                    ; 0088D5F0: dc.w $FDA8
        dc.w    $6718                    ; 0088D5F2: BEQ.S $0088D60C
        dc.w    $4A39                    ; 0088D5F4: dc.w $4A39
        dc.w    $00A1                    ; 0088D5F6: dc.w $00A1
        dc.w    $5120                    ; 0088D5F8: dc.w $5120
        dc.w    $66F8                    ; 0088D5FA: BNE.S $0088D5F4
        dc.w    $13FC                    ; 0088D5FC: dc.w $13FC
        dc.w    $002E                    ; 0088D5FE: dc.w $002E
        dc.w    $00A1                    ; 0088D600: dc.w $00A1
        dc.w    $5121                    ; 0088D602: dc.w $5121
        dc.w    $13FC                    ; 0088D604: dc.w $13FC
        dc.w    $0001                    ; 0088D606: dc.w $0001
        dc.w    $00A1                    ; 0088D608: dc.w $00A1
        dc.w    $5120                    ; 0088D60A: dc.w $5120
        dc.w    $41F9, $000E, $8C00    ; 0088D60C: LEA $000E8C00,A0
        dc.w    $227C, $0603, $D100    ; 0088D612: MOVEA.L #$0603D100,A1
        dc.w    $6100, $0CFC            ; 0088D618: BSR.W $0088E316
        dc.w    $4A38                    ; 0088D61C: dc.w $4A38
        dc.w    $A024                    ; 0088D61E: dc.w $A024
        dc.w    $6600, $004E            ; 0088D620: BNE.W $0088D670
        dc.w    $41F9, $000E, $8A00    ; 0088D624: LEA $000E8A00,A0
        dc.w    $227C, $0603, $B600    ; 0088D62A: MOVEA.L #$0603B600,A1
        dc.w    $6100, $0CE4            ; 0088D630: BSR.W $0088E316
        dc.w    $41F9, $000E, $B980    ; 0088D634: LEA $000EB980,A0
        dc.w    $227C, $0603, $DA00    ; 0088D63A: MOVEA.L #$0603DA00,A1
        dc.w    $6100, $0CD4            ; 0088D640: BSR.W $0088E316
        dc.w    $303C                    ; 0088D644: dc.w $303C
        dc.w    $0001                    ; 0088D646: dc.w $0001
        dc.w    $323C                    ; 0088D648: dc.w $323C
        dc.w    $0001                    ; 0088D64A: dc.w $0001
        dc.w    $343C                    ; 0088D64C: dc.w $343C
        dc.w    $0001                    ; 0088D64E: dc.w $0001
        dc.w    $363C                    ; 0088D650: dc.w $363C
        dc.w    $0026                    ; 0088D652: dc.w $0026
        dc.w    $383C                    ; 0088D654: dc.w $383C
        dc.w    $001A                    ; 0088D656: dc.w $001A
        dc.w    $41F9, $00FF, $1000    ; 0088D658: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088D65E: dc.w $4EBA
        dc.w    $0BCC                    ; 0088D660: dc.w $0BCC
        dc.w    $41F9, $00FF, $1000    ; 0088D662: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088D668: dc.w $4EBA
        dc.w    $0C86                    ; 0088D66A: dc.w $0C86
        dc.w    $6000, $0068            ; 0088D66C: BRA.W $0088D6D6
        dc.w    $41F9, $000E, $8E10    ; 0088D670: LEA $000E8E10,A0
        dc.w    $227C, $0603, $B600    ; 0088D676: MOVEA.L #$0603B600,A1
        dc.w    $6100, $0C98            ; 0088D67C: BSR.W $0088E316
        dc.w    $41F9, $000E, $8FB0    ; 0088D680: LEA $000E8FB0,A0
        dc.w    $227C, $0603, $DA00    ; 0088D686: MOVEA.L #$0603DA00,A1
        dc.w    $6100, $0C88            ; 0088D68C: BSR.W $0088E316
        dc.w    $303C                    ; 0088D690: dc.w $303C
        dc.w    $0001                    ; 0088D692: dc.w $0001
        dc.w    $323C                    ; 0088D694: dc.w $323C
        dc.w    $0001                    ; 0088D696: dc.w $0001
        dc.w    $343C                    ; 0088D698: dc.w $343C
        dc.w    $0001                    ; 0088D69A: dc.w $0001
        dc.w    $363C                    ; 0088D69C: dc.w $363C
        dc.w    $0026                    ; 0088D69E: dc.w $0026
        dc.w    $383C                    ; 0088D6A0: dc.w $383C
        dc.w    $0016                    ; 0088D6A2: dc.w $0016
        dc.w    $41F9, $00FF, $1000    ; 0088D6A4: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088D6AA: dc.w $4EBA
        dc.w    $0B80                    ; 0088D6AC: dc.w $0B80
        dc.w    $303C                    ; 0088D6AE: dc.w $303C
        dc.w    $0002                    ; 0088D6B0: dc.w $0002
        dc.w    $323C                    ; 0088D6B2: dc.w $323C
        dc.w    $0001                    ; 0088D6B4: dc.w $0001
        dc.w    $343C                    ; 0088D6B6: dc.w $343C
        dc.w    $0017                    ; 0088D6B8: dc.w $0017
        dc.w    $363C                    ; 0088D6BA: dc.w $363C
        dc.w    $0026                    ; 0088D6BC: dc.w $0026
        dc.w    $383C                    ; 0088D6BE: dc.w $383C
        dc.w    $0004                    ; 0088D6C0: dc.w $0004
        dc.w    $41F9, $00FF, $1000    ; 0088D6C2: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088D6C8: dc.w $4EBA
        dc.w    $0B62                    ; 0088D6CA: dc.w $0B62
        dc.w    $41F9, $00FF, $1000    ; 0088D6CC: LEA $00FF1000,A0
        dc.w    $4EBA                    ; 0088D6D2: dc.w $4EBA
        dc.w    $0C1C                    ; 0088D6D4: dc.w $0C1C
        dc.w    $4238                    ; 0088D6D6: dc.w $4238
        dc.w    $A027                    ; 0088D6D8: dc.w $A027
        dc.w    $7000                    ; 0088D6DA: MOVEQ #$00,D0
        dc.w    $7200                    ; 0088D6DC: MOVEQ #$00,D1
        dc.w    $1038                    ; 0088D6DE: dc.w $1038
        dc.w    $FEB1                    ; 0088D6E0: dc.w $FEB1
        dc.w    $670C                    ; 0088D6E2: BEQ.S $0088D6F0
        dc.w    $5340                    ; 0088D6E4: dc.w $5340
        dc.w    $0681                    ; 0088D6E6: dc.w $0681
        dc.w    $0000                    ; 0088D6E8: dc.w $0000
        dc.w    $03C0                    ; 0088D6EA: dc.w $03C0
        dc.w    $51C8, $FFF8            ; 0088D6EC: DBRA D0,$0088D6E6
        dc.w    $5881                    ; 0088D6F0: dc.w $5881
        dc.w    $21C1                    ; 0088D6F2: dc.w $21C1
        dc.w    $A028                    ; 0088D6F4: dc.w $A028
        dc.w    $4EB9, $0088, $204A    ; 0088D6F6: JSR $0088204A
        dc.w    $0239                    ; 0088D6FC: dc.w $0239
        dc.w    $00FC                    ; 0088D6FE: dc.w $00FC
        dc.w    $00A1                    ; 0088D700: dc.w $00A1
        dc.w    $5181                    ; 0088D702: dc.w $5181
        dc.w    $0039                    ; 0088D704: dc.w $0039
        dc.w    $0001                    ; 0088D706: dc.w $0001
        dc.w    $00A1                    ; 0088D708: dc.w $00A1
        dc.w    $5181                    ; 0088D70A: dc.w $5181
        dc.w    $33FC                    ; 0088D70C: dc.w $33FC
        dc.w    $8083                    ; 0088D70E: dc.w $8083
        dc.w    $00A1                    ; 0088D710: dc.w $00A1
        dc.w    $5100                    ; 0088D712: dc.w $5100
        dc.w    $08F8                    ; 0088D714: dc.w $08F8
        dc.w    $0006                    ; 0088D716: dc.w $0006
        dc.w    $C875                    ; 0088D718: dc.w $C875
        dc.w    $3AB8                    ; 0088D71A: dc.w $3AB8
        dc.w    $C874                    ; 0088D71C: dc.w $C874
        dc.w    $33FC                    ; 0088D71E: dc.w $33FC
        dc.w    $0020                    ; 0088D720: dc.w $0020
        dc.w    $00FF                    ; 0088D722: dc.w $00FF
        dc.w    $0008                    ; 0088D724: dc.w $0008
        dc.w    $4EB9, $0088, $4998    ; 0088D726: JSR $00884998
        dc.w    $31FC                    ; 0088D72C: dc.w $31FC
        dc.w    $0000                    ; 0088D72E: dc.w $0000
        dc.w    $C87E                    ; 0088D730: dc.w $C87E
        dc.w    $23FC, $0088, $D864, $00FF, $0002  ; 0088D732: MOVE.L #$0088D864,$00FF0002
        dc.w    $4A38                    ; 0088D73C: dc.w $4A38
        dc.w    $A024                    ; 0088D73E: dc.w $A024
        dc.w    $670A                    ; 0088D740: BEQ.S $0088D74C
        dc.w    $23FC, $0088, $D888, $00FF, $0002  ; 0088D742: MOVE.L #$0088D888,$00FF0002
        dc.w    $13FC                    ; 0088D74C: dc.w $13FC
        dc.w    $0000                    ; 0088D74E: dc.w $0000
        dc.w    $00FF                    ; 0088D750: dc.w $00FF
        dc.w    $60D4                    ; 0088D752: BRA.S $0088D728
        dc.w    $0838                    ; 0088D754: dc.w $0838
        dc.w    $0007                    ; 0088D756: dc.w $0007
        dc.w    $FDA8                    ; 0088D758: dc.w $FDA8
        dc.w    $6700, $000A            ; 0088D75A: BEQ.W $0088D766
        dc.w    $13FC                    ; 0088D75E: dc.w $13FC
        dc.w    $0001                    ; 0088D760: dc.w $0001
        dc.w    $00FF                    ; 0088D762: dc.w $00FF
        dc.w    $60D4                    ; 0088D764: BRA.S $0088D73A
        dc.w    $41F9, $00FF, $6100    ; 0088D766: LEA $00FF6100,A0
        dc.w    $303C                    ; 0088D76C: dc.w $303C
        dc.w    $007F                    ; 0088D76E: dc.w $007F
        dc.w    $4298                    ; 0088D770: dc.w $4298
        dc.w    $4298                    ; 0088D772: dc.w $4298
        dc.w    $4298                    ; 0088D774: dc.w $4298
        dc.w    $4298                    ; 0088D776: dc.w $4298
        dc.w    $4298                    ; 0088D778: dc.w $4298
        dc.w    $51C8, $FFF4            ; 0088D77A: DBRA D0,$0088D770
        dc.w    $4A39                    ; 0088D77E: dc.w $4A39
        dc.w    $00A1                    ; 0088D780: dc.w $00A1
        dc.w    $5120                    ; 0088D782: dc.w $5120
        dc.w    $66F8                    ; 0088D784: BNE.S $0088D77E
        dc.w    $4239                    ; 0088D786: dc.w $4239
        dc.w    $00A1                    ; 0088D788: dc.w $00A1
        dc.w    $5122                    ; 0088D78A: dc.w $5122
        dc.w    $4239                    ; 0088D78C: dc.w $4239
        dc.w    $00A1                    ; 0088D78E: dc.w $00A1
        dc.w    $5123                    ; 0088D790: dc.w $5123
        dc.w    $13FC                    ; 0088D792: dc.w $13FC
        dc.w    $0003                    ; 0088D794: dc.w $0003
        dc.w    $00A1                    ; 0088D796: dc.w $00A1
        dc.w    $5121                    ; 0088D798: dc.w $5121
        dc.w    $13FC                    ; 0088D79A: dc.w $13FC
        dc.w    $0001                    ; 0088D79C: dc.w $0001
        dc.w    $00A1                    ; 0088D79E: dc.w $00A1
        dc.w    $5120                    ; 0088D7A0: dc.w $5120
        dc.w    $4A39                    ; 0088D7A2: dc.w $4A39
        dc.w    $00A1                    ; 0088D7A4: dc.w $00A1
        dc.w    $5120                    ; 0088D7A6: dc.w $5120
        dc.w    $66F8                    ; 0088D7A8: BNE.S $0088D7A2
        dc.w    $11FC                    ; 0088D7AA: dc.w $11FC
        dc.w    $0081                    ; 0088D7AC: dc.w $0081
        dc.w    $C8A5                    ; 0088D7AE: dc.w $C8A5
        dc.w    $4E75                    ; 0088D7B0: RTS
        dc.w    $4400                    ; 0088D7B2: dc.w $4400
        dc.w    $44A3                    ; 0088D7B4: dc.w $44A3
        dc.w    $4946                    ; 0088D7B6: dc.w $4946
        dc.w    $4DE9                    ; 0088D7B8: dc.w $4DE9
        dc.w    $1C00                    ; 0088D7BA: dc.w $1C00
        dc.w    $28A3                    ; 0088D7BC: dc.w $28A3
        dc.w    $3546                    ; 0088D7BE: dc.w $3546
        dc.w    $41E9                    ; 0088D7C0: dc.w $41E9
        dc.w    $7FFF                    ; 0088D7C2: dc.w $7FFF
        dc.w    $7FFF                    ; 0088D7C4: dc.w $7FFF
        dc.w    $7FFF                    ; 0088D7C6: dc.w $7FFF
        dc.w    $7FFF                    ; 0088D7C8: dc.w $7FFF
        dc.w    $1C00                    ; 0088D7CA: dc.w $1C00
        dc.w    $28A3                    ; 0088D7CC: dc.w $28A3
        dc.w    $3546                    ; 0088D7CE: dc.w $3546
        dc.w    $41E9                    ; 0088D7D0: dc.w $41E9
        dc.w    $4400                    ; 0088D7D2: dc.w $4400
        dc.w    $44A3                    ; 0088D7D4: dc.w $44A3
        dc.w    $4946                    ; 0088D7D6: dc.w $4946
        dc.w    $4DE9                    ; 0088D7D8: dc.w $4DE9
        dc.w    $7FFF                    ; 0088D7DA: dc.w $7FFF
        dc.w    $63F5                    ; 0088D7DC: BLS.S $0088D7D3
        dc.w    $7FFF                    ; 0088D7DE: dc.w $7FFF
        dc.w    $7FFF                    ; 0088D7E0: dc.w $7FFF
        dc.w    $0010                    ; 0088D7E2: dc.w $0010
        dc.w    $14AF                    ; 0088D7E4: dc.w $14AF
        dc.w    $294E                    ; 0088D7E6: dc.w $294E
        dc.w    $3DED                    ; 0088D7E8: dc.w $3DED
        dc.w    $7FFF                    ; 0088D7EA: dc.w $7FFF
        dc.w    $7FFF                    ; 0088D7EC: dc.w $7FFF
        dc.w    $7FFF                    ; 0088D7EE: dc.w $7FFF
        dc.w    $7FFF                    ; 0088D7F0: dc.w $7FFF
        dc.w    $6337                    ; 0088D7F2: BLS.S $0088D82B
        dc.w    $6737                    ; 0088D7F4: BEQ.S $0088D82D
        dc.w    $6B58                    ; 0088D7F6: BMI.S $0088D850
        dc.w    $6F79                    ; 0088D7F8: BLE.S $0088D873
        dc.w    $6B36                    ; 0088D7FA: BMI.S $0088D832
        dc.w    $6B37                    ; 0088D7FC: BMI.S $0088D835
        dc.w    $6F58                    ; 0088D7FE: BLE.S $0088D858
        dc.w    $6F79                    ; 0088D800: BLE.S $0088D87B
        dc.w    $739A                    ; 0088D802: dc.w $739A
        dc.w    $61E8                    ; 0088D804: BSR.S $0088D7EE
        dc.w    $7FFF                    ; 0088D806: dc.w $7FFF
        dc.w    $1D4A                    ; 0088D808: dc.w $1D4A
        dc.w    $4B3A                    ; 0088D80A: dc.w $4B3A
        dc.w    $67FF                    ; 0088D80C: BEQ.S $0088D80D
        dc.w    $3AB6                    ; 0088D80E: dc.w $3AB6
        dc.w    $25CE                    ; 0088D810: dc.w $25CE
        dc.w    $10E1                    ; 0088D812: dc.w $10E1
        dc.w    $29A8                    ; 0088D814: dc.w $29A8
        dc.w    $4670                    ; 0088D816: dc.w $4670
        dc.w    $6337                    ; 0088D818: BLS.S $0088D851
        dc.w    $4445                    ; 0088D81A: dc.w $4445
        dc.w    $512B                    ; 0088D81C: dc.w $512B
        dc.w    $6212                    ; 0088D81E: BHI.S $0088D832
        dc.w    $6EF8                    ; 0088D820: BGT.S $0088D81A
        dc.w    $7FFF                    ; 0088D822: dc.w $7FFF
        dc.w    $031F                    ; 0088D824: dc.w $031F
        dc.w    $7FFF                    ; 0088D826: dc.w $7FFF
        dc.w    $0000                    ; 0088D828: dc.w $0000
        dc.w    $033E                    ; 0088D82A: dc.w $033E
        dc.w    $63FF                    ; 0088D82C: BLS.S $0088D82D
        dc.w    $01AF                    ; 0088D82E: dc.w $01AF
        dc.w    $0086                    ; 0088D830: dc.w $0086
        dc.w    $0000                    ; 0088D832: dc.w $0000
        dc.w    $0070                    ; 0088D834: dc.w $0070
        dc.w    $0110                    ; 0088D836: dc.w $0110
        dc.w    $0300                    ; 0088D838: dc.w $0300
        dc.w    $0000                    ; 0088D83A: dc.w $0000
        dc.w    $0000                    ; 0088D83C: dc.w $0000
        dc.w    $0110                    ; 0088D83E: dc.w $0110
        dc.w    $0130                    ; 0088D840: dc.w $0130
        dc.w    $02C0                    ; 0088D842: dc.w $02C0
        dc.w    $0000                    ; 0088D844: dc.w $0000
        dc.w    $0000                    ; 0088D846: dc.w $0000
        dc.w    $0120                    ; 0088D848: dc.w $0120
        dc.w    $0170                    ; 0088D84A: dc.w $0170
        dc.w    $02C0                    ; 0088D84C: dc.w $02C0
        dc.w    $0000                    ; 0088D84E: dc.w $0000
        dc.w    $0000                    ; 0088D850: dc.w $0000
        dc.w    $0000                    ; 0088D852: dc.w $0000
        dc.w    $0150                    ; 0088D854: dc.w $0150
        dc.w    $02C0                    ; 0088D856: dc.w $02C0
        dc.w    $0000                    ; 0088D858: dc.w $0000
        dc.w    $0000                    ; 0088D85A: dc.w $0000
        dc.w    $0000                    ; 0088D85C: dc.w $0000
        dc.w    $0180                    ; 0088D85E: dc.w $0180
        dc.w    $02C0                    ; 0088D860: dc.w $02C0
        dc.w    $0000                    ; 0088D862: dc.w $0000
        dc.w    $4EB9, $0088, $2080    ; 0088D864: JSR $00882080
        dc.w    $3038                    ; 0088D86A: dc.w $3038
        dc.w    $C87E                    ; 0088D86C: dc.w $C87E
        dc.w    $227B                    ; 0088D86E: dc.w $227B
        dc.w    $0004                    ; 0088D870: dc.w $0004
        dc.w    $4ED1                    ; 0088D872: JMP (A1)
        dc.w    $0088                    ; 0088D874: dc.w $0088
        dc.w    $D8CC                    ; 0088D876: dc.w $D8CC
        dc.w    $0088                    ; 0088D878: dc.w $0088
        dc.w    $DAC0                    ; 0088D87A: dc.w $DAC0
        dc.w    $0088                    ; 0088D87C: dc.w $0088
        dc.w    $DCD0                    ; 0088D87E: dc.w $DCD0
        dc.w    $0088                    ; 0088D880: dc.w $0088
        dc.w    $DFEC                    ; 0088D882: dc.w $DFEC
        dc.w    $0088                    ; 0088D884: dc.w $0088
        dc.w    $E00C                    ; 0088D886: dc.w $E00C
        dc.w    $4EB9, $0088, $2080    ; 0088D888: JSR $00882080
        dc.w    $3038                    ; 0088D88E: dc.w $3038
        dc.w    $C87E                    ; 0088D890: dc.w $C87E
        dc.w    $227B                    ; 0088D892: dc.w $227B
        dc.w    $0004                    ; 0088D894: dc.w $0004
        dc.w    $4ED1                    ; 0088D896: JMP (A1)
        dc.w    $0088                    ; 0088D898: dc.w $0088
        dc.w    $D8CC                    ; 0088D89A: dc.w $D8CC
        dc.w    $0088                    ; 0088D89C: dc.w $0088
        dc.w    $DAC0                    ; 0088D89E: dc.w $DAC0
        dc.w    $0088                    ; 0088D8A0: dc.w $0088
        dc.w    $DECE                    ; 0088D8A2: dc.w $DECE
        dc.w    $0088                    ; 0088D8A4: dc.w $0088
        dc.w    $DFEC                    ; 0088D8A6: dc.w $DFEC
        dc.w    $0088                    ; 0088D8A8: dc.w $0088
        dc.w    $E00C                    ; 0088D8AA: dc.w $E00C
        dc.w    $11FC                    ; 0088D8AC: dc.w $11FC
        dc.w    $0081                    ; 0088D8AE: dc.w $0081
        dc.w    $C8A5                    ; 0088D8B0: dc.w $C8A5
        dc.w    $5878                    ; 0088D8B2: dc.w $5878
        dc.w    $C87E                    ; 0088D8B4: dc.w $C87E
        dc.w    $4E75                    ; 0088D8B6: RTS
        dc.w    $4EBA                    ; 0088D8B8: dc.w $4EBA
        dc.w    $DDCA                    ; 0088D8BA: dc.w $DDCA
        dc.w    $0838                    ; 0088D8BC: dc.w $0838
        dc.w    $0006                    ; 0088D8BE: dc.w $0006
        dc.w    $C80E                    ; 0088D8C0: dc.w $C80E
        dc.w    $6606                    ; 0088D8C2: BNE.S $0088D8CA
        dc.w    $5878                    ; 0088D8C4: dc.w $5878
        dc.w    $C87E                    ; 0088D8C6: dc.w $C87E
        dc.w    $4E71                    ; 0088D8C8: NOP
        dc.w    $4E75                    ; 0088D8CA: RTS
        dc.w    $41F9, $00FF, $6E00    ; 0088D8CC: LEA $00FF6E00,A0
        dc.w    $43F9, $0088, $DAA8    ; 0088D8D2: LEA $0088DAA8,A1
        dc.w    $4240                    ; 0088D8D8: dc.w $4240
        dc.w    $1038                    ; 0088D8DA: dc.w $1038
        dc.w    $A019                    ; 0088D8DC: dc.w $A019
        dc.w    $4A38                    ; 0088D8DE: dc.w $4A38
        dc.w    $A027                    ; 0088D8E0: dc.w $A027
        dc.w    $6700, $0006            ; 0088D8E2: BEQ.W $0088D8EA
        dc.w    $1038                    ; 0088D8E6: dc.w $1038
        dc.w    $A025                    ; 0088D8E8: dc.w $A025
        dc.w    $D040                    ; 0088D8EA: dc.w $D040
        dc.w    $D040                    ; 0088D8EC: dc.w $D040
        dc.w    $2271                    ; 0088D8EE: dc.w $2271
        dc.w    $0000                    ; 0088D8F0: dc.w $0000
        dc.w    $303C                    ; 0088D8F2: dc.w $303C
        dc.w    $007F                    ; 0088D8F4: dc.w $007F
        dc.w    $30D9                    ; 0088D8F6: dc.w $30D9
        dc.w    $51C8, $FFFC            ; 0088D8F8: DBRA D0,$0088D8F6
        dc.w    $43F9, $00FF, $6100    ; 0088D8FC: LEA $00FF6100,A1
        dc.w    $337C                    ; 0088D902: dc.w $337C
        dc.w    $0001                    ; 0088D904: dc.w $0001
        dc.w    $0000                    ; 0088D906: dc.w $0000
        dc.w    $3378                    ; 0088D908: dc.w $3378
        dc.w    $A01A                    ; 0088D90A: dc.w $A01A
        dc.w    $0002                    ; 0088D90C: dc.w $0002
        dc.w    $3378                    ; 0088D90E: dc.w $3378
        dc.w    $A01C                    ; 0088D910: dc.w $A01C
        dc.w    $0004                    ; 0088D912: dc.w $0004
        dc.w    $3378                    ; 0088D914: dc.w $3378
        dc.w    $A01E                    ; 0088D916: dc.w $A01E
        dc.w    $0006                    ; 0088D918: dc.w $0006
        dc.w    $2038                    ; 0088D91A: dc.w $2038
        dc.w    $A014                    ; 0088D91C: dc.w $A014
        dc.w    $3340                    ; 0088D91E: dc.w $3340
        dc.w    $000A                    ; 0088D920: dc.w $000A
        dc.w    $3378                    ; 0088D922: dc.w $3378
        dc.w    $A020                    ; 0088D924: dc.w $A020
        dc.w    $0008                    ; 0088D926: dc.w $0008
        dc.w    $3378                    ; 0088D928: dc.w $3378
        dc.w    $A022                    ; 0088D92A: dc.w $A022
        dc.w    $000C                    ; 0088D92C: dc.w $000C
        dc.w    $337C                    ; 0088D92E: dc.w $337C
        dc.w    $0000                    ; 0088D930: dc.w $0000
        dc.w    $000E                    ; 0088D932: dc.w $000E
        dc.w    $41F9, $0088, $DA90    ; 0088D934: LEA $0088DA90,A0
        dc.w    $4241                    ; 0088D93A: dc.w $4241
        dc.w    $1238                    ; 0088D93C: dc.w $1238
        dc.w    $A019                    ; 0088D93E: dc.w $A019
        dc.w    $4A38                    ; 0088D940: dc.w $4A38
        dc.w    $A027                    ; 0088D942: dc.w $A027
        dc.w    $6704                    ; 0088D944: BEQ.S $0088D94A
        dc.w    $1238                    ; 0088D946: dc.w $1238
        dc.w    $A025                    ; 0088D948: dc.w $A025
        dc.w    $D241                    ; 0088D94A: dc.w $D241
        dc.w    $D241                    ; 0088D94C: dc.w $D241
        dc.w    $2370                    ; 0088D94E: dc.w $2370
        dc.w    $1000                    ; 0088D950: dc.w $1000
        dc.w    $0010                    ; 0088D952: dc.w $0010
        dc.w    $33FC                    ; 0088D954: dc.w $33FC
        dc.w    $0044                    ; 0088D956: dc.w $0044
        dc.w    $00A1                    ; 0088D958: dc.w $00A1
        dc.w    $5110                    ; 0088D95A: dc.w $5110
        dc.w    $13FC                    ; 0088D95C: dc.w $13FC
        dc.w    $0004                    ; 0088D95E: dc.w $0004
        dc.w    $00A1                    ; 0088D960: dc.w $00A1
        dc.w    $5107                    ; 0088D962: dc.w $5107
        dc.w    $4239                    ; 0088D964: dc.w $4239
        dc.w    $00A1                    ; 0088D966: dc.w $00A1
        dc.w    $5123                    ; 0088D968: dc.w $5123
        dc.w    $13FC                    ; 0088D96A: dc.w $13FC
        dc.w    $002B                    ; 0088D96C: dc.w $002B
        dc.w    $00A1                    ; 0088D96E: dc.w $00A1
        dc.w    $5121                    ; 0088D970: dc.w $5121
        dc.w    $13FC                    ; 0088D972: dc.w $13FC
        dc.w    $0001                    ; 0088D974: dc.w $0001
        dc.w    $00A1                    ; 0088D976: dc.w $00A1
        dc.w    $5120                    ; 0088D978: dc.w $5120
        dc.w    $0839                    ; 0088D97A: dc.w $0839
        dc.w    $0001                    ; 0088D97C: dc.w $0001
        dc.w    $00A1                    ; 0088D97E: dc.w $00A1
        dc.w    $5123                    ; 0088D980: dc.w $5123
        dc.w    $67F6                    ; 0088D982: BEQ.S $0088D97A
        dc.w    $08B9                    ; 0088D984: dc.w $08B9
        dc.w    $0001                    ; 0088D986: dc.w $0001
        dc.w    $00A1                    ; 0088D988: dc.w $00A1
        dc.w    $5123                    ; 0088D98A: dc.w $5123
        dc.w    $43F9, $00FF, $60C8    ; 0088D98C: LEA $00FF60C8,A1
        dc.w    $45F9, $00A1, $5112    ; 0088D992: LEA $00A15112,A2
        dc.w    $3E3C                    ; 0088D998: dc.w $3E3C
        dc.w    $0043                    ; 0088D99A: dc.w $0043
        dc.w    $0839                    ; 0088D99C: dc.w $0839
        dc.w    $0007                    ; 0088D99E: dc.w $0007
        dc.w    $00A1                    ; 0088D9A0: dc.w $00A1
        dc.w    $5107                    ; 0088D9A2: dc.w $5107
        dc.w    $66F6                    ; 0088D9A4: BNE.S $0088D99C
        dc.w    $3499                    ; 0088D9A6: dc.w $3499
        dc.w    $51CF, $FFF2            ; 0088D9A8: DBRA D7,$0088D99C
        dc.w    $2038                    ; 0088D9AC: dc.w $2038
        dc.w    $A014                    ; 0088D9AE: dc.w $A014
        dc.w    $0680                    ; 0088D9B0: dc.w $0680
        dc.w    $0000                    ; 0088D9B2: dc.w $0000
        dc.w    $0080                    ; 0088D9B4: dc.w $0080
        dc.w    $0280                    ; 0088D9B6: dc.w $0280
        dc.w    $0000                    ; 0088D9B8: dc.w $0000
        dc.w    $FFFF                    ; 0088D9BA: dc.w $FFFF
        dc.w    $21C0                    ; 0088D9BC: dc.w $21C0
        dc.w    $A014                    ; 0088D9BE: dc.w $A014
        dc.w    $4EB9, $0088, $179E    ; 0088D9C0: JSR $0088179E
        dc.w    $4A78                    ; 0088D9C6: dc.w $4A78
        dc.w    $A02C                    ; 0088D9C8: dc.w $A02C
        dc.w    $6600, $00B6            ; 0088D9CA: BNE.W $0088DA82
        dc.w    $4240                    ; 0088D9CE: dc.w $4240
        dc.w    $1038                    ; 0088D9D0: dc.w $1038
        dc.w    $A027                    ; 0088D9D2: dc.w $A027
        dc.w    $6100, $0B56            ; 0088D9D4: BSR.W $0088E52C
        dc.w    $1038                    ; 0088D9D8: dc.w $1038
        dc.w    $A019                    ; 0088D9DA: dc.w $A019
        dc.w    $3238                    ; 0088D9DC: dc.w $3238
        dc.w    $C86C                    ; 0088D9DE: dc.w $C86C
        dc.w    $0801                    ; 0088D9E0: dc.w $0801
        dc.w    $0003                    ; 0088D9E2: dc.w $0003
        dc.w    $6724                    ; 0088D9E4: BEQ.S $0088DA0A
        dc.w    $11FC                    ; 0088D9E6: dc.w $11FC
        dc.w    $00A9                    ; 0088D9E8: dc.w $00A9
        dc.w    $C8A4                    ; 0088D9EA: dc.w $C8A4
        dc.w    $4A38                    ; 0088D9EC: dc.w $4A38
        dc.w    $A027                    ; 0088D9EE: dc.w $A027
        dc.w    $6600, $000A            ; 0088D9F0: BNE.W $0088D9FC
        dc.w    $0C00                    ; 0088D9F4: dc.w $0C00
        dc.w    $0004                    ; 0088D9F6: dc.w $0004
        dc.w    $6C0C                    ; 0088D9F8: BGE.S $0088DA06
        dc.w    $6006                    ; 0088D9FA: BRA.S $0088DA02
        dc.w    $0C00                    ; 0088D9FC: dc.w $0C00
        dc.w    $0003                    ; 0088D9FE: dc.w $0003
        dc.w    $6C04                    ; 0088DA00: BGE.S $0088DA06
        dc.w    $5200                    ; 0088DA02: dc.w $5200
        dc.w    $6078                    ; 0088DA04: BRA.S $0088DA7E
        dc.w    $4200                    ; 0088DA06: dc.w $4200
        dc.w    $6074                    ; 0088DA08: BRA.S $0088DA7E
        dc.w    $0801                    ; 0088DA0A: dc.w $0801
        dc.w    $0002                    ; 0088DA0C: dc.w $0002
        dc.w    $6722                    ; 0088DA0E: BEQ.S $0088DA32
        dc.w    $11FC                    ; 0088DA10: dc.w $11FC
        dc.w    $00A9                    ; 0088DA12: dc.w $00A9
        dc.w    $C8A4                    ; 0088DA14: dc.w $C8A4
        dc.w    $4A00                    ; 0088DA16: dc.w $4A00
        dc.w    $6F04                    ; 0088DA18: BLE.S $0088DA1E
        dc.w    $5300                    ; 0088DA1A: dc.w $5300
        dc.w    $6060                    ; 0088DA1C: BRA.S $0088DA7E
        dc.w    $4A38                    ; 0088DA1E: dc.w $4A38
        dc.w    $A027                    ; 0088DA20: dc.w $A027
        dc.w    $6600, $0008            ; 0088DA22: BNE.W $0088DA2C
        dc.w    $103C                    ; 0088DA26: dc.w $103C
        dc.w    $0004                    ; 0088DA28: dc.w $0004
        dc.w    $6052                    ; 0088DA2A: BRA.S $0088DA7E
        dc.w    $103C                    ; 0088DA2C: dc.w $103C
        dc.w    $0003                    ; 0088DA2E: dc.w $0003
        dc.w    $604C                    ; 0088DA30: BRA.S $0088DA7E
        dc.w    $4A38                    ; 0088DA32: dc.w $4A38
        dc.w    $A024                    ; 0088DA34: dc.w $A024
        dc.w    $6746                    ; 0088DA36: BEQ.S $0088DA7E
        dc.w    $0801                    ; 0088DA38: dc.w $0801
        dc.w    $0000                    ; 0088DA3A: dc.w $0000
        dc.w    $6700, $001C            ; 0088DA3C: BEQ.W $0088DA5A
        dc.w    $4A38                    ; 0088DA40: dc.w $4A38
        dc.w    $A027                    ; 0088DA42: dc.w $A027
        dc.w    $6738                    ; 0088DA44: BEQ.S $0088DA7E
        dc.w    $11FC                    ; 0088DA46: dc.w $11FC
        dc.w    $00A9                    ; 0088DA48: dc.w $00A9
        dc.w    $C8A4                    ; 0088DA4A: dc.w $C8A4
        dc.w    $4238                    ; 0088DA4C: dc.w $4238
        dc.w    $A027                    ; 0088DA4E: dc.w $A027
        dc.w    $11C0                    ; 0088DA50: dc.w $11C0
        dc.w    $A026                    ; 0088DA52: dc.w $A026
        dc.w    $1038                    ; 0088DA54: dc.w $1038
        dc.w    $A025                    ; 0088DA56: dc.w $A025
        dc.w    $6024                    ; 0088DA58: BRA.S $0088DA7E
        dc.w    $0801                    ; 0088DA5A: dc.w $0801
        dc.w    $0001                    ; 0088DA5C: dc.w $0001
        dc.w    $6700, $001E            ; 0088DA5E: BEQ.W $0088DA7E
        dc.w    $0C38                    ; 0088DA62: dc.w $0C38
        dc.w    $0001                    ; 0088DA64: dc.w $0001
        dc.w    $A027                    ; 0088DA66: dc.w $A027
        dc.w    $6C14                    ; 0088DA68: BGE.S $0088DA7E
        dc.w    $11FC                    ; 0088DA6A: dc.w $11FC
        dc.w    $00A9                    ; 0088DA6C: dc.w $00A9
        dc.w    $C8A4                    ; 0088DA6E: dc.w $C8A4
        dc.w    $11FC                    ; 0088DA70: dc.w $11FC
        dc.w    $0001                    ; 0088DA72: dc.w $0001
        dc.w    $A027                    ; 0088DA74: dc.w $A027
        dc.w    $11C0                    ; 0088DA76: dc.w $11C0
        dc.w    $A025                    ; 0088DA78: dc.w $A025
        dc.w    $1038                    ; 0088DA7A: dc.w $1038
        dc.w    $A026                    ; 0088DA7C: dc.w $A026
        dc.w    $11C0                    ; 0088DA7E: dc.w $11C0
        dc.w    $A019                    ; 0088DA80: dc.w $A019
        dc.w    $5878                    ; 0088DA82: dc.w $5878
        dc.w    $C87E                    ; 0088DA84: dc.w $C87E
        dc.w    $33FC                    ; 0088DA86: dc.w $33FC
        dc.w    $0020                    ; 0088DA88: dc.w $0020
        dc.w    $00FF                    ; 0088DA8A: dc.w $00FF
        dc.w    $0008                    ; 0088DA8C: dc.w $0008
        dc.w    $4E75                    ; 0088DA8E: RTS
        dc.w    $2229                    ; 0088DA90: dc.w $2229
        dc.w    $6AE2                    ; 0088DA92: BPL.S $0088DA76
        dc.w    $2229                    ; 0088DA94: dc.w $2229
        dc.w    $840C                    ; 0088DA96: dc.w $840C
        dc.w    $2229                    ; 0088DA98: dc.w $2229
        dc.w    $A2EE                    ; 0088DA9A: dc.w $A2EE
        dc.w    $2229                    ; 0088DA9C: dc.w $2229
        dc.w    $B9F8                    ; 0088DA9E: dc.w $B9F8
        dc.w    $2229                    ; 0088DAA0: dc.w $2229
        dc.w    $D32C                    ; 0088DAA2: dc.w $D32C
        dc.w    $2229                    ; 0088DAA4: dc.w $2229
        dc.w    $6AE2                    ; 0088DAA6: BPL.S $0088DA8A
        dc.w    $008B                    ; 0088DAA8: dc.w $008B
        dc.w    $B65C                    ; 0088DAAA: dc.w $B65C
        dc.w    $008B                    ; 0088DAAC: dc.w $008B
        dc.w    $B75C                    ; 0088DAAE: dc.w $B75C
        dc.w    $008B                    ; 0088DAB0: dc.w $008B
        dc.w    $B85C                    ; 0088DAB2: dc.w $B85C
        dc.w    $008B                    ; 0088DAB4: dc.w $008B
        dc.w    $B95C                    ; 0088DAB6: dc.w $B95C
        dc.w    $008B                    ; 0088DAB8: dc.w $008B
        dc.w    $BA5C                    ; 0088DABA: dc.w $BA5C
        dc.w    $008B                    ; 0088DABC: dc.w $008B
        dc.w    $B65C                    ; 0088DABE: dc.w $B65C
        dc.w    $4240                    ; 0088DAC0: dc.w $4240
        dc.w    $1038                    ; 0088DAC2: dc.w $1038
        dc.w    $A027                    ; 0088DAC4: dc.w $A027
        dc.w    $4EBA                    ; 0088DAC6: dc.w $4EBA
        dc.w    $0A64                    ; 0088DAC8: dc.w $0A64
        dc.w    $207C, $0603, $D100    ; 0088DACA: MOVEA.L #$0603D100,A0
        dc.w    $227C, $2400, $4C58    ; 0088DAD0: MOVEA.L #$24004C58,A1
        dc.w    $303C                    ; 0088DAD6: dc.w $303C
        dc.w    $0090                    ; 0088DAD8: dc.w $0090
        dc.w    $323C                    ; 0088DADA: dc.w $323C
        dc.w    $0010                    ; 0088DADC: dc.w $0010
        dc.w    $6100, $087A            ; 0088DADE: BSR.W $0088E35A
        dc.w    $4240                    ; 0088DAE2: dc.w $4240
        dc.w    $1038                    ; 0088DAE4: dc.w $1038
        dc.w    $A019                    ; 0088DAE6: dc.w $A019
        dc.w    $4A38                    ; 0088DAE8: dc.w $4A38
        dc.w    $A027                    ; 0088DAEA: dc.w $A027
        dc.w    $6700, $0006            ; 0088DAEC: BEQ.W $0088DAF4
        dc.w    $1038                    ; 0088DAF0: dc.w $1038
        dc.w    $A025                    ; 0088DAF2: dc.w $A025
        dc.w    $D040                    ; 0088DAF4: dc.w $D040
        dc.w    $3200                    ; 0088DAF6: dc.w $3200
        dc.w    $D040                    ; 0088DAF8: dc.w $D040
        dc.w    $D040                    ; 0088DAFA: dc.w $D040
        dc.w    $D041                    ; 0088DAFC: dc.w $D041
        dc.w    $41F9, $00FF, $2000    ; 0088DAFE: LEA $00FF2000,A0
        dc.w    $31F0                    ; 0088DB04: dc.w $31F0
        dc.w    $0000                    ; 0088DB06: dc.w $0000
        dc.w    $A01A                    ; 0088DB08: dc.w $A01A
        dc.w    $31F0                    ; 0088DB0A: dc.w $31F0
        dc.w    $0002                    ; 0088DB0C: dc.w $0002
        dc.w    $A01C                    ; 0088DB0E: dc.w $A01C
        dc.w    $31F0                    ; 0088DB10: dc.w $31F0
        dc.w    $0004                    ; 0088DB12: dc.w $0004
        dc.w    $A01E                    ; 0088DB14: dc.w $A01E
        dc.w    $31F0                    ; 0088DB16: dc.w $31F0
        dc.w    $0006                    ; 0088DB18: dc.w $0006
        dc.w    $A020                    ; 0088DB1A: dc.w $A020
        dc.w    $31F0                    ; 0088DB1C: dc.w $31F0
        dc.w    $0008                    ; 0088DB1E: dc.w $0008
        dc.w    $A022                    ; 0088DB20: dc.w $A022
        dc.w    $3238                    ; 0088DB22: dc.w $3238
        dc.w    $C86E                    ; 0088DB24: dc.w $C86E
        dc.w    $E089                    ; 0088DB26: dc.w $E089
        dc.w    $0801                    ; 0088DB28: dc.w $0801
        dc.w    $0007                    ; 0088DB2A: dc.w $0007
        dc.w    $6700, $0130            ; 0088DB2C: BEQ.W $0088DC5E
        dc.w    $0801                    ; 0088DB30: dc.w $0801
        dc.w    $0005                    ; 0088DB32: dc.w $0005
        dc.w    $6600, $00CE            ; 0088DB34: BNE.W $0088DC04
        dc.w    $0801                    ; 0088DB38: dc.w $0801
        dc.w    $0000                    ; 0088DB3A: dc.w $0000
        dc.w    $671C                    ; 0088DB3C: BEQ.S $0088DB5A
        dc.w    $3038                    ; 0088DB3E: dc.w $3038
        dc.w    $A01C                    ; 0088DB40: dc.w $A01C
        dc.w    $6100, $0168            ; 0088DB42: BSR.W $0088DCAC
        dc.w    $0C40                    ; 0088DB46: dc.w $0C40
        dc.w    $02F0                    ; 0088DB48: dc.w $02F0
        dc.w    $6D00, $0006            ; 0088DB4A: BLT.W $0088DB52
        dc.w    $303C                    ; 0088DB4E: dc.w $303C
        dc.w    $02F0                    ; 0088DB50: dc.w $02F0
        dc.w    $31C0                    ; 0088DB52: dc.w $31C0
        dc.w    $A01C                    ; 0088DB54: dc.w $A01C
        dc.w    $6000, $0106            ; 0088DB56: BRA.W $0088DC5E
        dc.w    $0801                    ; 0088DB5A: dc.w $0801
        dc.w    $0001                    ; 0088DB5C: dc.w $0001
        dc.w    $671C                    ; 0088DB5E: BEQ.S $0088DB7C
        dc.w    $3038                    ; 0088DB60: dc.w $3038
        dc.w    $A01C                    ; 0088DB62: dc.w $A01C
        dc.w    $6100, $0158            ; 0088DB64: BSR.W $0088DCBE
        dc.w    $0C40                    ; 0088DB68: dc.w $0C40
        dc.w    $FBFE                    ; 0088DB6A: dc.w $FBFE
        dc.w    $6E00, $0006            ; 0088DB6C: BGT.W $0088DB74
        dc.w    $303C                    ; 0088DB70: dc.w $303C
        dc.w    $FBFE                    ; 0088DB72: dc.w $FBFE
        dc.w    $31C0                    ; 0088DB74: dc.w $31C0
        dc.w    $A01C                    ; 0088DB76: dc.w $A01C
        dc.w    $6000, $00E4            ; 0088DB78: BRA.W $0088DC5E
        dc.w    $0801                    ; 0088DB7C: dc.w $0801
        dc.w    $0003                    ; 0088DB7E: dc.w $0003
        dc.w    $671C                    ; 0088DB80: BEQ.S $0088DB9E
        dc.w    $3038                    ; 0088DB82: dc.w $3038
        dc.w    $A01A                    ; 0088DB84: dc.w $A01A
        dc.w    $6100, $0124            ; 0088DB86: BSR.W $0088DCAC
        dc.w    $0C40                    ; 0088DB8A: dc.w $0C40
        dc.w    $0120                    ; 0088DB8C: dc.w $0120
        dc.w    $6D00, $0006            ; 0088DB8E: BLT.W $0088DB96
        dc.w    $303C                    ; 0088DB92: dc.w $303C
        dc.w    $0120                    ; 0088DB94: dc.w $0120
        dc.w    $31C0                    ; 0088DB96: dc.w $31C0
        dc.w    $A01A                    ; 0088DB98: dc.w $A01A
        dc.w    $6000, $00C2            ; 0088DB9A: BRA.W $0088DC5E
        dc.w    $0801                    ; 0088DB9E: dc.w $0801
        dc.w    $0002                    ; 0088DBA0: dc.w $0002
        dc.w    $671C                    ; 0088DBA2: BEQ.S $0088DBC0
        dc.w    $3038                    ; 0088DBA4: dc.w $3038
        dc.w    $A01A                    ; 0088DBA6: dc.w $A01A
        dc.w    $6100, $0114            ; 0088DBA8: BSR.W $0088DCBE
        dc.w    $0C40                    ; 0088DBAC: dc.w $0C40
        dc.w    $FEE0                    ; 0088DBAE: dc.w $FEE0
        dc.w    $6E00, $0006            ; 0088DBB0: BGT.W $0088DBB8
        dc.w    $303C                    ; 0088DBB4: dc.w $303C
        dc.w    $FEE0                    ; 0088DBB6: dc.w $FEE0
        dc.w    $31C0                    ; 0088DBB8: dc.w $31C0
        dc.w    $A01A                    ; 0088DBBA: dc.w $A01A
        dc.w    $6000, $00A0            ; 0088DBBC: BRA.W $0088DC5E
        dc.w    $0801                    ; 0088DBC0: dc.w $0801
        dc.w    $0006                    ; 0088DBC2: dc.w $0006
        dc.w    $671C                    ; 0088DBC4: BEQ.S $0088DBE2
        dc.w    $3038                    ; 0088DBC6: dc.w $3038
        dc.w    $A01E                    ; 0088DBC8: dc.w $A01E
        dc.w    $6100, $00E0            ; 0088DBCA: BSR.W $0088DCAC
        dc.w    $0C40                    ; 0088DBCE: dc.w $0C40
        dc.w    $0460                    ; 0088DBD0: dc.w $0460
        dc.w    $6D00, $0006            ; 0088DBD2: BLT.W $0088DBDA
        dc.w    $303C                    ; 0088DBD6: dc.w $303C
        dc.w    $0460                    ; 0088DBD8: dc.w $0460
        dc.w    $31C0                    ; 0088DBDA: dc.w $31C0
        dc.w    $A01E                    ; 0088DBDC: dc.w $A01E
        dc.w    $6000, $007E            ; 0088DBDE: BRA.W $0088DC5E
        dc.w    $0801                    ; 0088DBE2: dc.w $0801
        dc.w    $0004                    ; 0088DBE4: dc.w $0004
        dc.w    $6776                    ; 0088DBE6: BEQ.S $0088DC5E
        dc.w    $3038                    ; 0088DBE8: dc.w $3038
        dc.w    $A01E                    ; 0088DBEA: dc.w $A01E
        dc.w    $6100, $00D0            ; 0088DBEC: BSR.W $0088DCBE
        dc.w    $0C40                    ; 0088DBF0: dc.w $0C40
        dc.w    $0050                    ; 0088DBF2: dc.w $0050
        dc.w    $6E00, $0006            ; 0088DBF4: BGT.W $0088DBFC
        dc.w    $303C                    ; 0088DBF8: dc.w $303C
        dc.w    $0050                    ; 0088DBFA: dc.w $0050
        dc.w    $31C0                    ; 0088DBFC: dc.w $31C0
        dc.w    $A01E                    ; 0088DBFE: dc.w $A01E
        dc.w    $6000, $005C            ; 0088DC00: BRA.W $0088DC5E
        dc.w    $0801                    ; 0088DC04: dc.w $0801
        dc.w    $0000                    ; 0088DC06: dc.w $0000
        dc.w    $6710                    ; 0088DC08: BEQ.S $0088DC1A
        dc.w    $3038                    ; 0088DC0A: dc.w $3038
        dc.w    $A020                    ; 0088DC0C: dc.w $A020
        dc.w    $6100, $00A8            ; 0088DC0E: BSR.W $0088DCB8
        dc.w    $31C0                    ; 0088DC12: dc.w $31C0
        dc.w    $A020                    ; 0088DC14: dc.w $A020
        dc.w    $6000, $0046            ; 0088DC16: BRA.W $0088DC5E
        dc.w    $0801                    ; 0088DC1A: dc.w $0801
        dc.w    $0001                    ; 0088DC1C: dc.w $0001
        dc.w    $6710                    ; 0088DC1E: BEQ.S $0088DC30
        dc.w    $3038                    ; 0088DC20: dc.w $3038
        dc.w    $A020                    ; 0088DC22: dc.w $A020
        dc.w    $6100, $00A4            ; 0088DC24: BSR.W $0088DCCA
        dc.w    $31C0                    ; 0088DC28: dc.w $31C0
        dc.w    $A020                    ; 0088DC2A: dc.w $A020
        dc.w    $6000, $0030            ; 0088DC2C: BRA.W $0088DC5E
        dc.w    $0801                    ; 0088DC30: dc.w $0801
        dc.w    $0003                    ; 0088DC32: dc.w $0003
        dc.w    $6710                    ; 0088DC34: BEQ.S $0088DC46
        dc.w    $3038                    ; 0088DC36: dc.w $3038
        dc.w    $A022                    ; 0088DC38: dc.w $A022
        dc.w    $6100, $007C            ; 0088DC3A: BSR.W $0088DCB8
        dc.w    $31C0                    ; 0088DC3E: dc.w $31C0
        dc.w    $A022                    ; 0088DC40: dc.w $A022
        dc.w    $6000, $001A            ; 0088DC42: BRA.W $0088DC5E
        dc.w    $0801                    ; 0088DC46: dc.w $0801
        dc.w    $0002                    ; 0088DC48: dc.w $0002
        dc.w    $6712                    ; 0088DC4A: BEQ.S $0088DC5E
        dc.w    $3038                    ; 0088DC4C: dc.w $3038
        dc.w    $A022                    ; 0088DC4E: dc.w $A022
        dc.w    $6100, $0078            ; 0088DC50: BSR.W $0088DCCA
        dc.w    $31C0                    ; 0088DC54: dc.w $31C0
        dc.w    $A022                    ; 0088DC56: dc.w $A022
        dc.w    $6000, $0004            ; 0088DC58: BRA.W $0088DC5E
        dc.w    $4E71                    ; 0088DC5C: NOP
        dc.w    $4240                    ; 0088DC5E: dc.w $4240
        dc.w    $1038                    ; 0088DC60: dc.w $1038
        dc.w    $A019                    ; 0088DC62: dc.w $A019
        dc.w    $4A38                    ; 0088DC64: dc.w $4A38
        dc.w    $A027                    ; 0088DC66: dc.w $A027
        dc.w    $6700, $0006            ; 0088DC68: BEQ.W $0088DC70
        dc.w    $1038                    ; 0088DC6C: dc.w $1038
        dc.w    $A025                    ; 0088DC6E: dc.w $A025
        dc.w    $D040                    ; 0088DC70: dc.w $D040
        dc.w    $3200                    ; 0088DC72: dc.w $3200
        dc.w    $D040                    ; 0088DC74: dc.w $D040
        dc.w    $D040                    ; 0088DC76: dc.w $D040
        dc.w    $D041                    ; 0088DC78: dc.w $D041
        dc.w    $41F9, $00FF, $2000    ; 0088DC7A: LEA $00FF2000,A0
        dc.w    $31B8                    ; 0088DC80: dc.w $31B8
        dc.w    $A01A                    ; 0088DC82: dc.w $A01A
        dc.w    $0000                    ; 0088DC84: dc.w $0000
        dc.w    $31B8                    ; 0088DC86: dc.w $31B8
        dc.w    $A01C                    ; 0088DC88: dc.w $A01C
        dc.w    $0002                    ; 0088DC8A: dc.w $0002
        dc.w    $31B8                    ; 0088DC8C: dc.w $31B8
        dc.w    $A01E                    ; 0088DC8E: dc.w $A01E
        dc.w    $0004                    ; 0088DC90: dc.w $0004
        dc.w    $31B8                    ; 0088DC92: dc.w $31B8
        dc.w    $A020                    ; 0088DC94: dc.w $A020
        dc.w    $0006                    ; 0088DC96: dc.w $0006
        dc.w    $31B8                    ; 0088DC98: dc.w $31B8
        dc.w    $A022                    ; 0088DC9A: dc.w $A022
        dc.w    $0008                    ; 0088DC9C: dc.w $0008
        dc.w    $33FC                    ; 0088DC9E: dc.w $33FC
        dc.w    $0020                    ; 0088DCA0: dc.w $0020
        dc.w    $00FF                    ; 0088DCA2: dc.w $00FF
        dc.w    $0008                    ; 0088DCA4: dc.w $0008
        dc.w    $5878                    ; 0088DCA6: dc.w $5878
        dc.w    $C87E                    ; 0088DCA8: dc.w $C87E
        dc.w    $4E75                    ; 0088DCAA: RTS
        dc.w    $0C40                    ; 0088DCAC: dc.w $0C40
        dc.w    $4000                    ; 0088DCAE: dc.w $4000
        dc.w    $6E0A                    ; 0088DCB0: BGT.S $0088DCBC
        dc.w    $0640                    ; 0088DCB2: dc.w $0640
        dc.w    $0010                    ; 0088DCB4: dc.w $0010
        dc.w    $6004                    ; 0088DCB6: BRA.S $0088DCBC
        dc.w    $0640                    ; 0088DCB8: dc.w $0640
        dc.w    $0040                    ; 0088DCBA: dc.w $0040
        dc.w    $4E75                    ; 0088DCBC: RTS
        dc.w    $0C40                    ; 0088DCBE: dc.w $0C40
        dc.w    $C000                    ; 0088DCC0: dc.w $C000
        dc.w    $6D0A                    ; 0088DCC2: BLT.S $0088DCCE
        dc.w    $0440                    ; 0088DCC4: dc.w $0440
        dc.w    $0010                    ; 0088DCC6: dc.w $0010
        dc.w    $6004                    ; 0088DCC8: BRA.S $0088DCCE
        dc.w    $0440                    ; 0088DCCA: dc.w $0440
        dc.w    $0040                    ; 0088DCCC: dc.w $0040
        dc.w    $4E75                    ; 0088DCCE: RTS
        dc.w    $4240                    ; 0088DCD0: dc.w $4240
        dc.w    $4EBA                    ; 0088DCD2: dc.w $4EBA
        dc.w    $0858                    ; 0088DCD4: dc.w $0858
        dc.w    $4EBA                    ; 0088DCD6: dc.w $4EBA
        dc.w    $D9AC                    ; 0088DCD8: dc.w $D9AC
        dc.w    $4EBA                    ; 0088DCDA: dc.w $4EBA
        dc.w    $D9FE                    ; 0088DCDC: dc.w $D9FE
        dc.w    $4A39                    ; 0088DCDE: dc.w $4A39
        dc.w    $00A1                    ; 0088DCE0: dc.w $00A1
        dc.w    $5120                    ; 0088DCE2: dc.w $5120
        dc.w    $66F8                    ; 0088DCE4: BNE.S $0088DCDE
        dc.w    $207C, $0603, $7000    ; 0088DCE6: MOVEA.L #$06037000,A0
        dc.w    $227C, $2401, $8010    ; 0088DCEC: MOVEA.L #$24018010,A1
        dc.w    $303C                    ; 0088DCF2: dc.w $303C
        dc.w    $0120                    ; 0088DCF4: dc.w $0120
        dc.w    $323C                    ; 0088DCF6: dc.w $323C
        dc.w    $0030                    ; 0088DCF8: dc.w $0030
        dc.w    $6100, $065E            ; 0088DCFA: BSR.W $0088E35A
        dc.w    $0838                    ; 0088DCFE: dc.w $0838
        dc.w    $0007                    ; 0088DD00: dc.w $0007
        dc.w    $FDA8                    ; 0088DD02: dc.w $FDA8
        dc.w    $6600, $0036            ; 0088DD04: BNE.W $0088DD3C
        dc.w    $207C, $0603, $A600    ; 0088DD08: MOVEA.L #$0603A600,A0
        dc.w    $7600                    ; 0088DD0E: MOVEQ #$00,D3
        dc.w    $383C                    ; 0088DD10: dc.w $383C
        dc.w    $0004                    ; 0088DD12: dc.w $0004
        dc.w    $0738                    ; 0088DD14: dc.w $0738
        dc.w    $EF07                    ; 0088DD16: dc.w $EF07
        dc.w    $671C                    ; 0088DD18: BEQ.S $0088DD36
        dc.w    $43F9, $0088, $DEB6    ; 0088DD1A: LEA $0088DEB6,A1
        dc.w    $3003                    ; 0088DD20: dc.w $3003
        dc.w    $D040                    ; 0088DD22: dc.w $D040
        dc.w    $D040                    ; 0088DD24: dc.w $D040
        dc.w    $2271                    ; 0088DD26: dc.w $2271
        dc.w    $0000                    ; 0088DD28: dc.w $0000
        dc.w    $303C                    ; 0088DD2A: dc.w $303C
        dc.w    $0010                    ; 0088DD2C: dc.w $0010
        dc.w    $323C                    ; 0088DD2E: dc.w $323C
        dc.w    $0010                    ; 0088DD30: dc.w $0010
        dc.w    $6100, $0626            ; 0088DD32: BSR.W $0088E35A
        dc.w    $5243                    ; 0088DD36: dc.w $5243
        dc.w    $51CC, $FFDA            ; 0088DD38: DBRA D4,$0088DD14
        dc.w    $207C, $0603, $B600    ; 0088DD3C: MOVEA.L #$0603B600,A0
        dc.w    $227C, $2401, $4010    ; 0088DD42: MOVEA.L #$24014010,A1
        dc.w    $303C                    ; 0088DD48: dc.w $303C
        dc.w    $0120                    ; 0088DD4A: dc.w $0120
        dc.w    $323C                    ; 0088DD4C: dc.w $323C
        dc.w    $0018                    ; 0088DD4E: dc.w $0018
        dc.w    $6100, $0608            ; 0088DD50: BSR.W $0088E35A
        dc.w    $43F9, $2403, $4850    ; 0088DD54: LEA $24034850,A1
        dc.w    $45F8                    ; 0088DD5A: dc.w $45F8
        dc.w    $EF08                    ; 0088DD5C: dc.w $EF08
        dc.w    $D5F8                    ; 0088DD5E: dc.w $D5F8
        dc.w    $A028                    ; 0088DD60: dc.w $A028
        dc.w    $7000                    ; 0088DD62: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088DD64: dc.w $1038
        dc.w    $A019                    ; 0088DD66: dc.w $A019
        dc.w    $D040                    ; 0088DD68: dc.w $D040
        dc.w    $D040                    ; 0088DD6A: dc.w $D040
        dc.w    $D040                    ; 0088DD6C: dc.w $D040
        dc.w    $D040                    ; 0088DD6E: dc.w $D040
        dc.w    $3200                    ; 0088DD70: dc.w $3200
        dc.w    $D040                    ; 0088DD72: dc.w $D040
        dc.w    $D040                    ; 0088DD74: dc.w $D040
        dc.w    $D041                    ; 0088DD76: dc.w $D041
        dc.w    $D040                    ; 0088DD78: dc.w $D040
        dc.w    $D5C0                    ; 0088DD7A: dc.w $D5C0
        dc.w    $0838                    ; 0088DD7C: dc.w $0838
        dc.w    $0007                    ; 0088DD7E: dc.w $0007
        dc.w    $FDA8                    ; 0088DD80: dc.w $FDA8
        dc.w    $6700, $0008            ; 0088DD82: BEQ.W $0088DD8C
        dc.w    $45F9, $0088, $DECA    ; 0088DD86: LEA $0088DECA,A2
        dc.w    $4EBA                    ; 0088DD8C: dc.w $4EBA
        dc.w    $06D8                    ; 0088DD8E: dc.w $06D8
        dc.w    $43F9, $2403, $48E8    ; 0088DD90: LEA $240348E8,A1
        dc.w    $45F8                    ; 0088DD96: dc.w $45F8
        dc.w    $FA48                    ; 0088DD98: dc.w $FA48
        dc.w    $7000                    ; 0088DD9A: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088DD9C: dc.w $1038
        dc.w    $FEB1                    ; 0088DD9E: dc.w $FEB1
        dc.w    $D040                    ; 0088DDA0: dc.w $D040
        dc.w    $D040                    ; 0088DDA2: dc.w $D040
        dc.w    $D040                    ; 0088DDA4: dc.w $D040
        dc.w    $3200                    ; 0088DDA6: dc.w $3200
        dc.w    $D040                    ; 0088DDA8: dc.w $D040
        dc.w    $D041                    ; 0088DDAA: dc.w $D041
        dc.w    $D040                    ; 0088DDAC: dc.w $D040
        dc.w    $D5C0                    ; 0088DDAE: dc.w $D5C0
        dc.w    $7000                    ; 0088DDB0: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088DDB2: dc.w $1038
        dc.w    $A019                    ; 0088DDB4: dc.w $A019
        dc.w    $D040                    ; 0088DDB6: dc.w $D040
        dc.w    $D040                    ; 0088DDB8: dc.w $D040
        dc.w    $D040                    ; 0088DDBA: dc.w $D040
        dc.w    $5840                    ; 0088DDBC: dc.w $5840
        dc.w    $D5C0                    ; 0088DDBE: dc.w $D5C0
        dc.w    $0838                    ; 0088DDC0: dc.w $0838
        dc.w    $0007                    ; 0088DDC2: dc.w $0007
        dc.w    $FDA8                    ; 0088DDC4: dc.w $FDA8
        dc.w    $6700, $0008            ; 0088DDC6: BEQ.W $0088DDD0
        dc.w    $45F9, $0088, $DECA    ; 0088DDCA: LEA $0088DECA,A2
        dc.w    $4EBA                    ; 0088DDD0: dc.w $4EBA
        dc.w    $0694                    ; 0088DDD2: dc.w $0694
        dc.w    $7000                    ; 0088DDD4: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088DDD6: dc.w $1038
        dc.w    $A019                    ; 0088DDD8: dc.w $A019
        dc.w    $43F9, $0088, $DE98    ; 0088DDDA: LEA $0088DE98,A1
        dc.w    $D040                    ; 0088DDE0: dc.w $D040
        dc.w    $3200                    ; 0088DDE2: dc.w $3200
        dc.w    $D040                    ; 0088DDE4: dc.w $D040
        dc.w    $D041                    ; 0088DDE6: dc.w $D041
        dc.w    $2071                    ; 0088DDE8: dc.w $2071
        dc.w    $0000                    ; 0088DDEA: dc.w $0000
        dc.w    $3031                    ; 0088DDEC: dc.w $3031
        dc.w    $0004                    ; 0088DDEE: dc.w $0004
        dc.w    $323C                    ; 0088DDF0: dc.w $323C
        dc.w    $0030                    ; 0088DDF2: dc.w $0030
        dc.w    $343C                    ; 0088DDF4: dc.w $343C
        dc.w    $0010                    ; 0088DDF6: dc.w $0010
        dc.w    $4A39                    ; 0088DDF8: dc.w $4A39
        dc.w    $00A1                    ; 0088DDFA: dc.w $00A1
        dc.w    $5120                    ; 0088DDFC: dc.w $5120
        dc.w    $66F8                    ; 0088DDFE: BNE.S $0088DDF8
        dc.w    $6100, $05B2            ; 0088DE00: BSR.W $0088E3B4
        dc.w    $33FC                    ; 0088DE04: dc.w $33FC
        dc.w    $0018                    ; 0088DE06: dc.w $0018
        dc.w    $00FF                    ; 0088DE08: dc.w $00FF
        dc.w    $0008                    ; 0088DE0A: dc.w $0008
        dc.w    $0C78                    ; 0088DE0C: dc.w $0C78
        dc.w    $0001                    ; 0088DE0E: dc.w $0001
        dc.w    $A02C                    ; 0088DE10: dc.w $A02C
        dc.w    $6700, $0054            ; 0088DE12: BEQ.W $0088DE68
        dc.w    $0C78                    ; 0088DE16: dc.w $0C78
        dc.w    $0002                    ; 0088DE18: dc.w $0002
        dc.w    $A02C                    ; 0088DE1A: dc.w $A02C
        dc.w    $6700, $005A            ; 0088DE1C: BEQ.W $0088DE78
        dc.w    $3238                    ; 0088DE20: dc.w $3238
        dc.w    $C86C                    ; 0088DE22: dc.w $C86C
        dc.w    $0201                    ; 0088DE24: dc.w $0201
        dc.w    $00E0                    ; 0088DE26: dc.w $00E0
        dc.w    $6616                    ; 0088DE28: BNE.S $0088DE40
        dc.w    $3238                    ; 0088DE2A: dc.w $3238
        dc.w    $C86C                    ; 0088DE2C: dc.w $C86C
        dc.w    $0201                    ; 0088DE2E: dc.w $0201
        dc.w    $0010                    ; 0088DE30: dc.w $0010
        dc.w    $6608                    ; 0088DE32: BNE.S $0088DE3C
        dc.w    $5178                    ; 0088DE34: dc.w $5178
        dc.w    $C87E                    ; 0088DE36: dc.w $C87E
        dc.w    $6000, $0056            ; 0088DE38: BRA.W $0088DE90
        dc.w    $50F8                    ; 0088DE3C: dc.w $50F8
        dc.w    $A018                    ; 0088DE3E: dc.w $A018
        dc.w    $11FC                    ; 0088DE40: dc.w $11FC
        dc.w    $00A8                    ; 0088DE42: dc.w $00A8
        dc.w    $C8A4                    ; 0088DE44: dc.w $C8A4
        dc.w    $11FC                    ; 0088DE46: dc.w $11FC
        dc.w    $0001                    ; 0088DE48: dc.w $0001
        dc.w    $C809                    ; 0088DE4A: dc.w $C809
        dc.w    $11FC                    ; 0088DE4C: dc.w $11FC
        dc.w    $0001                    ; 0088DE4E: dc.w $0001
        dc.w    $C80A                    ; 0088DE50: dc.w $C80A
        dc.w    $08F8                    ; 0088DE52: dc.w $08F8
        dc.w    $0007                    ; 0088DE54: dc.w $0007
        dc.w    $C80E                    ; 0088DE56: dc.w $C80E
        dc.w    $11FC                    ; 0088DE58: dc.w $11FC
        dc.w    $0001                    ; 0088DE5A: dc.w $0001
        dc.w    $C802                    ; 0088DE5C: dc.w $C802
        dc.w    $31FC                    ; 0088DE5E: dc.w $31FC
        dc.w    $0002                    ; 0088DE60: dc.w $0002
        dc.w    $A02C                    ; 0088DE62: dc.w $A02C
        dc.w    $6000, $0026            ; 0088DE64: BRA.W $0088DE8C
        dc.w    $0838                    ; 0088DE68: dc.w $0838
        dc.w    $0006                    ; 0088DE6A: dc.w $0006
        dc.w    $C80E                    ; 0088DE6C: dc.w $C80E
        dc.w    $661C                    ; 0088DE6E: BNE.S $0088DE8C
        dc.w    $4278                    ; 0088DE70: dc.w $4278
        dc.w    $A02C                    ; 0088DE72: dc.w $A02C
        dc.w    $6000, $0016            ; 0088DE74: BRA.W $0088DE8C
        dc.w    $0838                    ; 0088DE78: dc.w $0838
        dc.w    $0007                    ; 0088DE7A: dc.w $0007
        dc.w    $C80E                    ; 0088DE7C: dc.w $C80E
        dc.w    $660C                    ; 0088DE7E: BNE.S $0088DE8C
        dc.w    $4278                    ; 0088DE80: dc.w $4278
        dc.w    $A02C                    ; 0088DE82: dc.w $A02C
        dc.w    $5878                    ; 0088DE84: dc.w $5878
        dc.w    $C87E                    ; 0088DE86: dc.w $C87E
        dc.w    $6000, $0006            ; 0088DE88: BRA.W $0088DE90
        dc.w    $5178                    ; 0088DE8C: dc.w $5178
        dc.w    $C87E                    ; 0088DE8E: dc.w $C87E
        dc.w    $11FC                    ; 0088DE90: dc.w $11FC
        dc.w    $0001                    ; 0088DE92: dc.w $0001
        dc.w    $C821                    ; 0088DE94: dc.w $C821
        dc.w    $4E75                    ; 0088DE96: RTS
        dc.w    $2401                    ; 0088DE98: dc.w $2401
        dc.w    $8010                    ; 0088DE9A: dc.w $8010
        dc.w    $003A                    ; 0088DE9C: dc.w $003A
        dc.w    $2401                    ; 0088DE9E: dc.w $2401
        dc.w    $8049                    ; 0088DEA0: dc.w $8049
        dc.w    $003B                    ; 0088DEA2: dc.w $003B
        dc.w    $2401                    ; 0088DEA4: dc.w $2401
        dc.w    $8083                    ; 0088DEA6: dc.w $8083
        dc.w    $003A                    ; 0088DEA8: dc.w $003A
        dc.w    $2401                    ; 0088DEAA: dc.w $2401
        dc.w    $80BC                    ; 0088DEAC: dc.w $80BC
        dc.w    $003A                    ; 0088DEAE: dc.w $003A
        dc.w    $2401                    ; 0088DEB0: dc.w $2401
        dc.w    $80F5                    ; 0088DEB2: dc.w $80F5
        dc.w    $003B                    ; 0088DEB4: dc.w $003B
        dc.w    $2403                    ; 0088DEB6: dc.w $2403
        dc.w    $8412                    ; 0088DEB8: dc.w $8412
        dc.w    $2403                    ; 0088DEBA: dc.w $2403
        dc.w    $844C                    ; 0088DEBC: dc.w $844C
        dc.w    $2403                    ; 0088DEBE: dc.w $2403
        dc.w    $8486                    ; 0088DEC0: dc.w $8486
        dc.w    $2403                    ; 0088DEC2: dc.w $2403
        dc.w    $84BE                    ; 0088DEC4: dc.w $84BE
        dc.w    $2403                    ; 0088DEC6: dc.w $2403
        dc.w    $84F8                    ; 0088DEC8: dc.w $84F8
        dc.w    $CCCC                    ; 0088DECA: dc.w $CCCC
        dc.w    $0CCC                    ; 0088DECC: dc.w $0CCC
        dc.w    $4240                    ; 0088DECE: dc.w $4240
        dc.w    $1038                    ; 0088DED0: dc.w $1038
        dc.w    $A027                    ; 0088DED2: dc.w $A027
        dc.w    $4EBA                    ; 0088DED4: dc.w $4EBA
        dc.w    $0656                    ; 0088DED6: dc.w $0656
        dc.w    $4EBA                    ; 0088DED8: dc.w $4EBA
        dc.w    $D7AA                    ; 0088DEDA: dc.w $D7AA
        dc.w    $4EBA                    ; 0088DEDC: dc.w $4EBA
        dc.w    $D7FC                    ; 0088DEDE: dc.w $D7FC
        dc.w    $4A39                    ; 0088DEE0: dc.w $4A39
        dc.w    $00A1                    ; 0088DEE2: dc.w $00A1
        dc.w    $5120                    ; 0088DEE4: dc.w $5120
        dc.w    $66F8                    ; 0088DEE6: BNE.S $0088DEE0
        dc.w    $207C, $0603, $7000    ; 0088DEE8: MOVEA.L #$06037000,A0
        dc.w    $227C, $2401, $4010    ; 0088DEEE: MOVEA.L #$24014010,A1
        dc.w    $303C                    ; 0088DEF4: dc.w $303C
        dc.w    $0120                    ; 0088DEF6: dc.w $0120
        dc.w    $323C                    ; 0088DEF8: dc.w $323C
        dc.w    $0030                    ; 0088DEFA: dc.w $0030
        dc.w    $6100, $045C            ; 0088DEFC: BSR.W $0088E35A
        dc.w    $207C, $0603, $B600    ; 0088DF00: MOVEA.L #$0603B600,A0
        dc.w    $227C, $2401, $C010    ; 0088DF06: MOVEA.L #$2401C010,A1
        dc.w    $303C                    ; 0088DF0C: dc.w $303C
        dc.w    $0120                    ; 0088DF0E: dc.w $0120
        dc.w    $323C                    ; 0088DF10: dc.w $323C
        dc.w    $0010                    ; 0088DF12: dc.w $0010
        dc.w    $6100, $0444            ; 0088DF14: BSR.W $0088E35A
        dc.w    $4A39                    ; 0088DF18: dc.w $4A39
        dc.w    $00A1                    ; 0088DF1A: dc.w $00A1
        dc.w    $5120                    ; 0088DF1C: dc.w $5120
        dc.w    $66F8                    ; 0088DF1E: BNE.S $0088DF18
        dc.w    $6100, $01F6            ; 0088DF20: BSR.W $0088E118
        dc.w    $207C, $0603, $DA00    ; 0088DF24: MOVEA.L #$0603DA00,A0
        dc.w    $227C, $2401, $AC88    ; 0088DF2A: MOVEA.L #$2401AC88,A1
        dc.w    $303C                    ; 0088DF30: dc.w $303C
        dc.w    $0038                    ; 0088DF32: dc.w $0038
        dc.w    $323C                    ; 0088DF34: dc.w $323C
        dc.w    $0010                    ; 0088DF36: dc.w $0010
        dc.w    $6100, $0420            ; 0088DF38: BSR.W $0088E35A
        dc.w    $33FC                    ; 0088DF3C: dc.w $33FC
        dc.w    $0018                    ; 0088DF3E: dc.w $0018
        dc.w    $00FF                    ; 0088DF40: dc.w $00FF
        dc.w    $0008                    ; 0088DF42: dc.w $0008
        dc.w    $0C78                    ; 0088DF44: dc.w $0C78
        dc.w    $0001                    ; 0088DF46: dc.w $0001
        dc.w    $A02C                    ; 0088DF48: dc.w $A02C
        dc.w    $6700, $0070            ; 0088DF4A: BEQ.W $0088DFBC
        dc.w    $0C78                    ; 0088DF4E: dc.w $0C78
        dc.w    $0002                    ; 0088DF50: dc.w $0002
        dc.w    $A02C                    ; 0088DF52: dc.w $A02C
        dc.w    $6700, $0076            ; 0088DF54: BEQ.W $0088DFCC
        dc.w    $3238                    ; 0088DF58: dc.w $3238
        dc.w    $C86C                    ; 0088DF5A: dc.w $C86C
        dc.w    $0201                    ; 0088DF5C: dc.w $0201
        dc.w    $00E0                    ; 0088DF5E: dc.w $00E0
        dc.w    $6632                    ; 0088DF60: BNE.S $0088DF94
        dc.w    $0C38                    ; 0088DF62: dc.w $0C38
        dc.w    $0002                    ; 0088DF64: dc.w $0002
        dc.w    $A024                    ; 0088DF66: dc.w $A024
        dc.w    $6600, $0014            ; 0088DF68: BNE.W $0088DF7E
        dc.w    $3238                    ; 0088DF6C: dc.w $3238
        dc.w    $C86E                    ; 0088DF6E: dc.w $C86E
        dc.w    $3401                    ; 0088DF70: dc.w $3401
        dc.w    $0202                    ; 0088DF72: dc.w $0202
        dc.w    $00E0                    ; 0088DF74: dc.w $00E0
        dc.w    $661C                    ; 0088DF76: BNE.S $0088DF94
        dc.w    $0201                    ; 0088DF78: dc.w $0201
        dc.w    $0010                    ; 0088DF7A: dc.w $0010
        dc.w    $6612                    ; 0088DF7C: BNE.S $0088DF90
        dc.w    $3238                    ; 0088DF7E: dc.w $3238
        dc.w    $C86C                    ; 0088DF80: dc.w $C86C
        dc.w    $0201                    ; 0088DF82: dc.w $0201
        dc.w    $0010                    ; 0088DF84: dc.w $0010
        dc.w    $6608                    ; 0088DF86: BNE.S $0088DF90
        dc.w    $5178                    ; 0088DF88: dc.w $5178
        dc.w    $C87E                    ; 0088DF8A: dc.w $C87E
        dc.w    $6000, $0056            ; 0088DF8C: BRA.W $0088DFE4
        dc.w    $50F8                    ; 0088DF90: dc.w $50F8
        dc.w    $A018                    ; 0088DF92: dc.w $A018
        dc.w    $11FC                    ; 0088DF94: dc.w $11FC
        dc.w    $00A8                    ; 0088DF96: dc.w $00A8
        dc.w    $C8A4                    ; 0088DF98: dc.w $C8A4
        dc.w    $11FC                    ; 0088DF9A: dc.w $11FC
        dc.w    $0001                    ; 0088DF9C: dc.w $0001
        dc.w    $C809                    ; 0088DF9E: dc.w $C809
        dc.w    $11FC                    ; 0088DFA0: dc.w $11FC
        dc.w    $0001                    ; 0088DFA2: dc.w $0001
        dc.w    $C80A                    ; 0088DFA4: dc.w $C80A
        dc.w    $08F8                    ; 0088DFA6: dc.w $08F8
        dc.w    $0007                    ; 0088DFA8: dc.w $0007
        dc.w    $C80E                    ; 0088DFAA: dc.w $C80E
        dc.w    $11FC                    ; 0088DFAC: dc.w $11FC
        dc.w    $0001                    ; 0088DFAE: dc.w $0001
        dc.w    $C802                    ; 0088DFB0: dc.w $C802
        dc.w    $31FC                    ; 0088DFB2: dc.w $31FC
        dc.w    $0002                    ; 0088DFB4: dc.w $0002
        dc.w    $A02C                    ; 0088DFB6: dc.w $A02C
        dc.w    $6000, $0026            ; 0088DFB8: BRA.W $0088DFE0
        dc.w    $0838                    ; 0088DFBC: dc.w $0838
        dc.w    $0006                    ; 0088DFBE: dc.w $0006
        dc.w    $C80E                    ; 0088DFC0: dc.w $C80E
        dc.w    $661C                    ; 0088DFC2: BNE.S $0088DFE0
        dc.w    $4278                    ; 0088DFC4: dc.w $4278
        dc.w    $A02C                    ; 0088DFC6: dc.w $A02C
        dc.w    $6000, $0016            ; 0088DFC8: BRA.W $0088DFE0
        dc.w    $0838                    ; 0088DFCC: dc.w $0838
        dc.w    $0007                    ; 0088DFCE: dc.w $0007
        dc.w    $C80E                    ; 0088DFD0: dc.w $C80E
        dc.w    $660C                    ; 0088DFD2: BNE.S $0088DFE0
        dc.w    $4278                    ; 0088DFD4: dc.w $4278
        dc.w    $A02C                    ; 0088DFD6: dc.w $A02C
        dc.w    $5878                    ; 0088DFD8: dc.w $5878
        dc.w    $C87E                    ; 0088DFDA: dc.w $C87E
        dc.w    $6000, $0006            ; 0088DFDC: BRA.W $0088DFE4
        dc.w    $5178                    ; 0088DFE0: dc.w $5178
        dc.w    $C87E                    ; 0088DFE2: dc.w $C87E
        dc.w    $11FC                    ; 0088DFE4: dc.w $11FC
        dc.w    $0001                    ; 0088DFE6: dc.w $0001
        dc.w    $C821                    ; 0088DFE8: dc.w $C821
        dc.w    $4E75                    ; 0088DFEA: RTS
        dc.w    $4A38                    ; 0088DFEC: dc.w $4A38
        dc.w    $A018                    ; 0088DFEE: dc.w $A018
        dc.w    $6614                    ; 0088DFF0: BNE.S $0088E006
        dc.w    $11FC                    ; 0088DFF2: dc.w $11FC
        dc.w    $00F3                    ; 0088DFF4: dc.w $00F3
        dc.w    $C822                    ; 0088DFF6: dc.w $C822
        dc.w    $4A39                    ; 0088DFF8: dc.w $4A39
        dc.w    $00A1                    ; 0088DFFA: dc.w $00A1
        dc.w    $5120                    ; 0088DFFC: dc.w $5120
        dc.w    $66F8                    ; 0088DFFE: BNE.S $0088DFF8

