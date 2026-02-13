; ============================================================================
; Camera Selection Counter (Sound Effect A)
; ROM Range: $013734-$01377A (70 bytes)
; ============================================================================
; Category: game
; Purpose: If D2 == 0: adds D0 to SFX counter A ($A01E), wraps 0-12.
;   If D2 != 0: checks ranking ($A022), sets sound effect ($C822=$CA),
;   looks up SFX from table at $0089ACB0, stores to $C8A4, reverts game_state.
;
; Entry: D0 = increment, D2 = action flag
; Uses: D0, D2, A0
; RAM:
;   $A01E: SFX counter A (word, range 0-12)
;   $A022: ranking result (word)
;   $C822: sound effect ID (byte, set to $CA)
;   $C8A4: sound parameter (byte, from table)
;   $C87E: game_state (word)
; ============================================================================

camera_selection_counter_013734:
        tst.w   D2                              ; $013734  action flag
        bne.s   .select_sfx                     ; $013736  non-zero → select
        add.w   D0,($FFFFA01E).w                ; $013738  add increment to counter
        tst.w   ($FFFFA01E).w                   ; $01373C  counter < 0?
        bge.s   .check_max                      ; $013740  no → check max
        move.w  #$000C,($FFFFA01E).w            ; $013742  wrap to 12
.check_max:
        cmpi.w  #$000C,($FFFFA01E).w            ; $013748  counter <= 12?
        ble.s   .done                           ; $01374E  yes → done
        clr.w   ($FFFFA01E).w                   ; $013750  wrap to 0
        bra.s   .done                           ; $013754
.select_sfx:
        cmpi.w  #$0002,($FFFFA022).w            ; $013756  ranking == 2?
        beq.s   .set_sound                      ; $01375C  yes → skip $C822
        move.b  #$CA,($FFFFC822).w              ; $01375E  sound effect = $CA
.set_sound:
        lea     $0089ACB0,A0                    ; $013764  A0 = SFX table A
        move.w  ($FFFFA01E).w,D0                ; $01376A  D0 = SFX counter
        move.b  $00(A0,D0.W),($FFFFC8A4).w      ; $01376E  sound param = table[sfx]
        subq.w  #4,($FFFFC87E).w                ; $013774  revert game_state
.done:
        rts                                     ; $013778
