; ============================================================================
; AI Table Lookup + Conditional Fall-through
; ROM Range: $00B2D8-$00B2FC (36 bytes)
; ============================================================================
; Data prefix (12 bytes), then loads object+$2C index, computes
; table offset (index-1)*4 from AI table base ($C200). Tests
; if table entry < $60: if so, falls through to next function.
; Otherwise returns.
;
; Memory:
;   $FFFFC200 = AI table base (address loaded into A1)
; Entry: A0 = object pointer | Exit: conditional | Uses: D0, D3, A0, A1
; ============================================================================

ai_table_lookup_cond_fall_through:
        ori.l   #$01100080,-(a0)                ; $00B2D8: $00A0 $0110 $0080 — data/setup
        ori.l   #$00D00100,d0                   ; $00B2DE: $0080 $00D0 $0100 — data/setup
        move.w  $002C(a0),d3                    ; $00B2E4: $3628 $002C — load AI index
        subq.w  #1,d3                           ; $00B2E8: $5343 — index - 1
        lsl.w   #2,d3                           ; $00B2EA: $E543 — multiply by 4
        lea     ($FFFFC200).w,a1                ; $00B2EC: $43F8 $C200 — AI table base
        lea     $00(a1,d3.w),a1                 ; $00B2F0: $43F1 $3000 — index into table
        cmpi.b  #$60,(a1)                       ; $00B2F4: $0C11 $0060 — entry < $60?
        blt.s   bcd_time_update_010             ; $00B2F8: entry < $60 → fall through to next fn
        rts                                     ; $00B2FA: $4E75

