; ============================================================================
; Camera Selection Counter (Sound Effect B)
; ROM Range: $01377A-$0137C0 (70 bytes)
; ============================================================================
; Category: game
; Purpose: If D2 == 0: adds D0 to SFX counter B ($A020), wraps 0-9.
;   If D2 != 0: checks ranking ($A022), sets sound effect ($C822=$CA),
;   looks up SFX from table at $0089ACE6, stores to $C8A4, reverts game_state.
;   Same pattern as fn_12200_010 but different counter/table/range.
;
; Entry: D0 = increment, D2 = action flag
; Uses: D0, D2, A0
; RAM:
;   $A020: SFX counter B (word, range 0-9)
;   $A022: ranking result (word)
;   $C822: sound effect ID (byte, set to $CA)
;   $C8A4: sound parameter (byte, from table)
;   $C87E: game_state (word)
; ============================================================================

fn_12200_011:
        tst.w   D2                              ; $01377A  action flag
        bne.s   .select_sfx                     ; $01377C  non-zero → select
        add.w   D0,($FFFFA020).w                ; $01377E  add increment to counter
        tst.w   ($FFFFA020).w                   ; $013782  counter < 0?
        bge.s   .check_max                      ; $013786  no → check max
        move.w  #$0009,($FFFFA020).w            ; $013788  wrap to 9
.check_max:
        cmpi.w  #$0009,($FFFFA020).w            ; $01378E  counter <= 9?
        ble.s   .done                           ; $013794  yes → done
        clr.w   ($FFFFA020).w                   ; $013796  wrap to 0
        bra.s   .done                           ; $01379A
.select_sfx:
        cmpi.w  #$0002,($FFFFA022).w            ; $01379C  ranking == 2?
        beq.s   .set_sound                      ; $0137A2  yes → skip $C822
        move.b  #$CA,($FFFFC822).w              ; $0137A4  sound effect = $CA
.set_sound:
        lea     $0089ACE6,A0                    ; $0137AA  A0 = SFX table B
        move.w  ($FFFFA020).w,D0                ; $0137B0  D0 = SFX counter
        move.b  $00(A0,D0.W),($FFFFC8A4).w      ; $0137B4  sound param = table[sfx]
        subq.w  #4,($FFFFC87E).w                ; $0137BA  revert game_state
.done:
        rts                                     ; $0137BE
