; ============================================================================
; Object Heading Deviation Check + Warning Flag
; ROM Range: $007EFC-$007F50 (84 bytes)
; ============================================================================
; Category: game
; Purpose: Two entry points (A2 selects VDP target):
;   Entry 1 ($007EFC): A2 = $FF6940
;   Entry 2 ($007F04): A2 = $FF6930
;   Computes heading_mirror (A0+$3C) - heading (A0+$1E). If negative,
;   adds $10000 (wrap). If deviation is in range ($4000,$C000) exclusive
;   (i.e., more than 90° off): sets $C312 warning flag, clears (A2).
;   If $C8AB bit 2 set → writes $01 to (A2) instead.
;   If deviation is within safe range and $C312 is set: clears (A2)
;   and $C312.
;
; Uses: D0, A0, A2
; RAM:
;   $C312: heading warning flag (byte)
;   $C8AB: scene flags (byte, bit 2)
; Object (A0):
;   +$1E: heading (word)
;   +$3C: heading_mirror (word)
; ============================================================================

object_heading_deviation_check_warning_flag:
; --- entry 1: target $FF6940 ---
        lea     $00FF6940,A2                    ; $007EFC  A2 → VDP target A
        bra.s   .compute                        ; $007F02  → compute deviation
; --- entry 2: target $FF6930 ---
        lea     $00FF6930,A2                    ; $007F04  A2 → VDP target B
.compute:
        move.w  $003C(A0),D0                   ; $007F0A  D0 = heading_mirror
        sub.w   $001E(A0),D0                   ; $007F0E  D0 -= heading
        ext.l   D0                              ; $007F12  sign-extend to long
        bpl.s   .check_range                    ; $007F14  positive → check
        addi.l  #$00010000,D0                  ; $007F16  wrap negative → positive
.check_range:
        cmpi.l  #$00004000,D0                  ; $007F1C  deviation > $4000?
        ble.s   .safe                           ; $007F22  no → safe range
        cmpi.l  #$0000C000,D0                  ; $007F24  deviation < $C000?
        bge.s   .safe                           ; $007F2A  no → safe range
; --- deviation warning ---
        move.b  #$01,($FFFFC312).w             ; $007F2C  set warning flag
        clr.b   (A2)                            ; $007F32  clear VDP target
        btst    #2,($FFFFC8AB).w               ; $007F34  scene bit 2 set?
        beq.s   .exit                           ; $007F3A  no → exit
        move.b  #$01,(A2)                      ; $007F3C  write $01 to VDP target
        bra.s   .exit                           ; $007F40  → exit
.safe:
        tst.b   ($FFFFC312).w                  ; $007F42  warning active?
        beq.s   .exit                           ; $007F46  no → exit
        clr.b   (A2)                            ; $007F48  clear VDP target
        clr.b   ($FFFFC312).w                  ; $007F4A  clear warning flag
.exit:
        rts                                     ; $007F4E
