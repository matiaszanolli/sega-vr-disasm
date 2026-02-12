; ============================================================================
; Game Init + State Dispatch 002
; ROM Range: $0043D0-$004460 (144 bytes)
; ============================================================================
; Category: game
; Purpose: Two entry points:
;   Entry A ($0043D0): Game initialization — clears work buffers, resets state
;   Entry B ($00442E): State dispatcher with 4-entry jump table
;
; Uses: D0, A0, A1, A6
; RAM:
;   $C30E: race_flags
;   $C260: position_buf_a
;   $C200: work_buf_base
;   $C80E: race_ctrl
;   $C87E: game_state
;   $C880: vdp_color_a
;   $C882: vdp_color_b
;   $C048: camera_state
;   $C07C: input_state
;   $C8AA: frame_counter
;   $C800: race_init_flag
; Calls:
;   $00B4CA: fn_a200_038
;   $002890: fn_200_042 (tail call via JMP)
; Confidence: high
; ============================================================================

fn_4200_002:
; --- entry A: game initialization ---
        move.l  #$0088FB98,$00FF0002            ; $0043D0  vint handler = $FB98
        btst    #5,($FFFFC30E).w                ; $0043DA  race_flags bit 5?
        bne.s   .post_init                      ; $0043E0  yes → skip init
        move.l  #$60000000,($FFFFC260).w        ; $0043E2  position_buf_a = sentinel
        lea     ($FFFFC200).w,A1                ; $0043EA  A1 → work_buf_base
        move.w  $002C(A0),D0                    ; $0043EE  D0 = obj.lap_count
        lsl.w   #2,D0                           ; $0043F2  D0 *= 4
        move.l  #$00000000,$00(A1,D0.W)         ; $0043F4  clear work_buf[lap]
        bclr    #3,($FFFFC80E).w                ; $0043FC  clear race_ctrl bit 3
.post_init:
        andi.b  #$7F,($FFFFC80E).w              ; $004402  clear race_ctrl bit 7
        move.w  #$0000,($FFFFC87E).w            ; $004408  game_state = 0
        moveq   #$00,D0                         ; $00440E  D0 = 0
        move.w  D0,($FFFFC880).w                ; $004410  vdp_color_a = 0
        move.w  D0,($FFFFC882).w                ; $004414  vdp_color_b = 0
        move.w  #$0020,$00FF0008                ; $004418  display list cmd = $20
        dc.w    $4EBA,$70A8         ; JSR     $00B4CA(PC); $004420  fn_a200_038
        move.b  #$00,($FFFFC800).w              ; $004424  race_init_flag = 0
        dc.w    $4EFA,$E464         ; JMP     $002890(PC); $00442A  → fn_200_042
; --- entry B: state dispatch ---
        move.w  #$0001,($FFFFC048).w            ; $00442E  camera_state = 1
        move.w  ($FFFFC07C).w,D0                ; $004434  D0 = input_state
        movea.l $00443E(PC,D0.W),A1             ; $004438  A1 = jump table[D0]
        jmp     (A1)                            ; $00443C
; --- jump table (4 longword entries) ---
        dc.l    $0088444E                       ; $00443E  [00] → .state_0
        dc.l    $00884460                       ; $004442  [04] → past fn (external)
        dc.l    $00884498                       ; $004446  [08] → external
        dc.l    $008844A6                       ; $00444A  [0C] → external
; --- state 0: start ---
.state_0:
        move.b  #$01,($FFFFC800).w              ; $00444E  race_init_flag = 1
        addq.w  #4,($FFFFC07C).w                ; $004454  input_state += 4
        move.w  #$0000,($FFFFC8AA).w            ; $004458  frame_counter = 0
        rts                                     ; $00445E
