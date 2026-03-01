; ============================================================================
; Game Logic Init + State Dispatch
; ROM Range: $00471E-$0047CA (172 bytes)
; ============================================================================
; Two entry points: (1) init path — sets up VDP, sprite table, SH2
; command handler, then jumps to external init routine; (2) dispatch
; path — sets camera position, reads state index from input_state,
; and dispatches via 4-entry jump table. State 0 activates game and
; clears scene_state. State 1 waits 40 frames then advances state.
;
; Uses: D0, A1, A5
; RAM:
;   $C048: camera_position
;   $C07C: input_state (jump table index: 0/4/8/12)
;   $C260: sprite_table_init
;   $C30E: state_flags
;   $C800: game_active
;   $C802: init_flag_a
;   $C809: init_flag_b
;   $C80A: init_flag_c
;   $C80E: mode_flags
;   $C87E: game_state
;   $C880: vscroll_a
;   $C882: vscroll_b
;   $C8A8: state_timer
;   $C8AA: scene_state
; Calls:
;   $002890: game_init (JMP PC-relative)
;   $00B25E: state_advance (JMP PC-relative)
; ============================================================================

game_logic_init_state_dispatch:
; --- init entry point ---
        btst    #5,($FFFFC30E).w                ; sprite table initialized?
        bne.s   .skip_sprite_init
        move.l  #$60000000,($FFFFC260).w        ; init sprite_table (BRA $0)
.skip_sprite_init:
        andi.b  #$7F,($FFFFC80E).w              ; clear bit 7 of mode_flags
        move.w  #$0000,($FFFFC87E).w            ; clear game_state
        moveq   #$00,d0
        move.w  d0,($FFFFC880).w                ; clear vscroll_a
        move.w  d0,($FFFFC882).w                ; clear vscroll_b
        move.w  #$8B00,(a5)                     ; VDP reg $0B = $00 (H-scroll full)
        move.w  #$0000,($FFFFC8A8).w            ; clear state_timer
        move.w  #$0020,$00FF0008                ; set SH2 command $0020
        move.l  #$0088FB98,$00FF0002            ; set SH2 handler address
        move.b  #$00,($FFFFC800).w              ; clear game_active
        jmp     mars_comm_write(pc)     ; $4EFA $E128
; --- dispatch entry point ---
        move.w  #$0001,($FFFFC048).w            ; camera_position = 1
        move.w  ($FFFFC07C).w,d0                ; input_state (table index)
        movea.l $00477A(pc,d0.w),a1             ; load handler address
        jmp     (a1)                            ; dispatch to handler
; --- jump table (4 entries) ---
        dc.l    $0088478A                        ; state 0 → activate game
        dc.l    $0088479E                        ; state 1 → wait + advance
        dc.l    $008847CA                        ; state 2 → external handler
        dc.l    $008847E4                        ; state 3 → external handler
; --- state 0: activate game ---
        move.b  #$01,($FFFFC800).w              ; set game_active
        move.w  #$0000,($FFFFC8AA).w            ; clear scene_state
        addq.w  #4,($FFFFC07C).w                ; advance to next state
        jmp     bcd_scoring_calc(pc)    ; $4EFA $6AC2
; --- state 1: wait 40 frames then advance ---
        cmpi.w  #$0028,($FFFFC8AA).w            ; frame count = 40?
        bne.s   .state1_done
        move.w  #$0000,($FFFFC8AA).w            ; reset scene_state
        addq.w  #4,($FFFFC07C).w                ; advance to next state
        move.b  #$01,($FFFFC809).w              ; set init_flag_b
        move.b  #$01,($FFFFC80A).w              ; set init_flag_c
        bset    #7,($FFFFC80E).w                ; set bit 7 of mode_flags
        move.b  #$01,($FFFFC802).w              ; set init_flag_a
.state1_done:
        rts
