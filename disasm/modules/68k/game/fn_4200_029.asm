; ============================================================================
; Frame Orchestrator (8 Subroutines, 2 Entry Points, Controller Decode)
; ROM Range: $005676-$0056E4 (110 bytes)
; ============================================================================
; Category: game
; Purpose: Entry 1 ($5676): calls sfx, poll_controllers, 2 sprite handlers,
;   increments scene_state, reads controller byte from RAM pointer ($C880),
;   decodes to AI flags ($C971/$C973), calls 4 handlers, advances state,
;   writes $54 to SH2 COMM, tail-jumps to $56F8. Entry 2 ($56CE):
;   calls sfx, poll_controllers, increments scene_counter, writes $54.
;
; Uses: D0, D1, A0
; RAM:
;   $C87E: state_dispatch_idx (word)
;   $C880: controller_ptr (word)
;   $C886: scene_counter (byte)
;   $C8AA: scene_state (word)
;   $C970: work_param (longword, set to $FFFF0000)
;   $C971: ai_input_flags (byte, bits 2,3,4,6)
;   $C973: ai_direction_flags (byte, bits 0-1)
; Calls:
;   $00179E: poll_controllers
;   $0021CA: sfx_queue_process
;   $00593C: sprite_state_process
;   $00B504/$00B522/$00B5CA: sprite handlers
;   $00B684: object_update
;   $00B6DA: sprite_update
; ============================================================================

fn_4200_029:
; --- entry 1: full orchestrator ---
        dc.w    $4EBA,$CB52                     ; $005676  jsr $0021CA(pc) — sfx_queue_process
        dc.w    $4EBA,$C122                     ; $00567A  jsr $00179E(pc) — poll_controllers
        dc.w    $4EBA,$5E84                     ; $00567E  jsr $00B504(pc) — sprite handler A
        dc.w    $4EBA,$5E9E                     ; $005682  jsr $00B522(pc) — sprite handler B
        addq.w  #1,($FFFFC8AA).w                ; $005686  scene_state++
        move.l  #$FFFF0000,($FFFFC970).w        ; $00568A  clear work param
        movea.w ($FFFFC880).w,A0                ; $005692  A0 = controller_ptr
        move.b  (A0)+,D0                        ; $005696  D0 = controller byte
        move.b  D0,D1                           ; $005698  D1 = copy
        andi.b  #$5C,D0                         ; $00569A  extract bits 2,3,4,6
        move.b  D0,($FFFFC971).w                ; $00569E  ai_input_flags
        andi.b  #$03,D1                         ; $0056A2  extract bits 0-1
        move.b  D1,($FFFFC973).w                ; $0056A6  ai_direction_flags
        move.w  A0,($FFFFC880).w                ; $0056AA  advance controller_ptr
        dc.w    $4EBA,$5F1A                     ; $0056AE  jsr $00B5CA(pc) — sprite handler C
        dc.w    $4EBA,$0288                     ; $0056B2  jsr $00593C(pc) — sprite_state_process
        dc.w    $4EBA,$6022                     ; $0056B6  jsr $00B6DA(pc) — sprite_update
        dc.w    $4EBA,$5FC8                     ; $0056BA  jsr $00B684(pc) — object_update
        addq.w  #4,($FFFFC87E).w                ; $0056BE  advance state
        move.w  #$0054,$00FF0008                ; $0056C2  SH2 COMM = $54
        dc.w    $4EFA,$002C                     ; $0056CA  jmp $0056F8(pc) — controller handler
; --- entry 2: reduced orchestrator ---
        dc.w    $4EBA,$CAFA                     ; $0056CE  jsr $0021CA(pc) — sfx_queue_process
        dc.w    $4EBA,$C0CA                     ; $0056D2  jsr $00179E(pc) — poll_controllers
        addq.b  #1,($FFFFC886).w                ; $0056D6  scene_counter++
        move.w  #$0054,$00FF0008                ; $0056DA  SH2 COMM = $54
        rts                                     ; $0056E2
