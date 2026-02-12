; ============================================================================
; Camera Selection Counter (Music Track)
; ROM Range: $0136EA-$013734 (74 bytes)
; ============================================================================
; Category: game
; Purpose: If D2 == 0: adds D0 to music track counter ($A01C), wraps 0-25.
;   If D2 != 0: checks ranking ($A022), sets sound effect ($C822/$C8A7),
;   looks up music track from table at $0089AC62, reverts game_state.
;
; Entry: D0 = increment, D2 = action flag
; Uses: D0, D2, A0
; RAM:
;   $A01C: music track counter (word, range 0-25)
;   $A022: ranking result (word)
;   $C822: sound effect ID (byte, set to $F3)
;   $C8A5: sound parameter (byte, from table)
;   $C8A7: sound clear flag (byte, cleared)
;   $C87E: game_state (word)
; ============================================================================

fn_12200_009:
        tst.w   D2                              ; $0136EA  action flag
        bne.s   .select_track                   ; $0136EC  non-zero → select
        add.w   D0,($FFFFA01C).w                ; $0136EE  add increment to counter
        tst.w   ($FFFFA01C).w                   ; $0136F2  counter < 0?
        bge.s   .check_max                      ; $0136F6  no → check max
        move.w  #$0019,($FFFFA01C).w            ; $0136F8  wrap to 25
.check_max:
        cmpi.w  #$0019,($FFFFA01C).w            ; $0136FE  counter <= 25?
        ble.s   .done                           ; $013704  yes → done
        clr.w   ($FFFFA01C).w                   ; $013706  wrap to 0
        bra.s   .done                           ; $01370A
.select_track:
        cmpi.w  #$0002,($FFFFA022).w            ; $01370C  ranking == 2?
        beq.s   .set_sound                      ; $013712  yes → skip $C822
        move.b  #$F3,($FFFFC822).w              ; $013714  sound effect = $F3
.set_sound:
        clr.b   ($FFFFC8A7).w                   ; $01371A  clear sound flag
        lea     $0089AC62,A0                    ; $01371E  A0 = music track table
        move.w  ($FFFFA01C).w,D0                ; $013724  D0 = track counter
        move.b  $00(A0,D0.W),($FFFFC8A5).w      ; $013728  sound param = table[track]
        subq.w  #4,($FFFFC87E).w                ; $01372E  revert game_state
.done:
        rts                                     ; $013732
