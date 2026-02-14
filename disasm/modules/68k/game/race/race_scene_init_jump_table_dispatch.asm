; ============================================================================
; Race Scene Init + 6-Entry Jump Table Dispatch
; ROM Range: $00D04C-$00D08A (62 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 4 words ($5041,$4100,$504B,$4600) — ASCII-like
;   scene identifiers ("PA","A\0","PK","F\0").
;   Calls $00D00C (scene pre-init), loads race_state ($C8A0) and
;   copies 4-byte data from table at $00898C0C indexed by race_state
;   to VDP at $FF6868. Dispatches via 6-entry longword jump table
;   (all 6 entries point to $00D088 = shared RTS).
;
; Uses: D0, D1, A0, A1, A3
; RAM:
;   $C8A0: race_state (word, dispatch index)
; Calls:
;   $00D00C: scene pre-init
; ============================================================================

race_scene_init_jump_table_dispatch:
; --- data prefix: 4-word scene identifiers ---
        addq.w  #8,d1                   ; $5041
        dc.w    $4100                           ; $00D04E  "A\0"
        addq.w  #8,a3                   ; $504B
        not.b    d0                     ; $4600
; --- code ---
        jsr     scene_init_vdp_block_setup_counter_reset+54(pc); $4EBA $FFB6
        move.w  ($FFFFC8A0).w,D0               ; $00D058  D0 = race_state
        lea     $00898C0C,A1                    ; $00D05C  A1 → race data table
        move.l  $00(A1,D0.W),$00FF6868         ; $00D062  VDP = table[race_state]
        movea.l $00D070(PC,D0.W),A1            ; $00D06A  A1 = handler address
        jmp     (A1)                            ; $00D06E  dispatch
; --- jump table (6 longword entries — all point to RTS) ---
        dc.l    $0088D088                       ; $00D070  [00] → $00D088 (RTS)
        dc.l    $0088D088                       ; $00D074  [04] → $00D088 (RTS)
        dc.l    $0088D088                       ; $00D078  [08] → $00D088 (RTS)
        dc.l    $0088D088                       ; $00D07C  [0C] → $00D088 (RTS)
        dc.l    $0088D088                       ; $00D080  [10] → $00D088 (RTS)
        dc.l    $0088D088                       ; $00D084  [14] → $00D088 (RTS)
        rts                                     ; $00D088
