; ============================================================================
; SFX Trigger + Object Enable Fields
; ROM Range: $003D22-$003D5A (56 bytes)
; ============================================================================
; Category: game
; Purpose: If D1 == 4 or D1 == $16: plays SFX $BA via $C8A4.
;   Sets object fields at $FF6128: field $00 and $14 = 1.
;   If $C04C == 0: also sets fields $28 and $3C = 1.
;
; Entry: D1 = event index
; Uses: D0, D1, A1
; RAM:
;   $C04C: 2-player flag (word)
;   $C8A4: sound effect (byte)
; Object ($FF6128):
;   +$00/$14/$28/$3C: enable flags (word, set to 1)
; ============================================================================

fn_2200_067:
        cmpi.w  #$0004,D1                       ; $003D22  event == 4?
        bne.s   .check_16                       ; $003D26  no → check $16
        move.b  #$BA,($FFFFC8A4).w             ; $003D28  play SFX $BA
.check_16:
        cmpi.w  #$0016,D1                       ; $003D2E  event == $16?
        bne.s   .set_fields                     ; $003D32  no → set fields
        move.b  #$BA,($FFFFC8A4).w             ; $003D34  play SFX $BA
.set_fields:
        moveq   #$01,D0                         ; $003D3A  D0 = 1
        lea     $00FF6128,A1                    ; $003D3C  A1 → object
        move.w  D0,$0000(A1)                    ; $003D42  field $00 = 1
        move.w  D0,$0014(A1)                    ; $003D46  field $14 = 1
        tst.w   ($FFFFC04C).w                  ; $003D4A  2-player active?
        bne.s   .done                           ; $003D4E  yes → skip extra fields
        move.w  D0,$0028(A1)                    ; $003D50  field $28 = 1
        move.w  D0,$003C(A1)                    ; $003D54  field $3C = 1
.done:
        rts                                     ; $003D58
