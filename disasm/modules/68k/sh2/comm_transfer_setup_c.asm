; ============================================================================
; SH2 COMM Transfer Setup C (Third World Data)
; ROM Range: $00F0BE-$00F130 (114 bytes)
; ============================================================================
; Sets up SH2 COMM transfer block at $FF6100 with world coordinate data
; from $FF200C-$FF2010, callback $222BF710. Signals SH2 via COMM registers.
;
; Entry: D0 = parameter value
; Uses: A1
; ============================================================================

comm_transfer_setup_c:
        lea     $00FF6100,a1            ; SH2 COMM base
        move.w  #$0001,$0000(a1)        ; Command = 1
        move.w  #$0000,$0002(a1)        ; Param 0 = 0
        move.w  $00FF200E,$0004(a1)     ; Copy coord 1
        move.w  $00FF2010,$0006(a1)     ; Copy coord 2
        move.w  $00FF200C,$0008(a1)     ; Copy coord 3
        move.w  d0,$000A(a1)            ; Store D0
        move.w  #$0000,$000C(a1)        ; Clear field C
        move.w  #$0000,$000E(a1)        ; Clear field E
        move.l  #$222BF710,$0010(a1)    ; SH2 callback addr
        adda.l  #$00000014,a1           ; Advance past block
        move.w  #$0044,$00A15110        ; Set DREQ length
        move.b  #$04,$00A15107          ; Set COMM control
.wait:  tst.b   $00A15120               ; Wait SH2 ready
        bne.s   .wait                   ;   (poll loop)
        move.b  #$2A,$00A15121          ; Send command $2A
        move.b  #$01,$00A15120          ; Signal SH2
        rts
