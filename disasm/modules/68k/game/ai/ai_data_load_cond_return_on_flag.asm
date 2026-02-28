; ============================================================================
; AI Data Load + Conditional Return on Flag
; ROM Range: $00B598-$00B5AE (22 bytes)
; ============================================================================
; Loads shared memory pointer into A1, reads AI parameter from $9F2C,
; calls a sub-routine at $00B5B8, then tests bit 5 of the control
; flag at $C30E. Returns if set; falls through if clear.
;
; Memory:
;   $FFFF9F2C = AI parameter (word, loaded into D0)
;   $FFFFC30E = control flag (byte, bit 5 tested)
; Entry: none | Exit: returns if flag set | Uses: D0, A1
; ============================================================================

ai_data_load_cond_return_on_flag:
        lea     $00FF69CA,a1                    ; $00B598: $43F9 $00FF $69CA — shared memory ptr
        move.w  ($FFFF9F2C).w,d0               ; $00B59E: $3038 $9F2C — load AI parameter
        bsr.s   lap_disp_update_vdp_tile_write+10 ; $00B5A2: call sub (entry 1 + offset 10)
        btst    #5,($FFFFC30E).w               ; $00B5A4: $0838 $0005 $C30E — check control flag
        beq.s   fn_a200_020_end                 ; $00B5AA: $6702 — clear → fall through
        rts                                     ; $00B5AC: $4E75 — set → return
fn_a200_020_end:
