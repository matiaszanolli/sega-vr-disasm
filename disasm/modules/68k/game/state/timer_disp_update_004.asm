; ============================================================================
; Timer Display Update 004
; ROM Range: $008280-$0082E0 (96 bytes)
; ============================================================================
; Category: game
; Purpose: Updates race timer display via num_to_decimal conversion
;   Dispatches through jump table based on controller bits 6-7
;   Handles timer countdown with flag-based visibility
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D6, D7, A0, A1
; RAM:
;   $C319: controller_raw
;   $C04E: timer_countdown
;   $C305: race_phase
;   $C8AB: scene_state_hi
;   $C8AA: scene_state (cleared)
; Calls:
;   $00839A: num_to_decimal
;   Jump table at digit_extraction_via_division
; Object fields (A0):
;   +$02: flags
; Confidence: medium
; ============================================================================

timer_disp_update_004:
        clr.w   ($FFFFC8AA).w                   ; $008280  scene_state = 0
        moveq   #$00,D6                         ; $008284  D6 = 0
        move.b  ($FFFFC319).w,D0                ; $008286  D0 = controller_raw
        andi.w  #$00C0,D0                       ; $00828A  isolate bits 6-7
        lsr.b   #4,D0                           ; $00828E  D0 = 0/4/8/$C
        movea.l $0082E8(PC,D0.W),A1             ; $008290  A1 = jump table[D0]
        jsr     (A1)                            ; $008294  dispatch
        lea     $00FF68F8,A1                    ; $008296  A1 → time_display_buf
        move.b  D0,-$0007(A1)                   ; $00829C  buf[-7] = D0
        move.b  D1,(A1)+                        ; $0082A0  buf[0] = D1, A1++
        dc.w    $4EBA,$00F6         ; JSR     $00839A(PC); $0082A2  num_to_decimal
        move.w  ($FFFFC04E).w,D0                ; $0082A6  D0 = timer_countdown
        dc.w    $673A               ; BEQ.S   $0082E6    ; $0082AA  zero → exit (RTS in write_status_code_to_ram)
        moveq   #$00,D7                         ; $0082AC  D7 = 0
        subq.w  #1,($FFFFC04E).w                ; $0082AE  timer_countdown--
        dc.w    $672C               ; BEQ.S   $0082E0    ; $0082B2  now zero → store D7 status
        btst    #2,($FFFFC8AB).w                ; $0082B4  scene_state bit 2?
        bne.s   .skip_d7                        ; $0082BA  yes → skip
        moveq   #$03,D7                         ; $0082BC  D7 = 3
.skip_d7:
        tst.b   ($FFFFC305).w                   ; $0082BE  race_phase == 0?
        dc.w    $6622               ; BNE.S   $0082E6    ; $0082C2  no → exit
        tst.w   D0                              ; $0082C4  timer was negative?
        dc.w    $6B1E               ; BMI.S   $0082E6    ; $0082C6  yes → exit
        move.w  $0002(A0),D1                    ; $0082C8  D1 = obj.flags
        andi.w  #$0200,D1                       ; $0082CC  bit 9 set?
        dc.w    $670E               ; BEQ.S   $0082E0    ; $0082D0  no → store D7 status
        andi.w  #$FDFF,$0002(A0)                ; $0082D2  clear bit 9 in flags
        move.w  #$0000,($FFFFC04E).w            ; $0082D8  timer_countdown = 0
        rts                                     ; $0082DE
