; ============================================================================
; Camera SH2 Scene Transition + Dual DMA
; ROM Range: $013C30-$013CBA (138 bytes)
; ============================================================================
; Category: game
; Purpose: Calls SH2 scene transition, then DMA transfer.
;   Sends COMM protocol (cmd $2C, COMM4=$4000) to SH2, waits for ack.
;   Then sets height=$B8 via COMM4, sends two sh2_send_cmd DMA transfers
;   for dual display buffers ($06017CC0→$04007010 and $0601DFC0→$04013010).
;   Advances game_state, display mode $0020.
;
; Uses: D0, D1, A0, A1
; RAM:
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
;   $0088205E: SH2 scene transition
; ============================================================================

fn_12200_037:
        jsr     $0088205E                       ; $013C30  SH2 scene transition
        clr.w   D0                              ; $013C36  mode = 0
        dc.w    $4EBA,$A8F2                     ; $013C38  bsr.w dma_transfer ($00E52C)
.wait_comm0:
        tst.b   COMM0_HI                        ; $013C3C  COMM0 busy?
        bne.s   .wait_comm0                     ; $013C42  yes → wait
        move.w  #$0101,COMM6                    ; $013C44  COMM6 = $0101
        move.w  #$4000,COMM4                    ; $013C4C  COMM4 = $4000
        move.b  #$2C,COMM0_LO                   ; $013C54  cmd = $2C
        move.b  #$01,COMM0_HI                   ; $013C5C  trigger command
.wait_comm6:
        tst.b   COMM6                           ; $013C64  COMM6 cleared?
        bne.s   .wait_comm6                     ; $013C6A  no → wait
        move.w  #$00B8,COMM4                    ; $013C6C  height = $B8
        move.w  #$0101,COMM6                    ; $013C74  signal ready
        movea.l #$06017CC0,A0                   ; $013C7C  source A
        movea.l #$04007010,A1                   ; $013C82  dest A
        move.w  #$0120,D0                       ; $013C88  size = $120
        move.w  #$0058,D1                       ; $013C8C  width = $58
        dc.w    $4EBA,$A6C8                     ; $013C90  bsr.w sh2_send_cmd ($00E35A)
        movea.l #$0601DFC0,A0                   ; $013C94  source B
        movea.l #$04013010,A1                   ; $013C9A  dest B
        move.w  #$0120,D0                       ; $013CA0  size = $120
        move.w  #$0058,D1                       ; $013CA4  width = $58
        dc.w    $4EBA,$A6B0                     ; $013CA8  bsr.w sh2_send_cmd ($00E35A)
        addq.w  #4,($FFFFC87E).w                ; $013CAC  advance game_state
        move.w  #$0020,$00FF0008                ; $013CB0  display mode = $0020
        rts                                     ; $013CB8
