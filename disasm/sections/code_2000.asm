; ============================================================================
; Code_2000 ($2000-$4000)
; ============================================================================

        org     $002000

Code_2000:
        dc.w    $0000                    ; 00882000: dc.w $0000
        dc.w    $00A1                    ; 00882002: dc.w $00A1
        dc.w    $518B                    ; 00882004: dc.w $518B
        dc.w    $08F9                    ; 00882006: dc.w $08F9
        dc.w    $0007                    ; 00882008: dc.w $0007
        dc.w    $00A1                    ; 0088200A: dc.w $00A1
        dc.w    $5100                    ; 0088200C: dc.w $5100
        dc.w    $4E75                    ; 0088200E: RTS
        dc.w    $3015                    ; 00882010: dc.w $3015
        dc.w    $0839                    ; 00882012: dc.w $0839
        dc.w    $0000                    ; 00882014: dc.w $0000
        dc.w    $00A1                    ; 00882016: dc.w $00A1
        dc.w    $5123                    ; 00882018: dc.w $5123
        dc.w    $671C                    ; 0088201A: BEQ.S $00882038
        dc.w    $08B9                    ; 0088201C: dc.w $08B9
        dc.w    $0000                    ; 0088201E: dc.w $0000
        dc.w    $00A1                    ; 00882020: dc.w $00A1
        dc.w    $5123                    ; 00882022: dc.w $5123
        dc.w    $0C38                    ; 00882024: dc.w $0C38
        dc.w    $0018                    ; 00882026: dc.w $0018
        dc.w    $C8C5                    ; 00882028: dc.w $C8C5
        dc.w    $6606                    ; 0088202A: BNE.S $00882032
        dc.w    $31FC                    ; 0088202C: dc.w $31FC
        dc.w    $0000                    ; 0088202E: dc.w $0000
        dc.w    $C87E                    ; 00882030: dc.w $C87E
        dc.w    $11FC                    ; 00882032: dc.w $11FC
        dc.w    $0000                    ; 00882034: dc.w $0000
        dc.w    $C8C4                    ; 00882036: dc.w $C8C4
        dc.w    $4E75                    ; 00882038: RTS
        dc.w    $48E7, $FFFE            ; 0088203A: MOVEM.L regs,-(SP)
        dc.w    $4EB9, $008B, $0004    ; 0088203E: JSR $008B0004
        dc.w    $4CDF, $7FFF            ; 00882044: MOVEM.L (SP)+,regs
        dc.w    $4E75                    ; 00882048: RTS

; ============================================================================
; ClearInputState - Clear Input Processing State
; ============================================================================
; Clears all input-related RAM locations to reset controller state.
; Called 11 times during game loop.
;
; RAM State Cleared:
;   ($C8A4) - Input state counter
;   ($C822) - Controller state
;   ($C823) - Adjacent state byte
;   ($C8A2) - Secondary input state
; ============================================================================
ClearInputState:
        moveq   #$00,d0                 ; 0088204A: Load 0
        move.w  d0,($C8A4).w            ; 0088204C: Clear input counter
        move.b  d0,($C822).w            ; 00882050: Clear controller state
        move.b  d0,($C823).w            ; 00882054: Clear adjacent state
        move.w  d0,($C8A2).w            ; 00882058: Clear secondary state
        rts                             ; 0088205C: Return

; ============================================================================
; SetInputFlag - Set Input State Flag
; ============================================================================
; Sets the input processing flag to enable frame processing. Called 16 times.
;
; Sets:
;   ($C822) = $F0 (input processing enabled marker)
; ============================================================================
SetInputFlag:
        move.b  #$F0,($C822).w          ; 0088205E: Set input flag
        rts                             ; 00882064: Return

; ============================================================================
; InitInputSystem - Initialize Input System
; ============================================================================
; Initializes hardware and software input state on boot.
;
; Initializes:
;   ($8506) = $03 (input mode)
;   ($8504) = $30 (input control)
;   ($C822) = $00 (clear controller state)
;   ($C8A4) = $00 (clear input counter)
; ============================================================================
InitInputSystem:
        move.b  #$03,($8506).w          ; 00882066: Init input mode
        move.b  #$30,($8504).w          ; 0088206C: Init input control
        moveq   #$00,d0                 ; 00882072: Load 0
        move.b  d0,($C822).w            ; 00882074: Clear controller state
        move.l  d0,($C8A4).w            ; 00882078: Clear input counter
        dc.w    $4E75                    ; 0088207C: RTS
        dc.w    $4E75                    ; 0088207E: RTS

; --- Controller state machine (21 calls) ---
UpdateInputState:
        dc.w    $1038                    ; 00882080: dc.w $1038
        dc.w    $C822                    ; 00882082: dc.w $C822
        dc.w    $6710                    ; 00882084: BEQ.S $00882096
        dc.w    $11C0                    ; 00882086: dc.w $11C0
        dc.w    $8509                    ; 00882088: dc.w $8509
        dc.w    $7000                    ; 0088208A: MOVEQ #$00,D0
        dc.w    $11C0                    ; 0088208C: dc.w $11C0
        dc.w    $C822                    ; 0088208E: dc.w $C822
        dc.w    $21C0                    ; 00882090: dc.w $21C0
        dc.w    $C8A4                    ; 00882092: dc.w $C8A4
        dc.w    $6030                    ; 00882094: BRA.S $008820C6
        dc.w    $1038                    ; 00882096: dc.w $1038
        dc.w    $C8A5                    ; 00882098: dc.w $C8A5
        dc.w    $6716                    ; 0088209A: BEQ.S $008820B2
        dc.w    $B038                    ; 0088209C: dc.w $B038
        dc.w    $C8A7                    ; 0088209E: dc.w $C8A7
        dc.w    $6708                    ; 008820A0: BEQ.S $008820AA
        dc.w    $11C0                    ; 008820A2: dc.w $11C0
        dc.w    $850A                    ; 008820A4: dc.w $850A
        dc.w    $11C0                    ; 008820A6: dc.w $11C0
        dc.w    $C8A7                    ; 008820A8: dc.w $C8A7
        dc.w    $11FC                    ; 008820AA: dc.w $11FC
        dc.w    $0000                    ; 008820AC: dc.w $0000
        dc.w    $C8A5                    ; 008820AE: dc.w $C8A5
        dc.w    $6014                    ; 008820B0: BRA.S $008820C6
        dc.w    $1038                    ; 008820B2: dc.w $1038
        dc.w    $C8A4                    ; 008820B4: dc.w $C8A4
        dc.w    $670E                    ; 008820B6: BEQ.S $008820C6
        dc.w    $11C0                    ; 008820B8: dc.w $11C0
        dc.w    $850A                    ; 008820BA: dc.w $850A
        dc.w    $11C0                    ; 008820BC: dc.w $11C0
        dc.w    $C8A6                    ; 008820BE: dc.w $C8A6
        dc.w    $11FC                    ; 008820C0: dc.w $11FC
        dc.w    $0000                    ; 008820C2: dc.w $0000
        dc.w    $C8A4                    ; 008820C4: dc.w $C8A4

; --- V-INT state 11 input ---
ExtendedInputProcess:
        dc.w    $48E7, $0006            ; 008820C6: MOVEM.L regs,-(SP)
        dc.w    $4EB9, $008B, $0000    ; 008820CA: JSR $008B0000
        dc.w    $4CDF, $6000            ; 008820D0: MOVEM.L (SP)+,regs
        dc.w    $4E75                    ; 008820D4: RTS
        dc.w    $4A38                    ; 008820D6: dc.w $4A38
        dc.w    $850A                    ; 008820D8: dc.w $850A
        dc.w    $661C                    ; 008820DA: BNE.S $008820F8
        dc.w    $0838                    ; 008820DC: dc.w $0838
        dc.w    $0005                    ; 008820DE: dc.w $0005
        dc.w    $C30E                    ; 008820E0: dc.w $C30E
        dc.w    $6614                    ; 008820E2: BNE.S $008820F8
        dc.w    $11F8                    ; 008820E4: dc.w $11F8
        dc.w    $C8A4                    ; 008820E6: dc.w $C8A4
        dc.w    $850A                    ; 008820E8: dc.w $850A
        dc.w    $670C                    ; 008820EA: BEQ.S $008820F8
        dc.w    $11F8                    ; 008820EC: dc.w $11F8
        dc.w    $C8A4                    ; 008820EE: dc.w $C8A4
        dc.w    $C8A6                    ; 008820F0: dc.w $C8A6
        dc.w    $11FC                    ; 008820F2: dc.w $11FC
        dc.w    $0000                    ; 008820F4: dc.w $0000
        dc.w    $C8A4                    ; 008820F6: dc.w $C8A4
        dc.w    $48E7, $0006            ; 008820F8: MOVEM.L regs,-(SP)
        dc.w    $4EB9, $008B, $0000    ; 008820FC: JSR $008B0000
        dc.w    $4CDF, $6000            ; 00882102: MOVEM.L (SP)+,regs
        dc.w    $4EFA                    ; 00882106: dc.w $4EFA
        dc.w    $0226                    ; 00882108: dc.w $0226
        dc.w    $4A38                    ; 0088210A: dc.w $4A38
        dc.w    $850A                    ; 0088210C: dc.w $850A
        dc.w    $660C                    ; 0088210E: BNE.S $0088211C
        dc.w    $11F8                    ; 00882110: dc.w $11F8
        dc.w    $C8A5                    ; 00882112: dc.w $C8A5
        dc.w    $850A                    ; 00882114: dc.w $850A
        dc.w    $11FC                    ; 00882116: dc.w $11FC
        dc.w    $0000                    ; 00882118: dc.w $0000
        dc.w    $C8A5                    ; 0088211A: dc.w $C8A5
        dc.w    $48E7, $0006            ; 0088211C: MOVEM.L regs,-(SP)
        dc.w    $4EB9, $008B, $0000    ; 00882120: JSR $008B0000
        dc.w    $4CDF, $6000            ; 00882126: MOVEM.L (SP)+,regs
        dc.w    $4EFA                    ; 0088212A: dc.w $4EFA
        dc.w    $0202                    ; 0088212C: dc.w $0202
        dc.w    $1038                    ; 0088212E: dc.w $1038
        dc.w    $C822                    ; 00882130: dc.w $C822
        dc.w    $670E                    ; 00882132: BEQ.S $00882142
        dc.w    $11C0                    ; 00882134: dc.w $11C0
        dc.w    $8509                    ; 00882136: dc.w $8509
        dc.w    $7000                    ; 00882138: MOVEQ #$00,D0
        dc.w    $11C0                    ; 0088213A: dc.w $11C0
        dc.w    $C822                    ; 0088213C: dc.w $C822
        dc.w    $21C0                    ; 0088213E: dc.w $21C0
        dc.w    $C8A4                    ; 00882140: dc.w $C8A4
        dc.w    $48E7, $0006            ; 00882142: MOVEM.L regs,-(SP)
        dc.w    $4EB9, $008B, $0000    ; 00882146: JSR $008B0000
        dc.w    $4CDF, $6000            ; 0088214C: MOVEM.L (SP)+,regs
        dc.w    $4EFA                    ; 00882150: dc.w $4EFA
        dc.w    $01DC                    ; 00882152: dc.w $01DC
        dc.w    $4A38                    ; 00882154: dc.w $4A38
        dc.w    $850A                    ; 00882156: dc.w $850A
        dc.w    $6614                    ; 00882158: BNE.S $0088216E
        dc.w    $11F8                    ; 0088215A: dc.w $11F8
        dc.w    $C8A4                    ; 0088215C: dc.w $C8A4
        dc.w    $850A                    ; 0088215E: dc.w $850A
        dc.w    $670C                    ; 00882160: BEQ.S $0088216E
        dc.w    $11F8                    ; 00882162: dc.w $11F8
        dc.w    $C8A4                    ; 00882164: dc.w $C8A4
        dc.w    $C8A6                    ; 00882166: dc.w $C8A6
        dc.w    $11FC                    ; 00882168: dc.w $11FC
        dc.w    $0000                    ; 0088216A: dc.w $0000
        dc.w    $C8A4                    ; 0088216C: dc.w $C8A4
        dc.w    $48E7, $0006            ; 0088216E: MOVEM.L regs,-(SP)
        dc.w    $4EB9, $008B, $0000    ; 00882172: JSR $008B0000
        dc.w    $4CDF, $6000            ; 00882178: MOVEM.L (SP)+,regs
        dc.w    $4EFA                    ; 0088217C: dc.w $4EFA
        dc.w    $008E                    ; 0088217E: dc.w $008E
        dc.w    $4A38                    ; 00882180: dc.w $4A38
        dc.w    $850A                    ; 00882182: dc.w $850A
        dc.w    $660C                    ; 00882184: BNE.S $00882192
        dc.w    $11F8                    ; 00882186: dc.w $11F8
        dc.w    $C8A5                    ; 00882188: dc.w $C8A5
        dc.w    $850A                    ; 0088218A: dc.w $850A
        dc.w    $11FC                    ; 0088218C: dc.w $11FC
        dc.w    $0000                    ; 0088218E: dc.w $0000
        dc.w    $C8A5                    ; 00882190: dc.w $C8A5
        dc.w    $48E7, $0006            ; 00882192: MOVEM.L regs,-(SP)
        dc.w    $4EB9, $008B, $0000    ; 00882196: JSR $008B0000
        dc.w    $4CDF, $6000            ; 0088219C: MOVEM.L (SP)+,regs
        dc.w    $4EFA                    ; 008821A0: dc.w $4EFA
        dc.w    $006A                    ; 008821A2: dc.w $006A
        dc.w    $1038                    ; 008821A4: dc.w $1038
        dc.w    $C822                    ; 008821A6: dc.w $C822
        dc.w    $670E                    ; 008821A8: BEQ.S $008821B8
        dc.w    $11C0                    ; 008821AA: dc.w $11C0
        dc.w    $8509                    ; 008821AC: dc.w $8509
        dc.w    $7000                    ; 008821AE: MOVEQ #$00,D0
        dc.w    $11C0                    ; 008821B0: dc.w $11C0
        dc.w    $C822                    ; 008821B2: dc.w $C822
        dc.w    $21C0                    ; 008821B4: dc.w $21C0
        dc.w    $C8A4                    ; 008821B6: dc.w $C8A4
        dc.w    $48E7, $0006            ; 008821B8: MOVEM.L regs,-(SP)
        dc.w    $4EB9, $008B, $0000    ; 008821BC: JSR $008B0000
        dc.w    $4CDF, $6000            ; 008821C2: MOVEM.L (SP)+,regs
        dc.w    $4EFA                    ; 008821C6: dc.w $4EFA
        dc.w    $0044                    ; 008821C8: dc.w $0044

; --- Copy to controller buffer ---
CopyInputState:
        dc.w    $1038                    ; 008821CA: dc.w $1038
        dc.w    $C822                    ; 008821CC: dc.w $C822
        dc.w    $670E                    ; 008821CE: BEQ.S $008821DE
        dc.w    $11C0                    ; 008821D0: dc.w $11C0
        dc.w    $8509                    ; 008821D2: dc.w $8509
        dc.w    $7000                    ; 008821D4: MOVEQ #$00,D0
        dc.w    $11C0                    ; 008821D6: dc.w $11C0
        dc.w    $C822                    ; 008821D8: dc.w $C822
        dc.w    $21C0                    ; 008821DA: dc.w $21C0
        dc.w    $C8A4                    ; 008821DC: dc.w $C8A4
        dc.w    $48E7, $0006            ; 008821DE: MOVEM.L regs,-(SP)
        dc.w    $4EB9, $008B, $0000    ; 008821E2: JSR $008B0000
        dc.w    $4CDF, $6000            ; 008821E8: MOVEM.L (SP)+,regs
        dc.w    $4E75                    ; 008821EC: RTS
        dc.w    $11FC                    ; 008821EE: dc.w $11FC
        dc.w    $000A                    ; 008821F0: dc.w $000A
        dc.w    $C827                    ; 008821F2: dc.w $C827
        dc.w    $11FC                    ; 008821F4: dc.w $11FC
        dc.w    $000F                    ; 008821F6: dc.w $000F
        dc.w    $C828                    ; 008821F8: dc.w $C828
        dc.w    $4A78                    ; 008821FA: dc.w $4A78
        dc.w    $C8C8                    ; 008821FC: dc.w $C8C8
        dc.w    $6704                    ; 008821FE: BEQ.S $00882204
        dc.w    $5238                    ; 00882200: dc.w $5238
        dc.w    $C828                    ; 00882202: dc.w $C828
        dc.w    $08F8                    ; 00882204: dc.w $08F8
        dc.w    $0001                    ; 00882206: dc.w $0001
        dc.w    $C80B                    ; 00882208: dc.w $C80B
        dc.w    $4E75                    ; 0088220A: RTS
        dc.w    $3038                    ; 0088220C: dc.w $3038
        dc.w    $9F74                    ; 0088220E: dc.w $9F74
        dc.w    $1238                    ; 00882210: dc.w $1238
        dc.w    $9FE5                    ; 00882212: dc.w $9FE5
        dc.w    $47F8                    ; 00882214: dc.w $47F8
        dc.w    $8759                    ; 00882216: dc.w $8759
        dc.w    $45F8                    ; 00882218: dc.w $45F8
        dc.w    $8517                    ; 0088221A: dc.w $8517
        dc.w    $43F8                    ; 0088221C: dc.w $43F8
        dc.w    $8760                    ; 0088221E: dc.w $8760
        dc.w    $6114                    ; 00882220: BSR.S $00882236
        dc.w    $3038                    ; 00882222: dc.w $3038
        dc.w    $9074                    ; 00882224: dc.w $9074
        dc.w    $1238                    ; 00882226: dc.w $1238
        dc.w    $90E5                    ; 00882228: dc.w $90E5
        dc.w    $47F8                    ; 0088222A: dc.w $47F8
        dc.w    $8789                    ; 0088222C: dc.w $8789
        dc.w    $45F8                    ; 0088222E: dc.w $45F8
        dc.w    $8516                    ; 00882230: dc.w $8516
        dc.w    $43F8                    ; 00882232: dc.w $43F8
        dc.w    $8790                    ; 00882234: dc.w $8790

; --- Bit test utility ---
BitTestAndBranch:
        dc.w    $0801                    ; 00882236: dc.w $0801
        dc.w    $0004                    ; 00882238: dc.w $0004
        dc.w    $6710                    ; 0088223A: BEQ.S $0088224C
        dc.w    $1238                    ; 0088223C: dc.w $1238
        dc.w    $C827                    ; 0088223E: dc.w $C827
        dc.w    $B213                    ; 00882240: dc.w $B213
        dc.w    $6716                    ; 00882242: BEQ.S $0088225A
        dc.w    $1681                    ; 00882244: dc.w $1681
        dc.w    $14BC                    ; 00882246: dc.w $14BC
        dc.w    $0001                    ; 00882248: dc.w $0001
        dc.w    $600E                    ; 0088224A: BRA.S $0088225A
        dc.w    $1238                    ; 0088224C: dc.w $1238
        dc.w    $C828                    ; 0088224E: dc.w $C828
        dc.w    $B213                    ; 00882250: dc.w $B213
        dc.w    $6706                    ; 00882252: BEQ.S $0088225A
        dc.w    $1681                    ; 00882254: dc.w $1681
        dc.w    $14BC                    ; 00882256: dc.w $14BC
        dc.w    $0001                    ; 00882258: dc.w $0001
        dc.w    $0C78                    ; 0088225A: dc.w $0C78
        dc.w    $0000                    ; 0088225C: dc.w $0000
        dc.w    $C8C8                    ; 0088225E: dc.w $C8C8
        dc.w    $6748                    ; 00882260: BEQ.S $008822AA
        dc.w    $0C78                    ; 00882262: dc.w $0C78
        dc.w    $0002                    ; 00882264: dc.w $0002
        dc.w    $C8C8                    ; 00882266: dc.w $C8C8
        dc.w    $6700, $0082            ; 00882268: BEQ.W $008822EC
        dc.w    $EA48                    ; 0088226C: dc.w $EA48
        dc.w    $3200                    ; 0088226E: dc.w $3200
        dc.w    $E448                    ; 00882270: dc.w $E448
        dc.w    $D240                    ; 00882272: dc.w $D240
        dc.w    $E248                    ; 00882274: dc.w $E248
        dc.w    $D240                    ; 00882276: dc.w $D240
        dc.w    $0641                    ; 00882278: dc.w $0641
        dc.w    $1A5E                    ; 0088227A: dc.w $1A5E
        dc.w    $D251                    ; 0088227C: dc.w $D251
        dc.w    $E249                    ; 0088227E: dc.w $E249
        dc.w    $0C41                    ; 00882280: dc.w $0C41
        dc.w    $1E00                    ; 00882282: dc.w $1E00
        dc.w    $6E0E                    ; 00882284: BGT.S $00882294
        dc.w    $0C41                    ; 00882286: dc.w $0C41
        dc.w    $1A5E                    ; 00882288: dc.w $1A5E
        dc.w    $6E0C                    ; 0088228A: BGT.S $00882298
        dc.w    $323C                    ; 0088228C: dc.w $323C
        dc.w    $1A5E                    ; 0088228E: dc.w $1A5E
        dc.w    $3281                    ; 00882290: dc.w $3281
        dc.w    $4E75                    ; 00882292: RTS
        dc.w    $323C                    ; 00882294: dc.w $323C
        dc.w    $1E00                    ; 00882296: dc.w $1E00
        dc.w    $B251                    ; 00882298: dc.w $B251
        dc.w    $660A                    ; 0088229A: BNE.S $008822A6
        dc.w    $4EBA                    ; 0088229C: dc.w $4EBA
        dc.w    $26D0                    ; 0088229E: dc.w $26D0
        dc.w    $0240                    ; 008822A0: dc.w $0240
        dc.w    $000F                    ; 008822A2: dc.w $000F
        dc.w    $9240                    ; 008822A4: dc.w $9240
        dc.w    $3281                    ; 008822A6: dc.w $3281
        dc.w    $4E75                    ; 008822A8: RTS
        dc.w    $E848                    ; 008822AA: dc.w $E848
        dc.w    $3200                    ; 008822AC: dc.w $3200
        dc.w    $E248                    ; 008822AE: dc.w $E248
        dc.w    $D240                    ; 008822B0: dc.w $D240
        dc.w    $E248                    ; 008822B2: dc.w $E248
        dc.w    $D240                    ; 008822B4: dc.w $D240
        dc.w    $E448                    ; 008822B6: dc.w $E448
        dc.w    $D240                    ; 008822B8: dc.w $D240
        dc.w    $0641                    ; 008822BA: dc.w $0641
        dc.w    $1A5E                    ; 008822BC: dc.w $1A5E
        dc.w    $D251                    ; 008822BE: dc.w $D251
        dc.w    $E249                    ; 008822C0: dc.w $E249
        dc.w    $0C41                    ; 008822C2: dc.w $0C41
        dc.w    $21D0                    ; 008822C4: dc.w $21D0
        dc.w    $6E0E                    ; 008822C6: BGT.S $008822D6
        dc.w    $0C41                    ; 008822C8: dc.w $0C41
        dc.w    $1A5E                    ; 008822CA: dc.w $1A5E
        dc.w    $6E0C                    ; 008822CC: BGT.S $008822DA
        dc.w    $323C                    ; 008822CE: dc.w $323C
        dc.w    $1A5E                    ; 008822D0: dc.w $1A5E
        dc.w    $3281                    ; 008822D2: dc.w $3281
        dc.w    $4E75                    ; 008822D4: RTS
        dc.w    $323C                    ; 008822D6: dc.w $323C
        dc.w    $21D0                    ; 008822D8: dc.w $21D0
        dc.w    $B251                    ; 008822DA: dc.w $B251
        dc.w    $660A                    ; 008822DC: BNE.S $008822E8
        dc.w    $4EBA                    ; 008822DE: dc.w $4EBA
        dc.w    $268E                    ; 008822E0: dc.w $268E
        dc.w    $0240                    ; 008822E2: dc.w $0240
        dc.w    $000F                    ; 008822E4: dc.w $000F
        dc.w    $9240                    ; 008822E6: dc.w $9240
        dc.w    $3281                    ; 008822E8: dc.w $3281
        dc.w    $4E75                    ; 008822EA: RTS
        dc.w    $E848                    ; 008822EC: dc.w $E848
        dc.w    $3200                    ; 008822EE: dc.w $3200
        dc.w    $E248                    ; 008822F0: dc.w $E248
        dc.w    $D240                    ; 008822F2: dc.w $D240
        dc.w    $E248                    ; 008822F4: dc.w $E248
        dc.w    $D240                    ; 008822F6: dc.w $D240
        dc.w    $0641                    ; 008822F8: dc.w $0641
        dc.w    $1A5E                    ; 008822FA: dc.w $1A5E
        dc.w    $D251                    ; 008822FC: dc.w $D251
        dc.w    $E249                    ; 008822FE: dc.w $E249
        dc.w    $0C41                    ; 00882300: dc.w $0C41
        dc.w    $21A0                    ; 00882302: dc.w $21A0
        dc.w    $6E0E                    ; 00882304: BGT.S $00882314
        dc.w    $0C41                    ; 00882306: dc.w $0C41
        dc.w    $1A5E                    ; 00882308: dc.w $1A5E
        dc.w    $6E0C                    ; 0088230A: BGT.S $00882318
        dc.w    $323C                    ; 0088230C: dc.w $323C
        dc.w    $1A5E                    ; 0088230E: dc.w $1A5E
        dc.w    $3281                    ; 00882310: dc.w $3281
        dc.w    $4E75                    ; 00882312: RTS
        dc.w    $323C                    ; 00882314: dc.w $323C
        dc.w    $21A0                    ; 00882316: dc.w $21A0
        dc.w    $B251                    ; 00882318: dc.w $B251
        dc.w    $660A                    ; 0088231A: BNE.S $00882326
        dc.w    $4EBA                    ; 0088231C: dc.w $4EBA
        dc.w    $2650                    ; 0088231E: dc.w $2650
        dc.w    $0240                    ; 00882320: dc.w $0240
        dc.w    $000F                    ; 00882322: dc.w $000F
        dc.w    $9240                    ; 00882324: dc.w $9240
        dc.w    $3281                    ; 00882326: dc.w $3281
        dc.w    $4E75                    ; 00882328: RTS
        dc.w    $AFAD                    ; 0088232A: dc.w $AFAD
        dc.w    $AE00                    ; 0088232C: dc.w $AE00
        dc.w    $3038                    ; 0088232E: dc.w $3038
        dc.w    $9074                    ; 00882330: dc.w $9074
        dc.w    $43F8                    ; 00882332: dc.w $43F8
        dc.w    $8790                    ; 00882334: dc.w $8790
        dc.w    $0838                    ; 00882336: dc.w $0838
        dc.w    $0004                    ; 00882338: dc.w $0004
        dc.w    $90E5                    ; 0088233A: dc.w $90E5
        dc.w    $671A                    ; 0088233C: BEQ.S $00882358
        dc.w    $0C38                    ; 0088233E: dc.w $0C38
        dc.w    $0001                    ; 00882340: dc.w $0001
        dc.w    $C823                    ; 00882342: dc.w $C823
        dc.w    $6724                    ; 00882344: BEQ.S $0088236A
        dc.w    $11FC                    ; 00882346: dc.w $11FC
        dc.w    $0001                    ; 00882348: dc.w $0001
        dc.w    $C823                    ; 0088234A: dc.w $C823
        dc.w    $3038                    ; 0088234C: dc.w $3038
        dc.w    $C8C8                    ; 0088234E: dc.w $C8C8
        dc.w    $11FB                    ; 00882350: dc.w $11FB
        dc.w    $00D8                    ; 00882352: dc.w $00D8
        dc.w    $C8A5                    ; 00882354: dc.w $C8A5
        dc.w    $6012                    ; 00882356: BRA.S $0088236A
        dc.w    $4A38                    ; 00882358: dc.w $4A38
        dc.w    $C823                    ; 0088235A: dc.w $C823
        dc.w    $670C                    ; 0088235C: BEQ.S $0088236A
        dc.w    $11FC                    ; 0088235E: dc.w $11FC
        dc.w    $0000                    ; 00882360: dc.w $0000
        dc.w    $C823                    ; 00882362: dc.w $C823
        dc.w    $11FC                    ; 00882364: dc.w $11FC
        dc.w    $00AB                    ; 00882366: dc.w $00AB
        dc.w    $C8A5                    ; 00882368: dc.w $C8A5
        dc.w    $0838                    ; 0088236A: dc.w $0838
        dc.w    $0001                    ; 0088236C: dc.w $0001
        dc.w    $C80B                    ; 0088236E: dc.w $C80B
        dc.w    $6712                    ; 00882370: BEQ.S $00882384
        dc.w    $11F8                    ; 00882372: dc.w $11F8
        dc.w    $C828                    ; 00882374: dc.w $C828
        dc.w    $8789                    ; 00882376: dc.w $8789
        dc.w    $11FC                    ; 00882378: dc.w $11FC
        dc.w    $0001                    ; 0088237A: dc.w $0001
        dc.w    $8516                    ; 0088237C: dc.w $8516
        dc.w    $08B8                    ; 0088237E: dc.w $08B8
        dc.w    $0001                    ; 00882380: dc.w $0001
        dc.w    $C80B                    ; 00882382: dc.w $C80B
        dc.w    $0C78                    ; 00882384: dc.w $0C78
        dc.w    $0000                    ; 00882386: dc.w $0000
        dc.w    $C8C8                    ; 00882388: dc.w $C8C8
        dc.w    $6750                    ; 0088238A: BEQ.S $008823DC
        dc.w    $0C78                    ; 0088238C: dc.w $0C78
        dc.w    $0002                    ; 0088238E: dc.w $0002
        dc.w    $C8C8                    ; 00882390: dc.w $C8C8
        dc.w    $6700, $0092            ; 00882392: BEQ.W $00882426
        dc.w    $EA48                    ; 00882396: dc.w $EA48
        dc.w    $3200                    ; 00882398: dc.w $3200
        dc.w    $E448                    ; 0088239A: dc.w $E448
        dc.w    $D240                    ; 0088239C: dc.w $D240
        dc.w    $E248                    ; 0088239E: dc.w $E248
        dc.w    $D240                    ; 008823A0: dc.w $D240
        dc.w    $0641                    ; 008823A2: dc.w $0641
        dc.w    $1A5E                    ; 008823A4: dc.w $1A5E
        dc.w    $D251                    ; 008823A6: dc.w $D251
        dc.w    $E249                    ; 008823A8: dc.w $E249
        dc.w    $0C41                    ; 008823AA: dc.w $0C41
        dc.w    $1E00                    ; 008823AC: dc.w $1E00
        dc.w    $6E12                    ; 008823AE: BGT.S $008823C2
        dc.w    $0C41                    ; 008823B0: dc.w $0C41
        dc.w    $1A5E                    ; 008823B2: dc.w $1A5E
        dc.w    $6E10                    ; 008823B4: BGT.S $008823C6
        dc.w    $323C                    ; 008823B6: dc.w $323C
        dc.w    $1A5E                    ; 008823B8: dc.w $1A5E
        dc.w    $3281                    ; 008823BA: dc.w $3281
        dc.w    $31D1                    ; 008823BC: dc.w $31D1
        dc.w    $8760                    ; 008823BE: dc.w $8760
        dc.w    $4E75                    ; 008823C0: RTS
        dc.w    $323C                    ; 008823C2: dc.w $323C
        dc.w    $1E00                    ; 008823C4: dc.w $1E00
        dc.w    $B251                    ; 008823C6: dc.w $B251
        dc.w    $660A                    ; 008823C8: BNE.S $008823D4
        dc.w    $4EBA                    ; 008823CA: dc.w $4EBA
        dc.w    $25A2                    ; 008823CC: dc.w $25A2
        dc.w    $0240                    ; 008823CE: dc.w $0240
        dc.w    $000F                    ; 008823D0: dc.w $000F
        dc.w    $9240                    ; 008823D2: dc.w $9240
        dc.w    $3281                    ; 008823D4: dc.w $3281
        dc.w    $31D1                    ; 008823D6: dc.w $31D1
        dc.w    $8760                    ; 008823D8: dc.w $8760
        dc.w    $4E75                    ; 008823DA: RTS
        dc.w    $E848                    ; 008823DC: dc.w $E848
        dc.w    $3200                    ; 008823DE: dc.w $3200
        dc.w    $E248                    ; 008823E0: dc.w $E248
        dc.w    $D240                    ; 008823E2: dc.w $D240
        dc.w    $E248                    ; 008823E4: dc.w $E248
        dc.w    $D240                    ; 008823E6: dc.w $D240
        dc.w    $E448                    ; 008823E8: dc.w $E448
        dc.w    $D240                    ; 008823EA: dc.w $D240
        dc.w    $0641                    ; 008823EC: dc.w $0641
        dc.w    $1A5E                    ; 008823EE: dc.w $1A5E
        dc.w    $D251                    ; 008823F0: dc.w $D251
        dc.w    $E249                    ; 008823F2: dc.w $E249
        dc.w    $0C41                    ; 008823F4: dc.w $0C41
        dc.w    $21D0                    ; 008823F6: dc.w $21D0
        dc.w    $6E12                    ; 008823F8: BGT.S $0088240C
        dc.w    $0C41                    ; 008823FA: dc.w $0C41
        dc.w    $1A5E                    ; 008823FC: dc.w $1A5E
        dc.w    $6E10                    ; 008823FE: BGT.S $00882410
        dc.w    $323C                    ; 00882400: dc.w $323C
        dc.w    $1A5E                    ; 00882402: dc.w $1A5E
        dc.w    $3281                    ; 00882404: dc.w $3281
        dc.w    $31D1                    ; 00882406: dc.w $31D1
        dc.w    $8760                    ; 00882408: dc.w $8760
        dc.w    $4E75                    ; 0088240A: RTS
        dc.w    $323C                    ; 0088240C: dc.w $323C
        dc.w    $21D0                    ; 0088240E: dc.w $21D0
        dc.w    $B251                    ; 00882410: dc.w $B251
        dc.w    $660A                    ; 00882412: BNE.S $0088241E
        dc.w    $4EBA                    ; 00882414: dc.w $4EBA
        dc.w    $2558                    ; 00882416: dc.w $2558
        dc.w    $0240                    ; 00882418: dc.w $0240
        dc.w    $000F                    ; 0088241A: dc.w $000F
        dc.w    $9240                    ; 0088241C: dc.w $9240
        dc.w    $3281                    ; 0088241E: dc.w $3281
        dc.w    $31D1                    ; 00882420: dc.w $31D1
        dc.w    $8760                    ; 00882422: dc.w $8760
        dc.w    $4E75                    ; 00882424: RTS
        dc.w    $E848                    ; 00882426: dc.w $E848
        dc.w    $3200                    ; 00882428: dc.w $3200
        dc.w    $E248                    ; 0088242A: dc.w $E248
        dc.w    $D240                    ; 0088242C: dc.w $D240
        dc.w    $E248                    ; 0088242E: dc.w $E248
        dc.w    $D240                    ; 00882430: dc.w $D240
        dc.w    $0641                    ; 00882432: dc.w $0641
        dc.w    $1A5E                    ; 00882434: dc.w $1A5E
        dc.w    $D251                    ; 00882436: dc.w $D251
        dc.w    $E249                    ; 00882438: dc.w $E249
        dc.w    $0C41                    ; 0088243A: dc.w $0C41
        dc.w    $21A0                    ; 0088243C: dc.w $21A0
        dc.w    $6E12                    ; 0088243E: BGT.S $00882452
        dc.w    $0C41                    ; 00882440: dc.w $0C41
        dc.w    $1A5E                    ; 00882442: dc.w $1A5E
        dc.w    $6E10                    ; 00882444: BGT.S $00882456
        dc.w    $323C                    ; 00882446: dc.w $323C
        dc.w    $1A5E                    ; 00882448: dc.w $1A5E
        dc.w    $3281                    ; 0088244A: dc.w $3281
        dc.w    $31D1                    ; 0088244C: dc.w $31D1
        dc.w    $8760                    ; 0088244E: dc.w $8760
        dc.w    $4E75                    ; 00882450: RTS
        dc.w    $323C                    ; 00882452: dc.w $323C
        dc.w    $21A0                    ; 00882454: dc.w $21A0
        dc.w    $B251                    ; 00882456: dc.w $B251
        dc.w    $660A                    ; 00882458: BNE.S $00882464
        dc.w    $4EBA                    ; 0088245A: dc.w $4EBA
        dc.w    $2512                    ; 0088245C: dc.w $2512
        dc.w    $0240                    ; 0088245E: dc.w $0240
        dc.w    $000F                    ; 00882460: dc.w $000F
        dc.w    $9240                    ; 00882462: dc.w $9240
        dc.w    $3281                    ; 00882464: dc.w $3281
        dc.w    $31D1                    ; 00882466: dc.w $31D1
        dc.w    $8760                    ; 00882468: dc.w $8760
        dc.w    $4E75                    ; 0088246A: RTS
        dc.w    $11FC                    ; 0088246C: dc.w $11FC
        dc.w    $0001                    ; 0088246E: dc.w $0001
        dc.w    $8507                    ; 00882470: dc.w $8507
        dc.w    $4E75                    ; 00882472: RTS
        dc.w    $11FC                    ; 00882474: dc.w $11FC
        dc.w    $0080                    ; 00882476: dc.w $0080
        dc.w    $8507                    ; 00882478: dc.w $8507
        dc.w    $4E75                    ; 0088247A: RTS
        dc.w    $3C3C                    ; 0088247C: dc.w $3C3C
        dc.w    $E001                    ; 0088247E: dc.w $E001
        dc.w    $7000                    ; 00882480: MOVEQ #$00,D0
        dc.w    $7200                    ; 00882482: MOVEQ #$00,D1
        dc.w    $1018                    ; 00882484: dc.w $1018
        dc.w    $1200                    ; 00882486: dc.w $1200
        dc.w    $E808                    ; 00882488: dc.w $E808
        dc.w    $0201                    ; 0088248A: dc.w $0201
        dc.w    $000F                    ; 0088248C: dc.w $000F
        dc.w    $D046                    ; 0088248E: dc.w $D046
        dc.w    $D246                    ; 00882490: dc.w $D246
        dc.w    $3C80                    ; 00882492: dc.w $3C80
        dc.w    $3C81                    ; 00882494: dc.w $3C81
        dc.w    $7000                    ; 00882496: MOVEQ #$00,D0
        dc.w    $7200                    ; 00882498: MOVEQ #$00,D1
        dc.w    $1018                    ; 0088249A: dc.w $1018
        dc.w    $1200                    ; 0088249C: dc.w $1200
        dc.w    $E808                    ; 0088249E: dc.w $E808
        dc.w    $0201                    ; 008824A0: dc.w $0201
        dc.w    $000F                    ; 008824A2: dc.w $000F
        dc.w    $D046                    ; 008824A4: dc.w $D046
        dc.w    $D246                    ; 008824A6: dc.w $D246
        dc.w    $3C80                    ; 008824A8: dc.w $3C80
        dc.w    $3C81                    ; 008824AA: dc.w $3C81
        dc.w    $4E75                    ; 008824AC: RTS
        dc.w    $3C3C                    ; 008824AE: dc.w $3C3C
        dc.w    $E001                    ; 008824B0: dc.w $E001
        dc.w    $7000                    ; 008824B2: MOVEQ #$00,D0
        dc.w    $7200                    ; 008824B4: MOVEQ #$00,D1
        dc.w    $1018                    ; 008824B6: dc.w $1018
        dc.w    $1200                    ; 008824B8: dc.w $1200
        dc.w    $E808                    ; 008824BA: dc.w $E808
        dc.w    $0201                    ; 008824BC: dc.w $0201
        dc.w    $000F                    ; 008824BE: dc.w $000F
        dc.w    $D046                    ; 008824C0: dc.w $D046
        dc.w    $D246                    ; 008824C2: dc.w $D246
        dc.w    $3C80                    ; 008824C4: dc.w $3C80
        dc.w    $3C81                    ; 008824C6: dc.w $3C81
        dc.w    $4E75                    ; 008824C8: RTS

; --- Data processing ---
DataProcessing1:
        dc.w    $4A38                    ; 008824CA: dc.w $4A38
        dc.w    $C80D                    ; 008824CC: dc.w $C80D
        dc.w    $6600, $00C2            ; 008824CE: BNE.W $00882592
        dc.w    $31FC                    ; 008824D2: dc.w $31FC
        dc.w    $0000                    ; 008824D4: dc.w $0000
        dc.w    $8000                    ; 008824D6: dc.w $8000
        dc.w    $31FC                    ; 008824D8: dc.w $31FC
        dc.w    $FFF8                    ; 008824DA: dc.w $FFF8
        dc.w    $C880                    ; 008824DC: dc.w $C880
        dc.w    $41F9, $00FF, $6116    ; 008824DE: LEA $00FF6116,A0
        dc.w    $2ABC                    ; 008824E4: dc.w $2ABC
        dc.w    $6202                    ; 008824E6: BHI.S $008824EA
        dc.w    $0002                    ; 008824E8: dc.w $0002
        dc.w    $4EBA                    ; 008824EA: dc.w $4EBA
        dc.w    $FF90                    ; 008824EC: dc.w $FF90
        dc.w    $41F8                    ; 008824EE: dc.w $41F8
        dc.w    $9032                    ; 008824F0: dc.w $9032
        dc.w    $2ABC                    ; 008824F2: dc.w $2ABC
        dc.w    $620C                    ; 008824F4: BHI.S $00882502
        dc.w    $0002                    ; 008824F6: dc.w $0002
        dc.w    $4EBA                    ; 008824F8: dc.w $4EBA

; --- Data transformation ---
DataTransform:
        dc.w    $FF82                    ; 008824FA: dc.w $FF82
        dc.w    $41F9, $00FF, $611A    ; 008824FC: LEA $00FF611A,A0
        dc.w    $2ABC                    ; 00882502: dc.w $2ABC
        dc.w    $6216                    ; 00882504: BHI.S $0088251C
        dc.w    $0002                    ; 00882506: dc.w $0002
        dc.w    $4EBA                    ; 00882508: dc.w $4EBA
        dc.w    $FF72                    ; 0088250A: dc.w $FF72
        dc.w    $41F9, $00FF, $6108    ; 0088250C: LEA $00FF6108,A0
        dc.w    $2ABC                    ; 00882512: dc.w $2ABC
        dc.w    $6302                    ; 00882514: BLS.S $00882518
        dc.w    $0002                    ; 00882516: dc.w $0002
        dc.w    $4EBA                    ; 00882518: dc.w $4EBA

; --- Memory initialization ---
MemoryInit1:
        dc.w    $FF62                    ; 0088251A: dc.w $FF62

; --- Memory operation ---
MemoryOp1:
        dc.w    $41F9, $00FF, $610A    ; 0088251C: LEA $00FF610A,A0
        dc.w    $2ABC                    ; 00882522: dc.w $2ABC
        dc.w    $630C                    ; 00882524: BLS.S $00882532
        dc.w    $0002                    ; 00882526: dc.w $0002
        dc.w    $4EBA                    ; 00882528: dc.w $4EBA
        dc.w    $FF52                    ; 0088252A: dc.w $FF52

; --- Data processing ---
DataProcessing2:
        dc.w    $41F9, $00FF, $610C    ; 0088252C: LEA $00FF610C,A0
        dc.w    $2ABC                    ; 00882532: dc.w $2ABC
        dc.w    $6316                    ; 00882534: BLS.S $0088254C
        dc.w    $0002                    ; 00882536: dc.w $0002
        dc.w    $4EBA                    ; 00882538: dc.w $4EBA
        dc.w    $FF42                    ; 0088253A: dc.w $FF42
        dc.w    $41F9, $00FF, $6104    ; 0088253C: LEA $00FF6104,A0
        dc.w    $2ABC                    ; 00882542: dc.w $2ABC
        dc.w    $632A                    ; 00882544: BLS.S $00882570

; --- Data handling ---
DataHandling:
        dc.w    $0002                    ; 00882546: dc.w $0002
        dc.w    $4EBA                    ; 00882548: dc.w $4EBA
        dc.w    $FF32                    ; 0088254A: dc.w $FF32
        dc.w    $41F9, $00FF, $6106    ; 0088254C: LEA $00FF6106,A0
        dc.w    $2ABC                    ; 00882552: dc.w $2ABC
        dc.w    $6334                    ; 00882554: BLS.S $0088258A
        dc.w    $0002                    ; 00882556: dc.w $0002

; --- Memory utility ---
MemoryUtil:
        dc.w    $4EBA                    ; 00882558: dc.w $4EBA
        dc.w    $FF22                    ; 0088255A: dc.w $FF22
        dc.w    $41F9, $00FF, $5FF8    ; 0088255C: LEA $00FF5FF8,A0
        dc.w    $2ABC                    ; 00882562: dc.w $2ABC
        dc.w    $640C                    ; 00882564: BCC.S $00882572
        dc.w    $0002                    ; 00882566: dc.w $0002
        dc.w    $4EBA                    ; 00882568: dc.w $4EBA
        dc.w    $FF12                    ; 0088256A: dc.w $FF12
        dc.w    $2ABC                    ; 0088256C: dc.w $2ABC
        dc.w    $6416                    ; 0088256E: BCC.S $00882586
        dc.w    $0002                    ; 00882570: dc.w $0002
        dc.w    $4EBA                    ; 00882572: dc.w $4EBA
        dc.w    $FF08                    ; 00882574: dc.w $FF08
        dc.w    $2ABC                    ; 00882576: dc.w $2ABC
        dc.w    $6420                    ; 00882578: BCC.S $0088259A
        dc.w    $0002                    ; 0088257A: dc.w $0002
        dc.w    $4EBA                    ; 0088257C: dc.w $4EBA
        dc.w    $FEFE                    ; 0088257E: dc.w $FEFE
        dc.w    $2ABC                    ; 00882580: dc.w $2ABC
        dc.w    $642A                    ; 00882582: BCC.S $008825AE
        dc.w    $0002                    ; 00882584: dc.w $0002
        dc.w    $4EBA                    ; 00882586: dc.w $4EBA
        dc.w    $FEF4                    ; 00882588: dc.w $FEF4
        dc.w    $13FC                    ; 0088258A: dc.w $13FC
        dc.w    $0000                    ; 0088258C: dc.w $0000
        dc.w    $00FF                    ; 0088258E: dc.w $00FF
        dc.w    $5FFF                    ; 00882590: dc.w $5FFF
        dc.w    $4E75                    ; 00882592: RTS
        dc.w    $4A38                    ; 00882594: dc.w $4A38
        dc.w    $C80D                    ; 00882596: dc.w $C80D
        dc.w    $6614                    ; 00882598: BNE.S $008825AE
        dc.w    $41F8                    ; 0088259A: dc.w $41F8
        dc.w    $C886                    ; 0088259C: dc.w $C886
        dc.w    $2ABC                    ; 0088259E: dc.w $2ABC
        dc.w    $622A                    ; 008825A0: BHI.S $008825CC
        dc.w    $0002                    ; 008825A2: dc.w $0002
        dc.w    $4EBA                    ; 008825A4: dc.w $4EBA
        dc.w    $FF08                    ; 008825A6: dc.w $FF08
        dc.w    $11FC                    ; 008825A8: dc.w $11FC
        dc.w    $0000                    ; 008825AA: dc.w $0000
        dc.w    $C886                    ; 008825AC: dc.w $C886
        dc.w    $4E75                    ; 008825AE: RTS

; --- Memory operation ---
MemoryOp2:
        dc.w    $4A38                    ; 008825B0: dc.w $4A38
        dc.w    $C80D                    ; 008825B2: dc.w $C80D
        dc.w    $6600, $0086            ; 008825B4: BNE.W $0088263C
        dc.w    $41F8                    ; 008825B8: dc.w $41F8
        dc.w    $C888                    ; 008825BA: dc.w $C888
        dc.w    $2ABC                    ; 008825BC: dc.w $2ABC
        dc.w    $6502                    ; 008825BE: BCS.S $008825C2
        dc.w    $0002                    ; 008825C0: dc.w $0002
        dc.w    $4EBA                    ; 008825C2: dc.w $4EBA
        dc.w    $FEB8                    ; 008825C4: dc.w $FEB8
        dc.w    $4EBA                    ; 008825C6: dc.w $4EBA
        dc.w    $FEB4                    ; 008825C8: dc.w $FEB4
        dc.w    $2078                    ; 008825CA: dc.w $2078
        dc.w    $C888                    ; 008825CC: dc.w $C888
        dc.w    $2ABC                    ; 008825CE: dc.w $2ABC
        dc.w    $6514                    ; 008825D0: BCS.S $008825E6
        dc.w    $0002                    ; 008825D2: dc.w $0002
        dc.w    $4EBA                    ; 008825D4: dc.w $4EBA
        dc.w    $FEA6                    ; 008825D6: dc.w $FEA6
        dc.w    $2ABC                    ; 008825D8: dc.w $2ABC
        dc.w    $651E                    ; 008825DA: BCS.S $008825FA
        dc.w    $0002                    ; 008825DC: dc.w $0002
        dc.w    $4EBA                    ; 008825DE: dc.w $4EBA
        dc.w    $FE9C                    ; 008825E0: dc.w $FE9C
        dc.w    $2ABC                    ; 008825E2: dc.w $2ABC
        dc.w    $6528                    ; 008825E4: BCS.S $0088260E
        dc.w    $0002                    ; 008825E6: dc.w $0002
        dc.w    $4EBA                    ; 008825E8: dc.w $4EBA
        dc.w    $FE92                    ; 008825EA: dc.w $FE92
        dc.w    $2ABC                    ; 008825EC: dc.w $2ABC
        dc.w    $6532                    ; 008825EE: BCS.S $00882622
        dc.w    $0002                    ; 008825F0: dc.w $0002
        dc.w    $4EBA                    ; 008825F2: dc.w $4EBA
        dc.w    $FE88                    ; 008825F4: dc.w $FE88
        dc.w    $50B8                    ; 008825F6: dc.w $50B8
        dc.w    $C888                    ; 008825F8: dc.w $C888
        dc.w    $41F8                    ; 008825FA: dc.w $41F8
        dc.w    $C888                    ; 008825FC: dc.w $C888
        dc.w    $2ABC                    ; 008825FE: dc.w $2ABC
        dc.w    $6602                    ; 00882600: BNE.S $00882604
        dc.w    $0002                    ; 00882602: dc.w $0002
        dc.w    $4EBA                    ; 00882604: dc.w $4EBA
        dc.w    $FE76                    ; 00882606: dc.w $FE76
        dc.w    $4EBA                    ; 00882608: dc.w $4EBA
        dc.w    $FE72                    ; 0088260A: dc.w $FE72
        dc.w    $2078                    ; 0088260C: dc.w $2078
        dc.w    $C888                    ; 0088260E: dc.w $C888
        dc.w    $2ABC                    ; 00882610: dc.w $2ABC
        dc.w    $6614                    ; 00882612: BNE.S $00882628
        dc.w    $0002                    ; 00882614: dc.w $0002
        dc.w    $4EBA                    ; 00882616: dc.w $4EBA
        dc.w    $FE64                    ; 00882618: dc.w $FE64
        dc.w    $2ABC                    ; 0088261A: dc.w $2ABC
        dc.w    $661E                    ; 0088261C: BNE.S $0088263C
        dc.w    $0002                    ; 0088261E: dc.w $0002
        dc.w    $4EBA                    ; 00882620: dc.w $4EBA
        dc.w    $FE5A                    ; 00882622: dc.w $FE5A
        dc.w    $2ABC                    ; 00882624: dc.w $2ABC
        dc.w    $6628                    ; 00882626: BNE.S $00882650
        dc.w    $0002                    ; 00882628: dc.w $0002
        dc.w    $4EBA                    ; 0088262A: dc.w $4EBA
        dc.w    $FE50                    ; 0088262C: dc.w $FE50
        dc.w    $2ABC                    ; 0088262E: dc.w $2ABC
        dc.w    $6632                    ; 00882630: BNE.S $00882664
        dc.w    $0002                    ; 00882632: dc.w $0002
        dc.w    $4EBA                    ; 00882634: dc.w $4EBA
        dc.w    $FE46                    ; 00882636: dc.w $FE46
        dc.w    $51B8                    ; 00882638: dc.w $51B8
        dc.w    $C888                    ; 0088263A: dc.w $C888
        dc.w    $4E75                    ; 0088263C: RTS
        dc.w    $43FA                    ; 0088263E: dc.w $43FA
        dc.w    $0012                    ; 00882640: dc.w $0012
        dc.w    $45F9, $00A1, $5100    ; 00882642: LEA $00A15100,A2
        dc.w    $7E0C                    ; 00882648: MOVEQ #$0C,D7
        dc.w    $34D9                    ; 0088264A: dc.w $34D9
        dc.w    $51CF, $FFFC            ; 0088264C: DBRA D7,$0088264A
        dc.w    $4E75                    ; 00882650: RTS
        dc.w    $0083                    ; 00882652: dc.w $0083
        dc.w    $0000                    ; 00882654: dc.w $0000
        dc.w    $0001                    ; 00882656: dc.w $0001
        dc.w    $0000                    ; 00882658: dc.w $0000
        dc.w    $0000                    ; 0088265A: dc.w $0000
        dc.w    $0000                    ; 0088265C: dc.w $0000
        dc.w    $0000                    ; 0088265E: dc.w $0000
        dc.w    $0000                    ; 00882660: dc.w $0000
        dc.w    $0000                    ; 00882662: dc.w $0000
        dc.w    $0000                    ; 00882664: dc.w $0000
        dc.w    $0000                    ; 00882666: dc.w $0000
        dc.w    $0000                    ; 00882668: dc.w $0000
        dc.w    $0000                    ; 0088266A: dc.w $0000

; --- VDP-related operation ---
VDPOp1:
        dc.w    $43FA                    ; 0088266C: dc.w $43FA
        dc.w    $0012                    ; 0088266E: dc.w $0012
        dc.w    $45F9, $00A1, $5180    ; 00882670: LEA $00A15180,A2
        dc.w    $7E05                    ; 00882676: MOVEQ #$05,D7
        dc.w    $34D9                    ; 00882678: dc.w $34D9
        dc.w    $51CF, $FFFC            ; 0088267A: DBRA D7,$00882678
        dc.w    $4E75                    ; 0088267E: RTS
        dc.w    $8000                    ; 00882680: dc.w $8000
        dc.w    $0000                    ; 00882682: dc.w $0000
        dc.w    $0000                    ; 00882684: dc.w $0000
        dc.w    $0000                    ; 00882686: dc.w $0000
        dc.w    $0000                    ; 00882688: dc.w $0000
        dc.w    $0000                    ; 0088268A: dc.w $0000

; --- VDP-related operation ---
VDPOp2:
        dc.w    $49F9, $00A1, $5100    ; 0088268C: LEA $00A15100,A4
        dc.w    $08AC                    ; 00882692: dc.w $08AC
        dc.w    $0000                    ; 00882694: dc.w $0000
        dc.w    $008B                    ; 00882696: dc.w $008B
        dc.w    $4EBA                    ; 00882698: dc.w $4EBA
        dc.w    $00A8                    ; 0088269A: dc.w $00A8
        dc.w    $4EBA                    ; 0088269C: dc.w $4EBA
        dc.w    $0120                    ; 0088269E: dc.w $0120
        dc.w    $4EBA                    ; 008826A0: dc.w $4EBA
        dc.w    $017C                    ; 008826A2: dc.w $017C
        dc.w    $08EC                    ; 008826A4: dc.w $08EC
        dc.w    $0000                    ; 008826A6: dc.w $0000
        dc.w    $008B                    ; 008826A8: dc.w $008B
        dc.w    $4EBA                    ; 008826AA: dc.w $4EBA
        dc.w    $0096                    ; 008826AC: dc.w $0096
        dc.w    $4EBA                    ; 008826AE: dc.w $4EBA
        dc.w    $010E                    ; 008826B0: dc.w $010E
        dc.w    $4EBA                    ; 008826B2: dc.w $4EBA
        dc.w    $016A                    ; 008826B4: dc.w $016A
        dc.w    $08AC                    ; 008826B6: dc.w $08AC
        dc.w    $0000                    ; 008826B8: dc.w $0000
        dc.w    $008B                    ; 008826BA: dc.w $008B
        dc.w    $11FC                    ; 008826BC: dc.w $11FC
        dc.w    $0000                    ; 008826BE: dc.w $0000
        dc.w    $C80C                    ; 008826C0: dc.w $C80C
        dc.w    $7000                    ; 008826C2: MOVEQ #$00,D0
        dc.w    $4EFA                    ; 008826C4: dc.w $4EFA
        dc.w    $00BC                    ; 008826C6: dc.w $00BC

; --- Frame buffer FM toggle (10 calls) ---
VDPFrameControl:
        dc.w    $49F9, $00A1, $5100    ; 008826C8: LEA $00A15100,A4
        dc.w    $08AC                    ; 008826CE: dc.w $08AC
        dc.w    $0000                    ; 008826D0: dc.w $0000
        dc.w    $008B                    ; 008826D2: dc.w $008B
        dc.w    $616C                    ; 008826D4: BSR.S $00882742
        dc.w    $4EBA                    ; 008826D6: dc.w $4EBA
        dc.w    $00C8                    ; 008826D8: dc.w $00C8
        dc.w    $4EBA                    ; 008826DA: dc.w $4EBA
        dc.w    $0142                    ; 008826DC: dc.w $0142
        dc.w    $08EC                    ; 008826DE: dc.w $08EC
        dc.w    $0000                    ; 008826E0: dc.w $0000
        dc.w    $008B                    ; 008826E2: dc.w $008B
        dc.w    $615C                    ; 008826E4: BSR.S $00882742
        dc.w    $4EBA                    ; 008826E6: dc.w $4EBA
        dc.w    $00B8                    ; 008826E8: dc.w $00B8
        dc.w    $4EBA                    ; 008826EA: dc.w $4EBA
        dc.w    $0132                    ; 008826EC: dc.w $0132
        dc.w    $08AC                    ; 008826EE: dc.w $08AC
        dc.w    $0000                    ; 008826F0: dc.w $0000
        dc.w    $008B                    ; 008826F2: dc.w $008B
        dc.w    $11FC                    ; 008826F4: dc.w $11FC
        dc.w    $0000                    ; 008826F6: dc.w $0000
        dc.w    $C80C                    ; 008826F8: dc.w $C80C
        dc.w    $7000                    ; 008826FA: MOVEQ #$00,D0
        dc.w    $4EBA                    ; 008826FC: dc.w $4EBA
        dc.w    $0084                    ; 008826FE: dc.w $0084
        dc.w    $33FC                    ; 00882700: dc.w $33FC
        dc.w    $8000                    ; 00882702: dc.w $8000
        dc.w    $00A1                    ; 00882704: dc.w $00A1
        dc.w    $5202                    ; 00882706: dc.w $5202
        dc.w    $4E75                    ; 00882708: RTS

; --- VDP operation ---
VDPOp3:
        dc.w    $49F9, $00A1, $5100    ; 0088270A: LEA $00A15100,A4
        dc.w    $6130                    ; 00882710: BSR.S $00882742
        dc.w    $4EBA                    ; 00882712: dc.w $4EBA
        dc.w    $008C                    ; 00882714: dc.w $008C
        dc.w    $4EBA                    ; 00882716: dc.w $4EBA
        dc.w    $00C2                    ; 00882718: dc.w $00C2
        dc.w    $7001                    ; 0088271A: MOVEQ #$01,D0
        dc.w    $7400                    ; 0088271C: MOVEQ #$00,D2
        dc.w    $0838                    ; 0088271E: dc.w $0838
        dc.w    $0000                    ; 00882720: dc.w $0000
        dc.w    $C80C                    ; 00882722: dc.w $C80C
        dc.w    $6704                    ; 00882724: BEQ.S $0088272A
        dc.w    $7000                    ; 00882726: MOVEQ #$00,D0
        dc.w    $7401                    ; 00882728: MOVEQ #$01,D2
        dc.w    $1940                    ; 0088272A: dc.w $1940
        dc.w    $008B                    ; 0088272C: dc.w $008B
        dc.w    $6112                    ; 0088272E: BSR.S $00882742
        dc.w    $616E                    ; 00882730: BSR.S $008827A0
        dc.w    $4EBA                    ; 00882732: dc.w $4EBA
        dc.w    $00A6                    ; 00882734: dc.w $00A6
        dc.w    $1942                    ; 00882736: dc.w $1942
        dc.w    $008B                    ; 00882738: dc.w $008B
        dc.w    $4E75                    ; 0088273A: RTS
        dc.w    $49F9, $00A1, $5100    ; 0088273C: LEA $00A15100,A4

; --- VDP auto-fill operation ---
VDPAutoFill:
        dc.w    $45F9, $00A1, $5186    ; 00882742: LEA $00A15186,A2
        dc.w    $47F9, $00A1, $5188    ; 00882748: LEA $00A15188,A3
        dc.w    $022C                    ; 0088274E: dc.w $022C
        dc.w    $0040                    ; 00882750: dc.w $0040
        dc.w    $0081                    ; 00882752: dc.w $0081
        dc.w    $3E3C                    ; 00882754: dc.w $3E3C
        dc.w    $00FF                    ; 00882756: dc.w $00FF
        dc.w    $7000                    ; 00882758: MOVEQ #$00,D0
        dc.w    $7200                    ; 0088275A: MOVEQ #$00,D1
        dc.w    $343C                    ; 0088275C: dc.w $343C
        dc.w    $0100                    ; 0088275E: dc.w $0100
        dc.w    $397C                    ; 00882760: dc.w $397C
        dc.w    $00FF                    ; 00882762: dc.w $00FF
        dc.w    $0084                    ; 00882764: dc.w $0084
        dc.w    $3481                    ; 00882766: dc.w $3481
        dc.w    $3680                    ; 00882768: dc.w $3680
        dc.w    $082C, $0001, $008B    ; 0088276A: BTST #1,$008B(A4)
        dc.w    $66F8                    ; 00882770: BNE.S $0088276A
        dc.w    $D242                    ; 00882772: dc.w $D242
        dc.w    $51CF, $FFF0            ; 00882774: DBRA D7,$00882766
        dc.w    $4E75                    ; 00882778: RTS
        dc.w    $0239                    ; 0088277A: dc.w $0239
        dc.w    $0040                    ; 0088277C: dc.w $0040
        dc.w    $00A1                    ; 0088277E: dc.w $00A1
        dc.w    $5181                    ; 00882780: dc.w $5181
        dc.w    $45F9, $00A1, $5200    ; 00882782: LEA $00A15200,A2
        dc.w    $7E1F                    ; 00882788: MOVEQ #$1F,D7
        dc.w    $24C0                    ; 0088278A: dc.w $24C0
        dc.w    $24C0                    ; 0088278C: dc.w $24C0
        dc.w    $24C0                    ; 0088278E: dc.w $24C0
        dc.w    $24C0                    ; 00882790: dc.w $24C0
        dc.w    $51CF, $FFF6            ; 00882792: DBRA D7,$0088278A
        dc.w    $4E75                    ; 00882796: RTS
        dc.w    $0239                    ; 00882798: dc.w $0239
        dc.w    $0040                    ; 0088279A: dc.w $0040
        dc.w    $00A1                    ; 0088279C: dc.w $00A1
        dc.w    $5181                    ; 0088279E: dc.w $5181

; --- Frame buffer write ---
FrameBufferWrite:
        dc.w    $43F9, $0084, $0000    ; 008827A0: LEA $00840000,A1
        dc.w    $343C                    ; 008827A6: dc.w $343C
        dc.w    $1F00                    ; 008827A8: dc.w $1F00
        dc.w    $3E3C                    ; 008827AA: dc.w $3E3C
        dc.w    $00DF                    ; 008827AC: dc.w $00DF
        dc.w    $32C2                    ; 008827AE: dc.w $32C2
        dc.w    $51CF, $FFFC            ; 008827B0: DBRA D7,$008827AE
        dc.w    $4E75                    ; 008827B4: RTS
        dc.w    $0239                    ; 008827B6: dc.w $0239
        dc.w    $0040                    ; 008827B8: dc.w $0040
        dc.w    $00A1                    ; 008827BA: dc.w $00A1
        dc.w    $5181                    ; 008827BC: dc.w $5181
        dc.w    $43F9, $0084, $0000    ; 008827BE: LEA $00840000,A1
        dc.w    $303C                    ; 008827C4: dc.w $303C
        dc.w    $0100                    ; 008827C6: dc.w $0100
        dc.w    $323C                    ; 008827C8: dc.w $323C
        dc.w    $2000                    ; 008827CA: dc.w $2000
        dc.w    $3E3C                    ; 008827CC: dc.w $3E3C
        dc.w    $00DF                    ; 008827CE: dc.w $00DF
        dc.w    $32C1                    ; 008827D0: dc.w $32C1
        dc.w    $D240                    ; 008827D2: dc.w $D240
        dc.w    $51CF, $FFFA            ; 008827D4: DBRA D7,$008827D0
        dc.w    $4E75                    ; 008827D8: RTS
        dc.w    $6142                    ; 008827DA: BSR.S $0088281E
        dc.w    $49F9, $00A1, $5100    ; 008827DC: LEA $00A15100,A4
        dc.w    $45F9, $00A1, $5186    ; 008827E2: LEA $00A15186,A2
        dc.w    $47F9, $00A1, $5188    ; 008827E8: LEA $00A15188,A3
        dc.w    $323C                    ; 008827EE: dc.w $323C
        dc.w    $2000                    ; 008827F0: dc.w $2000
        dc.w    $6104                    ; 008827F2: BSR.S $008827F8
        dc.w    $323C                    ; 008827F4: dc.w $323C
        dc.w    $F000                    ; 008827F6: dc.w $F000

; --- VDP fill operation ---
VDPFill:
        dc.w    $3E3C                    ; 008827F8: dc.w $3E3C
        dc.w    $000F                    ; 008827FA: dc.w $000F
        dc.w    $303C                    ; 008827FC: dc.w $303C
        dc.w    $0101                    ; 008827FE: dc.w $0101
        dc.w    $343C                    ; 00882800: dc.w $343C
        dc.w    $0100                    ; 00882802: dc.w $0100
        dc.w    $397C                    ; 00882804: dc.w $397C
        dc.w    $00FF                    ; 00882806: dc.w $00FF
        dc.w    $0084                    ; 00882808: dc.w $0084
        dc.w    $3481                    ; 0088280A: dc.w $3481
        dc.w    $3680                    ; 0088280C: dc.w $3680
        dc.w    $082C, $0001, $008B    ; 0088280E: BTST #1,$008B(A4)
        dc.w    $66F8                    ; 00882814: BNE.S $0088280E
        dc.w    $D242                    ; 00882816: dc.w $D242
        dc.w    $51CF, $FFF0            ; 00882818: DBRA D7,$0088280A
        dc.w    $4E75                    ; 0088281C: RTS

; --- VDP preparation ---
VDPPrep:
        dc.w    $49F9, $00A1, $5100    ; 0088281E: LEA $00A15100,A4
        dc.w    $45F9, $00A1, $5186    ; 00882824: LEA $00A15186,A2
        dc.w    $47F9, $00A1, $5188    ; 0088282A: LEA $00A15188,A3
        dc.w    $323C                    ; 00882830: dc.w $323C
        dc.w    $1F00                    ; 00882832: dc.w $1F00
        dc.w    $303C                    ; 00882834: dc.w $303C
        dc.w    $0101                    ; 00882836: dc.w $0101
        dc.w    $397C                    ; 00882838: dc.w $397C
        dc.w    $00FF                    ; 0088283A: dc.w $00FF
        dc.w    $0084                    ; 0088283C: dc.w $0084
        dc.w    $3481                    ; 0088283E: dc.w $3481
        dc.w    $3680                    ; 00882840: dc.w $3680
        dc.w    $082C, $0001, $008B    ; 00882842: BTST #1,$008B(A4)
        dc.w    $66F8                    ; 00882848: BNE.S $00882842
        dc.w    $4E75                    ; 0088284A: RTS

; --- VDP-related ---
func_284C:
        dc.w    $47F9, $00A1, $5200    ; 0088284C: LEA $00A15200,A3
        dc.w    $7E1F                    ; 00882852: MOVEQ #$1F,D7
        dc.w    $26DA                    ; 00882854: dc.w $26DA
        dc.w    $26DA                    ; 00882856: dc.w $26DA
        dc.w    $26DA                    ; 00882858: dc.w $26DA
        dc.w    $26DA                    ; 0088285A: dc.w $26DA
        dc.w    $51CF, $FFF6            ; 0088285C: DBRA D7,$00882854
        dc.w    $4E75                    ; 00882860: RTS

; --- VDP-related ---
func_2862:
        dc.w    $47F9, $00A1, $5240    ; 00882862: LEA $00A15240,A3
        dc.w    $7E07                    ; 00882868: MOVEQ #$07,D7
        dc.w    $26DA                    ; 0088286A: dc.w $26DA
        dc.w    $26DA                    ; 0088286C: dc.w $26DA
        dc.w    $26DA                    ; 0088286E: dc.w $26DA
        dc.w    $26DA                    ; 00882870: dc.w $26DA
        dc.w    $51CF, $FFF6            ; 00882872: DBRA D7,$0088286A
        dc.w    $4E75                    ; 00882876: RTS
        dc.w    $4A38                    ; 00882878: dc.w $4A38
        dc.w    $C821                    ; 0088287A: dc.w $C821
        dc.w    $6710                    ; 0088287C: BEQ.S $0088288E
        dc.w    $43F9, $00FF, $6E00    ; 0088287E: LEA $00FF6E00,A1
        dc.w    $45F9, $00A1, $5200    ; 00882884: LEA $00A15200,A2
        dc.w    $4EFA                    ; 0088288A: dc.w $4EFA
        dc.w    $2046                    ; 0088288C: dc.w $2046
        dc.w    $4E75                    ; 0088288E: RTS
        dc.w    $0839                    ; 00882890: dc.w $0839
        dc.w    $0000                    ; 00882892: dc.w $0000
        dc.w    $00A1                    ; 00882894: dc.w $00A1
        dc.w    $5123                    ; 00882896: dc.w $5123
        dc.w    $67F6                    ; 00882898: BEQ.S $00882890
        dc.w    $08B9                    ; 0088289A: dc.w $08B9
        dc.w    $0000                    ; 0088289C: dc.w $0000
        dc.w    $00A1                    ; 0088289E: dc.w $00A1
        dc.w    $5123                    ; 008828A0: dc.w $5123
        dc.w    $31FC                    ; 008828A2: dc.w $31FC
        dc.w    $0000                    ; 008828A4: dc.w $0000
        dc.w    $C8A8                    ; 008828A6: dc.w $C8A8
        dc.w    $13F8                    ; 008828A8: dc.w $13F8
        dc.w    $C8A9                    ; 008828AA: dc.w $C8A9
        dc.w    $00A1                    ; 008828AC: dc.w $00A1
        dc.w    $5121                    ; 008828AE: dc.w $5121
        dc.w    $13F8                    ; 008828B0: dc.w $13F8
        dc.w    $C8A8                    ; 008828B2: dc.w $C8A8
        dc.w    $00A1                    ; 008828B4: dc.w $00A1
        dc.w    $5120                    ; 008828B6: dc.w $5120
        dc.w    $13FC                    ; 008828B8: dc.w $13FC
        dc.w    $0000                    ; 008828BA: dc.w $0000
        dc.w    $00A1                    ; 008828BC: dc.w $00A1
        dc.w    $5123                    ; 008828BE: dc.w $5123
        dc.w    $4E75                    ; 008828C0: RTS

; --- Called 2x ---
func_28C2:
        dc.w    $33FC                    ; 008828C2: dc.w $33FC
        dc.w    $0500                    ; 008828C4: dc.w $0500
        dc.w    $00A1                    ; 008828C6: dc.w $00A1
        dc.w    $5110                    ; 008828C8: dc.w $5110
        dc.w    $13FC                    ; 008828CA: dc.w $13FC
        dc.w    $0004                    ; 008828CC: dc.w $0004
        dc.w    $00A1                    ; 008828CE: dc.w $00A1
        dc.w    $5107                    ; 008828D0: dc.w $5107
        dc.w    $13F8                    ; 008828D2: dc.w $13F8
        dc.w    $C8A9                    ; 008828D4: dc.w $C8A9
        dc.w    $00A1                    ; 008828D6: dc.w $00A1
        dc.w    $5121                    ; 008828D8: dc.w $5121
        dc.w    $13F8                    ; 008828DA: dc.w $13F8
        dc.w    $C8A8                    ; 008828DC: dc.w $C8A8
        dc.w    $00A1                    ; 008828DE: dc.w $00A1
        dc.w    $5120                    ; 008828E0: dc.w $5120
        dc.w    $0839                    ; 008828E2: dc.w $0839
        dc.w    $0001                    ; 008828E4: dc.w $0001
        dc.w    $00A1                    ; 008828E6: dc.w $00A1
        dc.w    $5123                    ; 008828E8: dc.w $5123
        dc.w    $67F6                    ; 008828EA: BEQ.S $008828E2
        dc.w    $08B9                    ; 008828EC: dc.w $08B9
        dc.w    $0001                    ; 008828EE: dc.w $0001
        dc.w    $00A1                    ; 008828F0: dc.w $00A1
        dc.w    $5123                    ; 008828F2: dc.w $5123
        dc.w    $43F9, $00FF, $6000    ; 008828F4: LEA $00FF6000,A1
        dc.w    $45F9, $00A1, $5112    ; 008828FA: LEA $00A15112,A2
        dc.w    $4EB9, $0089, $88EC    ; 00882900: JSR $008988EC
        dc.w    $4EB9, $0089, $88EC    ; 00882906: JSR $008988EC
        dc.w    $4EB9, $0089, $88EC    ; 0088290C: JSR $008988EC
        dc.w    $4EB9, $0089, $88EC    ; 00882912: JSR $008988EC
        dc.w    $4EB9, $0089, $88EC    ; 00882918: JSR $008988EC
        dc.w    $4EB9, $0089, $88EC    ; 0088291E: JSR $008988EC
        dc.w    $4EB9, $0089, $88EC    ; 00882924: JSR $008988EC
        dc.w    $4EB9, $0089, $88EC    ; 0088292A: JSR $008988EC
        dc.w    $4EB9, $0089, $88EC    ; 00882930: JSR $008988EC
        dc.w    $4EF9, $0089, $88EC    ; 00882936: JMP $008988EC
        dc.w    $49F9, $00A1, $5100    ; 0088293C: LEA $00A15100,A4
        dc.w    $18BC                    ; 00882942: dc.w $18BC
        dc.w    $0000                    ; 00882944: dc.w $0000
        dc.w    $45F9, $00A1, $5186    ; 00882946: LEA $00A15186,A2
        dc.w    $47F9, $00A1, $5188    ; 0088294C: LEA $00A15188,A3
        dc.w    $3E3C                    ; 00882952: dc.w $3E3C
        dc.w    $00BF                    ; 00882954: dc.w $00BF
        dc.w    $7000                    ; 00882956: MOVEQ #$00,D0
        dc.w    $323C                    ; 00882958: dc.w $323C
        dc.w    $3000                    ; 0088295A: dc.w $3000
        dc.w    $343C                    ; 0088295C: dc.w $343C
        dc.w    $0100                    ; 0088295E: dc.w $0100
        dc.w    $397C                    ; 00882960: dc.w $397C
        dc.w    $009F                    ; 00882962: dc.w $009F
        dc.w    $0084                    ; 00882964: dc.w $0084
        dc.w    $3481                    ; 00882966: dc.w $3481
        dc.w    $3680                    ; 00882968: dc.w $3680
        dc.w    $706F                    ; 0088296A: MOVEQ #$6F,D0
        dc.w    $81FC                    ; 0088296C: dc.w $81FC
        dc.w    $0378                    ; 0088296E: dc.w $0378
        dc.w    $082C, $0001, $008B    ; 00882970: BTST #1,$008B(A4)
        dc.w    $66F8                    ; 00882976: BNE.S $00882970
        dc.w    $D242                    ; 00882978: dc.w $D242
        dc.w    $51CF, $FFEA            ; 0088297A: DBRA D7,$00882966
        dc.w    $18BC                    ; 0088297E: dc.w $18BC
        dc.w    $0080                    ; 00882980: dc.w $0080
        dc.w    $4E75                    ; 00882982: RTS
        dc.w    $41F8                    ; 00882984: dc.w $41F8
        dc.w    $9000                    ; 00882986: dc.w $9000
        dc.w    $43F9, $00FF, $6100    ; 00882988: LEA $00FF6100,A1
        dc.w    $4A78                    ; 0088298E: dc.w $4A78
        dc.w    $C04C                    ; 00882990: dc.w $C04C
        dc.w    $6600, $014A            ; 00882992: BNE.W $00882ADE
        dc.w    $3028                    ; 00882996: dc.w $3028
        dc.w    $0030                    ; 00882998: dc.w $0030
        dc.w    $3340                    ; 0088299A: dc.w $3340
        dc.w    $0016                    ; 0088299C: dc.w $0016
        dc.w    $3028                    ; 0088299E: dc.w $3028
        dc.w    $009C                    ; 008829A0: dc.w $009C
        dc.w    $E940                    ; 008829A2: dc.w $E940
        dc.w    $3200                    ; 008829A4: dc.w $3200
        dc.w    $9278                    ; 008829A6: dc.w $9278
        dc.w    $C054                    ; 008829A8: dc.w $C054
        dc.w    $4441                    ; 008829AA: dc.w $4441
        dc.w    $3341                    ; 008829AC: dc.w $3341
        dc.w    $0004                    ; 008829AE: dc.w $0004
        dc.w    $D078                    ; 008829B0: dc.w $D078
        dc.w    $C0E4                    ; 008829B2: dc.w $C0E4
        dc.w    $D068                    ; 008829B4: dc.w $D068
        dc.w    $0032                    ; 008829B6: dc.w $0032
        dc.w    $3340                    ; 008829B8: dc.w $3340
        dc.w    $0018                    ; 008829BA: dc.w $0018
        dc.w    $3378                    ; 008829BC: dc.w $3378
        dc.w    $C056                    ; 008829BE: dc.w $C056
        dc.w    $0006                    ; 008829C0: dc.w $0006
        dc.w    $3028                    ; 008829C2: dc.w $3028
        dc.w    $0034                    ; 008829C4: dc.w $0034
        dc.w    $3340                    ; 008829C6: dc.w $3340
        dc.w    $001A                    ; 008829C8: dc.w $001A
        dc.w    $3028                    ; 008829CA: dc.w $3028
        dc.w    $003A                    ; 008829CC: dc.w $003A
        dc.w    $E640                    ; 008829CE: dc.w $E640
        dc.w    $3200                    ; 008829D0: dc.w $3200
        dc.w    $D078                    ; 008829D2: dc.w $D078
        dc.w    $C0C8                    ; 008829D4: dc.w $C0C8
        dc.w    $3340                    ; 008829D6: dc.w $3340
        dc.w    $0008                    ; 008829D8: dc.w $0008
        dc.w    $3028                    ; 008829DA: dc.w $3028
        dc.w    $0044                    ; 008829DC: dc.w $0044
        dc.w    $E640                    ; 008829DE: dc.w $E640
        dc.w    $D041                    ; 008829E0: dc.w $D041
        dc.w    $4440                    ; 008829E2: dc.w $4440
        dc.w    $3340                    ; 008829E4: dc.w $3340
        dc.w    $001C                    ; 008829E6: dc.w $001C
        dc.w    $3028                    ; 008829E8: dc.w $3028
        dc.w    $003C                    ; 008829EA: dc.w $003C
        dc.w    $D068                    ; 008829EC: dc.w $D068
        dc.w    $0096                    ; 008829EE: dc.w $0096
        dc.w    $E640                    ; 008829F0: dc.w $E640
        dc.w    $3200                    ; 008829F2: dc.w $3200
        dc.w    $D078                    ; 008829F4: dc.w $D078
        dc.w    $C0CA                    ; 008829F6: dc.w $C0CA
        dc.w    $4440                    ; 008829F8: dc.w $4440
        dc.w    $3340                    ; 008829FA: dc.w $3340
        dc.w    $000A                    ; 008829FC: dc.w $000A
        dc.w    $3028                    ; 008829FE: dc.w $3028
        dc.w    $0046                    ; 00882A00: dc.w $0046
        dc.w    $E640                    ; 00882A02: dc.w $E640
        dc.w    $9240                    ; 00882A04: dc.w $9240
        dc.w    $3341                    ; 00882A06: dc.w $3341
        dc.w    $001E                    ; 00882A08: dc.w $001E
        dc.w    $3028                    ; 00882A0A: dc.w $3028
        dc.w    $003E                    ; 00882A0C: dc.w $003E
        dc.w    $E640                    ; 00882A0E: dc.w $E640
        dc.w    $3200                    ; 00882A10: dc.w $3200
        dc.w    $D078                    ; 00882A12: dc.w $D078
        dc.w    $C0CC                    ; 00882A14: dc.w $C0CC
        dc.w    $3340                    ; 00882A16: dc.w $3340
        dc.w    $000C                    ; 00882A18: dc.w $000C
        dc.w    $3028                    ; 00882A1A: dc.w $3028
        dc.w    $004A                    ; 00882A1C: dc.w $004A
        dc.w    $D068                    ; 00882A1E: dc.w $D068
        dc.w    $004C                    ; 00882A20: dc.w $004C
        dc.w    $EA40                    ; 00882A22: dc.w $EA40
        dc.w    $9041                    ; 00882A24: dc.w $9041
        dc.w    $3340                    ; 00882A26: dc.w $3340
        dc.w    $0020                    ; 00882A28: dc.w $0020
        dc.w    $3028                    ; 00882A2A: dc.w $3028
        dc.w    $0090                    ; 00882A2C: dc.w $0090
        dc.w    $E640                    ; 00882A2E: dc.w $E640
        dc.w    $3340                    ; 00882A30: dc.w $3340
        dc.w    $0032                    ; 00882A32: dc.w $0032
        dc.w    $3340                    ; 00882A34: dc.w $3340
        dc.w    $0046                    ; 00882A36: dc.w $0046
        dc.w    $3028                    ; 00882A38: dc.w $3028
        dc.w    $00BC                    ; 00882A3A: dc.w $00BC
        dc.w    $E640                    ; 00882A3C: dc.w $E640
        dc.w    $3340                    ; 00882A3E: dc.w $3340
        dc.w    $0030                    ; 00882A40: dc.w $0030
        dc.w    $3340                    ; 00882A42: dc.w $3340
        dc.w    $0044                    ; 00882A44: dc.w $0044
        dc.w    $3340                    ; 00882A46: dc.w $3340
        dc.w    $0058                    ; 00882A48: dc.w $0058
        dc.w    $4A38                    ; 00882A4A: dc.w $4A38
        dc.w    $C31C                    ; 00882A4C: dc.w $C31C
        dc.w    $6722                    ; 00882A4E: BEQ.S $00882A72
        dc.w    $0828, $0003, $00E5    ; 00882A50: BTST #3,$00E5(A0)
        dc.w    $671A                    ; 00882A56: BEQ.S $00882A72
        dc.w    $7000                    ; 00882A58: MOVEQ #$00,D0
        dc.w    $3280                    ; 00882A5A: dc.w $3280
        dc.w    $3340                    ; 00882A5C: dc.w $3340
        dc.w    $0014                    ; 00882A5E: dc.w $0014
        dc.w    $3340                    ; 00882A60: dc.w $3340
        dc.w    $0028                    ; 00882A62: dc.w $0028
        dc.w    $3340                    ; 00882A64: dc.w $3340
        dc.w    $003C                    ; 00882A66: dc.w $003C
        dc.w    $3340                    ; 00882A68: dc.w $3340
        dc.w    $0050                    ; 00882A6A: dc.w $0050
        dc.w    $3340                    ; 00882A6C: dc.w $3340
        dc.w    $0064                    ; 00882A6E: dc.w $0064
        dc.w    $4E75                    ; 00882A70: RTS
        dc.w    $7001                    ; 00882A72: MOVEQ #$01,D0
        dc.w    $3280                    ; 00882A74: dc.w $3280
        dc.w    $3340                    ; 00882A76: dc.w $3340
        dc.w    $0014                    ; 00882A78: dc.w $0014
        dc.w    $3340                    ; 00882A7A: dc.w $3340
        dc.w    $0028                    ; 00882A7C: dc.w $0028
        dc.w    $3340                    ; 00882A7E: dc.w $3340
        dc.w    $003C                    ; 00882A80: dc.w $003C
        dc.w    $3340                    ; 00882A82: dc.w $3340
        dc.w    $0050                    ; 00882A84: dc.w $0050
        dc.w    $3028                    ; 00882A86: dc.w $3028
        dc.w    $008A                    ; 00882A88: dc.w $008A
        dc.w    $6738                    ; 00882A8A: BEQ.S $00882AC4
        dc.w    $5340                    ; 00882A8C: dc.w $5340
        dc.w    $671A                    ; 00882A8E: BEQ.S $00882AAA
        dc.w    $2378                    ; 00882A90: dc.w $2378
        dc.w    $C74C                    ; 00882A92: dc.w $C74C
        dc.w    $0024                    ; 00882A94: dc.w $0024
        dc.w    $337C                    ; 00882A96: dc.w $337C
        dc.w    $0001                    ; 00882A98: dc.w $0001
        dc.w    $0064                    ; 00882A9A: dc.w $0064
        dc.w    $4A68                    ; 00882A9C: dc.w $4A68
        dc.w    $008C                    ; 00882A9E: dc.w $008C
        dc.w    $673A                    ; 00882AA0: BEQ.S $00882ADC
        dc.w    $337C                    ; 00882AA2: dc.w $337C
        dc.w    $0000                    ; 00882AA4: dc.w $0000
        dc.w    $0064                    ; 00882AA6: dc.w $0064
        dc.w    $4E75                    ; 00882AA8: RTS
        dc.w    $2378                    ; 00882AAA: dc.w $2378
        dc.w    $C748                    ; 00882AAC: dc.w $C748
        dc.w    $0024                    ; 00882AAE: dc.w $0024
        dc.w    $337C                    ; 00882AB0: dc.w $337C
        dc.w    $0001                    ; 00882AB2: dc.w $0001
        dc.w    $0064                    ; 00882AB4: dc.w $0064
        dc.w    $4A68                    ; 00882AB6: dc.w $4A68
        dc.w    $008C                    ; 00882AB8: dc.w $008C
        dc.w    $6720                    ; 00882ABA: BEQ.S $00882ADC
        dc.w    $337C                    ; 00882ABC: dc.w $337C
        dc.w    $0000                    ; 00882ABE: dc.w $0000
        dc.w    $0064                    ; 00882AC0: dc.w $0064
        dc.w    $4E75                    ; 00882AC2: RTS
        dc.w    $2378                    ; 00882AC4: dc.w $2378
        dc.w    $C710                    ; 00882AC6: dc.w $C710
        dc.w    $0024                    ; 00882AC8: dc.w $0024
        dc.w    $337C                    ; 00882ACA: dc.w $337C
        dc.w    $0001                    ; 00882ACC: dc.w $0001
        dc.w    $0064                    ; 00882ACE: dc.w $0064
        dc.w    $4A68                    ; 00882AD0: dc.w $4A68
        dc.w    $008C                    ; 00882AD2: dc.w $008C
        dc.w    $6706                    ; 00882AD4: BEQ.S $00882ADC
        dc.w    $337C                    ; 00882AD6: dc.w $337C
        dc.w    $0000                    ; 00882AD8: dc.w $0000
        dc.w    $0064                    ; 00882ADA: dc.w $0064
        dc.w    $4E75                    ; 00882ADC: RTS
        dc.w    $2378                    ; 00882ADE: dc.w $2378
        dc.w    $C724                    ; 00882AE0: dc.w $C724
        dc.w    $0024                    ; 00882AE2: dc.w $0024
        dc.w    $4A68                    ; 00882AE4: dc.w $4A68
        dc.w    $008A                    ; 00882AE6: dc.w $008A
        dc.w    $6706                    ; 00882AE8: BEQ.S $00882AF0
        dc.w    $2378                    ; 00882AEA: dc.w $2378
        dc.w    $C750                    ; 00882AEC: dc.w $C750
        dc.w    $0024                    ; 00882AEE: dc.w $0024
        dc.w    $3028                    ; 00882AF0: dc.w $3028
        dc.w    $0030                    ; 00882AF2: dc.w $0030
        dc.w    $3340                    ; 00882AF4: dc.w $3340
        dc.w    $0016                    ; 00882AF6: dc.w $0016
        dc.w    $3378                    ; 00882AF8: dc.w $3378
        dc.w    $C054                    ; 00882AFA: dc.w $C054
        dc.w    $0004                    ; 00882AFC: dc.w $0004
        dc.w    $3028                    ; 00882AFE: dc.w $3028
        dc.w    $009C                    ; 00882B00: dc.w $009C
        dc.w    $E940                    ; 00882B02: dc.w $E940
        dc.w    $D068                    ; 00882B04: dc.w $D068
        dc.w    $0032                    ; 00882B06: dc.w $0032
        dc.w    $D078                    ; 00882B08: dc.w $D078
        dc.w    $C0E4                    ; 00882B0A: dc.w $C0E4
        dc.w    $3340                    ; 00882B0C: dc.w $3340
        dc.w    $0018                    ; 00882B0E: dc.w $0018
        dc.w    $3378                    ; 00882B10: dc.w $3378
        dc.w    $C056                    ; 00882B12: dc.w $C056
        dc.w    $0006                    ; 00882B14: dc.w $0006
        dc.w    $3028                    ; 00882B16: dc.w $3028
        dc.w    $0034                    ; 00882B18: dc.w $0034
        dc.w    $3340                    ; 00882B1A: dc.w $3340
        dc.w    $001A                    ; 00882B1C: dc.w $001A
        dc.w    $3028                    ; 00882B1E: dc.w $3028
        dc.w    $003A                    ; 00882B20: dc.w $003A
        dc.w    $E640                    ; 00882B22: dc.w $E640
        dc.w    $3200                    ; 00882B24: dc.w $3200
        dc.w    $D078                    ; 00882B26: dc.w $D078
        dc.w    $C0C8                    ; 00882B28: dc.w $C0C8
        dc.w    $3340                    ; 00882B2A: dc.w $3340
        dc.w    $0008                    ; 00882B2C: dc.w $0008
        dc.w    $4441                    ; 00882B2E: dc.w $4441
        dc.w    $3341                    ; 00882B30: dc.w $3341
        dc.w    $001C                    ; 00882B32: dc.w $001C
        dc.w    $3028                    ; 00882B34: dc.w $3028
        dc.w    $003C                    ; 00882B36: dc.w $003C
        dc.w    $D068                    ; 00882B38: dc.w $D068
        dc.w    $0096                    ; 00882B3A: dc.w $0096
        dc.w    $9068                    ; 00882B3C: dc.w $9068
        dc.w    $0046                    ; 00882B3E: dc.w $0046
        dc.w    $E640                    ; 00882B40: dc.w $E640
        dc.w    $3200                    ; 00882B42: dc.w $3200
        dc.w    $D078                    ; 00882B44: dc.w $D078
        dc.w    $C0CA                    ; 00882B46: dc.w $C0CA
        dc.w    $4440                    ; 00882B48: dc.w $4440
        dc.w    $3340                    ; 00882B4A: dc.w $3340
        dc.w    $000A                    ; 00882B4C: dc.w $000A
        dc.w    $3341                    ; 00882B4E: dc.w $3341
        dc.w    $001E                    ; 00882B50: dc.w $001E
        dc.w    $3028                    ; 00882B52: dc.w $3028
        dc.w    $003E                    ; 00882B54: dc.w $003E
        dc.w    $E640                    ; 00882B56: dc.w $E640
        dc.w    $3200                    ; 00882B58: dc.w $3200
        dc.w    $D078                    ; 00882B5A: dc.w $D078
        dc.w    $C0CC                    ; 00882B5C: dc.w $C0CC
        dc.w    $3340                    ; 00882B5E: dc.w $3340
        dc.w    $000C                    ; 00882B60: dc.w $000C
        dc.w    $3028                    ; 00882B62: dc.w $3028
        dc.w    $004C                    ; 00882B64: dc.w $004C
        dc.w    $E840                    ; 00882B66: dc.w $E840
        dc.w    $9041                    ; 00882B68: dc.w $9041
        dc.w    $3340                    ; 00882B6A: dc.w $3340
        dc.w    $0020                    ; 00882B6C: dc.w $0020
        dc.w    $3028                    ; 00882B6E: dc.w $3028
        dc.w    $0090                    ; 00882B70: dc.w $0090
        dc.w    $E640                    ; 00882B72: dc.w $E640
        dc.w    $3340                    ; 00882B74: dc.w $3340
        dc.w    $0032                    ; 00882B76: dc.w $0032
        dc.w    $3340                    ; 00882B78: dc.w $3340
        dc.w    $0046                    ; 00882B7A: dc.w $0046
        dc.w    $3028                    ; 00882B7C: dc.w $3028
        dc.w    $00BC                    ; 00882B7E: dc.w $00BC
        dc.w    $E640                    ; 00882B80: dc.w $E640
        dc.w    $3340                    ; 00882B82: dc.w $3340
        dc.w    $0030                    ; 00882B84: dc.w $0030
        dc.w    $3340                    ; 00882B86: dc.w $3340
        dc.w    $0044                    ; 00882B88: dc.w $0044
        dc.w    $3238                    ; 00882B8A: dc.w $3238
        dc.w    $C088                    ; 00882B8C: dc.w $C088
        dc.w    $3028                    ; 00882B8E: dc.w $3028
        dc.w    $008E                    ; 00882B90: dc.w $008E
        dc.w    $48C1                    ; 00882B92: dc.w $48C1
        dc.w    $48C0                    ; 00882B94: dc.w $48C0
        dc.w    $D081                    ; 00882B96: dc.w $D081
        dc.w    $E280                    ; 00882B98: dc.w $E280
        dc.w    $31C0                    ; 00882B9A: dc.w $31C0
        dc.w    $C088                    ; 00882B9C: dc.w $C088
        dc.w    $4440                    ; 00882B9E: dc.w $4440
        dc.w    $3200                    ; 00882BA0: dc.w $3200
        dc.w    $EE41                    ; 00882BA2: dc.w $EE41
        dc.w    $EC40                    ; 00882BA4: dc.w $EC40
        dc.w    $D041                    ; 00882BA6: dc.w $D041
        dc.w    $E340                    ; 00882BA8: dc.w $E340
        dc.w    $3340                    ; 00882BAA: dc.w $3340
        dc.w    $0070                    ; 00882BAC: dc.w $0070
        dc.w    $4E75                    ; 00882BAE: RTS
        dc.w    $41F8                    ; 00882BB0: dc.w $41F8
        dc.w    $9000                    ; 00882BB2: dc.w $9000
        dc.w    $43F9, $00FF, $6100    ; 00882BB4: LEA $00FF6100,A1
        dc.w    $45F9, $00FF, $6330    ; 00882BBA: LEA $00FF6330,A2
        dc.w    $0838                    ; 00882BC0: dc.w $0838
        dc.w    $0005                    ; 00882BC2: dc.w $0005
        dc.w    $C30E                    ; 00882BC4: dc.w $C30E
        dc.w    $661E                    ; 00882BC6: BNE.S $00882BE6
        dc.w    $4EBA                    ; 00882BC8: dc.w $4EBA
        dc.w    $008E                    ; 00882BCA: dc.w $008E
        dc.w    $4A78                    ; 00882BCC: dc.w $4A78
        dc.w    $C04C                    ; 00882BCE: dc.w $C04C
        dc.w    $660C                    ; 00882BD0: BNE.S $00882BDE
        dc.w    $4EBA                    ; 00882BD2: dc.w $4EBA
        dc.w    $0108                    ; 00882BD4: dc.w $0108
        dc.w    $4EBA                    ; 00882BD6: dc.w $4EBA
        dc.w    $01F2                    ; 00882BD8: dc.w $01F2
        dc.w    $4EFA                    ; 00882BDA: dc.w $4EFA
        dc.w    $02EA                    ; 00882BDC: dc.w $02EA
        dc.w    $4EBA                    ; 00882BDE: dc.w $4EBA
        dc.w    $0324                    ; 00882BE0: dc.w $0324
        dc.w    $4EFA                    ; 00882BE2: dc.w $4EFA
        dc.w    $02BA                    ; 00882BE4: dc.w $02BA
        dc.w    $7002                    ; 00882BE6: MOVEQ #$02,D0
        dc.w    $3340                    ; 00882BE8: dc.w $3340
        dc.w    $0014                    ; 00882BEA: dc.w $0014
        dc.w    $3340                    ; 00882BEC: dc.w $3340
        dc.w    $0028                    ; 00882BEE: dc.w $0028
        dc.w    $3340                    ; 00882BF0: dc.w $3340
        dc.w    $003C                    ; 00882BF2: dc.w $003C
        dc.w    $3340                    ; 00882BF4: dc.w $3340
        dc.w    $0050                    ; 00882BF6: dc.w $0050
        dc.w    $4EBA                    ; 00882BF8: dc.w $4EBA
        dc.w    $0536                    ; 00882BFA: dc.w $0536
        dc.w    $4EBA                    ; 00882BFC: dc.w $4EBA
        dc.w    $0412                    ; 00882BFE: dc.w $0412
        dc.w    $4EFA                    ; 00882C00: dc.w $4EFA
        dc.w    $01C8                    ; 00882C02: dc.w $01C8
        dc.w    $41F8                    ; 00882C04: dc.w $41F8
        dc.w    $9F00                    ; 00882C06: dc.w $9F00
        dc.w    $43F9, $00FF, $6330    ; 00882C08: LEA $00FF6330,A1
        dc.w    $45F9, $00FF, $6100    ; 00882C0E: LEA $00FF6100,A2
        dc.w    $0838                    ; 00882C14: dc.w $0838
        dc.w    $0005                    ; 00882C16: dc.w $0005
        dc.w    $C30E                    ; 00882C18: dc.w $C30E
        dc.w    $661E                    ; 00882C1A: BNE.S $00882C3A
        dc.w    $4EBA                    ; 00882C1C: dc.w $4EBA
        dc.w    $007C                    ; 00882C1E: dc.w $007C
        dc.w    $4A78                    ; 00882C20: dc.w $4A78
        dc.w    $C04C                    ; 00882C22: dc.w $C04C
        dc.w    $660C                    ; 00882C24: BNE.S $00882C32
        dc.w    $4EBA                    ; 00882C26: dc.w $4EBA
        dc.w    $00B4                    ; 00882C28: dc.w $00B4
        dc.w    $4EBA                    ; 00882C2A: dc.w $4EBA
        dc.w    $0208                    ; 00882C2C: dc.w $0208
        dc.w    $4EFA                    ; 00882C2E: dc.w $4EFA
        dc.w    $0296                    ; 00882C30: dc.w $0296
        dc.w    $4EBA                    ; 00882C32: dc.w $4EBA
        dc.w    $02D0                    ; 00882C34: dc.w $02D0
        dc.w    $4EFA                    ; 00882C36: dc.w $4EFA
        dc.w    $027A                    ; 00882C38: dc.w $027A
        dc.w    $7002                    ; 00882C3A: MOVEQ #$02,D0
        dc.w    $3340                    ; 00882C3C: dc.w $3340
        dc.w    $0014                    ; 00882C3E: dc.w $0014
        dc.w    $3340                    ; 00882C40: dc.w $3340
        dc.w    $0028                    ; 00882C42: dc.w $0028
        dc.w    $3340                    ; 00882C44: dc.w $3340
        dc.w    $003C                    ; 00882C46: dc.w $003C
        dc.w    $3340                    ; 00882C48: dc.w $3340
        dc.w    $0050                    ; 00882C4A: dc.w $0050
        dc.w    $4EBA                    ; 00882C4C: dc.w $4EBA
        dc.w    $04E2                    ; 00882C4E: dc.w $04E2
        dc.w    $4EBA                    ; 00882C50: dc.w $4EBA
        dc.w    $03BE                    ; 00882C52: dc.w $03BE
        dc.w    $4EFA                    ; 00882C54: dc.w $4EFA
        dc.w    $01DE                    ; 00882C56: dc.w $01DE
        dc.w    $7000                    ; 00882C58: MOVEQ #$00,D0
        dc.w    $4A68                    ; 00882C5A: dc.w $4A68
        dc.w    $00C0                    ; 00882C5C: dc.w $00C0
        dc.w    $6728                    ; 00882C5E: BEQ.S $00882C88
        dc.w    $7001                    ; 00882C60: MOVEQ #$01,D0
        dc.w    $4A38                    ; 00882C62: dc.w $4A38
        dc.w    $9FE4                    ; 00882C64: dc.w $9FE4
        dc.w    $6606                    ; 00882C66: BNE.S $00882C6E
        dc.w    $4A38                    ; 00882C68: dc.w $4A38
        dc.w    $B4FC                    ; 00882C6A: dc.w $B4FC
        dc.w    $670C                    ; 00882C6C: BEQ.S $00882C7A
        dc.w    $0828, $0003, $00E5    ; 00882C6E: BTST #3,$00E5(A0)
        dc.w    $6712                    ; 00882C74: BEQ.S $00882C88
        dc.w    $7000                    ; 00882C76: MOVEQ #$00,D0
        dc.w    $600E                    ; 00882C78: BRA.S $00882C88
        dc.w    $0838                    ; 00882C7A: dc.w $0838
        dc.w    $0003                    ; 00882C7C: dc.w $0003
        dc.w    $9FE5                    ; 00882C7E: dc.w $9FE5
        dc.w    $6706                    ; 00882C80: BEQ.S $00882C88
        dc.w    $4A28                    ; 00882C82: dc.w $4A28
        dc.w    $00E4                    ; 00882C84: dc.w $00E4
        dc.w    $66EE                    ; 00882C86: BNE.S $00882C76
        dc.w    $3540                    ; 00882C88: dc.w $3540
        dc.w    $0118                    ; 00882C8A: dc.w $0118
        dc.w    $3540                    ; 00882C8C: dc.w $3540
        dc.w    $012C                    ; 00882C8E: dc.w $012C
        dc.w    $3540                    ; 00882C90: dc.w $3540
        dc.w    $0140                    ; 00882C92: dc.w $0140
        dc.w    $3540                    ; 00882C94: dc.w $3540
        dc.w    $0154                    ; 00882C96: dc.w $0154
        dc.w    $4E75                    ; 00882C98: RTS
        dc.w    $7000                    ; 00882C9A: MOVEQ #$00,D0
        dc.w    $4A68                    ; 00882C9C: dc.w $4A68
        dc.w    $00C0                    ; 00882C9E: dc.w $00C0
        dc.w    $6728                    ; 00882CA0: BEQ.S $00882CCA
        dc.w    $7001                    ; 00882CA2: MOVEQ #$01,D0
        dc.w    $4A38                    ; 00882CA4: dc.w $4A38
        dc.w    $90E4                    ; 00882CA6: dc.w $90E4
        dc.w    $6606                    ; 00882CA8: BNE.S $00882CB0
        dc.w    $4A38                    ; 00882CAA: dc.w $4A38
        dc.w    $B0FC                    ; 00882CAC: dc.w $B0FC
        dc.w    $670C                    ; 00882CAE: BEQ.S $00882CBC
        dc.w    $0828, $0003, $00E5    ; 00882CB0: BTST #3,$00E5(A0)
        dc.w    $6712                    ; 00882CB6: BEQ.S $00882CCA
        dc.w    $7000                    ; 00882CB8: MOVEQ #$00,D0
        dc.w    $600E                    ; 00882CBA: BRA.S $00882CCA
        dc.w    $0838                    ; 00882CBC: dc.w $0838
        dc.w    $0003                    ; 00882CBE: dc.w $0003
        dc.w    $90E5                    ; 00882CC0: dc.w $90E5
        dc.w    $6706                    ; 00882CC2: BEQ.S $00882CCA
        dc.w    $4A28                    ; 00882CC4: dc.w $4A28
        dc.w    $00E4                    ; 00882CC6: dc.w $00E4
        dc.w    $66EE                    ; 00882CC8: BNE.S $00882CB8
        dc.w    $3540                    ; 00882CCA: dc.w $3540
        dc.w    $0118                    ; 00882CCC: dc.w $0118
        dc.w    $3540                    ; 00882CCE: dc.w $3540
        dc.w    $012C                    ; 00882CD0: dc.w $012C
        dc.w    $3540                    ; 00882CD2: dc.w $3540
        dc.w    $0140                    ; 00882CD4: dc.w $0140
        dc.w    $3540                    ; 00882CD6: dc.w $3540
        dc.w    $0154                    ; 00882CD8: dc.w $0154
        dc.w    $4E75                    ; 00882CDA: RTS
        dc.w    $3028                    ; 00882CDC: dc.w $3028
        dc.w    $0030                    ; 00882CDE: dc.w $0030
        dc.w    $3340                    ; 00882CE0: dc.w $3340
        dc.w    $0016                    ; 00882CE2: dc.w $0016
        dc.w    $3540                    ; 00882CE4: dc.w $3540
        dc.w    $011A                    ; 00882CE6: dc.w $011A
        dc.w    $3028                    ; 00882CE8: dc.w $3028
        dc.w    $009C                    ; 00882CEA: dc.w $009C
        dc.w    $E940                    ; 00882CEC: dc.w $E940
        dc.w    $3200                    ; 00882CEE: dc.w $3200
        dc.w    $9278                    ; 00882CF0: dc.w $9278
        dc.w    $C054                    ; 00882CF2: dc.w $C054
        dc.w    $4441                    ; 00882CF4: dc.w $4441
        dc.w    $3341                    ; 00882CF6: dc.w $3341
        dc.w    $0004                    ; 00882CF8: dc.w $0004
        dc.w    $D078                    ; 00882CFA: dc.w $D078
        dc.w    $C0E4                    ; 00882CFC: dc.w $C0E4
        dc.w    $D068                    ; 00882CFE: dc.w $D068
        dc.w    $0032                    ; 00882D00: dc.w $0032
        dc.w    $3340                    ; 00882D02: dc.w $3340
        dc.w    $0018                    ; 00882D04: dc.w $0018
        dc.w    $3540                    ; 00882D06: dc.w $3540
        dc.w    $011C                    ; 00882D08: dc.w $011C
        dc.w    $3378                    ; 00882D0A: dc.w $3378
        dc.w    $C056                    ; 00882D0C: dc.w $C056
        dc.w    $0006                    ; 00882D0E: dc.w $0006
        dc.w    $3028                    ; 00882D10: dc.w $3028
        dc.w    $0034                    ; 00882D12: dc.w $0034
        dc.w    $3340                    ; 00882D14: dc.w $3340
        dc.w    $001A                    ; 00882D16: dc.w $001A
        dc.w    $3540                    ; 00882D18: dc.w $3540
        dc.w    $011E                    ; 00882D1A: dc.w $011E
        dc.w    $3028                    ; 00882D1C: dc.w $3028
        dc.w    $003A                    ; 00882D1E: dc.w $003A
        dc.w    $E640                    ; 00882D20: dc.w $E640
        dc.w    $3200                    ; 00882D22: dc.w $3200
        dc.w    $D078                    ; 00882D24: dc.w $D078
        dc.w    $C0C8                    ; 00882D26: dc.w $C0C8
        dc.w    $D078                    ; 00882D28: dc.w $D078
        dc.w    $C0AE                    ; 00882D2A: dc.w $C0AE
        dc.w    $3340                    ; 00882D2C: dc.w $3340
        dc.w    $0008                    ; 00882D2E: dc.w $0008
        dc.w    $3028                    ; 00882D30: dc.w $3028
        dc.w    $0044                    ; 00882D32: dc.w $0044
        dc.w    $E640                    ; 00882D34: dc.w $E640
        dc.w    $D041                    ; 00882D36: dc.w $D041
        dc.w    $4440                    ; 00882D38: dc.w $4440
        dc.w    $3340                    ; 00882D3A: dc.w $3340
        dc.w    $001C                    ; 00882D3C: dc.w $001C
        dc.w    $3540                    ; 00882D3E: dc.w $3540
        dc.w    $0120                    ; 00882D40: dc.w $0120
        dc.w    $3028                    ; 00882D42: dc.w $3028
        dc.w    $003C                    ; 00882D44: dc.w $003C
        dc.w    $D068                    ; 00882D46: dc.w $D068
        dc.w    $0096                    ; 00882D48: dc.w $0096
        dc.w    $E640                    ; 00882D4A: dc.w $E640
        dc.w    $3200                    ; 00882D4C: dc.w $3200
        dc.w    $D078                    ; 00882D4E: dc.w $D078
        dc.w    $C0CA                    ; 00882D50: dc.w $C0CA
        dc.w    $D078                    ; 00882D52: dc.w $D078
        dc.w    $C0B0                    ; 00882D54: dc.w $C0B0
        dc.w    $4440                    ; 00882D56: dc.w $4440
        dc.w    $3340                    ; 00882D58: dc.w $3340
        dc.w    $000A                    ; 00882D5A: dc.w $000A
        dc.w    $3028                    ; 00882D5C: dc.w $3028
        dc.w    $0046                    ; 00882D5E: dc.w $0046
        dc.w    $E640                    ; 00882D60: dc.w $E640
        dc.w    $9240                    ; 00882D62: dc.w $9240
        dc.w    $3341                    ; 00882D64: dc.w $3341
        dc.w    $001E                    ; 00882D66: dc.w $001E
        dc.w    $3541                    ; 00882D68: dc.w $3541
        dc.w    $0122                    ; 00882D6A: dc.w $0122
        dc.w    $3028                    ; 00882D6C: dc.w $3028
        dc.w    $003E                    ; 00882D6E: dc.w $003E
        dc.w    $E640                    ; 00882D70: dc.w $E640
        dc.w    $3200                    ; 00882D72: dc.w $3200
        dc.w    $D078                    ; 00882D74: dc.w $D078
        dc.w    $C0CC                    ; 00882D76: dc.w $C0CC
        dc.w    $D078                    ; 00882D78: dc.w $D078
        dc.w    $C0B2                    ; 00882D7A: dc.w $C0B2
        dc.w    $3340                    ; 00882D7C: dc.w $3340
        dc.w    $000C                    ; 00882D7E: dc.w $000C
        dc.w    $3028                    ; 00882D80: dc.w $3028
        dc.w    $004A                    ; 00882D82: dc.w $004A
        dc.w    $D068                    ; 00882D84: dc.w $D068
        dc.w    $004C                    ; 00882D86: dc.w $004C
        dc.w    $EA40                    ; 00882D88: dc.w $EA40
        dc.w    $9041                    ; 00882D8A: dc.w $9041
        dc.w    $3340                    ; 00882D8C: dc.w $3340
        dc.w    $0020                    ; 00882D8E: dc.w $0020
        dc.w    $3540                    ; 00882D90: dc.w $3540
        dc.w    $0124                    ; 00882D92: dc.w $0124
        dc.w    $3028                    ; 00882D94: dc.w $3028
        dc.w    $0090                    ; 00882D96: dc.w $0090
        dc.w    $E640                    ; 00882D98: dc.w $E640
        dc.w    $3340                    ; 00882D9A: dc.w $3340
        dc.w    $0032                    ; 00882D9C: dc.w $0032
        dc.w    $3340                    ; 00882D9E: dc.w $3340
        dc.w    $0046                    ; 00882DA0: dc.w $0046
        dc.w    $3540                    ; 00882DA2: dc.w $3540
        dc.w    $0136                    ; 00882DA4: dc.w $0136
        dc.w    $3540                    ; 00882DA6: dc.w $3540
        dc.w    $014A                    ; 00882DA8: dc.w $014A
        dc.w    $3028                    ; 00882DAA: dc.w $3028
        dc.w    $00BC                    ; 00882DAC: dc.w $00BC
        dc.w    $E640                    ; 00882DAE: dc.w $E640
        dc.w    $3340                    ; 00882DB0: dc.w $3340
        dc.w    $0030                    ; 00882DB2: dc.w $0030
        dc.w    $3340                    ; 00882DB4: dc.w $3340
        dc.w    $0044                    ; 00882DB6: dc.w $0044
        dc.w    $3340                    ; 00882DB8: dc.w $3340
        dc.w    $0058                    ; 00882DBA: dc.w $0058
        dc.w    $3540                    ; 00882DBC: dc.w $3540
        dc.w    $0134                    ; 00882DBE: dc.w $0134
        dc.w    $3540                    ; 00882DC0: dc.w $3540
        dc.w    $0148                    ; 00882DC2: dc.w $0148
        dc.w    $3540                    ; 00882DC4: dc.w $3540
        dc.w    $015C                    ; 00882DC6: dc.w $015C
        dc.w    $4E75                    ; 00882DC8: RTS
        dc.w    $3028                    ; 00882DCA: dc.w $3028
        dc.w    $008A                    ; 00882DCC: dc.w $008A
        dc.w    $6744                    ; 00882DCE: BEQ.S $00882E14
        dc.w    $5340                    ; 00882DD0: dc.w $5340
        dc.w    $6720                    ; 00882DD2: BEQ.S $00882DF4
        dc.w    $2378                    ; 00882DD4: dc.w $2378
        dc.w    $C74C                    ; 00882DD6: dc.w $C74C
        dc.w    $0024                    ; 00882DD8: dc.w $0024
        dc.w    $2578                    ; 00882DDA: dc.w $2578
        dc.w    $C74C                    ; 00882DDC: dc.w $C74C
        dc.w    $0128                    ; 00882DDE: dc.w $0128
        dc.w    $337C                    ; 00882DE0: dc.w $337C
        dc.w    $0001                    ; 00882DE2: dc.w $0001
        dc.w    $0064                    ; 00882DE4: dc.w $0064
        dc.w    $4A68                    ; 00882DE6: dc.w $4A68
        dc.w    $008C                    ; 00882DE8: dc.w $008C
        dc.w    $6746                    ; 00882DEA: BEQ.S $00882E32
        dc.w    $337C                    ; 00882DEC: dc.w $337C
        dc.w    $0000                    ; 00882DEE: dc.w $0000
        dc.w    $0064                    ; 00882DF0: dc.w $0064
        dc.w    $4E75                    ; 00882DF2: RTS
        dc.w    $2378                    ; 00882DF4: dc.w $2378
        dc.w    $C748                    ; 00882DF6: dc.w $C748
        dc.w    $0024                    ; 00882DF8: dc.w $0024
        dc.w    $2578                    ; 00882DFA: dc.w $2578
        dc.w    $C748                    ; 00882DFC: dc.w $C748
        dc.w    $0128                    ; 00882DFE: dc.w $0128
        dc.w    $337C                    ; 00882E00: dc.w $337C
        dc.w    $0001                    ; 00882E02: dc.w $0001
        dc.w    $0064                    ; 00882E04: dc.w $0064
        dc.w    $4A68                    ; 00882E06: dc.w $4A68
        dc.w    $008C                    ; 00882E08: dc.w $008C
        dc.w    $6726                    ; 00882E0A: BEQ.S $00882E32
        dc.w    $337C                    ; 00882E0C: dc.w $337C
        dc.w    $0000                    ; 00882E0E: dc.w $0000
        dc.w    $0064                    ; 00882E10: dc.w $0064
        dc.w    $4E75                    ; 00882E12: RTS
        dc.w    $2378                    ; 00882E14: dc.w $2378
        dc.w    $C710                    ; 00882E16: dc.w $C710
        dc.w    $0024                    ; 00882E18: dc.w $0024
        dc.w    $2578                    ; 00882E1A: dc.w $2578
        dc.w    $C710                    ; 00882E1C: dc.w $C710
        dc.w    $0128                    ; 00882E1E: dc.w $0128
        dc.w    $337C                    ; 00882E20: dc.w $337C
        dc.w    $0001                    ; 00882E22: dc.w $0001
        dc.w    $0064                    ; 00882E24: dc.w $0064
        dc.w    $4A68                    ; 00882E26: dc.w $4A68
        dc.w    $008C                    ; 00882E28: dc.w $008C
        dc.w    $6706                    ; 00882E2A: BEQ.S $00882E32
        dc.w    $337C                    ; 00882E2C: dc.w $337C
        dc.w    $0000                    ; 00882E2E: dc.w $0000
        dc.w    $0064                    ; 00882E30: dc.w $0064
        dc.w    $4E75                    ; 00882E32: RTS
        dc.w    $3028                    ; 00882E34: dc.w $3028
        dc.w    $008A                    ; 00882E36: dc.w $008A
        dc.w    $6744                    ; 00882E38: BEQ.S $00882E7E
        dc.w    $5340                    ; 00882E3A: dc.w $5340
        dc.w    $6720                    ; 00882E3C: BEQ.S $00882E5E
        dc.w    $2378                    ; 00882E3E: dc.w $2378
        dc.w    $C760                    ; 00882E40: dc.w $C760
        dc.w    $0024                    ; 00882E42: dc.w $0024
        dc.w    $2578                    ; 00882E44: dc.w $2578
        dc.w    $C760                    ; 00882E46: dc.w $C760
        dc.w    $0128                    ; 00882E48: dc.w $0128
        dc.w    $337C                    ; 00882E4A: dc.w $337C
        dc.w    $0001                    ; 00882E4C: dc.w $0001
        dc.w    $0064                    ; 00882E4E: dc.w $0064
        dc.w    $4A68                    ; 00882E50: dc.w $4A68
        dc.w    $008C                    ; 00882E52: dc.w $008C
        dc.w    $6746                    ; 00882E54: BEQ.S $00882E9C
        dc.w    $337C                    ; 00882E56: dc.w $337C
        dc.w    $0000                    ; 00882E58: dc.w $0000
        dc.w    $0064                    ; 00882E5A: dc.w $0064
        dc.w    $4E75                    ; 00882E5C: RTS
        dc.w    $2378                    ; 00882E5E: dc.w $2378
        dc.w    $C75C                    ; 00882E60: dc.w $C75C
        dc.w    $0024                    ; 00882E62: dc.w $0024
        dc.w    $2578                    ; 00882E64: dc.w $2578
        dc.w    $C75C                    ; 00882E66: dc.w $C75C
        dc.w    $0128                    ; 00882E68: dc.w $0128
        dc.w    $337C                    ; 00882E6A: dc.w $337C
        dc.w    $0001                    ; 00882E6C: dc.w $0001
        dc.w    $0064                    ; 00882E6E: dc.w $0064
        dc.w    $4A68                    ; 00882E70: dc.w $4A68
        dc.w    $008C                    ; 00882E72: dc.w $008C
        dc.w    $6726                    ; 00882E74: BEQ.S $00882E9C
        dc.w    $337C                    ; 00882E76: dc.w $337C
        dc.w    $0000                    ; 00882E78: dc.w $0000
        dc.w    $0064                    ; 00882E7A: dc.w $0064
        dc.w    $4E75                    ; 00882E7C: RTS
        dc.w    $2378                    ; 00882E7E: dc.w $2378
        dc.w    $C754                    ; 00882E80: dc.w $C754
        dc.w    $0024                    ; 00882E82: dc.w $0024
        dc.w    $2578                    ; 00882E84: dc.w $2578
        dc.w    $C754                    ; 00882E86: dc.w $C754
        dc.w    $0128                    ; 00882E88: dc.w $0128
        dc.w    $337C                    ; 00882E8A: dc.w $337C
        dc.w    $0001                    ; 00882E8C: dc.w $0001
        dc.w    $0064                    ; 00882E8E: dc.w $0064
        dc.w    $4A68                    ; 00882E90: dc.w $4A68
        dc.w    $008C                    ; 00882E92: dc.w $008C
        dc.w    $6706                    ; 00882E94: BEQ.S $00882E9C
        dc.w    $337C                    ; 00882E96: dc.w $337C
        dc.w    $0000                    ; 00882E98: dc.w $0000
        dc.w    $0064                    ; 00882E9A: dc.w $0064
        dc.w    $4E75                    ; 00882E9C: RTS
        dc.w    $2378                    ; 00882E9E: dc.w $2378
        dc.w    $C724                    ; 00882EA0: dc.w $C724
        dc.w    $0024                    ; 00882EA2: dc.w $0024
        dc.w    $4A68                    ; 00882EA4: dc.w $4A68
        dc.w    $008A                    ; 00882EA6: dc.w $008A
        dc.w    $6706                    ; 00882EA8: BEQ.S $00882EB0
        dc.w    $2378                    ; 00882EAA: dc.w $2378
        dc.w    $C750                    ; 00882EAC: dc.w $C750
        dc.w    $0024                    ; 00882EAE: dc.w $0024
        dc.w    $4E75                    ; 00882EB0: RTS
        dc.w    $2378                    ; 00882EB2: dc.w $2378
        dc.w    $C758                    ; 00882EB4: dc.w $C758
        dc.w    $0024                    ; 00882EB6: dc.w $0024
        dc.w    $4A68                    ; 00882EB8: dc.w $4A68
        dc.w    $008A                    ; 00882EBA: dc.w $008A
        dc.w    $6706                    ; 00882EBC: BEQ.S $00882EC4
        dc.w    $2378                    ; 00882EBE: dc.w $2378
        dc.w    $C764                    ; 00882EC0: dc.w $C764
        dc.w    $0024                    ; 00882EC2: dc.w $0024
        dc.w    $4E75                    ; 00882EC4: RTS
        dc.w    $4A38                    ; 00882EC6: dc.w $4A38
        dc.w    $C31C                    ; 00882EC8: dc.w $C31C
        dc.w    $6722                    ; 00882ECA: BEQ.S $00882EEE
        dc.w    $0828, $0003, $00E5    ; 00882ECC: BTST #3,$00E5(A0)
        dc.w    $671A                    ; 00882ED2: BEQ.S $00882EEE
        dc.w    $7000                    ; 00882ED4: MOVEQ #$00,D0
        dc.w    $3280                    ; 00882ED6: dc.w $3280
        dc.w    $3340                    ; 00882ED8: dc.w $3340
        dc.w    $0014                    ; 00882EDA: dc.w $0014
        dc.w    $3340                    ; 00882EDC: dc.w $3340
        dc.w    $0028                    ; 00882EDE: dc.w $0028
        dc.w    $3340                    ; 00882EE0: dc.w $3340
        dc.w    $003C                    ; 00882EE2: dc.w $003C
        dc.w    $3340                    ; 00882EE4: dc.w $3340
        dc.w    $0050                    ; 00882EE6: dc.w $0050
        dc.w    $3340                    ; 00882EE8: dc.w $3340
        dc.w    $0064                    ; 00882EEA: dc.w $0064
        dc.w    $4E75                    ; 00882EEC: RTS
        dc.w    $7001                    ; 00882EEE: MOVEQ #$01,D0
        dc.w    $3280                    ; 00882EF0: dc.w $3280
        dc.w    $3340                    ; 00882EF2: dc.w $3340
        dc.w    $0014                    ; 00882EF4: dc.w $0014
        dc.w    $3340                    ; 00882EF6: dc.w $3340
        dc.w    $0028                    ; 00882EF8: dc.w $0028
        dc.w    $3340                    ; 00882EFA: dc.w $3340
        dc.w    $003C                    ; 00882EFC: dc.w $003C
        dc.w    $3340                    ; 00882EFE: dc.w $3340
        dc.w    $0050                    ; 00882F00: dc.w $0050
        dc.w    $4E75                    ; 00882F02: RTS
        dc.w    $3028                    ; 00882F04: dc.w $3028
        dc.w    $0030                    ; 00882F06: dc.w $0030
        dc.w    $3340                    ; 00882F08: dc.w $3340
        dc.w    $0016                    ; 00882F0A: dc.w $0016
        dc.w    $3540                    ; 00882F0C: dc.w $3540
        dc.w    $011A                    ; 00882F0E: dc.w $011A
        dc.w    $3378                    ; 00882F10: dc.w $3378
        dc.w    $C054                    ; 00882F12: dc.w $C054
        dc.w    $0004                    ; 00882F14: dc.w $0004
        dc.w    $3028                    ; 00882F16: dc.w $3028
        dc.w    $009C                    ; 00882F18: dc.w $009C
        dc.w    $E940                    ; 00882F1A: dc.w $E940
        dc.w    $D068                    ; 00882F1C: dc.w $D068
        dc.w    $0032                    ; 00882F1E: dc.w $0032
        dc.w    $D078                    ; 00882F20: dc.w $D078
        dc.w    $C0E4                    ; 00882F22: dc.w $C0E4
        dc.w    $3340                    ; 00882F24: dc.w $3340
        dc.w    $0018                    ; 00882F26: dc.w $0018
        dc.w    $3540                    ; 00882F28: dc.w $3540
        dc.w    $011C                    ; 00882F2A: dc.w $011C
        dc.w    $3378                    ; 00882F2C: dc.w $3378
        dc.w    $C056                    ; 00882F2E: dc.w $C056
        dc.w    $0006                    ; 00882F30: dc.w $0006
        dc.w    $3028                    ; 00882F32: dc.w $3028
        dc.w    $0034                    ; 00882F34: dc.w $0034
        dc.w    $3340                    ; 00882F36: dc.w $3340
        dc.w    $001A                    ; 00882F38: dc.w $001A
        dc.w    $3540                    ; 00882F3A: dc.w $3540
        dc.w    $011E                    ; 00882F3C: dc.w $011E
        dc.w    $3028                    ; 00882F3E: dc.w $3028
        dc.w    $003A                    ; 00882F40: dc.w $003A
        dc.w    $E640                    ; 00882F42: dc.w $E640
        dc.w    $3200                    ; 00882F44: dc.w $3200
        dc.w    $D078                    ; 00882F46: dc.w $D078
        dc.w    $C0C8                    ; 00882F48: dc.w $C0C8
        dc.w    $D078                    ; 00882F4A: dc.w $D078
        dc.w    $C0AE                    ; 00882F4C: dc.w $C0AE
        dc.w    $3340                    ; 00882F4E: dc.w $3340
        dc.w    $0008                    ; 00882F50: dc.w $0008
        dc.w    $4441                    ; 00882F52: dc.w $4441
        dc.w    $3341                    ; 00882F54: dc.w $3341
        dc.w    $001C                    ; 00882F56: dc.w $001C
        dc.w    $3541                    ; 00882F58: dc.w $3541
        dc.w    $0120                    ; 00882F5A: dc.w $0120
        dc.w    $3028                    ; 00882F5C: dc.w $3028
        dc.w    $003C                    ; 00882F5E: dc.w $003C
        dc.w    $D068                    ; 00882F60: dc.w $D068
        dc.w    $0096                    ; 00882F62: dc.w $0096
        dc.w    $9068                    ; 00882F64: dc.w $9068
        dc.w    $0046                    ; 00882F66: dc.w $0046
        dc.w    $E640                    ; 00882F68: dc.w $E640
        dc.w    $3200                    ; 00882F6A: dc.w $3200
        dc.w    $D078                    ; 00882F6C: dc.w $D078
        dc.w    $C0CA                    ; 00882F6E: dc.w $C0CA
        dc.w    $D078                    ; 00882F70: dc.w $D078
        dc.w    $C0B0                    ; 00882F72: dc.w $C0B0
        dc.w    $4440                    ; 00882F74: dc.w $4440
        dc.w    $3340                    ; 00882F76: dc.w $3340
        dc.w    $000A                    ; 00882F78: dc.w $000A
        dc.w    $3341                    ; 00882F7A: dc.w $3341
        dc.w    $001E                    ; 00882F7C: dc.w $001E
        dc.w    $3028                    ; 00882F7E: dc.w $3028
        dc.w    $0046                    ; 00882F80: dc.w $0046
        dc.w    $E640                    ; 00882F82: dc.w $E640
        dc.w    $9240                    ; 00882F84: dc.w $9240
        dc.w    $3541                    ; 00882F86: dc.w $3541
        dc.w    $0122                    ; 00882F88: dc.w $0122
        dc.w    $3028                    ; 00882F8A: dc.w $3028
        dc.w    $003E                    ; 00882F8C: dc.w $003E
        dc.w    $E640                    ; 00882F8E: dc.w $E640
        dc.w    $3200                    ; 00882F90: dc.w $3200
        dc.w    $D078                    ; 00882F92: dc.w $D078
        dc.w    $C0CC                    ; 00882F94: dc.w $C0CC
        dc.w    $D078                    ; 00882F96: dc.w $D078
        dc.w    $C0B2                    ; 00882F98: dc.w $C0B2
        dc.w    $3340                    ; 00882F9A: dc.w $3340
        dc.w    $000C                    ; 00882F9C: dc.w $000C
        dc.w    $3028                    ; 00882F9E: dc.w $3028
        dc.w    $004C                    ; 00882FA0: dc.w $004C
        dc.w    $E840                    ; 00882FA2: dc.w $E840
        dc.w    $9041                    ; 00882FA4: dc.w $9041
        dc.w    $3340                    ; 00882FA6: dc.w $3340
        dc.w    $0020                    ; 00882FA8: dc.w $0020
        dc.w    $3028                    ; 00882FAA: dc.w $3028
        dc.w    $004A                    ; 00882FAC: dc.w $004A
        dc.w    $D068                    ; 00882FAE: dc.w $D068
        dc.w    $004C                    ; 00882FB0: dc.w $004C
        dc.w    $EA40                    ; 00882FB2: dc.w $EA40
        dc.w    $9041                    ; 00882FB4: dc.w $9041
        dc.w    $3540                    ; 00882FB6: dc.w $3540
        dc.w    $0124                    ; 00882FB8: dc.w $0124
        dc.w    $3028                    ; 00882FBA: dc.w $3028
        dc.w    $0090                    ; 00882FBC: dc.w $0090
        dc.w    $E640                    ; 00882FBE: dc.w $E640
        dc.w    $3340                    ; 00882FC0: dc.w $3340
        dc.w    $0032                    ; 00882FC2: dc.w $0032
        dc.w    $3340                    ; 00882FC4: dc.w $3340
        dc.w    $0046                    ; 00882FC6: dc.w $0046
        dc.w    $3540                    ; 00882FC8: dc.w $3540
        dc.w    $0136                    ; 00882FCA: dc.w $0136
        dc.w    $3540                    ; 00882FCC: dc.w $3540
        dc.w    $014A                    ; 00882FCE: dc.w $014A
        dc.w    $3028                    ; 00882FD0: dc.w $3028
        dc.w    $00BC                    ; 00882FD2: dc.w $00BC
        dc.w    $E640                    ; 00882FD4: dc.w $E640
        dc.w    $3340                    ; 00882FD6: dc.w $3340
        dc.w    $0030                    ; 00882FD8: dc.w $0030
        dc.w    $3340                    ; 00882FDA: dc.w $3340
        dc.w    $0044                    ; 00882FDC: dc.w $0044
        dc.w    $3540                    ; 00882FDE: dc.w $3540
        dc.w    $0134                    ; 00882FE0: dc.w $0134
        dc.w    $3540                    ; 00882FE2: dc.w $3540
        dc.w    $0148                    ; 00882FE4: dc.w $0148
        dc.w    $3540                    ; 00882FE6: dc.w $3540
        dc.w    $015C                    ; 00882FE8: dc.w $015C
        dc.w    $3238                    ; 00882FEA: dc.w $3238
        dc.w    $C088                    ; 00882FEC: dc.w $C088
        dc.w    $3028                    ; 00882FEE: dc.w $3028
        dc.w    $008E                    ; 00882FF0: dc.w $008E
        dc.w    $48C1                    ; 00882FF2: dc.w $48C1
        dc.w    $48C0                    ; 00882FF4: dc.w $48C0
        dc.w    $D081                    ; 00882FF6: dc.w $D081
        dc.w    $E280                    ; 00882FF8: dc.w $E280
        dc.w    $31C0                    ; 00882FFA: dc.w $31C0
        dc.w    $C088                    ; 00882FFC: dc.w $C088
        dc.w    $4440                    ; 00882FFE: dc.w $4440
        dc.w    $3200                    ; 00883000: dc.w $3200
        dc.w    $EE41                    ; 00883002: dc.w $EE41
        dc.w    $EC40                    ; 00883004: dc.w $EC40
        dc.w    $D041                    ; 00883006: dc.w $D041
        dc.w    $E340                    ; 00883008: dc.w $E340
        dc.w    $3340                    ; 0088300A: dc.w $3340
        dc.w    $0070                    ; 0088300C: dc.w $0070
        dc.w    $4E75                    ; 0088300E: RTS
        dc.w    $7000                    ; 00883010: MOVEQ #$00,D0
        dc.w    $4A68                    ; 00883012: dc.w $4A68
        dc.w    $00C0                    ; 00883014: dc.w $00C0
        dc.w    $6702                    ; 00883016: BEQ.S $0088301A
        dc.w    $7001                    ; 00883018: MOVEQ #$01,D0
        dc.w    $3540                    ; 0088301A: dc.w $3540
        dc.w    $0118                    ; 0088301C: dc.w $0118
        dc.w    $3540                    ; 0088301E: dc.w $3540
        dc.w    $012C                    ; 00883020: dc.w $012C
        dc.w    $3540                    ; 00883022: dc.w $3540
        dc.w    $0140                    ; 00883024: dc.w $0140
        dc.w    $3540                    ; 00883026: dc.w $3540
        dc.w    $0154                    ; 00883028: dc.w $0154
        dc.w    $3028                    ; 0088302A: dc.w $3028
        dc.w    $0030                    ; 0088302C: dc.w $0030
        dc.w    $3540                    ; 0088302E: dc.w $3540
        dc.w    $011A                    ; 00883030: dc.w $011A
        dc.w    $3028                    ; 00883032: dc.w $3028
        dc.w    $009C                    ; 00883034: dc.w $009C
        dc.w    $E940                    ; 00883036: dc.w $E940
        dc.w    $D078                    ; 00883038: dc.w $D078
        dc.w    $C0E4                    ; 0088303A: dc.w $C0E4
        dc.w    $D068                    ; 0088303C: dc.w $D068
        dc.w    $0032                    ; 0088303E: dc.w $0032
        dc.w    $3540                    ; 00883040: dc.w $3540
        dc.w    $011C                    ; 00883042: dc.w $011C
        dc.w    $3028                    ; 00883044: dc.w $3028
        dc.w    $0034                    ; 00883046: dc.w $0034
        dc.w    $3540                    ; 00883048: dc.w $3540
        dc.w    $011E                    ; 0088304A: dc.w $011E
        dc.w    $3228                    ; 0088304C: dc.w $3228
        dc.w    $003A                    ; 0088304E: dc.w $003A
        dc.w    $E641                    ; 00883050: dc.w $E641
        dc.w    $3028                    ; 00883052: dc.w $3028
        dc.w    $0044                    ; 00883054: dc.w $0044
        dc.w    $E640                    ; 00883056: dc.w $E640
        dc.w    $D041                    ; 00883058: dc.w $D041
        dc.w    $4440                    ; 0088305A: dc.w $4440
        dc.w    $3540                    ; 0088305C: dc.w $3540
        dc.w    $0120                    ; 0088305E: dc.w $0120
        dc.w    $3428                    ; 00883060: dc.w $3428
        dc.w    $003C                    ; 00883062: dc.w $003C
        dc.w    $D468                    ; 00883064: dc.w $D468
        dc.w    $0096                    ; 00883066: dc.w $0096
        dc.w    $E642                    ; 00883068: dc.w $E642
        dc.w    $3028                    ; 0088306A: dc.w $3028
        dc.w    $0046                    ; 0088306C: dc.w $0046
        dc.w    $E640                    ; 0088306E: dc.w $E640
        dc.w    $4440                    ; 00883070: dc.w $4440
        dc.w    $D042                    ; 00883072: dc.w $D042
        dc.w    $3540                    ; 00883074: dc.w $3540
        dc.w    $0122                    ; 00883076: dc.w $0122
        dc.w    $3628                    ; 00883078: dc.w $3628
        dc.w    $003E                    ; 0088307A: dc.w $003E
        dc.w    $E643                    ; 0088307C: dc.w $E643
        dc.w    $3028                    ; 0088307E: dc.w $3028
        dc.w    $004A                    ; 00883080: dc.w $004A
        dc.w    $D068                    ; 00883082: dc.w $D068
        dc.w    $004C                    ; 00883084: dc.w $004C
        dc.w    $EA40                    ; 00883086: dc.w $EA40
        dc.w    $D043                    ; 00883088: dc.w $D043
        dc.w    $4440                    ; 0088308A: dc.w $4440
        dc.w    $3540                    ; 0088308C: dc.w $3540
        dc.w    $0124                    ; 0088308E: dc.w $0124
        dc.w    $3028                    ; 00883090: dc.w $3028
        dc.w    $0090                    ; 00883092: dc.w $0090
        dc.w    $E640                    ; 00883094: dc.w $E640
        dc.w    $3340                    ; 00883096: dc.w $3340
        dc.w    $0032                    ; 00883098: dc.w $0032
        dc.w    $3340                    ; 0088309A: dc.w $3340
        dc.w    $0046                    ; 0088309C: dc.w $0046
        dc.w    $3540                    ; 0088309E: dc.w $3540
        dc.w    $0136                    ; 008830A0: dc.w $0136
        dc.w    $3540                    ; 008830A2: dc.w $3540
        dc.w    $014A                    ; 008830A4: dc.w $014A
        dc.w    $3028                    ; 008830A6: dc.w $3028
        dc.w    $00BC                    ; 008830A8: dc.w $00BC
        dc.w    $E640                    ; 008830AA: dc.w $E640
        dc.w    $3340                    ; 008830AC: dc.w $3340
        dc.w    $0030                    ; 008830AE: dc.w $0030
        dc.w    $3340                    ; 008830B0: dc.w $3340
        dc.w    $0044                    ; 008830B2: dc.w $0044
        dc.w    $3340                    ; 008830B4: dc.w $3340
        dc.w    $0058                    ; 008830B6: dc.w $0058
        dc.w    $3540                    ; 008830B8: dc.w $3540
        dc.w    $0134                    ; 008830BA: dc.w $0134
        dc.w    $3540                    ; 008830BC: dc.w $3540
        dc.w    $0148                    ; 008830BE: dc.w $0148
        dc.w    $3540                    ; 008830C0: dc.w $3540
        dc.w    $015C                    ; 008830C2: dc.w $015C
        dc.w    $4E75                    ; 008830C4: RTS
        dc.w    $0838                    ; 008830C6: dc.w $0838
        dc.w    $0005                    ; 008830C8: dc.w $0005
        dc.w    $C30E                    ; 008830CA: dc.w $C30E
        dc.w    $6746                    ; 008830CC: BEQ.S $00883114
        dc.w    $43F9, $00FF, $6100    ; 008830CE: LEA $00FF6100,A1
        dc.w    $3029                    ; 008830D4: dc.w $3029
        dc.w    $000A                    ; 008830D6: dc.w $000A
        dc.w    $9078                    ; 008830D8: dc.w $9078
        dc.w    $C0B0                    ; 008830DA: dc.w $C0B0
        dc.w    $323C                    ; 008830DC: dc.w $323C
        dc.w    $F000                    ; 008830DE: dc.w $F000
        dc.w    $B041                    ; 008830E0: dc.w $B041
        dc.w    $6F08                    ; 008830E2: BLE.S $008830EC
        dc.w    $0678                    ; 008830E4: dc.w $0678
        dc.w    $0040                    ; 008830E6: dc.w $0040
        dc.w    $C0B0                    ; 008830E8: dc.w $C0B0
        dc.w    $3200                    ; 008830EA: dc.w $3200
        dc.w    $3341                    ; 008830EC: dc.w $3341
        dc.w    $000A                    ; 008830EE: dc.w $000A
        dc.w    $3038                    ; 008830F0: dc.w $3038
        dc.w    $C056                    ; 008830F2: dc.w $C056
        dc.w    $323C                    ; 008830F4: dc.w $323C
        dc.w    $0280                    ; 008830F6: dc.w $0280
        dc.w    $4A78                    ; 008830F8: dc.w $4A78
        dc.w    $C8C8                    ; 008830FA: dc.w $C8C8
        dc.w    $6704                    ; 008830FC: BEQ.S $00883102
        dc.w    $323C                    ; 008830FE: dc.w $323C
        dc.w    $0350                    ; 00883100: dc.w $0350
        dc.w    $B041                    ; 00883102: dc.w $B041
        dc.w    $6F0A                    ; 00883104: BLE.S $00883110
        dc.w    $0478                    ; 00883106: dc.w $0478
        dc.w    $0010                    ; 00883108: dc.w $0010
        dc.w    $C056                    ; 0088310A: dc.w $C056
        dc.w    $3238                    ; 0088310C: dc.w $3238
        dc.w    $C056                    ; 0088310E: dc.w $C056
        dc.w    $31C1                    ; 00883110: dc.w $31C1
        dc.w    $C056                    ; 00883112: dc.w $C056
        dc.w    $4E75                    ; 00883114: RTS
        dc.w    $0838                    ; 00883116: dc.w $0838
        dc.w    $0005                    ; 00883118: dc.w $0005
        dc.w    $C30E                    ; 0088311A: dc.w $C30E
        dc.w    $6706                    ; 0088311C: BEQ.S $00883124
        dc.w    $0678                    ; 0088311E: dc.w $0678
        dc.w    $0040                    ; 00883120: dc.w $0040
        dc.w    $C0B0                    ; 00883122: dc.w $C0B0
        dc.w    $4E75                    ; 00883124: RTS
        dc.w    $41F8                    ; 00883126: dc.w $41F8
        dc.w    $9000                    ; 00883128: dc.w $9000
        dc.w    $43F9, $00FF, $6100    ; 0088312A: LEA $00FF6100,A1
        dc.w    $3378                    ; 00883130: dc.w $3378
        dc.w    $C086                    ; 00883132: dc.w $C086
        dc.w    $0002                    ; 00883134: dc.w $0002
        dc.w    $4EBA                    ; 00883136: dc.w $4EBA
        dc.w    $F85E                    ; 00883138: dc.w $F85E
        dc.w    $3038                    ; 0088313A: dc.w $3038
        dc.w    $C0AE                    ; 0088313C: dc.w $C0AE
        dc.w    $D169                    ; 0088313E: dc.w $D169
        dc.w    $0008                    ; 00883140: dc.w $0008
        dc.w    $3038                    ; 00883142: dc.w $3038
        dc.w    $C0B0                    ; 00883144: dc.w $C0B0
        dc.w    $D169                    ; 00883146: dc.w $D169
        dc.w    $000A                    ; 00883148: dc.w $000A
        dc.w    $3038                    ; 0088314A: dc.w $3038
        dc.w    $C0B2                    ; 0088314C: dc.w $C0B2
        dc.w    $D169                    ; 0088314E: dc.w $D169
        dc.w    $000C                    ; 00883150: dc.w $000C
        dc.w    $4A78                    ; 00883152: dc.w $4A78
        dc.w    $C8C8                    ; 00883154: dc.w $C8C8
        dc.w    $6706                    ; 00883156: BEQ.S $0088315E
        dc.w    $0669                    ; 00883158: dc.w $0669
        dc.w    $00E0                    ; 0088315A: dc.w $00E0
        dc.w    $0006                    ; 0088315C: dc.w $0006
        dc.w    $4E75                    ; 0088315E: RTS
        dc.w    $33FC                    ; 00883160: dc.w $33FC
        dc.w    $0001                    ; 00883162: dc.w $0001
        dc.w    $00FF                    ; 00883164: dc.w $00FF
        dc.w    $6100, $7070            ; 00883166: BSR.W $0088A1D8
        dc.w    $D078                    ; 0088316A: dc.w $D078
        dc.w    $C0C6                    ; 0088316C: dc.w $C0C6
        dc.w    $33C0                    ; 0088316E: dc.w $33C0
        dc.w    $00FF                    ; 00883170: dc.w $00FF
        dc.w    $60CE                    ; 00883172: BRA.S $00883142
        dc.w    $4A78                    ; 00883174: dc.w $4A78
        dc.w    $C0BA                    ; 00883176: dc.w $C0BA
        dc.w    $672A                    ; 00883178: BEQ.S $008831A4
        dc.w    $33FC                    ; 0088317A: dc.w $33FC
        dc.w    $0002                    ; 0088317C: dc.w $0002
        dc.w    $00FF                    ; 0088317E: dc.w $00FF
        dc.w    $6100, $43F8            ; 00883180: BSR.W $0088757A
        dc.w    $C0BA                    ; 00883184: dc.w $C0BA
        dc.w    $45F9, $00FF, $6102    ; 00883186: LEA $00FF6102,A2
        dc.w    $34D9                    ; 0088318C: dc.w $34D9

; --- Low code utility ---
func_318E:
        dc.w    $34D9                    ; 0088318E: dc.w $34D9
        dc.w    $34D9                    ; 00883190: dc.w $34D9
        dc.w    $3019                    ; 00883192: dc.w $3019
        dc.w    $E640                    ; 00883194: dc.w $E640
        dc.w    $34C0                    ; 00883196: dc.w $34C0
        dc.w    $3019                    ; 00883198: dc.w $3019
        dc.w    $E640                    ; 0088319A: dc.w $E640
        dc.w    $34C0                    ; 0088319C: dc.w $34C0
        dc.w    $3019                    ; 0088319E: dc.w $3019
        dc.w    $E640                    ; 008831A0: dc.w $E640
        dc.w    $3480                    ; 008831A2: dc.w $3480
        dc.w    $4E75                    ; 008831A4: RTS
        dc.w    $7000                    ; 008831A6: MOVEQ #$00,D0
        dc.w    $1038                    ; 008831A8: dc.w $1038
        dc.w    $C305                    ; 008831AA: dc.w $C305
        dc.w    $227B                    ; 008831AC: dc.w $227B
        dc.w    $0004                    ; 008831AE: dc.w $0004
        dc.w    $4ED1                    ; 008831B0: JMP (A1)
        dc.w    $0088                    ; 008831B2: dc.w $0088
        dc.w    $3378                    ; 008831B4: dc.w $3378
        dc.w    $0088                    ; 008831B6: dc.w $0088
        dc.w    $3272                    ; 008831B8: dc.w $3272
        dc.w    $0088                    ; 008831BA: dc.w $0088
        dc.w    $31DE                    ; 008831BC: dc.w $31DE
        dc.w    $0088                    ; 008831BE: dc.w $0088
        dc.w    $31DE                    ; 008831C0: dc.w $31DE
        dc.w    $0088                    ; 008831C2: dc.w $0088
        dc.w    $31DE                    ; 008831C4: dc.w $31DE
        dc.w    $0088                    ; 008831C6: dc.w $0088
        dc.w    $31DE                    ; 008831C8: dc.w $31DE
        dc.w    $0088                    ; 008831CA: dc.w $0088
        dc.w    $322A                    ; 008831CC: dc.w $322A
        dc.w    $0088                    ; 008831CE: dc.w $0088
        dc.w    $322A                    ; 008831D0: dc.w $322A
        dc.w    $0088                    ; 008831D2: dc.w $0088
        dc.w    $322A                    ; 008831D4: dc.w $322A
        dc.w    $0088                    ; 008831D6: dc.w $0088
        dc.w    $3204                    ; 008831D8: dc.w $3204
        dc.w    $0088                    ; 008831DA: dc.w $0088
        dc.w    $3250                    ; 008831DC: dc.w $3250
        dc.w    $4A78                    ; 008831DE: dc.w $4A78
        dc.w    $C04E                    ; 008831E0: dc.w $C04E
        dc.w    $676C                    ; 008831E2: BEQ.S $00883250
        dc.w    $2278                    ; 008831E4: dc.w $2278
        dc.w    $C258                    ; 008831E6: dc.w $C258
        dc.w    $137C                    ; 008831E8: dc.w $137C
        dc.w    $0002                    ; 008831EA: dc.w $0002
        dc.w    $0000                    ; 008831EC: dc.w $0000
        dc.w    $13FC                    ; 008831EE: dc.w $13FC
        dc.w    $0003                    ; 008831F0: dc.w $0003
        dc.w    $00FF                    ; 008831F2: dc.w $00FF
        dc.w    $6950                    ; 008831F4: BVS.S $00883246
        dc.w    $13FC                    ; 008831F6: dc.w $13FC
        dc.w    $0001                    ; 008831F8: dc.w $0001
        dc.w    $00FF                    ; 008831FA: dc.w $00FF
        dc.w    $6940                    ; 008831FC: BVS.S $0088323E
        dc.w    $5838                    ; 008831FE: dc.w $5838
        dc.w    $C305                    ; 00883200: dc.w $C305
        dc.w    $4E75                    ; 00883202: RTS
        dc.w    $5338                    ; 00883204: dc.w $5338
        dc.w    $C308                    ; 00883206: dc.w $C308
        dc.w    $661A                    ; 00883208: BNE.S $00883224
        dc.w    $3038                    ; 0088320A: dc.w $3038
        dc.w    $C08E                    ; 0088320C: dc.w $C08E
        dc.w    $B078                    ; 0088320E: dc.w $B078
        dc.w    $C07A                    ; 00883210: dc.w $C07A
        dc.w    $6710                    ; 00883212: BEQ.S $00883224
        dc.w    $3028                    ; 00883214: dc.w $3028
        dc.w    $002C                    ; 00883216: dc.w $002C
        dc.w    $43F9, $0089, $89EE    ; 00883218: LEA $008989EE,A1
        dc.w    $11F1                    ; 0088321E: dc.w $11F1
        dc.w    $0000                    ; 00883220: dc.w $0000
        dc.w    $C8A5                    ; 00883222: dc.w $C8A5
        dc.w    $11FC                    ; 00883224: dc.w $11FC
        dc.w    $0004                    ; 00883226: dc.w $0004
        dc.w    $C305                    ; 00883228: dc.w $C305
        dc.w    $4A78                    ; 0088322A: dc.w $4A78
        dc.w    $C04E                    ; 0088322C: dc.w $C04E
        dc.w    $6720                    ; 0088322E: BEQ.S $00883250
        dc.w    $2278                    ; 00883230: dc.w $2278
        dc.w    $C258                    ; 00883232: dc.w $C258
        dc.w    $137C                    ; 00883234: dc.w $137C
        dc.w    $0000                    ; 00883236: dc.w $0000
        dc.w    $0000                    ; 00883238: dc.w $0000
        dc.w    $13FC                    ; 0088323A: dc.w $13FC
        dc.w    $0000                    ; 0088323C: dc.w $0000
        dc.w    $00FF                    ; 0088323E: dc.w $00FF
        dc.w    $6940                    ; 00883240: BVS.S $00883282
        dc.w    $13FC                    ; 00883242: dc.w $13FC
        dc.w    $0000                    ; 00883244: dc.w $0000
        dc.w    $00FF                    ; 00883246: dc.w $00FF
        dc.w    $6950                    ; 00883248: BVS.S $0088329A
        dc.w    $5838                    ; 0088324A: dc.w $5838
        dc.w    $C305                    ; 0088324C: dc.w $C305
        dc.w    $4E75                    ; 0088324E: RTS
        dc.w    $2278                    ; 00883250: dc.w $2278
        dc.w    $C258                    ; 00883252: dc.w $C258
        dc.w    $137C                    ; 00883254: dc.w $137C
        dc.w    $0002                    ; 00883256: dc.w $0002
        dc.w    $0000                    ; 00883258: dc.w $0000
        dc.w    $13FC                    ; 0088325A: dc.w $13FC
        dc.w    $0000                    ; 0088325C: dc.w $0000
        dc.w    $00FF                    ; 0088325E: dc.w $00FF
        dc.w    $6940                    ; 00883260: BVS.S $008832A2
        dc.w    $13FC                    ; 00883262: dc.w $13FC
        dc.w    $0000                    ; 00883264: dc.w $0000
        dc.w    $00FF                    ; 00883266: dc.w $00FF
        dc.w    $6950                    ; 00883268: BVS.S $008832BA
        dc.w    $11FC                    ; 0088326A: dc.w $11FC
        dc.w    $0000                    ; 0088326C: dc.w $0000
        dc.w    $C305                    ; 0088326E: dc.w $C305
        dc.w    $4E75                    ; 00883270: RTS
        dc.w    $11FC                    ; 00883272: dc.w $11FC
        dc.w    $0002                    ; 00883274: dc.w $0002
        dc.w    $C308                    ; 00883276: dc.w $C308
        dc.w    $7000                    ; 00883278: MOVEQ #$00,D0
        dc.w    $43F9, $00FF, $68D0    ; 0088327A: LEA $00FF68D0,A1
        dc.w    $3028                    ; 00883280: dc.w $3028
        dc.w    $002C                    ; 00883282: dc.w $002C
        dc.w    $5340                    ; 00883284: dc.w $5340
        dc.w    $E948                    ; 00883286: dc.w $E948
        dc.w    $D3C0                    ; 00883288: dc.w $D3C0
        dc.w    $21C9                    ; 0088328A: dc.w $21C9
        dc.w    $C258                    ; 0088328C: dc.w $C258
        dc.w    $137C                    ; 0088328E: dc.w $137C
        dc.w    $0002                    ; 00883290: dc.w $0002
        dc.w    $0000                    ; 00883292: dc.w $0000
        dc.w    $13FC                    ; 00883294: dc.w $13FC
        dc.w    $0003                    ; 00883296: dc.w $0003
        dc.w    $00FF                    ; 00883298: dc.w $00FF
        dc.w    $6950                    ; 0088329A: BVS.S $008832EC
        dc.w    $3478                    ; 0088329C: dc.w $3478
        dc.w    $C076                    ; 0088329E: dc.w $C076
        dc.w    $7000                    ; 008832A0: MOVEQ #$00,D0
        dc.w    $1038                    ; 008832A2: dc.w $1038
        dc.w    $C806                    ; 008832A4: dc.w $C806
        dc.w    $11FC                    ; 008832A6: dc.w $11FC
        dc.w    $0000                    ; 008832A8: dc.w $0000
        dc.w    $C806                    ; 008832AA: dc.w $C806
        dc.w    $D040                    ; 008832AC: dc.w $D040
        dc.w    $47F9, $0089, $9884    ; 008832AE: LEA $00899884,A3
        dc.w    $3033                    ; 008832B4: dc.w $3033
        dc.w    $0000                    ; 008832B6: dc.w $0000
        dc.w    $14C0                    ; 008832B8: dc.w $14C0
        dc.w    $7000                    ; 008832BA: MOVEQ #$00,D0
        dc.w    $1038                    ; 008832BC: dc.w $1038
        dc.w    $C807                    ; 008832BE: dc.w $C807
        dc.w    $11FC                    ; 008832C0: dc.w $11FC
        dc.w    $00C4                    ; 008832C2: dc.w $00C4
        dc.w    $C807                    ; 008832C4: dc.w $C807
        dc.w    $0400                    ; 008832C6: dc.w $0400
        dc.w    $00C4                    ; 008832C8: dc.w $00C4
        dc.w    $D040                    ; 008832CA: dc.w $D040
        dc.w    $47F9, $0089, $9884    ; 008832CC: LEA $00899884,A3
        dc.w    $3033                    ; 008832D2: dc.w $3033
        dc.w    $0000                    ; 008832D4: dc.w $0000
        dc.w    $14C0                    ; 008832D6: dc.w $14C0
        dc.w    $7000                    ; 008832D8: MOVEQ #$00,D0
        dc.w    $1038                    ; 008832DA: dc.w $1038
        dc.w    $C808                    ; 008832DC: dc.w $C808
        dc.w    $11FC                    ; 008832DE: dc.w $11FC
        dc.w    $00C4                    ; 008832E0: dc.w $00C4
        dc.w    $C808                    ; 008832E2: dc.w $C808
        dc.w    $0400                    ; 008832E4: dc.w $0400
        dc.w    $00C4                    ; 008832E6: dc.w $00C4
        dc.w    $D040                    ; 008832E8: dc.w $D040
        dc.w    $47F9, $0089, $980C    ; 008832EA: LEA $0089980C,A3
        dc.w    $3033                    ; 008832F0: dc.w $3033
        dc.w    $0000                    ; 008832F2: dc.w $0000
        dc.w    $34C0                    ; 008832F4: dc.w $34C0
        dc.w    $31CA                    ; 008832F6: dc.w $31CA
        dc.w    $C076                    ; 008832F8: dc.w $C076
        dc.w    $4EB9, $0088, $B2E4    ; 008832FA: JSR $0088B2E4
        dc.w    $4EB9, $0088, $B422    ; 00883300: JSR $0088B422
        dc.w    $598A                    ; 00883306: dc.w $598A
        dc.w    $2012                    ; 00883308: dc.w $2012
        dc.w    $23FC, $222E, $070C, $00FF, $6948  ; 0088330A: MOVE.L #$222E070C,$00FF6948
        dc.w    $11FC                    ; 00883314: dc.w $11FC
        dc.w    $0000                    ; 00883316: dc.w $0000
        dc.w    $C30B                    ; 00883318: dc.w $C30B
        dc.w    $B0B8                    ; 0088331A: dc.w $B0B8
        dc.w    $C254                    ; 0088331C: dc.w $C254
        dc.w    $6C3C                    ; 0088331E: BGE.S $0088335C
        dc.w    $21C0                    ; 00883320: dc.w $21C0
        dc.w    $C254                    ; 00883322: dc.w $C254
        dc.w    $7000                    ; 00883324: MOVEQ #$00,D0
        dc.w    $43F9, $00FF, $68D1    ; 00883326: LEA $00FF68D1,A1
        dc.w    $1038                    ; 0088332C: dc.w $1038
        dc.w    $C307                    ; 0088332E: dc.w $C307
        dc.w    $45F1                    ; 00883330: dc.w $45F1
        dc.w    $0000                    ; 00883332: dc.w $0000
        dc.w    $14BC                    ; 00883334: dc.w $14BC
        dc.w    $0000                    ; 00883336: dc.w $0000
        dc.w    $3028                    ; 00883338: dc.w $3028
        dc.w    $002C                    ; 0088333A: dc.w $002C
        dc.w    $5340                    ; 0088333C: dc.w $5340
        dc.w    $E948                    ; 0088333E: dc.w $E948
        dc.w    $11C0                    ; 00883340: dc.w $11C0
        dc.w    $C307                    ; 00883342: dc.w $C307
        dc.w    $45F1                    ; 00883344: dc.w $45F1
        dc.w    $0000                    ; 00883346: dc.w $0000
        dc.w    $14BC                    ; 00883348: dc.w $14BC
        dc.w    $0001                    ; 0088334A: dc.w $0001
        dc.w    $23FC, $222D, $FB7C, $00FF, $6948  ; 0088334C: MOVE.L #$222DFB7C,$00FF6948
        dc.w    $11FC                    ; 00883356: dc.w $11FC
        dc.w    $0001                    ; 00883358: dc.w $0001
        dc.w    $C30B                    ; 0088335A: dc.w $C30B
        dc.w    $13FC                    ; 0088335C: dc.w $13FC
        dc.w    $0001                    ; 0088335E: dc.w $0001
        dc.w    $00FF                    ; 00883360: dc.w $00FF
        dc.w    $6940                    ; 00883362: BVS.S $008833A4
        dc.w    $1038                    ; 00883364: dc.w $1038
        dc.w    $C8AB                    ; 00883366: dc.w $C8AB
        dc.w    $0200                    ; 00883368: dc.w $0200
        dc.w    $0003                    ; 0088336A: dc.w $0003
        dc.w    $D000                    ; 0088336C: dc.w $D000
        dc.w    $D000                    ; 0088336E: dc.w $D000
        dc.w    $0600                    ; 00883370: dc.w $0600
        dc.w    $000C                    ; 00883372: dc.w $000C
        dc.w    $11C0                    ; 00883374: dc.w $11C0
        dc.w    $C305                    ; 00883376: dc.w $C305
        dc.w    $4E75                    ; 00883378: RTS
        dc.w    $7000                    ; 0088337A: MOVEQ #$00,D0
        dc.w    $1038                    ; 0088337C: dc.w $1038
        dc.w    $C305                    ; 0088337E: dc.w $C305
        dc.w    $227B                    ; 00883380: dc.w $227B
        dc.w    $0004                    ; 00883382: dc.w $0004
        dc.w    $4ED1                    ; 00883384: JMP (A1)
        dc.w    $0088                    ; 00883386: dc.w $0088
        dc.w    $34E6                    ; 00883388: dc.w $34E6
        dc.w    $0088                    ; 0088338A: dc.w $0088
        dc.w    $3404                    ; 0088338C: dc.w $3404
        dc.w    $0088                    ; 0088338E: dc.w $0088
        dc.w    $33C2                    ; 00883390: dc.w $33C2
        dc.w    $0088                    ; 00883392: dc.w $0088
        dc.w    $33C2                    ; 00883394: dc.w $33C2
        dc.w    $0088                    ; 00883396: dc.w $0088
        dc.w    $33C2                    ; 00883398: dc.w $33C2
        dc.w    $0088                    ; 0088339A: dc.w $0088
        dc.w    $33C2                    ; 0088339C: dc.w $33C2
        dc.w    $0088                    ; 0088339E: dc.w $0088
        dc.w    $33C2                    ; 008833A0: dc.w $33C2
        dc.w    $0088                    ; 008833A2: dc.w $0088
        dc.w    $33C2                    ; 008833A4: dc.w $33C2
        dc.w    $0088                    ; 008833A6: dc.w $0088
        dc.w    $33C2                    ; 008833A8: dc.w $33C2
        dc.w    $0088                    ; 008833AA: dc.w $0088
        dc.w    $33C2                    ; 008833AC: dc.w $33C2
        dc.w    $0088                    ; 008833AE: dc.w $0088
        dc.w    $33C2                    ; 008833B0: dc.w $33C2
        dc.w    $0088                    ; 008833B2: dc.w $0088
        dc.w    $33C2                    ; 008833B4: dc.w $33C2
        dc.w    $0088                    ; 008833B6: dc.w $0088
        dc.w    $33EC                    ; 008833B8: dc.w $33EC
        dc.w    $0088                    ; 008833BA: dc.w $0088
        dc.w    $33FC                    ; 008833BC: dc.w $33FC
        dc.w    $0088                    ; 008833BE: dc.w $0088
        dc.w    $34CA                    ; 008833C0: dc.w $34CA
        dc.w    $3038                    ; 008833C2: dc.w $3038
        dc.w    $C08E                    ; 008833C4: dc.w $C08E
        dc.w    $B078                    ; 008833C6: dc.w $B078
        dc.w    $C07A                    ; 008833C8: dc.w $C07A
        dc.w    $6718                    ; 008833CA: BEQ.S $008833E4
        dc.w    $5838                    ; 008833CC: dc.w $5838
        dc.w    $C305                    ; 008833CE: dc.w $C305
        dc.w    $3028                    ; 008833D0: dc.w $3028
        dc.w    $002C                    ; 008833D2: dc.w $002C
        dc.w    $5340                    ; 008833D4: dc.w $5340
        dc.w    $B038                    ; 008833D6: dc.w $B038
        dc.w    $C310                    ; 008833D8: dc.w $C310
        dc.w    $6606                    ; 008833DA: BNE.S $008833E2
        dc.w    $11FC                    ; 008833DC: dc.w $11FC
        dc.w    $0030                    ; 008833DE: dc.w $0030
        dc.w    $C305                    ; 008833E0: dc.w $C305
        dc.w    $4E75                    ; 008833E2: RTS
        dc.w    $11FC                    ; 008833E4: dc.w $11FC
        dc.w    $0034                    ; 008833E6: dc.w $0034
        dc.w    $C305                    ; 008833E8: dc.w $C305
        dc.w    $4E75                    ; 008833EA: RTS
        dc.w    $3028                    ; 008833EC: dc.w $3028
        dc.w    $002C                    ; 008833EE: dc.w $002C
        dc.w    $43F9, $0089, $89EE    ; 008833F0: LEA $008989EE,A1
        dc.w    $11F1                    ; 008833F6: dc.w $11F1
        dc.w    $0000                    ; 008833F8: dc.w $0000
        dc.w    $C8A5                    ; 008833FA: dc.w $C8A5
        dc.w    $11FC                    ; 008833FC: dc.w $11FC
        dc.w    $0000                    ; 008833FE: dc.w $0000
        dc.w    $C305                    ; 00883400: dc.w $C305
        dc.w    $4E75                    ; 00883402: RTS
        dc.w    $43F8                    ; 00883404: dc.w $43F8
        dc.w    $C806                    ; 00883406: dc.w $C806
        dc.w    $B0FC                    ; 00883408: dc.w $B0FC
        dc.w    $9000                    ; 0088340A: dc.w $9000
        dc.w    $6704                    ; 0088340C: BEQ.S $00883412
        dc.w    $43F8                    ; 0088340E: dc.w $43F8
        dc.w    $C813                    ; 00883410: dc.w $C813
        dc.w    $3478                    ; 00883412: dc.w $3478
        dc.w    $C076                    ; 00883414: dc.w $C076
        dc.w    $7000                    ; 00883416: MOVEQ #$00,D0
        dc.w    $1011                    ; 00883418: dc.w $1011
        dc.w    $12BC                    ; 0088341A: dc.w $12BC
        dc.w    $0000                    ; 0088341C: dc.w $0000
        dc.w    $D040                    ; 0088341E: dc.w $D040
        dc.w    $47F9, $0089, $9884    ; 00883420: LEA $00899884,A3
        dc.w    $3033                    ; 00883426: dc.w $3033
        dc.w    $0000                    ; 00883428: dc.w $0000
        dc.w    $14C0                    ; 0088342A: dc.w $14C0
        dc.w    $7000                    ; 0088342C: MOVEQ #$00,D0
        dc.w    $1029                    ; 0088342E: dc.w $1029
        dc.w    $0001                    ; 00883430: dc.w $0001
        dc.w    $137C                    ; 00883432: dc.w $137C
        dc.w    $00C4                    ; 00883434: dc.w $00C4
        dc.w    $0001                    ; 00883436: dc.w $0001
        dc.w    $0400                    ; 00883438: dc.w $0400
        dc.w    $00C4                    ; 0088343A: dc.w $00C4
        dc.w    $D040                    ; 0088343C: dc.w $D040
        dc.w    $47F9, $0089, $9884    ; 0088343E: LEA $00899884,A3
        dc.w    $3033                    ; 00883444: dc.w $3033
        dc.w    $0000                    ; 00883446: dc.w $0000
        dc.w    $14C0                    ; 00883448: dc.w $14C0
        dc.w    $7000                    ; 0088344A: MOVEQ #$00,D0

; --- Low code utility ---
func_344C:
        dc.w    $1029                    ; 0088344C: dc.w $1029
        dc.w    $0002                    ; 0088344E: dc.w $0002
        dc.w    $137C                    ; 00883450: dc.w $137C
        dc.w    $00C4                    ; 00883452: dc.w $00C4
        dc.w    $0002                    ; 00883454: dc.w $0002
        dc.w    $0400                    ; 00883456: dc.w $0400
        dc.w    $00C4                    ; 00883458: dc.w $00C4
        dc.w    $D040                    ; 0088345A: dc.w $D040
        dc.w    $47F9, $0089, $980C    ; 0088345C: LEA $0089980C,A3
        dc.w    $3033                    ; 00883462: dc.w $3033
        dc.w    $0000                    ; 00883464: dc.w $0000
        dc.w    $34C0                    ; 00883466: dc.w $34C0
        dc.w    $31CA                    ; 00883468: dc.w $31CA
        dc.w    $C076                    ; 0088346A: dc.w $C076
        dc.w    $4EBA                    ; 0088346C: dc.w $4EBA
        dc.w    $7E76                    ; 0088346E: MOVEQ #$76,D7
        dc.w    $598A                    ; 00883470: dc.w $598A
        dc.w    $2012                    ; 00883472: dc.w $2012
        dc.w    $B0B8                    ; 00883474: dc.w $B0B8
        dc.w    $C254                    ; 00883476: dc.w $C254
        dc.w    $6C32                    ; 00883478: BGE.S $008834AC
        dc.w    $21C0                    ; 0088347A: dc.w $21C0
        dc.w    $C254                    ; 0088347C: dc.w $C254
        dc.w    $3028                    ; 0088347E: dc.w $3028
        dc.w    $002C                    ; 00883480: dc.w $002C
        dc.w    $5340                    ; 00883482: dc.w $5340
        dc.w    $E948                    ; 00883484: dc.w $E948
        dc.w    $11C0                    ; 00883486: dc.w $11C0
        dc.w    $C307                    ; 00883488: dc.w $C307
        dc.w    $43F8                    ; 0088348A: dc.w $43F8
        dc.w    $C254                    ; 0088348C: dc.w $C254
        dc.w    $47F9, $00FF, $68E8    ; 0088348E: LEA $00FF68E8,A3
        dc.w    $B0FC                    ; 00883494: dc.w $B0FC
        dc.w    $9000                    ; 00883496: dc.w $9000
        dc.w    $6706                    ; 00883498: BEQ.S $008834A0
        dc.w    $47F9, $00FF, $6968    ; 0088349A: LEA $00FF6968,A3
        dc.w    $177C                    ; 008834A0: dc.w $177C
        dc.w    $0002                    ; 008834A2: dc.w $0002
        dc.w    $FFF8                    ; 008834A4: dc.w $FFF8
        dc.w    $4EB9, $0088, $B43C    ; 008834A6: JSR $0088B43C
        dc.w    $0838                    ; 008834AC: dc.w $0838
        dc.w    $0005                    ; 008834AE: dc.w $0005
        dc.w    $C30E                    ; 008834B0: dc.w $C30E
        dc.w    $660C                    ; 008834B2: BNE.S $008834C0
        dc.w    $4A38                    ; 008834B4: dc.w $4A38
        dc.w    $C819                    ; 008834B6: dc.w $C819
        dc.w    $6718                    ; 008834B8: BEQ.S $008834D2
        dc.w    $31F8                    ; 008834BA: dc.w $31F8
        dc.w    $C098                    ; 008834BC: dc.w $C098
        dc.w    $C07A                    ; 008834BE: dc.w $C07A
        dc.w    $31FC                    ; 008834C0: dc.w $31FC
        dc.w    $0004                    ; 008834C2: dc.w $0004
        dc.w    $C07C                    ; 008834C4: dc.w $C07C
        dc.w    $5238                    ; 008834C6: dc.w $5238
        dc.w    $C819                    ; 008834C8: dc.w $C819
        dc.w    $11FC                    ; 008834CA: dc.w $11FC
        dc.w    $0038                    ; 008834CC: dc.w $0038
        dc.w    $C305                    ; 008834CE: dc.w $C305
        dc.w    $4E75                    ; 008834D0: RTS
        dc.w    $1038                    ; 008834D2: dc.w $1038
        dc.w    $C8AB                    ; 008834D4: dc.w $C8AB
        dc.w    $0200                    ; 008834D6: dc.w $0200
        dc.w    $0003                    ; 008834D8: dc.w $0003
        dc.w    $D000                    ; 008834DA: dc.w $D000
        dc.w    $D000                    ; 008834DC: dc.w $D000
        dc.w    $0600                    ; 008834DE: dc.w $0600
        dc.w    $000C                    ; 008834E0: dc.w $000C
        dc.w    $11C0                    ; 008834E2: dc.w $11C0
        dc.w    $C305                    ; 008834E4: dc.w $C305
        dc.w    $4E75                    ; 008834E6: RTS
        dc.w    $7000                    ; 008834E8: MOVEQ #$00,D0
        dc.w    $1038                    ; 008834EA: dc.w $1038
        dc.w    $C305                    ; 008834EC: dc.w $C305
        dc.w    $227B                    ; 008834EE: dc.w $227B
        dc.w    $0004                    ; 008834F0: dc.w $0004
        dc.w    $4ED1                    ; 008834F2: JMP (A1)
        dc.w    $0088                    ; 008834F4: dc.w $0088
        dc.w    $36DC                    ; 008834F6: dc.w $36DC
        dc.w    $0088                    ; 008834F8: dc.w $0088
        dc.w    $35B4                    ; 008834FA: dc.w $35B4
        dc.w    $0088                    ; 008834FC: dc.w $0088
        dc.w    $3524                    ; 008834FE: dc.w $3524
        dc.w    $0088                    ; 00883500: dc.w $0088
        dc.w    $3524                    ; 00883502: dc.w $3524
        dc.w    $0088                    ; 00883504: dc.w $0088
        dc.w    $3524                    ; 00883506: dc.w $3524
        dc.w    $0088                    ; 00883508: dc.w $0088
        dc.w    $3524                    ; 0088350A: dc.w $3524
        dc.w    $0088                    ; 0088350C: dc.w $0088
        dc.w    $3580                    ; 0088350E: dc.w $3580
        dc.w    $0088                    ; 00883510: dc.w $0088
        dc.w    $3580                    ; 00883512: dc.w $3580
        dc.w    $0088                    ; 00883514: dc.w $0088
        dc.w    $3580                    ; 00883516: dc.w $3580
        dc.w    $0088                    ; 00883518: dc.w $0088
        dc.w    $3540                    ; 0088351A: dc.w $3540
        dc.w    $0088                    ; 0088351C: dc.w $0088
        dc.w    $359C                    ; 0088351E: dc.w $359C
        dc.w    $0088                    ; 00883520: dc.w $0088
        dc.w    $36C0                    ; 00883522: dc.w $36C0
        dc.w    $4A78                    ; 00883524: dc.w $4A78
        dc.w    $C04E                    ; 00883526: dc.w $C04E
        dc.w    $6772                    ; 00883528: BEQ.S $0088359C
        dc.w    $13FC                    ; 0088352A: dc.w $13FC
        dc.w    $0003                    ; 0088352C: dc.w $0003
        dc.w    $00FF                    ; 0088352E: dc.w $00FF
        dc.w    $6950                    ; 00883530: BVS.S $00883582
        dc.w    $13FC                    ; 00883532: dc.w $13FC
        dc.w    $0001                    ; 00883534: dc.w $0001
        dc.w    $00FF                    ; 00883536: dc.w $00FF
        dc.w    $6940                    ; 00883538: BVS.S $0088357A
        dc.w    $5838                    ; 0088353A: dc.w $5838
        dc.w    $C305                    ; 0088353C: dc.w $C305
        dc.w    $4E75                    ; 0088353E: RTS
        dc.w    $5338                    ; 00883540: dc.w $5338
        dc.w    $C308                    ; 00883542: dc.w $C308
        dc.w    $6634                    ; 00883544: BNE.S $0088357A
        dc.w    $3038                    ; 00883546: dc.w $3038
        dc.w    $C08E                    ; 00883548: dc.w $C08E
        dc.w    $B078                    ; 0088354A: dc.w $B078
        dc.w    $C07A                    ; 0088354C: dc.w $C07A
        dc.w    $672A                    ; 0088354E: BEQ.S $0088357A
        dc.w    $0838                    ; 00883550: dc.w $0838
        dc.w    $0005                    ; 00883552: dc.w $0005
        dc.w    $C30E                    ; 00883554: dc.w $C30E
        dc.w    $6622                    ; 00883556: BNE.S $0088357A
        dc.w    $3028                    ; 00883558: dc.w $3028
        dc.w    $002C                    ; 0088355A: dc.w $002C
        dc.w    $43F9, $0089, $89EE    ; 0088355C: LEA $008989EE,A1
        dc.w    $11F1                    ; 00883562: dc.w $11F1
        dc.w    $0000                    ; 00883564: dc.w $0000
        dc.w    $C8A5                    ; 00883566: dc.w $C8A5
        dc.w    $0CB9                    ; 00883568: dc.w $0CB9
        dc.w    $222E                    ; 0088356A: dc.w $222E
        dc.w    $0508                    ; 0088356C: dc.w $0508
        dc.w    $00FF                    ; 0088356E: dc.w $00FF
        dc.w    $6948                    ; 00883570: BVS.S $008835BA
        dc.w    $6606                    ; 00883572: BNE.S $0088357A
        dc.w    $11FC                    ; 00883574: dc.w $11FC
        dc.w    $0097                    ; 00883576: dc.w $0097
        dc.w    $C8A5                    ; 00883578: dc.w $C8A5
        dc.w    $11FC                    ; 0088357A: dc.w $11FC
        dc.w    $0004                    ; 0088357C: dc.w $0004
        dc.w    $C305                    ; 0088357E: dc.w $C305
        dc.w    $4A78                    ; 00883580: dc.w $4A78
        dc.w    $C04E                    ; 00883582: dc.w $C04E
        dc.w    $6716                    ; 00883584: BEQ.S $0088359C
        dc.w    $13FC                    ; 00883586: dc.w $13FC
        dc.w    $0000                    ; 00883588: dc.w $0000
        dc.w    $00FF                    ; 0088358A: dc.w $00FF
        dc.w    $6940                    ; 0088358C: BVS.S $008835CE
        dc.w    $13FC                    ; 0088358E: dc.w $13FC
        dc.w    $0000                    ; 00883590: dc.w $0000
        dc.w    $00FF                    ; 00883592: dc.w $00FF
        dc.w    $6950                    ; 00883594: BVS.S $008835E6
        dc.w    $5838                    ; 00883596: dc.w $5838
        dc.w    $C305                    ; 00883598: dc.w $C305
        dc.w    $4E75                    ; 0088359A: RTS
        dc.w    $13FC                    ; 0088359C: dc.w $13FC
        dc.w    $0000                    ; 0088359E: dc.w $0000
        dc.w    $00FF                    ; 008835A0: dc.w $00FF
        dc.w    $6940                    ; 008835A2: BVS.S $008835E4
        dc.w    $13FC                    ; 008835A4: dc.w $13FC
        dc.w    $0000                    ; 008835A6: dc.w $0000
        dc.w    $00FF                    ; 008835A8: dc.w $00FF
        dc.w    $6950                    ; 008835AA: BVS.S $008835FC
        dc.w    $11FC                    ; 008835AC: dc.w $11FC
        dc.w    $0000                    ; 008835AE: dc.w $0000
        dc.w    $C305                    ; 008835B0: dc.w $C305
        dc.w    $4E75                    ; 008835B2: RTS
        dc.w    $11FC                    ; 008835B4: dc.w $11FC
        dc.w    $0001                    ; 008835B6: dc.w $0001
        dc.w    $C308                    ; 008835B8: dc.w $C308
        dc.w    $3028                    ; 008835BA: dc.w $3028
        dc.w    $002C                    ; 008835BC: dc.w $002C
        dc.w    $5240                    ; 008835BE: dc.w $5240
        dc.w    $B038                    ; 008835C0: dc.w $B038
        dc.w    $C310                    ; 008835C2: dc.w $C310
        dc.w    $6606                    ; 008835C4: BNE.S $008835CC
        dc.w    $11FC                    ; 008835C6: dc.w $11FC
        dc.w    $0002                    ; 008835C8: dc.w $0002
        dc.w    $C308                    ; 008835CA: dc.w $C308
        dc.w    $13FC                    ; 008835CC: dc.w $13FC
        dc.w    $0003                    ; 008835CE: dc.w $0003
        dc.w    $00FF                    ; 008835D0: dc.w $00FF
        dc.w    $6950                    ; 008835D2: BVS.S $00883624
        dc.w    $3478                    ; 008835D4: dc.w $3478
        dc.w    $C076                    ; 008835D6: dc.w $C076
        dc.w    $7000                    ; 008835D8: MOVEQ #$00,D0
        dc.w    $1038                    ; 008835DA: dc.w $1038
        dc.w    $C806                    ; 008835DC: dc.w $C806
        dc.w    $11FC                    ; 008835DE: dc.w $11FC
        dc.w    $0000                    ; 008835E0: dc.w $0000
        dc.w    $C806                    ; 008835E2: dc.w $C806
        dc.w    $D040                    ; 008835E4: dc.w $D040
        dc.w    $47F9, $0089, $9884    ; 008835E6: LEA $00899884,A3
        dc.w    $3033                    ; 008835EC: dc.w $3033
        dc.w    $0000                    ; 008835EE: dc.w $0000
        dc.w    $14C0                    ; 008835F0: dc.w $14C0
        dc.w    $7000                    ; 008835F2: MOVEQ #$00,D0
        dc.w    $1038                    ; 008835F4: dc.w $1038
        dc.w    $C807                    ; 008835F6: dc.w $C807
        dc.w    $11FC                    ; 008835F8: dc.w $11FC
        dc.w    $00C4                    ; 008835FA: dc.w $00C4
        dc.w    $C807                    ; 008835FC: dc.w $C807
        dc.w    $0400                    ; 008835FE: dc.w $0400
        dc.w    $00C4                    ; 00883600: dc.w $00C4
        dc.w    $D040                    ; 00883602: dc.w $D040
        dc.w    $47F9, $0089, $9884    ; 00883604: LEA $00899884,A3
        dc.w    $3033                    ; 0088360A: dc.w $3033
        dc.w    $0000                    ; 0088360C: dc.w $0000
        dc.w    $14C0                    ; 0088360E: dc.w $14C0
        dc.w    $7000                    ; 00883610: MOVEQ #$00,D0
        dc.w    $1038                    ; 00883612: dc.w $1038
        dc.w    $C808                    ; 00883614: dc.w $C808
        dc.w    $11FC                    ; 00883616: dc.w $11FC
        dc.w    $00C4                    ; 00883618: dc.w $00C4
        dc.w    $C808                    ; 0088361A: dc.w $C808
        dc.w    $0400                    ; 0088361C: dc.w $0400
        dc.w    $00C4                    ; 0088361E: dc.w $00C4
        dc.w    $D040                    ; 00883620: dc.w $D040
        dc.w    $47F9, $0089, $980C    ; 00883622: LEA $0089980C,A3
        dc.w    $3033                    ; 00883628: dc.w $3033
        dc.w    $0000                    ; 0088362A: dc.w $0000
        dc.w    $34C0                    ; 0088362C: dc.w $34C0
        dc.w    $31CA                    ; 0088362E: dc.w $31CA
        dc.w    $C076                    ; 00883630: dc.w $C076
        dc.w    $4EBA                    ; 00883632: dc.w $4EBA
        dc.w    $7CB0                    ; 00883634: MOVEQ #$B0,D6
        dc.w    $4EBA                    ; 00883636: dc.w $4EBA
        dc.w    $7DD6                    ; 00883638: dc.w $7DD6
        dc.w    $598A                    ; 0088363A: dc.w $598A
        dc.w    $2012                    ; 0088363C: dc.w $2012
        dc.w    $23FC, $222E, $070C, $00FF, $6948  ; 0088363E: MOVE.L #$222E070C,$00FF6948
        dc.w    $B0B8                    ; 00883648: dc.w $B0B8
        dc.w    $C254                    ; 0088364A: dc.w $C254
        dc.w    $6C62                    ; 0088364C: BGE.S $008836B0
        dc.w    $21C0                    ; 0088364E: dc.w $21C0
        dc.w    $C254                    ; 00883650: dc.w $C254
        dc.w    $7200                    ; 00883652: MOVEQ #$00,D1
        dc.w    $3228                    ; 00883654: dc.w $3228
        dc.w    $002C                    ; 00883656: dc.w $002C
        dc.w    $5341                    ; 00883658: dc.w $5341
        dc.w    $E949                    ; 0088365A: dc.w $E949
        dc.w    $11C1                    ; 0088365C: dc.w $11C1
        dc.w    $C307                    ; 0088365E: dc.w $C307
        dc.w    $23FC, $222D, $FB7C, $00FF, $6948  ; 00883660: MOVE.L #$222DFB7C,$00FF6948
        dc.w    $43F8                    ; 0088366A: dc.w $43F8
        dc.w    $FDAA                    ; 0088366C: dc.w $FDAA
        dc.w    $3238                    ; 0088366E: dc.w $3238
        dc.w    $C89C                    ; 00883670: dc.w $C89C
        dc.w    $EB49                    ; 00883672: dc.w $EB49
        dc.w    $D278                    ; 00883674: dc.w $D278
        dc.w    $C8A0                    ; 00883676: dc.w $C8A0
        dc.w    $3438                    ; 00883678: dc.w $3438
        dc.w    $C8C8                    ; 0088367A: dc.w $C8C8
        dc.w    $E74A                    ; 0088367C: dc.w $E74A
        dc.w    $D478                    ; 0088367E: dc.w $D478
        dc.w    $C8CC                    ; 00883680: dc.w $C8CC
        dc.w    $D242                    ; 00883682: dc.w $D242
        dc.w    $43F1                    ; 00883684: dc.w $43F1
        dc.w    $1000                    ; 00883686: dc.w $1000
        dc.w    $B091                    ; 00883688: dc.w $B091
        dc.w    $6C24                    ; 0088368A: BGE.S $008836B0
        dc.w    $23FC, $222E, $0508, $00FF, $6948  ; 0088368C: MOVE.L #$222E0508,$00FF6948
        dc.w    $22C0                    ; 00883696: dc.w $22C0
        dc.w    $22F8                    ; 00883698: dc.w $22F8
        dc.w    $C270                    ; 0088369A: dc.w $C270
        dc.w    $22B8                    ; 0088369C: dc.w $22B8
        dc.w    $C274                    ; 0088369E: dc.w $C274
        dc.w    $43F9, $00FF, $6958    ; 008836A0: LEA $00FF6958,A1
        dc.w    $45F9, $00FF, $68E8    ; 008836A6: LEA $00FF68E8,A2
        dc.w    $24D9                    ; 008836AC: dc.w $24D9
        dc.w    $2491                    ; 008836AE: dc.w $2491
        dc.w    $13FC                    ; 008836B0: dc.w $13FC
        dc.w    $0001                    ; 008836B2: dc.w $0001
        dc.w    $00FF                    ; 008836B4: dc.w $00FF
        dc.w    $6940                    ; 008836B6: BVS.S $008836F8
        dc.w    $0838                    ; 008836B8: dc.w $0838
        dc.w    $0005                    ; 008836BA: dc.w $0005
        dc.w    $C30E                    ; 008836BC: dc.w $C30E
        dc.w    $6708                    ; 008836BE: BEQ.S $008836C8
        dc.w    $11FC                    ; 008836C0: dc.w $11FC
        dc.w    $002C                    ; 008836C2: dc.w $002C
        dc.w    $C305                    ; 008836C4: dc.w $C305
        dc.w    $4E75                    ; 008836C6: RTS
        dc.w    $1038                    ; 008836C8: dc.w $1038
        dc.w    $C8AB                    ; 008836CA: dc.w $C8AB
        dc.w    $0200                    ; 008836CC: dc.w $0200
        dc.w    $0003                    ; 008836CE: dc.w $0003
        dc.w    $D000                    ; 008836D0: dc.w $D000
        dc.w    $D000                    ; 008836D2: dc.w $D000
        dc.w    $0600                    ; 008836D4: dc.w $0600
        dc.w    $000C                    ; 008836D6: dc.w $000C
        dc.w    $11C0                    ; 008836D8: dc.w $11C0
        dc.w    $C305                    ; 008836DA: dc.w $C305
        dc.w    $4E75                    ; 008836DC: RTS
        dc.w    $41F8                    ; 008836DE: dc.w $41F8
        dc.w    $9100                    ; 008836E0: dc.w $9100
        dc.w    $43F9, $00FF, $6218    ; 008836E2: LEA $00FF6218,A1
        dc.w    $47F9, $0089, $58E4    ; 008836E8: LEA $008958E4,A3
        dc.w    $3038                    ; 008836EE: dc.w $3038
        dc.w    $C8CC                    ; 008836F0: dc.w $C8CC
        dc.w    $2673                    ; 008836F2: dc.w $2673
        dc.w    $0000                    ; 008836F4: dc.w $0000
        dc.w    $7E0E                    ; 008836F6: MOVEQ #$0E,D7
        dc.w    $7A00                    ; 008836F8: MOVEQ #$00,D5
        dc.w    $7C00                    ; 008836FA: MOVEQ #$00,D6
        dc.w    $7000                    ; 008836FC: MOVEQ #$00,D0
        dc.w    $1028                    ; 008836FE: dc.w $1028
        dc.w    $00C1                    ; 00883700: dc.w $00C1
        dc.w    $6700, $008C            ; 00883702: BEQ.W $00883790
        dc.w    $7A01                    ; 00883706: MOVEQ #$01,D5
        dc.w    $7C01                    ; 00883708: MOVEQ #$01,D6
        dc.w    $4A38                    ; 0088370A: dc.w $4A38
        dc.w    $90E4                    ; 0088370C: dc.w $90E4
        dc.w    $6606                    ; 0088370E: BNE.S $00883716
        dc.w    $4A38                    ; 00883710: dc.w $4A38
        dc.w    $C31C                    ; 00883712: dc.w $C31C
        dc.w    $6710                    ; 00883714: BEQ.S $00883726
        dc.w    $0828, $0003, $00E5    ; 00883716: BTST #3,$00E5(A0)
        dc.w    $6716                    ; 0088371C: BEQ.S $00883734
        dc.w    $7A00                    ; 0088371E: MOVEQ #$00,D5
        dc.w    $7C00                    ; 00883720: MOVEQ #$00,D6
        dc.w    $6000, $006C            ; 00883722: BRA.W $00883790
        dc.w    $0838                    ; 00883726: dc.w $0838
        dc.w    $0003                    ; 00883728: dc.w $0003
        dc.w    $90E5                    ; 0088372A: dc.w $90E5
        dc.w    $6706                    ; 0088372C: BEQ.S $00883734
        dc.w    $4A28                    ; 0088372E: dc.w $4A28
        dc.w    $00E4                    ; 00883730: dc.w $00E4
        dc.w    $66EA                    ; 00883732: BNE.S $0088371E
        dc.w    $0C40                    ; 00883734: dc.w $0C40
        dc.w    $0001                    ; 00883736: dc.w $0001
        dc.w    $6702                    ; 00883738: BEQ.S $0088373C
        dc.w    $7C00                    ; 0088373A: MOVEQ #$00,D6
        dc.w    $D040                    ; 0088373C: dc.w $D040
        dc.w    $D040                    ; 0088373E: dc.w $D040
        dc.w    $D068                    ; 00883740: dc.w $D068
        dc.w    $00C2                    ; 00883742: dc.w $00C2
        dc.w    $2373                    ; 00883744: dc.w $2373
        dc.w    $0000                    ; 00883746: dc.w $0000
        dc.w    $0010                    ; 00883748: dc.w $0010
        dc.w    $3038                    ; 0088374A: dc.w $3038
        dc.w    $C0E4                    ; 0088374C: dc.w $C0E4
        dc.w    $D068                    ; 0088374E: dc.w $D068
        dc.w    $0032                    ; 00883750: dc.w $0032
        dc.w    $3340                    ; 00883752: dc.w $3340
        dc.w    $0004                    ; 00883754: dc.w $0004
        dc.w    $3028                    ; 00883756: dc.w $3028
        dc.w    $003A                    ; 00883758: dc.w $003A
        dc.w    $E640                    ; 0088375A: dc.w $E640
        dc.w    $4440                    ; 0088375C: dc.w $4440
        dc.w    $3340                    ; 0088375E: dc.w $3340
        dc.w    $0008                    ; 00883760: dc.w $0008
        dc.w    $3028                    ; 00883762: dc.w $3028
        dc.w    $003C                    ; 00883764: dc.w $003C
        dc.w    $D068                    ; 00883766: dc.w $D068
        dc.w    $006E                    ; 00883768: dc.w $006E
        dc.w    $E640                    ; 0088376A: dc.w $E640
        dc.w    $3340                    ; 0088376C: dc.w $3340
        dc.w    $000A                    ; 0088376E: dc.w $000A
        dc.w    $3028                    ; 00883770: dc.w $3028
        dc.w    $003E                    ; 00883772: dc.w $003E
        dc.w    $E640                    ; 00883774: dc.w $E640
        dc.w    $4440                    ; 00883776: dc.w $4440
        dc.w    $3340                    ; 00883778: dc.w $3340
        dc.w    $000C                    ; 0088377A: dc.w $000C
        dc.w    $3028                    ; 0088377C: dc.w $3028
        dc.w    $00BC                    ; 0088377E: dc.w $00BC
        dc.w    $E640                    ; 00883780: dc.w $E640
        dc.w    $3340                    ; 00883782: dc.w $3340
        dc.w    $001C                    ; 00883784: dc.w $001C
        dc.w    $3028                    ; 00883786: dc.w $3028
        dc.w    $00C4                    ; 00883788: dc.w $00C4
        dc.w    $E640                    ; 0088378A: dc.w $E640
        dc.w    $3340                    ; 0088378C: dc.w $3340
        dc.w    $0030                    ; 0088378E: dc.w $0030
        dc.w    $3368                    ; 00883790: dc.w $3368
        dc.w    $0030                    ; 00883792: dc.w $0030
        dc.w    $0002                    ; 00883794: dc.w $0002
        dc.w    $3368                    ; 00883796: dc.w $3368
        dc.w    $0034                    ; 00883798: dc.w $0034
        dc.w    $0006                    ; 0088379A: dc.w $0006
        dc.w    $3345                    ; 0088379C: dc.w $3345
        dc.w    $0000                    ; 0088379E: dc.w $0000
        dc.w    $3346                    ; 008837A0: dc.w $3346
        dc.w    $0014                    ; 008837A2: dc.w $0014
        dc.w    $3346                    ; 008837A4: dc.w $3346
        dc.w    $0028                    ; 008837A6: dc.w $0028
        dc.w    $41E8                    ; 008837A8: dc.w $41E8
        dc.w    $0100                    ; 008837AA: dc.w $0100
        dc.w    $43E9                    ; 008837AC: dc.w $43E9
        dc.w    $003C                    ; 008837AE: dc.w $003C
        dc.w    $51CF, $FF46            ; 008837B0: DBRA D7,$008836F8
        dc.w    $4E75                    ; 008837B4: RTS
        dc.w    $41F8                    ; 008837B6: dc.w $41F8
        dc.w    $9000                    ; 008837B8: dc.w $9000
        dc.w    $3238                    ; 008837BA: dc.w $3238
        dc.w    $C8A0                    ; 008837BC: dc.w $C8A0
        dc.w    $43F9, $0089, $5A64    ; 008837BE: LEA $00895A64,A1
        dc.w    $2271                    ; 008837C4: dc.w $2271
        dc.w    $1000                    ; 008837C6: dc.w $1000
        dc.w    $45F9, $00FF, $659C    ; 008837C8: LEA $00FF659C,A2
        dc.w    $323C                    ; 008837CE: dc.w $323C
        dc.w    $0C80                    ; 008837D0: dc.w $0C80
        dc.w    $7E02                    ; 008837D2: MOVEQ #$02,D7
        dc.w    $3428                    ; 008837D4: dc.w $3428
        dc.w    $0030                    ; 008837D6: dc.w $0030
        dc.w    $3828                    ; 008837D8: dc.w $3828
        dc.w    $0034                    ; 008837DA: dc.w $0034
        dc.w    $9451                    ; 008837DC: dc.w $9451
        dc.w    $6A02                    ; 008837DE: BPL.S $008837E2
        dc.w    $4442                    ; 008837E0: dc.w $4442
        dc.w    $B441                    ; 008837E2: dc.w $B441
        dc.w    $6E46                    ; 008837E4: BGT.S $0088382C
        dc.w    $9869                    ; 008837E6: dc.w $9869
        dc.w    $0004                    ; 008837E8: dc.w $0004
        dc.w    $6A02                    ; 008837EA: BPL.S $008837EE
        dc.w    $4444                    ; 008837EC: dc.w $4444
        dc.w    $B841                    ; 008837EE: dc.w $B841
        dc.w    $6E3A                    ; 008837F0: BGT.S $0088382C
        dc.w    $357C                    ; 008837F2: dc.w $357C
        dc.w    $0001                    ; 008837F4: dc.w $0001
        dc.w    $0000                    ; 008837F6: dc.w $0000
        dc.w    $2559                    ; 008837F8: dc.w $2559
        dc.w    $0002                    ; 008837FA: dc.w $0002
        dc.w    $3559                    ; 008837FC: dc.w $3559
        dc.w    $0006                    ; 008837FE: dc.w $0006
        dc.w    $3559                    ; 00883800: dc.w $3559
        dc.w    $000A                    ; 00883802: dc.w $000A
        dc.w    $3559                    ; 00883804: dc.w $3559
        dc.w    $000E                    ; 00883806: dc.w $000E
        dc.w    $2251                    ; 00883808: dc.w $2251
        dc.w    $3038                    ; 0088380A: dc.w $3038
        dc.w    $C008                    ; 0088380C: dc.w $C008
        dc.w    $5240                    ; 0088380E: dc.w $5240
        dc.w    $0C40                    ; 00883810: dc.w $0C40
        dc.w    $000C                    ; 00883812: dc.w $000C
        dc.w    $6604                    ; 00883814: BNE.S $0088381A
        dc.w    $303C                    ; 00883816: dc.w $303C
        dc.w    $0000                    ; 00883818: dc.w $0000
        dc.w    $31C0                    ; 0088381A: dc.w $31C0
        dc.w    $C008                    ; 0088381C: dc.w $C008
        dc.w    $E248                    ; 0088381E: dc.w $E248
        dc.w    $D040                    ; 00883820: dc.w $D040
        dc.w    $D040                    ; 00883822: dc.w $D040
        dc.w    $2571                    ; 00883824: dc.w $2571
        dc.w    $0000                    ; 00883826: dc.w $0000
        dc.w    $0010                    ; 00883828: dc.w $0010
        dc.w    $600E                    ; 0088382A: BRA.S $0088383A
        dc.w    $43E9                    ; 0088382C: dc.w $43E9
        dc.w    $000E                    ; 0088382E: dc.w $000E
        dc.w    $51CF, $FFA2            ; 00883830: DBRA D7,$008837D4
        dc.w    $357C                    ; 00883834: dc.w $357C
        dc.w    $0000                    ; 00883836: dc.w $0000
        dc.w    $0000                    ; 00883838: dc.w $0000
        dc.w    $3038                    ; 0088383A: dc.w $3038
        dc.w    $C8A0                    ; 0088383C: dc.w $C8A0
        dc.w    $227B                    ; 0088383E: dc.w $227B
        dc.w    $0004                    ; 00883840: dc.w $0004
        dc.w    $4ED1                    ; 00883842: JMP (A1)
        dc.w    $0088                    ; 00883844: dc.w $0088
        dc.w    $385E                    ; 00883846: dc.w $385E
        dc.w    $0088                    ; 00883848: dc.w $0088
        dc.w    $395C                    ; 0088384A: dc.w $395C
        dc.w    $0088                    ; 0088384C: dc.w $0088
        dc.w    $385C                    ; 0088384E: dc.w $385C
        dc.w    $0088                    ; 00883850: dc.w $0088
        dc.w    $3AAA                    ; 00883852: dc.w $3AAA
        dc.w    $0088                    ; 00883854: dc.w $0088
        dc.w    $385C                    ; 00883856: dc.w $385C
        dc.w    $0088                    ; 00883858: dc.w $0088
        dc.w    $385C                    ; 0088385A: dc.w $385C
        dc.w    $4E75                    ; 0088385C: RTS
        dc.w    $4A38                    ; 0088385E: dc.w $4A38
        dc.w    $C80F                    ; 00883860: dc.w $C80F
        dc.w    $6702                    ; 00883862: BEQ.S $00883866
        dc.w    $4E75                    ; 00883864: RTS
        dc.w    $43F9, $0088, $3924    ; 00883866: LEA $00883924,A1
        dc.w    $45F9, $00FF, $65B0    ; 0088386C: LEA $00FF65B0,A2
        dc.w    $5678                    ; 00883872: dc.w $5678
        dc.w    $C8E2                    ; 00883874: dc.w $C8E2
        dc.w    $323C                    ; 00883876: dc.w $323C
        dc.w    $0C80                    ; 00883878: dc.w $0C80
        dc.w    $363C                    ; 0088387A: dc.w $363C
        dc.w    $1400                    ; 0088387C: dc.w $1400
        dc.w    $357C                    ; 0088387E: dc.w $357C
        dc.w    $0000                    ; 00883880: dc.w $0000
        dc.w    $0000                    ; 00883882: dc.w $0000
        dc.w    $357C                    ; 00883884: dc.w $357C
        dc.w    $0000                    ; 00883886: dc.w $0000
        dc.w    $0014                    ; 00883888: dc.w $0014
        dc.w    $3038                    ; 0088388A: dc.w $3038
        dc.w    $C8E2                    ; 0088388C: dc.w $C8E2
        dc.w    $0240                    ; 0088388E: dc.w $0240
        dc.w    $1FFF                    ; 00883890: dc.w $1FFF
        dc.w    $3540                    ; 00883892: dc.w $3540
        dc.w    $0020                    ; 00883894: dc.w $0020
        dc.w    $6128                    ; 00883896: BSR.S $008838C0
        dc.w    $45EA                    ; 00883898: dc.w $45EA
        dc.w    $0028                    ; 0088389A: dc.w $0028
        dc.w    $3038                    ; 0088389C: dc.w $3038
        dc.w    $C8E2                    ; 0088389E: dc.w $C8E2
        dc.w    $E148                    ; 008838A0: dc.w $E148
        dc.w    $48E7, $4040            ; 008838A2: MOVEM.L regs,-(SP)
        dc.w    $4EBA                    ; 008838A6: dc.w $4EBA
        dc.w    $56AA                    ; 008838A8: dc.w $56AA
        dc.w    $4CDF, $0202            ; 008838AA: MOVEM.L (SP)+,regs
        dc.w    $E540                    ; 008838AE: dc.w $E540
        dc.w    $3540                    ; 008838B0: dc.w $3540
        dc.w    $0020                    ; 008838B2: dc.w $0020
        dc.w    $357C                    ; 008838B4: dc.w $357C
        dc.w    $0000                    ; 008838B6: dc.w $0000
        dc.w    $0000                    ; 008838B8: dc.w $0000
        dc.w    $357C                    ; 008838BA: dc.w $357C
        dc.w    $0000                    ; 008838BC: dc.w $0000
        dc.w    $0010                    ; 008838BE: dc.w $0010

; --- Low code utility ---
func_38C0:
        dc.w    $3428                    ; 008838C0: dc.w $3428
        dc.w    $0030                    ; 008838C2: dc.w $0030
        dc.w    $3828                    ; 008838C4: dc.w $3828
        dc.w    $0034                    ; 008838C6: dc.w $0034
        dc.w    $3A28                    ; 008838C8: dc.w $3A28
        dc.w    $0032                    ; 008838CA: dc.w $0032
        dc.w    $9451                    ; 008838CC: dc.w $9451
        dc.w    $6A02                    ; 008838CE: BPL.S $008838D2
        dc.w    $4442                    ; 008838D0: dc.w $4442
        dc.w    $B441                    ; 008838D2: dc.w $B441
        dc.w    $6E4C                    ; 008838D4: BGT.S $00883922
        dc.w    $9A69                    ; 008838D6: dc.w $9A69
        dc.w    $0002                    ; 008838D8: dc.w $0002
        dc.w    $6A02                    ; 008838DA: BPL.S $008838DE
        dc.w    $4445                    ; 008838DC: dc.w $4445
        dc.w    $BA43                    ; 008838DE: dc.w $BA43
        dc.w    $6E40                    ; 008838E0: BGT.S $00883922
        dc.w    $9869                    ; 008838E2: dc.w $9869
        dc.w    $0004                    ; 008838E4: dc.w $0004
        dc.w    $6A02                    ; 008838E6: BPL.S $008838EA
        dc.w    $4444                    ; 008838E8: dc.w $4444
        dc.w    $B841                    ; 008838EA: dc.w $B841
        dc.w    $6E34                    ; 008838EC: BGT.S $00883922
        dc.w    $357C                    ; 008838EE: dc.w $357C
        dc.w    $0002                    ; 008838F0: dc.w $0002
        dc.w    $0000                    ; 008838F2: dc.w $0000
        dc.w    $2559                    ; 008838F4: dc.w $2559
        dc.w    $0002                    ; 008838F6: dc.w $0002
        dc.w    $3559                    ; 008838F8: dc.w $3559
        dc.w    $0006                    ; 008838FA: dc.w $0006
        dc.w    $3559                    ; 008838FC: dc.w $3559
        dc.w    $000A                    ; 008838FE: dc.w $000A
        dc.w    $3559                    ; 00883900: dc.w $3559
        dc.w    $000E                    ; 00883902: dc.w $000E
        dc.w    $2559                    ; 00883904: dc.w $2559
        dc.w    $0010                    ; 00883906: dc.w $0010
        dc.w    $357C                    ; 00883908: dc.w $357C
        dc.w    $0002                    ; 0088390A: dc.w $0002
        dc.w    $0014                    ; 0088390C: dc.w $0014
        dc.w    $2559                    ; 0088390E: dc.w $2559
        dc.w    $0016                    ; 00883910: dc.w $0016
        dc.w    $3559                    ; 00883912: dc.w $3559
        dc.w    $001A                    ; 00883914: dc.w $001A
        dc.w    $3559                    ; 00883916: dc.w $3559
        dc.w    $001E                    ; 00883918: dc.w $001E
        dc.w    $3559                    ; 0088391A: dc.w $3559
        dc.w    $0022                    ; 0088391C: dc.w $0022
        dc.w    $2559                    ; 0088391E: dc.w $2559
        dc.w    $0024                    ; 00883920: dc.w $0024
        dc.w    $4E75                    ; 00883922: RTS
        dc.w    $F809                    ; 00883924: dc.w $F809
        dc.w    $1417                    ; 00883926: dc.w $1417
        dc.w    $CF1F                    ; 00883928: dc.w $CF1F
        dc.w    $F07F                    ; 0088392A: dc.w $F07F
        dc.w    $0000                    ; 0088392C: dc.w $0000
        dc.w    $222A                    ; 0088392E: dc.w $222A
        dc.w    $1498                    ; 00883930: dc.w $1498
        dc.w    $0000                    ; 00883932: dc.w $0000
        dc.w    $1CB3                    ; 00883934: dc.w $1CB3
        dc.w    $0000                    ; 00883936: dc.w $0000
        dc.w    $0000                    ; 00883938: dc.w $0000
        dc.w    $0000                    ; 0088393A: dc.w $0000
        dc.w    $222A                    ; 0088393C: dc.w $222A
        dc.w    $160C                    ; 0088393E: dc.w $160C
        dc.w    $FDF0                    ; 00883940: dc.w $FDF0
        dc.w    $0A2C                    ; 00883942: dc.w $0A2C
        dc.w    $D161                    ; 00883944: dc.w $D161
        dc.w    $1000                    ; 00883946: dc.w $1000
        dc.w    $0000                    ; 00883948: dc.w $0000
        dc.w    $222A                    ; 0088394A: dc.w $222A
        dc.w    $1DBE                    ; 0088394C: dc.w $1DBE
        dc.w    $0000                    ; 0088394E: dc.w $0000
        dc.w    $1A69                    ; 00883950: dc.w $1A69
        dc.w    $0000                    ; 00883952: dc.w $0000
        dc.w    $0000                    ; 00883954: dc.w $0000
        dc.w    $0000                    ; 00883956: dc.w $0000
        dc.w    $222A                    ; 00883958: dc.w $222A
        dc.w    $1EB8                    ; 0088395A: dc.w $1EB8
        dc.w    $43F9, $0088, $3A4E    ; 0088395C: LEA $00883A4E,A1
        dc.w    $45F9, $00FF, $65B0    ; 00883962: LEA $00FF65B0,A2
        dc.w    $203C                    ; 00883968: dc.w $203C
        dc.w    $2229                    ; 0088396A: dc.w $2229
        dc.w    $5A24                    ; 0088396C: dc.w $5A24
        dc.w    $7E03                    ; 0088396E: MOVEQ #$03,D7
        dc.w    $4EBA                    ; 00883970: dc.w $4EBA
        dc.w    $007A                    ; 00883972: dc.w $007A
        dc.w    $4A38                    ; 00883974: dc.w $4A38
        dc.w    $C80F                    ; 00883976: dc.w $C80F
        dc.w    $6702                    ; 00883978: BEQ.S $0088397C
        dc.w    $4E75                    ; 0088397A: RTS
        dc.w    $43F9, $0088, $3A80    ; 0088397C: LEA $00883A80,A1
        dc.w    $45F9, $00FF, $65D8    ; 00883982: LEA $00FF65D8,A2
        dc.w    $0678                    ; 00883988: dc.w $0678
        dc.w    $001E                    ; 0088398A: dc.w $001E
        dc.w    $C8E2                    ; 0088398C: dc.w $C8E2
        dc.w    $323C                    ; 0088398E: dc.w $323C
        dc.w    $0C80                    ; 00883990: dc.w $0C80
        dc.w    $363C                    ; 00883992: dc.w $363C
        dc.w    $1400                    ; 00883994: dc.w $1400
        dc.w    $357C                    ; 00883996: dc.w $357C
        dc.w    $0000                    ; 00883998: dc.w $0000
        dc.w    $0000                    ; 0088399A: dc.w $0000
        dc.w    $357C                    ; 0088399C: dc.w $357C
        dc.w    $0000                    ; 0088399E: dc.w $0000
        dc.w    $0014                    ; 008839A0: dc.w $0014
        dc.w    $3038                    ; 008839A2: dc.w $3038
        dc.w    $C8E2                    ; 008839A4: dc.w $C8E2
        dc.w    $0240                    ; 008839A6: dc.w $0240
        dc.w    $1FFF                    ; 008839A8: dc.w $1FFF
        dc.w    $3540                    ; 008839AA: dc.w $3540
        dc.w    $0020                    ; 008839AC: dc.w $0020
        dc.w    $4EBA                    ; 008839AE: dc.w $4EBA
        dc.w    $FF10                    ; 008839B0: dc.w $FF10
        dc.w    $45F9, $00FF, $65C4    ; 008839B2: LEA $00FF65C4,A2
        dc.w    $357C                    ; 008839B8: dc.w $357C
        dc.w    $0000                    ; 008839BA: dc.w $0000
        dc.w    $0000                    ; 008839BC: dc.w $0000
        dc.w    $4A79                    ; 008839BE: dc.w $4A79
        dc.w    $00FF                    ; 008839C0: dc.w $00FF
        dc.w    $65D8                    ; 008839C2: BCS.S $0088399C
        dc.w    $6724                    ; 008839C4: BEQ.S $008839EA
        dc.w    $43F9, $0088, $3A76    ; 008839C6: LEA $00883A76,A1
        dc.w    $357C                    ; 008839CC: dc.w $357C
        dc.w    $0001                    ; 008839CE: dc.w $0001
        dc.w    $0000                    ; 008839D0: dc.w $0000
        dc.w    $2559                    ; 008839D2: dc.w $2559
        dc.w    $0002                    ; 008839D4: dc.w $0002
        dc.w    $3559                    ; 008839D6: dc.w $3559
        dc.w    $0006                    ; 008839D8: dc.w $0006
        dc.w    $3559                    ; 008839DA: dc.w $3559
        dc.w    $000A                    ; 008839DC: dc.w $000A
        dc.w    $3551                    ; 008839DE: dc.w $3551
        dc.w    $000E                    ; 008839E0: dc.w $000E
        dc.w    $257C                    ; 008839E2: dc.w $257C
        dc.w    $222A                    ; 008839E4: dc.w $222A
        dc.w    $218E                    ; 008839E6: dc.w $218E
        dc.w    $0010                    ; 008839E8: dc.w $0010
        dc.w    $4E75                    ; 008839EA: RTS
        dc.w    $323C                    ; 008839EC: dc.w $323C
        dc.w    $0C80                    ; 008839EE: dc.w $0C80
        dc.w    $363C                    ; 008839F0: dc.w $363C
        dc.w    $0300                    ; 008839F2: dc.w $0300
        dc.w    $3428                    ; 008839F4: dc.w $3428
        dc.w    $0030                    ; 008839F6: dc.w $0030
        dc.w    $3828                    ; 008839F8: dc.w $3828
        dc.w    $0034                    ; 008839FA: dc.w $0034
        dc.w    $3A28                    ; 008839FC: dc.w $3A28
        dc.w    $0032                    ; 008839FE: dc.w $0032
        dc.w    $9451                    ; 00883A00: dc.w $9451
        dc.w    $6A02                    ; 00883A02: BPL.S $00883A06
        dc.w    $4442                    ; 00883A04: dc.w $4442
        dc.w    $B441                    ; 00883A06: dc.w $B441
        dc.w    $6E34                    ; 00883A08: BGT.S $00883A3E
        dc.w    $9A69                    ; 00883A0A: dc.w $9A69
        dc.w    $0002                    ; 00883A0C: dc.w $0002
        dc.w    $6A02                    ; 00883A0E: BPL.S $00883A12
        dc.w    $4445                    ; 00883A10: dc.w $4445
        dc.w    $BA43                    ; 00883A12: dc.w $BA43
        dc.w    $6E28                    ; 00883A14: BGT.S $00883A3E
        dc.w    $9869                    ; 00883A16: dc.w $9869
        dc.w    $0004                    ; 00883A18: dc.w $0004
        dc.w    $6A02                    ; 00883A1A: BPL.S $00883A1E
        dc.w    $4444                    ; 00883A1C: dc.w $4444
        dc.w    $B841                    ; 00883A1E: dc.w $B841
        dc.w    $6E1C                    ; 00883A20: BGT.S $00883A3E
        dc.w    $357C                    ; 00883A22: dc.w $357C
        dc.w    $0001                    ; 00883A24: dc.w $0001
        dc.w    $0000                    ; 00883A26: dc.w $0000
        dc.w    $2559                    ; 00883A28: dc.w $2559
        dc.w    $0002                    ; 00883A2A: dc.w $0002
        dc.w    $3559                    ; 00883A2C: dc.w $3559
        dc.w    $0006                    ; 00883A2E: dc.w $0006
        dc.w    $3559                    ; 00883A30: dc.w $3559
        dc.w    $000A                    ; 00883A32: dc.w $000A
        dc.w    $3551                    ; 00883A34: dc.w $3551
        dc.w    $000E                    ; 00883A36: dc.w $000E
        dc.w    $2540                    ; 00883A38: dc.w $2540
        dc.w    $0010                    ; 00883A3A: dc.w $0010
        dc.w    $4E75                    ; 00883A3C: RTS
        dc.w    $43E9                    ; 00883A3E: dc.w $43E9
        dc.w    $000A                    ; 00883A40: dc.w $000A
        dc.w    $51CF, $FFB0            ; 00883A42: DBRA D7,$008839F4
        dc.w    $357C                    ; 00883A46: dc.w $357C
        dc.w    $0000                    ; 00883A48: dc.w $0000
        dc.w    $0000                    ; 00883A4A: dc.w $0000
        dc.w    $4E75                    ; 00883A4C: RTS
        dc.w    $F372                    ; 00883A4E: dc.w $F372
        dc.w    $1E33                    ; 00883A50: dc.w $1E33
        dc.w    $EE67                    ; 00883A52: dc.w $EE67
        dc.w    $F000                    ; 00883A54: dc.w $F000
        dc.w    $0100                    ; 00883A56: dc.w $0100
        dc.w    $1049                    ; 00883A58: dc.w $1049
        dc.w    $0FCD                    ; 00883A5A: dc.w $0FCD
        dc.w    $E5E2                    ; 00883A5C: dc.w $E5E2
        dc.w    $F000                    ; 00883A5E: dc.w $F000
        dc.w    $0110                    ; 00883A60: dc.w $0110
        dc.w    $F0A8                    ; 00883A62: dc.w $F0A8
        dc.w    $0DE6                    ; 00883A64: dc.w $0DE6
        dc.w    $E977                    ; 00883A66: dc.w $E977
        dc.w    $FCDF                    ; 00883A68: dc.w $FCDF
        dc.w    $00F7                    ; 00883A6A: dc.w $00F7
        dc.w    $0F89                    ; 00883A6C: dc.w $0F89
        dc.w    $08CD                    ; 00883A6E: dc.w $08CD
        dc.w    $E03C                    ; 00883A70: dc.w $E03C
        dc.w    $F800                    ; 00883A72: dc.w $F800
        dc.w    $0100                    ; 00883A74: dc.w $0100
        dc.w    $1617                    ; 00883A76: dc.w $1617
        dc.w    $06AC                    ; 00883A78: dc.w $06AC
        dc.w    $F7AE                    ; 00883A7A: dc.w $F7AE
        dc.w    $F476                    ; 00883A7C: dc.w $F476
        dc.w    $0100                    ; 00883A7E: dc.w $0100
        dc.w    $1579                    ; 00883A80: dc.w $1579
        dc.w    $10A8                    ; 00883A82: dc.w $10A8
        dc.w    $F74A                    ; 00883A84: dc.w $F74A
        dc.w    $F447                    ; 00883A86: dc.w $F447
        dc.w    $0000                    ; 00883A88: dc.w $0000
        dc.w    $222A                    ; 00883A8A: dc.w $222A
        dc.w    $20DE                    ; 00883A8C: dc.w $20DE
        dc.w    $0000                    ; 00883A8E: dc.w $0000
        dc.w    $0000                    ; 00883A90: dc.w $0000
        dc.w    $FA6A                    ; 00883A92: dc.w $FA6A
        dc.w    $0000                    ; 00883A94: dc.w $0000
        dc.w    $0000                    ; 00883A96: dc.w $0000
        dc.w    $222A                    ; 00883A98: dc.w $222A
        dc.w    $2272                    ; 00883A9A: dc.w $2272
        dc.w    $F2E1                    ; 00883A9C: dc.w $F2E1
        dc.w    $0633                    ; 00883A9E: dc.w $0633
        dc.w    $2A89                    ; 00883AA0: dc.w $2A89
        dc.w    $0000                    ; 00883AA2: dc.w $0000
        dc.w    $0100                    ; 00883AA4: dc.w $0100
        dc.w    $222A                    ; 00883AA6: dc.w $222A
        dc.w    $2508                    ; 00883AA8: dc.w $2508
        dc.w    $4A38                    ; 00883AAA: dc.w $4A38
        dc.w    $C80F                    ; 00883AAC: dc.w $C80F
        dc.w    $6702                    ; 00883AAE: BEQ.S $00883AB2
        dc.w    $4E75                    ; 00883AB0: RTS
        dc.w    $43F9, $0088, $3A9C    ; 00883AB2: LEA $00883A9C,A1
        dc.w    $45F9, $00FF, $65B0    ; 00883AB8: LEA $00FF65B0,A2
        dc.w    $0678                    ; 00883ABE: dc.w $0678
        dc.w    $003C                    ; 00883AC0: dc.w $003C
        dc.w    $C8E2                    ; 00883AC2: dc.w $C8E2
        dc.w    $323C                    ; 00883AC4: dc.w $323C
        dc.w    $0C80                    ; 00883AC6: dc.w $0C80
        dc.w    $363C                    ; 00883AC8: dc.w $363C
        dc.w    $1400                    ; 00883ACA: dc.w $1400
        dc.w    $357C                    ; 00883ACC: dc.w $357C
        dc.w    $0000                    ; 00883ACE: dc.w $0000
        dc.w    $0000                    ; 00883AD0: dc.w $0000
        dc.w    $3038                    ; 00883AD2: dc.w $3038
        dc.w    $C8E2                    ; 00883AD4: dc.w $C8E2
        dc.w    $0240                    ; 00883AD6: dc.w $0240
        dc.w    $1FFF                    ; 00883AD8: dc.w $1FFF
        dc.w    $3540                    ; 00883ADA: dc.w $3540
        dc.w    $000A                    ; 00883ADC: dc.w $000A
        dc.w    $3428                    ; 00883ADE: dc.w $3428
        dc.w    $0030                    ; 00883AE0: dc.w $0030
        dc.w    $3828                    ; 00883AE2: dc.w $3828
        dc.w    $0034                    ; 00883AE4: dc.w $0034
        dc.w    $3A28                    ; 00883AE6: dc.w $3A28
        dc.w    $0032                    ; 00883AE8: dc.w $0032
        dc.w    $9451                    ; 00883AEA: dc.w $9451
        dc.w    $6A02                    ; 00883AEC: BPL.S $00883AF0
        dc.w    $4442                    ; 00883AEE: dc.w $4442
        dc.w    $B441                    ; 00883AF0: dc.w $B441
        dc.w    $6E32                    ; 00883AF2: BGT.S $00883B26
        dc.w    $9A69                    ; 00883AF4: dc.w $9A69
        dc.w    $0002                    ; 00883AF6: dc.w $0002
        dc.w    $6A02                    ; 00883AF8: BPL.S $00883AFC
        dc.w    $4445                    ; 00883AFA: dc.w $4445
        dc.w    $BA43                    ; 00883AFC: dc.w $BA43
        dc.w    $6E26                    ; 00883AFE: BGT.S $00883B26
        dc.w    $9869                    ; 00883B00: dc.w $9869
        dc.w    $0004                    ; 00883B02: dc.w $0004
        dc.w    $6A02                    ; 00883B04: BPL.S $00883B08
        dc.w    $4444                    ; 00883B06: dc.w $4444
        dc.w    $B841                    ; 00883B08: dc.w $B841
        dc.w    $6E1A                    ; 00883B0A: BGT.S $00883B26
        dc.w    $357C                    ; 00883B0C: dc.w $357C
        dc.w    $0001                    ; 00883B0E: dc.w $0001
        dc.w    $0000                    ; 00883B10: dc.w $0000
        dc.w    $2559                    ; 00883B12: dc.w $2559
        dc.w    $0002                    ; 00883B14: dc.w $0002
        dc.w    $3559                    ; 00883B16: dc.w $3559
        dc.w    $0006                    ; 00883B18: dc.w $0006
        dc.w    $3559                    ; 00883B1A: dc.w $3559
        dc.w    $000C                    ; 00883B1C: dc.w $000C
        dc.w    $3559                    ; 00883B1E: dc.w $3559
        dc.w    $000E                    ; 00883B20: dc.w $000E
        dc.w    $2559                    ; 00883B22: dc.w $2559
        dc.w    $0010                    ; 00883B24: dc.w $0010
        dc.w    $4E75                    ; 00883B26: RTS
        dc.w    $41F8                    ; 00883B28: dc.w $41F8
        dc.w    $9F00                    ; 00883B2A: dc.w $9F00
        dc.w    $3238                    ; 00883B2C: dc.w $3238
        dc.w    $C8A0                    ; 00883B2E: dc.w $C8A0
        dc.w    $43F9, $0089, $5A64    ; 00883B30: LEA $00895A64,A1
        dc.w    $2271                    ; 00883B36: dc.w $2271
        dc.w    $1000                    ; 00883B38: dc.w $1000
        dc.w    $45F9, $00FF, $663C    ; 00883B3A: LEA $00FF663C,A2
        dc.w    $323C                    ; 00883B40: dc.w $323C
        dc.w    $0C80                    ; 00883B42: dc.w $0C80
        dc.w    $7E02                    ; 00883B44: MOVEQ #$02,D7
        dc.w    $3428                    ; 00883B46: dc.w $3428
        dc.w    $0030                    ; 00883B48: dc.w $0030
        dc.w    $3828                    ; 00883B4A: dc.w $3828
        dc.w    $0034                    ; 00883B4C: dc.w $0034
        dc.w    $9451                    ; 00883B4E: dc.w $9451
        dc.w    $6A02                    ; 00883B50: BPL.S $00883B54
        dc.w    $4442                    ; 00883B52: dc.w $4442
        dc.w    $B441                    ; 00883B54: dc.w $B441
        dc.w    $6E46                    ; 00883B56: BGT.S $00883B9E
        dc.w    $9869                    ; 00883B58: dc.w $9869
        dc.w    $0004                    ; 00883B5A: dc.w $0004
        dc.w    $6A02                    ; 00883B5C: BPL.S $00883B60
        dc.w    $4444                    ; 00883B5E: dc.w $4444
        dc.w    $B841                    ; 00883B60: dc.w $B841
        dc.w    $6E3A                    ; 00883B62: BGT.S $00883B9E
        dc.w    $357C                    ; 00883B64: dc.w $357C
        dc.w    $0001                    ; 00883B66: dc.w $0001
        dc.w    $0000                    ; 00883B68: dc.w $0000
        dc.w    $2559                    ; 00883B6A: dc.w $2559
        dc.w    $0002                    ; 00883B6C: dc.w $0002
        dc.w    $3559                    ; 00883B6E: dc.w $3559
        dc.w    $0006                    ; 00883B70: dc.w $0006
        dc.w    $3559                    ; 00883B72: dc.w $3559
        dc.w    $000A                    ; 00883B74: dc.w $000A
        dc.w    $3559                    ; 00883B76: dc.w $3559
        dc.w    $000E                    ; 00883B78: dc.w $000E
        dc.w    $2251                    ; 00883B7A: dc.w $2251
        dc.w    $3038                    ; 00883B7C: dc.w $3038
        dc.w    $C008                    ; 00883B7E: dc.w $C008
        dc.w    $5240                    ; 00883B80: dc.w $5240
        dc.w    $0C40                    ; 00883B82: dc.w $0C40
        dc.w    $000C                    ; 00883B84: dc.w $000C
        dc.w    $6604                    ; 00883B86: BNE.S $00883B8C
        dc.w    $303C                    ; 00883B88: dc.w $303C
        dc.w    $0000                    ; 00883B8A: dc.w $0000
        dc.w    $31C0                    ; 00883B8C: dc.w $31C0
        dc.w    $C008                    ; 00883B8E: dc.w $C008
        dc.w    $E248                    ; 00883B90: dc.w $E248
        dc.w    $D040                    ; 00883B92: dc.w $D040
        dc.w    $D040                    ; 00883B94: dc.w $D040
        dc.w    $2571                    ; 00883B96: dc.w $2571
        dc.w    $0000                    ; 00883B98: dc.w $0000
        dc.w    $0010                    ; 00883B9A: dc.w $0010
        dc.w    $600E                    ; 00883B9C: BRA.S $00883BAC
        dc.w    $43E9                    ; 00883B9E: dc.w $43E9
        dc.w    $000E                    ; 00883BA0: dc.w $000E
        dc.w    $51CF, $FFA2            ; 00883BA2: DBRA D7,$00883B46
        dc.w    $357C                    ; 00883BA6: dc.w $357C
        dc.w    $0000                    ; 00883BA8: dc.w $0000
        dc.w    $0000                    ; 00883BAA: dc.w $0000
        dc.w    $3238                    ; 00883BAC: dc.w $3238
        dc.w    $C89C                    ; 00883BAE: dc.w $C89C
        dc.w    $0C41                    ; 00883BB0: dc.w $0C41
        dc.w    $0001                    ; 00883BB2: dc.w $0001
        dc.w    $6672                    ; 00883BB4: BNE.S $00883C28
        dc.w    $43F9, $0088, $3A4E    ; 00883BB6: LEA $00883A4E,A1
        dc.w    $45F9, $00FF, $6650    ; 00883BBC: LEA $00FF6650,A2
        dc.w    $323C                    ; 00883BC2: dc.w $323C
        dc.w    $0C80                    ; 00883BC4: dc.w $0C80
        dc.w    $363C                    ; 00883BC6: dc.w $363C
        dc.w    $0300                    ; 00883BC8: dc.w $0300
        dc.w    $7E03                    ; 00883BCA: MOVEQ #$03,D7
        dc.w    $3428                    ; 00883BCC: dc.w $3428
        dc.w    $0030                    ; 00883BCE: dc.w $0030
        dc.w    $3828                    ; 00883BD0: dc.w $3828
        dc.w    $0034                    ; 00883BD2: dc.w $0034
        dc.w    $3A28                    ; 00883BD4: dc.w $3A28
        dc.w    $0032                    ; 00883BD6: dc.w $0032
        dc.w    $9451                    ; 00883BD8: dc.w $9451
        dc.w    $6A02                    ; 00883BDA: BPL.S $00883BDE
        dc.w    $4442                    ; 00883BDC: dc.w $4442
        dc.w    $B441                    ; 00883BDE: dc.w $B441
        dc.w    $6E38                    ; 00883BE0: BGT.S $00883C1A
        dc.w    $9A69                    ; 00883BE2: dc.w $9A69
        dc.w    $0002                    ; 00883BE4: dc.w $0002
        dc.w    $6A02                    ; 00883BE6: BPL.S $00883BEA
        dc.w    $4445                    ; 00883BE8: dc.w $4445
        dc.w    $BA43                    ; 00883BEA: dc.w $BA43
        dc.w    $6E2C                    ; 00883BEC: BGT.S $00883C1A
        dc.w    $9869                    ; 00883BEE: dc.w $9869
        dc.w    $0004                    ; 00883BF0: dc.w $0004
        dc.w    $6A02                    ; 00883BF2: BPL.S $00883BF6
        dc.w    $4444                    ; 00883BF4: dc.w $4444
        dc.w    $B841                    ; 00883BF6: dc.w $B841
        dc.w    $6E20                    ; 00883BF8: BGT.S $00883C1A
        dc.w    $357C                    ; 00883BFA: dc.w $357C
        dc.w    $0001                    ; 00883BFC: dc.w $0001
        dc.w    $0000                    ; 00883BFE: dc.w $0000
        dc.w    $2559                    ; 00883C00: dc.w $2559
        dc.w    $0002                    ; 00883C02: dc.w $0002
        dc.w    $3559                    ; 00883C04: dc.w $3559
        dc.w    $0006                    ; 00883C06: dc.w $0006
        dc.w    $3559                    ; 00883C08: dc.w $3559
        dc.w    $000A                    ; 00883C0A: dc.w $000A
        dc.w    $3551                    ; 00883C0C: dc.w $3551
        dc.w    $000E                    ; 00883C0E: dc.w $000E
        dc.w    $257C                    ; 00883C10: dc.w $257C
        dc.w    $2229                    ; 00883C12: dc.w $2229
        dc.w    $5A24                    ; 00883C14: dc.w $5A24
        dc.w    $0010                    ; 00883C16: dc.w $0010
        dc.w    $4E75                    ; 00883C18: RTS
        dc.w    $43E9                    ; 00883C1A: dc.w $43E9
        dc.w    $000A                    ; 00883C1C: dc.w $000A
        dc.w    $51CF, $FFAC            ; 00883C1E: DBRA D7,$00883BCC
        dc.w    $357C                    ; 00883C22: dc.w $357C
        dc.w    $0000                    ; 00883C24: dc.w $0000
        dc.w    $0000                    ; 00883C26: dc.w $0000
        dc.w    $4E75                    ; 00883C28: RTS
        dc.w    $F190                    ; 00883C2A: dc.w $F190
        dc.w    $09FA                    ; 00883C2C: dc.w $09FA
        dc.w    $F1F0                    ; 00883C2E: dc.w $F1F0
        dc.w    $F190                    ; 00883C30: dc.w $F190
        dc.w    $0A40                    ; 00883C32: dc.w $0A40
        dc.w    $F1F0                    ; 00883C34: dc.w $F1F0
        dc.w    $EA70                    ; 00883C36: dc.w $EA70
        dc.w    $03B3                    ; 00883C38: dc.w $03B3
        dc.w    $FB50                    ; 00883C3A: dc.w $FB50
        dc.w    $E900                    ; 00883C3C: dc.w $E900
        dc.w    $0AF0                    ; 00883C3E: dc.w $0AF0
        dc.w    $0800                    ; 00883C40: dc.w $0800
        dc.w    $EA70                    ; 00883C42: dc.w $EA70
        dc.w    $03B3                    ; 00883C44: dc.w $03B3
        dc.w    $FB50                    ; 00883C46: dc.w $FB50
        dc.w    $F190                    ; 00883C48: dc.w $F190
        dc.w    $09FA                    ; 00883C4A: dc.w $09FA
        dc.w    $F1F0                    ; 00883C4C: dc.w $F1F0
        dc.w    $0030                    ; 00883C4E: dc.w $0030
        dc.w    $002B                    ; 00883C50: dc.w $002B
        dc.w    $0031                    ; 00883C52: dc.w $0031
        dc.w    $FFFD                    ; 00883C54: dc.w $FFFD
        dc.w    $FFD7                    ; 00883C56: dc.w $FFD7
        dc.w    $002B                    ; 00883C58: dc.w $002B
        dc.w    $FFCE                    ; 00883C5A: dc.w $FFCE
        dc.w    $FFFD                    ; 00883C5C: dc.w $FFFD
        dc.w    $0034                    ; 00883C5E: dc.w $0034
        dc.w    $0021                    ; 00883C60: dc.w $0021
        dc.w    $0035                    ; 00883C62: dc.w $0035
        dc.w    $FFF3                    ; 00883C64: dc.w $FFF3
        dc.w    $FFD3                    ; 00883C66: dc.w $FFD3
        dc.w    $0021                    ; 00883C68: dc.w $0021
        dc.w    $FFCA                    ; 00883C6A: dc.w $FFCA
        dc.w    $FFF3                    ; 00883C6C: dc.w $FFF3
        dc.w    $0034                    ; 00883C6E: dc.w $0034
        dc.w    $0017                    ; 00883C70: dc.w $0017
        dc.w    $0035                    ; 00883C72: dc.w $0035
        dc.w    $FFEE                    ; 00883C74: dc.w $FFEE
        dc.w    $FFD3                    ; 00883C76: dc.w $FFD3
        dc.w    $0017                    ; 00883C78: dc.w $0017
        dc.w    $FFCA                    ; 00883C7A: dc.w $FFCA
        dc.w    $FFEE                    ; 00883C7C: dc.w $FFEE
        dc.w    $3038                    ; 00883C7E: dc.w $3038
        dc.w    $C8C8                    ; 00883C80: dc.w $C8C8
        dc.w    $E948                    ; 00883C82: dc.w $E948
        dc.w    $45FB                    ; 00883C84: dc.w $45FB
        dc.w    $00C8                    ; 00883C86: dc.w $00C8
        dc.w    $3038                    ; 00883C88: dc.w $3038
        dc.w    $C8A0                    ; 00883C8A: dc.w $C8A0
        dc.w    $D078                    ; 00883C8C: dc.w $D078
        dc.w    $C89E                    ; 00883C8E: dc.w $C89E
        dc.w    $47FB                    ; 00883C90: dc.w $47FB
        dc.w    $0098                    ; 00883C92: dc.w $0098
        dc.w    $43F9, $00FF, $66DC    ; 00883C94: LEA $00FF66DC,A1
        dc.w    $7201                    ; 00883C9A: MOVEQ #$01,D1
        dc.w    $7403                    ; 00883C9C: MOVEQ #$03,D2
        dc.w    $3341                    ; 00883C9E: dc.w $3341
        dc.w    $0000                    ; 00883CA0: dc.w $0000
        dc.w    $301B                    ; 00883CA2: dc.w $301B
        dc.w    $D05A                    ; 00883CA4: dc.w $D05A
        dc.w    $3340                    ; 00883CA6: dc.w $3340
        dc.w    $0002                    ; 00883CA8: dc.w $0002
        dc.w    $335B                    ; 00883CAA: dc.w $335B
        dc.w    $0004                    ; 00883CAC: dc.w $0004
        dc.w    $301B                    ; 00883CAE: dc.w $301B
        dc.w    $905A                    ; 00883CB0: dc.w $905A
        dc.w    $3340                    ; 00883CB2: dc.w $3340
        dc.w    $0006                    ; 00883CB4: dc.w $0006
        dc.w    $43E9                    ; 00883CB6: dc.w $43E9
        dc.w    $0014                    ; 00883CB8: dc.w $0014
        dc.w    $5D4B                    ; 00883CBA: dc.w $5D4B
        dc.w    $51CA, $FFE0            ; 00883CBC: DBRA D2,$00883C9E
        dc.w    $7000                    ; 00883CC0: MOVEQ #$00,D0
        dc.w    $600A                    ; 00883CC2: BRA.S $00883CCE
        dc.w    $7000                    ; 00883CC4: MOVEQ #$00,D0
        dc.w    $3038                    ; 00883CC6: dc.w $3038
        dc.w    $C026                    ; 00883CC8: dc.w $C026
        dc.w    $6A02                    ; 00883CCA: BPL.S $00883CCE
        dc.w    $4E75                    ; 00883CCC: RTS
        dc.w    $43F9, $00FF, $66EC    ; 00883CCE: LEA $00FF66EC,A1
        dc.w    $45F9, $0089, $5B7E    ; 00883CD4: LEA $00895B7E,A2
        dc.w    $E940                    ; 00883CDA: dc.w $E940
        dc.w    $7203                    ; 00883CDC: MOVEQ #$03,D1
        dc.w    $265A                    ; 00883CDE: dc.w $265A
        dc.w    $D7C0                    ; 00883CE0: dc.w $D7C0
        dc.w    $228B                    ; 00883CE2: dc.w $228B
        dc.w    $43E9                    ; 00883CE4: dc.w $43E9
        dc.w    $0014                    ; 00883CE6: dc.w $0014
        dc.w    $51C9, $FFF4            ; 00883CE8: DBRA D1,$00883CDE
        dc.w    $3238                    ; 00883CEC: dc.w $3238
        dc.w    $C026                    ; 00883CEE: dc.w $C026
        dc.w    $0C41                    ; 00883CF0: dc.w $0C41
        dc.w    $0007                    ; 00883CF2: dc.w $0007
        dc.w    $6D2C                    ; 00883CF4: BLT.S $00883D22
        dc.w    $0C41                    ; 00883CF6: dc.w $0C41
        dc.w    $0013                    ; 00883CF8: dc.w $0013
        dc.w    $6C26                    ; 00883CFA: BGE.S $00883D22
        dc.w    $7000                    ; 00883CFC: MOVEQ #$00,D0
        dc.w    $43F9, $00FF, $6128    ; 00883CFE: LEA $00FF6128,A1
        dc.w    $3340                    ; 00883D04: dc.w $3340
        dc.w    $0000                    ; 00883D06: dc.w $0000
        dc.w    $3340                    ; 00883D08: dc.w $3340
        dc.w    $0014                    ; 00883D0A: dc.w $0014
        dc.w    $4A78                    ; 00883D0C: dc.w $4A78
        dc.w    $C04C                    ; 00883D0E: dc.w $C04C
        dc.w    $660E                    ; 00883D10: BNE.S $00883D20
        dc.w    $3340                    ; 00883D12: dc.w $3340
        dc.w    $0028                    ; 00883D14: dc.w $0028
        dc.w    $4A78                    ; 00883D16: dc.w $4A78
        dc.w    $C8C8                    ; 00883D18: dc.w $C8C8
        dc.w    $6604                    ; 00883D1A: BNE.S $00883D20
        dc.w    $3340                    ; 00883D1C: dc.w $3340
        dc.w    $003C                    ; 00883D1E: dc.w $003C
        dc.w    $4E75                    ; 00883D20: RTS
        dc.w    $0C41                    ; 00883D22: dc.w $0C41
        dc.w    $0004                    ; 00883D24: dc.w $0004
        dc.w    $6606                    ; 00883D26: BNE.S $00883D2E
        dc.w    $11FC                    ; 00883D28: dc.w $11FC
        dc.w    $00BA                    ; 00883D2A: dc.w $00BA

; --- Low code utility ---
func_3D2C:
        dc.w    $C8A4                    ; 00883D2C: dc.w $C8A4
        dc.w    $0C41                    ; 00883D2E: dc.w $0C41
        dc.w    $0016                    ; 00883D30: dc.w $0016
        dc.w    $6606                    ; 00883D32: BNE.S $00883D3A
        dc.w    $11FC                    ; 00883D34: dc.w $11FC
        dc.w    $00BA                    ; 00883D36: dc.w $00BA
        dc.w    $C8A4                    ; 00883D38: dc.w $C8A4
        dc.w    $7001                    ; 00883D3A: MOVEQ #$01,D0
        dc.w    $43F9, $00FF, $6128    ; 00883D3C: LEA $00FF6128,A1
        dc.w    $3340                    ; 00883D42: dc.w $3340
        dc.w    $0000                    ; 00883D44: dc.w $0000
        dc.w    $3340                    ; 00883D46: dc.w $3340
        dc.w    $0014                    ; 00883D48: dc.w $0014
        dc.w    $4A78                    ; 00883D4A: dc.w $4A78
        dc.w    $C04C                    ; 00883D4C: dc.w $C04C
        dc.w    $6608                    ; 00883D4E: BNE.S $00883D58
        dc.w    $3340                    ; 00883D50: dc.w $3340
        dc.w    $0028                    ; 00883D52: dc.w $0028
        dc.w    $3340                    ; 00883D54: dc.w $3340
        dc.w    $003C                    ; 00883D56: dc.w $003C
        dc.w    $4E75                    ; 00883D58: RTS
        dc.w    $43F9, $00FF, $6980    ; 00883D5A: LEA $00FF6980,A1
        dc.w    $12BC                    ; 00883D60: dc.w $12BC
        dc.w    $0009                    ; 00883D62: dc.w $0009
        dc.w    $237C                    ; 00883D64: dc.w $237C
        dc.w    $0402                    ; 00883D66: dc.w $0402
        dc.w    $68F8                    ; 00883D68: BVC.S $00883D62

; --- Low code utility ---
func_3D6A:
        dc.w    $0004                    ; 00883D6A: dc.w $0004
        dc.w    $237C                    ; 00883D6C: dc.w $237C
        dc.w    $222F                    ; 00883D6E: dc.w $222F
        dc.w    $0FBE                    ; 00883D70: dc.w $0FBE
        dc.w    $0008                    ; 00883D72: dc.w $0008
        dc.w    $43F9, $00FF, $69C0    ; 00883D74: LEA $00FF69C0,A1
        dc.w    $12BC                    ; 00883D7A: dc.w $12BC
        dc.w    $0009                    ; 00883D7C: dc.w $0009
        dc.w    $43F9, $00FF, $6990    ; 00883D7E: LEA $00FF6990,A1
        dc.w    $12BC                    ; 00883D84: dc.w $12BC
        dc.w    $0009                    ; 00883D86: dc.w $0009
        dc.w    $237C                    ; 00883D88: dc.w $237C
        dc.w    $0402                    ; 00883D8A: dc.w $0402
        dc.w    $C8EC                    ; 00883D8C: dc.w $C8EC
        dc.w    $0004                    ; 00883D8E: dc.w $0004
        dc.w    $237C                    ; 00883D90: dc.w $237C
        dc.w    $222F                    ; 00883D92: dc.w $222F
        dc.w    $22A2                    ; 00883D94: dc.w $22A2
        dc.w    $0008                    ; 00883D96: dc.w $0008
        dc.w    $4E75                    ; 00883D98: RTS
        dc.w    $31FC                    ; 00883D9A: dc.w $31FC
        dc.w    $0000                    ; 00883D9C: dc.w $0000
        dc.w    $C8AA                    ; 00883D9E: dc.w $C8AA
        dc.w    $5878                    ; 00883DA0: dc.w $5878
        dc.w    $C8AC                    ; 00883DA2: dc.w $C8AC
        dc.w    $4E75                    ; 00883DA4: RTS
        dc.w    $0C78                    ; 00883DA6: dc.w $0C78
        dc.w    $0014                    ; 00883DA8: dc.w $0014
        dc.w    $C8AA                    ; 00883DAA: dc.w $C8AA
        dc.w    $6F24                    ; 00883DAC: BLE.S $00883DD2
        dc.w    $43F9, $00FF, $69C0    ; 00883DAE: LEA $00FF69C0,A1
        dc.w    $137C                    ; 00883DB4: dc.w $137C
        dc.w    $0009                    ; 00883DB6: dc.w $0009
        dc.w    $0000                    ; 00883DB8: dc.w $0000
        dc.w    $237C                    ; 00883DBA: dc.w $237C
        dc.w    $222F                    ; 00883DBC: dc.w $222F
        dc.w    $1D4A                    ; 00883DBE: dc.w $1D4A
        dc.w    $0008                    ; 00883DC0: dc.w $0008
        dc.w    $31FC                    ; 00883DC2: dc.w $31FC
        dc.w    $0000                    ; 00883DC4: dc.w $0000
        dc.w    $C8AA                    ; 00883DC6: dc.w $C8AA
        dc.w    $11FC                    ; 00883DC8: dc.w $11FC
        dc.w    $00A6                    ; 00883DCA: dc.w $00A6
        dc.w    $C8A4                    ; 00883DCC: dc.w $C8A4
        dc.w    $5878                    ; 00883DCE: dc.w $5878
        dc.w    $C8AC                    ; 00883DD0: dc.w $C8AC
        dc.w    $4E75                    ; 00883DD2: RTS
        dc.w    $0C78                    ; 00883DD4: dc.w $0C78
        dc.w    $0014                    ; 00883DD6: dc.w $0014
        dc.w    $C8AA                    ; 00883DD8: dc.w $C8AA
        dc.w    $6F2A                    ; 00883DDA: BLE.S $00883E06
        dc.w    $23FC, $222F, $29EE, $00FF, $69C8  ; 00883DDC: MOVE.L #$222F29EE,$00FF69C8
        dc.w    $23FC, $222F, $1716, $00FF, $6998  ; 00883DE6: MOVE.L #$222F1716,$00FF6998
        dc.w    $31FC                    ; 00883DF0: dc.w $31FC
        dc.w    $0000                    ; 00883DF2: dc.w $0000
        dc.w    $C8AA                    ; 00883DF4: dc.w $C8AA
        dc.w    $11FC                    ; 00883DF6: dc.w $11FC
        dc.w    $00A7                    ; 00883DF8: dc.w $00A7
        dc.w    $C8A4                    ; 00883DFA: dc.w $C8A4
        dc.w    $08F8                    ; 00883DFC: dc.w $08F8
        dc.w    $0004                    ; 00883DFE: dc.w $0004
        dc.w    $C30E                    ; 00883E00: dc.w $C30E
        dc.w    $5878                    ; 00883E02: dc.w $5878
        dc.w    $C8AC                    ; 00883E04: dc.w $C8AC
        dc.w    $4E75                    ; 00883E06: RTS
        dc.w    $0C78                    ; 00883E08: dc.w $0C78
        dc.w    $000A                    ; 00883E0A: dc.w $000A
        dc.w    $C8AA                    ; 00883E0C: dc.w $C8AA
        dc.w    $6618                    ; 00883E0E: BNE.S $00883E28
        dc.w    $3038                    ; 00883E10: dc.w $3038
        dc.w    $C89C                    ; 00883E12: dc.w $C89C
        dc.w    $11FB                    ; 00883E14: dc.w $11FB
        dc.w    $003C                    ; 00883E16: dc.w $003C
        dc.w    $C8A5                    ; 00883E18: dc.w $C8A5
        dc.w    $0838                    ; 00883E1A: dc.w $0838
        dc.w    $0005                    ; 00883E1C: dc.w $0005
        dc.w    $C80E                    ; 00883E1E: dc.w $C80E
        dc.w    $6706                    ; 00883E20: BEQ.S $00883E28
        dc.w    $11FC                    ; 00883E22: dc.w $11FC
        dc.w    $0093                    ; 00883E24: dc.w $0093
        dc.w    $C8A5                    ; 00883E26: dc.w $C8A5
        dc.w    $0C78                    ; 00883E28: dc.w $0C78
        dc.w    $0028                    ; 00883E2A: dc.w $0028
        dc.w    $C8AA                    ; 00883E2C: dc.w $C8AA
        dc.w    $6F20                    ; 00883E2E: BLE.S $00883E50
        dc.w    $31FC                    ; 00883E30: dc.w $31FC
        dc.w    $0000                    ; 00883E32: dc.w $0000
        dc.w    $C8AA                    ; 00883E34: dc.w $C8AA
        dc.w    $31FC                    ; 00883E36: dc.w $31FC
        dc.w    $0000                    ; 00883E38: dc.w $0000
        dc.w    $C8AC                    ; 00883E3A: dc.w $C8AC
        dc.w    $7000                    ; 00883E3C: MOVEQ #$00,D0
        dc.w    $13C0                    ; 00883E3E: dc.w $13C0
        dc.w    $00FF                    ; 00883E40: dc.w $00FF
        dc.w    $6980                    ; 00883E42: BVS.S $00883DC4
        dc.w    $13C0                    ; 00883E44: dc.w $13C0
        dc.w    $00FF                    ; 00883E46: dc.w $00FF
        dc.w    $6990                    ; 00883E48: BVS.S $00883DDA
        dc.w    $13C0                    ; 00883E4A: dc.w $13C0
        dc.w    $00FF                    ; 00883E4C: dc.w $00FF
        dc.w    $69C0                    ; 00883E4E: BVS.S $00883E10
        dc.w    $4E75                    ; 00883E50: RTS
        dc.w    $8383                    ; 00883E52: dc.w $8383
        dc.w    $8499                    ; 00883E54: dc.w $8499
        dc.w    $9E99                    ; 00883E56: dc.w $9E99
        dc.w    $31FC                    ; 00883E58: dc.w $31FC
        dc.w    $0000                    ; 00883E5A: dc.w $0000
        dc.w    $C8AA                    ; 00883E5C: dc.w $C8AA
        dc.w    $5878                    ; 00883E5E: dc.w $5878
        dc.w    $C8AC                    ; 00883E60: dc.w $C8AC
        dc.w    $4E75                    ; 00883E62: RTS
        dc.w    $31FC                    ; 00883E64: dc.w $31FC
        dc.w    $0000                    ; 00883E66: dc.w $0000
        dc.w    $C8AA                    ; 00883E68: dc.w $C8AA
        dc.w    $5878                    ; 00883E6A: dc.w $5878
        dc.w    $C8AC                    ; 00883E6C: dc.w $C8AC
        dc.w    $13FC                    ; 00883E6E: dc.w $13FC
        dc.w    $0009                    ; 00883E70: dc.w $0009
        dc.w    $00FF                    ; 00883E72: dc.w $00FF
        dc.w    $6980                    ; 00883E74: BVS.S $00883DF6
        dc.w    $11FC                    ; 00883E76: dc.w $11FC
        dc.w    $00C0                    ; 00883E78: dc.w $00C0
        dc.w    $C8A4                    ; 00883E7A: dc.w $C8A4
        dc.w    $4E75                    ; 00883E7C: RTS
        dc.w    $0C78                    ; 00883E7E: dc.w $0C78
        dc.w    $0014                    ; 00883E80: dc.w $0014
        dc.w    $C8AA                    ; 00883E82: dc.w $C8AA
        dc.w    $6F1A                    ; 00883E84: BLE.S $00883EA0
        dc.w    $23FC, $222F, $038A, $00FF, $6988  ; 00883E86: MOVE.L #$222F038A,$00FF6988
        dc.w    $11FC                    ; 00883E90: dc.w $11FC
        dc.w    $00C1                    ; 00883E92: dc.w $00C1
        dc.w    $C8A4                    ; 00883E94: dc.w $C8A4
        dc.w    $31FC                    ; 00883E96: dc.w $31FC
        dc.w    $0000                    ; 00883E98: dc.w $0000
        dc.w    $C8AA                    ; 00883E9A: dc.w $C8AA
        dc.w    $5878                    ; 00883E9C: dc.w $5878
        dc.w    $C8AC                    ; 00883E9E: dc.w $C8AC
        dc.w    $4E75                    ; 00883EA0: RTS
        dc.w    $0C78                    ; 00883EA2: dc.w $0C78
        dc.w    $0014                    ; 00883EA4: dc.w $0014
        dc.w    $C8AA                    ; 00883EA6: dc.w $C8AA
        dc.w    $6F1A                    ; 00883EA8: BLE.S $00883EC4
        dc.w    $23FC, $222F, $002C, $00FF, $6988  ; 00883EAA: MOVE.L #$222F002C,$00FF6988
        dc.w    $11FC                    ; 00883EB4: dc.w $11FC
        dc.w    $00C2                    ; 00883EB6: dc.w $00C2
        dc.w    $C8A4                    ; 00883EB8: dc.w $C8A4
        dc.w    $31FC                    ; 00883EBA: dc.w $31FC
        dc.w    $0000                    ; 00883EBC: dc.w $0000
        dc.w    $C8AA                    ; 00883EBE: dc.w $C8AA
        dc.w    $5878                    ; 00883EC0: dc.w $5878
        dc.w    $C8AC                    ; 00883EC2: dc.w $C8AC
        dc.w    $4E75                    ; 00883EC4: RTS
        dc.w    $0C78                    ; 00883EC6: dc.w $0C78
        dc.w    $0014                    ; 00883EC8: dc.w $0014
        dc.w    $C8AA                    ; 00883ECA: dc.w $C8AA
        dc.w    $6F26                    ; 00883ECC: BLE.S $00883EF4
        dc.w    $23FC, $222E, $EF3A, $00FF, $6988  ; 00883ECE: MOVE.L #$222EEF3A,$00FF6988
        dc.w    $11FC                    ; 00883ED8: dc.w $11FC
        dc.w    $00C3                    ; 00883EDA: dc.w $00C3
        dc.w    $C8A4                    ; 00883EDC: dc.w $C8A4
        dc.w    $31FC                    ; 00883EDE: dc.w $31FC
        dc.w    $0000                    ; 00883EE0: dc.w $0000
        dc.w    $C8AA                    ; 00883EE2: dc.w $C8AA
        dc.w    $08F8                    ; 00883EE4: dc.w $08F8
        dc.w    $0004                    ; 00883EE6: dc.w $0004
        dc.w    $C30E                    ; 00883EE8: dc.w $C30E
        dc.w    $08F8                    ; 00883EEA: dc.w $08F8
        dc.w    $0004                    ; 00883EEC: dc.w $0004
        dc.w    $B4EE                    ; 00883EEE: dc.w $B4EE
        dc.w    $5878                    ; 00883EF0: dc.w $5878
        dc.w    $C8AC                    ; 00883EF2: dc.w $C8AC
        dc.w    $4E75                    ; 00883EF4: RTS
        dc.w    $0C78                    ; 00883EF6: dc.w $0C78
        dc.w    $0005                    ; 00883EF8: dc.w $0005
        dc.w    $C8AA                    ; 00883EFA: dc.w $C8AA
        dc.w    $6606                    ; 00883EFC: BNE.S $00883F04
        dc.w    $11FC                    ; 00883EFE: dc.w $11FC
        dc.w    $0098                    ; 00883F00: dc.w $0098
        dc.w    $C8A5                    ; 00883F02: dc.w $C8A5
        dc.w    $7000                    ; 00883F04: MOVEQ #$00,D0
        dc.w    $0838                    ; 00883F06: dc.w $0838
        dc.w    $0002                    ; 00883F08: dc.w $0002
        dc.w    $C8AB                    ; 00883F0A: dc.w $C8AB
        dc.w    $6602                    ; 00883F0C: BNE.S $00883F10
        dc.w    $7009                    ; 00883F0E: MOVEQ #$09,D0
        dc.w    $13C0                    ; 00883F10: dc.w $13C0
        dc.w    $00FF                    ; 00883F12: dc.w $00FF
        dc.w    $6980                    ; 00883F14: BVS.S $00883E96
        dc.w    $0C78                    ; 00883F16: dc.w $0C78
        dc.w    $003C                    ; 00883F18: dc.w $003C
        dc.w    $C8AA                    ; 00883F1A: dc.w $C8AA
        dc.w    $6F0C                    ; 00883F1C: BLE.S $00883F2A
        dc.w    $13FC                    ; 00883F1E: dc.w $13FC
        dc.w    $0000                    ; 00883F20: dc.w $0000
        dc.w    $00FF                    ; 00883F22: dc.w $00FF
        dc.w    $6980                    ; 00883F24: BVS.S $00883EA6
        dc.w    $5878                    ; 00883F26: dc.w $5878
        dc.w    $C8AC                    ; 00883F28: dc.w $C8AC
        dc.w    $4E75                    ; 00883F2A: RTS
        dc.w    $4E75                    ; 00883F2C: RTS
        dc.w    $7600                    ; 00883F2E: MOVEQ #$00,D3
        dc.w    $7800                    ; 00883F30: MOVEQ #$00,D4
        dc.w    $4A79                    ; 00883F32: dc.w $4A79
        dc.w    $00FF                    ; 00883F34: dc.w $00FF
        dc.w    $6448                    ; 00883F36: BCC.S $00883F80
        dc.w    $670A                    ; 00883F38: BEQ.S $00883F44
        dc.w    $4A68                    ; 00883F3A: dc.w $4A68
        dc.w    $00C0                    ; 00883F3C: dc.w $00C0
        dc.w    $6704                    ; 00883F3E: BEQ.S $00883F44
        dc.w    $7601                    ; 00883F40: MOVEQ #$01,D3
        dc.w    $7802                    ; 00883F42: MOVEQ #$02,D4
        dc.w    $43F9, $00FF, $64AC    ; 00883F44: LEA $00FF64AC,A1
        dc.w    $4EBA                    ; 00883F4A: dc.w $4EBA
        dc.w    $0044                    ; 00883F4C: dc.w $0044
        dc.w    $7601                    ; 00883F4E: MOVEQ #$01,D3
        dc.w    $7802                    ; 00883F50: MOVEQ #$02,D4
        dc.w    $43F9, $00FF, $6178    ; 00883F52: LEA $00FF6178,A1
        dc.w    $6036                    ; 00883F58: BRA.S $00883F90
        dc.w    $7600                    ; 00883F5A: MOVEQ #$00,D3
        dc.w    $7800                    ; 00883F5C: MOVEQ #$00,D4
        dc.w    $4A79                    ; 00883F5E: dc.w $4A79
        dc.w    $00FF                    ; 00883F60: dc.w $00FF
        dc.w    $6218                    ; 00883F62: BHI.S $00883F7C
        dc.w    $670A                    ; 00883F64: BEQ.S $00883F70
        dc.w    $4A68                    ; 00883F66: dc.w $4A68
        dc.w    $00C0                    ; 00883F68: dc.w $00C0
        dc.w    $6704                    ; 00883F6A: BEQ.S $00883F70
        dc.w    $7601                    ; 00883F6C: MOVEQ #$01,D3
        dc.w    $7802                    ; 00883F6E: MOVEQ #$02,D4
        dc.w    $43F9, $00FF, $627C    ; 00883F70: LEA $00FF627C,A1
        dc.w    $4EBA                    ; 00883F76: dc.w $4EBA
        dc.w    $0018                    ; 00883F78: dc.w $0018
        dc.w    $7601                    ; 00883F7A: MOVEQ #$01,D3
        dc.w    $7802                    ; 00883F7C: MOVEQ #$02,D4
        dc.w    $43F9, $00FF, $63A8    ; 00883F7E: LEA $00FF63A8,A1
        dc.w    $600A                    ; 00883F84: BRA.S $00883F90
        dc.w    $43F9, $00FF, $6178    ; 00883F86: LEA $00FF6178,A1
        dc.w    $7601                    ; 00883F8C: MOVEQ #$01,D3
        dc.w    $7802                    ; 00883F8E: MOVEQ #$02,D4
        dc.w    $7200                    ; 00883F90: MOVEQ #$00,D1
        dc.w    $7414                    ; 00883F92: MOVEQ #$14,D2
        dc.w    $3341                    ; 00883F94: dc.w $3341
        dc.w    $0000                    ; 00883F96: dc.w $0000
        dc.w    $3381                    ; 00883F98: dc.w $3381
        dc.w    $2000                    ; 00883F9A: dc.w $2000
        dc.w    $3038                    ; 00883F9C: dc.w $3038
        dc.w    $C00C                    ; 00883F9E: dc.w $C00C
        dc.w    $6B1E                    ; 00883FA0: BMI.S $00883FC0
        dc.w    $D040                    ; 00883FA2: dc.w $D040
        dc.w    $D040                    ; 00883FA4: dc.w $D040
        dc.w    $45F9, $0089, $59B0    ; 00883FA6: LEA $008959B0,A2
        dc.w    $2372                    ; 00883FAC: dc.w $2372
        dc.w    $0000                    ; 00883FAE: dc.w $0000
        dc.w    $0010                    ; 00883FB0: dc.w $0010
        dc.w    $3344                    ; 00883FB2: dc.w $3344
        dc.w    $0000                    ; 00883FB4: dc.w $0000
        dc.w    $23B2                    ; 00883FB6: dc.w $23B2
        dc.w    $0000                    ; 00883FB8: dc.w $0000
        dc.w    $2010                    ; 00883FBA: dc.w $2010
        dc.w    $3383                    ; 00883FBC: dc.w $3383
        dc.w    $2000                    ; 00883FBE: dc.w $2000
        dc.w    $D3C2                    ; 00883FC0: dc.w $D3C2
        dc.w    $D3C2                    ; 00883FC2: dc.w $D3C2
        dc.w    $3341                    ; 00883FC4: dc.w $3341
        dc.w    $0000                    ; 00883FC6: dc.w $0000
        dc.w    $3038                    ; 00883FC8: dc.w $3038
        dc.w    $C012                    ; 00883FCA: dc.w $C012
        dc.w    $6B14                    ; 00883FCC: BMI.S $00883FE2
        dc.w    $D040                    ; 00883FCE: dc.w $D040

; --- Low code utility ---
func_3FD0:
        dc.w    $D040                    ; 00883FD0: dc.w $D040
        dc.w    $45F9, $0089, $59D0    ; 00883FD2: LEA $008959D0,A2
        dc.w    $2372                    ; 00883FD8: dc.w $2372
        dc.w    $0000                    ; 00883FDA: dc.w $0000
        dc.w    $0010                    ; 00883FDC: dc.w $0010
        dc.w    $3343                    ; 00883FDE: dc.w $3343
        dc.w    $0000                    ; 00883FE0: dc.w $0000
        dc.w    $D3C2                    ; 00883FE2: dc.w $D3C2
        dc.w    $3341                    ; 00883FE4: dc.w $3341
        dc.w    $0000                    ; 00883FE6: dc.w $0000
        dc.w    $3038                    ; 00883FE8: dc.w $3038
        dc.w    $C018                    ; 00883FEA: dc.w $C018
        dc.w    $6B14                    ; 00883FEC: BMI.S $00884002
        dc.w    $D040                    ; 00883FEE: dc.w $D040
        dc.w    $D040                    ; 00883FF0: dc.w $D040
        dc.w    $45F9, $0089, $59FC    ; 00883FF2: LEA $008959FC,A2
        dc.w    $2372                    ; 00883FF8: dc.w $2372
        dc.w    $0000                    ; 00883FFA: dc.w $0000
        dc.w    $0010                    ; 00883FFC: dc.w $0010
        dc.w    $3343                    ; 00883FFE: dc.w $3343

