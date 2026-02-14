; ============================================================================
; collision_response_surface_tracking — Collision Response + Surface Tracking
; ROM Range: $007700-$00789C (412 bytes)
; Iterative collision response with surface tracking. Calls obj_frame_calc
; ($00789C), then iteratively adjusts heading (+$40), scale (+$46), X (+$30),
; and Y (+$34) in 1/4 steps up to 4 iterations, checking collision flag
; (+$55 bit 0) each time. On collision, reverses last step. Second half
; performs surface-relative calculations on 4 neighboring probe points
; using tile lookup data from entity fields +$CE/+$D2/+$D6/+$DA.
;
; Entry: A0 = entity base pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; Object fields: +$30 x_pos, +$32 y_sub, +$34 y_pos, +$36/+$38 prev_pos,
;   +$40 heading, +$42 prev_heading, +$46 scale, +$48 prev_scale,
;   +$55 collision_flag, +$5A/+$5C/+$5E/+$32 surface_offsets
; Confidence: high
; ============================================================================

collision_response_surface_tracking:
        jsr     track_boundary_collision_detection(pc); $4EBA $019A
        CMPI.W  #$0000,$0062(A0)                ; $007704
        BGT.W  .loc_00FA                        ; $00770A
        BTST    #0,$0055(A0)                    ; $00770E
        BEQ.W  .loc_00FA                        ; $007714
        MOVE.W  $0040(A0),D3                    ; $007718
        SUB.W  $0042(A0),D3                     ; $00771C
        ASR.W  #2,D3                            ; $007720
        MOVE.W  $0046(A0),D4                    ; $007722
        SUB.W  $0048(A0),D4                     ; $007726
        ASR.W  #2,D4                            ; $00772A
        MOVE.W  $0030(A0),D5                    ; $00772C
        SUB.W  $0036(A0),D5                     ; $007730
        ASR.W  #2,D5                            ; $007734
        MOVE.W  $0034(A0),D6                    ; $007736
        SUB.W  $0038(A0),D6                     ; $00773A
        ASR.W  #2,D6                            ; $00773E
        MOVE.W  $0036(A0),$0030(A0)             ; $007740
        MOVE.W  $0038(A0),$0034(A0)             ; $007746
        MOVE.W  $0042(A0),$0040(A0)             ; $00774C
        MOVE.W  $0048(A0),$0046(A0)             ; $007752
        ADD.W  D3,$0040(A0)                     ; $007758
        ADD.W  D4,$0046(A0)                     ; $00775C
        ADD.W  D5,$0030(A0)                     ; $007760
        ADD.W  D6,$0034(A0)                     ; $007764
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A7)   ; $007768
        jsr     track_boundary_collision_detection(pc); $4EBA $012E
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7   ; $007770
        BTST    #0,$0055(A0)                    ; $007774
        BNE.W  .loc_00EA                        ; $00777A
        ADD.W  D3,$0040(A0)                     ; $00777E
        ADD.W  D4,$0046(A0)                     ; $007782
        ADD.W  D5,$0030(A0)                     ; $007786
        ADD.W  D6,$0034(A0)                     ; $00778A
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A7)   ; $00778E
        jsr     track_boundary_collision_detection(pc); $4EBA $0108
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7   ; $007796
        BTST    #0,$0055(A0)                    ; $00779A
        BNE.S  .loc_00EA                        ; $0077A0
        ADD.W  D3,$0040(A0)                     ; $0077A2
        ADD.W  D4,$0046(A0)                     ; $0077A6
        ADD.W  D5,$0030(A0)                     ; $0077AA
        ADD.W  D6,$0034(A0)                     ; $0077AE
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A7)   ; $0077B2
        jsr     track_boundary_collision_detection(pc); $4EBA $00E4
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7   ; $0077BA
        BTST    #0,$0055(A0)                    ; $0077BE
        BNE.S  .loc_00EA                        ; $0077C4
        ADD.W  D3,$0040(A0)                     ; $0077C6
        ADD.W  D4,$0046(A0)                     ; $0077CA
        ADD.W  D5,$0030(A0)                     ; $0077CE
        ADD.W  D6,$0034(A0)                     ; $0077D2
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7,-(A7)   ; $0077D6
        jsr     track_boundary_collision_detection(pc); $4EBA $00C0
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7   ; $0077DE
        BTST    #0,$0055(A0)                    ; $0077E2
        BEQ.S  .loc_00FA                        ; $0077E8
.loc_00EA:
        SUB.W  D3,$0040(A0)                     ; $0077EA
        SUB.W  D4,$0046(A0)                     ; $0077EE
        SUB.W  D5,$0030(A0)                     ; $0077F2
        SUB.W  D6,$0034(A0)                     ; $0077F6
.loc_00FA:
        MOVE.W  $0040(A0),$0042(A0)             ; $0077FA
        MOVE.W  $0046(A0),$0048(A0)             ; $007800
        MOVE.W  $0030(A0),$0036(A0)             ; $007806
        MOVE.W  $0034(A0),$0038(A0)             ; $00780C
        BRA.W  .loc_011A                        ; $007812
        jsr     track_boundary_collision_detection(pc); $4EBA $0084
.loc_011A:
        MOVEA.L $00D2(A0),A2                    ; $00781A
        MOVE.W  (-16172).W,D1                   ; $00781E
        MOVE.W  (-16170).W,D2                   ; $007822
        jsr     plane_eval+24(pc)       ; $4EBA $FDB8
        BLE.S  .loc_013A                        ; $00782A
        MOVE.W  $005A(A0),D2                    ; $00782C
        EXT.L   D2                              ; $007830
        ADD.L   D2,D1; $007832
        ASR.L  #1,D1                            ; $007834
        MOVE.W  D1,$005A(A0)                    ; $007836
.loc_013A:
        MOVEA.L $00D6(A0),A2                    ; $00783A
        MOVE.W  (-16168).W,D1                   ; $00783E
        MOVE.W  (-16166).W,D2                   ; $007842
        jsr     plane_eval+24(pc)       ; $4EBA $FD98
        BLE.S  .loc_015A                        ; $00784A
        MOVE.W  $005C(A0),D2                    ; $00784C
        EXT.L   D2                              ; $007850
        ADD.L   D2,D1; $007852
        ASR.L  #1,D1                            ; $007854
        MOVE.W  D1,$005C(A0)                    ; $007856
.loc_015A:
        MOVEA.L $00DA(A0),A2                    ; $00785A
        MOVE.W  (-16164).W,D1                   ; $00785E
        MOVE.W  (-16162).W,D2                   ; $007862
        jsr     plane_eval+24(pc)       ; $4EBA $FD78
        BLE.S  .loc_017A                        ; $00786A
        MOVE.W  $005E(A0),D2                    ; $00786C
        EXT.L   D2                              ; $007870
        ADD.L   D2,D1; $007872
        ASR.L  #1,D1                            ; $007874
        MOVE.W  D1,$005E(A0)                    ; $007876
.loc_017A:
        MOVEA.L $00CE(A0),A2                    ; $00787A
        MOVE.W  (-16176).W,D1                   ; $00787E
        MOVE.W  (-16174).W,D2                   ; $007882
        jsr     plane_eval+24(pc)       ; $4EBA $FD58
        BLE.S  .loc_019A                        ; $00788A
        MOVE.W  $0032(A0),D2                    ; $00788C
        EXT.L   D2                              ; $007890
        ADD.L   D2,D1; $007892
        ASR.L  #1,D1                            ; $007894
        MOVE.W  D1,$0032(A0)                    ; $007896
.loc_019A:
        RTS                                     ; $00789A
