; ============================================================================
; Name Entry Score Area DMA Transfer
; ROM Range: $011C7E-$011D0A (140 bytes)
; ============================================================================
; Category: game
; Purpose: Sends SH2 DMA for one of 4 score display areas based on
;   ranking result ($A04E) and display toggle ($A050).
;   If $A04E == 0: sends current score area ($06018F80 or $06010000)
;   If $A04E == 1: sends alternate score area ($06019AC0 or $06010000)
;   If $A04E == 2: skips transfer entirely.
;   Toggle bit 0 of $A050 selects between two VRAM sources.
;
; Uses: D0, D1, A0, A1
; RAM:
;   $A04E: ranking result (word, 0/1/2)
;   $A050: display toggle (byte, bit 0)
; Calls:
;   $00E35A: sh2_send_cmd (A0=src, A1=dest, D0=size, D1=width)
; ============================================================================

name_entry_score_area_dma_xfer:
        tst.w   ($FFFFA04E).w                   ; $011C7E  ranking result
        bne.s   .check_rank1                    ; $011C82  non-zero → check rank 1
        btst    #0,($FFFFA050).w                ; $011C84  display toggle
        bne.s   .rank0_alt                      ; $011C8A  alternate source
        movea.l #$06018F80,A0                   ; $011C8C  A0 = score area 1 (primary)
        movea.l #$0400D018,A1                   ; $011C92  A1 = display dest 1
        move.w  #$0078,D0                       ; $011C98  size = $78
        move.w  #$0018,D1                       ; $011C9C  width = $18
        jsr     sh2_send_cmd(pc)        ; $4EBA $C6B8
        bra.w   .done                           ; $011CA4
.rank0_alt:
        movea.l #$06010000,A0                   ; $011CA8  A0 = alt source
        movea.l #$0400D018,A1                   ; $011CAE  A1 = display dest 1
        move.w  #$0078,D0                       ; $011CB4  size = $78
        move.w  #$0018,D1                       ; $011CB8  width = $18
        jsr     sh2_send_cmd(pc)        ; $4EBA $C69C
        bra.w   .done                           ; $011CC0
.check_rank1:
        cmpi.w  #$0002,($FFFFA04E).w            ; $011CC4  ranking == 2?
        beq.s   .done                           ; $011CCA  yes → skip entirely
        btst    #0,($FFFFA050).w                ; $011CCC  display toggle
        bne.s   .rank1_alt                      ; $011CD2  alternate source
        movea.l #$06019AC0,A0                   ; $011CD4  A0 = score area 2 (primary)
        movea.l #$0400D0A0,A1                   ; $011CDA  A1 = display dest 2
        move.w  #$0078,D0                       ; $011CE0  size = $78
        move.w  #$0018,D1                       ; $011CE4  width = $18
        jsr     sh2_send_cmd(pc)        ; $4EBA $C670
        bra.w   .done                           ; $011CEC
.rank1_alt:
        movea.l #$06010000,A0                   ; $011CF0  A0 = alt source
        movea.l #$0400D0A0,A1                   ; $011CF6  A1 = display dest 2
        move.w  #$0078,D0                       ; $011CFC  size = $78
        move.w  #$0018,D1                       ; $011D00  width = $18
        jsr     sh2_send_cmd(pc)        ; $4EBA $C654
.done:
        rts                                     ; $011D08
