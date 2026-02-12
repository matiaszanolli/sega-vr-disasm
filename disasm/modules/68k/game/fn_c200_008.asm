; ============================================================================
; Scene Dispatch + Input Replay
; ROM Range: $00C4C2-$00C542 (128 bytes)
; ============================================================================
; Increments frame/scene counters, reads next input byte from replay
; buffer (splitting direction + button bits), calls scene logic,
; then dispatches to state handler via 4-entry jump table indexed
; by menu_state. Post-dispatch calls sprite_update, object_update,
; and tail-calls to frame finalize.
;
; Uses: D0, D1, D2, A0, A1, A2
; RAM:
;   $C080: frame_counter
;   $C082: menu_state (jump table index: 0/4/8/12)
;   $C886: sub_frame
;   $C8AA: scene_state
;   $C8C0: replay_buffer_ptr
;   $C8C4: frame_counter_b
;   $C970: anim_state (init $FFFF0000)
;   $C971: direction_bits (from replay: bits masked $5C)
;   $C973: button_bits (from replay: bits masked $03)
; Calls:
;   $00B684: object_update (JSR PC-relative)
;   $00B6DA: sprite_update (JSR PC-relative)
;   $00C070: scene_logic (JSR PC-relative)
;   $00C662: frame_finalize (JMP PC-relative)
; ============================================================================

fn_c200_008:
        jsr     $0088179E                       ; external call
        addq.w  #1,($FFFFC080).w                ; increment frame_counter
        addq.w  #1,($FFFFC8AA).w                ; increment scene_state
        move.l  #$FFFF0000,($FFFFC970).w        ; init anim_state
; --- read next input from replay buffer ---
        movea.w ($FFFFC8C0).w,a0                ; replay_buffer_ptr
        move.b  (a0)+,d0                        ; read input byte
        move.b  d0,d1                           ; copy
        andi.b  #$5C,d0                         ; extract direction bits
        move.b  d0,($FFFFC971).w                ; store direction_bits
        andi.b  #$03,d1                         ; extract button bits
        move.b  d1,($FFFFC973).w                ; store button_bits
        move.w  a0,($FFFFC8C0).w                ; update replay_buffer_ptr
; --- scene logic calls ---
        jsr     $00886DF0                       ; external call
        jsr     $008824CA                       ; external call
        addq.b  #1,($FFFFC886).w                ; increment sub_frame
        addq.b  #4,($FFFFC8C4).w                ; advance frame_counter_b by 4
        move.w  #$0044,$00FF0008                ; set SH2 command
; --- state dispatch via jump table ---
        moveq   #$00,d0
        move.b  ($FFFFC082).w,d0                ; menu_state (table index)
        movea.l $00C52C(pc,d0.w),a1             ; load handler address
        jsr     (a1)                            ; call state handler
; --- post-dispatch calls ---
        dc.w    $4EBA,$FB52                      ; jsr scene_logic(pc) → $00C070
        dc.w    $4EBA,$F1B8                      ; jsr sprite_update(pc) → $00B6DA
        dc.w    $4EBA,$F15E                      ; jsr object_update(pc) → $00B684
        dc.w    $4EFA,$0138                      ; jmp frame_finalize(pc) → $00C662
; --- jump table (4 entries) ---
        dc.l    $0088C542                        ; state 0 → external handler
        dc.l    $0088C544                        ; state 1 → external handler
        dc.l    $0088C586                        ; state 2 → external handler
        dc.l    $0088C592                        ; state 3 → external handler
; --- auxiliary exit (reached via state handler return) ---
        addq.b  #1,($FFFFC886).w                ; increment sub_frame
        rts
