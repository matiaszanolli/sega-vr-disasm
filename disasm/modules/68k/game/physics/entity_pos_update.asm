; ============================================================================
; entity_pos_update — Entity Position Update — Heading-Based Movement
; ROM Range: $006F98-$006FFA (98 bytes)
; Computes entity X/Y position delta from heading angle and speed using
; sine/cosine lookups. Contains sub at $006FDE that multiplies speed by
; sin/cos and accumulates into D3 (X) and D4 (Y). Three dispatch paths:
; normal (heading_mirror), special (+$92 > 0), and alternate (+$62 != 0).
;
; Entry: A0 = entity base pointer
; Uses: D0, D2, D3, D4, D5, D6, A0
; Object fields: +$06 speed, +$30 x_position, +$34 y_position,
;   +$3C heading_mirror, +$40 heading_angle, +$62 mode, +$92 param,
;   +$96 heading_offset
; Confidence: high
; ============================================================================

entity_pos_update:
        TST.W  $0062(A0)                        ; $006F98
        BNE.S  .loc_003E                        ; $006F9C
        TST.W  $0092(A0)                        ; $006F9E
        BGT.S  .loc_0036                        ; $006FA2
        MOVE.W  $003C(A0),D0                    ; $006FA4
        ADD.W  $0096(A0),D0                     ; $006FA8
        MOVE.W  D0,$0040(A0)                    ; $006FAC
        NEG.W  D0                               ; $006FB0
        MOVE.W  $0006(A0),D2                    ; $006FB2
        MOVE.W  $0030(A0),D3                    ; $006FB6
        MOVE.W  $0034(A0),D4                    ; $006FBA
        jsr     entity_pos_update+70(pc); $4EBA $001E
        MOVE.W  D3,$0030(A0)                    ; $006FC2
        MOVE.W  D4,$0034(A0)                    ; $006FC6
        jmp     collision_response_surface_tracking(pc); $4EFA $0734
.loc_0036:
        jsr     counter_guard(pc)       ; $4EBA $002A
        jmp     collision_response_surface_tracking+278(pc); $4EFA $0842
.loc_003E:
        jsr     camera_position_smooth(pc); $4EBA $0030
        jmp     collision_response_surface_tracking+278(pc); $4EFA $083A
        MOVEQ   #$0C,D6                         ; $006FDE
        MOVE.W  D0,D5                           ; $006FE0
        jsr     sine_cosine_quadrant_lookup+4(pc); $4EBA $1F6E
        MULS    D2,D0                           ; $006FE6
        ASR.L  D6,D0                            ; $006FE8
        ADD.W   D0,D3                           ; $006FEA
        MOVE.W  D5,D0                           ; $006FEC
        jsr     sine_cosine_quadrant_lookup(pc); $4EBA $1F5E
        MULS    D2,D0                           ; $006FF2
        ASR.L  D6,D0                            ; $006FF4
        ADD.W   D0,D4                           ; $006FF6
        RTS                                     ; $006FF8
