; ============================================================================
; SH2 Mode Dispatcher — Select Scene by Track/Mode
; ROM Range: $012F0A-$012F56 (76 bytes)
; ============================================================================
; Resets the SH2 communication state, reads the player 1 selection
; from $A019, copies it to the race mode flag at $C817, then uses it
; as an index into a jump table to select the appropriate SH2 scene
; handler address. Special case: if selection == 2 and bit 3 of
; controller config ($C818) is set, forces index to 6.
;
; Memory:
;   $FFFFC87E = main game state (word, cleared to 0)
;   $FFFFA019 = player 1 selection / track index (byte, read)
;   $FFFFC817 = race mode flag (byte, written from selection)
;   $FFFFC818 = controller config flags (byte, bit 3 tested)
;   $00FF0002 = SH2 scene handler pointer (long, set from table)
;   $00FF0008 = display mode / frame delay (word, set to $0020)
; Entry: none | Exit: SH2 scene configured
; Uses: D1
; ============================================================================

sh2_mode_disp_select_scene_by_track_mode:
.wait_sh2:
        tst.b   COMM0_HI                        ; $012F0A: $4A38 $5120 — wait for SH2 idle
        bne.s   .wait_sh2                       ; $012F10: $66F8
        clr.b   COMM1_LO                        ; $012F12: $4238 $5123 — clear COMM1
        move.w  #$0000,($FFFFC87E).w           ; $012F18: $31FC $0000 $C87E — reset game state
        moveq   #$00,d1                         ; $012F1E: $7200 — clear D1
        move.b  ($FFFFA019).w,d1               ; $012F20: $1238 $A019 — load track selection
        move.b  d1,($FFFFC817).w               ; $012F24: $11C1 $C817 — save as race mode flag
        cmpi.b  #$02,d1                         ; $012F28: $0C01 $0002 — selection == 2?
        bne.s   .index_ready                    ; $012F2C: $660C — no → use as-is
        btst    #3,($FFFFC818).w               ; $012F2E: $0838 $0003 $C818 — special config flag?
        beq.s   .index_ready                    ; $012F34: $6604 — no → use as-is
        move.w  #$0006,d1                       ; $012F36: $323C $0006 — force index 6 (special mode)
.index_ready:
        add.w   d1,d1                           ; $012F3A: $D241 — D1 *= 2
        add.w   d1,d1                           ; $012F3C: $D241 — D1 *= 2 (total: ×4 for long table)
        move.w  #$0000,($FFFFC87E).w           ; $012F3E: $31FC $0000 $C87E — reset game state again
        move.l  $012F56(PC,d1.w),$00FF0002 ; $012F44: — load scene handler from table
        move.w  #$0020,$00FF0008                ; $012F4C: $33FC $0020 $00FF $0008 — display mode
        rts                                     ; $012F54: $4E75
