; ============================================================================
; Name Entry SH2 COMM + Scroll DMA + Blink
; ROM Range: $0115A8-$011630 (136 bytes)
; ============================================================================
; Category: game
; Purpose: DMA transfer, sends SH2 COMM commands (same as fn_10200_025),
;   then sends scroll view DMA ($26028000+offset → $24010018, $80×$50).
;   Decrements blink counter ($A052), toggles display toggle ($A050)
;   on underflow. Calls score area transfer sub ($011C7E).
;   Advances game_state, display mode $0020.
;
; Uses: D0, D1, A0, A1
; RAM:
;   $A022: scroll position (long)
;   $A050: display toggle (byte, bit 0)
;   $A052: blink counter (word)
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
;   $011C7E: score_area_transfer (fn_10200_037)
; ============================================================================

fn_10200_027:
        clr.w   D0                              ; $0115A8  mode = 0
        dc.w    $4EBA,$CF80                     ; $0115AA  bsr.w dma_transfer ($00E52C)
.wait_comm0:
        tst.b   COMM0_HI                        ; $0115AE  COMM0 busy?
        bne.s   .wait_comm0                     ; $0115B4  yes → wait
        move.w  #$0101,COMM6                    ; $0115B6  COMM6 = $0101
        move.w  #$8000,COMM4                    ; $0115BE  COMM4 = $8000
        move.b  #$2C,COMM0_LO                   ; $0115C6  cmd = $2C
        move.b  #$01,COMM0_HI                   ; $0115CE  trigger command
.wait_comm6:
        tst.b   COMM6                           ; $0115D6  COMM6 busy?
        bne.s   .wait_comm6                     ; $0115DC  yes → wait
        move.w  #$0050,COMM4                    ; $0115DE  COMM4 = $0050
        move.w  #$0101,COMM6                    ; $0115E6  COMM6 = $0101
        movea.l #$26028000,A0                   ; $0115EE  A0 = VRAM scroll source
        move.l  ($FFFFA022).w,D0                ; $0115F4  D0 = scroll offset
        adda.l  D0,A0                           ; $0115F8  A0 += scroll position
        movea.l #$24010018,A1                   ; $0115FA  A1 = scroll dest
        move.w  #$0080,D0                       ; $011600  size = $80
        move.w  #$0050,D1                       ; $011604  width = $50
        dc.w    $4EBA,$CD50                     ; $011608  bsr.w sh2_send_cmd ($00E35A)
        subq.w  #1,($FFFFA052).w                ; $01160C  decrement blink counter
        bcc.s   .render_scores                  ; $011610  no underflow → render
        move.w  #$0010,($FFFFA052).w            ; $011612  reset counter (16)
        bchg    #0,($FFFFA050).w                ; $011618  toggle display
.render_scores:
        dc.w    $6100,$065E                     ; $01161E  bsr.w score_area_transfer ($011C7E)
        move.w  #$0020,$00FF0008                ; $011622  display mode = $0020
        addq.w  #4,($FFFFC87E).w                ; $01162A  advance game_state
        rts                                     ; $01162E
