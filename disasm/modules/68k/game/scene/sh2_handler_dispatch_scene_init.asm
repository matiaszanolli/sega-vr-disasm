; ============================================================================
; SH2 Handler Dispatch + Scene Init
; ROM Range: $005866-$0058EA (132 bytes)
; ============================================================================
; Two code paths: (1) reads current SH2 handler address from
; $00FF0002, matches against 4 known values, replaces with
; corresponding new handler, then jumps to init routine.
; (2) Scene setup — calls display digit extract, JSR to track
; init, checks race_substate and control flags.
;
; Uses: D0, D1, D4, D7, A0, A1, A4, A6
; RAM:
;   $A000: scene_palette_base
;   $C26C: display_config
;   $C81C: control_mode_flags
;   $C89C: race_substate
;   $C8C5: state_counter
; Calls:
;   $002474: vint_init (JMP PC-relative)
;   $002890: game_init (JMP PC-relative)
;   $0049AA: SetDisplayParams (JSR PC-relative)
;   $006B8A: track_init (JSR PC-relative)
;   $00B4CA: display_digit_extract (JSR PC-relative)
; ============================================================================

sh2_handler_dispatch_scene_init:
; --- entry 1: handler replacement dispatch ---
        dc.w    $4EBA,$5C62                      ; jsr display_digit_extract(pc) → $00B4CA
        move.l  $00FF0002,d0                    ; current SH2 handler address
        moveq   #-$04,d1                        ; init search index
        moveq   #$03,d7                         ; 4 entries to check
        dc.w    $43FA,$001E                      ; lea match_table(pc),a1 → $005894
.search:
        addq.w  #4,d1                           ; advance index
        cmp.l   (a1)+,d0                        ; match current entry?
        dbeq    d7,.search                      ; loop until match or exhausted
        move.l  $0058A4(pc,d1.w),$00FF0002      ; replace with new handler
        move.w  #$0020,$00FF0008                ; set SH2 command $0020
        dc.w    $4EFA,$CFFE                      ; jmp game_init(pc) → $002890
; --- match table: 4 handler addresses to detect ---
        dc.l    $00885618                        ; match 0
        dc.l    $00885308                        ; match 1
        dc.l    $00885024                        ; match 2
        dc.l    $00884CBC                        ; match 3
; --- replacement table: 4 new handler addresses ---
        dc.l    $008909AE                        ; replace 0
        dc.l    $0088FB98                        ; replace 1
        dc.l    $0088FB98                        ; replace 2
        dc.l    $0088FB98                        ; replace 3
; --- entry 2: scene setup ---
        move.b  #$00,$00FF69F0                  ; clear scene flag
        dc.w    $4EBA,$F0EC                      ; jsr SetDisplayParams(pc) → $0049AA
        addq.b  #4,($FFFFC8C5).w                ; advance state_counter by 4
        dc.w    $4EFA,$CBAE                      ; jmp vint_init(pc) → $002474
; --- entry 3: track init + control check ---
        dc.w    $4EBA,$12C0                      ; jsr track_init(pc) → $006B8A
        lea     ($FFFFA000).w,a4                ; scene_palette_base
        move.w  ($FFFFC26C).w,d0                ; display_config
        btst    #7,($FFFFC81C).w                ; control mode bit 7?
        bne.s   .check_mask
        tst.w   ($FFFFC89C).w                   ; race_substate active?
        dc.w    $6708                            ; beq.s $0058EA → external (skip mask)
.check_mask:
        andi.w  #$0138,d0                       ; mask relevant bits
        dc.w    $6708                            ; beq.s $0058F0 → external (bits clear)
        rts
