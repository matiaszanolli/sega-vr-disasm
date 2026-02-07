; ============================================================================
; Obj Palette Update 043 (auto-analyzed)
; ROM Range: $005DC8-$005E38 (112 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 17 subroutines
;   Calls: sprite_buffer_alt, angle_to_sine, obj_velocity_x, math_routine
;   Object (A0, A6): +$44 (display_offset), +$46 (display_scale), +$4A, +$88
;
; Entry: A0 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, A0, A2, A6
; Calls:
;   $002984: palette_update
;   $0031A6: display_mode_dispatch
;   $0036DE: clear_buffer
;   $0037B6: memory_copy
;   $0070AA: angle_to_sine
;   $0071A6: obj_screen_coord
; Object fields:
;   +$44: display_offset
;   +$46: display_scale
;   +$4A: [unknown]
;   +$88: [unknown]
; Confidence: high
; ============================================================================

fn_4200_043:
        DC.W    $0088                           ; $005DC8
        DC.W    $3C7E                           ; $005DCA
        DC.W    $0088                           ; $005DCC
        MOVE.W  (A2)+,$0088(A6)                 ; $005DCE
        MOVE.W  (A2)+,$0088(A6)                 ; $005DD2
        MOVE.W  (A2)+,$0088(A6)                 ; $005DD6
        MOVE.W  (A2)+,$0088(A6)                 ; $005DDA
        MOVE.W  (A2)+,$4EBA(A6)                 ; $005DDE
        DC.W    $EBC8                           ; $005DE2
        DC.W    $4EBA,$5996         ; JSR     $00B77C(PC); $005DE4
        MOVEQ   #$00,D0                         ; $005DE8
        MOVE.W  D0,$0044(A0)                    ; $005DEA
        MOVE.W  D0,$0046(A0)                    ; $005DEE
        MOVE.W  D0,$004A(A0)                    ; $005DF2
        DC.W    $4EBA,$12B2         ; JSR     $0070AA(PC); $005DF6
        DC.W    $4EBA,$134E         ; JSR     $00714A(PC); $005DFA
        DC.W    $4EBA,$184E         ; JSR     $00764E(PC); $005DFE
        DC.W    $4EBA,$214C         ; JSR     $007F50(PC); $005E02
        DC.W    $4EBA,$3EC6         ; JSR     $009CCE(PC); $005E06
        DC.W    $4EBA,$28F2         ; JSR     $0086FE(PC); $005E0A
        DC.W    $4EBA,$3230         ; JSR     $009040(PC); $005E0E
        DC.W    $4EBA,$23C4         ; JSR     $0081D8(PC); $005E12
        DC.W    $4EBA,$E26C         ; JSR     $004084(PC); $005E16
        DC.W    $4EBA,$17E2         ; JSR     $0075FE(PC); $005E1A
        DC.W    $4EBA,$1386         ; JSR     $0071A6(PC); $005E1E
        DC.W    $4EBA,$CB60         ; JSR     $002984(PC); $005E22
        DC.W    $4EBA,$D37E         ; JSR     $0031A6(PC); $005E26
        DC.W    $4EBA,$D8B2         ; JSR     $0036DE(PC); $005E2A
        DC.W    $4EBA,$D986         ; JSR     $0037B6(PC); $005E2E
        DC.W    $4EBA,$D292         ; JSR     $0030C6(PC); $005E32
        RTS                                     ; $005E36
