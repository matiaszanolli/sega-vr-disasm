; ============================================================================
; FM SSG-EG Register Write — write 4 operator SSG-EG values
; ROM Range: $031574-$031590 (28 bytes)
; ============================================================================
; Loads register table from $031590 (8 bytes: 4 pairs of SSG-EG register
; + reset register numbers). For each of 4 operators: reads value from
; sequence (A4), writes SSG-EG register via fm_conditional_write, then
; writes reset register with $1F.
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Uses: D0, D1, D3, A1, A4
; Calls:
;   $030CA2: fm_conditional_write
; Confidence: medium
; ============================================================================

fm_ssg_eg_reg_write:
        lea     fm_reg_table_channel_pause(pc),a1; $43FA $001A
        MOVEQ   #$03,D3                         ; $031578
.loc_0006:
        MOVE.B  (A1)+,D0                        ; $03157A
        MOVE.B  (A4)+,D1                        ; $03157C
        jsr     fm_cond_write_with_bus(pc); $4EBA $F722
        MOVE.B  (A1)+,D0                        ; $031582
        MOVEQ   #$1F,D1                         ; $031584
        jsr     fm_cond_write_with_bus(pc); $4EBA $F71A
        DBRA    D3,.loc_0006                    ; $03158A
        RTS                                     ; $03158E
