; ============================================================================
; FM Register Table + Vibrato Setup — operator registers and vibrato init
; ROM Range: $0313CA-$031406 (60 bytes)
; ============================================================================
; Data prefix ($0313CA-$0313E1): FM operator register number table (20
; register bytes for DT/MUL, TL, RS/AR, DR, SR, SL/RR used by
; fn_30200_050's instrument write loop, plus 8 TL register bytes).
; Code at $0313E2: Vibrato setup sequence command. Sets high bit of
; A5+$0A (marks vibrato active), saves sequence pointer to A5+$14.
; Reads 4 vibrato parameters from sequence: initial frequency ($18),
; speed ($19), direction ($1A), depth ($1B, halved). Clears position ($1C).
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Uses: D0, A4
; Confidence: medium
; ============================================================================

fn_30200_052:
        MOVE.W  ($343C).W,D0                    ; $0313CA
        ADDQ.W  #8,(A0)+                        ; $0313CE
        ADDQ.W  #2,(A4)+                        ; $0313D0
        DC.W    $6068               ; BRA.S  $03143C; $0313D2
        DC.W    $646C               ; BCC.S  $031442; $0313D4
        MOVEQ   #$78,D0                         ; $0313D6
        MOVEQ   #$7C,D2                         ; $0313D8
        DC.W    $8088                           ; $0313DA
        DC.W    $848C                           ; $0313DC
        DC.W    $4048                           ; $0313DE
        DC.W    $444C                           ; $0313E0
        BSET    #7,$000A(A5)                    ; $0313E2
        MOVE.L  A4,$0014(A5)                    ; $0313E8
        MOVE.B  (A4)+,$0018(A5)                 ; $0313EC
        MOVE.B  (A4)+,$0019(A5)                 ; $0313F0
        MOVE.B  (A4)+,$001A(A5)                 ; $0313F4
        MOVE.B  (A4)+,D0                        ; $0313F8
        LSR.B  #1,D0                            ; $0313FA
        MOVE.B  D0,$001B(A5)                    ; $0313FC
        CLR.W  $001C(A5)                        ; $031400
        RTS                                     ; $031404
